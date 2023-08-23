Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADCE7858A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjHWNOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjHWNOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:14:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A2AAE74;
        Wed, 23 Aug 2023 06:14:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C581B152B;
        Wed, 23 Aug 2023 06:15:14 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A1373F740;
        Wed, 23 Aug 2023 06:14:28 -0700 (PDT)
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
Subject: [PATCH RFC 04/37] mm: Add MIGRATE_METADATA allocation policy
Date:   Wed, 23 Aug 2023 14:13:17 +0100
Message-Id: <20230823131350.114942-5-alexandru.elisei@arm.com>
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

Some architectures implement hardware memory coloring to catch incorrect
usage of memory allocation. One such architecture is arm64, which calls its
hardware implementation Memory Tagging Extension.

So far, the memory which stores the metadata has been configured by
firmware and hidden from Linux. For arm64, it is impossible to to have the
entire system RAM allocated with metadata because executable memory cannot
be tagged. Furthermore, in practice, only a chunk of all the memory that
can have tags is actually used as tagged. which leaves a portion of
metadata memory unused. As such, it would be beneficial to use this memory,
which so far has been unaccessible to Linux, to service allocation
requests. To prepare for exposing this metadata memory a new migratetype is
being added to the page allocator, called MIGRATE_METADATA.

One important aspect is that for arm64 the memory that stores metadata
cannot have metadata associated with it, it can only be used to store
metadata for other pages. This means that the page allocator will *not*
allocate from this migratetype if at least one of the following is true:

- The allocation also needs metadata to be allocated.
- The allocation isn't movable. A metadata page storing data must be
  able to be migrated at any given time so it can be repurposed to store
  metadata.

Both cases are specific to arm64's implementation of memory metadata.

For now, metadata storage pages management is disabled, and it will be
enabled once the architecture-specific handling is added.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/memory_metadata.h | 21 ++++++++++++++++++
 arch/arm64/mm/fault.c                    |  3 +++
 include/asm-generic/Kbuild               |  1 +
 include/asm-generic/memory_metadata.h    | 18 +++++++++++++++
 include/linux/mmzone.h                   | 11 ++++++++++
 mm/Kconfig                               |  3 +++
 mm/internal.h                            |  5 +++++
 mm/page_alloc.c                          | 28 ++++++++++++++++++++++++
 8 files changed, 90 insertions(+)
 create mode 100644 arch/arm64/include/asm/memory_metadata.h
 create mode 100644 include/asm-generic/memory_metadata.h

diff --git a/arch/arm64/include/asm/memory_metadata.h b/arch/arm64/include/asm/memory_metadata.h
new file mode 100644
index 000000000000..5269be7f455f
--- /dev/null
+++ b/arch/arm64/include/asm/memory_metadata.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+#ifndef __ASM_MEMORY_METADATA_H
+#define __ASM_MEMORY_METADATA_H
+
+#include <asm-generic/memory_metadata.h>
+
+#ifdef CONFIG_MEMORY_METADATA
+static inline bool metadata_storage_enabled(void)
+{
+	return false;
+}
+static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
+{
+	return false;
+}
+#endif /* CONFIG_MEMORY_METADATA */
+
+#endif /* __ASM_MEMORY_METADATA_H  */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0ca89ebcdc63..1ca421c11ebc 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -13,6 +13,7 @@
 #include <linux/kfence.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
+#include <linux/mmzone.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
 #include <linux/kasan.h>
