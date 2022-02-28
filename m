Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD66E4C6C1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 13:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbiB1MXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 07:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiB1MXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:23:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2774637
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:22:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 27so11207390pgk.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19HOHREB3NEbsy4dM9jVcuvJDaSZuxg6+0rHeJjgl+I=;
        b=o+jT2XLIR7Y7UVKvY8JafceKomqSpgXrMRhIUcYJEMeon2pgAq7w7Uuq6AU2Sz6mcz
         N0ockYvnCBlCZCqiFw2JXLUem3Zky3vbq36reHdc0d4In6703th6HilA6xP9AiTN7n26
         Bn80c4iFAd4JUYBDniNKWxraNAivV0PDCX8gauhtZ3p+IbtPR6Jeetw2at8WknPas5MP
         dg5TX1SLraM+pGz8sxmn34po3dlRur/2Rdeb3Lmv5eexUZdv2hsZfjVUAo9HQtX5i8By
         +HmHL1kWTAFRlHbDPah2ymV0bPFfwq+yYJxfpuwRhLf1XpHB05DxgvW1NOiu517gGrCa
         +UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19HOHREB3NEbsy4dM9jVcuvJDaSZuxg6+0rHeJjgl+I=;
        b=whUxT3nSkh6Myif2qCCxteHcyzi+XbAHpx8FrLqsaadtUWqMywGBundAlQmkvgnPob
         WWQWp6w5mwP1MEJqleM/9vzzkEajYQWhKefh4+7x9cuDWJaL8+oHoxYnMCRQkH9ZMXeb
         +DfhCNEZ7SKIdtF0focXSKbxj9JdHBSm2p3fa7+H0srTefSJTo4DOipCBhvM15ZJA+qY
         F7LoLeC+IM/J69vwC1D5r4hEVvpmqXP0xXWmf2Mo7cp55s8Zl4aGcUl+jQ9tiCEc5x6U
         lc+INgHVFjc2dqj5N+fpmp7bTFowevHCkeUXTtmxatsphyKUJUHP/edIvuzYbeqoeVMw
         hwgA==
X-Gm-Message-State: AOAM530FK9CTQPd798xiaVTYcxvX51IGcPvAW3SgEtK2dTYYmn4L4DOs
        6o5PFgTUYh3v2R/YK/DPQTK2kQ==
X-Google-Smtp-Source: ABdhPJzIC8BNlybGIkNHzucmSZt/c2J6UPZC8cp/U77QOEXiYl5AUGQs6/Cq/PkNCHbZpwqYr/hwAg==
X-Received: by 2002:a05:6a00:1c47:b0:4e1:2c3a:ac3d with SMTP id s7-20020a056a001c4700b004e12c3aac3dmr21147863pfw.15.1646050942145;
        Mon, 28 Feb 2022 04:22:22 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:22:21 -0800 (PST)
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
Subject: [PATCH v6 01/16] mm: list_lru: transpose the array of per-node per-memcg lru lists
Date:   Mon, 28 Feb 2022 20:21:11 +0800
Message-Id: <20220228122126.37293-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current scheme of maintaining per-node per-memcg lru lists looks like:
  struct list_lru {
    struct list_lru_node *node;           (for each node)
      struct list_lru_memcg *memcg_lrus;
        struct list_lru_one *lru[];       (for each memcg)
  }

By effectively transposing the two-dimension array of list_lru_one's structures
(per-node per-memcg => per-memcg per-node) it's possible to save some memory
and simplify alloc/dealloc paths. The new scheme looks like:
  struct list_lru {
    struct list_lru_memcg *mlrus;
      struct list_lru_per_memcg *mlru[];  (for each memcg)
        struct list_lru_one node[0];      (for each node)
  }

Memory savings are coming from not only 'struct rcu_head' but also some
pointer arrays used to store the pointer to 'struct list_lru_one'.  The
array is per node and its size is 8 (a pointer) * num_memcgs. So the total
size of the arrays is  8 * num_nodes * memcg_nr_cache_ids. After this patch,
the size becomes 8 * memcg_nr_cache_ids.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/list_lru.h |  17 ++--
 mm/list_lru.c            | 206 +++++++++++++++++------------------------------
 2 files changed, 86 insertions(+), 137 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 1b5fceb565df..729a27b6ff53 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -31,10 +31,15 @@ struct list_lru_one {
 	long			nr_items;
 };
 
