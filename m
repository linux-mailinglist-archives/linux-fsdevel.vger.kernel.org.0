Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED44347C28A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbhLUPOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:14:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:45742 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239220AbhLUPOG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099646; x=1671635646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5zzz92of88u9uerfPpCKXW7gLJYXxLAwfpsouVXIluU=;
  b=cmtLMmAewqhVgCKbtLFup6b8HqMTq/iBQxajfxcg3m3Kas8H1xr6O15+
   B3rAU/lJc+ZkAC6NiviNx8poWdxJixX3ZnFrMkMdriDJSQ50TB0Er0FHK
   F7KVzxe50okPS6tTwyPmmQuWSZISNblIQY3jVDG10qmoK0BfSBmf2upNE
   kqfcuM9y4NCS4ZGKH41PjCC/Fxhkgpl/f73C86UWskkNg0sjQEX7VrJnJ
   2PuGe+Vxeu8dmKZ1ii5IhroYmUZdDAOM5Uc6+lqfLStn/SvakrLQ7xyiG
   GP+KbwzOrhRVnlnogB3XKvzX/lHwcZzjP9XdpcO7AMjtA4/VNbQzwh6aF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227259678"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="227259678"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:13:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688668"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:13:48 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: [PATCH v3 14/15] KVM: Use kvm_userspace_memory_region_ext
Date:   Tue, 21 Dec 2021 23:11:24 +0800
Message-Id: <20211221151125.19446-15-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new extended memslot structure kvm_userspace_memory_region_ext
which includes two additional fd/ofs fields comparing to the current
kvm_userspace_memory_region. The fields fd/ofs will be copied from
userspace only when KVM_MEM_PRIVATE is set.

