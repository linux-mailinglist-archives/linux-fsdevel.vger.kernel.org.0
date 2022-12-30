Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF25A659EEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiL3Xxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiL3Xxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:53:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FA1E3D6;
        Fri, 30 Dec 2022 15:53:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D627A61B98;
        Fri, 30 Dec 2022 23:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455D6C433D2;
        Fri, 30 Dec 2022 23:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444427;
        bh=AKaVQQmU9fM/WNiMCxkI/eFl5zhqdBthV24kVCilEYc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kj0SjqgfuKHSNWH9nfHb20MSEgxo3J1fBsBnVPyNatJqyXA0usxKIF+FHDSpb1mrM
         t9uE/6uJsKpwyf1IiyA50n6mmBPLjLBKjC99zAHuvp9wT3+5ENGWoNeHiOt4yEnaYD
         06+zZeT1IXRTxgKf2SLmTOHYOiNyMXIpyydN0sOwUCQLkRhdQWiqu0S1q0Gfm9NDQV
         IKLs3x5bHbfUw3F1eO74swLP1pFsh2tEUPXzb+PU5Zs7vuS841MbLM40YsxeyCXat0
         x8hlHsxkcRIwbD9oTaLE2r8NOB+XKygjicYXXMuLftCaXCK6VLc4XQcT6KJfFxD7OH
         eeaJVZ7OKX/Wg==
Subject: [PATCH 14/21] xfs: allow xfs_swap_range to use older extent swap
 algorithms
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:57 -0800
Message-ID: <167243843727.699466.11955722742191147402.stgit@magnolia>
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

