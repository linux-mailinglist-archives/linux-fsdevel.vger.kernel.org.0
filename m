Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A704FE0BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354143AbiDLMr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353876AbiDLMrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:47:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFCF7EA1C;
        Tue, 12 Apr 2022 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649765456; x=1681301456;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=H3y2PO8iP1I2VKt5VHY/5jS3296P+ova6WPUU37ZDYU=;
  b=LCwSRPoD9b2KFpawNEJKy3JDmx4uDi81yNqhaHN3Gbi39hIcl12KEzr5
   kWTSxy4bspvRwhoTa3qMoS+gY9j9AbP1rdzLipno/mdGEa5xtCH+f3jw7
   4Ej1dsP7Uu5zkkXxHHGJ8qSf5gXHFel2I1yqPfFJdP2race8ZzhrEQubZ
   6S8JwSso2kwQO/UcJleqqRQ5oLVqFgt6jvNzwYpXyekiwNQrgs4BqfSfY
   KcLpmO2vW8cCg9O5dLz3kxpWM5vF/RZW1izgkWuyR+FHrhf/9BZL6/Z0v
   rz7WulDQ6afLkl96B4gqIPq6lze4skEyxvg9aD5Hhf1iTm7PAlvEdMnKg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261798001"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261798001"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 05:10:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="526015878"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2022 05:10:16 -0700
Date:   Tue, 12 Apr 2022 20:10:05 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 09/13] KVM: Handle page fault for private memory
Message-ID: <20220412121005.GC7309@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-10-chao.p.peng@linux.intel.com>
 <YkJbxiL/Az7olWlq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkJbxiL/Az7olWlq@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:07:18AM +0000, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
