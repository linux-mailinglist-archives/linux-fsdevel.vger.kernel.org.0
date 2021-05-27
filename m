Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F60392771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhE0G1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbhE0G0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:26:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECD1C061342
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso1789378pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S96t8FV/KVNYLav3maTnbrPOMh4mzE7td/+61i8wGYU=;
        b=ZzjS56RR/gxspe+uPrYR7tN3OvcenOUl4lHdbQYCqpGeWtNBE+MN1sPQM4ddTrn4Ci
         3Aw8aKmWyhCmaAhHS0LmcUssEmhpVaNeysyT9fzF2U+JziP5mlZTeJK8ZhoZa90jSdy+
         AsmMCpO4aBjil+2oYTtjl5uEcuwT5V+So1dvuyWx75TGTCcx/DD8l7bHCiqgtISAxqRI
         e65lltGTG2iRXhufqP/pPCxITpv1goQSakxaslrT8UbcEboHiCnPc2RCB1NyzCM/gagF
         EdVKjMPh3hP87/1cOZEfNbDa7EbZ4wASdW70QlwkmkPHvHiof67zOYYgUw92+V7hpUW9
         SwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S96t8FV/KVNYLav3maTnbrPOMh4mzE7td/+61i8wGYU=;
        b=B/K9vPP5tYCJNfWBxdpYi+Sz1fHu7lh8vrsyE+lNV6PA+xjZgsGHtUg+lee32NkHUg
         +lmG2x8ChOQ6Wb1BKwJdhTwtRNYSSE3MOzJPD7AnOIQZNK6QH/wZe/1IQV21OtEbaGYl
         gTI93LJMFDKlErEdPikWhUU8hjZOuNeDThTSDWhPDaWZaJvlV+g+z+xa4nmKdTbh/Cme
         G+Lps/5rYo0YLIBegPwYhTV2DeMnTKAQ2psQJNm5NSCNqCuAPeEc9AKx9KmdypNZUQI2
         pyV6we5zoqmN5ffOLLyuGyjRUG4Uni6TKVWy4WYsRdobC6xWwlZlPFffew3x0HvAVlrP
         63Dg==
X-Gm-Message-State: AOAM532mtmyW+x1kIo+W4FTgtxTzt5AjVQG0zO4I8pxGl8IJU0QtqgKq
        qIJfZqTfJhpq5DNRS1SAe13EFw==
