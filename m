Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0AF334587
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhCJRrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhCJRqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92E2C061760;
        Wed, 10 Mar 2021 09:46:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so7638113pjb.0;
        Wed, 10 Mar 2021 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJz0Wb5sPGubosZGWYITbWJb9prsfgWGS78iJTHia7k=;
        b=hwmGVy7R7pl3/e+v47GWlbKqHBOLmJ94Qrk62MCC030HH4KX6PRx0iAmUE1p8pDzNi
         F/LSOLjE0cet/nr83buTzNrZpM0dpyEyr/hVUGQIvBIsIxsyHtWURh0uCjYjU9ENb4Db
         dPOL3E+vRSg5NRdseOw6yYlVj952heRYvZEcYigrIWTi8WNFatQt9NKijhRkVKb1AUtC
         97HCsLisryN80Ldfxr/nv+TBd4VNWwtltn8jtn+gxcTl5OgJxM2DJsgKC+AMxOPy2VQ5
         Oequx25raFoyykWstClKOop08hSLpFylGK/uB6UEO7khh5mvsikyMfrVyAqtDIqTaMcI
         LBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJz0Wb5sPGubosZGWYITbWJb9prsfgWGS78iJTHia7k=;
        b=YbwZ6P2jN1V7ytRlrhuSvnLXFmUQyQxlF33+QaGHnk58edX/Ew8hTwCjWVswkb40KW
         RVI+vrthX01EbZ8sekjtfNdpi0ZSr2wjA1ysp06WFq3SAZDrWYzczrxWHLmpo+cZsjnk
         SqlVdZhl7Hv7MZexyKnOWbLPF86aJcOi3D1dNwPHIn84Q2EfMKrisWCRZ6QYtCoLGbrf
         IQH+rZZyp4X4QfqFpzXwze70MNrfs0r/uOJ265sDWQ5Br2AgAF0+DlJWbbKRmwQf8laH
         3EDbDhl5/mYppMAKJzh+srtEYNasUjTvBSyP6hE7A9gZjXH5wDL9al48eWZewpfQA5Df
         ZGNA==
X-Gm-Message-State: AOAM532hfpIsBv94EyXRheiI9dmfRbfFWxjXEWkF9toim5+6E+IQXz7y
        ZwvhaCMAeBa3nFDSi2VBSds=
X-Google-Smtp-Source: ABdhPJxd01rtfsohsp6B/Mcet9kZtJ3KN9JVwchG8OO5e7MCaQ8wJTNHPWJpN2zoiIerX1hfoH8USQ==
X-Received: by 2002:a17:90b:609:: with SMTP id gb9mr4568728pjb.209.1615398395320;
        Wed, 10 Mar 2021 09:46:35 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:34 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 10/13] mm: vmscan: use per memcg nr_deferred of shrinker
Date:   Wed, 10 Mar 2021 09:46:00 -0800
Message-Id: <20210310174603.5093-11-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
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
index ae82afe6cec6..326f0e0c4356 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -374,6 +374,24 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
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
@@ -412,6 +430,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
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
@@ -423,6 +453,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
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
@@ -559,14 +622,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -576,7 +635,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * and zero it so that other concurrent shrinker invocations
 	 * don't also do this scanning work.
 	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+	nr = xchg_nr_deferred(shrinker, shrinkctl);
 
 	total_scan = nr;
 	if (shrinker->seeks) {
@@ -667,14 +726,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

