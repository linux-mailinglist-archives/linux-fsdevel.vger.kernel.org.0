Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B32F8407
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbhAOSUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388286AbhAOSUO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:20:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D4023B04;
        Fri, 15 Jan 2021 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734773;
        bh=lWIceMQifieDhWiC7QjP98ytWH7p7DaIa26BuTP9jp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ypf1JetLybM+F+e7pC7oeQSMyx43ycU7RPuDdVAe/JXnM+tW7bytgXXmw4iWGRm5W
         swF5akPffhKQeVFslk0qFyN8fg9yQ1gW58OkZKIh3Q3gmeWHqmZhNOqqSNyC4MOONJ
         +f7AzkN60Kg0pc6LklapgdqZHrdlumgFEyPuUU3kfq2qnsQPlFjHeYc3pp/lPAtgtv
         fEDwbm+9FaUOStFLOZGak11/Q9lfplNgKjtoROiji0hWeUhJppUhArxb2xq8CEvboQ
         zdKqB7pV/zrlO+H21jIcFYenkDWDaAbuJWfx2WYX6sOw2wuA3RLuQeXiTEVjxWfNYj
         JXq6EF2rU8odA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [PATCH 3/6] fs-verity: add FS_IOC_READ_VERITY_METADATA ioctl
Date:   Fri, 15 Jan 2021 10:18:16 -0800
Message-Id: <20210115181819.34732-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115181819.34732-1-ebiggers@kernel.org>
References: <20210115181819.34732-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add an ioctl FS_IOC_READ_VERITY_METADATA which will allow reading verity
metadata from a file that has fs-verity enabled, including:

- The Merkle tree
- The fsverity_descriptor (not including the signature if present)
- The built-in signature, if present

This ioctl has similar semantics to pread().  It is passed the type of
metadata to read (one of the above three), and a buffer, offset, and
size.  It returns the number of bytes read or an error.

Separate patches will add support for each of the above metadata types.
This patch just adds the ioctl itself.

This ioctl doesn't make any assumption about where the metadata is
stored on-disk.  It does assume the metadata is in a stable format, but
that's basically already the case:

- The Merkle tree and fsverity_descriptor are defined by how fs-verity
  file digests are computed; see the "File digest computation" section
  of Documentation/filesystems/fsverity.rst.  Technically, the way in
  which the levels of the tree are ordered relative to each other wasn't
  previously specified, but it's logical to put the root level first.

- The built-in signature is the value passed to FS_IOC_ENABLE_VERITY.

This ioctl is useful because it allows writing a server program that
takes a verity file and serves it to a client program, such that the
client can do its own fs-verity compatible verification of the file.
This only makes sense if the client doesn't trust the server and if the
server needs to provide the storage for the client.

