Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC545889F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 11:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiHCJ5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 05:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiHCJ47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:56:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB9B1CB03;
        Wed,  3 Aug 2022 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659520618; x=1691056618;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=p5ITce4KSwHKZdQfiAt1mQ6fsiDPcz5sMpR9X2/JV9U=;
  b=J44Oroi9dkQohAkdmm//1B3v0l3PSQYvfuswpDxH10tA4gy/+8JuXOVQ
   Wfok64HMXke9Dlb5BIsAYfLsGUXyxrslajIu9ZLN38w2+plrSOLuQh0cm
   uxBzY2tJyfuREhUH0ZKCDCzqEP/ET+vY6ZdCfIq9HgNRn1VIUx+P3PdZL
   5KXEYPouBEe1ajqbEAYNwC692NS9tLy0SHWyEBBGAor5tE2Te1uwHtJS7
   9zfcX+P7gL3QIhNFX6u5Sq0CPjbBBYnc9drQ8Y7NEKEnUQZZBgn7UxCZr
   XH3wC7QoLwXu0YuwEyhy8RuIOL/AD9oexftddJqjrpt3Sxm27F+DlADSm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="272680561"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="272680561"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="599589620"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2022 02:56:47 -0700
Date:   Wed, 3 Aug 2022 17:52:00 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 12/14] KVM: Handle page fault for private memory
Message-ID: <20220803095200.GB607465@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-13-chao.p.peng@linux.intel.com>
 <YuRKAcT3cuEE4GgF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuRKAcT3cuEE4GgF@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 08:58:41PM +0000, Sean Christopherson wrote:
