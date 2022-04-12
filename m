Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2202C4FE17E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354979AbiDLNFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354975AbiDLNCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:02:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C53198;
        Tue, 12 Apr 2022 05:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649767275; x=1681303275;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=eyXblfG/A5HWVja7fFUb4HNY/ZRRmFMXW6QIdjEei/o=;
  b=Bf3bPc/YraGzPZAJmicdhLm+9cFkKE5cPUl/VANxPQgA3hCbaw/aB6ll
   ZD7EkPG0pScmuSl8bC1F/ByShPpMM5XywO9YoXWFp9zvfIXxcyzSgWS4F
   qyxkp/zKVIC/3GmZqUCgB7x+qYFGLluSh74zlGjxj6f1lrXnDJs5fwJWs
   5XMLNJ5A1UHAYOu09dSrrcUuAzkdCavt3rCuJ5+iu+V/Zs1x/pSxcNTc7
   QBDUWmUqLMDeznZPqx+8xmnEMikNLBFpndwHseJ6yV+jbb2BOrkUgaE83
   CaVJNhneaOY8Y78bV1D5+4WR+eGxcJE6vIAMuaXV+5NjpdL8+R8BPMl6w
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262112433"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262112433"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 05:41:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="526023841"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2022 05:41:06 -0700
Date:   Tue, 12 Apr 2022 20:40:56 +0800
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
Subject: Re: [PATCH v5 10/13] KVM: Register private memslot to memory backing
 store
Message-ID: <20220412124056.GA8013@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-11-chao.p.peng@linux.intel.com>
 <YkNXoCBjfpfI67QF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkNXoCBjfpfI67QF@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 07:01:52PM +0000, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
> > Add 'notifier' to memslot to make it a memfile_notifier node and then
> > register it to memory backing store via memfile_register_notifier() when
> > memslot gets created. When memslot is deleted, do the reverse with
> > memfile_unregister_notifier(). Note each KVM memslot can be registered
> > to different memory backing stores (or the same backing store but at
> > different offset) independently.
> > 
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  include/linux/kvm_host.h |  1 +
> >  virt/kvm/kvm_main.c      | 75 ++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 70 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 6e1d770d6bf8..9b175aeca63f 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -567,6 +567,7 @@ struct kvm_memory_slot {
> >  	struct file *private_file;
> >  	loff_t private_offset;
> >  	struct memfile_pfn_ops *pfn_ops;
> > +	struct memfile_notifier notifier;
> >  };
> >  
> >  static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index d11a2628b548..67349421eae3 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -840,6 +840,37 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
> >  
> >  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
> >  
> > +#ifdef CONFIG_MEMFILE_NOTIFIER
> > +static inline int kvm_memfile_register(struct kvm_memory_slot *slot)
> 
> This is a good oppurtunity to hide away the memfile details a bit.  Maybe
> kvm_private_mem_{,un}register()?

Happy to change.

> 
> > +{
> > +	return memfile_register_notifier(file_inode(slot->private_file),
> > +					 &slot->notifier,
> > +					 &slot->pfn_ops);
> > +}
> > +
> > +static inline void kvm_memfile_unregister(struct kvm_memory_slot *slot)
> > +{
> > +	if (slot->private_file) {
> > +		memfile_unregister_notifier(file_inode(slot->private_file),
> > +					    &slot->notifier);
> > +		fput(slot->private_file);
> 
> This should not do fput(), it makes the helper imbalanced with respect to the
> register path and will likely lead to double fput().  Indeed, if preparing the
> region fails, __kvm_set_memory_region() will double up on fput() due to checking
> its local "file" for null, not slot->private for null.

Right.

> 
> > +		slot->private_file = NULL;
> > +	}
> > +}
> > +
> > +#else /* !CONFIG_MEMFILE_NOTIFIER */
> > +
> > +static inline int kvm_memfile_register(struct kvm_memory_slot *slot)
> > +{
> 
> This should WARN_ON_ONCE().  Ditto for unregister.
> 
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static inline void kvm_memfile_unregister(struct kvm_memory_slot *slot)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_MEMFILE_NOTIFIER */
> > +
> >  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
> >  static int kvm_pm_notifier_call(struct notifier_block *bl,
> >  				unsigned long state,
> > @@ -884,6 +915,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
> >  /* This does not remove the slot from struct kvm_memslots data structures */
> >  static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
> >  {
> > +	if (slot->flags & KVM_MEM_PRIVATE)
> > +		kvm_memfile_unregister(slot);
> 
> With fput() move out of unregister, this needs to be:

Agreed.

> 
> 	if (slot->flags & KVM_MEM_PRIVATE) {
> 		kvm_private_mem_unregister(slot);
> 		fput(slot->private_file);
> 	}
> > +
> >  	kvm_destroy_dirty_bitmap(slot);
> >  
> >  	kvm_arch_free_memslot(kvm, slot);
> > @@ -1738,6 +1772,12 @@ static int kvm_set_memslot(struct kvm *kvm,
> >  		kvm_invalidate_memslot(kvm, old, invalid_slot);
> >  	}
> >  
> > +	if (new->flags & KVM_MEM_PRIVATE && change == KVM_MR_CREATE) {
> > +		r = kvm_memfile_register(new);
> > +		if (r)
> > +			return r;
> > +	}
> 
> This belongs in kvm_prepare_memory_region().  The shenanigans for DELETE and MOVE
> are special.

Sure.

> 
> > +
> >  	r = kvm_prepare_memory_region(kvm, old, new, change);
> >  	if (r) {
> >  		/*
> > @@ -1752,6 +1792,10 @@ static int kvm_set_memslot(struct kvm *kvm,
> >  		} else {
> >  			mutex_unlock(&kvm->slots_arch_lock);
> >  		}
> > +
> > +		if (new->flags & KVM_MEM_PRIVATE && change == KVM_MR_CREATE)
> > +			kvm_memfile_unregister(new);
> > +
> >  		return r;
> >  	}
> >  
> > @@ -1817,6 +1861,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  	enum kvm_mr_change change;
> >  	unsigned long npages;
> >  	gfn_t base_gfn;
> > +	struct file *file = NULL;
> 
> Nit, naming this private_file would help understand its use.  Though I think it's
> easier to not have a local variable.  More below.
> 
> >  	int as_id, id;
> >  	int r;
> >  
> > @@ -1890,14 +1935,24 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  			return 0;
> >  	}
> >  
> > +	if (mem->flags & KVM_MEM_PRIVATE) {
> > +		file = fdget(region_ext->private_fd).file;
> 
> This can use fget() instead of fdget().
> 
> > +		if (!file)
> > +			return -EINVAL;
> > +	}
> > +
> >  	if ((change == KVM_MR_CREATE || change == KVM_MR_MOVE) &&
> > -	    kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages))
> > -		return -EEXIST;
> > +	    kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages)) {
> > +		r = -EEXIST;
> > +		goto out;
> > +	}
> >  
> >  	/* Allocate a slot that will persist in the memslot. */
> >  	new = kzalloc(sizeof(*new), GFP_KERNEL_ACCOUNT);
> > -	if (!new)
> > -		return -ENOMEM;
> > +	if (!new) {
> > +		r = -ENOMEM;
> > +		goto out;
> > +	}
> >  
> >  	new->as_id = as_id;
> >  	new->id = id;
> > @@ -1905,10 +1960,18 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  	new->npages = npages;
> >  	new->flags = mem->flags;
> >  	new->userspace_addr = mem->userspace_addr;
> > +	new->private_file = file;
> > +	new->private_offset = mem->flags & KVM_MEM_PRIVATE ?
> > +			      region_ext->private_offset : 0;
> 
> "new" is zero-allocated, so all the private stuff, including the fget(), can be
> wrapped in a single KVM_MEM_PRIVATE check.  Moving fget() eliminates the number
> of gotos needed (the above -EEXIST and -ENOMEM paths don't need to be modified).
> 
> >  	r = kvm_set_memslot(kvm, old, new, change);
> > -	if (r)
> > -		kfree(new);
> > +	if (!r)
> > +		return r;
> 
> Use goto, e.g.
> 
> 	if (r)
> 		goto out;
> 
> 	return 0;
> 
> Burying the happy path in a taken if-statement is confusing and error prone,
> mostly because it breaks well-established kernel patterns.  Note, there's no need
> for a separate out_free since new->private_file will be NULL in either case.  I
> don't have a strong preference, I just find it easier to read code that's more
> explicit, but I'm a-ok collapsing them into a single label.

Will follow this, thanks for the detailed suggestion.

Chao
> 
> 	if ((change == KVM_MR_CREATE || change == KVM_MR_MOVE) &&
> 	    kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages))
> 		return -EEXIST;
> 
> 	/* Allocate a slot that will persist in the memslot. */
> 	new = kzalloc(sizeof(*new), GFP_KERNEL_ACCOUNT);
> 	if (!new)
> 		return -ENOMEM;
> 
> 	new->as_id = as_id;
> 	new->id = id;
> 	new->base_gfn = base_gfn;
> 	new->npages = npages;
> 	new->flags = mem->flags;
> 	new->userspace_addr = mem->userspace_addr;
> 
> 	if (mem->flags & KVM_MEM_PRIVATE) {
> 		new->private_file = fget(mem->private_fd);
> 		if (!new->private_file) {
> 			r = -EINVAL;
> 			goto out_free;
> 		}
> 		new->private_offset = mem->private_offset;
> 	}
> 
> 	r = kvm_set_memslot(kvm, old, new, change);
> 	if (r)
> 		goto out;
> 
> 	return 0;
> 
> out:
> 	if (new->private_file)
> 		fput(new->private_file);
> 
> out_free:
> 	kfree(new);
> 	return r;
