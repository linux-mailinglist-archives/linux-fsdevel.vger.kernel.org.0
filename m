Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AD33456A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhCJRqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhCJRq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBAAC061760;
        Wed, 10 Mar 2021 09:46:27 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id w34so10807857pga.8;
        Wed, 10 Mar 2021 09:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2W3ntTrXqJM/mWjhYznbaelKG6bWKsePb0Ao/1PIRAY=;
        b=rIXhaC5Iki0FteZltEViFBuKC2WQJmHTczF1sDVbvHzQEsocI1b8KimJcJJ9h1PK3d
         hDqDujx/g9plz4rDssRAyG53/VMiisuKHoWDAqAs4UWVoGmdTCgYsZHtARMv96JBnf0L
         SUuUO+e5iMODTtGcm/+3pKAJubLup3ugfKQ3Lu1K/5HD8wsakBES/BOYEd1BFtmHNEUC
         MTv08xK90bQjeWiDt+vyAycuHbHwymrAxQ9i22yVf0IC21+Tl1vDO65igqPxf/3u/7GC
         B6Z7L04Hc5LtEBA5B2rni4MA4KZIb8MAEyjFjSu04TOOQIX3kjQJw48jR2WHhx6kRckF
         BgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2W3ntTrXqJM/mWjhYznbaelKG6bWKsePb0Ao/1PIRAY=;
        b=hPg80FTXZOhmPfXYenn/ngyRw1IvJHyxsx+mxZBKp7Rv9lJvbZcMLtaAha7vg+VMvy
         vTgCH7kNPQMSr1kR5oC7e+IQcHfUZTfi+ZRxW3LsPgDKX4vlbv5Dk7lv8xzyKiecX2mZ
         03aiep2SyMPH24NCo8W5r+B9du4u7oYQ7wYHZCg8lbDo6/F1n+E17CA3qvHwo0Uy25aK
         yLTrcw5MXAWIMPbJ5HXjqn5UbJDbkwQGmhL3yYbOKfsReeybuwWx6ne5+a2M0uk6RVsO
         7YjlSDaqDtsEgYo/ek3TUXBu51Hb+4nwBwobIqaiMXiF/ZPMbvioPn57F2mfHMuzxyLB
         qCNQ==
X-Gm-Message-State: AOAM530VK0evNEWccGJjTcIq56BbIWCcOQIYTzRdzDmI0YOBp1de6eNa
        ldPxw1iEAV2tN2Ac2j2EFXs=
X-Google-Smtp-Source: ABdhPJy6hWQf8gzXhJQdLdSQs/jiVAM24ALfP1sKNe+juvOErAoTmQ8kndGD/Yxo1X0R4jgbO//iFQ==
X-Received: by 2002:a62:62c1:0:b029:1ee:7ad:8cb3 with SMTP id w184-20020a6262c10000b02901ee07ad8cb3mr4067466pfb.21.1615398387208;
        Wed, 10 Mar 2021 09:46:27 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:26 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 06/13] mm: memcontrol: rename shrinker_map to shrinker_info
Date:   Wed, 10 Mar 2021 09:45:56 -0800
Message-Id: <20210310174603.5093-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
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
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/memcontrol.h |  8 +++---
 mm/memcontrol.c            |  6 ++--
 mm/vmscan.c                | 58 +++++++++++++++++++-------------------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fb2b7ef298ec..308a202f1de2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -100,7 +100,7 @@ struct batched_lruvec_stat {
  * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
  * which have elements charged to this memcg.
  */
-struct memcg_shrinker_map {
+struct shrinker_info {
 	struct rcu_head rcu;
 	unsigned long map[];
 };
@@ -128,7 +128,7 @@ struct mem_cgroup_per_node {
 
 	struct mem_cgroup_reclaim_iter	iter;
 
-	struct memcg_shrinker_map __rcu	*shrinker_map;
+	struct shrinker_info __rcu	*shrinker_info;
 
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
@@ -1565,8 +1565,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
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
index a89c960f768e..edd8a06c751f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5226,11 +5226,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -5294,7 +5294,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
-	free_shrinker_maps(memcg);
+	free_shrinker_info(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c9898e66011e..7f3c00e76fd1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -192,15 +192,15 @@ static inline int shrinker_map_size(int nr_items)
 	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
 }
 
-static int expand_one_shrinker_map(struct mem_cgroup *memcg,
-				   int size, int old_size)
+static int expand_one_shrinker_info(struct mem_cgroup *memcg,
+				    int size, int old_size)
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
@@ -213,17 +213,17 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 		memset(new->map, (int)0xff, old_size);
 		memset((void *)new->map + old_size, 0, size - old_size);
 
-		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
 		kvfree_rcu(old, rcu);
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
@@ -231,15 +231,15 @@ void free_shrinker_maps(struct mem_cgroup *memcg)
 
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
@@ -248,20 +248,20 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 	down_write(&shrinker_rwsem);
 	size = shrinker_map_size(shrinker_nr_max);
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
@@ -281,7 +281,7 @@ static int expand_shrinker_maps(int new_id)
 	do {
 		if (mem_cgroup_is_root(memcg))
 			continue;
-		ret = expand_one_shrinker_map(memcg, size, old_size);
+		ret = expand_one_shrinker_info(memcg, size, old_size);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
 			goto out;
@@ -297,13 +297,13 @@ static int expand_shrinker_maps(int new_id)
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
@@ -334,7 +334,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
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

