Return-Path: <linux-fsdevel+bounces-16993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DCA8A5E9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D5F28505B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867EE159593;
	Mon, 15 Apr 2024 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyO3B7jw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E91591FB;
	Mon, 15 Apr 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224590; cv=none; b=kI77v56c5FEcJrbGOa14/wqZ0+fw+bZLggZimkInWnFQ2kFEm4k9wHMC+GJ48m3Dj5DXJw9XkgbjWylrlcSxtt0+5Vu3PdtettDUzMZa4dXB1YJ+0artkbxjV9zU+6lVpGBbs6Sk2yAEQdwAamRUr/GZZIimmjzYkkJay/ha17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224590; c=relaxed/simple;
	bh=RBuZK/MPNTI9Rc9yJg8B3pzXKrbgX4/aD/+3kjJySLw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVIwi/oBiJy1OjRa4v2oGH1wBHkN8BksNuPTos9RnKE0sjF1InOauubPDF49Bl4Q6D4SxPOwglIjtpsEiF7ulcAe7G4Wqiv7lTxvAQOzMEhracgBuQSDaRb37/NUaFUQOMd21C22Ki53a79cD/paqnlRwZLP/BGPrhm3lwUHaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyO3B7jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E00C113CC;
	Mon, 15 Apr 2024 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224589;
	bh=RBuZK/MPNTI9Rc9yJg8B3pzXKrbgX4/aD/+3kjJySLw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cyO3B7jwo+2VQUOCLc3Fyytro1MbOrF1ELc/+ZJfA+K3GXUvvfmvguEfEO39bqGMK
	 onZTbq7L5ZNX50k3Az0f4Cc4Uh5vwXYKTjligiORX18L6dSaaGV26kk7XBzjnXy/l7
	 u47efsSVPh93fbKiKl4OX7qDmuU9BXujjFAefzCkxIkCzg6xKEV0CHOHGMJ6KNAox5
	 wusUSH5UIfbvBNB/UFTQgE3l5b+GxNBMXgfb6U9auME2ceJEHBOzGyfvI/tt9aluXj
	 rLT94U5jBvnt3Q54cezT5IL9UcvGtYCQihqRHi3OTYNwVNM+3aRhMzYp6yMXFu2YTn
	 Cg7LC6kjH/p2A==
Date: Mon, 15 Apr 2024 16:43:08 -0700
Subject: [PATCH 09/15] xfs: condense directories after a mapping exchange
 operation
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322381374.87355.12051184717672831777.stgit@frogsfrogsfrogs>
In-Reply-To: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
References: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The previous commit added a new file mapping exchange flag that enables
us to perform post-swap processing on file2 once we're done exchanging
extent mappings.  Now add this ability for directories.

This isn't used anywhere right now, but we need to have the basic ondisk
flags in place so that a future online directory repair feature can
create salvaged dirents in a temporary directory and exchange the data
fork mappings when ready.  If one file is in extents format and the
other is inline, we will have to promote both to extents format to
perform the exchange.  After the exchange, we can try to condense the
fixed directory down to inline format if possible.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_exchmaps.c |   43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index e46b314fa0cf..f199629adbf0 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -28,6 +28,8 @@
 #include "xfs_da_btree.h"
 #include "xfs_attr_leaf.h"
 #include "xfs_attr.h"
+#include "xfs_dir2_priv.h"
+#include "xfs_dir2.h"
 
 struct kmem_cache	*xfs_exchmaps_intent_cache;
 
@@ -395,6 +397,42 @@ xfs_exchmaps_attr_to_sf(
 	return xfs_attr3_leaf_to_shortform(bp, &args, forkoff);
 }
 
+/* Convert inode2's block dir fork back to shortform, if possible.. */
+STATIC int
+xfs_exchmaps_dir_to_sf(
+	struct xfs_trans		*tp,
+	struct xfs_exchmaps_intent	*xmi)
+{
+	struct xfs_da_args	args = {
+		.dp		= xmi->xmi_ip2,
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
+	error = xfs_dir3_block_read(tp, xmi->xmi_ip2, &bp);
+	if (error)
+		return error;
+
+	size = xfs_dir2_block_sfsize(xmi->xmi_ip2, bp->b_addr, &sfh);
+	if (size > xfs_inode_data_fork_size(xmi->xmi_ip2))
+		return 0;
+
+	return xfs_dir2_block_to_sf(&args, bp, size, &sfh);
+}
+
 /* Clear the reflink flag after an exchange. */
 static inline void
 xfs_exchmaps_clear_reflink(
@@ -418,6 +456,8 @@ xfs_exchmaps_do_postop_work(
 
 		if (xmi->xmi_flags & XFS_EXCHMAPS_ATTR_FORK)
 			error = xfs_exchmaps_attr_to_sf(tp, xmi);
+		else if (S_ISDIR(VFS_I(xmi->xmi_ip2)->i_mode))
+			error = xfs_exchmaps_dir_to_sf(tp, xmi);
 		xmi->xmi_flags &= ~__XFS_EXCHMAPS_INO2_SHORTFORM;
 		if (error)
 			return error;
@@ -882,6 +922,9 @@ xfs_exchmaps_init_intent(
 			xmi->xmi_flags |= XFS_EXCHMAPS_CLEAR_INO2_REFLINK;
 	}
 
+	if (S_ISDIR(VFS_I(xmi->xmi_ip2)->i_mode))
+		xmi->xmi_flags |= __XFS_EXCHMAPS_INO2_SHORTFORM;
+
 	return xmi;
 }
 


