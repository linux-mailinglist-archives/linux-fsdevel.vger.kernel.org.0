Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC957858A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjHWNO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbjHWNOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:14:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 524A210EC;
        Wed, 23 Aug 2023 06:14:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85FE01570;
        Wed, 23 Aug 2023 06:15:21 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B54533F740;
        Wed, 23 Aug 2023 06:14:34 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC 05/37] mm: Add memory statistics for the MIGRATE_METADATA allocation policy
Date:   Wed, 23 Aug 2023 14:13:18 +0100
Message-Id: <20230823131350.114942-6-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823131350.114942-1-alexandru.elisei@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep track of the total number of metadata pages available in the system,
as well as the per-zone pages.

Opportunistically add braces to an "if" block from rmqueue_bulk() where
the body contains multiple lines of code.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 fs/proc/meminfo.c                     |  8 ++++++++
 include/asm-generic/memory_metadata.h |  2 ++
 include/linux/mmzone.h                | 13 +++++++++++++
 include/linux/vmstat.h                |  2 ++
 mm/page_alloc.c                       | 18 +++++++++++++++++-
 mm/page_owner.c                       |  3 ++-
 mm/show_mem.c                         |  4 ++++
 mm/vmstat.c                           |  8 ++++++--
 8 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 8dca4d6d96c7..c9970860b5be 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -17,6 +17,9 @@
 #ifdef CONFIG_CMA
 #include <linux/cma.h>
 #endif
+#ifdef CONFIG_MEMORY_METADATA
+#include <asm/memory_metadata.h>
+#endif
 #include <asm/page.h>
 #include "internal.h"
 
@@ -167,6 +170,11 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "CmaFree:        ",
 		    global_zone_page_state(NR_FREE_CMA_PAGES));
 #endif
+#ifdef CONFIG_MEMORY_METADATA
+	show_val_kb(m, "MetadataTotal:  ", totalmetadata_pages);
+	show_val_kb(m, "MetadataFree:   ",
+		    global_zone_page_state(NR_FREE_METADATA_PAGES));
+#endif
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	show_val_kb(m, "Unaccepted:     ",
diff --git a/include/asm-generic/memory_metadata.h b/include/asm-generic/memory_metadata.h
index dc0c84408a8e..63ea661b354d 100644
--- a/include/asm-generic/memory_metadata.h
+++ b/include/asm-generic/memory_metadata.h
@@ -4,6 +4,8 @@
 
 #include <linux/gfp.h>
 
+extern unsigned long totalmetadata_pages;
+
 #ifndef CONFIG_MEMORY_METADATA
 static inline bool metadata_storage_enabled(void)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 74925806687e..48c237248d87 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -160,6 +160,7 @@ enum zone_stat_item {
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	NR_UNACCEPTED,
 #endif
+	NR_FREE_METADATA_PAGES,
 	NR_VM_ZONE_STAT_ITEMS };
 
 enum node_stat_item {
@@ -914,6 +915,9 @@ struct zone {
 #ifdef CONFIG_CMA
 	unsigned long		cma_pages;
 #endif
+#ifdef CONFIG_MEMORY_METADATA
+	unsigned long 		metadata_pages;
+#endif
 
 	const char		*name;
 
@@ -1026,6 +1030,15 @@ static inline unsigned long zone_cma_pages(struct zone *zone)
 #endif
 }
 
+static inline unsigned long zone_metadata_pages(struct zone *zone)
+{
+#ifdef CONFIG_MEMORY_METADATA
+	return zone->metadata_pages;
+#else
+	return 0;
+#endif
+}
+
 static inline unsigned long zone_end_pfn(const struct zone *zone)
 {
 	return zone->zone_start_pfn + zone->spanned_pages;
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fed855bae6d8..15aa069df6b1 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -493,6 +493,8 @@ static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
 	__mod_zone_page_state(zone, NR_FREE_PAGES, nr_pages);
 	if (is_migrate_cma(migratetype))
 		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
+	if (is_migrate_metadata(migratetype))
+		__mod_zone_page_state(zone, NR_FREE_METADATA_PAGES, nr_pages);
 }
 
 extern const char * const vmstat_text[];
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7baa78abf351..829134a4dfa8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2202,9 +2202,14 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * pages are ordered properly.
 		 */
 		list_add_tail(&page->pcp_list, list);
-		if (is_migrate_cma(get_pcppage_migratetype(page)))
+		if (is_migrate_cma(get_pcppage_migratetype(page))) {
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
 					      -(1 << order));
+		}
+		if (is_migrate_metadata(get_pcppage_migratetype(page))) {
+			__mod_zone_page_state(zone, NR_FREE_METADATA_PAGES,
+					      -(1 << order));
+		}
 	}
 
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
@@ -2894,6 +2899,10 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	unusable_free += zone_page_state(z, NR_UNACCEPTED);
 #endif
