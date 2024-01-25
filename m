Return-Path: <linux-fsdevel+bounces-8967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 846FD83C8BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF6228F904
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E814078F;
	Thu, 25 Jan 2024 16:45:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D4C14077B;
	Thu, 25 Jan 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201108; cv=none; b=dusvbrQqAq2amNDtEDicXmZ82rt+S7q2DbIcksbu1s9gn6BWbQgFzYSGWH7GRGle/zhrZXSS+OC/C7b72aP+wFw8QkC3lEPcBQMPFGTrn3RdVhOdwQvhk0alijNkBxN4e7BUOujQM2iPDPWW/ZE6rp+UXK/Nh2tc+ZQzgERxTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201108; c=relaxed/simple;
	bh=ggHjcfU4VCeOao++ElqGqgiF/c149/rlQ6OJmkprADY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ge7Qa01IUNfGHqE4UMDn2qOdzEHGKAh/ZIDuSV0y0rZ3bdExUTkHRXL0ERuHwW75V6HUj/zPpnyb1X4DBS0dNoFplo9fVyYLvYbo9vbt2HeUjpWh5lC2K6XQZIlN+sRljLwL7S9zmIhZ9ITwRGtOLkMG1h5Gf3FlSq1W0Z5ytT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43F741692;
	Thu, 25 Jan 2024 08:45:50 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54CF73F5A1;
	Thu, 25 Jan 2024 08:45:00 -0800 (PST)
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
Subject: [PATCH RFC v3 24/35] arm64: mte: Perform CMOs for tag blocks
Date: Thu, 25 Jan 2024 16:42:45 +0000
Message-Id: <20240125164256.4147-25-alexandru.elisei@arm.com>
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

Make sure the contents of the tag storage block is not corrupted by
performing:

1. A tag dcache inval when the associated tagged pages are freed, to avoid
   dirty tag cache lines being evicted and corrupting the tag storage
   block when it's being used to store data.

2. A data cache inval when the tag storage block is being reserved, to
   ensure that no dirty data cache lines are present, which would
   trigger a writeback that could corrupt the tags stored in the block.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/assembler.h       | 10 ++++++++++
 arch/arm64/include/asm/mte_tag_storage.h |  2 ++
 arch/arm64/kernel/mte_tag_storage.c      | 11 +++++++++++
 arch/arm64/lib/mte.S                     | 16 ++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 513787e43329..65fe88cce72b 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -310,6 +310,16 @@ alternative_cb_end
 	lsl		\reg, \reg, \tmp	// actual cache line size
 	.endm
 
+/*
+ * tcache_line_size - get the safe tag cache line size across all CPUs
+ */
+	.macro	tcache_line_size, reg, tmp
+	read_ctr	\tmp
+	ubfm		\tmp, \tmp, #32, #37	// tag cache line size encoding
+	mov		\reg, #4		// bytes per word
+	lsl		\reg, \reg, \tmp	// actual tag cache line size
+	.endm
+
 /*
  * raw_icache_line_size - get the minimum I-cache line size on this CPU
  * from the CTR register.
diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
index 09f1318d924e..423b19e0cc46 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -11,6 +11,8 @@
 
 #include <asm/mte.h>
 
+extern void dcache_inval_tags_poc(unsigned long start, unsigned long end);
+
 #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
 
 DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 762c7c803a70..8c347f4855e4 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <linux/xarray.h>
 
+#include <asm/cacheflush.h>
 #include <asm/mte_tag_storage.h>
 
 __ro_after_init DEFINE_STATIC_KEY_FALSE(tag_storage_enabled_key);
@@ -421,8 +422,13 @@ static bool tag_storage_block_is_reserved(unsigned long block)
 
 static int tag_storage_reserve_block(unsigned long block, struct tag_region *region, int order)
 {
+	unsigned long block_va;
 	int ret;
 
+	block_va = (unsigned long)page_to_virt(pfn_to_page(block));
+	/* Avoid writeback of dirty data cache lines corrupting tags. */
+	dcache_inval_poc(block_va, block_va + region->block_size_pages * PAGE_SIZE);
+
 	ret = xa_err(xa_store(&tag_blocks_reserved, block, pfn_to_page(block), GFP_KERNEL));
 	if (!ret)
 		block_ref_add(block, region, order);
@@ -570,6 +576,7 @@ void free_tag_storage(struct page *page, int order)
 {
 	unsigned long block, start_block, end_block;
 	struct tag_region *region;
+	unsigned long page_va;
 	unsigned long flags;
 	int ret;
 
@@ -577,6 +584,10 @@ void free_tag_storage(struct page *page, int order)
 	if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", page_to_pfn(page)))
 		return;
 
+	page_va = (unsigned long)page_to_virt(page);
+	/* Avoid writeback of dirty tag cache lines corrupting data. */
+	dcache_inval_tags_poc(page_va, page_va + (PAGE_SIZE << order));
+
 	end_block = start_block + order_to_num_blocks(order, region->block_size_pages);
 
 	xa_lock_irqsave(&tag_blocks_reserved, flags);
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 9f623e9da09f..bc02b4e95062 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -175,3 +175,19 @@ SYM_FUNC_START(mte_copy_page_tags_from_buf)
 
 	ret
 SYM_FUNC_END(mte_copy_page_tags_from_buf)
+
+/*
+ *	dcache_inval_tags_poc(start, end)
+ *
+ *	Ensure that any tags in the D-cache for the interval [start, end)
+ *	are invalidated to PoC.
+ *
+ *	- start   - virtual start address of region
+ *	- end     - virtual end address of region
+ */
+SYM_FUNC_START(__pi_dcache_inval_tags_poc)
+	tcache_line_size x2, x3
+	dcache_by_myline_op igvac, sy, x0, x1, x2, x3
+	ret
+SYM_FUNC_END(__pi_dcache_inval_tags_poc)
+SYM_FUNC_ALIAS(dcache_inval_tags_poc, __pi_dcache_inval_tags_poc)
-- 
2.43.0


