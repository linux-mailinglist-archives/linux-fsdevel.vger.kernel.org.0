Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57D537A4FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 12:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhEKKwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 06:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhEKKwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 06:52:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC9CC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:51:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m190so15525988pga.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=570qZ6BW+Bw5Veu1Tn32KJSDsrgLb0WocPAS7l9UKjo=;
        b=cXkuqPg26sg7zCH8Zlm/L88hhl+2M29S3NHF0UZeW5xgiIgj31m3I8ZyPpcszdrz7c
         15RY5Bsx8gNF/FQ4bejRpw932IgFMX1JZRbJ5gE7Y8QdG+g18lfChibOAzcm65JIaIrw
         86LR4GShsjV0SzJt73Sbhs2DwfFfqzUOJufF5icNTSDzL+3bKpmAUn0IrL+P0ZmGNZyR
         6vGPdtR0+qN8zCBTgpJCOEdgIxd8ZYNFQ/wlCXv14MwQj3gTzslwBhxFrUi6Vuqx6mr7
         8nE9r+O6raKN2Gprocb5v5qTnkk9+rRfWZKcBZB4W6l7Eae5w5CMcEdB8xg+9+J7GhM6
         yYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=570qZ6BW+Bw5Veu1Tn32KJSDsrgLb0WocPAS7l9UKjo=;
        b=rC4RE0FH/UecnDf0y74T0k/GpsjEoJtLZQFL6f7iMat/wJ61Ef2ey6mLE/s3mEnWdO
         24oaeY9nyclEkhpP+aBwhorJVjRrQ9yXdKIzxwTHyFRbjiOK0CJkB3ZWtAFUVXXquD2E
         s4YGq77jkQO0XHlaRNs6a7whS0WR8xFdybKp5OUOFoBJ9FzNNluO0EXo1I1bSHiE38/V
         oG+nZke4Pu/Zip8sVIW1UHgcUZKStjoUmddZJcfYRlbASrZSlwJ0AmMhKip0sVIV7s9q
         xdOlK+KpcOT1NyU1pqejIVgPEcCNWS2tyqoJ+vEuDPR6EDHpYcCGOhPtG2Ool5q7WN2o
         txHQ==
X-Gm-Message-State: AOAM533c57EOOqCPTRWXdKjb/OdWHgtP84Yxh9gA/ZuA37B3f5v76HHO
        JDiO1Wfb9I5DbKoFEBehk4ksNA==
X-Google-Smtp-Source: ABdhPJx7H8aic1vSgbaFmAPVPSrhFZQeZuy+H/+JFDYMlJNa7Yea+LAnclzj4B/AdQ6QtWZrhZyQZw==
X-Received: by 2002:aa7:8a87:0:b029:27d:a1e:bc71 with SMTP id a7-20020aa78a870000b029027d0a1ebc71mr12280361pfc.14.1620730304649;
        Tue, 11 May 2021 03:51:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:51:44 -0700 (PDT)
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
Subject: [PATCH 04/17] mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
Date:   Tue, 11 May 2021 18:46:34 +0800
Message-Id: <20210511104647.604-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move memcg_online_kmem() to mem_cgroup_css_online() to simplify the
code. In this case, we can remove memcg_free_kmem().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e161a319982a..0d1c09873bad 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3460,6 +3460,9 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (cgroup_memory_nokmem)
 		return 0;
 
+	if (mem_cgroup_is_root(memcg))
+		return 0;
+
 	BUG_ON(memcg->kmemcg_id >= 0);
 
 	memcg_id = memcg_alloc_cache_id();
@@ -3486,6 +3489,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	struct mem_cgroup *parent;
 	int kmemcg_id;
 
+	if (mem_cgroup_is_root(memcg))
+		return;
+
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
 		parent = root_mem_cgroup;
@@ -3499,14 +3505,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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
@@ -3516,9 +3514,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 }
-static void memcg_free_kmem(struct mem_cgroup *memcg)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
@@ -5047,7 +5042,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
 	struct mem_cgroup *memcg, *old_memcg;
-	long error = -ENOMEM;
 
 	old_memcg = set_active_memcg(parent);
 	memcg = mem_cgroup_alloc();
@@ -5077,38 +5071,36 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
 	css_get(css);
 	return 0;
+offline_kmem:
+	memcg_offline_kmem(memcg);
+remove_id:
+	mem_cgroup_id_remove(memcg);
+	return -ENOMEM;
 }
 
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
@@ -5166,7 +5158,6 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
-	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
 
-- 
2.11.0

