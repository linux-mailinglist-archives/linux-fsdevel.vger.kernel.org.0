Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DEB7858D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbjHWNRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjHWNRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:17:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAB841736;
        Wed, 23 Aug 2023 06:16:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA46F15DB;
        Wed, 23 Aug 2023 06:16:43 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7DD83F740;
        Wed, 23 Aug 2023 06:15:56 -0700 (PDT)
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
Subject: [PATCH RFC 18/37] arm64: mte: Check that tag storage blocks are in the same zone
Date:   Wed, 23 Aug 2023 14:13:31 +0100
Message-Id: <20230823131350.114942-19-alexandru.elisei@arm.com>
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

alloc_contig_range() requires that the requested pages are in the same
zone. Check that this is indeed the case before initializing the tag
storage blocks.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/mte_tag_storage.c | 35 ++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index f45128d0244e..3e0123aa3fb3 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -269,12 +269,41 @@ void __init mte_tag_storage_init(void)
 	num_tag_regions = 0;
 }
 
+/* alloc_contig_range() requires all pages to be in the same zone. */
+static int __init mte_tag_storage_check_zone(void)
+{
+	struct range *tag_range;
+	struct zone *zone;
+	unsigned long pfn;
+	u32 block_size;
+	int i, j;
+
+	for (i = 0; i < num_tag_regions; i++) {
+		block_size = tag_regions[i].block_size;
+		if (block_size == 1)
+			continue;
+
+		tag_range = &tag_regions[i].tag_range;
+		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += block_size) {
+			zone = page_zone(pfn_to_page(pfn));
+			for (j = 1; j < block_size; j++) {
+				if (page_zone(pfn_to_page(pfn + j)) != zone) {
+					pr_err("Tag block pages in different zones");
+					return -EINVAL;
+				}
+			}
+		}
+	}
+
+	 return 0;
+}
+
 static int __init mte_tag_storage_activate_regions(void)
 {
 	phys_addr_t dram_start, dram_end;
 	struct range *tag_range;
 	unsigned long pfn;
-	int i;
+	int i, ret;
 
 	if (num_tag_regions == 0)
 		return 0;
@@ -326,6 +355,10 @@ static int __init mte_tag_storage_activate_regions(void)
 		return 0;
 	}
 
+	ret = mte_tag_storage_check_zone();
+	if (ret)
+		return ret;
+
 	for (i = 0; i < num_tag_regions; i++) {
 		tag_range = &tag_regions[i].tag_range;
 		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages) {
-- 
2.41.0

