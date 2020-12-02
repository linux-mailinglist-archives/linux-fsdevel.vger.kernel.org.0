Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE6F2CC51F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbgLBS3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgLBS3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:29:04 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832CEC061A48;
        Wed,  2 Dec 2020 10:27:58 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l23so1441482pjg.1;
        Wed, 02 Dec 2020 10:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRhj+7Yw6nzO31JxEIwcT1NZoXG/VTPVzLY9DATZGMw=;
        b=udkLiOrTpnntm/BoSKN6xy1KfnG22UeN3YaATFMhEgkjws17uqY62Eq50VzYN0qqLZ
         1otEnXdRn8Aya6N7TZ0BMj8yUS3YSZqyLJR2xJ3l4MqIjf8dBnPFOa/YqAV5YmXXM0UX
         eykp67hoXd8/9AivpVGnM9rx1n4IbTRz/I7LLboJvfwfn29qbOuP14dHyzdv+axkXDHf
         O/ni5EkpulwQNRn1IavIIZzquyKh8t50anN7MtewYS2e/Vm3BEJv/87JfcdIRYGoEabb
         sIX1bvczm3IG2omxpJFuFcrJkSN6OmdmXZWCJfnUYrWs4y3FeIMOthgbnydJK+iRTXCz
         jYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRhj+7Yw6nzO31JxEIwcT1NZoXG/VTPVzLY9DATZGMw=;
        b=pc/eHy5jnvYblICusEM91eS3vHY+/f6RoYGdEswHC4zR3p88R4fgFjMzgyTpARYlJ/
         L9GTmmprhVltuAWe5t2Z3f4bVeWxiFRuAC+mC4d1ig23FZZPiPjlFr/vy3P8Ch/sI3aT
         6/81Vvzg66lTiklbemCcO4MgK7JEpC35t84QtYYs6CzMI1N2vK/0sdKeglIsLOkdeyJm
         bpq89IyModmCpe/2+dh+oXxMxSuVtGR7APraU7mW72DawMHsUzEW2DvX5SXKTf+TnW6G
         Q6Uov0cywHORNFq/rUWSLVTsD1O/d4yCGKFH1rlE5zLQi73U2q5p+M0aRWt0CZEv8I7K
         TkzQ==
X-Gm-Message-State: AOAM530WS7vKtD31Gsjq8ni6/9dpBDCeJAJde4pt67309R6gqvfsv4ho
        J4rtvxRLkgC1vxRZ/x1v4hXuyPsp97EpdQ==
X-Google-Smtp-Source: ABdhPJyZuE3BsVEDtG861FaWW1Yoxny4ZeCG0JCGZCytbEtkzuSlK9Bur5LHBr+r//ymjguIfWrd7g==
X-Received: by 2002:a17:902:7606:b029:da:246c:5bd8 with SMTP id k6-20020a1709027606b02900da246c5bd8mr3825003pll.27.1606933678126;
        Wed, 02 Dec 2020 10:27:58 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c6sm396906pgl.38.2020.12.02.10.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:27:56 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
Date:   Wed,  2 Dec 2020 10:27:22 -0800
Message-Id: <20201202182725.265020-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202182725.265020-1-shy828301@gmail.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
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
 mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cba0bc8d4661..d569fdcaba79 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
 static DEFINE_IDR(shrinker_idr);
 static int shrinker_nr_max;
 
+static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
+{
+	return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
+		!mem_cgroup_disabled();
+}
+
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
@@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #endif
 	return false;
 }
+
+static inline long count_nr_deferred(struct shrinker *shrinker,
+				     struct shrink_control *sc)
+{
+	bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
+	struct memcg_shrinker_deferred *deferred;
+	struct mem_cgroup *memcg = sc->memcg;
+	int nid = sc->nid;
+	int id = shrinker->id;
+	long nr;
+
+	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+		nid = 0;
+
+	if (per_memcg_deferred) {
+		deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
+						     true);
+		nr = atomic_long_xchg(&deferred->nr_deferred[id], 0);
+	} else
+		nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+
+	return nr;
+}
+
+static inline long set_nr_deferred(long nr, struct shrinker *shrinker,
+				   struct shrink_control *sc)
+{
+	bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
+	struct memcg_shrinker_deferred *deferred;
+	struct mem_cgroup *memcg = sc->memcg;
+	int nid = sc->nid;
+	int id = shrinker->id;
+	long new_nr;
+
+	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+		nid = 0;
+
+	if (per_memcg_deferred) {
+		deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
+						     true);
+		new_nr = atomic_long_add_return(nr, &deferred->nr_deferred[id]);
+	} else
+		new_nr = atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
+
+	return new_nr;
+}
 #else
+static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
+{
+	return false;
+}
+
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	return 0;
@@ -290,6 +347,29 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 {
 	return true;
 }
+
+static inline long count_nr_deferred(struct shrinker *shrinker,
+				     struct shrink_control *sc)
+{
+	int nid = sc->nid;
+
+	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+		nid = 0;
+
+	return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+}
+
+static inline long set_nr_deferred(long nr, struct shrinker *shrinker,
+				   struct shrink_control *sc)
+{
+	int nid = sc->nid;
+
+	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
+		nid = 0;
+
+	return atomic_long_add_return(nr,
+				      &shrinker->nr_deferred[nid]);
+}
 #endif
 
 /*
@@ -429,13 +509,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long freeable;
 	long nr;
 	long new_nr;
-	int nid = shrinkctl->nid;
 	long batch_size = shrinker->batch ? shrinker->batch
 					  : SHRINK_BATCH;
 	long scanned = 0, next_deferred;
 
-	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
-		nid = 0;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
 	if (freeable == 0 || freeable == SHRINK_EMPTY)
@@ -446,7 +523,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * and zero it so that other concurrent shrinker invocations
 	 * don't also do this scanning work.
 	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+	nr = count_nr_deferred(shrinker, shrinkctl);
 
 	total_scan = nr;
 	if (shrinker->seeks) {
@@ -539,8 +616,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * move the unused scan count back into the shrinker in a
 	 * manner that handles concurrent updates.
 	 */
-	new_nr = atomic_long_add_return(next_deferred,
-					&shrinker->nr_deferred[nid]);
+	new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);
 
 	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
-- 
2.26.2

