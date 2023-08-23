Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9D7858CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjHWNRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjHWNQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:16:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBCAAE75;
        Wed, 23 Aug 2023 06:16:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8850B165C;
        Wed, 23 Aug 2023 06:16:18 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEDA63F740;
        Wed, 23 Aug 2023 06:15:30 -0700 (PDT)
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
Subject: [PATCH RFC 14/37] arm64: mte: Expose tag storage pages to the MIGRATE_METADATA freelist
Date:   Wed, 23 Aug 2023 14:13:27 +0100
Message-Id: <20230823131350.114942-15-alexandru.elisei@arm.com>
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

Add the MTE tag storage pages to the MIGRATE_METADATA freelist, which
allows the page allocator to manage them like (almost) regular pages.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/mte_tag_storage.c | 47 +++++++++++++++++++++++++++++
 include/linux/gfp.h                 |  8 +++++
 mm/mm_init.c                        | 24 +++++++++++++--
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 5014dda9bf35..87160f53960f 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -5,10 +5,12 @@
  * Copyright (C) 2023 ARM Ltd.
  */
 
+#include <linux/gfp.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/of_device.h>
 #include <linux/of_fdt.h>
+#include <linux/pageblock-flags.h>
 #include <linux/range.h>
 #include <linux/string.h>
 #include <linux/xarray.h>
@@ -190,6 +192,12 @@ static int __init fdt_init_tag_storage(unsigned long node, const char *uname,
 		return ret;
 	}
 
+	/* Pages are managed in pageblock_nr_pages chunks */
+	if (!IS_ALIGNED(tag_range->start | range_len(tag_range), pageblock_nr_pages)) {
+		pr_err("Tag storage region not aligned to 0x%lx", pageblock_nr_pages);
+		return -EINVAL;
+	}
+
 	ret = tag_storage_get_memory_node(node, &mem_node);
 	if (ret)
 		return ret;
@@ -260,3 +268,42 @@ void __init mte_tag_storage_init(void)
 	}
 	num_tag_regions = 0;
 }
+
+static int __init mte_tag_storage_activate_regions(void)
+{
+	phys_addr_t dram_start, dram_end;
+	struct range *tag_range;
+	unsigned long pfn;
+	int i;
+
+	if (num_tag_regions == 0)
+		return 0;
+
+	dram_start = memblock_start_of_DRAM();
+	dram_end = memblock_end_of_DRAM();
+
+	for (i = 0; i < num_tag_regions; i++) {
+		tag_range = &tag_regions[i].tag_range;
+		/*
+		 * Tag storage region was clipped by arm64_bootmem_init()
+		 * enforcing addressing limits.
+		 */
+		if (PFN_PHYS(tag_range->start) < dram_start ||
+		    PFN_PHYS(tag_range->end) >= dram_end) {
+			pr_err("Tag storage region 0x%llx-0x%llx outside addressable memory",
+				PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end + 1));
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < num_tag_regions; i++) {
+		tag_range = &tag_regions[i].tag_range;
+		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages) {
+			init_metadata_reserved_pageblock(pfn_to_page(pfn));
+			totalmetadata_pages += pageblock_nr_pages;
+		}
+	}
+
+	return 0;
+}
+core_initcall(mte_tag_storage_activate_regions)
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 665f06675c83..fb344baa9a9b 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -354,4 +354,12 @@ extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 #endif
 void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 
+#ifdef CONFIG_MEMORY_METADATA
+extern void init_metadata_reserved_pageblock(struct page *page);
+#else
+static inline void init_metadata_reserved_pageblock(struct page *page)
+{
+}
+#endif
+
 #endif /* __LINUX_GFP_H */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..467c80e9dacc 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2329,8 +2329,9 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
 
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
-#ifdef CONFIG_CMA
-void __init init_cma_reserved_pageblock(struct page *page)
+#if defined(CONFIG_CMA) || defined(CONFIG_MEMORY_METADATA)
+static void __init init_reserved_pageblock(struct page *page,
+					   enum migratetype migratetype)
 {
 	unsigned i = pageblock_nr_pages;
 	struct page *p = page;
@@ -2340,15 +2341,32 @@ void __init init_cma_reserved_pageblock(struct page *page)
 		set_page_count(p, 0);
 	} while (++p, --i);
 
-	set_pageblock_migratetype(page, MIGRATE_CMA);
+	set_pageblock_migratetype(page, migratetype);
 	set_page_refcounted(page);
 	__free_pages(page, pageblock_order);
 
 	adjust_managed_page_count(page, pageblock_nr_pages);
+}
+
+#ifdef CONFIG_CMA
+/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
+void __init init_cma_reserved_pageblock(struct page *page)
+{
+	init_reserved_pageblock(page, MIGRATE_CMA);
 	page_zone(page)->cma_pages += pageblock_nr_pages;
 }
 #endif
 
+#ifdef CONFIG_MEMORY_METADATA
+/* Free whole pageblock and set its migration type to MIGRATE_METADATA. */
+void __init init_metadata_reserved_pageblock(struct page *page)
+{
+	init_reserved_pageblock(page, MIGRATE_METADATA);
+	page_zone(page)->metadata_pages += pageblock_nr_pages;
+}
+#endif
+#endif /* CONFIG_CMA || CONFIG_MEMORY_METADATA */
+
 void set_zone_contiguous(struct zone *zone)
 {
 	unsigned long block_start_pfn = zone->zone_start_pfn;
-- 
2.41.0

