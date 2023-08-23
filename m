Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821D978590C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjHWNTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjHWNSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:18:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E88A1996;
        Wed, 23 Aug 2023 06:18:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AF6E16F8;
        Wed, 23 Aug 2023 06:18:30 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CE8A3F740;
        Wed, 23 Aug 2023 06:17:44 -0700 (PDT)
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
Subject: [PATCH RFC 34/37] arm64: mte: Handle fatal signal in reserve_metadata_storage()
Date:   Wed, 23 Aug 2023 14:13:47 +0100
Message-Id: <20230823131350.114942-35-alexandru.elisei@arm.com>
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

As long as a fatal signal is pending, alloc_contig_range() will fail with
-EINTR. This makes it impossible for tag storage allocation to succeed, and
the page allocator will print an OOM splat.

The process is going to be killed, so return 0 (success) from
reserve_metadata_storage() to allow the page allocator to make progress.
set_pte_at() will map it with PAGE_METADATA_NONE and subsequent accesses
from different threads will trap until the signal is delivered.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/mte_tag_storage.c | 17 +++++++++++++++++
 arch/arm64/mm/fault.c               | 23 +++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index ce378f45f866..1ccbcc144979 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -556,6 +556,23 @@ int reserve_metadata_storage(struct page *page, int order, gfp_t gfp)
 				break;
 		}
 
+		/*
+		 * alloc_contig_range() returns -EINTR from
+		 * __alloc_contig_migrate_range() if a fatal signal is pending.
+		 * As long as the signal hasn't been handled, it is impossible
+		 * to reserve tag storage for any page. Treat it as an error,
+		 * but return 0 so the page allocator can make forward progress,
+		 * instead of printing an OOM splat.
+		 *
+		 * The tagged page with missing tag storage will be mapped with
+		 * PAGE_METADATA_NONE in set_pte_at(), and accesses until the
+		 * signal is delivered will cause a fault.
+		 */
+		if (ret == -EINTR) {
+			ret = 0;
+			goto out_error;
+		}
+
 		if (ret)
 			goto out_error;
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7e2dcf5e3baf..64c5d77664c8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -37,7 +37,9 @@
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/kprobes.h>
+#include <asm/memory_metadata.h>
 #include <asm/mte.h>
+#include <asm/mte_tag_storage.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
@@ -936,10 +938,31 @@ void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
 }
 NOKPROBE_SYMBOL(do_debug_exception);
 
+static void save_zero_page_tags(struct page *page)
+{
+	void *tags;
+
+	clear_page(page_address(page));
+
+	tags = kmalloc(MTE_PAGE_TAG_STORAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
+	if (WARN_ON(!tags))
+		return;
+
+	if (WARN_ON(mte_save_page_tags_by_pfn(page, tags)))
+		mte_free_tags_mem(tags);
+}
+
 void tag_clear_highpage(struct page *page)
 {
 	/* Tag storage pages cannot be tagged. */
 	WARN_ON_ONCE(is_migrate_metadata_page(page));
+
+	if (metadata_storage_enabled() &&
+	    unlikely(!page_tag_storage_reserved(page))) {
+		save_zero_page_tags(page);
+		return;
+	}
+
 	/* Newly allocated page, shouldn't have been tagged yet */
 	WARN_ON_ONCE(!try_page_mte_tagging(page));
 	mte_zero_clear_page_tags(page_address(page));
-- 
2.41.0

