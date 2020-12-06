Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC42D01E3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgLFIdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgLFIdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:33:10 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7064C08E863
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:32:05 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l11so5531886plt.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lP6NOXY9P1Y1tdnLUE8WJ9oCZQOprYuVn3yHjkNbfog=;
        b=EXcZ7sDghEHanmw7oN1QvmiFqdNgVMPn4nxp5QrGV7ENEoDYwofyu11Px+/NibCKAf
         fmyDb/uqNjxbGizqa2LrxwD13xo7YmNycDZvWPARPTKLARWA/9ZWeJQJtRccj0B5wy+S
         h6zBOQpoOfi6JblccslS0e8TdwLvzMpIv8ZO+uQ7RJxaRXZmyQoUD5vmhOeGU/VuGl1N
         XttH3IKOla/ZAbSTwpsejWyqi86ar9zjgUH56qfCAp6qtLvH4E5rqoVgYJJW6lq1i6Mh
         Ftzp9nx4AFEkD2MKP2r0mJMHYeu2nmvkFpu64metQYT24FytfEiSGhDt/V2LgBObhBlQ
         jb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lP6NOXY9P1Y1tdnLUE8WJ9oCZQOprYuVn3yHjkNbfog=;
        b=FmxpEB2X2BezFBX5NdsK661GrxyESZJPjoS4z+wZBUnLs42CroJNGyaYK2q03uQ7lH
         weKs4Uflo6rFjVSzBSa0FYjK6DV6pbQCHWboGcLpCYvZwl48Ln9tZFRWUPT9M6MWas3E
         lZPUWdBo1o5cd3eJJA9/22UcL9QmcCJ0nE0DHog6xzdrbUXyfpWGU2E5U9hKnPFTe0jJ
         oK2X8GQD29G8wevwmxWjAXIqjjVYL6M/f5UyWlC2VpJAiAIwR0wNvAbr4HFZPbtuanU6
         JuJZjBjcvXj635E+InRCddiEtWjNzRuGLmaRrcxn6uW3SgdlNGe3jtfVDtciKEe0npSX
         KZdg==
X-Gm-Message-State: AOAM531xNulmdYKGrfzmy++yWkD2ZmDTtlQ7GQz3aiH9kGaPY8RoFNlr
        IvKkM9fsyyTJ6MFP/27AqqcVZg==
X-Google-Smtp-Source: ABdhPJwfN8K8E4tC4ljKBXcesQmCoi2n20gNTIjFvrvBhaPpV6baXBdLdTDzByNenjoMaa1RhWAeiQ==
X-Received: by 2002:a17:902:8bcb:b029:d9:d765:d7f3 with SMTP id r11-20020a1709028bcbb02900d9d765d7f3mr10785319plo.69.1607243525364;
        Sun, 06 Dec 2020 00:32:05 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id c2sm10229107pfa.59.2020.12.06.00.31.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:32:04 -0800 (PST)
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
Subject: [PATCH v2 12/12] mm: memcontrol: remove {global_}node_page_state_pages
Date:   Sun,  6 Dec 2020 16:29:48 +0800
Message-Id: <20201206082948.11812-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082948.11812-1-songmuchun@bytedance.com>
References: <20201206082948.11812-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now the unit of the vmstat counters are either pages or bytes. So we can
adjust the node_page_state to always returns values in pages and remove
the node_page_state_pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c     | 10 +++++-----
 fs/proc/meminfo.c       | 12 ++++++------
 include/linux/vmstat.h  | 17 +----------------
 kernel/power/snapshot.c |  2 +-
 mm/oom_kill.c           |  2 +-
 mm/page_alloc.c         | 10 +++++-----
 mm/vmscan.c             |  2 +-
 mm/vmstat.c             | 23 ++++++-----------------
 8 files changed, 26 insertions(+), 52 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index bc01ce0b2fcd..42298e3552e5 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -374,8 +374,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 	unsigned long sreclaimable, sunreclaimable;
 
 	si_meminfo_node(&i, nid);
