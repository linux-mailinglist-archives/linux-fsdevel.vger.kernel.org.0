Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7288840A876
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhINHrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbhINHqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:46:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4929CC0611BC
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v19so5572912pjh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qd3JCTi5wbFZt3xTDhqi0ubmAfWxjHRi18zkP7I6S4w=;
        b=Q0rTdTePiA1aISyMI1lJTmxXrCCiTPU2/otzi2UP0+/EBol5iMHhmBmGk3S8IdWvYL
         FcDoN8E6KijVWJNy+FDpRnpKwzaOpxaIJqkvBzuuH1ivbWlDcvqKUbK2vgqx47eRumuZ
         zjmAbyxudD7BoH6ckUsV6HwvM2HffeujJbySU90r7zRvwTmx07gT4LYDnjXINn+Yl1hS
         HCowg6xq9AOLpw/IYuQegWv29YzfYfUkgLgSxbBhy+HR2NQy4A51ZTWWcfpfdIYHPZs2
         rx/HAo8FZolVzqFgOJnrWYqM7AUPCfa2HmFAbbv+bLkKOHboxU5zsQtBFi39mXghOpud
         RKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qd3JCTi5wbFZt3xTDhqi0ubmAfWxjHRi18zkP7I6S4w=;
        b=UYDWxfi5Sj7rjjqAydQQP8ORfAnklNpCtE7Pd5OIZikQLWUkZkp0UJc/RdpJSvpFiy
         tTo0F4y27hMVuwwBDC/tCZImEb3wiLa9U7E8dSO4v80DBwj4Ma3TWW7ADBLwJAMEr8Qf
         GqK/7qiy7/fBupOMJbEgpkHMhQ7icfAJmtqKsed7UUokDuSb+hLye5lXy4VjoajtpmGe
         NCpwu7KLPoeT0A7t8x4NHKVG3ItoccSUui+7vdCWaWJuuD2sLw61Ha092JjsJ3GK6HCd
         JyTccH6X0rAe08wg3A2m85LUEImn8OAFL0As5q6q8IY1g8kuHNwckM4jXpCvLM98Hums
         wLLw==
X-Gm-Message-State: AOAM533fgWyPHWgNBJGa9dSjlT5kV4nA/HtW6ygveesJ/axK3biZr1hi
        O8KYs9C2LFzAbZKL/BlbYrlbeQ==
X-Google-Smtp-Source: ABdhPJxLG/giOtojdFkHj3noOFcRNcXlP8dNSDM7IrE1aImOxvxQ3JkC4gA7HRIjphrCRW3CPYkS9Q==
X-Received: by 2002:a17:90a:1de:: with SMTP id 30mr589068pjd.106.1631605292735;
        Tue, 14 Sep 2021 00:41:32 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.41.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:41:32 -0700 (PDT)
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
Subject: [PATCH v3 72/76] mm: list_lru: replace linear array with xarray
Date:   Tue, 14 Sep 2021 15:29:34 +0800
Message-Id: <20210914072938.6440-73-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
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
 include/linux/list_lru.h   |  13 +--
 include/linux/memcontrol.h |  23 ------
 mm/list_lru.c              | 196 ++++++++++++++-------------------------------
 mm/memcontrol.c            |  77 ++----------------
 4 files changed, 68 insertions(+), 241 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 5e9c632c9eb7..c423be3cf2d3 100644
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
@@ -57,10 +52,7 @@ struct list_lru {
 	struct list_head	list;
 	int			shrinker_id;
 	bool			memcg_aware;
-	/* protects ->memcg_lrus->lrus[i] */
-	spinlock_t		lock;
-	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
-	struct list_lru_memcg	__rcu *memcg_lrus;
+	struct xarray		xa;
 #endif
 };
 
@@ -76,7 +68,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 #define list_lru_init_memcg(lru, shrinker)		\
 	__list_lru_init((lru), true, NULL, shrinker)
 
