Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A540A78B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbhINHfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbhINHfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:35:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508EDC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1444920pjc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1kAf0XYLhQyaq0Tfwg29KiVIv9l+PC00VybqIGq6HA=;
        b=BfCSpRlfLt480JnDBDwIZcbb16eriJDkUQJs9r2y8Ydzzg++/KQA9DBYR4pEWZOu/8
         MTSRuzhQHDWC+emsX0t3C8Z5Jw2hSoB5iLcjEpBHHhLcajsrtJQksFMLTw0pNY2bC8AK
         L2z8QpO7P3Rjs9xeE30uvW1Z+YUhP9M65m6J/YVMeBb45MoT3qrF4ZNb3FZD4F0nZWuk
         REKsakZTZ58lbX483F2Oqt0Q4vLn6bAi++c5CbH6bbxWEuxGJbhXXb78b9yk9Swt5jkV
         Kr0aYN6ylfPtfYFB1W4OHRMKpg2Dh1cOPiO3cF/Nn5qEEugNDNFbmSlMCvPeL2ruyBzS
         Pbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1kAf0XYLhQyaq0Tfwg29KiVIv9l+PC00VybqIGq6HA=;
        b=YJMDqj77V/Ld02DbnPsvyN8sPclVMGRCqoFoZvm8dPlslv0DEwkRkq2C8ZqL4Flql5
         A0l5fq3HFbaa9nJon5/4iOaBWCNzy3ZgUGVyIZspXgKaVL/aSom0sNJNIqUC37kFW3/w
         IxCJkqVKKoRqznGwColyA2+JuiNLOYmEtPjQWC9x+4nNNrN+v4rVExxR3zyMn6F+A6YD
         3JowSgLCKEmGwi8wLMlWn4wrx9u0c5McdM4+oal7evQob241ilvCJHF98Lq6yDBFYHqk
         7h7SMChpe+8Tp84+PfZlCgPhDc4nY3gqRl7WOe5vhuF5q9PexzOpikkC6PNQp3GGpIb5
         /7Jw==
X-Gm-Message-State: AOAM530GS3LQTR7YwIcF3I1NmfgM3SPGCjkbYg7FciWc4dy5rYuxw0ob
        5RSsG6hs3yrhRSRt+FZfP6TLYg==
X-Google-Smtp-Source: ABdhPJwHvDvAJKRV7EYhcf5UWWuf/yjQ4SAMKBm3iQathHWPnBgxU68AQllTLW+xIZHjmMlY0QL1GA==
X-Received: by 2002:a17:90a:1c81:: with SMTP id t1mr545581pjt.170.1631604830756;
        Tue, 14 Sep 2021 00:33:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:50 -0700 (PDT)
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
Subject: [PATCH v3 08/76] mm: introduce kmem_cache_alloc_lru
Date:   Tue, 14 Sep 2021 15:28:30 +0800
Message-Id: <20210914072938.6440-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We currently allocate scope for every memcg to be able to tracked on
every superblock instantiated in the system, regardless of whether
that superblock is even accessible to that memcg.

These huge memcg counts come from container hosts where memcgs are
confined to just a small subset of the total number of superblocks
that instantiated at any given point in time.

For these systems with huge container counts, list_lru does not need
the capability of tracking every memcg on every superblock. What it
comes down to is that adding the memcg to the list_lru at the first
insert. So introduce kmem_cache_alloc_lru to allocate objects and its
list_lru. In the later patch, we will convert all inode and dentry
allocation from kmem_cache_alloc to kmem_cache_alloc_lru.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h   |   3 ++
 include/linux/memcontrol.h |  14 ++++++
 include/linux/slab.h       |   3 ++
 mm/list_lru.c              | 114 +++++++++++++++++++++++++++++++++++++++++----
 mm/memcontrol.c            |  14 ------
 mm/slab.c                  |  39 +++++++++++-----
 mm/slab.h                  |  17 ++++++-
 mm/slob.c                  |   6 +++
 mm/slub.c                  |  42 +++++++++++------
 9 files changed, 202 insertions(+), 50 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 2b32dbd89214..50a3144016b4 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -56,11 +56,14 @@ struct list_lru {
 	struct list_head	list;
 	int			shrinker_id;
 	bool			memcg_aware;
+	/* protects ->memcg_lrus->lrus[i] */
+	spinlock_t		lock;
 	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
 	struct list_lru_memcg	__rcu *memcg_lrus;
 #endif
 };
 
