Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B375350B87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDABIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhDABIx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:08:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B6D261057;
        Thu,  1 Apr 2021 01:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239333;
        bh=s1vnFkM93qidlmxs8gaOkPwGZyfYT15DiNKJAyKcX4I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ahtoiLSkVEulXiBJub8SgK+Ewp+Nd6/vKGwhTptZmc8SrIpB0O4fJKBZv4Bi7CZdI
         L/f2th1yBlndKNO9fCNjh5nCYqDm+q582pJcgB6njiH+yubC9KiQNLCKV3NFI3XobL
         bB/BvTHWk4aLcx3udav1+bu9ieLifSR3VMCPr2WwznnTOozavh8VO0awo/VrpRXDDc
         qiVF3OppAIGKNLxWn0Gr7mLwGcZvEqQILqiX32Fhg2GWIrWAq2hxV1gMgodrEXu+N8
         AlL1W4yLYCUHLUyV8y5Ek2WOyCt0NMw6TiQyUKN3R3dJH59SASd0XAhRk8CAbBjQhx
         5RigQ0SD7D7Jg==
Subject: [PATCH 01/18] vfs: introduce new file range exchange ioctl
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:08:52 -0700
Message-ID: <161723933214.3149451.12102627412985512284.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Introduce a new ioctl to handle swapping ranges of bytes between files.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/filesystems/vfs.rst |   16 ++
 fs/ioctl.c                        |   42 +++++
 fs/remap_range.c                  |  283 +++++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_fs.h            |    1 
 include/linux/fs.h                |   14 ++
 include/uapi/linux/fiexchange.h   |  101 +++++++++++++
 6 files changed, 456 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/fiexchange.h


diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 2049bbf5e388..9f16b260bc7e 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1006,6 +1006,8 @@ This describes how the VFS can manipulate an open file.  As of kernel
 		loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
 					   struct file *file_out, loff_t pos_out,
 					   loff_t len, unsigned int remap_flags);
+                int (*xchg_file_range)(struct file *file1, struct file *file2,
+                                       struct file_xchg_range *fxr);
 		int (*fadvise)(struct file *, loff_t, loff_t, int);
 	};
 
@@ -1124,6 +1126,20 @@ otherwise noted.
 	ok with the implementation shortening the request length to
 	satisfy alignment or EOF requirements (or any other reason).
 
+``xchg_file_range``
+	called by the ioctl(2) system call for FIEXCHANGE_RANGE to exchange the
+	contents of two file ranges.  An implementation should exchange
+	fxr.length bytes starting at fxr.file1_offset in file1 with the same
+	number of bytes starting at fxr.file2_offset in file2.  Refer to
+	fiexchange.h file for more information.  Implementations must call
+	generic_xchg_file_range_prep to prepare the two files prior to taking
+	locks; they must call generic_xchg_file_range_check_fresh once the
+	inode is locked to abort the call if file2 has changed; and they must
+	update the inode change and mod times of both files as part of the
+	metadata update.  The timestamp updates must be done atomically as part
+	of the data exchange operation to ensure correctness of the freshness
+	check.
+
 ``fadvise``
 	possibly called by the fadvise64() system call.
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4e6cc0a7d69c..a1c64fdfd2f2 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -260,6 +260,45 @@ static long ioctl_file_clone_range(struct file *file,
 				args.src_length, args.dest_offset);
 }
 
+static long ioctl_file_xchg_range(struct file *file2,
+				  struct file_xchg_range __user *argp)
+{
+	struct file_xchg_range args;
+	struct fd file1;
+	__u64 old_flags;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	file1 = fdget(args.file1_fd);
+	if (!file1.file)
+		return -EBADF;
+
+	ret = -EXDEV;
+	if (file1.file->f_path.mnt != file2->f_path.mnt)
+		goto fdput;
+
+	old_flags = args.flags;
+
+	ret = vfs_xchg_file_range(file1.file, file2, &args);
+	if (ret)
+		goto fdput;
+
+	/*
+	 * The VFS will set RANGE_FSYNC on its own if the file or inode require
+	 * synchronous writes.  Don't leak this back to userspace.
+	 */
+	args.flags &= ~FILE_XCHG_RANGE_FSYNC;
+	args.flags |= (old_flags & FILE_XCHG_RANGE_FSYNC);
+
+	if (copy_to_user(argp, &args, sizeof(args)))
+		ret = -EFAULT;
+fdput:
+	fdput(file1);
+	return ret;
+}
+
 #ifdef CONFIG_BLOCK
 
 static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
