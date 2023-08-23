Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708867858B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjHWNPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjHWNPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:15:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72AA810E5;
        Wed, 23 Aug 2023 06:14:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB0511596;
        Wed, 23 Aug 2023 06:15:39 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 756C53F740;
        Wed, 23 Aug 2023 06:14:53 -0700 (PDT)
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
Subject: [PATCH RFC 08/37] mm: compaction: Account for free metadata pages in __compact_finished()
Date:   Wed, 23 Aug 2023 14:13:21 +0100
Message-Id: <20230823131350.114942-9-alexandru.elisei@arm.com>
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

__compact_finished() signals the end of compaction if a page of an order
greater than or equal to the requested order if found on a free_area.
When allocation of MIGRATE_METADATA pages is allowed, count the number
of free metadata storage pages towards the request order.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 mm/compaction.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index dbc9f86b1934..f132c02b0655 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2208,6 +2208,13 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 		if (migratetype == MIGRATE_MOVABLE &&
 			!free_area_empty(area, MIGRATE_CMA))
 			return COMPACT_SUCCESS;
+#endif
+#ifdef CONFIG_MEMORY_METADATA
+		if (metadata_storage_enabled() &&
+		    migratetype == MIGRATE_MOVABLE &&
+		    (cc->alloc_flags & ALLOC_FROM_METADATA) &&
+		    !free_area_empty(area, MIGRATE_METADATA))
+			return COMPACT_SUCCESS;
 #endif
 		/*
 		 * Job done if allocation would steal freepages from
-- 
2.41.0

