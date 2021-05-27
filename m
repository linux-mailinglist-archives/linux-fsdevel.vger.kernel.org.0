Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1771B392786
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhE0G2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhE0G1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:27:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF616C06138D
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q6so2153700pjj.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxzrjvjXV2Eb7kWOVBsK4sUU1R7f70qUcGgMHnDVcHI=;
        b=t4hkMdYNvrvfTjfTlG4PkoB+1Y72l29crVEA4B0v9iJzdHGAeR7stiwSa9UlZhvTKv
         BrPAqyck16KYdqqW1zhyGFF9NRlSY3TlHhpTZz34YNZPZg9kaJRCIbhXMRZ1zVM52mcz
         0fJTaCqA1XgvhKynVVYi3qbYRbFZK1pHmZ7n55qPOauFpIOVFHVyd5fN2YBWS3XMbWqo
         beud+Ewd9d81BNQpBv9GViXrbb4dwTG3u8ZGJzSoU9tUM3tJX2p8WXsUS23pCEfAvc1H
         O259gMTGuy/TEsH8cJ/lUgmzyL2akCG0RjTUdyjzNpKiFozXI0Z5glni2U5T5BScwLvO
         PviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxzrjvjXV2Eb7kWOVBsK4sUU1R7f70qUcGgMHnDVcHI=;
        b=Gy1oprI1G2ena5erfrLlRaFabb3bNwMG5Z7O7LDi830NSnx/YG7pnnZkEJC76eGkBz
         H0cL2mZfEuot+Hoim3y8cuUtPXdmnACM7DgFJQC3FKL1UcTRCHCCnd0O8C5sK5F2vTdN
         nEjiArz8gqQkCXQc3cHIUqW3Fec9GZxbfEP843SfduEXxnQ/FhnTyPO30Sbr6rB0Z7Qe
         Su47fbazywp2fInvf0QYFNEnbVG+8BVK3EftVHqTSYMh39/V0+WafwLmqRbmWVjXZJTp
         WIziCfaPXYTCApy+EG0i9UMif3LqtgymMxH8zfrww9nmJp+nWwq4CgQkeVKFGdVdUEDm
         X4SQ==
X-Gm-Message-State: AOAM5312ucc2peRMid0IKYleJvHgSfiKOr3HOQNO/vi42qpdgKWOCb2q
        xrI6/B13JEYXQBpUDFiaSlYirQ==
X-Google-Smtp-Source: ABdhPJzb1VGLxwaOmIEI3Kq0EsIx65fHzy4pZUgLiumgkQjJ8LkIodccqpolnl9x+a/RgJ1oO/TpfA==
X-Received: by 2002:a17:90a:590d:: with SMTP id k13mr2203021pji.68.1622096766339;
        Wed, 26 May 2021 23:26:06 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.25.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:26:06 -0700 (PDT)
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
Subject: [PATCH v2 15/21] mm: list_lru: allocate list_lru_one only when needed
Date:   Thu, 27 May 2021 14:21:42 +0800
Message-Id: <20210527062148.9361-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In our server, we found a suspected memory leak problem. The kmalloc-32
consumes more than 6GB of memory. Other kmem_caches consume less than
2GB memory.

After our in-depth analysis, the memory consumption of kmalloc-32 slab
cache is the cause of list_lru_one allocation.

  crash> p memcg_nr_cache_ids
  memcg_nr_cache_ids = $2 = 24574

memcg_nr_cache_ids is very large and memory consumption of each list_lru
can be calculated with the following formula.

  num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)

There are 4 numa nodes in our system, so each list_lru consumes ~3MB.

  crash> list super_blocks | wc -l
  952

Every mount will register 2 list lrus, one is for inode, another is for
dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
MB (~5.6GB). But the number of memory cgroup is less than 500. So I
guess more than 12286 containers have been deployed on this machine (I
do not know why there are so many containers, it may be a user's bug or
the user really want to do that). And memcg_nr_cache_ids has not been
reduced to a suitable value. This can waste a lot of memory.

Now the infrastructure for dynamic list_lru_one allocation is ready, so
remove statically allocated memory code to save memory.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |   8 +--
 mm/list_lru.c            | 125 +++++++++++++++++++++++++++--------------------
 mm/memcontrol.c          |   7 ++-
 3 files changed, 81 insertions(+), 59 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 2083f4f2701f..00c15dc1ede3 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -32,14 +32,15 @@ struct list_lru_one {
 };
 
 struct list_lru_per_memcg {
+	struct rcu_head		rcu;
 	/* array of per cgroup per node lists, indexed by node id */
-	struct list_lru_one	nodes[0];
+	struct list_lru_one	nodes[];
 };
 
 struct list_lru_memcg {
 	struct rcu_head			rcu;
 	/* array of per cgroup lists, indexed by memcg_cache_id */
-	struct list_lru_per_memcg	*lrus[];
+	struct list_lru_per_memcg __rcu	*lrus[];
 };
 
 struct list_lru_node {
@@ -75,7 +76,8 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
+void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
+			       struct mem_cgroup *dst_memcg);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 4ba1db6d4409..43eadb0834e1 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -60,8 +60,12 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 	 */
 	memcg_lrus = rcu_dereference_check(lru->memcg_lrus,
 					   lockdep_is_held(&nlru->lock));
