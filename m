Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4334C6C56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 13:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiB1MZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 07:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiB1MZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:25:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C550369CEA
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:24:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m22so11021754pja.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dade4m+tPfltv+YBL5BFr4S8sLSocJ6SVbceY12YVP4=;
        b=f1g/kvJBjfN30xCsylnaAygl8oPPzFBGUC8L8YafA7UAzTnfBH0+sZQQBOK++jomNI
         Tceo+BhZpE4oUeGWcQO1j530JhBX7s+U0HKG1ZQl1Ld42RMI15jdS7wAbaElmylLb3/s
         u0ZEqF7T4koLmlohM2LsJTLPYEvtbIFCu8jH9LMz7VdecFs0W1qDuzPAxiZnurzDfJ0y
         lVwxikx3PqhBzItEXWc3X8ZejterQIMtsBIOy/5tLh+ZbdoB9trsE+k62QIRsKeXqvS8
         B+ycUjdT4PdUlLqy0fas3es6mEtLdxZTbF6GKz8nDt4WOMqSDPGfzzHihHOx2vsOHvuW
         Hpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dade4m+tPfltv+YBL5BFr4S8sLSocJ6SVbceY12YVP4=;
        b=hkac/5jyO0oUnxaQUxY1/D2dkgW8M5+27jHxz8iTvB3A2V3mMs7pUjDoey3ckhm81X
         3SdR7tudKM+jPasl4rTlpLYd8tqqT+hqxeulX1T0B4mLZkRfnwzeBDur88P04KUwMMNn
         H+cRLO4VEM0jvrqGjA7iUx240QSC/U51AO1aZ3jH3oSE6UL70HhcPV09z3HHR98sFgN5
         qa5jBO/3g0st7nENdC6rR3wXO7i8AIackujdL2CM0nP6ac1umSeQCt8tzuIa7C+2snIn
         G/quw2jS3w8CZr8Ld8wzvWtzJkW5iIBB2pjynk/z5tq4SyjKMCS0bkIOQ+ctCNB2Zayo
         /fcA==
X-Gm-Message-State: AOAM532vbinSfRrcrtMnCdVKskt6LYkGy45esLlrqKtPKPYdT0v3c/R2
        DL7E9ywO1Liz45l+DSP0J3ovug==
X-Google-Smtp-Source: ABdhPJzClMB8yg4ny/EoRfVDOp+9+WQf3gvaUjAwm4C20/JUl5vRwJA/JWNNEr5DbzV/BI2AAherTg==
X-Received: by 2002:a17:90a:a385:b0:1b9:cfb8:de07 with SMTP id x5-20020a17090aa38500b001b9cfb8de07mr16121962pjp.162.1646051049016;
        Mon, 28 Feb 2022 04:24:09 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:24:08 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 13/16] mm: memcontrol: reuse memory cgroup ID for kmem ID
Date:   Mon, 28 Feb 2022 20:21:23 +0800
Message-Id: <20220228122126.37293-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two idrs being used by memory cgroup, one is for kmem ID,
another is for memory cgroup ID. The maximum ID of both is 64Ki.
Both of them can limit the total number of memory cgroups. Actually,
we can reuse memory cgroup ID for kmem ID to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 361ac289d8e9..809dfa4b2abc 100644
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
@@ -3543,7 +3526,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg;
-	int memcg_id;
 
 	if (cgroup_memory_nokmem)
 		return 0;
@@ -3551,22 +3533,16 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
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
+	memcg->kmemcg_id = memcg->id.id;
 
 	return 0;
 }
@@ -3574,7 +3550,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup *parent;
-	int kmemcg_id;
 
 	if (cgroup_memory_nokmem)
 		return;
@@ -3589,20 +3564,12 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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
-- 
2.11.0

