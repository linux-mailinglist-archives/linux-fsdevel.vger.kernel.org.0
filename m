Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7440A86F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhINHrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbhINHqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:46:14 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2805C061341
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k23so8274967pji.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxvfsGkKeBEY2itVvQZ6+QMFfMS4SNIyE7u/7vw52Iw=;
        b=MmJn02iHhdABrRmbmf8BSrQ+CdzyPJhawXtW7d4P1ZH5LGYmm511on5hCVAbNivQrq
         7Ah82nMAtVWA14gMJhkkKms/9ET0uolPvTyu5/KxF2IYvzgLUf9nnN7hPhbMLsPIo4xQ
         dHB73TJQ8g9idDHpQSTf29yr2VpMfumIwW8SUOplv8bjy3tLex8OcqsFCowg7wpepoTQ
         8ZsTatW4f4V541LuK1IGldIO6HTHnDuPI6Sa4B8kFtBoMLEMaRZWyiasAHy+dGy5gU+/
         UYb1F1te4TIFalhk9s/dyhQgtjP4amRaFGOPlmmJkdHcenhe1vCJQjNbOL9WxKDOyJwy
         BF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxvfsGkKeBEY2itVvQZ6+QMFfMS4SNIyE7u/7vw52Iw=;
        b=k4/ZIOO/FaPlPGMeeCfzlR7ZCVMZva8nzv++ql5dmaz4noNAczQYSvy0vhwsFrrAPw
         K32MGOiViH8P2oRbHHtotuRS5i99Ur/Vyu8vEYr2ZKd6FfJeZG3IywEmxS6BJaHCbZP2
         Qk5/k2SmAxUPR92HSwcSBzOuZD0+MVguuVotN6iF0rEvWkSf0iXURl5X5A0ZZSJNPH84
         XNt1ZLU2+dVdT6Ft8MyfCbeTQnqQ4O8IANQe3k+PK/4J1aTTRMpvHsOG2P1cEVnczXId
         R/XvfIaymongxYliuXmYPqfFaeKnwU/hlYs8je4ZhZuD5Djkx0fdbL+tRgAfwV4SfHiI
         W0IQ==
X-Gm-Message-State: AOAM533aheVlPl5SOtCsQfiSp4k7RlPZ4ponsc2SywRphnWBJbw6eMHp
        sNK1Vff9BIHJK16KpwV+jaiOrQ==
X-Google-Smtp-Source: ABdhPJwNmqVn718jVTEAY+i2ZrXpt4iydXzHIiOuyKDSgGMzgjWVqpcENduFVuPpSXunxnd62/6VzQ==
X-Received: by 2002:a17:90a:4ce3:: with SMTP id k90mr538007pjh.237.1631605278515;
        Tue, 14 Sep 2021 00:41:18 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.41.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:41:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 70/76] mm: list_lru: allocate list_lru_one only when needed
Date:   Tue, 14 Sep 2021 15:29:32 +0800
Message-Id: <20210914072938.6440-71-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/linux/list_lru.h |   8 +--
 mm/list_lru.c            | 125 +++++++++++++++++++++++++++--------------------
 mm/memcontrol.c          |   7 ++-
 3 files changed, 81 insertions(+), 59 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 50a3144016b4..62f407831b8c 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -32,14 +32,15 @@ struct list_lru_one {
 };
 
 struct list_lru_per_memcg {
+	struct rcu_head		rcu;
 	/* array of per cgroup per node lists, indexed by node id */
-	struct list_lru_one	nodes[0];
+	struct list_lru_one	nodes[];
 };
 
 struct list_lru_memcg {
 	struct rcu_head			rcu;
 	/* array of per cgroup lists, indexed by memcg_cache_id */
-	struct list_lru_per_memcg	*lrus[];
+	struct list_lru_per_memcg __rcu	*lrus[];
 };
 
 struct list_lru_node {
@@ -76,7 +77,8 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
+void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
+			       struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index eea29eb4cf48..48651c29a9d1 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -60,8 +60,12 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 	 */
 	memcg_lrus = rcu_dereference_check(lru->memcg_lrus,
 					   lockdep_is_held(&nlru->lock));
-	if (memcg_lrus && idx >= 0)
-		return &memcg_lrus->lrus[idx]->nodes[nid];
+	if (memcg_lrus && idx >= 0) {
+		struct list_lru_per_memcg *mlru;
+
+		mlru = rcu_dereference_check(memcg_lrus->lrus[idx], true);
+		return mlru ? &mlru->nodes[nid] : NULL;
+	}
 	return &nlru->lru;
 }
 
