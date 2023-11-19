Return-Path: <linux-fsdevel+bounces-3152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F187F07D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F48280E02
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8746B154A0;
	Sun, 19 Nov 2023 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2515A10DE;
	Sun, 19 Nov 2023 08:58:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B42E1476;
	Sun, 19 Nov 2023 08:59:29 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C846B3F6C4;
	Sun, 19 Nov 2023 08:58:37 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v2 12/27] arm64: mte: Add tag storage pages to the MIGRATE_CMA migratetype
Date: Sun, 19 Nov 2023 16:57:06 +0000
Message-Id: <20231119165721.9849-13-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the MTE tag storage pages to the MIGRATE_CMA migratetype, which allows
the page allocator to manage them like regular pages.

Ths migratype lends the pages some very desirable properties:

* They cannot be longterm pinned, meaning they will always be migratable.

* The pages can be allocated explicitely by using their PFN (with
  alloc_contig_range()) when they are needed to store tags.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/kernel/mte_tag_storage.c | 68 +++++++++++++++++++++++++++++
 include/linux/mmzone.h              |  5 +++
 mm/internal.h                       |  3 --
 4 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe8276fdc7a8..047487046e8f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2065,6 +2065,7 @@ config ARM64_MTE
 if ARM64_MTE
 config ARM64_MTE_TAG_STORAGE
 	bool "Dynamic MTE tag storage management"
+	select CONFIG_CMA
 	help
 	  Adds support for dynamic management of the memory used by the hardware
 	  for storing MTE tags. This memory, unlike normal memory, cannot be
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index fa6267ef8392..427f4f1909f3 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -5,10 +5,12 @@
  * Copyright (C) 2023 ARM Ltd.
  */
 
+#include <linux/cma.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/of_device.h>
 #include <linux/of_fdt.h>
+#include <linux/pageblock-flags.h>
 #include <linux/range.h>
 #include <linux/string.h>
 #include <linux/xarray.h>
@@ -189,6 +191,14 @@ static int __init fdt_init_tag_storage(unsigned long node, const char *uname,
 		return ret;
 	}
 
+	/* Pages are managed in pageblock_nr_pages chunks */
+	if (!IS_ALIGNED(tag_range->start | range_len(tag_range), pageblock_nr_pages)) {
+		pr_err("Tag storage region 0x%llx-0x%llx not aligned to pageblock size 0x%llx",
+		       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end),
+		       PFN_PHYS(pageblock_nr_pages));
+		return -EINVAL;
+	}
+
 	ret = tag_storage_get_memory_node(node, &mem_node);
 	if (ret)
 		return ret;
@@ -254,3 +264,61 @@ void __init mte_tag_storage_init(void)
 		pr_info("MTE tag storage region management disabled");
 	}
 }
+
+static int __init mte_tag_storage_activate_regions(void)
+{
+	phys_addr_t dram_start, dram_end;
+	struct range *tag_range;
+	unsigned long pfn;
+	int i, ret;
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
+				PFN_PHYS(tag_range->end) >= dram_end) {
+			pr_err("Tag storage region 0x%llx-0x%llx outside addressable memory",
+			       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end));
+			ret = -EINVAL;
+			goto out_disabled;
+		}
+	}
+
+	/*
+	 * MTE disabled, tag storage pages can be used like any other pages. The
+	 * only restriction is that the pages cannot be used by kexec because
+	 * the memory remains marked as reserved in the memblock allocator.
+	 */
+	if (!system_supports_mte()) {
+		for (i = 0; i< num_tag_regions; i++) {
+			tag_range = &tag_regions[i].tag_range;
+			for (pfn = tag_range->start; pfn <= tag_range->end; pfn++)
+				free_reserved_page(pfn_to_page(pfn));
+		}
+		ret = 0;
+		goto out_disabled;
+	}
+
+	for (i = 0; i < num_tag_regions; i++) {
+		tag_range = &tag_regions[i].tag_range;
+		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages)
+			init_cma_reserved_pageblock(pfn_to_page(pfn));
+		totalcma_pages += range_len(tag_range);
+	}
+
+	return 0;
+
+out_disabled:
+	pr_info("MTE tag storage region management disabled");
+	return ret;
+}
+arch_initcall(mte_tag_storage_activate_regions);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3c25226beeed..15f81429e145 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -83,6 +83,11 @@ static inline bool is_migrate_movable(int mt)
 	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
 }
 
+#ifdef CONFIG_CMA
+/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
+void init_cma_reserved_pageblock(struct page *page);
+#endif
+
 /*
  * Check whether a migratetype can be merged with another migratetype.
  *
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..ddf6bb6c6308 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -539,9 +539,6 @@ isolate_migratepages_range(struct compact_control *cc,
 int __alloc_contig_migrate_range(struct compact_control *cc,
 					unsigned long start, unsigned long end);
 
-/* Free whole pageblock and set its migration type to MIGRATE_CMA. */
-void init_cma_reserved_pageblock(struct page *page);
-
 #endif /* CONFIG_COMPACTION || CONFIG_CMA */
 
 int find_suitable_fallback(struct free_area *area, unsigned int order,
-- 
2.42.1


