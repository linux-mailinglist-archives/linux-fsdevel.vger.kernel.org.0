Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DA658E8A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiHJIYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiHJIYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:24:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4721885F88;
        Wed, 10 Aug 2022 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660119880; x=1691655880;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=6kT9mTMxRWS6E11jw9PH26Anrkm3qIMlLthMQe7yaTk=;
  b=A7UeecBqYGcs818PljT93xy7yN1I2Hi5FEH2T4fJYUXeHBAvSV2hAUeT
   V4kOGW7cqdLNQGRqAE35GoDPubqecUgDgeo3tvEnL/VsnybJAPHJhFG7g
   CDGEQ2uCQtpCja9UOh0kL0/L1jc49///IAFQma+JN52Xk+US5sxjeLiZf
   vLyzwrbDHKDC8sd0pImoKZ/QAVMcZ/yLzTg4lXSEc0KqkaLrMlkPZb/+A
   YjlKv73oklEKEeKz0iDgI7CIXtho+lUjcTppRypanTTJ0AOmW5dRSfC8y
   Acvtk/7HG6P6X0gh0DwN5G2xxOvyTGRApzwRJM/PEeFpG0ZkcayhPCMwF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="289784598"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="289784598"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 01:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="601738890"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2022 01:24:29 -0700
Date:   Wed, 10 Aug 2022 16:19:43 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 07/14] KVM: Use gfn instead of hva for
 mmu_notifier_retry
Message-ID: <20220810081943.GB862421@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-8-chao.p.peng@linux.intel.com>
 <20220804071044.GA4091749@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804071044.GA4091749@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 04, 2022 at 12:10:44AM -0700, Isaku Yamahata wrote:
> On Wed, Jul 06, 2022 at 04:20:09PM +0800,
> Chao Peng <chao.p.peng@linux.intel.com> wrote:
> 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 0bdb6044e316..e9153b54e2a4 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1362,10 +1362,8 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
> >  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
> >  #endif
> >  
> > -void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
> > -				   unsigned long end);
> > -void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
> > -				   unsigned long end);
> > +void kvm_inc_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
> > +void kvm_dec_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
> >  
> >  long kvm_arch_dev_ioctl(struct file *filp,
> >  			unsigned int ioctl, unsigned long arg);
> 
> The corresponding changes in kvm_main.c are missing.

Exactly! Actually it's in the next patch while it should indeed in
this patch.

Chao
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b2c79bef61bd..0184e327f6f5 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -711,8 +711,7 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>         kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
>  }
>  
> -void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
> -                                  unsigned long end)
> +void kvm_inc_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end)
>  {
>         /*
>          * The count increase must become visible at unlock time as no
> @@ -786,8 +785,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>         return 0;
>  }
>  
> -void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
> -                                  unsigned long end)
> +void kvm_dec_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end)
>  {
>         /*
>          * This sequence increase will notify the kvm page fault that
> 
> 
> -- 
> Isaku Yamahata <isaku.yamahata@gmail.com>
