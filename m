Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC63350F62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhDAGvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 02:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbhDAGvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:51:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D5AC0613E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:51:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d8so520370plh.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TL0yIPSgBqQg9K+SpnL1dqDaXv+MEk4aUKTBXVLaUpY=;
        b=j6cnoLcnReJ6wKuKx7wRkJbjSXZlIqQmZyij2dBBHYtmt0npKVj8I+tc28+gIHleNS
         k26uGXKSiZn4Jyim9/e5gIT4XC5D3z9J523DK3WUp2B/oosIbRlM1UczsRhCPX0+ZzRx
         4KBLpIeAnKXIl5DzRhQr/5mdarO1ecEM5yilPaD383cNuRPGdbgf7k+HlGrqLLOkFr+P
         VXIdP4P0kyfshYfw/6BUIkzIiizUAUoR1FgK3H9nZ3ILcZpfCM2N3qKpn6z0I7GvMi+y
         NBuMK9W4F+KywMofcIpuKZ4zWP6vfm6q1BNuuk5KImVkUjth85ouJoLMqh7nzZnqvtY+
         9EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TL0yIPSgBqQg9K+SpnL1dqDaXv+MEk4aUKTBXVLaUpY=;
        b=D3TPfGWwdI+rNoRFJhTHOVBWzCcPI1FKnKnrMEK+oiyEwb6lhKUkF005sfmNCy7Tig
         pXBo3s0/ArDUwkjpbGFbkTRjFIWCiiIgAuP+LrPWsg2zigMr6Ha47ToQhNEhXQHM8AAP
         VgYn51MwTQNDgxiP54fAk8rFygcEpinPuAEk7dX062oAl4FGD6pr56iA+KmGB7lLcIny
         XtT36zTrKoRmD8Uz+uJemxRZ6UZX1oipkvmu0bZS77UysNTbRi2iWeIsagus34820nKi
         y2KiN0lDg9yBJCtYM8wi+8vj6UJNxNyESLNAO8GkRM1L7pgHfS9LAmIMo14MLETa8bl9
         oGUA==
X-Gm-Message-State: AOAM530YCnxwPZoDXwl493DbGbb34XBHXrmi2QMSXW3UriBrEIDk2ocn
        68amaiY32bh6F0Xcu+yJgHM8YOFYvCQgfQ==
X-Google-Smtp-Source: ABdhPJwLjZ2J+EeXd0Qo9hozEr8X68DsAU1iOEhRmeOYhE2HJ6HcQ8qRKBPql7NYu8ZyXxumHqU0Zg==
X-Received: by 2002:a17:902:c48c:b029:e4:c093:593a with SMTP id n12-20020a170902c48cb02900e4c093593amr6591724plx.1.1617259893624;
        Wed, 31 Mar 2021 23:51:33 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:3734])
        by smtp.gmail.com with ESMTPSA id kk6sm4158345pjb.51.2021.03.31.23.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:51:32 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v9 3/9] fs: add RWF_ENCODED for reading/writing compressed data
Date:   Wed, 31 Mar 2021 23:51:08 -0700
Message-Id: <e192638d62c9766c4bc3e98cc4aab6761574b952.1617258892.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617258892.git.osandov@fb.com>
References: <cover.1617258892.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Btrfs supports transparent compression: data written by the user can be
compressed when written to disk and decompressed when read back.
However, we'd like to add an interface to write pre-compressed data
directly to the filesystem, and the matching interface to read
compressed data without decompressing it. This adds support for
so-called "encoded I/O" via preadv2() and pwritev2().

A new RWF_ENCODED flags indicates that a read or write is "encoded". If
this flag is set, iov[0].iov_base points to a struct encoded_iov which
is used for metadata: namely, the compression algorithm, unencoded
(i.e., decompressed) length, and what subrange of the unencoded data
should be used (needed for truncated or hole-punched extents and when
reading in the middle of an extent). For reads, the filesystem returns
this information; for writes, the caller provides it to the filesystem.
iov[0].iov_len must be set to sizeof(struct encoded_iov), which can be
used to extend the interface in the future a la copy_struct_from_user().
The remaining iovecs contain the encoded extent.