> On Wed, Jul 06, 2022, Chao Peng wrote:
> > A page fault can carry the private/shared information for
> > KVM_MEM_PRIVATE memslot, this can be filled by architecture code(like
> > TDX code). To handle page fault for such access, KVM maps the page only
> > when this private property matches the host's view on the page.
> > 
> > For a successful match, private pfn is obtained with memfile_notifier
> > callbacks from private fd and shared pfn is obtained with existing
> > get_user_pages.
> > 
> > For a failed match, KVM causes a KVM_EXIT_MEMORY_FAULT exit to
> > userspace. Userspace then can convert memory between private/shared from
> > host's view then retry the access.
> > 
> > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c          | 60 ++++++++++++++++++++++++++++++++-
> >  arch/x86/kvm/mmu/mmu_internal.h | 18 ++++++++++
> >  arch/x86/kvm/mmu/mmutrace.h     |  1 +
> >  include/linux/kvm_host.h        | 35 ++++++++++++++++++-
> >  4 files changed, 112 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 545eb74305fe..27dbdd4fe8d1 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3004,6 +3004,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
> >  	if (max_level == PG_LEVEL_4K)
> >  		return PG_LEVEL_4K;
> >  
> > +	if (kvm_mem_is_private(kvm, gfn))
> > +		return max_level;
> > +
> >  	host_level = host_pfn_mapping_level(kvm, gfn, pfn, slot);
> >  	return min(host_level, max_level);
> >  }
> > @@ -4101,10 +4104,52 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
> >  	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, 0, true);
> >  }
> >  
> > +static inline u8 order_to_level(int order)
> > +{
> > +	enum pg_level level;
> > +
> > +	for (level = KVM_MAX_HUGEPAGE_LEVEL; level > PG_LEVEL_4K; level--)
> 
> Curly braces needed for the for-loop.
> 
> And I think it makes sense to take in the fault->max_level, that way this is
> slightly more performant when the guest mapping is smaller than the host, e.g.
> 
> 	for (level = max_level; level > PG_LEVEL_4K; level--)
> 		...
> 
> 	return level;
> 
> Though I think I'd vote to avoid a loop entirely and do:
> 
> 	BUILD_BUG_ON(KVM_MAX_HUGEPAGE_LEVEL > PG_LEVEL_1G);
> 
> 	if (order > ???)
> 		return PG_LEVEL_1G;
> 	
> 	if (order > ???)
> 		return PG_LEVEL_2M;
> 
> 	return PG_LEVEL_4K;

Sounds good.

> 
> 
> > +		if (order >= page_level_shift(level) - PAGE_SHIFT)
> > +			return level;
> > +	return level;
> > +}
> > +
> > +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> > +				   struct kvm_page_fault *fault)
> > +{
> > +	int order;
> > +	struct kvm_memory_slot *slot = fault->slot;
> > +	bool private_exist = kvm_mem_is_private(vcpu->kvm, fault->gfn);
> > +
> > +	if (fault->is_private != private_exist) {
> > +		vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
> > +		if (fault->is_private)
> > +			vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
> > +		else
> > +			vcpu->run->memory.flags = 0;
> > +		vcpu->run->memory.padding = 0;
> > +		vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> > +		vcpu->run->memory.size = PAGE_SIZE;
> > +		return RET_PF_USER;
> > +	}
> > +
> > +	if (fault->is_private) {
> > +		if (kvm_private_mem_get_pfn(slot, fault->gfn, &fault->pfn, &order))
> > +			return RET_PF_RETRY;
> > +		fault->max_level = min(order_to_level(order), fault->max_level);
> > +		fault->map_writable = !(slot->flags & KVM_MEM_READONLY);
> > +		return RET_PF_FIXED;
> > +	}
> > +
> > +	/* Fault is shared, fallthrough. */
> > +	return RET_PF_CONTINUE;
> > +}
> > +
> >  static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >  {
> >  	struct kvm_memory_slot *slot = fault->slot;
> >  	bool async;
> > +	int r;
> >  
> >  	/*
> >  	 * Retry the page fault if the gfn hit a memslot that is being deleted
> > @@ -4133,6 +4178,12 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >  			return RET_PF_EMULATE;
> >  	}
> >  
> > +	if (kvm_slot_can_be_private(slot)) {
> > +		r = kvm_faultin_pfn_private(vcpu, fault);
> > +		if (r != RET_PF_CONTINUE)
> > +			return r == RET_PF_FIXED ? RET_PF_CONTINUE : r;
> 
> I apologize if I've given you conflicting feedback in the past.  Now that this
> returns RET_PF_* directly, I definitely think it makes sense to do:
> 
> 	if (kvm_slot_can_be_private(slot) &&
> 	    fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> 		vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
> 		if (fault->is_private)
> 			vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
> 		else
> 			vcpu->run->memory.flags = 0;
> 		vcpu->run->memory.padding = 0;
> 		vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> 		vcpu->run->memory.size = PAGE_SIZE;
> 		return RET_PF_USER;
> 	}
> 
> 	if (fault->is_private)
> 		return kvm_faultin_pfn_private(vcpu, fault);
> 
> That way kvm_faultin_pfn_private() only handles private faults, and this doesn't
> need to play games with RET_PF_FIXED.

Agreed, this looks much simpler.

> 
> 
> > +	}
> > +
> >  	async = false;
> >  	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
> >  					  fault->write, &fault->map_writable,
> > @@ -4241,7 +4292,11 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  		read_unlock(&vcpu->kvm->mmu_lock);
> >  	else
> >  		write_unlock(&vcpu->kvm->mmu_lock);
> > -	kvm_release_pfn_clean(fault->pfn);
> > +
> > +	if (fault->is_private)
> > +		kvm_private_mem_put_pfn(fault->slot, fault->pfn);
> > +	else
> > +		kvm_release_pfn_clean(fault->pfn);
> 
> AFAIK, we never bottomed out on whether or not this is needed[*].  Can you follow
> up with Kirill to get an answer before posting v8?

Sure.

Chao
> 
> [*] https://lore.kernel.org/all/20220620141647.GC2016793@chaop.bj.intel.com
