Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00C44EB3D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbiC2TDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 15:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiC2TDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:03:42 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E62E1250
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 12:01:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t4so12543305pgc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2XeIM1SVjYsGalPDLQxopalWmUCHnrUjVEEJ+tulJdw=;
        b=fkATFbG5P1QdsRl3f5I5TTNI5ChWdFQqj0PejuKROxLUJnUOxzgKe+W4LhC5IZAI4H
         YtsmX3rK45fXNWubfbpZPqb9DnxrrAbfux1L4qkhlnrcAasThinipJ2Q3eV/AR/L8pQY
         cRcROodkTR03YOK9g3nobLnLQ905Gk1gr+g/5/aOMWcSLRh80tKrndhIfqqoN+N3vRsS
         DIOkXafKz0QlgKRKQ9CcqexPq7225Bm1SKVztp6KtFJXqZwd53geDw7ldIZ4DNNPAqx+
         3sIDGdLWnk5KF2cMv6hxUP0l3WPVCea9ErtR4WnbKShs+t9nnnof7J9xgjZLKizrsTPW
         Bp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2XeIM1SVjYsGalPDLQxopalWmUCHnrUjVEEJ+tulJdw=;
        b=P0CjfBA5bqctzuNQma0znG2wkLtDWkx1PBHr7Z+FBAFRamIez4ZuGWbrqkyG0qzC/c
         30k4VITJmK7U5pObdF5WFhYiTq5mMczgKYkFHplz8r2tWFhrZBY9Z5//mjWnm3sRhWK4
         QWd2Z2RR/2wGgGcKmVS1WWnLm5sXPQTlgMBOOWKC+mfBIrxNnIQC7yocaldVvjJTQCkY
         NMY0EIYKdpI44fagzfHGqksUOVCCLwVwG6Ux5KkRRhcCs82OTNPcNmqGUyYIUIC2WAgn
         v453ciHncZ9McqELU5AXwsxHdCg2XMar3ZYuSxluwwoEGpk5nplKjyPt+4kMnjBGpmkA
         u/bw==
X-Gm-Message-State: AOAM532IFNBt8k12CRTnMO8M9BhyT35F378ZSz1DIIMhpRMkQVvf9xLB
        rVG7yV8a6rhgFT7b9p8GzYwnoQ==
X-Google-Smtp-Source: ABdhPJzEpA97rJvGQuEnxLNNeV8mQMFbR/iU9G4YS04U64x9rSctBZQKrTxpUvsX+m2/3qlD8psMvg==
X-Received: by 2002:a63:7888:0:b0:398:91:7b5e with SMTP id t130-20020a637888000000b0039800917b5emr3047768pgc.212.1648580517007;
        Tue, 29 Mar 2022 12:01:57 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id ip1-20020a17090b314100b001c7b10fe359sm3975575pjb.5.2022.03.29.12.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 12:01:55 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:01:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
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
Message-ID: <YkNXoCBjfpfI67QF@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-11-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-11-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022, Chao Peng wrote:
> Add 'notifier' to memslot to make it a memfile_notifier node and then
> register it to memory backing store via memfile_register_notifier() when
> memslot gets created. When memslot is deleted, do the reverse with
> memfile_unregister_notifier(). Note each KVM memslot can be registered
> to different memory backing stores (or the same backing store but at
> different offset) independently.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/kvm_host.h |  1 +
>  virt/kvm/kvm_main.c      | 75 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 70 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6e1d770d6bf8..9b175aeca63f 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -567,6 +567,7 @@ struct kvm_memory_slot {
>  	struct file *private_file;
>  	loff_t private_offset;
>  	struct memfile_pfn_ops *pfn_ops;
> +	struct memfile_notifier notifier;
>  };
>  
>  static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d11a2628b548..67349421eae3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -840,6 +840,37 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>  
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>  
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +static inline int kvm_memfile_register(struct kvm_memory_slot *slot)

This is a good oppurtunity to hide away the memfile details a bit.  Maybe
kvm_private_mem_{,un}register()?

