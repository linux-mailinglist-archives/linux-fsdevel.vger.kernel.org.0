Return-Path: <linux-fsdevel+bounces-8963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD36083C8B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EB11C2146A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C613EFE1;
	Thu, 25 Jan 2024 16:44:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C37913E230;
	Thu, 25 Jan 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201085; cv=none; b=OPF6qc1ABVAAFKgOp7nwzoLqyP2CaHKBWjg2zfejuc7amj4iJUzQYcFmlfpqGoOX5YfG9lvN1yUQ4a4ZcBA0Kg7ESkFu7n8mi9bFKUuBS7/H7wRyOWd+tZC/wTQgg5MwtjugtQXCwqiREpD0gg2ttndfIIEsjwketQ7yLYz/hAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201085; c=relaxed/simple;
	bh=MdXbuNdRy+WoWvTiQP66X3emkGzg8oT5eaf5lWD0Nb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITkyBA1ee/bUsQOd0UzmmVotCqZfpJ6JvNoEH/8lYsDxRroAwRcoNei5D7tCFGaQmSSpYeERRhILoTc/0ItvQXSkzTp+sNcIcBEmBvL0By8OFej7Gc4/9Mcklu6YPPXoCZNMDw1NXx7ePhpSc8mV36QgrNrrwSoV/PmybUlwGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294E21684;
	Thu, 25 Jan 2024 08:45:27 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AF663F5A1;
	Thu, 25 Jan 2024 08:44:37 -0800 (PST)
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
Subject: [PATCH RFC v3 20/35] arm64: mte: Add tag storage memory to CMA
Date: Thu, 25 Jan 2024 16:42:41 +0000
Message-Id: <20240125164256.4147-21-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the MTE tag storage pages to CMA, which allows the page allocator to
manage them like regular pages.

The CMA migratype lends the tag storage pages some very desirable
properties:

* They cannot be longterm pinned, meaning they should always be migratable.

* The pages can be allocated explicitely by using their PFN (with
  alloc_cma_range()) when they are needed to store tags.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since v2:

* Reworked from rfc v2 patch #12 ("arm64: mte: Add tag storage pages to the
MIGRATE_CMA migratetype").
* Tag storage memory is now added to the cma_areas array and will be managed
like a regular CMA region (David Hildenbrand).
* If a tag storage region spans multiple zones, CMA won't be able to activate
the region. Split such regions into multiple tag storage regions (Hyesoo Yu).

 arch/arm64/Kconfig                  |   1 +
 arch/arm64/kernel/mte_tag_storage.c | 150 +++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 92d97930b56e..6f65e9005dc9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2085,6 +2085,7 @@ config ARM64_MTE
 if ARM64_MTE
 config ARM64_MTE_TAG_STORAGE
 	bool
+	select CONFIG_CMA
 	help
 	  Adds support for dynamic management of the memory used by the hardware
 	  for storing MTE tags. This memory, unlike normal memory, cannot be
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 2f32265d8ad8..90b157132efa 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2023 ARM Ltd.
  */
 
+#include <linux/cma.h>
+#include <linux/log2.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/of.h>
@@ -22,6 +24,7 @@ struct tag_region {
 	struct range tag_range;	/* Tag storage memory, in PFNs. */
 	u32 block_size_pages;	/* Tag block size, in pages. */
 	phandle mem_phandle;	/* phandle for the associated memory node. */
+	struct cma *cma;	/* CMA cookie */
 };
 
 #define MAX_TAG_REGIONS	32
@@ -139,9 +142,88 @@ static int __init mte_find_tagged_memory_regions(void)
 	return -EINVAL;
 }
 
