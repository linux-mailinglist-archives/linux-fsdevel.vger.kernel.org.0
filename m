Return-Path: <linux-fsdevel+bounces-15731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2D589285B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337CF1C20EFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51AD1366;
	Sat, 30 Mar 2024 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY12tj5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A467E2;
	Sat, 30 Mar 2024 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759215; cv=none; b=Tm1XBoSFJn6NoSAH9xTvFgi7D1lNq/hK6BuNHPOZy5om5TUltM4rEOhrp8qou+2EiHNNIOi2C3lqxtavg2z0sN/OcAe7wkPl2B1hf7V3JayVF82eNN8AYG6Qdwx2J9ma3ldFaLhimc0FvLnPmdLmF3K2zIkDI+XUVky3hp7jnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759215; c=relaxed/simple;
	bh=jhBGgMiZxMGiPOzCnb+cKyYOOq0sqOQyHzh3z2sEXz8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kj2IvZ9HPGhtiMQtGKUqUbF08srUZ2MvG7BA294ZV2d/9OEXGMv9YaD1f0rpdl3bbe/M8H+S5jETrqjMMNEBXzAjzGGyaZfLd8jWlxZfenCeyoexjXSkg7tX+eYXwRcxw8pL80YPGRe3BgdlUSNFCcLwvz5DysmB8x8hgWkQcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY12tj5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDBCC433F1;
	Sat, 30 Mar 2024 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759214;
	bh=jhBGgMiZxMGiPOzCnb+cKyYOOq0sqOQyHzh3z2sEXz8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fY12tj5+iaRDJCPBazLKzRe1JgNQKEKhiCFa061MkvOzPTmsQk8tyTkgG/h/SDBu4
	 5X3vIQHVicCE9v8MxbGttjjerIyBk9H3P0gedFc6Dpx5JXtBNKPXZjCGyngZAI3IZd
	 Xesws/6R3eGbgAPOJKP5iaYVD3RtvfW6Pfn4ppgmY54gThJYA9upuIbyn6GQjr55zw
	 E9bN4CenP3c7UDkhrYK3zemXtsMDuFpbT/ZvHW3CDmQrFiMeLMXPjt9mABT5LwSItw
	 T1LXsWHkHrrrjIFO1SP6RyMe1aVf4Cp+MCJcUs07JWsatEeYsP5TqiE8MvEBfsbiLM
	 cgzPZ40iyFEjA==
Date: Fri, 29 Mar 2024 17:40:14 -0700
Subject: [PATCH 16/29] xfs: shrink verity blob cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868826.1988170.6498728857662092789.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
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

