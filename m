Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA04C6C48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 13:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiB1MYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 07:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbiB1MYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:24:21 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D833075218
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:23:42 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id ay5so7741167plb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPduYZNuH2LeQ+4I4Un4vr4KBtJTEFjv8pV2NSnkp+k=;
        b=5N5c2FHFLz0xZnPyJoJgkrqFicmCzd/wc3HjC1BAvo3IxgD8PXVx0RmdAYi90tZ5+q
         mbItK9Gv9HnkZ4q19O8L7saz1gV283CAw8mdLnCbRQdLk8G7QKWURocIIJV+/sSPKzPu
         NL6OZOVKCwdzC2xnBawYe8kTlJiDv9oCZYCDST0/CisVZEWw1N1Wd0WOGFjHNWTnhSx6
         kuYHPSx/fD1PWZkfMaeLnB5EO1xkJyMAE/7gRJI7XpPkfvvl5dOm9JMjJbOnNCOI8304
         4shO9MsyTTAaJvMD4mBJWit0s6dHFq2AFxWMSlKr9+yWG1urgir3Ol5GVVkJp93QRNtW
         yGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPduYZNuH2LeQ+4I4Un4vr4KBtJTEFjv8pV2NSnkp+k=;
        b=vJSNiECqGtuhH6aPQgrhBf2Wd+Abkm3Cfuy+ruNuCvGu8/ZJpxr3+pTIeNYFblSN9R
         1lLUCCCZIHDUAIxCkZZSRSpUppZ4ooI8kFnaSbuAnbjMUNPWtzQLu8gSLaTVb++zvCO0
         06rvGa4W/BcI4zR1g5bd5Ki1ULpTylFxmOLHevm/Hhse0szMm8YePZYNCgafIEEKJFgF
         PEGazLS/0fdn4OoGpXQTW7IMhCoIs7zQH3TrAyFTYVB1z63btR28jL6wj3zgdHky559f
         jmyTMVW1I0qclPCCP4SLeLWWCu3rxS5fgpVTPcJ99b6lN85n0XZvUkTDLmxKlPwLcFTU
         N45Q==
X-Gm-Message-State: AOAM532aJZ2lAqbqFBwKL6rbYDVCOUglQflwtioEgjV0GL9AWrwFMyMC
        CweJE3bW2ke+dV+JAKVMoxHwpQ==
X-Google-Smtp-Source: ABdhPJw2wR/nODJVHzJwh92P8d7ZUF4eXRNnfA+tb9OvOfSgYD6XG0GxdF0tqCjFAGoepfvGj5r42Q==
X-Received: by 2002:a17:90a:f0cb:b0:1bd:2372:c992 with SMTP id fa11-20020a17090af0cb00b001bd2372c992mr9640250pjb.71.1646051022289;
        Mon, 28 Feb 2022 04:23:42 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:23:41 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 10/16] mm: list_lru: allocate list_lru_one only when needed
Date:   Mon, 28 Feb 2022 20:21:20 +0800
Message-Id: <20220228122126.37293-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In our server, we found a suspected memory leak problem. The kmalloc-32
consumes more than 6GB of memory. Other kmem_caches consume less than
2GB memory.

After our in-depth analysis, the memory consumption of kmalloc-32 slab
cache is the cause of list_lru_one allocation.

  crash> p memcg_nr_cache_ids
  memcg_nr_cache_ids = $2 = 24574

memcg_nr_cache_ids is very large and memory consumption of each list_lru
can be calculated with the following formula.

  num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)

There are 4 numa nodes in our system, so each list_lru consumes ~3MB.

  crash> list super_blocks | wc -l
  952

Every mount will register 2 list lrus, one is for inode, another is for
dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
MB (~5.6GB). But the number of memory cgroup is less than 500. So I
guess more than 12286 containers have been deployed on this machine (I
do not know why there are so many containers, it may be a user's bug or
the user really want to do that). And memcg_nr_cache_ids has not been
reduced to a suitable value. This can waste a lot of memory.

