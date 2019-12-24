Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE51129EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 08:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLXHz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 02:55:27 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39247 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXHz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 02:55:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id t101so886934pjb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 23:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5g2CLXGgkilXyD/2e6aUVdcgkPOtGJ9tnX8zatE5JMA=;
        b=q+8rr6ajBZfR9pA/qszO7K4g081IeY3nrEQ0eX0Ta/Iz18TJqfZeSQjtCFBLFjUIJH
         v6i+88Xa5c6dpn80FykmXrKZM39ZVIo3cpDEAsTTlpvjSgVf//zRp2wtShjifLC9M4SY
         OtcFOM6UMIji/p0EQHRYLXjl/GBJvgyOgMjM0+ejtQajtd9JVh9dA4y1qu18XJ0eav3L
         PaYyfXGVm+Sd5g6L20U+HWInvM4gQVtz/hudATeZ9XiACsil7xbo9+wLor6vNYcvw3Qa
         LjhUJ9FKqhoTbebSbGFj/wE19bXexAbrbzZXEZD1hiXpbwxRaP4DDYhNIi6xdIMXLD0X
         4weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5g2CLXGgkilXyD/2e6aUVdcgkPOtGJ9tnX8zatE5JMA=;
        b=Kx0EDg45clgbQvPXZ8swXsZsdTVj9pDJpUOt7kwCXvzKmxjFhUNIoTxeAy9qYq+ZlD
         6JlrURsVeTfVKBCVX4HW5BcIFLB6Vx3AEhyx4b7hQDzbpC/a98/+JVskftq4XqqWOajO
         E66cEFxL5xfsxca6IvovrGrxGd2g0kI41AxTeV7c4BWOfaH183hUKzsE8EBTzhNJhi/M
         YZ8OymFJBP8h+u3lDmuPnFyDo4BiPLgkRRnAjhPO9Iaz1MNi9QfG/qmcLINnLBDvDIZd
         J/T8Wr/tq8u5F/AX68WkHr3ZPxwZyAo3cMMmEUtG97gJrIJosKvJErubHlHQGHwU8lzE
         5kpg==
X-Gm-Message-State: APjAAAVt3fFAhyKu7WEddy00GlKov5FNbyqU2OWKmk6YqNUOL0D43yib
        LXL+w/Sqo+ikdJf5YZlyYQU=
X-Google-Smtp-Source: APXvYqyjF29Qc3jrwSpUGKp+qUPPcOVOx2HneauT30nXLFZAOThRTyDFmjPqhi8ssMoVbQr35afI0g==
X-Received: by 2002:a17:90a:77c1:: with SMTP id e1mr4325998pjs.134.1577174126920;
        Mon, 23 Dec 2019 23:55:26 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c2sm2004064pjq.27.2019.12.23.23.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 23:55:26 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, david@fromorbit.com, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2 4/5] mm: make memcg visible to lru walker isolation function
Date:   Tue, 24 Dec 2019 02:53:25 -0500
Message-Id: <1577174006-13025-5-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
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

Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h | 21 +++++++++++++++++++++
 mm/list_lru.c              | 22 ++++++++++++----------
 mm/memcontrol.c            | 15 ---------------
 3 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1a315c7..f36ada9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -449,6 +449,21 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
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
@@ -949,6 +964,12 @@ static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
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
index 0f1f6b0..536830d 100644
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
@@ -299,17 +299,15 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 				 list_lru_walk_cb isolate, void *cb_arg,
 				 unsigned long *nr_to_walk)
 {
+	struct mem_cgroup *memcg;
 	long isolated = 0;
-	int memcg_idx;
 
-	isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
-				      nr_to_walk);
-	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
-		for_each_memcg_cache_index(memcg_idx) {
+	if (list_lru_memcg_aware(lru)) {
+		for_each_mem_cgroup(memcg) {
 			struct list_lru_node *nlru = &lru->node[nid];
 
 			spin_lock(&nlru->lock);
-			isolated += __list_lru_walk_one(nlru, memcg_idx,
+			isolated += __list_lru_walk_one(nlru, memcg,
 							isolate, cb_arg,
 							nr_to_walk);
 			spin_unlock(&nlru->lock);
@@ -317,7 +315,11 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 			if (*nr_to_walk <= 0)
 				break;
 		}
+	} else {
+		isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
+					      nr_to_walk);
 	}
+
 	return isolated;
 }
 EXPORT_SYMBOL_GPL(list_lru_walk_node);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2e78931..2fc2bf4 100644
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

