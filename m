Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2237E2D6F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 05:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395395AbgLKEYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 23:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395370AbgLKEY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 23:24:27 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59FC0617B0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:18 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id l23so1679497pjg.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 20:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cU/HrVcwfM3LPFm4rjOQAH8JdzbfJ+ZpL7D7Ks2Uco0=;
        b=tih4ZHbKA0YgssVEixNJ0hUNRlQ83ass+bYW1yuu3v27Qw+hZwKiLO7xMEW7V9iGfo
         CL+A5/3YoVRnB1m1CfbOvvdxL6uiv1v8CvG7gKw4Lqm6dLgN8Ih0dD9pkJVjxa2DsOGp
         HjsANWSDU0LDkKJLCdqXKHlEN7jTGU+zJDrDwyUVrV9i4kCXKTXRf2tAU81mxiMaCZ3J
         wJj9xeB0NYehtyC1FQ1pBreTX1nJiWNTjK4sEq6AQHFSwQuLlbadTYekoPpxVHudgs4W
         Ko1GxshKle2QfTsP0MSzCxmnG8MEgEHist32cC9QtFWhohA01FbOh+c+Aayw1n7tTkbJ
         9gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cU/HrVcwfM3LPFm4rjOQAH8JdzbfJ+ZpL7D7Ks2Uco0=;
        b=Fbccfm7GqW4rQxZ+FY+QqXBHsS6DTm0pJPsQb+sEKjWDmdBvieQXTFzkDC0vwHAbIM
         lLdChP80xz8WmsXv5trz6AXNqkTUwV1C29HVlgjymdc2IrdfsSFrp8LtG80f1CxPmeWI
         V6mbNe3U3cn6AqScoB4Soxh/tdUnGMm+EP0ldewwEKHGk/+5DqJ5K7/k7KTRHteC7SKG
         TjzPSr9bqZJLCIgz6mcFx/FcMC7a8aezOIAEsPIO7R2gNY4XjB5K6NJYiltVUNAmWg2I
         9cyrZeaIVSP9Wm4554aKzBZOmEb3+cGZiueR72X/9CCMVPyMf7rQSI+XC1qPFmjBptcQ
         n/zA==
X-Gm-Message-State: AOAM530hpq1m/Hq94XJgNiYfsW50pD7ewSB5uTN65YOdhsg/qUc806h1
        ysMqYmnpukKO3DI5U1yrDQtD3Q==
X-Google-Smtp-Source: ABdhPJwvRIgVYH8myVTOip532m/G1DHFdQPbkxnk9Pu1iXGs/BxE4LZolQ+5F26TEiO0j8O5CqF9nQ==
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr11374155pjb.172.1607660597400;
        Thu, 10 Dec 2020 20:23:17 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id 19sm8623352pfu.85.2020.12.10.20.23.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 20:23:16 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 2/7] mm: memcontrol: convert NR_ANON_THPS account to pages
Date:   Fri, 11 Dec 2020 12:19:49 +0800
Message-Id: <20201211041954.79543-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201211041954.79543-1-songmuchun@bytedance.com>
References: <20201211041954.79543-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The unit of NR_ANON_THPS is HPAGE_PMD_NR. Convert the NR_ANON_THPS
account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 15 +++++++++------
 fs/proc/meminfo.c      |  2 +-
 include/linux/mmzone.h |  9 +++++++++
 mm/huge_memory.c       |  3 ++-
 mm/memcontrol.c        | 20 ++++++--------------
 mm/page_alloc.c        |  2 +-
 mm/rmap.c              |  7 ++++---
 mm/vmstat.c            | 11 +++++++++--
 8 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 04f71c7bc3f8..6da0c3508bc9 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -461,8 +461,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(sunreclaimable)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     ,
-			     nid, K(node_page_state(pgdat, NR_ANON_THPS) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
 				    HPAGE_PMD_NR),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
@@ -519,10 +518,14 @@ static ssize_t node_read_vmstat(struct device *dev,
 				     sum_zone_numa_state(nid, i));
 
 #endif
