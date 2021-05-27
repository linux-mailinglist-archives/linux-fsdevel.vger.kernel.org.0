Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EB39279B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhE0G27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhE0G2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:28:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D17C061346
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d78so2847458pfd.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saeNxjM08r5E+Sxs4m/QIhTTsKS/EbXdDHTVWv65coY=;
        b=e477haKznXStV5QieRFLlp0oO6Mf7tJUPQD/akahq0QEMUAs9WhgOa8q4TAUL0mNbp
         tCbPP9HrJFaOCgJMFNXRdTj2N+slXNojfhxZ9+KsGhkbA57CcSwqoF9fSxEYlm3NpMtf
         b2KAO/RQjm/XUHC8jhaCDihIBYEGU57r/yVkCp3Pbri6GKVGfn0avw1etj1Ek1htHp3M
         pc0wYQtUG6MUlJwFlS+nKjMeE14vx21zzCA1R8wRZQkSvAEkyjpFYU2fotx8UefC8WSG
         JXj21Ts/X5GhBs0I032lldbxlfC2xKl/4YpZUHk10bi1NYIHI8k/9fcmyigK4tjnhkyT
         23Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saeNxjM08r5E+Sxs4m/QIhTTsKS/EbXdDHTVWv65coY=;
        b=pWi7rZ9gdcWT5jm6c/p/Ae1VAq8hlhahkzqpVPqjh8tk+lnygk32xc3uah0uxOHHiI
         YMVbLSQ0lWAEGkcaByGuni0Q0Srr1fPijaQY42aD8Aw03QdPUSjJDMpv38ipCMsjNwO8
         zU97F9HKpUP32NdTnNNnh5YWjAFyIaMqmQAV+0itMSasmS/YW4UttBItobKeQ5zxB+Oz
         ue4bbCsx/0zN/FIOmqFlQT8mmnOv7q8zymwmAedCLhKKe2QYUrpR6Zp9F8vVc6Wt3nDz
         yKoNhzjwYxhI0Z3RUsudgIqgM+i0wRA6E37pZ0bDkLecPlKndm2rxR159ybwy2AOMbX4
         3mVQ==
X-Gm-Message-State: AOAM531k21f5JaI02Ja+zxWrqqCH8HOk8i2+VHVs6lYR+1IKBhKx8155
        pUYm7S02eM2D2CxvqLmsD5HwFw==
X-Google-Smtp-Source: ABdhPJyqz+2+MPfbYrdMkC+0d1NyNM7mJV+9i/WYx14HfOOaqe+ZuDWugDDPw7OgbcsrX7OPn62MqQ==
X-Received: by 2002:a63:752:: with SMTP id 79mr2314672pgh.10.1622096811343;
        Wed, 26 May 2021 23:26:51 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.26.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:26:51 -0700 (PDT)
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
Subject: [PATCH v2 21/21] mm: memcontrol: rename memcg_cache_id to memcg_kmem_id
Date:   Thu, 27 May 2021 14:21:48 +0800
Message-Id: <20210527062148.9361-22-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
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
index e129c7067f63..637d5854fdda 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1654,7 +1654,7 @@ static inline void memcg_kmem_uncharge_page(struct page *page, int order)
  * A helper for accessing memcg's kmem_id, used for getting
  * corresponding LRU lists.
  */
-static inline int memcg_cache_id(struct mem_cgroup *memcg)
+static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 {
 	return memcg ? memcg->kmemcg_id : -1;
 }
@@ -1688,7 +1688,7 @@ static inline bool memcg_kmem_enabled(void)
 	return false;
 }
 
-static inline int memcg_cache_id(struct mem_cgroup *memcg)
+static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 {
 	return -1;
 }
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 77efdd0c8b24..1ee2b28ded7d 100644
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
@@ -469,7 +469,7 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 static bool memcg_list_lru_skip_alloc(struct list_lru *lru,
 				      struct mem_cgroup *memcg)
 {
-	int idx = memcg_cache_id(memcg);
+	int idx = memcg_kmem_id(memcg);
 
 	if (unlikely(idx < 0) || xa_load(lru->xa, idx))
 		return true;
@@ -524,7 +524,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 
 	xas_lock_irqsave(&xas, flags);
 	while (i--) {
-		int index = memcg_cache_id(table[i].memcg);
+		int index = memcg_kmem_id(table[i].memcg);
 		struct list_lru_memcg *mlru = table[i].mlru;
 
 		xas_set(&xas, index);
@@ -544,7 +544,7 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
 				 * memcg id. More details see the comments
 				 * in memcg_reparent_list_lrus().
 				 */
-				index = memcg_cache_id(table[i].memcg);
+				index = memcg_kmem_id(table[i].memcg);
 				if (index < 0)
 					ret = 0;
 				else if (!ret && index != xas.xa_index)
-- 
2.11.0

