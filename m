Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A0B134713
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 17:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgAHQER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 11:04:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45531 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgAHQER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:04:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so1776919pgk.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 08:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+W6SlExR6PKwRnyZCifqOOllR7j0S8vS7QHNpyNirE=;
        b=jHFsoUv+fk7tRl48S/e6aBzrLKh2yNcQQgtLnKmG9XevPsfsPb48fW5yCEDc706k2y
         wKoqvBY1TG7vZDte52ZxqnML6yVbJmjFtwbWT8bGQmWzn2CpHkFhqywLIB8Gt1HTIFyL
         6EPh72jl4eDFJUUl5mIewIJozdWcP/8AbjkJ0oGAEpUeVLXX71H15J0t0FkHIAy/tX/7
         ziFFwGD0r6XzGpuduRS2SQ0fZYlSHQPaXmkZ9jebN6kBjO0ycc6dzYvzZbLYXNPCln4l
         LcZedYpV//pE9YMcfoqBnn2bISg1I8jr604D7b1GEsvT9FDtchax9jykRBaVPLBv6Gli
         a0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+W6SlExR6PKwRnyZCifqOOllR7j0S8vS7QHNpyNirE=;
        b=GfzAdg3zTKrtiZtjED/6z6J8Uv/yo25XtPeC5CLUgY6zeAPJD4fzbf/tVjWWTbLZfJ
         qA/CWiORabqamPPbExrPQIq5oQWm1JPF3EkcwFvt/Zg3h+cyu+0l3TdPmtXdK+sVQqO3
         9fogMK8T6zgfhKit5A0FpluTcyCDupsAxQ9eI/Tluj0fD8Z9wFn5YNOGlwmrNnIHaH6D
         tdWsk6t30JDWwokDGIoFeW3ZchJqA9GDtYuIbxrO1Kb5vjUrDAude5Ip5opIi4KZgTu9
         uaLaHPl2A1qxHwQN4IZF7ioOX2cPR36MoogRnBJ9H+td1lzrlxuWNUvxZoRJPQG/1qGr
         PXOA==
X-Gm-Message-State: APjAAAUafmXOyy8ud/Zyje4JICUcF8kkh+cS51qA1m34JwId7ciSfFNQ
        868SN/+LHUxjkCBU1TXR4WA=
X-Google-Smtp-Source: APXvYqwCNKT0hQU2RWOH39HQnV30TOQjHn3K4hasN6PpsgAwO+KDKmGgw5JxPLmGIh7UdYu5S1epqQ==
X-Received: by 2002:a63:5a64:: with SMTP id k36mr6064508pgm.323.1578499456356;
        Wed, 08 Jan 2020 08:04:16 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id d22sm4079894pfo.187.2020.01.08.08.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 08:04:15 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 1/3] mm, list_lru: make memcg visible to lru walker isolation function
Date:   Wed,  8 Jan 2020 11:03:55 -0500
Message-Id: <1578499437-1664-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
References: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
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
 include/linux/memcontrol.h | 21 +++++++++++++++++++++
 mm/list_lru.c              | 47 +++++++++++++++++++++++++++-------------------
 mm/memcontrol.c            | 15 ---------------
 3 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5..a624c42 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -445,6 +445,21 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
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
index 0f1f6b0..6daa8c6 100644
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
@@ -273,7 +273,7 @@ unsigned long list_lru_count_node(struct list_lru *lru, int nid)
 	unsigned long ret;
 
 	spin_lock(&nlru->lock);
-	ret = __list_lru_walk_one(nlru, memcg_cache_id(memcg), isolate, cb_arg,
+	ret = __list_lru_walk_one(nlru, memcg, isolate, cb_arg,
 				  nr_to_walk);
 	spin_unlock(&nlru->lock);
 	return ret;
@@ -289,7 +289,7 @@ unsigned long list_lru_count_node(struct list_lru *lru, int nid)
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
index 601405b..9bd4ea7 100644
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
1.8.3.1

