Return-Path: <linux-fsdevel+bounces-12994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5AA869E36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 18:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EEC2913A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FF4F88E;
	Tue, 27 Feb 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8KOYJYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399FB4F219;
	Tue, 27 Feb 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056010; cv=none; b=XNnElG5+pEqudjwPnRihzI43gCjylvcawwq2i62xV861Mudyzw+Ob26HoaatsNQtpdfv1F2xM6B+Dn5sveNjkWH5u17C23dWthb8+4YgDYNiQsUSKC23CUC4FrtbJqRxxVZxCDrehf8HzhBqfuLW8StRUwqZiBYM/LyplZBVH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056010; c=relaxed/simple;
	bh=AnsiBkQ+52OyPvCPOo4rfbzn1dHC4MPnqG/4AgznKUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpG+Qyne5g6yXRoyrpm+pGukc5ngVeSCUP1TOgJ7nkqvqNcLP99F4ew9HtNOGJID6MNN/yxIzF9mnM4DzFIXGsxmdvjrzWn5bt6MQuMkP9aQ86y/Q1xNuzm6/7o5fGBBsY1ZcT6CKjYwgyE/nDw5UnzTtp0jRpJ3FWkuyt0OZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8KOYJYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0104C433C7;
	Tue, 27 Feb 2024 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056009;
	bh=AnsiBkQ+52OyPvCPOo4rfbzn1dHC4MPnqG/4AgznKUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8KOYJYGA+xzjX4ZGRgylJd5VQBRnr5X9Vd8k6uFSjm4W+KTYPOq/gs04htBB38O6
	 HWYqORj2kVZ81g8J2gvn9Y/0OXams6o2jFKMd+PsQobQKBRmzKVZm4AZltcMDpYenN
	 DlJPsbQp3TSdKiBcZtm7tzRhSP806V25xYX7vijwR9eiya51U8jnAUQTBtyBr++WQd
	 0p1KEffiBVGaX0N6zLIRnd2wMESmfrxbtwmyl1kC/gQ4915si0Zv6fcLls5cLqCOFR
	 IA7GM62bFco53R645z9L8fyVCS7+PBLxdmRWmfnMLFXNeNZ9uQSZvwB0Xw5mqtM9Ak
	 AEjqoDJkya4AQ==
Date: Tue, 27 Feb 2024 09:46:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de
Cc: Amir Goldstein <amir73il@gmail.com>, jlayton@kernel.org
Subject: [PATCH 14/13] xfs: make XFS_IOC_COMMIT_RANGE freshness data opaque
Message-ID: <20240227174649.GL6184@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

To head off bikeshedding about the fields in xfs_commit_range, let's
make it an opaque u64 array and require the userspace program to call
a third ioctl to sample the freshness data for us.  If we ever converge
on a definition for i_version then we can use that; for now we'll just
use mtime/ctime like the old swapext ioctl.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   13 +++--------
 fs/xfs/xfs_exchrange.c |   15 ++++++++++++
 fs/xfs/xfs_exchrange.h |    1 +
 fs/xfs/xfs_ioctl.c     |   58 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 01b3553adfc55..4019a78ee3ea5 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -860,14 +860,8 @@ struct xfs_commit_range {
 
 	__u64		flags;		/* see XFS_EXCHRANGE_* below */
 
-	/* file2 metadata for freshness checks */
-	__u64		file2_ino;	/* inode number */
-	__s64		file2_mtime;	/* modification time */
-	__s64		file2_ctime;	/* change time */
-	__s32		file2_mtime_nsec; /* mod time, nsec */
-	__s32		file2_ctime_nsec; /* change time, nsec */
-
-	__u64		pad;		/* must be zeroes */
+	/* opaque file2 metadata for freshness checks */
+	__u64		file2_freshness[5];
 };
 
 /*
@@ -973,7 +967,8 @@ struct xfs_commit_range {
 #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
 #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
 #define XFS_IOC_EXCHANGE_RANGE	     _IOWR('X', 129, struct xfs_exch_range)
-#define XFS_IOC_COMMIT_RANGE	     _IOWR('X', 129, struct xfs_commit_range)
+#define XFS_IOC_START_COMMIT	     _IOWR('X', 130, struct xfs_commit_range)
+#define XFS_IOC_COMMIT_RANGE	     _IOWR('X', 131, struct xfs_commit_range)
 /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
 
 
diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index e55ae06f1a32c..dae855515c3c4 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -863,3 +863,18 @@ xfs_exchange_range(
 		fsnotify_modify(fxr->file2);
 	return 0;
 }
+
+/* Sample freshness data from fxr->file2 for a commit range operation. */
+void
+xfs_exchrange_freshness(
+	struct xfs_exchrange	*fxr)
+{
+	struct inode		*inode2 = file_inode(fxr->file2);
+	struct xfs_inode	*ip2 = XFS_I(inode2);
+
+	xfs_ilock(ip2, XFS_IOLOCK_SHARED | XFS_MMAPLOCK_SHARED | XFS_ILOCK_SHARED);
+	fxr->file2_ino = ip2->i_ino;
+	fxr->file2_ctime = inode_get_ctime(inode2);
+	fxr->file2_mtime = inode_get_mtime(inode2);
+	xfs_iunlock(ip2, XFS_IOLOCK_SHARED | XFS_MMAPLOCK_SHARED | XFS_ILOCK_SHARED);
+}
diff --git a/fs/xfs/xfs_exchrange.h b/fs/xfs/xfs_exchrange.h
index 2dd9ab7d76828..942283a7f75f5 100644
--- a/fs/xfs/xfs_exchrange.h
+++ b/fs/xfs/xfs_exchrange.h
@@ -36,6 +36,7 @@ struct xfs_exchrange {
 	struct timespec64	file2_ctime;
 };
 
