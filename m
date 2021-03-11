Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ABB337D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCKTJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCKTJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:04 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB2BC061574;
        Thu, 11 Mar 2021 11:09:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q204so174918pfq.10;
        Thu, 11 Mar 2021 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXVD1HfpEWEnPEpQNQZ2lptmmkG469kO8T607Rced4s=;
        b=EUuo4QwlFAcOak5Bd6ymMS/yjW6KIitnzDmweZ+6TMFTs28kzMP153UsCSwNHtB8GN
         ugv5lyBUhhNlU83j1V7JpEQoliqop1Q/rAAYy83B4rbWQf0A+Gn3m8NEWbY0op5Av6zB
         4w0trsxiK0JWamO+YOPbZt7TEopBi9efsgdQL4bnapW6XkuA9B+YkpFG9H+oMr+kBEEI
         /lWkv23t+88xGcpnNJ9+rAYmEhY3qa9LvPx7MKG0EGzga6YZDoYnmrFEndeiBeXzbyOJ
         k1tM+ljirBNAuBvPLvi/eJbFzKWfBZXrdqzYGN7KSOuqooAyI/M4+mhgNzCXSSmZuVOS
         WyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXVD1HfpEWEnPEpQNQZ2lptmmkG469kO8T607Rced4s=;
        b=L10Y0xncfseiyG1ljI92+KBULnQJa0sCmQVLdMV3apLjDryQmP4BCpAfkZViY02ODq
         9k6w6uVsgxg23LbXueZatUBy/cmF7GdQhyqU3gWX8feKyDNU/9lEk/2LaW3K3VhmCqDc
         GFBeegmGWxAmHEqpXqMIPoaLnV8n30ihPbArRL4DPyIdFPe/j9ZDzHbMKZqtBBZcQqEY
         gzYgRWSxAOAHrUjbNfBCIr3Rf9574WW2ZbuZAZFtwkJIXbHOsWxaF6cLtKW+tuU/WppH
         nNX1LUnrBu1X5t0L/NTvHbHkQru0sPr4Ex72MmWWfiF8VnVPpq4MVj1L21Q4FsmjNaFJ
         x7sA==
X-Gm-Message-State: AOAM5308NhofPSEm/1NcVmRXIWxbb9McsnLbRYLFOHmQdT/tylfS4Dxv
        7YPxpD5cFznu5xof0nobLf8=
X-Google-Smtp-Source: ABdhPJx98HcHkFsDZbrn39hydWs6DZ5rXIRgUHXoKJBLC01b9UOlPPllqcquB2rNWDllsSt1a3aSEw==
X-Received: by 2002:aa7:8498:0:b029:1f6:8a25:7ade with SMTP id u24-20020aa784980000b02901f68a257ademr8837086pfn.76.1615489743876;
        Thu, 11 Mar 2021 11:09:03 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:02 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 02/13] mm: vmscan: consolidate shrinker_maps handling code
Date:   Thu, 11 Mar 2021 11:08:34 -0800
Message-Id: <20210311190845.9708-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The shrinker map management is not purely memcg specific, it is at the intersection
between memory cgroup and shrinkers.  It's allocation and assignment of a structure,
and the only memcg bit is the map is being stored in a memcg structure.  So move the
shrinker_maps handling code into vmscan.c for tighter integration with shrinker code,
and remove the "memcg_" prefix.  There is no functional change.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/memcontrol.h |  11 ++--
 mm/huge_memory.c           |   4 +-
 mm/list_lru.c              |   6 +-
 mm/memcontrol.c            | 130 +-----------------------------------
 mm/vmscan.c                | 132 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 142 insertions(+), 141 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e946c96daa32..b07dc2d5014d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1533,10 +1533,9 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 	return false;
 }
 
-extern int memcg_expand_shrinker_maps(int new_id);
-
-extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
-				   int nid, int shrinker_id);
+int alloc_shrinker_maps(struct mem_cgroup *memcg);
+void free_shrinker_maps(struct mem_cgroup *memcg);
+void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
 #else
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
@@ -1546,8 +1545,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 	return false;
 }
 
-static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
-					  int nid, int shrinker_id)
+static inline void set_shrinker_bit(struct mem_cgroup *memcg,
+				    int nid, int shrinker_id)
 {
 }
 #endif
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bff92dea5ab3..92a1227be029 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2836,8 +2836,8 @@ void deferred_split_huge_page(struct page *page)
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
 		if (memcg)
