Return-Path: <linux-fsdevel+bounces-16393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7165389D11C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7531F21A58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45110757F6;
	Tue,  9 Apr 2024 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8LoBdX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22577441A;
	Tue,  9 Apr 2024 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633702; cv=none; b=kLSCuxllAxCXcRqHqMKMYKYkf59Qtr5tiW/Xm5f6p4owXywpOSxOhPQ5xE/NO3CAWtNWjr6fsXeYypRHvUCWEUHDX8IT2B7JFb9R+B5YcjPTCeKCzbGXvMf/2t5eMf/S5DW34/eAJFX6eUOlJDJkR8sbtQX4KuBGIv6+XPM6SG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633702; c=relaxed/simple;
	bh=L4KkAgeONeaAhIhdo+39tCxIp1zkOs+OTlTNUNwBywU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuXrngLoBBMPHGtjZY/0HTjpGOQ1uQ/10b7Lrk4BOx5L1D7r7BQSdCkd1nWNk2RxJKOS09l67oIC5dx9niGMl8+IRMktpNT/J57PP/3RpLHJ+5Ulwh1Q4Ht0HUVHxSkhb6CzCl+XNEzgD9vRg23jbGlwLzS1OgPULp0OnbYWM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8LoBdX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB9AC433F1;
	Tue,  9 Apr 2024 03:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633702;
	bh=L4KkAgeONeaAhIhdo+39tCxIp1zkOs+OTlTNUNwBywU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=B8LoBdX+qCUU/4jHgNyzMH0gcIPDK3hU+f2zeg/+JhRIJLJ/fZZ2+1mgORu7FhiQ7
	 +5qTrxj568I64qSaefqP1fL9vxZUyCb03t1p2YQMcahdTZ2Z17G4yEb53zHXYWmpnl
	 MEGaVooiKZq/XiorIeXjKND1UoVrAWplvV0xGWadqRwhfOsyYFQ090ltTfs7PqEloT
	 LORRblpTn/QkyYEWr3RiENCPrDhwyrNivrkVb8PbI0CZkcUeqIYuc268YEgso2UOZa
	 hX6zHonCpEtyPF2qTVbBz5ywysvu5lX0N+gNEpySPXt/L0hnYHlJX9q9iHTv6NHPI5
	 toT64sCvzCVZQ==
Date: Mon, 08 Apr 2024 20:35:02 -0700
Subject: [PATCH 02/14] xfs: introduce new file range exchange ioctl
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171263348495.2978056.17700757606901934616.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Introduce a new ioctl to handle exchanging ranges of bytes
between files.  The goal here is to perform the exchange atomically with
respect to applications -- either they see the file contents before the
exchange or they see that A-B is now B-A, even if the kernel crashes.

My original goal with all this code was to make it so that online repair
can build a replacement directory or xattr structure in a temporary file
and commit the repair by atomically exchanging all the data blocks
between the two files.  However, I needed a way to test this mechanism
thoroughly, so I've been evolving an ioctl interface since then.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/Makefile        |    1 
 fs/xfs/libxfs/xfs_fs.h |   41 ++++++
 fs/xfs/xfs_exchrange.c |  304 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_exchrange.h |   34 +++++
 fs/xfs/xfs_ioctl.c     |   38 ++++++
 5 files changed, 418 insertions(+)
 create mode 100644 fs/xfs/xfs_exchrange.c
 create mode 100644 fs/xfs/xfs_exchrange.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 76674ad5833e3..2474242f5a05f 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -67,6 +67,7 @@ xfs-y				+= xfs_aops.o \
 				   xfs_dir2_readdir.o \
 				   xfs_discard.o \
 				   xfs_error.o \
