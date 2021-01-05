Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC302EB5B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbhAEXAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 18:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbhAEXAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:00:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC88C0617A3;
        Tue,  5 Jan 2021 14:59:02 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q4so552095plr.7;
        Tue, 05 Jan 2021 14:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ckz+iajI2TNnqdbm5CVDffNmOINo4C2i2MSG0RCclRM=;
        b=oluYyeVNBXayU4Icdv9HkuZMEQpG1jl7sJ6hxEkS/sGxQLUqYkMEVSjdV5xIMKkzRL
         N590EgDkFgj3vnWPjzL8Lq5Mq2hv7uSb8u/BNiXukSpfuSHWQEQHHldKeoRn4SHUw5a6
         dt98gk6oplwMDfwoDCSpy7SprMrBCirsZVSxz4rf71MHSo4SNDZ8UFReAAIv0fbdxEqX
         ZMAxKxFm5RFN5sQ93Zu/RPkI5lhq5l3m1kc9Uq2MZoTlpKYR66RNSApyfElOlEaeG/eR
         CtSGQpgzJCymonVPtFgnoAtNqV/LfeJPn4rMqdV4M59C3dYuR6XLYI8F1cHNQm3A9bMm
         YWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ckz+iajI2TNnqdbm5CVDffNmOINo4C2i2MSG0RCclRM=;
        b=BWCfVo1HCjwU4V10MresGUD4kTCmF5Sdjbyqf0SHvurSSQKym717CFfgvjBJiB3y/+
         Bnf4bi8B9Wn9tWIR2BSXtTSyyUmtuVK0KZuacWvNWBIoTzxIzl5ocvc6P7g4E0Q2Kg46
         uKSCPZadG9eHx5R76x8qkj3EnkHi0folC7Zl9RD0OCN6oaGplrhkG5zuf0OuswJk+7m0
         omWgOME/KSITu7ytybQf+wM793SpU+BoyssBFRamqDQa7OClnLFM5axfkgNu2g1vA9GD
         VgKvI7s3BkmZt4fGtfuRR0XbUuV3lqP97r2B7xYqj3x9VTIcgpEGPwqKL5sVROtnIUGx
         HkyA==
X-Gm-Message-State: AOAM532n773M4naI3eDOcBsBBCq9emoJU/TcyGqyNfyh1XwxrPvFbhYH
        NjjYuF5CmoBxIfAP94erhCo=
X-Google-Smtp-Source: ABdhPJzBzueIBvuKEVP0dGpLPdFnWIZUhYeGgv8FEZm16lQPS322SeWlEnAWVQ+a32ib8v0PZHxN+w==
X-Received: by 2002:a17:902:b601:b029:da:d459:65dc with SMTP id b1-20020a170902b601b02900dad45965dcmr1321996pls.26.1609887541717;
        Tue, 05 Jan 2021 14:59:01 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw12sm244233pjb.43.2021.01.05.14.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:59:00 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of shrinker
Date:   Tue,  5 Jan 2021 14:58:14 -0800
Message-Id: <20210105225817.1036378-9-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105225817.1036378-1-shy828301@gmail.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
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
index 72259253e414..f20ed8e928c2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -372,6 +372,27 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 	up_write(&shrinker_rwsem);
 }
 
+static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
+				    struct mem_cgroup *memcg)
+{
+	struct memcg_shrinker_info *info;
+
+	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 true);
+	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
+}
+
+static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
+				  struct mem_cgroup *memcg)
+{
+	struct memcg_shrinker_info *info;
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
@@ -410,6 +431,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
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
@@ -421,6 +454,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
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
@@ -558,14 +624,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -575,7 +637,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * and zero it so that other concurrent shrinker invocations
 	 * don't also do this scanning work.
 	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+	nr = count_nr_deferred(shrinker, shrinkctl);
 
 	total_scan = nr;
 	if (shrinker->seeks) {
@@ -666,14 +728,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

