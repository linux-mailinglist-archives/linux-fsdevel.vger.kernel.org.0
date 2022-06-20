Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61DC551F65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiFTOxq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiFTOx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:53:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1D5402D;
        Mon, 20 Jun 2022 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655734345; x=1687270345;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=K/d62gPSVg4NmMutWFje50dPhFVYB3cepmG67K0wcUc=;
  b=PtAYmLFQJH9hc5Pl0XaLMJftFj9UzobtnBZaW9X0eKi2Qn5YTowkdk0q
   Ac4ko5y31hNZx86a1OWG34b1sAn9YaX8HgmKdm+m51pBFKYufhJOHuAjS
   8zsfsTCLhtlsIiWNSseiMw6z+ISlqm/c42LpX3uuzSTVSKzzaiuZSeabV
   1SOAStvCRkWdvs3paqR8NtHQ0KPFr+8//jV7Ht+Jnp3H9RHGv4hDuZqoc
   0u5pgKNUblhhQ7Y/slD1urir1uUFBNbtaYjvJq+ticiu8yVtrgGIxLVsS
   91PVWCA/EgZu6rTiKMWXoMNdvJQZfxjwC8+/wWwE5GhXdO/UAYoOHxqrC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278677648"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278677648"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 07:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584911886"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2022 07:12:02 -0700
Date:   Mon, 20 Jun 2022 22:08:41 +0800
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220620140841.GA2016793@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <Yqzpf3AEYabFWjnW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqzpf3AEYabFWjnW@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 08:52:15PM +0000, Sean Christopherson wrote:
> On Thu, May 19, 2022, Chao Peng wrote:
> > @@ -653,12 +662,12 @@ struct kvm_irq_routing_table {
> >  };
> >  #endif
> >  
> > -#ifndef KVM_PRIVATE_MEM_SLOTS
> > -#define KVM_PRIVATE_MEM_SLOTS 0
> > +#ifndef KVM_INTERNAL_MEM_SLOTS
> > +#define KVM_INTERNAL_MEM_SLOTS 0
> >  #endif
> 
> This rename belongs in a separate patch.

Will separate it out, thanks.