+int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t gfp);
 void list_lru_destroy(struct list_lru *lru);
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key, struct shrinker *shrinker);
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7267cf9d1f3d..06ee32822fd4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -520,6 +520,20 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+retry:
+	memcg = obj_cgroup_memcg(objcg);
+	if (unlikely(!css_tryget(&memcg->css)))
+		goto retry;
+	rcu_read_unlock();
+
+	return memcg;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * folio_memcg_kmem - Check if the folio has the memcg_kmem flag set.
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6ce826d8194d..441f4e87cb34 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -135,6 +135,7 @@
 
 #include <linux/kasan.h>
 
+struct list_lru;
 struct mem_cgroup;
 /*
  * struct kmem_cache related prototypes
@@ -429,6 +430,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 __alloc_size(1)
 void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __malloc;
 void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_kmalloc_alignment __malloc;
+void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
+			   gfp_t gfpflags) __assume_kmalloc_alignment __malloc;
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 /*
diff --git a/mm/list_lru.c b/mm/list_lru.c
index f1c73b53af9a..eea29eb4cf48 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -339,22 +339,30 @@ static void memcg_destroy_list_lru_range(struct list_lru_memcg *memcg_lrus,
 		kfree(memcg_lrus->lrus[i]);
 }
 
+static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
+{
+	int nid;
+	struct list_lru_per_memcg *lru;
+
+	lru = kmalloc(struct_size(lru, nodes, nr_node_ids), gfp);
+	if (!lru)
+		return NULL;
+
+	for_each_node(nid)
+		init_one_lru(&lru->nodes[nid]);
+
+	return lru;
+}
+
 static int memcg_init_list_lru_range(struct list_lru_memcg *memcg_lrus,
 				     int begin, int end)
 {
 	int i;
 
 	for (i = begin; i < end; i++) {
-		int nid;
-		struct list_lru_per_memcg *lru;
-
-		lru = kmalloc(struct_size(lru, nodes, nr_node_ids), GFP_KERNEL);
-		if (!lru)
+		memcg_lrus->lrus[i] = memcg_list_lru_alloc(GFP_KERNEL);
+		if (!memcg_lrus->lrus[i])
 			goto fail;
-
-		for_each_node(nid)
-			init_one_lru(&lru->nodes[nid]);
-		memcg_lrus->lrus[i] = lru;
 	}
 	return 0;
 fail:
@@ -371,6 +379,8 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 	if (!memcg_aware)
 		return 0;
 
+	spin_lock_init(&lru->lock);
+
 	memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
 			      size * sizeof(memcg_lrus->lrus[0]), GFP_KERNEL);
 	if (!memcg_lrus)
@@ -418,8 +428,11 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
 		return -ENOMEM;
 	}
 
+	spin_lock_irq(&lru->lock);
 	memcpy(&new->lrus, &old->lrus, old_size * sizeof(new->lrus[0]));
 	rcu_assign_pointer(lru->memcg_lrus, new);
+	spin_unlock_irq(&lru->lock);
+
 	kvfree_rcu(old, rcu);
 	return 0;
 }
@@ -504,6 +517,89 @@ void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
 		memcg_drain_list_lru(lru, src_idx, dst_memcg);
 	mutex_unlock(&list_lrus_mutex);
 }
+
+static bool memcg_list_lru_skip_alloc(struct list_lru *lru,
+				      struct mem_cgroup *memcg)
+{
+	struct list_lru_memcg *memcg_lrus;
+	int idx = memcg_cache_id(memcg);
+
+	if (unlikely(idx < 0))
+		return true;
+
+	rcu_read_lock();
+	memcg_lrus = rcu_dereference(lru->memcg_lrus);
+	if (memcg_lrus->lrus[idx]) {
+		rcu_read_unlock();
+		return true;
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
+int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t gfp)
+{
+	unsigned long flags;
+	struct list_lru_memcg *memcg_lrus;
+	int i;
+
+	struct list_lru_memcg {
+		struct list_lru_per_memcg *mlru;
+		struct mem_cgroup *memcg;
+	} *table;
+
+	if (!list_lru_memcg_aware(lru))
+		return 0;
+
+	if (memcg_list_lru_skip_alloc(lru, memcg))
+		return 0;
+
+	/*
+	 * The allocated list_lru_per_memcg array is not accounted directly.
+	 * Moreover, it should not come from DMA buffer and is not readily
+	 * reclaimable. So those GFP bits should be masked off.
+	 */
+	gfp &= ~(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT | __GFP_ZERO);
+	table = kmalloc_array(memcg->css.cgroup->level, sizeof(*table), gfp);
+	if (!table)
+		return -ENOMEM;
+
+	/*
+	 * Because the list_lru can be reparented to the parent cgroup's
+	 * list_lru, we should make sure that this cgroup and all its
+	 * ancestors have allocated list_lru_per_memcg.
+	 */
+	for (i = 0; memcg; memcg = parent_mem_cgroup(memcg), i++) {
+		if (memcg_list_lru_skip_alloc(lru, memcg))
+			break;
+
+		table[i].memcg = memcg;
+		table[i].mlru = memcg_list_lru_alloc(gfp);
+		if (!table[i].mlru) {
+			while (i--)
+				kfree(table[i].mlru);
+			kfree(table);
+			return -ENOMEM;
+		}
+	}
+
+	spin_lock_irqsave(&lru->lock, flags);
+	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
+	while (i--) {
+		int index = memcg_cache_id(table[i].memcg);
+
+		if (memcg_lrus->lrus[index])
+			kfree(table[i].mlru);
+		else
+			memcg_lrus->lrus[index] = table[i].mlru;
+	}
+	spin_unlock_irqrestore(&lru->lock, flags);
+
+	kfree(table);
+
+	return 0;
+}
 #else
 static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a85b52968666..0e8c8d8465e5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2763,20 +2763,6 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }
 
