Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945F126C8DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIPS6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgIPS6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:58:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F26FC061788;
        Wed, 16 Sep 2020 11:58:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so4533108pfd.3;
        Wed, 16 Sep 2020 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GS1CmojHoBv0FOA7wjuZ6JbQNF7dWa7IOU4RRajxCU=;
        b=twVEt6yAH1J0hYMOAkUnGcn22t7f1gc8OJLPyJ1wgboYkQD66pKW4FQw1EZFFInGR/
         jg1rwIZVaysLXIYLc4uUj0g7o7kFALf1Tsp8G61bskPXY6+a1BjUqEBLC1w/GUg9k3Eo
         V0ySr7IdFH0532/PCKXTip69AbrjjXbWXtyRU5seINb0xZR5BkfnPlxphb/Smxg7by6i
         9LKAtzO46HsEiSLpNe/QTMgRUvhstbHK0jPfXI+S7hG0CgKaiGO1HX6SQYS3jf6KLwx3
         XhLlyQlSacL6cMZcDZgvCaTi2cn//2idNXncGpXi3vQevWA3dAfqP98zIJipclXZLZT4
         XxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GS1CmojHoBv0FOA7wjuZ6JbQNF7dWa7IOU4RRajxCU=;
        b=HuEZ7NSCvw9JyGjxOBFVeYpsNlS8f8oLl/wHfOZu5/23kFJNGB4npOZsmbrAuhnRir
         Wjd2zXf/cLPhQs3bxSvvCoReNt1csnVs8N83UgSvkxEB1kxBZctIZWhZL5a5c5VJiELi
         YIlerIsfj7g9l0zaB2I3wvd2vsv6UsxYFcXnOPMGp4vCxlxRikfMxTH3UXUd66vaRaA3
         SZFy8L9OrI5MBEl23oX31lxM36/aFwLNol24qvPkH0cdjRZEnJvA9RWJmFkrrvlJjNaA
         HwmWFtYWVh43qPVNn1NLo7FobGJwau7iSmCYB+ES+FuGSIWA/Kon73czcPBZcjy5y6RU
         7arA==
X-Gm-Message-State: AOAM5337I9DLlxGirAg3wgcgtDlGNHwnvmymgqDHduNNcFSEHMpQIMaQ
        kyHTWIQ2QbRlspaefKDB6hY=
X-Google-Smtp-Source: ABdhPJxG4mlRvALLbKL294G8Pg1sefaHQgZzLWug4UuvBIJJrfp1yzL8vB8ylD0VIS05yl65dNpabw==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr18656349pgm.82.1600282722853;
        Wed, 16 Sep 2020 11:58:42 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id fz23sm3453747pjb.36.2020.09.16.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:58:41 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     shy828301@gmail.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] mm: vmscan: remove shrinker's nr_deferred
Date:   Wed, 16 Sep 2020 11:58:23 -0700
Message-Id: <20200916185823.5347-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916185823.5347-1-shy828301@gmail.com>
References: <20200916185823.5347-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recently huge amount one-off slab drop was seen on some vfs metadata heavy workloads,
it turned out there were huge amount accumulated nr_deferred objects seen by the
shrinker.

I managed to reproduce this problem with kernel build workload plus negative dentry
generator.

First step, run the below kernel build test script:

NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`

cd /root/Buildarea/linux-stable

for i in `seq 1500`; do
        cgcreate -g memory:kern_build
        echo 4G > /sys/fs/cgroup/memory/kern_build/memory.limit_in_bytes

        echo 3 > /proc/sys/vm/drop_caches
        cgexec -g memory:kern_build make clean > /dev/null 2>&1
        cgexec -g memory:kern_build make -j$NR_CPUS > /dev/null 2>&1

        cgdelete -g memory:kern_build
done

That would generate huge amount deferred objects due to __GFP_NOFS allocations.

Then run the below negative dentry generator script:

NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`

mkdir /sys/fs/cgroup/memory/test
echo $$ > /sys/fs/cgroup/memory/test/tasks