+void xfs_exchrange_freshness(struct xfs_exchrange *fxr);
 int xfs_exchange_range(struct xfs_exchrange *fxr);
 
 /* XFS-specific parts of file exchanges */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ee26ac2028da1..1940da72a1da7 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -2402,6 +2402,47 @@ xfs_ioc_exchange_range(
 	return error;
 }
 
+/* Opaque freshness blob for XFS_IOC_COMMIT_RANGE */
+struct xfs_commit_range_fresh {
+	__u64		file2_ino;	/* inode number */
+	__s64		file2_mtime;	/* modification time */
+	__s64		file2_ctime;	/* change time */
+	__s32		file2_mtime_nsec; /* mod time, nsec */
+	__s32		file2_ctime_nsec; /* change time, nsec */
+	__u64		pad;		/* zero */
+};
+
+static long
+xfs_ioc_start_commit(
+	struct file			*file,
+	struct xfs_commit_range __user	*argp)
+{
+	struct xfs_exchrange		fxr = {
+		.file2			= file,
+	};
+	struct xfs_commit_range		args;
+	struct xfs_commit_range_fresh	*kern_f;
+	struct xfs_commit_range_fresh	__user *user_f;
+
+	BUILD_BUG_ON(sizeof(struct xfs_commit_range_fresh) !=
+		     sizeof(args.file2_freshness));
+
+	xfs_exchrange_freshness(&fxr);
+
+	kern_f = (struct xfs_commit_range_fresh *)&args.file2_freshness;
+	kern_f->file2_ino		= fxr.file2_ino;
+	kern_f->file2_mtime		= fxr.file2_mtime.tv_sec;
+	kern_f->file2_mtime_nsec	= fxr.file2_mtime.tv_nsec;
+	kern_f->file2_ctime		= fxr.file2_ctime.tv_sec;
+	kern_f->file2_ctime_nsec	= fxr.file2_ctime.tv_nsec;
+
+	user_f = (struct xfs_commit_range_fresh *)&argp->file2_freshness;
+	if (copy_to_user(user_f, kern_f, sizeof(*kern_f)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long
 xfs_ioc_commit_range(
 	struct file			*file,
@@ -2411,12 +2452,15 @@ xfs_ioc_commit_range(
 		.file2			= file,
 	};
 	struct xfs_commit_range		args;
+	struct xfs_commit_range_fresh	*kern_f;
 	struct fd			file1;
 	int				error;
 
+	kern_f = (struct xfs_commit_range_fresh *)&args.file2_freshness;
+
 	if (copy_from_user(&args, argp, sizeof(args)))
 		return -EFAULT;
-	if (memchr_inv(&args.pad, 0, sizeof(args.pad)))
+	if (memchr_inv(&kern_f->pad, 0, sizeof(kern_f->pad)))
 		return -EINVAL;
 	if (args.flags & ~XFS_EXCHRANGE_ALL_FLAGS)
 		return -EINVAL;
@@ -2425,11 +2469,11 @@ xfs_ioc_commit_range(
 	fxr.file2_offset	= args.file2_offset;
 	fxr.length		= args.length;
 	fxr.flags		= args.flags | __XFS_EXCHRANGE_CHECK_FRESH2;
-	fxr.file2_ino		= args.file2_ino;
-	fxr.file2_mtime.tv_sec	= args.file2_mtime;
-	fxr.file2_mtime.tv_nsec	= args.file2_mtime_nsec;
-	fxr.file2_ctime.tv_sec	= args.file2_ctime;
-	fxr.file2_ctime.tv_nsec	= args.file2_ctime_nsec;
+	fxr.file2_ino		= kern_f->file2_ino;
+	fxr.file2_mtime.tv_sec	= kern_f->file2_mtime;
+	fxr.file2_mtime.tv_nsec	= kern_f->file2_mtime_nsec;
+	fxr.file2_ctime.tv_sec	= kern_f->file2_ctime;
+	fxr.file2_ctime.tv_nsec	= kern_f->file2_ctime_nsec;
 
 	file1 = fdget(args.file1_fd);
 	if (!file1.file)
@@ -2782,6 +2826,8 @@ xfs_file_ioctl(
 
 	case XFS_IOC_EXCHANGE_RANGE:
 		return xfs_ioc_exchange_range(filp, arg);
+	case XFS_IOC_START_COMMIT:
+		return xfs_ioc_start_commit(filp, arg);
 	case XFS_IOC_COMMIT_RANGE:
 		return xfs_ioc_commit_range(filp, arg);
 

