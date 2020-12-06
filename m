Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF66A2D029D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgLFKSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgLFKSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:18:39 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B14C08E861
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:18:23 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x15so5596201pll.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cL9BVbVQLgAGW6GpXAhL1X3CA8w9xPKU91tirmQZrTs=;
        b=0MtFDJWkKOQQMDcBAWzMx6gdC5YkqHBAIYhp+BQWqaLCRwKSjpNgXt0q+GE5YDnhq7
         zZlx16g/g5Hty2Kbo00woChd1R2HTbXvLREFGr+dgsJNg5wqsoVf732VjIl8t0tx/guG
         xKJjwyDtJ23mJ3u2LiGrZt8158SzBOEHqu1EONODMauwN44TsNCh+5mOLcjf6KWCRj+Q
         PpDhsHo4azjOMj55FDu9gE2qP5mrbjysGxlYeo4D7bHzSkfdcbJN0sB1YfNpHorDM+rk
         KTXv8MboLM+aP9XEdWHdigIwbkC+YMT4rLQKIz5VS8XacdkjzRDyPoEiVJiUVpjvTk70
         B/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cL9BVbVQLgAGW6GpXAhL1X3CA8w9xPKU91tirmQZrTs=;
        b=Z+3DuF0sffXEEN6gd+pDSy1MU3nnQL0/XeByYFV2mSf8IAa24wmWdIA2LAo6MiJyW9
         cVQ05FRslhJIFqKXLm9CPKZP/4IoNddpYu4/4bxRu5dCFNZeYClFcmwGz4GBoPTRbn4Z
         vGKcRA4QKszBQT1Pd242cyNkTyHbn76C11hmc2wzB+CWRSVzHUAVRDb+/NoxAKohzjLX
         K9YOxmYk3GHr+c+zV5HGE+Z2vaSxDN//DURdWyq0gCyRjHljpHkBWDbMyB6CEPj32kiz
         qis+zmxUNJG3W+CRps6LOHBPLZrU3i1dsKE+tCxyH/VQjaoKjb9hswfurEYVFOdni6xf
         e7iw==
X-Gm-Message-State: AOAM532/WwVtMOir/41vq3J2P4OzTcrLsJbfyKXmpkpn1Y3ptYoqWuHw
        7ikXnSAynpN8zh+cWAXA4wrMTA==
X-Google-Smtp-Source: ABdhPJz5DNYCSJVhDue++Ah/epNUxyRIwmJ9vSLViSgMOWI7q8z87Dx9FtBFYEBh1GWmEzjkBxvqzQ==
X-Received: by 2002:a17:902:b582:b029:d6:6008:264d with SMTP id a2-20020a170902b582b02900d66008264dmr11050550pls.80.1607249902812;
        Sun, 06 Dec 2020 02:18:22 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.18.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:18:22 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RESEND PATCH v2 10/12] mm: memcontrol: scale stat_threshold for byted-sized vmstat
Date:   Sun,  6 Dec 2020 18:14:49 +0800
Message-Id: <20201206101451.14706-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some vmstat counters are being accounted in bytes not pages, so the
stat_threshold should also scale to bytes.

The vmstat counters are already long type for memcg (can reference
to struct lruvec_stat). For the global per-node vmstat counters
also can scale to long. But the maximum vmstat threshold is 125,
so the type of s32 is enough.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h | 17 ++++++-----------
 include/linux/vmstat.h |  1 -
 mm/vmstat.c            | 24 +++++++++++++-----------
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1f9c83778629..d53328551225 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -216,17 +216,12 @@ enum node_stat_item {
  */
 static __always_inline bool vmstat_item_in_bytes(int idx)
 {
-	/*
-	 * Global and per-node slab counters track slab pages.
-	 * It's expected that changes are multiples of PAGE_SIZE.
-	 * Internally values are stored in pages.
-	 *
-	 * Per-memcg and per-lruvec counters track memory, consumed
-	 * by individual slab objects. These counters are actually
-	 * byte-precise.
-	 */
 	return (idx == NR_SLAB_RECLAIMABLE_B ||
-		idx == NR_SLAB_UNRECLAIMABLE_B);
+		idx == NR_SLAB_UNRECLAIMABLE_B ||
+#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
+		idx == NR_KERNEL_SCS_B ||
+#endif
+		idx == NR_KERNEL_STACK_B);
 }
 
 /*
@@ -340,7 +335,7 @@ struct per_cpu_pageset {
 
 struct per_cpu_nodestat {
 	s8 stat_threshold;
-	s8 vm_node_stat_diff[NR_VM_NODE_STAT_ITEMS];
+	s32 vm_node_stat_diff[NR_VM_NODE_STAT_ITEMS];
 };
 
 #endif /* !__GENERATING_BOUNDS.H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fd1a3d5d4926..afd84dc2398c 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -211,7 +211,6 @@ static inline unsigned long global_node_page_state(enum node_stat_item item)
 {
 	long x = atomic_long_read(&vm_node_stat[item]);
 
-	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 7fb0c7cb9516..25751b1d8e2e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -341,13 +341,15 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 				long delta)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
 	long x;
 	long t;
 
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
+	if (vmstat_item_in_bytes(item))
+		t <<= PAGE_SHIFT;
 
 	if (unlikely(abs(x) > t)) {
 		node_page_state_add(x, pgdat, item);
@@ -399,15 +401,15 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	s8 v, t;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 v, t;
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
-		s8 overstep = t >> 1;
+		s32 overstep = t >> 1;
 
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
@@ -445,8 +447,8 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	s8 v, t;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 v, t;
 
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
@@ -546,7 +548,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
        enum node_stat_item item, int delta, int overstep_mode)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
 	long o, n, t, z;
 
 	do {
@@ -563,6 +565,8 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		 * for all cpus in a node.
 		 */
 		t = this_cpu_read(pcp->stat_threshold);
+		if (vmstat_item_in_bytes(item))
+			t <<= PAGE_SHIFT;
 
 		o = this_cpu_read(*p);
 		n = delta + o;
@@ -829,7 +833,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		struct per_cpu_nodestat __percpu *p = pgdat->per_cpu_nodestats;
 
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			int v;
+			s32 v;
 
 			v = this_cpu_xchg(p->vm_node_stat_diff[i], 0);
 			if (v) {
@@ -899,7 +903,7 @@ void cpu_vm_stats_fold(int cpu)
 
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 			if (p->vm_node_stat_diff[i]) {
-				int v;
+				s32 v;
 
 				v = p->vm_node_stat_diff[i];
 				p->vm_node_stat_diff[i] = 0;
@@ -1017,8 +1021,6 @@ unsigned long node_page_state(struct pglist_data *pgdat,
 {
 	long x = atomic_long_read(&pgdat->vm_stat[item]);
 
-	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
-
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
-- 
2.11.0

