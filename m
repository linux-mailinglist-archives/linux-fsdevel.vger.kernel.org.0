Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5082D711C87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjEZB1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEZB1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:27:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81E4125;
        Thu, 25 May 2023 18:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6679560ADA;
        Fri, 26 May 2023 01:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE10C433D2;
        Fri, 26 May 2023 01:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685064434;
        bh=4hQj0uHhsgEH7t+v+Ra/MC2aHDG5Qefg5cpBVZ1uQIo=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=gFNFfkJQAYiQO9u6/dkLul3DjWxYbXqYt+jmcvbRyqoAkwiJQGKjWvcVBWt2b6LVC
         lGP3c+ud9XeYn/MimxG6c5oU2solT6azNQX8emvQXTlGf8+as5GPXbdkFO3BPhvYPM
         f/+9O3xdSd/Unk8s9BWTSRNbbFOqpISObr82xA1KJfYxZCg58lbKjpyrZ0mwaRHQuV
         K4IhJ8zfo+gWa/izKhoCY3whP44sUfGAPGOZVqXf/atakd4wavYLrZlPQfshcQHTuO
         9sMcltWY/qpVjj2+7lktRK4gbwzj92Qx7YJldRVdP+ss9jnQXosmUwRfPaKmvVaXJ5
         CvdU58+TPE8ZQ==
Date:   Thu, 25 May 2023 18:27:14 -0700
Subject: [PATCH 20/25] xfs: condense extended attributes after an atomic swap
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065270.3734442.5264834080869081518.stgit@frogsfrogsfrogs>
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

Add a new swapext flag that enables us to perform post-swap processing
on file2 once we're done swapping the extent maps.  If we were swapping
the extended attributes, we want to be able to convert file2's attr fork
from block to inline format.

This isn't used anywhere right now, but we need to have the basic ondisk
flags in place so that a future online xattr repair feature can create
salvaged attrs in a temporary file and swap the attr forks when ready.
If one file is in extents format and the other is inline, we will have to
promote both to extents format to perform the swap.  After the swap, we
can try to condense the fixed file's attr fork back down to inline
format if possible.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_log_format.h |    9 +++++--
 fs/xfs/libxfs/xfs_swapext.c    |   51 +++++++++++++++++++++++++++++++++++++++-
 fs/xfs/libxfs/xfs_swapext.h    |    9 +++++--
 3 files changed, 64 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 171f72e41225..c7d02bb04f41 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -909,18 +909,23 @@ struct xfs_swap_extent {
 /* Clear the reflink flag from inode2 after the operation. */
 #define XFS_SWAP_EXT_CLEAR_INO2_REFLINK	(1ULL << 4)
 
+/* Try to convert inode2 from block to short format at the end, if possible. */
+#define XFS_SWAP_EXT_CVT_INO2_SF	(1ULL << 5)
+
 #define XFS_SWAP_EXT_FLAGS		(XFS_SWAP_EXT_ATTR_FORK | \
 					 XFS_SWAP_EXT_SET_SIZES | \
 					 XFS_SWAP_EXT_INO1_WRITTEN | \
 					 XFS_SWAP_EXT_CLEAR_INO1_REFLINK | \
-					 XFS_SWAP_EXT_CLEAR_INO2_REFLINK)
+					 XFS_SWAP_EXT_CLEAR_INO2_REFLINK | \
+					 XFS_SWAP_EXT_CVT_INO2_SF)
 
 #define XFS_SWAP_EXT_STRINGS \
 	{ XFS_SWAP_EXT_ATTR_FORK,		"ATTRFORK" }, \
 	{ XFS_SWAP_EXT_SET_SIZES,		"SETSIZES" }, \
 	{ XFS_SWAP_EXT_INO1_WRITTEN,		"INO1_WRITTEN" }, \
 	{ XFS_SWAP_EXT_CLEAR_INO1_REFLINK,	"CLEAR_INO1_REFLINK" }, \
-	{ XFS_SWAP_EXT_CLEAR_INO2_REFLINK,	"CLEAR_INO2_REFLINK" }
+	{ XFS_SWAP_EXT_CLEAR_INO2_REFLINK,	"CLEAR_INO2_REFLINK" }, \
+	{ XFS_SWAP_EXT_CVT_INO2_SF,		"CVT_INO2_SF" }
 
 /* This is the structure used to lay out an sxi log item in the log. */
 struct xfs_sxi_log_format {
diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index 08c5f854edcd..61e66e3d96e3 100644
--- a/fs/xfs/libxfs/xfs_swapext.c
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -23,6 +23,10 @@
 #include "xfs_error.h"
 #include "xfs_errortag.h"
 #include "xfs_health.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include "xfs_attr_leaf.h"
+#include "xfs_attr.h"
 
 struct kmem_cache	*xfs_swapext_intent_cache;
 
@@ -121,7 +125,8 @@ static inline bool
 sxi_has_postop_work(const struct xfs_swapext_intent *sxi)
 {
 	return sxi->sxi_flags & (XFS_SWAP_EXT_CLEAR_INO1_REFLINK |
-				 XFS_SWAP_EXT_CLEAR_INO2_REFLINK);
+				 XFS_SWAP_EXT_CLEAR_INO2_REFLINK |
+				 XFS_SWAP_EXT_CVT_INO2_SF);
 }
 
 static inline void
