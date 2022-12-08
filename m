Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD9646E80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 12:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLHL2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 06:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLHL2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:28:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED8032BA1;
        Thu,  8 Dec 2022 03:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670498898; x=1702034898;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=kkfKYNW897QGADCHf4pXD/hg7a3COoLl72uqh/oQOlk=;
  b=dFOyK3HqLBDjC0Buk0lJpztFXD4JkZ+Pe91LscObKqkKguJiI+RQMuD7
   sWUk+p252Pm5b2FWJRs1mNvPhgww8zNLHlMFCzCMtZXRWZbjHuB+Z6ngx
   eSV8bP7mrLUtILxBlFUSINVvuSMf6wqzifYbOxyyoPSh0hvp0ZCMbp26k
   1Wcuvpta2hBh3m4Ll5IiBHBCuxVmP1ZN7y3zkBQJV45mc5kCKAPOLXZal
   v3hJa+40ldmuuMq/TllLbyhvwrVkoC1nBn05/rLxVuy6fs/N9TjEoFumo
   zhBz/DHceCp1ktusczvP0S+VQxkau5oi+DuKq/nRABdVpH/OLR2MSisse
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318286759"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="318286759"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 03:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="677720118"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="677720118"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 08 Dec 2022 03:28:05 -0800
Date:   Thu, 8 Dec 2022 19:23:46 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 8/9] KVM: Handle page fault for private memory
Message-ID: <20221208112346.GD1304936@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-9-chao.p.peng@linux.intel.com>
 <20221208022918.fbddl3bflsip4ivg@yy-desk-7060>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208022918.fbddl3bflsip4ivg@yy-desk-7060>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 08, 2022 at 10:29:18AM +0800, Yuan Yao wrote:
> On Fri, Dec 02, 2022 at 02:13:46PM +0800, Chao Peng wrote:
> > A KVM_MEM_PRIVATE memslot can include both fd-based private memory and
> > hva-based shared memory. Architecture code (like TDX code) can tell
> > whether the on-going fault is private or not. This patch adds a
> > 'is_private' field to kvm_page_fault to indicate this and architecture
> > code is expected to set it.
> >
> > To handle page fault for such memslot, the handling logic is different
> > depending on whether the fault is private or shared. KVM checks if
> > 'is_private' matches the host's view of the page (maintained in
> > mem_attr_array).
> >   - For a successful match, private pfn is obtained with
> >     restrictedmem_get_page() and shared pfn is obtained with existing
> >     get_user_pages().
> >   - For a failed match, KVM causes a KVM_EXIT_MEMORY_FAULT exit to
> >     userspace. Userspace then can convert memory between private/shared
> >     in host's view and retry the fault.
> >
> > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c          | 63 +++++++++++++++++++++++++++++++--
> >  arch/x86/kvm/mmu/mmu_internal.h | 14 +++++++-
> >  arch/x86/kvm/mmu/mmutrace.h     |  1 +
> >  arch/x86/kvm/mmu/tdp_mmu.c      |  2 +-
> >  include/linux/kvm_host.h        | 30 ++++++++++++++++
> >  5 files changed, 105 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 2190fd8c95c0..b1953ebc012e 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3058,7 +3058,7 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
> >
> >  int kvm_mmu_max_mapping_level(struct kvm *kvm,
> >  			      const struct kvm_memory_slot *slot, gfn_t gfn,
> > -			      int max_level)
> > +			      int max_level, bool is_private)
> >  {
> >  	struct kvm_lpage_info *linfo;
> >  	int host_level;
> > @@ -3070,6 +3070,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
> >  			break;
> >  	}
> >
> > +	if (is_private)
> > +		return max_level;
> 
> lpage mixed information already saved, so is that possible
> to query info->disallow_lpage without care 'is_private' ?

Actually we already queried info->disallow_lpage just before this
sentence. The check is needed because later in the function we call
host_pfn_mapping_level() which is shared memory specific.