-static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
-{
-	struct mem_cgroup *memcg;
-
-	rcu_read_lock();
-retry:
-	memcg = obj_cgroup_memcg(objcg);
-	if (unlikely(!css_tryget(&memcg->css)))
-		goto retry;
-	rcu_read_unlock();
-
-	return memcg;
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * The allocated objcg pointers array is not accounted directly.
diff --git a/mm/slab.c b/mm/slab.c
index d0f725637663..9a001aabc77b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3219,7 +3219,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
 	bool init = false;
 
 	flags &= gfp_allowed_mask;
-	cachep = slab_pre_alloc_hook(cachep, &objcg, 1, flags);
+	cachep = slab_pre_alloc_hook(cachep, NULL, &objcg, 1, flags);
 	if (unlikely(!cachep))
 		return NULL;
 
@@ -3295,7 +3295,8 @@ __do_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 #endif /* CONFIG_NUMA */
 
 static __always_inline void *
-slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned long caller)
+slab_alloc(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
+	   size_t orig_size, unsigned long caller)
 {
 	unsigned long save_flags;
 	void *objp;
@@ -3303,7 +3304,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, size_t orig_size, unsigned lo
 	bool init = false;
 
 	flags &= gfp_allowed_mask;
-	cachep = slab_pre_alloc_hook(cachep, &objcg, 1, flags);
+	cachep = slab_pre_alloc_hook(cachep, lru, &objcg, 1, flags);
 	if (unlikely(!cachep))
 		return NULL;
 
@@ -3492,6 +3493,18 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 	__free_one(ac, objp);
 }
 
