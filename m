Return-Path: <linux-fsdevel+bounces-8965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C483C8B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24A11C21D63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE08713F01B;
	Thu, 25 Jan 2024 16:44:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4FC1350EA;
	Thu, 25 Jan 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201096; cv=none; b=dVcfsCaMbkC/XreZ5dYLy43zEO5x9YlWstvWrXlKdITV7e3ZVj0ehNoPV67kpf2N2Fvh9/fGhpLz2hvC0iKI5XbSQGuqh7JQjwWaeqk7PSoc2X2JQRogb7FmYwZXPUqotReqYW5spvZnBzJ6imbeyUkMKvKzbbsZBfgb7USQ9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201096; c=relaxed/simple;
	bh=5j3hCO+SRe3ogKV7m0cZMRApaUCUfxhFuXhoI8hsaew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGwIGPWOho8aA+asoz4tHg2PZtpujmMStT1AMlXGsUrGSjW3wkLTHsnihV2hzC5bnESrjx3QQYR4q2GJDumHX5itx4ksFMMFObDD2p2COlQ0tLE+b9lPeqVX0+l+zsT9TEqSIKffL9gi1agTLSKsyJP0TT08mfVfk1MfDCih5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1083168F;
	Thu, 25 Jan 2024 08:45:38 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C149A3F5A1;
	Thu, 25 Jan 2024 08:44:48 -0800 (PST)
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
Subject: [PATCH RFC v3 22/35] arm64: mte: Enable tag storage if CMA areas have been activated
Date: Thu, 25 Jan 2024 16:42:43 +0000
Message-Id: <20240125164256.4147-23-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before enabling MTE tag storage management, make sure that the CMA areas
have been successfully activated. If a CMA area fails activation, the pages
are kept as reserved. Reserved pages are never used by the page allocator.

If this happens, the kernel would have to manage tag storage only for some
of the memory, but not for all memory, and that would make the code
unreasonably complicated.

Choose to disable tag storage management altogether if a CMA area fails to
be activated.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since v2:

* New patch.

 arch/arm64/include/asm/mte_tag_storage.h | 12 ++++++
 arch/arm64/kernel/mte_tag_storage.c      | 50 ++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
index 3c2cd29e053e..7b3f6bff8e6f 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -6,8 +6,20 @@
 #define __ASM_MTE_TAG_STORAGE_H
 
 #ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+
+DECLARE_STATIC_KEY_FALSE(tag_storage_enabled_key);
+
+static inline bool tag_storage_enabled(void)
+{
+	return static_branch_likely(&tag_storage_enabled_key);
+}
+
 void mte_init_tag_storage(void);
 #else
+static inline bool tag_storage_enabled(void)
+{
+	return false;
+}
 static inline void mte_init_tag_storage(void)
 {
 }
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 9a1a8a45171e..d58c68b4a849 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -19,6 +19,8 @@
 
 #include <asm/mte_tag_storage.h>
 
+__ro_after_init DEFINE_STATIC_KEY_FALSE(tag_storage_enabled_key);
+
 struct tag_region {
 	struct range mem_range;	/* Memory associated with the tag storage, in PFNs. */
 	struct range tag_range;	/* Tag storage memory, in PFNs. */
@@ -314,3 +316,51 @@ void __init mte_init_tag_storage(void)
 	num_tag_regions = 0;
 	pr_info("MTE tag storage region management disabled");
 }
+
+static int __init mte_enable_tag_storage(void)
+{
+	struct range *tag_range;
+	struct cma *cma;
+	int i, ret;
+
+	if (num_tag_regions == 0)
+		return 0;
+
+	for (i = 0; i < num_tag_regions; i++) {
+		tag_range = &tag_regions[i].tag_range;
+		cma = tag_regions[i].cma;
+		/*
+		 * CMA will keep the pages as reserved when the region fails
+		 * activation.
+		 */
+		if (PageReserved(pfn_to_page(tag_range->start)))
+			goto out_disabled;
+	}
+
+	static_branch_enable(&tag_storage_enabled_key);
+	pr_info("MTE tag storage region management enabled");
+
+	return 0;
+
+out_disabled:
+	for (i = 0; i < num_tag_regions; i++) {
+		tag_range = &tag_regions[i].tag_range;
+		cma = tag_regions[i].cma;
+
+		if (PageReserved(pfn_to_page(tag_range->start)))
+			continue;
+
+		/* Try really hard to reserve the tag storage. */
+		ret = cma_alloc(cma, range_len(tag_range), 8, true);
+		/*
+		 * Tag storage is still in use for data, memory and/or tag
+		 * corruption will ensue.
+		 */
+		WARN_ON_ONCE(ret);
+	}
+	num_tag_regions = 0;
+	pr_info("MTE tag storage region management disabled");
+
+	return -EINVAL;
+}
+arch_initcall(mte_enable_tag_storage);
-- 
2.43.0