More concretely, there is interest in using this ability in Android to
export APK files (which are protected by fs-verity) to "protected VMs".
This would use Protected KVM (https://lwn.net/Articles/836693), which
provides an isolated execution environment without having to trust the
traditional "host".  A "guest" VM can boot from a signed image and
perform specific tasks in a minimum trusted environment using files that
have fs-verity enabled on the host, without trusting the host or
requiring that the guest has its own trusted storage.

Technically, it would be possible to duplicate the metadata and store it
in separate files for serving.  However, that would be less efficient
and would require extra care in userspace to maintain file consistency.

In addition to the above, the ability to read the built-in signatures is
useful because it allows a system that is using the in-kernel signature
verification to migrate to userspace signature verification.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fsverity.rst | 57 ++++++++++++++++++++++++++
 fs/ext4/ioctl.c                        |  7 ++++
 fs/f2fs/file.c                         | 11 +++++
 fs/verity/Makefile                     |  1 +
 fs/verity/read_metadata.c              | 55 +++++++++++++++++++++++++
 include/linux/fsverity.h               | 12 ++++++
 include/uapi/linux/fsverity.h          | 10 +++++
 7 files changed, 153 insertions(+)
 create mode 100644 fs/verity/read_metadata.c

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index e0204a23e997e..9ef7a7de60085 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -217,6 +217,63 @@ FS_IOC_MEASURE_VERITY can fail with the following errors:
 - ``EOVERFLOW``: the digest is longer than the specified
   ``digest_size`` bytes.  Try providing a larger buffer.
 
+FS_IOC_READ_VERITY_METADATA
+---------------------------
+
+The FS_IOC_READ_VERITY_METADATA ioctl reads verity metadata from a
+verity file.  This ioctl is available since Linux v5.12.
+
+This ioctl allows writing a server program that takes a verity file
+and serves it to a client program, such that the client can do its own
+fs-verity compatible verification of the file.  This only makes sense
+if the client doesn't trust the server and if the server needs to
+provide the storage for the client.
+
+This is a fairly specialized use case, and most fs-verity users won't
+need this ioctl.
+
+This ioctl takes in a pointer to the following structure::
+
+   struct fsverity_read_metadata_arg {
+           __u64 metadata_type;
+           __u64 offset;
+           __u64 length;
+           __u64 buf_ptr;
+           __u64 __reserved;
+   };
+
+``metadata_type`` specifies the type of metadata to read.
+
+The semantics are similar to those of ``pread()``.  ``offset``
+specifies the offset in bytes into the metadata item to read from, and
+``length`` specifies the maximum number of bytes to read from the
+metadata item.  ``buf_ptr`` is the pointer to the buffer to read into,
+cast to a 64-bit integer.  ``__reserved`` must be 0.  On success, the
+number of bytes read is returned.  0 is returned at the end of the
+metadata item.  The returned length may be less than ``length``, for
+example if the ioctl is interrupted.
+
+The metadata returned by FS_IOC_READ_VERITY_METADATA isn't guaranteed
+to be authenticated against the file digest that would be returned by
+`FS_IOC_MEASURE_VERITY`_, as the metadata is expected to be used to
+implement fs-verity compatible verification anyway (though absent a
+malicious disk, the metadata will indeed match).  E.g. to implement
+this ioctl, the filesystem is allowed to just read the Merkle tree
+blocks from disk without actually verifying the path to the root node.
+
+FS_IOC_READ_VERITY_METADATA can fail with the following errors:
+
+- ``EFAULT``: the caller provided inaccessible memory
+- ``EINTR``: the ioctl was interrupted before any data was read
+- ``EINVAL``: reserved fields were set, or ``offset + length``
+  overflowed
+- ``ENODATA``: the file is not a verity file
+- ``ENOTTY``: this type of filesystem does not implement fs-verity, or
+  this ioctl is not yet implemented on it
+- ``EOPNOTSUPP``: the kernel was not configured with fs-verity
+  support, or the filesystem superblock has not had the 'verity'
+  feature enabled on it.  (See `Filesystem support`_.)
+
 FS_IOC_GETFLAGS
 ---------------
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 524e134324475..56dc58adba8ac 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1306,6 +1306,12 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EOPNOTSUPP;
 		return fsverity_ioctl_measure(filp, (void __user *)arg);
 
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!ext4_has_feature_verity(sb))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp,
+						    (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -1388,6 +1394,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_GETFSMAP:
 	case FS_IOC_ENABLE_VERITY:
 	case FS_IOC_MEASURE_VERITY:
+	case FS_IOC_READ_VERITY_METADATA:
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	case EXT4_IOC_GETSTATE:
 	case EXT4_IOC_GET_ES_CACHE:
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f585545277d77..d0aefb5b97fac 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3357,6 +3357,14 @@ static int f2fs_ioc_measure_verity(struct file *filp, unsigned long arg)
 	return fsverity_ioctl_measure(filp, (void __user *)arg);
 }
 
+static int f2fs_ioc_read_verity_metadata(struct file *filp, unsigned long arg)
+{
+	if (!f2fs_sb_has_verity(F2FS_I_SB(file_inode(filp))))
+		return -EOPNOTSUPP;
+
+	return fsverity_ioctl_read_metadata(filp, (const void __user *)arg);
+}
+
 static int f2fs_ioc_getfslabel(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -4272,6 +4280,8 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_enable_verity(filp, arg);
 	case FS_IOC_MEASURE_VERITY:
 		return f2fs_ioc_measure_verity(filp, arg);
+	case FS_IOC_READ_VERITY_METADATA:
+		return f2fs_ioc_read_verity_metadata(filp, arg);
 	case FS_IOC_GETFSLABEL:
 		return f2fs_ioc_getfslabel(filp, arg);
 	case FS_IOC_SETFSLABEL:
@@ -4523,6 +4533,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_RESIZE_FS:
 	case FS_IOC_ENABLE_VERITY:
 	case FS_IOC_MEASURE_VERITY:
+	case FS_IOC_READ_VERITY_METADATA:
 	case FS_IOC_GETFSLABEL:
 	case FS_IOC_SETFSLABEL:
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
diff --git a/fs/verity/Makefile b/fs/verity/Makefile
index 570e9136334d4..435559a4fa9ea 100644
--- a/fs/verity/Makefile
+++ b/fs/verity/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_FS_VERITY) += enable.o \
 			   init.o \
 			   measure.o \
 			   open.o \
