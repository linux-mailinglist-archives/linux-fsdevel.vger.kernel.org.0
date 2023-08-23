Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A7A785926
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjHWN1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjHWN1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:27:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30E2A10CF;
        Wed, 23 Aug 2023 06:26:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93C321691;
        Wed, 23 Aug 2023 06:16:56 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 033CD3F740;
        Wed, 23 Aug 2023 06:16:09 -0700 (PDT)
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
Subject: [PATCH RFC 20/37] mm: compaction: Reserve metadata storage in compaction_alloc()
Date:   Wed, 23 Aug 2023 14:13:33 +0100
Message-Id: <20230823131350.114942-21-alexandru.elisei@arm.com>
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

If the source page being migrated has metadata associated with it, make
sure to reserve the metadata storage when choosing a suitable destination
page from the free list.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 mm/compaction.c | 9 +++++++++
 mm/internal.h   | 1 +
 2 files changed, 10 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index cc0139fa0cb0..af2ee3085623 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -570,6 +570,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 	bool locked = false;
 	unsigned long blockpfn = *start_pfn;
 	unsigned int order;
+	int ret;
 
 	/* Strict mode is for isolation, speed is secondary */
 	if (strict)
@@ -626,6 +627,11 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 		/* Found a free page, will break it into order-0 pages */
 		order = buddy_order(page);
+		if (metadata_storage_enabled() && cc->reserve_metadata) {
+			ret = reserve_metadata_storage(page, order, cc->gfp_mask);
+			if (ret)
+				goto isolate_fail;
+		}
 		isolated = __isolate_free_page(page, order);
 		if (!isolated)
 			break;
@@ -1757,6 +1763,9 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 
+	if (metadata_storage_enabled())
+		cc->reserve_metadata = folio_has_metadata(src);
+
 	if (list_empty(&cc->freepages)) {
 		isolate_freepages(cc);
 
diff --git a/mm/internal.h b/mm/internal.h
index d28ac0085f61..046cc264bfbe 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -492,6 +492,7 @@ struct compact_control {
 					 */
 	bool alloc_contig;		/* alloc_contig_range allocation */
 	bool source_has_metadata;	/* source pages have associated metadata */
+	bool reserve_metadata;
 };
 
 /*
-- 
2.41.0

