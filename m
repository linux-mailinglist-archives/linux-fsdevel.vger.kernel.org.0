Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AACA392769
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhE0G0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhE0G0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:26:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E4BC061763
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:07 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 6so2930124pgk.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0eTzwbGvY3CeE+TpYrKkohuxs+OEth+NadypEgOkaJk=;
        b=BLRFzNEGNdR3foZPmFTep+tFknCyuLCTIY800eKx21ZgtrUSzYmcTuSLA97UO/af+u
         eMV43ouw74DPjAop/i9B0z8H3Hm7Uh3OUYAY1Ve83BJmZmpai95PzbDaUYX12HB9srWD
         GlvKtv/ECD2FF93sn3jumrTn7gptqmG0wFcC4NwA0dF5cZz2rnMMD9X1rsnn5lIQsEtz
         nN3WllBjsBBGKk5oN/x94pyrsdpYqRgpY5suCmQZqRTZQIKJEvEZupdvjYdx1akI8ULk
         BrnG3TEQAm63dTx/UL99DM0xR+7hzFutf9ViuSK/dA/PLJg9COf51B2hVpj9aP163el2
         BYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0eTzwbGvY3CeE+TpYrKkohuxs+OEth+NadypEgOkaJk=;
        b=pMHqqfJQcbJxcc6EhIeRHgE8QvyHn4CxUax4Qb8IEnKKvBYYDBzmFvUxNWbvNC0jBP
         qqhFTOsL4UU3xeTiLFbuh7ctOpa4V0vsDQN4ay4rMOAmrtVqiUYR0ocCtvqGzx2WnHmw
         yzr83cpD80awJANzn7lBwWT2W0oaf+Xym2xxJQlMkf7kagUVcvP+FDWUSi1KnBV2Mv35
         LFC3gVWVxNkSaPnLu6VdRfsEaCKHAMMzPO9Cmb4cTTvbSYy/3h7HXDZKdq6zm7tGQWoU
         6i6g1SYKg/jlQiHDHwGai8d9G54SZSA4SdUHwh+jUT4wEqFvcOCU/1Vvm7S8lcCc0aZM
         HMbA==
X-Gm-Message-State: AOAM531t4fue5hk79AlABBbcMVkxH+WC81KUoK9xGThyqIGbe+51brzE
        ZrnB2h39HflORjWJgMHyxMcNWQ==
X-Google-Smtp-Source: ABdhPJx69UQxplc9r/Oe9C7QDynhj361rLe45eMKQsH8ZPDIMauhXxR1Gke1KhDNIyf85fbct6qSgg==
X-Received: by 2002:a63:224d:: with SMTP id t13mr2259684pgm.283.1622096707266;
        Wed, 26 May 2021 23:25:07 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.25.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:25:06 -0700 (PDT)
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
Subject: [PATCH v2 07/21] mm: list_lru: optimize the array of per memcg lists memory consumption
Date:   Thu, 27 May 2021 14:21:34 +0800
Message-Id: <20210527062148.9361-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The list_lru use an array to store the list_lru_one pointers, which is
per-memcg per-node. What if we run 10k containers in the system? The
size of the array of every list_lru can be 10k * number_of_node *
sizeof(void *). The array size becomes very big, the more numa node
in the system, the more memory we consume. We can convert the array
to per memcg instead of per-memcg per-node. It can save memory
especially when there are many numa nodes in the system. And also
simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  17 +++--
 mm/list_lru.c            | 191 +++++++++++++++++------------------------------
 2 files changed, 79 insertions(+), 129 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 9dcaa3e582c9..20a43904001d 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -31,10 +31,15 @@ struct list_lru_one {
 	long			nr_items;
 };
 
+struct list_lru_per_memcg {
+	/* array of per cgroup per node lists, indexed by node id */
+	struct list_lru_one	nodes[0];
+};
+
 struct list_lru_memcg {
-	struct rcu_head		rcu;
+	struct rcu_head			rcu;
 	/* array of per cgroup lists, indexed by memcg_cache_id */
-	struct list_lru_one	*lru[];
+	struct list_lru_per_memcg	*lrus[];
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
+	struct list_lru_memcg	__rcu *memcg_lrus;
 #endif
 };
 
