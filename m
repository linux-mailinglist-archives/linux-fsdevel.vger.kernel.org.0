Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9333675EA9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 06:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGXEpx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 00:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXEpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:45:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157E31B6;
        Sun, 23 Jul 2023 21:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690173950; x=1721709950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q9qzwcL7N7viHeki30qyeMCUuWnJ87fuGcM4hbUg7Mg=;
  b=NtpaCJWf6JJa6XKHuLRhKK7pFYUMMQofEh2yTs7d9WA3ZIjgFpTCtoO8
   Edq8KDCrQHBYbTHzNoEKucA3E/6cCWGpY+/cHVV3MX4ik/jHgQCEORqb7
   wSvC3eAiwOb9mxxDhb2CFyIoMeZLOYM/+LtMn7OQ5nxM9W4wZ/sPTI1tK
   rK2afDRyd8OL3KOXO4edKYiz4plKbrPXt9jP806iSOeAifT4wf4mrQrJT
   P+1iFE9zVghp6PjgfNxT1AKG3HPWrObiD8mhr5u8bIAStC5OxIqIhqmVJ
   9oPghZ7iu+7LX+G8RepHnjlob953+e312EqqjRnbgQpH2pS+GLieZdvYo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="352240346"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="352240346"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 21:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="972119310"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="972119310"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2023 21:45:40 -0700
Date:   Mon, 24 Jul 2023 12:43:53 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v11 08/29] KVM: Introduce per-page memory attributes
Message-ID: <ZL4BiQWihfrD0TOJ@yilunxu-OptiPlex-7050>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-9-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718234512.1690985-9-seanjc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-18 at 16:44:51 -0700, Sean Christopherson wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> In confidential computing usages, whether a page is private or shared is
> necessary information for KVM to perform operations like page fault
> handling, page zapping etc. There are other potential use cases for
> per-page memory attributes, e.g. to make memory read-only (or no-exec,
> or exec-only, etc.) without having to modify memslots.
> 
> Introduce two ioctls (advertised by KVM_CAP_MEMORY_ATTRIBUTES) to allow
> userspace to operate on the per-page memory attributes.
>   - KVM_SET_MEMORY_ATTRIBUTES to set the per-page memory attributes to
>     a guest memory range.
>   - KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to return the KVM supported
>     memory attributes.
> 
> Use an xarray to store the per-page attributes internally, with a naive,
> not fully optimized implementation, i.e. prioritize correctness over
> performance for the initial implementation.
> 
> Because setting memory attributes is roughly analogous to mprotect() on
> memory that is mapped into the guest, zap existing mappings prior to
> updating the memory attributes.  Opportunistically provide an arch hook
> for the post-set path (needed to complete invalidation anyways) in
> anticipation of x86 needing the hook to update metadata related to
> determining whether or not a given gfn can be backed with various sizes
> of hugepages.
> 
> It's possible that future usages may not require an invalidation, e.g.
> if KVM ends up supporting RWX protections and userspace grants _more_
> protections, but again opt for simplicity and punt optimizations to
> if/when they are needed.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com
> Cc: Fuad Tabba <tabba@google.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  Documentation/virt/kvm/api.rst |  60 ++++++++++++
>  include/linux/kvm_host.h       |  14 +++
>  include/uapi/linux/kvm.h       |  14 +++
>  virt/kvm/Kconfig               |   4 +
>  virt/kvm/kvm_main.c            | 170 +++++++++++++++++++++++++++++++++
>  5 files changed, 262 insertions(+)
>

Only some trivial concerns below.

[...]
 
> @@ -1175,6 +1176,9 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
>  	spin_lock_init(&kvm->mn_invalidate_lock);
>  	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
>  	xa_init(&kvm->vcpu_array);
> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +	xa_init(&kvm->mem_attr_array);
> +#endif
>  
>  	INIT_LIST_HEAD(&kvm->gpc_list);
>  	spin_lock_init(&kvm->gpc_lock);
> @@ -1346,6 +1350,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
>  		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
>  	}
> +#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
> +	xa_destroy(&kvm->mem_attr_array);
> +#endif

Is it better to make the destruction in reverse order from the creation?
To put xa_destroy(&kvm->mem_attr_array) after cleanup_srcu_struct(&kvm->srcu),
or put xa_init(&kvm->mem_attr_array) after init_srcu_struct(&kvm->irq_srcu).

>  	cleanup_srcu_struct(&kvm->irq_srcu);
>  	cleanup_srcu_struct(&kvm->srcu);
>  	kvm_arch_free_vm(kvm);
> @@ -2346,6 +2353,145 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  }
>  #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */

[...]

> +static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> +					   struct kvm_memory_attributes *attrs)
> +{
> +	gfn_t start, end;
> +
> +	/* flags is currently not used. */
> +	if (attrs->flags)
> +		return -EINVAL;
> +	if (attrs->attributes & ~kvm_supported_mem_attributes(kvm))
> +		return -EINVAL;
> +	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
> +		return -EINVAL;
> +	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
> +		return -EINVAL;
> +
> +	start = attrs->address >> PAGE_SHIFT;
> +	end = (attrs->address + attrs->size - 1 + PAGE_SIZE) >> PAGE_SHIFT;

As the attrs->address/size are both garanteed to be non-zero, non-wrap
and page aligned in prevous check. Is it OK to simplify the calculation,
like:

  end = (attrs->address + attrs->size) >> PAGE_SHIFT;

> +
> +	if (WARN_ON_ONCE(start == end))
> +		return -EINVAL;

Also, is this check possible to be hit? Maybe remove it?

Thanks,
Yilun

> +
> +	/*
> +	 * xarray tracks data using "unsigned long", and as a result so does
> +	 * KVM.  For simplicity, supports generic attributes only on 64-bit
> +	 * architectures.
> +	 */
> +	BUILD_BUG_ON(sizeof(attrs->attributes) != sizeof(unsigned long));
> +
> +	return kvm_vm_set_mem_attributes(kvm, attrs->attributes, start, end);
> +}
> +#endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
