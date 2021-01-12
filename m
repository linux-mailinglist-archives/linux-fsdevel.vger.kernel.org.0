Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92322F2547
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbhALBIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:08:47 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:45908 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731358AbhALBIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:08:46 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 0F0DF67F5;
        Tue, 12 Jan 2021 12:08:00 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-005Wb9-Fw; Tue, 12 Jan 2021 12:07:49 +1100
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-004qaw-7o; Tue, 12 Jan 2021 12:07:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com, andres@anarazel.de
Subject: [PATCH 1/6] iomap: convert iomap_dio_rw() to an args structure
Date:   Tue, 12 Jan 2021 12:07:41 +1100
Message-Id: <20210112010746.1154363-2-david@fromorbit.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112010746.1154363-1-david@fromorbit.com>
References: <20210112010746.1154363-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=EmqxpYm9HcoA:10 a=20KFwNOVAAAA:8 a=3h4dG6124SXyyoldOQQA:9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Adding yet another parameter to the iomap_dio_rw() interface means
changing lots of filesystems to add the parameter. Convert this
interface to an args structure so in future we don't need to modify
every caller to add a new parameter.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/btrfs/file.c       | 21 ++++++++++++++++-----
 fs/ext4/file.c        | 24 ++++++++++++++++++------
 fs/gfs2/file.c        | 19 ++++++++++++++-----
 fs/iomap/direct-io.c  | 30 ++++++++++++++----------------
 fs/xfs/xfs_file.c     | 30 +++++++++++++++++++++---------
 fs/zonefs/super.c     | 21 +++++++++++++++++----
 include/linux/iomap.h | 16 ++++++++++------
 7 files changed, 110 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e41459b8de6..a49d9fa918d1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1907,6 +1907,13 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio = NULL;
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= from,
+		.ops			= &btrfs_dio_iomap_ops,
+		.dops			= &btrfs_dio_ops,
+		.wait_for_completion	= is_sync_kiocb(iocb),
+	};
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1949,9 +1956,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		goto buffered;
 	}
 
-	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops,
-			     &btrfs_dio_ops, is_sync_kiocb(iocb));
-
+	dio = __iomap_dio_rw(&args);
 	btrfs_inode_unlock(inode, ilock_flags);
 
 	if (IS_ERR_OR_NULL(dio)) {
@@ -3617,13 +3622,19 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= to,
+		.ops			= &btrfs_dio_iomap_ops,
+		.dops			= &btrfs_dio_ops,
+		.wait_for_completion	= is_sync_kiocb(iocb),
+	};
 
 	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
 		return 0;
 
 	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
-	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			   is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(&args);
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	return ret;
 }
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 3ed8c048fb12..436508be6d88 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -53,6 +53,12 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= to,
+		.ops			= &ext4_iomap_ops,
+		.wait_for_completion	= is_sync_kiocb(iocb),
+	};
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		if (!inode_trylock_shared(inode))
@@ -74,8 +80,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return generic_file_read_iter(iocb, to);
 	}
 
-	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(&args);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
@@ -459,9 +464,15 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(from);
-	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
 	bool extend = false, unaligned_io = false;
 	bool ilock_shared = true;
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= from,
+		.ops			= &ext4_iomap_ops,
+		.dops			= &ext4_dio_write_ops,
+		.wait_for_completion	= is_sync_kiocb(iocb),
+	};
 
 	/*
 	 * We initially start with shared inode lock unless it is
@@ -548,9 +559,10 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	if (ilock_shared)
-		iomap_ops = &ext4_iomap_overwrite_ops;
-	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
-			   is_sync_kiocb(iocb) || unaligned_io || extend);
+		args.ops = &ext4_iomap_overwrite_ops;
+	if (unaligned_io || extend)
+		args.wait_for_completion = true;
+	ret = iomap_dio_rw(&args);
 	if (ret == -ENOTBLK)
 		ret = 0;
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b39b339feddc..d44a5f9c5f34 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -788,6 +788,12 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
 	size_t count = iov_iter_count(to);
 	ssize_t ret;
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= to,
+		.ops			= &gfs2_iomap_ops,
+		.wait_for_completion	= is_sync_kiocb(iocb),
+	};
 
 	if (!count)
 		return 0; /* skip atime */
