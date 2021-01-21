Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F52FF898
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbhAUXQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbhAUXHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:07:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE579C06174A;
        Thu, 21 Jan 2021 15:06:47 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x20so2648722pjh.3;
        Thu, 21 Jan 2021 15:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=znjWC9WcMpZrPJmV/Ont8uolgMCcznsgXVeTspUOoC8=;
        b=skeSoalhaMwUVhxMFcGSdD6cqKJseQeQs3HECxY9vV07FbRrVgUwQ5XCiiIHrOWq4z
         6/vwmsaln1LMhY7DWantYSWR4CC1TLoRjfEDkcIGiGg6POdPChbo4yMtyGpcmNw99Lo8
         piB18/srTxE/4ei//DOjOXJaAGYsuiTX5eB/zOPdoa3QwfDQnznNkSHu3leUQUm3p8oy
         UWL7A0ZEw2Z4xjQnp8UKRLbQR8uvgtHuDMrZJD7T82wHTf0BKm7c74WcqvnNoj6lgPNp
         xZffwCn1CAXQIaezl3Izpsb1MiL0i7OH3TtYlgzpuM96y43g9JLZ7m/+OQX3isfONJO2
         +zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=znjWC9WcMpZrPJmV/Ont8uolgMCcznsgXVeTspUOoC8=;
        b=fxXiWoF2bqJu5pOTf0W0k0TeLLA8mGzowSoReX84ar5N66Bozix7PH6IUDkzLhISQ4
         yllZ4a9qbfO0rU7agd8OInlyMxUwEjc/vFJ1TXz+xJcxShvKtsbBST1CDbevS1fMnL2p
         O6YKSncLlLOFXoXJqGTidGYG4uQ8cNxbZCyx4QzrdfsUW71l2nIdztMHT3v0Cpd/U+Xu
         EeVx/LqeldTkS8g8IIRcOqdoRYZy+B5vbg45zZdFqTbajX8Z4GQZYfbksUPq4MEefZfa
         7qCyWaNVCfQX3vk9wJFFfuux9UY13TrrhIStBEvN6K67MKL98aYQV4UHQFZ3g6Vlb1Ee
         Wwpw==
X-Gm-Message-State: AOAM530YiP+fCX2Qo6napyWth6fwK622Dih90ghBUUtwCkTphtj4xiL+
        be37sUlopkM2+XT/4s8juik=
X-Google-Smtp-Source: ABdhPJzufOJUfBKmPJxfd+xTIlJpEIlx+BhAty8GjV+05RTYiuwyNbYLP9mMcJM5OLzYVEnyg0cH7g==
X-Received: by 2002:a17:902:ba85:b029:de:ba16:818b with SMTP id k5-20020a170902ba85b02900deba16818bmr1596578pls.75.1611270407235;
        Thu, 21 Jan 2021 15:06:47 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y16sm6722921pfb.83.2021.01.21.15.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:06:46 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 05/11] mm: memcontrol: rename shrinker_map to shrinker_info
Date:   Thu, 21 Jan 2021 15:06:15 -0800
Message-Id: <20210121230621.654304-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121230621.654304-1-shy828301@gmail.com>
References: <20210121230621.654304-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following patch is going to add nr_deferred into shrinker_map, the change will
make shrinker_map not only include map anymore, so rename it to a more general
name.  And this should make the patch adding nr_deferred cleaner and readable and make
review easier. Rename "memcg_shrinker_info" to "shrinker_info" as well.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/memcontrol.h |  8 ++---
 mm/memcontrol.c            |  6 ++--
 mm/vmscan.c                | 64 +++++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0ee2924991fb..62b888b88a5f 100644
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
 
-extern int alloc_shrinker_maps(struct mem_cgroup *memcg);
-extern void free_shrinker_maps(struct mem_cgroup *memcg);
+extern int alloc_shrinker_info(struct mem_cgroup *memcg);
+extern void free_shrinker_info(struct mem_cgroup *memcg);
 extern void set_shrinker_bit(struct mem_cgroup *memcg,
 			     int nid, int shrinker_id);
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 76a557520a1a..65d9eb0215b5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5248,11 +5248,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -5316,7 +5316,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
-	free_shrinker_maps(memcg);
+	free_shrinker_info(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 40e7751ef961..dcb7f2913ace 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -187,20 +187,20 @@ static DECLARE_RWSEM(shrinker_rwsem);
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
 
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
@@ -213,17 +213,17 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
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
@@ -231,16 +231,16 @@ void free_shrinker_maps(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
-		map = rcu_dereference_protected(pn->shrinker_map, true);
-		if (map)
-			kvfree(map);
-		rcu_assign_pointer(pn->shrinker_map, NULL);
+		info = rcu_dereference_protected(pn->shrinker_info, true);
+		if (info)
+			kvfree(info);
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
@@ -249,20 +249,20 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 	down_write(&shrinker_rwsem);
 	size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
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
@@ -280,7 +280,7 @@ static int expand_shrinker_maps(int new_id)
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
@@ -663,7 +663,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct mem_cgroup *memcg, int priority)
 {
-	struct memcg_shrinker_map *map;
+	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
 	int i;
 
@@ -673,12 +673,12 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
@@ -689,7 +689,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		shrinker = idr_find(&shrinker_idr, i);
 		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
 			if (!shrinker)
-				clear_bit(i, map->map);
+				clear_bit(i, info->map);
 			continue;
 		}
 
@@ -700,7 +700,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY) {
-			clear_bit(i, map->map);
+			clear_bit(i, info->map);
 			/*
 			 * After the shrinker reported that it had no objects to
 			 * free, but before we cleared the corresponding bit in
-- 
2.26.2

