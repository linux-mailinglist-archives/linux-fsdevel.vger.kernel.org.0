Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A1F47A670
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbhLTI6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhLTI6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:58:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77637C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v19so7552966plo.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMvcBVwXnNFX2TRf33ZNs6lKAej6Dsa2gPzCzMJOYCg=;
        b=g8WXPdWnN0qRnYI+vDliaVn5biyV21O8OhvDzPWXyPHSbR+iL6Bh65Fo+eiMhRISdj
         K+xGefT/f2xFvTJfYqA/BM+J03Cj8rmdViKVf76lrJrXs5bYixre2h7mh9yUEyOVwbGP
         VXJW+vqH0L7KLSLuNoY9lZnbUWzeIFagV7xnXrsczlCqtB9Rj+MIotGtbgE0QvR12zjS
         rM5cJsSJ2vesMsXUBBTHvPIaBq0AN5kt4sFNQXobgR6lYI7+uoaPrf5tJpzXybpMpRRh
         xpYy65flBjlzH652NTxy0tp7dyusBTNmONgSh5WzNN3bJ+mf3WkZDFBc/zCZfI4/ZbvP
         yc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMvcBVwXnNFX2TRf33ZNs6lKAej6Dsa2gPzCzMJOYCg=;
        b=pGKi5sa4j2NUyglTmR2IpmP43KL1DgUesqBPZWrw4C100nwYk8qJm2fkSbVo4gpuSu
         Hp0honTE06f+0pO4DIyYS/tOqjbDdKhG9ntb+tTWYC1F3iCzJ/axN/9krbNrjGW3EdGS
         bPQOnWwfvEfM9R7L3+5lpsdxBbAX0NZ0SbKdvmsTeavOTOlPMnkyn0ALssBkVHZAVC5U
         dNL4qj7asN4jGqJ9QA6R52QZ62oAR5G+1T9sSgMUiqk7NCH5VS6T7J+SQjn0z5XXPeko
         r620bXeVgLaq2v3oBTWJuv662FrWtPrPI2qlVP7u5F6/gB6earSG1y3/Tq4CeOUV/AoM
         5f5Q==
X-Gm-Message-State: AOAM530VBldN0s/Kj+fRx+3l2EqiKrxbs+Uk6w3j4GP3ktC0mgigGgrk
        VoWLp7J1Pbd+4Nh5dPoAh93XqA==
X-Google-Smtp-Source: ABdhPJy7kSK/AMCHCx5fZ5LpzmHWwGlHbQWWLpAP0yPvc2IX+lwQp+aENkkzbM/BgcYMy839TxPHgw==
X-Received: by 2002:a17:90b:388b:: with SMTP id mu11mr6387529pjb.21.1639990733033;
        Mon, 20 Dec 2021 00:58:53 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:58:52 -0800 (PST)
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
Subject: [PATCH v5 09/16] mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
Date:   Mon, 20 Dec 2021 16:56:42 +0800
Message-Id: <20211220085649.8196-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It will simplify the code if moving memcg_online_kmem() to
mem_cgroup_css_online() and do not need to set ->kmemcg_id
to -1 to indicate the memcg is offline. In the next patch,
->kmemcg_id will be used to sync list lru reparenting which
requires not to change ->kmemcg_id.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d505b43d5f3b..ec7a62f39326 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3604,7 +3604,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (cgroup_memory_nokmem)
 		return 0;
 
-	BUG_ON(memcg->kmemcg_id >= 0);
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		return 0;
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3630,7 +3631,10 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	struct mem_cgroup *parent;
 	int kmemcg_id;
 
-	if (memcg->kmemcg_id == -1)
+	if (cgroup_memory_nokmem)
+		return;
+
+	if (unlikely(mem_cgroup_is_root(memcg)))
 		return;
 
 	parent = parent_mem_cgroup(memcg);
@@ -3640,7 +3644,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	kmemcg_id = memcg->kmemcg_id;
-	BUG_ON(kmemcg_id < 0);
 
 	/*
 	 * After we have finished memcg_reparent_objcgs(), all list_lrus
@@ -3651,7 +3654,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
-	memcg->kmemcg_id = -1;
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
@@ -5159,7 +5161,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
 	struct mem_cgroup *memcg, *old_memcg;
-	long error = -ENOMEM;
 
 	old_memcg = set_active_memcg(parent);
 	memcg = mem_cgroup_alloc();
@@ -5188,34 +5189,26 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
@@ -5225,6 +5218,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -5282,9 +5280,6 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
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