-			memcg_set_shrinker_bit(memcg, page_to_nid(page),
-					       deferred_split_shrinker.id);
+			set_shrinker_bit(memcg, page_to_nid(page),
+					 deferred_split_shrinker.id);
 #endif
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 6f067b6b935f..cd58790d0fb3 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -125,8 +125,8 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
 		if (!l->nr_items++)
-			memcg_set_shrinker_bit(memcg, nid,
-					       lru_shrinker_id(lru));
+			set_shrinker_bit(memcg, nid,
+					 lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -540,7 +540,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 
 	if (src->nr_items) {
 		dst->nr_items += src->nr_items;
-		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
+		set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 		src->nr_items = 0;
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index da6fded852df..aeb1847f159c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -402,130 +402,6 @@ DEFINE_STATIC_KEY_FALSE(memcg_kmem_enabled_key);
 EXPORT_SYMBOL(memcg_kmem_enabled_key);
 #endif
 
-static int memcg_shrinker_map_size;
-static DEFINE_MUTEX(memcg_shrinker_map_mutex);
-
-static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
-{
-	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
-}
-
-static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
-					 int size, int old_size)
-{
-	struct memcg_shrinker_map *new, *old;
-	struct mem_cgroup_per_node *pn;
-	int nid;
-
-	lockdep_assert_held(&memcg_shrinker_map_mutex);
-
-	for_each_node(nid) {
-		pn = memcg->nodeinfo[nid];
-		old = rcu_dereference_protected(pn->shrinker_map, true);
-		/* Not yet online memcg */
-		if (!old)
-			return 0;
-
-		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
-		if (!new)
-			return -ENOMEM;
-
-		/* Set all old bits, clear all new bits */
-		memset(new->map, (int)0xff, old_size);
-		memset((void *)new->map + old_size, 0, size - old_size);
-
-		rcu_assign_pointer(pn->shrinker_map, new);
-		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
-	}
-
-	return 0;
-}
-
-static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup_per_node *pn;
-	struct memcg_shrinker_map *map;
-	int nid;
-
-	if (mem_cgroup_is_root(memcg))
-		return;
-
-	for_each_node(nid) {
-		pn = memcg->nodeinfo[nid];
-		map = rcu_dereference_protected(pn->shrinker_map, true);
-		kvfree(map);
-		rcu_assign_pointer(pn->shrinker_map, NULL);
-	}
-}
-
-static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
-{
-	struct memcg_shrinker_map *map;
-	int nid, size, ret = 0;
-
-	if (mem_cgroup_is_root(memcg))
-		return 0;
-
-	mutex_lock(&memcg_shrinker_map_mutex);
-	size = memcg_shrinker_map_size;
-	for_each_node(nid) {
-		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
-		if (!map) {
-			memcg_free_shrinker_maps(memcg);
-			ret = -ENOMEM;
-			break;
-		}
-		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
-	}
-	mutex_unlock(&memcg_shrinker_map_mutex);
-
-	return ret;
-}
-
-int memcg_expand_shrinker_maps(int new_id)
-{
-	int size, old_size, ret = 0;
-	struct mem_cgroup *memcg;
-
-	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
-	old_size = memcg_shrinker_map_size;
-	if (size <= old_size)
-		return 0;
-
-	mutex_lock(&memcg_shrinker_map_mutex);
-	if (!root_mem_cgroup)
-		goto unlock;
-
-	for_each_mem_cgroup(memcg) {
-		if (mem_cgroup_is_root(memcg))
-			continue;
-		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
-		if (ret) {
-			mem_cgroup_iter_break(NULL, memcg);
-			goto unlock;
-		}
-	}
-unlock:
-	if (!ret)
-		memcg_shrinker_map_size = size;
-	mutex_unlock(&memcg_shrinker_map_mutex);
-	return ret;
-}
-
-void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
-{
-	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
-		struct memcg_shrinker_map *map;
-
-		rcu_read_lock();
-		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
-		/* Pairs with smp mb in shrink_slab() */
-		smp_mb__before_atomic();
-		set_bit(shrinker_id, map->map);
-		rcu_read_unlock();
-	}
-}
-
 /**
  * mem_cgroup_css_from_page - css of the memcg associated with a page
  * @page: page of interest
@@ -5255,11 +5131,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
 	/*
-	 * A memcg must be visible for memcg_expand_shrinker_maps()
+	 * A memcg must be visible for expand_shrinker_maps()
 	 * by the time the maps are allocated. So, we allocate maps
 	 * here, when for_each_mem_cgroup() can't skip it.
 	 */
