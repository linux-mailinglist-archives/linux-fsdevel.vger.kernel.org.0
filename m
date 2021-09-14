Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90AB40A883
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhINHsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhINHru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:47:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3376DC061A2A
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:42:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1460273pjc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CUB88/FqeRt+OVWlft0iBfJ40Vb/KWjqElOuPdMD70=;
        b=rTJJ/eMiE+Avxnn6TesM3SKY0q/LBFL95nxNlqPiFb0QWIihuVfQq6xQqgeFTwvmAl
         tIRfhq3xNb0KzfufoUgbX2K2vXKNf1+jNptKTW/XhwEM3xUv00+pbwZrWtFFGrEM+Eyg
         W7KvfKxYMy3wdJNxJPfj3/jeh0fTBH86WeGHNC4dm29fahTON9a0fX+QEYFopyaEXu9A
         EnQ6ZuzbwiYn92qbSNvH/pi5NYQoHHtIqNL6MkzmqQ59JmP7cCY7ewb2xzNilHG/+Qyw
         g9BthK+IwaDnI9b/N2LDXadLAObW/BHqeyJ3FO677/RjuIg53p1jIEed4dPS1A6M6EiT
         AB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CUB88/FqeRt+OVWlft0iBfJ40Vb/KWjqElOuPdMD70=;
        b=dgZfsPCldEZkrG6YPtxUGnyfumYc7ZSuvA7Z/giACe5qc11goTeWBqCorv/1DQGIvx
         ivm13+8td/PQ4RWAnaDMX7ogFVJXNhmLDuKoFFpqYtBfz0QX9HxfAZ4pXk1ohzS0zLLC
         Kte+9iY8mHowNOatzd4jnqTRMgJKMmgnK+yppr4r1axkbqYIYt2pCBnHQyNScTA0x5qg
         h3vIFLCkrcT4m9rKJ861KabIOXVF2cwYPRddlQoK35tpTNivaDXNZFryVrUrMbkUZIKB
         /5btW+FE1ZJPvxgaG0WyyluDbEAUBlfT8s8GTMi7HwPXsH2LFHbTH7dZZb3s9Bf/0p+o
         nJVA==
X-Gm-Message-State: AOAM532i+FYih7HT0Vo8mO/QSQRKCn1Pm4MaXbCQpFx2l7akjynouKT4
        oY42uaZSLS6wkbx0xyI4ltjmzJZNKP7SmA==
X-Google-Smtp-Source: ABdhPJxXQb/1pg6WwA5902/GVe6aKv1ypsajk4jUVpRYCnVpAyd3ouY5mba5097zNjHbW4FJ2ybJgA==
X-Received: by 2002:a17:90a:4ce3:: with SMTP id k90mr540686pjh.237.1631605321784;
        Tue, 14 Sep 2021 00:42:01 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.41.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:42:01 -0700 (PDT)
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
Subject: [PATCH v3 76/76] mm: memcontrol: rename memcg_cache_id to memcg_kmem_id
Date:   Tue, 14 Sep 2021 15:29:38 +0800
Message-Id: <20210914072938.6440-77-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The memcg_cache_id is introduced by commit 2633d7a02823 ("slab/slub:
consider a memcg parameter in kmem_create_cache"). It is used to index
in the kmem_cache->memcg_params->memcg_caches array. Since
kmem_cache->memcg_params.memcg_caches has been removed by commit
9855609bde03 ("mm: memcg/slab: use a single set of kmem_caches for
all accounted allocations"). So the name does not need to reflect cache
related. Just rename it to memcg_kmem_id. And it can reflect kmem
related.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  4 ++--
 mm/list_lru.c              | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 33f6ec4783f8..6541ec768a60 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1713,7 +1713,7 @@ static inline void memcg_kmem_uncharge_page(struct page *page, int order)
  * A helper for accessing memcg's kmem_id, used for getting
  * corresponding LRU lists.
  */
-static inline int memcg_cache_id(struct mem_cgroup *memcg)
+static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 {
 	return memcg ? memcg->kmemcg_id : -1;
 }
@@ -1751,7 +1751,7 @@ static inline bool memcg_kmem_enabled(void)
 	return false;
 }
 
-static inline int memcg_cache_id(struct mem_cgroup *memcg)
+static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 {
 	return -1;
 }
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 371097ee2485..8fb38dee0e99 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -74,7 +74,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 	if (!memcg)
 		goto out;
 
-	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 out:
 	if (memcg_ptr)
 		*memcg_ptr = memcg;
@@ -181,7 +181,7 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 	long count = 0;
 
 	rcu_read_lock();
-	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 	if (l)
 		count = READ_ONCE(l->nr_items);
 	rcu_read_unlock();
@@ -273,7 +273,7 @@ list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock(&nlru->lock);
-	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+	ret = __list_lru_walk_one(lru, nid, memcg_kmem_id(memcg), isolate,
 				  cb_arg, nr_to_walk);
 	spin_unlock(&nlru->lock);
 	return ret;
@@ -289,7 +289,7 @@ list_lru_walk_one_irq(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock_irq(&nlru->lock);
-	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+	ret = __list_lru_walk_one(lru, nid, memcg_kmem_id(memcg), isolate,
 				  cb_arg, nr_to_walk);
 	spin_unlock_irq(&nlru->lock);
 	return ret;
@@ -463,7 +463,7 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 static bool memcg_list_lru_skip_alloc(struct list_lru *lru,
 				      struct mem_cgroup *memcg)
 {
-	int idx = memcg_cache_id(memcg);
+	int idx = memcg_kmem_id(memcg);
 
 	if (unlikely(idx < 0) || xa_load(&lru->xa, idx))
 		return true;
@@ -518,7 +518,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 
 	xas_lock_irqsave(&xas, flags);
 	while (i--) {
-		int index = memcg_cache_id(table[i].memcg);
+		int index = memcg_kmem_id(table[i].memcg);
 		struct list_lru_memcg *mlru = table[i].mlru;
 
 		xas_set(&xas, index);
@@ -538,7 +538,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 				 * memcg id. More details see the comments
 				 * in memcg_reparent_list_lrus().
 				 */
-				index = memcg_cache_id(table[i].memcg);
+				index = memcg_kmem_id(table[i].memcg);
 				if (index < 0)
 					xas_set_err(&xas, 0);
 				else if (!xas_error(&xas) && index != xas.xa_index)
-- 
2.11.0

