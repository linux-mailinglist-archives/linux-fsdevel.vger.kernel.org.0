Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFE8473251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 17:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbhLMQyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 11:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbhLMQyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:54:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D13C061751
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:54:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b13so11603398plg.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AUUc9kTnow40P9guadSw5wty/6rJ+ZwPD37o3khGJ+c=;
        b=e4Xr52onHQiwiC2t3CPxnmBhQmUEOsflEmCg8V8RC3ZPUlv56xOEhXMQY1EdoSBnAB
         UFrZMCSlhHraW+vGk+wYyiUt8kKhK1h4d3J25H0BhBOdP7VAWbZkHmD6B70me66L2C2Z
         hoCBYoP/+PIhnU4VKnQx3rxNsnFAXByeCTKrmyGdVsXOXuFuvDoNl8XUBMrO/CYkrHck
         YvgP3Q33+fdNeICkmSxa5sULSTZAe0g56p17ZMa02Jpj7c41j7Kbv8yXXFbnBXFW5bgZ
         ut0l78yFG4fx0LLoUedzzOUgDAKJFvkBUAvidTSRtq2J2n+WFQMDyOHn+C+M8xSxHatJ
         fbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AUUc9kTnow40P9guadSw5wty/6rJ+ZwPD37o3khGJ+c=;
        b=Ymn2rOqBpclZJGpmzFMjgKwOdBwa8P3zlLr9fbT1KCwX9qjchqJkd8SpRsmv1AUxao
         Vsg7U3CFBfyffjB3L43tjWirI8SO/OfuJN+6YmlP5/0jm3i8J01LWlOyzmYrtwOQm4Lg
         YMXU8r79RV6YgFdxVONBi3hVJaAZ5Y7pp9b4EGLD3LGCAOEGFmZ3XvqJUJnQIMFLGkDS
         UTQNNfi/l/9n4LOMePM1Ga2vrSfoRVBYhSBb1Eq9Q3YO411jbTlsW3llvPW3RBwtir2/
         Yq67cMusruxKGv98RZ1qN2QxZ3NJFp6CaafdxMgqy40Y5sVTgXXRgCwi85Y5Vad1FXb2
         f7FA==
X-Gm-Message-State: AOAM530UrFO1ZTvO/PFEOUxhFRDwj20VvjWrUzdsfTREjJWfMV/onsEO
        AKjDVypMJaxCeQSmorsWH4335A==
X-Google-Smtp-Source: ABdhPJwFzGN8q01mhFIhn+E1H2/0nVTtErabq09vTHt9/86a7l2Zv930XiQu+MjlpHgfm496Oj1IZA==
X-Received: by 2002:a17:90a:e00f:: with SMTP id u15mr44867096pjy.123.1639414475092;
        Mon, 13 Dec 2021 08:54:35 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.54.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:54:34 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 02/17] mm: introduce kmem_cache_alloc_lru
Date:   Tue, 14 Dec 2021 00:53:27 +0800
Message-Id: <20211213165342.74704-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
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
 include/linux/list_lru.h   |   4 ++
 include/linux/memcontrol.h |  14 ++++++
 include/linux/slab.h       |   3 ++
 mm/list_lru.c              | 110 +++++++++++++++++++++++++++++++++++++++++----
 mm/memcontrol.c            |  14 ------
 mm/slab.c                  |  39 +++++++++++-----
 mm/slab.h                  |  25 +++++++++--
 mm/slob.c                  |   6 +++
 mm/slub.c                  |  42 +++++++++++------
 9 files changed, 204 insertions(+), 53 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 729a27b6ff53..ab912c49334f 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -56,6 +56,8 @@ struct list_lru {
 	struct list_head	list;
 	int			shrinker_id;
 	bool			memcg_aware;
+	/* protects ->mlrus->mlru[i] */
+	spinlock_t		lock;
 	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
 	struct list_lru_memcg	__rcu *mlrus;
 #endif
@@ -72,6 +74,8 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 #define list_lru_init_memcg(lru, shrinker)		\
 	__list_lru_init((lru), true, NULL, shrinker)
 
+int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
+			 gfp_t gfp);
 int memcg_update_all_list_lrus(int num_memcgs);
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6..561ba47760db 100644
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
index 181045148b06..eccbd21d3753 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -135,6 +135,7 @@
 
 #include <linux/kasan.h>
 
