Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D3A39278F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhE0G20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbhE0G16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:27:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F0AC06134C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c12so2863719pfl.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=euRdI3+gePz0YL3AmMLDmFSwJVE1/9POfNyNrwNdGts=;
        b=u5udodkivP1/r7m/y55ITUBRvgZ5nw+e01yxKI0hvDN+FAtUtZ1t9dCyPpr0cGKK0n
         PlUy5uGLHuOO7wDrKNzoDGBBQT4yiLttmkGTKSq6f2ubAR2oOhCczhLaEhzx8tBI3lX1
         fXhtRt6U4VeqfTH+Rkbd5ipQ26rKTUjX4Dr56Om8YhMaSWAS+b5PpQptKJrSMUYeEvQe
         lFZJNoXpdw0NkgfTDMP8GoPPm0Go7Tbg5Q6tCCE/PQkigjDczcdSrLYjB9jVqV4oVdqz
         0KBe5eB98dDswVYHkZ/6MkErV8tuuffBshnLcyABC1L5GJ2CWcG8WUmvsm9qvBmUgMbm
         jehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=euRdI3+gePz0YL3AmMLDmFSwJVE1/9POfNyNrwNdGts=;
        b=k7TQD9aVT0RJZS3H7elPobyS0yp/wgVi9raFwfAiBYWF6RnJUzt7UlN2RUYJK2kG1e
         cfQII180iJxLFx4LcDumg4JaANcpQq3XfknmqYSiu2L8N4wnIY51y0S9YppQ73ZFZ0DK
         Vy0m+U9kKL0JWe0uKZWdwDRktu28sfFYSt3hL8dtjwPkWbroRi3/W6JiTxGjeNE2eoJc
         6u1/9ZPlta3NW8B1Cs3GsMPH9GkodK0kQ1kG4Y5cEAqvUNauMPjxmt1TnzOKzQMQ8GSE
         Te97yabFeZr07+j3DGbR9v/BnHLmqzsSENDAUJ/7Lfk5wuZb0R+BDwTNtqZIuW9QXqDQ
         KhBg==
X-Gm-Message-State: AOAM532YIToD+DJjPSdKe2WC2mE3vbDN+wxS2YCEi6s6Gi5+SUI5mNj2
        8sbNGGWBd29DK+vHu+nU0aeXtg==
X-Google-Smtp-Source: ABdhPJyRYvAYd1RhR0zZeEllPWvhZpSW6Y8Srt/81mS8UrOongws4wuYEIDPpD+2ZeOzlZx8xBViEA==
X-Received: by 2002:a62:3344:0:b029:28c:6f0f:cb90 with SMTP id z65-20020a6233440000b029028c6f0fcb90mr2245523pfz.58.1622096781592;
        Wed, 26 May 2021 23:26:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.26.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:26:21 -0700 (PDT)
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
Subject: [PATCH v2 17/21] mm: list_lru: replace linear array with xarray
Date:   Thu, 27 May 2021 14:21:44 +0800
Message-Id: <20210527062148.9361-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we run 10k containers in the system, the size of the
list_lru_memcg->lrus can be ~96KB per list_lru. When we decrease the
number containers, the size of the array will not be shrinked. It is
not scalable. The xarray is a good choice for this case. We can save
a lot of memory when there are tens of thousands continers in the
system. If we use xarray, we also can remove the logic code of
resizing array, which can simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h   |  12 +---
 include/linux/memcontrol.h |  23 ------
 mm/list_lru.c              | 173 +++++++++++++++------------------------------
 mm/memcontrol.c            |  77 ++------------------
 4 files changed, 63 insertions(+), 222 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 60970ea48c29..d7c9bd29e836 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/nodemask.h>
 #include <linux/shrinker.h>
+#include <linux/xarray.h>
 
 struct mem_cgroup;
 
@@ -37,12 +38,6 @@ struct list_lru_per_memcg {
 	struct list_lru_one	nodes[];
 };
 