+#ifdef CONFIG_MEMORY_METADATA
+	if (!(alloc_flags & ALLOC_FROM_METADATA))
+		unusable_free += zone_page_state(z, NR_FREE_METADATA_PAGES);
+#endif
 
 	return unusable_free;
 }
@@ -2974,6 +2983,13 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			return true;
 		}
 #endif
+
+#ifdef CONFIG_MEMORY_METADATA
+		if ((alloc_flags & ALLOC_FROM_METADATA) &&
+		    !free_area_empty(area, MIGRATE_METADATA)) {
+			return true;
+		}
+#endif
 		if ((alloc_flags & (ALLOC_HIGHATOMIC|ALLOC_OOM)) &&
 		    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
 			return true;
diff --git a/mm/page_owner.c b/mm/page_owner.c
index c93baef0148f..c66e25536068 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -333,7 +333,8 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 			page_owner = get_page_owner(page_ext);
 			page_mt = gfp_migratetype(page_owner->gfp_mask);
 			if (pageblock_mt != page_mt) {
-				if (is_migrate_cma(pageblock_mt))
+				if (is_migrate_cma(pageblock_mt) ||
+				    is_migrate_metadata(pageblock_mt))
 					count[MIGRATE_MOVABLE]++;
 				else
 					count[pageblock_mt]++;
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 01f8e9905817..3935410c98ac 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -22,6 +22,7 @@ atomic_long_t _totalram_pages __read_mostly;
 EXPORT_SYMBOL(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
+unsigned long totalmetadata_pages __read_mostly;
 
 static inline void show_node(struct zone *zone)
 {
@@ -423,6 +424,9 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 #ifdef CONFIG_CMA
 	printk("%lu pages cma reserved\n", totalcma_pages);
 #endif
+#ifdef CONFIG_MEMORY_METADATA
+	printk("%lu pages metadata reserved\n", totalmetadata_pages);
+#endif
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b731d57996c5..07caa284a724 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1184,6 +1184,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	"nr_unaccepted",
 #endif
+	"nr_free_metadata",
 
 	/* enum numa_stat_item counters */
 #ifdef CONFIG_NUMA
@@ -1695,7 +1696,8 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   "\n        spanned  %lu"
 		   "\n        present  %lu"
 		   "\n        managed  %lu"
-		   "\n        cma      %lu",
+		   "\n        cma      %lu"
+		   "\n        metadata %lu",
 		   zone_page_state(zone, NR_FREE_PAGES),
 		   zone->watermark_boost,
 		   min_wmark_pages(zone),
@@ -1704,7 +1706,8 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   zone->spanned_pages,
 		   zone->present_pages,
 		   zone_managed_pages(zone),
-		   zone_cma_pages(zone));
+		   zone_cma_pages(zone),
+		   zone_metadata_pages(zone));
 
 	seq_printf(m,
 		   "\n        protection: (%ld",
@@ -1909,6 +1912,7 @@ int vmstat_refresh(struct ctl_table *table, int write,
 		switch (i) {
 		case NR_ZONE_WRITE_PENDING:
 		case NR_FREE_CMA_PAGES:
+		case NR_FREE_METADATA_PAGES:
 			continue;
 		}
 		val = atomic_long_read(&vm_zone_stat[i]);
-- 
2.41.0

