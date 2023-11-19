Return-Path: <linux-fsdevel+bounces-3155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94D07F07D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638581F22A13
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9CF168AA;
	Sun, 19 Nov 2023 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2B18139;
	Sun, 19 Nov 2023 08:58:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2E19FEC;
	Sun, 19 Nov 2023 08:59:44 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9966B3F6C4;
	Sun, 19 Nov 2023 08:58:53 -0800 (PST)
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
Subject: [PATCH RFC v2 15/27] arm64: mte: Check that tag storage blocks are in the same zone
Date: Sun, 19 Nov 2023 16:57:09 +0000
Message-Id: <20231119165721.9849-16-alexandru.elisei@arm.com>
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

alloc_contig_range() requires that the requested pages are in the same
zone. Check that this is indeed the case before initializing the tag
storage blocks.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/mte_tag_storage.c | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 8b9bedf7575d..fd63430d4dc0 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -265,6 +265,35 @@ void __init mte_tag_storage_init(void)
 	}
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
+					pr_err("Tag storage block pages in different zones");
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
@@ -321,6 +350,10 @@ static int __init mte_tag_storage_activate_regions(void)
 		goto out_disabled;
 	}
 
+	ret = mte_tag_storage_check_zone();
+	if (ret)
+		goto out_disabled;
+
 	for (i = 0; i < num_tag_regions; i++) {
 		tag_range = &tag_regions[i].tag_range;
 		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages)
-- 
2.42.1


