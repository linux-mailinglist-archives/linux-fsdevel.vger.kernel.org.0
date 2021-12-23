Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1147E383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348567AbhLWMdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:33:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:1026 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348496AbhLWMcv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262771; x=1671798771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pB0U4IoAn2FVqOKKSo9Pzwd6Ru3anEta8cgDh0MsBiY=;
  b=Q+9BPttTnC1bIaYYCQ48ITLPUx5ewoFszWaJweKnQ6+rnD4eF5661h0K
   TaZdWb3OxOj/zpdX9UvSrsZA4iyhIzyxyNECt8XyM2fjflOCHeqHXHBIJ
   pZ4h1wn2R5QQ2Djf/4S5BBiT/uY/RIHgFKVVQelKgSS8fKuFIecW3Tx2w
   1orSw6k2dQ0IYRMhRlnREk7qR5xvo1nLjXA/weUqZNaJloWkYNGckXsPC
   rrZ4AIt5P+yfz0Z1Tfz6Oh/6AW3tbzyyL21fsuCB++Hie+CC90cgKSaAv
   usvMjU7hK7DrqKLYoKxGs5qYDrpvTmJJOvdK9T1TkBUPCsBa/kOci4Krd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="239574303"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="239574303"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="522079079"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 04:32:39 -0800
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
Subject: [PATCH v3 kvm/queue 14/16] KVM: Handle page fault for private memory
Date:   Thu, 23 Dec 2021 20:30:09 +0800
Message-Id: <20211223123011.41044-15-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
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
 arch/x86/kvm/mmu/mmu.c         | 73 ++++++++++++++++++++++++++++++++--
 arch/x86/kvm/mmu/paging_tmpl.h | 11 +++--
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2856eb662a21..fbcdf62f8281 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2920,6 +2920,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 	if (max_level == PG_LEVEL_4K)
 		return PG_LEVEL_4K;
 
+	if (kvm_slot_is_private(slot))
+		return max_level;
+
 	host_level = host_pfn_mapping_level(kvm, gfn, pfn, slot);
 	return min(host_level, max_level);
 }
@@ -3950,7 +3953,59 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
 }
 
-static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault, int *r)
+static bool kvm_vcpu_is_private_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	/*
+	 * At this time private gfn has not been supported yet. Other patch
+	 * that enables it should change this.
+	 */
+	return false;
+}
+
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
@@ -3984,6 +4039,10 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 		}
 	}
 
+	if (kvm_slot_is_private(slot) &&
+	    kvm_faultin_pfn_private(vcpu, fault, is_private_pfn, r))
+		return *r == RET_PF_FIXED ? false : true;
+
 	async = false;
 	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
 					  fault->write, &fault->map_writable,
@@ -4044,6 +4103,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
 
 	unsigned long mmu_seq;
+	bool is_private_pfn = false;
 	int r;
 
 	fault->gfn = fault->addr >> PAGE_SHIFT;
@@ -4063,7 +4123,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (kvm_faultin_pfn(vcpu, fault, &r))
+	if (kvm_faultin_pfn(vcpu, fault, &is_private_pfn, &r))
 		return r;
 
 	if (handle_abnormal_pfn(vcpu, fault, ACC_ALL, &r))
@@ -4076,7 +4136,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	else
 		write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
+	if (!is_private_pfn && is_page_fault_stale(vcpu, fault, mmu_seq))
 		goto out_unlock;
 
 	r = make_mmu_pages_available(vcpu);
@@ -4093,7 +4153,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
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
index 5b5bdac97c7b..640fd1e2fe4c 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -825,6 +825,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	int r;
 	unsigned long mmu_seq;
 	bool is_self_change_mapping;
+	bool is_private_pfn = false;
+
 
 	pgprintk("%s: addr %lx err %x\n", __func__, fault->addr, fault->error_code);
 	WARN_ON_ONCE(fault->is_tdp);
@@ -873,7 +875,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
 	smp_rmb();
 
-	if (kvm_faultin_pfn(vcpu, fault, &r))
+	if (kvm_faultin_pfn(vcpu, fault, &is_private_pfn, &r))
 		return r;
 
 	if (handle_abnormal_pfn(vcpu, fault, walker.pte_access, &r))
@@ -901,7 +903,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	r = RET_PF_RETRY;
 	write_lock(&vcpu->kvm->mmu_lock);
 
-	if (is_page_fault_stale(vcpu, fault, mmu_seq))
+	if (!is_private_pfn && is_page_fault_stale(vcpu, fault, mmu_seq))
 		goto out_unlock;
 
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PAGE_FAULT);
@@ -913,7 +915,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
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

