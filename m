Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22AA47A683
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 10:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhLTI76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhLTI76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:59:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6CC06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:59:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so9723329pjj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7Mg/f9nLeyIWPXNcJvDRJ+Jd7WL7Il017lo2NLhARI=;
        b=AObXVaMCAZp1YSpU+N0pd6b07yZsOB0gSHwjRit7kLVYIZYiRfeQ/spzZXewRhTyMr
         9zaGnTPCpA/zmFjGnY68cgU+xL9qQL2htZp6Zqeie2XKwUyKx+VcuYh2HoGW5CyLZ3tl
         6+l07WxDwkKR8yn284XkR8CoQyeCnFyTm49lYj8Vbe8ajOJxOSJOwAwp/x0vmAyNVmnj
         xQlZ64Oqvv4P6iAYhMcwyxRDd6nnNevokyhdHMcfYrW8fxUL8nLJXNGWZbPVETcy4pFO
         WjtaCCOEuv+cJ5O7aRdjkwL2gP/mrZnl5CdjsHZIOrJ8Ltn+Cp51WsJpIqNHM106kMNj
         0/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7Mg/f9nLeyIWPXNcJvDRJ+Jd7WL7Il017lo2NLhARI=;
        b=WXFYll87c9p437tUkc2m9fBxGjCOYfYMgSLqi3/6duZrrCEFjGLbAROLOqtN2x5R2D
         uga9r24OQTgt6VeqDFGH1UdqPWvfTEwDhijq1bQrFp575IRWD7IQmKwHZHssKo7n7Gqn
         L2j7yP12VqxCUf2j/BLvzqthFYyfcrNe/NR5vTnJ/HRn/Fgx/ao4c7Zyy44ZOB3mvrYd
         gV0kA3aIsXtwtPY9i+fMRpFRdR6DLQOFFtWa9KNI/QBeatF+lsTWwW2LTCefRPXXaYCq
         vkzqutq20peDGpe4psEKz8Lzi/Yn2DtDWSHL5/HAFUgKQ9hlNd0LpjgGCpUSQvrH+nx2
         8RGQ==
X-Gm-Message-State: AOAM530nusKRBDJ7TZD6358hKzwmYwNM0hZmpKkEWmRtpCdEHTCx2Qrv
        ahY/St/qxi1Uezi7JPaASJ2GtQ==
X-Google-Smtp-Source: ABdhPJxnxSChBfXQZtFai6mG8NPSe+Q2tN3yMmFqcabRYLbf40MvRwYGGO1kMR6ED42RJ5L/OKu9aw==
X-Received: by 2002:a17:90a:d792:: with SMTP id z18mr1922586pju.182.1639990797245;
        Mon, 20 Dec 2021 00:59:57 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:59:56 -0800 (PST)
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
Subject: [PATCH v5 15/16] mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
Date:   Mon, 20 Dec 2021 16:56:48 +0800
Message-Id: <20211220085649.8196-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
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
index 8dc1dabb9f05..38f711e9b56e 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -53,7 +53,7 @@ static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
 	if (list_lru_memcg_aware(lru) && idx >= 0) {
-		struct list_lru_per_memcg *mlru = xa_load(&lru->xa, idx);
+		struct list_lru_memcg *mlru = xa_load(&lru->xa, idx);
 
 		return mlru ? &mlru->node[nid] : NULL;
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
-static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
+static struct list_lru_memcg *memcg_init_list_lru_one(gfp_t gfp)
 {
 	int nid;
-	struct list_lru_per_memcg *mlru;
+	struct list_lru_memcg *mlru;
 
 	mlru = kmalloc(struct_size(mlru, node, nr_node_ids), gfp);
 	if (!mlru)
@@ -352,7 +352,7 @@ static struct list_lru_per_memcg *memcg_init_list_lru_one(gfp_t gfp)
 
 static void memcg_list_lru_free(struct list_lru *lru, int src_idx)
 {
-	struct list_lru_per_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
+	struct list_lru_memcg *mlru = xa_erase_irq(&lru->xa, src_idx);
 
 	/*
 	 * The __list_lru_walk_one() can walk the list of this node.
@@ -374,7 +374,7 @@ static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 	XA_STATE(xas, &lru->xa, 0);
-	struct list_lru_per_memcg *mlru;
+	struct list_lru_memcg *mlru;
 
 	if (!list_lru_memcg_aware(lru))
 		return;
@@ -476,7 +476,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	unsigned long flags;
 	struct list_lru_memcg *mlrus;
 	struct list_lru_memcg_table {
-		struct list_lru_per_memcg *mlru;
+		struct list_lru_memcg *mlru;
 		struct mem_cgroup *memcg;
 	} *table;
 	XA_STATE(xas, &lru->xa, 0);
@@ -492,7 +492,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	/*
 	 * Because the list_lru can be reparented to the parent cgroup's
 	 * list_lru, we should make sure that this cgroup and all its
-	 * ancestors have allocated list_lru_per_memcg.
+	 * ancestors have allocated list_lru_memcg.
 	 */
 	for (i = 0; memcg; memcg = parent_mem_cgroup(memcg), i++) {
 		if (memcg_list_lru_allocated(memcg, lru))
@@ -511,7 +511,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 	xas_lock_irqsave(&xas, flags);
 	while (i--) {
 		int index = READ_ONCE(table[i].memcg->kmemcg_id);
-		struct list_lru_per_memcg *mlru = table[i].mlru;
+		struct list_lru_memcg *mlru = table[i].mlru;
 
 		xas_set(&xas, index);
 retry:
-- 
2.11.0

