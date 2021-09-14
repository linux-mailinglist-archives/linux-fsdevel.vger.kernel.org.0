Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0AD40A780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbhINHfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbhINHen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:34:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AAAC0613E1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso1441174pji.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9dWAQT9MnFNTmopLa7uI8hnCzKur7mFh/tgOEsG0ak=;
        b=tvtI2oh7KRqjHCGIC33vHZ0eTeCepMMOZzXUpOe8B0d52bMkBme0jt/iAIH+WSxPrU
         bmQxXDU5jsRQtJpLnGyCh7yW3S9qM2hCZqV3O4vqTbI16BR8EagQaj5prtkzuF1OLCgQ
         rSpGZHDgWCEWqYpkz+G07cHTCU35NTg5bhnq73sgywUxy1uC+y4xFqljbevKplx0vCIF
         8ewaaJ6a04UMwXac4zqf+HlKhbM7u5HD+IrzirICPUWi3cVzIFEd1tQcvxmSw3M9EAPW
         qB4HE29noctkhSzKmIGAKTzrJn/qPJIViF3DVha1y4XA0qZ5Cx2vgipV5a+eR5V6n/N8
         WzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9dWAQT9MnFNTmopLa7uI8hnCzKur7mFh/tgOEsG0ak=;
        b=RkGPWWNkz60dC5VkIlMyGgIK95JQjn9DV2RqEdMGEHjZLSwd+SafSIB2mJ67iNg9SB
         32Y9XdbiSOS++q6Yo9n2xPvq8xfgqz+6TsOxD4GYOX7qO4EMuXeeDrWiCZe8WxuB3vma
         ib4e8W12DoRoId0BEaJL5ANUgwxgxhiHsN6bflZ7fJr3L2N96xw1PWSBCCr1bJeP+Klq
         gd4h19i2QMwC4qI+2NlUo1Xv7rbaxxbURPVvtveQZpN6bu3GYwoc6VCvO+m/aNs+DgHz
         QaHj9ZJATJWTVdACdupFnuD+Pe0vcYJIgpgf8J18uO9iC4hyppcneMGFy47mHTZF6adw
         9huA==
X-Gm-Message-State: AOAM531RGoBiOwKLhEX3PPQTUrr1XbJxC1WMd7y2aI/oNi9TyuuDLDQn
        BlvfJaQs2dO2ppnowbflbw+FA4gF05vmIA==
X-Google-Smtp-Source: ABdhPJw9AsHD8axsXPLJrDHn4xQlPyJpmiPLXcwCJC6VSXKd8nsAkTIpKAaLCtfS9+xfnNlqvB4zfg==
X-Received: by 2002:a17:90b:2243:: with SMTP id hk3mr507259pjb.203.1631604803701;
        Tue, 14 Sep 2021 00:33:23 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:23 -0700 (PDT)
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
Subject: [PATCH v3 04/76] mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
Date:   Tue, 14 Sep 2021 15:28:26 +0800
Message-Id: <20210914072938.6440-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It will simplify code if moving work of making kmem online to the place
where making memcg online. It is unnecessary to set ->kmemcg_id when the
kmem is offline, memcg_free_kmem() can go away as well.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6844d8b511d8..a85b52968666 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3610,7 +3610,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (cgroup_memory_nokmem)
 		return 0;
 
-	BUG_ON(memcg->kmemcg_id >= 0);
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		return 0;
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3639,6 +3640,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (cgroup_memory_nokmem)
 		return;
 
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		return;
+
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
 		parent = root_mem_cgroup;
@@ -3646,20 +3650,11 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	kmemcg_id = memcg->kmemcg_id;
-	BUG_ON(kmemcg_id < 0);
 
 	/* memcg_reparent_objcgs() must be called before this. */
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
-	memcg->kmemcg_id = -1;
-}
-
-static void memcg_free_kmem(struct mem_cgroup *memcg)
-{
-	/* css_alloc() failed, offlining didn't happen */
-	if (unlikely(memcg->kmemcg_id != -1))
-		memcg_offline_kmem(memcg);
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
@@ -3669,9 +3664,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 }
-static void memcg_free_kmem(struct mem_cgroup *memcg)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
@@ -5183,7 +5175,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
 	struct mem_cgroup *memcg, *old_memcg;
-	long error = -ENOMEM;
 
 	old_memcg = set_active_memcg(parent);
 	memcg = mem_cgroup_alloc();
@@ -5213,33 +5204,26 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	}
 
 	/* The following stuff does not apply to the root */
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
@@ -5249,6 +5233,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -5306,7 +5295,6 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
-	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
 
-- 
2.11.0

