Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F6060D05C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiJYPV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiJYPVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:21:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF219C33;
        Tue, 25 Oct 2022 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666711193; x=1698247193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Npg8YeluRyzE+wi0wB8FNymqEhtTKsC/t0Ec1nfRz0=;
  b=G8FJPcFB2N/IRaWapAdfIezBzvfEH77ePUyQiKhX62SrrrevISZISH5J
   xZNR1lKwIXdOCG1v0Lfb62FG2VU4uaB512ps58TiKNGxr5Ba8pxsJFIgv
   J4nief4E3/bX9UtkpZcXrBlLg/B/2sv56uRcH0OFCdQCdUD2x8cJrlyDX
   TwjHBead7ggo5fk+54ArvLVFICVJtQ+ZgUgBE2SnkuWmY5egbvI50GgFV
   mKkzpi0tSzLez4y/0EKim2dpxH5r+bn34JfgkcmrISXkfWXGSn5dgzjlS
   49TotV7MCA1YXxgC1C9NVVRevzXZipJNtPpl4w16BNGJkRfiXMi29iRqt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="369772308"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="369772308"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 08:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="736865800"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="736865800"
Received: from chaop.bj.intel.com ([10.240.193.75])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2022 08:19:32 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: [PATCH v9 7/8] KVM: Handle page fault for private memory
Date:   Tue, 25 Oct 2022 23:13:43 +0800
Message-Id: <20221025151344.3784230-8-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A memslot with KVM_MEM_PRIVATE being set can include both fd-based
private memory and hva-based shared memory. Architecture code (like TDX
code) can tell whether the on-going fault is private or not. This patch
adds a 'is_private' field to kvm_page_fault to indicate this and
architecture code is expected to set it.

To handle page fault for such memslot, the handling logic is different
depending on whether the fault is private or shared. KVM checks if
'is_private' matches the host's view of the page (maintained in
mem_attr_array).
  - For a successful match, private pfn is obtained with
    restrictedmem_get_page () from private fd and shared pfn is obtained
    with existing get_user_pages().
  - For a failed match, KVM causes a KVM_EXIT_MEMORY_FAULT exit to
    userspace. Userspace then can convert memory between private/shared
    in host's view and retry the fault.

Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/mmu/mmu.c          | 56 +++++++++++++++++++++++++++++++--
 arch/x86/kvm/mmu/mmu_internal.h | 14 ++++++++-
 arch/x86/kvm/mmu/mmutrace.h     |  1 +
 arch/x86/kvm/mmu/spte.h         |  6 ++++
 arch/x86/kvm/mmu/tdp_mmu.c      |  3 +-
 include/linux/kvm_host.h        | 28 +++++++++++++++++
 6 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 67a9823a8c35..10017a9f26ee 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3030,7 +3030,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 
 int kvm_mmu_max_mapping_level(struct kvm *kvm,
 			      const struct kvm_memory_slot *slot, gfn_t gfn,
-			      int max_level)
+			      int max_level, bool is_private)
 {
 	struct kvm_lpage_info *linfo;
 	int host_level;
@@ -3042,6 +3042,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 			break;
 	}
 
+	if (is_private)
+		return max_level;
+
 	if (max_level == PG_LEVEL_4K)
 		return PG_LEVEL_4K;
 
@@ -3070,7 +3073,8 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * level, which will be used to do precise, accurate accounting.
 	 */
 	fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot,
-						     fault->gfn, fault->max_level);
+						     fault->gfn, fault->max_level,
+						     fault->is_private);
 	if (fault->req_level == PG_LEVEL_4K || fault->huge_page_disallowed)
 		return;
 
@@ -4141,6 +4145,32 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
 }
 
+static inline u8 order_to_level(int order)
+{
+	BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
+
+	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
+		return PG_LEVEL_1G;
+
+	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
+		return PG_LEVEL_2M;
+
+	return PG_LEVEL_4K;
+}
+
+static int kvm_faultin_pfn_private(struct kvm_page_fault *fault)
+{
+	int order;
+	struct kvm_memory_slot *slot = fault->slot;
+
+	if (kvm_restricted_mem_get_pfn(slot, fault->gfn, &fault->pfn, &order))
+		return RET_PF_RETRY;
+
+	fault->max_level = min(order_to_level(order), fault->max_level);
+	fault->map_writable = !(slot->flags & KVM_MEM_READONLY);
+	return RET_PF_CONTINUE;
+}
+
 static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_memory_slot *slot = fault->slot;
@@ -4173,6 +4203,22 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 			return RET_PF_EMULATE;
 	}
 
+	if (kvm_slot_can_be_private(slot) &&
+	    fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
+		vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
+		if (fault->is_private)
+			vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
+		else
+			vcpu->run->memory.flags = 0;
+		vcpu->run->memory.padding = 0;
+		vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
+		vcpu->run->memory.size = PAGE_SIZE;
+		return RET_PF_USER;
+	}
+
+	if (fault->is_private)
+		return kvm_faultin_pfn_private(fault);
+
 	async = false;
 	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
 					  fault->write, &fault->map_writable,
