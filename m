Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C9524CF7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHUHjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgHUHi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:38:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1A7C06138B
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:38:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so524570plr.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7nmOKKnzuw08JzbWz9S0vd+MFbiT4hw/Chd9PX4ZOw=;
        b=wz1QmbUYJKU+Q7LFSB1tYfwiECD8FKoD5F6G3knrVhNPhSt3w+2lkmzQVEp3NflNuK
         xKqcWtwJpod9vm/nDGTClJ/KR8QgElBtCOT4YTPlnDSdW3dMFO/02QGVM3sS0ESn/lNk
         x0gZG9lmVXf3tIZmg8KRwZUSHY9cyqFXX+qAtodabQNN/LDeABOQVLSVBAdCTcLTUFYB
         CBP3TTZHKDvHJRA1wK+u000/JzbU3wsHsKxqTbH5SazNMUQ7o/cn9zfP70OoadAehs64
         96rv+0aTyAnAH67NQ/QwqNux7x9B0Hb9FTSBq/RXWoRkxTdYod70auTvl2GwAYX8dW5t
         38Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7nmOKKnzuw08JzbWz9S0vd+MFbiT4hw/Chd9PX4ZOw=;
        b=Iz7D6XbRp+tt70Nhvtd8hOoFpb2jp6wqcY/UYp0yMRVGSGcwxerEVnvlVow8stVzWX
         WyYwyGcKrKEsp5td0WuMc8Rhp2EP6rrgmFTYNOh7zb9Hs3CGWbF6rezzPXojY8j20JvZ
         Qh9I1z8Pocq75x2Xa9EqlHEO5BGMwTChlirw9doXdkkE89kyWFrGdmDgOlF7x0zaVjuT
         4AGd/KNbwMBS9Wej4qoev2cFWrnfyv0TxI4/JJnJdraxSneyfqEhwFnvTDtPhrjmCG8F
         u+42/JPnaB93vS2aKDOAY28BsoZ2+aYKpWV9SADTymOZYi+roLu7h60Lp8KKVdFzMrUO
         WXLg==
X-Gm-Message-State: AOAM530kH8PRYXtBEw3PQTPYAPOUImsAfzThKmGusjglk3GwSAa3Sxd3
        svLfl1JHofi6T57vXgX86yQNugZgtsdvwA==
X-Google-Smtp-Source: ABdhPJzNq5b0oCyp5wN5loyDfbwwJJc2y7r3fFrA/34tycWTESDg8chxCrwnWO1bAGqsKLSyvM4Png==
X-Received: by 2002:a17:90a:4dca:: with SMTP id r10mr1430612pjl.200.1597995537889;
        Fri, 21 Aug 2020 00:38:57 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id t10sm1220867pgp.15.2020.08.21.00.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:38:56 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 3/9] fs: add RWF_ENCODED for reading/writing compressed data
Date:   Fri, 21 Aug 2020 00:38:34 -0700
Message-Id: <9020a583581b644ae86b7c05de6a39fd5204f06d.1597993855.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597993855.git.osandov@osandov.com>
References: <cover.1597993855.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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

This adds the VFS helpers for supporting encoded I/O and documentation
for filesystem support.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 Documentation/filesystems/encoded_io.rst |  74 ++++++++++
 Documentation/filesystems/index.rst      |   1 +
 include/linux/fs.h                       |  16 +++
 include/uapi/linux/fs.h                  |  33 ++++-
 mm/filemap.c                             | 166 +++++++++++++++++++++--
 5 files changed, 276 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst

diff --git a/Documentation/filesystems/encoded_io.rst b/Documentation/filesystems/encoded_io.rst
new file mode 100644
index 000000000000..50405276d866
--- /dev/null
+++ b/Documentation/filesystems/encoded_io.rst
@@ -0,0 +1,74 @@
+===========
+Encoded I/O
+===========
+
+Encoded I/O is a mechanism for reading and writing encoded (e.g., compressed
+and/or encrypted) data directly from/to the filesystem. The userspace interface
+is thoroughly described in the :manpage:`encoded_io(7)` man page; this document
+describes the requirements for filesystem support.
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
+=====
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
+======
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
index 4c536e66dc4c..9adbbc3c7441 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -55,6 +55,7 @@ filesystem implementations.
    journalling
    fscrypt
    fsverity
