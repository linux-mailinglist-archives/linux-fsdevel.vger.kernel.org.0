Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E296C623236
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKISQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKISQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:16:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA13127910;
        Wed,  9 Nov 2022 10:16:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7630F61C33;
        Wed,  9 Nov 2022 18:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC04C43143;
        Wed,  9 Nov 2022 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017806;
        bh=EjUE5T4PVnEgWGCsZY38G9ZLknia0cmi78DPbBCklMs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CIp4ugJ7riOzceFQmTdpcq6RGy8i/BUK59VuYC6mmnQLwG0ibYdxsDEuFZAWqqJue
         wdXw8SoOXgzCj/8cpoHRex7lIg+X3xxXkMEDAy2qU/iW++W1EV6v6stjH5rBS9yKhC
         4q4oAF6Tt9a/VCmIVYbSEnbP4KjatuYpZ07NpyuPwLwSp6caoIisYmqmUqJR27qPv5
         pwH4rOQ/EZXU+IUG5vrfRFeBgtD3wWKbyGoSvI1NDR51cwITuwtvo6m9b8vFWNm/h8
         Ik+NpIOH8lHnynBIz79m+2+AINepLEV1udvJhOs6q4wMiLbe3iyuY95LpkT4T6GSvn
         5+bn0OGDra4sw==
Subject: [PATCH 11/14] xfs: move the seq counters for buffered writes to a
 private struct
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Date:   Wed, 09 Nov 2022 10:16:46 -0800
Message-ID: <166801780645.3992140.5437978046181951687.stgit@magnolia>
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

To avoid racing with writeback, XFS needs to revalidate (io)mappings
after grabbing each folio lock.  Right now, XFS stashes the sequence
counter values in the (void *pointer) field of the iomap, which is not
the greatest solution.  First, we don't record which fork was sampled,
which means that the current code which samples either fork and compares
it to the data fork seqcount is wrong.  Second, if another thread
touches the cow fork, we (conservatively) want to revalidate because
*something* has changed.

