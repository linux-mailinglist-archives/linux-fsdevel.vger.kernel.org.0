Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0B844D7F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhKKOSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:18:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:59112 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233773AbhKKOSS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:18:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="293739862"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="293739862"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492555579"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:15:12 -0800
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
Subject: [RFC PATCH 3/6] kvm: x86: add private_ops to memslot
Date:   Thu, 11 Nov 2021 22:13:42 +0800
Message-Id: <20211111141352.26311-4-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
References: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Guest memory for guest private memslot is designed to be backed by an
"enlightened" file descriptor(fd). Some callbacks (working on the fd)
are implemented by some other kernel subsystems who want to provide
guest private memory to help KVM to establish the memory mapping.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 Documentation/virt/kvm/api.rst |  1 +
 arch/x86/kvm/mmu/mmu.c         | 47 ++++++++++++++++++++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  3 ++-
 include/linux/kvm_host.h       |  8 ++++++
 include/uapi/linux/kvm.h       |  3 +++
 5 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 47054a79d395..16c06bf10302 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1260,6 +1260,7 @@ yet and must be cleared on entry.
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
 	__u64 userspace_addr; /* start of the userspace allocated memory */
+	__u32 fd; /* memory fd that provides guest memory */
   };
 
   /* for kvm_memory_region::flags */
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8483c15eac6f..af5ecf4ef62a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2932,6 +2932,19 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	return level;
 }
 
+static int host_private_pfn_mapping_level(const struct kvm_memory_slot *slot,
+		gfn_t gfn)
+{
+	kvm_pfn_t pfn;
+	int page_level = PG_LEVEL_4K;
+
+	pfn = slot->private_ops->get_lock_pfn(slot, gfn, &page_level);
+	if (pfn >= 0)
+		slot->private_ops->put_unlock_pfn(pfn);
+
+	return page_level;
+}
+
 int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_memory_slot *slot,
 			      gfn_t gfn, kvm_pfn_t pfn, int max_level)
 {
@@ -2947,6 +2960,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (max_level == PG_LEVEL_4K)
 		return PG_LEVEL_4K;
 
+	if (memslot_is_private(slot))
+		return host_private_pfn_mapping_level(slot, gfn);
+
 	return host_pfn_mapping_level(kvm, gfn, pfn, slot);
 }
 
@@ -3926,10 +3942,13 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 			 gpa_t cr2_or_gpa, kvm_pfn_t *pfn, hva_t *hva,
-			 bool write, bool *writable)
+			 bool write, bool *writable, bool private)
 {
-	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+	struct kvm_memory_slot *slot;
 	bool async;
+	int page_level;
+
+	slot = __kvm_vcpu_gfn_to_memslot(vcpu, gfn, private);
 
 	/* Don't expose aliases for no slot GFNs or private memslots */
 	if ((cr2_or_gpa & vcpu_gpa_stolen_mask(vcpu)) &&
@@ -3945,6 +3964,17 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 		return false;
 	}
 
+	if (private) {
+		*pfn = slot->private_ops->get_lock_pfn(slot, gfn, &page_level);
+		if (*pfn < 0)
+			*pfn = KVM_PFN_ERR_FAULT;
+		if (writable)
+			*writable = slot->flags & KVM_MEM_READONLY ?
+						false : true;
+
+		return false;
+	}
+
 	async = false;
 	*pfn = __gfn_to_pfn_memslot(slot, gfn, false, &async,
 				    write, writable, hva);
@@ -3971,7 +4001,9 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			     kvm_pfn_t *pfn)
 {
 	bool write = error_code & PFERR_WRITE_MASK;
+	bool private = is_private_gfn(vcpu, gpa >> PAGE_SHIFT);
 	bool map_writable;
+	struct kvm_memory_slot *slot;
 
 	gfn_t gfn = vcpu_gpa_to_gfn_unalias(vcpu, gpa);
 	unsigned long mmu_seq;
@@ -3995,7 +4027,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	smp_rmb();
 
 	if (try_async_pf(vcpu, prefault, gfn, gpa, pfn, &hva,
-			 write, &map_writable))
+			 write, &map_writable, private))
 		return RET_PF_RETRY;
 
 	if (handle_abnormal_pfn(vcpu, is_tdp ? 0 : gpa, gfn, *pfn, ACC_ALL, &r))
@@ -4008,7 +4040,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	else
 		write_lock(&vcpu->kvm->mmu_lock);
 
-	if (!is_noslot_pfn(*pfn) &&
+	if (!private && !is_noslot_pfn(*pfn) &&
 	    mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, hva))
 		goto out_unlock;
 	r = make_mmu_pages_available(vcpu);
@@ -4027,7 +4059,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		read_unlock(&vcpu->kvm->mmu_lock);
 	else
 		write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(*pfn);
+
+	if (!private)
+		kvm_release_pfn_clean(*pfn);
+	else
+		slot->private_ops->put_unlock_pfn(*pfn);
+
 	return r;
 }
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 1fc3a0826072..5ffeb9c85fba 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -799,6 +799,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 {
 	bool write_fault = error_code & PFERR_WRITE_MASK;
 	bool user_fault = error_code & PFERR_USER_MASK;
+	bool private = is_private_gfn(vcpu, addr >> PAGE_SHIFT);
 	struct guest_walker walker;
 	int r;
 	kvm_pfn_t pfn;
@@ -854,7 +855,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 	smp_rmb();
 
 	if (try_async_pf(vcpu, prefault, walker.gfn, addr, &pfn, &hva,
-			 write_fault, &map_writable))
+			 write_fault, &map_writable, private))
 		return RET_PF_RETRY;
 
 	if (handle_abnormal_pfn(vcpu, addr, walker.gfn, pfn, walker.pte_access, &r))
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8e5b197230ed..83345460c5f5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -347,6 +347,12 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 	return cmpxchg(&vcpu->mode, IN_GUEST_MODE, EXITING_GUEST_MODE);
 }
 
+struct kvm_private_memory_ops {
+	unsigned long (*get_lock_pfn)(const struct kvm_memory_slot *slot,
+				      gfn_t gfn, int *page_level);
+	void (*put_unlock_pfn)(unsigned long pfn);
+};
+
 /*
  * Some of the bitops functions do not support too long bitmaps.
  * This number must be determined not to exceed such limits.
@@ -362,6 +368,8 @@ struct kvm_memory_slot {
 	u32 flags;
 	short id;
 	u16 as_id;
+	struct file *file;
+	struct kvm_private_memory_ops *private_ops;
 };
 
 static inline bool kvm_slot_dirty_track_enabled(struct kvm_memory_slot *slot)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d3c9caf86d80..8d20caae9180 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -100,6 +100,9 @@ struct kvm_userspace_memory_region {
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
 	__u64 userspace_addr; /* start of the userspace allocated memory */
+#ifdef KVM_PRIVATE_ADDRESS_SPACE
+	__u32 fd; /* valid if memslot is guest private memory */
+#endif
 };
 
 /*
-- 
2.17.1