-	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		len += sysfs_emit_at(buf, len, "%s %lu\n",
-				     node_stat_name(i),
-				     node_page_state_pages(pgdat, i));
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		unsigned long pages = node_page_state_pages(pgdat, i);
+
+		if (vmstat_item_print_in_thp(i))
+			pages /= HPAGE_PMD_NR;
+		len += sysfs_emit_at(buf, len, "%s %lu\n", node_stat_name(i),
+				     pages);
+	}
 
 	return len;
 }
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index d6fc74619625..a635c8a84ddf 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -129,7 +129,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	show_val_kb(m, "AnonHugePages:  ",
-		    global_node_page_state(NR_ANON_THPS) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_ANON_THPS));
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
 	show_val_kb(m, "ShmemPmdMapped: ",
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..4ac95448421c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -210,6 +210,15 @@ enum node_stat_item {
 };
 
 /*
+ * Returns true if the item should prints in THPs. The /proc/vmstat currently
+ * prints number of anon, file and shmem THPs. But the item is charged in pages.
+ */
+static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
+{
+	return item == NR_ANON_THPS;
+}
+
+/*
  * Returns true if the value is measured in bytes (most vmstat values are
  * measured in pages). This defines the API part, the internal representation
  * might be different.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 10dd3cae5f53..66ec454120de 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2178,7 +2178,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		lock_page_memcg(page);
 		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
 			/* Last compound_mapcount is gone. */
-			__dec_lruvec_page_state(page, NR_ANON_THPS);
+			__mod_lruvec_page_state(page, NR_ANON_THPS,
+						-HPAGE_PMD_NR);
 			if (TestClearPageDoubleMap(page)) {
 				/* No need in mapcount reference anymore */
 				for (i = 0; i < HPAGE_PMD_NR; i++)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8818bf64d6fe..b18e25a5cdf3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1532,7 +1532,7 @@ static struct memory_stat memory_stats[] = {
 	 * on some architectures, the macro of HPAGE_PMD_SIZE is not
 	 * constant(e.g. powerpc).
 	 */
-	{ "anon_thp", 0, NR_ANON_THPS },
+	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
 	{ "file_thp", 0, NR_FILE_THPS },
 	{ "shmem_thp", 0, NR_SHMEM_THPS },
 #endif
@@ -1565,8 +1565,7 @@ static int __init memory_stats_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_ANON_THPS ||
-		    memory_stats[i].idx == NR_FILE_THPS ||
+		if (memory_stats[i].idx == NR_FILE_THPS ||
 		    memory_stats[i].idx == NR_SHMEM_THPS)
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
 #endif
@@ -4088,10 +4087,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memcg1_stats[i] == NR_ANON_THPS)
-			nr *= HPAGE_PMD_NR;
-#endif
 		seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
 	}
 
@@ -4122,10 +4117,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state(memcg, memcg1_stats[i]);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memcg1_stats[i] == NR_ANON_THPS)
-			nr *= HPAGE_PMD_NR;
-#endif
 		seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
 						(u64)nr * PAGE_SIZE);
 	}
@@ -5653,10 +5644,11 @@ static int mem_cgroup_move_account(struct page *page,
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
 			if (PageTransHuge(page)) {
-				__dec_lruvec_state(from_vec, NR_ANON_THPS);
-				__inc_lruvec_state(to_vec, NR_ANON_THPS);
+				__mod_lruvec_state(from_vec, NR_ANON_THPS,
+						   -nr_pages);
+				__mod_lruvec_state(to_vec, NR_ANON_THPS,
+						   nr_pages);
 			}
-
 		}
 	} else {
 		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 469e28f95ce7..1700f52b7869 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5580,7 +5580,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
 					* HPAGE_PMD_NR),
-			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
 			node_page_state(pgdat, NR_KERNEL_STACK_KB),
diff --git a/mm/rmap.c b/mm/rmap.c
index 08c56aaf72eb..f59e92e26b61 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1144,7 +1144,8 @@ void do_page_add_anon_rmap(struct page *page,
 		 * disabled.
 		 */
 		if (compound)
-			__inc_lruvec_page_state(page, NR_ANON_THPS);
+			__mod_lruvec_page_state(page, NR_ANON_THPS,
+						HPAGE_PMD_NR);
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
 
@@ -1186,7 +1187,7 @@ void page_add_new_anon_rmap(struct page *page,
 		if (hpage_pincount_available(page))
 			atomic_set(compound_pincount_ptr(page), 0);
 
-		__inc_lruvec_page_state(page, NR_ANON_THPS);
+		__mod_lruvec_page_state(page, NR_ANON_THPS, HPAGE_PMD_NR);
 	} else {
 		/* Anon THP always mapped first with PMD */
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
@@ -1292,7 +1293,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return;
 
-	__dec_lruvec_page_state(page, NR_ANON_THPS);
+	__mod_lruvec_page_state(page, NR_ANON_THPS, -HPAGE_PMD_NR);
 
 	if (TestClearPageDoubleMap(page)) {
 		/*
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 663f49ed1fd6..37c9e7b21e1e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1624,8 +1624,12 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	if (is_zone_first_populated(pgdat, zone)) {
 		seq_printf(m, "\n  per-node stats");
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+			unsigned long pages = node_page_state_pages(pgdat, i);
+
+			if (vmstat_item_print_in_thp(i))
+				pages /= HPAGE_PMD_NR;
 			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
-				   node_page_state_pages(pgdat, i));
+				   pages);
 		}
 	}
 	seq_printf(m,
@@ -1745,8 +1749,11 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 	v += NR_VM_NUMA_STAT_ITEMS;
 #endif
 
-	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
 		v[i] = global_node_page_state_pages(i);
+		if (vmstat_item_print_in_thp(i))
+			v[i] /= HPAGE_PMD_NR;
+	}
 	v += NR_VM_NODE_STAT_ITEMS;
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
-- 
2.11.0