> > @@ -3890,7 +3893,59 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  				  kvm_vcpu_gfn_to_hva(vcpu, gfn), &arch);
> >  }
> >  
> > -static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault, int *r)
> > +static bool kvm_vcpu_is_private_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
> > +{
> > +	/*
> > +	 * At this time private gfn has not been supported yet. Other patch
> > +	 * that enables it should change this.
> > +	 */
> > +	return false;
> > +}
> > +
> > +static bool kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> > +				    struct kvm_page_fault *fault,
> > +				    bool *is_private_pfn, int *r)
> 
> @is_private_pfn should be a field in @fault, not a separate parameter, and it
> should be a const property set by the original caller.  I would also name it
> "is_private", because if KVM proceeds past this point, it will be a property of
> the fault/access _and_ the pfn
> 
> I say it's a property of the fault because the below kvm_vcpu_is_private_gfn()
> should instead be:
> 
> 	if (fault->is_private)
> 
> The kvm_vcpu_is_private_gfn() check is TDX centric.  For SNP, private vs. shared
> is communicated via error code.  For software-only (I'm being optimistic ;-) ),
> we'd probably need to track private vs. shared internally in KVM, I don't think
> we'd want to force it to be a property of the gfn.

Make sense.

> 
> Then you can also move the fault->is_private waiver into is_page_fault_stale(),
> and drop the local is_private_pfn in direct_page_fault().
> 
> > +{
> > +	int order;
> > +	unsigned int flags = 0;
> > +	struct kvm_memory_slot *slot = fault->slot;
> > +	long pfn = kvm_memfile_get_pfn(slot, fault->gfn, &order);
> 
> If get_lock_pfn() and thus kvm_memfile_get_pfn() returns a pure error code instead
> of multiplexing the pfn, then this can be:
> 
> 	bool is_private_pfn;
> 
> 	is_private_pfn = !!kvm_memfile_get_pfn(slot, fault->gfn, &fault->pfn, &order);
> 
> That self-documents the "pfn < 0" == shared logic.

Yes, agreed.

> 
> > +
> > +	if (kvm_vcpu_is_private_gfn(vcpu, fault->addr >> PAGE_SHIFT)) {
> > +		if (pfn < 0)
> > +			flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
> > +		else {
> > +			fault->pfn = pfn;
> > +			if (slot->flags & KVM_MEM_READONLY)
> > +				fault->map_writable = false;
> > +			else
> > +				fault->map_writable = true;
> > +
> > +			if (order == 0)
> > +				fault->max_level = PG_LEVEL_4K;
> 
> This doesn't correctly handle order > 0, but less than the next page size, in which
> case max_level needs to be PG_LEVEL_4k.  It also doesn't handle the case where
> max_level > PG_LEVEL_2M.
> 
> That said, I think the proper fix is to have the get_lock_pfn() API return the max
> mapping level, not the order.  KVM, and presumably any other secondary MMU that might
> use these APIs, doesn't care about the order of the struct page, KVM cares about the
> max size/level of page it can map into the guest.  And similar to the previous patch,
> "order" is specific to struct page, which we are trying to avoid.

I remembered I suggested return max mapping level instead of order but
Kirill reminded me that PG_LEVEL_* is x86 specific, then changed back
to 'order'. It's just a matter of backing store or KVM to convert
'order' to mapping level.

> 
> > +			*is_private_pfn = true;
> 
> This is where KVM guarantees that is_private_pfn == fault->is_private.
> 
> > +			*r = RET_PF_FIXED;
> > +			return true;
> 
> Ewww.  This is super confusing.  Ditto for the "*r = -1" magic number.  I totally
> understand why you took this approach, it's just hard to follow because it kinda
> follows the kvm_faultin_pfn() semantics, but then inverts true and false in this
> one case.
> 
> I think the least awful option is to forego the helper and open code everything.
> If we ever refactor kvm_faultin_pfn() to be less weird then we can maybe move this
> to a helper.
> 
> Open coding isn't too bad if you reorganize things so that the exit-to-userspace
> path is a dedicated, early check.  IMO, it's a lot easier to read this way, open
> coded or not.

Yes the existing way of handling this is really awful, including the handling for 'r'
that will be finally return to KVM_RUN as part of the uAPI. Let me try your above
suggestion.

> 
> I think this is correct?  "is_private_pfn" and "level" are locals, everything else
> is in @fault.
> 
> 	if (kvm_slot_is_private(slot)) {
> 		is_private_pfn = !!kvm_memfile_get_pfn(slot, fault->gfn,
> 						       &fault->pfn, &level);
> 
> 		if (fault->is_private != is_private_pfn) {
> 			if (is_private_pfn)
> 				kvm_memfile_put_pfn(slot, fault->pfn);
> 
> 			vcpu->run->exit_reason = KVM_EXIT_MEMORY_ERROR;
> 			if (fault->is_private)
> 				vcpu->run->memory.flags = KVM_MEMORY_EXIT_FLAG_PRIVATE;
> 			else
> 				vcpu->run->memory.flags = 0;
> 			vcpu->run->memory.padding = 0;
> 			vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
> 			vcpu->run->memory.size = PAGE_SIZE;
> 			*r = 0;
> 			return true;
> 		}
> 
> 		/*
> 		 * fault->pfn is all set if the fault is for a private pfn, just
> 		 * need to update other metadata.
> 		 */
> 		if (fault->is_private) {
> 			fault->max_level = min(fault->max_level, level);
> 			fault->map_writable = !(slot->flags & KVM_MEM_READONLY);
> 			return false;
> 		}
> 
> 		/* Fault is shared, fallthrough to the standard path. */
> 	}
> 
> 	async = false;
> 
> > @@ -4016,7 +4076,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  	else
> >  		write_lock(&vcpu->kvm->mmu_lock);
> >  
> > -	if (is_page_fault_stale(vcpu, fault, mmu_seq))
> > +	if (!is_private_pfn && is_page_fault_stale(vcpu, fault, mmu_seq))
> 
> As above, I'd prefer this check go in is_page_fault_stale().  It means shadow MMUs
> will suffer a pointless check, but I don't think that's a big issue.  Oooh, unless
> we support software-only, which would play nice with nested and probably even legacy
> shadow paging.  Fun :-)

Sounds good.

> 
> >  		goto out_unlock;
> >  
> >  	r = make_mmu_pages_available(vcpu);
> > @@ -4033,7 +4093,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  		read_unlock(&vcpu->kvm->mmu_lock);
> >  	else
> >  		write_unlock(&vcpu->kvm->mmu_lock);
> > -	kvm_release_pfn_clean(fault->pfn);
> > +
> > +	if (is_private_pfn)
> 
> And this can be
> 
> 	if (fault->is_private)
> 
> Same feedback for paging_tmpl.h.

Agreed.

Thanks,
Chao
