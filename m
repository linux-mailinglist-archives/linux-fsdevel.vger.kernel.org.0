Return-Path: <linux-fsdevel+bounces-8975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5626683C8DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E39296AB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC33145349;
	Thu, 25 Jan 2024 16:45:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E81137C23;
	Thu, 25 Jan 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201155; cv=none; b=b1MBEbsZf9SZbBOOx3H/UQfuA30PrQsNRypYqoV0A+/iRMJZ4yfJBMhPa0JBGDq5HErDi1r8Xvz9Y3I4r6m5A2p6G1tIMzAS6oHfuxDih66XWX+s05R98jhp1VF5HAp8EnN7yu9IOZYJc5aqyfYnvY504eHYtkLwvQMMNsiFV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201155; c=relaxed/simple;
	bh=PNox0xf587s1x2eRw+biNRki00+HQLEwqWs9fYTEJag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBMs/lZOp8Po48J5sjAL4gio2Wh2zkCc2AK3BxiowRJHfwGqFu6yDugzGZSmF/vPq1L8UcZKrdPp8nrGvBV36SmYkhVJwFxibOInHfevutqTJGdV1AEJWnBtDKoCyjjX72Pa9wJ3FV5nHqHal6DutqpLNhOqeyxw/3P5A+XMpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F38316F8;
	Thu, 25 Jan 2024 08:46:36 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D8F93F5A1;
	Thu, 25 Jan 2024 08:45:46 -0800 (PST)
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
Subject: [PATCH RFC v3 32/35] KVM: arm64: mte: Reserve tag storage for virtual machines with MTE
Date: Thu, 25 Jan 2024 16:42:53 +0000
Message-Id: <20240125164256.4147-33-alexandru.elisei@arm.com>
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

KVM allows MTE enabled VMs to be created when the backing VMA does not have
MTE enabled. As a result, pages allocated for the virtual machine's memory
won't have tag storage reserved. Try to reserve tag storage the first time
the page is accessed by the guest. This is similar to how pages mapped
without tag storage in an MTE VMA are handled.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch.

 arch/arm64/include/asm/mte_tag_storage.h | 10 ++++++
 arch/arm64/include/asm/pgtable.h         |  7 +++-
 arch/arm64/kvm/mmu.c                     | 43 ++++++++++++++++++++++++
 arch/arm64/mm/fault.c                    |  2 +-
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
index 40590a8c3748..32940ef7bcdf 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -34,6 +34,8 @@ void free_tag_storage(struct page *page, int order);
 bool page_tag_storage_reserved(struct page *page);
 bool page_is_tag_storage(struct page *page);
 
+int replace_folio_with_tagged(struct folio *folio);
+
 vm_fault_t handle_folio_missing_tag_storage(struct folio *folio, struct vm_fault *vmf,
 					    bool *map_pte);
 vm_fault_t mte_try_transfer_swap_tags(swp_entry_t entry, struct page *page);
@@ -67,6 +69,14 @@ static inline bool page_tag_storage_reserved(struct page *page)
 {
 	return true;
 }
+static inline bool page_is_tag_storage(struct page *page)
+{
+	return false;
+}
+static inline int replace_folio_with_tagged(struct folio *folio)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d0473538c926..7f89606ad617 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1108,7 +1108,12 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 #define __HAVE_ARCH_FREE_PAGES_PREPARE
 static inline void arch_free_pages_prepare(struct page *page, int order)
 {
-	if (tag_storage_enabled() && page_mte_tagged(page))
+	/*
+	 * KVM can free a page after tag storage has been reserved and before is
+	 * marked as tagged, hence use page_tag_storage_reserved() instead of
+	 * page_mte_tagged() to check for tag storage.
+	 */
+	if (tag_storage_enabled() && page_tag_storage_reserved(page))
 		free_tag_storage(page, order);
 }
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index b7517c4a19c4..986a9544228d 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1361,6 +1361,8 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 	if (!kvm_has_mte(kvm))
 		return;
 
+	WARN_ON_ONCE(tag_storage_enabled() && !page_tag_storage_reserved(pfn_to_page(pfn)));
+
 	for (i = 0; i < nr_pages; i++, page++) {
 		if (try_page_mte_tagging(page)) {
 			mte_clear_page_tags(page_address(page));
@@ -1374,6 +1376,39 @@ static bool kvm_vma_mte_allowed(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_MTE_ALLOWED;
 }
 
+/*
+ * Called with an elevated reference on the pfn. If successful, the reference
+ * count is not changed. If it returns an error, the elevated reference is
+ * dropped.
+ */
+static int kvm_mte_reserve_tag_storage(kvm_pfn_t pfn)
+{
+	struct folio *folio;
+	int ret;
+
+	folio = page_folio(pfn_to_page(pfn));
+
+	if (page_tag_storage_reserved(folio_page(folio, 0)))
+		 return 0;
+
+	if (page_is_tag_storage(folio_page(folio, 0)))
+		goto migrate;
+
+	ret = reserve_tag_storage(folio_page(folio, 0), folio_order(folio),
+				  GFP_HIGHUSER_MOVABLE);
+	if (!ret)
+		return 0;
+
+migrate:
+	replace_folio_with_tagged(folio);
+	/*
+	 * If migration succeeds, the fault needs to be replayed because 'pfn'
+	 * has been unmapped. If migration fails, KVM will try to reserve tag
+	 * storage again by replaying the fault.
+	 */
+	return -EAGAIN;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  bool fault_is_perm)
@@ -1488,6 +1523,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	pfn = __gfn_to_pfn_memslot(memslot, gfn, false, false, NULL,
 				   write_fault, &writable, NULL);
+
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
 		kvm_send_hwpoison_signal(hva, vma_shift);
 		return 0;
@@ -1518,6 +1554,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (exec_fault && device)
 		return -ENOEXEC;
 
+	if (tag_storage_enabled() && !fault_is_perm && !device &&
+	    kvm_has_mte(kvm) && mte_allowed) {
+		ret = kvm_mte_reserve_tag_storage(pfn);
+		if (ret)
+			return ret == -EAGAIN ? 0 : ret;
+	}
+
 	read_lock(&kvm->mmu_lock);
 	pgt = vcpu->arch.hw_mmu->pgt;
 	if (mmu_invalidate_retry(kvm, mmu_seq))
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 01450ab91a87..5c12232bdf0b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -974,7 +974,7 @@ void tag_clear_highpage(struct page *page)
  * Called with an elevated reference on the folio.
  * Returns with the elevated reference dropped.
  */
-static int replace_folio_with_tagged(struct folio *folio)
+int replace_folio_with_tagged(struct folio *folio)
 {
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
-- 
2.43.0


