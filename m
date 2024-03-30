Return-Path: <linux-fsdevel+bounces-15753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEDC892890
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823401C20BD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823561C17;
	Sat, 30 Mar 2024 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPnAgS+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429717D2;
	Sat, 30 Mar 2024 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760341; cv=none; b=EINWZFRMAkxRhEIUuqWk6NONDmCuJ7rpyYGYZdqEaIfa9FKXNYDKiakC5Zw14B+B1CSko/X8rfa0YZqoeCzuH/sEtWRq9reb64PGBY2x48qHU2FgljGaekdIxWH5iqmPUXc1YaBJjVNqmHWKeC70eqUxfcuiu5G05ExxbVjzY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760341; c=relaxed/simple;
	bh=2CbjXVVC7rH4fJ8nQfzjaRJ9KDsYqvhqemRwb7RGsa4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRcZecGremo+kudEZuIyLeuF79iKHgEmatY2ab3HaZNS3EtaBWpzs0hOolAwZrmOBdjU6ERiQrhBBSmDGvOfWpklsUj73YxlW9wvxuxQDpg7E10911/YumhJ8Y8cPJ1F4KsLfQwcBOXDjLq3eUt7D3dVdFYUFSGgrKSXh7f1Np8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPnAgS+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1A7C433C7;
	Sat, 30 Mar 2024 00:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711760341;
	bh=2CbjXVVC7rH4fJ8nQfzjaRJ9KDsYqvhqemRwb7RGsa4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XPnAgS+GXFAHH2C+w8SPokYgljeMhiPRkFvUb1m0IKyO9WfQqP3pduWvctQWKZjRU
	 D+MKYGLzd9YTxD1NxdGI2YODeGAOdj745Eqp0RcAWR8Q/UG2gQqGj63QEb4r4wSZcA
	 XzxbmdIqFK04OUQBtPZVSKsY8csTho2wHKFGB0N7bVRxcXpS9KXgR0N8en/vi8dT6g
	 9Jc5xlLThFHPUNZeKutOG3yDB9NdTFr+0X/EReobxPpdVxvQ6iNtc0ngahT2o8qB4L
	 ap4qqgooUw0DGYg/dHsh2mg0Jmq+By92pJsr/1CwXyazWV0Ve6F9UKc0/R0Kyj/Pnn
	 n3RcxjbcNCubA==
Date: Fri, 29 Mar 2024 17:59:00 -0700
Subject: [PATCH 08/14] xfs: condense extended attributes after a mapping
 exchange operation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <171176018810.2014991.1092873122982645197.stgit@frogsfrogsfrogs>
In-Reply-To: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
References: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
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

Add a new file mapping exchange flag that enables us to perform
post-exchange processing on file2 once we're done exchanging the extent
mappings.  If we were swapping mappings between extended attribute
forks, we want to be able to convert file2's attr fork from block to
inline format.

(This implies that all fork contents are exchanged.)

This isn't used anywhere right now, but we need to have the basic ondisk
flags in place so that a future online xattr repair feature can create
salvaged attrs in a temporary file and exchange the attr fork mappings
when ready.  If one file is in extents format and the other is inline,
we will have to promote both to extents format to perform the exchange.
After the exchange, we can try to condense the fixed file's attr fork
back down to inline format if possible.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_exchmaps.c |   53 ++++++++++++++++++++++++++++++++++++++++--
 fs/xfs/libxfs/xfs_exchmaps.h |    5 ++++
 fs/xfs/xfs_trace.h           |    3 ++
 3 files changed, 58 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index 7b51771f81968..a4578231ed3e3 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -24,6 +24,10 @@
 #include "xfs_errortag.h"
 #include "xfs_health.h"
 #include "xfs_exchmaps_item.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include "xfs_attr_leaf.h"
+#include "xfs_attr.h"
 
 struct kmem_cache	*xfs_exchmaps_intent_cache;
 
@@ -121,7 +125,8 @@ static inline bool
 xmi_has_postop_work(const struct xfs_exchmaps_intent *xmi)
 {
 	return xmi->xmi_flags & (XFS_EXCHMAPS_CLEAR_INO1_REFLINK |
-				 XFS_EXCHMAPS_CLEAR_INO2_REFLINK);
+				 XFS_EXCHMAPS_CLEAR_INO2_REFLINK |
+				 __XFS_EXCHMAPS_INO2_SHORTFORM);
 }
 
 /* Check all mappings to make sure we can actually exchange them. */
@@ -360,6 +365,36 @@ xfs_exchmaps_one_step(
 	xmi_advance(xmi, irec1);
 }
 