This adds the VFS helpers for supporting encoded I/O and documentation.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 Documentation/filesystems/encoded_io.rst | 240 +++++++++++++++++++++++
 Documentation/filesystems/index.rst      |   1 +
 fs/read_write.c                          | 168 ++++++++++++++--
 include/linux/encoded_io.h               |  17 ++
 include/linux/fs.h                       |  13 ++
 include/uapi/linux/encoded_io.h          |  30 +++
 include/uapi/linux/fs.h                  |   5 +-
 7 files changed, 460 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst
 create mode 100644 include/linux/encoded_io.h
 create mode 100644 include/uapi/linux/encoded_io.h

diff --git a/Documentation/filesystems/encoded_io.rst b/Documentation/filesystems/encoded_io.rst
new file mode 100644
index 000000000000..58132ec6f681
--- /dev/null
+++ b/Documentation/filesystems/encoded_io.rst
@@ -0,0 +1,240 @@
+===========
+Encoded I/O
+===========
+
+Several filesystems (e.g., Btrfs) support transparent encoding (e.g.,
+compression, encryption) of data on disk: written data is encoded by the kernel
+before it is written to disk, and read data is decoded before being returned to
+the user. In some cases, it is useful to skip this encoding step. For example,
+the user may want to read the compressed contents of a file or write
+pre-compressed data directly to a file. This is referred to as "encoded I/O".
+
+User API
+========
+
+Encoded I/O is specified with the ``RWF_ENCODED`` flag to ``preadv2()`` and
+``pwritev2()``. If ``RWF_ENCODED`` is specified, then ``iov[0].iov_base``
+points to an ``encoded_iov`` structure, defined in ``<linux/encoded_io.h>``
+as::
+
+    struct encoded_iov {
+            __aligned_u64 len;
+            __aligned_u64 unencoded_len;
+            __aligned_u64 unencoded_offset;
+            __u32 compression;
+            __u32 encryption;
+    };
+
+This may be extended in the future, so ``iov[0].iov_len`` must be set to
+``sizeof(struct encoded_iov)`` for forward/backward compatibility. The
+remaining buffers contain the encoded data.
+
+``compression`` and ``encryption`` are the encoding fields. ``compression`` is
+``ENCODED_IOV_COMPRESSION_NONE`` (zero) or a filesystem-specific
+``ENCODED_IOV_COMPRESSION_*`` constant; see `Filesystem support`_ below.
+``encryption`` is currently always ``ENCODED_IOV_ENCRYPTION_NONE`` (zero).
+
+``unencoded_len`` is the length of the unencoded (i.e., decrypted and
+decompressed) data. ``unencoded_offset`` is the offset from the first byte of
+the unencoded data to the first byte of logical data in the file (less than or
+equal to ``unencoded_len``). ``len`` is the length of the data in the file
+(less than or equal to ``unencoded_len - unencoded_offset``). See `Extent
+layout`_ below for some examples.
+
+If the unencoded data is actually longer than ``unencoded_len``, then it is
+truncated; if it is shorter, then it is extended with zeroes.
+
+``pwritev2()`` uses the metadata specified in ``iov[0]``, writes the encoded
+data from the remaining buffers, and returns the number of encoded bytes
+written (that is, the sum of ``iov[n].iov_len for 1 <= n < iovcnt``; partial
+writes will not occur). At least one encoding field must be non-zero. Note that
+the encoded data is not validated when it is written; if it is not valid (e.g.,
+it cannot be decompressed), then a subsequent read may return an error. If the
+offset argument to ``pwritev2()`` is -1, then the file offset is incremented by
+``len``. If ``iov[0].iov_len`` is less than ``sizeof(struct encoded_iov)`` in
+the kernel, then any fields unknown to user space are treated as if they were
+zero; if it is greater and any fields unknown to the kernel are non-zero, then
+``pwritev2()`` returns -1 and sets errno to ``E2BIG``.
+
+``preadv2()`` populates the metadata in ``iov[0]``, the encoded data in the
+remaining buffers, and returns the number of encoded bytes read. This will only
+return one extent per call. This can also read data which is not encoded; all
+encoding fields will be zero in that case. If the offset argument to
+``preadv2()`` is -1, then the file offset is incremented by ``len``. If
+``iov[0].iov_len`` is less than ``sizeof(struct encoded_iov)`` in the kernel
+and any fields unknown to user space are non-zero, then ``preadv2()`` returns
+-1 and sets errno to ``E2BIG``; if it is greater, then any fields unknown to
+the kernel are returned as zero. If the provided buffers are not large enough
+to return an entire encoded extent, then ``preadv2()`` returns -1 and sets
+errno to ``ENOBUFS``.
+
+As the filesystem page cache typically contains decoded data, encoded I/O
+bypasses the page cache.
+
+Extent layout
+-------------
+
+By using ``len``, ``unencoded_len``, and ``unencoded_offset``, it is possible
+to refer to a subset of an unencoded extent.
+
+In the simplest case, ``len`` is equal to ``unencoded_len`` and
+``unencoded_offset`` is zero. This means that the entire unencoded extent is
+used.
+
+However, suppose we read 50 bytes into a file which contains a single
+compressed extent. The filesystem must still return the entire compressed
+extent for us to be able to decompress it, so ``unencoded_len`` would be the
+length of the entire decompressed extent. However, because the read was at
+offset 50, the first 50 bytes should be ignored. Therefore,
+``unencoded_offset`` would be 50, and ``len`` would accordingly be
+``unencoded_len - 50``.
+
+Additionally, suppose we want to create an encrypted file with length 500, but
+the file is encrypted with a block cipher using a block size of 4096. The
+unencoded data would therefore include the appropriate padding, and
+``unencoded_len`` would be 4096. However, to represent the logical size of the
+file, ``len`` would be 500 (and ``unencoded_offset`` would be 0).
+
+Similar situations can arise in other cases:
+
+* If the filesystem pads data to the filesystem block size before compressing,
+  then compressed files with a size unaligned to the filesystem block size will
+  end with an extent with ``len < unencoded_len``.
+
+* Extents cloned from the middle of a larger encoded extent with
+  ``FICLONERANGE`` may have a non-zero ``unencoded_offset`` and/or
+  ``len < unencoded_len``.
+
+* If the middle of an encoded extent is overwritten, the filesystem may create
+  extents with a non-zero ``unencoded_offset`` and/or ``len < unencoded_len``
+  for the parts that were not overwritten.
+
+Security
+--------
+
+Encoded I/O creates the potential for some security issues:
+
+* Encoded writes allow writing arbitrary data which the kernel will decode on a
+  subsequent read. Decompression algorithms are complex and may have bugs that
+  can be exploited by maliciously crafted data.
+* Encoded reads may return data that is not logically present in the file (see
+  the discussion of ``len`` vs ``unencoded_len`` above). It may not be intended
+  for this data to be readable.
+
+Therefore, encoded I/O requires privilege. Namely, the ``RWF_ENCODED`` flag may
+only be used if the file description has the ``O_ALLOW_ENCODED`` file status
+flag set, and the ``O_ALLOW_ENCODED`` flag may only be set by a thread with the
+``CAP_SYS_ADMIN`` capability. The ``O_ALLOW_ENCODED`` flag can be set by
+``open()`` or ``fcntl()``. It can also be cleared by ``fcntl()``; clearing it
+does not require ``CAP_SYS_ADMIN``. Note that it is not cleared on ``fork()``
+or ``execve()``. One may wish to use ``O_CLOEXEC`` with ``O_ALLOW_ENCODED``.
+
+Filesystem support
+------------------
+
+Encoded I/O is supported on the following filesystems:
+
+Btrfs (since Linux 5.13)
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Btrfs supports encoded reads and writes of compressed data. The data is encoded
+as follows:
+
+* If ``compression`` is ``ENCODED_IOV_COMPRESSION_BTRFS_ZLIB``, then the encoded
+  data is a single zlib stream.
+* If ``compression`` is ``ENCODED_IOV_COMPRESSION_BTRFS_ZSTD``, then the
+  encoded data is a single zstd frame compressed with the windowLog compression
+  parameter set to no more than 17.
+* If ``compression`` is one of ``ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K``,
+  ``ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K``,
+  ``ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K``,
+  ``ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K``, or
+  ``ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K``, then the encoded data is
+  compressed page by page (using the page size indicated by the name of the
+  constant) with LZO1X and wrapped in the format documented in the Linux kernel
+  source file ``fs/btrfs/lzo.c``.
+
+Additionally, there are some restrictions on ``pwritev2()``:
+
+* ``offset`` (or the current file offset if ``offset`` is -1) must be aligned
+  to the sector size of the filesystem.
+* ``len`` must be aligned to the sector size of the filesystem unless the data
+  ends at or beyond the current end of the file.
+* ``unencoded_len`` and the length of the encoded data must each be no more
+  than 128 KiB. This limit may increase in the future.
+* The length of the encoded data must be less than or equal to
+  ``unencoded_len.``
+* If using LZO, the filesystem's page size must match the compression page
+  size.
+
+Implementation
+==============
+
+This section describes the requirements for filesystems implementing encoded
+I/O.
+
+First of all, a filesystem supporting encoded I/O must indicate this by setting
+the ``FMODE_ENCODED_IO`` flag in its ``file_open`` file operation::
+
+    static int foo_file_open(struct inode *inode, struct file *filp)
+    {
+            ...
+            filep->f_mode |= FMODE_ENCODED_IO;
+            ...
+    }
+
+Encoded I/O goes through ``read_iter`` and ``write_iter``, designated by the
+``IOCB_ENCODED`` flag in ``kiocb->ki_flags``.
+
+Reads
+-----
+
+Encoded ``read_iter`` should:
+
+1. Call ``generic_encoded_read_checks()`` to validate the file and buffers
+   provided by userspace.
+2. Initialize the ``encoded_iov`` appropriately.
+3. Copy it to the user with ``copy_encoded_iov_to_iter()``.
+4. Copy the encoded data to the user.
+5. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
+6. Return the size of the encoded data read, not including the ``encoded_iov``.
+
+There are a few details to be aware of:
+
+* Encoded ``read_iter`` should support reading unencoded data if the extent is
+  not encoded.
+* If the buffers provided by the user are not large enough to contain an entire
+  encoded extent, then ``read_iter`` should return ``-ENOBUFS``. This is to
+  avoid confusing userspace with truncated data that cannot be properly
+  decoded.
+* Reads in the middle of an encoded extent can be returned by setting
+  ``encoded_iov->unencoded_offset`` to non-zero.
+* Truncated unencoded data (e.g., because the file does not end on a block
+  boundary) may be returned by setting ``encoded_iov->len`` to a value smaller
+  value than ``encoded_iov->unencoded_len - encoded_iov->unencoded_offset``.
+
+Writes
+------
+
+Encoded ``write_iter`` should (in addition to the usual accounting/checks done
+by ``write_iter``):
+
+1. Call ``copy_encoded_iov_from_iter()`` to get and validate the
+   ``encoded_iov``.
+2. Call ``generic_encoded_write_checks()`` instead of
+   ``generic_write_checks()``.
+3. Check that the provided encoding in ``encoded_iov`` is supported.
+4. Advance ``kiocb->ki_pos`` by ``encoded_iov->len``.
+5. Return the size of the encoded data written.
+
+Again, there are a few details:
+
+* Encoded ``write_iter`` doesn't need to support writing unencoded data.
+* ``write_iter`` should either write all of the encoded data or none of it; it
+  must not do partial writes.
+* ``write_iter`` doesn't need to validate the encoded data; a subsequent read
+  may return, e.g., ``-EIO`` if the data is not valid.
+* The user may lie about the unencoded size of the data; a subsequent read
+  should truncate or zero-extend the unencoded data rather than returning an
+  error.
+* Be careful of page cache coherency.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1f76b1cb3348..4c391a3d6bad 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -53,6 +53,7 @@ filesystem implementations.
    journalling
    fscrypt
    fsverity
