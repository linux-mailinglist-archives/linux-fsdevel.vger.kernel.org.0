Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06267551F7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbiFTO64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiFTO5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:57:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF70117AA9;
        Mon, 20 Jun 2022 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655734832; x=1687270832;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=j5dmRBX11KpQ0doZYX6GRPhSnkODpaL7Hahti3PPX3U=;
  b=KPAoYHU/m5CdBpYQZk5adX3KdDSMzWSrHRplWbhQRpS+VED981e9orUF
   pYzaQkQInSxXRmqQW9xrvlcjfcYBce5sP1YyVZ/OnHUKN9RAyht8xSdIX
   xyo3iV8qsg/ZuCNvJfPVTLr642cJ3v1qYqYiOpoZ/IS27PQ2XLkGLQsHr
   J3T9Y5hASV/BwW2RocCaSAOCABADnGl3bJ48UOWggD1lCP916Ue0mSCCw
   rinKuNTj/gEzhg5JxQts4mefQLTCEx+jMsljqMA8Cfl0bSkjSgSBIPw+A
   wJ/wfOKXfyNz+J6l+OXOp/3bZzNtNpoFa2hBKbfCdMBeS3S4jMgfpKCGG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268626429"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268626429"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 07:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584914017"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2022 07:20:09 -0700
Date:   Mon, 20 Jun 2022 22:16:47 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        kirill.shutemov@linux.intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 6/8] KVM: Handle page fault for private memory
Message-ID: <20220620141647.GC2016793@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-7-chao.p.peng@linux.intel.com>
 <YqzyjZnflCMPo8b/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqzyjZnflCMPo8b/@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:30:53PM +0000, Sean Christopherson wrote:
> On Thu, May 19, 2022, Chao Peng wrote:
> > @@ -4028,8 +4081,11 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
> >  	if (!sp && kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu))
> >  		return true;
> >  
> > -	return fault->slot &&
> > -	       mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
> > +	if (fault->is_private)
> > +		return mmu_notifier_retry(vcpu->kvm, mmu_seq);
> 
> Hmm, this is somewhat undesirable, because faulting in private pfns will be blocked
> by unrelated mmu_notifier updates.  The issue is mitigated to some degree by bumping
> the sequence count if and only if overlap with a memslot is detected, e.g. mapping
> changes that affects only userspace won't block the guest.
> 
> It probably won't be an issue, but at the same time it's easy to solve, and I don't
> like piggybacking mmu_notifier_seq as private mappings shouldn't be subject to the
> mmu_notifier.
> 
> That would also fix a theoretical bug in this patch where mmu_notifier_retry()
> wouldn't be defined if CONFIG_MEMFILE_NOTIFIER=y && CONFIG_MMU_NOTIFIER=n.a

Agreed, Thanks.

