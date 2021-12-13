Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C575F473278
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 17:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhLMQ4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 11:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbhLMQ4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:56:17 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D52C061748
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:17 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y8so11611845plg.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfbkH/h70OdnmNQUcXk11r7MzAW36gDVTmVU+n5HIps=;
        b=wEHwUZ1PyQFT5RACnLppyjzc3YOW9zH+ve/COT4OIihuzDe7uA4HDjcRTwokJw/87q
         qWmjZ1HY670mVFpBTGJsm+4x5baTRBA3wHaTob4pglZC/MLdYFe+OShbnnjVMwREnJ6u
         0qnJYQ1c3h5P9RP1X1mw90bSLu6yhFjf0OUJ/YbwkHjlVUhLIrWGQXpZT8PZfCzoeRgk
         WlMMS5RYBob1sk8WI4azUw+6Q7mbpZcpa2E8cbayfJca3rkrVRmmvlfMHdS0f3jDW1DJ
         CMtatBfT47AIrlES00T5GRnTb5OzKjyEqNnIU4b73RdsZdKk4Es/MulJZ7aoU3as69Es
         Q7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfbkH/h70OdnmNQUcXk11r7MzAW36gDVTmVU+n5HIps=;
        b=tbF53sq7dhIjWZWacKtmh2Aj4Rd4zZThHiLjxVIe8a5I4bhgNIIEhX3iYtGbOUlFZ/
         6XQXppII4ViqCjqP7hDPSw/NvMeojjhGx4dRuuOrQiP6OT4yHQClCoOy8Jm+B3suY4Ec
         KT2gsKDB++pRaQcFgNbt2KhCRhjS0AGUfttTUFbZVVf5rU57bk/0VUHBSGW8NHrfy0Ap
         pJmWRwCdPKzDAnCC7zqEaF8rqqCp26msxX8ITASVxjEdPA5NCwkiaxmO3HiT/q9udFL3
         mLcs6Hre5U8KQytqicvpc4+1AO2EL4OHp2dThDuBClHePeANQErLwNyS1cPNGlVcTSHa
         3CDg==
X-Gm-Message-State: AOAM533Zz4gcXnEW5uun9FN8ceeHLcR8mFJxCZXJ4GEhFW1uvZ20e3dS
        8ivey48ZdL+E3Rrl3q6hUJjaOA==
X-Google-Smtp-Source: ABdhPJyEEOsGZEvFuHQvonGRX6fNIx50TwdOkiR3/8WtGudnAe0Rjdp9J3svWADnecjvuHbVpAxcAw==
X-Received: by 2002:a17:902:e781:b0:143:d589:1d0b with SMTP id cp1-20020a170902e78100b00143d5891d0bmr96993817plb.31.1639414576452;
        Mon, 13 Dec 2021 08:56:16 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:56:16 -0800 (PST)
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
Subject: [PATCH v4 13/17] mm: list_lru: replace linear array with xarray
Date:   Tue, 14 Dec 2021 00:53:38 +0800
Message-Id: <20211213165342.74704-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
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
 mm/list_lru.c              | 202 +++++++++++++++------------------------------
 mm/memcontrol.c            |  77 ++---------------
 4 files changed, 73 insertions(+), 242 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 4b00fd8cb373..572c263561ac 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/nodemask.h>
 #include <linux/shrinker.h>
+#include <linux/xarray.h>
 
 struct mem_cgroup;
 
@@ -37,12 +38,6 @@ struct list_lru_per_memcg {
 	struct list_lru_one	node[];
 };
 
-struct list_lru_memcg {
-	struct rcu_head			rcu;
-	/* array of per cgroup lists, indexed by memcg_cache_id */
-	struct list_lru_per_memcg __rcu	*mlru[];
-};
-
 struct list_lru_node {
 	/* protects all lists on the node, including per cgroup */
 	spinlock_t		lock;
@@ -57,10 +52,7 @@ struct list_lru {
 	struct list_head	list;
 	int			shrinker_id;
 	bool			memcg_aware;
-	/* protects ->mlrus->mlru[i] */
-	spinlock_t		lock;
-	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
-	struct list_lru_memcg	__rcu *mlrus;
+	struct xarray		xa;
 #endif
 };
 
@@ -77,7 +69,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 
 int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			 gfp_t gfp);