+				   xfs_exchrange.o \
 				   xfs_export.o \
 				   xfs_extent_busy.o \
 				   xfs_file.o \
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index ca1b17d014377..8a1e30cf4dc88 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -772,6 +772,46 @@ struct xfs_scrub_metadata {
 #  define XFS_XATTR_LIST_MAX 65536
 #endif
 
+/*
+ * Exchange part of file1 with part of the file that this ioctl that is being
+ * called against (which we'll call file2).  Filesystems must be able to
+ * restart and complete the operation even after the system goes down.
+ */
+struct xfs_exchange_range {
+	__s32		file1_fd;
+	__u32		pad;		/* must be zeroes */
+	__u64		file1_offset;	/* file1 offset, bytes */
+	__u64		file2_offset;	/* file2 offset, bytes */
+	__u64		length;		/* bytes to exchange */
+
+	__u64		flags;		/* see XFS_EXCHANGE_RANGE_* below */
+};
+
+/*
+ * Exchange file data all the way to the ends of both files, and then exchange
+ * the file sizes.  This flag can be used to replace a file's contents with a
+ * different amount of data.  length will be ignored.
+ */
+#define XFS_EXCHANGE_RANGE_TO_EOF	(1ULL << 0)
+
+/* Flush all changes in file data and file metadata to disk before returning. */
+#define XFS_EXCHANGE_RANGE_DSYNC	(1ULL << 1)
+
+/* Dry run; do all the parameter verification but do not change anything. */
+#define XFS_EXCHANGE_RANGE_DRY_RUN	(1ULL << 2)
+
+/*
+ * Exchange only the parts of the two files where the file allocation units
+ * mapped to file1's range have been written to.  This can accelerate
+ * scatter-gather atomic writes with a temp file if all writes are aligned to
+ * the file allocation unit.
+ */
+#define XFS_EXCHANGE_RANGE_FILE1_WRITTEN (1ULL << 3)
+
+#define XFS_EXCHANGE_RANGE_ALL_FLAGS	(XFS_EXCHANGE_RANGE_TO_EOF | \
+					 XFS_EXCHANGE_RANGE_DSYNC | \
+					 XFS_EXCHANGE_RANGE_DRY_RUN | \
+					 XFS_EXCHANGE_RANGE_FILE1_WRITTEN)
 
 /*
  * ioctl commands that are used by Linux filesystems
@@ -843,6 +883,7 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_FSGEOMETRY	     _IOR ('X', 126, struct xfs_fsop_geom)
 #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
 #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
+#define XFS_IOC_EXCHANGE_RANGE	     _IOWR('X', 129, struct xfs_exchange_range)
 /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
 
 
diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
new file mode 100644
index 0000000000000..a575e26ae1a58
--- /dev/null
+++ b/fs/xfs/xfs_exchrange.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020-2024 Oracle.  All Rights Reserved.
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
+#include "xfs_exchrange.h"
+#include <linux/fsnotify.h>
+
+/*
+ * Generic code for exchanging ranges of two files via XFS_IOC_EXCHANGE_RANGE.
+ * This part deals with struct file objects and byte ranges and does not deal
+ * with XFS-specific data structures such as xfs_inodes and block ranges.  This
+ * separation may some day facilitate porting to another filesystem.
+ *
+ * The goal is to exchange fxr.length bytes starting at fxr.file1_offset in
+ * file1 with the same number of bytes starting at fxr.file2_offset in file2.
+ * Implementations must call xfs_exchange_range_prep to prepare the two
+ * files prior to taking locks; and they must update the inode change and mod
+ * times of both files as part of the metadata update.  The timestamp update
+ * and freshness checks must be done atomically as part of the data exchange
+ * operation to ensure correctness of the freshness check.
+ * xfs_exchange_range_finish must be called after the operation completes
+ * successfully but before locks are dropped.
+ */
+
+/* Verify that we have security clearance to perform this operation. */
+static int
+xfs_exchange_range_verify_area(
+	struct xfs_exchrange	*fxr)
+{
+	int			ret;
+
+	ret = remap_verify_area(fxr->file1, fxr->file1_offset, fxr->length,
+			true);
+	if (ret)
+		return ret;
+
+	return remap_verify_area(fxr->file2, fxr->file2_offset, fxr->length,
+			true);
+}
+
+/*
+ * Performs necessary checks before doing a range exchange, having stabilized
+ * mutable inode attributes via i_rwsem.
+ */
+static inline int
+xfs_exchange_range_checks(
+	struct xfs_exchrange	*fxr,
+	unsigned int		alloc_unit)
+{
+	struct inode		*inode1 = file_inode(fxr->file1);
+	struct inode		*inode2 = file_inode(fxr->file2);
+	uint64_t		allocmask = alloc_unit - 1;
+	int64_t			test_len;
+	uint64_t		blen;
+	loff_t			size1, size2, tmp;
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
+	 * If the caller said to exchange to EOF, we set the length of the
+	 * request large enough to cover everything to the end of both files.
+	 */
+	if (fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF) {
+		fxr->length = max_t(int64_t, size1 - fxr->file1_offset,
+					     size2 - fxr->file2_offset);
+
+		error = xfs_exchange_range_verify_area(fxr);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * The start of both ranges must be aligned to the file allocation
+	 * unit.
+	 */
+	if (!IS_ALIGNED(fxr->file1_offset, alloc_unit) ||
+	    !IS_ALIGNED(fxr->file2_offset, alloc_unit))
+		return -EINVAL;
+
+	/* Ensure offsets don't wrap. */
+	if (check_add_overflow(fxr->file1_offset, fxr->length, &tmp) ||
+	    check_add_overflow(fxr->file2_offset, fxr->length, &tmp))
+		return -EINVAL;
+
+	/*
+	 * We require both ranges to end within EOF, unless we're exchanging
+	 * to EOF.
+	 */
+	if (!(fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF) &&
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
+	error = generic_write_check_limits(fxr->file2, fxr->file2_offset,
+			&test_len);
+	if (error)
+		return error;
+	error = generic_write_check_limits(fxr->file1, fxr->file1_offset,
+			&test_len);
+	if (error)
+		return error;
+	if (test_len != fxr->length)
+		return -EINVAL;
+
+	/*
+	 * If the user wanted us to exchange up to the infile's EOF, round up
+	 * to the next allocation unit boundary for this check.  Do the same
+	 * for the outfile.
+	 *
+	 * Otherwise, reject the range length if it's not aligned to an
+	 * allocation unit.
+	 */
+	if (fxr->file1_offset + fxr->length == size1)
+		blen = ALIGN(size1, alloc_unit) - fxr->file1_offset;
+	else if (fxr->file2_offset + fxr->length == size2)
+		blen = ALIGN(size2, alloc_unit) - fxr->file2_offset;
+	else if (!IS_ALIGNED(fxr->length, alloc_unit))
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
+	/*
+	 * Ensure that we don't exchange a partial EOF block into the middle of
+	 * another file.
+	 */
+	if ((fxr->length & allocmask) == 0)
+		return 0;
+
+	blen = fxr->length;
+	if (fxr->file2_offset + blen < size2)
+		blen &= ~allocmask;
+
+	if (fxr->file1_offset + blen < size1)
+		blen &= ~allocmask;
+
+	return blen == fxr->length ? 0 : -EINVAL;
+}
+
+/*
+ * Check that the two inodes are eligible for range exchanges, the ranges make
+ * sense, and then flush all dirty data.  Caller must ensure that the inodes
+ * have been locked against any other modifications.
+ */
+static inline int
+xfs_exchange_range_prep(
+	struct xfs_exchrange	*fxr,
+	unsigned int		alloc_unit)
+{
+	struct inode		*inode1 = file_inode(fxr->file1);
+	struct inode		*inode2 = file_inode(fxr->file2);
+	bool			same_inode = (inode1 == inode2);
+	int			error;
+
+	/* Check that we don't violate system file offset limits. */
+	error = xfs_exchange_range_checks(fxr, alloc_unit);
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
+	if (((fxr->file1->f_flags | fxr->file2->f_flags) & O_SYNC) ||
+	    IS_SYNC(inode1) || IS_SYNC(inode2))
+		fxr->flags |= XFS_EXCHANGE_RANGE_DSYNC;
+
+	return 0;
+}
+
+/*
+ * Finish a range exchange operation, if it was successful.  Caller must ensure
+ * that the inodes are still locked against any other modifications.
+ */
+static inline int
+xfs_exchange_range_finish(
+	struct xfs_exchrange	*fxr)
+{
+	int			error;
+
+	error = file_remove_privs(fxr->file1);
+	if (error)
+		return error;
+	if (file_inode(fxr->file1) == file_inode(fxr->file2))
+		return 0;
+
+	return file_remove_privs(fxr->file2);
+}
+
+/* Exchange parts of two files. */
+int
+xfs_exchange_range(
+	struct xfs_exchrange	*fxr)
+{
+	struct inode		*inode1 = file_inode(fxr->file1);
+	struct inode		*inode2 = file_inode(fxr->file2);
+	int			ret;
+
+	BUILD_BUG_ON(XFS_EXCHANGE_RANGE_ALL_FLAGS &
+		     XFS_EXCHANGE_RANGE_PRIV_FLAGS);
+
+	/* Both files must be on the same mount/filesystem. */
+	if (fxr->file1->f_path.mnt != fxr->file2->f_path.mnt)
+		return -EXDEV;
+
+	if (fxr->flags & ~XFS_EXCHANGE_RANGE_ALL_FLAGS)
+		return -EINVAL;
+
+	/* Userspace requests only honored for regular files. */
+	if (S_ISDIR(inode1->i_mode) || S_ISDIR(inode2->i_mode))
+		return -EISDIR;
+	if (!S_ISREG(inode1->i_mode) || !S_ISREG(inode2->i_mode))
+		return -EINVAL;
+
+	/* Both files must be opened for read and write. */
+	if (!(fxr->file1->f_mode & FMODE_READ) ||
+	    !(fxr->file1->f_mode & FMODE_WRITE) ||
+	    !(fxr->file2->f_mode & FMODE_READ) ||
+	    !(fxr->file2->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	/* Neither file can be opened append-only. */
+	if ((fxr->file1->f_flags & O_APPEND) ||
+	    (fxr->file2->f_flags & O_APPEND))
+		return -EBADF;
+
+	/*
+	 * If we're not exchanging to EOF, we can check the areas before
+	 * stabilizing both files' i_size.
+	 */
+	if (!(fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF)) {
+		ret = xfs_exchange_range_verify_area(fxr);
+		if (ret)
+			return ret;
+	}
+
+	/* Update cmtime if the fd/inode don't forbid it. */
+	if (!(fxr->file1->f_mode & FMODE_NOCMTIME) && !IS_NOCMTIME(inode1))
+		fxr->flags |= __XFS_EXCHANGE_RANGE_UPD_CMTIME1;
+	if (!(fxr->file2->f_mode & FMODE_NOCMTIME) && !IS_NOCMTIME(inode2))
+		fxr->flags |= __XFS_EXCHANGE_RANGE_UPD_CMTIME2;
+
+	file_start_write(fxr->file2);
+	ret = -EOPNOTSUPP; /* XXX call out to lower level code */
+	file_end_write(fxr->file2);
+	if (ret)
+		return ret;
+
+	fsnotify_modify(fxr->file1);
+	if (fxr->file2 != fxr->file1)
+		fsnotify_modify(fxr->file2);
+	return 0;
+}
diff --git a/fs/xfs/xfs_exchrange.h b/fs/xfs/xfs_exchrange.h
new file mode 100644
index 0000000000000..923c386cb9756
--- /dev/null
+++ b/fs/xfs/xfs_exchrange.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2020-2024 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_EXCHRANGE_H__
+#define __XFS_EXCHRANGE_H__
+
+/* Update the mtime/cmtime of file1 and file2 */
+#define __XFS_EXCHANGE_RANGE_UPD_CMTIME1	(1ULL << 63)
+#define __XFS_EXCHANGE_RANGE_UPD_CMTIME2	(1ULL << 62)
+
+#define XFS_EXCHANGE_RANGE_PRIV_FLAGS	(__XFS_EXCHANGE_RANGE_UPD_CMTIME1 | \
+					 __XFS_EXCHANGE_RANGE_UPD_CMTIME2)
+
+struct xfs_exchrange {
+	struct file		*file1;
+	struct file		*file2;
+
+	loff_t			file1_offset;
+	loff_t			file2_offset;
+	u64			length;
+
+	u64			flags;	/* XFS_EXCHANGE_RANGE flags */
+
+	/* file2 metadata for freshness checks if file1_ino != 0 */
+	u64			file2_ino;
+	struct timespec64	file2_mtime;
+	struct timespec64	file2_ctime;
+};
+
+int xfs_exchange_range(struct xfs_exchrange *fxr);
+
+#endif /* __XFS_EXCHRANGE_H__ */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 1397edea20f19..b11077b12f5fd 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -40,6 +40,7 @@
 #include "xfs_xattr.h"
 #include "xfs_rtbitmap.h"
 #include "xfs_file.h"
+#include "xfs_exchrange.h"
 
 #include <linux/mount.h>
 #include <linux/namei.h>
@@ -1930,6 +1931,40 @@ xfs_ioctl_fs_counts(
 	return 0;
 }
 
+static long
+xfs_ioc_exchange_range(
+	struct file			*file,
+	struct xfs_exchange_range __user *argp)
+{
+	struct xfs_exchrange		fxr = {
+		.file2			= file,
+	};
+	struct xfs_exchange_range	args;
+	struct fd			file1;
+	int				error;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+	if (memchr_inv(&args.pad, 0, sizeof(args.pad)))
+		return -EINVAL;
+	if (args.flags & ~XFS_EXCHANGE_RANGE_ALL_FLAGS)
+		return -EINVAL;
+
+	fxr.file1_offset	= args.file1_offset;
+	fxr.file2_offset	= args.file2_offset;
+	fxr.length		= args.length;
+	fxr.flags		= args.flags;
+
+	file1 = fdget(args.file1_fd);
+	if (!file1.file)
+		return -EBADF;
+	fxr.file1 = file1.file;
+
+	error = xfs_exchange_range(&fxr);
+	fdput(file1);
+	return error;
+}
+
 /*
  * These long-unused ioctls were removed from the official ioctl API in 5.17,
  * but retain these definitions so that we can log warnings about them.
@@ -2170,6 +2205,9 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case XFS_IOC_EXCHANGE_RANGE:
+		return xfs_ioc_exchange_range(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}


