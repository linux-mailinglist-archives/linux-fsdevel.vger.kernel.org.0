Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121A22EB59F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbhAEW7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 17:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbhAEW7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:59:39 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDFC061798;
        Tue,  5 Jan 2021 14:58:48 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id q4so551864plr.7;
        Tue, 05 Jan 2021 14:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BtzkGwYCF7iiL9RJdxkc2LInj3eT01vio3n5yrDXOSA=;
        b=pSfQ/digrUY1CaSTwgYc+ifH6Kr+cRVtFhlg2WZ8oZ6Zf26702NoIhuBQrc74S9Fe+
         bAzFPWIuke4uPoyH2Dl+6vDS/p6mdml9B1QX1igu2WSaD7cJTAH93b9Eldl00+7ZY7wk
         qHcJH8xBscu3P6uR8q6FC3I3DbMvXgww0DZ6xH0ngVtVm/CEFTLDuLxrk2/ZCacxu7QY
         8VJSLyQig7eu5dKn0yMMgT/gIeUvlTY5IG61KN9DdCCJ+zUH9TvmEc9+nh6QEDzeOlU3
         iJArDJV9YxVxebkWlNpACANvQN6T1eEQy2pQsIQh3URmODt7AiiYAQHzWVP9ybd9QYFk
         RqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BtzkGwYCF7iiL9RJdxkc2LInj3eT01vio3n5yrDXOSA=;
        b=lpTKH9fIs1IsbWVtTGj5ztQYR+xwSWu2E5UetccQvG9SjnUYkoCdaxDF/I/uBArF3T
         AzvyDD82IdZzvszcXXTIjLinRnmvL0plPmtxU7YO9tXv/6a54s9w8x8lpzVf8DCJweyr
         vQTdNcIOe1JNRePWzYP91NAKhqtghnwIissy+VD+nvwBS1/JbEdReJXDjPNDh89CpOd0
         CPm38SIi+m4I640Efd/2aQc4YTrlQUqpgzQ49IVh2MfsxS3OFh9wY9dNdBCrlOSg+ejs
         xfFq5p1Nyvhan+7Dmxlgl5d/ICHSNZTQI6hqkOexEFYVG5mhI1XLCc9hYk2jHOcKA9QA
         dz3A==
X-Gm-Message-State: AOAM532AWjrpQndY2w0M0NJGDtB9l932IBPGy3RQIixoEelnWj4rD6Aj
        zYwGcPIDdobbG/O6t7Rsqrw=
X-Google-Smtp-Source: ABdhPJwYHvRJMu/xFhZtAxI7EPrkD6bOlQFuNk0100uQ8a9BNDkmwtnYTz3X6vbh27M+iIZBZyohaQ==
X-Received: by 2002:a17:902:7001:b029:da:bbb6:c7e2 with SMTP id y1-20020a1709027001b02900dabbb6c7e2mr1711242plk.50.1609887528393;
        Tue, 05 Jan 2021 14:58:48 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw12sm244233pjb.43.2021.01.05.14.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:58:47 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling code
Date:   Tue,  5 Jan 2021 14:58:08 -0800
Message-Id: <20210105225817.1036378-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105225817.1036378-1-shy828301@gmail.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The shrinker map management is not really memcg specific, it's just allocation
and assignment of a structure, and the only memcg bit is the map is being stored
in a memcg structure.  So move the shrinker_maps handling code into vmscan.c for
tighter integration with shrinker code.  There is no functional change.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/memcontrol.h |   4 +-
 mm/memcontrol.c            | 124 ------------------------------------
 mm/vmscan.c                | 126 +++++++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+), 126 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d827bd7f3bfe..d128d2842f22 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1581,8 +1581,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 	return false;
 }
 
-extern int memcg_expand_shrinker_maps(int new_id);
-
+extern int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg);
+extern void memcg_free_shrinker_maps(struct mem_cgroup *memcg);
 extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 				   int nid, int shrinker_id);
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 605f671203ef..817dde366258 100644
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
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cb24ef952efc..9db7b4d6d0ae 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -185,6 +185,132 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
+
+static int memcg_shrinker_map_size;
+static DEFINE_MUTEX(memcg_shrinker_map_mutex);
+
+static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
+					 int size, int old_size)
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
+		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		/* Set all old bits, clear all new bits */
+		memset(new->map, (int)0xff, old_size);
+		memset((void *)new->map + old_size, 0, size - old_size);
+
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+	}
+
+	return 0;
+}
+
+void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
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
+int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
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
+		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
+		if (!map) {
+			memcg_free_shrinker_maps(memcg);
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
+static int memcg_expand_shrinker_maps(int new_id)
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
+		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
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
+void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
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
-- 
2.26.2

