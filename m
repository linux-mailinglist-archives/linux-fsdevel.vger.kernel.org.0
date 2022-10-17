Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FBA60119D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJQOx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 10:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJQOxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3FB68CD1;
        Mon, 17 Oct 2022 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666018398; x=1697554398;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=I4wfniHW10JfPeprn5rTb+kTvRXkxXZTaEZmmRNpMCk=;
  b=P8R4Dh4olIwXLAjxWflWJ5tLmVFc0gNEIKGdSW0s1WdPBjbDbeK4mdnp
   IeBEmYrdybRBOeEBW0e3OfTJhuD/BJm+m4xFTNVdgvUGStjGZ/gPyFGmm
   2fdWUHlHLPk3TAh4PQ7JQ5JOlPwU0VJgXSEsycHLqxDJ2pBw/cLAZb82R
   Nf9QAqzkIamAMl/vebcQUKjpOC8T7zFi/7nXzwOMw1MhqAVrIOGnwJjNS
   1kTD9F0XiNbmIFPrBGB5UwNEUhasB1KvuF3vezv9rPu+A2WqTK14lPp9y
   SPEbJIA0hubiF89W/60ihQzPLn4SMhrZZ3We3+O71Vd73sTL556F2Nrad
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="370008643"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="370008643"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 07:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691384101"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="691384101"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2022 07:53:06 -0700
Date:   Mon, 17 Oct 2022 22:48:35 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
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
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 7/8] KVM: Handle page fault for private memory
Message-ID: <20221017144835.GA3417432@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-8-chao.p.peng@linux.intel.com>
 <Y0mxEFpvS7O96CCD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0mxEFpvS7O96CCD@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 06:57:20PM +0000, Sean Christopherson wrote:
> On Thu, Sep 15, 2022, Chao Peng wrote:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index a0f198cede3d..81ab20003824 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3028,6 +3028,9 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm,
> >  			break;
> >  	}
> >  
> > +	if (kvm_mem_is_private(kvm, gfn))
> 
> Rather than reload the Xarray info, which is unnecessary overhead, pass in
> @is_private.  The caller must hold mmu_lock, i.e. invalidations from
> private<->shared conversions will be stalled and will zap the new SPTE if the
> state is changed.

Make sense. TDX/SEV should be easy to query that.

Chao
> 
> E.g.
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index d68944f07b4b..44eea47697d8 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3072,8 +3072,8 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>          * Enforce the iTLB multihit workaround after capturing the requested
>          * level, which will be used to do precise, accurate accounting.
>          */
> -       fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot,
> -                                                    fault->gfn, fault->max_level);
> +       fault->req_level = kvm_mmu_max_mapping_level(vcpu->kvm, slot, fault->gfn,
> +                                                    fault->max_level, fault->is_private);
>         if (fault->req_level == PG_LEVEL_4K || fault->huge_page_disallowed)
>                 return;
>  
> @@ -6460,7 +6460,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
>                  */
>                 if (sp->role.direct &&
>                     sp->role.level < kvm_mmu_max_mapping_level(kvm, slot, sp->gfn,
> -                                                              PG_LEVEL_NUM)) {
> +                                                              PG_LEVEL_NUM, false)) {
>                         kvm_zap_one_rmap_spte(kvm, rmap_head, sptep);
>  
>                         if (kvm_available_flush_tlb_with_range())
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 7670c13ce251..9acdf72537ce 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -315,6 +315,12 @@ static inline bool is_dirty_spte(u64 spte)
>         return dirty_mask ? spte & dirty_mask : spte & PT_WRITABLE_MASK;
>  }
>  
> +static inline bool is_private_spte(u64 spte)
> +{
> +       /* FIXME: Query C-bit/S-bit for SEV/TDX. */
> +       return false;
> +}
> +
>  static inline u64 get_rsvd_bits(struct rsvd_bits_validate *rsvd_check, u64 pte,
>                                 int level)
>  {
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 672f0432d777..69ba00157e90 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1767,8 +1767,9 @@ static void zap_collapsible_spte_range(struct kvm *kvm,
>                 if (iter.gfn < start || iter.gfn >= end)
>                         continue;
>  
> -               max_mapping_level = kvm_mmu_max_mapping_level(kvm, slot,
> -                                                             iter.gfn, PG_LEVEL_NUM);
> +               max_mapping_level = kvm_mmu_max_mapping_level(kvm, slot, iter.gfn,
> +                                                             PG_LEVEL_NUM,
> +                                                             is_private_spte(iter.old_spte));
>                 if (max_mapping_level < iter.level)
>                         continue;
>  