@@ -184,11 +188,12 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 				 int nid, struct mem_cgroup *memcg)
 {
 	struct list_lru_one *l;
-	long count;
+	long count = 0;
 
 	rcu_read_lock();
 	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
-	count = READ_ONCE(l->nr_items);
+	if (l)
+		count = READ_ONCE(l->nr_items);
 	rcu_read_unlock();
 
 	if (unlikely(count < 0))
@@ -217,8 +222,11 @@ __list_lru_walk_one(struct list_lru *lru, int nid, int memcg_idx,
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
 
@@ -262,6 +270,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid, int memcg_idx,
 			BUG();
 		}
 	}
+out:
 	return isolated;
 }
 
@@ -354,20 +363,26 @@ static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
 	return lru;
 }
 
-static int memcg_init_list_lru_range(struct list_lru_memcg *memcg_lrus,
-				     int begin, int end)
+static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	int i;
+	struct list_lru_memcg *memcg_lrus;
+	struct list_lru_per_memcg *mlru;
 
-	for (i = begin; i < end; i++) {
-		memcg_lrus->lrus[i] = memcg_list_lru_alloc(GFP_KERNEL);
-		if (!memcg_lrus->lrus[i])
-			goto fail;
-	}
-	return 0;
-fail:
-	memcg_destroy_list_lru_range(memcg_lrus, begin, i);
-	return -ENOMEM;
+	spin_lock_irq(&lru->lock);
+	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
+	mlru = rcu_dereference_protected(memcg_lrus->lrus[src_idx], true);
+	if (mlru)
+		rcu_assign_pointer(memcg_lrus->lrus[src_idx], NULL);
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
@@ -381,15 +396,11 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 
 	spin_lock_init(&lru->lock);
 
-	memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
+	memcg_lrus = kvzalloc(sizeof(*memcg_lrus) +
 			      size * sizeof(memcg_lrus->lrus[0]), GFP_KERNEL);
 	if (!memcg_lrus)
 		return -ENOMEM;
 
-	if (memcg_init_list_lru_range(memcg_lrus, 0, size)) {
-		kvfree(memcg_lrus);
-		return -ENOMEM;
-	}
 	RCU_INIT_POINTER(lru->memcg_lrus, memcg_lrus);
 
 	return 0;
@@ -423,13 +434,9 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
 	if (!new)
 		return -ENOMEM;
 
-	if (memcg_init_list_lru_range(new, old_size, new_size)) {
-		kvfree(new);
-		return -ENOMEM;
-	}
-
 	spin_lock_irq(&lru->lock);
 	memcpy(&new->lrus, &old->lrus, old_size * sizeof(new->lrus[0]));
+	memset(&new->lrus[old_size], 0, (new_size - old_size) * sizeof(new->lrus[0]));
 	rcu_assign_pointer(lru->memcg_lrus, new);
 	spin_unlock_irq(&lru->lock);
 
@@ -437,20 +444,6 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
 	return 0;
 }
 
