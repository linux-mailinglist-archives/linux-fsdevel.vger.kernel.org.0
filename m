Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32540A878
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhINHrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbhINHqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:46:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF550C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g14so11364138pfm.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTuclICje8xvheuCWw6eY5mtrJC1enFIQ8G/X086C4w=;
        b=1+5SZrthq4E9CNTL9shy+XTzy4GfS0MhkZdeG8bD6fclynhHhj6SeOoRgLf3pFR4my
         BGdV0PSiF09qkvytKWXvDnXU/KOBFqL/mqyOd1sL+vo2Gj5NZHMeujnW4p/ySo1tTlxW
         5MEgUiDUCrH+j8TmwGGLYiTNfhLcLs0t0Id5/t6xyCn302Mn4qKJClIS5r943Vjxj4R3
         3ESMJEOYtM7rTAMfYaypQTmjrXvgsC2iUteRT+ora65DDVkEHvRsGjpmwEPEOxw8Zrdi
         fZ9RQ48GuD6pdi3pqwQ3fw6la2Ty26HoG1CaMfVQn3mCzfqq1EJZGL+pXOhOIh4oqFaO
         8qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTuclICje8xvheuCWw6eY5mtrJC1enFIQ8G/X086C4w=;
        b=zxLnFKzdlqKOp2poti1403yZUHVewF/PCnK6licmC0coxFCKQXNVzALyjecfYk3SA4
         IVC1Dm0KvaBHWfi3cWReirnJ4QI4Pe/GenV1M3o2l7Q62zpMY+WhzpE1D0wAkw9WqWE/
         GrJInEiME0+DuDkZUzfi8W2D18f9yZX0ooIXE61YqZnUqgj2XJ8BVBOO1nc7jgdL21Bp
         OQO+ZeMsXYC7+EZrYrG2A/qYsDMai7APEQvboI2dcIDqVcbq+jkdxJbo2LPtcQeaQNHw
         0YBMITAC6PTFDiQsnOdv5SI+xbMzC3XkIIFvIzqRFKGhZl2CGNfAyPrAExbkRTmrQJgt
         cd6g==
X-Gm-Message-State: AOAM531IawxSheNdeKYMMUN9mS7bQD+Kg8vF9fvN1Kz4ERWPBk2cE3+f
        9U/cvAzZryDuVc2nOcOd8o91/g==
X-Google-Smtp-Source: ABdhPJyCCwvzSMLS40nMeu2zuIgha4feIFEx/Jfsb/Qd1SEBLvcROtNSaH2rs4+NXS6rDZ6silJirQ==
X-Received: by 2002:a63:1f24:: with SMTP id f36mr14690074pgf.6.1631605300457;
        Tue, 14 Sep 2021 00:41:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.41.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:41:39 -0700 (PDT)
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
Subject: [PATCH v3 73/76] mm: memcontrol: reuse memory cgroup ID for kmem ID
Date:   Tue, 14 Sep 2021 15:29:35 +0800
Message-Id: <20210914072938.6440-74-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two idrs being used by memory cgroup, one is for kmem ID,
another is for memory cgroup ID. The maximum ID of both is 64Ki.
Both of them can limit the total number of memory cgroups. Actually,
we can reuse memory cgroup ID for kmem ID to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 47 ++++++++--------------------------------------
 2 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 83add6c484b1..33f6ec4783f8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -56,6 +56,7 @@ struct mem_cgroup_reclaim_cookie {
 #ifdef CONFIG_MEMCG
 
 #define MEM_CGROUP_ID_SHIFT	16
+#define MEM_CGROUP_ID_MIN	1
 #define MEM_CGROUP_ID_MAX	USHRT_MAX
 
 struct mem_cgroup_id {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8e0cde19b648..e3a2e4d65cc5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -356,23 +356,6 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 }
 
 /*
- * This will be used as a shrinker list's index.
- * The main reason for not using cgroup id for this:
- *  this works better in sparse environments, where we have a lot of memcgs,
- *  but only a few kmem-limited.
- */
-static DEFINE_IDA(memcg_cache_ida);
-
-/*
- * MAX_SIZE should be as large as the number of cgrp_ids. Ideally, we could get
- * this constant directly from cgroup, but it is understandable that this is
- * better kept as an internal representation in cgroup.c. In any case, the
- * cgrp_id space is not getting any smaller, and we don't have to necessarily
- * increase ours as well if it increases.
- */
-#define MEMCG_CACHES_MAX_SIZE MEM_CGROUP_ID_MAX
-
-/*
  * A lot of the calls to the cache allocation functions are expected to be
  * inlined by the compiler. Since the calls to memcg_slab_pre_alloc_hook() are
  * conditional to this static branch, we'll have to allow modules that does
@@ -3520,10 +3503,12 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 }
 
 #ifdef CONFIG_MEMCG_KMEM
+#define MEM_CGROUP_KMEM_ID_MIN	-1
+#define MEM_CGROUP_ID_DIFF	(MEM_CGROUP_ID_MIN - MEM_CGROUP_KMEM_ID_MIN)
+
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg;
-	int memcg_id;
 
 	if (cgroup_memory_nokmem)
 		return 0;
@@ -3531,22 +3516,16 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (unlikely(mem_cgroup_is_root(memcg)))
 		return 0;
 
-	memcg_id = ida_alloc_max(&memcg_cache_ida, MEMCG_CACHES_MAX_SIZE - 1,
-				 GFP_KERNEL);
-	if (memcg_id < 0)
-		return memcg_id;
-
 	objcg = obj_cgroup_alloc();
-	if (!objcg) {
-		ida_free(&memcg_cache_ida, memcg_id);
+	if (!objcg)
 		return -ENOMEM;
-	}
+
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 
 	static_branch_enable(&memcg_kmem_enabled_key);
 
-	memcg->kmemcg_id = memcg_id;
+	memcg->kmemcg_id = memcg->id.id - MEM_CGROUP_ID_DIFF;
 
 	return 0;
 }
@@ -3554,7 +3533,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup *parent;
-	int kmemcg_id;
 
 	if (cgroup_memory_nokmem)
 		return;
@@ -3567,16 +3545,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	memcg_reparent_objcgs(memcg, parent);
-
-	/*
-	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
-	 * Cache it to @kmemcg_id.
-	 */
-	kmemcg_id = memcg->kmemcg_id;
-
 	memcg_reparent_list_lrus(memcg, parent);
-
-	ida_free(&memcg_cache_ida, kmemcg_id);
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
@@ -5042,7 +5011,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		return ERR_PTR(error);
 
 	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
+				 MEM_CGROUP_ID_MIN, MEM_CGROUP_ID_MAX,
 				 GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
@@ -5070,7 +5039,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	spin_lock_init(&memcg->event_list_lock);
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
-	memcg->kmemcg_id = -1;
+	memcg->kmemcg_id = MEM_CGROUP_KMEM_ID_MIN;
 	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
-- 
2.11.0