@@ -797,9 +803,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to,
 	if (ret)
 		goto out_uninit;
 
-	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
-
+	ret = iomap_dio_rw(&args);
 	gfs2_glock_dq(gh);
 out_uninit:
 	gfs2_holder_uninit(gh);
@@ -815,6 +819,12 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	size_t len = iov_iter_count(from);
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret;
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= from,
+		.ops			= &gfs2_iomap_ops,
+		.wait_for_completion	= is_sync_kiocb(iocb),
+	};
 
 	/*
 	 * Deferred lock, even if its a write, since we do no allocation on
@@ -833,8 +843,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
-	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
-			   is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(&args);
 	if (ret == -ENOTBLK)
 		ret = 0;
 out:
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..05cacc27578c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -418,13 +418,13 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
  * writes.  The callers needs to fall back to buffered I/O in this case.
  */
 struct iomap_dio *
-__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion)
+__iomap_dio_rw(struct iomap_dio_rw_args *args)
 {
+	struct kiocb *iocb = args->iocb;
+	struct iov_iter *iter = args->iter;
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
-	size_t count = iov_iter_count(iter);
+	size_t count = iov_iter_count(args->iter);
 	loff_t pos = iocb->ki_pos;
 	loff_t end = iocb->ki_pos + count - 1, ret = 0;
 	unsigned int flags = IOMAP_DIRECT;
@@ -434,7 +434,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!count)
 		return NULL;
 
-	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
+	if (WARN_ON(is_sync_kiocb(iocb) && !args->wait_for_completion))
 		return ERR_PTR(-EIO);
 
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
@@ -445,7 +445,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	atomic_set(&dio->ref, 1);
 	dio->size = 0;
 	dio->i_size = i_size_read(inode);
-	dio->dops = dops;
+	dio->dops = args->dops;
 	dio->error = 0;
 	dio->flags = 0;
 
@@ -490,7 +490,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret)
 		goto out_free_dio;
 
