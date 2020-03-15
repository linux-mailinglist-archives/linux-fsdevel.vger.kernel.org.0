Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3151E185B17
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 08:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgCOHxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 03:53:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33851 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgCOHxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:53:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id 23so8006846pfj.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2020 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GR+4RQ/CtYjBoLtm6xDE+j3oEJzKJmkJkF8JHfLM9+I=;
        b=AnNSrJxr3L6owNh+RpUvCyIVb9IkGboEQh51GvFU7aHaxGPwVdI06d7i4AW+6kjc10
         CU9osRaYVfKKmQfSZl9vTifThOPbfhRjv+0Pe+t8+JYZWl6GoiaNb/fWM8qICrYBHyIF
         th9YAM0yFugK7p+txE2AbIIzs3wBnjfA9zEFp62SU3R1kSZ4chkUlsmRjlJzUGr4x8nn
         PQAVcywhC699mjASDGfGlFP1itIQbJxS20v79/vv5ag89WofOWxvGSU6tw5YN8LOtQKN
         sTe9umHJ3jbWrxZH7ys2gumvWAqJrmpm1RmsKCo34cDQdMzHGk3WF66SBZ9wP1lQdzyw
         loRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GR+4RQ/CtYjBoLtm6xDE+j3oEJzKJmkJkF8JHfLM9+I=;
        b=Ih72sSf4isXi1Nee8aPISj7XncEib7sANgr3QPWK4oytWYIc5wbfNez//WpVUYhy6v
         ozyTSkeOiedBKu5pxldM0i64kqEdq2uavoVlErVviYzkn/orQ+2Eu8qVHbF2xGdbu6Df
         6pTAdG1kPcLSa7gQqbFmlTzOy024A9ms8KLWWnxGoxDtZH9E50a6fUy9z+4qyAaN0aCW
         ic6i6F30vrDktqory1n2Gqmrn1nwidBGpH9L5GyxbTBm1tyAGaHGwB+1zSQNsgd8/QW8
         NAB+JDle5uJXe9IokkLkW2UenIuRPzNnoyFDJJtGr/kv93g/7ZSwvolXWn1T95i48+YH
         TsGA==
X-Gm-Message-State: ANhLgQ1vOeWssn2XHhJz5j7JqVK2GxiYIENPbZMVrxj+jL21OfIIxtyk
        xnUZb5PsU0CsA+rPT8mo0Lc=
X-Google-Smtp-Source: ADFU+vtDK7Ak+zn2clzqTJRjeDSuOpfNuPgnLW/K67KXpqO+HpI+acgrjbUDJ/GsyeXLxy2Xy2P8dw==
X-Received: by 2002:a62:be04:: with SMTP id l4mr22649023pff.234.1584258780484;
        Sun, 15 Mar 2020 00:53:00 -0700 (PDT)
Received: from master.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id w11sm62592984pfn.4.2020.03.15.00.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 00:52:59 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 1/3] mm, list_lru: make memcg visible to lru walker isolation function
Date:   Sun, 15 Mar 2020 05:53:40 -0400
Message-Id: <20200315095342.10178-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200315095342.10178-1-laoar.shao@gmail.com>
References: <20200315095342.10178-1-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The lru walker isolation function may use this memcg to do something, e.g.
the inode isolatation function will use the memcg to do inode protection in
followup patch. So make memcg visible to the lru walker isolation function.

Something should be emphasized in this patch is it replaces
for_each_memcg_cache_index() with for_each_mem_cgroup() in
list_lru_walk_node(). Because there's a gap between these two MACROs that
for_each_mem_cgroup() depends on CONFIG_MEMCG while the other one depends
on CONFIG_MEMCG_KMEM. But as list_lru_memcg_aware() returns false if
CONFIG_MEMCG_KMEM is not configured, it is safe to this replacement.
Another difference between for_each_memcg_cache_index() and
for_each_mem_cgroup() is that for_each_memcg_cache_index() excludes the
root_mem_cgroup because its kmemcg_id is -1, while for_each_mem_cgroup()
includes the root_mem_cgroup. So we need to skip the root_mem_cgroup
explicitly in the for loop.

Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h | 21 +++++++++++++++++
 mm/list_lru.c              | 47 +++++++++++++++++++++++---------------
 mm/memcontrol.c            | 15 ------------
 3 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5c8d5..a624c423e60b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -445,6 +445,21 @@ void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
 int mem_cgroup_scan_tasks(struct mem_cgroup *,
 			  int (*)(struct task_struct *, void *), void *);
 