-	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
-	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
+	sreclaimable = node_page_state(pgdat, NR_SLAB_RECLAIMABLE_B);
+	sunreclaimable = node_page_state(pgdat, NR_SLAB_UNRECLAIMABLE_B);
 	len = sysfs_emit_at(buf, len,
 			    "Node %d MemTotal:       %8lu kB\n"
 			    "Node %d MemFree:        %8lu kB\n"
@@ -446,9 +446,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_FILE_MAPPED)),
 			     nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 			     nid, K(i.sharedram),
-			     nid, node_page_state(pgdat, NR_KERNEL_STACK_B) / SZ_1K,
+			     nid, K(node_page_state(pgdat, NR_KERNEL_STACK_B)),
 #ifdef CONFIG_SHADOW_CALL_STACK
-			     nid, node_page_state(pgdat, NR_KERNEL_SCS_B) / SZ_1K,
+			     nid, K(node_page_state(pgdat, NR_KERNEL_SCS_B)),
 #endif
 			     nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
 			     nid, 0UL,
@@ -517,7 +517,7 @@ static ssize_t node_read_vmstat(struct device *dev,
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 		len += sysfs_emit_at(buf, len, "%s %lu\n",
 				     node_stat_name(i),
-				     node_page_state_pages(pgdat, i));
+				     node_page_state(pgdat, i));
 
 	return len;
 }
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 69895e83d4fc..95ea5f062161 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -52,8 +52,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
 
 	available = si_mem_available();
-	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
-	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
+	sreclaimable = global_node_page_state(NR_SLAB_RECLAIMABLE_B);
+	sunreclaim = global_node_page_state(NR_SLAB_UNRECLAIMABLE_B);
 
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
@@ -100,11 +100,11 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
 	show_val_kb(m, "SReclaimable:   ", sreclaimable);
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
-	seq_printf(m, "KernelStack:    %8lu kB\n",
-		   global_node_page_state(NR_KERNEL_STACK_B) / SZ_1K);
+	show_val_kb(m, "KernelStack:    ",
+		    global_node_page_state(NR_KERNEL_STACK_B));
 #ifdef CONFIG_SHADOW_CALL_STACK
-	seq_printf(m, "ShadowCallStack:%8lu kB\n",
-		   global_node_page_state(NR_KERNEL_SCS_B) / SZ_1K);
+	show_val_kb(m, "ShadowCallStack:",
+		    global_node_page_state(NR_KERNEL_SCS_B));
 #endif
 	show_val_kb(m, "PageTables:     ",
 		    global_zone_page_state(NR_PAGETABLE));
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index afd84dc2398c..ae821e016fdd 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -193,8 +193,7 @@ static inline unsigned long global_zone_page_state(enum zone_stat_item item)
 	return x;
 }
 
-static inline
-unsigned long global_node_page_state_pages(enum node_stat_item item)
+static inline unsigned long global_node_page_state(enum node_stat_item item)
 {
 	long x = atomic_long_read(&vm_node_stat[item]);
 
@@ -207,17 +206,6 @@ unsigned long global_node_page_state_pages(enum node_stat_item item)
 	return x;
 }
 
-static inline unsigned long global_node_page_state(enum node_stat_item item)
-{
-	long x = atomic_long_read(&vm_node_stat[item]);
-
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
-}
-
 static inline unsigned long zone_page_state(struct zone *zone,
 					enum zone_stat_item item)
 {
@@ -258,12 +246,9 @@ extern unsigned long sum_zone_node_page_state(int node,
 extern unsigned long sum_zone_numa_state(int node, enum numa_stat_item item);
 extern unsigned long node_page_state(struct pglist_data *pgdat,
 						enum node_stat_item item);
-extern unsigned long node_page_state_pages(struct pglist_data *pgdat,
-					   enum node_stat_item item);
 #else
 #define sum_zone_node_page_state(node, item) global_zone_page_state(item)
 #define node_page_state(node, item) global_node_page_state(item)
-#define node_page_state_pages(node, item) global_node_page_state_pages(item)
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_SMP
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d63560e1cf87..664520bdaa20 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1705,7 +1705,7 @@ static unsigned long minimum_image_size(unsigned long saveable)
 {
 	unsigned long size;
 
-	size = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B)
+	size = global_node_page_state(NR_SLAB_RECLAIMABLE_B)
 		+ global_node_page_state(NR_ACTIVE_ANON)
 		+ global_node_page_state(NR_INACTIVE_ANON)
 		+ global_node_page_state(NR_ACTIVE_FILE)
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 04b19b7b5435..73861473c7d4 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -188,7 +188,7 @@ static bool should_dump_unreclaim_slab(void)
 		 global_node_page_state(NR_ISOLATED_FILE) +
 		 global_node_page_state(NR_UNEVICTABLE);
 
-	return (global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B) > nr_lru);
+	return (global_node_page_state(NR_SLAB_UNRECLAIMABLE_B) > nr_lru);
 }
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 58916b3afdab..d16c9388c0b8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5372,7 +5372,7 @@ long si_mem_available(void)
 	 * items that are in use, and cannot be freed. Cap this estimate at the
 	 * low watermark.
 	 */
