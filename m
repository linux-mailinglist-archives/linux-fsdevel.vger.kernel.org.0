Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD84F97A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiDHOJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiDHOJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:09:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F9B2359C8;
        Fri,  8 Apr 2022 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649426855; x=1680962855;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=eDkQXvXOF7yKn1iuVU45nfja4Im2dxSC1xviYqR0nWQ=;
  b=ICiKASg3rkBRceREPDm4MiYaX73yeThwuA5l6JPgLhYBYwq++0vArNfv
   RsvxmS5ZIIs2AL1GUBbCIR9F+f90JSMvY022SOJVVUb3SfMWB1dUF3T6i
   REd+RSKyve//qaPIgD3vLX7NILGUScXrfFiP5olfODN24CHJtyhQ9bEGW
   uO3ZQbHfslw3tA1dI2s2afgvKGEmF2OjQ6HywGOV9BSrvP4DV2YsLYRpl
   T1yn1Z5KPot0HaRey2YvfH1jLtVc2zZIluyL1hh6LOEEdL//YzwePvL+b
   64u09CWZKdHse32di7wOF/kWnceH2Fepjrb9pvETbsZR/w4MYidqL6jN8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260436696"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="260436696"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 07:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="571498592"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 08 Apr 2022 07:07:18 -0700
Date:   Fri, 8 Apr 2022 22:07:07 +0800
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
Subject: Re: [PATCH v5 08/13] KVM: Use memfile_pfn_ops to obtain pfn for
 private pages
Message-ID: <20220408140707.GG57095@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-9-chao.p.peng@linux.intel.com>
 <YkJLFu98hZOvTSrL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkJLFu98hZOvTSrL@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:56:06PM +0000, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
> > @@ -2217,4 +2220,34 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
> >  /* Max number of entries allowed for each kvm dirty ring */
> >  #define  KVM_DIRTY_RING_MAX_ENTRIES  65536
> >  
> > +#ifdef CONFIG_MEMFILE_NOTIFIER
> > +static inline long kvm_memfile_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn,
> > +				       int *order)
> > +{
> > +	pgoff_t index = gfn - slot->base_gfn +
> > +			(slot->private_offset >> PAGE_SHIFT);
> 
> This is broken for 32-bit kernels, where gfn_t is a 64-bit value but pgoff_t is a
> 32-bit value.  There's no reason to support this for 32-bit kernels, so...
> 
> The easiest fix, and likely most maintainable for other code too, would be to
> add a dedicated CONFIG for private memory, and then have KVM check that for all
> the memfile stuff.  x86 can then select it only for 64-bit kernels, and in turn
> select MEMFILE_NOTIFIER iff private memory is supported.

Looks good.

> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index ca7b2a6a452a..ee9c8c155300 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -48,7 +48,9 @@ config KVM
>         select SRCU
>         select INTERVAL_TREE
>         select HAVE_KVM_PM_NOTIFIER if PM
> -       select MEMFILE_NOTIFIER
> +       select HAVE_KVM_PRIVATE_MEM if X86_64
> +       select MEMFILE_NOTIFIER if HAVE_KVM_PRIVATE_MEM
> +
>         help
>           Support hosting fully virtualized guest machines using hardware
>           virtualization extensions.  You will need a fairly recent
> 
> And in addition to replacing checks on CONFIG_MEMFILE_NOTIFIER, the probing of
> whether or not KVM_MEM_PRIVATE is allowed can be:
> 
> @@ -1499,23 +1499,19 @@ static void kvm_replace_memslot(struct kvm *kvm,
>         }
>  }
> 
> -bool __weak kvm_arch_private_memory_supported(struct kvm *kvm)
> -{
> -       return false;
> -}
> -
>  static int check_memory_region_flags(struct kvm *kvm,
>                                 const struct kvm_userspace_memory_region *mem)
>  {
>         u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
> 
> -       if (kvm_arch_private_memory_supported(kvm))
> -               valid_flags |= KVM_MEM_PRIVATE;
> -
>  #ifdef __KVM_HAVE_READONLY_MEM
>         valid_flags |= KVM_MEM_READONLY;
>  #endif
> 
> +#ifdef CONFIG_KVM_HAVE_PRIVATE_MEM
> +       valid_flags |= KVM_MEM_PRIVATE;
> +#endif
> +
>         if (mem->flags & ~valid_flags)
>                 return -EINVAL;
> 
> > +
> > +	return slot->pfn_ops->get_lock_pfn(file_inode(slot->private_file),
> > +					   index, order);
> 
> In a similar vein, get_locK_pfn() shouldn't return a "long".  KVM likely won't use
> these APIs on 32-bit kernels, but that may not hold true for other subsystems, and
> this code is confusing and technically wrong.  The pfns for struct page squeeze
> into an unsigned long because PAE support is capped at 64gb, but casting to a
> signed long could result in a pfn with bit 31 set being misinterpreted as an error.
> 
> Even returning an "unsigned long" for the pfn is wrong.  It "works" for the shmem
> code because shmem deals only with struct page, but it's technically wrong, especially
> since one of the selling points of this approach is that it can work without struct
> page.

Hmmm, that's correct.

> 
> OUT params suck, but I don't see a better option than having the return value be
> 0/-errno, with "pfn_t *pfn" for the resolved pfn.
> 
> > +}
> > +
> > +static inline void kvm_memfile_put_pfn(struct kvm_memory_slot *slot,
> > +				       kvm_pfn_t pfn)
> > +{
> > +	slot->pfn_ops->put_unlock_pfn(pfn);
> > +}
> > +
> > +#else
> > +static inline long kvm_memfile_get_pfn(struct kvm_memory_slot *slot, gfn_t gfn,
> > +				       int *order)
> > +{
> 
> This should be a WARN_ON() as its usage should be guarded by a KVM_PRIVATE_MEM
> check, and private memslots should be disallowed in this case.
> 
> Alternatively, it might be a good idea to #ifdef these out entirely and not provide
> stubs.  That'd likely require a stub or two in arch code, but overall it might be
> less painful in the long run, e.g. would force us to more carefully consider the
> touch points for private memory.  Definitely not a requirement, just an idea.

Make sense, let me try.

Thanks,
Chao