-static void memcg_cancel_update_list_lru(struct list_lru *lru,
-					 int old_size, int new_size)
-{
-	struct list_lru_memcg *memcg_lrus;
-
-	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus,
-					       lockdep_is_held(&list_lrus_mutex));
-	/*
-	 * Do not bother shrinking the array back to the old size, because we
-	 * cannot handle allocation failures here.
-	 */
-	memcg_destroy_list_lru_range(memcg_lrus, old_size, new_size);
-}
-
 int memcg_update_all_list_lrus(int new_size)
 {
 	int ret = 0;
@@ -461,15 +454,10 @@ int memcg_update_all_list_lrus(int new_size)
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
@@ -486,6 +474,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	spin_lock_irq(&nlru->lock);
 
 	src = list_lru_from_memcg_idx(lru, nid, src_idx);
+	if (!src)
+		goto out;
 	dst = list_lru_from_memcg_idx(lru, nid, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
@@ -495,7 +485,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 		set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 		src->nr_items = 0;
 	}
-
+out:
 	spin_unlock_irq(&nlru->lock);
 }
 
@@ -506,11 +496,37 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 
 	for_each_node(i)
 		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
+
+	memcg_list_lru_free(lru, src_idx);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
+void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
+			       struct mem_cgroup *dst_memcg)
 {
+	struct cgroup_subsys_state *css;
 	struct list_lru *lru;
+	int src_idx = src_memcg->kmemcg_id;
+
+	/*
+	 * Change kmemcg_id of this cgroup and all its descendants to the
+	 * parent's id, and then move all entries from this cgroup's list_lrus
+	 * to ones of the parent.
+	 *
+	 * After we have finished, all list_lrus corresponding to this cgroup
+	 * are guaranteed to remain empty. So we can safely free this cgroup's
+	 * list lrus which is freed in memcg_list_lru_free().
+	 * Changing ->kmemcg_id to the parent can prevent list_lru_memcg_alloc()
+	 * from allocating list lrus for this cgroup after calling
+	 * memcg_list_lru_free().
+	 */
+	rcu_read_lock();
+	css_for_each_descendant_pre(css, &src_memcg->css) {
+		struct mem_cgroup *memcg;
+
+		memcg = mem_cgroup_from_css(css);
+		memcg->kmemcg_id = dst_memcg->kmemcg_id;
+	}
+	rcu_read_unlock();
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &memcg_list_lrus, list)
@@ -529,7 +545,7 @@ static bool memcg_list_lru_skip_alloc(struct list_lru *lru,
 
 	rcu_read_lock();
 	memcg_lrus = rcu_dereference(lru->memcg_lrus);
-	if (memcg_lrus->lrus[idx]) {
+	if (rcu_access_pointer(memcg_lrus->lrus[idx])) {
 		rcu_read_unlock();
 		return true;
 	}
@@ -544,7 +560,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	struct list_lru_memcg *memcg_lrus;
 	int i;
 
-	struct list_lru_memcg {
+	struct list_lru_memcg_table {
 		struct list_lru_per_memcg *mlru;
 		struct mem_cgroup *memcg;
 	} *table;
@@ -588,11 +604,12 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
 	while (i--) {
 		int index = memcg_cache_id(table[i].memcg);
+		struct list_lru_per_memcg *mlru = table[i].mlru;
 
-		if (memcg_lrus->lrus[index])
-			kfree(table[i].mlru);
+		if (index < 0 || rcu_dereference_protected(memcg_lrus->lrus[index], true))
+			kfree(mlru);
 		else
-			memcg_lrus->lrus[index] = table[i].mlru;
+			rcu_assign_pointer(memcg_lrus->lrus[index], mlru);
 	}
 	spin_unlock_irqrestore(&lru->lock, flags);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0e8c8d8465e5..2045cd8b1d7f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3635,10 +3635,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
 	memcg_reparent_objcgs(memcg, parent);
 
+	/*
+	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * Cache it to @kmemcg_id.
+	 */
 	kmemcg_id = memcg->kmemcg_id;
 
-	/* memcg_reparent_objcgs() must be called before this. */
-	memcg_drain_all_list_lrus(kmemcg_id, parent);
+	memcg_drain_all_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