+struct list_lru_per_memcg {
+	/* array of per cgroup per node lists, indexed by node id */
+	struct list_lru_one	node[0];
+};
+
 struct list_lru_memcg {
-	struct rcu_head		rcu;
+	struct rcu_head			rcu;
 	/* array of per cgroup lists, indexed by memcg_cache_id */
-	struct list_lru_one	*lru[];
+	struct list_lru_per_memcg	*mlru[];
 };
 
 struct list_lru_node {
@@ -42,11 +47,7 @@ struct list_lru_node {
 	spinlock_t		lock;
 	/* global list, used for the root cgroup in cgroup aware lrus */
 	struct list_lru_one	lru;
-#ifdef CONFIG_MEMCG_KMEM
-	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
-	struct list_lru_memcg	__rcu *memcg_lrus;
-#endif
-	long nr_items;
+	long			nr_items;
 } ____cacheline_aligned_in_smp;
 
 struct list_lru {
@@ -55,6 +56,8 @@ struct list_lru {
 	struct list_head	list;
 	int			shrinker_id;
 	bool			memcg_aware;
+	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
+	struct list_lru_memcg	__rcu *mlrus;
 #endif
 };
 
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0cd5e89ca063..7d1356241aa8 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -49,35 +49,37 @@ static int lru_shrinker_id(struct list_lru *lru)
 }
 
 static inline struct list_lru_one *
-list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
+list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
-	struct list_lru_memcg *memcg_lrus;
+	struct list_lru_memcg *mlrus;
+	struct list_lru_node *nlru = &lru->node[nid];
+
 	/*
 	 * Either lock or RCU protects the array of per cgroup lists
-	 * from relocation (see memcg_update_list_lru_node).
+	 * from relocation (see memcg_update_list_lru).
 	 */
-	memcg_lrus = rcu_dereference_check(nlru->memcg_lrus,
-					   lockdep_is_held(&nlru->lock));
-	if (memcg_lrus && idx >= 0)
-		return memcg_lrus->lru[idx];
+	mlrus = rcu_dereference_check(lru->mlrus, lockdep_is_held(&nlru->lock));
+	if (mlrus && idx >= 0)
+		return &mlrus->mlru[idx]->node[nid];
 	return &nlru->lru;
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 		   struct mem_cgroup **memcg_ptr)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l = &nlru->lru;
 	struct mem_cgroup *memcg = NULL;
 
-	if (!nlru->memcg_lrus)
+	if (!lru->mlrus)
 		goto out;
 
 	memcg = mem_cgroup_from_obj(ptr);
 	if (!memcg)
 		goto out;
 
-	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
 out:
 	if (memcg_ptr)
 		*memcg_ptr = memcg;
@@ -103,18 +105,18 @@ static inline bool list_lru_memcg_aware(struct list_lru *lru)
 }
 
 static inline struct list_lru_one *
-list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
+list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
-	return &nlru->lru;
+	return &lru->node[nid].lru;
 }
 
 static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
+list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 		   struct mem_cgroup **memcg_ptr)
 {
 	if (memcg_ptr)
 		*memcg_ptr = NULL;
-	return &nlru->lru;
+	return &lru->node[nid].lru;
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
@@ -127,7 +129,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, &memcg);
+		l = list_lru_from_kmem(lru, nid, item, &memcg);
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
 		if (!l->nr_items++)
@@ -150,7 +152,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(lru, nid, item, NULL);
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;
@@ -180,12 +182,11 @@ EXPORT_SYMBOL_GPL(list_lru_isolate_move);
 unsigned long list_lru_count_one(struct list_lru *lru,
 				 int nid, struct mem_cgroup *memcg)
 {
-	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
 	long count;
 
 	rcu_read_lock();
-	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
 	count = READ_ONCE(l->nr_items);
 	rcu_read_unlock();
 
@@ -206,16 +207,16 @@ unsigned long list_lru_count_node(struct list_lru *lru, int nid)
 EXPORT_SYMBOL_GPL(list_lru_count_node);
 
 static unsigned long
-__list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
+__list_lru_walk_one(struct list_lru *lru, int nid, int memcg_idx,
 		    list_lru_walk_cb isolate, void *cb_arg,
 		    unsigned long *nr_to_walk)
 {
-
+	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
 	struct list_head *item, *n;
 	unsigned long isolated = 0;
 
-	l = list_lru_from_memcg_idx(nlru, memcg_idx);
+	l = list_lru_from_memcg_idx(lru, nid, memcg_idx);
 restart:
 	list_for_each_safe(item, n, &l->list) {
 		enum lru_status ret;
@@ -272,8 +273,8 @@ list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock(&nlru->lock);
-	ret = __list_lru_walk_one(nlru, memcg_cache_id(memcg), isolate, cb_arg,
-				  nr_to_walk);
+	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+				  cb_arg, nr_to_walk);
 	spin_unlock(&nlru->lock);
 	return ret;
 }
@@ -288,8 +289,8 @@ list_lru_walk_one_irq(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock_irq(&nlru->lock);
-	ret = __list_lru_walk_one(nlru, memcg_cache_id(memcg), isolate, cb_arg,
-				  nr_to_walk);
+	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+				  cb_arg, nr_to_walk);
 	spin_unlock_irq(&nlru->lock);
 	return ret;
 }
