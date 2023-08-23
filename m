Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078307858E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjHWNRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjHWNRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:17:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17DE8E6A;
        Wed, 23 Aug 2023 06:17:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 740FB16F8;
        Wed, 23 Aug 2023 06:17:57 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BF5A3F740;
        Wed, 23 Aug 2023 06:17:10 -0700 (PDT)
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
Subject: [PATCH RFC 29/37] mm: arm64: Define the PAGE_METADATA_NONE page protection
Date:   Wed, 23 Aug 2023 14:13:42 +0100
Message-Id: <20230823131350.114942-30-alexandru.elisei@arm.com>
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

Define the PAGE_METADATA_NONE page protection to be used when a page with
metadata doesn't have metadata storage reserved.

For arm64, this is accomplished by adding a new page table entry software
bit PTE_METADATA_NONE. Linux doesn't set any of the PBHA bits in entries
from the last level of the translation table and it doesn't use the
TCR_ELx.HWUxx bits.  This makes it safe to define PTE_METADATA_NONE as bit
59.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h |  2 ++
 arch/arm64/include/asm/pgtable.h      | 16 ++++++++++++++--
 include/linux/pgtable.h               | 12 ++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index eed814b00a38..ed2a98ec4e95 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -19,6 +19,7 @@
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
+#define PTE_METADATA_NONE	(_AT(pteval_t, 1) << 59) /* only when PTE_PROT_NONE */
 
 /*
  * This bit indicates that the entry is present i.e. pmd_page()
@@ -98,6 +99,7 @@ extern bool arm64_use_ng_mappings;
 	 })
 
 #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
+#define PAGE_METADATA_NONE	__pgprot((_PAGE_DEFAULT & ~PTE_VALID) | PTE_PROT_NONE | PTE_METADATA_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
 /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
 #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
 #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 944860d7090e..2e42f7713425 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -451,6 +451,18 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
+#ifdef CONFIG_MEMORY_METADATA
+static inline bool pte_metadata_none(pte_t pte)
+{
+	return (((pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE)
+		&& (pte_val(pte) & PTE_METADATA_NONE));
+}
+static inline bool pmd_metadata_none(pmd_t pmd)
+{
+	return pte_metadata_none(pmd_pte(pmd));
+}
+#endif
+
 #define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
 
 static inline int pmd_present(pmd_t pmd)
@@ -809,8 +821,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
 	 */
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
-			      PTE_ATTRINDX_MASK;
+			      PTE_PROT_NONE | PTE_METADATA_NONE | PTE_VALID |
+			      PTE_WRITE | PTE_GP | PTE_ATTRINDX_MASK;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = pte_mkdirty(pte);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5063b482e34f..0119ffa2c0ab 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1340,6 +1340,18 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifndef CONFIG_MEMORY_METADATA
+static inline bool pte_metadata_none(pte_t pte)
+{
+	return false;
+}
+
+static inline bool pmd_metadata_none(pmd_t pmd)
+{
+	return false;
+}
+#endif /* CONFIG_MEMORY_METADATA */
+
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-- 
2.41.0

