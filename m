Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8F659EFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiL3Xyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiL3Xyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:54:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05DB1E3D3;
        Fri, 30 Dec 2022 15:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E96461C5B;
        Fri, 30 Dec 2022 23:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5EDC433D2;
        Fri, 30 Dec 2022 23:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444473;
        bh=Us/J2beDbg7zaJmu/2DSsuF/lnWPPWk8P86/YJdCKYE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MQ/ZzJ4gA741tuxb4WrqZ1rqBehyN4kLiNpUGLCmfIUY/AiLhh9o4TnEGlKuX0Z48
         DcRz/LMqrBJ7essq/zyAZRsXO730WHN5P9/oXOZ3Iz5WvRjPbWaGOBV2q01RRCaUiH
         w/dz+HaLQh7XjL8KYXMohbSErVprl8n0hIS3eXjbD4RZDkvixSSbbWu68JCmzmL825
         Jn6W43okbGSvwe91y++f5AAaYU39QH+eIYl9R700mNxJXLUU5pdT3EptqEnUFMmPxQ
         n8/XOp1TGsKd6lgfHF6y+045wE3eipMC4sLUSpbNJIA3RQ8PUBgRWD6A2Yu0a2LQkX
         UDS5SOgy3j1KQ==
Subject: [PATCH 17/21] xfs: condense directories after an atomic swap
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:57 -0800
Message-ID: <167243843771.699466.8963465782484534140.stgit@magnolia>
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

The previous commit added a new swapext flag that enables us to perform
post-swap processing on file2 once we're done swapping the extent maps.
Now add this ability for directories.

This isn't used anywhere right now, but we need to have the basic ondisk
flags in place so that a future online directory repair feature can
create salvaged dirents in a temporary directory and swap the data forks
when ready.  If one file is in extents format and the other is inline,
we will have to promote both to extents format to perform the swap.
After the swap, we can try to condense the fixed directory down to
inline format if possible.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_swapext.c |   44 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index 6b5223e73692..a52f72a499f4 100644
--- a/fs/xfs/libxfs/xfs_swapext.c
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -27,6 +27,8 @@
 #include "xfs_da_btree.h"
 #include "xfs_attr_leaf.h"
 #include "xfs_attr.h"
+#include "xfs_dir2_priv.h"
+#include "xfs_dir2.h"
 
 struct kmem_cache	*xfs_swapext_intent_cache;
 
@@ -385,6 +387,42 @@ xfs_swapext_attr_to_sf(
 	return xfs_attr3_leaf_to_shortform(bp, &args, forkoff);
 }
 
+/* Convert inode2's block dir fork back to shortform, if possible.. */
+STATIC int
+xfs_swapext_dir_to_sf(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_da_args	args = {
+		.dp		= sxi->sxi_ip2,
+		.geo		= tp->t_mountp->m_dir_geo,
+		.whichfork	= XFS_DATA_FORK,
+		.trans		= tp,
+	};
+	struct xfs_dir2_sf_hdr	sfh;
+	struct xfs_buf		*bp;
+	bool			isblock;
+	int			size;
+	int			error;
+
+	error = xfs_dir2_isblock(&args, &isblock);
+	if (error)
+		return error;
+
+	if (!isblock)
+		return 0;
+
+	error = xfs_dir3_block_read(tp, sxi->sxi_ip2, &bp);
+	if (error)
+		return error;
+
+	size = xfs_dir2_block_sfsize(sxi->sxi_ip2, bp->b_addr, &sfh);
+	if (size > xfs_inode_data_fork_size(sxi->sxi_ip2))
+		return 0;
+
+	return xfs_dir2_block_to_sf(&args, bp, size, &sfh);
+}
+
 static inline void
 xfs_swapext_clear_reflink(
 	struct xfs_trans	*tp,
@@ -407,6 +445,8 @@ xfs_swapext_do_postop_work(
 
 		if (sxi->sxi_flags & XFS_SWAP_EXT_ATTR_FORK)
 			error = xfs_swapext_attr_to_sf(tp, sxi);
+		else if (S_ISDIR(VFS_I(sxi->sxi_ip2)->i_mode))
+			error = xfs_swapext_dir_to_sf(tp, sxi);
 		sxi->sxi_flags &= ~XFS_SWAP_EXT_CVT_INO2_SF;
 		if (error)
 			return error;
@@ -1061,7 +1101,9 @@ xfs_swapext(
 	if (req->req_flags & XFS_SWAP_REQ_SET_SIZES)
 		ASSERT(req->whichfork == XFS_DATA_FORK);
 	if (req->req_flags & XFS_SWAP_REQ_CVT_INO2_SF)
-		ASSERT(req->whichfork == XFS_ATTR_FORK);
+		ASSERT(req->whichfork == XFS_ATTR_FORK ||
+		       (req->whichfork == XFS_DATA_FORK &&
+			S_ISDIR(VFS_I(req->ip2)->i_mode)));
 
 	if (req->blockcount == 0)
 		return;