+   encoded_io
 
 Filesystems
 ===========
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e019ea2f1347..a3fe6fa9687c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -178,6 +178,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports async buffered reads */
 #define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
 
+/* File supports encoded IO */
+#define FMODE_ENCODED_IO	((__force fmode_t)0x80000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
@@ -321,6 +324,7 @@ enum rw_hint {
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 8)
 #define IOCB_NOIO		(1 << 9)
+#define IOCB_ENCODED		(1 << 10)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -3006,6 +3010,13 @@ extern int sb_min_blocksize(struct super_block *, int);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
+struct encoded_iov;
+extern int generic_encoded_write_checks(struct kiocb *,
+					const struct encoded_iov *);
+extern int copy_encoded_iov_from_iter(struct encoded_iov *, struct iov_iter *);
+extern ssize_t generic_encoded_read_checks(struct kiocb *, struct iov_iter *);
+extern int copy_encoded_iov_to_iter(const struct encoded_iov *,
+				    struct iov_iter *);
 extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				loff_t *count, unsigned int remap_flags);
@@ -3324,6 +3335,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 			return -EOPNOTSUPP;
 		kiocb_flags |= IOCB_NOWAIT | IOCB_NOIO;
 	}
+	if (flags & RWF_ENCODED) {
+		if (!(ki->ki_filp->f_mode & FMODE_ENCODED_IO))
+			return -EOPNOTSUPP;
+		kiocb_flags |= IOCB_ENCODED;
+	}
 	if (flags & RWF_HIPRI)
 		kiocb_flags |= IOCB_HIPRI;
 	if (flags & RWF_DSYNC)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..972390d3089d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -279,6 +279,34 @@ struct fsxattr {
 					 SYNC_FILE_RANGE_WAIT_BEFORE | \
 					 SYNC_FILE_RANGE_WAIT_AFTER)
 
+enum {
+	ENCODED_IOV_COMPRESSION_NONE,
+#define ENCODED_IOV_COMPRESSION_NONE ENCODED_IOV_COMPRESSION_NONE
+	ENCODED_IOV_COMPRESSION_ZLIB,
+#define ENCODED_IOV_COMPRESSION_ZLIB ENCODED_IOV_COMPRESSION_ZLIB
+	ENCODED_IOV_COMPRESSION_LZO,
+#define ENCODED_IOV_COMPRESSION_LZO ENCODED_IOV_COMPRESSION_LZO
+	ENCODED_IOV_COMPRESSION_ZSTD,
+#define ENCODED_IOV_COMPRESSION_ZSTD ENCODED_IOV_COMPRESSION_ZSTD
+	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_ZSTD,
+};
+
+enum {
+	ENCODED_IOV_ENCRYPTION_NONE,
+#define ENCODED_IOV_ENCRYPTION_NONE ENCODED_IOV_ENCRYPTION_NONE
+	ENCODED_IOV_ENCRYPTION_TYPES = ENCODED_IOV_ENCRYPTION_NONE,
+};
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
 /*
  * Flags for preadv2/pwritev2:
  */
@@ -300,8 +328,11 @@ typedef int __bitwise __kernel_rwf_t;
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
diff --git a/mm/filemap.c b/mm/filemap.c
index 1aaea26556cc..f28b42888144 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3022,24 +3022,15 @@ static int generic_write_check_limits(struct file *file, loff_t pos,
 	return 0;
 }
 
-/*
- * Performs necessary checks before doing a write
- *
- * Can adjust writing position or amount of bytes to write.
- * Returns appropriate error code that caller should return or
- * zero in case that write should be allowed.
- */
-inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
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
@@ -3049,8 +3040,21 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
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
+ * Returns a negative errno or the new number of bytes to write.
+ */
+inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
+{
+	loff_t count = iov_iter_count(from);
+	int ret;
+
+	ret = generic_write_checks_common(iocb, &count);
 	if (ret)
 		return ret;
 
@@ -3059,6 +3063,142 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_write_checks);
 
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
+	ret = copy_struct_from_iter(encoded, sizeof(*encoded), from, usize);
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
+
 /*
  * Performs necessary checks before doing a clone.
  *
-- 
2.28.0

