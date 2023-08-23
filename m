Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56767858BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbjHWNP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjHWNP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:15:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2D6D10C8;
        Wed, 23 Aug 2023 06:15:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72F7D15BF;
        Wed, 23 Aug 2023 06:15:52 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69A753F740;
        Wed, 23 Aug 2023 06:15:05 -0700 (PDT)
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
Subject: [PATCH RFC 10/37] mm: compaction: Do not use MIGRATE_METADATA to replace pages with metadata
Date:   Wed, 23 Aug 2023 14:13:23 +0100
Message-Id: <20230823131350.114942-11-alexandru.elisei@arm.com>
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

MIGRATE_METADATA pages are special because for the one architecture
(arm64) that use them, it is not possible to have metadata associated
with a page used to store metadata.

To avoid a situation where a page with metadata is being migrated to a
page which cannot have metadata, keep track of whether such pages have
been isolated as the source for migration. When allocating a destination
page for migration, deny allocations from MIGRATE_METADATA if that's the
case.

fast_isolate_freepages() takes pages only from the MIGRATE_MOVABLE list,
which means it is not necessary to have a similar check, as
MIGRATE_METADATA pages will never be considered.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/memory_metadata.h |  5 +++++
 include/asm-generic/memory_metadata.h    |  5 +++++
 include/linux/mmzone.h                   |  2 +-
 mm/compaction.c                          | 19 +++++++++++++++++--
 mm/internal.h                            |  1 +
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/memory_metadata.h b/arch/arm64/include/asm/memory_metadata.h
index 5269be7f455f..c57c435c8ba3 100644
--- a/arch/arm64/include/asm/memory_metadata.h
+++ b/arch/arm64/include/asm/memory_metadata.h
@@ -7,6 +7,8 @@
 
 #include <asm-generic/memory_metadata.h>
 
+#include <asm/mte.h>
+
 #ifdef CONFIG_MEMORY_METADATA
 static inline bool metadata_storage_enabled(void)
 {
@@ -16,6 +18,9 @@ static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
 {
 	return false;
 }
+
+#define page_has_metadata(page)			page_mte_tagged(page)
+
 #endif /* CONFIG_MEMORY_METADATA */
 
 #endif /* __ASM_MEMORY_METADATA_H  */
diff --git a/include/asm-generic/memory_metadata.h b/include/asm-generic/memory_metadata.h
index 63ea661b354d..02b279823920 100644
--- a/include/asm-generic/memory_metadata.h
+++ b/include/asm-generic/memory_metadata.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_MEMORY_METADATA_H
 
 #include <linux/gfp.h>
+#include <linux/mm_types.h>
 
 extern unsigned long totalmetadata_pages;
 
@@ -15,6 +16,10 @@ static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
 {
 	return false;
 }
+static inline bool page_has_metadata(struct page *page)
+{
+	return false;
+}
 #endif /* !CONFIG_MEMORY_METADATA */
 
 #endif /* __ASM_GENERIC_MEMORY_METADATA_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 48c237248d87..12d5072668ab 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -91,7 +91,7 @@ extern const char * const migratetype_names[MIGRATE_TYPES];
 
 static inline bool is_migrate_movable(int mt)
 {
-	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
+	return is_migrate_cma(mt) || is_migrate_metadata(mt) || mt == MIGRATE_MOVABLE;
 }
 
 /*
diff --git a/mm/compaction.c b/mm/compaction.c
index a29db409c5cc..cc0139fa0cb0 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1153,6 +1153,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		nr_isolated += folio_nr_pages(folio);
 		nr_scanned += folio_nr_pages(folio) - 1;
 
+		if (page_has_metadata(&folio->page))
+			cc->source_has_metadata = true;
+
 		/*
 		 * Avoid isolating too much unless this block is being
 		 * fully scanned (e.g. dirty/writeback pages, parallel allocation)
@@ -1328,6 +1331,15 @@ static bool suitable_migration_source(struct compact_control *cc,
 static bool suitable_migration_target(struct compact_control *cc,
 							struct page *page)
 {
+	int block_mt;
+
+	block_mt = get_pageblock_migratetype(page);
+
+	/* Pages from MIGRATE_METADATA cannot have metadata. */
+	if (is_migrate_metadata(block_mt) && cc->source_has_metadata)
+		return false;
+
+
 	/* If the page is a large free page, then disallow migration */
 	if (PageBuddy(page)) {
 		/*
@@ -1342,8 +1354,11 @@ static bool suitable_migration_target(struct compact_control *cc,
 	if (cc->ignore_block_suitable)
 		return true;
 
-	/* If the block is MIGRATE_MOVABLE or MIGRATE_CMA, allow migration */
-	if (is_migrate_movable(get_pageblock_migratetype(page)))
+	/*
+	 * If the block is MIGRATE_MOVABLE, MIGRATE_CMA or MIGRATE_METADATA,
+	 * allow migration.
+	 */
+	if (is_migrate_movable(block_mt))
 		return true;
 
 	/* Otherwise skip the block */
diff --git a/mm/internal.h b/mm/internal.h
index efd52c9f1578..d28ac0085f61 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -491,6 +491,7 @@ struct compact_control {
 					 * ensure forward progress.
 					 */
 	bool alloc_contig;		/* alloc_contig_range allocation */
+	bool source_has_metadata;	/* source pages have associated metadata */
 };
 
 /*
-- 
2.41.0

