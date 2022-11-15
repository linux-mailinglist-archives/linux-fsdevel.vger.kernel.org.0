Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C417629462
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKOJeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 04:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiKOJeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:34:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E4F12A83;
        Tue, 15 Nov 2022 01:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668504840; x=1700040840;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dNsM3rb5V+KYXYHSWNPt0esoX7Bknd1ZB3DIEqhegvE=;
  b=laSyQh9BYUDcQhpk6onkC9y1IzD78AgQ/VF08NtB1LAiCm3ZcVJyjf+D
   ZhQN3y6h2XpasQdGf0d1DomcbrAk/v33UmJMnKfp5otsD1Ff/X6B8vpgB
   h0MYr9jGqjtQ77xXr18+Xf7oqWq05I3UpT/1C8KKMl7+PsBj+Eag6ZHo+
   tdXoUYob1eAgebzDA54+or1o8mbfpGNcGo+TGvJ7yn3qJZh8vwBP/4vWE
   bZAKt6XeVwdT10i7JG7yVPLpzyqlIEJormRM6k325mq7zm0ufWkwr5XzL
   zWiQWJjXQUa0wD6dZJuTIEns2F4pa0UXemG/+RdchABkpBZVAIghUcrCs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="299733891"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="299733891"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 01:33:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702370731"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="702370731"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2022 01:33:31 -0800
Date:   Tue, 15 Nov 2022 17:29:06 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 2/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20221115092906.GA338422@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-3-chao.p.peng@linux.intel.com>
 <877czxbjf6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877czxbjf6.fsf@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:04:59PM +0000, Alex Bennée wrote:
> 
> Chao Peng <chao.p.peng@linux.intel.com> writes:
> 
> > In memory encryption usage, guest memory may be encrypted with special
> > key and can be accessed only by the guest itself. We call such memory
> > private memory. It's valueless and sometimes can cause problem to allow
> > userspace to access guest private memory. This new KVM memslot extension
> > allows guest private memory being provided though a restrictedmem
> > backed file descriptor(fd) and userspace is restricted to access the
> > bookmarked memory in the fd.
> >
> <snip>
> > To make code maintenance easy, internally we use a binary compatible
> > alias struct kvm_user_mem_region to handle both the normal and the
> > '_ext' variants.
> 
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 0d5d4419139a..f1ae45c10c94 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -103,6 +103,33 @@ struct kvm_userspace_memory_region {
> >  	__u64 userspace_addr; /* start of the userspace allocated memory */
> >  };
> >  
> > +struct kvm_userspace_memory_region_ext {
> > +	struct kvm_userspace_memory_region region;
> > +	__u64 restricted_offset;
> > +	__u32 restricted_fd;
> > +	__u32 pad1;
> > +	__u64 pad2[14];
> > +};
> > +
> > +#ifdef __KERNEL__
> > +/*
> > + * kvm_user_mem_region is a kernel-only alias of kvm_userspace_memory_region_ext
> > + * that "unpacks" kvm_userspace_memory_region so that KVM can directly access
> > + * all fields from the top-level "extended" region.
> > + */
> > +struct kvm_user_mem_region {
> > +	__u32 slot;
> > +	__u32 flags;
> > +	__u64 guest_phys_addr;
> > +	__u64 memory_size;
> > +	__u64 userspace_addr;
> > +	__u64 restricted_offset;
> > +	__u32 restricted_fd;
> > +	__u32 pad1;
> > +	__u64 pad2[14];
> > +};
> > +#endif
> 
> I'm not sure I buy the argument this makes the code maintenance easier
> because you now have multiple places to update if you extend the field.
> Was this simply to avoid changing:
> 
>   foo->slot to foo->region.slot
> 
> in the underlying code?

That is one of the reasons, by doing this we can also avoid confusion to
deal with '_ext' and the 'base' struct for different functions spread
across KVM code. No doubt now I need update every places where the
'base' struct is being used, but that makes future maintenance easier,
e.g. adding another new field or even extend the memslot structure again
would just require changes to the flat struct here and the places where
the new field is actually used.

