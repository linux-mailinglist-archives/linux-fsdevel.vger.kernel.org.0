Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92B62DCCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 14:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiKQNam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 08:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiKQNab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:30:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96372997;
        Thu, 17 Nov 2022 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668691826; x=1700227826;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=kkui0TYDb/IbaSu7o0K1fhPB2oH/R5viDFHkl5cBAL8=;
  b=JOGkeTCPVQwfbgFOzqLH/KfcdO9XlGrgmN6tnFCA2GirUX4Yq1VWM4ie
   9GL011Gs4eBJ28MSVHe2t1n5TQLVdavt0CQr3zihbE+PZbudydg085No3
   1D10aaqGUL6pcr+XBz/kD7hYztPVrBt3gZCfJwVAH7doZWgzrqWuxJErA
   x+rcPqCAlGRFBPvFFexeQHTnycMY8ixjR58iDVANPQGFL+Ttwu1l5IV6w
   UktvANPLWyoGBhpgsDQw5kVKfAZIf9QI72YL28BXEO2IeMEFtrtM8xFmr
   J/l8GcAjZQPJYJirFu0liOowm7X5oxDex3s1qJ1/GMwycYRaTsmXHoA53
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="310479173"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="310479173"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 05:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="703332498"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="703332498"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2022 05:30:16 -0800
Date:   Thu, 17 Nov 2022 21:25:51 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ackerley Tng <ackerleytng@google.com>, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org,
        bfields@fieldses.org, bp@alien8.de, corbet@lwn.net,
        dave.hansen@intel.com, david@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, hpa@zytor.com, hughd@google.com,
        jlayton@kernel.org, jmattson@google.com, joro@8bytes.org,
        jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mail@maciej.szmigiero.name,
        mhocko@suse.com, michael.roth@amd.com, mingo@redhat.com,
        pbonzini@redhat.com, qemu-devel@nongnu.org, qperret@google.com,
        rppt@kernel.org, shuah@kernel.org, songmuchun@bytedance.com,
        steven.price@arm.com, tabba@google.com, tglx@linutronix.de,
        vannapurve@google.com, vbabka@suse.cz, vkuznets@redhat.com,
        wanpengli@tencent.com, wei.w.wang@intel.com, x86@kernel.org,
        yu.c.zhang@linux.intel.com
Subject: Re: [PATCH v9 7/8] KVM: Handle page fault for private memory
Message-ID: <20221117132551.GB422408@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-8-chao.p.peng@linux.intel.com>
 <20221116205025.1510291-1-ackerleytng@google.com>
 <Y3Vgc5KrNRA8r6vh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Vgc5KrNRA8r6vh@google.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:13:07PM +0000, Sean Christopherson wrote:
> On Wed, Nov 16, 2022, Ackerley Tng wrote:
> > >@@ -4173,6 +4203,22 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> > > 			return RET_PF_EMULATE;
> > > 	}
> > >
> > >+	if (kvm_slot_can_be_private(slot) &&
> > >+	    fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> > >+		vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
> > >+		if (fault->is_private)
> > >+			vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
> > >+		else
> > >+			vcpu->run->memory.flags = 0;
> > >+		vcpu->run->memory.padding = 0;
> > >+		vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> > >+		vcpu->run->memory.size = PAGE_SIZE;
> > >+		return RET_PF_USER;
> > >+	}
> > >+
> > >+	if (fault->is_private)
> > >+		return kvm_faultin_pfn_private(fault);
> > >+
> > 
> > Since each memslot may also not be backed by restricted memory, we
> > should also check if the memslot has been set up for private memory
> > with
> > 
> > 	if (fault->is_private && kvm_slot_can_be_private(slot))
> > 		return kvm_faultin_pfn_private(fault);
> > 
> > Without this check, restrictedmem_get_page will get called with NULL
> > in slot->restricted_file, which causes a NULL pointer dereference.
> 
> Hmm, silently skipping the faultin would result in KVM faulting in the shared
> portion of the memslot, and I believe would end up mapping that pfn as private,
> i.e. would map a non-UPM PFN as a private mapping.  For TDX and SNP, that would
> be double ungood as it would let the host access memory that is mapped private,
> i.e. lead to #MC or #PF(RMP) in the host.

That's correct.

> 
> I believe the correct solution is to drop the "can be private" check from the
> above check, and instead handle that in kvm_faultin_pfn_private().  That would fix
> another bug, e.g. if the fault is shared, the slot can't be private, but for
> whatever reason userspace marked the gfn as private.  Even though KVM might be
> able service the fault, the correct thing to do in that case is to exit to userspace.

It makes sense to me.

Chao
> 
> E.g.
> 
> ---
>  arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 10017a9f26ee..e2ac8873938e 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4158,11 +4158,29 @@ static inline u8 order_to_level(int order)
>  	return PG_LEVEL_4K;
>  }
>  
> -static int kvm_faultin_pfn_private(struct kvm_page_fault *fault)
> +static int kvm_do_memory_fault_exit(struct kvm_vcpu *vcpu,
> +					struct kvm_page_fault *fault)
> +{
> +	vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
> +	if (fault->is_private)
> +		vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
> +	else
> +		vcpu->run->memory.flags = 0;
> +	vcpu->run->memory.padding = 0;
> +	vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> +	vcpu->run->memory.size = PAGE_SIZE;
> +	return RET_PF_USER;
> +}
> +
> +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> +				   struct kvm_page_fault *fault)
>  {
>  	int order;
>  	struct kvm_memory_slot *slot = fault->slot;
>  
> +	if (kvm_slot_can_be_private(slot))
> +		return kvm_do_memory_fault_exit(vcpu, fault);
> +
>  	if (kvm_restricted_mem_get_pfn(slot, fault->gfn, &fault->pfn, &order))
>  		return RET_PF_RETRY;
>  
> @@ -4203,21 +4221,11 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  			return RET_PF_EMULATE;
>  	}
>  
> -	if (kvm_slot_can_be_private(slot) &&
> -	    fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
> -		vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
> -		if (fault->is_private)
> -			vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
> -		else
> -			vcpu->run->memory.flags = 0;
> -		vcpu->run->memory.padding = 0;
> -		vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> -		vcpu->run->memory.size = PAGE_SIZE;
> -		return RET_PF_USER;
> -	}
> +	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn))
> +		return kvm_do_memory_fault_exit(vcpu, fault);
>  
>  	if (fault->is_private)
> -		return kvm_faultin_pfn_private(fault);
> +		return kvm_faultin_pfn_private(vcpu, fault);
>  
>  	async = false;
>  	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
> 
> base-commit: 969d761bb7b8654605937f31ae76123dcb7f15a3
> -- 