+struct list_lru;
 struct mem_cgroup;
 /*
  * struct kmem_cache related prototypes
@@ -425,6 +426,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 
 void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
 void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
+void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
+			   gfp_t gfpflags) __assume_slab_alignment __malloc;
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 /*
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 7d1356241aa8..d716edfaae38 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -338,22 +338,30 @@ static void memcg_destroy_list_lru_range(struct list_lru_memcg *mlrus,
 		kfree(mlrus->mlru[i]);
 }
 
+static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
+{
+	int nid;
+	struct list_lru_per_memcg *mlru;
+
+	mlru = kmalloc(struct_size(mlru, node, nr_node_ids), GFP_KERNEL);
+	if (!mlru)
+		return NULL;
+
+	for_each_node(nid)
+		init_one_lru(&mlru->node[nid]);
+
+	return mlru;
+}
+
 static int memcg_init_list_lru_range(struct list_lru_memcg *mlrus,
 				     int begin, int end)
 {
 	int i;
 
 	for (i = begin; i < end; i++) {
-		int nid;
-		struct list_lru_per_memcg *mlru;
-
-		mlru = kmalloc(struct_size(mlru, node, nr_node_ids), GFP_KERNEL);
-		if (!mlru)
+		mlrus->mlru[i] = memcg_init_list_lru_one(GFP_KERNEL);
+		if (!mlrus->mlru[i])
 			goto fail;
-
-		for_each_node(nid)
-			init_one_lru(&mlru->node[nid]);
-		mlrus->mlru[i] = mlru;
 	}
 	return 0;
 fail:
@@ -370,6 +378,8 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 	if (!memcg_aware)
 		return 0;
 
+	spin_lock_init(&lru->lock);
+
 	mlrus = kvmalloc(struct_size(mlrus, mlru, size), GFP_KERNEL);
 	if (!mlrus)
 		return -ENOMEM;
@@ -416,8 +426,11 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
 		return -ENOMEM;
 	}
 
+	spin_lock_irq(&lru->lock);
 	memcpy(&new->mlru, &old->mlru, flex_array_size(new, mlru, old_size));
 	rcu_assign_pointer(lru->mlrus, new);
+	spin_unlock_irq(&lru->lock);
+
 	kvfree_rcu(old, rcu);
 	return 0;
 }
@@ -502,6 +515,85 @@ void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
 		memcg_drain_list_lru(lru, src_idx, dst_memcg);
 	mutex_unlock(&list_lrus_mutex);
 }
+
+static bool memcg_list_lru_allocated(struct mem_cgroup *memcg,
+				     struct list_lru *lru)
+{
+	bool allocated;
+	int idx;
+
+	idx = memcg->kmemcg_id;
+	if (unlikely(idx < 0))
+		return true;
+
+	rcu_read_lock();
+	allocated = !!rcu_dereference(lru->mlrus)->mlru[idx];
+	rcu_read_unlock();
+
+	return allocated;
+}
+
+/*
+ * The allocated list lru pointers array is not accounted directly.
+ * Moreover, it should not come from DMA buffer and is not readily
+ * reclaimable. So those GFP bits should be masked off.
+ */
+#define LRUS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT | __GFP_ZERO)
+
+int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
+			 gfp_t gfp)
+{
+	int i;
+	unsigned long flags;
+	struct list_lru_memcg *mlrus;
+	struct list_lru_memcg_table {
+		struct list_lru_per_memcg *mlru;
+		struct mem_cgroup *memcg;
+	} *table;
+
+	if (!list_lru_memcg_aware(lru) || memcg_list_lru_allocated(memcg, lru))
+		return 0;
+
+	gfp &= ~LRUS_CLEAR_MASK;
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
+		if (memcg_list_lru_allocated(memcg, lru))
+			break;
+
+		table[i].memcg = memcg;
+		table[i].mlru = memcg_init_list_lru_one(gfp);
+		if (!table[i].mlru) {
+			while (i--)
+				kfree(table[i].mlru);
+			kfree(table);
+			return -ENOMEM;
+		}
+	}
+
+	spin_lock_irqsave(&lru->lock, flags);
+	mlrus = rcu_dereference_protected(lru->mlrus, true);
+	while (i--) {
+		int index = table[i].memcg->kmemcg_id;
+
+		if (mlrus->mlru[index])
+			kfree(table[i].mlru);
+		else
+			mlrus->mlru[index] = table[i].mlru;
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
index 6863a834ed42..d505b43d5f3b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2794,20 +2794,6 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
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
index ca4822f6b2b6..9f9e5593f67e 100644
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
index 56ad7eea3ddf..5768252aad1c 100644
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
@@ -284,13 +286,26 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 	if (!objcg)
 		return true;
 
-	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s))) {
-		obj_cgroup_put(objcg);
-		return false;
+	if (lru) {
+		int ret;
+		struct mem_cgroup *memcg;
+
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		ret = memcg_list_lru_alloc(memcg, lru, flags);
+		css_put(&memcg->css);
+
+		if (ret)
+			goto out;
 	}
 
+	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
+		goto out;
+
 	*objcgp = objcg;
 	return true;
+out:
+	obj_cgroup_put(objcg);
+	return false;
 }
 
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
@@ -386,6 +401,7 @@ static inline void memcg_free_page_obj_cgroups(struct page *page)
 }
 
 static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