-int memcg_update_all_list_lrus(int num_memcgs);
 void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 06ee32822fd4..83add6c484b1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1689,18 +1689,6 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
 
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
@@ -1757,9 +1745,6 @@ static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
-#define for_each_memcg_cache_index(_idx)	\
-	for (; NULL; )
-
 static inline bool memcg_kmem_enabled(void)
 {
 	return false;
@@ -1770,14 +1755,6 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
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
index 1e42d9847b08..1202519aeb31 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -51,22 +51,12 @@ static int lru_shrinker_id(struct list_lru *lru)
 static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
-	struct list_lru_memcg *memcg_lrus;
-	struct list_lru_node *nlru = &lru->node[nid];
-
-	/*
-	 * Either lock or RCU protects the array of per cgroup lists
-	 * from relocation (see memcg_update_list_lru).
-	 */
-	memcg_lrus = rcu_dereference_check(lru->memcg_lrus,
-					   lockdep_is_held(&nlru->lock));
-	if (memcg_lrus && idx >= 0) {
-		struct list_lru_per_memcg *mlru;
+	if (list_lru_memcg_aware(lru) && idx >= 0) {
+		struct list_lru_per_memcg *mlru = xa_load(&lru->xa, idx);
 
-		mlru = rcu_dereference_check(memcg_lrus->lrus[idx], true);
 		return mlru ? &mlru->nodes[nid] : NULL;
 	}
-	return &nlru->lru;
+	return &lru->node[nid].lru;
 }
 
 static inline struct list_lru_one *
@@ -77,7 +67,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 	struct list_lru_one *l = &nlru->lru;
 	struct mem_cgroup *memcg = NULL;
 
-	if (!lru->memcg_lrus)
+	if (!list_lru_memcg_aware(lru))
 		goto out;
 
 	memcg = mem_cgroup_from_obj(ptr);
@@ -310,16 +300,20 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 				 unsigned long *nr_to_walk)
 {
 	long isolated = 0;
-	int memcg_idx;
 
 	isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
 				      nr_to_walk);
+
+#ifdef CONFIG_MEMCG_KMEM
 	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
-		for_each_memcg_cache_index(memcg_idx) {
+		struct list_lru_per_memcg *mlru;
+		unsigned long index;
+
+		xa_for_each(&lru->xa, index, mlru) {
 			struct list_lru_node *nlru = &lru->node[nid];
 
 			spin_lock(&nlru->lock);
-			isolated += __list_lru_walk_one(lru, nid, memcg_idx,
+			isolated += __list_lru_walk_one(lru, nid, index,
 							isolate, cb_arg,
 							nr_to_walk);
 			spin_unlock(&nlru->lock);
@@ -328,6 +322,8 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 				break;
 		}
 	}
+#endif
+
 	return isolated;
 }
 EXPORT_SYMBOL_GPL(list_lru_walk_node);
@@ -339,15 +335,6 @@ static void init_one_lru(struct list_lru_one *l)
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
@@ -365,15 +352,7 @@ static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
 
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
+	struct list_lru_per_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
 
 	/*
 	 * The __list_lru_walk_one() can walk the list of this node.
@@ -385,79 +364,27 @@ static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 		kvfree_rcu(mlru, rcu);
 }
 
-static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
+static void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
-	struct list_lru_memcg *memcg_lrus;
-	int size = memcg_nr_cache_ids;
-
+	if (memcg_aware)
+		xa_init_flags(&lru->xa, XA_FLAGS_LOCK_IRQ);
 	lru->memcg_aware = memcg_aware;
-	if (!memcg_aware)
-		return 0;
-
-	spin_lock_init(&lru->lock);
-
-	memcg_lrus = kvzalloc(sizeof(*memcg_lrus) +
-			      size * sizeof(memcg_lrus->lrus[0]), GFP_KERNEL);
-	if (!memcg_lrus)
-		return -ENOMEM;
-
-	RCU_INIT_POINTER(lru->memcg_lrus, memcg_lrus);
-
-	return 0;
 }
 
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
-	struct list_lru_memcg *memcg_lrus;
+	XA_STATE(xas, &lru->xa, 0);
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
-	list_for_each_entry(lru, &memcg_list_lrus, list) {
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
 }
 
 static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
@@ -536,27 +463,17 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 static bool memcg_list_lru_skip_alloc(struct list_lru *lru,
 				      struct mem_cgroup *memcg)
 {
-	struct list_lru_memcg *memcg_lrus;
 	int idx = memcg_cache_id(memcg);
 
-	if (unlikely(idx < 0))
-		return true;
-
-	rcu_read_lock();
-	memcg_lrus = rcu_dereference(lru->memcg_lrus);
-	if (rcu_access_pointer(memcg_lrus->lrus[idx])) {
-		rcu_read_unlock();
+	if (unlikely(idx < 0) || xa_load(&lru->xa, idx))
 		return true;
-	}
-	rcu_read_unlock();
-
 	return false;
 }
 
 int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t gfp)
 {
+	XA_STATE(xas, &lru->xa, 0);
 	unsigned long flags;
-	struct list_lru_memcg *memcg_lrus;
 	int i;
 
 	struct list_lru_memcg_table {
@@ -599,27 +516,49 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
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
+		if (unlikely(index < 0 || xas_error(&xas) || xas_load(&xas))) {
 			kfree(mlru);
-		else
-			rcu_assign_pointer(memcg_lrus->lrus[index], mlru);
+		} else {
+			xas_store(&xas, mlru);
+			if (xas_error(&xas) == -ENOMEM) {
+				xas_unlock_irqrestore(&xas, flags);
+				if (xas_nomem(&xas, gfp))
+					xas_set_err(&xas, 0);
+				xas_lock_irqsave(&xas, flags);
+				/*
+				 * The xas lock has been released, this memcg
+				 * can be reparented before us. So reload
+				 * memcg id. More details see the comments
+				 * in memcg_reparent_list_lrus().
+				 */
+				index = memcg_cache_id(table[i].memcg);
+				if (index < 0)
+					xas_set_err(&xas, 0);
+				else if (!xas_error(&xas) && index != xas.xa_index)
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
+	return xas_error(&xas);
 }
 #else