+   encoded_io
 
 Filesystems
 ===========
diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..f8db16e01227 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/encoded_io.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -1632,24 +1633,15 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 	return 0;
 }
 
-/*
- * Performs necessary checks before doing a write
- *
- * Can adjust writing position or amount of bytes to write.
- * Returns appropriate error code that caller should return or
- * zero in case that write should be allowed.
- */
-ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
+static int generic_write_checks_common(struct kiocb *iocb, loff_t *count)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	loff_t count;
-	int ret;
 
 	if (IS_SWAPFILE(inode))
 		return -ETXTBSY;
 
-	if (!iov_iter_count(from))
+	if (!*count)
 		return 0;
 
 	/* FIXME: this is for backwards compatibility with 2.4 */
@@ -1659,8 +1651,22 @@ ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
 		return -EINVAL;
 
-	count = iov_iter_count(from);
-	ret = generic_write_check_limits(file, iocb->ki_pos, &count);
+	return generic_write_check_limits(iocb->ki_filp, iocb->ki_pos, count);
+}
+
+/*
+ * Performs necessary checks before doing a write
+ *
+ * Can adjust writing position or amount of bytes to write.
+ * Returns appropriate error code that caller should return or
+ * zero in case that write should be allowed.
+ */
+ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
+{
+	loff_t count = iov_iter_count(from);
+	int ret;
+
+	ret = generic_write_checks_common(iocb, &count);
 	if (ret)
 		return ret;
 
@@ -1691,3 +1697,139 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
 	return 0;
 }
