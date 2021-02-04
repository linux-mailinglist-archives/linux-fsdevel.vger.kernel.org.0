Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8630E0CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 18:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhBCRWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 12:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhBCRVz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:21:55 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D0C06178C;
        Wed,  3 Feb 2021 09:21:15 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c132so194171pga.3;
        Wed, 03 Feb 2021 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXtPEywIbSFfu0wKh0tRPmppW5eyLPez/dQsEA4k5Mk=;
        b=iYaAM05Oa/JGSauSHx/gM2aYGkUdHiRvExStSYA19xz4gqFK4yAfIL+AIP9i2Jwh5P
         2f6kvPmnLn8rbifhyj4NNs1j4kzLZD8/tY6wQLJ+qLEOXTed3zwnB726auz+CsFMMES3
         gK6M6if3+T3eneJe8gfRGxNPUUiB1YGuAysZ9A2hwo432mkiCrSRuAvFWvhKCbhzxvWg
         sZcVEAhNJfpWmlGupWkGHeNmazl+wTv7iW8EKIyLsPYwnZlZpFh8OuzK6NKoVEkSv8F8
         KW0SW+2nXJP9UxmdFaxPZ9ugNVDcEPjeYl1qb9bYK/JXNnxDs8XWDiehXHPWlAskARem
         qIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXtPEywIbSFfu0wKh0tRPmppW5eyLPez/dQsEA4k5Mk=;
        b=MO4gTsplHv27L49oZXM7KBmwWhXI6Rn6zG8iseLm1MIWT2xcAy7N+1yrBJ7IY5Nca1
         2XpSnhWkKX6bsJO/oRRew5n9ea6qm+vUtQJYXnohoDTENMy/qjejyeLK53O1tBgeZMB3
         Jdt3YodO+OCFR3n5hd2BBtjEHw3evJ6UXWR3BmH7Ea9oUKitdSAA8q3uneuzF163qn4u
         Ck38ApwxgXjpyO9zrfCggc89ceNKbIP3jZ5rwcwBVq5GiPCrYWaL82N9wqWJt7pQ/XS8
         MumPc06I/mbJbIm6Gjih83+RsS6KHCUOnRVP69fjwrUnslwnnkAQ0N3GWC4HsACeuXS5
         Y75g==
X-Gm-Message-State: AOAM533tGsmEW5hlasl6FY0zZgEaTdTgU4JB18fIVnHb7QBjLaYQbVzp
        rhjZRYkJ15CbXF1InIiZvrY=
X-Google-Smtp-Source: ABdhPJznzEslG9nHRE7Ytmf1OboCKCEf9yXdAenfA36ZxnUA5qVj5+NnnSPF7LWT22GsDgdoK01/DQ==
X-Received: by 2002:a05:6a00:138f:b029:1b8:b9d5:3a2c with SMTP id t15-20020a056a00138fb02901b8b9d53a2cmr3970345pfg.10.1612372874625;
        Wed, 03 Feb 2021 09:21:14 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x21sm2368636pfn.100.2021.02.03.09.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:21:13 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v6 PATCH 05/11] mm: memcontrol: rename shrinker_map to shrinker_info
