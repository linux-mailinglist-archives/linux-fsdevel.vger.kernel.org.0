Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ECD47C28D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbhLUPOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:14:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:9908 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239194AbhLUPOM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099652; x=1671635652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IxToifQm+9Y4O1zxSJ9m5WL26XRsf9dP/O1hd+4ZWcI=;
  b=j6r9elk+ufSCyS5ysnvuJEsASsey4YFiQ/PzuqEIqxmp/oJi3Td0i/ns
   HCeJFROX9KPq6JHENUozouJ/cBEToQtmSgNAU3F8AYXRMnWLOqff+V55e
   ngRHtYZ7FXmcve16OTxnxAh/N6agj5iEf63LX9XhWCBmDPhg86nY80vEk
   DKu6/IYKzaK2/WWKb58XtqMS12Qt+4vl/3EUMtQVdZMvpwQOykgulr1I/
   i9Wbue7rLZ24rNsKWnGlWXMUIbbJwBO6jxsKkxje0I8h9sMhkblXQT5Gm
   XLJpk0SsDUj0AIngl1xyWIgXOv/1MfV/6EPnkBlWrGthoYCh4KTYbLKFi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227704138"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="227704138"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:13:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688647"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:13:40 -0800
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
Subject: [PATCH v3 13/15] KVM: Handle page fault for private memory
Date:   Tue, 21 Dec 2021 23:11:23 +0800
Message-Id: <20211221151125.19446-14-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a page fault from the secondary page table while the guest is
running happens in a memslot with KVM_MEM_PRIVATE, we need go
different paths for private access and shared access.

  - For private access, KVM checks if the page is already allocated in
    the memory backend, if yes KVM establishes the mapping, otherwise
    exits to userspace to convert a shared page to private one.

  - For shared access, KVM also checks if the page is already allocated
    in the memory backend, if yes then exit to userspace to convert a
    private page to shared one, otherwise it's treated as a traditional
    hva-based shared memory, KVM lets existing code to obtain a pfn with
    get_user_pages() and establish the mapping.

The above code assume private memory is persistent and pre-allocated in
the memory backend so KVM can use this information as an indicator for
a page is private or shared. The above check is then performed by
calling kvm_memfd_get_pfn() which currently is implemented as a
pagecache search but in theory that can be implemented differently
(i.e. when the page is even not mapped into host pagecache there should
be some different implementation).

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/mmu/mmu.c         | 64 +++++++++++++++++++++++++++++++---
 arch/x86/kvm/mmu/paging_tmpl.h | 11 ++++--
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a7006e1ac2d2..7fc29f85313d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3156,6 +3156,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 	if (max_level == PG_LEVEL_4K)
 		return PG_LEVEL_4K;
 
+	if (kvm_slot_is_private(slot))
+		return max_level;
+
 	host_level = host_pfn_mapping_level(kvm, gfn, pfn, slot);
 	return min(host_level, max_level);
 }
@@ -4359,7 +4362,50 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
 }
 
-static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault, int *r)
+static bool kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
+				    struct kvm_page_fault *fault,
+				    bool *is_private_pfn, int *r)
+{
+	int order;
+	int mem_convert_type;
+	struct kvm_memory_slot *slot = fault->slot;
+	long pfn = kvm_memfd_get_pfn(slot, fault->gfn, &order);
+
+	if (kvm_vcpu_is_private_gfn(vcpu, fault->addr >> PAGE_SHIFT)) {
+		if (pfn < 0)
+			mem_convert_type = KVM_EXIT_MEM_MAP_PRIVATE;
+		else {
+			fault->pfn = pfn;
+			if (slot->flags & KVM_MEM_READONLY)
+				fault->map_writable = false;
+			else
+				fault->map_writable = true;
+
+			if (order == 0)
+				fault->max_level = PG_LEVEL_4K;
+			*is_private_pfn = true;
+			*r = RET_PF_FIXED;
+			return true;
+		}
+	} else {
+		if (pfn < 0)
+			return false;
+
+		kvm_memfd_put_pfn(pfn);
+		mem_convert_type = KVM_EXIT_MEM_MAP_SHARED;
+	}
+
+	vcpu->run->exit_reason = KVM_EXIT_MEMORY_ERROR;
+	vcpu->run->mem.type = mem_convert_type;
+	vcpu->run->mem.u.map.gpa = fault->gfn << PAGE_SHIFT;
+	vcpu->run->mem.u.map.size = PAGE_SIZE;
+	fault->pfn = -1;
+	*r = -1;
+	return true;
+}
+
+static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
+			    bool *is_private_pfn, int *r)
 {
 	struct kvm_memory_slot *slot = fault->slot;
 	bool async;
@@ -4400,6 +4446,10 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 		}
 	}
 
+	if (kvm_slot_is_private(slot) &&
+	    kvm_faultin_pfn_private(vcpu, fault, is_private_pfn, r))
+		return *r == RET_PF_FIXED ? false : true;
+
 	async = false;
 	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
 					  fault->write, &fault->map_writable,
@@ -4446,6 +4496,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
 
 	unsigned long mmu_seq;
+	bool is_private_pfn = false;
 	int r;
 
 	fault->gfn = kvm_gfn_unalias(vcpu->kvm, fault->addr);
@@ -4465,7 +4516,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (kvm_faultin_pfn(vcpu, fault, &r))
+	if (kvm_faultin_pfn(vcpu, fault, &is_private_pfn, &r))
 		return r;
 
 	if (handle_abnormal_pfn(vcpu, fault, ACC_ALL, &r))
@@ -4504,7 +4555,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	else
 		write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
+	if (!is_private_pfn && is_page_fault_stale(vcpu, fault, mmu_seq))
 		goto out_unlock;
 
 	r = make_mmu_pages_available(vcpu);
@@ -4522,7 +4573,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		read_unlock(&vcpu->kvm->mmu_lock);
 	else
 		write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+
+	if (is_private_pfn)
+		kvm_memfd_put_pfn(fault->pfn);
+	else
+		kvm_release_pfn_clean(fault->pfn);
+
 	return r;
 }
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 6d343a399913..ebd5c923f844 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -842,6 +842,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	int r;
 	unsigned long mmu_seq;
 	bool is_self_change_mapping;
+	bool is_private_pfn = false;
+
 
 	pgprintk("%s: addr %lx err %x\n", __func__, fault->addr, fault->error_code);
 	WARN_ON_ONCE(fault->is_tdp);
@@ -890,7 +892,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (kvm_faultin_pfn(vcpu, fault, &r))
+	if (kvm_faultin_pfn(vcpu, fault, &is_private_pfn, &r))
 		return r;
 
 	if (handle_abnormal_pfn(vcpu, fault, walker.pte_access, &r))
@@ -918,7 +920,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
+	if (!is_private_pfn && is_page_fault_stale(vcpu, fault, mmu_seq))
 		goto out_unlock;
 
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PAGE_FAULT);
@@ -930,7 +932,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+	if (is_private_pfn)
+		kvm_memfd_put_pfn(fault->pfn);
+	else
+		kvm_release_pfn_clean(fault->pfn);
 	return r;
 }
 
-- 
2.17.1

