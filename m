Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549F272929D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 10:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbjFIIRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 04:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240262AbjFIIRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:17:47 -0400
Received: from out-41.mta0.migadu.com (out-41.mta0.migadu.com [IPv6:2001:41d0:1004:224b::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF323A87
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 01:17:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686298623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50XF484pkGZZlvaX6wjD3S7ullpcs6Au3jWyE87o9lo=;
        b=VJW/sTjlrsD06VeMs5MWZHOINSVeIuvUVV3XeMcdlaZgU6yHH1KDKeoDlQ0uNJ8ow7jI5i
        C2f1mQy0VShusDu7ScqyZuVT65khmY5y8dLoApSOfxCjNpnx2aeqmPB13WMTVIUTOMDiTn
        dvzcgxnTuwP9thnsK4Ff5TbiUeHu3ak=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, muchun.song@linux.dev, yujie.liu@intel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/7] Revert "mm: shrinkers: convert shrinker_rwsem to mutex"
Date:   Fri,  9 Jun 2023 08:15:12 +0000
Message-Id: <20230609081518.3039120-2-qi.zheng@linux.dev>
In-Reply-To: <20230609081518.3039120-1-qi.zheng@linux.dev>
References: <20230609081518.3039120-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

This reverts commit cf2e309ebca7bb0916771839f9b580b06c778530.

Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
test case [1], which is caused by commit f95bdb700bc6 ("mm: vmscan: make
global slab shrink lockless"). The root cause is that SRCU has to be careful
to not frequently check for SRCU read-side critical section exits. Therefore,
even if no one is currently in the SRCU read-side critical section,
synchronize_srcu() cannot return quickly. That's why unregister_shrinker()
has become slower.

After discussion, we will try to use the refcount+RCU method [2] proposed
by Dave Chinner to continue to re-implement the lockless slab shrink. So
revert the shrinker_mutex back to shrinker_rwsem first.

[1]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
[2]. https://lore.kernel.org/lkml/ZIJhou1d55d4H1s0@dread.disaster.area/

Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305230837.db2c233f-yujie.liu@intel.com
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/md/dm-cache-metadata.c |  2 +-
 drivers/md/dm-thin-metadata.c  |  2 +-
 fs/super.c                     |  2 +-
 mm/shrinker_debug.c            | 14 +++++++-------
 mm/vmscan.c                    | 34 +++++++++++++++++-----------------
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
index 9e0c69958587..acffed750e3e 100644
--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -1828,7 +1828,7 @@ int dm_cache_metadata_abort(struct dm_cache_metadata *cmd)
 	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
 	 * cmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
 	 * shrinker associated with the block manager's bufio client vs cmd root_lock).
-	 * - must take shrinker_mutex without holding cmd->root_lock
+	 * - must take shrinker_rwsem without holding cmd->root_lock
 	 */
 	new_bm = dm_block_manager_create(cmd->bdev, DM_CACHE_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
 					 CACHE_MAX_CONCURRENT_LOCKS);
diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 9f5cb52c5763..fd464fb024c3 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1887,7 +1887,7 @@ int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
 	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
 	 * pmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
 	 * shrinker associated with the block manager's bufio client vs pmd root_lock).
-	 * - must take shrinker_mutex without holding pmd->root_lock
+	 * - must take shrinker_rwsem without holding pmd->root_lock
 	 */
 	new_bm = dm_block_manager_create(pmd->bdev, THIN_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
 					 THIN_MAX_CONCURRENT_LOCKS);
diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..04bc62ab7dfe 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -54,7 +54,7 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
  * If that happens we could trigger unregistering the shrinker from within the
- * shrinker path and that leads to deadlock on the shrinker_mutex. Hence we
+ * shrinker path and that leads to deadlock on the shrinker_rwsem. Hence we
  * take a passive reference to the superblock to avoid this from occurring.
  */
 static unsigned long super_cache_scan(struct shrinker *shrink,
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index fe10436d9911..2be15b8a6d0b 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -8,7 +8,7 @@
 #include <linux/srcu.h>
 
 /* defined in vmscan.c */
-extern struct mutex shrinker_mutex;
+extern struct rw_semaphore shrinker_rwsem;
 extern struct list_head shrinker_list;
 extern struct srcu_struct shrinker_srcu;
 
@@ -168,7 +168,7 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	char buf[128];
 	int id;
 
-	lockdep_assert_held(&shrinker_mutex);
+	lockdep_assert_held(&shrinker_rwsem);
 
 	/* debugfs isn't initialized yet, add debugfs entries later. */
 	if (!shrinker_debugfs_root)
@@ -211,7 +211,7 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 	if (!new)
 		return -ENOMEM;
 
-	mutex_lock(&shrinker_mutex);
+	down_write(&shrinker_rwsem);
 
 	old = shrinker->name;
 	shrinker->name = new;
@@ -229,7 +229,7 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 			shrinker->debugfs_entry = entry;
 	}
 
-	mutex_unlock(&shrinker_mutex);
+	up_write(&shrinker_rwsem);
 
 	kfree_const(old);
 
@@ -242,7 +242,7 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 {
 	struct dentry *entry = shrinker->debugfs_entry;
 
-	lockdep_assert_held(&shrinker_mutex);
+	lockdep_assert_held(&shrinker_rwsem);
 
 	kfree_const(shrinker->name);
 	shrinker->name = NULL;
@@ -271,14 +271,14 @@ static int __init shrinker_debugfs_init(void)
 	shrinker_debugfs_root = dentry;
 
 	/* Create debugfs entries for shrinkers registered at boot */
-	mutex_lock(&shrinker_mutex);
+	down_write(&shrinker_rwsem);
 	list_for_each_entry(shrinker, &shrinker_list, list)
 		if (!shrinker->debugfs_entry) {
 			ret = shrinker_debugfs_add(shrinker);
 			if (ret)
 				break;
 		}
-	mutex_unlock(&shrinker_mutex);
+	up_write(&shrinker_rwsem);
 
 	return ret;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6d0cd2840cf0..4730dba253c8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -35,7 +35,7 @@
 #include <linux/cpuset.h>
 #include <linux/compaction.h>
 #include <linux/notifier.h>
-#include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
@@ -190,7 +190,7 @@ struct scan_control {
 int vm_swappiness = 60;
 
 LIST_HEAD(shrinker_list);
-DEFINE_MUTEX(shrinker_mutex);
+DECLARE_RWSEM(shrinker_rwsem);
 DEFINE_SRCU(shrinker_srcu);
 static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
 
@@ -213,7 +213,7 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 {
 	return srcu_dereference_check(memcg->nodeinfo[nid]->shrinker_info,
 				      &shrinker_srcu,
-				      lockdep_is_held(&shrinker_mutex));
+				      lockdep_is_held(&shrinker_rwsem));
 }
 
 static struct shrinker_info *shrinker_info_srcu(struct mem_cgroup *memcg,
@@ -292,7 +292,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	int nid, size, ret = 0;
 	int map_size, defer_size = 0;
 
-	mutex_lock(&shrinker_mutex);
+	down_write(&shrinker_rwsem);
 	map_size = shrinker_map_size(shrinker_nr_max);
 	defer_size = shrinker_defer_size(shrinker_nr_max);
 	size = map_size + defer_size;
@@ -308,7 +308,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 		info->map_nr_max = shrinker_nr_max;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
-	mutex_unlock(&shrinker_mutex);
+	up_write(&shrinker_rwsem);
 
 	return ret;
 }
@@ -324,7 +324,7 @@ static int expand_shrinker_info(int new_id)
 	if (!root_mem_cgroup)
 		goto out;
 
-	lockdep_assert_held(&shrinker_mutex);
+	lockdep_assert_held(&shrinker_rwsem);
 
 	map_size = shrinker_map_size(new_nr_max);
 	defer_size = shrinker_defer_size(new_nr_max);
@@ -374,7 +374,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	if (mem_cgroup_disabled())
 		return -ENOSYS;
 
-	mutex_lock(&shrinker_mutex);
+	down_write(&shrinker_rwsem);
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -388,7 +388,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	shrinker->id = id;
 	ret = 0;
 unlock:
-	mutex_unlock(&shrinker_mutex);
+	up_write(&shrinker_rwsem);
 	return ret;
 }
 
@@ -398,7 +398,7 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 
 	BUG_ON(id < 0);
 
-	lockdep_assert_held(&shrinker_mutex);
+	lockdep_assert_held(&shrinker_rwsem);
 
 	idr_remove(&shrinker_idr, id);
 }
@@ -433,7 +433,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	mutex_lock(&shrinker_mutex);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -442,7 +442,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			atomic_long_add(nr, &parent_info->nr_deferred[i]);
 		}
 	}
