Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4E39278C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhE0G2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbhE0G1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:27:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF249C061346
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so1756369pjg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pnkdwc8KsT1GR9l5lzjPujWtU4Fy6ow0RMQ7lQzc3wo=;
        b=gLcNOB+p56/1OyW0KDnFNXJnhY1wq5sR/LUtKbPM+6AIV1MAhLgP0CbU0JWSE7RZS8
         8trQWtZPBkUOu5Z9rExHocprXBJSQptaR17TjUhihZR/N8TeKodMIdEH6osF99IgiNSX
         sWYYGQPW8HyF/53eTiHoJC1r9YMik7tIh5LmQgUhgbOkJ24ucutk+CyX5oaA6bOAxcxK
         2IYhWdHcInlaymo6ez7CvCJCsxLJQi51k2sDd7pf+57wHZ9QvNv9x1hos9L7X8sZzXKG
         Ugji1MktpwaEqvl9nredGmJiv9OFyYzJlQW/gs8ySASY0o3oE6Y4pYznYfg1fBXciJJG
         pGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pnkdwc8KsT1GR9l5lzjPujWtU4Fy6ow0RMQ7lQzc3wo=;
        b=e2AfgI2g3T1KZ5dQ5Jee5b8oC207vMk5ZZ9bGCjlYui9Ixw4055mdR9cU5bOXGGc/+
         ABNGyVGPc5ZdxrinLNrSu8iOT9tTWlvMcYMWbonTWDKnt4NSM4UZxPAFq8ZtO8qnUbtL
         3T4Hu33RyPSkgb+8AIgYjIPm6CpX3XMzMS8VTyzBdiSSxSILCZBoIGU0KRdHIIiKB0kS
         kcMIiaGIMOi0q69SxIrm6xahsdYlGbYjSNcFtfKniwVWo6CcK2zfCJqupA/PtOpUoHTn
         B4OOYUUbxKaCM6HFa8s4lJHjRle24H/TFR3e/+y56mr8A86YGLbMyk7MDXgCyvDMUmIO
         UoAQ==
X-Gm-Message-State: AOAM5305pzuShJAxez+gMvl/HOxG7q/D6sMvYHZXHIsgBEfiu/5oumQQ
        iALR3+ajzOYo7wA1lZoz+yQnFA==
X-Google-Smtp-Source: ABdhPJxiIU2q4U//tQXOFSyBTMchzcY7zKsgW3oycyLxDKvIr+hJxeAKcfNys0Oh43G5MEPm7F+WHw==
X-Received: by 2002:a17:90a:eb0f:: with SMTP id j15mr2009156pjz.149.1622096774257;
        Wed, 26 May 2021 23:26:14 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.26.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:26:13 -0700 (PDT)
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
Subject: [PATCH v2 16/21] mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus
Date:   Thu, 27 May 2021 14:21:43 +0800
Message-Id: <20210527062148.9361-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
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
 include/linux/list_lru.h |  3 +--
 mm/list_lru.c            | 25 ++++++++++++-------------
 mm/memcontrol.c          |  4 ++--
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 00c15dc1ede3..60970ea48c29 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -76,8 +76,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
-void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
-			       struct mem_cgroup *dst_memcg);
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
  * list_lru_add: add an element to the lru list's tail
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 43eadb0834e1..dec116a12629 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -462,8 +462,8 @@ int memcg_update_all_list_lrus(int new_size)
 	return ret;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
-				      int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
+					 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
@@ -491,23 +491,22 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
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
 
-void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
-			       struct mem_cgroup *dst_memcg)
+void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
 	struct cgroup_subsys_state *css;
 	struct list_lru *lru;
-	int src_idx = src_memcg->kmemcg_id;
+	int src_idx = memcg->kmemcg_id;
 
 	/*
 	 * Change kmemcg_id of this cgroup and all its descendants to the
@@ -522,17 +521,17 @@ void memcg_drain_all_list_lrus(struct mem_cgroup *src_memcg,
 	 * memcg_list_lru_free().
 	 */
 	rcu_read_lock();
-	css_for_each_descendant_pre(css, &src_memcg->css) {
-		struct mem_cgroup *memcg;
+	css_for_each_descendant_pre(css, &memcg->css) {
+		struct mem_cgroup *child;
 
-		memcg = mem_cgroup_from_css(css);
-		memcg->kmemcg_id = dst_memcg->kmemcg_id;
+		child = mem_cgroup_from_css(css);
+		child->kmemcg_id = parent->kmemcg_id;
 	}
 	rcu_read_unlock();
 
 	mutex_lock(&list_lrus_mutex);
 	list_for_each_entry(lru, &list_lrus, list)
-		memcg_drain_list_lru(lru, src_idx, dst_memcg);
+		memcg_reparent_list_lru(lru, src_idx, parent);
 	mutex_unlock(&list_lrus_mutex);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1994513a33d4..205bf710486c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3655,12 +3655,12 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_objcgs(memcg, parent);
 
 	/*
-	 * memcg_drain_all_list_lrus() can change memcg->kmemcg_id.
+	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
 	 * Cache it to @kmemcg_id.
 	 */
 	kmemcg_id = memcg->kmemcg_id;
 
-	memcg_drain_all_list_lrus(memcg, parent);
+	memcg_reparent_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
 }
-- 
2.11.0