> +{
> +	return memfile_register_notifier(file_inode(slot->private_file),
> +					 &slot->notifier,
> +					 &slot->pfn_ops);
> +}
> +
> +static inline void kvm_memfile_unregister(struct kvm_memory_slot *slot)
> +{
> +	if (slot->private_file) {
> +		memfile_unregister_notifier(file_inode(slot->private_file),
> +					    &slot->notifier);
> +		fput(slot->private_file);

This should not do fput(), it makes the helper imbalanced with respect to the
register path and will likely lead to double fput().  Indeed, if preparing the
region fails, __kvm_set_memory_region() will double up on fput() due to checking
its local "file" for null, not slot->private for null.

> +		slot->private_file = NULL;
> +	}
> +}
> +
> +#else /* !CONFIG_MEMFILE_NOTIFIER */
> +
> +static inline int kvm_memfile_register(struct kvm_memory_slot *slot)
> +{

This should WARN_ON_ONCE().  Ditto for unregister.

> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void kvm_memfile_unregister(struct kvm_memory_slot *slot)
> +{
> +}
> +
> +#endif /* CONFIG_MEMFILE_NOTIFIER */
> +
>  #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
>  static int kvm_pm_notifier_call(struct notifier_block *bl,
>  				unsigned long state,
> @@ -884,6 +915,9 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
>  /* This does not remove the slot from struct kvm_memslots data structures */
>  static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
>  {
> +	if (slot->flags & KVM_MEM_PRIVATE)
> +		kvm_memfile_unregister(slot);

With fput() move out of unregister, this needs to be:

	if (slot->flags & KVM_MEM_PRIVATE) {
		kvm_private_mem_unregister(slot);
		fput(slot->private_file);
	}
> +
>  	kvm_destroy_dirty_bitmap(slot);
>  
>  	kvm_arch_free_memslot(kvm, slot);
> @@ -1738,6 +1772,12 @@ static int kvm_set_memslot(struct kvm *kvm,
>  		kvm_invalidate_memslot(kvm, old, invalid_slot);
>  	}
>  
> +	if (new->flags & KVM_MEM_PRIVATE && change == KVM_MR_CREATE) {
> +		r = kvm_memfile_register(new);
> +		if (r)
> +			return r;
> +	}

This belongs in kvm_prepare_memory_region().  The shenanigans for DELETE and MOVE
are special.

> +
>  	r = kvm_prepare_memory_region(kvm, old, new, change);
>  	if (r) {
>  		/*
> @@ -1752,6 +1792,10 @@ static int kvm_set_memslot(struct kvm *kvm,
>  		} else {
>  			mutex_unlock(&kvm->slots_arch_lock);
>  		}
> +
> +		if (new->flags & KVM_MEM_PRIVATE && change == KVM_MR_CREATE)
> +			kvm_memfile_unregister(new);
> +
>  		return r;
>  	}
>  
> @@ -1817,6 +1861,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  	enum kvm_mr_change change;
>  	unsigned long npages;
>  	gfn_t base_gfn;
> +	struct file *file = NULL;

Nit, naming this private_file would help understand its use.  Though I think it's
easier to not have a local variable.  More below.

>  	int as_id, id;
>  	int r;
>  
> @@ -1890,14 +1935,24 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  			return 0;
>  	}
>  
> +	if (mem->flags & KVM_MEM_PRIVATE) {
> +		file = fdget(region_ext->private_fd).file;

This can use fget() instead of fdget().

> +		if (!file)
> +			return -EINVAL;
> +	}
> +
>  	if ((change == KVM_MR_CREATE || change == KVM_MR_MOVE) &&
> -	    kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages))
> -		return -EEXIST;
> +	    kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages)) {
> +		r = -EEXIST;
> +		goto out;
> +	}
>  
>  	/* Allocate a slot that will persist in the memslot. */
>  	new = kzalloc(sizeof(*new), GFP_KERNEL_ACCOUNT);
> -	if (!new)
> -		return -ENOMEM;
> +	if (!new) {
> +		r = -ENOMEM;
> +		goto out;
> +	}
>  
>  	new->as_id = as_id;
>  	new->id = id;
> @@ -1905,10 +1960,18 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  	new->npages = npages;
>  	new->flags = mem->flags;
>  	new->userspace_addr = mem->userspace_addr;
> +	new->private_file = file;
> +	new->private_offset = mem->flags & KVM_MEM_PRIVATE ?
> +			      region_ext->private_offset : 0;

"new" is zero-allocated, so all the private stuff, including the fget(), can be
wrapped in a single KVM_MEM_PRIVATE check.  Moving fget() eliminates the number
of gotos needed (the above -EEXIST and -ENOMEM paths don't need to be modified).

>  	r = kvm_set_memslot(kvm, old, new, change);
> -	if (r)
> -		kfree(new);
> +	if (!r)
> +		return r;

Use goto, e.g.

	if (r)
		goto out;

	return 0;

Burying the happy path in a taken if-statement is confusing and error prone,
mostly because it breaks well-established kernel patterns.  Note, there's no need
for a separate out_free since new->private_file will be NULL in either case.  I
don't have a strong preference, I just find it easier to read code that's more
explicit, but I'm a-ok collapsing them into a single label.

	if ((change == KVM_MR_CREATE || change == KVM_MR_MOVE) &&
	    kvm_check_memslot_overlap(slots, id, base_gfn, base_gfn + npages))
		return -EEXIST;

	/* Allocate a slot that will persist in the memslot. */
	new = kzalloc(sizeof(*new), GFP_KERNEL_ACCOUNT);
	if (!new)
		return -ENOMEM;

	new->as_id = as_id;
	new->id = id;
	new->base_gfn = base_gfn;
	new->npages = npages;
	new->flags = mem->flags;
	new->userspace_addr = mem->userspace_addr;

	if (mem->flags & KVM_MEM_PRIVATE) {
		new->private_file = fget(mem->private_fd);
		if (!new->private_file) {
			r = -EINVAL;
			goto out_free;
		}
		new->private_offset = mem->private_offset;
	}

	r = kvm_set_memslot(kvm, old, new, change);
	if (r)
		goto out;

	return 0;

out:
	if (new->private_file)
		fput(new->private_file);

out_free:
	kfree(new);
	return r;