-	mutex_unlock(&shrinker_mutex);
+	up_write(&shrinker_rwsem);
 }
 
 static bool cgroup_reclaim(struct scan_control *sc)
@@ -743,9 +743,9 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 	shrinker->name = NULL;
 #endif
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		mutex_lock(&shrinker_mutex);
+		down_write(&shrinker_rwsem);
 		unregister_memcg_shrinker(shrinker);
-		mutex_unlock(&shrinker_mutex);
+		up_write(&shrinker_rwsem);
 		return;
 	}
 
@@ -755,11 +755,11 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
-	mutex_lock(&shrinker_mutex);
+	down_write(&shrinker_rwsem);
 	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
-	mutex_unlock(&shrinker_mutex);
+	up_write(&shrinker_rwsem);
 }
 
 static int __register_shrinker(struct shrinker *shrinker)
@@ -810,13 +810,13 @@ void unregister_shrinker(struct shrinker *shrinker)
 	if (!(shrinker->flags & SHRINKER_REGISTERED))
 		return;
 
-	mutex_lock(&shrinker_mutex);
+	down_write(&shrinker_rwsem);
 	list_del_rcu(&shrinker->list);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
-	mutex_unlock(&shrinker_mutex);
+	up_write(&shrinker_rwsem);
 
 	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
-- 
2.30.2