> 
> > +
> >  /*
> >   * The bit 0 ~ bit 15 of kvm_memory_region::flags are visible for userspace,
> >   * other bits are reserved for kvm internal use which are defined in
> > @@ -110,6 +137,7 @@ struct kvm_userspace_memory_region {
> >   */
> >  #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> >  #define KVM_MEM_READONLY	(1UL << 1)
> > +#define KVM_MEM_PRIVATE		(1UL << 2)
> >  
> >  /* for KVM_IRQ_LINE */
> >  struct kvm_irq_level {
> > @@ -1178,6 +1206,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_S390_ZPCI_OP 221
> >  #define KVM_CAP_S390_CPU_TOPOLOGY 222
> >  #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
> > +#define KVM_CAP_PRIVATE_MEM 224
> >  
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >  
> > diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> > index 800f9470e36b..9ff164c7e0cc 100644
> > --- a/virt/kvm/Kconfig
> > +++ b/virt/kvm/Kconfig
> > @@ -86,3 +86,6 @@ config KVM_XFER_TO_GUEST_WORK
> >  
> >  config HAVE_KVM_PM_NOTIFIER
> >         bool
> > +
> > +config HAVE_KVM_RESTRICTED_MEM
> > +       bool
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index e30f1b4ecfa5..8dace78a0278 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -1526,7 +1526,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
> >  	}
> >  }
> >  
> > -static int check_memory_region_flags(const struct kvm_userspace_memory_region *mem)
> > +static int check_memory_region_flags(const struct kvm_user_mem_region *mem)
> >  {
> >  	u32 valid_flags = KVM_MEM_LOG_DIRTY_PAGES;
> >  
> > @@ -1920,7 +1920,7 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
> >   * Must be called holding kvm->slots_lock for write.
> >   */
> >  int __kvm_set_memory_region(struct kvm *kvm,
> > -			    const struct kvm_userspace_memory_region *mem)
> > +			    const struct kvm_user_mem_region *mem)
> >  {
> >  	struct kvm_memory_slot *old, *new;
> >  	struct kvm_memslots *slots;
> > @@ -2024,7 +2024,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
> >  
> >  int kvm_set_memory_region(struct kvm *kvm,
> > -			  const struct kvm_userspace_memory_region *mem)
> > +			  const struct kvm_user_mem_region *mem)
> >  {
> >  	int r;
> >  
> > @@ -2036,7 +2036,7 @@ int kvm_set_memory_region(struct kvm *kvm,
> >  EXPORT_SYMBOL_GPL(kvm_set_memory_region);
> >  
> >  static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
> > -					  struct kvm_userspace_memory_region *mem)
> > +					  struct kvm_user_mem_region *mem)
> >  {
> >  	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
> >  		return -EINVAL;
> > @@ -4627,6 +4627,33 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
> >  	return fd;
> >  }
> >  
> > +#define SANITY_CHECK_MEM_REGION_FIELD(field)					\
> > +do {										\
> > +	BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=		\
> > +		     offsetof(struct kvm_userspace_memory_region, field));	\
> > +	BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) !=		\
> > +		     sizeof_field(struct kvm_userspace_memory_region, field));	\
> > +} while (0)
> > +
> > +#define SANITY_CHECK_MEM_REGION_EXT_FIELD(field)					\
> > +do {											\
> > +	BUILD_BUG_ON(offsetof(struct kvm_user_mem_region, field) !=			\
> > +		     offsetof(struct kvm_userspace_memory_region_ext, field));		\
> > +	BUILD_BUG_ON(sizeof_field(struct kvm_user_mem_region, field) !=			\
> > +		     sizeof_field(struct kvm_userspace_memory_region_ext, field));	\
> > +} while (0)
> > +
> > +static void kvm_sanity_check_user_mem_region_alias(void)
> > +{
> > +	SANITY_CHECK_MEM_REGION_FIELD(slot);
> > +	SANITY_CHECK_MEM_REGION_FIELD(flags);
> > +	SANITY_CHECK_MEM_REGION_FIELD(guest_phys_addr);
> > +	SANITY_CHECK_MEM_REGION_FIELD(memory_size);
> > +	SANITY_CHECK_MEM_REGION_FIELD(userspace_addr);
> > +	SANITY_CHECK_MEM_REGION_EXT_FIELD(restricted_offset);
> > +	SANITY_CHECK_MEM_REGION_EXT_FIELD(restricted_fd);
> > +}
> 
> Do we have other examples in the kernel that jump these hoops?

grep -rn 'BUILD_BUG_ON(offsetof' can give you some hint on other usages
in the kernel. But for a quick check you can look:
  siginfo_buildtime_checks()

> 
> >  static long kvm_vm_ioctl(struct file *filp,
> >  			   unsigned int ioctl, unsigned long arg)
> >  {
> > @@ -4650,14 +4677,20 @@ static long kvm_vm_ioctl(struct file *filp,
> >  		break;
> >  	}
> >  	case KVM_SET_USER_MEMORY_REGION: {
> > -		struct kvm_userspace_memory_region kvm_userspace_mem;
> > +		struct kvm_user_mem_region mem;
> > +		unsigned long size = sizeof(struct kvm_userspace_memory_region);
> > +
> > +		kvm_sanity_check_user_mem_region_alias();
> >  
> >  		r = -EFAULT;
> > -		if (copy_from_user(&kvm_userspace_mem, argp,
> > -						sizeof(kvm_userspace_mem)))
> > +		if (copy_from_user(&mem, argp, size))
> > +			goto out;
> > +
> > +		r = -EINVAL;
> > +		if (mem.flags & KVM_MEM_PRIVATE)
> >  			goto out;
> 
> Hmm I can see in the later code you explicitly check for the
> KVM_MEM_PRIVATE flag with:
> 
> 		if (get_user(flags, (u32 __user *)(argp + flags_offset)))
> 			goto out;
> 
> 		if (flags & KVM_MEM_PRIVATE)
> 			size = sizeof(struct kvm_userspace_memory_region_ext);
> 		else
> 			size = sizeof(struct kvm_userspace_memory_region);
> 
> I think it would make sense to bring that sanity checking forward into
> this patch to avoid the validation logic working in two different ways
> over the series.

That is my original code actually, then Sean suggested to change to
current code[*], the reason is these two pathes are for different
purpose, this patch introduces the data structures but the later patch
actually makes use of the '_ext' variant.

[*] https://lkml.kernel.org/kvm/YuQ6QWcdZLdStkWl@google.com/

Chao
> 
> >  
> > -		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
> > +		r = kvm_vm_ioctl_set_memory_region(kvm, &mem);
> >  		break;
> >  	}
> >  	case KVM_GET_DIRTY_LOG: {
> 
> 
> -- 
> Alex Bennée
