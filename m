Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35419659EDE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiL3XxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiL3XxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:53:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922AC1DF3A;
        Fri, 30 Dec 2022 15:53:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5358DB80883;
        Fri, 30 Dec 2022 23:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147CFC433EF;
        Fri, 30 Dec 2022 23:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444396;
        bh=Z+WdyR21OnOkAeFJd2/2V5xKTkymJYwVNQwGZNWgWyI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RoHEcXPkIC0ZIWtPZKMaIdjba+Tl6GeRUpGzQCsShCBhbQWxxpdgNGqHJiYr1Id6C
         YMwaDVb9KzbGzkzXRf1/wNb1unt/xTzize8L2hBPuhwoKcL1dRraurGOv5aFguvIfg
         4bDNCkoBbr7goYUFs6boFTLoYwX5AhHNkhKJmAgRun6U2Sx13QwPLz6TN5/NCx+si5
         S7WmhbtiEUnteZWsJBr2ltKFlMkF6cz5fCZAAzRhrYOraER+on3BZ6alPuJ8SvB/BY
         uPbd1RVCzNu4Qyk3t2TLAzvcOGwq5NkDChfujF9km5TeWUHXSOc1js59a2C9njRvRL
         DGJb+ekII01Sw==
Subject: [PATCH 12/21] xfs: consolidate all of the xfs_swap_extent_forks code
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:57 -0800
Message-ID: <167243843698.699466.5411234125659051866.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
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

Now that we've moved the old swapext code to use the new log-assisted
extent swap code for rmap filesystems, let's start porting the old
implementation to the new ioctl interface so that later we can port the
old interface to the new interface.

Consolidate the reflink flag swap code and the the bmbt owner change
scan code in xfs_swap_extent_forks, since both interfaces are going to
need that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |  220 ++++++++++++++++++++++++------------------------
 1 file changed, 108 insertions(+), 112 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 4d4696bf9b08..dbd95d86addb 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1360,19 +1360,61 @@ xfs_swap_extent_flush(
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
@@ -1380,14 +1422,14 @@ xfs_swap_extent_forks(
 	 */
 	if (xfs_inode_has_attr_fork(ip) && ip->i_af.if_nextents > 0 &&
 	    ip->i_af.if_format != XFS_DINODE_FMT_LOCAL) {
-		error = xfs_bmap_count_blocks(tp, ip, XFS_ATTR_FORK, &junk,
+		error = xfs_bmap_count_blocks(*tpp, ip, XFS_ATTR_FORK, &junk,
 				&aforkblks);
 		if (error)
 			return error;
 	}
 	if (xfs_inode_has_attr_fork(tip) && tip->i_af.if_nextents > 0 &&
 	    tip->i_af.if_format != XFS_DINODE_FMT_LOCAL) {
-		error = xfs_bmap_count_blocks(tp, tip, XFS_ATTR_FORK, &junk,
+		error = xfs_bmap_count_blocks(*tpp, tip, XFS_ATTR_FORK, &junk,
 				&taforkblks);
 		if (error)
 			return error;
@@ -1402,9 +1444,9 @@ xfs_swap_extent_forks(
 	 */
 	if (xfs_has_v3inodes(ip->i_mount)) {
 		if (ip->i_df.if_format == XFS_DINODE_FMT_BTREE)
-			(*target_log_flags) |= XFS_ILOG_DOWNER;
+			target_log_flags |= XFS_ILOG_DOWNER;
 		if (tip->i_df.if_format == XFS_DINODE_FMT_BTREE)
-			(*src_log_flags) |= XFS_ILOG_DOWNER;
+			src_log_flags |= XFS_ILOG_DOWNER;
 	}
 
 	/*
@@ -1434,71 +1476,80 @@ xfs_swap_extent_forks(
 
 	switch (ip->i_df.if_format) {
 	case XFS_DINODE_FMT_EXTENTS:
-		(*src_log_flags) |= XFS_ILOG_DEXT;
+		src_log_flags |= XFS_ILOG_DEXT;
 		break;
 	case XFS_DINODE_FMT_BTREE:
 		ASSERT(!xfs_has_v3inodes(ip->i_mount) ||
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
 		ASSERT(!xfs_has_v3inodes(ip->i_mount) ||
-		       (*target_log_flags & XFS_ILOG_DOWNER));
+		       (target_log_flags & XFS_ILOG_DOWNER));
 		break;
 	}
 
+	/* Do we have to swap reflink flags? */
+	if ((ip->i_diflags2 & XFS_DIFLAG2_REFLINK) ^
+	    (tip->i_diflags2 & XFS_DIFLAG2_REFLINK)) {
+		uint64_t	f;
+
+		f = ip->i_diflags2 & XFS_DIFLAG2_REFLINK;
+		ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
+		ip->i_diflags2 |= tip->i_diflags2 & XFS_DIFLAG2_REFLINK;
+		tip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
+		tip->i_diflags2 |= f & XFS_DIFLAG2_REFLINK;
+	}
+
+	/* Swap the cow forks. */
+	if (xfs_has_reflink(ip->i_mount)) {
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
@@ -1508,9 +1559,7 @@ xfs_swap_extents(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_bstat	*sbp = &sxp->sx_stat;
-	int			src_log_flags, target_log_flags;
 	int			error = 0;
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
 	if (xfs_has_rmapbt(mp)) {
 		struct xfs_swapext_req	req = {
 			.ip1		= tip,
@@ -1655,62 +1701,12 @@ xfs_swap_extents(
 		xfs_swapext(tp, &req);
 		error = xfs_defer_finish(&tp);
 	} else
-		error = xfs_swap_extent_forks(tp, ip, tip, &src_log_flags,
-				&target_log_flags);
+		error = xfs_swap_extent_forks(&tp, ip, tip);
 	if (error) {
 		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
 		goto out_trans_cancel;
 	}
 
-	/* Do we have to swap reflink flags? */
-	if ((ip->i_diflags2 & XFS_DIFLAG2_REFLINK) ^
-	    (tip->i_diflags2 & XFS_DIFLAG2_REFLINK)) {
-		f = ip->i_diflags2 & XFS_DIFLAG2_REFLINK;
-		ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
-		ip->i_diflags2 |= tip->i_diflags2 & XFS_DIFLAG2_REFLINK;
-		tip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
-		tip->i_diflags2 |= f & XFS_DIFLAG2_REFLINK;
-	}
-
-	/* Swap the cow forks. */
-	if (xfs_has_reflink(mp)) {
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

