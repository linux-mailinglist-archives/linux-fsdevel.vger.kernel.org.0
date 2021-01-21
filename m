Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122272FF884
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbhAUXNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbhAUXHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:07:31 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55527C0613ED;
        Thu, 21 Jan 2021 15:06:54 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n25so2403246pgb.0;
        Thu, 21 Jan 2021 15:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SlHfZhSiZNKbs0mjvUox6d28geo/ZvBRCAhNI+IEVc=;
        b=sDJz2yo6fVhLXppFA6DLaTHwx1TBzkOJPIpEiu9J0oik+Hl6Jdnzr52Nz7mYZFxtwl
         lQyYLhO+PcOLm5Xg9Gu2HIrGORhm22/JGifPt9t4qtHquP4ORMLfwutzjnYyTdZFBHps
         nOfABIw8MRYXjFcsZzvgApucTjH6re4Se4lIlrIua9lwe+ZP6u3iS3wEhJ4w8cV1b1Kn
         xwG+nNpiXQZuHGi2BtGfmu9aSnlgh2djyA5XF8n0NqMclHGN0WWyuS5K5cD7Apd05kue
         +KxQ56Tbe8sgrdPGkAOcUO86FaDS7ZO9hRHqzXqDZTGoqhXdYlplbyXZGLSwFq/ZHaVI
         jSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SlHfZhSiZNKbs0mjvUox6d28geo/ZvBRCAhNI+IEVc=;
        b=JXtSryI+Csyk/HmBz18vC0zEia9fn4oC+uBC3sSDFN6YeYJHr1qhUlaqcnLoGkc/ZJ
         kZmJ84cCj1kLrQu3CRjQua5KTw9dEk/Rd9+Jcr7Nlqfy22qs+CrABHJCHNNm3TgUXtzR
         UpZSztavBhhVi/E+OERT9OmgpIMdcvZW6Ok6r28hcnbNcFgFPbv3+5/4/iLUJ0fseMhL
         RtVbl9BUbdJKgXyS3J4PkLd/MRbkfyhZzwTzutI8ZgCDNlvEWfAzWgB8rkwJOIf1YI1K
         jN6JD34+y0BzYqNJp4Een1tP7HXJG0a30bvpbuKup3bavxC57hhyiyeZQhFdeFBrtytS
         duzw==
X-Gm-Message-State: AOAM531kd+aEi6kqFOt0MX/EJWjtLdHa5MKwJMJcHCDoJsTrqYBc9Fko
        P9zUaokdEKBUSTZsmRTK1Iw=
X-Google-Smtp-Source: ABdhPJwIU5G2rXN+/5fiO72dLGOTVGko9BsBg3ezB7RegtX65G41XVMMa1YdR7nAzZtQ8X/DwgrLUQ==
X-Received: by 2002:a62:5207:0:b029:1b7:6c49:f971 with SMTP id g7-20020a6252070000b02901b76c49f971mr1836224pfb.23.1611270413916;
        Thu, 21 Jan 2021 15:06:53 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y16sm6722921pfb.83.2021.01.21.15.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:06:52 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of shrinker
Date:   Thu, 21 Jan 2021 15:06:18 -0800
Message-Id: <20210121230621.654304-9-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121230621.654304-1-shy828301@gmail.com>
References: <20210121230621.654304-1-shy828301@gmail.com>
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
 mm/vmscan.c | 81 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 722aa71b13b2..d8e77ea13815 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -359,6 +359,27 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 	up_write(&shrinker_rwsem);
 }
 
+static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
+				    struct mem_cgroup *memcg)
+{
+	struct shrinker_info *info;
+
+	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 true);
+	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
+}
+
+static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
+				  struct mem_cgroup *memcg)
+{
+	struct shrinker_info *info;
+
+	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 true);
+
+	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
+}
+
 static bool cgroup_reclaim(struct scan_control *sc)
 {
 	return sc->target_mem_cgroup;
@@ -397,6 +418,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 {
 }
 
+static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
+				    struct mem_cgroup *memcg)
+{
+	return 0;
+}
+
+static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
+				  struct mem_cgroup *memcg)
+{
+	return 0;
+}
+
 static bool cgroup_reclaim(struct scan_control *sc)
 {
 	return false;
@@ -408,6 +441,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
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
+static long set_nr_deferred(long nr, struct shrinker *shrinker,
+			    struct shrink_control *sc)
+{
+	int nid = sc->nid;
+
+	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+		nid = 0;
+
+	if (sc->memcg &&
+	    (shrinker->flags & SHRINKER_MEMCG_AWARE))
+		return set_nr_deferred_memcg(nr, nid, shrinker,
+					     sc->memcg);
+
+	return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
+}
+
 /*
  * This misses isolated pages which are not accounted for to save counters.
  * As the data only determines if reclaim or compaction continues, it is
@@ -544,14 +610,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -561,7 +623,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * and zero it so that other concurrent shrinker invocations
 	 * don't also do this scanning work.
 	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+	nr = count_nr_deferred(shrinker, shrinkctl);
 
 	total_scan = nr;
 	if (shrinker->seeks) {
@@ -652,14 +714,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
+	new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);
 
 	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
-- 
2.26.2