+static __always_inline
+void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
+			     gfp_t flags)
+{
+	void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
+
+	trace_kmem_cache_alloc(_RET_IP_, ret,
+			       cachep->object_size, cachep->size, flags);
+
+	return ret;
+}
+
 /**
  * kmem_cache_alloc - Allocate an object
  * @cachep: The cache to allocate from.
@@ -3504,15 +3517,17 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
  */
 void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
-	void *ret = slab_alloc(cachep, flags, cachep->object_size, _RET_IP_);
-
-	trace_kmem_cache_alloc(_RET_IP_, ret,
-			       cachep->object_size, cachep->size, flags);
-
-	return ret;
+	return __kmem_cache_alloc_lru(cachep, NULL, flags);
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
+void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
+			   gfp_t flags)
+{
+	return __kmem_cache_alloc_lru(cachep, lru, flags);
+}
+EXPORT_SYMBOL(kmem_cache_alloc_lru);
+
 static __always_inline void
 cache_alloc_debugcheck_after_bulk(struct kmem_cache *s, gfp_t flags,
 				  size_t size, void **p, unsigned long caller)
@@ -3529,7 +3544,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	size_t i;
 	struct obj_cgroup *objcg = NULL;
 
-	s = slab_pre_alloc_hook(s, &objcg, size, flags);
+	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
 	if (!s)
 		return 0;
 
@@ -3570,7 +3585,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 {
 	void *ret;
 
-	ret = slab_alloc(cachep, flags, size, _RET_IP_);
+	ret = slab_alloc(cachep, NULL, flags, size, _RET_IP_);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc(_RET_IP_, ret,
@@ -3697,7 +3712,7 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
-	ret = slab_alloc(cachep, flags, size, caller);
+	ret = slab_alloc(cachep, NULL, flags, size, caller);
 
 	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc(caller, ret,
diff --git a/mm/slab.h b/mm/slab.h
index 58c01a34e5b8..c6fbfda824df 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -46,6 +46,7 @@ struct kmem_cache {
 #include <linux/kmemleak.h>
 #include <linux/random.h>
 #include <linux/sched/mm.h>
+#include <linux/list_lru.h>
 
 /*
  * State of the slab allocator.
@@ -269,6 +270,7 @@ static inline size_t obj_full_size(struct kmem_cache *s)
  * Returns false if the allocation should fail.
  */
 static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+					     struct list_lru *lru,
 					     struct obj_cgroup **objcgp,
 					     size_t objects, gfp_t flags)
 {
@@ -284,6 +286,17 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 	if (!objcg)
 		return true;
 
+	if (lru) {
+		struct mem_cgroup *memcg = get_mem_cgroup_from_objcg(objcg);
+
+		if (list_lru_memcg_alloc(lru, memcg, flags)) {
+			css_put(&memcg->css);
+			obj_cgroup_put(objcg);
+			return false;
+		}
+		css_put(&memcg->css);
+	}
+
 	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s))) {
 		obj_cgroup_put(objcg);
 		return false;
@@ -386,6 +399,7 @@ static inline void memcg_free_page_obj_cgroups(struct page *page)
 }
 
 static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+					     struct list_lru *lru,
 					     struct obj_cgroup **objcgp,
 					     size_t objects, gfp_t flags)
 {
@@ -484,6 +498,7 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
 }
 
 static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
+						     struct list_lru *lru,
 						     struct obj_cgroup **objcgp,
 						     size_t size, gfp_t flags)
 {
@@ -494,7 +509,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 	if (should_failslab(s, flags))
 		return NULL;
 
-	if (!memcg_slab_pre_alloc_hook(s, objcgp, size, flags))
+	if (!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags))
 		return NULL;
 
 	return s;
