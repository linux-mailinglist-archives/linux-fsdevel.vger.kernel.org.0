Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B79350BA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhDABKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233015AbhDABJz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6C3761059;
        Thu,  1 Apr 2021 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239394;
        bh=kGuTKMRoOtBJmS6w3RxU6UOKAxuYkkteYS0JlY5ZRG8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WgXAj5IhQVvwY98Rt0c7Sk+d3sDRJdp1Hq/xWLO5p+2S8bBCRi2+h33SMj6QLvKsj
         Vg+VC7Z+vg5C9efr0vGNi2yOjdwjuZA9q344uFgTlNvwRvrp0Nwkoae3cIqLVXsgL1
         apL9C1AKsyKF3cnrFAJ92jyp5s5qiQUhLoc6BnC+fctIoIGYBTaq6sbebcHrjPQKO2
         QPs8/IT5AMSH+kup9I9vXPebK6DfzhSumFZm3HR27g//x02GujqjcVkkdCOgZx4WxF
         sQ6vXZdOTQA+Mmia/8bbCxshoKw+wpI7POPEyejSs0TyaL/5f7ndajummV6k0s+wRv
         weEbqLBg87oQg==
Subject: [PATCH 12/18] xfs: refactor reflink flag handling in
 xfs_swap_extent_forks
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:53 -0700
Message-ID: <161723939377.3149451.9062940592016276415.stgit@magnolia>
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

Refactor the old data fork swap function to use the new reflink flag
helpers to propagate reflink flags between the two files.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |   58 +++++++++++++-----------------------------------
 1 file changed, 16 insertions(+), 42 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index bff8725082e8..7cd6a6d5fb00 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1404,17 +1404,21 @@ xfs_swap_change_owner(
 STATIC int
 xfs_swap_extent_forks(
 	struct xfs_trans	**tpp,
-	struct xfs_inode	*ip,
-	struct xfs_inode	*tip)
+	struct xfs_swapext_req	*req)
 {
+	struct xfs_inode	*ip = req->ip1;
+	struct xfs_inode	*tip = req->ip2;
 	xfs_filblks_t		aforkblks = 0;
 	xfs_filblks_t		taforkblks = 0;
 	xfs_extnum_t		junk;
 	uint64_t		tmp;
+	unsigned int		reflink_state;
 	int			src_log_flags = XFS_ILOG_CORE;
 	int			target_log_flags = XFS_ILOG_CORE;
 	int			error;
 
+	reflink_state = xfs_swapext_reflink_prep(req);
+
 	/*
 	 * Count the number of extended attribute blocks
 	 */
@@ -1494,36 +1498,7 @@ xfs_swap_extent_forks(
 		break;
 	}
 
-	/* Do we have to swap reflink flags? */
-	if ((ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK) ^
-	    (tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK)) {
-		uint64_t	f;
-
-		f = ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
-		ip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
-		ip->i_d.di_flags2 |= tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
-		tip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
-		tip->i_d.di_flags2 |= f & XFS_DIFLAG2_REFLINK;
-	}
-
-	/* Swap the cow forks. */
-	if (xfs_sb_version_hasreflink(&ip->i_mount->m_sb)) {
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
+	xfs_swapext_reflink_finish(*tpp, req, reflink_state);
 
 	xfs_trans_log_inode(*tpp, ip,  src_log_flags);
 	xfs_trans_log_inode(*tpp, tip, target_log_flags);
@@ -1554,6 +1529,11 @@ xfs_swap_extents(
 	struct xfs_inode	*tip,	/* tmp inode */
 	struct xfs_swapext	*sxp)
 {
+	struct xfs_swapext_req	req = {
+		.ip1		= ip,
+		.ip2		= tip,
+		.whichfork	= XFS_DATA_FORK,
+	};
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_bstat	*sbp = &sxp->sx_stat;
@@ -1689,17 +1669,11 @@ xfs_swap_extents(
 	 * recovery is going to see the fork as owned by the swapped inode,
 	 * not the pre-swapped inodes.
 	 */
-	if (xfs_sb_version_hasrmapbt(&mp->m_sb)) {
-		struct xfs_swapext_req	req = {
-			.ip1		= ip,
-			.ip2		= tip,
-			.whichfork	= XFS_DATA_FORK,
-			.blockcount	= XFS_B_TO_FSB(ip->i_mount,
-						       i_size_read(VFS_I(ip))),
-		};
+	req.blockcount = XFS_B_TO_FSB(ip->i_mount, i_size_read(VFS_I(ip)));
+	if (xfs_sb_version_hasrmapbt(&mp->m_sb))
 		error = xfs_swapext(&tp, &req);
-	} else
-		error = xfs_swap_extent_forks(&tp, ip, tip);
+	else
+		error = xfs_swap_extent_forks(&tp, &req);
 	if (error) {
 		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
 		goto out_trans_cancel;

