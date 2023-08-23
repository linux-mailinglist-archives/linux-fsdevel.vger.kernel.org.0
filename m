Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A943C785902
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbjHWNS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbjHWNSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:18:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22E64E58;
        Wed, 23 Aug 2023 06:18:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8531815BF;
        Wed, 23 Aug 2023 06:18:17 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FC3D3F740;
        Wed, 23 Aug 2023 06:17:29 -0700 (PDT)
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
Subject: [PATCH RFC 32/37] mm: Call arch_swap_prepare_to_restore() before arch_swap_restore()
Date:   Wed, 23 Aug 2023 14:13:45 +0100
Message-Id: <20230823131350.114942-33-alexandru.elisei@arm.com>
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

arch_swap_restore() allows an architecture to restore metadata before the
page is swapped in and it's called in atomic context (with the ptl lock
held). Introduce arch_swap_prepare_to_restore() to allow such architectures
to perform extra work in a blocking context.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/linux/pgtable.h |  7 +++++++
 mm/memory.c             | 11 +++++++++++
 mm/shmem.c              |  4 ++++
 mm/swapfile.c           |  4 ++++
 4 files changed, 26 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 0119ffa2c0ab..0bce12f9eaab 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -816,6 +816,13 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 }
 #endif
 
+#ifndef __HAVE_ARCH_SWAP_PREPARE_TO_RESTORE
+static inline int arch_swap_prepare_to_restore(swp_entry_t entry, struct folio *folio)
+{
+	return 0;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PGD_OFFSET_GATE
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 6c4a6151c7b2..5f7587109ac2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3724,6 +3724,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swp_entry_t entry;
 	pte_t pte;
 	int locked;
+	int error;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
@@ -3892,6 +3893,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	folio_throttle_swaprate(folio, GFP_KERNEL);
 
+	/*
+	 * Some architecture may need to perform certain operations before
+	 * arch_swap_restore() in preemptible context (like memory allocations).
+	 */
+	error = arch_swap_prepare_to_restore(entry, folio);
+	if (error) {
+		ret = VM_FAULT_ERROR;
+		goto out_page;
+	}
+
 	/*
 	 * Back out if somebody else already faulted in this pte.
 	 */
diff --git a/mm/shmem.c b/mm/shmem.c
index 0b772ec34caa..4704be6a4e9b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1796,6 +1796,10 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 	folio_wait_writeback(folio);
 
+	error = arch_swap_prepare_to_restore(swap, folio);
+	if (error)
+		goto unlock;
+
 	/*
 	 * Some architectures may have to restore extra metadata to the
 	 * folio after reading from swap.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6d719ed5c616..387971e2c5f0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1756,6 +1756,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	else if (unlikely(PTR_ERR(page) == -EHWPOISON))
 		hwposioned = true;
 
+	ret = arch_swap_prepare_to_restore(entry, folio);
+	if (ret)
+		return ret;
+
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (unlikely(!pte || !pte_same_as_swp(ptep_get(pte),
 						swp_entry_to_pte(entry)))) {
-- 
2.41.0