-static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
+static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
-	return 0;
 }
 
 static void memcg_destroy_list_lru(struct list_lru *lru)
@@ -631,7 +570,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key, struct shrinker *shrinker)
 {
 	int i;
-	int err = -ENOMEM;
 
 #ifdef CONFIG_MEMCG_KMEM
 	if (shrinker)
@@ -639,11 +577,10 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	else
 		lru->shrinker_id = -1;
 #endif
-	memcg_get_cache_ids();
 
 	lru->node = kcalloc(nr_node_ids, sizeof(*lru->node), GFP_KERNEL);
 	if (!lru->node)
-		goto out;
+		return -ENOMEM;
 
 	for_each_node(i) {
 		spin_lock_init(&lru->node[i].lock);
@@ -652,18 +589,10 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		init_one_lru(&lru->node[i].lru);
 	}
 
-	err = memcg_init_list_lru(lru, memcg_aware);
-	if (err) {
-		kfree(lru->node);
-		/* Do this so a list_lru_destroy() doesn't crash: */
-		lru->node = NULL;
-		goto out;
-	}
-
+	memcg_init_list_lru(lru, memcg_aware);
 	list_lru_register(lru);
-out:
-	memcg_put_cache_ids();
-	return err;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(__list_lru_init);
 
@@ -673,8 +602,6 @@ void list_lru_destroy(struct list_lru *lru)
 	if (!lru->node)
 		return;
 
-	memcg_get_cache_ids();
-
 	list_lru_unregister(lru);
 
 	memcg_destroy_list_lru(lru);
@@ -684,6 +611,5 @@ void list_lru_destroy(struct list_lru *lru)
 #ifdef CONFIG_MEMCG_KMEM
 	lru->shrinker_id = -1;
 #endif
-	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4cf98de2ad09..8e0cde19b648 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -359,42 +359,17 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
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
@@ -2879,49 +2854,6 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
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
@@ -3599,13 +3531,14 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (unlikely(mem_cgroup_is_root(memcg)))
 		return 0;
 
-	memcg_id = memcg_alloc_cache_id();
+	memcg_id = ida_alloc_max(&memcg_cache_ida, MEMCG_CACHES_MAX_SIZE - 1,
+				 GFP_KERNEL);
 	if (memcg_id < 0)
 		return memcg_id;
 
 	objcg = obj_cgroup_alloc();
 	if (!objcg) {
-		memcg_free_cache_id(memcg_id);
+		ida_free(&memcg_cache_ida, memcg_id);
 		return -ENOMEM;
 	}
 	objcg->memcg = memcg;
@@ -3643,7 +3576,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
 	memcg_reparent_list_lrus(memcg, parent);
 
-	memcg_free_cache_id(kmemcg_id);
+	ida_free(&memcg_cache_ida, kmemcg_id);
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
-- 
2.11.0