+/* Convert inode2's leaf attr fork back to shortform, if possible.. */
+STATIC int
+xfs_exchmaps_attr_to_sf(
+	struct xfs_trans		*tp,
+	struct xfs_exchmaps_intent	*xmi)
+{
+	struct xfs_da_args	args = {
+		.dp		= xmi->xmi_ip2,
+		.geo		= tp->t_mountp->m_attr_geo,
+		.whichfork	= XFS_ATTR_FORK,
+		.trans		= tp,
+	};
+	struct xfs_buf		*bp;
+	int			forkoff;
+	int			error;
+
+	if (!xfs_attr_is_leaf(xmi->xmi_ip2))
+		return 0;
+
+	error = xfs_attr3_leaf_read(tp, xmi->xmi_ip2, 0, &bp);
+	if (error)
+		return error;
+
+	forkoff = xfs_attr_shortform_allfit(bp, xmi->xmi_ip2);
+	if (forkoff == 0)
+		return 0;
+
+	return xfs_attr3_leaf_to_shortform(bp, &args, forkoff);
+}
+
 /* Clear the reflink flag after an exchange. */
 static inline void
 xfs_exchmaps_clear_reflink(
@@ -378,6 +413,16 @@ xfs_exchmaps_do_postop_work(
 	struct xfs_trans		*tp,
 	struct xfs_exchmaps_intent	*xmi)
 {
+	if (xmi->xmi_flags & __XFS_EXCHMAPS_INO2_SHORTFORM) {
+		int			error = 0;
+
+		if (xmi->xmi_flags & XFS_EXCHMAPS_ATTR_FORK)
+			error = xfs_exchmaps_attr_to_sf(tp, xmi);
+		xmi->xmi_flags &= ~__XFS_EXCHMAPS_INO2_SHORTFORM;
+		if (error)
+			return error;
+	}
+
 	if (xmi->xmi_flags & XFS_EXCHMAPS_CLEAR_INO1_REFLINK) {
 		xfs_exchmaps_clear_reflink(tp, xmi->xmi_ip1);
 		xmi->xmi_flags &= ~XFS_EXCHMAPS_CLEAR_INO1_REFLINK;
@@ -809,8 +854,10 @@ xfs_exchmaps_init_intent(
 	xmi->xmi_isize1 = xmi->xmi_isize2 = -1;
 	xmi->xmi_flags = req->flags & XFS_EXCHMAPS_PARAMS;
 
-	if (xfs_exchmaps_whichfork(xmi) == XFS_ATTR_FORK)
+	if (xfs_exchmaps_whichfork(xmi) == XFS_ATTR_FORK) {
+		xmi->xmi_flags |= __XFS_EXCHMAPS_INO2_SHORTFORM;
 		return xmi;
+	}
 
 	if (req->flags & XFS_EXCHMAPS_SET_SIZES) {
 		xmi->xmi_flags |= XFS_EXCHMAPS_SET_SIZES;
@@ -1031,6 +1078,8 @@ xfs_exchange_mappings(
 {
 	struct xfs_exchmaps_intent	*xmi;
 
+	BUILD_BUG_ON(XFS_EXCHMAPS_INTERNAL_FLAGS & XFS_EXCHMAPS_LOGGED_FLAGS);
+
 	xfs_assert_ilocked(req->ip1, XFS_ILOCK_EXCL);
 	xfs_assert_ilocked(req->ip2, XFS_ILOCK_EXCL);
 	ASSERT(!(req->flags & ~XFS_EXCHMAPS_LOGGED_FLAGS));
diff --git a/fs/xfs/libxfs/xfs_exchmaps.h b/fs/xfs/libxfs/xfs_exchmaps.h
index e8fc3f80c68c2..d8718fca606e5 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.h
+++ b/fs/xfs/libxfs/xfs_exchmaps.h
@@ -27,6 +27,11 @@ struct xfs_exchmaps_intent {
 	uint64_t		xmi_flags;	/* XFS_EXCHMAPS_* flags */
 };
 
+/* Try to convert inode2 from block to short format at the end, if possible. */
+#define __XFS_EXCHMAPS_INO2_SHORTFORM	(1ULL << 63)
+
+#define XFS_EXCHMAPS_INTERNAL_FLAGS	(__XFS_EXCHMAPS_INO2_SHORTFORM)
+
 /* flags that can be passed to xfs_exchmaps_{estimate,mappings} */
 #define XFS_EXCHMAPS_PARAMS		(XFS_EXCHMAPS_ATTR_FORK | \
 					 XFS_EXCHMAPS_SET_SIZES | \
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e18480109e08c..d688b9e5e08a6 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -4779,7 +4779,8 @@ DEFINE_XFBTREE_FREESP_EVENT(xfbtree_free_block);
 	{ XFS_EXCHMAPS_SET_SIZES,		"SETSIZES" }, \
 	{ XFS_EXCHMAPS_INO1_WRITTEN,		"INO1_WRITTEN" }, \
 	{ XFS_EXCHMAPS_CLEAR_INO1_REFLINK,	"CLEAR_INO1_REFLINK" }, \
-	{ XFS_EXCHMAPS_CLEAR_INO2_REFLINK,	"CLEAR_INO2_REFLINK" }
+	{ XFS_EXCHMAPS_CLEAR_INO2_REFLINK,	"CLEAR_INO2_REFLINK" }, \
+	{ __XFS_EXCHMAPS_INO2_SHORTFORM,	"INO2_SF" }
 
 DEFINE_INODE_IREC_EVENT(xfs_exchmaps_mapping1_skip);
 DEFINE_INODE_IREC_EVENT(xfs_exchmaps_mapping1);


