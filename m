Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB28456FEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 14:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbhKSNwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 08:52:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:20905 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235657AbhKSNwB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:52:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="215128508"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="215128508"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:49:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="507904829"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2021 05:48:51 -0800
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
Subject: [RFC v2 PATCH 03/13] KVM: Extend kvm_userspace_memory_region to support fd based memslot
Date:   Fri, 19 Nov 2021 21:47:29 +0800
Message-Id: <20211119134739.20218-4-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch introduces two fds into memslot, guarded by KVM_MEM_FD flag.
The userspace_addr field is repurposed as the offset into two fds, for
respectively the shared and private views. If private_fd == -1, the
memory slot has only a shared view.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
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
 arch/x86/include/asm/kvm_host.h    |  6 +++---
 arch/x86/kvm/vmx/main.c            |  6 +++---
 arch/x86/kvm/vmx/tdx.c             |  6 +++---
 arch/x86/kvm/vmx/tdx_stubs.c       |  6 +++---
 arch/x86/kvm/x86.c                 | 16 ++++++++--------
 include/linux/kvm_host.h           | 18 +++++++++---------
 include/uapi/linux/kvm.h           | 12 ++++++++++++
 virt/kvm/kvm_main.c                | 23 +++++++++++++++--------
 18 files changed, 133 insertions(+), 114 deletions(-)

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
index 562aa878b266..ef71146809d5 100644
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
index 35e9cccdeef9..4aa5ef921710 100644
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
index d81bae8eb55e..a7f25b0da391 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -456,10 +456,10 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
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
@@ -471,9 +471,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
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
index c6257f625929..dc9d1ec3d337 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5018,9 +5018,9 @@ vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 
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
@@ -5043,10 +5043,10 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
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
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9ab707646ed1..86a17a23d6be 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1556,9 +1556,9 @@ struct kvm_x86_ops {
 	void (*vcpu_deliver_sipi_vector)(struct kvm_vcpu *vcpu, u8 vector);
 
 	int (*prepare_memory_region)(struct kvm *kvm,
-				     struct kvm_memory_slot *memslot,
-				     const struct kvm_userspace_memory_region *mem,
-				     enum kvm_mr_change change);
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change);
 
 #ifdef CONFIG_KVM_TDX_SEAM_BACKDOOR
 	void (*do_seamcall)(struct kvm_seamcall *call);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 1473fe8ce5a6..0a8bedaf9c1b 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -992,9 +992,9 @@ static void vt_setup_mce(struct kvm_vcpu *vcpu)
 }
 
 static int vt_prepare_memory_region(struct kvm *kvm,
-				    struct kvm_memory_slot *memslot,
-				    const struct kvm_userspace_memory_region *mem,
-				    enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	if (is_td(kvm))
 		tdx_prepare_memory_region(kvm, memslot, mem, change);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 4992750b6db0..839740a98d47 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2679,9 +2679,9 @@ static void tdx_flush_gprs(struct kvm_vcpu *vcpu)
 }
 
 static int tdx_prepare_memory_region(struct kvm *kvm,
-				     struct kvm_memory_slot *memslot,
-				     const struct kvm_userspace_memory_region *mem,
-				     enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	/* TDX Secure-EPT allows only RWX. */
 	if (mem->flags & KVM_MEM_READONLY)
diff --git a/arch/x86/kvm/vmx/tdx_stubs.c b/arch/x86/kvm/vmx/tdx_stubs.c
index 9c6023d18afd..490a5faeb411 100644
--- a/arch/x86/kvm/vmx/tdx_stubs.c
+++ b/arch/x86/kvm/vmx/tdx_stubs.c
@@ -28,9 +28,9 @@ static int tdx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector) { ret
 static void tdx_get_exit_info(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2,
 			      u32 *intr_info, u32 *error_code) {}
 static int tdx_prepare_memory_region(struct kvm *kvm,
-				     struct kvm_memory_slot *memslot,
-				     const struct kvm_userspace_memory_region *mem,
-				     enum kvm_mr_change change) { return 0; }
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change) { return 0; }
 static void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu) {}
 static int __init tdx_check_processor_compatibility(void) { return 0; }
 static void __init tdx_pre_kvm_init(unsigned int *vcpu_size,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a02920b49b26..1558f6375949 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11635,7 +11635,7 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	}
 
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
-		struct kvm_userspace_memory_region m;
+		struct kvm_userspace_memory_region_ext m;
 
 		m.slot = id | (i << 16);
 		m.flags = 0;
