Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD3E59F7FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 12:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiHXKme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 06:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiHXKmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:42:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB0381B24;
        Wed, 24 Aug 2022 03:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661337751; x=1692873751;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=lnG4/IetgJJiCFvYl2XSmHM42xhaifZaMgp7nfdirTE=;
  b=eNZsqDl4c8MZlLJ2p0h20eTzbb5c754AMOUHjTxenfjCe6a5zRuA3vdB
   JpIIgiJbkGJ2YxTocSYwyLXKU6TW1aEZ4/DimabkqBATW7lS47yBDKJWT
   RBM3hvH78/yAmYocq20gokL8cRZ2w3XaKOQXMvJIhutN5YJoQC5mZNZYC
   8kVpnUIzYIHzIGP0nfhPOTzp6JfZn/5ThXoMNwF7ujFQBZXf0OSUERmgK
   4f9sVKh6c2AkR24KPiw6ew1FgLJwQTrCkqctXLWqcXVrJeYyZbMbbUuYP
   834PtJ9Jbyia4YGVAeNOAOwcomG+ME3BZ9d6+Y3dbrXZA+7s/Q1o6HNGe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355660053"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="355660053"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 03:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="605989312"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2022 03:42:21 -0700
Date:   Wed, 24 Aug 2022 18:37:38 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Message-ID: <20220824103738.GA1386620@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <CAGtprH9xyw6bt4=RBWF6-v2CSpabOCpKq5rPz+e-9co7EisoVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH9xyw6bt4=RBWF6-v2CSpabOCpKq5rPz+e-9co7EisoVQ@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 12:37:42PM -0700, Vishal Annapurve wrote:
> > ...
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 230c8ff9659c..bb714c2a4b06 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -914,6 +914,35 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
> >
> >  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
> >
> > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> > +#define KVM_MEM_ATTR_PRIVATE   0x0001
> > +static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl,
> > +                                            struct kvm_enc_region *region)
> > +{
> > +       unsigned long start, end;
> > +       void *entry;
> > +       int r;
> > +
> > +       if (region->size == 0 || region->addr + region->size < region->addr)
> > +               return -EINVAL;
> > +       if (region->addr & (PAGE_SIZE - 1) || region->size & (PAGE_SIZE - 1))
> > +               return -EINVAL;
> > +
> > +       start = region->addr >> PAGE_SHIFT;
> > +       end = (region->addr + region->size - 1) >> PAGE_SHIFT;
> > +
> > +       entry = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION ?
> > +                               xa_mk_value(KVM_MEM_ATTR_PRIVATE) : NULL;
> > +
> > +       r = xa_err(xa_store_range(&kvm->mem_attr_array, start, end,
> > +                                       entry, GFP_KERNEL_ACCOUNT));
> 
> xa_store_range seems to create multi-index entries by default.
> Subsequent xa_store_range call changes all the entries stored
> previously.

By using xa_store_range and storing them as multi-index entries I
expected to save some memory for continuous pages originally.

But sounds like the current multi-index store behaviour isn't quite
ready for our usage.

Chao
> xa_store needs to be used here instead of xa_store_range to achieve
> the intended behavior.
> 
> > +
> > +       kvm_zap_gfn_range(kvm, start, end + 1);
> > +
> > +       return r;
> > +}
> > +#endif /* CONFIG_HAVE_KVM_PRIVATE_MEM */
> > +
> > ...