for i in `seq $NR_CPUS`; do
        while true; do
                FILE=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
                cat $FILE 2>/dev/null
        done &
done

Then kswapd will shrink half of dentry cache in just one loop as the below tracing result
showed:

	kswapd0-475   [028] .... 305968.252561: mm_shrink_slab_start: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0
objects to shrink 4994376020 gfp_flags GFP_KERNEL cache items 93689873 delta 45746 total_scan 46844936 priority 12
	kswapd0-475   [021] .... 306013.099399: mm_shrink_slab_end: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0 unused
scan count 4994376020 new scan count 4947576838 total_scan 8 last shrinker return val 46844928

There were huge deferred objects before the shrinker was called, the behavior does match the code
but it might be not desirable from the user's stand of point.

IIUC the deferred objects were used to make balance between slab and page cache, but since commit
9092c71bb724dba2ecba849eae69e5c9d39bd3d2 ("mm: use sc->priority for slab shrink targets") they
were decoupled.  And as that commit stated "these two things have nothing to do with each other".

So why do we have to still keep it around?  I can think of there might be huge slab accumulated
without taking into account deferred objects, but nowadays the most workloads are constrained by
memcg which could limit the usage of kmem (by default now), so it seems maintaining deferred
objects is not that useful anymore.  It seems we could remove it to simplify the shrinker logic
a lot.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/shrinker.h      |  2 -
 include/trace/events/vmscan.h | 11 ++---
 mm/vmscan.c                   | 91 +++--------------------------------
 3 files changed, 12 insertions(+), 92 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 0f80123650e2..db1d3e7d098e 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -73,8 +73,6 @@ struct shrinker {
 	/* ID in shrinker_idr */
 	int id;
 #endif
-	/* objs pending delete, per node */
-	atomic_long_t *nr_deferred;
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 27f268bbeba4..130abf781790 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -184,10 +184,10 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_softlimit_re
 
 TRACE_EVENT(mm_shrink_slab_start,
 	TP_PROTO(struct shrinker *shr, struct shrink_control *sc,
-		unsigned long cache_items, unsigned long long delta,
-		unsigned long total_scan, int priority),
+		unsigned long cache_items, unsigned long total_scan,
+		int priority),
 
-	TP_ARGS(shr, sc, cache_items, delta, total_scan, priority),
+	TP_ARGS(shr, sc, cache_items, total_scan, priority),
 
 	TP_STRUCT__entry(
 		__field(struct shrinker *, shr)
@@ -195,7 +195,6 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__field(int, nid)
 		__field(gfp_t, gfp_flags)
 		__field(unsigned long, cache_items)
-		__field(unsigned long long, delta)
 		__field(unsigned long, total_scan)
 		__field(int, priority)
 	),
@@ -206,18 +205,16 @@ TRACE_EVENT(mm_shrink_slab_start,
 		__entry->nid = sc->nid;
 		__entry->gfp_flags = sc->gfp_mask;
 		__entry->cache_items = cache_items;
-		__entry->delta = delta;
 		__entry->total_scan = total_scan;
 		__entry->priority = priority;
 	),
 
-	TP_printk("%pS %p: nid: %d gfp_flags %s cache items %ld delta %lld total_scan %ld priority %d",
+	TP_printk("%pS %p: nid: %d gfp_flags %s cache items %ld total_scan %ld priority %d",
 		__entry->shrink,
 		__entry->shr,
 		__entry->nid,
 		show_gfp_flags(__entry->gfp_flags),
 		__entry->cache_items,
-		__entry->delta,
 		__entry->total_scan,
 		__entry->priority)
 );
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 48ebea97f12f..5223131a20d0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -336,38 +336,21 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
-
-	if (shrinker->flags & SHRINKER_NUMA_AWARE)
-		size *= nr_node_ids;
-
-	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
-	if (!shrinker->nr_deferred)
-		return -ENOMEM;
-
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		if (prealloc_memcg_shrinker(shrinker))
-			goto free_deferred;
+			goto nomem;
 	}
 
 	return 0;
 
