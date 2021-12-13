Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940BB473274
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 17:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhLMQ4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 11:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241196AbhLMQ4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:56:08 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F5C061751
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so13845818pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdtfe1LcQo3Qu9RxCCpvyKyO2e4/06WIWZXzrRc4RLo=;
        b=cDze2dAZOSxa0rvXQ0rj9yRXAegrrUEEqhed0oeppCWkPnVhi6j/MuKPEGva/FuQhd
         UOOIPLRc4wSDbmfdIxdP7p1QN8/YojbI8s9/A+FKC9xb5x/G/Q16ICTYWRHVVgW8/VIC
         vE2b8peoAWBA3FeIKXq/vQdCNxhDvTSCiNkegbxpuRT5YSXtC7gk27XzXQ7ToGHW4d/c
         TyXG12LgvZ5WjhXcfHnI4wpJU3y5gcvJrBrSEeexfMGMfDOPCapE1xUyrQ6luP+OZaCq
         Oh4oZJbat7ALDmSMTTlWVexeRYB6AMmxqVifEORvu5bcnhXDEFzKgS8I6pzwuISwac7s
         GLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdtfe1LcQo3Qu9RxCCpvyKyO2e4/06WIWZXzrRc4RLo=;
        b=rUc/dsbJ+2DIZ190Dmesju3ffWDsabithfg37pFzT27GrE8LxxTtAO74+isitWz16S
         vWSfYJeMixEC6cvqV2GxgxOq2TYvTxBuWs7rUVDp9nh0HCdoxwL3qeZchAsqhFLAvH73
         v2iIEHvlV7DZeeBzxlHIBAXy89Ng18/9IraK6P3HJo9HIRs8BF2rrHc5KUeurJ2qNYQl
         l7/ajR6Rho+FBOiwxvTHu/4LOKUQrZhEd9Jnq36tJ8Lf84mMwdjnmE/QiKusKMV3T3Pu
         g9PwZ1ISMSMum34XZtwRn6zB8m6ZYTk02XFuEnPMzuOKek0Jvwf1KI7FWtF+i+qt0dZB
         /JIA==
X-Gm-Message-State: AOAM5313YpmpcOV/SEEAdh75cTRZBVY5BxT3loMMVbb+EMGCP2mSECZE
        hKSgDMkxmwUAX78oyX46am/fBg==
X-Google-Smtp-Source: ABdhPJx3vZN32C6bOQQc0YtUhrrg3EL/OFD/PYgy/UznQ1p6vhAieu0TD482F2XmslQUgNUI8udVSA==
X-Received: by 2002:a17:90a:5d8e:: with SMTP id t14mr45024882pji.95.1639414567507;
        Mon, 13 Dec 2021 08:56:07 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.55.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:56:07 -0800 (PST)
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
Subject: [PATCH v4 12/17] mm: list_lru: rename memcg_drain_all_list_lrus to memcg_reparent_list_lrus
Date:   Tue, 14 Dec 2021 00:53:37 +0800
Message-Id: <20211213165342.74704-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
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
index 4af820c191a7..9116e220e9b8 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -456,8 +456,8 @@ int memcg_update_all_list_lrus(int new_size)
 	return ret;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
-				      int src_idx, struct mem_cgroup *dst_memcg)
+static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
+					 int src_idx, struct mem_cgroup *dst_memcg)
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
@@ -485,22 +485,22 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
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
@@ -516,17 +516,17 @@ void memcg_drain_all_list_lrus(struct mem_cgroup *src, struct mem_cgroup *dst)
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

