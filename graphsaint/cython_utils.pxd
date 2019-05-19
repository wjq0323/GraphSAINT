# cython: language_level=3
# distutils: language=c++
# distutils: extra_compile_args = -fopenmp -std=c++11
# distutils: extra_link_args = -fopenmp

from libcpp.vector cimport vector
cimport cython
import numpy as np
cimport numpy as np


cdef extern from "<utility>" namespace "std" nogil:
    T move[T](T)


cdef class array_wrapper_float:
    cdef vector[float] vec
    cdef Py_ssize_t shape[1]
    cdef Py_ssize_t strides[1]
    cdef void set_data(self,vector[float]& data)

cdef class array_wrapper_int:
    cdef vector[int] vec
    cdef Py_ssize_t shape[1]
    cdef Py_ssize_t strides[1]
    cdef void set_data(self,vector[int]& data)

cdef inline void npy2vec_int(np.ndarray[int,ndim=1,mode='c'] nda, vector[int]& vec):
    cdef int size = nda.size
    cdef int* vec_c = &(nda[0])
    vec.assign(vec_c,vec_c+size)

cdef inline void npy2vec_float(np.ndarray[float,ndim=1,mode='c'] nda, vector[float]& vec):
    cdef int size = nda.size
    cdef float* vec_c = &(nda[0])
    vec.assign(vec_c,vec_c+size)

cdef void _adj_extract_cython(vector[int]& adj_indptr, vector[int]& adj_indices, vector[vector[int]]& node_sampled,\
        vector[vector[int]]& ret_indptr, vector[vector[int]]& ret_indices, vector[vector[int]]& ret_indices_orig,\
        vector[vector[float]]& ret_data, int p, int num_rep) nogil

cdef void _adj_extract_ind_cython(vector[int]& adj_indptr,vector[vector[int]]& node_sampled,\
        vector[vector[int]]& ret_row, vector[vector[int]]& ret_col, vector[vector[int]]& ret_indices_orig, vector[vector[float]]& ret_data,\
        int depth_walk, int p, int num_rep) nogil
