Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43336209FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 08:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiKHHVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 02:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiKHHVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:21:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9ED13D05;
        Mon,  7 Nov 2022 23:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667892062; x=1699428062;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=upQwL5A0Maekh82raTC60T5oBKGppSiNQzfVbZZR6Q8=;
  b=NHZNtum37Ge4b2nlVNYfhNWqQeDTgP1qrq3FaXkb/9JepQ1xobuoFHio
   xA1ch3lfnVuWBN6NE6rVlH6Y90/WigCk9thA8qEijNyDaPkooyfOis+OZ
   u334GIWAl3n/QSoVrQW+s4g6QgZX8NF3qAv+TYTOHYB0+h7me/Ox/daGR
   YRF54QlGLpHFHLxpwFFK3F8R4c9Pl0wiwhVQXIda1xfgsM7cuFl2g3++L
   P/865ao2BKIRjxHfTEQKJciWfW49XFgQ8IVeVA0qx1l92X5uJveR081M9
   5qSSWBgCwZFjro/whtOeNKQsm24iAl6DeVwzMLYBFKO+cyPGRMGcNf5y9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="312416933"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="312416933"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638690908"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="638690908"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 23:20:50 -0800
Date:   Tue, 8 Nov 2022 15:16:24 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
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
Subject: Re: [PATCH v9 4/8] KVM: Use gfn instead of hva for mmu_notifier_retry
Message-ID: <20221108071624.GA76278@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-5-chao.p.peng@linux.intel.com>
 <CA+EHjTySnJTuLB+XoRya6kS_zw2iMahW9-Ze70oKTf+6k0GrGQ@mail.gmail.com>
 <20221104022813.GA4129873@chaop.bj.intel.com>
 <Y2WSXLtcJOpWPtuv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2WSXLtcJOpWPtuv@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:29:48PM +0000, Sean Christopherson wrote:
> On Fri, Nov 04, 2022, Chao Peng wrote:
> > On Thu, Oct 27, 2022 at 11:29:14AM +0100, Fuad Tabba wrote:
> > > Hi,
> > > 
> > > On Tue, Oct 25, 2022 at 4:19 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > > >
> > > > Currently in mmu_notifier validate path, hva range is recorded and then
> > > > checked against in the mmu_notifier_retry_hva() of the page fault path.
> > > > However, for the to be introduced private memory, a page fault may not
> > > > have a hva associated, checking gfn(gpa) makes more sense.
> > > >
> > > > For existing non private memory case, gfn is expected to continue to
> > > > work. The only downside is when aliasing multiple gfns to a single hva,
> > > > the current algorithm of checking multiple ranges could result in a much
> > > > larger range being rejected. Such aliasing should be uncommon, so the
> > > > impact is expected small.
> > > >
> > > > It also fixes a bug in kvm_zap_gfn_range() which has already been using
> > > 
> > > nit: Now it's kvm_unmap_gfn_range().
> > 
> > Forgot to mention: the bug is still with kvm_zap_gfn_range(). It calls
> > kvm_mmu_invalidate_begin/end with a gfn range but before this series
> > kvm_mmu_invalidate_begin/end actually accept a hva range. Note it's
> > unrelated to whether we use kvm_zap_gfn_range() or kvm_unmap_gfn_range()
> > in the following patch (patch 05).
> 
> Grr, in the future, if you find an existing bug, please send a patch.  At the
> very least, report the bug.

Agreed, this can be sent out separately from this series.

> The APICv case that this was added for could very
> well be broken because of this, and the resulting failures would be an absolute
> nightmare to debug.

Given the apicv_inhibit should be rare, the change looks good to me.
Just to be clear, your will send out this fix, right?

Chao

> 
> Compile tested only...
> 
> --
> From: Sean Christopherson <seanjc@google.com>
> Date: Fri, 4 Nov 2022 22:20:33 +0000
> Subject: [PATCH] KVM: x86/mmu: Block all page faults during
>  kvm_zap_gfn_range()
> 
> When zapping a GFN range, pass 0 => ALL_ONES for the to-be-invalidated
> range to effectively block all page faults while the zap is in-progress.
> The invalidation helpers take a host virtual address, whereas zapping a
> GFN obviously provides a guest physical address and with the wrong unit
> of measurement (frame vs. byte).
> 
> Alternatively, KVM could walk all memslots to get the associated HVAs,
> but thanks to SMM, that would require multiple lookups.  And practically
> speaking, kvm_zap_gfn_range() usage is quite rare and not a hot path,
> e.g. MTRR and CR0.CD are almost guaranteed to be done only on vCPU0
> during boot, and APICv inhibits are similarly infrequent operations.
> 
> Fixes: edb298c663fc ("KVM: x86/mmu: bump mmu notifier count in kvm_zap_gfn_range")
> Cc: stable@vger.kernel.org
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6f81539061d6..1ccb769f62af 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6056,7 +6056,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>  
>  	write_lock(&kvm->mmu_lock);
>  
> -	kvm_mmu_invalidate_begin(kvm, gfn_start, gfn_end);
> +	kvm_mmu_invalidate_begin(kvm, 0, -1ul);
>  
>  	flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
>  
> @@ -6070,7 +6070,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
>  		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
>  						   gfn_end - gfn_start);
>  
> -	kvm_mmu_invalidate_end(kvm, gfn_start, gfn_end);
> +	kvm_mmu_invalidate_end(kvm, 0, -1ul);
>  
>  	write_unlock(&kvm->mmu_lock);
>  }
> 
> base-commit: c12879206e47730ff5ab255bbf625b28ade4028f
> -- 