+/*
+ * Iteration constructs for visiting all cgroups (under a tree).  If
+ * loops are exited prematurely (break), mem_cgroup_iter_break() must
+ * be used for reference counting.
+ */
+#define for_each_mem_cgroup_tree(iter, root)		\
+	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(root, iter, NULL))
+
+#define for_each_mem_cgroup(iter)			\
+	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(NULL, iter, NULL))
+
 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 {
 	if (mem_cgroup_disabled())
@@ -945,6 +960,12 @@ static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return 0;
 }
 
+#define for_each_mem_cgroup_tree(iter)		\
+	for (iter = NULL; iter; )
+
+#define for_each_mem_cgroup(iter)		\
+	for (iter = NULL; iter; )
+
 static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 {
 	return 0;
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0f1f6b06b7f3..6daa8c64d13d 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -207,11 +207,11 @@ unsigned long list_lru_count_node(struct list_lru *lru, int nid)
 EXPORT_SYMBOL_GPL(list_lru_count_node);
 
 static unsigned long
-__list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
+__list_lru_walk_one(struct list_lru_node *nlru, struct mem_cgroup *memcg,
 		    list_lru_walk_cb isolate, void *cb_arg,
 		    unsigned long *nr_to_walk)
 {
-
+	int memcg_idx = memcg_cache_id(memcg);
 	struct list_lru_one *l;
 	struct list_head *item, *n;
 	unsigned long isolated = 0;
@@ -273,7 +273,7 @@ list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock(&nlru->lock);
-	ret = __list_lru_walk_one(nlru, memcg_cache_id(memcg), isolate, cb_arg,
+	ret = __list_lru_walk_one(nlru, memcg, isolate, cb_arg,
 				  nr_to_walk);
 	spin_unlock(&nlru->lock);
 	return ret;
@@ -289,7 +289,7 @@ list_lru_walk_one_irq(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock_irq(&nlru->lock);
-	ret = __list_lru_walk_one(nlru, memcg_cache_id(memcg), isolate, cb_arg,
+	ret = __list_lru_walk_one(nlru, memcg, isolate, cb_arg,
 				  nr_to_walk);
 	spin_unlock_irq(&nlru->lock);
 	return ret;
@@ -299,25 +299,34 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 				 list_lru_walk_cb isolate, void *cb_arg,
 				 unsigned long *nr_to_walk)
 {
-	long isolated = 0;
-	int memcg_idx;
+	struct list_lru_node *nlru;
+	struct mem_cgroup *memcg;
+	long isolated;
 
-	isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
-				      nr_to_walk);
-	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
-		for_each_memcg_cache_index(memcg_idx) {
-			struct list_lru_node *nlru = &lru->node[nid];
+	/* iterate the global lru first */
+	isolated = list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
+				     nr_to_walk);
 
-			spin_lock(&nlru->lock);
-			isolated += __list_lru_walk_one(nlru, memcg_idx,
-							isolate, cb_arg,
-							nr_to_walk);
-			spin_unlock(&nlru->lock);
+	if (!list_lru_memcg_aware(lru))
+		goto out;
 
-			if (*nr_to_walk <= 0)
-				break;
-		}
+	nlru = &lru->node[nid];
+	for_each_mem_cgroup(memcg) {
+		/* already scanned the root memcg above */
+		if (mem_cgroup_is_root(memcg))
+			continue;
+
+		if (*nr_to_walk <= 0)
+			break;
+
+		spin_lock(&nlru->lock);
+		isolated += __list_lru_walk_one(nlru, memcg,
+						isolate, cb_arg,
+						nr_to_walk);
+		spin_unlock(&nlru->lock);
 	}
+
+out:
 	return isolated;
 }
 EXPORT_SYMBOL_GPL(list_lru_walk_node);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d09776cd6e10..688d51dbb731 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -222,21 +222,6 @@ enum res_type {
 /* Used for OOM nofiier */
 #define OOM_CONTROL		(0)
 
-/*
- * Iteration constructs for visiting all cgroups (under a tree).  If
- * loops are exited prematurely (break), mem_cgroup_iter_break() must
- * be used for reference counting.
- */
-#define for_each_mem_cgroup_tree(iter, root)		\
-	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(root, iter, NULL))
-
-#define for_each_mem_cgroup(iter)			\
-	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(NULL, iter, NULL))
-
 static inline bool should_force_charge(void)
 {
 	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
-- 
2.18.1

