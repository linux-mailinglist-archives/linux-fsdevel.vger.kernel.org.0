Return-Path: <linux-fsdevel+bounces-8976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA4283C8DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397DC1F22511
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDBF145B04;
	Thu, 25 Jan 2024 16:46:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D265137C23;
	Thu, 25 Jan 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201160; cv=none; b=YeUv1FcPoObbJXDc6Tqhb4Dkh7q7+p8+m2iyNjcM+jY0imVwal0cB3SPbndExZhu7nEPcd6wFNQhHjfiu6nDagWeOJovU54vK1aNCzAZy83+iz/eRahsswgnc9Y/bFsijI5LjU0D8SnelTMpXSqB5RBdFwghjKxyLSSabByw7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201160; c=relaxed/simple;
	bh=jf3Xh166N5zSaNQYdq/n7NZadT8xLrh4Y+lkU9MROGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLptRH2o0NmiZ2Sj1Mef8BAUduSBX+nyjB7XofM+HrRNHq5SkwHvop/yYdsicHV11cle9Du0UrpNxr+LuCQJBObYqQ/TkuO9AizZ0flvrrm/tJ03GALRNWXj2pnQTi0FtNziRfV7a88lyPtOlApfCDOR9s896K/oWq0jQSM+W1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1422C1758;
	Thu, 25 Jan 2024 08:46:42 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B5AC3F5A1;
	Thu, 25 Jan 2024 08:45:52 -0800 (PST)
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
Subject: [PATCH RFC v3 33/35] KVM: arm64: mte: Introduce VM_MTE_KVM VMA flag
Date: Thu, 25 Jan 2024 16:42:54 +0000
Message-Id: <20240125164256.4147-34-alexandru.elisei@arm.com>
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

Tag storage pages mapped by the host in a VM with MTE enabled are migrated
when they are first accessed by the guest. This introduces latency spikes
for memory accesses made by the guest.

Tag storage pages can be mapped in the guest memory when the VM_MTE VMA
flag is not set. Introduce a new VMA flag, VM_MTE_KVM, to stop tag storage
pages from being mapped in a VM with MTE enabled.

The flag is different from VM_MTE, because the pages from the VMA won't be
mapped as tagged in the host, and host's userspace can continue to access
the guest memory as Untagged. The flag's only function is to instruct the
page allocator to treat the allocation as tagged, so tag storage pages
aren't used. The page allocator will also try to reserve tag storage for
the new page, which can speed up stage 2 aborts further if the VMM has
accessed the memory before the guest. For example, qemu and kvmtool will
benefit from this change because the guest image is copied after the
memslot is created.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch.

 arch/arm64/kvm/mmu.c  | 77 ++++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/mm/fault.c |  2 +-
 include/linux/mm.h    |  2 ++
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 986a9544228d..45c57c4b9fe2 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1420,7 +1420,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	unsigned long mmu_seq;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *old_vma;
 	short vma_shift;
 	gfn_t gfn;
 	kvm_pfn_t pfn;
@@ -1428,6 +1428,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	long vma_pagesize, fault_granule;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt;
+	bool vma_has_kvm_mte = false;
 
 	if (fault_is_perm)
 		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
@@ -1506,6 +1507,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	gfn = fault_ipa >> PAGE_SHIFT;
 	mte_allowed = kvm_vma_mte_allowed(vma);
+	vma_has_kvm_mte = !!(vma->vm_flags & VM_MTE_KVM);
+	old_vma = vma;
 
 	/* Don't use the VMA after the unlock -- it may have vanished */
 	vma = NULL;
@@ -1521,6 +1524,27 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	mmap_read_unlock(current->mm);
 
