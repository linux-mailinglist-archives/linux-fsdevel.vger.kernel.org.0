Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2DF47328A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 17:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbhLMQ4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 11:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbhLMQ4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:56:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8BC061751
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:45 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b11so11577043pld.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2YmK/AqMe27j9o3uI5YugTy0n4T5vwwV8kNY4d0ulCc=;
        b=U2enTDU8zPJw/9r5F06prOrfcbqd4ATnOlcT9Z0Nl419NKeqvecXqzpTag0O+LGl0n
         FY2tnX1mrHDmqs0sNJL2kB1M4rvEMmgYK0F2IhhqOYMGdyg3jjuzvhh/aqqnmuVh+vPi
         idEmGZwqgqFUYWO93RRL7zl+IJDaso/9X2Fag+rbHfH7L0y6Yl6M3RjD0hF0MgkKicRD
         GV7Ize5rLoleK9GG6CY0Wnz1o1Tb33KK3P/6pqYwBgzrcunDfj7Xvj41MJ2nSbvWoUs8
         noV35gy+Ixz7MvCToIK6saidiZ+AueZmBczwdo6vCGjC3wS8d3b3+VUgg86IFFz5DVzs
         VqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2YmK/AqMe27j9o3uI5YugTy0n4T5vwwV8kNY4d0ulCc=;
        b=oqKJe2Q0lAF0tkHyFeWH2N3pqgEOI3m1w67RrYBFQ15ceKGpetg9qCZipreCNEoq0Z
         SjlqbsVrnLCV56zOdCUp25phognkONr704QwF5Oz5a7d6hz83fHhkdBfeYWynp1c1Fv7
         Gj/GOBqj3EVW5sgD2OCVZeIrz03yY+03t23LatiW8NiN1MNa1Ox9gJxY2S0W3FOTpKvT
         +Hh9FUrFMPiqIqdQmr2yHUCNaDFDEITCNflqTGAcwv1jU4XJ+txnzQgow4tDBX6zzqd3
         YuneFitp0OFNANSJ0DGx/v+pqHz56UbquNZecgoe/u6qCb62p5lSao40KhiZWXGa/laQ
         C//Q==
X-Gm-Message-State: AOAM531Ze9LEdKRV3+ffsxPsbPgG8Rp+pCOtIbu2EZjs5qxjG4cAapLk
        9Cn1CxPUZ5PhcZ10QrHjMf0DqQ==
X-Google-Smtp-Source: ABdhPJynw5ovDTz6V5Rg6PcsaCj0FkW5zMQOf7jLCguHchhkjHruMJaYxa1EQux3Ek4059JC8PzN2Q==
X-Received: by 2002:a17:902:e0ca:b0:143:c213:ffa1 with SMTP id e10-20020a170902e0ca00b00143c213ffa1mr96720866pla.73.1639414604718;
        Mon, 13 Dec 2021 08:56:44 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.56.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:56:44 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 16/17] mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
Date:   Tue, 14 Dec 2021 00:53:41 +0800
Message-Id: <20211213165342.74704-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The name of list_lru_memcg was occupied before and became free since last
commit. Rename list_lru_per_memcg to list_lru_memcg since the name is brief.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  2 +-
 mm/list_lru.c            | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 572c263561ac..b35968ee9fb5 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -32,7 +32,7 @@ struct list_lru_one {
 	long			nr_items;
 };
 
-struct list_lru_per_memcg {
+struct list_lru_memcg {
 	struct rcu_head		rcu;
 	/* array of per cgroup per node lists, indexed by node id */
 	struct list_lru_one	node[];
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 7ff3988e92aa..589146fd3770 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -52,7 +52,7 @@ static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
 	if (list_lru_memcg_aware(lru) && idx >= 0) {
-		struct list_lru_per_memcg *mlru = xa_load(&lru->xa, idx);
+		struct list_lru_memcg *mlru = xa_load(&lru->xa, idx);
 
 		return mlru ? &mlru->node[nid] : NULL;
 	}
@@ -305,7 +305,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 
 #ifdef CONFIG_MEMCG_KMEM
 	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		unsigned long index;
 
 		xa_for_each(&lru->xa, index, mlru) {
@@ -334,10 +334,10 @@ static void init_one_lru(struct list_lru_one *l)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
+static struct list_lru_memcg *memcg_init_list_lru_one(gfp_t gfp)
 {
 	int nid;
-	struct list_lru_per_memcg *mlru;
+	struct list_lru_memcg *mlru;
 
 	mlru = kmalloc(struct_size(mlru, node, nr_node_ids), GFP_KERNEL);
 	if (!mlru)
@@ -351,7 +351,7 @@ static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
 
 static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	struct list_lru_per_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
+	struct list_lru_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
 
 	/*
 	 * The __list_lru_walk_one() can walk the list of this node.
@@ -373,7 +373,7 @@ static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 	XA_STATE(xas, &lru->xa, 0);
-	struct list_lru_per_memcg *mlru;
+	struct list_lru_memcg *mlru;
 
 	if (!list_lru_memcg_aware(lru))
 		return;
@@ -482,7 +482,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	unsigned long flags;
 	struct list_lru_memcg *mlrus;
 	struct list_lru_memcg_table {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		struct mem_cgroup *memcg;
 	} *table;
 	XA_STATE(xas, &lru->xa, 0);
@@ -498,7 +498,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	/*
 	 * Because the list_lru can be reparented to the parent cgroup's
 	 * list_lru, we should make sure that this cgroup and all its
-	 * ancestors have allocated list_lru_per_memcg.
+	 * ancestors have allocated list_lru_memcg.
 	 */
 	for (i = 0; memcg; memcg = parent_mem_cgroup(memcg), i++) {
 		if (memcg_list_lru_allocated(memcg, lru))
@@ -517,7 +517,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	xas_lock_irqsave(&xas, flags);
 	while (i--) {
 		int index = READ_ONCE(table[i].memcg->kmemcg_id);
-		struct list_lru_per_memcg *mlru = table[i].mlru;
+		struct list_lru_memcg *mlru = table[i].mlru;
 
 		xas_set(&xas, index);
 retry:
-- 
2.11.0