The previous three patches reorganized the iomap callbacks to pass the
iomap_iter to the ->iomap_{begin,end} functions and provided a way to
set the iter->private field for a buffered write.  Now we can update the
buffered write paths in XFS to allocate the necessary memory to sample
both forks' sequence counters and revalidate the data fork during a
write operation.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c   |    2 -
 fs/xfs/libxfs/xfs_bmap.c |    4 +-
 fs/xfs/xfs_aops.c        |    2 -
 fs/xfs/xfs_file.c        |    3 +
 fs/xfs/xfs_iomap.c       |  115 ++++++++++++++++++++++++++++------------------
 fs/xfs/xfs_iomap.h       |   10 +++-
 fs/xfs/xfs_pnfs.c        |    5 +-
 fs/xfs/xfs_reflink.c     |    3 +
 include/linux/iomap.h    |    2 -
 9 files changed, 90 insertions(+), 56 deletions(-)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 779244960153..130890907615 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -631,7 +631,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	 * to zero) and corrupt data.
 	 */
 	if (ops->iomap_valid) {
-		bool iomap_valid = ops->iomap_valid(iter->inode, &iter->iomap);
+		bool iomap_valid = ops->iomap_valid(iter);
 
 		if (!iomap_valid) {
 			iter->iomap.flags |= IOMAP_F_STALE;
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index db225130618c..bdaa55e725a8 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4552,7 +4552,7 @@ xfs_bmapi_convert_delalloc(
 	 */
 	if (!isnullstartblock(bma.got.br_startblock)) {
 		*seq = READ_ONCE(ifp->if_seq);
-		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags, *seq);
+		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
 		goto out_trans_cancel;
 	}
 
@@ -4600,7 +4600,7 @@ xfs_bmapi_convert_delalloc(
 
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
 	*seq = READ_ONCE(ifp->if_seq);
-	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags, *seq);
+	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
 
 	if (whichfork == XFS_COW_FORK)
 		xfs_refcount_alloc_cow_extent(tp, bma.blkno, bma.length);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index ca5a9e45a48c..5d1a995b15f8 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -373,7 +373,7 @@ xfs_map_blocks(
 	    isnullstartblock(imap.br_startblock))
 		goto allocate_blocks;
 
-	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
+	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0);
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f3671e22ba16..64a1e8982467 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -701,6 +701,7 @@ xfs_file_buffered_write(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
+	struct xfs_iomap_buffered_ctx ibc = { };
 	struct inode		*inode = iocb->ki_filp->f_mapping->host;
 	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret;
@@ -722,7 +723,7 @@ xfs_file_buffered_write(
 
 	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
-			&xfs_buffered_write_iomap_ops, NULL);
+			&xfs_buffered_write_iomap_ops, &ibc);
 	if (likely(ret >= 0))
 		iocb->ki_pos += ret;
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 00a4b60c97e9..c3c23524a3d2 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -48,14 +48,30 @@ xfs_alert_fsblock_zero(
 	return -EFSCORRUPTED;
 }
 
+static inline void
+xfs_iomap_sample_seq(
+	const struct iomap_iter		*iter,
+	struct xfs_inode		*ip)
+{
+	struct xfs_iomap_buffered_ctx	*ibc = iter->private;
+
+	if (!ibc)
+		return;
+
+	/* The extent tree sequence is needed for iomap validity checking. */
+	ibc->data_seq = READ_ONCE(ip->i_df.if_seq);
+	ibc->has_cow_seq = xfs_inode_has_cow_data(ip);
+	if (ibc->has_cow_seq)
+		ibc->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
+}
+
 int
 xfs_bmbt_to_iomap(
 	struct xfs_inode	*ip,
 	struct iomap		*iomap,
 	struct xfs_bmbt_irec	*imap,
 	unsigned int		mapping_flags,
-	u16			iomap_flags,
-	int			sequence)
+	u16			iomap_flags)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
@@ -92,9 +108,6 @@ xfs_bmbt_to_iomap(
 	if (xfs_ipincount(ip) &&
 	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
 		iomap->flags |= IOMAP_F_DIRTY;
-
-	/* The extent tree sequence is needed for iomap validity checking. */
-	*((int *)&iomap->private) = sequence;
 	return 0;
 }
 
@@ -193,14 +206,14 @@ xfs_iomap_eof_align_last_fsb(
 	return end_fsb;
 }
 
-int
-xfs_iomap_write_direct(
+static int
+__xfs_iomap_write_direct(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
 	xfs_fileoff_t		count_fsb,
 	unsigned int		flags,
 	struct xfs_bmbt_irec	*imap,
-	int			*seq)
+	const struct iomap_iter	*iter)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -290,8 +303,8 @@ xfs_iomap_write_direct(
 		error = xfs_alert_fsblock_zero(ip, imap);
 
 out_unlock:
-	if (seq)
-		*seq = READ_ONCE(ip->i_df.if_seq);
+	if (iter)
+		xfs_iomap_sample_seq(iter, ip);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 
@@ -300,6 +313,18 @@ xfs_iomap_write_direct(
 	goto out_unlock;
 }
 
+int
+xfs_iomap_write_direct(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		count_fsb,
+	unsigned int		flags,
+	struct xfs_bmbt_irec	*imap)
+{
+	return __xfs_iomap_write_direct(ip, offset_fsb, count_fsb, flags, imap,
+			NULL);
+}
+
 STATIC bool
 xfs_quota_need_throttle(
 	struct xfs_inode	*ip,
@@ -751,7 +776,6 @@ xfs_direct_write_iomap_begin(
 	bool			shared = false;
 	u16			iomap_flags = 0;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
-	int			seq;
 
 	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
 
@@ -820,10 +844,10 @@ xfs_direct_write_iomap_begin(
 			goto out_unlock;
 	}
 
-	seq = READ_ONCE(ip->i_df.if_seq);
+	xfs_iomap_sample_seq(iter, ip);
 	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags);
 
 allocate_blocks:
 	error = -EAGAIN;
@@ -848,26 +872,26 @@ xfs_direct_write_iomap_begin(
 		end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
 	xfs_iunlock(ip, lockmode);
 
-	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
-			flags, &imap, &seq);
+	error = __xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
+			flags, &imap, iter);
 	if (error)
 		return error;
 
 	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 iomap_flags | IOMAP_F_NEW, seq);
+				 iomap_flags | IOMAP_F_NEW);
 
 out_found_cow:
