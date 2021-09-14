Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7540A785
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbhINHfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbhINHey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:34:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D8EC0613DF
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso1441570pji.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rI7PKACqM/Kwcdk+6AVk4DQ16MheMLZPlQjMEC5n7yk=;
        b=EdRD6sHziaUM8ZWwxrmJqt7nsJvDxYQmRneqGGkNe4BMlgV93fTvY2OehhPz1IFX1k
         YZkwM/14bd/X2mxRpcHaMtYegAn4Xp3oZu5WoP1rYKkupk8RUyF4chweIn+rbkx6PI0T
         2tzbfNdxm3YDWMnbwTb3lzapiSC+RYDp1PRGKF9ZVYYwMk+tIfuidHTsOb58Nbx8ATZP
         amG6TR448PN8cJaY2YytWw9yP5YHUl3aLII/2hVQ0/UmP9eiyVwl+G4TVNV/cpizgA8N
         EEkC7jtYQmemaObOfbSkvNmmSWli8j1ASAjaJe4Ey7y3CNI7wdSRaBChZ8WUoNUxdEYF
         jG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rI7PKACqM/Kwcdk+6AVk4DQ16MheMLZPlQjMEC5n7yk=;
        b=grVWIpjfwgG9ZWK7nNwTdP/9w+XiAioNbRnOpHfH6EVTi0supAMyhajKb7ec4ysBKI
         +MnZjjdGzlI5R4vVMxCakwG336iVUotfltKGkGEiApGDyVth6khnMO9neMV941RQzSKF
         WGa5q835hDx0joQLqNNrNMCWZ4Vx0jlQiJQQRxr2FN6GuR9ctF0AP0r4TyfLU0JL2F99
         6oP9YJjgHL+nFWcxiSG1kHJI1xR5uxkSfw9FNg9LBQ17fEEa3LsTH7tHa1oxBMsZpnrX
         2LlpWMKMfhErONX8xnML3smGOPzVBxJFy2HHkXsw+XkS/Db6VADdMQrdpBDPCIhT+7Ls
         0PWg==
X-Gm-Message-State: AOAM530YZ0sMsNeVMxB8ZW39W1SPmgsvFYkQQQIoGMzO4gEWMJM/cBbf
        t0e+kuG9PzHqi/0nlIvpYOiauQ==
X-Google-Smtp-Source: ABdhPJxU1w9S8RjHsj9t6dgNar9sO/uqvNbkUMk51yUE+y0Vgte07Q6BLLNmpDqU438/KSBl1gIduw==
X-Received: by 2002:a17:90b:3890:: with SMTP id mu16mr575506pjb.78.1631604817392;
        Tue, 14 Sep 2021 00:33:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.33.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:33:36 -0700 (PDT)
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
Subject: [PATCH v3 06/76] mm: list_lru: only add memcg-aware lrus to the global lru list
Date:   Tue, 14 Sep 2021 15:28:28 +0800
Message-Id: <20210914072938.6440-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The non-memcg-aware lru is always skiped when traversing the global lru
list, which is not efficient. We can only add the memcg-aware lru to the
global lru list instead to make traversing more efficient.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 6b2f3cbe5f67..39828632631c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -15,18 +15,29 @@
 #include "slab.h"
 
 #ifdef CONFIG_MEMCG_KMEM
-static LIST_HEAD(list_lrus);
+static LIST_HEAD(memcg_list_lrus);
 static DEFINE_MUTEX(list_lrus_mutex);
 
+static inline bool list_lru_memcg_aware(struct list_lru *lru)
+{
+	return lru->memcg_aware;
+}
+
 static void list_lru_register(struct list_lru *lru)
 {
+	if (!list_lru_memcg_aware(lru))
+		return;
+
 	mutex_lock(&list_lrus_mutex);
-	list_add(&lru->list, &list_lrus);
+	list_add(&lru->list, &memcg_list_lrus);
 	mutex_unlock(&list_lrus_mutex);
 }
 
 static void list_lru_unregister(struct list_lru *lru)
 {
+	if (!list_lru_memcg_aware(lru))
+		return;
+
 	mutex_lock(&list_lrus_mutex);
 	list_del(&lru->list);
 	mutex_unlock(&list_lrus_mutex);
@@ -37,11 +48,6 @@ static int lru_shrinker_id(struct list_lru *lru)
 	return lru->shrinker_id;
 }
 
-static inline bool list_lru_memcg_aware(struct list_lru *lru)
-{
-	return lru->memcg_aware;
-}
-
 static inline struct list_lru_one *
 list_lru_from_memcg_idx(struct list_lru_node *nlru, int idx)
 {
@@ -458,9 +464,6 @@ static int memcg_update_list_lru(struct list_lru *lru,
 {
 	int i;
 
-	if (!list_lru_memcg_aware(lru))
-		return 0;
-
 	for_each_node(i) {
 		if (memcg_update_list_lru_node(&lru->node[i],
 					       old_size, new_size))
@@ -483,9 +486,6 @@ static void memcg_cancel_update_list_lru(struct list_lru *lru,
 {
 	int i;
 
-	if (!list_lru_memcg_aware(lru))
-		return;
-
 	for_each_node(i)
 		memcg_cancel_update_list_lru_node(&lru->node[i],
 						  old_size, new_size);
@@ -498,7 +498,7 @@ int memcg_update_all_list_lrus(int new_size)
 	int old_size = memcg_nr_cache_ids;
 
 	mutex_lock(&list_lrus_mutex);
-	list_for_each_entry(lru, &list_lrus, list) {
+	list_for_each_entry(lru, &memcg_list_lrus, list) {
 		ret = memcg_update_list_lru(lru, old_size, new_size);
 		if (ret)
 			goto fail;
@@ -507,7 +507,7 @@ int memcg_update_all_list_lrus(int new_size)
 	mutex_unlock(&list_lrus_mutex);
 	return ret;
 fail:
-	list_for_each_entry_continue_reverse(lru, &list_lrus, list)
+	list_for_each_entry_continue_reverse(lru, &memcg_list_lrus, list)
 		memcg_cancel_update_list_lru(lru, old_size, new_size);
 	goto out;
 }
@@ -544,9 +544,6 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 {
 	int i;
 
-	if (!list_lru_memcg_aware(lru))
-		return;
-
 	for_each_node(i)
 		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
@@ -556,7 +553,7 @@ void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
 	struct list_lru *lru;
 
 	mutex_lock(&list_lrus_mutex);
-	list_for_each_entry(lru, &list_lrus, list)
+	list_for_each_entry(lru, &memcg_list_lrus, list)
 		memcg_drain_list_lru(lru, src_idx, dst_memcg);
 	mutex_unlock(&list_lrus_mutex);
 }
-- 
2.11.0

