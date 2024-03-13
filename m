Return-Path: <linux-fsdevel+bounces-14346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D987B0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BDD288E88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B175A0F8;
	Wed, 13 Mar 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgmwVkFu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08584D135;
	Wed, 13 Mar 2024 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352730; cv=none; b=trvbXlBu03ABDQC+NE8g8Z6l5mtij9szwSeq2hn6McXqLVCZStiAmP5AIVc2W+TOKDa1YldXdmCok/g6+OlUlLnoKyyUls+lXpxm2UIVrPevjGuhdj65I3Z+XS4/AkAUnZ5CErLSfI99MuLFbu0jZV+eVyoaUhvwqG4LvgnloY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352730; c=relaxed/simple;
	bh=DPAgxv3Q4uy9579uRuOaPirjLjDerwFfZUZuJEme2wU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCwBERRn4pcq95G33k0KXNPjkogfQAdrF5oA/7tycl+129dl7OyK97+kYZJv8kjG9k7jqFAVMGyCv0F5WFr2/mm1CzUZWGSUk017OSa7svJS0LG05yXE4bJqhF1jrLliCh9091iqTGZB2PZsFZXexvZPUbGxKpL/0yn6FUu32/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgmwVkFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D67C433F1;
	Wed, 13 Mar 2024 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352730;
	bh=DPAgxv3Q4uy9579uRuOaPirjLjDerwFfZUZuJEme2wU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fgmwVkFu2aZK/Goijdzlg7qFfTIm96tn+sxO9YZmhdZB5ebLgxm5uZQn10xN1N6f2
	 +mqPUa6aPhS4lLrHYivf9KaGOEmpJmXkHL+ExThJJmTsDsDrNTiWctlGw4GoA68I7C
	 0HITK6iuA2GjB+Y6J6wBbp7stmTwtMDMxTnQu3xe2sv9WKMdX0Px7lfXIIuDb16ZLB
	 uK2z1ZNPTU7qzUpINYHrzX0z4Vw+ztcIAPvCIOECzFWGWvhPyVNBWr9sp/U9Fsp0v6
	 /dPsnyZ/mT853j7H+OTum5ow2OjkHslpqlLyXjzRmNSOeyidkuveyVqvbxpvHx7k5L
	 Nc34MM4Ze31Cw==
Date: Wed, 13 Mar 2024 10:58:49 -0700
Subject: [PATCH 24/29] xfs: shrink verity blob cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223742.2613863.15483199528192039477.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
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
 fs/xfs/xfs_trace.h  |    1 +
 fs/xfs/xfs_verity.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)


diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 91a73399114e..37ea6822cca3 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -4797,6 +4797,7 @@ DEFINE_EVENT(xfs_verity_cache_class, name, \
 DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_load);
 DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_store);
 DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_drop);
+DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_reclaim);
 
 TRACE_EVENT(xfs_verity_shrinker_count,
 	TP_PROTO(struct xfs_mount *mp, unsigned long long count,
diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index 5d698383ed21..bb4ca8716c34 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -42,6 +42,9 @@ struct xfs_merkle_blob {
 	/* refcount of this item; the cache holds its own ref */
 	refcount_t		refcount;
 
+	/* number of times the shrinker should ignore this item */
+	atomic_t		shrinkref;
+
 	/* blob data, must be last! */
 	unsigned char		data[];
 };
@@ -97,8 +100,10 @@ xfs_verity_cache_drop(
 	struct xfs_inode	*ip)
 {
 	XA_STATE(xas, &ip->i_merkle_blocks, 0);
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_merkle_blob	*mk;
 	unsigned long		flags;
+	s64			freed = 0;
 
 	xas_lock_irqsave(&xas, flags);
 	xas_for_each(&xas, mk, ULONG_MAX) {
@@ -106,10 +111,13 @@ xfs_verity_cache_drop(
 
 		trace_xfs_verity_cache_drop(ip, xas.xa_index, _RET_IP_);
 
+		freed++;
 		xas_store(&xas, NULL);
 		xfs_merkle_blob_rele(mk);
 	}
+	percpu_counter_sub(&mp->m_verity_blocks, freed);
 	xas_unlock_irqrestore(&xas, flags);
+	xfs_inode_clear_verity_tag(ip);
 }
 
 /* Destroy the merkle tree block cache */
@@ -168,6 +176,7 @@ xfs_verity_cache_store(
 	unsigned long		key,
 	struct xfs_merkle_blob	*mk)
 {
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_merkle_blob	*old;
 	unsigned long		flags;
 
@@ -182,6 +191,8 @@ xfs_verity_cache_store(
 		old = __xa_cmpxchg(&ip->i_merkle_blocks, key, NULL, mk,
 				GFP_KERNEL);
 	} while (old && !refcount_inc_not_zero(&old->refcount));
+	if (!old)
+		percpu_counter_add(&mp->m_verity_blocks, 1);
 	xa_unlock_irqrestore(&ip->i_merkle_blocks, flags);
 
 	if (old == NULL) {
@@ -244,12 +255,73 @@ struct xfs_verity_scan {
 	unsigned long		freed;
 };
 
+/* Reclaim inactive merkle tree blocks that have run out of second chances. */
+static void
+xfs_verity_cache_reclaim(
+	struct xfs_inode	*ip,
+	struct xfs_verity_scan	*vs)
+{
+	XA_STATE(xas, &ip->i_merkle_blocks, 0);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_merkle_blob	*mk;
+	unsigned long		flags;
+	s64			freed = 0;
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
+		trace_xfs_verity_cache_reclaim(ip, xas.xa_index, _RET_IP_);
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
 xfs_verity_scan_inode(
 	struct xfs_inode	*ip,
 	struct xfs_icwalk	*icw)
 {
+	struct xfs_verity_scan	*vs;
+
+	vs = container_of(icw, struct xfs_verity_scan, icw);
+
+	if (vs->sc->nr_to_scan > 0)
+		xfs_verity_cache_reclaim(ip, vs);
+
+	if (vs->sc->nr_to_scan == 0)
+		xfs_icwalk_verity_stop(icw);
+
 	xfs_irele(ip);
 	return 0;
 }
@@ -522,6 +594,13 @@ xfs_verity_read_merkle(
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
 
 	/* We might have loaded this in from disk, fsverity must recheck */
@@ -530,6 +609,13 @@ xfs_verity_read_merkle(
 out_hit:
 	block->kaddr   = (void *)mk->data;
 	block->context = mk;
+
+	/*
+	 * Prioritize keeping the root-adjacent levels cached if this isn't a
+	 * streaming read.
+	 */
+	if (req->level >= 0)
+		atomic_set(&mk->shrinkref, req->level + 1);
 	return 0;
 
 out_new_mk:


