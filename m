Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41F84FE17C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 15:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351828AbiDLNFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 09:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356112AbiDLNDR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:03:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3CC6A05E;
        Tue, 12 Apr 2022 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649767432; x=1681303432;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=dy/TdJnUMbUKhIlocJ/LouJFjjtZwg5GwrTeZmhomcI=;
  b=QF5XI7sKGB+JCj9Po7OuVzK/cL5tsOa/oQEsr66dt68Wt8RsWFtGwAw5
   VMsZvLPCyJ4ZCLptcoBNeSjuU+BnaSOoWoVn/JELsFu1IzMKZ8qrYQlX4
   A4BHZe+QuRft5G3PMQ9HRikQN9NEyLt7fdZAJvYfHEHz6Kc0iEDIGAXuJ
   nVmJPi9MXxRmYYIdiV+5HItqf+hxvYDfQlRE8rdpNzx6KBz3v4Npr187L
   IfgccopctVlZLryG3664OSMUWwliS+fFV3sESacDAp7OxJfLRzCdLiUoc
   30kdjw+strp5PW0c8npdHluKUJuJnILejcroY8Bu8SjlGX5aWFXGT/9z1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262545039"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262545039"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 05:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="526024498"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2022 05:43:36 -0700
Date:   Tue, 12 Apr 2022 20:43:25 +0800
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
Subject: Re: [PATCH v5 11/13] KVM: Zap existing KVM mappings when pages
 changed in the private fd
Message-ID: <20220412124325.GB8013@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-12-chao.p.peng@linux.intel.com>
 <YkNcmGsOw4MThaym@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkNcmGsOw4MThaym@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 07:23:04PM +0000, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 67349421eae3..52319f49d58a 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -841,8 +841,43 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
> >  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
> >  
> >  #ifdef CONFIG_MEMFILE_NOTIFIER
> > +static void kvm_memfile_notifier_handler(struct memfile_notifier *notifier,
> > +					 pgoff_t start, pgoff_t end)
> > +{
> > +	int idx;
> > +	struct kvm_memory_slot *slot = container_of(notifier,
> > +						    struct kvm_memory_slot,
> > +						    notifier);
> > +	struct kvm_gfn_range gfn_range = {
> > +		.slot		= slot,
> > +		.start		= start - (slot->private_offset >> PAGE_SHIFT),
> > +		.end		= end - (slot->private_offset >> PAGE_SHIFT),
> > +		.may_block 	= true,
> > +	};
> > +	struct kvm *kvm = slot->kvm;
> > +
> > +	gfn_range.start = max(gfn_range.start, slot->base_gfn);
> > +	gfn_range.end = min(gfn_range.end, slot->base_gfn + slot->npages);
> > +
> > +	if (gfn_range.start >= gfn_range.end)
> > +		return;
> > +
> > +	idx = srcu_read_lock(&kvm->srcu);
> > +	KVM_MMU_LOCK(kvm);
> > +	kvm_unmap_gfn_range(kvm, &gfn_range);
> > +	kvm_flush_remote_tlbs(kvm);
> 
> This should check the result of kvm_unmap_gfn_range() and flush only if necessary.

Yep.

> 
> kvm->mmu_notifier_seq needs to be incremented, otherwise KVM will incorrectly
> install a SPTE if the mapping is zapped between retrieving the pfn in faultin and
> installing it after acquire mmu_lock.

Good catch.

Chao
> 
> 
> > +	KVM_MMU_UNLOCK(kvm);
> > +	srcu_read_unlock(&kvm->srcu, idx);
> > +}
> > +
> > +static struct memfile_notifier_ops kvm_memfile_notifier_ops = {
> > +	.invalidate = kvm_memfile_notifier_handler,
> > +	.fallocate = kvm_memfile_notifier_handler,
> > +};
> > +
> >  static inline int kvm_memfile_register(struct kvm_memory_slot *slot)
> >  {
> > +	slot->notifier.ops = &kvm_memfile_notifier_ops;
> >  	return memfile_register_notifier(file_inode(slot->private_file),
> >  					 &slot->notifier,
> >  					 &slot->pfn_ops);
> > @@ -1963,6 +1998,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  	new->private_file = file;
> >  	new->private_offset = mem->flags & KVM_MEM_PRIVATE ?
> >  			      region_ext->private_offset : 0;
> > +	new->kvm = kvm;
> >  
> >  	r = kvm_set_memslot(kvm, old, new, change);
> >  	if (!r)
> > -- 
> > 2.17.1
> > 
