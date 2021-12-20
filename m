Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA07B47A689
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 10:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhLTJAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 04:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbhLTI7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:59:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925EFC061748
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:59:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso10543396pjc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yE80mqiok0lBzQsvKCygl5SYuh3BGa/YlTAclAjawz8=;
        b=5QnugMkys/poSZA1IKOgp4SijtJnmKugtOMzsBN9jYA+6Z0EpInS6OEOwjGpZE9lm6
         Cd3DzkWRKCqOuKYxI7ctrrljdBKxyWZTzRrvB8lXiPPb+fF9vcLMS1hGuUC8LHccbdro
         7zgZpkH2DAeWVENROfQjmtPTQ1HWwo0PQ0gBkIiidfqFmhCldj5HNSKTEG8VpkEz282a
         j9Amvh0kck1RfVZmMZKMuEDghBgFc/GTQkYI8jhoQSXb8D5hO2/ioZ+oCcZJ5mahJdP+
         0S9pDuxt/0SVZSQVPu98eZ/laGtc7YHS+GnfW3n2s1e5eN9HlzEcLEDiz7OE9BdlFPWP
         mEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yE80mqiok0lBzQsvKCygl5SYuh3BGa/YlTAclAjawz8=;
        b=o0uVQM0uNevwmGzt8PuqghMfvjxph2S3Fw68meZTCbcOs31CKH+ZRzWgQWmYYEWIhB
         iAjmJomVVmSE1CJLIp7rnFRFiMEIZ9hMF6VBllEsdPz0qLXECIe0ChR9n5nEDGmOK7TV
         qWfKNUMCIH0e6P0vnTS9if0hcXQmYZGpUewPwjvyU+4xdJ+fuON8lCAhhhgPSiqIBDwn
         czmTmHj7sRXpNkfBF+L83QajSlAY0ZZjNPpGAb7rBT8iTDpxbfB9eeajIfvAY8Cz1SLV
         Uvt24mSL/scfzNim5eM/m5I9iKQLZt59n1oTIyTrgipodFJh5/bYopKVQ7vFjhYDKi+z
         8Kyw==
X-Gm-Message-State: AOAM531asV6tC5Iy+Q8jALbQIM7vdcXRpj20kCiH0zQgJY2HnNKp47Cn
        aG76UQMgJOXImqS2SQAxVSmzg3aOcDpSJA==
X-Google-Smtp-Source: ABdhPJxfH0Ud5oQiLWFf+MqrfeoLK9vxT10TK2i7+PWqU8pkkWY7mGtNkvu1INqXv62BdWiuWM9qYw==
X-Received: by 2002:a17:90a:9907:: with SMTP id b7mr27395923pjp.137.1639990775170;
        Mon, 20 Dec 2021 00:59:35 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:59:34 -0800 (PST)
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
Subject: [PATCH v5 13/16] mm: memcontrol: reuse memory cgroup ID for kmem ID
Date:   Mon, 20 Dec 2021 16:56:46 +0800
Message-Id: <20211220085649.8196-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
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
 mm/memcontrol.c            | 46 ++++++++--------------------------------------
 2 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3fc437162add..7b472f805d77 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -56,6 +56,7 @@ struct mem_cgroup_reclaim_cookie {
 #ifdef CONFIG_MEMCG
 
 #define MEM_CGROUP_ID_SHIFT	16
+#define MEM_CGROUP_ID_MIN	1
 #define MEM_CGROUP_ID_MAX	USHRT_MAX
 
 struct mem_cgroup_id {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 28d6d2564f9d..04f75055f518 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -348,23 +348,6 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
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
@@ -3528,10 +3511,12 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
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
@@ -3539,22 +3524,16 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
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
@@ -3562,7 +3541,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup *parent;
-	int kmemcg_id;
 
 	if (cgroup_memory_nokmem)
 		return;
@@ -3577,20 +3555,12 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	/*
-	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
-	 * Cache it to local @kmemcg_id.
-	 */
-	kmemcg_id = memcg->kmemcg_id;
-
-	/*
 	 * After we have finished memcg_reparent_objcgs(), all list_lrus
 	 * corresponding to this cgroup are guaranteed to remain empty.
 	 * The ordering is imposed by list_lru_node->lock taken by
 	 * memcg_reparent_list_lrus().
 	 */
 	memcg_reparent_list_lrus(memcg, parent);
-
-	ida_free(&memcg_cache_ida, kmemcg_id);
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
@@ -5043,7 +5013,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		return ERR_PTR(error);
 
 	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
+				 MEM_CGROUP_ID_MIN, MEM_CGROUP_ID_MAX,
 				 GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
@@ -5071,7 +5041,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
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