@@ -308,7 +309,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 			struct list_lru_node *nlru = &lru->node[nid];
 
 			spin_lock(&nlru->lock);
-			isolated += __list_lru_walk_one(nlru, memcg_idx,
+			isolated += __list_lru_walk_one(lru, nid, memcg_idx,
 							isolate, cb_arg,
 							nr_to_walk);
 			spin_unlock(&nlru->lock);
@@ -328,166 +329,111 @@ static void init_one_lru(struct list_lru_one *l)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
-					  int begin, int end)
+static void memcg_destroy_list_lru_range(struct list_lru_memcg *mlrus,
+					 int begin, int end)
 {
 	int i;
 
 	for (i = begin; i < end; i++)
-		kfree(memcg_lrus->lru[i]);
+		kfree(mlrus->mlru[i]);
 }
 
-static int __memcg_init_list_lru_node(struct list_lru_memcg *memcg_lrus,
-				      int begin, int end)
+static int memcg_init_list_lru_range(struct list_lru_memcg *mlrus,
+				     int begin, int end)
 {
 	int i;
 
 	for (i = begin; i < end; i++) {
-		struct list_lru_one *l;
+		int nid;
+		struct list_lru_per_memcg *mlru;
 
-		l = kmalloc(sizeof(struct list_lru_one), GFP_KERNEL);
-		if (!l)
+		mlru = kmalloc(struct_size(mlru, node, nr_node_ids), GFP_KERNEL);
+		if (!mlru)
 			goto fail;
 
-		init_one_lru(l);
-		memcg_lrus->lru[i] = l;
+		for_each_node(nid)
+			init_one_lru(&mlru->node[nid]);
+		mlrus->mlru[i] = mlru;
 	}
 	return 0;
 fail:
-	__memcg_destroy_list_lru_node(memcg_lrus, begin, i);
+	memcg_destroy_list_lru_range(mlrus, begin, i);
 	return -ENOMEM;
 }
 
-static int memcg_init_list_lru_node(struct list_lru_node *nlru)
+static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
-	struct list_lru_memcg *memcg_lrus;
+	struct list_lru_memcg *mlrus;
 	int size = memcg_nr_cache_ids;
 
-	memcg_lrus = kvmalloc(struct_size(memcg_lrus, lru, size), GFP_KERNEL);
-	if (!memcg_lrus)
+	lru->memcg_aware = memcg_aware;
+	if (!memcg_aware)
+		return 0;
+
+	mlrus = kvmalloc(struct_size(mlrus, mlru, size), GFP_KERNEL);
+	if (!mlrus)
 		return -ENOMEM;
 
-	if (__memcg_init_list_lru_node(memcg_lrus, 0, size)) {
-		kvfree(memcg_lrus);
+	if (memcg_init_list_lru_range(mlrus, 0, size)) {
+		kvfree(mlrus);
 		return -ENOMEM;
 	}
-	RCU_INIT_POINTER(nlru->memcg_lrus, memcg_lrus);
+	RCU_INIT_POINTER(lru->mlrus, mlrus);
 
 	return 0;
 }
 
-static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
+static void memcg_destroy_list_lru(struct list_lru *lru)
 {
-	struct list_lru_memcg *memcg_lrus;
+	struct list_lru_memcg *mlrus;
+
+	if (!list_lru_memcg_aware(lru))
+		return;
+
 	/*
 	 * This is called when shrinker has already been unregistered,
 	 * and nobody can use it. So, there is no need to use kvfree_rcu().
 	 */
-	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
-	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
-	kvfree(memcg_lrus);
+	mlrus = rcu_dereference_protected(lru->mlrus, true);
+	memcg_destroy_list_lru_range(mlrus, 0, memcg_nr_cache_ids);
+	kvfree(mlrus);
 }
 
