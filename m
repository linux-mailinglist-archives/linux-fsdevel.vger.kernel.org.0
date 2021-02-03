Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E448F30E0D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 18:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBCRWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 12:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhBCRWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:22:17 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D03C061794;
        Wed,  3 Feb 2021 09:21:26 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t25so202332pga.2;
        Wed, 03 Feb 2021 09:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ne9c28jAeNdinyG89P4oWkn90QuBd4v0cKiR/cg2+U=;
        b=orZSCV6SHryTbhEuW2L5pMDNGTnkvPbjkzPIslnHCrX8y7dM+IHRgsQC7hetZxHcH9
         s1jEQuYyZaeyxfG0l/QBgW41BLgZqfwtsIXzWZDL/H9N0pE9TdyD1VGD+OcRmJHoPE6R
         lvLGCmdZLEdXmQz89rED6ElQ1i7IV/FhmdXJzWZNRUcHmprcn8JHklhLvFxTSRIiWS37
         aivC59/7hrfd16QOLI2SRDmsmog3iAGEbVdGAtnWWQycXbNhAaLkpqz/zb/QrZVp93Kw
         v8pSWU0c24/FNFn+04rdxNSmw9EvUvHRHKPJ0EVpDFNp5Z9WGwV3lbaM7m1TLitZHB7W
         RQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ne9c28jAeNdinyG89P4oWkn90QuBd4v0cKiR/cg2+U=;
        b=L7Z7igiw2TDHXb5mihYehM6bAtoRSFhUlWaO9vLs748Tb6nlAeukYHfSc/j5Bzjy9j
         4sq+HOkbdSS1IMrk+C7bjvxutJ1+Npt5KjgXrTgQ3Ym79YJzIp+WANYP9+f9IjyOzvlp
         knxshg1RpKNx5/uXgKem5yroRoZEpbVxPoEvpCbHGy6rDe1oBzRHqD1jKt0VU4YIB76I
         GWp4fb0S4HrcTZNHr4eAUU8RYl0rUJndajLXUidojKSM8dgppQftM5wemGCBINOKKY4Y
         OPXTqCFtlkbLSaPWYItGourR5vMdSClG/mfMOYs0paQgaBLAgo6eViqsrllxlecijbXS
         xsEA==
X-Gm-Message-State: AOAM530EVSMD8JweoUjmQmb6jSmzO+zv/OZGzlQMeCAk2s1JnQYUVasS
        NTTPHShSi/m/W4u2vrHdpTs=
X-Google-Smtp-Source: ABdhPJweS1ZsAvxHk9E6TASUPG1UDfzIqhh+bhCZU+sXXpV+OultKCvbpaaw1AfBEFMLbFaCmGylnA==
X-Received: by 2002:a62:1ec5:0:b029:1ce:b354:b25f with SMTP id e188-20020a621ec50000b02901ceb354b25fmr3901139pfe.56.1612372885959;
        Wed, 03 Feb 2021 09:21:25 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x21sm2368636pfn.100.2021.02.03.09.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:21:23 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v6 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of shrinker
Date:   Wed,  3 Feb 2021 09:20:39 -0800
Message-Id: <20210203172042.800474-9-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203172042.800474-1-shy828301@gmail.com>
References: <20210203172042.800474-1-shy828301@gmail.com>
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
 mm/vmscan.c | 94 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d9126f12890f..545422d2aeec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -190,6 +190,13 @@ static int shrinker_nr_max;
 #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
 	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
 
+static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
+						     int nid)
+{
+	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 lockdep_is_held(&shrinker_rwsem));
+}
+
 static void free_shrinker_info_rcu(struct rcu_head *head)
 {
 	kvfree(container_of(head, struct shrinker_info, rcu));
@@ -204,8 +211,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 	int size = m_size + d_size;
 
 	for_each_node(nid) {
-		old = rcu_dereference_protected(
-			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
+		old = shrinker_info_protected(memcg, nid);
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
@@ -239,7 +245,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
-		info = rcu_dereference_protected(pn->shrinker_info, true);
+		info = shrinker_info_protected(memcg, nid);
 		kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
@@ -358,6 +364,25 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 	up_write(&shrinker_rwsem);
 }
 
+
+static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
+				    struct mem_cgroup *memcg)
+{
+	struct shrinker_info *info;
+
+	info = shrinker_info_protected(memcg, nid);
+	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
+}
+
+static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
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
@@ -396,6 +421,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
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
@@ -407,6 +444,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
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
@@ -539,14 +609,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -556,7 +622,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * and zero it so that other concurrent shrinker invocations
 	 * don't also do this scanning work.
 	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+	nr = count_nr_deferred(shrinker, shrinkctl);
 
 	total_scan = nr;
 	if (shrinker->seeks) {
@@ -647,14 +713,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -674,8 +735,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
 
-	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
-					 true);
+	info = shrinker_info_protected(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
-- 
2.26.2

