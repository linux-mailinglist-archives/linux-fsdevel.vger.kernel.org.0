Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1C7292C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbjFIITI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbjFIISQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:18:16 -0400
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [91.218.175.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C211C2715;
        Fri,  9 Jun 2023 01:17:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686298649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/E+4G7xduNcnh08om90Yauw78sQGFjRZ4mRQx21A2Q=;
        b=Hp4UWFqQJil8Kf9Kbk7PpaCcvuRjBeSALwQccnwRZWKqDBGAxb1HaJdVYPnL+2SqJ79gWL
        Dvz4OkZmXEAisnQB6TAIkcV1qOdjUk0ksJQqHC9jb/4iwoI78cHfc6hLpTA+6ksOQfKmVx
        x7esjKuYGnPxyQBoj7U7f+XOMRKIYW8=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, muchun.song@linux.dev, yujie.liu@intel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 6/7] Revert "mm: vmscan: make memcg slab shrink lockless"
Date:   Fri,  9 Jun 2023 08:15:17 +0000
Message-Id: <20230609081518.3039120-7-qi.zheng@linux.dev>
In-Reply-To: <20230609081518.3039120-1-qi.zheng@linux.dev>
References: <20230609081518.3039120-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

This reverts commit caa05325c9126c77ebf114edce51536a0d0a9a08.

Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
test case [1], which is caused by commit f95bdb700bc6 ("mm: vmscan: make
global slab shrink lockless"). The root cause is that SRCU has to be careful
to not frequently check for SRCU read-side critical section exits. Therefore,
even if no one is currently in the SRCU read-side critical section,
synchronize_srcu() cannot return quickly. That's why unregister_shrinker()
has become slower.

After discussion, we will try to use the refcount+RCU method [2] proposed
by Dave Chinner to continue to re-implement the lockless slab shrink. So
revert the shrinker_srcu related changes first.

[1]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
[2]. https://lore.kernel.org/lkml/ZIJhou1d55d4H1s0@dread.disaster.area/

Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305230837.db2c233f-yujie.liu@intel.com
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50775b73d0c7..a008d7f2d0fc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -210,21 +210,8 @@ static inline int shrinker_defer_size(int nr_items)
 static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 						     int nid)
 {
-	return srcu_dereference_check(memcg->nodeinfo[nid]->shrinker_info,
-				      &shrinker_srcu,
-				      lockdep_is_held(&shrinker_rwsem));
-}
-
-static struct shrinker_info *shrinker_info_srcu(struct mem_cgroup *memcg,
-						     int nid)
-{
-	return srcu_dereference(memcg->nodeinfo[nid]->shrinker_info,
-				&shrinker_srcu);
-}
-
-static void free_shrinker_info_rcu(struct rcu_head *head)
-{
-	kvfree(container_of(head, struct shrinker_info, rcu));
+	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 lockdep_is_held(&shrinker_rwsem));
 }
 
 static int expand_one_shrinker_info(struct mem_cgroup *memcg,
@@ -265,7 +252,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		       defer_size - old_defer_size);
 
 		rcu_assign_pointer(pn->shrinker_info, new);
-		call_srcu(&shrinker_srcu, &old->rcu, free_shrinker_info_rcu);
+		kvfree_rcu(old, rcu);
 	}
 
 	return 0;
@@ -351,16 +338,15 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 {
 	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
 		struct shrinker_info *info;
-		int srcu_idx;
 
-		srcu_idx = srcu_read_lock(&shrinker_srcu);
-		info = shrinker_info_srcu(memcg, nid);
+		rcu_read_lock();
+		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
 		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
 			/* Pairs with smp mb in shrink_slab() */
 			smp_mb__before_atomic();
 			set_bit(shrinker_id, info->map);
 		}
-		srcu_read_unlock(&shrinker_srcu, srcu_idx);
+		rcu_read_unlock();
 	}
 }
 
@@ -374,6 +360,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 		return -ENOSYS;
 
 	down_write(&shrinker_rwsem);
+	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -407,7 +394,7 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 
-	info = shrinker_info_srcu(memcg, nid);
+	info = shrinker_info_protected(memcg, nid);
 	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
 }
 
@@ -416,7 +403,7 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 
-	info = shrinker_info_srcu(memcg, nid);
+	info = shrinker_info_protected(memcg, nid);
 	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
 }
 
@@ -947,14 +934,15 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
-	int srcu_idx;
 	int i;
 
 	if (!mem_cgroup_online(memcg))
 		return 0;
 
-	srcu_idx = srcu_read_lock(&shrinker_srcu);
-	info = shrinker_info_srcu(memcg, nid);
+	if (!down_read_trylock(&shrinker_rwsem))
+		return 0;
+
+	info = shrinker_info_protected(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
@@ -1004,9 +992,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 				set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
+
+		if (rwsem_is_contended(&shrinker_rwsem)) {
+			freed = freed ? : 1;
+			break;
+		}
 	}
 unlock:
-	srcu_read_unlock(&shrinker_srcu, srcu_idx);
+	up_read(&shrinker_rwsem);
 	return freed;
 }
 #else /* CONFIG_MEMCG */
-- 
2.30.2

