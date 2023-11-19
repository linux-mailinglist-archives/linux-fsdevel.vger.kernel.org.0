Return-Path: <linux-fsdevel+bounces-3154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689B7F07D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4163280DCC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E117731;
	Sun, 19 Nov 2023 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C8C1172D;
	Sun, 19 Nov 2023 08:58:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E171DA7;
	Sun, 19 Nov 2023 08:59:39 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A3EA3F6C4;
	Sun, 19 Nov 2023 08:58:48 -0800 (PST)
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
Subject: [PATCH RFC v2 14/27] arm64: mte: Disable dynamic tag storage management if HW KASAN is enabled
Date: Sun, 19 Nov 2023 16:57:08 +0000
Message-Id: <20231119165721.9849-15-alexandru.elisei@arm.com>
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

To be able to reserve the tag storage associated with a page requires that
the tag storage page can be migrated.

When HW KASAN is enabled, the kernel allocates pages, which are now tagged,
in non-preemptible contexts, which can make reserving the associate tag
storage impossible.

Keep the tag storage pages reserved if HW KASAN is enabled.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/mte_tag_storage.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 427f4f1909f3..8b9bedf7575d 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -308,6 +308,19 @@ static int __init mte_tag_storage_activate_regions(void)
 		goto out_disabled;
 	}
 
+	/*
+	 * The kernel allocates memory in non-preemptible contexts, which makes
+	 * migration impossible when reserving the associated tag storage.
+	 *
+	 * The check is safe to make because KASAN HW tags are enabled before
+	 * the rest of the init functions are called, in smp_prepare_boot_cpu().
+	 */
+	if (kasan_hw_tags_enabled()) {
+		pr_info("KASAN HW tags incompatible with MTE tag storage management");
+		ret = 0;
+		goto out_disabled;
+	}
+
 	for (i = 0; i < num_tag_regions; i++) {
 		tag_range = &tag_regions[i].tag_range;
 		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages)
-- 
2.42.1


