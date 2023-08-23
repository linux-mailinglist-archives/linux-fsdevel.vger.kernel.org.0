Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E777859DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjHWN4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjHWN4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:56:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37C15E45;
        Wed, 23 Aug 2023 06:56:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB6C41692;
        Wed, 23 Aug 2023 06:17:22 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EA123F740;
        Wed, 23 Aug 2023 06:16:36 -0700 (PDT)
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
Subject: [PATCH RFC 24/37] mm: page_alloc: Teach alloc_contig_range() about MIGRATE_METADATA
Date:   Wed, 23 Aug 2023 14:13:37 +0100
Message-Id: <20230823131350.114942-25-alexandru.elisei@arm.com>
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

alloc_contig_range() allocates a contiguous range of physical memory.
Metadata pages in use for data will have to be migrated and then taken from
the free lists when they are repurposed to store tags, and that will be
accomplished by calling alloc_contig_range().

The first step in alloc_contig_range() is to isolate the requested pages.
If the pages are part of a larger huge page, then the hugepage must be
split before the pages can be isolated. Add support for metadata pages in
isolate_single_pageblock().

__isolate_free_page() checks the WMARK_MIN watermark before deleting the
page from the free list. alloc_contig_range(), when called to allocate
MIGRATE_METADATA pages, ends up calling this function from
isolate_freepages_range() -> isolate_freepages_block(). As such, take into
account the number of free metadata pages when checking the watermark to
avoid false negatives.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 mm/compaction.c     |  4 ++--
 mm/page_alloc.c     |  9 +++++----
 mm/page_isolation.c | 19 +++++++++++++------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index af2ee3085623..314793ec8bdb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -46,7 +46,7 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
 #define count_compact_events(item, delta) do { } while (0)
 #endif
 
-#if defined CONFIG_COMPACTION || defined CONFIG_CMA
+#if defined CONFIG_COMPACTION || defined CONFIG_CMA || defined CONFIG_MEMORY_METADATA
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/compaction.h>
@@ -1306,7 +1306,7 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
 	return ret;
 }
 
-#endif /* CONFIG_COMPACTION || CONFIG_CMA */
+#endif /* CONFIG_COMPACTION || CONFIG_CMA || CONFIG_MEMORY_METADATA */
 #ifdef CONFIG_COMPACTION
 
 static bool suitable_migration_source(struct compact_control *cc,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 911d3c362848..1adaefa22208 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2624,7 +2624,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		 * exists.
 		 */
 		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
-		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
+		if (!zone_watermark_ok(zone, 0, watermark, 0,
+		    ALLOC_CMA | ALLOC_FROM_METADATA))
 			return 0;
 
 		__mod_zone_freepage_state(zone, -(1UL << order), mt);
@@ -6246,9 +6247,9 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
  * @start:	start PFN to allocate
  * @end:	one-past-the-last PFN to allocate
  * @migratetype:	migratetype of the underlying pageblocks (either
- *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
- *			in range must have the same migratetype and it must
- *			be either of the two.
+ *			#MIGRATE_MOVABLE, #MIGRATE_CMA or #MIGRATE_METADATA).
+ *			All pageblocks in range must have the same migratetype
+ *			and it must be either of the three.
  * @gfp_mask:	GFP mask to use during compaction
  *
  * The PFN range does not have to be pageblock aligned. The PFN range must
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6599cc965e21..bb2a72ce201b 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -52,6 +52,13 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 		return page;
 	}
 
+	if (is_migrate_metadata_page(page)) {
+		if (is_migrate_metadata(migratetype))
+			return NULL;
+		else
+			return page;
+	}
+
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		page = pfn_to_page(pfn);
 
@@ -396,7 +403,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				pfn = head_pfn + nr_pages;
 				continue;
 			}
-#if defined CONFIG_COMPACTION || defined CONFIG_CMA
+#if defined CONFIG_COMPACTION || defined CONFIG_CMA || defined CONFIG_MEMORY_METADATA
 			/*
 			 * hugetlb, lru compound (THP), and movable compound pages
 			 * can be migrated. Otherwise, fail the isolation.
@@ -466,7 +473,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				pfn = outer_pfn;
 				continue;
 			} else
-#endif
+#endif /* CONFIG_COMPACTION || CONFIG_CMA || CONFIG_MEMORY_METADATA */
 				goto failed;
 		}
 
@@ -495,10 +502,10 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
  * @gfp_flags:		GFP flags used for migrating pages that sit across the
  *			range boundaries.
  *
- * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
- * the range will never be allocated. Any free pages and pages freed in the
- * future will not be allocated again. If specified range includes migrate types
- * other than MOVABLE or CMA, this will fail with -EBUSY. For isolating all
+ * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in the
+ * range will never be allocated. Any free pages and pages freed in the future
+ * will not be allocated again. If specified range includes migrate types other
+ * than MOVABLE, CMA or METADATA, this will fail with -EBUSY. For isolating all
  * pages in the range finally, the caller have to free all pages in the range.
  * test_page_isolated() can be used for test it.
  *
-- 
2.41.0