-	if (memcg_alloc_shrinker_maps(memcg)) {
+	if (alloc_shrinker_maps(memcg)) {
 		mem_cgroup_id_remove(memcg);
 		return -ENOMEM;
 	}
@@ -5323,7 +5199,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
-	memcg_free_shrinker_maps(memcg);
+	free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bdc32c803c66..98a44fb81f8a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -185,6 +185,132 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
+
+static int memcg_shrinker_map_size;
+static DEFINE_MUTEX(memcg_shrinker_map_mutex);
+
+static void free_shrinker_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int expand_one_shrinker_map(struct mem_cgroup *memcg,
+				   int size, int old_size)
+{
+	struct memcg_shrinker_map *new, *old;
+	struct mem_cgroup_per_node *pn;
+	int nid;
+
+	lockdep_assert_held(&memcg_shrinker_map_mutex);
+
+	for_each_node(nid) {
+		pn = memcg->nodeinfo[nid];
+		old = rcu_dereference_protected(pn->shrinker_map, true);
+		/* Not yet online memcg */
+		if (!old)
+			return 0;
+
+		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
+		if (!new)
+			return -ENOMEM;
+
+		/* Set all old bits, clear all new bits */
+		memset(new->map, (int)0xff, old_size);
+		memset((void *)new->map + old_size, 0, size - old_size);
+
+		rcu_assign_pointer(pn->shrinker_map, new);
+		call_rcu(&old->rcu, free_shrinker_map_rcu);
+	}
+
+	return 0;
+}
+
+void free_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_per_node *pn;
+	struct memcg_shrinker_map *map;
+	int nid;
+
+	if (mem_cgroup_is_root(memcg))
+		return;
+
+	for_each_node(nid) {
+		pn = memcg->nodeinfo[nid];
+		map = rcu_dereference_protected(pn->shrinker_map, true);
+		kvfree(map);
+		rcu_assign_pointer(pn->shrinker_map, NULL);
+	}
+}
+
+int alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct memcg_shrinker_map *map;
+	int nid, size, ret = 0;
+
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	size = memcg_shrinker_map_size;
+	for_each_node(nid) {
+		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
+		if (!map) {
+			free_shrinker_maps(memcg);
+			ret = -ENOMEM;
+			break;
+		}
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
+	}
+	mutex_unlock(&memcg_shrinker_map_mutex);
+
+	return ret;
+}
+
+static int expand_shrinker_maps(int new_id)
+{
+	int size, old_size, ret = 0;
+	struct mem_cgroup *memcg;
+
+	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
+	old_size = memcg_shrinker_map_size;
+	if (size <= old_size)
+		return 0;
+
+	mutex_lock(&memcg_shrinker_map_mutex);
+	if (!root_mem_cgroup)
+		goto unlock;
+
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		if (mem_cgroup_is_root(memcg))
+			continue;
+		ret = expand_one_shrinker_map(memcg, size, old_size);
+		if (ret) {
+			mem_cgroup_iter_break(NULL, memcg);
+			goto unlock;
+		}
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+unlock:
+	if (!ret)
+		memcg_shrinker_map_size = size;
+	mutex_unlock(&memcg_shrinker_map_mutex);
+	return ret;
+}
+
+void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
+{
+	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
+		struct memcg_shrinker_map *map;
+
+		rcu_read_lock();
+		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
+		set_bit(shrinker_id, map->map);
+		rcu_read_unlock();
+	}
+}
+
 /*
  * We allow subsystems to populate their shrinker-related
  * LRU lists before register_shrinker_prepared() is called
@@ -212,7 +338,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 		goto unlock;
 
 	if (id >= shrinker_nr_max) {
-		if (memcg_expand_shrinker_maps(id)) {
+		if (expand_shrinker_maps(id)) {
 			idr_remove(&shrinker_idr, id);
 			goto unlock;
 		}
@@ -590,7 +716,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			 * case, we invoke the shrinker one more time and reset
 			 * the bit if it reports that it is not empty anymore.
 			 * The memory barrier here pairs with the barrier in
-			 * memcg_set_shrinker_bit():
+			 * set_shrinker_bit():
 			 *
 			 * list_lru_add()     shrink_slab_memcg()
 			 *   list_add_tail()    clear_bit()
@@ -602,7 +728,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			if (ret == SHRINK_EMPTY)
 				ret = 0;
 			else
-				memcg_set_shrinker_bit(memcg, nid, i);
+				set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
 
-- 
2.26.2

