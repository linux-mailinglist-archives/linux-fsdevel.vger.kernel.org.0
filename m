Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8804A2DA391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441157AbgLNWlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502537AbgLNWjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:39:06 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7AC061285;
        Mon, 14 Dec 2020 14:37:54 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id g18so13777395pgk.1;
        Mon, 14 Dec 2020 14:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kmdzUyomriPoEmgNJZkhkyxllzW++vSvJDg1wBbRWU=;
        b=iI8SQ4uIBy6rSF6WJgwZJtcCMKt06dXZSxVquYF/3xfi7j7bZXBscDEUmCgzi5GewB
         IkE8ILNOew3ChA1nW75iqnez79iWw1ndLmdEo8i3ua18h3SXGZmqO0ZMh1+wRiabjzqR
         u457fTskXBgUezEgKLBY80N5NDt6zlCNjwuLuHFKLHmuCBZW8+xvjRE2ntee027Cahhr
         NM9BA3PYx/1thRe828BQdlVujz2/6yVbURUpZFHYoG9XQbBcF0YdiW1At1cCihtAuj12
         e4tXSPFTIhhJ5e/n3mwY124qc/D8hTOntHETVdST3zZcxe1yU7NptmaHaERLmo9+Wwta
         EO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kmdzUyomriPoEmgNJZkhkyxllzW++vSvJDg1wBbRWU=;
        b=V0/tNCieSBE5g/I0MkVuTL6cx/gzttn7Nuo3s5Ll3bvT/l3zyQcpt8/WowTnDBgYlj
         PYZ/lBH80iNrh7PTonHrC6mECX9q2+Z0i5eqFb1B9H2lqeK/dBXKmrnnBgqzDvuQAqEZ
         AOG3GVPStcKW3VETcWNBjvzFSXgzSzyuzHNn3uNIeuW2X8Y/heys7EQ3e2yivDaVOP4c
         CsHEZQOn8W9rveIuTSTPTGz+s1oqou2HoyTUfYwv4LWL/j49u9TnUYzPxgFMuWD2oSJX
         gZ6RVUc3KpSAldL0ffEmVvDGAfJZGy8xTuw0/HmaV6uXiSbDWF7N643tDD2KaQVR28Rm
         Fy2A==
X-Gm-Message-State: AOAM530jfsGmolA6O0jVJ16o2+iAh+YCjb104cDeXkyGnjFWp95hNQoP
        2fI2bXcqbcWtSpE3jSnfqYo=
X-Google-Smtp-Source: ABdhPJz/LPX+WFR6Oci5zsfqoxLPRAVL4rXMXlUq7w+UJS5jvacni+aMkFdG5kal9SInUPXavYNuhQ==
X-Received: by 2002:aa7:963c:0:b029:19d:dcd3:b2ae with SMTP id r28-20020aa7963c0000b029019ddcd3b2aemr25803975pfg.76.1607985474398;
        Mon, 14 Dec 2020 14:37:54 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d4sm20610758pfo.127.2020.12.14.14.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:37:53 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
Date:   Mon, 14 Dec 2020 14:37:19 -0800
Message-Id: <20201214223722.232537-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214223722.232537-1-shy828301@gmail.com>
References: <20201214223722.232537-1-shy828301@gmail.com>
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
 mm/vmscan.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 83 insertions(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bf34167dd67e..bce8cf44eca2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -203,6 +203,12 @@ DECLARE_RWSEM(shrinker_rwsem);
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
@@ -537,14 +614,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

