Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BDD37A505
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhEKKxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhEKKxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 06:53:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3CC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:51:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t2-20020a17090ae502b029015b0fbfbc50so909179pjy.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11A9hpa5Km9RVMW4601u7SbycLIFDxGvAvOSrlim2Xc=;
        b=yvPuzFw8N21facJrGJT4nrD88AXfMowTGYWSysddZzFx/clZ7i+LX0/i80M1CQJC7s
         hDg1wMBVRyNqoW+qSMU0KfF4kqCu3tdVj3ab7VQwAZIc0K+VgO6dmODMUDM60L51DXi+
         9YcldnlL3DtH7o5LHcBhHQcmGVMH6UvDbERiGnRtomQvVaFJEVqN/hZP/teDZ3ziC5WH
         WAFw9a80wFGLpiIUUXa8sX4iu5e0M4qf0FZDf85MS2U3v9D1Xd8y9wXYyClWDPBjcthL
         y5BwP2U8SnzmIrEeiyadG1itAlx9lLrZzT2WpzdEmAdRGrBOKlk+nPAMLvmoMlTGds3k
         WN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11A9hpa5Km9RVMW4601u7SbycLIFDxGvAvOSrlim2Xc=;
        b=RdB0Ex/EV+XToi/TqBqlEx7Yt4UH/+tVK1GDvQ1HAPjl3nplINagfr8LxoHi7xiY+h
         utTkwUpJSyeEYiJz2rBJKKwjlonsI0+LV+KaT49wcLS7fcIe7gjMm4/EW0xbSU/3bkvf
         a6+tjIU+5DrmT1G0cImLy5JJS+SPETkZTGZqugDWwoqm0G3VHFkHg2/vxk2OLoDLjnLp
         eyj285q5BA0qdIXPDRxgCYdFaX6h+C24D7pkyKJklJ61rsNYtT26o4J7KCAiIQTF8gOa
         5YHm9UPhzPw4xTIl3Ox6dBlHFZHX6C4gobKBmnW5dLZ3EJBf46zaIcxf5l96sTyWrhxg
         8HFQ==
X-Gm-Message-State: AOAM530wqMfytzZg0aGb3eNMLv/WjTXxW+usRsy4Buq7QPNy8PF4ByVf
        pgnChZsnKVUpGqTfe2RMGu2ahw==
X-Google-Smtp-Source: ABdhPJxl/y4TP7fRrZPnVbX3UHYYrhhayxnsGFGvdtwDYk3OoIIY/8ZJmdVs7gcENlBfgEL4O2dyJg==
X-Received: by 2002:a17:90a:2a84:: with SMTP id j4mr32249851pjd.42.1620730319173;
        Tue, 11 May 2021 03:51:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.51.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:51:58 -0700 (PDT)
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
Subject: [PATCH 06/17] mm: list_lru: only add the memcg aware lrus to the list
Date:   Tue, 11 May 2021 18:46:36 +0800
Message-Id: <20210511104647.604-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210511104647.604-1-songmuchun@bytedance.com>
References: <20210511104647.604-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to traverse every lru in the list_lrus in some routines, but skip
the non memcg aware lru. Actually, we can only add the memcg aware lrus to
the list. This can be efficient.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/list_lru.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index e86d4d055d3c..bed699edabe5 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -18,8 +18,16 @@
 static LIST_HEAD(list_lrus);
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
 	list_add(&lru->list, &list_lrus);
 	mutex_unlock(&list_lrus_mutex);
@@ -27,6 +35,9 @@ static void list_lru_register(struct list_lru *lru)
 
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
@@ -460,9 +466,6 @@ static int memcg_update_list_lru(struct list_lru *lru,
 {
 	int i;
 
-	if (!list_lru_memcg_aware(lru))
-		return 0;
-
 	for_each_node(i) {
 		if (memcg_update_list_lru_node(&lru->node[i],
 					       old_size, new_size))
@@ -485,9 +488,6 @@ static void memcg_cancel_update_list_lru(struct list_lru *lru,
 {
 	int i;
 
-	if (!list_lru_memcg_aware(lru))
-		return;
-
 	for_each_node(i)
 		memcg_cancel_update_list_lru_node(&lru->node[i],
 						  old_size, new_size);
@@ -546,9 +546,6 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 {
 	int i;
 
-	if (!list_lru_memcg_aware(lru))
-		return;
-
 	for_each_node(i)
 		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
-- 
2.11.0