-struct list_lru_memcg {
-	struct rcu_head			rcu;
-	/* array of per cgroup lists, indexed by memcg_cache_id */
-	struct list_lru_per_memcg __rcu	*lrus[];
-};
-
 struct list_lru_node {
 	/* protects all lists on the node, including per cgroup */
 	spinlock_t		lock;
@@ -56,10 +51,8 @@ struct list_lru {
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
 	int			shrinker_id;
-	/* protects ->memcg_lrus->lrus[i] */
-	spinlock_t		lock;
 	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
-	struct list_lru_memcg	__rcu *memcg_lrus;
+	struct xarray		*xa;
 #endif
 };
 
@@ -75,7 +68,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 #define list_lru_init_memcg(lru, shrinker)		\
 	__list_lru_init((lru), true, NULL, shrinker)
 
-int memcg_update_all_list_lrus(int num_memcgs);
 void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 84a70c219e85..e129c7067f63 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1631,18 +1631,6 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
 
 extern struct static_key_false memcg_kmem_enabled_key;
 
-extern int memcg_nr_cache_ids;
-void memcg_get_cache_ids(void);
-void memcg_put_cache_ids(void);
-
-/*
- * Helper macro to loop through all memcg-specific caches. Callers must still
- * check if the cache is valid (it is either valid or NULL).
- * the slab_mutex must be held when looping through those caches
- */
-#define for_each_memcg_cache_index(_idx)	\
-	for ((_idx) = 0; (_idx) < memcg_nr_cache_ids; (_idx)++)
-
 static inline bool memcg_kmem_enabled(void)
 {
 	return static_branch_likely(&memcg_kmem_enabled_key);
@@ -1695,9 +1683,6 @@ static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
-#define for_each_memcg_cache_index(_idx)	\
-	for (; NULL; )
-
 static inline bool memcg_kmem_enabled(void)
 {
 	return false;
@@ -1708,14 +1693,6 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return -1;
 }
 
-static inline void memcg_get_cache_ids(void)
-{
-}
-
-static inline void memcg_put_cache_ids(void)
-{
-}
-
 static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
 {
        return NULL;
diff --git a/mm/list_lru.c b/mm/list_lru.c
index dec116a12629..37052864bf78 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(list_lrus_mutex);
 
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
-	return !!rcu_access_pointer(lru->memcg_lrus);
+	return !!lru->xa;
 }
 
 static void list_lru_register(struct list_lru *lru)
@@ -51,22 +51,12 @@ static int lru_shrinker_id(struct list_lru *lru)
 static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
-	struct list_lru_memcg *memcg_lrus;
-	struct list_lru_node *nlru = &lru->node[nid];
+	if (list_lru_memcg_aware(lru) && idx >= 0) {
+		struct list_lru_per_memcg *mlru = xa_load(lru->xa, idx);
 
-	/*
-	 * Either lock or RCU protects the array of per cgroup lists
-	 * from relocation (see memcg_update_list_lru).
-	 */
-	memcg_lrus = rcu_dereference_check(lru->memcg_lrus,
-					   lockdep_is_held(&nlru->lock));
-	if (memcg_lrus && idx >= 0) {
-		struct list_lru_per_memcg *mlru;
-
-		mlru = rcu_dereference_check(memcg_lrus->lrus[idx], true);
 		return mlru ? &mlru->nodes[nid] : NULL;
 	}
-	return &nlru->lru;
+	return &lru->node[nid].lru;
 }
 
 static inline struct list_lru_one *
@@ -310,16 +300,18 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 				 unsigned long *nr_to_walk)
 {
 	long isolated = 0;
-	int memcg_idx;
 
 	isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
 				      nr_to_walk);
 	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
-		for_each_memcg_cache_index(memcg_idx) {
+		struct list_lru_per_memcg *mlru;
+		unsigned long index;
+
+		xa_for_each(lru->xa, index, mlru) {
 			struct list_lru_node *nlru = &lru->node[nid];
 
 			spin_lock(&nlru->lock);
-			isolated += __list_lru_walk_one(lru, nid, memcg_idx,
+			isolated += __list_lru_walk_one(lru, nid, index,
 							isolate, cb_arg,
 							nr_to_walk);
 			spin_unlock(&nlru->lock);
@@ -339,15 +331,6 @@ static void init_one_lru(struct list_lru_one *l)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static void memcg_destroy_list_lru_range(struct list_lru_memcg *memcg_lrus,
-					 int begin, int end)
-{
-	int i;
-
-	for (i = begin; i < end; i++)
-		kfree(memcg_lrus->lrus[i]);
-}
-
 static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
 {
 	int nid;
@@ -365,15 +348,7 @@ static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
 
 static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	struct list_lru_memcg *memcg_lrus;
-	struct list_lru_per_memcg *mlru;
-
-	spin_lock_irq(&lru->lock);
-	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
-	mlru = rcu_dereference_protected(memcg_lrus->lrus[src_idx], true);
-	if (mlru)
-		rcu_assign_pointer(memcg_lrus->lrus[src_idx], NULL);
-	spin_unlock_irq(&lru->lock);
+	struct list_lru_per_memcg *mlru = xa_erase_irq(lru->xa, src_idx);
 
 	/*
 	 * The __list_lru_walk_one() can walk the list of this node.
@@ -387,79 +362,35 @@ static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 
 static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
-	struct list_lru_memcg *memcg_lrus;
-	int size = memcg_nr_cache_ids;
-
 	if (!memcg_aware) {
-		lru->memcg_lrus = NULL;
+		lru->xa = NULL;
 		return 0;
 	}
 
-	spin_lock_init(&lru->lock);
-
-	memcg_lrus = kvzalloc(sizeof(*memcg_lrus) +
-			      size * sizeof(memcg_lrus->lrus[0]), GFP_KERNEL);
-	if (!memcg_lrus)
+	lru->xa = kmalloc(sizeof(*lru->xa), GFP_KERNEL);
+	if (!lru->xa)
 		return -ENOMEM;
-
-	RCU_INIT_POINTER(lru->memcg_lrus, memcg_lrus);
+	xa_init_flags(lru->xa, XA_FLAGS_LOCK_IRQ);
 
 	return 0;
 }
 
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
-	struct list_lru_memcg *memcg_lrus;
+	XA_STATE(xas, lru->xa, 0);
+	struct list_lru_per_memcg *mlru;
 
 	if (!list_lru_memcg_aware(lru))
 		return;
 
-	/*
-	 * This is called when shrinker has already been unregistered,
-	 * and nobody can use it. So, there is no need to use kvfree_rcu().
-	 */
-	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
-	memcg_destroy_list_lru_range(memcg_lrus, 0, memcg_nr_cache_ids);
-	kvfree(memcg_lrus);
-}
-
-static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_size)
-{
-	struct list_lru_memcg *old, *new;
-
-	BUG_ON(old_size > new_size);
-
-	old = rcu_dereference_protected(lru->memcg_lrus,
-					lockdep_is_held(&list_lrus_mutex));
-	new = kvmalloc(sizeof(*new) + new_size * sizeof(new->lrus[0]), GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-
-	spin_lock_irq(&lru->lock);
-	memcpy(&new->lrus, &old->lrus, old_size * sizeof(new->lrus[0]));
-	memset(&new->lrus[old_size], 0, (new_size - old_size) * sizeof(new->lrus[0]));
-	rcu_assign_pointer(lru->memcg_lrus, new);
-	spin_unlock_irq(&lru->lock);
-
-	kvfree_rcu(old, rcu);
-
-	return 0;
-}
-
-int memcg_update_all_list_lrus(int new_size)
-{
-	int ret = 0;
-	struct list_lru *lru;
-	int old_size = memcg_nr_cache_ids;
-
-	mutex_lock(&list_lrus_mutex);
-	list_for_each_entry(lru, &list_lrus, list) {
-		ret = memcg_update_list_lru(lru, old_size, new_size);
-		if (ret)
-			break;
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, mlru, ULONG_MAX) {
+		kfree(mlru);
+		xas_store(&xas, NULL);
 	}
-	mutex_unlock(&list_lrus_mutex);
-	return ret;
+	xas_unlock_irq(&xas);
+
+	kfree(lru->xa);
 }
 
 static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
@@ -538,28 +469,18 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 static bool memcg_list_lru_skip_alloc(struct list_lru *lru,
 				      struct mem_cgroup *memcg)
 {
-	struct list_lru_memcg *memcg_lrus;
 	int idx = memcg_cache_id(memcg);
 
-	if (unlikely(idx < 0))
+	if (unlikely(idx < 0) || xa_load(lru->xa, idx))
 		return true;
-
-	rcu_read_lock();
-	memcg_lrus = rcu_dereference(lru->memcg_lrus);
-	if (rcu_access_pointer(memcg_lrus->lrus[idx])) {
-		rcu_read_unlock();
-		return true;
-	}
-	rcu_read_unlock();
-
 	return false;
 }
 
 int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t gfp)
 {
+	XA_STATE(xas, lru->xa, 0);
 	unsigned long flags;
-	struct list_lru_memcg *memcg_lrus;
-	int i;
+	int i, ret = 0;
 
 	struct list_lru_memcg_table {
 		struct list_lru_per_memcg *mlru;
@@ -601,22 +522,45 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 		}
 	}
 
-	spin_lock_irqsave(&lru->lock, flags);
-	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
+	xas_lock_irqsave(&xas, flags);
 	while (i--) {
 		int index = memcg_cache_id(table[i].memcg);
 		struct list_lru_per_memcg *mlru = table[i].mlru;
 
-		if (index < 0 || rcu_dereference_protected(memcg_lrus->lrus[index], true))
+		xas_set(&xas, index);
+retry:
+		if (unlikely(index < 0 || ret || xas_load(&xas))) {
 			kfree(mlru);
-		else
-			rcu_assign_pointer(memcg_lrus->lrus[index], mlru);
+		} else {
+			ret = xa_err(xas_store(&xas, mlru));
+			if (ret == -ENOMEM) {
+				xas_unlock_irqrestore(&xas, flags);
+				if (xas_nomem(&xas, gfp))
+					ret = 0;
+				xas_lock_irqsave(&xas, flags);
+				/*
+				 * The xas lock has been released, this memcg
+				 * can be reparented before us. So reload
+				 * memcg id. More details see the comments
+				 * in memcg_reparent_list_lrus().
+				 */
+				index = memcg_cache_id(table[i].memcg);
+				if (index < 0)
+					ret = 0;
+				else if (!ret && index != xas.xa_index)
+					xas_set(&xas, index);
+				goto retry;
+			}
+		}
 	}
-	spin_unlock_irqrestore(&lru->lock, flags);
+	/* xas_nomem() is used to free memory instead of memory allocation. */
+	if (xas.xa_alloc)
+		xas_nomem(&xas, gfp);
+	xas_unlock_irqrestore(&xas, flags);
 
 	kfree(table);
 
-	return 0;
+	return ret;
 }
 #else
 static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
@@ -641,7 +585,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	else
 		lru->shrinker_id = -1;
 #endif
-	memcg_get_cache_ids();
 
 	lru->node = kcalloc(nr_node_ids, sizeof(*lru->node), GFP_KERNEL);
 	if (!lru->node)
@@ -664,7 +607,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 
 	list_lru_register(lru);
 out:
-	memcg_put_cache_ids();
 	return err;
 }
 EXPORT_SYMBOL_GPL(__list_lru_init);
@@ -675,8 +617,6 @@ void list_lru_destroy(struct list_lru *lru)
 	if (!lru->node)
 		return;
 
-	memcg_get_cache_ids();
-
 	list_lru_unregister(lru);
 
 	memcg_destroy_list_lru(lru);
@@ -686,6 +626,5 @@ void list_lru_destroy(struct list_lru *lru)
 #ifdef CONFIG_MEMCG_KMEM
 	lru->shrinker_id = -1;
 #endif
-	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 205bf710486c..82b147597138 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -345,42 +345,17 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
  * This will be used as a shrinker list's index.
  * The main reason for not using cgroup id for this:
  *  this works better in sparse environments, where we have a lot of memcgs,
- *  but only a few kmem-limited. Or also, if we have, for instance, 200
- *  memcgs, and none but the 200th is kmem-limited, we'd have to have a
- *  200 entry array for that.
- *
- * The current size of the caches array is stored in memcg_nr_cache_ids. It
- * will double each time we have to increase it.
+ *  but only a few kmem-limited.
  */
 static DEFINE_IDA(memcg_cache_ida);
-int memcg_nr_cache_ids;
-
-/* Protects memcg_nr_cache_ids */
-static DECLARE_RWSEM(memcg_cache_ids_sem);
-
-void memcg_get_cache_ids(void)
-{
-	down_read(&memcg_cache_ids_sem);
-}
-
-void memcg_put_cache_ids(void)
-{
-	up_read(&memcg_cache_ids_sem);
-}
 
 /*
- * MIN_SIZE is different than 1, because we would like to avoid going through
- * the alloc/free process all the time. In a small machine, 4 kmem-limited
- * cgroups is a reasonable guess. In the future, it could be a parameter or
- * tunable, but that is strictly not necessary.
- *
  * MAX_SIZE should be as large as the number of cgrp_ids. Ideally, we could get
  * this constant directly from cgroup, but it is understandable that this is
  * better kept as an internal representation in cgroup.c. In any case, the
  * cgrp_id space is not getting any smaller, and we don't have to necessarily
  * increase ours as well if it increases.
  */
-#define MEMCG_CACHES_MIN_SIZE 4
 #define MEMCG_CACHES_MAX_SIZE MEM_CGROUP_ID_MAX
 
 /*
@@ -2903,49 +2878,6 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 	return objcg;
 }
 
-static int memcg_alloc_cache_id(void)
-{
-	int id, size;
-	int err;
-
-	id = ida_simple_get(&memcg_cache_ida,
-			    0, MEMCG_CACHES_MAX_SIZE, GFP_KERNEL);
-	if (id < 0)
-		return id;
-
-	if (id < memcg_nr_cache_ids)
-		return id;
-
-	/*
-	 * There's no space for the new id in memcg_caches arrays,
-	 * so we have to grow them.
-	 */
-	down_write(&memcg_cache_ids_sem);
-
-	size = 2 * (id + 1);
-	if (size < MEMCG_CACHES_MIN_SIZE)
-		size = MEMCG_CACHES_MIN_SIZE;
-	else if (size > MEMCG_CACHES_MAX_SIZE)
-		size = MEMCG_CACHES_MAX_SIZE;
-
-	err = memcg_update_all_list_lrus(size);
-	if (!err)
-		memcg_nr_cache_ids = size;
-
-	up_write(&memcg_cache_ids_sem);
-
-	if (err) {
-		ida_simple_remove(&memcg_cache_ida, id);
-		return err;
-	}
-	return id;
-}
-
-static void memcg_free_cache_id(int id)
-{
-	ida_simple_remove(&memcg_cache_ida, id);
-}
-
 /*
  * obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a objcg
  * @objcg: object cgroup to uncharge
@@ -3618,13 +3550,14 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (unlikely(mem_cgroup_is_root(memcg)))
 		return 0;
 
-	memcg_id = memcg_alloc_cache_id();
+	memcg_id = ida_simple_get(&memcg_cache_ida, 0, MEMCG_CACHES_MAX_SIZE,
+				  GFP_KERNEL);
 	if (memcg_id < 0)
 		return memcg_id;
 
 	objcg = obj_cgroup_alloc();
 	if (!objcg) {
-		memcg_free_cache_id(memcg_id);
+		ida_simple_remove(&memcg_cache_ida, memcg_id);
 		return -ENOMEM;
 	}
 	objcg->memcg = memcg;
@@ -3662,7 +3595,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
 	memcg_reparent_list_lrus(memcg, parent);
 
-	memcg_free_cache_id(kmemcg_id);
+	ida_simple_remove(&memcg_cache_ida, kmemcg_id);
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
-- 
2.11.0

