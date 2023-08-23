Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDA7858BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbjHWNQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjHWNQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:16:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DB9EE5C;
        Wed, 23 Aug 2023 06:15:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9081C15DB;
        Wed, 23 Aug 2023 06:15:58 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C7E63F740;
        Wed, 23 Aug 2023 06:15:12 -0700 (PDT)
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
Subject: [PATCH RFC 11/37] mm: migrate/mempolicy: Allocate metadata-enabled destination page
Date:   Wed, 23 Aug 2023 14:13:24 +0100
Message-Id: <20230823131350.114942-12-alexandru.elisei@arm.com>
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

With explicit metadata page management support, it's important to know if
the source page for migration has metadata associated with it for two
reasons:

- The page allocator knows to skip metadata pages (which cannot have
  metadata) when allocating the destination page.
- The associated metadata page is correctly reserved when fulfilling the
  allocation for the destination page.

When choosing the destination during migration, keep track if the source
page has metadata.

The mbind() system call changes the NUMA allocation policy for the
specified memory range and nodemask. If the MPOL_MF_MOVE or
MPOL_MF_MOVE_ALL flags are set, then any existing allocations that fall
within the range which don't conform to the specified policy will be
migrated. The function that allocates the destination page for migration
is new_page(), teach it too about source pages with metadata.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/memory_metadata.h | 4 ++++
 include/asm-generic/memory_metadata.h    | 4 ++++
 mm/mempolicy.c                           | 4 ++++
 mm/migrate.c                             | 6 ++++++
 4 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/memory_metadata.h b/arch/arm64/include/asm/memory_metadata.h
index c57c435c8ba3..132707fce9ab 100644
--- a/arch/arm64/include/asm/memory_metadata.h
+++ b/arch/arm64/include/asm/memory_metadata.h
@@ -21,6 +21,10 @@ static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
 
 #define page_has_metadata(page)			page_mte_tagged(page)
 
+static inline bool folio_has_metadata(struct folio *folio)
+{
+	return page_has_metadata(&folio->page);
+}
 #endif /* CONFIG_MEMORY_METADATA */
 
 #endif /* __ASM_MEMORY_METADATA_H  */
diff --git a/include/asm-generic/memory_metadata.h b/include/asm-generic/memory_metadata.h
index 02b279823920..8f4e2fba222f 100644
--- a/include/asm-generic/memory_metadata.h
+++ b/include/asm-generic/memory_metadata.h
@@ -20,6 +20,10 @@ static inline bool page_has_metadata(struct page *page)
 {
 	return false;
 }
+static inline bool folio_has_metadata(struct folio *folio)
+{
+	return false;
+}
 #endif /* !CONFIG_MEMORY_METADATA */
 
 #endif /* __ASM_GENERIC_MEMORY_METADATA_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index edc25195f5bd..d164b5c50243 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -103,6 +103,7 @@
 #include <linux/printk.h>
 #include <linux/swapops.h>
 
+#include <asm/memory_metadata.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <linux/uaccess.h>
@@ -1219,6 +1220,9 @@ static struct folio *new_folio(struct folio *src, unsigned long start)
 	if (folio_test_large(src))
 		gfp = GFP_TRANSHUGE;
 
+	if (folio_has_metadata(src))
+		gfp |= __GFP_TAGGED;
+
 	/*
 	 * if !vma, vma_alloc_folio() will use task or system default policy
 	 */
diff --git a/mm/migrate.c b/mm/migrate.c
index 24baad2571e3..c6826562220a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -51,6 +51,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 
+#include <asm/memory_metadata.h>
 #include <asm/tlbflush.h>
 
 #include <trace/events/migrate.h>
@@ -1990,6 +1991,9 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 	if (nid == NUMA_NO_NODE)
 		nid = folio_nid(src);
 
+	if (folio_has_metadata(src))
+		gfp_mask |= __GFP_TAGGED;
+
 	if (folio_test_hugetlb(src)) {
 		struct hstate *h = folio_hstate(src);
 
@@ -2476,6 +2480,8 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 			__GFP_NOWARN;
 		gfp &= ~__GFP_RECLAIM;
 	}
+	if (folio_has_metadata(src))
+		gfp |= __GFP_TAGGED;
 	return __folio_alloc_node(gfp, order, nid);
 }
 
-- 
2.41.0