+static void __init mte_split_tag_region(struct tag_region *region, unsigned long last_tag_pfn)
+{
+	struct tag_region *new_region;
+	unsigned long last_mem_pfn;
+
+	new_region = &tag_regions[num_tag_regions];
+	last_mem_pfn = region->mem_range.start + (last_tag_pfn - region->tag_range.start) * 32;
+
+	new_region->mem_range.start = last_mem_pfn + 1;
+	new_region->mem_range.end = region->mem_range.end;
+	region->mem_range.end = last_mem_pfn;
+
+	new_region->tag_range.start = last_tag_pfn + 1;
+	new_region->tag_range.end = region->tag_range.end;
+	region->tag_range.end = last_tag_pfn;
+
+	new_region->block_size_pages = region->block_size_pages;
+
+	num_tag_regions++;
+}
+
+/*
+ * Split any tag region that spans multiple zones - CMA will fail if that
+ * happens.
+ */
+static int __init mte_split_tag_regions(void)
+{
+	struct tag_region *region;
+	struct range *tag_range;
+	struct zone *zone;
+	unsigned long pfn;
+	int i;
+
+	for (i = 0; i < num_tag_regions; i++) {
+		region = &tag_regions[i];
+		tag_range = &region->tag_range;
+		zone = page_zone(pfn_to_page(tag_range->start));
+
+		for (pfn = tag_range->start + 1; pfn <= tag_range->end; pfn++) {
+			if (page_zone(pfn_to_page(pfn)) == zone)
+				continue;
+
+			if (WARN_ON_ONCE(pfn % region->block_size_pages))
+				goto out_err;
+
+			if (num_tag_regions == MAX_TAG_REGIONS)
+				goto out_err;
+
+			mte_split_tag_region(&tag_regions[i], pfn - 1);
+			/* Move on to the next region. */
+			break;
+		}
+	}
+
+	return 0;
+
+out_err:
+	pr_err("Error splitting tag storage region 0x%llx-0x%llx spanning multiple zones",
+		PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end + 1) - 1);
+	return -EINVAL;
+}
+
 void __init mte_init_tag_storage(void)
 {
-	int ret;
+	unsigned long long mem_end;
+	struct tag_region *region;
+	unsigned long pfn, order;
+	u64 start, end;
+	int i, j, ret;
+
+	/*
+	 * Tag storage memory requires that tag storage pages in use for data
+	 * are always migratable when they need to be repurposed to store tags.
+	 * If ARCH_KEEP_MEMBLOCK is enabled, kexec will not scan reserved
+	 * memblocks when trying to find a suitable location for the kernel
+	 * image. This means that kexec will not use tag storage pages for
+	 * copying the kernel, and the pages will remain migratable.
+	 *
+	 * Add the check in case arm64 stops selecting ARCH_KEEP_MEMBLOCK by
+	 * default.
+	 */
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK));
 
 	if (num_tag_regions == 0)
 		return;
@@ -150,6 +232,72 @@ void __init mte_init_tag_storage(void)
 	if (ret)
 		goto out_disabled;
 
+	mem_end = PHYS_PFN(memblock_end_of_DRAM());
+
+	/*
+	 * MTE is disabled, tag storage pages can be used like any other pages.
+	 * The only restriction is that the pages cannot be used by kexec
+	 * because the memory remains marked as reserved in the memblock
+	 * allocator.
+	 */
+	if (!system_supports_mte()) {
+		for (i = 0; i< num_tag_regions; i++) {
+			start = tag_regions[i].tag_range.start;
+			end = tag_regions[i].tag_range.end;
+
+			/* end is inclusive, mem_end is not */
+			if (end >= mem_end)
+				end = mem_end - 1;
+			if (end < start)
+				continue;
+			for (pfn = start; pfn <= end; pfn++)
+				free_reserved_page(pfn_to_page(pfn));
+		}
+		goto out_disabled;
+	}
+
+	/*
+	 * Check that tag storage is addressable by the kernel.
+	 * cma_init_reserved_mem(), unlike cma_declare_contiguous_nid(), doesn't
+	 * perform this check.
+	 */
+	for (i = 0; i< num_tag_regions; i++) {
+		start = tag_regions[i].tag_range.start;
+		end = tag_regions[i].tag_range.end;
+
+		if (end >= mem_end) {
+			pr_err("Tag region 0x%llx-0x%llx outside addressable memory",
+				PFN_PHYS(start), PFN_PHYS(end + 1) - 1);
+			goto out_disabled;
+		}
+	}
+
+	ret = mte_split_tag_regions();
+	if (ret)
+		goto out_disabled;
+
+	for (i = 0; i < num_tag_regions; i++) {
+		region = &tag_regions[i];
+
+		/* Tag storage pages are managed in block_size_pages chunks. */
+		if (is_power_of_2(region->block_size_pages))
+			order = ilog2(region->block_size_pages);
+		else
+			order = 0;
+
+		ret = cma_init_reserved_mem(PFN_PHYS(region->tag_range.start),
+				PFN_PHYS(range_len(&region->tag_range)),
+				order, NULL, &region->cma);
+		if (ret) {
+			for (j = 0; j < i; j++)
+				cma_remove_mem(&region->cma);
+			goto out_disabled;
+		}
+
+		/* Keep pages reserved if activation fails. */
+		cma_reserve_pages_on_error(region->cma);
+	}
+
 	return;
 
 out_disabled:
-- 
2.43.0


