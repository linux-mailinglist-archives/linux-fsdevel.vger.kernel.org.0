Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E4E37A526
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 12:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhEKKy3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhEKKyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 06:54:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA92C061343
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:53:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n16so10631460plf.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIJ6Bm+nra3MZOT6RE/mgqHKmSIemQHQMXkUmKw30r0=;
        b=pl7J7yLOZ4rOnofgbxw2wUdk44kF9RmMAtEsMMXd/H7V7yElZCN3YgC7zID7YH9w2k
         V1iDFYyYJxobgTVULxxayQo38dXv96Bj5YxCevPD62DVdOol0rN7G+Z4+P+IZDTU/eCT
         +Bvu2eJ4mHzI0mYjLcbqGrhq3sYoZ2QZqeo+xkKhAQqzePyYwsfv+J2eYM4qpNVxN0gC
         Sjz1+RnRurRW55DriTN/MjiPBM1LAWqk103Ikry3uY6de9gHLISjxV+Fjyo0G7cQKOp4
         vQBlDMpr5vTnvbVpKjZE2Fn/PzHBTovB3mutLhmY1z7fGOjgRd62j+TrEte/kYcgmL14
         JAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIJ6Bm+nra3MZOT6RE/mgqHKmSIemQHQMXkUmKw30r0=;
        b=YJ6RoayCui6n6JAFGdTLe6wBJDCgcOjCGxDz7IEvGuyAlFIFLvoVCC4hBHzv/3DZ1E
         jXiEtezVrZQLppsmrWCh+7RMoKOQyKi295+oc7/b2vI+PKHGpSBnUdOm9Tg3ocXG+ZGu
         13ow0YMg4BND8KxyT44Rv47U6kvWITVeFQcm4jX+Dw3nWGL8feV09BFRgQ7VsqlBssGf
         +vuI37ShLCcv2104sm66bpoxVDrcfw5AyMj+0K7syjYSF5jqsWknCXniwe8MVyravYNx
         OVKLidYlPJdK1IkijCfmdRtVG3aVIYc8mHLGzrNEJt2luhRoeNuBSRDz04QwQJjrLkTY
         nZjw==
X-Gm-Message-State: AOAM531LwAOeO+h5NLeJ3m/VWcV7RbetqmOMdaTFBchXJ+4UQww2CRgj
        U7xURuT9Clh8+Td5iD+14jDh0w==
X-Google-Smtp-Source: ABdhPJwS4BSVz9Do8hecfmV7Egr+Ohgvhurob05IY2qYSmo8rnJdjXQn+1WWEd7HbkBJW2ihWC+ioQ==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr32078079pjo.45.1620730387003;
        Tue, 11 May 2021 03:53:07 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.52.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:53:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 15/17] mm: list_lru: allocate list_lru_one only when needed
Date:   Tue, 11 May 2021 18:46:45 +0800
Message-Id: <20210511104647.604-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
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

Now the infrastructure for dynamic memory allocation is ready, so remove
statically allocated memory code to save memory.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |   6 ++-
 mm/list_lru.c            | 122 +++++++++++++++++++++++++----------------------
 mm/memcontrol.c          |   6 ++-
 3 files changed, 74 insertions(+), 60 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 2b2fdb4de96a..7d4346b93b24 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -32,6 +32,7 @@ struct list_lru_one {
 };
 
 struct list_lru_per_memcg {
+	struct rcu_head		rcu;
 	/* array of per cgroup per node lists, indexed by node id */
 	struct list_lru_one	nodes[0];
 };