Now the infrastructure for dynamic list_lru_one allocation is ready, so
remove statically allocated memory code to save memory.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |   7 +--
 mm/list_lru.c            | 121 ++++++++++++++++++++++++++---------------------
 mm/memcontrol.c          |   6 ++-
 3 files changed, 77 insertions(+), 57 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index ab912c49334f..c36db6dc2a65 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -32,14 +32,15 @@ struct list_lru_one {
 };
 
 struct list_lru_per_memcg {
+	struct rcu_head		rcu;
 	/* array of per cgroup per node lists, indexed by node id */
-	struct list_lru_one	node[0];
+	struct list_lru_one	node[];
 };
 
 struct list_lru_memcg {
 	struct rcu_head			rcu;
 	/* array of per cgroup lists, indexed by memcg_cache_id */
-	struct list_lru_per_memcg	*mlru[];
+	struct list_lru_per_memcg __rcu	*mlru[];
 };
 
 struct list_lru_node {
@@ -77,7 +78,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			 gfp_t gfp);
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
+void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index bffa80527723..fc938d8ff48f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -60,8 +60,12 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 	 * from relocation (see memcg_update_list_lru).
 	 */
 	mlrus = rcu_dereference_check(lru->mlrus, lockdep_is_held(&nlru->lock));
-	if (mlrus && idx >= 0)
-		return &mlrus->mlru[idx]->node[nid];
+	if (mlrus && idx >= 0) {
+		struct list_lru_per_memcg *mlru;
+
+		mlru = rcu_dereference_check(mlrus->mlru[idx], true);
+		return mlru ? &mlru->node[nid] : NULL;
+	}
 	return &nlru->lru;
 }
 
@@ -188,7 +192,7 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 
 	rcu_read_lock();
 	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
-	count = READ_ONCE(l->nr_items);
+	count = l ? READ_ONCE(l->nr_items) : 0;
 	rcu_read_unlock();
 
 	if (unlikely(count < 0))
@@ -217,8 +221,11 @@ __list_lru_walk_one(struct list_lru *lru, int nid, int memcg_idx,
 	struct list_head *item, *n;
 	unsigned long isolated = 0;
 
-	l = list_lru_from_memcg_idx(lru, nid, memcg_idx);
 restart:
+	l = list_lru_from_memcg_idx(lru, nid, memcg_idx);
+	if (!l)
+		goto out;
+
 	list_for_each_safe(item, n, &l->list) {
 		enum lru_status ret;
 
@@ -262,6 +269,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid, int memcg_idx,
 			BUG();
 		}
 	}
+out:
 	return isolated;
 }
 
@@ -354,20 +362,25 @@ static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
 	return mlru;
 }
 
-static int memcg_init_list_lru_range(struct list_lru_memcg *mlrus,
-				     int begin, int end)
+static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	int i;
+	struct list_lru_memcg *mlrus;
+	struct list_lru_per_memcg *mlru;
 
-	for (i = begin; i < end; i++) {
-		mlrus->mlru[i] = memcg_init_list_lru_one(GFP_KERNEL);
-		if (!mlrus->mlru[i])
-			goto fail;
-	}
-	return 0;
-fail:
-	memcg_destroy_list_lru_range(mlrus, begin, i);
-	return -ENOMEM;
+	spin_lock_irq(&lru->lock);
+	mlrus = rcu_dereference_protected(lru->mlrus, true);
+	mlru = rcu_dereference_protected(mlrus->mlru[src_idx], true);
+	rcu_assign_pointer(mlrus->mlru[src_idx], NULL);
+	spin_unlock_irq(&lru->lock);
+
+	/*
+	 * The __list_lru_walk_one() can walk the list of this node.
+	 * We need kvfree_rcu() here. And the walking of the list
+	 * is under lru->node[nid]->lock, which can serve as a RCU
+	 * read-side critical section.
+	 */
+	if (mlru)
+		kvfree_rcu(mlru, rcu);
 }
 
 static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
@@ -381,14 +394,10 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 
 	spin_lock_init(&lru->lock);
 
-	mlrus = kvmalloc(struct_size(mlrus, mlru, size), GFP_KERNEL);
+	mlrus = kvzalloc(struct_size(mlrus, mlru, size), GFP_KERNEL);
 	if (!mlrus)
 		return -ENOMEM;
 
-	if (memcg_init_list_lru_range(mlrus, 0, size)) {
-		kvfree(mlrus);
-		return -ENOMEM;
-	}
 	RCU_INIT_POINTER(lru->mlrus, mlrus);
 
 	return 0;
@@ -422,13 +431,9 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
 	if (!new)
 		return -ENOMEM;
 
-	if (memcg_init_list_lru_range(new, old_size, new_size)) {
-		kvfree(new);
-		return -ENOMEM;
-	}
-
 	spin_lock_irq(&lru->lock);
 	memcpy(&new->mlru, &old->mlru, flex_array_size(new, mlru, old_size));
+	memset(&new->mlru[old_size], 0, flex_array_size(new, mlru, new_size - old_size));
 	rcu_assign_pointer(lru->mlrus, new);
 	spin_unlock_irq(&lru->lock);
 
@@ -436,20 +441,6 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
 	return 0;
 }
 