> 
> >  #define KVM_MEM_SLOTS_NUM SHRT_MAX
> > -#define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_PRIVATE_MEM_SLOTS)
> > +#define KVM_USER_MEM_SLOTS (KVM_MEM_SLOTS_NUM - KVM_INTERNAL_MEM_SLOTS)
> >  
> >  #ifndef __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
> >  static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
> > @@ -1087,9 +1096,9 @@ enum kvm_mr_change {
> >  };
> >  
> >  int kvm_set_memory_region(struct kvm *kvm,
> > -			  const struct kvm_userspace_memory_region *mem);
> > +			  const struct kvm_user_mem_region *mem);
> >  int __kvm_set_memory_region(struct kvm *kvm,
> > -			    const struct kvm_userspace_memory_region *mem);
> > +			    const struct kvm_user_mem_region *mem);
> >  void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
> >  void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
> >  int kvm_arch_prepare_memory_region(struct kvm *kvm,
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index e10d131edd80..28cacd3656d4 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -103,6 +103,29 @@ struct kvm_userspace_memory_region {
> >  	__u64 userspace_addr; /* start of the userspace allocated memory */
> >  };
> >  
> > +struct kvm_userspace_memory_region_ext {
> > +	struct kvm_userspace_memory_region region;
> > +	__u64 private_offset;
> > +	__u32 private_fd;
> > +	__u32 pad1;
> > +	__u64 pad2[14];
> > +};
> > +
> > +#ifdef __KERNEL__
> > +/* Internal helper, the layout must match above user visible structures */
> 
> It's worth explicity calling out which structureso this aliases.  And rather than
> add a comment about the layout needing to match that, enforce it in code. I
> personally wouldn't bother with an expolicit comment about the layout, IMO that's
> a fairly obvious implication of aliasing.
> 
> /*
>  * kvm_user_mem_region is a kernel-only alias of kvm_userspace_memory_region_ext
>  * that "unpacks" kvm_userspace_memory_region so that KVM can directly access
>  * all fields from the top-level "extended" region.
>  */
> 

Thanks.

> 
> And I think it's in this patch that you missed a conversion to the alias, in the
> prototype for check_memory_region_flags() (looks like it gets fixed up later in
> the series).
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0f81bf0407be..8765b334477d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1466,7 +1466,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
>         }
>  }
> 
> -static int check_memory_region_flags(const struct kvm_userspace_memory_region *mem)
> +static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
>  {
>         u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
> 
> @@ -4514,6 +4514,33 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
>         return fd;
>  }
> 
> +#define SANITY_CHECK_MEM_REGION_FIELD(field)                                   \
> +do {                                                                           \
> +       BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=             \
> +                    offsetof(struct kvm_userspace_memory_region, field));      \
> +       BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) !=         \
> +                    sizeof_field(struct kvm_userspace_memory_region, field));  \
> +} while (0)
> +
> +#define SANITY_CHECK_MEM_REGION_EXT_FIELD(field)                                       \
> +do {                                                                                   \
> +       BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=                     \
> +                    offsetof(struct kvm_userspace_memory_region_ext, field));          \
> +       BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) !=                 \
> +                    sizeof_field(struct kvm_userspace_memory_region_ext, field));      \
> +} while (0)
> +
> +static void kvm_sanity_check_user_mem_region_alias(void)
> +{
> +       SANITY_CHECK_MEM_REGION_FIELD(slot);
> +       SANITY_CHECK_MEM_REGION_FIELD(flags);
> +       SANITY_CHECK_MEM_REGION_FIELD(guest_phys_addr);
> +       SANITY_CHECK_MEM_REGION_FIELD(memory_size);
> +       SANITY_CHECK_MEM_REGION_FIELD(userspace_addr);
> +       SANITY_CHECK_MEM_REGION_EXT_FIELD(private_offset);
> +       SANITY_CHECK_MEM_REGION_EXT_FIELD(private_fd);
> +}
> +
>  static long kvm_vm_ioctl(struct file *filp,
>                            unsigned int ioctl, unsigned long arg)
>  {
> @@ -4541,6 +4568,8 @@ static long kvm_vm_ioctl(struct file *filp,
>                 unsigned long size;
>                 u32 flags;
> 
> +               kvm_sanity_check_user_mem_region_alias();
> +
>                 memset(&mem, 0, sizeof(mem));
> 
>                 r = -EFAULT;
> 
> > +struct kvm_user_mem_region {
> > +	__u32 slot;
> > +	__u32 flags;
> > +	__u64 guest_phys_addr;
> > +	__u64 memory_size;
> > +	__u64 userspace_addr;
> > +	__u64 private_offset;
> > +	__u32 private_fd;
> > +	__u32 pad1;
> > +	__u64 pad2[14];
> > +};
> > +#endif
> > +
> >  /*
> >   * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
> >   * other bits are reserved for kvm internal use which are defined in
> > @@ -110,6 +133,7 @@ struct kvm_userspace_memory_region {
> >   */
> >  #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> >  #define KVM_MEM_READONLY	(1UL << 1)
> > +#define KVM_MEM_PRIVATE		(1UL << 2)
> 
> Hmm, KVM_MEM_PRIVATE is technically wrong now that a "private" memslot maps private
> and/or shared memory.  Strictly speaking, we don't actually need a new flag.  Valid
> file descriptors must be >=0, so the logic for specifying a memslot that can be
> converted between private and shared could be that "(int)private_fd < 0" means
> "not convertible", i.e. derive the flag from private_fd.

I think a flag is still needed, the problem is private_fd can be safely
accessed only when this flag is set, e.g. without this flag, we can't
copy_from_user these new fields since they don't exist for previous
kvm_userspace_memory_region callers.

> 
> And looking at the two KVM consumers of the flag, via kvm_slot_is_private(), they're
> both wrong.  Both kvm_faultin_pfn() and kvm_mmu_max_mapping_level() should operate
> on the _fault_, not the slot.  So it would actually be a positive to not have an easy
> way to query if a slot supports conversion.
> 
> >  /* for KVM_IRQ_LINE */
> >  struct kvm_irq_level {
> 
> ...
> 
> > +		if (flags & KVM_MEM_PRIVATE) {
> 
> An added bonus of dropping KVM_MEM_PRIVATE is that these checks go away.
> 
> > +			r = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		size = sizeof(struct kvm_userspace_memory_region);
> > +
> > +		if (copy_from_user(&mem, argp, size))
> > +			goto out;
> > +
> > +		r = -EINVAL;
> > +		if ((flags ^ mem.flags) & KVM_MEM_PRIVATE)
> >  			goto out;
> >  
> > -		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
> > +		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
> >  		break;
> >  	}
> >  	case KVM_GET_DIRTY_LOG: {
> > -- 
> > 2.25.1
> > 
