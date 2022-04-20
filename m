Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F153507F8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 05:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359225AbiDTDUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 23:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiDTDUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:20:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB139FD6;
        Tue, 19 Apr 2022 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650424656; x=1681960656;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=aSlmWYo67979bXI+8rgE6ppMUFAAUoPR5mX4oC2meD8=;
  b=QzBDTsvB3pu732uwEag5dKe9Z5E4wa2OBJsOu4qRT8u9ak/Jwj8wDepy
   hrvclFPbcUWUmVpyOIRKUJ8ybBNU+dDgHMzBKzKMHRieiGfcMVXiuUPcK
   C2sLPXkWyP6AHeM9M2kvB1CAXL9fvOdyyhvl3Wd2lgnUCV05eaq//irld
   m8PEQd3mOZkWzJz1N1+Z2OFBWt77Zrrg4/PzhZWQgWyfEVsMHLR90TyXQ
   4u8juvKqF0fiNsgu+RiS4oFwTOXNqcuYX4uCRG1zbcGO2HHwyVJreDvR8
   6vVg458hdAiLnQrEOfMRCgSCO/rfRpkqXnF1n1Zirg0JHrclmKisYCgVb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350375126"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="350375126"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 20:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="667588846"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2022 20:17:27 -0700
Date:   Wed, 20 Apr 2022 11:17:18 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 11/13] KVM: Zap existing KVM mappings when pages
 changed in the private fd
Message-ID: <20220420031718.GA39591@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-12-chao.p.peng@linux.intel.com>
 <CAGtprH-qTB2sehidF7xkSvR3X4D5cUOLpMBXf4mhTEh0BUR-mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH-qTB2sehidF7xkSvR3X4D5cUOLpMBXf4mhTEh0BUR-mQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 03:43:56PM -0700, Vishal Annapurve wrote:
> On Thu, Mar 10, 2022 at 6:11 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >
> > KVM gets notified when memory pages changed in the memory backing store.
> > When userspace allocates the memory with fallocate() or frees memory
> > with fallocate(FALLOC_FL_PUNCH_HOLE), memory backing store calls into
> > KVM fallocate/invalidate callbacks respectively. To ensure KVM never
> > maps both the private and shared variants of a GPA into the guest, in
> > the fallocate callback, we should zap the existing shared mapping and
> > in the invalidate callback we should zap the existing private mapping.
> >
> > In the callbacks, KVM firstly converts the offset range into the
> > gfn_range and then calls existing kvm_unmap_gfn_range() which will zap
> > the shared or private mapping. Both callbacks pass in a memslot
> > reference but we need 'kvm' so add a reference in memslot structure.
> >
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  include/linux/kvm_host.h |  3 ++-
> >  virt/kvm/kvm_main.c      | 36 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 9b175aeca63f..186b9b981a65 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -236,7 +236,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
> >  #endif
> >
> > -#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
> > +#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_MEMFILE_NOTIFIER)
> >  struct kvm_gfn_range {
> >         struct kvm_memory_slot *slot;
> >         gfn_t start;
> > @@ -568,6 +568,7 @@ struct kvm_memory_slot {
> >         loff_t private_offset;
> >         struct memfile_pfn_ops *pfn_ops;
> >         struct memfile_notifier notifier;
> > +       struct kvm *kvm;
> >  };
> >
> >  static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 67349421eae3..52319f49d58a 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -841,8 +841,43 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
> >  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
> >
> >  #ifdef CONFIG_MEMFILE_NOTIFIER
> > +static void kvm_memfile_notifier_handler(struct memfile_notifier *notifier,
> > +                                        pgoff_t start, pgoff_t end)
> > +{
> > +       int idx;
> > +       struct kvm_memory_slot *slot = container_of(notifier,
> > +                                                   struct kvm_memory_slot,
> > +                                                   notifier);
> > +       struct kvm_gfn_range gfn_range = {
> > +               .slot           = slot,
> > +               .start          = start - (slot->private_offset >> PAGE_SHIFT),
> > +               .end            = end - (slot->private_offset >> PAGE_SHIFT),
> > +               .may_block      = true,
> > +       };
> > +       struct kvm *kvm = slot->kvm;
> > +
> > +       gfn_range.start = max(gfn_range.start, slot->base_gfn);
> 
> gfn_range.start seems to be page offset within the file. Should this rather be:
> gfn_range.start = slot->base_gfn + min(gfn_range.start, slot->npages);

Right. For start we don't really need care about the uppper bound
here (will check below), so this should be enough:
	gfn_range.start = slot->base_gfn + gfn_range.start;

> 
> > +       gfn_range.end = min(gfn_range.end, slot->base_gfn + slot->npages);
> > +
> 
> Similar to previous comment, should this rather be:
> gfn_range.end = slot->base_gfn + min(gfn_range.end, slot->npages);

This is correct.

Thanks,
Chao
> 
> > +       if (gfn_range.start >= gfn_range.end)
> > +               return;
> > +
> > +       idx = srcu_read_lock(&kvm->srcu);
> > +       KVM_MMU_LOCK(kvm);
> > +       kvm_unmap_gfn_range(kvm, &gfn_range);
> > +       kvm_flush_remote_tlbs(kvm);
> > +       KVM_MMU_UNLOCK(kvm);
> > +       srcu_read_unlock(&kvm->srcu, idx);
> > +}
> > +
> > +static struct memfile_notifier_ops kvm_memfile_notifier_ops = {
> > +       .invalidate = kvm_memfile_notifier_handler,
> > +       .fallocate = kvm_memfile_notifier_handler,
> > +};
> > +
> >  static inline int kvm_memfile_register(struct kvm_memory_slot *slot)
> >  {
> > +       slot->notifier.ops = &kvm_memfile_notifier_ops;
> >         return memfile_register_notifier(file_inode(slot->private_file),
> >                                          &slot->notifier,
> >                                          &slot->pfn_ops);
> > @@ -1963,6 +1998,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >         new->private_file = file;
> >         new->private_offset = mem->flags & KVM_MEM_PRIVATE ?
> >                               region_ext->private_offset : 0;
> > +       new->kvm = kvm;
> >
> >         r = kvm_set_memslot(kvm, old, new, change);
> >         if (!r)
> > --
> > 2.17.1
> >
