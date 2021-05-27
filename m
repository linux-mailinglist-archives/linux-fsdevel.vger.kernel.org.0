Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03360392760
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhE0G0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhE0G0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:26:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAAFC061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:24:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ot16so2147614pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69t5JvkMUpa4S3zHMzIPphToxILDMFyOxSV05k21NRo=;
        b=HKrLitcBnnklOOWAEzdjePdIbJuUgcw2SjWSInye4lqApH/rU0YcYtdFyq/JhyyFoG
         Su+eQeNmI0dL5rm6AjU4TNwh7Cg/2BG2fW/54JrJNPMdw0DSbUCF98FyR6DMchWC742O
         YEbNH8cBvRolyAvZ7fPJm3xEFzSKD6S7nZZ4chf7nnrx5f7Oj4yoKFFVxp2noXxKTiQr
         04fVYRoe8f/H88BRNeu84IxYynvj3YflDbnQIR7hks2nJU1fXSZCf7AuwIkfagDooa/9
         7JXKTpGfB0m4oKQFs/dL4v6rMwUMkavZlMi5+jXC+PVmOxDWraZ5CiqdbxoSm2TH5bgw
         YSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69t5JvkMUpa4S3zHMzIPphToxILDMFyOxSV05k21NRo=;
        b=mOEkg4L1n7bZPWj9AyamvJ9NSlPmx4/LKZgWEBeTd2k1OJlki3XgsCS1HtU4nNfh1E
         dgUggghcBTMCBAh9fJfKjp4DtmAg+d4zjSSEoqrC8l+9SbP5L/3G+G4F7fuvvT7bvnBp
         Y325C9wQAhUgUL9u4hM8gXoNR/8QMN77MS+oQvaqKDbmd4070g93RJBDbfYwjwPC48qn
         FqKBmFNWeMrxyRjyFccX6IZVnPHvtvkDWNPdhnFZ9ViOtohsHe5mEZ2VMVZWEmt4RaG+
         m/EXCxGmY7eQsAjnAozVGmWaFXri5FpwiYan4HBdoEWHc/e/c/RqP3nQBHsX6nGvQ+wK
         x1Ww==
X-Gm-Message-State: AOAM533t6iES3zd3pUspMnxAuR4ubcXW+z+mMjgoVoi8dx6HKkjtY177
        3MPKt2G7G5+FxmWDgHsTDhs7pA==
X-Google-Smtp-Source: ABdhPJxmvTKJ6I8q166ESGz1b/+UAvPTvctOrfMJF1LBcEehrkaOaWTcdudYGcw9acZPesyY84UDFw==
X-Received: by 2002:a17:902:db0f:b029:f3:e5f4:87f1 with SMTP id m15-20020a170902db0fb02900f3e5f487f1mr1856086plx.26.1622096683363;
        Wed, 26 May 2021 23:24:43 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.24.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:24:43 -0700 (PDT)
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
Subject: [PATCH v2 04/21] mm: memcontrol: do it in mem_cgroup_css_online to make the kmem online
Date:   Thu, 27 May 2021 14:21:31 +0800
Message-Id: <20210527062148.9361-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we do it in the mem_cgroup_css_online() to make the kmem online,
we do not need to set ->kmemcg_id when the kmem is offline. And we
also can remove memcg_free_kmem(). So just do that to simplify the
code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 23a9fc8dc143..377ec9847179 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3629,7 +3629,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (cgroup_memory_nokmem)
 		return 0;
 
-	BUG_ON(memcg->kmemcg_id >= 0);
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		return 0;
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3658,6 +3659,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (cgroup_memory_nokmem)
 		return;
 
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		return;
+
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
 		parent = root_mem_cgroup;
@@ -3665,20 +3669,11 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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
@@ -3688,9 +3683,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 }
-static void memcg_free_kmem(struct mem_cgroup *memcg)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
@@ -5219,7 +5211,6 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
 	struct mem_cgroup *memcg, *old_memcg;
-	long error = -ENOMEM;
 
 	old_memcg = set_active_memcg(parent);
 	memcg = mem_cgroup_alloc();
@@ -5249,38 +5240,36 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
@@ -5338,7 +5327,6 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
-	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
 
-- 
2.11.0

