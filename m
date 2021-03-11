Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085CF337D4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCKTJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhCKTJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C94C061760;
        Thu, 11 Mar 2021 11:09:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so9820439pjg.5;
        Thu, 11 Mar 2021 11:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkw5+G90n94OUjiIXFC/vgHLYhl7hCOYiRf2Qw5jx3o=;
        b=AZcAO2+Zu7/HIsDOkfadeet7K1FjCBUqPJHcDw10r6Ip/XSXQgclt7/on3IYyaVxzb
         gVfFraVv9Ztw5I3oKVe3BZ+0bbxXZc9dxi9YjiQKKhZ54f4Mm7t538LK+afS4g9WAmlk
         ZUI3rjA2+8XWNmrElOpXt/U5+ruaHwy9YwDgDjAvMK8uy0435JphBeu107Q5p1bmAE38
         EBMmd2n59UEAmYKPBEd1hi/iFeUyPjyP5NgQd9ECU+/ZD81eV3zRtWvSdYjad3VbncTI
         drbXs6PpDSyksEWLlBYEYfq+beef6niS2B+C13hy1CNOZ7jK1J/pQ424C5TVHyf6yocq
         o2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkw5+G90n94OUjiIXFC/vgHLYhl7hCOYiRf2Qw5jx3o=;
        b=qPusX28c9SRE7bAKbcvp49QwfFZco15+0eCeRgxvh9Qea+tjlohkCKiYXtnpoHjNeJ
         vBiBCRIQ9MfYiPnq1YQDtbUmh7764Kh0hBJDenabwRFnHZ1l2Sfrc3pPL2cpyOIQWZro
         gW18zq4R6GXUoabMoXm3Fo0GpNQv2bw7VzCqr9RfpUnIbXeq7TyKdTgM8aKbQnoNhfm1
         lb/4//WG+I5jEFCp29fs68arfJrKiH9cpO9JatIISc9keH77SYiYSeserPXWLfXQdXDB
         A0BlVEs92JElkyHy4euGnGXFS9sXbt/JmT5k6s2c2ZUQuiH9xxRhD/hhxmxmLfsQmQMi
         U7tQ==
X-Gm-Message-State: AOAM531va8A9hJ5pelr8KmGCOnTYS4vpEaHnmg66Jrw0r5HwAXfj5oaS
        smJXoRZGdVsmc9cNaLpWxd8=
X-Google-Smtp-Source: ABdhPJxnH70sPhLOC3ftHwNORmFlXsCr7F56porR1CAZav7poDXAWwFtgfvr0AYbNHuZhf+apfLeCg==
X-Received: by 2002:a17:902:7c8e:b029:e5:f70f:b7ab with SMTP id y14-20020a1709027c8eb02900e5f70fb7abmr9749952pll.32.1615489761244;
        Thu, 11 Mar 2021 11:09:21 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:20 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 10/13] mm: vmscan: use per memcg nr_deferred of shrinker
Date:   Thu, 11 Mar 2021 11:08:42 -0800
Message-Id: <20210311190845.9708-11-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
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

Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 78 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 397f3b67bad8..5bc6975cb635 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -376,6 +376,24 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 	idr_remove(&shrinker_idr, id);
 }
 
+static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
+				   struct mem_cgroup *memcg)
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
@@ -414,6 +432,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 {
 }
 
+static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
+				   struct mem_cgroup *memcg)
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
@@ -425,6 +455,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 }
 #endif
 
+static long xchg_nr_deferred(struct shrinker *shrinker,
+			     struct shrink_control *sc)
+{
+	int nid = sc->nid;
+
+	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+		nid = 0;
+
+	if (sc->memcg &&
+	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
+		return xchg_nr_deferred_memcg(nid, shrinker,
+					      sc->memcg);
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
@@ -561,14 +624,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -578,7 +637,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * and zero it so that other concurrent shrinker invocations
 	 * don't also do this scanning work.
 	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+	nr = xchg_nr_deferred(shrinker, shrinkctl);
 
 	total_scan = nr;
 	if (shrinker->seeks) {
@@ -669,14 +728,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

