Return-Path: <linux-fsdevel+bounces-15729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD64892858
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46EF1F21B27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D115C3;
	Sat, 30 Mar 2024 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARoQkLZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDDC7F8;
	Sat, 30 Mar 2024 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759183; cv=none; b=KEWMFfQ500ixpEATBc3xulTT7mwXwHIYTHmv2EPo9t4pNYeg0fQ6g6lFuQogOBQkmG9+E7t7luGd4KaaEOhd9mNygzGYdUvWSvDiZKFWXCazWG7yZs1WxbqyVqyaouT6vRNuMg/tdPyJgXPd62c1bVmrg2+AWNpn8vMBZS97RBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759183; c=relaxed/simple;
	bh=sbhJ2Ash/OfmVqM+S0Ffls52RaZMPhx0Ed/7uRa9JfA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+na9Wf862eRWcOPnnu8hP7019rl5knLzec+idkZX4Dv8+WJd6/Crx111quFjPiDcJXJS0xCPG5wowoCI/Z5mgS6NbVqNrhZ1YvHgi1pXfz3JZE1OVfybgORClk0vkQxM/NaRn0mIWhKHbIXJV9JPSzzcBQ4mfALHGafIGWjCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARoQkLZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED0CC433F1;
	Sat, 30 Mar 2024 00:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759183;
	bh=sbhJ2Ash/OfmVqM+S0Ffls52RaZMPhx0Ed/7uRa9JfA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ARoQkLZpEz1XpgJAUZhVDuOKD8NvPQ0iSERft3PSfIXmad9cqgIQuXQ8bK5RxkoGL
	 BZY98e2FfN76dEVHutWK0tWnpz4+YoxzgUNZVvpqGoBM+7PwaYgZauMiZE4LHstSMe
	 sStn+sqZpFNQ1ZfqUIogAuLr8ZTdROe9F1Kb2RtvIZHUgVNwqjrXROwGnvnkeUBVjs
	 yZgMypb9BOgdid2FAenKuN0lC9TVfeC62Y/ry8ebX5lsNkz0HPjzcFi+ZJ/BkMiHcp
	 AV3tGbILYKJLirhoyo44FOvRMZWgzEA+x5QLo9M0hsyCY6Jkt3f393tcBbMNvgmp9Z
	 kfaBOPja45K8w==
Date: Fri, 29 Mar 2024 17:39:43 -0700
Subject: [PATCH 14/29] xfs: create a per-mount shrinker for verity inodes
 merkle tree blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868793.1988170.8461136895877903082.stgit@frogsfrogsfrogs>
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

Create a shrinker for an entire filesystem that will walk the inodes
looking for inodes that are caching merkle tree blocks, and invoke
shrink functions on that cache.  The actual details of shrinking merkle
tree caches are left for subsequent patches.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_fsverity.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsverity.h |    5 +++
 fs/xfs/xfs_mount.c    |   10 ++++++
 fs/xfs/xfs_mount.h    |    6 ++++
 fs/xfs/xfs_trace.h    |   20 +++++++++++++
 5 files changed, 117 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index a4a52575fb3d5..46640a495e705 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -20,6 +20,7 @@
 #include "xfs_trace.h"
 #include "xfs_quota.h"
 #include "xfs_fsverity.h"
+#include "xfs_icache.h"
 #include <linux/fsverity.h>
 
 /*
@@ -276,6 +277,82 @@ xfs_fsverity_delete_merkle_block(
 	return xfs_attr_removename(&args, false);
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
+	return min_t(s64, ULONG_MAX, count);
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
+/* Register a shrinker so we can release cached merkle tree blocks. */
+int
+xfs_fsverity_register_shrinker(
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
+	mp->m_verity_shrinker->count_objects = xfs_fsverity_shrinker_count;
+	mp->m_verity_shrinker->scan_objects = xfs_fsverity_shrinker_scan;
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
+xfs_fsverity_unregister_shrinker(struct xfs_mount *mp)
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
 /* Retrieve the verity descriptor. */
 static int
 xfs_fsverity_get_descriptor(
diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
index 277a9f856f518..7148e0c4dde1f 100644
--- a/fs/xfs/xfs_fsverity.h
+++ b/fs/xfs/xfs_fsverity.h
@@ -10,11 +10,16 @@ void xfs_fsverity_cache_init(struct xfs_inode *ip);
 void xfs_fsverity_cache_drop(struct xfs_inode *ip);
 void xfs_fsverity_cache_destroy(struct xfs_inode *ip);
 
+int xfs_fsverity_register_shrinker(struct xfs_mount *mp);
+void xfs_fsverity_unregister_shrinker(struct xfs_mount *mp);
+
 extern const struct fsverity_operations xfs_fsverity_ops;
 #else
 # define xfs_fsverity_cache_init(ip)		((void)0)
 # define xfs_fsverity_cache_drop(ip)		((void)0)
 # define xfs_fsverity_cache_destroy(ip)		((void)0)
+# define xfs_fsverity_register_shrinker(mp)	(0)
+# define xfs_fsverity_unregister_shrinker(mp)	((void)0)
 #endif	/* CONFIG_FS_VERITY */
 
 #endif	/* __XFS_FSVERITY_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 20949adb5f80b..1e6a0bc933897 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -38,6 +38,7 @@
 #include "xfs_rtgroup.h"
 #include "xfs_rtrmap_btree.h"
 #include "xfs_rtrefcount_btree.h"
+#include "xfs_fsverity.h"
 #include "scrub/stats.h"
 
 static DEFINE_MUTEX(xfs_uuid_table_mutex);
@@ -918,6 +919,10 @@ xfs_mountfs(
 	if (error)
 		goto out_fail_wait;
 
+	error = xfs_fsverity_register_shrinker(mp);
+	if (error)
+		goto out_inodegc_shrinker;
+
 	/*
 	 * Log's mount-time initialization. The first part of recovery can place
 	 * some items on the AIL, to be handled when recovery is finished or
@@ -928,7 +933,7 @@ xfs_mountfs(
 			      XFS_FSB_TO_BB(mp, sbp->sb_logblocks));
 	if (error) {
 		xfs_warn(mp, "log mount failed");
-		goto out_inodegc_shrinker;
+		goto out_verity_shrinker;
 	}
 
 	error = xfs_mountfs_set_perm_log_features(mp);
@@ -1137,6 +1142,8 @@ xfs_mountfs(
 	 */
 	xfs_unmount_flush_inodes(mp);
 	xfs_log_mount_cancel(mp);
+ out_verity_shrinker:
+	xfs_fsverity_unregister_shrinker(mp);
  out_inodegc_shrinker:
 	shrinker_free(mp->m_inodegc_shrinker);
  out_fail_wait:
@@ -1228,6 +1235,7 @@ xfs_unmountfs(
 #if defined(DEBUG)
 	xfs_errortag_clearall(mp);
 #endif
+	xfs_fsverity_unregister_shrinker(mp);
 	shrinker_free(mp->m_inodegc_shrinker);
 	xfs_free_rtgroups(mp);
 	xfs_free_perag(mp);
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 08ec154eb0e98..2c354da8fa55b 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -274,6 +274,12 @@ typedef struct xfs_mount {
 
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
index 86a8702c1e27c..e3edd43661bd9 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -5938,6 +5938,26 @@ DEFINE_EVENT(xfs_fsverity_cache_class, name, \
 DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_load);
 DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_store);
 DEFINE_XFS_FSVERITY_CACHE_EVENT(xfs_fsverity_cache_drop);
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