@@ -39,7 +40,7 @@ struct list_lru_per_memcg {
 struct list_lru_memcg {
 	struct rcu_head			rcu;
 	/* array of per cgroup lists, indexed by memcg_cache_id */
-	struct list_lru_per_memcg	*lrus[0];
+	struct list_lru_per_memcg __rcu	*lrus[0];
 };
 
 struct list_lru_node {
@@ -75,7 +76,8 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
+void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
+			       struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 182cb2a2e64f..b5ed6b797a48 100644
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
 
@@ -354,22 +363,6 @@ static struct list_lru_per_memcg *list_lru_per_memcg_alloc(gfp_t gfp)
 	return lru;
 }
 
-static int memcg_init_list_lru_range(struct list_lru_memcg *memcg_lrus,
-				     int begin, int end)
-{
-	int i;
-
-	for (i = begin; i < end; i++) {
-		memcg_lrus->lrus[i] = list_lru_per_memcg_alloc(GFP_KERNEL);
-		if (!memcg_lrus->lrus[i])
-			goto fail;
-	}
-	return 0;
-fail:
-	memcg_destroy_list_lru_range(memcg_lrus, begin, i);
-	return -ENOMEM;
-}
-
 static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
 	struct list_lru_memcg *memcg_lrus;
@@ -382,15 +375,11 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 
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
@@ -424,13 +413,9 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
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
 
@@ -439,20 +424,6 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
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
@@ -463,15 +434,10 @@ int memcg_update_all_list_lrus(int new_size)
 	list_for_each_entry(lru, &list_lrus, list) {
 		ret = memcg_update_list_lru(lru, old_size, new_size);
 		if (ret)
-			goto fail;
+			break;
 	}
-out:
 	mutex_unlock(&list_lrus_mutex);
 	return ret;
-fail:
-	list_for_each_entry_continue_reverse(lru, &list_lrus, list)
-		memcg_cancel_update_list_lru(lru, old_size, new_size);
-	goto out;
 }
 
 static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
@@ -488,6 +454,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	spin_lock_irq(&nlru->lock);
 
 	src = list_lru_from_memcg_idx(lru, nid, src_idx);
+	if (!src)
+		goto out;
 	dst = list_lru_from_memcg_idx(lru, nid, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
@@ -497,10 +465,32 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 		set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 		src->nr_items = 0;
 	}
-
+out:
 	spin_unlock_irq(&nlru->lock);
 }
 
+static void list_lru_per_memcg_free(struct list_lru *lru, int src_idx)
+{
+	struct list_lru_memcg *memcg_lrus;
+	struct list_lru_per_memcg *mlru;
+
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
+}
+
 static void memcg_drain_list_lru(struct list_lru *lru,
 				 int src_idx, struct mem_cgroup *dst_memcg)
 {
@@ -508,11 +498,28 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 
 	for_each_node(i)
 		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
+
+	list_lru_per_memcg_free(lru, src_idx);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
+void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
+			       struct mem_cgroup *dst_memcg)
 {
 	struct list_lru *lru;
+	int src_idx = src_memcg->kmemcg_id;
+
+	/*
+	 * Change kmemcg_id of this cgroup to the parent's id, and then move
+	 * all entries from this cgroup's list_lrus to ones of the parent.
+	 *
+	 * After we have finished, all list_lrus corresponding to this cgroup
+	 * are guaranteed to remain empty. So we can safely free this cgroup's
+	 * list lrus which is implemented in list_lru_per_memcg_free().
+	 * Changing ->kmemcg_id to the parent can prevent list_lru_memcg_alloc()
+	 * from allocating list lrus for this cgroup after calling
+	 * list_lru_per_memcg_free().
+	 */
+	src_memcg->kmemcg_id = dst_memcg->kmemcg_id;
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
@@ -531,7 +538,7 @@ static bool list_lru_per_memcg_allocated(struct list_lru *lru,
 
 	rcu_read_lock();
 	memcg_lrus = rcu_dereference(lru->memcg_lrus);
-	if (memcg_lrus->lrus[idx]) {
+	if (rcu_access_pointer(memcg_lrus->lrus[idx])) {
 		rcu_read_unlock();
 		return true;
 	}
@@ -590,11 +597,12 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
 	while (i--) {
 		int idx = memcg_cache_id(table[i].memcg);
+		struct list_lru_per_memcg *mlru = table[i].mlru;
 
-		if (memcg_lrus->lrus[idx])
-			kfree(table[i].mlru);
+		if (idx < 0 || rcu_dereference_protected(memcg_lrus->lrus[idx], true))
+			kfree(mlru);
 		else
-			memcg_lrus->lrus[idx] = table[i].mlru;
+			rcu_assign_pointer(memcg_lrus->lrus[idx], mlru);
 	}
 	spin_unlock_irqrestore(&lru->lock, flags);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6aace39fd1a4..879d2ff8d81f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3484,11 +3484,15 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
 	memcg_reparent_objcgs(memcg, parent);
 
+	/*
+	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * Cache it to @kmemcg_id.
+	 */
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
 	/* memcg_reparent_objcgs() must be called before this. */
-	memcg_drain_all_list_lrus(kmemcg_id, parent);
+	memcg_drain_all_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

