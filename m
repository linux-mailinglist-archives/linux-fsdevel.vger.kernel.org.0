Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C32878592B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjHWN1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjHWN1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:27:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2EB410D0;
        Wed, 23 Aug 2023 06:26:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D19016F3;
        Wed, 23 Aug 2023 06:17:51 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9D2F3F740;
        Wed, 23 Aug 2023 06:17:04 -0700 (PDT)
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
Subject: [PATCH RFC 28/37] mm: sched: Introduce PF_MEMALLOC_ISOLATE
Date:   Wed, 23 Aug 2023 14:13:41 +0100
Message-Id: <20230823131350.114942-29-alexandru.elisei@arm.com>
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

On arm64, when reserving tag storage for an allocated page, if the tag
storage is in use, the tag storage must be migrated before it can be
reserved. As part of the migration process, the tag storage block is
first isolated.

Compaction also isolates the source pages before migrating them. If the
target for compaction requires metadata pages to be reserved, those
metadata pages might also need to be isolated, which, in rare
circumstances, can lead to the threshold in too_many_isolated() being
reached, and isolate_migratepages_pageblock() will get stuck in an infinite
loop.

Add the flag PF_MEMALLOC_ISOLATE for the current thread, which makes
too_many_isolated() ignore the threshold to make forward progress in
isolate_migratepages_pageblock().

For consistency, the similarly named function too_many_isolated() called
during reclaim has received the same treatment.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/mte_tag_storage.c |  5 ++++-
 include/linux/sched.h               |  2 +-
 include/linux/sched/mm.h            | 13 +++++++++++++
 mm/compaction.c                     |  3 +++
 mm/vmscan.c                         |  3 +++
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 1ab875be5f9b..ba316ffb9aef 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -505,9 +505,9 @@ static int order_to_num_blocks(int order)
 int reserve_metadata_storage(struct page *page, int order, gfp_t gfp)
 {
 	unsigned long start_block, end_block;
+	unsigned long flags, cflags;
 	struct tag_region *region;
 	unsigned long block;
-	unsigned long flags;
 	int i, tries;
 	int ret = 0;
 
@@ -539,6 +539,7 @@ int reserve_metadata_storage(struct page *page, int order, gfp_t gfp)
 	}
 	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
 
+	cflags = memalloc_isolate_save();
 	for (block = start_block; block < end_block; block += region->block_size) {
 		/* Refcount incremented above. */
 		if (tag_storage_block_is_reserved(block))
@@ -566,6 +567,7 @@ int reserve_metadata_storage(struct page *page, int order, gfp_t gfp)
 	for (i = 0; i < (1 << order); i++)
 		set_bit(PG_tag_storage_reserved, &(page + i)->flags);
 
+	memalloc_isolate_restore(cflags);
 	mutex_unlock(&tag_blocks_lock);
 
 	return 0;
@@ -581,6 +583,7 @@ int reserve_metadata_storage(struct page *page, int order, gfp_t gfp)
 	}
 	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
 
+	memalloc_isolate_restore(cflags);
 	mutex_unlock(&tag_blocks_lock);
 
 	count_vm_events(METADATA_RESERVE_FAIL, region->block_size);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb0..a2a930cab31a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1734,7 +1734,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_MEMALLOC_ISOLATE	0x00010000	/* Ignore isolation limits */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 8d89c8c4fac1..8db491208746 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -393,6 +393,19 @@ static inline void memalloc_pin_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC_PIN) | flags;
 }
 
+static inline unsigned int memalloc_isolate_save(void)
+{
+	unsigned int flags = current->flags & PF_MEMALLOC_ISOLATE;
+
+	current->flags |= PF_MEMALLOC_ISOLATE;
+	return flags;
+}
+
+static inline void memalloc_isolate_restore(unsigned int flags)
+{
+	current->flags = (current->flags & ~PF_MEMALLOC_ISOLATE) | flags;
+}
+
 #ifdef CONFIG_MEMCG
 DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 /**
diff --git a/mm/compaction.c b/mm/compaction.c
index 314793ec8bdb..fdb75316f0cc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -778,6 +778,9 @@ static bool too_many_isolated(struct compact_control *cc)
 
 	unsigned long active, inactive, isolated;
 
+	if (current->flags & PF_MEMALLOC_ISOLATE)
+		return false;
+
 	inactive = node_page_state(pgdat, NR_INACTIVE_FILE) +
 			node_page_state(pgdat, NR_INACTIVE_ANON);
 	active = node_page_state(pgdat, NR_ACTIVE_FILE) +
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1080209a568b..912ebb6003a0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2453,6 +2453,9 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 	if (current_is_kswapd())
 		return 0;
 
+	if (current->flags & PF_MEMALLOC_ISOLATE)
+		return 0;
+
 	if (!writeback_throttling_sane(sc))
 		return 0;
 
-- 
2.41.0