> 
> ---
>  arch/x86/kvm/mmu/mmu.c   | 11 ++++++-----
>  include/linux/kvm_host.h | 16 +++++++++++-----
>  virt/kvm/kvm_main.c      |  2 +-
>  3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 0b455c16ec64..a4cbd29433e7 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4100,10 +4100,10 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
>  		return true;
> 
>  	if (fault->is_private)
> -		return mmu_notifier_retry(vcpu->kvm, mmu_seq);
> -	else
> -		return fault->slot &&
> -			mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
> +		return memfile_notifier_retry(vcpu->kvm, mmu_seq);
> +
> +	return fault->slot &&
> +	       mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
>  }
> 
>  static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> @@ -4127,7 +4127,8 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  	if (r)
>  		return r;
> 
> -	mmu_seq = vcpu->kvm->mmu_notifier_seq;
> +	mmu_seq = fault->is_private ? vcpu->kvm->memfile_notifier_seq :
> +				      vcpu->kvm->mmu_notifier_seq;
>  	smp_rmb();
> 
>  	r = kvm_faultin_pfn(vcpu, fault);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 92afa5bddbc5..31f704c83099 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -773,16 +773,15 @@ struct kvm {
>  	struct hlist_head irq_ack_notifier_list;
>  #endif
> 
> -#if (defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)) ||\
> -	defined(CONFIG_MEMFILE_NOTIFIER)
> +#if (defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER))
>  	unsigned long mmu_notifier_seq;
> -#endif
> -
> -#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>  	struct mmu_notifier mmu_notifier;
>  	long mmu_notifier_count;
>  	unsigned long mmu_notifier_range_start;
>  	unsigned long mmu_notifier_range_end;
> +#endif
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +	unsigned long memfile_notifier_seq;
>  #endif
>  	struct list_head devices;
>  	u64 manual_dirty_log_protect;
> @@ -1964,6 +1963,13 @@ static inline int mmu_notifier_retry_hva(struct kvm *kvm,
>  }
>  #endif
> 
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +static inline bool memfile_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
> +{
> +	return kvm->memfile_notifier_seq != mmu_seq;
> +}
> +#endif
> +
>  #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
> 
>  #define KVM_MAX_IRQ_ROUTES 4096 /* might need extension/rework in the future */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2b416d3bd60e..e6d34c964d51 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -898,7 +898,7 @@ static void kvm_private_mem_notifier_handler(struct memfile_notifier *notifier,
>  	KVM_MMU_LOCK(kvm);
>  	if (kvm_unmap_gfn_range(kvm, &gfn_range))
>  		kvm_flush_remote_tlbs(kvm);
> -	kvm->mmu_notifier_seq++;
> +	kvm->memfile_notifier_seq++;
>  	KVM_MMU_UNLOCK(kvm);
>  	srcu_read_unlock(&kvm->srcu, idx);
>  }
> 
> base-commit: 333ef501c7f6c6d4ef2b7678905cad0f8ef3e271
> --
> 
> > +	else
> > +		return fault->slot &&
> > +			mmu_notifier_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
> >  }
> >  
> >  static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> > @@ -4088,7 +4144,12 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  		read_unlock(&vcpu->kvm->mmu_lock);
> >  	else
> >  		write_unlock(&vcpu->kvm->mmu_lock);
> > -	kvm_release_pfn_clean(fault->pfn);
> > +
> > +	if (fault->is_private)
> > +		kvm_private_mem_put_pfn(fault->slot, fault->pfn);
> 
> Why does the shmem path lock the page, and then unlock it here?

Initially this is to prevent race between SLPT population and
truncate/punch on the fd. Without this, a gfn may become stale before
the page is populated in SLPT. However, with memfile_notifier_retry
mechanism, this sounds not needed.

> 
> Same question for why this path marks it dirty?  The guest has the page mapped
> so the dirty flag is immediately stale.

I believe so.

> 
> In other words, why does KVM need to do something different for private pfns?

These two are inherited from Kirill's previous code. See if he has any
comment.

> 
> > +	else
> > +		kvm_release_pfn_clean(fault->pfn);
> > +
> >  	return r;
> >  }
> >  
> 
> ...
> 
> > diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> > index 7f8f1c8dbed2..1d857919a947 100644
> > --- a/arch/x86/kvm/mmu/paging_tmpl.h
> > +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> > @@ -878,7 +878,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  
> >  out_unlock:
> >  	write_unlock(&vcpu->kvm->mmu_lock);
> > -	kvm_release_pfn_clean(fault->pfn);
> > +	if (fault->is_private)
> 
> Indirect MMUs can't support private faults, i.e. this is unnecessary.

Okay.

> 
> > +		kvm_private_mem_put_pfn(fault->slot, fault->pfn);
> > +	else
> > +		kvm_release_pfn_clean(fault->pfn);
> >  	return r;
> >  }
> >  
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 3fd168972ecd..b0a7910505ed 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2241,4 +2241,26 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
> >  /* Max number of entries allowed for each kvm dirty ring */
> >  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
> >  
> > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> > +static inline int kvm_private_mem_get_pfn(struct kvm_memory_slot *slot,
> > +					  gfn_t gfn, kvm_pfn_t *pfn, int *order)
> > +{
> > +	int ret;
> > +	pfn_t pfnt;
> > +	pgoff_t index = gfn - slot->base_gfn +
> > +			(slot->private_offset >> PAGE_SHIFT);
> > +
> > +	ret = slot->notifier.bs->get_lock_pfn(slot->private_file, index, &pfnt,
> > +						order);
> > +	*pfn = pfn_t_to_pfn(pfnt);
> > +	return ret;
> > +}
> > +
> > +static inline void kvm_private_mem_put_pfn(struct kvm_memory_slot *slot,
> > +					   kvm_pfn_t pfn)
> > +{
> > +	slot->notifier.bs->put_unlock_pfn(pfn_to_pfn_t(pfn));
> > +}
> > +#endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
> > +
> >  #endif
> > -- 
> > 2.25.1
> > 
