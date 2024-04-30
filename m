Return-Path: <linux-fsdevel+bounces-18244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC608B689C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394281F24587
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7C10979;
	Tue, 30 Apr 2024 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI4d48PF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC210A01;
	Tue, 30 Apr 2024 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447682; cv=none; b=eZD5AT0RRKUhnFXFnj/VgDW1D9mfBO6aKnDusCxNTsLwXrUU+sKiVKNx9kMenfGCsQrAFwQ2iFUN2W6NcDA+Plz5quScqsUnwV2GhMozzTHK8r+EhDoniXV3+WY4aM80H6eaHHNOTBZF+1tPYAqxESZbEK7Yi19QODgGcAja5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447682; c=relaxed/simple;
	bh=+WQxAqookFGan0iRYQCqELTHay12WnvYsTSw3Q1g4Us=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4Yp5Q8iDDXvEA1Om9eNsu0cEoRC/ZT2wmVGfi93AkcyQp35te6+VaeMQws2oVAgUsc46Gi1JAT21Okri8sv1B3RcVUyYwPb9CGk4iQNLUrQHdsD9LveFy8LGaA1K6BJEw8bk/BZt95mZiNpQyZp6w9VsVo553IdQ6nhlSu1anU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI4d48PF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F985C116B1;
	Tue, 30 Apr 2024 03:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447681;
	bh=+WQxAqookFGan0iRYQCqELTHay12WnvYsTSw3Q1g4Us=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jI4d48PFIcg8wYMq+wN/3QK3HC0EYe8tapMlv3Pv78jH3g6d1FhLYnRgIMBulNPIq
	 aGVZ8S87DRvfCe0Xc0Z8jctGj9nOZZkNA6NG8YY9d2jXFF/l9t2vwA6wIsbysQ8qyH
	 gL0ym8gmCe5GiHiAFy7XhEh/n4qSXchqpkm05gDXVyes6Se8kfCK0q+cqHIAeOdX7t
	 sDHX3uQYtPWOPXwZJJNvZAQ0f0RHsMyK8CG7wEBu+OkrVYgJcVwK7jKmY1ap98nBE5
	 Twcd/+RY4Q6VoiC1IJBa/vnur2+aLlzNjHnpmZXYG7M4UcI0VOD+Gj2XZPdCo/gqko
	 QSpljXMDDyPWg==
Date: Mon, 29 Apr 2024 20:28:01 -0700
Subject: [PATCH 15/26] xfs: create a per-mount shrinker for verity inodes
 merkle tree blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680620.957659.5136878867888967888.stgit@frogsfrogsfrogs>
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

Create a shrinker for an entire filesystem that will walk the inodes
looking for inodes that are caching merkle tree blocks, and invoke
shrink functions on that cache.  The actual details of shrinking merkle
tree caches are left for subsequent patches.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_fsverity.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h    |    6 +++++
 fs/xfs/xfs_trace.h    |   20 +++++++++++++++++
 3 files changed, 84 insertions(+)


diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index e0f54acd4f786..ae3d1bdac2876 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -21,6 +21,7 @@
 #include "xfs_quota.h"
 #include "xfs_ag.h"
 #include "xfs_fsverity.h"