diff --git a/mm/list_lru.c b/mm/list_lru.c
index bed699edabe5..e52f5a91fa0f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -49,35 +49,38 @@ static int lru_shrinker_id(struct list_lru *lru)
 }
 
 static inline struct list_lru_one *
-list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
+list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
 	struct list_lru_memcg *memcg_lrus;
+	struct list_lru_node *nlru = &lru->node[nid];
+
 	/*
 	 * Either lock or RCU protects the array of per cgroup lists
-	 * from relocation (see memcg_update_list_lru_node).
+	 * from relocation (see memcg_update_list_lru).
 	 */
-	memcg_lrus = rcu_dereference_check(nlru->memcg_lrus,
+	memcg_lrus = rcu_dereference_check(lru->memcg_lrus,
 					   lockdep_is_held(&nlru->lock));
 	if (memcg_lrus && idx >= 0)
-		return memcg_lrus->lru[idx];
+		return &memcg_lrus->lrus[idx]->nodes[nid];
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
+	if (!lru->memcg_lrus)
 		goto out;
 
 	memcg = mem_cgroup_from_obj(ptr);
 	if (!memcg)
 		goto out;
 
-	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
 out:
 	if (memcg_ptr)
 		*memcg_ptr = memcg;
@@ -103,18 +106,18 @@ static inline bool list_lru_memcg_aware(struct list_lru *lru)
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
 
@@ -127,7 +130,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, &memcg);
+		l = list_lru_from_kmem(lru, nid, item, &memcg);
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
 		if (!l->nr_items++)
@@ -150,7 +153,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(nlru, item, NULL);
+		l = list_lru_from_kmem(lru, nid, item, NULL);
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;
@@ -180,12 +183,11 @@ EXPORT_SYMBOL_GPL(list_lru_isolate_move);
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
 
@@ -206,16 +208,16 @@ unsigned long list_lru_count_node(struct list_lru *lru, int nid)
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
@@ -272,8 +274,8 @@ list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock(&nlru->lock);
-	ret = __list_lru_walk_one(nlru, memcg_cache_id(memcg), isolate, cb_arg,
-				  nr_to_walk);
+	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+				  cb_arg, nr_to_walk);
 	spin_unlock(&nlru->lock);
 	return ret;
 }
@@ -288,8 +290,8 @@ list_lru_walk_one_irq(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock_irq(&nlru->lock);
-	ret = __list_lru_walk_one(nlru, memcg_cache_id(memcg), isolate, cb_arg,
-				  nr_to_walk);
+	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+				  cb_arg, nr_to_walk);
 	spin_unlock_irq(&nlru->lock);
 	return ret;
 }
@@ -308,7 +310,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 			struct list_lru_node *nlru = &lru->node[nid];
 
 			spin_lock(&nlru->lock);
-			isolated += __list_lru_walk_one(nlru, memcg_idx,
+			isolated += __list_lru_walk_one(lru, nid, memcg_idx,
 							isolate, cb_arg,
 							nr_to_walk);
 			spin_unlock(&nlru->lock);
@@ -328,169 +330,114 @@ static void init_one_lru(struct list_lru_one *l)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
-					  int begin, int end)
+static void memcg_destroy_list_lru_range(struct list_lru_memcg *memcg_lrus,
+					 int begin, int end)
 {
 	int i;
 
 	for (i = begin; i < end; i++)
-		kfree(memcg_lrus->lru[i]);
+		kfree(memcg_lrus->lrus[i]);
 }
 