-	seq = READ_ONCE(ip->i_df.if_seq);
+	xfs_iomap_sample_seq(iter, ip);
 	xfs_iunlock(ip, lockmode);
 	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
 	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
 	if (imap.br_startblock != HOLESTARTBLOCK) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
 		if (error)
 			return error;
 	}
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED);
 
 out_unlock:
 	if (lockmode)
@@ -926,7 +950,6 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 	unsigned int		lockmode = XFS_ILOCK_EXCL;
-	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1105,29 +1128,29 @@ xfs_buffered_write_iomap_begin(
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
-	seq = READ_ONCE(ip->i_df.if_seq);
+	xfs_iomap_sample_seq(iter, ip);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW);
 
 found_imap:
-	seq = READ_ONCE(ip->i_df.if_seq);
+	xfs_iomap_sample_seq(iter, ip);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
 
 found_cow:
-	seq = READ_ONCE(ip->i_df.if_seq);
+	xfs_iomap_sample_seq(iter, ip);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	if (imap.br_startoff <= offset_fsb) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
 		if (error)
 			return error;
 		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-					 IOMAP_F_SHARED, seq);
+					 IOMAP_F_SHARED);
 	}
 
 	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0);
 
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1340,12 +1363,12 @@ xfs_buffered_write_iomap_end(
  */
 static bool
 xfs_buffered_write_iomap_valid(
-	struct inode		*inode,
-	const struct iomap	*iomap)
+	const struct iomap_iter		*iter)
 {
-	int			seq = *((int *)&iomap->private);
+	struct xfs_iomap_buffered_ctx	*ibc = iter->private;
+	struct xfs_inode		*ip = XFS_I(iter->inode);
 
-	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
+	if (ibc->data_seq != READ_ONCE(ip->i_df.if_seq))
 		return false;
 	return true;
 }
