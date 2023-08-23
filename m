Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5B7858B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjHWNPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjHWNPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:15:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1049CE74;
        Wed, 23 Aug 2023 06:15:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7E7415A1;
        Wed, 23 Aug 2023 06:15:45 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647253F740;
        Wed, 23 Aug 2023 06:14:59 -0700 (PDT)
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
Subject: [PATCH RFC 09/37] mm: compaction: Handle metadata pages as source for direct compaction
Date:   Wed, 23 Aug 2023 14:13:22 +0100
Message-Id: <20230823131350.114942-10-alexandru.elisei@arm.com>
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

Metadata pages can have special requirements and can only be allocated
if an architecture allows it.

In the direct compaction case, the source pages that will be migrated
will then be used to satisfy the allocation request that triggered the
compaction. Make sure that the allocation allows the use of metadata
pages when considering them for migration.

When a page is freed during direct compaction, the page allocator will
try to use that page to satisfy the allocation request. Don't capture a
metadata page in this case, even if the allocation request would allow
it, to increase the chances that the page is free when it needs to be
taken from the allocator to store metadata.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 mm/compaction.c | 10 ++++++++--
 mm/page_alloc.c |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index f132c02b0655..a29db409c5cc 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -23,6 +23,7 @@
 #include <linux/freezer.h>
 #include <linux/page_owner.h>
 #include <linux/psi.h>
+#include <asm/memory_metadata.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
@@ -1307,11 +1308,16 @@ static bool suitable_migration_source(struct compact_control *cc,
 	if (pageblock_skip_persistent(page))
 		return false;
 
+	block_mt = get_pageblock_migratetype(page);
+
+	if (metadata_storage_enabled() && cc->direct_compaction &&
+	    is_migrate_metadata(block_mt) &&
+	    !(cc->alloc_flags & ALLOC_FROM_METADATA))
+		return false;
+
 	if ((cc->mode != MIGRATE_ASYNC) || !cc->direct_compaction)
 		return true;
 
-	block_mt = get_pageblock_migratetype(page);
-
 	if (cc->migratetype == MIGRATE_MOVABLE)
 		return is_migrate_movable(block_mt);
 	else
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bbb49b489230..011645d07ce9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -654,6 +654,7 @@ compaction_capture(struct capture_control *capc, struct page *page,
 
 	/* Do not accidentally pollute CMA or isolated regions*/
 	if (is_migrate_cma(migratetype) ||
+	    is_migrate_metadata(migratetype) ||
 	    is_migrate_isolate(migratetype))
 		return false;
 
-- 
2.41.0