If userspace permits non-atomic swap operations, use the older code
paths to implement the same functionality.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |    4 +-
 fs/xfs/xfs_bmap_util.h |    4 ++
 fs/xfs/xfs_xchgrange.c |   96 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 92 insertions(+), 12 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 9d6337a05544..e8562c4de7eb 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1261,7 +1261,7 @@ xfs_insert_file_space(
  * reject and log the attempt. basically we are putting the responsibility on
  * userspace to get this right.
  */
-static int
+int
 xfs_swap_extents_check_format(
 	struct xfs_inode	*ip,	/* target inode */
 	struct xfs_inode	*tip)	/* tmp inode */
@@ -1403,7 +1403,7 @@ xfs_swap_change_owner(
 }
 
 /* Swap the extents of two files by swapping data forks. */
-STATIC int
+int
 xfs_swap_extent_forks(
 	struct xfs_trans	**tpp,
 	struct xfs_swapext_req	*req)
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 6888078f5c31..39c71da08403 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -69,6 +69,10 @@ int	xfs_free_eofblocks(struct xfs_inode *ip);
 int	xfs_swap_extents(struct xfs_inode *ip, struct xfs_inode *tip,
 			 struct xfs_swapext *sx);
 
+struct xfs_swapext_req;
+int xfs_swap_extent_forks(struct xfs_trans **tpp, struct xfs_swapext_req *req);
+int xfs_swap_extents_check_format(struct xfs_inode *ip, struct xfs_inode *tip);
+
 xfs_daddr_t xfs_fsb_to_db(struct xfs_inode *ip, xfs_fsblock_t fsb);
 
 xfs_extnum_t xfs_bmap_count_leaves(struct xfs_ifork *ifp, xfs_filblks_t *count);
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
index 9966938134c0..2b7aedc49923 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -297,6 +297,33 @@ xfs_xchg_range_rele_log_assist(
 	xlog_drop_incompat_feat(mp->m_log, XLOG_INCOMPAT_FEAT_SWAPEXT);
 }
 
+/* Decide if we can use the old data fork exchange code. */
+static inline bool
+xfs_xchg_use_forkswap(
+	const struct file_xchg_range	*fxr,
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2)
+{
+	if (!(fxr->flags & FILE_XCHG_RANGE_NONATOMIC))
+		return false;
+	if (!(fxr->flags & FILE_XCHG_RANGE_FULL_FILES))
+		return false;
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
+		return false;
+	if (fxr->file1_offset != 0 || fxr->file2_offset != 0)
+		return false;
+	if (fxr->length != ip1->i_disk_size)
+		return false;
+	if (fxr->length != ip2->i_disk_size)
+		return false;
+	return true;
+}
+
+enum xchg_strategy {
+	SWAPEXT		= 1,	/* xfs_swapext() */
+	FORKSWAP	= 2,	/* exchange forks */
+};
+
 /* Exchange the contents of two files. */
 int
 xfs_xchg_range(
@@ -316,19 +343,13 @@ xfs_xchg_range(
 	};
 	struct xfs_trans		*tp;
 	unsigned int			qretry;
+	unsigned int			flags = 0;
 	bool				retried = false;
+	enum xchg_strategy		strategy;
 	int				error;
 
 	trace_xfs_xchg_range(ip1, fxr, ip2, xchg_flags);
 
-	/*
-	 * This function only supports using log intent items (SXI items if
-	 * atomic exchange is required, or BUI items if not) to exchange file
-	 * data.  The legacy whole-fork swap will be ported in a later patch.
-	 */
-	if (!(xchg_flags & XFS_XCHG_RANGE_LOGGED) && !xfs_swapext_supported(mp))
-		return -EOPNOTSUPP;
-
 	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
 		req.req_flags |= XFS_SWAP_REQ_SET_SIZES;
 	if (fxr->flags & FILE_XCHG_RANGE_SKIP_FILE1_HOLES)
@@ -340,10 +361,25 @@ xfs_xchg_range(
 	if (error)
 		return error;
 
+	/*
+	 * We haven't decided which exchange strategy we want to use yet, but
+	 * here we must choose if we want freed blocks during the swap to be
+	 * added to the transaction block reservation (RES_FDBLKS) or freed
+	 * into the global fdblocks.  The legacy fork swap mechanism doesn't
+	 * free any blocks, so it doesn't require it.  It is also the only
+	 * option that works for older filesystems.
+	 *
+	 * The bmap log intent items that were added with rmap and reflink can
+	 * change the bmbt shape, so the intent-based swap strategies require
+	 * us to set RES_FDBLKS.
+	 */
+	if (xfs_has_lazysbcount(mp))
+		flags |= XFS_TRANS_RES_FDBLKS;
+
 retry:
 	/* Allocate the transaction, lock the inodes, and join them. */
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, req.resblks, 0,
-			XFS_TRANS_RES_FDBLKS, &tp);
+			flags, &tp);
 	if (error)
 		return error;
 
@@ -386,6 +422,40 @@ xfs_xchg_range(
 	if (error)
 		goto out_trans_cancel;
 
+	if ((xchg_flags & XFS_XCHG_RANGE_LOGGED) || xfs_swapext_supported(mp)) {
+		/*
+		 * xfs_swapext() uses deferred bmap log intent items to swap
+		 * extents between file forks.  If the atomic log swap feature
+		 * is enabled, it will also use swapext log intent items to
+		 * restart the operation in case of failure.
+		 *
+		 * This means that we can use it if we previously obtained
+		 * permission from the log to use log-assisted atomic extent
+		 * swapping; or if the fs supports rmap or reflink and the
+		 * user said NONATOMIC.
+		 */
+		strategy = SWAPEXT;
+	} else if (xfs_xchg_use_forkswap(fxr, ip1, ip2)) {
+		/*
+		 * Exchange the file contents by using the old bmap fork
+		 * exchange code, if we're a defrag tool doing a full file
+		 * swap.
+		 */
+		strategy = FORKSWAP;
+
+		error = xfs_swap_extents_check_format(ip2, ip1);
+		if (error) {
+			xfs_notice(mp,
+		"%s: inode 0x%llx format is incompatible for exchanging.",
+					__func__, ip2->i_ino);
+			goto out_trans_cancel;
+		}
+	} else {
+		/* We cannot exchange the file contents. */
+		error = -EOPNOTSUPP;
+		goto out_trans_cancel;
+	}
+
 	/* If we got this far on a dry run, all parameters are ok. */
 	if (fxr->flags & FILE_XCHG_RANGE_DRY_RUN)
 		goto out_trans_cancel;
@@ -398,7 +468,13 @@ xfs_xchg_range(
 		xfs_trans_ichgtime(tp, ip2,
 				XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
 
-	xfs_swapext(tp, &req);
+	if (strategy == SWAPEXT) {
+		xfs_swapext(tp, &req);
+	} else {
+		error = xfs_swap_extent_forks(&tp, &req);
+		if (error)
+			goto out_trans_cancel;
+	}
 
 	/*
 	 * Force the log to persist metadata updates if the caller or the

