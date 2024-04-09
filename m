Return-Path: <linux-fsdevel+bounces-16399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90E89D12A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC661C23FA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EFD54FA0;
	Tue,  9 Apr 2024 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDQOmEfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53254902;
	Tue,  9 Apr 2024 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633796; cv=none; b=Mwokv6o+xRCIhSNfuAPfZ6PvM2RbS8RqySo0bExfz1wTUdKoRsxKVOgpkn0I+Ybs8aQykaf3YX5bIE56JCfi2JlKJh355+VyoEGGPlUoIYMErtYditZqk7qX6r509GhgErm2JeAhoK1JE5UhnJJeDEg41L9lyvqgdL95ah2b0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633796; c=relaxed/simple;
	bh=h5RMsKEZgtG2EP++EsUF/zmE8sUswM3CNX/6LRourIc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrlEseS8MYhTpnmE4Rl5bX0Vmgs0sm5SB8dDDoWA9FXoRtJV76ocmuLLVnnc2p96W/+GZ57531OfQRp17h+uT2NtG+5T07wtsUF8/Zz3ZpKXRdoPQ5HX5+NPcfFy64GSxrrkvqIygb4JJI1Klpe0jw3fmm2RjzCnLfewCHuoI5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDQOmEfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AB3C433C7;
	Tue,  9 Apr 2024 03:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633796;
	bh=h5RMsKEZgtG2EP++EsUF/zmE8sUswM3CNX/6LRourIc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TDQOmEfWmVB8KjR98WAdFKH+7sqd0EHxa8e8+jqRpRBTxdQ/nQmSZZnp9dHwiEfpi
	 dc3BTMa+cJP+auVN2gV4R5PBl2boqY9z4+vSderWiDmKUHopCfv2ZK4J2DrANci5Ux
	 araxgW6tKrxeJGcyh2UAHHwLDyAm+CijeoGyDuMDmj4Ctjp1cOxPtvkKXDcS9UH5ty
	 OPWoL2ozL1/O3cywxAAXQtLGlM/bv4eWRkeoJ5YtNcPgK5WR7YTrTqXUkpesbhs0GT
	 JBcy7sqaRewgP+DORJ0J4Vcqo7HDH5qZJvvd1eMR1p9uPcdRlCYO3IXGpPBfBty6y2
	 GxTag8LQGmkkw==
Date: Mon, 08 Apr 2024 20:36:35 -0700
Subject: [PATCH 08/14] xfs: condense extended attributes after a mapping
 exchange operation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171263348596.2978056.13179580730997975563.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
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
index 3b1f29e95fea6..e46b314fa0cfd 100644
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


