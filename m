Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A022B8496
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgKRTSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgKRTSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:18:41 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840A2C061A48
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:18:40 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v12so2023323pfm.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZS1I+iubJlvGTh/5zhzfr+dwFvZv2oTc0CEWdPvDISI=;
        b=sYbwczFFGSZLjQsg+OsnMDPxOwTjpFioIFSjgdyrm/adp92sQP59P/5s1dz/uVCSzB
         IyMwlU8/4zihkX/cjPreNGUuUvhJF4i/riVtp9Hyqs6pwizy/ZamqCOU+gJdS1uRImq4
         W2nxA/cqUm9m3jYzFfbpFLAfT2FihMqGunzUYTMkr1AIeD8Cn3+gKuQBPLWS7gsYOyAj
         AsUHf50do1Rxr3kvLJepw3h0CvjtzpqPlTjJcVn4oH6kwdOz8XKyxXyVWjY2mr9Vq/Rm
         KnHrmwLrf8Tpq3T9OAClexVNPSreDArOMuFlVi/qSr/zJIVC1nv6GlazPNhKhKFrdPd0
         rQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS1I+iubJlvGTh/5zhzfr+dwFvZv2oTc0CEWdPvDISI=;
        b=e2DiEgFpp8HG6bNI2OMn869N/5rz7qHuqcICssgWXpoBb3h+oWUQe75KqO23zQMtYG
         z84Uz0Hp2jOPHcwrRJxyBZ9KtKeol75tQgEHrollFq1Ms3fGJ6TMvL3YCYRQK/kKdhgq
         5RRXFQE/gIKQzWjxKhRztMJ2LtUICIn+T7pUiBcdwWIkRbvGoCbfqLut8xy+qK9jUdDm
         RNkCdrwcaAzcijv5MfTkZE9fXhcM2AR0csXUMG7kwCFxWYVxYze5odCDWElSDPIVPrOz
         geCg36IZKnDs+zct0aEv61gv9tBcapERSKov9PQr77AOmvgwhyX+Wz0Lz9G12pwFmYQk
         Iagw==
X-Gm-Message-State: AOAM532SUzgxnxBwelkx0411q7R07ZnpxYD4rVrVbaVmo5QebPTYBV1r
        IAEzZ7t019Gj9XTl4c1y6nxGLTdkBtteyw==
X-Google-Smtp-Source: ABdhPJzALwrnt7hm2+zRDSR3pJfCPBy4OvEskRy4U/p38/SjQINTVBFn9iE4DcfMZ+GcuELTDLczJQ==
X-Received: by 2002:a63:381:: with SMTP id 123mr9975085pgd.112.1605727119243;
        Wed, 18 Nov 2020 11:18:39 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id c22sm19491863pfo.211.2020.11.18.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:18:38 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v6 03/11] fs: add RWF_ENCODED for reading/writing compressed data
Date:   Wed, 18 Nov 2020 11:18:10 -0800
Message-Id: <a14f36933f38a80ed1962bd82986fe0e9d92d586.1605723568.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723568.git.osandov@fb.com>
References: <cover.1605723568.git.osandov@fb.com>
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

This adds the VFS helpers for supporting encoded I/O and documentation
for filesystem support.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 Documentation/filesystems/encoded_io.rst |  74 ++++++++++
 Documentation/filesystems/index.rst      |   1 +
 fs/read_write.c                          | 167 +++++++++++++++++++++--
 include/linux/fs.h                       |  11 ++
 include/uapi/linux/fs.h                  |  41 +++++-
 5 files changed, 280 insertions(+), 14 deletions(-)
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
index 98f59a864242..6d9e3ff0a455 100644
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
index 75f764b43418..e2ad418d2987 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1625,24 +1625,15 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
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
@@ -1652,8 +1643,22 @@ ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
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
 
@@ -1684,3 +1689,139 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8667d0cdc71e..67810bf6fb1c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -178,6 +178,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports async buffered reads */
 #define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
 
+/* File supports encoded IO */
+#define FMODE_ENCODED_IO	((__force fmode_t)0x80000000)
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -308,6 +311,7 @@ enum rw_hint {
 #define IOCB_SYNC		(__force int) RWF_SYNC
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
+#define IOCB_ENCODED		(__force int) RWF_ENCODED
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -2964,6 +2968,13 @@ extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
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
 extern ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		struct iov_iter *to, ssize_t already_read);
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..95493420117a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -279,6 +279,42 @@ struct fsxattr {
 					 SYNC_FILE_RANGE_WAIT_BEFORE | \
 					 SYNC_FILE_RANGE_WAIT_AFTER)
 
+enum {
+	ENCODED_IOV_COMPRESSION_NONE,
+#define ENCODED_IOV_COMPRESSION_NONE ENCODED_IOV_COMPRESSION_NONE
+	ENCODED_IOV_COMPRESSION_BTRFS_ZLIB,
+#define ENCODED_IOV_COMPRESSION_BTRFS_ZLIB ENCODED_IOV_COMPRESSION_BTRFS_ZLIB
+	ENCODED_IOV_COMPRESSION_BTRFS_ZSTD,
+#define ENCODED_IOV_COMPRESSION_BTRFS_ZSTD ENCODED_IOV_COMPRESSION_BTRFS_ZSTD
+	ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K
+	ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K ENCODED_IOV_COMPRESSION_BTRFS_LZO_8K
+	ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K ENCODED_IOV_COMPRESSION_BTRFS_LZO_16K
+	ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K ENCODED_IOV_COMPRESSION_BTRFS_LZO_32K
+	ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K,
+#define ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K
+	ENCODED_IOV_COMPRESSION_TYPES = ENCODED_IOV_COMPRESSION_BTRFS_LZO_64K,
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
@@ -300,8 +336,11 @@ typedef int __bitwise __kernel_rwf_t;
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
2.29.2

