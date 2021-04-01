Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2203350BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhDABKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233058AbhDABKR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:10:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E1E361057;
        Thu,  1 Apr 2021 01:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239417;
        bh=EHexnMUPXVMA8P8+HRwyKDzp+u/zimj6uGvKXiZZDWg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WPxOBt4UG+nYD8DzQ2aoZcGBkq74YV5wyA0iixQDNvD+iJNb65tUW+mTKkI++Pvfz
         woesT1ot9oP2LTvww356i2JywbAkEebBBNA/NMRlY5LeRAszJyYPSN+jiNsoYSHWcb
         LvrKDf2SVvEWBmyWhqG3EQMm4U7+p9mZiuwA8Vt/pH9WztGnnnQmwZs0N+G0NVXa0I
         7tbb89h7sWid19fHt2kz7X5bkGtop5h6lAyMwCBmBwSEzijyH2MF3y3gp3aTJ/DK63
         e6br7tdZ5XM+iAqIJ1aCKaNg/EuGEkuUNJ/rBsmFZoYt/7lg+O6E2+1aIoIRXNv31/
         edM16yJXtKCWA==
Subject: [PATCH 16/18] xfs: condense directories after an atomic swap
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:10:16 -0700
Message-ID: <161723941629.3149451.10077250207225395498.stgit@magnolia>
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
 fs/xfs/libxfs/xfs_swapext.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index 964af61c9e5d..41042ee05e40 100644
--- a/fs/xfs/libxfs/xfs_swapext.c
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -25,6 +25,7 @@
 #include "xfs_da_format.h"
 #include "xfs_da_btree.h"
 #include "xfs_attr_leaf.h"
+#include "xfs_dir2_priv.h"
 
 /* Information to help us reset reflink flag / CoW fork state after a swap. */
 
@@ -232,6 +233,37 @@ xfs_swapext_attr_to_shortform2(
 /* Mask of all flags that require post-processing of file2. */
 #define XFS_SWAP_EXTENT_POST_PROCESSING (XFS_SWAP_EXTENT_INO2_SHORTFORM)
 
+/* Convert inode2's block dir fork back to shortform, if possible.. */
+STATIC int
+xfs_swapext_dir_to_shortform2(
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
+	int			size;
+	int			error;
+
+	if (!xfs_bmap_one_block(sxi->sxi_ip2, XFS_DATA_FORK))
+		return 0;
+
+	error = xfs_dir3_block_read(tp, sxi->sxi_ip2, &bp);
+	if (error)
+		return error;
+
+	size = xfs_dir2_block_sfsize(sxi->sxi_ip2, bp->b_addr, &sfh);
+	if (size > XFS_IFORK_DSIZE(sxi->sxi_ip2))
+		return 0;
+
+	return xfs_dir2_block_to_sf(&args, bp, size, &sfh);
+}
+
 /* Do we have more work to do to finish this operation? */
 bool
 xfs_swapext_has_more_work(
@@ -321,6 +353,8 @@ xfs_swapext_finish_one(
 		if (sxi->sxi_flags & XFS_SWAP_EXTENT_INO2_SHORTFORM) {
 			if (sxi->sxi_flags & XFS_SWAP_EXTENT_ATTR_FORK)
 				error = xfs_swapext_attr_to_shortform2(tp, sxi);
+			else if (S_ISDIR(VFS_I(sxi->sxi_ip2)->i_mode))
+				error = xfs_swapext_dir_to_shortform2(tp, sxi);
 			sxi->sxi_flags &= ~XFS_SWAP_EXTENT_INO2_SHORTFORM;
 			return error;
 		}

