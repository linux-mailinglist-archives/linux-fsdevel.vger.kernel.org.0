Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C284347A656
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbhLTI5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbhLTI5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:57:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED50C06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:57:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gj24so8705038pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UxuL/PhoaZlUroZ58E2TVpI9m3e9c8bjKrbBMVbzN0Q=;
        b=JuqnvlFa6CKD/DBI/wOxWbKDJsjIteNmZ6j2KNzBABg/kCuTxJtvrJZA71N+Q5sJM6
         kolCeFui5Kbk/N4mek1175t0ad+QsaccKI/EIzqzOU00bGh8Jnv79meD/YxCKMs+ark7
         h3cuiCaC/HmqTIHLnV9GglkKVpcPqHRp4FtDM2BW5/5KUeObY7JpYPTUJTAVmRNv002Q
         YWSoROjWcADDjRqJkgMkMn+K4dn6l/iWfic97DdUfujEsX310MtK0TIhGJqqWoRSQujr
         j+2FMwAzeFFmh5GaVEeIbBF0CGrBAOYSHxCivhs5njdQ3Qv/KT2JAcFYUn/ayaOtwkJ1
         lCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxuL/PhoaZlUroZ58E2TVpI9m3e9c8bjKrbBMVbzN0Q=;
        b=eirw7lmTpMgzk/Nw43kCRBAF+Q/Wa7+luaACHRDcDVysTsTUKvr6Sl3+yM1QU2TLKD
         DkH6asKPd7dqQ5N2hNUMJQ49D1hybQP4kBq8qTD4tWAahWBmEm8+KmtIVAJbZLoO5W4e
         OD5fuynxCC7huzSE2cQJT6hrmfohjVigSB2I/4Oa643FOAUkjUqj577u14RDICKBm4xk
         m2r2biZ3GMH1j9SPgKZGqDmtCO+JJZibWRFWn/3QBRnUkPN4XBPHMMk+0dwpEmi38xD9
         hVn/SdzsvhDnyZHmq3SZOgozWTvGkZfvNk2wstz/S1srMeWnck09q4inHVCRDdyTBhlE
         TWnw==
X-Gm-Message-State: AOAM5316B+JR8d3tcL7ZQIGr2423nnVf3hbw7iGnUgsDHfG7N9Xt4ANC
        OcRPhxIo1UCLg00zFhL7xp6zUA==
X-Google-Smtp-Source: ABdhPJzqbkjzEEeZY47V+QQ6Ob+PnAIcNgNfhemVnfJR1Bc3FgN3t+BjuRBGmInXu0PkEaZoNULU9A==
X-Received: by 2002:a17:902:7044:b0:148:ef6f:fc52 with SMTP id h4-20020a170902704400b00148ef6ffc52mr11486299plt.67.1639990657600;
        Mon, 20 Dec 2021 00:57:37 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:57:37 -0800 (PST)
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
Subject: [PATCH v5 02/16] mm: introduce kmem_cache_alloc_lru
Date:   Mon, 20 Dec 2021 16:56:35 +0800
Message-Id: <20211220085649.8196-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
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
 mm/list_lru.c              | 104 +++++++++++++++++++++++++++++++++++++++++----
 mm/memcontrol.c            |  14 ------
 mm/slab.c                  |  39 +++++++++++------
 mm/slab.h                  |  25 +++++++++--
 mm/slob.c                  |   6 +++
 mm/slub.c                  |  42 ++++++++++++------
 9 files changed, 198 insertions(+), 53 deletions(-)

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
index 7d1356241aa8..bffa80527723 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/memcontrol.h>
 #include "slab.h"
+#include "internal.h"
 
 #ifdef CONFIG_MEMCG_KMEM
 static LIST_HEAD(memcg_list_lrus);
@@ -338,22 +339,30 @@ static void memcg_destroy_list_lru_range(struct list_lru_memcg *mlrus,
 		kfree(mlrus->mlru[i]);
 }
 
+static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
+{
+	int nid;
+	struct list_lru_per_memcg *mlru;
+
+	mlru = kmalloc(struct_size(mlru, node, nr_node_ids), gfp);
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
@@ -370,6 +379,8 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 	if (!memcg_aware)
 		return 0;
 
+	spin_lock_init(&lru->lock);
+
 	mlrus = kvmalloc(struct_size(mlrus, mlru, size), GFP_KERNEL);
 	if (!mlrus)
 		return -ENOMEM;
@@ -416,8 +427,11 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
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
@@ -502,6 +516,78 @@ void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
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
+	gfp &= GFP_RECLAIM_MASK;
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