@@ -1383,7 +1406,6 @@ xfs_read_iomap_begin(
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
-	int			seq;
 
 	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
 
@@ -1397,14 +1419,15 @@ xfs_read_iomap_begin(
 			       &nimaps, 0);
 	if (!error && (flags & IOMAP_REPORT))
 		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
-	seq = READ_ONCE(ip->i_df.if_seq);
+	if (!error)
+		xfs_iomap_sample_seq(iter, ip);
 	xfs_iunlock(ip, lockmode);
 
 	if (error)
 		return error;
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 shared ? IOMAP_F_SHARED : 0, seq);
+				 shared ? IOMAP_F_SHARED : 0);
 }
 
 const struct iomap_ops xfs_read_iomap_ops = {
@@ -1463,9 +1486,13 @@ xfs_seek_iomap_begin(
 	if (cow_fsb != NULLFILEOFF && cow_fsb <= offset_fsb) {
 		if (data_fsb < cow_fsb + cmap.br_blockcount)
 			end_fsb = min(end_fsb, data_fsb);
+		xfs_iomap_sample_seq(iter, ip);
 		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
 		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-				IOMAP_F_SHARED, READ_ONCE(ip->i_cowfp->if_seq));
+				IOMAP_F_SHARED);
+		if (error)
+			goto out_unlock;
+
 		/*
 		 * This is a COW extent, so we must probe the page cache
 		 * because there could be dirty page cache being backed
@@ -1487,8 +1514,8 @@ xfs_seek_iomap_begin(
 	imap.br_state = XFS_EXT_NORM;
 done:
 	xfs_trim_extent(&imap, offset_fsb, end_fsb);
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0,
-			READ_ONCE(ip->i_df.if_seq));
+	xfs_iomap_sample_seq(iter, ip);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
 out_unlock:
 	xfs_iunlock(ip, lockmode);
 	return error;
@@ -1515,7 +1542,6 @@ xfs_xattr_iomap_begin(
 	struct xfs_bmbt_irec	imap;
 	int			nimaps = 1, error = 0;
 	unsigned		lockmode;
-	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1532,14 +1558,13 @@ xfs_xattr_iomap_begin(
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
 			       &nimaps, XFS_BMAPI_ATTRFORK);
 out_unlock:
-
-	seq = READ_ONCE(ip->i_af.if_seq);
+	xfs_iomap_sample_seq(iter, ip);
 	xfs_iunlock(ip, lockmode);
 
 	if (error)
 		return error;
 	ASSERT(nimaps);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
 }
 
 const struct iomap_ops xfs_xattr_iomap_ops = {
@@ -1553,13 +1578,14 @@ xfs_zero_range(
 	loff_t			len,
 	bool			*did_zero)
 {
+	struct xfs_iomap_buffered_ctx ibc = { };
 	struct inode		*inode = VFS_I(ip);
 
 	if (IS_DAX(inode))
 		return dax_zero_range(inode, pos, len, did_zero,
 				      &xfs_direct_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
-				&xfs_buffered_write_iomap_ops, NULL);
+				&xfs_buffered_write_iomap_ops, &ibc);
 }
 
 int
@@ -1568,11 +1594,12 @@ xfs_truncate_page(
 	loff_t			pos,
 	bool			*did_zero)
 {
+	struct xfs_iomap_buffered_ctx ibc = { };
 	struct inode		*inode = VFS_I(ip);
 
 	if (IS_DAX(inode))
 		return dax_truncate_page(inode, pos, did_zero,
 					&xfs_direct_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
-				   &xfs_buffered_write_iomap_ops, NULL);
+				   &xfs_buffered_write_iomap_ops, &ibc);
 }
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 792fed2a9072..369de43ae568 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -11,16 +11,22 @@
 struct xfs_inode;
 struct xfs_bmbt_irec;
 
+struct xfs_iomap_buffered_ctx {
+	unsigned int	data_seq;
+	unsigned int	cow_seq;
+	bool		has_cow_seq;
+};
+
 int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
 		xfs_fileoff_t count_fsb, unsigned int flags,
-		struct xfs_bmbt_irec *imap, int *sequence);
+		struct xfs_bmbt_irec *imap);
 int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
 
 int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
 		struct xfs_bmbt_irec *imap, unsigned int mapping_flags,
-		u16 iomap_flags, int sequence);
+		u16 iomap_flags);
 
 int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
 		bool *did_zero);
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index eea507a80c5c..37a24f0f7cd4 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -125,7 +125,6 @@ xfs_fs_map_blocks(
 	int			nimaps = 1;
 	uint			lock_flags;
 	int			error = 0;
-	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -190,7 +189,7 @@ xfs_fs_map_blocks(
 		xfs_iunlock(ip, lock_flags);
 
 		error = xfs_iomap_write_direct(ip, offset_fsb,
-				end_fsb - offset_fsb, 0, &imap, &seq);
+				end_fsb - offset_fsb, 0, &imap);
 		if (error)
 			goto out_unlock;
 
@@ -210,7 +209,7 @@ xfs_fs_map_blocks(
 	}
 	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0, seq);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0);
 	*device_generation = mp->m_generation;
 	return error;
 out_unlock:
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 31b7b6e5db45..33b4853a31d5 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1683,6 +1683,7 @@ xfs_reflink_unshare(
 	xfs_off_t		offset,
 	xfs_off_t		len)
 {
+	struct xfs_iomap_buffered_ctx ibc = { };
 	struct inode		*inode = VFS_I(ip);
 	int			error;
 
@@ -1694,7 +1695,7 @@ xfs_reflink_unshare(
 	inode_dio_wait(inode);
 
 	error = iomap_file_unshare(inode, offset, len,
-			&xfs_buffered_write_iomap_ops, NULL);
+			&xfs_buffered_write_iomap_ops, &ibc);
 	if (error)
 		goto out;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 152353164a5a..af8ead9ac362 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -182,7 +182,7 @@ struct iomap_ops {
 	 * This is called with the folio over the specified file position
 	 * held locked by the iomap code.
 	 */
-	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+	bool (*iomap_valid)(const struct iomap_iter *iter);
 };
 
 /**