Internal the KVM we change all existing kvm_userspace_memory_region to
kvm_userspace_memory_region_ext since the new extended structure covers
all the existing fields in kvm_userspace_memory_region.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/arm64/kvm/mmu.c               | 14 +++++++-------
 arch/mips/kvm/mips.c               | 14 +++++++-------
 arch/powerpc/include/asm/kvm_ppc.h | 28 ++++++++++++++--------------
 arch/powerpc/kvm/book3s.c          | 14 +++++++-------
 arch/powerpc/kvm/book3s_hv.c       | 14 +++++++-------
 arch/powerpc/kvm/book3s_pr.c       | 14 +++++++-------
 arch/powerpc/kvm/booke.c           | 14 +++++++-------
 arch/powerpc/kvm/powerpc.c         | 14 +++++++-------
 arch/riscv/kvm/mmu.c               | 14 +++++++-------
 arch/s390/kvm/kvm-s390.c           | 14 +++++++-------
 arch/x86/kvm/x86.c                 | 16 ++++++++--------
 include/linux/kvm_host.h           | 18 +++++++++---------
 virt/kvm/kvm_main.c                | 23 +++++++++++++++--------
 13 files changed, 109 insertions(+), 102 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 326cdfec74a1..395e52314834 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1463,10 +1463,10 @@ int kvm_mmu_init(u32 *hyp_va_bits)
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
-				   const struct kvm_userspace_memory_region *mem,
-				   struct kvm_memory_slot *old,
-				   const struct kvm_memory_slot *new,
-				   enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 	/*
 	 * At this point memslot has been committed and there is an
@@ -1486,9 +1486,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				   struct kvm_memory_slot *memslot,
-				   const struct kvm_userspace_memory_region *mem,
-				   enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	hva_t hva = mem->userspace_addr;
 	hva_t reg_end = hva + mem->memory_size;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index aa20d074d388..28c58562266c 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -233,18 +233,18 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				   struct kvm_memory_slot *memslot,
-				   const struct kvm_userspace_memory_region *mem,
-				   enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	return 0;
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
-				   const struct kvm_userspace_memory_region *mem,
-				   struct kvm_memory_slot *old,
-				   const struct kvm_memory_slot *new,
-				   enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 	int needs_flush;
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 671fbd1a765e..7cdc756a94a0 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -200,14 +200,14 @@ extern void kvmppc_core_destroy_vm(struct kvm *kvm);
 extern void kvmppc_core_free_memslot(struct kvm *kvm,
 				     struct kvm_memory_slot *slot);
 extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
-				struct kvm_memory_slot *memslot,
-				const struct kvm_userspace_memory_region *mem,
-				enum kvm_mr_change change);
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change);
 extern void kvmppc_core_commit_memory_region(struct kvm *kvm,
-				const struct kvm_userspace_memory_region *mem,
-				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change);
+			const struct kvm_userspace_memory_region_ext *mem,
+			const struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change);
 extern int kvm_vm_ioctl_get_smmu_info(struct kvm *kvm,
 				      struct kvm_ppc_smmu_info *info);
 extern void kvmppc_core_flush_memslot(struct kvm *kvm,
@@ -274,14 +274,14 @@ struct kvmppc_ops {
 	int (*get_dirty_log)(struct kvm *kvm, struct kvm_dirty_log *log);
 	void (*flush_memslot)(struct kvm *kvm, struct kvm_memory_slot *memslot);
 	int (*prepare_memory_region)(struct kvm *kvm,
-				     struct kvm_memory_slot *memslot,
-				     const struct kvm_userspace_memory_region *mem,
-				     enum kvm_mr_change change);
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change);
 	void (*commit_memory_region)(struct kvm *kvm,
-				     const struct kvm_userspace_memory_region *mem,
-				     const struct kvm_memory_slot *old,
-				     const struct kvm_memory_slot *new,
-				     enum kvm_mr_change change);
+			const struct kvm_userspace_memory_region_ext *mem,
+			const struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change);
 	bool (*unmap_gfn_range)(struct kvm *kvm, struct kvm_gfn_range *range);
 	bool (*age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
 	bool (*test_age_gfn)(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b785f6772391..6b4bf08e7c8b 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -847,19 +847,19 @@ void kvmppc_core_flush_memslot(struct kvm *kvm, struct kvm_memory_slot *memslot)
 }
 
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
-				struct kvm_memory_slot *memslot,
-				const struct kvm_userspace_memory_region *mem,
-				enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	return kvm->arch.kvm_ops->prepare_memory_region(kvm, memslot, mem,
 							change);
 }
 
 void kvmppc_core_commit_memory_region(struct kvm *kvm,
-				const struct kvm_userspace_memory_region *mem,
-				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			const struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 	kvm->arch.kvm_ops->commit_memory_region(kvm, mem, old, new, change);
 }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7b74fc0a986b..3b7be7894c48 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4854,9 +4854,9 @@ static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *slot)
 }
 
 static int kvmppc_core_prepare_memory_region_hv(struct kvm *kvm,
-					struct kvm_memory_slot *slot,
-					const struct kvm_userspace_memory_region *mem,
-					enum kvm_mr_change change)
+			struct kvm_memory_slot *slot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	unsigned long npages = mem->memory_size >> PAGE_SHIFT;
 
@@ -4871,10 +4871,10 @@ static int kvmppc_core_prepare_memory_region_hv(struct kvm *kvm,
 }
 
 static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
-				const struct kvm_userspace_memory_region *mem,
-				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			const struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 	unsigned long npages = mem->memory_size >> PAGE_SHIFT;
 
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 6bc9425acb32..4dd06b24c1b6 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1899,18 +1899,18 @@ static void kvmppc_core_flush_memslot_pr(struct kvm *kvm,
 }
 
 static int kvmppc_core_prepare_memory_region_pr(struct kvm *kvm,
-					struct kvm_memory_slot *memslot,
-					const struct kvm_userspace_memory_region *mem,
-					enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	return 0;
 }
 
 static void kvmppc_core_commit_memory_region_pr(struct kvm *kvm,
-				const struct kvm_userspace_memory_region *mem,
-				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			const struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 	return;
 }
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 8c15c90dd3a9..f2d1acd782bf 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1821,18 +1821,18 @@ void kvmppc_core_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 }
 
 int kvmppc_core_prepare_memory_region(struct kvm *kvm,
-				      struct kvm_memory_slot *memslot,
-				      const struct kvm_userspace_memory_region *mem,
-				      enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	return 0;
 }
 
 void kvmppc_core_commit_memory_region(struct kvm *kvm,
-				const struct kvm_userspace_memory_region *mem,
-				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			const struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index a72920f4f221..aaff1476af52 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -706,18 +706,18 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				   struct kvm_memory_slot *memslot,
-				   const struct kvm_userspace_memory_region *mem,
-				   enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	return kvmppc_core_prepare_memory_region(kvm, memslot, mem, change);
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
-				   const struct kvm_userspace_memory_region *mem,
-				   struct kvm_memory_slot *old,
-				   const struct kvm_memory_slot *new,
-				   enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 	kvmppc_core_commit_memory_region(kvm, mem, old, new, change);
 }
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index fc058ff5f4b6..83b784336018 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -462,10 +462,10 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
-				const struct kvm_userspace_memory_region *mem,
-				struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 	/*
 	 * At this point memslot has been committed and there is an
@@ -477,9 +477,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				struct kvm_memory_slot *memslot,
-				const struct kvm_userspace_memory_region *mem,
-				enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	hva_t hva = mem->userspace_addr;
 	hva_t reg_end = hva + mem->memory_size;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 14a18ba5ff2c..3c1b8e0136dc 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5020,9 +5020,9 @@ vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 
 /* Section: memory related */
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				   struct kvm_memory_slot *memslot,
-				   const struct kvm_userspace_memory_region *mem,
-				   enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	/* A few sanity checks. We can have memory slots which have to be
 	   located/ended at a segment boundary (1MB). The memory in userland is
@@ -5045,10 +5045,10 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
-				const struct kvm_userspace_memory_region *mem,
-				struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 	int rc = 0;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0d3ce7b356e8..6b6f819fdb0b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11583,7 +11583,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	}
 
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
-		struct kvm_userspace_memory_region m;
+		struct kvm_userspace_memory_region_ext m;
 
 		m.slot = id | (i << 16);
 		m.flags = 0;
@@ -11765,9 +11765,9 @@ void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				struct kvm_memory_slot *memslot,
-				const struct kvm_userspace_memory_region *mem,
-				enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	if (change == KVM_MR_CREATE || change == KVM_MR_MOVE)
 		return kvm_alloc_memslot_metadata(kvm, memslot,
@@ -11863,10 +11863,10 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kvm,
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
-				const struct kvm_userspace_memory_region *mem,
-				struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
+			const struct kvm_userspace_memory_region_ext *mem,
+			struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change)
 {
 	if (!kvm->arch.n_requested_mmu_pages)
 		kvm_mmu_change_mmu_pages(kvm,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1f69d76983a2..0c53df0a6b2e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -847,20 +847,20 @@ enum kvm_mr_change {
 };
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem);
+			  const struct kvm_userspace_memory_region_ext *mem);
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem);
+			    const struct kvm_userspace_memory_region_ext *mem);
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				struct kvm_memory_slot *memslot,
-				const struct kvm_userspace_memory_region *mem,
-				enum kvm_mr_change change);
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change);
 void kvm_arch_commit_memory_region(struct kvm *kvm,
-				const struct kvm_userspace_memory_region *mem,
-				struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change);
+			const struct kvm_userspace_memory_region_ext *mem,
+			struct kvm_memory_slot *old,
+			const struct kvm_memory_slot *new,
+			enum kvm_mr_change change);
 /* flush all memory translations */
 void kvm_arch_flush_shadow_all(struct kvm *kvm);
 /* flush memory translations pointing to 'slot' */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1b7cf05759c7..79313c549fb9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1510,7 +1510,7 @@ bool __weak kvm_arch_dirty_log_supported(struct kvm *kvm)
 }
 
 static int check_memory_region_flags(struct kvm *kvm,
-				     const struct kvm_userspace_memory_region *mem)
+			     const struct kvm_userspace_memory_region_ext *mem)
 {
 	u32 valid_flags = 0;
 
@@ -1622,7 +1622,7 @@ static struct kvm_memslots *kvm_dup_memslots(struct kvm_memslots *old,
 }
 
 static int kvm_set_memslot(struct kvm *kvm,
-			   const struct kvm_userspace_memory_region *mem,
+			   const struct kvm_userspace_memory_region_ext *mem,
 			   struct kvm_memory_slot *new, int as_id,
 			   enum kvm_mr_change change)
 {
@@ -1737,7 +1737,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 }
 
 static int kvm_delete_memslot(struct kvm *kvm,
-			      const struct kvm_userspace_memory_region *mem,
+			      const struct kvm_userspace_memory_region_ext *mem,
 			      struct kvm_memory_slot *old, int as_id)
 {
 	struct kvm_memory_slot new;
@@ -1765,7 +1765,7 @@ static int kvm_delete_memslot(struct kvm *kvm,
  * Must be called holding kvm->slots_lock for write.
  */
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem)
+			    const struct kvm_userspace_memory_region_ext *mem)
 {
 	struct kvm_memory_slot old, new;
 	struct kvm_memory_slot *tmp;
@@ -1884,7 +1884,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem)
+			  const struct kvm_userspace_memory_region_ext *mem)
 {
 	int r;
 
@@ -1896,7 +1896,7 @@ int kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(kvm_set_memory_region);
 
 static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
-					  struct kvm_userspace_memory_region *mem)
+				struct kvm_userspace_memory_region_ext *mem)
 {
 	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
@@ -4393,12 +4393,19 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_SET_USER_MEMORY_REGION: {
-		struct kvm_userspace_memory_region kvm_userspace_mem;
+		struct kvm_userspace_memory_region_ext kvm_userspace_mem;
 
 		r = -EFAULT;
 		if (copy_from_user(&kvm_userspace_mem, argp,
-						sizeof(kvm_userspace_mem)))
+				sizeof(struct kvm_userspace_memory_region)))
 			goto out;
+		if (kvm_userspace_mem.flags & KVM_MEM_PRIVATE) {
+			int offset = offsetof(
+				struct kvm_userspace_memory_region_ext, ofs);
+			if (copy_from_user(&kvm_userspace_mem.ofs, argp + offset,
+					   sizeof(kvm_userspace_mem) - offset))
+				goto out;
+		}
 
 		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
 		break;
-- 
2.17.1

