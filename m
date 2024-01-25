Return-Path: <linux-fsdevel+bounces-8974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D453E83C8D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8401F24FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001C14532B;
	Thu, 25 Jan 2024 16:45:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D763144632;
	Thu, 25 Jan 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201148; cv=none; b=hnL756+VxG9XYmA5huV23M8WWFbfX0zlb34lglQusTkbtHS4bONF/Z9NxaETHWsJ1PlneKYPpNKqIhqHLgeCGs3/qRmg/wD5Z7qiZXrzWl32vQy0TDUjll1eK9BFj8uIH3gfzgze1ndb3z/kP1B/Zxy/9xKMBETUgezmmGapeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201148; c=relaxed/simple;
	bh=MOpgrrJcQ/MuxDeBbUcSDCqPbGVfpCoyzo9ytzas7Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taTv8gPE3SR6hSvMt5Vbd/wNreLu7aQeXXinPVBFzeXC88YaRA34YG0byTKshDl0vk/b/XWzLj8fi70qdjHWqyRSC5awidSvFcb1i77g7rXWzgaGgIcIknfh4/sQwiEF9oEKQ/V628HxU7wqcPIibMy6082Z/OZ/DkcXLkqzC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8549C1756;
	Thu, 25 Jan 2024 08:46:30 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 945353F8A4;
	Thu, 25 Jan 2024 08:45:40 -0800 (PST)
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
Subject: [PATCH RFC v3 31/35] khugepaged: arm64: Don't collapse MTE enabled VMAs
Date: Thu, 25 Jan 2024 16:42:52 +0000
Message-Id: <20240125164256.4147-32-alexandru.elisei@arm.com>
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

copy_user_highpage() will do memory allocation if there are saved tags for
the destination page, and the page is missing tag storage.

After commit a349d72fd9ef ("mm/pgtable: add rcu_read_lock() and
rcu_read_unlock()s"), collapse_huge_page() calls
__collapse_huge_page_copy() -> .. -> copy_user_highpage() with the RCU lock
held, which means that copy_user_highpage() can only allocate memory using
GFP_ATOMIC or equivalent.

Get around this by refusing to collapse pages into a transparent huge page
if the VMA is MTE-enabled.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch. I think an agreement on whether copy*_user_highpage() should be
always allowed to sleep, or should not be allowed, would be useful.

 arch/arm64/include/asm/pgtable.h    | 3 +++
 arch/arm64/kernel/mte_tag_storage.c | 5 +++++
 include/linux/khugepaged.h          | 5 +++++
 mm/khugepaged.c                     | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 87ae59436162..d0473538c926 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1120,6 +1120,9 @@ static inline bool arch_alloc_cma(gfp_t gfp_mask)
 	return true;
 }
 
+bool arch_hugepage_vma_revalidate(struct vm_area_struct *vma, unsigned long address);
+#define arch_hugepage_vma_revalidate arch_hugepage_vma_revalidate
+
 #endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
 #endif /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index ac7b9c9c585c..a99959b70573 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -636,3 +636,8 @@ void arch_alloc_page(struct page *page, int order, gfp_t gfp)
 	if (tag_storage_enabled() && alloc_requires_tag_storage(gfp))
 		reserve_tag_storage(page, order, gfp);
 }
+
+bool arch_hugepage_vma_revalidate(struct vm_area_struct *vma, unsigned long address)
+{
+	return !(vma->vm_flags & VM_MTE);
+}
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index f68865e19b0b..461e4322dff2 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -38,6 +38,11 @@ static inline void khugepaged_exit(struct mm_struct *mm)
 	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
 		__khugepaged_exit(mm);
 }
+
+#ifndef arch_hugepage_vma_revalidate
+#define arch_hugepage_vma_revalidate(vma, address) 1
+#endif
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2b219acb528e..cb9a9ddb4d86 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -935,6 +935,10 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	 */
 	if (expect_anon && (!(*vmap)->anon_vma || !vma_is_anonymous(*vmap)))
 		return SCAN_PAGE_ANON;
+
+	if (!arch_hugepage_vma_revalidate(vma, address))
+		return SCAN_VMA_CHECK;
+
 	return SCAN_SUCCEED;
 }
 
-- 
2.43.0