X-Google-Smtp-Source: ABdhPJzjTQ6qtKCqzsaaiaYadkTszCwHc8sq/qdllmh3hpdht+UN80mUw23TYDzYYWnTiO4wAUd5jw==
X-Received: by 2002:a17:90b:3709:: with SMTP id mg9mr7572081pjb.149.1622096721286;
        Wed, 26 May 2021 23:25:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.25.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:25:20 -0700 (PDT)
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
Subject: [PATCH v2 09/21] mm: introduce kmem_cache_alloc_lru
Date:   Thu, 27 May 2021 14:21:36 +0800
Message-Id: <20210527062148.9361-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
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
 include/linux/slab.h       |   4 ++
 mm/list_lru.c              | 115 +++++++++++++++++++++++++++++++++++++++++----
 mm/memcontrol.c            |  14 ------
 mm/slab.c                  |  39 ++++++++++-----
 mm/slab.h                  |  17 ++++++-
 mm/slub.c                  |  42 +++++++++++------
 8 files changed, 197 insertions(+), 51 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 4a9e4aaecc69..2083f4f2701f 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -55,11 +55,14 @@ struct list_lru {
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
 	int			shrinker_id;
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
index 6d0638e13fc1..84a70c219e85 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -517,6 +517,20 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
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
  * PageMemcgKmem - check if the page has MemcgKmem flag set
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9d316aac0aba..346698208258 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -424,8 +424,12 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 #define kmalloc_index(s) __kmalloc_index(s, true)
 #endif /* !CONFIG_SLOB */
 
+struct list_lru;
+
 void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __malloc;
 void *kmem_cache_alloc(struct kmem_cache *, gfp_t flags) __assume_slab_alignment __malloc;
+void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
+			   gfp_t gfpflags) __assume_slab_alignment __malloc;
 void kmem_cache_free(struct kmem_cache *, void *);
 
 /*
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 8006c0fcc506..4ba1db6d4409 100644
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
@@ -372,6 +380,8 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 		return 0;
 	}
 
+	spin_lock_init(&lru->lock);
+
 	memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
 			      size * sizeof(memcg_lrus->lrus[0]), GFP_KERNEL);
 	if (!memcg_lrus)
@@ -419,9 +429,11 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
 		return -ENOMEM;
 	}
 
+	spin_lock_irq(&lru->lock);
 	memcpy(&new->lrus, &old->lrus, old_size * sizeof(new->lrus[0]));
-
 	rcu_assign_pointer(lru->memcg_lrus, new);
+	spin_unlock_irq(&lru->lock);
+
 	kvfree_rcu(old, rcu);
 
 	return 0;
@@ -507,6 +519,89 @@ void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
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
index 377ec9847179..09bafa82781f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2787,20 +2787,6 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 	page->memcg_data = (unsigned long)memcg;
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
index b4cdf8687120..473b75777a4d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -46,6 +46,7 @@ struct kmem_cache {
 #include <linux/kmemleak.h>
 #include <linux/random.h>
 #include <linux/sched/mm.h>
+#include <linux/list_lru.h>
 
 /*
  * State of the slab allocator.
@@ -262,6 +263,7 @@ static inline size_t obj_full_size(struct kmem_cache *s)
  * Returns false if the allocation should fail.
  */
 static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+					     struct list_lru *lru,
 					     struct obj_cgroup **objcgp,
 					     size_t objects, gfp_t flags)
 {
@@ -277,6 +279,17 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
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
@@ -379,6 +392,7 @@ static inline void memcg_free_page_obj_cgroups(struct page *page)
 }
 
 static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+					     struct list_lru *lru,
 					     struct obj_cgroup **objcgp,
 					     size_t objects, gfp_t flags)
 {
@@ -477,6 +491,7 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
 }
 
 static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
+						     struct list_lru *lru,
 						     struct obj_cgroup **objcgp,
 						     size_t size, gfp_t flags)
 {
@@ -487,7 +502,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 	if (should_failslab(s, flags))
 		return NULL;
 
-	if (!memcg_slab_pre_alloc_hook(s, objcgp, size, flags))
+	if (!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags))
 		return NULL;
 
 	return s;
diff --git a/mm/slub.c b/mm/slub.c
index 6b896b8c36f0..d49c139d6dce 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2862,7 +2862,7 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
  *
  * Otherwise we can simply pick the next object from the lockless free list.
  */
-static __always_inline void *slab_alloc_node(struct kmem_cache *s,
+static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
 	void *object;
@@ -2872,7 +2872,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	struct obj_cgroup *objcg = NULL;
 	bool init = false;
 
-	s = slab_pre_alloc_hook(s, &objcg, 1, gfpflags);
+	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
 	if (!s)
 		return NULL;
 
@@ -2956,27 +2956,41 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
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
@@ -2987,7 +3001,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #ifdef CONFIG_NUMA
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, s->object_size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    s->object_size, s->size, gfpflags, node);
@@ -3001,7 +3015,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 				    gfp_t gfpflags,
 				    int node, size_t size)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, s->size, gfpflags, node);
@@ -3352,7 +3366,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	struct obj_cgroup *objcg = NULL;
 
 	/* memcg and kmem_cache debug support */
-	s = slab_pre_alloc_hook(s, &objcg, size, flags);
+	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
 	if (unlikely(!s))
 		return false;
 	/*
@@ -4109,7 +4123,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc(s, flags, _RET_IP_, size);
+	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
 
@@ -4157,7 +4171,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc_node(s, flags, node, _RET_IP_, size);
+	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
 
 	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
 
@@ -4619,7 +4633,7 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc(s, gfpflags, caller, size);
+	ret = slab_alloc(s, NULL, gfpflags, caller, size);
 
 	/* Honor the call site pointer we received. */
 	trace_kmalloc(caller, ret, size, s->size, gfpflags);
@@ -4650,7 +4664,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc_node(s, gfpflags, node, caller, size);
+	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
 	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
-- 
2.11.0