-int memcg_update_all_list_lrus(int num_memcgs);
 void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 561ba47760db..3fc437162add 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1711,18 +1711,6 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
 
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
@@ -1779,9 +1767,6 @@ static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
-#define for_each_memcg_cache_index(_idx)	\
-	for (; NULL; )
-
 static inline bool memcg_kmem_enabled(void)
 {
 	return false;
@@ -1792,14 +1777,6 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
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
index 9116e220e9b8..7ff3988e92aa 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -51,21 +51,12 @@ static int lru_shrinker_id(struct list_lru *lru)
 static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
-	struct list_lru_memcg *mlrus;
-	struct list_lru_node *nlru = &lru->node[nid];
+	if (list_lru_memcg_aware(lru) && idx >= 0) {
+		struct list_lru_per_memcg *mlru = xa_load(&lru->xa, idx);
 
-	/*
-	 * Either lock or RCU protects the array of per cgroup lists
-	 * from relocation (see memcg_update_list_lru).
-	 */
-	mlrus = rcu_dereference_check(lru->mlrus, lockdep_is_held(&nlru->lock));
-	if (mlrus && idx >= 0) {
-		struct list_lru_per_memcg *mlru;
-
-		mlru = rcu_dereference_check(mlrus->mlru[idx], true);
 		return mlru ? &mlru->node[nid] : NULL;
 	}
-	return &nlru->lru;
+	return &lru->node[nid].lru;
 }
 
 static inline struct list_lru_one *
@@ -76,7 +67,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 	struct list_lru_one *l = &nlru->lru;
 	struct mem_cgroup *memcg = NULL;
 
-	if (!lru->mlrus)
+	if (!list_lru_memcg_aware(lru))
 		goto out;
 
 	memcg = mem_cgroup_from_obj(ptr);
@@ -308,16 +299,20 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
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
@@ -326,6 +321,8 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 				break;
 		}
 	}
+#endif
+
 	return isolated;
 }
 EXPORT_SYMBOL_GPL(list_lru_walk_node);
@@ -337,15 +334,6 @@ static void init_one_lru(struct list_lru_one *l)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static void memcg_destroy_list_lru_range(struct list_lru_memcg *mlrus,
-					 int begin, int end)
-{
-	int i;
-
-	for (i = begin; i < end; i++)
-		kfree(mlrus->mlru[i]);
-}
-
 static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
 {
 	int nid;
@@ -363,14 +351,7 @@ static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
 
 static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	struct list_lru_memcg *mlrus;
-	struct list_lru_per_memcg *mlru;
-
-	spin_lock_irq(&lru->lock);
-	mlrus = rcu_dereference_protected(lru->mlrus, true);
-	mlru = rcu_dereference_protected(mlrus->mlru[src_idx], true);
-	rcu_assign_pointer(mlrus->mlru[src_idx], NULL);
-	spin_unlock_irq(&lru->lock);
+	struct list_lru_per_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
 
 	/*
 	 * The __list_lru_walk_one() can walk the list of this node.
@@ -382,78 +363,27 @@ static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 		kvfree_rcu(mlru, rcu);
 }
 
-static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
+static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
-	struct list_lru_memcg *mlrus;
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
-	mlrus = kvzalloc(struct_size(mlrus, mlru, size), GFP_KERNEL);
-	if (!mlrus)
-		return -ENOMEM;
-
-	RCU_INIT_POINTER(lru->mlrus, mlrus);
-
-	return 0;
 }
 
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
-	struct list_lru_memcg *mlrus;
+	XA_STATE(xas, &lru->xa, 0);
+	struct list_lru_per_memcg *mlru;
 
 	if (!list_lru_memcg_aware(lru))
 		return;
 
-	/*
-	 * This is called when shrinker has already been unregistered,
-	 * and nobody can use it. So, there is no need to use kvfree_rcu().
-	 */
-	mlrus = rcu_dereference_protected(lru->mlrus, true);
-	memcg_destroy_list_lru_range(mlrus, 0, memcg_nr_cache_ids);
-	kvfree(mlrus);
-}
-
-static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_size)
-{
-	struct list_lru_memcg *old, *new;
-
-	BUG_ON(old_size > new_size);
-
-	old = rcu_dereference_protected(lru->mlrus,
-					lockdep_is_held(&list_lrus_mutex));
-	new = kvmalloc(struct_size(new, mlru, new_size), GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-
-	spin_lock_irq(&lru->lock);
-	memcpy(&new->mlru, &old->mlru, flex_array_size(new, mlru, old_size));
-	memset(&new->mlru[old_size], 0, flex_array_size(new, mlru, new_size - old_size));
-	rcu_assign_pointer(lru->mlrus, new);
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
@@ -520,7 +450,7 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 		struct mem_cgroup *child;
 
 		child = mem_cgroup_from_css(css);
-		child->kmemcg_id = parent->kmemcg_id;
+		WRITE_ONCE(child->kmemcg_id, parent->kmemcg_id);
 	}
 	rcu_read_unlock();
 
@@ -530,21 +460,12 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 	mutex_unlock(&list_lrus_mutex);
 }
 
