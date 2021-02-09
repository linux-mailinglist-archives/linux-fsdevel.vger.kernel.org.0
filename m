Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115A631559C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhBISGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 13:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhBIRsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:48:09 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B2C061794;
        Tue,  9 Feb 2021 09:47:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g3so10170674plp.2;
        Tue, 09 Feb 2021 09:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLHMO0CJlDGDLfBj7qUuWKf63jRhI9bAFy0uZYnSIgU=;
        b=iLutBmpw9q9DSfaNwTjqN17qLywyO9FvLxIpnRaQ/yPDHlc/FJfxq/D3q6Uh1uNd09
         UgWHri/Fa1exto/A08UNGi1MQj0V037ASVjoYKgaja/cyLEdjWuYyC4bBZIXwQ2qGBoe
         a2KUM2IO5ZncBQNRTNqNcrkt8gyfro++XD3B76BYTp3/yPZ1drQ9ZWwXObYsIKexa7vT
         K5WPUDPiWvQU4yQd6kXTC+pW8GmJEJKwZ3hnTH6Fls8d6tY5fCshtlWb+75eZuVDOZyn
         /1h0jJqZCRxfqhIP1MH7OB8Q4ND25rnwElP+wCjZ9sHY+j/XQHZQLhtQ+w+nRUVb4rLF
         sYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLHMO0CJlDGDLfBj7qUuWKf63jRhI9bAFy0uZYnSIgU=;
        b=ao6/7fw82N4ElyD2xoK0jWPyZ8sSi822BIp5RPfHoohlBhN/qbHqOa9LqawFK/BxwA
         x0Zj1pxDo9yxiOSBPo8MHi/cHJPcZxSpT+H25pwBrtM2wvFdXnYaC/Yw9p9ly6pWreG1
         CI8v3ZfFg4vvjbR/ffHseGHlSRsXTPBxt4PfsMWFX0xdczyBK6s7jexvxTFZ/249lUXD
         Mld4voClnpUyXYoW/fLMc/+CAlCzB/YIx0y3bkCdI92XPb+gzcyeIVjxH0mPgIKnAb/y
         qAlf3+P+8iEPcGDXgkQv4Aya782eeCxeVNe+r2pFEmmRjAm657zS/ZmBtqGN562/bfr/
         JXiQ==
X-Gm-Message-State: AOAM5331FlONSw9Ngt1WxRxfUBwu50IdLxganPKUs3UZlUSPsU+/3JD1
        /2ki98VSkmFZVVh/qv2YY9A=
X-Google-Smtp-Source: ABdhPJzLr+e2VbMOyew26Jy1J13A+S62eVR/KNdvufscmPTbomzdCkSx5wFdCzpD0Ky2wyEMrbpB4A==
X-Received: by 2002:a17:90a:a22:: with SMTP id o31mr4925486pjo.221.1612892844684;
        Tue, 09 Feb 2021 09:47:24 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id j1sm22260929pfr.78.2021.02.09.09.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:47:23 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 PATCH 09/12] mm: vmscan: use per memcg nr_deferred of shrinker
Date:   Tue,  9 Feb 2021 09:46:43 -0800
Message-Id: <20210209174646.1310591-10-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209174646.1310591-1-shy828301@gmail.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
will be used in the following cases:
    1. Non memcg aware shrinkers
    2. !CONFIG_MEMCG
    3. memcg is disabled by boot parameter

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 78 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4b030a0b2a9..748aa6e90f83 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -368,6 +368,24 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 	up_write(&shrinker_rwsem);
 }
 
+static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
+				    struct mem_cgroup *memcg)
+{
+	struct shrinker_info *info;
+
+	info = shrinker_info_protected(memcg, nid);
+	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
+}
+
+static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
+				  struct mem_cgroup *memcg)
+{
+	struct shrinker_info *info;
+
+	info = shrinker_info_protected(memcg, nid);
+	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
+}
+
 static bool cgroup_reclaim(struct scan_control *sc)
 {
 	return sc->target_mem_cgroup;
@@ -406,6 +424,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 {
 }
 
+static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
+				    struct mem_cgroup *memcg)
+{
+	return 0;
+}
+
+static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
+				  struct mem_cgroup *memcg)
+{
+	return 0;
+}
+
 static bool cgroup_reclaim(struct scan_control *sc)
 {
 	return false;
@@ -417,6 +447,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 }
 #endif
 
+static long count_nr_deferred(struct shrinker *shrinker,
+			      struct shrink_control *sc)
+{
+	int nid = sc->nid;
+
+	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+		nid = 0;
+
+	if (sc->memcg &&
+	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
+		return count_nr_deferred_memcg(nid, shrinker,
+					       sc->memcg);
+
+	return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+}
+
+
+static long add_nr_deferred(long nr, struct shrinker *shrinker,
+			    struct shrink_control *sc)
+{
+	int nid = sc->nid;
+
+	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+		nid = 0;
+
+	if (sc->memcg &&
+	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
+		return add_nr_deferred_memcg(nr, nid, shrinker,
+					     sc->memcg);
+
+	return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
+}
+
 /*
  * This misses isolated pages which are not accounted for to save counters.
  * As the data only determines if reclaim or compaction continues, it is
@@ -549,14 +612,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long freeable;
 	long nr;
 	long new_nr;
-	int nid = shrinkctl->nid;
 	long batch_size = shrinker->batch ? shrinker->batch
 					  : SHRINK_BATCH;
 	long scanned = 0, next_deferred;
 
-	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
-		nid = 0;
-
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
 	if (freeable == 0 || freeable == SHRINK_EMPTY)
 		return freeable;
@@ -566,7 +625,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * and zero it so that other concurrent shrinker invocations
 	 * don't also do this scanning work.
 	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+	nr = count_nr_deferred(shrinker, shrinkctl);
 
 	total_scan = nr;
 	if (shrinker->seeks) {
@@ -657,14 +716,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		next_deferred = 0;
 	/*
 	 * move the unused scan count back into the shrinker in a
-	 * manner that handles concurrent updates. If we exhausted the
-	 * scan, there is no need to do an update.
+	 * manner that handles concurrent updates.
 	 */
-	if (next_deferred > 0)
-		new_nr = atomic_long_add_return(next_deferred,
-						&shrinker->nr_deferred[nid]);
-	else
-		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
+	new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
 
 	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
-- 
2.26.2

