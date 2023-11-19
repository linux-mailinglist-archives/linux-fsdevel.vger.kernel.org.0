Return-Path: <linux-fsdevel+bounces-3161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7087F07E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5065D1F22A44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F304F17757;
	Sun, 19 Nov 2023 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 829E31984;
	Sun, 19 Nov 2023 08:59:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BE0DDA7;
	Sun, 19 Nov 2023 09:00:16 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D8F3F6C4;
	Sun, 19 Nov 2023 08:59:25 -0800 (PST)
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
Subject: [PATCH RFC v2 21/27] mm: arm64: Handle tag storage pages mapped before mprotect(PROT_MTE)
Date: Sun, 19 Nov 2023 16:57:15 +0000
Message-Id: <20231119165721.9849-22-alexandru.elisei@arm.com>
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

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/mte_tag_storage.h |  1 +
 arch/arm64/kernel/mte_tag_storage.c      | 15 +++++++
 arch/arm64/mm/fault.c                    | 55 ++++++++++++++++++++++++
 include/linux/migrate.h                  |  8 +++-
 include/linux/migrate_mode.h             |  1 +
 mm/internal.h                            |  6 ---
 6 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
index b97406d369ce..6a8b19a6a758 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -33,6 +33,7 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp);
 void free_tag_storage(struct page *page, int order);
 
 bool page_tag_storage_reserved(struct page *page);
+bool page_is_tag_storage(struct page *page);
 
 vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf);
 vm_fault_t handle_huge_page_missing_tag_storage(struct vm_fault *vmf);
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index a1cc239f7211..5096ce859136 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -500,6 +500,21 @@ bool page_tag_storage_reserved(struct page *page)
 	return test_bit(PG_tag_storage_reserved, &page->flags);
 }
 
+bool page_is_tag_storage(struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	struct range *tag_range;
+	int i;
+
+	for (i = 0; i < num_tag_regions; i++) {
+		tag_range = &tag_regions[i].tag_range;
+		if (tag_range->start <= pfn && pfn <= tag_range->end)
+			return true;
+	}
+
+	return false;
+}
+
 int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
 {
 	unsigned long start_block, end_block;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 6730a0812a24..964c5ae161a3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -12,6 +12,7 @@
 #include <linux/extable.h>
 #include <linux/kfence.h>
 #include <linux/signal.h>
+#include <linux/migrate.h>
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
@@ -956,6 +957,50 @@ void tag_clear_highpage(struct page *page)
 }
 
 #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+
+#define MR_TAGGED_TAG_STORAGE	MR_ARCH_1
+
+extern bool isolate_lru_page(struct page *page);
+extern void putback_movable_pages(struct list_head *l);
+
+/* Returns with the page reference dropped. */
+static void migrate_tag_storage_page(struct page *page)
+{
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_TAGGED,
+	};
+	unsigned long i, nr_pages = compound_nr(page);
+	LIST_HEAD(pagelist);
+	int ret, tries;
+
+	lru_cache_disable();
+
+	for (i = 0; i < nr_pages; i++) {
+		if (!isolate_lru_page(page + i)) {
+			ret = -EAGAIN;
+			goto out;
+		}
+		/* Isolate just grabbed another reference, drop ours. */
+		put_page(page + i);
+		list_add_tail(&(page + i)->lru, &pagelist);
+	}
+
+	tries = 5;
+	while (tries--) {
+		ret = migrate_pages(&pagelist, alloc_migration_target, NULL, (unsigned long)&mtc,
+				    MIGRATE_SYNC, MR_TAGGED_TAG_STORAGE, NULL);
+		if (ret == 0 || ret != -EBUSY)
+			break;
+	}
+
+out:
+	if (ret != 0)
+		putback_movable_pages(&pagelist);
+
+	lru_cache_enable();
+}
+
 vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -1013,6 +1058,11 @@ vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf)
 	if (unlikely(is_migrate_isolate_page(page)))
 		goto out_retry;
 
+	if (unlikely(page_is_tag_storage(page))) {
+		migrate_tag_storage_page(page);
+		return 0;
+	}
+
 	ret = reserve_tag_storage(page, 0, GFP_HIGHUSER_MOVABLE);
 	if (ret)
 		goto out_retry;
@@ -1098,6 +1148,11 @@ vm_fault_t handle_huge_page_missing_tag_storage(struct vm_fault *vmf)
 	if (unlikely(is_migrate_isolate_page(page)))
 		goto out_retry;
 
+	if (unlikely(page_is_tag_storage(page))) {
+		migrate_tag_storage_page(page);
+		return 0;
+	}
+
 	ret = reserve_tag_storage(page, HPAGE_PMD_ORDER, GFP_HIGHUSER_MOVABLE);
 	if (ret)
 		goto out_retry;
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 0acef592043c..afca42ace735 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -10,8 +10,6 @@
 typedef struct folio *new_folio_t(struct folio *folio, unsigned long private);
 typedef void free_folio_t(struct folio *folio, unsigned long private);
 
-struct migration_target_control;
-
 /*
  * Return values from addresss_space_operations.migratepage():
  * - negative errno on page migration failure;
@@ -57,6 +55,12 @@ struct movable_operations {
 	void (*putback_page)(struct page *);
 };
 
+struct migration_target_control {
+	int nid;		/* preferred node id */
+	nodemask_t *nmask;
+	gfp_t gfp_mask;
+};
+
 /* Defined in mm/debug.c: */
 extern const char *migrate_reason_names[MR_TYPES];
 
diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index f37cc03f9369..c6c5c7726d26 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -29,6 +29,7 @@ enum migrate_reason {
 	MR_CONTIG_RANGE,
 	MR_LONGTERM_PIN,
 	MR_DEMOTION,
+	MR_ARCH_1,
 	MR_TYPES
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index ddf6bb6c6308..96fff5dfc041 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -949,12 +949,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 
-struct migration_target_control {
-	int nid;		/* preferred node id */
-	nodemask_t *nmask;
-	gfp_t gfp_mask;
-};
-
 /*
  * mm/filemap.c
  */
-- 
2.42.1


