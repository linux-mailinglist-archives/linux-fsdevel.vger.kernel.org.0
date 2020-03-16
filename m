Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B568186946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 11:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgCPKka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 06:40:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41297 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgCPKka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:40:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id z65so9692765pfz.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2020 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2GXt5l0BnU2RaVncy40HZUiqISCrmfLRyzDrfxLSYfo=;
        b=DS6qyJAVsjhyGFLKknVXpXrpm8SXdExRu5smq/INJvlVQNIksj/Z/DLTRGiDCGpf1g
         CJDalo4ezR0dkUepeQbBTC6a+nWdpToG3zBO+Cw4NpW38yZ7UNAAx/yOVopse2BmkcTR
         0ag3iz6UBPaArUSqXLv6c4I50C65K1jEUDXZFBkjRiZMmaf6tHafTYptAhenll4rwRR+
         vD86Fumx1e1+kMiqv0bUHeeS1hf8OgTtKSzwQ5VpkKvOmxsbQCzRV//YZObofz82x2k7
         a1ItwC4dOxG4+53n6ZEmiv86CW2ZtPOE3lBWbIQ3iqNvXw+uz4yVnVVMLbPCz+OjLZrA
         WXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2GXt5l0BnU2RaVncy40HZUiqISCrmfLRyzDrfxLSYfo=;
        b=Auzi47AHzemAoqJV4AItmD0T10ego9mIAxS3DU0V+UG3sxtFMxo7r03odbtA1a/+1F
         L0jCN2kcTOFcOyy184zj50Ckwf6ZApT0CpZ9aKKnwHbYjNL7fi/8cmdNFQsTdJYAxChO
         8usYC7wWCtlZXIZ6twksRPZ0KYzIQfmEYFVilpzFxNs5zU3aM2lUQm0WCVJYVs5kTYbM
         KwVvUMzDjo/FbDFreZOLxO2gIy3++FLK6kSadL37ejFCV/22HiLlVCq8ejdMO/+19aVT
         u7bqD2XIXcDY1XJbP4banvoClOBWkgojZgTC6H23WhXMxOXrfJUNtXAsHTOZNeBO59wl
         tKHg==
X-Gm-Message-State: ANhLgQ3ZujBcw1DZcyd98hvHt4eix/oBy9LZ7MOMF/hkwOpaMel8F3J3
        Tn5IuH1ClcwW0FrvgXVrzwE=
X-Google-Smtp-Source: ADFU+vsDFwodClKlUJFRep/E7/L5Oz3gg/x0Pio8rVsxenPZ+WUNteouZKf+PQdwdm5z0p4Mb76Hdg==
X-Received: by 2002:a62:1dd3:: with SMTP id d202mr5005931pfd.47.1584355229901;
        Mon, 16 Mar 2020 03:40:29 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id h2sm19834276pjc.7.2020.03.16.03.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 03:40:29 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 1/3] mm, list_lru: make memcg visible to lru walker isolation function
Date:   Mon, 16 Mar 2020 06:39:56 -0400
Message-Id: <1584355198-10137-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584355198-10137-1-git-send-email-laoar.shao@gmail.com>
References: <1584355198-10137-1-git-send-email-laoar.shao@gmail.com>
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

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h | 18 ++++++++++++++++++
 mm/list_lru.c              | 47 +++++++++++++++++++++++++++-------------------
 mm/memcontrol.c            | 15 ---------------
 3 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5..39be2e4 100644
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
@@ -945,6 +960,9 @@ static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 	return 0;
 }
 
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
index 2058b8d..587c6b2 100644
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