-static void memcg_cancel_update_list_lru(struct list_lru *lru,
-					 int old_size, int new_size)
-{
-	struct list_lru_memcg *mlrus;
-
-	mlrus = rcu_dereference_protected(lru->mlrus,
-					  lockdep_is_held(&list_lrus_mutex));
-	/*
-	 * Do not bother shrinking the array back to the old size, because we
-	 * cannot handle allocation failures here.
-	 */
-	memcg_destroy_list_lru_range(mlrus, old_size, new_size);
-}
-
 int memcg_update_all_list_lrus(int new_size)
 {
 	int ret = 0;
@@ -460,15 +451,10 @@ int memcg_update_all_list_lrus(int new_size)
 	list_for_each_entry(lru, &memcg_list_lrus, list) {
 		ret = memcg_update_list_lru(lru, old_size, new_size);
 		if (ret)
-			goto fail;
+			break;
 	}
-out:
 	mutex_unlock(&list_lrus_mutex);
 	return ret;
-fail:
-	list_for_each_entry_continue_reverse(lru, &memcg_list_lrus, list)
-		memcg_cancel_update_list_lru(lru, old_size, new_size);
-	goto out;
 }
 
 static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
@@ -485,6 +471,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	spin_lock_irq(&nlru->lock);
 
 	src = list_lru_from_memcg_idx(lru, nid, src_idx);
+	if (!src)
+		goto out;
 	dst = list_lru_from_memcg_idx(lru, nid, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
@@ -494,7 +482,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 		set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 		src->nr_items = 0;
 	}
-
+out:
 	spin_unlock_irq(&nlru->lock);
 }
 
@@ -505,15 +493,41 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 
 	for_each_node(i)
 		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
+
+	memcg_list_lru_free(lru, src_idx);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
+void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst)
 {
+	struct cgroup_subsys_state *css;
 	struct list_lru *lru;
+	int src_idx = src->kmemcg_id;
+
+	/*
+	 * Change kmemcg_id of this cgroup and all its descendants to the
+	 * parent's id, and then move all entries from this cgroup's list_lrus
+	 * to ones of the parent.
+	 *
+	 * After we have finished, all list_lrus corresponding to this cgroup
+	 * are guaranteed to remain empty. So we can safely free this cgroup's
+	 * list lrus in memcg_list_lru_free().
+	 *
+	 * Changing ->kmemcg_id to the parent can prevent memcg_list_lru_alloc()
+	 * from allocating list lrus for this cgroup after memcg_list_lru_free()
+	 * call.
+	 */
+	rcu_read_lock();
+	css_for_each_descendant_pre(css, &src->css) {
+		struct mem_cgroup *memcg;
+
+		memcg = mem_cgroup_from_css(css);
+		memcg->kmemcg_id = dst->kmemcg_id;
+	}
+	rcu_read_unlock();
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &memcg_list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_memcg);
+		memcg_drain_list_lru(lru, src_idx, dst);
 	mutex_unlock(&list_lrus_mutex);
 }
 
@@ -528,7 +542,7 @@ static bool memcg_list_lru_allocated(struct mem_cgroup *memcg,
 		return true;
 
 	rcu_read_lock();
-	allocated = !!rcu_dereference(lru->mlrus)->mlru[idx];
+	allocated = !!rcu_access_pointer(rcu_dereference(lru->mlrus)->mlru[idx]);
 	rcu_read_unlock();
 
 	return allocated;
@@ -576,11 +590,12 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	mlrus = rcu_dereference_protected(lru->mlrus, true);
 	while (i--) {
 		int index = table[i].memcg->kmemcg_id;
+		struct list_lru_per_memcg *mlru = table[i].mlru;
 
-		if (mlrus->mlru[index])
-			kfree(table[i].mlru);
+		if (index < 0 || rcu_dereference_protected(mlrus->mlru[index], true))
+			kfree(mlru);
 		else
-			mlrus->mlru[index] = table[i].mlru;
+			rcu_assign_pointer(mlrus->mlru[index], mlru);
 	}
 	spin_unlock_irqrestore(&lru->lock, flags);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5bdf5184681c..c8d39d7fc2e5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3655,6 +3655,10 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
 	memcg_reparent_objcgs(memcg, parent);
 
+	/*
+	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * Cache it to local @kmemcg_id.
+	 */
 	kmemcg_id = memcg->kmemcg_id;
 
 	/*
@@ -3663,7 +3667,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	 * The ordering is imposed by list_lru_node->lock taken by
 	 * memcg_drain_all_list_lrus().
 	 */
-	memcg_drain_all_list_lrus(kmemcg_id, parent);
+	memcg_drain_all_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