+					     struct list_lru *lru,
 					     struct obj_cgroup **objcgp,
 					     size_t objects, gfp_t flags)
 {
@@ -484,6 +500,7 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
 }
 
 static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
+						     struct list_lru *lru,
 						     struct obj_cgroup **objcgp,
 						     size_t size, gfp_t flags)
 {
@@ -494,7 +511,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 	if (should_failslab(s, flags))
 		return NULL;
 
-	if (!memcg_slab_pre_alloc_hook(s, objcgp, size, flags))
+	if (!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags))
 		return NULL;
 
 	return s;
diff --git a/mm/slob.c b/mm/slob.c
index 03deee1e6a94..fd9d7c24921f 100644
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
index a8626825a829..6d9f05d13c0e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3135,7 +3135,7 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
  *
  * Otherwise we can simply pick the next object from the lockless free list.
  */
-static __always_inline void *slab_alloc_node(struct kmem_cache *s,
+static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
 	void *object;
@@ -3145,7 +3145,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	struct obj_cgroup *objcg = NULL;
 	bool init = false;
 
-	s = slab_pre_alloc_hook(s, &objcg, 1, gfpflags);
+	s = slab_pre_alloc_hook(s, lru, &objcg, 1, gfpflags);
 	if (!s)
 		return NULL;
 
@@ -3236,27 +3236,41 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
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
@@ -3267,7 +3281,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_trace);
 #ifdef CONFIG_NUMA
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, s->object_size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
 
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    s->object_size, s->size, gfpflags, node);
@@ -3281,7 +3295,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 				    gfp_t gfpflags,
 				    int node, size_t size)
 {
-	void *ret = slab_alloc_node(s, gfpflags, node, _RET_IP_, size);
+	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, s->size, gfpflags, node);
@@ -3667,7 +3681,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	struct obj_cgroup *objcg = NULL;
 
 	/* memcg and kmem_cache debug support */
-	s = slab_pre_alloc_hook(s, &objcg, size, flags);
+	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
 	if (unlikely(!s))
 		return false;
 	/*
@@ -4416,7 +4430,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc(s, flags, _RET_IP_, size);
+	ret = slab_alloc(s, NULL, flags, _RET_IP_, size);
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
 
@@ -4464,7 +4478,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc_node(s, flags, node, _RET_IP_, size);
+	ret = slab_alloc_node(s, NULL, flags, node, _RET_IP_, size);
 
 	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
 
@@ -4922,7 +4936,7 @@ void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc(s, gfpflags, caller, size);
+	ret = slab_alloc(s, NULL, gfpflags, caller, size);
 
 	/* Honor the call site pointer we received. */
 	trace_kmalloc(caller, ret, size, s->size, gfpflags);
@@ -4953,7 +4967,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t gfpflags,
 	if (unlikely(ZERO_OR_NULL_PTR(s)))
 		return s;
 
-	ret = slab_alloc_node(s, gfpflags, node, caller, size);
+	ret = slab_alloc_node(s, NULL, gfpflags, node, caller, size);
 
 	/* Honor the call site pointer we received. */
 	trace_kmalloc_node(caller, ret, size, s->size, gfpflags, node);
-- 
2.11.0