-	if (iov_iter_rw(iter) == WRITE) {
+	if (iov_iter_rw(args->iter) == WRITE) {
 		/*
 		 * Try to invalidate cache pages for the range we are writing.
 		 * If this invalidation fails, let the caller fall back to
@@ -503,7 +503,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_free_dio;
 		}
 
-		if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
+		if (!args->wait_for_completion && !inode->i_sb->s_dio_done_wq) {
 			ret = sb_init_dio_done_wq(inode->i_sb);
 			if (ret < 0)
 				goto out_free_dio;
@@ -514,12 +514,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	blk_start_plug(&plug);
 	do {
-		ret = iomap_apply(inode, pos, count, flags, ops, dio,
+		ret = iomap_apply(inode, pos, count, flags, args->ops, dio,
 				iomap_dio_actor);
 		if (ret <= 0) {
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {
-				wait_for_completion = true;
+				args->wait_for_completion = true;
 				ret = 0;
 			}
 			break;
@@ -566,9 +566,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 *	of the final reference, and we will complete and free it here
 	 *	after we got woken by the I/O completion handler.
 	 */
-	dio->wait_for_completion = wait_for_completion;
+	dio->wait_for_completion = args->wait_for_completion;
 	if (!atomic_dec_and_test(&dio->ref)) {
-		if (!wait_for_completion)
+		if (!args->wait_for_completion)
 			return ERR_PTR(-EIOCBQUEUED);
 
 		for (;;) {
@@ -596,13 +596,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 EXPORT_SYMBOL_GPL(__iomap_dio_rw);
 
 ssize_t
-iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion)
+iomap_dio_rw(struct iomap_dio_rw_args *args)
 {
 	struct iomap_dio *dio;
 
-	dio = __iomap_dio_rw(iocb, iter, ops, dops, wait_for_completion);
+	dio = __iomap_dio_rw(args);
 	if (IS_ERR_OR_NULL(dio))
 		return PTR_ERR_OR_ZERO(dio);
 	return iomap_dio_complete(dio);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b0f93f73837..29f4204e551f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -205,6 +205,12 @@ xfs_file_dio_aio_read(
 	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
 	size_t			count = iov_iter_count(to);
 	ssize_t			ret;
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= to,
+		.ops			= &xfs_read_iomap_ops,
+		.wait_for_completion	= is_sync_kiocb(iocb),
+	};
 
 	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);
 
@@ -219,8 +225,7 @@ xfs_file_dio_aio_read(
 	} else {
 		xfs_ilock(ip, XFS_IOLOCK_SHARED);
 	}
-	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
-			is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(&args);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -519,6 +524,13 @@ xfs_file_dio_aio_write(
 	int			iolock;
 	size_t			count = iov_iter_count(from);
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= from,
+		.ops			= &xfs_direct_write_iomap_ops,
+		.dops			= &xfs_dio_write_ops,
+		.wait_for_completion	= is_sync_kiocb(iocb),
+	};
 
 	/* DIO must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
@@ -535,6 +547,12 @@ xfs_file_dio_aio_write(
 	    ((iocb->ki_pos + count) & mp->m_blockmask)) {
 		unaligned_io = 1;
 
+		/*
+		 * This must be the only IO in-flight. Wait on it before we
+		 * release the iolock to prevent subsequent overlapping IO.
+		 */
+		args.wait_for_completion = true;
+
 		/*
 		 * We can't properly handle unaligned direct I/O to reflink
 		 * files yet, as we can't unshare a partial block.
@@ -578,13 +596,7 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	/*
-	 * If unaligned, this is the only IO in-flight. Wait on it before we
-	 * release the iolock to prevent subsequent overlapping IO.
-	 */
-	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
-			   &xfs_dio_write_ops,
-			   is_sync_kiocb(iocb) || unaligned_io);
+	ret = iomap_dio_rw(&args);
 out:
 	xfs_iunlock(ip, iolock);
 
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074b..edf353ad1edc 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -735,6 +735,13 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	bool append = false;
 	size_t count;
 	ssize_t ret;
+	struct iomap_dio_rw_args args = {
+		.iocb			= iocb,
+		.iter			= from,
+		.ops			= &zonefs_iomap_ops,
+		.dops			= &zonefs_write_dio_ops,
+		.wait_for_completion	= sync,
+	};
 
 	/*
 	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
@@ -779,8 +786,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	if (append)
 		ret = zonefs_file_dio_append(iocb, from);
 	else
-		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
-				   &zonefs_write_dio_ops, sync);
+		ret = iomap_dio_rw(&args);
+
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
 	    (ret > 0 || ret == -EIOCBQUEUED)) {
 		if (ret > 0)
@@ -909,6 +916,13 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	mutex_unlock(&zi->i_truncate_mutex);
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
+		struct iomap_dio_rw_args args = {
+			.iocb			= iocb,
+			.iter			= to,
+			.ops			= &zonefs_iomap_ops,
+			.dops			= &zonefs_read_dio_ops,
+			.wait_for_completion	= is_sync_kiocb(iocb),
+		};
 		size_t count = iov_iter_count(to);
 
 		if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
@@ -916,8 +930,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			goto inode_unlock;
 		}
 		file_accessed(iocb->ki_filp);
-		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
-				   &zonefs_read_dio_ops, is_sync_kiocb(iocb));
+		ret = iomap_dio_rw(&args);
 	} else {
 		ret = generic_file_read_iter(iocb, to);
 		if (ret == -EIO)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5bd3cac4df9c..16d20c01b5bb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -256,12 +256,16 @@ struct iomap_dio_ops {
 			struct bio *bio, loff_t file_offset);
 };
 
-ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion);
-struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-		bool wait_for_completion);
+struct iomap_dio_rw_args {
+	struct kiocb		*iocb;
+	struct iov_iter		*iter;
+	const struct iomap_ops	*ops;
+	const struct iomap_dio_ops *dops;
+	bool			wait_for_completion;
+};
+
+ssize_t iomap_dio_rw(struct iomap_dio_rw_args *args);
+struct iomap_dio *__iomap_dio_rw(struct iomap_dio_rw_args *args);
 ssize_t iomap_dio_complete(struct iomap_dio *dio);
 int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
-- 
2.28.0

