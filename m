Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6585F350BA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhDABKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233036AbhDABKA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:10:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AE2861073;
        Thu,  1 Apr 2021 01:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239400;
        bh=g41iFUu/ELIShU2ZENeAptrhYIpTYEX+OOLzxVKS/Kk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Zy2H6PiMDTnLG8DB0E7Q8V4XiaWvRZ289N0UEbH0JXzKXTPSLAP+XBSAfq6OovIW1
         1RCNoaLs79bYBOXA8ZJf5KIh+Uyv7B4WZA4fEUbPJBh9WPsA3Kpm023eI1MZ4cL5Gt
         kkCDKHCsJOKEBRNmEvOyorxL6te2JKzWqd48Ko7BhEdg8zthen3vFJmsmSG014Aaln
         f6pvHp2sE7QdpYTHElGdc7l5ZPRot/eRzB5CWnr5dJwcXTNZ1fFLVIQpf72BQWZ6WS
         NcgpkhUxokw5suvvhf36Y6d6Et+TyTEzwcaT9zoCw1W6IJ6xsQaBZyigVznuO0D6k4
         dpiTCcdvvcuOQ==
Subject: [PATCH 13/18] xfs: allow xfs_swap_range to use older extent swap
 algorithms
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:59 -0700
Message-ID: <161723939929.3149451.10970679280631570212.stgit@magnolia>
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

If userspace permits non-atomic swap operations, use the older code
paths to implement the same functionality.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |    4 +--
 fs/xfs/xfs_bmap_util.h |    4 +++
 fs/xfs/xfs_xchgrange.c |   66 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 66 insertions(+), 8 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 7cd6a6d5fb00..94f1d0d685fe 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1259,7 +1259,7 @@ xfs_insert_file_space(
  * reject and log the attempt. basically we are putting the responsibility on
  * userspace to get this right.
  */
-static int
+int
 xfs_swap_extents_check_format(
 	struct xfs_inode	*ip,	/* target inode */
 	struct xfs_inode	*tip)	/* tmp inode */
@@ -1401,7 +1401,7 @@ xfs_swap_change_owner(
 }
 
 /* Swap the extents of two files by swapping data forks. */
-STATIC int
+int
 xfs_swap_extent_forks(
 	struct xfs_trans	**tpp,
 	struct xfs_swapext_req	*req)
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 9f993168b55b..de3173e64f47 100644
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
index 877ef9f3eb64..ef74965198c6 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -259,6 +259,26 @@ xfs_swapext_enable_log_assist(
 	return error;
 }
 
+/* Decide if we can use the old data fork exchange code. */
+static inline bool
+xfs_xchg_use_forkswap(
+	const struct file_xchg_range	*fxr,
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2)
+{
+	return	(fxr->flags & FILE_XCHG_RANGE_NONATOMIC) &&
+		(fxr->flags & FILE_XCHG_RANGE_FULL_FILES) &&
+		!(fxr->flags & FILE_XCHG_RANGE_TO_EOF) &&
+		fxr->file1_offset == 0 && fxr->file2_offset == 0 &&
+		fxr->length == ip1->i_d.di_size &&
+		fxr->length == ip2->i_d.di_size;
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
@@ -279,12 +299,9 @@ xfs_xchg_range(
 	unsigned int			qretry;
 	bool				retried = false;
 	bool				use_atomic = false;
+	enum xchg_strategy		strategy;
 	int				error;
 
-	/* We don't support whole-fork swapping yet. */
-	if (!xfs_sb_version_canatomicswap(&mp->m_sb))
-		return -EOPNOTSUPP;
-
 	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
 		req.flags |= XFS_SWAPEXT_SET_SIZES;
 	if (fxr->flags & FILE_XCHG_RANGE_SKIP_FILE1_HOLES)
@@ -374,6 +391,41 @@ xfs_xchg_range(
 	if (error)
 		goto out_trans_cancel;
 
+	if (use_atomic || xfs_sb_version_hasreflink(&mp->m_sb) ||
+	    xfs_sb_version_hasrmapbt(&mp->m_sb)) {
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
@@ -395,8 +447,10 @@ xfs_xchg_range(
 		xfs_trans_ichgtime(tp, ip2,
 				XFS_ICHGTIME_MOD | XFS_ICHGTIME_CHG);
 
-	/* Exchange the file contents by swapping the block mappings. */
-	error = xfs_swapext(&tp, &req);
+	if (strategy == SWAPEXT)
+		error = xfs_swapext(&tp, &req);
+	else
+		error = xfs_swap_extent_forks(&tp, &req);
 	if (error)
 		goto out_trans_cancel;
 

