Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBADD30681D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 00:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhA0XkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 18:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhA0Xfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:35:33 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49841C061793;
        Wed, 27 Jan 2021 15:34:09 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b17so2052280plz.6;
        Wed, 27 Jan 2021 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjfIUTm7EyLVGh5kUmhdOqVLNJ4R1Pj2IbptP7JZXIY=;
        b=CJGu6zGoPLDDnlpgOZuwWPp5CWHGWPlM7mMwoQ0ox5SqOSYYVS5mq9g8fqQEiW9V2H
         XgRxKyb1+rTefGeCguck/SZyFuSAXs9DnQjGQNpl7we4T/YKjYZ6uBdDkb7EEc4X4PtM
         YbK8jzIXjJKyq5w27JRArLsiyxFfepRLTdq45qlJjRtNOZlzqqJNcdVlhKFb0gwGOhBg
         F2eMiUlzjiGI0mhL3gz2cEG1CL50nND1/42YUNuOgIRDVnxffBzoI4DueKCvpPn+pU3S
         CdqkmaTB+n0BgXDkuJ5F1ufWkQOxEnzai+vb7GmdMYUCRcvdAnxn3GeG+MJZK4K1leYE
         4Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjfIUTm7EyLVGh5kUmhdOqVLNJ4R1Pj2IbptP7JZXIY=;
        b=kbH1+AG54ZKF7uoioLkr9MQ38A0s0ykMOMJwVYosTxkwmqC3UpPw9i9paGNOEe4ozI
         KPt5PU4alPHkZdpEKvg4qIL7A4i+3WrTqarkasbjZwEWgHf210zvkdn21eeKBs5ZagUH
         9VFi8Ax+L5K1MFFezcFoQlY51LwSL1Bax1ascY+iitLXcJ7hq8IgQdMlhKoGM0mCmPtF
         w5oE5O356y3fokg4EA94fPR2ljwoLN+kqkkYwgdlPlggARBgFH7BSl9Ordf/YUTReAxf
         CYXmPqbh5AkPUUlz+fApdDKKcs+t3sd58N2vvt4N99ghyoT0eGvAFIRQLPGo95CsNneE
         JJUQ==
X-Gm-Message-State: AOAM5327fNag9bVcWVT7CK+hj5shG2apmloxqE3WHHvB5QbDKpEcGm3U
        i8uGSeAqSS6A1dEuuEQ1GAw=
X-Google-Smtp-Source: ABdhPJx+sxQ8J5zuiqS4QK0aWVfSSOBe71N3VVys+iKEeQQxQLYUqN96B/84mTeDUBCUzzatPEJ2fQ==
X-Received: by 2002:a17:90a:da02:: with SMTP id e2mr8105516pjv.173.1611790448927;
        Wed, 27 Jan 2021 15:34:08 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 124sm3498648pfd.59.2021.01.27.15.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:34:08 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of shrinker
Date:   Wed, 27 Jan 2021 15:33:42 -0800
Message-Id: <20210127233345.339910-9-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127233345.339910-1-shy828301@gmail.com>
References: <20210127233345.339910-1-shy828301@gmail.com>
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
 mm/vmscan.c | 87 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 20be0db291fe..e1f8960f5cf6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -205,7 +205,8 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 
 	for_each_node(nid) {
 		old = rcu_dereference_protected(
-			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
+			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info,
+			lockdep_is_held(&shrinker_rwsem));
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
@@ -239,7 +240,8 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
-		info = rcu_dereference_protected(pn->shrinker_info, true);
+		info = rcu_dereference_protected(pn->shrinker_info,
+						 lockdep_is_held(&shrinker_rwsem));
 		if (info)
 			kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
@@ -360,6 +362,27 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 	up_write(&shrinker_rwsem);
 }
 
+static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
+				    struct mem_cgroup *memcg)
+{
+	struct shrinker_info *info;
+
+	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 lockdep_is_held(&shrinker_rwsem));
+	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
+}
+
+static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
+				  struct mem_cgroup *memcg)
+{
+	struct shrinker_info *info;
+
+	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 lockdep_is_held(&shrinker_rwsem));
+
+	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
+}
+
 static bool cgroup_reclaim(struct scan_control *sc)
 {
 	return sc->target_mem_cgroup;
@@ -398,6 +421,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
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
@@ -409,6 +444,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
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
@@ -545,14 +613,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -562,7 +626,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * and zero it so that other concurrent shrinker invocations
 	 * don't also do this scanning work.
 	 */
-	nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
+	nr = count_nr_deferred(shrinker, shrinkctl);
 
 	total_scan = nr;
 	if (shrinker->seeks) {
@@ -653,14 +717,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

