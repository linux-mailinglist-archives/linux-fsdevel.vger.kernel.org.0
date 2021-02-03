Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF27730E0D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 18:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhBCRWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 12:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhBCRWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:22:17 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D8FC061797;
        Wed,  3 Feb 2021 09:21:29 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i7so174809pgc.8;
        Wed, 03 Feb 2021 09:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZyoHuzV1k2TIojfPlHgQ9uQzq96PQTgKepbMyYmNmc0=;
        b=sItIFo8+Tv2+14wSPbPAt5ataYj6jUfSFcSvfEdBqVF6eJH7vgm6Lq5sXA5/68u4dn
         sw118c/7ai8dwWAaGxIGo1pCnH2NswhKt7TNxF3DwfQgwlynTIDa0vgaUsVH8MA6NKIJ
         CrdP7aCjHuKt1uXcBPzdPgey/+8QE89OpT82AAiGh/KDMBxyV3ohfEpTuIMhTYBlYOtI
         099vjIo9ZpsbV/EXg2FCX+krFVDctzo1RpPu9OnpPFsSiaJgJTk0JbzlrsjHvzEnH4yw
         wA35sVtLpS2Y43o+oomX7WICvQlBpciz1XGF59guja7MqQqjQCzIz56uRSqwnpN8ngEb
         iO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZyoHuzV1k2TIojfPlHgQ9uQzq96PQTgKepbMyYmNmc0=;
        b=hiWM36QWlG/91UPRBJKpuYHyXbUokuNl7tTGLpCo2RIHCmzLTjB0ZKp+bcLe5L+zZG
         LQXnG4au6JA3JI7i1w7LA3kmy0hDAKR4dbNIxMltVmX2YWjpif7S26MtpfnFsVEXtH9k
         u/gdoiRV9U97cYNQhd2HIefWnBvjEz0IXV3rGsArozewhtNm/xg2E5iKMvsL7/OPlwL3
         frCLL+O1nGiMxciD+3luVsUAioAn1k7q7oeO552JUoWIsiMp9KF4+MTvLnL7rBoGiLOz
         ACzmm95Sz2SwxQiM/PzNIQT58tPU600B8ojhr2YQ6nMNuoM+ljojiE/4iv/VpnVC3KI4
         r9TA==
X-Gm-Message-State: AOAM533gKfEdRR1a+bjTIZScDW37R1TW/bXhKK0XcjkwOkakVMPh5Bkz
        2KDu4o9qPDWNxMpTycGCOvk=
X-Google-Smtp-Source: ABdhPJz+Zs59uEkfLCtuU40slq96EYyTOTHEgvjkTOIZezz5jTc8D2BmsjoMjeIQUTzuvj0ddSrIzQ==
X-Received: by 2002:a62:ae0c:0:b029:1bc:a0b9:f0aa with SMTP id q12-20020a62ae0c0000b02901bca0b9f0aamr3901720pff.78.1612372888904;
        Wed, 03 Feb 2021 09:21:28 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x21sm2368636pfn.100.2021.02.03.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:21:27 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v6 PATCH 09/11] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Wed,  3 Feb 2021 09:20:40 -0800
Message-Id: <20210203172042.800474-10-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203172042.800474-1-shy828301@gmail.com>
References: <20210203172042.800474-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
allocate shrinker->nr_deferred for such shrinkers anymore.

The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
This makes the implementation of this patch simpler.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 545422d2aeec..20a35d26ae12 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -334,6 +334,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
+	if (mem_cgroup_disabled())
+		return -ENOSYS;
+
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
@@ -414,7 +417,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #else
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static void unregister_memcg_shrinker(struct shrinker *shrinker)
@@ -525,8 +528,18 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
+	unsigned int size;
+	int err;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		err = prealloc_memcg_shrinker(shrinker);
+		if (err != -ENOSYS)
+			return err;
 
+		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
+	}
+
+	size = sizeof(*shrinker->nr_deferred);
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
 
@@ -534,26 +547,14 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		if (prealloc_memcg_shrinker(shrinker))
-			goto free_deferred;
-	}
 
 	return 0;
-
-free_deferred:
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
-		return;
-
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
+		return unregister_memcg_shrinker(shrinker);
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
-- 
2.26.2

