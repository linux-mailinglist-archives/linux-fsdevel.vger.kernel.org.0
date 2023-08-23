Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED6F78592F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjHWN1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbjHWN1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:27:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27F5C10FB;
        Wed, 23 Aug 2023 06:26:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D68951682;
        Wed, 23 Aug 2023 06:17:38 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFDA13F740;
        Wed, 23 Aug 2023 06:16:50 -0700 (PDT)
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
Subject: [PATCH RFC 26/37] arm64: mte: Perform CMOs for tag blocks on tagged page allocation/free
Date:   Wed, 23 Aug 2023 14:13:39 +0100
Message-Id: <20230823131350.114942-27-alexandru.elisei@arm.com>
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

Make sure that the contents of the tag storage block is not corrupted by
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
 arch/arm64/kernel/mte_tag_storage.c      | 14 ++++++++++++++
 arch/arm64/lib/mte.S                     | 16 ++++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 376a980f2bad..8d41c8cfdc69 100644
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
index 7b69a8af13f3..bad865866eeb 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -7,6 +7,8 @@
 
 #include <linux/mm_types.h>
 
+extern void dcache_inval_tags_poc(unsigned long start, unsigned long end);
+
 #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
 void mte_tag_storage_init(void);
 bool page_tag_storage_reserved(struct page *page);
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 075231443dec..7dff93492a7b 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -19,6 +19,7 @@
 #include <linux/vm_event_item.h>
 #include <linux/xarray.h>
 
+#include <asm/cacheflush.h>
 #include <asm/memory_metadata.h>
 #include <asm/mte_tag_storage.h>
 
@@ -470,8 +471,13 @@ static bool tag_storage_block_is_reserved(unsigned long block)
 
 static int tag_storage_reserve_block(unsigned long block, struct tag_region *region, int order)
 {
+	unsigned long block_va;
 	int ret;
 
+	block_va = (unsigned long)page_to_virt(pfn_to_page(block));
+	/* Avoid writeback of dirty data cache lines corrupting tags. */
+	dcache_inval_poc(block_va, block_va + region->block_size * PAGE_SIZE);
+
 	ret = xa_err(xa_store(&tag_blocks_reserved, block, pfn_to_page(block), GFP_KERNEL));
 	if (!ret)
 		block_ref_add(block, region, order);
@@ -584,6 +590,7 @@ void free_metadata_storage(struct page *page, int order)
 {
 	unsigned long block, start_block, end_block;
 	struct tag_region *region;
+	unsigned long page_va;
 	unsigned long flags;
 	int ret;
 
@@ -594,6 +601,13 @@ void free_metadata_storage(struct page *page, int order)
 	if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", page_to_pfn(page)))
 		return;
 
+	page_va = (unsigned long)page_to_virt(page);
+	/*
+	 * Remove dirty tag cache lines to avoid corruption of the tag storage
+	 * page contents when it gets freed back to the page allocator.
+	 */
+	dcache_inval_tags_poc(page_va, page_va + (PAGE_SIZE << order));
+
 	end_block = start_block + order_to_num_blocks(order) * region->block_size;
 
 	xa_lock_irqsave(&tag_blocks_reserved, flags);
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index d3c4ff70f48b..97f0bb071284 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -175,3 +175,19 @@ SYM_FUNC_START(mte_restore_page_tags_from_mem)
 
 	ret
 SYM_FUNC_END(mte_restore_page_tags_from_mem)
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
2.41.0

