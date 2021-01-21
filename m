Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A352FF881
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbhAUXMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbhAUXHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:07:31 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A338BC06121C;
        Thu, 21 Jan 2021 15:06:56 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q131so2452602pfq.10;
        Thu, 21 Jan 2021 15:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZLMf4A0IHqVBFCj87SkKbs9E9e3bcGD5MPZ0Wkq/mc=;
        b=c9oY6ctP2b/rT4QSmLGh0urDBiDIMwa+LiG+0UYKP238b6uBaZEyVR0T1ZIOAg5GWa
         byoPVJmG97Ev2e+Wl1qb4HAjdpUTOG4o7Jr8EBk3SkGpdY4EKo++kmmImqTVN6KBwhts
         IanjXH4X0hq2JP0RiJrivJgmCEO1/Un16rV6aQDZ32p2av3G9S2Fv6F0hcYX0ivUGXRF
         ep0sRSbMxb8hBL8+WtQPHB+IcOBvotAwzJEObtKHOTi48ZOEV6e6i+Qzccv+REprcaw9
         Xq1zWL4oft9V2sxGBUdqDdwaJfDXr40IMNOydFb3GpttFn30lBbv7Wyfb5H+/SbFQeu7
         3/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZLMf4A0IHqVBFCj87SkKbs9E9e3bcGD5MPZ0Wkq/mc=;
        b=XwaBcImq0lxPeanxd08+GgTisedTK4Db41TrtZkDnwvccn4cDKKcBi5JM3elyD534n
         kVbEp82jUOGgx++QQNB5Smj4iCbWUYfWIIDgEW0fUWkcyZL77DwFcBG3FoLwEfL4Emq/
         Lp1ac+nrocoMyZu37ku4QhsNW9XCn+nvtE2wDWPHv/PYbmb1V49EYcVbc4f2SHSfgtW3
         UKzSShZkMXSzXwkwgIOPSkwQY+fpEynpFs+Mu9OYsyESi+InyEbUoDdWyYFVAX+atR+H
         lBYs/NMpWKi6j0Y64PEKnsruTxI9fkZcieWtDt01btHaBwHkod23AF8t8Nvlttrb1yO3
         0C0A==
X-Gm-Message-State: AOAM531uiK5TvcgqlnMj6gV8HPY6UjTv9Ey6xCNb2kcZTGiiYivuj1Ey
        qhTvfdNaIp/ToAE+7jxhWw4=
X-Google-Smtp-Source: ABdhPJwozmAUrFq5/542uQo/T7+zhXr34cLbhu0JgxH/zwZSWSWNnoG9bMZDzJbaT7H/G+OraFRYmw==
X-Received: by 2002:a62:e516:0:b029:156:3b35:9423 with SMTP id n22-20020a62e5160000b02901563b359423mr1841757pff.19.1611270416239;
        Thu, 21 Jan 2021 15:06:56 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y16sm6722921pfb.83.2021.01.21.15.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:06:55 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 09/11] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Thu, 21 Jan 2021 15:06:19 -0800
Message-Id: <20210121230621.654304-10-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121230621.654304-1-shy828301@gmail.com>
References: <20210121230621.654304-1-shy828301@gmail.com>
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

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8e77ea13815..ea1402e7b968 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -329,6 +329,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
+	if (mem_cgroup_disabled())
+		return -ENOSYS;
+
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);
@@ -411,7 +414,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #else
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static void unregister_memcg_shrinker(struct shrinker *shrinker)
@@ -522,8 +525,20 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
+	unsigned int size;
+	int err;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		err = prealloc_memcg_shrinker(shrinker);
+		if (!err)
+			return 0;
+		if (err != -ENOSYS)
+			return err;
+
+		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
+	}
 
+	size = sizeof(*shrinker->nr_deferred);
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
 
@@ -531,26 +546,14 @@ int prealloc_shrinker(struct shrinker *shrinker)
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