-	reclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) +
+	reclaimable = global_node_page_state(NR_SLAB_RECLAIMABLE_B) +
 		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
 	available += reclaimable - min(reclaimable / 2, wmark_low);
 
@@ -5516,8 +5516,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		global_node_page_state(NR_UNEVICTABLE),
 		global_node_page_state(NR_FILE_DIRTY),
 		global_node_page_state(NR_WRITEBACK),
-		global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B),
-		global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
+		global_node_page_state(NR_SLAB_RECLAIMABLE_B),
+		global_node_page_state(NR_SLAB_UNRECLAIMABLE_B),
 		global_node_page_state(NR_FILE_MAPPED),
 		global_node_page_state(NR_SHMEM),
 		global_zone_page_state(NR_PAGETABLE),
@@ -5572,9 +5572,9 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
-			node_page_state(pgdat, NR_KERNEL_STACK_B) / SZ_1K,
+			K(node_page_state(pgdat, NR_KERNEL_STACK_B)),
 #ifdef CONFIG_SHADOW_CALL_STACK
-			node_page_state(pgdat, NR_KERNEL_SCS_B) / SZ_1K,
+			K(node_page_state(pgdat, NR_KERNEL_SCS_B)),
 #endif
 			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
 				"yes" : "no");
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 469016222cdb..5d3c8fa68979 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4220,7 +4220,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 	 * unmapped file backed pages.
 	 */
 	if (node_pagecache_reclaimable(pgdat) <= pgdat->min_unmapped_pages &&
-	    node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B) <=
+	    node_page_state(pgdat, NR_SLAB_RECLAIMABLE_B) <=
 	    pgdat->min_slab_pages)
 		return NODE_RECLAIM_FULL;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 25751b1d8e2e..b7cdef585efd 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1000,22 +1000,9 @@ unsigned long sum_zone_numa_state(int node,
 }
 
 /*
- * Determine the per node value of a stat item.
+ * Determine the per node value of a stat item. This always returns
+ * values in pages.
  */
-unsigned long node_page_state_pages(struct pglist_data *pgdat,
-				    enum node_stat_item item)
-{
-	long x = atomic_long_read(&pgdat->vm_stat[item]);
-
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	if (vmstat_item_in_bytes(item))
-		x >>= PAGE_SHIFT;
-	return x;
-}
-
 unsigned long node_page_state(struct pglist_data *pgdat,
 			      enum node_stat_item item)
 {
@@ -1025,6 +1012,8 @@ unsigned long node_page_state(struct pglist_data *pgdat,
 	if (x < 0)
 		x = 0;
 #endif
+	if (vmstat_item_in_bytes(item))
+		x >>= PAGE_SHIFT;
 	return x;
 }
 #endif
@@ -1626,7 +1615,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		seq_printf(m, "\n  per-node stats");
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
 			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
-				   node_page_state_pages(pgdat, i));
+				   node_page_state(pgdat, i));
 		}
 	}
 	seq_printf(m,
@@ -1747,7 +1736,7 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 #endif
 
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		v[i] = global_node_page_state_pages(i);
+		v[i] = global_node_page_state(i);
 	v += NR_VM_NODE_STAT_ITEMS;
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
-- 
2.11.0