-static bool memcg_list_lru_allocated(struct mem_cgroup *memcg,
-				     struct list_lru *lru)
+static inline bool memcg_list_lru_allocated(struct mem_cgroup *memcg,
+					    struct list_lru *lru)
 {
-	bool allocated;
-	int idx;
+	int idx = memcg->kmemcg_id;
 
-	idx = memcg->kmemcg_id;
-	if (unlikely(idx < 0))
-		return true;
-
-	rcu_read_lock();
-	allocated = !!rcu_access_pointer(rcu_dereference(lru->mlrus)->mlru[idx]);
-	rcu_read_unlock();
-
-	return allocated;
+	return idx < 0 || xa_load(&lru->xa, idx);
 }
 
 /*
@@ -564,6 +485,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 		struct list_lru_per_memcg *mlru;
 		struct mem_cgroup *memcg;
 	} *table;
+	XA_STATE(xas, &lru->xa, 0);
 
 	if (!list_lru_memcg_aware(lru) || memcg_list_lru_allocated(memcg, lru))
 		return 0;
@@ -592,27 +514,48 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 		}
 	}
 
-	spin_lock_irqsave(&lru->lock, flags);
-	mlrus = rcu_dereference_protected(lru->mlrus, true);
+	xas_lock_irqsave(&xas, flags);
 	while (i--) {
-		int index = table[i].memcg->kmemcg_id;
+		int index = READ_ONCE(table[i].memcg->kmemcg_id);
 		struct list_lru_per_memcg *mlru = table[i].mlru;
 
-		if (index < 0 || rcu_dereference_protected(mlrus->mlru[index], true))
+		xas_set(&xas, index);
+retry:
+		if (unlikely(index < 0 || xas_error(&xas) || xas_load(&xas))) {
 			kfree(mlru);
-		else
-			rcu_assign_pointer(mlrus->mlru[index], mlru);
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
+				index = READ_ONCE(table[i].memcg->kmemcg_id);
+				if (index < 0)
+					xas_set_err(&xas, 0);
+				else if (!xas_error(&xas) && index != xas.xa_index)
+					xas_set(&xas, index);
+				goto retry;
+			}
+		}
 	}
-	spin_unlock_irqrestore(&lru->lock, flags);
-
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
@@ -624,7 +567,6 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key, struct shrinker *shrinker)
 {
 	int i;
-	int err = -ENOMEM;
 
 #ifdef CONFIG_MEMCG_KMEM
 	if (shrinker)
@@ -632,11 +574,10 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
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
@@ -645,18 +586,10 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
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
 
@@ -666,8 +599,6 @@ void list_lru_destroy(struct list_lru *lru)
 	if (!lru->node)
 		return;
 
-	memcg_get_cache_ids();
-
 	list_lru_unregister(lru);
 
 	memcg_destroy_list_lru(lru);
@@ -677,6 +608,5 @@ void list_lru_destroy(struct list_lru *lru)
 #ifdef CONFIG_MEMCG_KMEM
 	lru->shrinker_id = -1;
 #endif
-	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a19b1a1c8ea9..28d6d2564f9d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -351,42 +351,17 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
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
@@ -2910,49 +2885,6 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
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
@@ -3607,13 +3539,14 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
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
@@ -3657,7 +3590,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	 */
 	memcg_reparent_list_lrus(memcg, parent);
 
-	memcg_free_cache_id(kmemcg_id);
+	ida_free(&memcg_cache_ida, kmemcg_id);
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
-- 
2.11.0

