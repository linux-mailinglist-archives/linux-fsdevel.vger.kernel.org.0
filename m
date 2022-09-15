Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A22E5B9D6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 16:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIOOg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiIOOgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:36:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2288DD6;
        Thu, 15 Sep 2022 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663252512; x=1694788512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OtV5Z+PSFLnhwjt/AzM9n4q6l2/VthWxC8/mcPUKv2E=;
  b=b3HEzBN/LPv1d188VDJQPEnaCpgPcJjNby3hhAjVQkSwIrDCKG0ubnMj
   TfbU0XWmC60MctCz8gwTxKN0QuCvEyUZUTLHFmN5UAMqidtgZ0Cya2Grl
   pE7kWsnJ6At2oaqpiR/8DW4MxqhvmvZdT7yWm1QwP7yNbVPT+g+wE8XtP
   qiQqofZQvMECjlJIYxfxDvSZ1lnaulTKYVZDngoTkdQH6hCWdr8JgY006
   Y8gbR3javi4BqSE22VPr6L4nmZOe6Ehot7aHnpQTmyfkvS4OPFKSQ6yCh
   Aa0sz69hsUk9SASOQd/d2rX3OlRdARhHt2F/QVV++T/4W2Ur5N/EVLFTq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="385021706"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="385021706"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 07:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="945977249"
Received: from chaop.bj.intel.com ([10.240.193.75])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2022 07:35:02 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: [PATCH v8 7/8] KVM: Handle page fault for private memory
Date:   Thu, 15 Sep 2022 22:29:12 +0800
Message-Id: <20220915142913.2213336-8-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
'is_private' matches the host's view of the page (this is maintained in
mem_attr_array).
  - For a successful match, private pfn is obtained with
    inaccessible_get_pfn() from private fd and shared pfn is obtained
    with existing get_user_pages().
  - For a failed match, KVM causes a KVM_EXIT_MEMORY_FAULT exit to
    userspace. Userspace then can convert memory between private/shared
    in host's view and then retry the access.

Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/mmu/mmu.c          | 54 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/mmu/mmu_internal.h | 18 +++++++++++
 arch/x86/kvm/mmu/mmutrace.h     |  1 +
 include/linux/kvm_host.h        | 24 +++++++++++++++
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a0f198cede3d..81ab20003824 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3028,6 +3028,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
 			break;
 	}
 
+	if (kvm_mem_is_private(kvm, gfn))
+		return max_level;
+
 	if (max_level == PG_LEVEL_4K)
 		return PG_LEVEL_4K;
 
@@ -4127,6 +4130,32 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
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
+	if (kvm_private_mem_get_pfn(slot, fault->gfn, &fault->pfn, &order))
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
@@ -4159,6 +4188,22 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
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
@@ -4267,7 +4312,11 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		read_unlock(&vcpu->kvm->mmu_lock);
 	else
 		write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+
+	if (fault->is_private)
+		kvm_private_mem_put_pfn(fault->slot, fault->pfn);
+	else
+		kvm_release_pfn_clean(fault->pfn);
 	return r;
 }
 
@@ -5543,6 +5592,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 			return -EIO;
 	}
 
+	if (r == RET_PF_USER)
+		return 0;
+
 	if (r < 0)
 		return r;
 	if (r != RET_PF_EMULATE)
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 582def531d4d..a55e352246a7 100644
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
@@ -318,4 +321,19 @@ void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 void account_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 void unaccount_huge_nx_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 
+#ifndef CONFIG_HAVE_KVM_PRIVATE_MEM
+static inline int kvm_private_mem_get_pfn(struct kvm_memory_slot *slot,
+					  gfn_t gfn, kvm_pfn_t *pfn, int *order)
+{
+	WARN_ON_ONCE(1);
+	return -EOPNOTSUPP;
+}
+
+static inline void kvm_private_mem_put_pfn(struct kvm_memory_slot *slot,
+					   kvm_pfn_t pfn)
+{
+	WARN_ON_ONCE(1);
+}
+#endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
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
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index fd36ce6597ad..b9906cdf468b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2292,6 +2292,30 @@ static inline void kvm_arch_update_mem_attr(struct kvm *kvm, unsigned int attr,
 }
 #endif
 
+static inline int kvm_private_mem_get_pfn(struct kvm_memory_slot *slot,
+					  gfn_t gfn, kvm_pfn_t *pfn, int *order)
+{
+	int ret;
+	pfn_t pfnt;
+	pgoff_t index = gfn - slot->base_gfn +
+			(slot->private_offset >> PAGE_SHIFT);
+
+	ret = inaccessible_get_pfn(slot->private_file, index, &pfnt, order);
+	*pfn = pfn_t_to_pfn(pfnt);
+	return ret;
+}
+
+static inline void kvm_private_mem_put_pfn(struct kvm_memory_slot *slot,
+					   kvm_pfn_t pfn)
+{
+	inaccessible_put_pfn(slot->private_file, pfn_to_pfn_t(pfn));
+}
+
+static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
+{
+	return !xa_load(&kvm->mem_attr_array, gfn);
+}
+
 #endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
 
 #endif
-- 
2.25.1