+	/*
+	 * If the VMA was created after the memslot, it doesn't have the
+	 * VM_MTE_KVM flag set.
+	 */
+	if (unlikely(tag_storage_enabled() && !fault_is_perm &&
+	    kvm_has_mte(kvm) && mte_allowed && !vma_has_kvm_mte)) {
+		mmap_write_lock(current->mm);
+		vma = vma_lookup(current->mm, hva);
+		/* The VMA was changed, replay the fault. */
+		if (vma != old_vma) {
+			mmap_write_unlock(current->mm);
+			return 0;
+		}
+		if (!(vma->vm_flags & VM_MTE_KVM)) {
+			vma_start_write(vma);
+			vm_flags_reset(vma, vma->vm_flags | VM_MTE_KVM);
+		}
+		vma = NULL;
+		mmap_write_unlock(current->mm);
+	}
+
 	pfn = __gfn_to_pfn_memslot(memslot, gfn, false, false, NULL,
 				   write_fault, &writable, NULL);
 
@@ -1986,6 +2010,40 @@ int __init kvm_mmu_init(u32 *hyp_va_bits)
 	return err;
 }
 
+static int kvm_set_clear_kvm_mte_vma(const struct kvm_memory_slot *memslot, bool set)
+{
+	struct vm_area_struct *vma;
+	hva_t hva, memslot_end;
+	int ret = 0;
+
+	hva = memslot->userspace_addr;
+	memslot_end = hva + (memslot->npages << PAGE_SHIFT);
+
+	mmap_write_lock(current->mm);
+
+	do {
+		vma = find_vma_intersection(current->mm, hva, memslot_end);
+		if (!vma)
+			break;
+		if (!kvm_vma_mte_allowed(vma))
+			continue;
+		if (set) {
+			if (!(vma->vm_flags & VM_MTE_KVM)) {
+				vma_start_write(vma);
+				vm_flags_reset(vma, vma->vm_flags | VM_MTE_KVM);
+			}
+		} else if (vma->vm_flags & VM_MTE_KVM) {
+			vma_start_write(vma);
+			vm_flags_reset(vma, vma->vm_flags & ~VM_MTE_KVM);
+		}
+		hva = min(memslot_end, vma->vm_end);
+	} while (hva < memslot_end);
+
+	mmap_write_unlock(current->mm);
+
+	return ret;
+}
+
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *old,
 				   const struct kvm_memory_slot *new,
@@ -1993,6 +2051,23 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 {
 	bool log_dirty_pages = new && new->flags & KVM_MEM_LOG_DIRTY_PAGES;
 
+	if (kvm_has_mte(kvm) && change != KVM_MR_FLAGS_ONLY) {
+		switch (change) {
+		case KVM_MR_CREATE:
+			kvm_set_clear_kvm_mte_vma(new, true);
+			break;
+		case KVM_MR_DELETE:
+			kvm_set_clear_kvm_mte_vma(old, false);
+			break;
+		case KVM_MR_MOVE:
+			kvm_set_clear_kvm_mte_vma(old, false);
+			kvm_set_clear_kvm_mte_vma(new, true);
+			break;
+		default:
+			WARN(true, "Unknown memslot change");
+		}
+	}
+
 	/*
 	 * At this point memslot has been committed and there is an
 	 * allocated dirty_bitmap[], dirty pages will be tracked while the
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5c12232bdf0b..f4ca3ba8dde7 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -947,7 +947,7 @@ NOKPROBE_SYMBOL(do_debug_exception);
  */
 gfp_t arch_calc_vma_gfp(struct vm_area_struct *vma, gfp_t gfp)
 {
-	if (vma->vm_flags & VM_MTE)
+	if (vma->vm_flags & (VM_MTE |VM_MTE_KVM))
 		return __GFP_TAGGED;
 	return 0;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..924aa7c26ec9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -375,9 +375,11 @@ extern unsigned int kobjsize(const void *objp);
 #if defined(CONFIG_ARM64_MTE)
 # define VM_MTE		VM_HIGH_ARCH_0	/* Use Tagged memory for access control */
 # define VM_MTE_ALLOWED	VM_HIGH_ARCH_1	/* Tagged memory permitted */
+# define VM_MTE_KVM	VM_HIGH_ARCH_2	/* VMA is mapped in a virtual machine with MTE */
 #else
 # define VM_MTE		VM_NONE
 # define VM_MTE_ALLOWED	VM_NONE
+# define VM_MTE_KVM	VM_NONE
 #endif
 
 #ifndef VM_GROWSUP
-- 
2.43.0


