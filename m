Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FAC711C41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbjEZBPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbjEZBPE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:15:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F1ED8;
        Thu, 25 May 2023 18:15:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76237615D3;
        Fri, 26 May 2023 01:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D38C433D2;
        Fri, 26 May 2023 01:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063699;
        bh=fqlFU0uZST6TtoFdGbatlT1JTB7gXKRDKCmZgN14jC4=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=GtAJLqD4ukWlA7rNdM86uQlGrHlkrYqhqq73OOk9zsjlmS92RXL1vD4H8Lkmr4uyV
         ArDHyvy8CiZCO1sZzsQ2qXNDsctsMCzWG2yGiWlHrkerSTiyUADhb/3WHps4um1fmh
         1SWNuKPB+uonX7sW+NqXKhTdZlW424Cl1mNJIGuWC9W2KrfrDuwAP2D/h1QA8C9fqE
         h35vHQxDvp17348YzYg6x2/39KOzAnpjn+E2rOpanJS8cA4GwfQAPemn+JAwqPZQza
         UApJFyWcthq8ZF+AYYsmmS9xoI3IhJ8BBzoiRZdLiX9r3XZlR6VTTAHbNW3RzuTJsl
         vgxdN8rMJX3vA==
Date:   Thu, 25 May 2023 18:14:59 -0700
Subject: [PATCH 02/25] xfs: introduce new file range exchange ioctl
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065007.3734442.5982224085517839532.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Introduce a new ioctl to handle swapping ranges of bytes between files.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/read_write.c                |    2 
 fs/remap_range.c               |    4 
 fs/xfs/Makefile                |    1 
 fs/xfs/libxfs/xfs_fs.h         |    1 
 fs/xfs/libxfs/xfs_fs_staging.h |   89 ++++++++++
 fs/xfs/xfs_ioctl.c             |   30 +++
 fs/xfs/xfs_xchgrange.c         |  343 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_xchgrange.h         |   18 ++
 include/linux/fs.h             |    1 
 9 files changed, 487 insertions(+), 2 deletions(-)
 create mode 100644 fs/xfs/xfs_xchgrange.c
 create mode 100644 fs/xfs/xfs_xchgrange.h


diff --git a/fs/read_write.c b/fs/read_write.c
index a21ba3be7dbe..480e687a1587 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1650,6 +1650,7 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 
 	return 0;
 }
+EXPORT_SYMBOL(generic_write_check_limits);
 
 /* Like generic_write_checks(), but takes size of write instead of iter. */
 int generic_write_checks_count(struct kiocb *iocb, loff_t *count)
@@ -1718,3 +1719,4 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
 	return 0;
 }
+EXPORT_SYMBOL(generic_file_rw_checks);
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 1331a890f2f2..ed1ee6576e03 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -98,8 +98,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	return 0;
 }
 
-static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
-			     bool write)
+int remap_verify_area(struct file *file, loff_t pos, loff_t len, bool write)
 {
 	if (unlikely(pos < 0 || len < 0))
 		return -EINVAL;
@@ -109,6 +108,7 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 
 	return security_file_permission(file, write ? MAY_WRITE : MAY_READ);
 }
+EXPORT_SYMBOL(remap_verify_area);
 
 /*
  * Ensure that we don't remap a partial EOF block in the middle of something
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 56861c8f78cc..6cc3b1fe5754 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -93,6 +93,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_sysfs.o \
 				   xfs_trans.o \
 				   xfs_xattr.o \
+				   xfs_xchgrange.o \
 				   kmem.o
 
 # low-level transaction/log code
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 400cf68e551e..29857b0f87df 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -841,6 +841,7 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_FSGEOMETRY	     _IOR ('X', 126, struct xfs_fsop_geom)
 #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
 #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
+/*	XFS_IOC_EXCHANGE_RANGE -------- staging 129	 */
 /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
 
 
