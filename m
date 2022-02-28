Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B752A4C6C4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 13:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiB1MYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 07:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiB1MYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:24:16 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8F87487F
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:23:34 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c1so11206309pgk.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4weE4kqhVNNelpninfKVs0Z5lAWaMF5vJ9tpJi1vKqM=;
        b=jNIurO4J5jzzg6tw4FkyFriQIvcP76IRCFSaYIPHcK6WypzpBeQpxT2wVTd235Rx+H
         zIM3T3a8rwrhBykl8ohYk5Rc989WTu+s+jPwkike3SU1b3etv0KAPcS0b4SrXMmRau5V
         0XbYaQddQw2cwYkWhjXYHjmGO10fEHgAzCMhMqJ2gkZ3249Xgb3P6nEgYgKIL7C8Fduc
         PlmhdyUHJ1/oOtXztvv1x2qiybg82kKYTC7ZYo3Wp4hJOrsH08TwJq1UFHRkMxviVlee
         kHCyRPQBH+81w9gv77XtRh/AUjRq2gsCar9rXwYlvYrfL/BuBWxcTVZaCJTztmsk1L4F
         5z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4weE4kqhVNNelpninfKVs0Z5lAWaMF5vJ9tpJi1vKqM=;
        b=bvY1cBxPkbVOcJn8P86D7xMnVMrbyMN1BI+EmQSbeUH51l+1++P9JG/zSPnAc2bZRv
         UdbbqBC+Qji5VdZHGeTlNpvUgGRaeISUuaQEqPjabMFP9luJx9+nhqq61U3ib1YvgmmV
         TtQ/OKvrN7+9TchGXI2wHD0LRaMwOs9gVgNPBNCN8apOpe7Oqn0zOJDowuucPJ6y744r
         UjymlgBKaVClUDEgirT52QknRIAvX+sJWgYzG4G9fSEXJvSqOdk9QLbEmWDDcs1dCk3w
         6hn7W6QX7787Gz43V+G7U3vTzcOWH/OXGSe4oUIjV8jlQNyC3gU2MUKfMJ+Fh5rDRsDR
         9dig==
X-Gm-Message-State: AOAM533iKGwpdw/r5pRwc5revhY+Nik007iP4Hi1unFBsaScpzqEh1Qu
        +c/OnOxXWzOuAyCktrw/qDfVIw==
X-Google-Smtp-Source: ABdhPJy0Y3sz8zYIu7FfTE85icoaySMSdHhDkvZcfxDVS79w35TAOVMTZcKVPjThbCUvuMwVu0O9uQ==
X-Received: by 2002:a65:554e:0:b0:34d:f721:7fef with SMTP id t14-20020a65554e000000b0034df7217fefmr7749911pgr.476.1646051013796;
        Mon, 28 Feb 2022 04:23:33 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:23:33 -0800 (PST)
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
Subject: [PATCH v6 09/16] mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
Date:   Mon, 28 Feb 2022 20:21:19 +0800
Message-Id: <20220228122126.37293-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It will simplify the code if moving memcg_online_kmem() to
mem_cgroup_css_online() and do not need to set ->kmemcg_id
to -1 to indicate the memcg is offline. In the next patch,
->kmemcg_id will be used to sync list lru reparenting which
requires not to change ->kmemcg_id.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ffc5f0798de1..5bdf5184681c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3616,7 +3616,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (cgroup_memory_nokmem)
 		return 0;
 
-	BUG_ON(memcg->kmemcg_id >= 0);
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		return 0;
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3642,7 +3643,10 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	struct mem_cgroup *parent;
 	int kmemcg_id;
 
-	if (memcg->kmemcg_id == -1)
+	if (cgroup_memory_nokmem)
+		return;
+
+	if (unlikely(mem_cgroup_is_root(memcg)))
 		return;
 
 	parent = parent_mem_cgroup(memcg);
@@ -3652,7 +3656,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	kmemcg_id = memcg->kmemcg_id;
-	BUG_ON(kmemcg_id < 0);
 
 	/*
 	 * After we have finished memcg_reparent_objcgs(), all list_lrus
@@ -3663,7 +3666,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
-	memcg->kmemcg_id = -1;
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
@@ -5178,7 +5180,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
 	struct mem_cgroup *memcg, *old_memcg;
-	long error = -ENOMEM;
 
 	old_memcg = set_active_memcg(parent);
 	memcg = mem_cgroup_alloc();
@@ -5207,34 +5208,26 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return &memcg->css;
 	}
 
-	/* The following stuff does not apply to the root */
-	error = memcg_online_kmem(memcg);
-	if (error)
-		goto fail;
-
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_inc(&memcg_sockets_enabled_key);
 
 	return &memcg->css;
-fail:
-	mem_cgroup_id_remove(memcg);
-	mem_cgroup_free(memcg);
-	return ERR_PTR(error);
 }
 
 static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (memcg_online_kmem(memcg))
+		goto remove_id;
+
 	/*
 	 * A memcg must be visible for expand_shrinker_info()
 	 * by the time the maps are allocated. So, we allocate maps
 	 * here, when for_each_mem_cgroup() can't skip it.
 	 */
-	if (alloc_shrinker_info(memcg)) {
-		mem_cgroup_id_remove(memcg);
-		return -ENOMEM;
-	}
+	if (alloc_shrinker_info(memcg))
+		goto offline_kmem;
 
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
@@ -5244,6 +5237,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   2UL*HZ);
 	return 0;
+offline_kmem:
+	memcg_offline_kmem(memcg);
+remove_id:
+	mem_cgroup_id_remove(memcg);
+	return -ENOMEM;
 }
 
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
@@ -5301,9 +5299,6 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
-
-	/* Need to offline kmem if online_css() fails */
-	memcg_offline_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
 
-- 
2.11.0

