Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB943350BA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhDABKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232976AbhDABJt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23B2761057;
        Thu,  1 Apr 2021 01:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239389;
        bh=FktpAorfGucB1O/xR7ez7es2iLEjY3vYt4PTNPJBfy4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qclsjq4WsupXgvY5zzCu1mdYhyHncmjFyZ210681rBoJeOrjTELa+flO5mcZ6EzkV
         ergRdmNeFSJ+8KiPymxBBfbk3XgAQnl2T+Wto4csn4r3nokX7P2ZK4waylR/Tqs8np
         vsPaoubo0KFjAmd9guS/bNmjxrBl81ZQ+PdPDEmOBqOZSa3empEv7uE3sSVmGGL904
         CQzciXQrojuLngCLI8us2IPaDPzLwv2R2xq/np7r/6jpmkEOAMbkS6+xOkFmsnIOWd
         e7tQLwldhttFDtZBJT+BxMHqTmI1DPOfqu9j+BkJcbnntfRSFIdQhYrH/VP/zUUUyi
         b1Dm2G7vtJ4AA==
Subject: [PATCH 11/18] xfs: consolidate all of the xfs_swap_extent_forks code
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:48 -0700
Message-ID: <161723938822.3149451.8293083317769661922.stgit@magnolia>
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

Consolidate the bmbt owner change scan code in xfs_swap_extent_forks,
since it's not needed for the deferred bmap log item swapext
implementation.

The goal is to package up all three implementations into functions that
have the same preconditions and leave the system in the same state.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |  220 ++++++++++++++++++++++++------------------------
 1 file changed, 108 insertions(+), 112 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 2881583bb957..bff8725082e8 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1358,19 +1358,61 @@ xfs_swap_extent_flush(
 	return 0;
 }
 
