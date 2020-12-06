Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568C42D02A5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgLFKTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLFKTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:19:01 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D94EC0613D4
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:18:40 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id p4so1132692pfg.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lP6NOXY9P1Y1tdnLUE8WJ9oCZQOprYuVn3yHjkNbfog=;
        b=ZcB+MrFfITKTQD6yHNcSXXGhcuAfJVfq9Vc0JYQrQO8x+y4QfNb3GbTp1Bw/q0Xh1C
         SRPp2uOrMxEWh2MTi3HsJw/K2uDSI7BPt7W9VaUyVAlrworEQCgS3w0i4ICgyZ0NW2Zx
         rpIPH2IBLP/NecuXoWwQwHU8HJfMMqjmeilA0qISzpe3Ua5VcpfB1uHFE8rwuzE/+BBu
         dU61wVmkRUSnIPY6q3zmuFpZhfYSc1xyARC+ZWy/++zR4K0ULoqC3Ec/hYdfb+kc7cKa
         6FL91dJW9nMFXkchdG699Ol55L2kOxnfCBh+PsPo6Ib+GHG2WmGfHHoPHmJdZUhbgFZi
         R05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lP6NOXY9P1Y1tdnLUE8WJ9oCZQOprYuVn3yHjkNbfog=;
        b=UYjS03Idbnu6RLPMjqnGq9I+gzkGCr7MtCB4v6h4M3VK8df9HWDMe50zErNRMHKrbA
         tAgJR++Wi4FJ6DuTfI0XhmdN04jLbfIu0v2hcThwRmyds+MvH3lKVQIFyC4MGdLNgZ4e
         zAMxa4dhMOCXoDCF0dw9hZjuPuWjiplxy8Cs4/UDP7gpCPOPY3nYEIKkRqA3JGScpYxv
         Sn3hXy9zyemDDa9/yvF+VPr7z7fCX0oRJqKsCqfDpRlC7Tnzs0u2Dst4F8G1wyEFncOf
         2wok1HuUsMMJUbhKgP3B8v/RfEcj9kjxONDKkyXV8ZNkzGHQu+eo3Dr39t+z4qwJd7qW
         LsNA==
X-Gm-Message-State: AOAM533U6oxIwhgKXjwTrKU/Hlj5ggVmCYloJWOl7wr68c3a5iUoaTL6
        PORMi1ISIve/dhtsiaV5Rqnedw==
X-Google-Smtp-Source: ABdhPJyTR5IEC8wjJwZanqPdp0TYqYuwBV1k98LMJDgi/aO+lbtgHvOt9jKwuJZe7B/Wxcytd89bHw==
X-Received: by 2002:aa7:991c:0:b029:19d:b276:1ecb with SMTP id z28-20020aa7991c0000b029019db2761ecbmr11518358pff.73.1607249919971;
        Sun, 06 Dec 2020 02:18:39 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:18:39 -0800 (PST)
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
Subject: [RESEND PATCH v2 12/12] mm: memcontrol: remove {global_}node_page_state_pages
Date:   Sun,  6 Dec 2020 18:14:51 +0800
Message-Id: <20201206101451.14706-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
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

