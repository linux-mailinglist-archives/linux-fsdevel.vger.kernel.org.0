Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4CE7859EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjHWOBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjHWN1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:27:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ECF110C7;
        Wed, 23 Aug 2023 06:27:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC9FC1684;
        Wed, 23 Aug 2023 06:16:30 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E4913F740;
        Wed, 23 Aug 2023 06:15:44 -0700 (PDT)
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
Subject: [PATCH RFC 16/37] arm64: mte: Move tag storage to MIGRATE_MOVABLE when MTE is disabled
Date:   Wed, 23 Aug 2023 14:13:29 +0100
Message-Id: <20230823131350.114942-17-alexandru.elisei@arm.com>
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

If MTE is disabled (for example, from the kernel command line with the
arm64.nomte option), the tag storage pages behave just like normal
pages, because they will never be used to store tags. If that's the
case, expose them to the page allocator as MIGRATE_MOVABLE pages.

MIGRATE_MOVABLE has been chosen because the bulk of memory allocations
comes from userspace, and the migratetype for those allocations is
MIGRATE_MOVABLE. MIGRATE_RECLAIMABLE and MIGRATE_UNMOVABLE requests can
still use the pages as a fallback.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/mte_tag_storage.c | 18 ++++++++++++++++++
 include/linux/gfp.h                 |  2 ++
 mm/mm_init.c                        |  3 +--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 87160f53960f..4a6bfdf88458 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -296,6 +296,24 @@ static int __init mte_tag_storage_activate_regions(void)
 		}
 	}
 
+	/*
+	 * MTE disabled, tag storage pages can be used like any other pages. The
+	 * only restriction is that the pages cannot be used by kexec because
+	 * the memory is marked as reserved in the memblock allocator.
+	 */
+	if (!system_supports_mte()) {
+		for (i = 0; i< num_tag_regions; i++) {
+			tag_range = &tag_regions[i].tag_range;
+			for (pfn = tag_range->start;
+			     pfn <= tag_range->end;
+			     pfn += pageblock_nr_pages) {
+				init_reserved_pageblock(pfn_to_page(pfn), MIGRATE_MOVABLE);
+			}
+		}
+
+		return 0;
+	}
+
 	for (i = 0; i < num_tag_regions; i++) {
 		tag_range = &tag_regions[i].tag_range;
 		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages) {
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index fb344baa9a9b..622bb9406cae 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -354,6 +354,8 @@ extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 #endif
 void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 
+extern void init_reserved_pageblock(struct page *page, enum migratetype migratetype);
+
 #ifdef CONFIG_MEMORY_METADATA
 extern void init_metadata_reserved_pageblock(struct page *page);
 #else
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 467c80e9dacc..eedaacdf153d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2330,8 +2330,7 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 #if defined(CONFIG_CMA) || defined(CONFIG_MEMORY_METADATA)
-static void __init init_reserved_pageblock(struct page *page,
-					   enum migratetype migratetype)
+void __init init_reserved_pageblock(struct page *page, enum migratetype migratetype)
 {
 	unsigned i = pageblock_nr_pages;
 	struct page *p = page;
-- 
2.41.0