+			   read_metadata.o \
 			   verify.o
 
 obj-$(CONFIG_FS_VERITY_BUILTIN_SIGNATURES) += signature.o
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
new file mode 100644
index 0000000000000..43be990fd53e4
--- /dev/null
+++ b/fs/verity/read_metadata.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Ioctl to read verity metadata
+ *
+ * Copyright 2021 Google LLC
+ */
+
+#include "fsverity_private.h"
+
+#include <linux/uaccess.h>
+
+/**
+ * fsverity_ioctl_read_metadata() - read verity metadata from a file
+ * @filp: file to read the metadata from
+ * @uarg: user pointer to fsverity_read_metadata_arg
+ *
+ * Return: length read on success, 0 on EOF, -errno on failure
+ */
+int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg)
+{
+	struct inode *inode = file_inode(filp);
+	const struct fsverity_info *vi;
+	struct fsverity_read_metadata_arg arg;
+	int length;
+	void __user *buf;
+
+	vi = fsverity_get_info(inode);
+	if (!vi)
+		return -ENODATA; /* not a verity file */
+	/*
+	 * Note that we don't have to explicitly check that the file is open for
+	 * reading, since verity files can only be opened for reading.
+	 */
+
+	if (copy_from_user(&arg, uarg, sizeof(arg)))
+		return -EFAULT;
+
+	if (arg.__reserved)
+		return -EINVAL;
+
+	/* offset + length must not overflow. */
+	if (arg.offset + arg.length < arg.offset)
+		return -EINVAL;
+
+	/* Ensure that the return value will fit in INT_MAX. */
+	length = min_t(u64, arg.length, INT_MAX);
+
+	buf = u64_to_user_ptr(arg.buf_ptr);
+
+	switch (arg.metadata_type) {
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(fsverity_ioctl_read_metadata);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index c1144a4503920..b568b3c7d095e 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -138,6 +138,10 @@ int fsverity_file_open(struct inode *inode, struct file *filp);
 int fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void fsverity_cleanup_inode(struct inode *inode);
 
+/* read_metadata.c */
+
+int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
+
 /* verify.c */
 
 bool fsverity_verify_page(struct page *page);
@@ -183,6 +187,14 @@ static inline void fsverity_cleanup_inode(struct inode *inode)
 {
 }
 
+/* read_metadata.c */
+
+static inline int fsverity_ioctl_read_metadata(struct file *filp,
+					       const void __user *uarg)
+{
+	return -EOPNOTSUPP;
+}
+
 /* verify.c */
 
 static inline bool fsverity_verify_page(struct page *page)
diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
index 33f44156f8ea5..e062751294d01 100644
--- a/include/uapi/linux/fsverity.h
+++ b/include/uapi/linux/fsverity.h
@@ -83,7 +83,17 @@ struct fsverity_formatted_digest {
 	__u8 digest[];
 };
 
+struct fsverity_read_metadata_arg {
+	__u64 metadata_type;
+	__u64 offset;
+	__u64 length;
+	__u64 buf_ptr;
+	__u64 __reserved;
+};
+
 #define FS_IOC_ENABLE_VERITY	_IOW('f', 133, struct fsverity_enable_arg)
 #define FS_IOC_MEASURE_VERITY	_IOWR('f', 134, struct fsverity_digest)
+#define FS_IOC_READ_VERITY_METADATA \
+	_IOWR('f', 135, struct fsverity_read_metadata_arg)
 
 #endif /* _UAPI_LINUX_FSVERITY_H */
-- 
2.30.0