+/*
+ * Fix up the owners of the bmbt blocks to refer to the current inode. The
+ * change owner scan attempts to order all modified buffers in the current
+ * transaction. In the event of ordered buffer failure, the offending buffer is
+ * physically logged as a fallback and the scan returns -EAGAIN. We must roll
+ * the transaction in this case to replenish the fallback log reservation and
+ * restart the scan. This process repeats until the scan completes.
+ */
+static int
+xfs_swap_change_owner(
+	struct xfs_trans	**tpp,
+	struct xfs_inode	*ip,
+	struct xfs_inode	*tmpip)
+{
+	int			error;
+	struct xfs_trans	*tp = *tpp;
+
+	do {
+		error = xfs_bmbt_change_owner(tp, ip, XFS_DATA_FORK, ip->i_ino,
+					      NULL);
+		/* success or fatal error */
+		if (error != -EAGAIN)
+			break;
+
+		error = xfs_trans_roll(tpp);
+		if (error)
+			break;
+		tp = *tpp;
+
+		/*
+		 * Redirty both inodes so they can relog and keep the log tail
+		 * moving forward.
+		 */
+		xfs_trans_ijoin(tp, ip, 0);
+		xfs_trans_ijoin(tp, tmpip, 0);
+		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+		xfs_trans_log_inode(tp, tmpip, XFS_ILOG_CORE);
+	} while (true);
+
+	return error;
+}
+
 /* Swap the extents of two files by swapping data forks. */
 STATIC int
 xfs_swap_extent_forks(
-	struct xfs_trans	*tp,
+	struct xfs_trans	**tpp,
 	struct xfs_inode	*ip,
-	struct xfs_inode	*tip,
-	int			*src_log_flags,
-	int			*target_log_flags)
+	struct xfs_inode	*tip)
 {
 	xfs_filblks_t		aforkblks = 0;
 	xfs_filblks_t		taforkblks = 0;
 	xfs_extnum_t		junk;
 	uint64_t		tmp;
+	int			src_log_flags = XFS_ILOG_CORE;
+	int			target_log_flags = XFS_ILOG_CORE;
 	int			error;
 
 	/*
@@ -1378,14 +1420,14 @@ xfs_swap_extent_forks(
 	 */
 	if (XFS_IFORK_Q(ip) && ip->i_afp->if_nextents > 0 &&
 	    ip->i_afp->if_format != XFS_DINODE_FMT_LOCAL) {
-		error = xfs_bmap_count_blocks(tp, ip, XFS_ATTR_FORK, &junk,
+		error = xfs_bmap_count_blocks(*tpp, ip, XFS_ATTR_FORK, &junk,
 				&aforkblks);
 		if (error)
 			return error;
 	}
 	if (XFS_IFORK_Q(tip) && tip->i_afp->if_nextents > 0 &&
 	    tip->i_afp->if_format != XFS_DINODE_FMT_LOCAL) {
-		error = xfs_bmap_count_blocks(tp, tip, XFS_ATTR_FORK, &junk,
+		error = xfs_bmap_count_blocks(*tpp, tip, XFS_ATTR_FORK, &junk,
 				&taforkblks);
 		if (error)
 			return error;
@@ -1400,9 +1442,9 @@ xfs_swap_extent_forks(
 	 */
 	if (xfs_sb_version_has_v3inode(&ip->i_mount->m_sb)) {
 		if (ip->i_df.if_format == XFS_DINODE_FMT_BTREE)
-			(*target_log_flags) |= XFS_ILOG_DOWNER;
+			target_log_flags |= XFS_ILOG_DOWNER;
 		if (tip->i_df.if_format == XFS_DINODE_FMT_BTREE)
-			(*src_log_flags) |= XFS_ILOG_DOWNER;
+			src_log_flags |= XFS_ILOG_DOWNER;
 	}
 
 	/*
@@ -1432,71 +1474,80 @@ xfs_swap_extent_forks(
 
 	switch (ip->i_df.if_format) {
 	case XFS_DINODE_FMT_EXTENTS:
-		(*src_log_flags) |= XFS_ILOG_DEXT;
+		src_log_flags |= XFS_ILOG_DEXT;
 		break;
 	case XFS_DINODE_FMT_BTREE:
 		ASSERT(!xfs_sb_version_has_v3inode(&ip->i_mount->m_sb) ||
-		       (*src_log_flags & XFS_ILOG_DOWNER));
-		(*src_log_flags) |= XFS_ILOG_DBROOT;
+		       (src_log_flags & XFS_ILOG_DOWNER));
+		src_log_flags |= XFS_ILOG_DBROOT;
 		break;
 	}
 
 	switch (tip->i_df.if_format) {
 	case XFS_DINODE_FMT_EXTENTS:
-		(*target_log_flags) |= XFS_ILOG_DEXT;
+		target_log_flags |= XFS_ILOG_DEXT;
 		break;
 	case XFS_DINODE_FMT_BTREE:
-		(*target_log_flags) |= XFS_ILOG_DBROOT;
+		target_log_flags |= XFS_ILOG_DBROOT;
 		ASSERT(!xfs_sb_version_has_v3inode(&ip->i_mount->m_sb) ||
-		       (*target_log_flags & XFS_ILOG_DOWNER));
+		       (target_log_flags & XFS_ILOG_DOWNER));
 		break;
 	}
 
+	/* Do we have to swap reflink flags? */
+	if ((ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK) ^
+	    (tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK)) {
+		uint64_t	f;
+
+		f = ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
+		ip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
+		ip->i_d.di_flags2 |= tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
+		tip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
+		tip->i_d.di_flags2 |= f & XFS_DIFLAG2_REFLINK;
+	}
+
+	/* Swap the cow forks. */
+	if (xfs_sb_version_hasreflink(&ip->i_mount->m_sb)) {
+		ASSERT(!ip->i_cowfp ||
+		       ip->i_cowfp->if_format == XFS_DINODE_FMT_EXTENTS);
+		ASSERT(!tip->i_cowfp ||
+		       tip->i_cowfp->if_format == XFS_DINODE_FMT_EXTENTS);
+
+		swap(ip->i_cowfp, tip->i_cowfp);
+
+		if (ip->i_cowfp && ip->i_cowfp->if_bytes)
+			xfs_inode_set_cowblocks_tag(ip);
+		else
+			xfs_inode_clear_cowblocks_tag(ip);
+		if (tip->i_cowfp && tip->i_cowfp->if_bytes)
+			xfs_inode_set_cowblocks_tag(tip);
+		else
+			xfs_inode_clear_cowblocks_tag(tip);
+	}
+
+	xfs_trans_log_inode(*tpp, ip,  src_log_flags);
+	xfs_trans_log_inode(*tpp, tip, target_log_flags);
+
+	/*
+	 * The extent forks have been swapped, but crc=1,rmapbt=0 filesystems
+	 * have inode number owner values in the bmbt blocks that still refer to
+	 * the old inode. Scan each bmbt to fix up the owner values with the
+	 * inode number of the current inode.
+	 */
+	if (src_log_flags & XFS_ILOG_DOWNER) {
+		error = xfs_swap_change_owner(tpp, ip, tip);
+		if (error)
+			return error;
+	}
+	if (target_log_flags & XFS_ILOG_DOWNER) {
+		error = xfs_swap_change_owner(tpp, tip, ip);
+		if (error)
+			return error;
+	}
+
 	return 0;
 }
 
-/*
- * Fix up the owners of the bmbt blocks to refer to the current inode. The
- * change owner scan attempts to order all modified buffers in the current
- * transaction. In the event of ordered buffer failure, the offending buffer is
- * physically logged as a fallback and the scan returns -EAGAIN. We must roll
- * the transaction in this case to replenish the fallback log reservation and
- * restart the scan. This process repeats until the scan completes.
- */
-static int
-xfs_swap_change_owner(
-	struct xfs_trans	**tpp,
-	struct xfs_inode	*ip,
-	struct xfs_inode	*tmpip)
-{
-	int			error;
-	struct xfs_trans	*tp = *tpp;
-
-	do {
-		error = xfs_bmbt_change_owner(tp, ip, XFS_DATA_FORK, ip->i_ino,
-					      NULL);
-		/* success or fatal error */
-		if (error != -EAGAIN)
-			break;
-
-		error = xfs_trans_roll(tpp);
-		if (error)
-			break;
-		tp = *tpp;
-
-		/*
-		 * Redirty both inodes so they can relog and keep the log tail
-		 * moving forward.
-		 */
-		xfs_trans_ijoin(tp, ip, 0);
-		xfs_trans_ijoin(tp, tmpip, 0);
-		xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
-		xfs_trans_log_inode(tp, tmpip, XFS_ILOG_CORE);
-	} while (true);
-
-	return error;
-}
-
 int
 xfs_swap_extents(
 	struct xfs_inode	*ip,	/* target inode */
@@ -1506,10 +1557,8 @@ xfs_swap_extents(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_bstat	*sbp = &sxp->sx_stat;
-	int			src_log_flags, target_log_flags;
 	int			error = 0;
 	int			lock_flags;
-	uint64_t		f;
 	int			resblks = 0;
 	unsigned int		flags = 0;
 
@@ -1640,9 +1689,6 @@ xfs_swap_extents(
 	 * recovery is going to see the fork as owned by the swapped inode,
 	 * not the pre-swapped inodes.
 	 */
-	src_log_flags = XFS_ILOG_CORE;
-	target_log_flags = XFS_ILOG_CORE;
-
 	if (xfs_sb_version_hasrmapbt(&mp->m_sb)) {
 		struct xfs_swapext_req	req = {
 			.ip1		= ip,
@@ -1653,62 +1699,12 @@ xfs_swap_extents(
 		};
 		error = xfs_swapext(&tp, &req);
 	} else
-		error = xfs_swap_extent_forks(tp, ip, tip, &src_log_flags,
-				&target_log_flags);
+		error = xfs_swap_extent_forks(&tp, ip, tip);
 	if (error) {
 		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
 		goto out_trans_cancel;
 	}
 
-	/* Do we have to swap reflink flags? */
-	if ((ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK) ^
-	    (tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK)) {
-		f = ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
-		ip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
-		ip->i_d.di_flags2 |= tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
-		tip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
-		tip->i_d.di_flags2 |= f & XFS_DIFLAG2_REFLINK;
-	}
-
-	/* Swap the cow forks. */
-	if (xfs_sb_version_hasreflink(&mp->m_sb)) {
-		ASSERT(!ip->i_cowfp ||
-		       ip->i_cowfp->if_format == XFS_DINODE_FMT_EXTENTS);
-		ASSERT(!tip->i_cowfp ||
-		       tip->i_cowfp->if_format == XFS_DINODE_FMT_EXTENTS);
-
-		swap(ip->i_cowfp, tip->i_cowfp);
-
-		if (ip->i_cowfp && ip->i_cowfp->if_bytes)
-			xfs_inode_set_cowblocks_tag(ip);
-		else
-			xfs_inode_clear_cowblocks_tag(ip);
-		if (tip->i_cowfp && tip->i_cowfp->if_bytes)
-			xfs_inode_set_cowblocks_tag(tip);
-		else
-			xfs_inode_clear_cowblocks_tag(tip);
-	}
-
-	xfs_trans_log_inode(tp, ip,  src_log_flags);
-	xfs_trans_log_inode(tp, tip, target_log_flags);
-
-	/*
-	 * The extent forks have been swapped, but crc=1,rmapbt=0 filesystems
-	 * have inode number owner values in the bmbt blocks that still refer to
-	 * the old inode. Scan each bmbt to fix up the owner values with the
-	 * inode number of the current inode.
-	 */
-	if (src_log_flags & XFS_ILOG_DOWNER) {
-		error = xfs_swap_change_owner(&tp, ip, tip);
-		if (error)
-			goto out_trans_cancel;
-	}
-	if (target_log_flags & XFS_ILOG_DOWNER) {
-		error = xfs_swap_change_owner(&tp, tip, ip);
-		if (error)
-			goto out_trans_cancel;
-	}
-
 	/*
 	 * If this is a synchronous mount, make sure that the
 	 * transaction goes to disk before returning to the user.