@@ -11841,9 +11841,9 @@ void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-				struct kvm_memory_slot *memslot,
-				const struct kvm_userspace_memory_region *mem,
-				enum kvm_mr_change change)
+			struct kvm_memory_slot *memslot,
+			const struct kvm_userspace_memory_region_ext *mem,
+			enum kvm_mr_change change)
 {
 	int err;
 
@@ -11948,10 +11948,10 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kvm,
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
index 3dd5c349f52e..99e9f9969703 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -824,20 +824,20 @@ enum kvm_mr_change {
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
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 7e3a8935534b..374da6767ef6 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -103,6 +103,17 @@ struct kvm_userspace_memory_region {
 	__u64 userspace_addr; /* start of the userspace allocated memory */
 };
 
+struct kvm_userspace_memory_region_ext {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size; /* bytes */
+	__u64 userspace_addr; /* offset into fd/private_fd */
+	__s32 fd;
+	__s32 private_fd; /* valid if guest private memory is supported */
+	__u32 padding[6];
+};
+
 /*
  * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
  * other bits are reserved for kvm internal use which are defined in
@@ -110,6 +121,7 @@ struct kvm_userspace_memory_region {
  */
 #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
 #define KVM_MEM_READONLY	(1UL << 1)
+#define KVM_MEM_FD		(1UL << 2)
 
 /* for KVM_IRQ_LINE */
 struct kvm_irq_level {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1578be8e4441..271cef8d1cd0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1424,7 +1424,7 @@ static void update_memslots(struct kvm_memslots *slots,
 }
 
 static int check_memory_region_flags(struct kvm *kvm,
-				     const struct kvm_userspace_memory_region *mem)
+			     const struct kvm_userspace_memory_region_ext *mem)
 {
 	u32 valid_flags = 0;
 
@@ -1537,7 +1537,7 @@ static struct kvm_memslots *kvm_dup_memslots(struct kvm_memslots *old,
 }
 
 static int kvm_set_memslot(struct kvm *kvm,
-			   const struct kvm_userspace_memory_region *mem,
+			   const struct kvm_userspace_memory_region_ext *mem,
 			   struct kvm_memory_slot *old,
 			   struct kvm_memory_slot *new, int as_id,
 			   enum kvm_mr_change change)
@@ -1629,7 +1629,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 }
 
 static int kvm_delete_memslot(struct kvm *kvm,
-			      const struct kvm_userspace_memory_region *mem,
+			      const struct kvm_userspace_memory_region_ext *mem,
 			      struct kvm_memory_slot *old, int as_id)
 {
 	struct kvm_memory_slot new;
@@ -1663,7 +1663,7 @@ static int kvm_delete_memslot(struct kvm *kvm,
  * Must be called holding kvm->slots_lock for write.
  */
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem)
+			    const struct kvm_userspace_memory_region_ext *mem)
 {
 	struct kvm_memory_slot old, new;
 	struct kvm_memory_slot *tmp;
@@ -1783,7 +1783,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem)
+			  const struct kvm_userspace_memory_region_ext *mem)
 {
 	int r;
 
@@ -1795,7 +1795,7 @@ int kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(kvm_set_memory_region);
 
 static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
-					  struct kvm_userspace_memory_region *mem)
+				struct kvm_userspace_memory_region_ext *mem)
 {
 	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
@@ -4368,12 +4368,19 @@ static long kvm_vm_ioctl(struct file *filp,
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
+		if (kvm_userspace_mem.flags & KVM_MEM_FD) {
+			int offset = offsetof(
+				struct kvm_userspace_memory_region_ext, fd);
+			if (copy_from_user(&kvm_userspace_mem.fd, argp + offset,
+					   sizeof(kvm_userspace_mem) - offset))
+				goto out;
+		}
 
 		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
 		break;
-- 
2.17.1