diff --git a/fs/xfs/libxfs/xfs_fs_staging.h b/fs/xfs/libxfs/xfs_fs_staging.h
index bc97193dde9d..0453e7f31af0 100644
--- a/fs/xfs/libxfs/xfs_fs_staging.h
+++ b/fs/xfs/libxfs/xfs_fs_staging.h
@@ -15,4 +15,93 @@
  * explaining where it went.
  */
 
+/*
+ * Exchange part of file1 with part of the file that this ioctl that is being
+ * called against (which we'll call file2).  Filesystems must be able to
+ * restart and complete the operation even after the system goes down.
+ */
+struct xfs_exch_range {
+	__s64		file1_fd;
+	__s64		file1_offset;	/* file1 offset, bytes */
+	__s64		file2_offset;	/* file2 offset, bytes */
+	__u64		length;		/* bytes to exchange */
+
+	__u64		flags;		/* see XFS_EXCH_RANGE_* below */
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
+#define XFS_EXCH_RANGE_NONATOMIC	(1 << 0)
+
+/*
+ * Check that file2's inode number, mtime, and ctime against the values
+ * provided, and return -EBUSY if there isn't an exact match.
+ */
+#define XFS_EXCH_RANGE_FILE2_FRESH	(1 << 1)
+
+/*
+ * Check that the file1's length is equal to file1_offset + length, and that
+ * file2's length is equal to file2_offset + length.  Returns -EDOM if there
+ * isn't an exact match.
+ */
+#define XFS_EXCH_RANGE_FULL_FILES	(1 << 2)
+
+/*
+ * Exchange file data all the way to the ends of both files, and then exchange
+ * the file sizes.  This flag can be used to replace a file's contents with a
+ * different amount of data.  length will be ignored.
+ */
+#define XFS_EXCH_RANGE_TO_EOF		(1 << 3)
+
+/* Flush all changes in file data and file metadata to disk before returning. */
+#define XFS_EXCH_RANGE_FSYNC		(1 << 4)
+
+/* Dry run; do all the parameter verification but do not change anything. */
+#define XFS_EXCH_RANGE_DRY_RUN		(1 << 5)
+
+/*
+ * Exchange only the parts of the two files where the file allocation units
+ * mapped to file1's range have been written to.  This can accelerate
+ * scatter-gather atomic writes with a temp file if all writes are aligned to
+ * the file allocation unit.
+ */
+#define XFS_EXCH_RANGE_FILE1_WRITTEN	(1 << 6)
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
+ * FILE1_WRITTEN.
+ */
+#define XFS_EXCH_RANGE_COMMIT		(XFS_EXCH_RANGE_FILE2_FRESH | \
+					 XFS_EXCH_RANGE_FSYNC)
+
+#define XFS_EXCH_RANGE_ALL_FLAGS	(XFS_EXCH_RANGE_NONATOMIC | \
+					 XFS_EXCH_RANGE_FILE2_FRESH | \
+					 XFS_EXCH_RANGE_FULL_FILES | \
+					 XFS_EXCH_RANGE_TO_EOF | \
+					 XFS_EXCH_RANGE_FSYNC | \
+					 XFS_EXCH_RANGE_DRY_RUN | \
+					 XFS_EXCH_RANGE_FILE1_WRITTEN)
+
+#define XFS_IOC_EXCHANGE_RANGE	_IOWR('X', 129, struct xfs_exch_range)
+
 #endif /* __XFS_FS_STAGING_H__ */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0667e088a289..19724b3a5fdc 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -38,6 +38,7 @@
 #include "xfs_reflink.h"
 #include "xfs_ioctl.h"
 #include "xfs_xattr.h"
+#include "xfs_xchgrange.h"
 
 #include <linux/mount.h>
 #include <linux/namei.h>
@@ -1862,6 +1863,32 @@ xfs_fs_eofblocks_from_user(
 	return 0;
 }
 