diff --git a/mm/slob.c b/mm/slob.c
index 74d3f6e60666..9db272c75928 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -633,6 +633,12 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 }
 EXPORT_SYMBOL(kmem_cache_alloc);
 
+
+void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags)
+{
+	return slob_alloc_node(cachep, flags, NUMA_NO_NODE);
+}
+EXPORT_SYMBOL(kmem_cache_alloc_lru);
 #ifdef CONFIG_NUMA
 void *__kmalloc_node(size_t size, gfp_t gfp, int node)
 {
diff --git a/mm/slub.c b/mm/slub.c
index df1ac8aff86f..41211a2de0da 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3083,7 +3083,7 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
  *
  * Otherwise we can simply pick the next object from the lockless free list.
  */
-static __always_inline void *slab_alloc_node(struct kmem_cache *s,
+static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
 	void *object;
@@ -3093,7 +3093,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	struct obj_cgroup *objcg = NULL;
 	bool init = false;
 
-	s = slab_pre_alloc_hook(s, &objcg, 1, gfpflags);
+	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
 	if (!s)
 		return NULL;
 
@@ -3184,27 +3184,41 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	return object;
 }
 
-static __always_inline void *slab_alloc(struct kmem_cache *s,
+static __always_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *lru,
 		gfp_t gfpflags, unsigned long addr, size_t orig_size)
 {
-	return slab_alloc_node(s, gfpflags, NUMA_NO_NODE, addr, orig_size);
+	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
 }
 
-void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
+static __always_inline
+void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
+			     gfp_t gfpflags)
 {
-	void *ret = slab_alloc(s, gfpflags, _RET_IP_, s->object_size);
+	void *ret = slab_alloc(s, lru, gfpflags, _RET_IP_, s->object_size);
 
 	trace_kmem_cache_alloc(_RET_IP_, ret, s->object_size,
 				s->size, gfpflags);
 
 	return ret;
 }
+
+void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
+{
+	return __kmem_cache_alloc_lru(s, NULL, gfpflags);
+}
 EXPORT_SYMBOL(kmem_cache_alloc);
 
+void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
+			   gfp_t gfpflags)
+{
+	return __kmem_cache_alloc_lru(s, lru, gfpflags);
+}
+EXPORT_SYMBOL(kmem_cache_alloc_lru);
+
 #ifdef CONFIG_TRACING
 void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
-	void *ret = slab_alloc(s, gfpflags, _RET_IP_, size);
+	void *ret = slab_alloc(s, NULL, gfpflags, _RET_IP_, size);
 	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
@@ -3215,7 +3229,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #ifdef CONFIG_NUMA
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, s->object_size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    s->object_size, s->size, gfpflags, node);
@@ -3229,7 +3243,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 				    gfp_t gfpflags,
 				    int node, size_t size)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, s->size, gfpflags, node);
@@ -3611,7 +3625,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	struct obj_cgroup *objcg = NULL;
 
 	/* memcg and kmem_cache debug support */
-	s = slab_pre_alloc_hook(s, &objcg, size, flags);
+	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
 	if (unlikely(!s))
 		return false;
 	/*
@@ -4360,7 +4374,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc(s, flags, _RET_IP_, size);
+	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
 
@@ -4408,7 +4422,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc_node(s, flags, node, _RET_IP_, size);
+	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
 
 	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
 
@@ -4878,7 +4892,7 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc(s, gfpflags, caller, size);
+	ret = slab_alloc(s, NULL, gfpflags, caller, size);
 
 	/* Honor the call site pointer we received. */
 	trace_kmalloc(caller, ret, size, s->size, gfpflags);
@@ -4909,7 +4923,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc_node(s, gfpflags, node, caller, size);
+	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
 	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
-- 
2.11.0

