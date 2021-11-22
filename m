Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977FB458B37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhKVJWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 04:22:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:19907 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhKVJWw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:22:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="214781457"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="214781457"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 01:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="496790995"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2021 01:19:09 -0800
Date:   Mon, 22 Nov 2021 17:18:23 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Yao Yuan <yaoyuan0329os@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [RFC v2 PATCH 07/13] KVM: Handle page fault for fd based memslot
Message-ID: <20211122091823.GB28749@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-8-chao.p.peng@linux.intel.com>
 <20211120015529.w23fg2df3fqs4ov5@sapienza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120015529.w23fg2df3fqs4ov5@sapienza>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 20, 2021 at 09:55:29AM +0800, Yao Yuan wrote:
> On Fri, Nov 19, 2021 at 09:47:33PM +0800, Chao Peng wrote:
> > Current code assume the private memory is persistent and KVM can check
> > with backing store to see if private memory exists at the same address
> > by calling get_pfn(alloc=false).
> >
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 75 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 73 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 40377901598b..cd5d1f923694 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3277,6 +3277,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
> >  	if (max_level == PG_LEVEL_4K)
> >  		return PG_LEVEL_4K;
> >
> > +	if (memslot_is_memfd(slot))
> > +		return max_level;
> > +
> >  	host_level = host_pfn_mapping_level(kvm, gfn, pfn, slot);
> >  	return min(host_level, max_level);
> >  }
> > @@ -4555,6 +4558,65 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
> >  }
> >
> > +static bool kvm_faultin_pfn_memfd(struct kvm_vcpu *vcpu,
> > +				  struct kvm_page_fault *fault, int *r)
> > +{	int order;
> > +	kvm_pfn_t pfn;
> > +	struct kvm_memory_slot *slot = fault->slot;
> > +	bool priv_gfn = kvm_vcpu_is_private_gfn(vcpu, fault->addr >> PAGE_SHIFT);
> > +	bool priv_slot_exists = memslot_has_private(slot);
> > +	bool priv_gfn_exists = false;
> > +	int mem_convert_type;
> > +
> > +	if (priv_gfn && !priv_slot_exists) {
> > +		*r = RET_PF_INVALID;
> > +		return true;
> > +	}
> > +
> > +	if (priv_slot_exists) {
> > +		pfn = slot->memfd_ops->get_pfn(slot, slot->priv_file,
> > +					       fault->gfn, false, &order);
> > +		if (pfn >= 0)
> > +			priv_gfn_exists = true;
> 
> Need "fault->pfn = pfn" here if actual pfn is returned in
> get_pfn(alloc=false) case for private page case.
> 
> > +	}
> > +
> > +	if (priv_gfn && !priv_gfn_exists) {
> > +		mem_convert_type = KVM_EXIT_MEM_MAP_PRIVATE;
> > +		goto out_convert;
> > +	}
> > +
> > +	if (!priv_gfn && priv_gfn_exists) {
> > +		slot->memfd_ops->put_pfn(pfn);
> > +		mem_convert_type = KVM_EXIT_MEM_MAP_SHARED;
> > +		goto out_convert;
> > +	}
> > +
> > +	if (!priv_gfn) {
> > +		pfn = slot->memfd_ops->get_pfn(slot, slot->file,
> > +					       fault->gfn, true, &order);
> 
> Need "fault->pfn = pfn" here, because he pfn for
> share page is getted here only.
> 
> > +		if (fault->pfn < 0) {
> > +			*r = RET_PF_INVALID;
> > +			return true;
> > +		}
> > +	}

Right, I actually have "fault->pfn = pfn" here but accidentally deleted
in a code factoring.

Chao
> > +
> > +	if (slot->flags & KVM_MEM_READONLY)
> > +		fault->map_writable = false;
> > +	if (order == 0)
> > +		fault->max_level = PG_LEVEL_4K;
> > +
> > +	return false;
> > +
> > +out_convert:
> > +	vcpu->run->exit_reason = KVM_EXIT_MEMORY_ERROR;
> > +	vcpu->run->mem.type = mem_convert_type;
> > +	vcpu->run->mem.u.map.gpa = fault->gfn << PAGE_SHIFT;
> > +	vcpu->run->mem.u.map.size = PAGE_SIZE;
> > +	fault->pfn = -1;
> > +	*r = -1;
> > +	return true;
> > +}
> > +
> >  static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault, int *r)
> >  {
> >  	struct kvm_memory_slot *slot = fault->slot;
> > @@ -4596,6 +4658,9 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> >  		}
> >  	}
> >
> > +	if (memslot_is_memfd(slot))
> > +		return kvm_faultin_pfn_memfd(vcpu, fault, r);
> > +
> >  	async = false;
> >  	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
> >  					  fault->write, &fault->map_writable,
> > @@ -4660,7 +4725,8 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  	else
> >  		write_lock(&vcpu->kvm->mmu_lock);
> >
> > -	if (fault->slot && mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, fault->hva))
> > +	if (fault->slot && !memslot_is_memfd(fault->slot) &&
> > +			mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, fault->hva))
> >  		goto out_unlock;
> >  	r = make_mmu_pages_available(vcpu);
> >  	if (r)
> > @@ -4676,7 +4742,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  		read_unlock(&vcpu->kvm->mmu_lock);
> >  	else
> >  		write_unlock(&vcpu->kvm->mmu_lock);
> > -	kvm_release_pfn_clean(fault->pfn);
> > +
> > +	if (memslot_is_memfd(fault->slot))
> > +		fault->slot->memfd_ops->put_pfn(fault->pfn);
> > +	else
> > +		kvm_release_pfn_clean(fault->pfn);
> > +
> >  	return r;
> >  }
> >
> > --
> > 2.17.1
> >
