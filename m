Return-Path: <linux-fsdevel+bounces-8970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E5283C8CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F06A2955A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3E1420B1;
	Thu, 25 Jan 2024 16:45:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644DD1419BB;
	Thu, 25 Jan 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201126; cv=none; b=P0XAT2e8La98zR7bx4hSlR4QZMI5chaZI2YQrCQGbnh7iEusTBIWfC6jNUZ/Le1o6l8Sq1AJeUr3wHmSD2jq64VJKFZy2QdSGFsvhtLywBPMORYel3s8wr1t7OkKJe2C/ROsTxjLNDKcNNyJnEnqp1SGZqMYxGZ0+tVD8RMynss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201126; c=relaxed/simple;
	bh=2RhSOWW7qykQzaUujrQLhtTHlBuoPtuitHn9qoqXTkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R9iIbU1GyQff9qNVq5JSUveBeL7klGfnx4L7XTyrTvonKuuOgbMqwD6vLVccsKnIK4VaZEbfd91+5ro7nx3sg8VjEhLnRvKEH22adSMX0gqzoVfY3XUn0n/2zqFz4m7YnMvUj0nFMjOZ7EzRmXBxeNbQ88AriBYPiJKvKIVAUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA3516A3;
	Thu, 25 Jan 2024 08:46:07 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963B83F5A1;
	Thu, 25 Jan 2024 08:45:17 -0800 (PST)
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
Subject: [PATCH RFC v3 27/35] arm64: mte: Handle tag storage pages mapped in an MTE VMA
Date: Thu, 25 Jan 2024 16:42:48 +0000
Message-Id: <20240125164256.4147-28-alexandru.elisei@arm.com>
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

Tag stoarge pages cannot be tagged. When such a page is mapped in a
MTE-enabled VMA, migrate it out directly and don't try to reserve tag
storage for it.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/include/asm/mte_tag_storage.h |  1 +
 arch/arm64/kernel/mte_tag_storage.c      | 15 +++++++++++++++
 arch/arm64/mm/fault.c                    | 11 +++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
index 6d0f6ffcfdd6..50bdae94cf71 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -32,6 +32,7 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp);
 void free_tag_storage(struct page *page, int order);
 
 bool page_tag_storage_reserved(struct page *page);
+bool page_is_tag_storage(struct page *page);
 
 vm_fault_t handle_folio_missing_tag_storage(struct folio *folio, struct vm_fault *vmf,
 					    bool *map_pte);
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 1c8469781870..afe2bb754879 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -492,6 +492,21 @@ bool page_tag_storage_reserved(struct page *page)
 	return test_bit(PG_tag_storage_reserved, &page->flags);
 }
 
+bool page_is_tag_storage(struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	struct range *tag_range;
+	int i;
+
+	for (i = 0; i < num_tag_regions; i++) {
+		tag_range = &tag_regions[i].tag_range;
+		if (tag_range->start <= pfn && pfn <= tag_range->end)
+			return true;
+	}
+
+	return false;
+}
+
 int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
 {
 	unsigned long start_block, end_block;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 1db3adb6499f..01450ab91a87 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -1014,6 +1014,7 @@ static int replace_folio_with_tagged(struct folio *folio)
 vm_fault_t handle_folio_missing_tag_storage(struct folio *folio, struct vm_fault *vmf,
 					    bool *map_pte)
 {
+	bool is_tag_storage = page_is_tag_storage(folio_page(folio, 0));
 	struct vm_area_struct *vma = vmf->vma;
 	int ret = 0;
 
@@ -1033,12 +1034,18 @@ vm_fault_t handle_folio_missing_tag_storage(struct folio *folio, struct vm_fault
 	if (unlikely(is_migrate_isolate_page(folio_page(folio, 0))))
 		goto out_retry;
 
-	ret = reserve_tag_storage(folio_page(folio, 0), folio_order(folio), GFP_HIGHUSER_MOVABLE);
-	if (ret) {
+	if (!is_tag_storage) {
+		ret = reserve_tag_storage(folio_page(folio, 0), folio_order(folio),
+					  GFP_HIGHUSER_MOVABLE);
+		if (!ret)
+			goto out_map;
+
 		/* replace_folio_with_tagged() is expensive, try to avoid it. */
 		if (fault_flag_allow_retry_first(vmf->flags))
 			goto out_retry;
+	}
 
+	if (ret || is_tag_storage) {
 		replace_folio_with_tagged(folio);
 		return 0;
 	}
-- 
2.43.0