-static int memcg_update_list_lru_node(struct list_lru_node *nlru,
-				      int old_size, int new_size)
+static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_size)
 {
 	struct list_lru_memcg *old, *new;
 
 	BUG_ON(old_size > new_size);
 
-	old = rcu_dereference_protected(nlru->memcg_lrus,
+	old = rcu_dereference_protected(lru->mlrus,
 					lockdep_is_held(&list_lrus_mutex));
-	new = kvmalloc(struct_size(new, lru, new_size), GFP_KERNEL);
+	new = kvmalloc(struct_size(new, mlru, new_size), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
-	if (__memcg_init_list_lru_node(new, old_size, new_size)) {
+	if (memcg_init_list_lru_range(new, old_size, new_size)) {
 		kvfree(new);
 		return -ENOMEM;
 	}
 
-	memcpy(&new->lru, &old->lru, flex_array_size(new, lru, old_size));
-	rcu_assign_pointer(nlru->memcg_lrus, new);
+	memcpy(&new->mlru, &old->mlru, flex_array_size(new, mlru, old_size));
+	rcu_assign_pointer(lru->mlrus, new);
 	kvfree_rcu(old, rcu);
 	return 0;
 }
 
-static void memcg_cancel_update_list_lru_node(struct list_lru_node *nlru,
-					      int old_size, int new_size)
-{
-	struct list_lru_memcg *memcg_lrus;
-
-	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus,
-					       lockdep_is_held(&list_lrus_mutex));
-	/* do not bother shrinking the array back to the old size, because we
-	 * cannot handle allocation failures here */
-	__memcg_destroy_list_lru_node(memcg_lrus, old_size, new_size);
-}
-
-static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
-{
-	int i;
-
-	lru->memcg_aware = memcg_aware;
-
-	if (!memcg_aware)
-		return 0;
-
-	for_each_node(i) {
-		if (memcg_init_list_lru_node(&lru->node[i]))
-			goto fail;
-	}
-	return 0;
-fail:
-	for (i = i - 1; i >= 0; i--) {
-		if (!lru->node[i].memcg_lrus)
-			continue;
-		memcg_destroy_list_lru_node(&lru->node[i]);
-	}
-	return -ENOMEM;
-}
-
-static void memcg_destroy_list_lru(struct list_lru *lru)
-{
-	int i;
-
-	if (!list_lru_memcg_aware(lru))
-		return;
-
-	for_each_node(i)
-		memcg_destroy_list_lru_node(&lru->node[i]);
-}
-
-static int memcg_update_list_lru(struct list_lru *lru,
-				 int old_size, int new_size)
-{
-	int i;
-
-	for_each_node(i) {
-		if (memcg_update_list_lru_node(&lru->node[i],
-					       old_size, new_size))
-			goto fail;
-	}
-	return 0;
-fail:
-	for (i = i - 1; i >= 0; i--) {
-		if (!lru->node[i].memcg_lrus)
-			continue;
-
-		memcg_cancel_update_list_lru_node(&lru->node[i],
-						  old_size, new_size);
-	}
-	return -ENOMEM;
-}
-
 static void memcg_cancel_update_list_lru(struct list_lru *lru,
 					 int old_size, int new_size)
 {
-	int i;
+	struct list_lru_memcg *mlrus;
 
-	for_each_node(i)
-		memcg_cancel_update_list_lru_node(&lru->node[i],
-						  old_size, new_size);
+	mlrus = rcu_dereference_protected(lru->mlrus,
+					  lockdep_is_held(&list_lrus_mutex));
+	/*
+	 * Do not bother shrinking the array back to the old size, because we
+	 * cannot handle allocation failures here.
+	 */
+	memcg_destroy_list_lru_range(mlrus, old_size, new_size);
 }
 
 int memcg_update_all_list_lrus(int new_size)
@@ -524,8 +470,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	 */
 	spin_lock_irq(&nlru->lock);
 
-	src = list_lru_from_memcg_idx(nlru, src_idx);
-	dst = list_lru_from_memcg_idx(nlru, dst_idx);
+	src = list_lru_from_memcg_idx(lru, nid, src_idx);
+	dst = list_lru_from_memcg_idx(lru, nid, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
 
-- 
2.11.0