@@ -5557,6 +5603,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 			return -EIO;
 	}
 
+	if (r == RET_PF_USER)
+		return 0;
+
 	if (r < 0)
 		return r;
 	if (r != RET_PF_EMULATE)
@@ -6408,7 +6457,8 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		 */
 		if (sp->role.direct &&
 		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
-							       PG_LEVEL_NUM)) {
+							       PG_LEVEL_NUM,
+							       false)) {
 			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
 
 			if (kvm_available_flush_tlb_with_range())
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 582def531d4d..5cdff5ca546c 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -188,6 +188,7 @@ struct kvm_page_fault {
 
 	/* Derived from mmu and global state.  */
 	const bool is_tdp;
+	const bool is_private;
 	const bool nx_huge_page_workaround_enabled;
 
 	/*
@@ -236,6 +237,7 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
  * RET_PF_RETRY: let CPU fault again on the address.
  * RET_PF_EMULATE: mmio page fault, emulate the instruction directly.
  * RET_PF_INVALID: the spte is invalid, let the real page fault path update it.
+ * RET_PF_USER: need to exit to userspace to handle this fault.
  * RET_PF_FIXED: The faulting entry has been fixed.
  * RET_PF_SPURIOUS: The faulting entry was already fixed, e.g. by another vCPU.
  *
@@ -252,6 +254,7 @@ enum {
 	RET_PF_RETRY,
 	RET_PF_EMULATE,
 	RET_PF_INVALID,
+	RET_PF_USER,
 	RET_PF_FIXED,
 	RET_PF_SPURIOUS,
 };
@@ -309,7 +312,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 int kvm_mmu_max_mapping_level(struct kvm *kvm,
 			      const struct kvm_memory_slot *slot, gfn_t gfn,
-			      int max_level);
+			      int max_level, bool is_private);
 void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_level);
 
@@ -318,4 +321,13 @@ void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 
+#ifndef CONFIG_HAVE_KVM_RESTRICTED_MEM
+static inline int kvm_restricted_mem_get_pfn(struct kvm_memory_slot *slot,
+					gfn_t gfn, kvm_pfn_t *pfn, int *order)
+{
+	WARN_ON_ONCE(1);
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
+
 #endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index ae86820cef69..2d7555381955 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -58,6 +58,7 @@ TRACE_DEFINE_ENUM(RET_PF_CONTINUE);
 TRACE_DEFINE_ENUM(RET_PF_RETRY);
 TRACE_DEFINE_ENUM(RET_PF_EMULATE);
 TRACE_DEFINE_ENUM(RET_PF_INVALID);
+TRACE_DEFINE_ENUM(RET_PF_USER);
 TRACE_DEFINE_ENUM(RET_PF_FIXED);
 TRACE_DEFINE_ENUM(RET_PF_SPURIOUS);
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 7670c13ce251..9acdf72537ce 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -315,6 +315,12 @@ static inline bool is_dirty_spte(u64 spte)
 	return dirty_mask ? spte & dirty_mask : spte & PT_WRITABLE_MASK;
 }
 
+static inline bool is_private_spte(u64 spte)
+{
+	/* FIXME: Query C-bit/S-bit for SEV/TDX. */
+	return false;
+}
+
 static inline u64 get_rsvd_bits(struct rsvd_bits_validate *rsvd_check, u64 pte,
 				int level)
 {
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 672f0432d777..9f97aac90606 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1768,7 +1768,8 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
 			continue;
 
 		max_mapping_level = kvm_mmu_max_mapping_level(kvm, slot,
-							      iter.gfn, PG_LEVEL_NUM);
+						iter.gfn, PG_LEVEL_NUM,
+						is_private_spte(iter.old_spte));
 		if (max_mapping_level < iter.level)
 			continue;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6ce36065532c..69300fc6d572 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2301,6 +2301,34 @@ static inline void kvm_arch_update_mem_attr(struct kvm *kvm,
 }
 #endif
 
+static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
+{
+	return !xa_load(&kvm->mem_attr_array, gfn);
+}
+
+#else /* !CONFIG_KVM_GENERIC_PRIVATE_MEM */
+
+static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
+{
+	return false;
+}
+
 #endif /* CONFIG_KVM_GENERIC_PRIVATE_MEM */
 
+#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
+static inline int kvm_restricted_mem_get_pfn(struct kvm_memory_slot *slot,
+					gfn_t gfn, kvm_pfn_t *pfn, int *order)
+{
+	int ret;
+	struct page *page;
+	pgoff_t index = gfn - slot->base_gfn +
+			(slot->restricted_offset >> PAGE_SHIFT);
+
+	ret = restrictedmem_get_page(slot->restricted_file, index,
+				     &page, order);
+	*pfn = page_to_pfn(page);
+	return ret;
+}
+#endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
+
 #endif
-- 
2.25.1

