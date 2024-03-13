Return-Path: <linux-fsdevel+bounces-14344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775887B0A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8561F2A092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36F59B6E;
	Wed, 13 Mar 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH61lwNy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F659B63;
	Wed, 13 Mar 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352699; cv=none; b=N+i0LKBwn4Gs0Q1eibVVf3jgAwxaxKvR7kzes8UPBFlzvKjrpcnVLhLZI84Qqx9zn6515Hmd16LgECFkGRE15l45SbeA0YmUz71VXT5KzY2Xl0WMe2LmisW9ariCdZSOq2/BySG8OmfCpMYpsOs25Gp8ta5+duRVXSpQzyDCymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352699; c=relaxed/simple;
	bh=9aNnEIVecuTEfZ9EOGAhAn3k+OtIpt0Q6d1/0iL//H0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqFcd6Y75Q5rh4d2YzSyAWKr6nOJ8rPMSXJSeEVAGq0c2Dsr/5OnnGq07ORWfihRIjvoMLtAcXbwTK2nEmozQuMNQyrIp70tv1NF8dxQhZOztXEffNkrAsKTW1KcTNIuh5uko/+yBGAGAPTK/Z49kW37eb3i92nFUM0IaYkyqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH61lwNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB79C433F1;
	Wed, 13 Mar 2024 17:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352699;
	bh=9aNnEIVecuTEfZ9EOGAhAn3k+OtIpt0Q6d1/0iL//H0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KH61lwNyzfAIYMle/RCbOX/DSB5i2ZR6TJlJ8Nf3kWx7Bk7869LjJnHwiI3UgpNvO
	 PAqAek987egO9bGA7g/kKIoXOeXcrGTwecleO+N+xtfwULWZON3uAfjdrB0zntvzXk
	 vic9SvCR+pCQSHs8PXtzaVy/HSnWKfsgGrQClIRTJ+OHLgYV0BVcHNZGEebQG0TcF+
	 Odq6OiHqaLKDauvfGnwSkmA4IxSsscsQmOYz5WCwj3Y4R+yTUGVc7Yt492f1SxyQRe
	 jtHhxA+dcQ8dl+VjQ9m5mNDlPsjQDgKm/l731MPil+JHlCPcnqTdM//xOrOd0IK+Ny
	 ZTprXzHaOXLgA==
Date: Wed, 13 Mar 2024 10:58:18 -0700
Subject: [PATCH 22/29] xfs: create a per-mount shrinker for verity inodes
 merkle tree blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223710.2613863.3703735595488208587.stgit@frogsfrogsfrogs>
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

Create a shrinker for an entire filesystem that will walk the inodes
looking for inodes that are caching merkle tree blocks, and invoke
shrink functions on that cache.  The actual details of shrinking merkle
tree caches are left for subsequent patches.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_mount.c  |   10 ++++++-
 fs/xfs/xfs_mount.h  |    6 ++++
 fs/xfs/xfs_trace.h  |   20 +++++++++++++
 fs/xfs/xfs_verity.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_verity.h |    5 +++
 5 files changed, 117 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 7328034d42ed..4b5b74809cff 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -34,6 +34,7 @@
 #include "xfs_health.h"
 #include "xfs_trace.h"
 #include "xfs_ag.h"
+#include "xfs_verity.h"
 #include "scrub/stats.h"
 
 static DEFINE_MUTEX(xfs_uuid_table_mutex);
