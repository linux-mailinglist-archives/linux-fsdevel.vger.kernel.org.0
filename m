Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F82306804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 00:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhA0Xg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 18:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhA0XfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:35:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318DAC0613ED;
        Wed, 27 Jan 2021 15:33:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z21so2822599pgj.4;
        Wed, 27 Jan 2021 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuCgItErx3mwuUfHlTHM7xjza45qOuWeaGuXNrAI598=;
        b=fL1vXxuh469ps/ZMe7z3gDHMlaLENwKYPEUvymAjnDXjdgSBwB2DMDEHdntpScegMn
         GbSAATL3R88s9axg9mBEqicycWnjus4JZ8F83bZ7GesdTbnTAtJK/3uOGET/RHrmr+uI
         66MnjK7wY5fxeddtqCmYFZ/vlxvicCD34T0vhBb+DhQpau4C3a5oGAYj0RA4ZvI980t3
         iO+WKxBFC1m2LeuuMAtzHi83Zkpr4Wm7XF7YkHUW0qXFFzFPQWhg0rou1I3bpG92Z4Mc
         Qbf0c4l4PZfCAr+eaVa7QDDktxbppIg9EyXxf3sxabiMWrvy5JG0QtzFYK85h3G7X6Hm
         JAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuCgItErx3mwuUfHlTHM7xjza45qOuWeaGuXNrAI598=;
        b=NqySyiXIZuyM8J6WGHoQt0Sf/1uMvJ9r46I05mBCd1eIqyh4C4rn+Z6VGKdpZD/GAg
         kjUXFhy9HuGit15Et/FOTXtxihWSQU/BbjS2nBrD7PqYeXLqkuqQgKVU+QVl0BQVwCUW
         if57DL/wEykTBZysC2juILl2wQUyqgi4thxjUjNghuVII2+x1nvUA5hRPSw0LpADfCYs
         es1rBOtTVgsAzlR0Uzre7oVLqaHBQyIcJqriVIPg9ABVBS28fSdm20L9VOURdAD6GEHQ
         VhbLK7ol1etugKq0cIzXVYzg7oQ395XFNkHDfw7utbqq0Cr2t4z2TuyjzT2M9eyvTsTR
         MoFA==
X-Gm-Message-State: AOAM530fponsz9k+fc5GmGH5XNO3xvlJH0saw7lE9shAZxwGwfrJTNq1
        eSLLEPEGacrHWAXv3MLrUt0=
X-Google-Smtp-Source: ABdhPJynCu+Hpo9rcWyzbCKoIAjclQBtHH+5BgAdOkIw/tZhe8K92z1tTByxnkim2Qzn6ljdiETYxA==
X-Received: by 2002:a63:5f93:: with SMTP id t141mr13638281pgb.299.1611790435797;
        Wed, 27 Jan 2021 15:33:55 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 124sm3498648pfd.59.2021.01.27.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:33:54 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling code
Date:   Wed, 27 Jan 2021 15:33:36 -0800
Message-Id: <20210127233345.339910-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127233345.339910-1-shy828301@gmail.com>
References: <20210127233345.339910-1-shy828301@gmail.com>
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

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/memcontrol.h |  12 ++--
 mm/huge_memory.c           |   4 +-
 mm/list_lru.c              |   6 +-
 mm/memcontrol.c            | 130 +------------------------------------
 mm/vmscan.c                | 130 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 142 insertions(+), 140 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index eeb0b52203e9..0ee2924991fb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1581,10 +1581,10 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 	return false;
 }
 
-extern int memcg_expand_shrinker_maps(int new_id);
-
-extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
-				   int nid, int shrinker_id);
+extern int alloc_shrinker_maps(struct mem_cgroup *memcg);
+extern void free_shrinker_maps(struct mem_cgroup *memcg);
+extern void set_shrinker_bit(struct mem_cgroup *memcg,
+			     int nid, int shrinker_id);
 #else
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
@@ -1594,8 +1594,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
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
index 9237976abe72..05190d7f32ae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2823,8 +2823,8 @@ void deferred_split_huge_page(struct page *page)
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
index fe230081690b..628030fa5f69 100644
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
@@ -548,7 +548,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 
 	if (src->nr_items) {
 		dst->nr_items += src->nr_items;
-		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
+		set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 		src->nr_items = 0;
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e2de77b5bcc2..f5c9a0d2160b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -397,130 +397,6 @@ DEFINE_STATIC_KEY_FALSE(memcg_kmem_enabled_key);
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
-	int nid;
-
-	lockdep_assert_held(&memcg_shrinker_map_mutex);
-
-	for_each_node(nid) {
-		old = rcu_dereference_protected(
-			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
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
-		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
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
-		pn = mem_cgroup_nodeinfo(memcg, nid);
-		map = rcu_dereference_protected(pn->shrinker_map, true);
-		if (map)
-			kvfree(map);
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
@@ -5370,11 +5246,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -5438,7 +5314,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
-	memcg_free_shrinker_maps(memcg);
+	free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b512dd5e3a1c..d950cead66ca 100644
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
+	int nid;
+
+	lockdep_assert_held(&memcg_shrinker_map_mutex);
+
+	for_each_node(nid) {
+		old = rcu_dereference_protected(
+			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
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
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
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
+		pn = mem_cgroup_nodeinfo(memcg, nid);
+		map = rcu_dereference_protected(pn->shrinker_map, true);
+		if (map)
+			kvfree(map);
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
@@ -601,7 +727,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			if (ret == SHRINK_EMPTY)
 				ret = 0;
 			else
-				memcg_set_shrinker_bit(memcg, nid, i);
+				set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
 
-- 
2.26.2

