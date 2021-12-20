Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2153747A677
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 09:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhLTI7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 03:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhLTI7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:59:14 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE398C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:59:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so9721605pjj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 00:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/WV+PEM0qRFObJD60MTy318d/sBpYLGf9zHlu84rNE=;
        b=er0uUJ5nWVMqv44Chh4Oim+XKLcVbBY67REXI0OnktRhkl6hTPom5GlYhr5UmFfGPa
         tBXvTU8zJXaS5OfnZuviJJ1wGlRJoptfqZ4Zs0N/g/LaKnmC7u5G1o6FPsX8YttydaZu
         PEghV5FRJR4kNZJkv0Nz4B/k69higWo0E6Q8EgW77oO/qp7FwNvl0fXPyZ6IV7tZBHLM
         aSyzXbvScR/vGnlN/PbteThuVwOF5DHMt+PqB44MFoQAGDbCgdKjjEFMxACrbPf1BRXY
         ZPUgqdMFGADM3sr0FK++BaCC91SiRn1am1vwhBVQJSPnoaXM/bOuFkICrwifcm9d3ZH4
         Scpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/WV+PEM0qRFObJD60MTy318d/sBpYLGf9zHlu84rNE=;
        b=rqgQmdzLxzrV1K449nOTqE33O3AlHkV1TZRSDH0P9DTHsJXOyweWF6t/S8MR5NFnRT
         eDvQ5FEMbl5WyMiIHnT381rCZKpi8cC0YHfP9vADLguGYlB1m90msE1bnC+wtfs/gEYm
         N+/iAUEi3N9zBwkwmEUTD159ylpoyjzXGB66uTD4Qv9SX2dpCn5MHea+WqDUExggZpD4
         b39yNFon039J0LLPTEi+5fZLp3CJrHcunBZqZ5jjZsyE2+Cz5pFMQwkariQCS+RQSab8
         Lmb5zHyfhYeHaV6X2NCLr9IhYQ+GL3l4/a8s1bsMfdts6VRN35QidxG1ypzV+SsSacUq
         dIQg==
X-Gm-Message-State: AOAM532P0BTndNSfpaZYbksusNqTdb+Ecd3ia+F2RpVM7yS3eCbj7+8n
        p/3mMgn/MailM4Yiq7NGQbdxrQ==
X-Google-Smtp-Source: ABdhPJz7R7KZTGpYgr+N/1z8ytfjorVFmZnVH/SFLni/xAXuvqP7Pb61rT1y9a/NjRktSbe0C5CZgA==
X-Received: by 2002:a17:903:300c:b0:148:ac70:e0ba with SMTP id o12-20020a170903300c00b00148ac70e0bamr16078310pla.141.1639990754269;
        Mon, 20 Dec 2021 00:59:14 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m11sm18441647pfk.27.2021.12.20.00.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 00:59:13 -0800 (PST)
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
Subject: [PATCH v5 11/16] mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus
Date:   Mon, 20 Dec 2021 16:56:44 +0800
Message-Id: <20211220085649.8196-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211220085649.8196-1-songmuchun@bytedance.com>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of the memcg_drain_all_list_lrus() is list_lrus reparenting.
It is very similar to memcg_reparent_objcgs(). Rename it to
memcg_reparent_list_lrus() so that the name can more consistent with
memcg_reparent_objcgs().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/list_lru.h |  2 +-
 mm/list_lru.c            | 24 ++++++++++++------------
 mm/memcontrol.c          |  6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index c36db6dc2a65..4b00fd8cb373 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -78,7 +78,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			 gfp_t gfp);
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst);
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index fc938d8ff48f..488dacd1f8ff 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -457,8 +457,8 @@ int memcg_update_all_list_lrus(int new_size)
 	return ret;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
-				      int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
+					 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
@@ -486,22 +486,22 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	spin_unlock_irq(&nlru->lock);
 }
 
-static void memcg_drain_list_lru(struct list_lru *lru,
-				 int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru(struct list_lru *lru,
+				    int src_idx, struct mem_cgroup *dst_memcg)
 {
 	int i;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
+		memcg_reparent_list_lru_node(lru, i, src_idx, dst_memcg);
 
 	memcg_list_lru_free(lru, src_idx);
 }
 
-void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst)
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
 	struct cgroup_subsys_state *css;
 	struct list_lru *lru;
-	int src_idx = src->kmemcg_id;
+	int src_idx = memcg->kmemcg_id;
 
 	/*
 	 * Change kmemcg_id of this cgroup and all its descendants to the
@@ -517,17 +517,17 @@ void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst)
 	 * call.
 	 */
 	rcu_read_lock();
-	css_for_each_descendant_pre(css, &src->css) {
-		struct mem_cgroup *memcg;
+	css_for_each_descendant_pre(css, &memcg->css) {
+		struct mem_cgroup *child;
 
-		memcg = mem_cgroup_from_css(css);
-		memcg->kmemcg_id = dst->kmemcg_id;
+		child = mem_cgroup_from_css(css);
+		child->kmemcg_id = parent->kmemcg_id;
 	}
 	rcu_read_unlock();
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &memcg_list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst);
+		memcg_reparent_list_lru(lru, src_idx, parent);
 	mutex_unlock(&list_lrus_mutex);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 94d8f742c32e..a19b1a1c8ea9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3644,7 +3644,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	/*
-	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
 	 * Cache it to local @kmemcg_id.
 	 */
 	kmemcg_id = memcg->kmemcg_id;
@@ -3653,9 +3653,9 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	 * After we have finished memcg_reparent_objcgs(), all list_lrus
 	 * corresponding to this cgroup are guaranteed to remain empty.
 	 * The ordering is imposed by list_lru_node->lock taken by
-	 * memcg_drain_all_list_lrus().
+	 * memcg_reparent_list_lrus().
 	 */
-	memcg_drain_all_list_lrus(memcg, parent);
+	memcg_reparent_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

