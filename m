Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D9B40A87F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbhINHsU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbhINHrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:47:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C89C061141
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so7598630plp.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSAYuhOyann2TYu2BTLW7Gh2GVVnTWM86+XGXivlMaI=;
        b=RjdpnwuZYCntSc2k5Rp9Zx731FWalvTUA4/EVgheivP6nkFjljjrIAA+dnk+yGBWcV
         7BAOAkK3M032Ow0n4G1tYHQ6EpH5PxkTcfLDV6d/Jd6kD2VzfvtAmYTJCpdu/yyqTsdL
         7YKM/5D7ol1TY3tqUaj967frvkZYXxgdGQ/m3tayT79s8ZIw6Qxr4TkeqmUTij+ICSRC
         ouoo34le5ARMxk2v6MeKQdJu61ALZb3IwujZ0AQOxJgjHkKq8nVx5Qah3Gi8bPeaYlB9
         /I0RdqovHxgW/13VCn+0pG8ByT7yBRcecKun3z+OVZJQUl33KATYfAcW71RnjFjXCwb2
         sCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSAYuhOyann2TYu2BTLW7Gh2GVVnTWM86+XGXivlMaI=;
        b=V51/6QsS4gnRKBD0vyXCN3jzSoHNqRRRN4m5LZnjbV+RxYh3jEaFrEArv9RUgBdQDY
         yUM2vVkMY8TiANgdpkGXX+1XFX/FmQqoeo0IL8FtOjrnb7n4O2MKylHpHlp7+DEGL4qY
         qc4oUR/CUW+aGyXpZGwwoPPtwahO/yGDZgDK2/EwDiz+9tVLL2cxfwgKQ/+ypQ39co2D
         ETrp5g1PiXIHVI0p3JLzQBqb+pqXNdtTy8P7bzPsJ6buZ7dwwEyvX+XtrS1s6dfR5voS
         mr65TXKbWvVHnUHKngudRC3DIpKGl1ft7FbhOSgfIiU0xUMr4yUW87jJ5D3jIhK1+QMw
         pF7Q==
X-Gm-Message-State: AOAM533fnNG+HSoEYcZXcyWpBQvZYg7MCjW0ovhei0++LHVxvjPSFLlx
        CK4Jf5jOVGaLBvtG5J8JKeySyQ==
X-Google-Smtp-Source: ABdhPJzZ/+akkmlZcbuRVLuFo7kw7adZkfup1RQUhnKbZBRJAiX9R8j05PAQA34sU2tGS+Roa9MW9w==
X-Received: by 2002:a17:90a:1c81:: with SMTP id t1mr577065pjt.170.1631605314870;
        Tue, 14 Sep 2021 00:41:54 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.41.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:41:54 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 75/76] mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
Date:   Tue, 14 Sep 2021 15:29:37 +0800
Message-Id: <20210914072938.6440-76-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before now, the name of list_lru_memcg was occupied. Since previous
patch, the name is free. So rename list_lru_per_memcg to list_lru_memcg,
it is more brief.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  2 +-
 mm/list_lru.c            | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index c423be3cf2d3..d654c8e3d262 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -32,7 +32,7 @@ struct list_lru_one {
 	long			nr_items;
 };
 
-struct list_lru_per_memcg {
+struct list_lru_memcg {
 	struct rcu_head		rcu;
 	/* array of per cgroup per node lists, indexed by node id */
 	struct list_lru_one	nodes[];
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 1202519aeb31..371097ee2485 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -52,7 +52,7 @@ static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
 	if (list_lru_memcg_aware(lru) && idx >= 0) {
-		struct list_lru_per_memcg *mlru = xa_load(&lru->xa, idx);
+		struct list_lru_memcg *mlru = xa_load(&lru->xa, idx);
 
 		return mlru ? &mlru->nodes[nid] : NULL;
 	}
@@ -306,7 +306,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 
 #ifdef CONFIG_MEMCG_KMEM
 	if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		unsigned long index;
 
 		xa_for_each(&lru->xa, index, mlru) {
@@ -335,10 +335,10 @@ static void init_one_lru(struct list_lru_one *l)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
-static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
+static struct list_lru_memcg *memcg_list_lru_alloc(gfp_t gfp)
 {
 	int nid;
-	struct list_lru_per_memcg *lru;
+	struct list_lru_memcg *lru;
 
 	lru = kmalloc(struct_size(lru, nodes, nr_node_ids), gfp);
 	if (!lru)
@@ -352,7 +352,7 @@ static struct list_lru_per_memcg *memcg_list_lru_alloc(gfp_t gfp)
 
 static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	struct list_lru_per_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
+	struct list_lru_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
 
 	/*
 	 * The __list_lru_walk_one() can walk the list of this node.
@@ -374,7 +374,7 @@ static void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 	XA_STATE(xas, &lru->xa, 0);
-	struct list_lru_per_memcg *mlru;
+	struct list_lru_memcg *mlru;
 
 	if (!list_lru_memcg_aware(lru))
 		return;
@@ -477,7 +477,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	int i;
 
 	struct list_lru_memcg_table {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		struct mem_cgroup *memcg;
 	} *table;
 
@@ -488,7 +488,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 		return 0;
 
 	/*
-	 * The allocated list_lru_per_memcg array is not accounted directly.
+	 * The allocated list_lru_memcg array is not accounted directly.
 	 * Moreover, it should not come from DMA buffer and is not readily
 	 * reclaimable. So those GFP bits should be masked off.
 	 */
@@ -500,7 +500,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	/*
 	 * Because the list_lru can be reparented to the parent cgroup's
 	 * list_lru, we should make sure that this cgroup and all its
-	 * ancestors have allocated list_lru_per_memcg.
+	 * ancestors have allocated list_lru_memcg.
 	 */
 	for (i = 0; memcg; memcg = parent_mem_cgroup(memcg), i++) {
 		if (memcg_list_lru_skip_alloc(lru, memcg))
@@ -519,7 +519,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 	xas_lock_irqsave(&xas, flags);
 	while (i--) {
 		int index = memcg_cache_id(table[i].memcg);
-		struct list_lru_per_memcg *mlru = table[i].mlru;
+		struct list_lru_memcg *mlru = table[i].mlru;
 
 		xas_set(&xas, index);
 retry:
-- 
2.11.0

