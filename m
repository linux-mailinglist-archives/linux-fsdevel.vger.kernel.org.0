Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15B37A509
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 12:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhEKKxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 06:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhEKKxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 06:53:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38187C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:52:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fa21-20020a17090af0d5b0290157eb6b590fso1123652pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jeTdKVRo5QuCEVZvKj9gqqAVw4NEW3vKLIlTKdR8pEg=;
        b=WOPHoX6BIlEp8VCErN6A7MSF0B/or02EmfQESVTCay6cbvtkIwijQDJkB5QcnN8yaG
         pknIj8oCwjzhmrUjKxfue2hrDZM/dwXZO7XNwqGLyEstGsyT8pEiabjUg5vcuo4Yr1rE
         UUiKYUR2S9AeIAqGsg8fcxjOHtwtgH0lAN2MAUXXngRNP2NAHafIGo3tG7RPSeAI/Ihr
         V/t0txXkFOvLBanEtbQIijkBBQ+4ECWiKOvds4GrV0QtWdiyYxi+d1FjOEM5sJkPy9Xe
         BHQ8DBvNd+MbpDCI7My51VARp9Oup4dbaNVX9bGjRueqSESvyyh2wlc293POFgkgeGMp
         BXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jeTdKVRo5QuCEVZvKj9gqqAVw4NEW3vKLIlTKdR8pEg=;
        b=AJKrCh1+/BeT/PAajAIiLOtF+NGDXwYgIbG6O+rbqjaBm9tn+P0dBUhYv8MO6+HvcX
         xyjA8HZAjVaSSB+P1ObY3zG4dppifU8PCWUGwT2WDH1Yz/7/Ny0vkO0T+I/fVubabfOX
         v2ccZDzlcmeC2wCv5kJI70fM3+wTIkVCKmxP4+wYDkanu8scwxYYQ8hmNJuYKMa66M70
         NOElyWCZzFtEr1bpZe0xaYjDmS+ZxlURNKI8PvPmUpNz7mLWMDN7JDmHvoqngV0TmLiY
         wlUAdJV1fJif+gSx/rynDQR3KGbvIjCMqviVPcK0M348BhQCJyLoTc4wlHH9R+r6MZm9
         0+vQ==
X-Gm-Message-State: AOAM533PbMNfE1wjY0ugJpEu+9zJwYSN3fPhpunHMUTJY/ld7I9ItEMC
        ZgyrWs9TKErenbPXAbxIRiEAqg==
X-Google-Smtp-Source: ABdhPJxot+KaqQBQ93sZ5shlFuZodNdl7RCg71lYf+C98aDm4ASSHdeHf7imeXBDKqNZSd+EyI7mwg==
X-Received: by 2002:a17:90a:1d41:: with SMTP id u1mr19116963pju.20.1620730326736;
        Tue, 11 May 2021 03:52:06 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.51.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:52:06 -0700 (PDT)
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
Subject: [PATCH 07/17] mm: list_lru: optimize the array of per memcg lists
Date:   Tue, 11 May 2021 18:46:37 +0800
Message-Id: <20210511104647.604-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The list_lru use an array to store the list_lru_one pointers, which is
per memcg per node. What if we run 10k+ containers in the system? The
size of the arrays for every list lru can be 10k * number_of_node *
sizeof(void *). We can convert the array to per memcg instead of per
memcg per node. It can help us save memory especially when there are
many nodes in the system. And also simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  17 +++--
 mm/list_lru.c            | 192 +++++++++++++++++------------------------------
 2 files changed, 80 insertions(+), 129 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 9dcaa3e582c9..228bef9fdd0b 100644
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
+	struct list_lru_per_memcg	*lrus[0];
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
index bed699edabe5..57c55916cc1c 100644
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
@@ -328,169 +330,115 @@ static void init_one_lru(struct list_lru_one *l)
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
+		lru = kmalloc(sizeof(*lru) + nr_node_ids * sizeof(lru->nodes[0]),
+			      GFP_KERNEL);
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
@@ -527,8 +475,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	 */
 	spin_lock_irq(&nlru->lock);
 
-	src = list_lru_from_memcg_idx(nlru, src_idx);
-	dst = list_lru_from_memcg_idx(nlru, dst_idx);
+	src = list_lru_from_memcg_idx(lru, nid, src_idx);
+	dst = list_lru_from_memcg_idx(lru, nid, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
 
-- 
2.11.0

