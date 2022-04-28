Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE435133EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbiD1Mo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 08:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346554AbiD1Mot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:44:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F710FC5;
        Thu, 28 Apr 2022 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651149690; x=1682685690;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=jDaoso8XSbsD6Q5i89/pk/Xi3K1DdLaMWFukTg8hKeQ=;
  b=mTcux2E7ZLul7MpCZLIMfoDriwNJqnMz08/1yY6N7lUQOdpSzQlRi2CR
   XjwiKL17tL2EoGizi8SGPBxtO5mwy0vXEILR3KOD3OmuKa5T60/aArtms
   uoKLMaoga72Lyl3+fDW2KsCAjYd7U4rmVIIEHhzAoHIPema68eVdxNhWf
   +EGhhHkh36orMeUZUh7VvGllZ7CcIkvOj2hY2N+zN10NIGL9Shb2TMz5C
   ejMydCXr/rM8xB/dmkTC2CprTYklu+G+84dySdNZtXcEj09+ItL2k4VJJ
   bSSXlAcsEIlKlDltX+qXwtzF5b0WrCyygI6s5wc1q0gCQztlSeeOQk0KC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="352710663"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="352710663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 05:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="706039981"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2022 05:41:23 -0700
Date:   Thu, 28 Apr 2022 20:37:51 +0800
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
Message-ID: <20220428123751.GB10508@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-9-chao.p.peng@linux.intel.com>
 <YkJLFu98hZOvTSrL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkJLFu98hZOvTSrL@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

One thing to mention is CONFIG_KVM_HAVE_PRIVATE_MEM is build-time thing.
Do you think we should or not do that for runtime? E.g. expose by vm_type
so only when TDX is enabled KVM_MEM_PRIVATE is exposed.

Chao