@@ -813,6 +814,10 @@ xfs_mountfs(
 	if (error)
 		goto out_fail_wait;
 
+	error = xfs_verity_register_shrinker(mp);
+	if (error)
+		goto out_inodegc_shrinker;
+
 	/*
 	 * Log's mount-time initialization. The first part of recovery can place
 	 * some items on the AIL, to be handled when recovery is finished or
@@ -823,7 +828,7 @@ xfs_mountfs(
 			      XFS_FSB_TO_BB(mp, sbp->sb_logblocks));
 	if (error) {
 		xfs_warn(mp, "log mount failed");
-		goto out_inodegc_shrinker;
+		goto out_verity_shrinker;
 	}
 
 	/* Enable background inode inactivation workers. */
@@ -1018,6 +1023,8 @@ xfs_mountfs(
 	xfs_unmount_flush_inodes(mp);
  out_log_dealloc:
 	xfs_log_mount_cancel(mp);
+ out_verity_shrinker:
+	xfs_verity_unregister_shrinker(mp);
  out_inodegc_shrinker:
 	shrinker_free(mp->m_inodegc_shrinker);
  out_fail_wait:
@@ -1100,6 +1107,7 @@ xfs_unmountfs(
 #if defined(DEBUG)
 	xfs_errortag_clearall(mp);
 #endif
+	xfs_verity_unregister_shrinker(mp);
 	shrinker_free(mp->m_inodegc_shrinker);
 	xfs_free_perag(mp);
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index f198d7c82552..855517583ce6 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -255,6 +255,12 @@ typedef struct xfs_mount {
 
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
index 23abec742c3b..fa05122a7c4d 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -4797,6 +4797,26 @@ DEFINE_EVENT(xfs_verity_cache_class, name, \
 DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_load);
 DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_store);
 DEFINE_XFS_VERITY_CACHE_EVENT(xfs_verity_cache_drop);
+
+TRACE_EVENT(xfs_verity_shrinker_count,
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
diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index 9f3bcc9150d2..25d10e00698b 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -18,6 +18,7 @@
 #include "xfs_trans.h"
 #include "xfs_attr_leaf.h"
 #include "xfs_trace.h"
+#include "xfs_icache.h"
 #include <linux/fsverity.h>
 
 /*
@@ -217,6 +218,82 @@ xfs_fsverity_merkle_key_from_disk(
 	return be64_to_cpu(key->merkleoff);
 }
 
+/* Count the merkle tree blocks that we might be able to reclaim. */
+static unsigned long
+xfs_verity_shrinker_count(
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
+	trace_xfs_verity_shrinker_count(mp, count, _RET_IP_);
+	return min_t(s64, ULONG_MAX, count);
+}
+
+/* Actually try to reclaim merkle tree blocks. */
+static unsigned long
+xfs_verity_shrinker_scan(
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
+/* Register a shrinker so we can release cached merkle tree blocks. */
+int
+xfs_verity_register_shrinker(
+	struct xfs_mount	*mp)
+{
+	int			error;
+
+	if (!xfs_has_verity(mp))
+		return 0;
+
+	error = percpu_counter_init(&mp->m_verity_blocks, 0, GFP_KERNEL);
+	if (error)
+		return error;
+
+	mp->m_verity_shrinker = shrinker_alloc(0, "xfs-verity:%s",
+			mp->m_super->s_id);
+	if (!mp->m_verity_shrinker) {
+		percpu_counter_destroy(&mp->m_verity_blocks);
+		return -ENOMEM;
+	}
+
+	mp->m_verity_shrinker->count_objects = xfs_verity_shrinker_count;
+	mp->m_verity_shrinker->scan_objects = xfs_verity_shrinker_scan;
+	mp->m_verity_shrinker->seeks = 0;
+	mp->m_verity_shrinker->private_data = mp;
+
+	shrinker_register(mp->m_verity_shrinker);
+
+	return 0;
+}
+
+/* Unregister the merkle tree block shrinker. */
+void
+xfs_verity_unregister_shrinker(struct xfs_mount *mp)
+{
+	if (!xfs_has_verity(mp))
+		return;
+
+	ASSERT(percpu_counter_sum(&mp->m_verity_blocks) == 0);
+
+	shrinker_free(mp->m_verity_shrinker);
+	percpu_counter_destroy(&mp->m_verity_blocks);
+}
+
 static int
 xfs_verity_get_descriptor(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
index 31d51482f7f7..0ec0a61bee65 100644
--- a/fs/xfs/xfs_verity.h
+++ b/fs/xfs/xfs_verity.h
@@ -10,11 +10,16 @@ void xfs_verity_cache_init(struct xfs_inode *ip);
 void xfs_verity_cache_drop(struct xfs_inode *ip);
 void xfs_verity_cache_destroy(struct xfs_inode *ip);
 
+int xfs_verity_register_shrinker(struct xfs_mount *mp);
+void xfs_verity_unregister_shrinker(struct xfs_mount *mp);
+
 extern const struct fsverity_operations xfs_verity_ops;
 #else
 # define xfs_verity_cache_init(ip)		((void)0)
 # define xfs_verity_cache_drop(ip)		((void)0)
 # define xfs_verity_cache_destroy(ip)		((void)0)
+# define xfs_verity_register_shrinker(mp)	(0)
+# define xfs_verity_unregister_shrinker(mp)	((void)0)
 #endif	/* CONFIG_FS_VERITY */
 
 #endif	/* __XFS_VERITY_H__ */