-	if (memcg_lrus && idx >= 0)
-		return &memcg_lrus->lrus[idx]->nodes[nid];
+	if (memcg_lrus && idx >= 0) {
+		struct list_lru_per_memcg *mlru;
+
+		mlru = rcu_dereference_check(memcg_lrus->lrus[idx], true);
+		return mlru ? &mlru->nodes[nid] : NULL;
+	}
 	return &nlru->lru;
 }
 
@@ -184,11 +188,12 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 				 int nid, struct mem_cgroup *memcg)
 {
 	struct list_lru_one *l;
-	long count;
+	long count = 0;
 
 	rcu_read_lock();
 	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
-	count = READ_ONCE(l->nr_items);
+	if (l)
+		count = READ_ONCE(l->nr_items);
 	rcu_read_unlock();
 
 	if (unlikely(count < 0))
@@ -217,8 +222,11 @@ __list_lru_walk_one(struct list_lru *lru, int nid, int memcg_idx,
 	struct list_head *item, *n;
 	unsigned long isolated = 0;
 
-	l = list_lru_from_memcg_idx(lru, nid, memcg_idx);
 restart:
+	l = list_lru_from_memcg_idx(lru, nid, memcg_idx);
+	if (!l)
+		goto out;
+
 	list_for_each_safe(item, n, &l->list) {
 		enum lru_status ret;
 
@@ -262,6 +270,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid, int memcg_idx,
 			BUG();
 		}
 	}
+out:
 	return isolated;
 }
 
@@ -354,20 +363,26 @@ static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
 	return lru;
 }
 
-static int memcg_init_list_lru_range(struct list_lru_memcg *memcg_lrus,
-				     int begin, int end)
+static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	int i;
+	struct list_lru_memcg *memcg_lrus;
+	struct list_lru_per_memcg *mlru;
 
-	for (i = begin; i < end; i++) {
-		memcg_lrus->lrus[i] = memcg_list_lru_alloc(GFP_KERNEL);
-		if (!memcg_lrus->lrus[i])
-			goto fail;
-	}
-	return 0;
-fail:
-	memcg_destroy_list_lru_range(memcg_lrus, begin, i);
-	return -ENOMEM;
+	spin_lock_irq(&lru->lock);
+	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
+	mlru = rcu_dereference_protected(memcg_lrus->lrus[src_idx], true);
+	if (mlru)
+		rcu_assign_pointer(memcg_lrus->lrus[src_idx], NULL);
+	spin_unlock_irq(&lru->lock);
+
+	/*
+	 * The __list_lru_walk_one() can walk the list of this node.
+	 * We need kvfree_rcu() here. And the walking of the list
+	 * is under lru->node[nid]->lock, which can serve as a RCU
+	 * read-side critical section.
+	 */
+	if (mlru)
+		kvfree_rcu(mlru, rcu);
 }
 
 static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
@@ -382,15 +397,11 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 
 	spin_lock_init(&lru->lock);
 
-	memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
+	memcg_lrus = kvzalloc(sizeof(*memcg_lrus) +
 			      size * sizeof(memcg_lrus->lrus[0]), GFP_KERNEL);
 	if (!memcg_lrus)
 		return -ENOMEM;
 
-	if (memcg_init_list_lru_range(memcg_lrus, 0, size)) {
-		kvfree(memcg_lrus);
-		return -ENOMEM;
-	}
 	RCU_INIT_POINTER(lru->memcg_lrus, memcg_lrus);
 
 	return 0;
@@ -424,13 +435,9 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
 	if (!new)
 		return -ENOMEM;
 
-	if (memcg_init_list_lru_range(new, old_size, new_size)) {
-		kvfree(new);
-		return -ENOMEM;
-	}
-
 	spin_lock_irq(&lru->lock);
 	memcpy(&new->lrus, &old->lrus, old_size * sizeof(new->lrus[0]));
+	memset(&new->lrus[old_size], 0, (new_size - old_size) * sizeof(new->lrus[0]));
 	rcu_assign_pointer(lru->memcg_lrus, new);
 	spin_unlock_irq(&lru->lock);
 