@@ -720,6 +759,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FIDEDUPERANGE:
 		return ioctl_file_dedupe_range(filp, argp);
 
+	case FIEXCHANGE_RANGE:
+		return ioctl_file_xchg_range(filp, argp);
+
 	case FIONREAD:
 		if (!S_ISREG(inode->i_mode))
 			return vfs_ioctl(filp, cmd, arg);
diff --git a/fs/remap_range.c b/fs/remap_range.c
index e4a5fdd7ad7b..1a0bbd73106e 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -580,3 +580,286 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	return ret;
 }
 EXPORT_SYMBOL(vfs_dedupe_file_range);
+
+/* Performs necessary checks before doing a range exchange. */
+static int generic_xchg_file_range_checks(struct file *file1,
+					  struct file *file2,
+					  const struct file_xchg_range *fxr,
+					  unsigned int blocksize)
+{
+	struct inode *inode1 = file1->f_mapping->host;
+	struct inode *inode2 = file2->f_mapping->host;
+	int64_t test_len;
+	uint64_t blen;
+	loff_t size1, size2;
+	int ret;
+
+	if (fxr->length < 0)
+		return -EINVAL;
+
+	/* The start of both ranges must be aligned to an fs block. */
+	if (!IS_ALIGNED(fxr->file1_offset, blocksize) ||
+	    !IS_ALIGNED(fxr->file2_offset, blocksize))
+		return -EINVAL;
+
+	/* Ensure offsets don't wrap. */
+	if (fxr->file1_offset + fxr->length < fxr->file1_offset ||
+	    fxr->file2_offset + fxr->length < fxr->file2_offset)
+		return -EINVAL;
+
+	size1 = i_size_read(inode1);
+	size2 = i_size_read(inode2);
+
+	/*
+	 * We require both ranges to be within EOF, unless we're exchanging
+	 * to EOF.  generic_xchg_range_prep already checked that both
+	 * fxr->file1_offset and fxr->file2_offset are within EOF.
+	 */
+	if (!(fxr->flags & FILE_XCHG_RANGE_TO_EOF) &&
+	    (fxr->file1_offset + fxr->length > size1 ||
+	     fxr->file2_offset + fxr->length > size2))
+		return -EINVAL;
+
+	/*
+	 * Make sure we don't hit any file size limits.  If we hit any size
+	 * limits such that test_length was adjusted, we abort the whole
+	 * operation.
+	 */
+	test_len = fxr->length;
+	ret = generic_write_check_limits(file2, fxr->file2_offset, &test_len);
+	if (ret)
+		return ret;
+	ret = generic_write_check_limits(file1, fxr->file1_offset, &test_len);
+	if (ret)
+		return ret;
+	if (test_len != fxr->length)
+		return -EINVAL;
+
+	/*
+	 * If the user wanted us to exchange up to the infile's EOF, round up
+	 * to the next block boundary for this check.  Do the same for the
+	 * outfile.
+	 *
+	 * Otherwise, reject the range length if it's not block aligned.  We
+	 * already confirmed the starting offsets' block alignment.
+	 */
+	if (fxr->file1_offset + fxr->length == size1)
+		blen = ALIGN(size1, blocksize) - fxr->file1_offset;
+	else if (fxr->file2_offset + fxr->length == size2)
+		blen = ALIGN(size2, blocksize) - fxr->file2_offset;
+	else if (!IS_ALIGNED(fxr->length, blocksize))
+		return -EINVAL;
+	else
+		blen = fxr->length;
+
+	/* Don't allow overlapped exchanges within the same file. */
+	if (inode1 == inode2 &&
+	    fxr->file2_offset + blen > fxr->file1_offset &&
+	    fxr->file1_offset + blen > fxr->file2_offset)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Check that the two inodes are eligible for range exchanges, the ranges make
+ * sense, and then flush all dirty data.  Caller must ensure that the inodes
+ * have been locked against any other modifications.
+ */
+int generic_xchg_file_range_prep(struct file *file1, struct file *file2,
+				 struct file_xchg_range *fxr,
+				 unsigned int blocksize)
+{
+	struct inode *inode1 = file_inode(file1);
+	struct inode *inode2 = file_inode(file2);
+	u64 blkmask = blocksize - 1;
+	bool same_inode = (inode1 == inode2);
+	int ret;
+
+	/* Don't touch certain kinds of inodes */
+	if (IS_IMMUTABLE(inode1) || IS_IMMUTABLE(inode2))
+		return -EPERM;
+	if (IS_SWAPFILE(inode1) || IS_SWAPFILE(inode2))
+		return -ETXTBSY;
+
+	/* Don't reflink dirs, pipes, sockets... */
+	if (S_ISDIR(inode1->i_mode) || S_ISDIR(inode2->i_mode))
+		return -EISDIR;
+	if (!S_ISREG(inode1->i_mode) || !S_ISREG(inode2->i_mode))
+		return -EINVAL;
+
+	/* Ranges cannot start after EOF. */
+	if (fxr->file1_offset > i_size_read(inode1) ||
+	    fxr->file2_offset > i_size_read(inode2))
+		return -EINVAL;
+
+	/*
+	 * If the caller said to exchange to EOF, we set the length of the
+	 * request large enough to cover everything to the end of both files.
+	 */
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
+		fxr->length = max_t(int64_t,
+				    i_size_read(inode1) - fxr->file1_offset,
+				    i_size_read(inode2) - fxr->file2_offset);
+
+	/* Zero length exchange exits immediately. */
+	if (fxr->length == 0)
+		return 0;
+
+	/* Check that we don't violate system file offset limits. */
+	ret = generic_xchg_file_range_checks(file1, file2, fxr, blocksize);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ensure that we don't exchange a partial EOF block into the middle of
+	 * another file.
+	 */
+	if (fxr->length & blkmask) {
+		loff_t new_length = fxr->length;
+
+		if (fxr->file2_offset + new_length < i_size_read(inode2))
+			new_length &= ~blkmask;
+
+		if (fxr->file1_offset + new_length < i_size_read(inode1))
+			new_length &= ~blkmask;
+
+		if (new_length != fxr->length)
+			return -EINVAL;
+	}
+
+	/* Wait for the completion of any pending IOs on both files */
+	inode_dio_wait(inode1);
+	if (!same_inode)
+		inode_dio_wait(inode2);
+
+	ret = filemap_write_and_wait_range(inode1->i_mapping, fxr->file1_offset,
+					   fxr->file1_offset + fxr->length - 1);
+	if (ret)
+		return ret;
+
+	ret = filemap_write_and_wait_range(inode2->i_mapping, fxr->file2_offset,
+					   fxr->file2_offset + fxr->length - 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the files or inodes involved require synchronous writes, amend
+	 * the request to force the filesystem to flush all data and metadata
+	 * to disk after the operation completes.
+	 */
+	if (((file1->f_flags | file2->f_flags) & (__O_SYNC | O_DSYNC)) ||
+	    IS_SYNC(file_inode(file1)) || IS_SYNC(file_inode(file2)))
+		fxr->flags |= FILE_XCHG_RANGE_FSYNC;
+
+	/* Remove privilege bits from both files. */
+	ret = file_remove_privs(file1);
+	if (ret)
+		return ret;
+	return file_remove_privs(file2);
+}
+EXPORT_SYMBOL(generic_xchg_file_range_prep);
+
+/*
+ * Check that both files' metadata agree with the snapshot that we took for
+ * the range exchange request.
+
+ * This should be called after the filesystem has locked /all/ inode metadata
+ * against modification.
+ */
+int generic_xchg_file_range_check_fresh(struct inode *inode1,
+					struct inode *inode2,
+					const struct file_xchg_range *fxr)
+{
+	/* Check that the offset/length values cover all of both files */
+	if ((fxr->flags & FILE_XCHG_RANGE_FULL_FILES) &&
+	    (fxr->file1_offset != 0 ||
+	     fxr->file2_offset != 0 ||
+	     fxr->length != i_size_read(inode1) ||
+	     fxr->length != i_size_read(inode2)))
+		return -EDOM;
+
+	/* Check that file2 hasn't otherwise been modified. */
+	if ((fxr->flags & FILE_XCHG_RANGE_FILE2_FRESH) &&
+	    (fxr->file2_ino        != inode2->i_ino ||
+	     fxr->file2_ctime      != inode2->i_ctime.tv_sec  ||
+	     fxr->file2_ctime_nsec != inode2->i_ctime.tv_nsec ||
+	     fxr->file2_mtime      != inode2->i_mtime.tv_sec  ||
+	     fxr->file2_mtime_nsec != inode2->i_mtime.tv_nsec))
+		return -EBUSY;
+
+	return 0;
+}
+EXPORT_SYMBOL(generic_xchg_file_range_check_fresh);
+
+static inline int xchg_range_verify_area(struct file *file, loff_t pos,
+					 struct file_xchg_range *fxr)
+{
+	int64_t len = fxr->length;
+
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
+		len = min_t(int64_t, len, i_size_read(file_inode(file)) - pos);
+	return remap_verify_area(file, pos, len, true);
+}
+
+int do_xchg_file_range(struct file *file1, struct file *file2,
+		       struct file_xchg_range *fxr)
+{
+	int ret;
+
+	if ((fxr->flags & ~FILE_XCHG_RANGE_ALL_FLAGS) ||
+	    memchr_inv(&fxr->pad, 0, sizeof(fxr->pad)))
+		return -EINVAL;
+
+	if ((fxr->flags & FILE_XCHG_RANGE_FULL_FILES) &&
+	    (fxr->flags & FILE_XCHG_RANGE_TO_EOF))
+		return -EINVAL;
+
+	/*
+	 * The ioctl enforces that src and dest files are on the same mount.
+	 * Practically, they only need to be on the same file system.
+	 */
+	if (file_inode(file1)->i_sb != file_inode(file2)->i_sb)
+		return -EXDEV;
+
+	ret = generic_file_rw_checks(file1, file2);
+	if (ret < 0)
+		return ret;
+
+	ret = generic_file_rw_checks(file2, file1);
+	if (ret < 0)
+		return ret;
+
+	if (!file1->f_op->xchg_file_range)
+		return -EOPNOTSUPP;
+
+	ret = xchg_range_verify_area(file1, fxr->file1_offset, fxr);
+	if (ret)
+		return ret;
+
+	ret = xchg_range_verify_area(file2, fxr->file2_offset, fxr);
+	if (ret)
+		return ret;
+
+	ret = file2->f_op->xchg_file_range(file1, file2, fxr);
+	if (ret)
+		return ret;
+
+	fsnotify_modify(file1);
+	fsnotify_modify(file2);
+	return 0;
+}
+EXPORT_SYMBOL(do_xchg_file_range);
+
+int vfs_xchg_file_range(struct file *file1, struct file *file2,
+			struct file_xchg_range *fxr)
+{
+	int ret;
+
+	file_start_write(file2);
+	ret = do_xchg_file_range(file1, file2, fxr);
+	file_end_write(file2);
+
+	return ret;
+}
+EXPORT_SYMBOL(vfs_xchg_file_range);
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 75cdf2685c0d..e7e1e3051739 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -848,6 +848,7 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_FSGEOMETRY	     _IOR ('X', 126, struct xfs_fsop_geom)
 #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
 #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
+/*	FIEXCHANGE_RANGE ----------- hoisted 129	 */
 /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
 
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..a38209fdf200 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -44,6 +44,7 @@
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
+#include <uapi/linux/fiexchange.h>
 
 struct backing_dev_info;
 struct bdi_writeback;
@@ -1924,6 +1925,8 @@ struct file_operations {
 	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
+	int (*xchg_file_range)(struct file *file1, struct file *file2,
+			       struct file_xchg_range *fsr);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
 } __randomize_layout;
 
@@ -1993,6 +1996,9 @@ extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					 struct file *file_out, loff_t pos_out,
 					 loff_t *count,
 					 unsigned int remap_flags);
+extern int generic_xchg_file_range_prep(struct file *file1, struct file *file2,
+					struct file_xchg_range *fsr,
+					unsigned int blocksize);
 extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  loff_t len, unsigned int remap_flags);