@@ -369,6 +374,36 @@ xfs_swapext_exchange_mappings(
 	sxi_advance(sxi, irec1);
 }
 
+/* Convert inode2's leaf attr fork back to shortform, if possible.. */
+STATIC int
+xfs_swapext_attr_to_sf(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_da_args	args = {
+		.dp		= sxi->sxi_ip2,
+		.geo		= tp->t_mountp->m_attr_geo,
+		.whichfork	= XFS_ATTR_FORK,
+		.trans		= tp,
+	};
+	struct xfs_buf		*bp;
+	int			forkoff;
+	int			error;
+
+	if (!xfs_attr_is_leaf(sxi->sxi_ip2))
+		return 0;
+
+	error = xfs_attr3_leaf_read(tp, sxi->sxi_ip2, 0, &bp);
+	if (error)
+		return error;
+
+	forkoff = xfs_attr_shortform_allfit(bp, sxi->sxi_ip2);
+	if (forkoff == 0)
+		return 0;
+
+	return xfs_attr3_leaf_to_shortform(bp, &args, forkoff);
+}
+
 static inline void
 xfs_swapext_clear_reflink(
 	struct xfs_trans	*tp,
@@ -386,6 +421,16 @@ xfs_swapext_do_postop_work(
 	struct xfs_trans		*tp,
 	struct xfs_swapext_intent	*sxi)
 {
+	if (sxi->sxi_flags & XFS_SWAP_EXT_CVT_INO2_SF) {
+		int			error = 0;
+
+		if (sxi->sxi_flags & XFS_SWAP_EXT_ATTR_FORK)
+			error = xfs_swapext_attr_to_sf(tp, sxi);
+		sxi->sxi_flags &= ~XFS_SWAP_EXT_CVT_INO2_SF;
+		if (error)
+			return error;
+	}
+
 	if (sxi->sxi_flags & XFS_SWAP_EXT_CLEAR_INO1_REFLINK) {
 		xfs_swapext_clear_reflink(tp, sxi->sxi_ip1);
 		sxi->sxi_flags &= ~XFS_SWAP_EXT_CLEAR_INO1_REFLINK;
@@ -813,6 +858,8 @@ xfs_swapext_init_intent(
 
 	if (req->req_flags & XFS_SWAP_REQ_INO1_WRITTEN)
 		sxi->sxi_flags |= XFS_SWAP_EXT_INO1_WRITTEN;
+	if (req->req_flags & XFS_SWAP_REQ_CVT_INO2_SF)
+		sxi->sxi_flags |= XFS_SWAP_EXT_CVT_INO2_SF;
 
 	if (req->req_flags & XFS_SWAP_REQ_LOGGED)
 		sxi->sxi_op_flags |= XFS_SWAP_EXT_OP_LOGGED;
@@ -1032,6 +1079,8 @@ xfs_swapext(
 	ASSERT(!(req->req_flags & ~XFS_SWAP_REQ_FLAGS));
 	if (req->req_flags & XFS_SWAP_REQ_SET_SIZES)
 		ASSERT(req->whichfork == XFS_DATA_FORK);
+	if (req->req_flags & XFS_SWAP_REQ_CVT_INO2_SF)
+		ASSERT(req->whichfork == XFS_ATTR_FORK);
 
 	if (req->blockcount == 0)
 		return;
diff --git a/fs/xfs/libxfs/xfs_swapext.h b/fs/xfs/libxfs/xfs_swapext.h
index 7aa499537fd8..01e02c5d277f 100644
--- a/fs/xfs/libxfs/xfs_swapext.h
+++ b/fs/xfs/libxfs/xfs_swapext.h
@@ -129,16 +129,21 @@ struct xfs_swapext_req {
 /* Files need to be upgraded to have large extent counts. */
 #define XFS_SWAP_REQ_NREXT64		(1U << 3)
 
+/* Try to convert inode2's fork to local format, if possible. */
+#define XFS_SWAP_REQ_CVT_INO2_SF	(1U << 4)
+
 #define XFS_SWAP_REQ_FLAGS		(XFS_SWAP_REQ_LOGGED | \
 					 XFS_SWAP_REQ_SET_SIZES | \
 					 XFS_SWAP_REQ_INO1_WRITTEN | \
-					 XFS_SWAP_REQ_NREXT64)
+					 XFS_SWAP_REQ_NREXT64 | \
+					 XFS_SWAP_REQ_CVT_INO2_SF)
 
 #define XFS_SWAP_REQ_STRINGS \
 	{ XFS_SWAP_REQ_LOGGED,		"LOGGED" }, \
 	{ XFS_SWAP_REQ_SET_SIZES,	"SETSIZES" }, \
 	{ XFS_SWAP_REQ_INO1_WRITTEN,	"INO1_WRITTEN" }, \
-	{ XFS_SWAP_REQ_NREXT64,		"NREXT64" }
+	{ XFS_SWAP_REQ_NREXT64,		"NREXT64" }, \
+	{ XFS_SWAP_REQ_CVT_INO2_SF,	"CVT_INO2_SF" }
 
 unsigned int xfs_swapext_reflink_prep(const struct xfs_swapext_req *req);
 void xfs_swapext_reflink_finish(struct xfs_trans *tp,

