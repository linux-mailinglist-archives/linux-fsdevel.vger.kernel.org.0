Return-Path: <linux-fsdevel+bounces-18245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD98B68A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3672834A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E3E11185;
	Tue, 30 Apr 2024 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku9/CaVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE42156C2;
	Tue, 30 Apr 2024 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447697; cv=none; b=rFeCSn8ykVhp7kpf+gzHyQQA6+CAcPqT8KgGCmKpsyrmhvx0gDqpiU/XX0O0zS/6wxangR47xfWhbfMbTfS1NAPXxw46UeSmdTDPmhkencZ/TPH9GcVP8Vm3toG9iHw22Yl4tBIOyzJPsK+o8jkV0rkv774vY3p6JnTzVhsbRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447697; c=relaxed/simple;
	bh=Vkmr4g33MoOF/Zqsrvn4ruSmF3/aw67gsvBQJB9Oh9s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEfapR0IJPFP+tAVelEiBreX/ae0QEWpJEvHV3zi0Fkx7xaOL+5rLcdjy3LUqwXOvLh/RnoWaRJ9pVYreVVi7JGdORnoDsIPAdtAZda+Z3dY7rYavtAoUPCwed5UGmRNoafzvShkQOFznclJ+whuc1l+/EInfHFLxTWLEpFHmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku9/CaVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B14C116B1;
	Tue, 30 Apr 2024 03:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447697;
	bh=Vkmr4g33MoOF/Zqsrvn4ruSmF3/aw67gsvBQJB9Oh9s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ku9/CaVN0DnrJtoTv3MrlxNDVsXe44a3eDSJfX+/I2qupn//NGpO/nFdUOjQRoMHD
	 MTHx5xgSRwdIb9YpKkgfEHWK6dNm7OSsDsWSLLanRn8dx9PPV/7m8w7XDczwYuNmWP
	 tea76pd+srnZ0MxfdAzn7CDbe+3IlVC05+Z5nBT5iNXx6iylG4JzSEHDexdVEw/jUF
	 IXc5BfKtUwfhs0Qp65HqJhy8+08tGsrz8SVHf309f+SjhJPL4f+eHv5M3wPl/FR1U2
	 cNc/XggVqFf2Ei9V8x1q9splv7ONXqyWuA0auohKon3nfxMMYRK91ci5C9ghJR8X5C
	 0dgAEfSvuyerw==
Date: Mon, 29 Apr 2024 20:28:16 -0700
Subject: [PATCH 16/26] xfs: shrink verity blob cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680638.957659.5700993395267457237.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
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
 fs/xfs/xfs_fsverity.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_trace.h    |   23 +++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index ae3d1bdac2876..546c7ec6daadc 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -50,6 +50,9 @@ struct xfs_merkle_blob {
 	/* refcount of this item; the cache holds its own ref */
 	refcount_t		refcount;
 
+	/* number of times the shrinker should ignore this item */
+	atomic_t		shrinkref;
+
 	unsigned long		flags;
 
 	/* Pointer to the merkle tree block, which is power-of-2 sized */
@@ -89,6 +92,7 @@ xfs_merkle_blob_alloc(
 
 	/* Caller owns this refcount. */
 	refcount_set(&mk->refcount, 1);
+	atomic_set(&mk->shrinkref, 0);
 	mk->flags = 0;
 	mk->key.ino = ip->i_ino;
 	mk->key.pos = pos;
@@ -321,18 +325,94 @@ xfs_fsverity_shrinker_count(
 	return min_t(u64, ULONG_MAX, count);
 }
 
+struct xfs_fsverity_scan {
+	struct shrink_control	*sc;
+
+	unsigned long		scanned;
+	unsigned long		freed;
+};
+
+/* Reclaim inactive merkle tree blocks that have run out of second chances. */
+static void
+xfs_fsverity_perag_reclaim(
+	struct xfs_perag		*pag,
+	struct xfs_fsverity_scan	*vs)
+{
+	struct rhashtable_iter		iter;
+	struct xfs_mount		*mp = pag->pag_mount;
+	struct xfs_merkle_blob		*mk;
+	s64				freed = 0;
+
+	rhashtable_walk_enter(&pag->pagi_merkle_blobs, &iter);
+	rhashtable_walk_start(&iter);
+	while ((mk = rhashtable_walk_next(&iter)) != NULL) {
+		if (IS_ERR(mk))
+			continue;
+
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
+		/*
+		 * Grab our own active reference to the blob handle.  If we
+		 * can't, then we're racing with a cache drop and can move on.
+		 */
+		if (!refcount_inc_not_zero(&mk->refcount))
+			continue;
+
+		rhashtable_walk_stop(&iter);
+
+		trace_xfs_fsverity_cache_reclaim(mp, &mk->key, _RET_IP_);
+
+		xfs_merkle_blob_drop(pag, mk);
+		freed++;
+
+		rhashtable_walk_start(&iter);
+	}
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+
+	percpu_counter_sub(&mp->m_verity_blocks, freed);
+	vs->freed += freed;
+}
+
 /* Actually try to reclaim merkle tree blocks. */
 static unsigned long
 xfs_fsverity_shrinker_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
+	struct xfs_fsverity_scan vs = { .sc = sc };
 	struct xfs_mount	*mp = shrink->private_data;
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		agno;
 
 	if (!xfs_has_verity(mp))
 		return SHRINK_STOP;
 
-	return 0;
+	for_each_perag(mp, agno, pag) {
+		xfs_fsverity_perag_reclaim(pag, &vs);
+
+		if (sc->nr_to_scan == 0) {
+			xfs_perag_rele(pag);
+			break;
+		}
+	}
+
+	trace_xfs_fsverity_shrinker_scan(mp, vs.scanned, vs.freed, _RET_IP_);
+	return vs.freed;
 }
 
 /* Set up fsverity for this mount. */
@@ -765,6 +845,13 @@ xfs_fsverity_read_merkle(
 	block->context = mk;
 	block->verified = test_bit(XFS_MERKLE_BLOB_VERIFIED_BIT, &mk->flags);
 
+	/*
+	 * Prioritize keeping the root-adjacent levels cached if this isn't a
+	 * streaming read.
+	 */
+	if (req->level != FSVERITY_STREAMING_READ)
+		atomic_set(&mk->shrinkref, req->level + 1);
+
 	return 0;
 
 out_new_mk:
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 3810e20b9ee9b..21e8643e021eb 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -5979,6 +5979,29 @@ TRACE_EVENT(xfs_fsverity_shrinker_count,
 		  __entry->count,
 		  __entry->caller_ip)
 )
+
+TRACE_EVENT(xfs_fsverity_shrinker_scan,
+	TP_PROTO(struct xfs_mount *mp, unsigned long scanned,
+		 unsigned long freed, unsigned long caller_ip),
+	TP_ARGS(mp, scanned, freed, caller_ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long, scanned)
+		__field(unsigned long, freed)
+		__field(void *, caller_ip)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->scanned = scanned;
+		__entry->freed = freed;
+		__entry->caller_ip = (void *)caller_ip;
+	),
+	TP_printk("dev %d:%d scanned %lu freed %lu caller %pS",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->scanned,
+		  __entry->freed,
+		  __entry->caller_ip)
+)
 #endif /* CONFIG_XFS_VERITY */
 
 #endif /* _TRACE_XFS_H */