@@ -2004,7 +2010,13 @@ extern int vfs_dedupe_file_range(struct file *file,
 extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
-
+extern int do_xchg_file_range(struct file *file1, struct file *file2,
+			      struct file_xchg_range *fsr);
+extern int vfs_xchg_file_range(struct file *file1, struct file *file2,
+			       struct file_xchg_range *fsr);
+extern int generic_xchg_file_range_check_fresh(struct inode *inode1,
+					struct inode *inode2,
+					const struct file_xchg_range *fsr);
 
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
diff --git a/include/uapi/linux/fiexchange.h b/include/uapi/linux/fiexchange.h
new file mode 100644
index 000000000000..17372590371a
--- /dev/null
+++ b/include/uapi/linux/fiexchange.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
+/*
+ * FIEXCHANGE ioctl definitions, to facilitate exchanging parts of files.
+ *
+ * Copyright (C) 2021 Oracle.  All Rights Reserved.
+ *
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef _LINUX_FIEXCHANGE_H
+#define _LINUX_FIEXCHANGE_H
+
+#include <linux/types.h>
+
+/*
+ * Exchange part of file1 with part of the file that this ioctl that is being
+ * called against (which we'll call file2).  Filesystems must be able to
+ * restart and complete the operation even after the system goes down.
+ */
+struct file_xchg_range {
+	__s64		file1_fd;
+	__s64		file1_offset;	/* file1 offset, bytes */
+	__s64		file2_offset;	/* file2 offset, bytes */
+	__s64		length;		/* bytes to exchange */
+
+	__u64		flags;		/* see FILE_XCHG_RANGE_* below */
+
+	/* file2 metadata for optional freshness checks */
+	__s64		file2_ino;	/* inode number */
+	__s64		file2_mtime;	/* modification time */
+	__s64		file2_ctime;	/* change time */
+	__s32		file2_mtime_nsec; /* mod time, nsec */
+	__s32		file2_ctime_nsec; /* change time, nsec */
+
+	__u64		pad[6];		/* must be zeroes */
+};
+
+/*
+ * Atomic exchange operations are not required.  This relaxes the requirement
+ * that the filesystem must be able to complete the operation after a crash.
+ */
+#define FILE_XCHG_RANGE_NONATOMIC	(1 << 0)
+
+/*
+ * Check that file2's inode number, mtime, and ctime against the values
+ * provided, and return -EBUSY if there isn't an exact match.
+ */
+#define FILE_XCHG_RANGE_FILE2_FRESH	(1 << 1)
+
+/*
+ * Check that the file1's length is equal to file1_offset + length, and that
+ * file2's length is equal to file2_offset + length.  Returns -EDOM if there
+ * isn't an exact match.
+ */
+#define FILE_XCHG_RANGE_FULL_FILES	(1 << 2)
+
+/*
+ * Exchange file data all the way to the ends of both files, and then exchange
+ * the file sizes.  This flag can be used to replace a file's contents with a
+ * different amount of data.  length will be ignored.
+ */
+#define FILE_XCHG_RANGE_TO_EOF		(1 << 3)
+
+/* Flush all changes in file data and file metadata to disk before returning. */
+#define FILE_XCHG_RANGE_FSYNC		(1 << 4)
+
+/* Dry run; do all the parameter verification but do not change anything. */
+#define FILE_XCHG_RANGE_DRY_RUN		(1 << 5)
+
+/*
+ * Do not exchange any part of the range where file1's mapping is a hole.  This
+ * can be used to emulate scatter-gather atomic writes with a temp file.
+ */
+#define FILE_XCHG_RANGE_SKIP_FILE1_HOLES (1 << 6)
+
+/*
+ * Commit the contents of file1 into file2 if file2 has the same inode number,
+ * mtime, and ctime as the arguments provided to the call.  The old contents of
+ * file2 will be moved to file1.
+ *
+ * With this flag, all committed information can be retrieved even if the
+ * system crashes or is rebooted.  This includes writing through or flushing a
+ * disk cache if present.  The call blocks until the device reports that the
+ * commit is complete.
+ *
+ * This flag should not be combined with NONATOMIC.  It can be combined with
+ * SKIP_FILE1_HOLES.
+ */
+#define FILE_XCHG_RANGE_COMMIT		(FILE_XCHG_RANGE_FILE2_FRESH | \
+					 FILE_XCHG_RANGE_FSYNC)
+
+#define FILE_XCHG_RANGE_ALL_FLAGS	(FILE_XCHG_RANGE_NONATOMIC | \
+					 FILE_XCHG_RANGE_FILE2_FRESH | \
+					 FILE_XCHG_RANGE_FULL_FILES | \
+					 FILE_XCHG_RANGE_TO_EOF | \
+					 FILE_XCHG_RANGE_FSYNC | \
+					 FILE_XCHG_RANGE_DRY_RUN | \
+					 FILE_XCHG_RANGE_SKIP_FILE1_HOLES)
+
+#define FIEXCHANGE_RANGE	_IOWR('X', 129, struct file_xchg_range)
+
+#endif /* _LINUX_FIEXCHANGE_H */