-free_deferred:
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
+nomem:
 	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
-		return;
-
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
-
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
 }
 
 void register_shrinker_prepared(struct shrinker *shrinker)
@@ -397,15 +380,11 @@ EXPORT_SYMBOL(register_shrinker);
  */
 void unregister_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
-		return;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
 }
 EXPORT_SYMBOL(unregister_shrinker);
 
@@ -415,15 +394,11 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 				    struct shrinker *shrinker, int priority)
 {
 	unsigned long freed = 0;
-	unsigned long long delta;
 	long total_scan;
 	long freeable;
-	long nr;
-	long new_nr;
 	int nid = shrinkctl->nid;
 	long batch_size = shrinker->batch ? shrinker->batch
 					  : SHRINK_BATCH;
-	long scanned = 0, next_deferred;
 
 	if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 		nid = 0;
@@ -432,61 +407,27 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	if (freeable == 0 || freeable == SHRINK_EMPTY)
 		return freeable;
 
-	/*
-	 * copy the current shrinker scan count into a local variable
-	 * and zero it so that other concurrent shrinker invocations
-	 * don't also do this scanning work.
-	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
-
-	total_scan = nr;
 	if (shrinker->seeks) {
-		delta = freeable >> priority;
-		delta *= 4;
-		do_div(delta, shrinker->seeks);
+		total_scan = freeable >> priority;
+		total_scan *= 4;
+		do_div(total_scan, shrinker->seeks);
 	} else {
 		/*
 		 * These objects don't require any IO to create. Trim
 		 * them aggressively under memory pressure to keep
 		 * them from causing refetches in the IO caches.
 		 */
-		delta = freeable / 2;
+		total_scan = freeable / 2;
 	}
 
-	total_scan += delta;
 	if (total_scan < 0) {
 		pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
 		       shrinker->scan_objects, total_scan);
 		total_scan = freeable;
-		next_deferred = nr;
-	} else
-		next_deferred = total_scan;
-
-	/*
-	 * We need to avoid excessive windup on filesystem shrinkers
-	 * due to large numbers of GFP_NOFS allocations causing the
-	 * shrinkers to return -1 all the time. This results in a large
-	 * nr being built up so when a shrink that can do some work
-	 * comes along it empties the entire cache due to nr >>>
-	 * freeable. This is bad for sustaining a working set in
-	 * memory.
-	 *
-	 * Hence only allow the shrinker to scan the entire cache when
-	 * a large delta change is calculated directly.
-	 */
-	if (delta < freeable / 4)
-		total_scan = min(total_scan, freeable / 2);
-
-	/*
-	 * Avoid risking looping forever due to too large nr value:
-	 * never try to free more than twice the estimate number of
-	 * freeable entries.
-	 */
-	if (total_scan > freeable * 2)
-		total_scan = freeable * 2;
+	}
 
 	trace_mm_shrink_slab_start(shrinker, shrinkctl, 
-				   freeable, delta, total_scan, priority);
+				   freeable, total_scan, priority);
 
 	/*
 	 * Normally, we should not scan less than batch_size objects in one
@@ -517,26 +458,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 
 		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
 		total_scan -= shrinkctl->nr_scanned;
-		scanned += shrinkctl->nr_scanned;
 
 		cond_resched();
 	}
 
-	if (next_deferred >= scanned)
-		next_deferred -= scanned;
-	else
-		next_deferred = 0;
-	/*
-	 * move the unused scan count back into the shrinker in a
-	 * manner that handles concurrent updates. If we exhausted the
-	 * scan, there is no need to do an update.
-	 */
-	if (next_deferred > 0)
-		new_nr = atomic_long_add_return(next_deferred,
-						&shrinker->nr_deferred[nid]);
-	else
-		new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
-
 	trace_mm_shrink_slab_end(shrinker, nid, freed, total_scan);
 	return freed;
 }
-- 
2.26.2