@@ -956,6 +957,8 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 
 void tag_clear_highpage(struct page *page)
 {
+	/* Tag storage pages cannot be tagged. */
+	WARN_ON_ONCE(is_migrate_metadata_page(page));
 	/* Newly allocated page, shouldn't have been tagged yet */
 	WARN_ON_ONCE(!try_page_mte_tagging(page));
 	mte_zero_clear_page_tags(page_address(page));
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 941be574bbe0..048ecffc430c 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -36,6 +36,7 @@ mandatory-y += kprobes.h
 mandatory-y += linkage.h
 mandatory-y += local.h
 mandatory-y += local64.h
+mandatory-y += memory_metadata.h
 mandatory-y += mmiowb.h
 mandatory-y += mmu.h
 mandatory-y += mmu_context.h
diff --git a/include/asm-generic/memory_metadata.h b/include/asm-generic/memory_metadata.h
new file mode 100644
index 000000000000..dc0c84408a8e
--- /dev/null
+++ b/include/asm-generic/memory_metadata.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_MEMORY_METADATA_H
+#define __ASM_GENERIC_MEMORY_METADATA_H
+
+#include <linux/gfp.h>
+
+#ifndef CONFIG_MEMORY_METADATA
+static inline bool metadata_storage_enabled(void)
+{
+	return false;
+}
+static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
+{
+	return false;
+}
+#endif /* !CONFIG_MEMORY_METADATA */
+
+#endif /* __ASM_GENERIC_MEMORY_METADATA_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5e50b78d58ea..74925806687e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -61,6 +61,9 @@ enum migratetype {
 	 */
 	MIGRATE_CMA,
 #endif
+#ifdef CONFIG_MEMORY_METADATA
+	MIGRATE_METADATA,
+#endif
 #ifdef CONFIG_MEMORY_ISOLATION
 	MIGRATE_ISOLATE,	/* can't allocate from here */
 #endif
@@ -78,6 +81,14 @@ extern const char * const migratetype_names[MIGRATE_TYPES];
 #  define is_migrate_cma_page(_page) false
 #endif
 
+#ifdef CONFIG_MEMORY_METADATA
+#  define is_migrate_metadata(migratetype) unlikely((migratetype) == MIGRATE_METADATA)
+#  define is_migrate_metadata_page(_page) (get_pageblock_migratetype(_page) == MIGRATE_METADATA)
+#else
+#  define is_migrate_metadata(migratetype) false
+#  define is_migrate_metadata_page(_page) false
+#endif
+
 static inline bool is_migrate_movable(int mt)
 {
 	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
diff --git a/mm/Kconfig b/mm/Kconfig
index 09130434e30d..838193522e20 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1236,6 +1236,9 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config MEMORY_METADATA
+	bool
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/internal.h b/mm/internal.h
index a7d9e980429a..efd52c9f1578 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -824,6 +824,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
+#ifdef CONFIG_MEMORY_METADATA
+#define ALLOC_FROM_METADATA	0x400 /* allow allocations from MIGRATE_METADATA list */
+#else
+#define ALLOC_FROM_METADATA	0x0
+#endif
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 /* Flags that allow allocations below the min watermark. */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fdc230440a44..7baa78abf351 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -53,6 +53,7 @@
 #include <linux/khugepaged.h>
 #include <linux/delayacct.h>
 #include <asm/div64.h>
+#include <asm/memory_metadata.h>
 #include "internal.h"
 #include "shuffle.h"
 #include "page_reporting.h"
@@ -1645,6 +1646,17 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
 					unsigned int order) { return NULL; }
 #endif
 
+#ifdef CONFIG_MEMORY_METADATA
+static __always_inline struct page *__rmqueue_metadata_fallback(struct zone *zone,
+					unsigned int order)
+{
+	return __rmqueue_smallest(zone, order, MIGRATE_METADATA);
+}
+#else
+static inline struct page *__rmqueue_metadata_fallback(struct zone *zone,
+					unsigned int order) { return NULL; }
+#endif
+
 /*
  * Move the free pages in a range to the freelist tail of the requested type.
  * Note that start_page and end_pages are not aligned on a pageblock
@@ -2144,6 +2156,15 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 		if (alloc_flags & ALLOC_CMA)
 			page = __rmqueue_cma_fallback(zone, order);
 
+		/*
+		 * Allocate data pages from MIGRATE_METADATA only if the regular
+		 * allocation path fails to increase the chance that the
+		 * metadata page is available when the associated data page
+		 * needs it.
+		 */
+		if (!page && (alloc_flags & ALLOC_FROM_METADATA))
+			page = __rmqueue_metadata_fallback(zone, order);
+
 		if (!page && __rmqueue_fallback(zone, order, migratetype,
 								alloc_flags))
 			goto retry;
@@ -3088,6 +3109,13 @@ static inline unsigned int gfp_to_alloc_flags_fast(gfp_t gfp_mask,
 	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
 		alloc_flags |= ALLOC_CMA;
 #endif
+#ifdef CONFIG_MEMORY_METADATA
+	if (metadata_storage_enabled() &&
+	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE &&
+	    alloc_can_use_metadata_pages(gfp_mask))
+		alloc_flags |= ALLOC_FROM_METADATA;
+#endif
+
 	return alloc_flags;
 }
 
-- 
2.41.0

