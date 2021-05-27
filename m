Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB2392767
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhE0G0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhE0G0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:26:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA6FC06138E
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y202so2860026pfc.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HEia8IE8kslbq8l2doyQoIh1s6NP1wi5+X3AcZEFjeo=;
        b=kvlV9ariGPa/KOzsdvMjL84J7KWbdBZljXXTqzBfy1gdD9aUiqOXYY7jJQcZ6EvphQ
         g5z1HggN5fovKKWheUdFdNevBNnCo1Y5FChVJM1/DuUAV36d/srrFP8AiZwJCy+M1ATd
         3xhBPwrQGJbKj2Kl3PGvzcn+Dg2smkoyiPmIwtsfxEKF6SrN6b04pXobPQjFpXbR6spG
         lJc/mkpgOWaK5OEFoF0G+i+xICYWPwDNN/lYDf5Mj138CEBpr7jh8ghx1EP+yJo8N+z8
         QxZdlGmO13yEIskhtzWSkcu7NE88svZEfcAegqOuCoCVD2QjYW395gNPHg9oHw5ejkrV
         /ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HEia8IE8kslbq8l2doyQoIh1s6NP1wi5+X3AcZEFjeo=;
        b=VhQ29M7BDP/pwSCAQht70JS5FEY+i93NRonLBF1U++/7pKNI64pCtNve+fCbMRESNf
         zjYfEpaA2NYgLqOZhV2SO9Y+mn/mCuqPeCicKBBu+6wQXxB4IvmgRblVvwWU64NPgQof
         +Hl3jaRWutU0fLMm2cD8xA3+y1BD/9fcZd1A/D2rmCKfPiAbo4cpHRm6USA3avPt8Hwi
         a3KmO3Vy3cjw2pSfKStT/URSGz1LxuJFd+9skzZ+a7gA3veNr7UiVUBpaO8Nrp3VKfDb
         AYDUyxoq/NYqtIvU6A1Cz0rCCZULOum26On7/9yuR80/mvWP79b2lJT/k5uoXI6ZOlCl
         wiuQ==
X-Gm-Message-State: AOAM5329FfNevNL/8Q2CbZN+3Kl8b369+Xw5NUudTGf1tOWf0zOzoiPN
        UhuqVpMSMMQAPDnPkWxhSJeDWQ==
X-Google-Smtp-Source: ABdhPJy8A0vvkxkOQSVawjHK6CAOJlYjigmh+AJP/eE52bt7Q22D37+MA/80ZY8HArWIAUCkU+9QRQ==
X-Received: by 2002:a65:64cc:: with SMTP id t12mr2330420pgv.64.1622096699772;
        Wed, 26 May 2021 23:24:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.24.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:24:59 -0700 (PDT)
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
Subject: [PATCH v2 06/21] mm: list_lru: only add the memcg aware lrus to the list_lrus
Date:   Thu, 27 May 2021 14:21:33 +0800
Message-Id: <20210527062148.9361-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to traverse every lru in the list_lrus in some routines, but skip
memcg non-aware lrus. However, we can only add the memcg aware lrus to
the list_lrus. This can be efficient to traverse the list.

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