Add some shrinkers so that reclaim can free cached merkle tree blocks
when memory is tight.  We add a shrinkref variable to bias reclaim
against freeing the upper levels of the merkle tree in the hope of
maintaining read performance.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_fsverity.c |   91 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_trace.h    |    1 +
 2 files changed, 90 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 37876ce612540..d675b0f71bde5 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -44,6 +44,9 @@ struct xfs_merkle_blob {
 	/* refcount of this item; the cache holds its own ref */
 	refcount_t		refcount;
 
+	/* number of times the shrinker should ignore this item */
+	atomic_t		shrinkref;
+
 	unsigned long		flags;
 
 	/* Pointer to the merkle tree block, which is power-of-2 sized */
@@ -74,6 +77,7 @@ xfs_merkle_blob_alloc(
 
 	/* Caller owns this refcount. */
 	refcount_set(&mk->refcount, 1);
+	atomic_set(&mk->shrinkref, 0);
 	mk->flags = 0;
 	return mk;
 }
@@ -106,8 +110,10 @@ xfs_fsverity_cache_drop(
 	struct xfs_inode	*ip)
 {
 	XA_STATE(xas, &ip->i_merkle_blocks, 0);
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_merkle_blob	*mk;
 	unsigned long		flags;
+	s64			freed = 0;
 
 	xas_lock_irqsave(&xas, flags);
 	xas_for_each(&xas, mk, ULONG_MAX) {
@@ -115,10 +121,13 @@ xfs_fsverity_cache_drop(
 
 		trace_xfs_fsverity_cache_drop(ip, xas.xa_index, _RET_IP_);
 
+		freed++;
 		xas_store(&xas, NULL);
 		xfs_merkle_blob_rele(mk);
 	}
+	percpu_counter_sub(&mp->m_verity_blocks, freed);
 	xas_unlock_irqrestore(&xas, flags);
+	xfs_inode_clear_verity_tag(ip);
 }
 
 /* Destroy the merkle tree block cache */
@@ -177,6 +186,7 @@ xfs_fsverity_cache_store(
 	unsigned long		key,
 	struct xfs_merkle_blob	*mk)
 {
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_merkle_blob	*old;
 	unsigned long		flags;
 
@@ -191,6 +201,8 @@ xfs_fsverity_cache_store(
 		old = __xa_cmpxchg(&ip->i_merkle_blocks, key, NULL, mk,
 				GFP_KERNEL);
 	} while (old && !refcount_inc_not_zero(&old->refcount));
+	if (!old)
+		percpu_counter_add(&mp->m_verity_blocks, 1);
 	xa_unlock_irqrestore(&ip->i_merkle_blocks, flags);
 
 	if (old == NULL) {
@@ -303,12 +315,73 @@ struct xfs_fsverity_scan {
 	unsigned long		freed;
 };
 
+/* Reclaim inactive merkle tree blocks that have run out of second chances. */
+static void
+xfs_fsverity_cache_reclaim(
+	struct xfs_inode		*ip,
+	struct xfs_fsverity_scan	*vs)
+{
+	XA_STATE(xas, &ip->i_merkle_blocks, 0);
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_merkle_blob		*mk;
+	unsigned long			flags;
+	s64				freed = 0;
+
+	xas_lock_irqsave(&xas, flags);
+	xas_for_each(&xas, mk, ULONG_MAX) {
+		/*
+		 * Tell the shrinker that we scanned this merkle tree block,
+		 * even if we don't remove it.
+		 */
+		vs->scanned++;
+		if (vs->sc->nr_to_scan-- == 0)
+			break;
+
+		/* Retain if there are active references */
+		if (refcount_read(&mk->refcount) > 1)
+			continue;
+
+		/* Ignore if the item still has lru refcount */
+		if (atomic_add_unless(&mk->shrinkref, -1, 0))
+			continue;
+
+		trace_xfs_fsverity_cache_reclaim(ip, xas.xa_index, _RET_IP_);
+
+		freed++;
+		xas_store(&xas, NULL);
+		xfs_merkle_blob_rele(mk);
+	}
+	percpu_counter_sub(&mp->m_verity_blocks, freed);
+	xas_unlock_irqrestore(&xas, flags);
+
+	/*
+	 * Try to clear the verity tree tag if we reclaimed all the cached
+	 * blocks.  On the flag setting side, we should have IOLOCK_SHARED.
+	 */
+	xfs_ilock(ip, XFS_IOLOCK_EXCL);
+	if (xa_empty(&ip->i_merkle_blocks))
+		xfs_inode_clear_verity_tag(ip);
+	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
+
+	vs->freed += freed;
+}
+
 /* Scan an inode as part of a verity scan. */
 int
 xfs_fsverity_scan_inode(
-	struct xfs_inode	*ip,
-	struct xfs_icwalk	*icw)
+	struct xfs_inode		*ip,
+	struct xfs_icwalk		*icw)
 {
+	struct xfs_fsverity_scan	*vs;
+
+	vs = container_of(icw, struct xfs_fsverity_scan, icw);
+
+	if (vs->sc->nr_to_scan > 0)
+		xfs_fsverity_cache_reclaim(ip, vs);
+
+	if (vs->sc->nr_to_scan == 0)
+		xfs_icwalk_verity_stop(icw);
+
 	xfs_irele(ip);
 	return 0;
 }
@@ -606,6 +679,13 @@ xfs_fsverity_read_merkle(
 		 * Free the new cache blob and continue with the existing one.
 		 */
 		xfs_merkle_blob_rele(new_mk);
+	} else {
+		/*
+		 * We added this merkle tree block to the cache; tag the inode
+		 * so that reclaim will scan this inode.  The caller holds
+		 * IOLOCK_SHARED this will not race with the shrinker.
+		 */
+		xfs_inode_set_verity_tag(ip);
 	}
 
 out_hit:
@@ -613,6 +693,13 @@ xfs_fsverity_read_merkle(
 	block->context = mk;
 	block->verified = test_bit(XFS_MERKLE_BLOB_VERIFIED_BIT, &mk->flags);
 
+	/*
+	 * Prioritize keeping the root-adjacent levels cached if this isn't a
+	 * streaming read.
+	 */
+	if (req->level >= 0)
+		atomic_set(&mk->shrinkref, req->level + 1);
+
 	return 0;
 
 out_new_mk:
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index a5b811c1731d7..ac7201a24b107 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -5938,6 +5938,7 @@ DEFINE_EVENT(xfs_fsverity_cache_class, name, \
 DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_load);
 DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_store);
 DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_drop);
+DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_reclaim);
 
 TRACE_EVENT(xfs_fsverity_shrinker_count,
 	TP_PROTO(struct xfs_mount *mp, unsigned long long count,


