Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1B5595A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiFXIrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiFXIrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:47:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D94F1EF;
        Fri, 24 Jun 2022 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656060431; x=1687596431;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Jc8yORiINhpFzMTo8QL55TU28YhiMcNQ45ukyK/l2T4=;
  b=J+itO333pEe0lD7h4UCLylQhKjz/cC3Brz7o4DZu/mugC8zlX8EbPHjn
   ESycCCZwvltZvaqp5pqbDoM1z3qdOb8z35PGhrqUOOglEYDs0yosBmUS9
   /V6eJIZGKveyH46orbbj5xCUPs766GPOvIWUp06GDAGW/NikMdaN/VOEx
   +KC7TAO9+bvvHUNtiZv3XR+PuMGBoIGnsDnFk2YJFWhMuDu3feYhk6nAF
   3iTWySQ6hzxNjncDHn2vU/7MGdVxRPRattnmk4VagUgTrTlUx0iWsr2U5
   AWbQYQ1VDo50CTR5iuJcDTDiJiX09DoXOGCZ+trvy5fqXiUMdEUIGqYT1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261382642"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="261382642"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 01:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="586508201"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2022 01:47:01 -0700
Date:   Fri, 24 Jun 2022 16:43:41 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
        Quentin Perret <qperret@google.com>, mhocko@suse.com
Subject: Re: [PATCH v6 7/8] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <20220624084341.GA2178308@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-8-chao.p.peng@linux.intel.com>
 <20220623220751.emt3iqq77faxfzzy@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623220751.emt3iqq77faxfzzy@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 05:07:51PM -0500, Michael Roth wrote:
...
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index db9d39a2d3a6..f93ac7cdfb53 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -843,6 +843,73 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
> >  
> >  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
> >  
> > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> > +static void kvm_private_mem_notifier_handler(struct memfile_notifier *notifier,
> > +					     pgoff_t start, pgoff_t end)
> > +{
> > +	int idx;
> > +	struct kvm_memory_slot *slot = container_of(notifier,
> > +						    struct kvm_memory_slot,
> > +						    notifier);
> > +	struct kvm_gfn_range gfn_range = {
> > +		.slot		= slot,
> > +		.start		= start - (slot->private_offset >> PAGE_SHIFT),
> > +		.end		= end - (slot->private_offset >> PAGE_SHIFT),
> 
> This code assumes that 'end' is greater than slot->private_offset, but
> even if slot->private_offset is non-zero, nothing stops userspace from
> allocating pages in the range of 0 through slot->private_offset, which
> will still end up triggering this notifier. In that case gfn_range.end
> will end up going negative, and the below code will limit that to
> slot->npages and do a populate/invalidate for the entire range.
> 
> Not sure if this covers all the cases, but this fixes the issue for me:

Right, already noticed this issue, will fix in next version. Thanks.

> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 903ffdb5f01c..4c744d8f7527 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -872,6 +872,19 @@ static void kvm_private_mem_notifier_handler(struct memfile_notifier *notifier,
>                 .may_block      = true,
>         };
> 
>         struct kvm *kvm = slot->kvm;
> +
> +       if (slot->private_offset > end)
> +               return;
> +
> 
