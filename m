Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C647859E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjHWOBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 10:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbjHWN1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:27:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 548CE10CA;
        Wed, 23 Aug 2023 06:27:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95B2168F;
        Wed, 23 Aug 2023 06:17:03 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4A793F740;
        Wed, 23 Aug 2023 06:16:16 -0700 (PDT)
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
Subject: [PATCH RFC 21/37] mm: khugepaged: Handle metadata-enabled VMAs
Date:   Wed, 23 Aug 2023 14:13:34 +0100
Message-Id: <20230823131350.114942-22-alexandru.elisei@arm.com>
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

Both madvise(MADV_COLLAPSE) and khugepaged can collapse a contiguous
THP-sized memory region mapped as PTEs into a THP. If metadata is enabled for
the VMA where the PTEs are mapped, make sure to allocate metadata storage for
the compound page that will be replacing them.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/memory_metadata.h | 7 +++++++
 include/asm-generic/memory_metadata.h    | 4 ++++
 mm/khugepaged.c                          | 7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/memory_metadata.h b/arch/arm64/include/asm/memory_metadata.h
index 1b18e3217dd0..ade37331a5c8 100644
--- a/arch/arm64/include/asm/memory_metadata.h
+++ b/arch/arm64/include/asm/memory_metadata.h
@@ -5,6 +5,8 @@
 #ifndef __ASM_MEMORY_METADATA_H
 #define __ASM_MEMORY_METADATA_H
 
+#include <linux/mm.h>
+
 #include <asm-generic/memory_metadata.h>
 
 #include <asm/mte.h>
@@ -40,6 +42,11 @@ static inline int reserve_metadata_storage(struct page *page, int order, gfp_t g
 static inline void free_metadata_storage(struct page *page, int order)
 {
 }
+
+static inline bool vma_has_metadata(struct vm_area_struct *vma)
+{
+	return vma && (vma->vm_flags & VM_MTE);
+}
 #endif /* CONFIG_MEMORY_METADATA */
 
 #endif /* __ASM_MEMORY_METADATA_H  */
diff --git a/include/asm-generic/memory_metadata.h b/include/asm-generic/memory_metadata.h
index 111d6edc0997..35a0d6a8b5fc 100644
--- a/include/asm-generic/memory_metadata.h
+++ b/include/asm-generic/memory_metadata.h
@@ -35,6 +35,10 @@ static inline bool folio_has_metadata(struct folio *folio)
 {
 	return false;
 }
+static inline bool vma_has_metadata(struct vm_area_struct *vma)
+{
+	return false;
+}
 #endif /* !CONFIG_MEMORY_METADATA */
 
 #endif /* __ASM_GENERIC_MEMORY_METADATA_H */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 78c8d5d8b628..174710d941c2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -20,6 +20,7 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 
+#include <asm/memory_metadata.h>
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
 #include "internal.h"
@@ -96,6 +97,7 @@ static struct kmem_cache *mm_slot_cache __read_mostly;
 
 struct collapse_control {
 	bool is_khugepaged;
+	bool has_metadata;
 
 	/* Num pages scanned per node */
 	u32 node_load[MAX_NUMNODES];
@@ -1069,6 +1071,9 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
 	int node = hpage_collapse_find_target_node(cc);
 	struct folio *folio;
 
+	if (cc->has_metadata)
+		gfp |= __GFP_TAGGED;
+
 	if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
 
@@ -2497,6 +2502,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 		if (khugepaged_scan.address < hstart)
 			khugepaged_scan.address = hstart;
 		VM_BUG_ON(khugepaged_scan.address & ~HPAGE_PMD_MASK);
+		cc->has_metadata = vma_has_metadata(vma);
 
 		while (khugepaged_scan.address < hend) {
 			bool mmap_locked = true;
@@ -2838,6 +2844,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	if (!cc)
 		return -ENOMEM;
 	cc->is_khugepaged = false;
+	cc->has_metadata = vma_has_metadata(vma);
 
 	mmgrab(mm);
 	lru_add_drain_all();
-- 
2.41.0