-static int __memcg_init_list_lru_node(struct list_lru_memcg *memcg_lrus,
-				      int begin, int end)
+static int memcg_init_list_lru_range(struct list_lru_memcg *memcg_lrus,
+				     int begin, int end)
 {
 	int i;
 
 	for (i = begin; i < end; i++) {
-		struct list_lru_one *l;
+		int nid;
+		struct list_lru_per_memcg *lru;
 
-		l = kmalloc(sizeof(struct list_lru_one), GFP_KERNEL);
-		if (!l)
+		lru = kmalloc(struct_size(lru, nodes, nr_node_ids), GFP_KERNEL);
+		if (!lru)
 			goto fail;
 
-		init_one_lru(l);
-		memcg_lrus->lru[i] = l;
+		for_each_node(nid)
+			init_one_lru(&lru->nodes[nid]);
+		memcg_lrus->lrus[i] = lru;
 	}
 	return 0;
 fail:
-	__memcg_destroy_list_lru_node(memcg_lrus, begin, i);
+	memcg_destroy_list_lru_range(memcg_lrus, begin, i);
 	return -ENOMEM;
 }
 
-static int memcg_init_list_lru_node(struct list_lru_node *nlru)
+static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
 	struct list_lru_memcg *memcg_lrus;
 	int size = memcg_nr_cache_ids;
 
+	lru->memcg_aware = memcg_aware;
+	if (!memcg_aware)
+		return 0;
+
 	memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
-			      size * sizeof(void *), GFP_KERNEL);
+			      size * sizeof(memcg_lrus->lrus[0]), GFP_KERNEL);
 	if (!memcg_lrus)
 		return -ENOMEM;
 
-	if (__memcg_init_list_lru_node(memcg_lrus, 0, size)) {
+	if (memcg_init_list_lru_range(memcg_lrus, 0, size)) {
 		kvfree(memcg_lrus);
 		return -ENOMEM;
 	}
-	RCU_INIT_POINTER(nlru->memcg_lrus, memcg_lrus);
+	RCU_INIT_POINTER(lru->memcg_lrus, memcg_lrus);
 
 	return 0;
 }
 
-static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
+static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 	struct list_lru_memcg *memcg_lrus;
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
+	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
+	memcg_destroy_list_lru_range(memcg_lrus, 0, memcg_nr_cache_ids);
 	kvfree(memcg_lrus);
 }
 
-static int memcg_update_list_lru_node(struct list_lru_node *nlru,
-				      int old_size, int new_size)
+static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_size)
 {
 	struct list_lru_memcg *old, *new;
 
 	BUG_ON(old_size > new_size);
 
-	old = rcu_dereference_protected(nlru->memcg_lrus,
+	old = rcu_dereference_protected(lru->memcg_lrus,
 					lockdep_is_held(&list_lrus_mutex));
-	new = kvmalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
+	new = kvmalloc(sizeof(*new) + new_size * sizeof(new->lrus[0]), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
-	if (__memcg_init_list_lru_node(new, old_size, new_size)) {
+	if (memcg_init_list_lru_range(new, old_size, new_size)) {
 		kvfree(new);
 		return -ENOMEM;
 	}
 
-	memcpy(&new->lru, &old->lru, old_size * sizeof(void *));
+	memcpy(&new->lrus, &old->lrus, old_size * sizeof(new->lrus[0]));
 
-	rcu_assign_pointer(nlru->memcg_lrus, new);
+	rcu_assign_pointer(lru->memcg_lrus, new);
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
+	struct list_lru_memcg *memcg_lrus;
 
-	for_each_node(i)
-		memcg_cancel_update_list_lru_node(&lru->node[i],
-						  old_size, new_size);
+	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus,
+					       lockdep_is_held(&list_lrus_mutex));
+	/*
+	 * Do not bother shrinking the array back to the old size, because we
+	 * cannot handle allocation failures here.
+	 */
+	memcg_destroy_list_lru_range(memcg_lrus, old_size, new_size);
 }
 
 int memcg_update_all_list_lrus(int new_size)
@@ -527,8 +474,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	 */
 	spin_lock_irq(&nlru->lock);
 
-	src = list_lru_from_memcg_idx(nlru, src_idx);
-	dst = list_lru_from_memcg_idx(nlru, dst_idx);
+	src = list_lru_from_memcg_idx(lru, nid, src_idx);
+	dst = list_lru_from_memcg_idx(lru, nid, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
 
-- 
2.11.0

