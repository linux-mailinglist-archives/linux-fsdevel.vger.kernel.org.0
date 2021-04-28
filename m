Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473B736D515
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhD1JzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 05:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhD1JzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:55:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202EFC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m11so197022pfc.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbfZmKXxQSOn7wHkCejhev2qWZcfPUS5M9gRiT8vHvs=;
        b=BqOFNyjA/Es8BddpzZ+9QxaIwEeZvSIuQO419b/fBSreqOqcUtciS6XnVplZDrZlG/
         Imy6gNobcHN9VQvDMV/23CyMkdByJAqNWYXOjnXrqLQnlBCL3Q5MGNlt5tUXlbGe2fsh
         EzWGLAY4HuEZi8OeUdvhfwXr+AJyKi8UUff6lbxmCS5S1oHkh6xPZtngzOHzBOlXvwa7
         mXj6jgUf+OY2OCpdvZPqdFr/f0e9CYhODs0mfdwqr9OPaDCGojvLQSHtoTaEfwj0nl7d
         rN6sbJqX27CKHTBysTUwLvfX/Ky7+llOZ3baxVl62+P2oov3Ev4KJJ6+DO2fgHGZetZS
         JHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbfZmKXxQSOn7wHkCejhev2qWZcfPUS5M9gRiT8vHvs=;
        b=LoFq4AFKRd5+72qHAEnuevaFhrF11CSHmaZyCS1fLzCSrhKf/Hijiou1PrcCfT/9YB
         fu1kZX4pQMilJKJAv4hyFk3z2pexcqse7EJOInJ7DeS+0cOeaOawGVYdULZMbueIPHMO
         MK6XjdeQv7mvGkPsCapJ64cpAS6t49IYfEMKcqTi2DVrBekJpGiwDmPCZU051QcQ9zLu
         qcPa1CvwnLxacmYbloTnRej2D8KcufqlpabHJPzRoA26GlfRQ0+6y4KHQlkikIMnpnOd
         r/efYXgtRjek4mvo5v/jMEZm0PGtKWwRSO2kW1SULIaWUzjxgWAYmqIbPcSySBM0fPkg
         0oxA==
X-Gm-Message-State: AOAM530jfSDMerzjTJk3OlQ/gjOQ6YZrIg0QCvapy08yE5tV2gXyOYVj
        btJsX/gyInAIoatoKjxJxz/ZKw==
X-Google-Smtp-Source: ABdhPJw1XENVld3cLK+I71antXFfgkPHZ+eowp5+rG7qg4jm1nTaFVssJ6CW0IB96l43Y9shWLLlEQ==
X-Received: by 2002:aa7:9806:0:b029:253:e613:4ada with SMTP id e6-20020aa798060000b0290253e6134adamr27192427pfl.65.1619603655719;
        Wed, 28 Apr 2021 02:54:15 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:54:15 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/9] mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus
Date:   Wed, 28 Apr 2021 17:49:43 +0800
Message-Id: <20210428094949.43579-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since we do not change memcg->kmemcg_id before calling
memcg_drain_all_list_lrus(), so we do not need to take kmemcg_id as
parameter. The two parameters of memcg_drain_all_list_lrus() seems
odd, one is kmemcg_id, another is memcg. Now we can change the
kmemcg_id to the memcg. It is more consistent. Since the purpose of
the memcg_drain_all_list_lrus() is list_lru reparenting. So also
rename it to memcg_reparent_list_lrus(). The name is also consistent
with memcg_reparent_objcgs().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  2 +-
 mm/list_lru.c            | 23 ++++++++++++-----------
 mm/memcontrol.c          |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 9dcaa3e582c9..e8a5e3a2c0dd 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -70,7 +70,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg);
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 4962d48d4410..d78dba5a6dab 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -523,11 +523,11 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
-				      int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
+					 struct mem_cgroup *memcg,
+					 struct mem_cgroup *parent)
 {
 	struct list_lru_node *nlru = &lru->node[nid];
-	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
 	/*
@@ -536,22 +536,23 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	 */
 	spin_lock_irq(&nlru->lock);
 
-	src = list_lru_from_memcg_idx(nlru, src_idx);
-	dst = list_lru_from_memcg_idx(nlru, dst_idx);
+	src = list_lru_from_memcg_idx(nlru, memcg->kmemcg_id);
+	dst = list_lru_from_memcg_idx(nlru, parent->kmemcg_id);
 
 	list_splice_init(&src->list, &dst->list);
 
 	if (src->nr_items) {
 		dst->nr_items += src->nr_items;
-		set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
+		set_shrinker_bit(parent, nid, lru_shrinker_id(lru));
 		src->nr_items = 0;
 	}
 
 	spin_unlock_irq(&nlru->lock);
 }
 
-static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru(struct list_lru *lru,
+				    struct mem_cgroup *memcg,
+				    struct mem_cgroup *parent)
 {
 	int i;
 
@@ -559,16 +560,16 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
+		memcg_reparent_list_lru_node(lru, i, memcg, parent);
 }
 
-void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
 	struct list_lru *lru;
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_memcg);
+		memcg_reparent_list_lru(lru, memcg, parent);
 	mutex_unlock(&list_lrus_mutex);
 }
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 21e12312509c..c1ce4fdba028 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3503,7 +3503,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	BUG_ON(kmemcg_id < 0);
 
 	/* memcg_reparent_objcgs() must be called before this. */
-	memcg_drain_all_list_lrus(kmemcg_id, parent);
+	memcg_reparent_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