Date:   Wed,  3 Feb 2021 09:20:36 -0800
Message-Id: <20210203172042.800474-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203172042.800474-1-shy828301@gmail.com>
References: <20210203172042.800474-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following patch is going to add nr_deferred into shrinker_map, the change will
make shrinker_map not only include map anymore, so rename it to "memcg_shrinker_info".
And this should make the patch adding nr_deferred cleaner and readable and make
review easier.  Also remove the "memcg_" prefix.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/memcontrol.h |  8 ++---
 mm/memcontrol.c            |  6 ++--
 mm/vmscan.c                | 62 +++++++++++++++++++-------------------
 3 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1739f17e0939..4c9253896e25 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -96,7 +96,7 @@ struct lruvec_stat {
  * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
  * which have elements charged to this memcg.
  */
-struct memcg_shrinker_map {
+struct shrinker_info {
 	struct rcu_head rcu;
 	unsigned long map[];
 };
@@ -118,7 +118,7 @@ struct mem_cgroup_per_node {
 
 	struct mem_cgroup_reclaim_iter	iter;
 
-	struct memcg_shrinker_map __rcu	*shrinker_map;
+	struct shrinker_info __rcu	*shrinker_info;
 
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
@@ -1581,8 +1581,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 	return false;
 }
 
-int alloc_shrinker_maps(struct mem_cgroup *memcg);
-void free_shrinker_maps(struct mem_cgroup *memcg);
+int alloc_shrinker_info(struct mem_cgroup *memcg);
+void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
 #else
 #define mem_cgroup_sockets_enabled 0
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f5c9a0d2160b..f64ad0d044d9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5246,11 +5246,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
 	/*
-	 * A memcg must be visible for expand_shrinker_maps()
+	 * A memcg must be visible for expand_shrinker_info()
 	 * by the time the maps are allocated. So, we allocate maps
 	 * here, when for_each_mem_cgroup() can't skip it.
 	 */
-	if (alloc_shrinker_maps(memcg)) {
+	if (alloc_shrinker_info(memcg)) {
 		mem_cgroup_id_remove(memcg);
 		return -ENOMEM;
 	}
@@ -5314,7 +5314,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
-	free_shrinker_maps(memcg);
+	free_shrinker_info(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 641077b09e5d..9436f9246d32 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -190,20 +190,20 @@ static int shrinker_nr_max;
 #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
 	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
 
-static void free_shrinker_map_rcu(struct rcu_head *head)
+static void free_shrinker_info_rcu(struct rcu_head *head)
 {
-	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+	kvfree(container_of(head, struct shrinker_info, rcu));
 }
 
-static int expand_one_shrinker_map(struct mem_cgroup *memcg,
+static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 				   int size, int old_size)
 {
-	struct memcg_shrinker_map *new, *old;
+	struct shrinker_info *new, *old;
 	int nid;
 
 	for_each_node(nid) {
 		old = rcu_dereference_protected(
-			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
+			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
@@ -216,17 +216,17 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 		memset(new->map, (int)0xff, old_size);
 		memset((void *)new->map + old_size, 0, size - old_size);
 
-		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
-		call_rcu(&old->rcu, free_shrinker_map_rcu);
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
+		call_rcu(&old->rcu, free_shrinker_info_rcu);
 	}
 
 	return 0;
 }
 
-void free_shrinker_maps(struct mem_cgroup *memcg)
+void free_shrinker_info(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_per_node *pn;
-	struct memcg_shrinker_map *map;
+	struct shrinker_info *info;
 	int nid;
 
 	if (mem_cgroup_is_root(memcg))
@@ -234,15 +234,15 @@ void free_shrinker_maps(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
-		map = rcu_dereference_protected(pn->shrinker_map, true);
-		kvfree(map);
-		rcu_assign_pointer(pn->shrinker_map, NULL);
+		info = rcu_dereference_protected(pn->shrinker_info, true);
+		kvfree(info);
+		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
 }
 
-int alloc_shrinker_maps(struct mem_cgroup *memcg)
+int alloc_shrinker_info(struct mem_cgroup *memcg)
 {
-	struct memcg_shrinker_map *map;
+	struct shrinker_info *info;
 	int nid, size, ret = 0;
 
 	if (mem_cgroup_is_root(memcg))
@@ -251,20 +251,20 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 	down_write(&shrinker_rwsem);
 	size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
 	for_each_node(nid) {
-		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
-		if (!map) {
-			free_shrinker_maps(memcg);
+		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
+		if (!info) {
+			free_shrinker_info(memcg);
 			ret = -ENOMEM;
 			break;
 		}
-		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
 	up_write(&shrinker_rwsem);
 
 	return ret;
 }
 
-static int expand_shrinker_maps(int new_id)
+static int expand_shrinker_info(int new_id)
 {
 	int size, old_size, ret = 0;
 	int new_nr_max = new_id + 1;
@@ -282,7 +282,7 @@ static int expand_shrinker_maps(int new_id)
 	do {
 		if (mem_cgroup_is_root(memcg))
 			continue;
-		ret = expand_one_shrinker_map(memcg, size, old_size);
+		ret = expand_one_shrinker_info(memcg, size, old_size);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
 			goto out;
@@ -298,13 +298,13 @@ static int expand_shrinker_maps(int new_id)
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 {
 	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
-		struct memcg_shrinker_map *map;
+		struct shrinker_info *info;
 
 		rcu_read_lock();
-		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
 		/* Pairs with smp mb in shrink_slab() */
 		smp_mb__before_atomic();
-		set_bit(shrinker_id, map->map);
+		set_bit(shrinker_id, info->map);
 		rcu_read_unlock();
 	}
 }
@@ -335,7 +335,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 		goto unlock;
 
 	if (id >= shrinker_nr_max) {
-		if (expand_shrinker_maps(id)) {
+		if (expand_shrinker_info(id)) {
 			idr_remove(&shrinker_idr, id);
 			goto unlock;
 		}
@@ -664,7 +664,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct mem_cgroup *memcg, int priority)
 {
-	struct memcg_shrinker_map *map;
+	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
 	int i;
 
@@ -674,12 +674,12 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
 
-	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
-					true);
-	if (unlikely(!map))
+	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 true);
+	if (unlikely(!info))
 		goto unlock;
 
-	for_each_set_bit(i, map->map, shrinker_nr_max) {
+	for_each_set_bit(i, info->map, shrinker_nr_max) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -690,7 +690,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		shrinker = idr_find(&shrinker_idr, i);
 		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
 			if (!shrinker)
-				clear_bit(i, map->map);
+				clear_bit(i, info->map);
 			continue;
 		}
 
@@ -701,7 +701,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY) {
-			clear_bit(i, map->map);
+			clear_bit(i, info->map);
 			/*
 			 * After the shrinker reported that it had no objects to
 			 * free, but before we cleared the corresponding bit in
-- 
2.26.2

