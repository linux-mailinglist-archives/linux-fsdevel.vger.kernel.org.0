Return-Path: <linux-fsdevel+bounces-14606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3B87DE9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA10281026
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98F84C84;
	Sun, 17 Mar 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc66V4Gp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C931B949;
	Sun, 17 Mar 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693058; cv=none; b=Bl0RuwfLrK/YSf9laVbjIpeQ+6f7LJNrbsbJS9N+bszKCfvnQ45klq0I30vdAly9vs7gC2eX+A+B06IEM8ZLnmIetPwA2XhzSHbdhqM5k+8bCIcnTN61pV2HS9JLBlL5C/aVKWaj0NbRPH7/n+3wxjM+5rqOkvFLaIzD1MOfZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693058; c=relaxed/simple;
	bh=JWJ6asaa3IgK2Lg0qfpCMVmw2WfKIpy4CzWRor5gTcw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxxdVIRdTH4x7uCMKqn/RX5f7R3lNczZzrwu4NscfpoisRnes9xfpH00CSPYO5Xtxnc95kL+pIRhxDCmLM2poOlU2afPomY2MPOpHro1+01PkTi8SXW9frXI/tOBGShG75rWF2FXlecvgruSet6nFCNnxvFvj+qTVpLvqti5pws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc66V4Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6FBC433C7;
	Sun, 17 Mar 2024 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693058;
	bh=JWJ6asaa3IgK2Lg0qfpCMVmw2WfKIpy4CzWRor5gTcw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Xc66V4Gp9ro7OPX71mlUyGezytQejc0bHpiUQRCcOh7f0ZrGxpa582hNfFdh1sxn1
	 d4hyts6xsG4NNLr1fVKQnICAsnveYKDR3MxJRMGdmdXmY1wQGRMmnMh5Iq325b8eNj
	 Fz/Mfw/674EEZA1mb3Ly+0JeF3skPeRChYGaQlIDDD4ai+2DHAWn7iXWbIIIdlcL3J
	 PjwvxIPKxRFBolAHN0pbrypzXHOjrtsZ5dpS3Csj2NoUaE5eVv16rWL3+aiFNPGVSY
	 zGBeFg1+103cyPTCDH6z4mYIEGUOgBAk6b05FG9qmMvckCXEHrDhQE1S15MX0Sd34U
	 nylOMiQbSSshA==
Date: Sun, 17 Mar 2024 09:30:57 -0700
Subject: [PATCH 29/40] xfs: shrink verity blob cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246376.2684506.9738125055810923344.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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
 fs/xfs/xfs_verity.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)


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
index 8d1888353515..c19fa47d1f76 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -42,6 +42,9 @@ struct xfs_merkle_blob {
 	/* refcount of this item; the cache holds its own ref */
 	refcount_t		refcount;
 
+	/* number of times the shrinker should ignore this item */
+	atomic_t		shrinkref;
+
 	unsigned long		flags;
 
 	/* Pointer to the merkle tree block, which is power-of-2 sized */
@@ -72,6 +75,7 @@ xfs_merkle_blob_alloc(
 
 	/* Caller owns this refcount. */
 	refcount_set(&mk->refcount, 1);
+	atomic_set(&mk->shrinkref, 0);
 	mk->flags = 0;
 	return mk;
 }
@@ -104,8 +108,10 @@ xfs_verity_cache_drop(
 	struct xfs_inode	*ip)
 {
 	XA_STATE(xas, &ip->i_merkle_blocks, 0);
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_merkle_blob	*mk;
 	unsigned long		flags;
+	s64			freed = 0;
 
 	xas_lock_irqsave(&xas, flags);
 	xas_for_each(&xas, mk, ULONG_MAX) {
@@ -113,10 +119,13 @@ xfs_verity_cache_drop(
 
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
@@ -175,6 +184,7 @@ xfs_verity_cache_store(
 	unsigned long		key,
 	struct xfs_merkle_blob	*mk)
 {
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_merkle_blob	*old;
 	unsigned long		flags;
 
@@ -189,6 +199,8 @@ xfs_verity_cache_store(
 		old = __xa_cmpxchg(&ip->i_merkle_blocks, key, NULL, mk,
 				GFP_KERNEL);
 	} while (old && !refcount_inc_not_zero(&old->refcount));
+	if (!old)
+		percpu_counter_add(&mp->m_verity_blocks, 1);
 	xa_unlock_irqrestore(&ip->i_merkle_blocks, flags);
 
 	if (old == NULL) {
@@ -234,12 +246,73 @@ struct xfs_verity_scan {
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
@@ -512,6 +585,13 @@ xfs_verity_read_merkle(
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
@@ -519,6 +599,13 @@ xfs_verity_read_merkle(
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


