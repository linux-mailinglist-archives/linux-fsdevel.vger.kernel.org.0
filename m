Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35057292C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbjFIITJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 04:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjFIISY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:18:24 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03722121
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 01:17:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686298655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMn+msnIJXvC+06grZ542lhB8pLG9zNhZSiyiHhRbaA=;
        b=QnAzENdGYWeYO57Spgjhk1adZxJY7gan2t4wYWPeZIaItdmJZDM8xOICqPyq/QELcJD9OY
        hG30tKtjBO4CWu/+8SDMmqFoQybaFEZQceY8dbZCLKigPc6SX9awgQJwPEusZAlihLEw5W
        Hw8FqnopH5nBR0yG+Weoe/3z4ob2VOY=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, muchun.song@linux.dev, yujie.liu@intel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 7/7] Revert "mm: vmscan: make global slab shrink lockless"
Date:   Fri,  9 Jun 2023 08:15:18 +0000
Message-Id: <20230609081518.3039120-8-qi.zheng@linux.dev>
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

This reverts commit f95bdb700bc6bb74e1199b1f5f90c613e152cfa7.

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
 mm/vmscan.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a008d7f2d0fc..5bf98d0a22c9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -57,7 +57,6 @@
 #include <linux/khugepaged.h>
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
-#include <linux/srcu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -191,7 +190,6 @@ int vm_swappiness = 60;
 
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
-DEFINE_SRCU(shrinker_srcu);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -742,7 +740,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
-	list_add_tail_rcu(&shrinker->list, &shrinker_list);
+	list_add_tail(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
 	up_write(&shrinker_rwsem);
@@ -797,15 +795,13 @@ void unregister_shrinker(struct shrinker *shrinker)
 		return;
 
 	down_write(&shrinker_rwsem);
-	list_del_rcu(&shrinker->list);
+	list_del(&shrinker->list);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
 	up_write(&shrinker_rwsem);
 
-	synchronize_srcu(&shrinker_srcu);
-
 	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
 
 	kfree(shrinker->nr_deferred);
@@ -825,7 +821,6 @@ void synchronize_shrinkers(void)
 {
 	down_write(&shrinker_rwsem);
 	up_write(&shrinker_rwsem);
-	synchronize_srcu(&shrinker_srcu);
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
 
@@ -1036,7 +1031,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
-	int srcu_idx;
 
 	/*
 	 * The root memcg might be allocated even though memcg is disabled
@@ -1048,10 +1042,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	srcu_idx = srcu_read_lock(&shrinker_srcu);
+	if (!down_read_trylock(&shrinker_rwsem))
+		goto out;
 
-	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
-				 srcu_read_lock_held(&shrinker_srcu)) {
+	list_for_each_entry(shrinker, &shrinker_list, list) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -1062,9 +1056,19 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
+		/*
+		 * Bail out if someone want to register a new shrinker to
+		 * prevent the registration from being stalled for long periods
+		 * by parallel ongoing shrinking.
+		 */
+		if (rwsem_is_contended(&shrinker_rwsem)) {
+			freed = freed ? : 1;
+			break;
+		}
 	}
 
-	srcu_read_unlock(&shrinker_srcu, srcu_idx);
+	up_read(&shrinker_rwsem);
+out:
 	cond_resched();
 	return freed;
 }
-- 
2.30.2