+#include "xfs_icache.h"
 #include <linux/fsverity.h>
 
 /*
@@ -182,6 +183,7 @@ xfs_fsverity_drop_cache(
 	}
 
 	xfs_perag_put(pag);
+	percpu_counter_sub(&mp->m_verity_blocks, freed);
 }
 
 /*
@@ -283,6 +285,7 @@ xfs_fsverity_cache_store(
 		refcount_inc(&mk->refcount);
 		spin_unlock(&pag->pagi_merkle_lock);
 		xfs_perag_put(pag);
+		percpu_counter_add(&mp->m_verity_blocks, 1);
 
 		trace_xfs_fsverity_cache_store(mp, &mk->key, _RET_IP_);
 		return mk;
@@ -300,6 +303,38 @@ xfs_fsverity_cache_store(
 	return old;
 }
 
+/* Count the merkle tree blocks that we might be able to reclaim. */
+static unsigned long
+xfs_fsverity_shrinker_count(
+	struct shrinker		*shrink,
+	struct shrink_control	*sc)
+{
+	struct xfs_mount	*mp = shrink->private_data;
+	s64			count;
+
+	if (!xfs_has_verity(mp))
+		return SHRINK_EMPTY;
+
+	count = percpu_counter_sum_positive(&mp->m_verity_blocks);
+
+	trace_xfs_fsverity_shrinker_count(mp, count, _RET_IP_);
+	return min_t(u64, ULONG_MAX, count);
+}
+
+/* Actually try to reclaim merkle tree blocks. */
+static unsigned long
+xfs_fsverity_shrinker_scan(
+	struct shrinker		*shrink,
+	struct shrink_control	*sc)
+{
+	struct xfs_mount	*mp = shrink->private_data;
+
+	if (!xfs_has_verity(mp))
+		return SHRINK_STOP;
+
+	return 0;
+}
+
 /* Set up fsverity for this mount. */
 int
 xfs_fsverity_mount(
@@ -312,6 +347,10 @@ xfs_fsverity_mount(
 	if (!xfs_has_verity(mp))
 		return 0;
 
+	error = percpu_counter_init(&mp->m_verity_blocks, 0, GFP_KERNEL);
+	if (error)
+		return error;
+
 	for_each_perag(mp, agno, pag) {
 		spin_lock_init(&pag->pagi_merkle_lock);
 		error = rhashtable_init(&pag->pagi_merkle_blobs,
@@ -323,6 +362,20 @@ xfs_fsverity_mount(
 		set_bit(XFS_AGSTATE_MERKLE, &pag->pag_opstate);
 	}
 
+	mp->m_verity_shrinker = shrinker_alloc(0, "xfs-verity:%s",
+			mp->m_super->s_id);
+	if (!mp->m_verity_shrinker) {
+		error = -ENOMEM;
+		goto out_perag;
+	}
+
+	mp->m_verity_shrinker->count_objects = xfs_fsverity_shrinker_count;
+	mp->m_verity_shrinker->scan_objects = xfs_fsverity_shrinker_scan;
+	mp->m_verity_shrinker->seeks = 0;
+	mp->m_verity_shrinker->private_data = mp;
+
+	shrinker_register(mp->m_verity_shrinker);
+
 	return 0;
 out_perag:
 	for_each_perag(mp, agno, pag) {
@@ -405,11 +458,16 @@ xfs_fsverity_unmount(
 	if (!xfs_has_verity(mp))
 		return;
 
+	shrinker_free(mp->m_verity_shrinker);
+
 	for_each_perag(mp, agno, pag) {
 		if (test_and_clear_bit(XFS_AGSTATE_MERKLE, &pag->pag_opstate))
 			rhashtable_free_and_destroy(&pag->pagi_merkle_blobs,
 					xfs_merkle_blob_destroy, &fu);
 	}
+
+	ASSERT(percpu_counter_sum(&mp->m_verity_blocks) == fu.freed);
+	percpu_counter_destroy(&mp->m_verity_blocks);
 }
 
 /*
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 78284e91244a8..dd6d33deed030 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -271,6 +271,12 @@ typedef struct xfs_mount {
 
 	/* Hook to feed dirent updates to an active online repair. */
 	struct xfs_hooks	m_dir_update_hooks;
+
+#ifdef CONFIG_FS_VERITY
+	/* shrinker and cached blocks count for merkle trees */
+	struct shrinker		*m_verity_shrinker;
+	struct percpu_counter	m_verity_blocks;
+#endif
 } xfs_mount_t;
 
 #define M_IGEO(mp)		(&(mp)->m_ino_geo)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 3e44d38fd871a..3810e20b9ee9b 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -5959,6 +5959,26 @@ DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_store);
 DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_drop);
 DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_unmount);
 DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_reclaim);
+
+TRACE_EVENT(xfs_fsverity_shrinker_count,
+	TP_PROTO(struct xfs_mount *mp, unsigned long long count,
+		 unsigned long caller_ip),
+	TP_ARGS(mp, count, caller_ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long long, count)
+		__field(void *, caller_ip)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->count = count;
+		__entry->caller_ip = (void *)caller_ip;
+	),
+	TP_printk("dev %d:%d count %llu caller %pS",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->count,
+		  __entry->caller_ip)
+)
 #endif /* CONFIG_XFS_VERITY */
 
 #endif /* _TRACE_XFS_H */


