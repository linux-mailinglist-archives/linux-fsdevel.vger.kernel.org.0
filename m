Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933FF7858F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjHWNSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjHWNSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:18:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9118D10FE;
        Wed, 23 Aug 2023 06:17:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D5841756;
        Wed, 23 Aug 2023 06:18:10 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F2923F740;
        Wed, 23 Aug 2023 06:17:23 -0700 (PDT)
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
Subject: [PATCH RFC 31/37] mm: arm64: Set PAGE_METADATA_NONE in set_pte_at() if missing metadata storage
Date:   Wed, 23 Aug 2023 14:13:44 +0100
Message-Id: <20230823131350.114942-32-alexandru.elisei@arm.com>
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

When a metadata page is mapped in the process address space and then
mprotect(PROT_MTE) changes the VMA flags to allow the use of tags, the page
is migrated out when it is first accessed.

But this creates an interesting corner case. Let's consider the scenario:

Initial conditions: metadata page M1 and page P1 are mapped in a VMA
without VM_MTE. The metadata storage for page P1 is **metadata page M1**.

1. mprotect(PROT_MTE) changes the VMA, so now all pages must have the
   associated metadata storage reserved. The to-be-tagged pages are marked
   as PAGE_METADATA_NONE.
2. Page P1 is accessed and metadata page M1 must be reserved.
3. Because it is mapped, the metadata storage code will migrate metadata
   page M1. The replacement page for M1, page P2, is allocated without
   metadata storage (__GFP_TAGGED is not set). This is done intentionally
   in reserve_metadata_storage() to avoid recursion and deadlock.
4. Migration finishes and page P2 replaces M1 in a VMA with VM_MTE set.

The result: P2 is mapped in a VM_MTE VMA, but the associated metadata
storage is not reserved.

Fix this by teaching set_pte_at() -> mte_sync_tags() to change the PTE
protection to PAGE_METADATA_NONE when the associated metadata storage is
not reserved.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/mte.h     |  4 ++--
 arch/arm64/include/asm/pgtable.h |  2 +-
 arch/arm64/kernel/mte.c          | 14 +++++++++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 70cfd09b4a11..e89d1fa3f410 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -108,7 +108,7 @@ static inline bool try_page_mte_tagging(struct page *page)
 }
 
 void mte_zero_clear_page_tags(void *addr);
-void mte_sync_tags(pte_t pte);
+void mte_sync_tags(pte_t *pteval);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void mte_thread_init_user(void);
 void mte_thread_switch(struct task_struct *next);
@@ -140,7 +140,7 @@ static inline bool try_page_mte_tagging(struct page *page)
 static inline void mte_zero_clear_page_tags(void *addr)
 {
 }
-static inline void mte_sync_tags(pte_t pte)
+static inline void mte_sync_tags(pte_t *pteval)
 {
 }
 static inline void mte_copy_page_tags(void *kto, const void *kfrom)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2e42f7713425..e5e1c23afb14 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -338,7 +338,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (system_supports_mte() && pte_access_permitted(pte, false) &&
 	    !pte_special(pte) && pte_tagged(pte))
-		mte_sync_tags(pte);
+		mte_sync_tags(&pte);
 
 	__check_safe_pte_update(mm, ptep, pte);
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 4edecaac8f91..4556989f0b9e 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -20,7 +20,9 @@
 
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
+#include <asm/memory_metadata.h>
 #include <asm/mte.h>
+#include <asm/mte_tag_storage.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
@@ -35,13 +37,19 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
 EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
 #endif
 
-void mte_sync_tags(pte_t pte)
+void mte_sync_tags(pte_t *pteval)
 {
-	struct page *page = pte_page(pte);
+	struct page *page = pte_page(*pteval);
 	long i, nr_pages = compound_nr(page);
 
-	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
+		if (metadata_storage_enabled() &&
+		    unlikely(!page_tag_storage_reserved(page))) {
+			*pteval = pte_modify(*pteval, PAGE_METADATA_NONE);
+			continue;
+		}
+
+		/* if PG_mte_tagged is set, tags have already been initialised */
 		if (try_page_mte_tagging(page)) {
 			mte_clear_page_tags(page_address(page));
 			set_page_mte_tagged(page);
-- 
2.41.0

