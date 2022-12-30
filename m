Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B47659EF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiL3Xxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiL3Xxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:53:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E9E1E3C3;
        Fri, 30 Dec 2022 15:53:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFA09B81DE0;
        Fri, 30 Dec 2022 23:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3CEC43392;
        Fri, 30 Dec 2022 23:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444411;
        bh=Rl5SwoFy18xfolYMtYCB6aH9T6OJCaLqHEoNpxvqv8Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P0/wxArwOglTj3cMbDqwQs4+uAD/BAdx9r/wr4iwX+5LxP4BCZ+MBngjy0yn78B70
         rNnrnjYwiIHCBUIP5BM7hs+CDtoqq6bvA+h9pXMh6VlPAU7CXWqN+1iN5P4P42tqAw
         OW1RWzchfO1LWaQ91m7lAzDK0N4o7oaaN2Lq2HIChvHy33so6RbOtGbmhOrZJcVy96
         AIKAbj3VoEWWRlOZTo+XiCJ5WBCA2A0iDT9Ti4RX5wPfcx2ZwcIliY4zctoqSGOXdn
         Wxr/wsqnfsOIJXTvt4m4fnk1B8khCmFUVDKShwurLngWSh7k2Myxz8WSX1Otxeq+yn
         RYFxapMi4lxdA==
Subject: [PATCH 13/21] xfs: port xfs_swap_extent_forks to use xfs_swapext_req
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:57 -0800
Message-ID: <167243843712.699466.14764003951903637803.stgit@magnolia>
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

Port the old extent fork swapping function to take a xfs_swapext_req as
input, which aligns it with the new fiexchange interface.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index dbd95d86addb..9d6337a05544 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1406,9 +1406,10 @@ xfs_swap_change_owner(
 STATIC int
 xfs_swap_extent_forks(
 	struct xfs_trans	**tpp,
-	struct xfs_inode	*ip,
-	struct xfs_inode	*tip)
+	struct xfs_swapext_req	*req)
 {
+	struct xfs_inode	*ip = req->ip2;
+	struct xfs_inode	*tip = req->ip1;
 	xfs_filblks_t		aforkblks = 0;
 	xfs_filblks_t		taforkblks = 0;
 	xfs_extnum_t		junk;
@@ -1556,6 +1557,11 @@ xfs_swap_extents(
 	struct xfs_inode	*tip,	/* tmp inode */
 	struct xfs_swapext	*sxp)
 {
+	struct xfs_swapext_req	req = {
+		.ip1		= tip,
+		.ip2		= ip,
+		.whichfork	= XFS_DATA_FORK,
+	};
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_bstat	*sbp = &sxp->sx_stat;
@@ -1689,19 +1695,12 @@ xfs_swap_extents(
 	 * recovery is going to see the fork as owned by the swapped inode,
 	 * not the pre-swapped inodes.
 	 */
+	req.blockcount = XFS_B_TO_FSB(ip->i_mount, i_size_read(VFS_I(ip)));
 	if (xfs_has_rmapbt(mp)) {
-		struct xfs_swapext_req	req = {
-			.ip1		= tip,
-			.ip2		= ip,
-			.whichfork	= XFS_DATA_FORK,
-			.blockcount	= XFS_B_TO_FSB(ip->i_mount,
-						       i_size_read(VFS_I(ip))),
-		};
-
 		xfs_swapext(tp, &req);
 		error = xfs_defer_finish(&tp);
 	} else
-		error = xfs_swap_extent_forks(&tp, ip, tip);
+		error = xfs_swap_extent_forks(&tp, &req);
 	if (error) {
 		trace_xfs_swap_extent_error(ip, error, _THIS_IP_);
 		goto out_trans_cancel;