+static long
+xfs_ioc_exchange_range(
+	struct file			*file2,
+	struct xfs_exch_range __user	*argp)
+{
+	struct xfs_exch_range		args;
+	struct fd			file1;
+	int				error;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	file1 = fdget(args.file1_fd);
+	if (!file1.file)
+		return -EBADF;
+
+	error = -EXDEV;
+	if (file1.file->f_path.mnt != file2->f_path.mnt)
+		goto fdput;
+
+	error = xfs_exch_range(file1.file, file2, &args);
+fdput:
+	fdput(file1);
+	return error;
+}
+
 /*
  * These long-unused ioctls were removed from the official ioctl API in 5.17,
  * but retain these definitions so that we can log warnings about them.
@@ -2150,6 +2177,9 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case XFS_IOC_EXCHANGE_RANGE:
+		return xfs_ioc_exchange_range(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
new file mode 100644
index 000000000000..b91df426d426
--- /dev/null
+++ b/fs/xfs/xfs_xchgrange.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "xfs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_defer.h"
+#include "xfs_inode.h"
+#include "xfs_trans.h"
+#include "xfs_xchgrange.h"
+#include <linux/fsnotify.h>
+
+/*
+ * Generic code for exchanging ranges of two files via XFS_IOC_EXCHANGE_RANGE.
+ * This part does not deal with XFS-specific data structures, and may some day
+ * be ported to the VFS.
+ *
+ * The goal is to exchange fxr.length bytes starting at fxr.file1_offset in
+ * file1 with the same number of bytes starting at fxr.file2_offset in file2.
+ * Implementations must call xfs_exch_range_prep to prepare the two files
+ * prior to taking locks; they must call xfs_exch_range_check_fresh once
+ * the inode is locked to abort the call if file2 has changed; and they must
+ * update the inode change and mod times of both files as part of the metadata
+ * update.  The timestamp updates must be done atomically as part of the data
+ * exchange operation to ensure correctness of the freshness check.
+ */
+
+/*
+ * Check that both files' metadata agree with the snapshot that we took for
+ * the range exchange request.
+ *
+ * This should be called after the filesystem has locked /all/ inode metadata
+ * against modification.
+ */
+STATIC int
+xfs_exch_range_check_fresh(
+	struct inode			*inode2,
+	const struct xfs_exch_range	*fxr)
+{
+	/* Check that file2 hasn't otherwise been modified. */
+	if ((fxr->flags & XFS_EXCH_RANGE_FILE2_FRESH) &&
+	    (fxr->file2_ino        != inode2->i_ino ||
+	     fxr->file2_ctime      != inode2->i_ctime.tv_sec  ||
+	     fxr->file2_ctime_nsec != inode2->i_ctime.tv_nsec ||
+	     fxr->file2_mtime      != inode2->i_mtime.tv_sec  ||
+	     fxr->file2_mtime_nsec != inode2->i_mtime.tv_nsec))
+		return -EBUSY;
+
+	return 0;
+}
+
+/* Performs necessary checks before doing a range exchange. */
+STATIC int
+xfs_exch_range_checks(
+	struct file		*file1,
+	struct file		*file2,
+	struct xfs_exch_range	*fxr,
+	unsigned int		blocksize)
+{
+	struct inode		*inode1 = file1->f_mapping->host;
+	struct inode		*inode2 = file2->f_mapping->host;
+	uint64_t		blkmask = blocksize - 1;
+	int64_t			test_len;
+	uint64_t		blen;
+	loff_t			size1, size2;
+	int			error;
+
+	/* Don't touch certain kinds of inodes */
+	if (IS_IMMUTABLE(inode1) || IS_IMMUTABLE(inode2))
+		return -EPERM;
+	if (IS_SWAPFILE(inode1) || IS_SWAPFILE(inode2))
+		return -ETXTBSY;
+
+	size1 = i_size_read(inode1);
+	size2 = i_size_read(inode2);
+
+	/* Ranges cannot start after EOF. */
+	if (fxr->file1_offset > size1 || fxr->file2_offset > size2)
+		return -EINVAL;
+
+	/*
+	 * If the caller asked for full files, check that the offset/length
+	 * values cover all of both files.
+	 */
+	if ((fxr->flags & XFS_EXCH_RANGE_FULL_FILES) &&
+	    (fxr->file1_offset != 0 || fxr->file2_offset != 0 ||
+	     fxr->length != size1 || fxr->length != size2))
+		return -EDOM;
+
+	/*
+	 * If the caller said to exchange to EOF, we set the length of the
+	 * request large enough to cover everything to the end of both files.
+	 */
+	if (fxr->flags & XFS_EXCH_RANGE_TO_EOF)
+		fxr->length = max_t(int64_t, size1 - fxr->file1_offset,
+					     size2 - fxr->file2_offset);
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
+	/*
+	 * We require both ranges to be within EOF, unless we're exchanging
+	 * to EOF.  xfs_xchg_range_prep already checked that both
+	 * fxr->file1_offset and fxr->file2_offset are within EOF.
+	 */
+	if (!(fxr->flags & XFS_EXCH_RANGE_TO_EOF) &&
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
+	error = generic_write_check_limits(file2, fxr->file2_offset, &test_len);
+	if (error)
+		return error;
+	error = generic_write_check_limits(file1, fxr->file1_offset, &test_len);
+	if (error)
+		return error;
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
+	/* If we already failed the freshness check, we're done. */
+	error = xfs_exch_range_check_fresh(inode2, fxr);
+	if (error)
+		return error;
+
+	/*
+	 * Ensure that we don't exchange a partial EOF block into the middle of
+	 * another file.
+	 */
+	if ((fxr->length & blkmask) == 0)
+		return 0;
+
+	blen = fxr->length;
+	if (fxr->file2_offset + blen < size2)
+		blen &= ~blkmask;
+
+	if (fxr->file1_offset + blen < size1)
+		blen &= ~blkmask;
+
+	return blen == fxr->length ? 0 : -EINVAL;
+}
+
+/*
+ * Check that the two inodes are eligible for range exchanges, the ranges make
+ * sense, and then flush all dirty data.  Caller must ensure that the inodes
+ * have been locked against any other modifications.
+ */
+int
+xfs_exch_range_prep(
+	struct file		*file1,
+	struct file		*file2,
+	struct xfs_exch_range	*fxr,
+	unsigned int		blocksize)
+{
+	struct inode		*inode1 = file_inode(file1);
+	struct inode		*inode2 = file_inode(file2);
+	bool			same_inode = (inode1 == inode2);
+	int			error;
+
+	/* Check that we don't violate system file offset limits. */
+	error = xfs_exch_range_checks(file1, file2, fxr, blocksize);
+	if (error || fxr->length == 0)
+		return error;
+
+	/* Wait for the completion of any pending IOs on both files */
+	inode_dio_wait(inode1);
+	if (!same_inode)
+		inode_dio_wait(inode2);
+
+	error = filemap_write_and_wait_range(inode1->i_mapping,
+			fxr->file1_offset,
+			fxr->file1_offset + fxr->length - 1);
+	if (error)
+		return error;
+
+	error = filemap_write_and_wait_range(inode2->i_mapping,
+			fxr->file2_offset,
+			fxr->file2_offset + fxr->length - 1);
+	if (error)
+		return error;
+
+	/*
+	 * If the files or inodes involved require synchronous writes, amend
+	 * the request to force the filesystem to flush all data and metadata
+	 * to disk after the operation completes.
+	 */
+	if (((file1->f_flags | file2->f_flags) & (__O_SYNC | O_DSYNC)) ||
+	    IS_SYNC(inode1) || IS_SYNC(inode2))
+		fxr->flags |= XFS_EXCH_RANGE_FSYNC;
+
+	return 0;
+}
+
+/*
+ * Finish a range exchange operation, if it was successful.  Caller must ensure
+ * that the inodes are still locked against any other modifications.
+ */
+int
+xfs_exch_range_finish(
+	struct file		*file1,
+	struct file		*file2)
+{
+	int			error;
+
+	error = file_remove_privs(file1);
+	if (error)
+		return error;
+	if (file_inode(file1) == file_inode(file2))
+		return 0;
+
+	return file_remove_privs(file2);
+}
+
+/* Decide if it's ok to remap the selected range of a given file. */
+STATIC int
+xfs_exch_range_verify_area(
+	struct file		*file,
+	loff_t			pos,
+	struct xfs_exch_range	*fxr)
+{
+	int64_t			len = fxr->length;
+
+	if (pos < 0)
+		return -EINVAL;
+
+	if (fxr->flags & XFS_EXCH_RANGE_TO_EOF)
+		len = min_t(int64_t, len, i_size_read(file_inode(file)) - pos);
+	return remap_verify_area(file, pos, len, true);
+}
+
+/* Prepare for and exchange parts of two files. */
+static inline int
+__xfs_exch_range(
+	struct file		*file1,
+	struct file		*file2,
+	struct xfs_exch_range	*fxr)
+{
+	struct inode		*inode1 = file_inode(file1);
+	struct inode		*inode2 = file_inode(file2);
+	int			ret;
+
+	if ((fxr->flags & ~XFS_EXCH_RANGE_ALL_FLAGS) ||
+	    memchr_inv(&fxr->pad, 0, sizeof(fxr->pad)))
+		return -EINVAL;
+
+	if ((fxr->flags & XFS_EXCH_RANGE_FULL_FILES) &&
+	    (fxr->flags & XFS_EXCH_RANGE_TO_EOF))
+		return -EINVAL;
+
+	/*
+	 * The ioctl enforces that src and dest files are on the same mount.
+	 * However, they only need to be on the same file system.
+	 */
+	if (inode1->i_sb != inode2->i_sb)
+		return -EXDEV;
+
+	/* This only works for regular files. */
+	if (S_ISDIR(inode1->i_mode) || S_ISDIR(inode2->i_mode))
+		return -EISDIR;
+	if (!S_ISREG(inode1->i_mode) || !S_ISREG(inode2->i_mode))
+		return -EINVAL;
+
+	ret = generic_file_rw_checks(file1, file2);
+	if (ret < 0)
+		return ret;
+
+	ret = generic_file_rw_checks(file2, file1);
+	if (ret < 0)
+		return ret;
+
+	ret = xfs_exch_range_verify_area(file1, fxr->file1_offset, fxr);
+	if (ret)
+		return ret;
+
+	ret = xfs_exch_range_verify_area(file2, fxr->file2_offset, fxr);
+	if (ret)
+		return ret;
+
+	ret = -EOPNOTSUPP; /* XXX call out to xfs code */
+	if (ret)
+		return ret;
+
+	fsnotify_modify(file1);
+	if (file2 != file1)
+		fsnotify_modify(file2);
+	return 0;
+}
+
+/* Exchange parts of two files. */
+int
+xfs_exch_range(
+	struct file		*file1,
+	struct file		*file2,
+	struct xfs_exch_range	*fxr)
+{
+	int			error;
+
+	file_start_write(file2);
+	error = __xfs_exch_range(file1, file2, fxr);
+	file_end_write(file2);
+
+	return error;
+}
diff --git a/fs/xfs/xfs_xchgrange.h b/fs/xfs/xfs_xchgrange.h
new file mode 100644
index 000000000000..414fce7a159f
--- /dev/null
+++ b/fs/xfs/xfs_xchgrange.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020-2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_XCHGRANGE_H__
+#define __XFS_XCHGRANGE_H__
+
+/* Prepare generic VFS data structures for file exchanges */
+
+int xfs_exch_range_prep(struct file *file1, struct file *file2,
+		struct xfs_exch_range *fxr, unsigned int blocksize);
+int xfs_exch_range_finish(struct file *file1, struct file *file2);
+
+int xfs_exch_range(struct file *file1, struct file *file2,
+		struct xfs_exch_range *fxr);
+
+#endif /* __XFS_XCHGRANGE_H__ */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 147644b5d648..d7ee5122d40b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1884,6 +1884,7 @@ extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				       struct file *file_out, loff_t pos_out,
 				       size_t len, unsigned int flags);
+int remap_verify_area(struct file *file, loff_t pos, loff_t len, bool write);
 int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    loff_t *len, unsigned int remap_flags,