Thanks,
Chao
> 
> > +
> >  	if (max_level == PG_LEVEL_4K)
> >  		return PG_LEVEL_4K;
> >
> > @@ -3098,7 +3101,8 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  	 * level, which will be used to do precise, accurate accounting.
> >  	 */
> >  	fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot,
> > -						     fault->gfn, fault->max_level);
> > +						     fault->gfn, fault->max_level,
> > +						     fault->is_private);
> >  	if (fault->req_level == PG_LEVEL_4K || fault->huge_page_disallowed)
> >  		return;
> >
> > @@ -4178,6 +4182,49 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
> >  	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
> >  }
> >
> > +static inline u8 order_to_level(int order)
> > +{
> > +	BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
> > +
> > +	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_1G))
> > +		return PG_LEVEL_1G;
> > +
> > +	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
> > +		return PG_LEVEL_2M;
> > +
> > +	return PG_LEVEL_4K;
> > +}
> > +
> > +static int kvm_do_memory_fault_exit(struct kvm_vcpu *vcpu,
> > +				    struct kvm_page_fault *fault)
> > +{
> > +	vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
> > +	if (fault->is_private)
> > +		vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
> > +	else
> > +		vcpu->run->memory.flags = 0;
> > +	vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> > +	vcpu->run->memory.size = PAGE_SIZE;
> > +	return RET_PF_USER;
> > +}
> > +
> > +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> > +				   struct kvm_page_fault *fault)
> > +{
> > +	int order;
> > +	struct kvm_memory_slot *slot = fault->slot;
> > +
> > +	if (!kvm_slot_can_be_private(slot))
> > +		return kvm_do_memory_fault_exit(vcpu, fault);
> > +
> > +	if (kvm_restricted_mem_get_pfn(slot, fault->gfn, &fault->pfn, &order))
> > +		return RET_PF_RETRY;
> > +
> > +	fault->max_level = min(order_to_level(order), fault->max_level);
> > +	fault->map_writable = !(slot->flags & KVM_MEM_READONLY);
> > +	return RET_PF_CONTINUE;
> > +}
> > +
> >  static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >  {
> >  	struct kvm_memory_slot *slot = fault->slot;
> > @@ -4210,6 +4257,12 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >  			return RET_PF_EMULATE;
> >  	}
> >
> > +	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn))
> > +		return kvm_do_memory_fault_exit(vcpu, fault);
> > +
> > +	if (fault->is_private)
> > +		return kvm_faultin_pfn_private(vcpu, fault);
> > +
> >  	async = false;
> >  	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, &async,
> >  					  fault->write, &fault->map_writable,
> > @@ -5599,6 +5652,9 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
> >  			return -EIO;
> >  	}
> >
> > +	if (r == RET_PF_USER)
> > +		return 0;
> > +
> >  	if (r < 0)
> >  		return r;
> >  	if (r != RET_PF_EMULATE)
> > @@ -6452,7 +6508,8 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
> >  		 */
> >  		if (sp->role.direct &&
> >  		    sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
> > -							       PG_LEVEL_NUM)) {
> > +							       PG_LEVEL_NUM,
> > +							       false)) {
> >  			kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
> >
> >  			if (kvm_available_flush_tlb_with_range())
> > diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> > index dbaf6755c5a7..5ccf08183b00 100644
> > --- a/arch/x86/kvm/mmu/mmu_internal.h
> > +++ b/arch/x86/kvm/mmu/mmu_internal.h
> > @@ -189,6 +189,7 @@ struct kvm_page_fault {
> >
> >  	/* Derived from mmu and global state.  */
> >  	const bool is_tdp;
> > +	const bool is_private;
> >  	const bool nx_huge_page_workaround_enabled;
> >
> >  	/*
> > @@ -237,6 +238,7 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
> >   * RET_PF_RETRY: let CPU fault again on the address.
> >   * RET_PF_EMULATE: mmio page fault, emulate the instruction directly.
> >   * RET_PF_INVALID: the spte is invalid, let the real page fault path update it.
> > + * RET_PF_USER: need to exit to userspace to handle this fault.
> >   * RET_PF_FIXED: The faulting entry has been fixed.
> >   * RET_PF_SPURIOUS: The faulting entry was already fixed, e.g. by another vCPU.
> >   *
> > @@ -253,6 +255,7 @@ enum {
> >  	RET_PF_RETRY,
> >  	RET_PF_EMULATE,
> >  	RET_PF_INVALID,
> > +	RET_PF_USER,
> >  	RET_PF_FIXED,
> >  	RET_PF_SPURIOUS,
> >  };
> > @@ -310,7 +313,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >
> >  int kvm_mmu_max_mapping_level(struct kvm *kvm,
> >  			      const struct kvm_memory_slot *slot, gfn_t gfn,
> > -			      int max_level);
> > +			      int max_level, bool is_private);
> >  void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
> >  void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_level);
> >
> > @@ -319,4 +322,13 @@ void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
> >  void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
> >  void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
> >
> > +#ifndef CONFIG_HAVE_KVM_RESTRICTED_MEM
> > +static inline int kvm_restricted_mem_get_pfn(struct kvm_memory_slot *slot,
> > +					gfn_t gfn, kvm_pfn_t *pfn, int *order)
> > +{
> > +	WARN_ON_ONCE(1);
> > +	return -EOPNOTSUPP;
> > +}
> > +#endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
> > +
> >  #endif /* __KVM_X86_MMU_INTERNAL_H */
> > diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
> > index ae86820cef69..2d7555381955 100644
> > --- a/arch/x86/kvm/mmu/mmutrace.h
> > +++ b/arch/x86/kvm/mmu/mmutrace.h
> > @@ -58,6 +58,7 @@ TRACE_DEFINE_ENUM(RET_PF_CONTINUE);
> >  TRACE_DEFINE_ENUM(RET_PF_RETRY);
> >  TRACE_DEFINE_ENUM(RET_PF_EMULATE);
> >  TRACE_DEFINE_ENUM(RET_PF_INVALID);
> > +TRACE_DEFINE_ENUM(RET_PF_USER);
> >  TRACE_DEFINE_ENUM(RET_PF_FIXED);
> >  TRACE_DEFINE_ENUM(RET_PF_SPURIOUS);
> >
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index 771210ce5181..8ba1a4afc546 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -1768,7 +1768,7 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
> >  			continue;
> >
> >  		max_mapping_level = kvm_mmu_max_mapping_level(kvm, slot,
> > -							      iter.gfn, PG_LEVEL_NUM);
> > +						iter.gfn, PG_LEVEL_NUM, false);
> >  		if (max_mapping_level < iter.level)
> >  			continue;
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 25099c94e770..153842bb33df 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2335,4 +2335,34 @@ static inline void kvm_arch_set_memory_attributes(struct kvm *kvm,
> >  }
> >  #endif /* __KVM_HAVE_ARCH_SET_MEMORY_ATTRIBUTES */
> >
> > +#ifdef CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES
> > +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +{
> > +	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn)) &
> > +	       KVM_MEMORY_ATTRIBUTE_PRIVATE;
> > +}
> > +#else
> > +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +{
> > +	return false;
> > +}
> > +
> > +#endif /* CONFIG_HAVE_KVM_MEMORY_ATTRIBUTES */
> > +
> > +#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
> > +static inline int kvm_restricted_mem_get_pfn(struct kvm_memory_slot *slot,
> > +					gfn_t gfn, kvm_pfn_t *pfn, int *order)
> > +{
> > +	int ret;
> > +	struct page *page;
> > +	pgoff_t index = gfn - slot->base_gfn +
> > +			(slot->restricted_offset >> PAGE_SHIFT);
> > +
> > +	ret = restrictedmem_get_page(slot->restricted_file, index,
> > +				     &page, order);
> > +	*pfn = page_to_pfn(page);
> > +	return ret;
> > +}
> > +#endif /* CONFIG_HAVE_KVM_RESTRICTED_MEM */
> > +
> >  #endif
> > --
> > 2.25.1
> >
> >