+
+/**
+ * generic_encoded_write_checks() - check an encoded write
+ * @iocb: I/O context.
+ * @encoded: Encoding metadata.
+ *
+ * This should be called by RWF_ENCODED write implementations rather than
+ * generic_write_checks(). Unlike generic_write_checks(), it returns -EFBIG
+ * instead of adjusting the size of the write.
+ *
+ * Return: 0 on success, -errno on error.
+ */
+int generic_encoded_write_checks(struct kiocb *iocb,
+				 const struct encoded_iov *encoded)
+{
+	loff_t count = encoded->len;
+	int ret;
+
+	if (!(iocb->ki_filp->f_flags & O_ALLOW_ENCODED))
+		return -EPERM;
+
+	ret = generic_write_checks_common(iocb, &count);
+	if (ret)
+		return ret;
+
+	if (count != encoded->len) {
+		/*
+		 * The write got truncated by generic_write_checks_common(). We
+		 * can't do a partial encoded write.
+		 */
+		return -EFBIG;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(generic_encoded_write_checks);
+
+/**
+ * copy_encoded_iov_from_iter() - copy a &struct encoded_iov from userspace
+ * @encoded: Returned encoding metadata.
+ * @from: Source iterator.
+ *
+ * This copies in the &struct encoded_iov and does some basic sanity checks.
+ * This should always be used rather than a plain copy_from_iter(), as it does
+ * the proper handling for backward- and forward-compatibility.
+ *
+ * Return: 0 on success, -EFAULT if access to userspace failed, -E2BIG if the
+ *         copied structure contained non-zero fields that this kernel doesn't
+ *         support, -EINVAL if the copied structure was invalid.
+ */
+int copy_encoded_iov_from_iter(struct encoded_iov *encoded,
+			       struct iov_iter *from)
+{
+	size_t usize;
+	int ret;
+
+	usize = iov_iter_single_seg_count(from);
+	if (usize > PAGE_SIZE)
+		return -E2BIG;
+	if (usize < ENCODED_IOV_SIZE_VER0)
+		return -EINVAL;
+	ret = copy_struct_from_iter(encoded, sizeof(*encoded), from);
+	if (ret)
+		return ret;
+
+	if (encoded->compression == ENCODED_IOV_COMPRESSION_NONE &&
+	    encoded->encryption == ENCODED_IOV_ENCRYPTION_NONE)
+		return -EINVAL;
+	if (encoded->compression > ENCODED_IOV_COMPRESSION_TYPES ||
+	    encoded->encryption > ENCODED_IOV_ENCRYPTION_TYPES)
+		return -EINVAL;
+	if (encoded->unencoded_offset > encoded->unencoded_len)
+		return -EINVAL;
+	if (encoded->len > encoded->unencoded_len - encoded->unencoded_offset)
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL(copy_encoded_iov_from_iter);
+
+/**
+ * generic_encoded_read_checks() - sanity check an RWF_ENCODED read
+ * @iocb: I/O context.
+ * @iter: Destination iterator for read.
+ *
+ * This should always be called by RWF_ENCODED read implementations before
+ * returning any data.
+ *
+ * Return: Number of bytes available to return encoded data in @iter on success,
+ *         -EPERM if the file was not opened with O_ALLOW_ENCODED, -EINVAL if
+ *         the size of the &struct encoded_iov iovec is invalid.
+ */
+ssize_t generic_encoded_read_checks(struct kiocb *iocb, struct iov_iter *iter)
+{
+	size_t usize;
+
+	if (!(iocb->ki_filp->f_flags & O_ALLOW_ENCODED))
+		return -EPERM;
+	usize = iov_iter_single_seg_count(iter);
+	if (usize > PAGE_SIZE || usize < ENCODED_IOV_SIZE_VER0)
+		return -EINVAL;
+	return iov_iter_count(iter) - usize;
+}
+EXPORT_SYMBOL(generic_encoded_read_checks);
+
+/**
+ * copy_encoded_iov_to_iter() - copy a &struct encoded_iov to userspace
+ * @encoded: Encoding metadata to return.
+ * @to: Destination iterator.
+ *
+ * This should always be used by RWF_ENCODED read implementations rather than a
+ * plain copy_to_iter(), as it does the proper handling for backward- and
+ * forward-compatibility. The iterator must be sanity-checked with
+ * generic_encoded_read_checks() before this is called.
+ *
+ * Return: 0 on success, -EFAULT if access to userspace failed, -E2BIG if there
+ *         were non-zero fields in @encoded that the user buffer could not
+ *         accommodate.
+ */
+int copy_encoded_iov_to_iter(const struct encoded_iov *encoded,
+			     struct iov_iter *to)
+{
+	size_t ksize = sizeof(*encoded);
+	size_t usize = iov_iter_single_seg_count(to);
+	size_t size = min(ksize, usize);
+
+	/* We already sanity-checked usize in generic_encoded_read_checks(). */
+
+	if (usize < ksize &&
+	    memchr_inv((char *)encoded + usize, 0, ksize - usize))
+		return -E2BIG;
+	if (copy_to_iter(encoded, size, to) != size ||
+	    (usize > ksize &&
+	     iov_iter_zero(usize - ksize, to) != usize - ksize))
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL(copy_encoded_iov_to_iter);
diff --git a/include/linux/encoded_io.h b/include/linux/encoded_io.h
new file mode 100644
index 000000000000..a8cfc0108ba0
--- /dev/null
+++ b/include/linux/encoded_io.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ENCODED_IO_H
+#define _LINUX_ENCODED_IO_H
+
+#include <uapi/linux/encoded_io.h>
+
+struct encoded_iov;
+struct iov_iter;
+struct kiocb;
+extern int generic_encoded_write_checks(struct kiocb *,
+					const struct encoded_iov *);
+extern int copy_encoded_iov_from_iter(struct encoded_iov *, struct iov_iter *);
+extern ssize_t generic_encoded_read_checks(struct kiocb *, struct iov_iter *);
+extern int copy_encoded_iov_to_iter(const struct encoded_iov *,
+				    struct iov_iter *);
+
+#endif /* _LINUX_ENCODED_IO_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..7b63f85204eb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -180,6 +180,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports async buffered reads */
 #define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
 
+/* File supports encoded IO */
+#define FMODE_ENCODED_IO	((__force fmode_t)0x80000000)
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -310,6 +313,7 @@ enum rw_hint {
 #define IOCB_SYNC		(__force int) RWF_SYNC
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
+#define IOCB_ENCODED		(__force int) RWF_ENCODED
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -3079,6 +3083,13 @@ extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
+struct encoded_iov;
+extern int generic_encoded_write_checks(struct kiocb *,
+					const struct encoded_iov *);
+extern int copy_encoded_iov_from_iter(struct encoded_iov *, struct iov_iter *);
+extern ssize_t generic_encoded_read_checks(struct kiocb *, struct iov_iter *);
+extern int copy_encoded_iov_to_iter(const struct encoded_iov *,
+				    struct iov_iter *);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
 ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *to,
 		ssize_t already_read);
@@ -3384,6 +3395,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 			return -EOPNOTSUPP;
 		kiocb_flags |= IOCB_NOIO;
 	}
+	if ((flags & RWF_ENCODED) && !(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
+		return -EOPNOTSUPP;
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/uapi/linux/encoded_io.h b/include/uapi/linux/encoded_io.h
new file mode 100644
index 000000000000..cf741453dba4
--- /dev/null
+++ b/include/uapi/linux/encoded_io.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_ENCODED_IO_H
+#define _UAPI_LINUX_ENCODED_IO_H
+
+#include <linux/types.h>
+
+#define ENCODED_IOV_COMPRESSION_NONE 0
+#define ENCODED_IOV_COMPRESSION_BTRFS_ZLIB 1
+#define ENCODED_IOV_COMPRESSION_BTRFS_ZSTD 2
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K 3
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K 4
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K 5
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K 6
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K 7
+#define ENCODED_IOV_COMPRESSION_TYPES 8
+
+#define ENCODED_IOV_ENCRYPTION_NONE 0
+#define ENCODED_IOV_ENCRYPTION_TYPES 1
+
+struct encoded_iov {
+	__aligned_u64 len;
+	__aligned_u64 unencoded_len;
+	__aligned_u64 unencoded_offset;
+	__u32 compression;
+	__u32 encryption;
+};
+
+#define ENCODED_IOV_SIZE_VER0 32
+
+#endif /* _UAPI_LINUX_ENCODED_IO_H */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..0800b01524e8 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -300,8 +300,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* encoded (e.g., compressed and/or encrypted) IO */
+#define RWF_ENCODED	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_ENCODED)
 
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.31.1

