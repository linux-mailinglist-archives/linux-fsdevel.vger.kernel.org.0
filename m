Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC1237A52A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhEKKyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 06:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhEKKyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 06:54:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742B0C06138A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:53:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fa21-20020a17090af0d5b0290157eb6b590fso1125003pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8N5ZUdYb8l/oRbGA6g7N4k0yzncAYFXCS7KEjhs0TU=;
        b=pE/EHpen5n4IYXpbRh8rAp8XuzT/8oWVSC4E6SwrUfStEJI8TITTEghKAeCrkLNFZI
         Q8U/OIBh/EJ3sZqvIvd5t2PPwjaw5PX1aWZcJlv0aAEG3q+uY3KUEf6xwBywKBp4OF9c
         vDT2wtI7BsdYMX6ltbRtlTC9hmlJ+l0O8yefFrC+65WYut3Dx+8hIHmi6kbs3CLdenAi
         jf89YMOOS1MDOlKuWkBLfqpSAjwKzqBuIZWoD/Lz8cXePLeDTZ1fkT9ELjjIMsv5UFOV
         b25XostjxyOgCTo4y5Mz/UwLe4pnqKJkCC++Gs65Y0p46H27uIpS3V9j29mk4eFuLgcV
         O3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8N5ZUdYb8l/oRbGA6g7N4k0yzncAYFXCS7KEjhs0TU=;
        b=RWprTHOt2OnG7ik/Mxw5rOBjimZKl/Ava9GQvnAfOOnq2XDHldIxptEMS5A2K0RWrq
         uY6X8S2hvh67mCzsRr37tZr8y6ZyeY4h0oXXQnOgIuWsEL/+qg7E+XsDGTF2ir6eE+b2
         9c8+EpNfK7HC0KfPdT5VFuZXLw76UwADRSwCRLQPLWLV6bq4QL1p8ZRBa4Lh3Eg2hiWN
         x5pq4jRwgoCdAhIpPhgyi+D6skWzL8f1Z0x1OmPH4eGjXldp61d4IgvOZHs0yLXyS5OS
         xrPhC1/9gfnP/LTEI+T8JJHSjiRe49UkttNMYIu8VU3IAaCDr5Cj8WP0Nl+uu212zBKt
         IOog==
X-Gm-Message-State: AOAM532LqkGzq4/F1uGiEx/sAff0Q5tTKIcOhcM8AXksH0zLJ+N2ijRX
        ZYXImRW9LiA1rYViD9HbZtU+rw==
X-Google-Smtp-Source: ABdhPJyh1wXx5mYfbkgRhiGJmuigd7/EclP3NGsv7ZdHfD+hX+newjmF7fotu22j9mscSwJYcjyXXQ==
X-Received: by 2002:a17:902:e804:b029:ed:5748:9047 with SMTP id u4-20020a170902e804b02900ed57489047mr29202382plg.36.1620730394053;
        Tue, 11 May 2021 03:53:14 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.53.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:53:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 16/17] mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus
Date:   Tue, 11 May 2021 18:46:46 +0800
Message-Id: <20210511104647.604-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of the memcg_drain_all_list_lrus() is list_lrus reparenting.
It is very similar to memcg_reparent_objcgs(). Rename it to
memcg_reparent_list_lrus() so that the name can more consistent with
memcg_reparent_objcgs().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  3 +--
 mm/list_lru.c            | 19 +++++++++----------
 mm/memcontrol.c          |  4 ++--
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 7d4346b93b24..9222d0295d30 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -76,8 +76,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
-			       struct mem_cgroup *dst_memcg);
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index b5ed6b797a48..6d7ae24a4a70 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -440,8 +440,8 @@ int memcg_update_all_list_lrus(int new_size)
 	return ret;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
-				      int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
+					 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
@@ -491,22 +491,21 @@ static void list_lru_per_memcg_free(struct list_lru *lru, int src_idx)
 		kvfree_rcu(mlru, rcu);
 }
 
-static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru(struct list_lru *lru,
+				    int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
+		memcg_reparent_list_lru_node(lru, i, src_idx, dst_memcg);
 
 	list_lru_per_memcg_free(lru, src_idx);
 }
 
-void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
-			       struct mem_cgroup *dst_memcg)
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
 	struct list_lru *lru;
-	int src_idx = src_memcg->kmemcg_id;
+	int src_idx = memcg->kmemcg_id;
 
 	/*
 	 * Change kmemcg_id of this cgroup to the parent's id, and then move
@@ -519,11 +518,11 @@ void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
 	 * from allocating list lrus for this cgroup after calling
 	 * list_lru_per_memcg_free().
 	 */
-	src_memcg->kmemcg_id = dst_memcg->kmemcg_id;
+	memcg->kmemcg_id = parent->kmemcg_id;
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_memcg);
+		memcg_reparent_list_lru(lru, src_idx, parent);
 	mutex_unlock(&list_lrus_mutex);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 879d2ff8d81f..02a65ff3b77a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3485,14 +3485,14 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	/*
-	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
 	 * Cache it to @kmemcg_id.
 	 */
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
 	/* memcg_reparent_objcgs() must be called before this. */
-	memcg_drain_all_list_lrus(memcg, parent);
+	memcg_reparent_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

