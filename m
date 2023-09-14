Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCD79F8A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 05:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjINDHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 23:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjINDH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:07:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7351BD3;
        Wed, 13 Sep 2023 20:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694660844; x=1726196844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hQLGmdNELjYMZnPnnmaVF9DnSi0UkgWqzZbEZVq1o/k=;
  b=FI9x9MO5qnIqKzGBysp95vNBROi36Q7/V4jPiHVcgspt8vmNYz8klgfq
   3CZCTuGPniIWfha733s4sET13N09B2ekEYh+sY4awVSxC94jcck6ZUU0o
   S9d4kORNFCh6bcMBDei7xLcde4JADeQgnnUsS1e54AGIKaa5vuTDHEt2L
   3fH2BsYqqbttb3R7bJSv8KXbXXfYf/tQJhhzyhvMCrYlRxmskLtX0y4qo
   H0sIU19QQE5d6TU2NQQZ6aZzan5ZAO9tvN5SuMqZDk5oEKjKMEXbyuE5u
   bfYod9APQN2sBs4JcveKa0dTedprBke5YUFwLSIwO4LJ+YFABiOKtdTuL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="382644882"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="382644882"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 20:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747565104"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="747565104"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.8.84]) ([10.238.8.84])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 20:07:14 -0700
Message-ID: <54d3e6bf-d374-caa5-0920-bb2fe3b7595c@linux.intel.com>
Date:   Thu, 14 Sep 2023 11:07:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v12 02/33] KVM: Use gfn instead of hva for
 mmu_notifier_retry
To:     Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230914015531.1419405-1-seanjc@google.com>
 <20230914015531.1419405-3-seanjc@google.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20230914015531.1419405-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/14/2023 9:55 AM, Sean Christopherson wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
>
> Currently in mmu_notifier invalidate path, hva range is recorded and
> then checked against by mmu_notifier_retry_hva() in the page fault
> handling path. However, for the to be introduced private memory, a page
> fault may not have a hva associated, checking gfn(gpa) makes more sense.
>
> For existing hva based shared memory, gfn is expected to also work. The
> only downside is when aliasing multiple gfns to a single hva, the
> current algorithm of checking multiple ranges could result in a much
> larger range being rejected. Such aliasing should be uncommon, so the
> impact is expected small.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> [sean: convert vmx_set_apic_access_page_addr() to gfn-based API]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/mmu.c   | 10 ++++++----
>   arch/x86/kvm/vmx/vmx.c   | 11 +++++------
>   include/linux/kvm_host.h | 33 +++++++++++++++++++++------------
>   virt/kvm/kvm_main.c      | 40 +++++++++++++++++++++++++++++++---------
>   4 files changed, 63 insertions(+), 31 deletions(-)
>
[...]
>   
> -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> -			      unsigned long end)
> +void kvm_mmu_invalidate_begin(struct kvm *kvm)
>   {
> +	lockdep_assert_held_write(&kvm->mmu_lock);
>   	/*
>   	 * The count increase must become visible at unlock time as no
>   	 * spte can be established without taking the mmu_lock and
>   	 * count is also read inside the mmu_lock critical section.
>   	 */
>   	kvm->mmu_invalidate_in_progress++;
> +
> +	if (likely(kvm->mmu_invalidate_in_progress == 1))
> +		kvm->mmu_invalidate_range_start = INVALID_GPA;
> +}
> +
> +void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
> +{
> +	lockdep_assert_held_write(&kvm->mmu_lock);
> +
> +	WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
> +
>   	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
>   		kvm->mmu_invalidate_range_start = start;
>   		kvm->mmu_invalidate_range_end = end;
> @@ -771,6 +781,12 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
>   	}
>   }
>   
> +static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> +{
> +	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
> +	return kvm_unmap_gfn_range(kvm, range);
> +}
> +
>   static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   					const struct mmu_notifier_range *range)
>   {
> @@ -778,7 +794,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   	const struct kvm_mmu_notifier_range hva_range = {
>   		.start		= range->start,
>   		.end		= range->end,
> -		.handler	= kvm_unmap_gfn_range,
> +		.handler	= kvm_mmu_unmap_gfn_range,
>   		.on_lock	= kvm_mmu_invalidate_begin,
>   		.on_unlock	= kvm_arch_guest_memory_reclaimed,
>   		.flush_on_ret	= true,
> @@ -817,8 +833,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   	return 0;
>   }
>   
> -void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
> -			    unsigned long end)
> +void kvm_mmu_invalidate_end(struct kvm *kvm)
>   {
>   	/*
>   	 * This sequence increase will notify the kvm page fault that
> @@ -833,6 +848,13 @@ void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
>   	 * in conjunction with the smp_rmb in mmu_invalidate_retry().
>   	 */
>   	kvm->mmu_invalidate_in_progress--;
> +
> +	/*
> +	 * Assert that at least one range must be added between start() and
> +	 * end().  Not adding a range isn't fatal, but it is a KVM bug.
> +	 */
> +	WARN_ON_ONCE(kvm->mmu_invalidate_in_progress &&
> +		     kvm->mmu_invalidate_range_start == INVALID_GPA);
Should the check happen before the decrease of 
kvm->mmu_invalidate_in_progress?
Otherwise, KVM calls kvm_mmu_invalidate_begin(), then 
kvm_mmu_invalidate_end()
the check will not take effect.

>   }
>   
>   static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,

