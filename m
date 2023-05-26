Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F0711C73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbjEZBTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbjEZBTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EF3195;
        Thu, 25 May 2023 18:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 773EB64ADA;
        Fri, 26 May 2023 01:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA75DC433D2;
        Fri, 26 May 2023 01:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063940;
        bh=37esDxlRbUjx0N8q3MK7osXMgM5iPyp0s7LzTVHvcEQ=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=WBhjVuerst6HgNnE5APXVVSwyayp6AxMuZhvZlCBS2T6fqVWrZwQWY3R35XQyrtKI
         P8ZNeGIfBjxhmgR5a5QXqkjcspsiqVfOhGVWTlWp556bevU+xA20AIR3M41GtJbnrC
         2dVm+Lj0hoU5C51h80uzWrkJq88oupWnVemavz/XRzKUf1Z4ZsIQatWAL+Sgp0qlkS
         E5QSnbQepXPfGklbDU6pQgx8AMntwVpFvYNjsrzOBtfoxa+rbo1ioYHwYtR2LoR4ue
         UBN6wpuZrfB3QAK4CxYLUgwJfWogXpOZt/N3osZD5A85DARKGkvMglkAxajvYryIEJ
         glOqLgztwBI1g==
Date:   Thu, 25 May 2023 18:19:01 -0700
Subject: [PATCH 17/25] xfs: port xfs_swap_extent_forks to use xfs_swapext_req
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065226.3734442.16423148944941847636.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 9007466e56e6..52f799b72021 100644
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