@@ -439,20 +446,6 @@ static int memcg_update_list_lru(struct list_lru *lru, int old_size, int new_siz
 	return 0;
 }
 
-static void memcg_cancel_update_list_lru(struct list_lru *lru,
-					 int old_size, int new_size)
-{
-	struct list_lru_memcg *memcg_lrus;
-
-	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus,
-					       lockdep_is_held(&list_lrus_mutex));
-	/*
-	 * Do not bother shrinking the array back to the old size, because we
-	 * cannot handle allocation failures here.
-	 */
-	memcg_destroy_list_lru_range(memcg_lrus, old_size, new_size);
-}
-
 int memcg_update_all_list_lrus(int new_size)
 {
 	int ret = 0;
@@ -463,15 +456,10 @@ int memcg_update_all_list_lrus(int new_size)
 	list_for_each_entry(lru, &list_lrus, list) {
 		ret = memcg_update_list_lru(lru, old_size, new_size);
 		if (ret)
-			goto fail;
+			break;
 	}
-out:
 	mutex_unlock(&list_lrus_mutex);
 	return ret;
-fail:
-	list_for_each_entry_continue_reverse(lru, &list_lrus, list)
-		memcg_cancel_update_list_lru(lru, old_size, new_size);
-	goto out;
 }
 
 static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
@@ -488,6 +476,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	spin_lock_irq(&nlru->lock);
 
 	src = list_lru_from_memcg_idx(lru, nid, src_idx);
+	if (!src)
+		goto out;
 	dst = list_lru_from_memcg_idx(lru, nid, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
@@ -497,7 +487,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 		set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 		src->nr_items = 0;
 	}
-
+out:
 	spin_unlock_irq(&nlru->lock);
 }
 
@@ -508,11 +498,37 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 
 	for_each_node(i)
 		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
+
+	memcg_list_lru_free(lru, src_idx);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
+void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
+			       struct mem_cgroup *dst_memcg)
 {
+	struct cgroup_subsys_state *css;
 	struct list_lru *lru;
+	int src_idx = src_memcg->kmemcg_id;
+
+	/*
+	 * Change kmemcg_id of this cgroup and all its descendants to the
+	 * parent's id, and then move all entries from this cgroup's list_lrus
+	 * to ones of the parent.
+	 *
+	 * After we have finished, all list_lrus corresponding to this cgroup
+	 * are guaranteed to remain empty. So we can safely free this cgroup's
+	 * list lrus which is freed in memcg_list_lru_free().
+	 * Changing ->kmemcg_id to the parent can prevent list_lru_memcg_alloc()
+	 * from allocating list lrus for this cgroup after calling
+	 * memcg_list_lru_free().
+	 */
+	rcu_read_lock();
+	css_for_each_descendant_pre(css, &src_memcg->css) {
+		struct mem_cgroup *memcg;
+
+		memcg = mem_cgroup_from_css(css);
+		memcg->kmemcg_id = dst_memcg->kmemcg_id;
+	}
+	rcu_read_unlock();
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
@@ -531,7 +547,7 @@ static bool memcg_list_lru_skip_alloc(struct list_lru *lru,
 
 	rcu_read_lock();
 	memcg_lrus = rcu_dereference(lru->memcg_lrus);
-	if (memcg_lrus->lrus[idx]) {
+	if (rcu_access_pointer(memcg_lrus->lrus[idx])) {
 		rcu_read_unlock();
 		return true;
 	}
@@ -546,7 +562,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	struct list_lru_memcg *memcg_lrus;
 	int i;
 
-	struct list_lru_memcg {
+	struct list_lru_memcg_table {
 		struct list_lru_per_memcg *mlru;
 		struct mem_cgroup *memcg;
 	} *table;
@@ -590,11 +606,12 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
 	while (i--) {
 		int index = memcg_cache_id(table[i].memcg);
+		struct list_lru_per_memcg *mlru = table[i].mlru;
 
-		if (memcg_lrus->lrus[index])
-			kfree(table[i].mlru);
+		if (index < 0 || rcu_dereference_protected(memcg_lrus->lrus[index], true))
+			kfree(mlru);
 		else
-			memcg_lrus->lrus[index] = table[i].mlru;
+			rcu_assign_pointer(memcg_lrus->lrus[index], mlru);
 	}
 	spin_unlock_irqrestore(&lru->lock, flags);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09bafa82781f..1994513a33d4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3654,10 +3654,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
 	memcg_reparent_objcgs(memcg, parent);
 
+	/*
+	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * Cache it to @kmemcg_id.
+	 */
 	kmemcg_id = memcg->kmemcg_id;
 
-	/* memcg_reparent_objcgs() must be called before this. */
-	memcg_drain_all_list_lrus(kmemcg_id, parent);
+	memcg_drain_all_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

