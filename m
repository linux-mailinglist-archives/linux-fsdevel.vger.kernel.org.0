Return-Path: <linux-fsdevel+bounces-10768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C5284DF1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 12:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281791F215FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16C47317B;
	Thu,  8 Feb 2024 10:57:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5926EB6D;
	Thu,  8 Feb 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389848; cv=none; b=luhTubdb7m+zHgWEVA9meQNT6dtGdlQ9El+q+QVBu1d/1aj8tsWOitygnbrICVNn5KeC0dEz4tvaqHMv41X3uLrWokpXZlwFUEjQv/8Lwkcs9jkxHytDjruehlx35g8g8V3aXFm9Amox5xrFDlln3LuRv4S0tMSMxNVAcnHhOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389848; c=relaxed/simple;
	bh=F0AD35zRkzPDFFqGLNrXClBOwbPZXXqj2AyKsqqb3P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jz09XQ1ARDdkKlRzJoOdCcg9DVALgA1kBpZIzU00ZUhy3LGGhoX6p3Yuivl4W232CeSE0teKfeWkIxYYNcHvwhN3EF3p8HDop6C34RswFIPicSPiRFPL/u8WNxXCwl6AJhzO51ow+3PIt8wmjHOn0Ra7xjSd7+7wDRjUX8laE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99EB01FB;
	Thu,  8 Feb 2024 02:58:07 -0800 (PST)
Received: from [10.57.10.153] (unknown [10.57.10.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D64DA3F762;
	Thu,  8 Feb 2024 02:57:22 -0800 (PST)
Message-ID: <761a3982-c7a1-40f1-92d8-5c08dad8383a@arm.com>
Date: Thu, 8 Feb 2024 10:57:21 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC gmem v1 3/8] KVM: x86: Add gmem hook for initializing
 memory
Content-Language: en-GB
To: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org
Cc: linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 isaku.yamahata@intel.com, ackerleytng@google.com, vbabka@suse.cz,
 ashish.kalra@amd.com, nikunj.dadhania@amd.com, jroedel@suse.de,
 pankaj.gupta@amd.com
References: <20231016115028.996656-1-michael.roth@amd.com>
 <20231016115028.996656-4-michael.roth@amd.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231016115028.996656-4-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 16/10/2023 12:50, Michael Roth wrote:
> guest_memfd pages are generally expected to be in some arch-defined
> initial state prior to using them for guest memory. For SEV-SNP this
> initial state is 'private', or 'guest-owned', and requires additional
> operations to move these pages into a 'private' state by updating the
> corresponding entries the RMP table.
> 
> Allow for an arch-defined hook to handle updates of this sort, and go
> ahead and implement one for x86 so KVM implementations like AMD SVM can
> register a kvm_x86_ops callback to handle these updates for SEV-SNP
> guests.
> 
> The preparation callback is always called when allocating/grabbing
> folios via gmem, and it is up to the architecture to keep track of
> whether or not the pages are already in the expected state (e.g. the RMP
> table in the case of SEV-SNP).
> 
> In some cases, it is necessary to defer the preparation of the pages to
> handle things like in-place encryption of initial guest memory payloads
> before marking these pages as 'private'/'guest-owned', so also add a
> helper that performs the same function as kvm_gmem_get_pfn(), but allows
> for the preparation callback to be bypassed to allow for pages to be
> accessed beforehand.

This will be useful for Arm CCA, where the pages need to be moved into
"Realm state". Some minor comments below.

> 
> Link: https://lore.kernel.org/lkml/ZLqVdvsF11Ddo7Dq@google.com/
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   arch/x86/include/asm/kvm-x86-ops.h |  1 +
>   arch/x86/include/asm/kvm_host.h    |  2 ++
>   arch/x86/kvm/x86.c                 |  6 ++++
>   include/linux/kvm_host.h           | 14 ++++++++
>   virt/kvm/Kconfig                   |  4 +++
>   virt/kvm/guest_memfd.c             | 56 +++++++++++++++++++++++++++---
>   6 files changed, 78 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index e3054e3e46d5..0c113f42d5c7 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -134,6 +134,7 @@ KVM_X86_OP(msr_filter_changed)
>   KVM_X86_OP(complete_emulated_msr)
>   KVM_X86_OP(vcpu_deliver_sipi_vector)
>   KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
> +KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>   
>   #undef KVM_X86_OP
>   #undef KVM_X86_OP_OPTIONAL
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 95018cc653f5..66fc89d1858f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1752,6 +1752,8 @@ struct kvm_x86_ops {
>   	 * Returns vCPU specific APICv inhibit reasons
>   	 */
>   	unsigned long (*vcpu_get_apicv_inhibit_reasons)(struct kvm_vcpu *vcpu);
> +
> +	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>   };
>   
>   struct kvm_x86_nested_ops {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 767236b4d771..33a4cc33d86d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13301,6 +13301,12 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
>   }
>   EXPORT_SYMBOL_GPL(kvm_arch_no_poll);
>   
> +#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
> +int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
> +{
> +	return static_call(kvm_x86_gmem_prepare)(kvm, pfn, gfn, max_order);
> +}
> +#endif
>   
>   int kvm_spec_ctrl_test_value(u64 value)
>   {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 8c5c017ab4e9..c7f82c2f1bcf 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2403,9 +2403,19 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>   #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
>   
>   #ifdef CONFIG_KVM_PRIVATE_MEM
> +int __kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> +		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prep);
>   int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>   			      gfn_t gfn, kvm_pfn_t *pfn, int *max_order);
>   #else
> +static inline int __kvm_gmem_get_pfn(struct kvm *kvm,
> +				     struct kvm_memory_slot *slot, gfn_t gfn,
> +				     kvm_pfn_t *pfn, int *max_order)

Missing "bool prep" here ?

minor nit: Do we need to export both __kvm_gmem_get_pfn and 
kvm_gmem_get_pfn ? I don't see anyone else using the former.

We could have :

#ifdef CONFIG_KVM_PRIVATE_MEM
int __kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prep);
#else
static inline int __kvm_gmem_get_pfn(struct kvm *kvm,
				    struct kvm_memory_slot *slot, gfn_t gfn,
				    kvm_pfn_t *pfn, int *max_order,
				    bool prep)
{
	KVM_BUG_ON(1, kvm);
	return -EIO;
}
#endif

static inline int kvm_gmem_get_pfn(struct kvm *kvm,
				 struct kvm_memory_slot *slot, gfn_t gfn,
				kvm_pfn_t *pfn, int *max_order)
{
	return __kvm_gmem_get_pfn(kvm, slot, gfn, pfn, max_order, true);
}


Suzuki

> +	KVM_BUG_ON(1, kvm);
> +	return -EIO;
> +}
> +
>   static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>   				   struct kvm_memory_slot *slot, gfn_t gfn,
>   				   kvm_pfn_t *pfn, int *max_order)
> @@ -2415,4 +2425,8 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>   }
>   #endif /* CONFIG_KVM_PRIVATE_MEM */
>   
> +#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
> +int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
> +#endif
> +
>   #endif
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 2c964586aa14..992cf6ed86ef 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -109,3 +109,7 @@ config KVM_GENERIC_PRIVATE_MEM
>          select KVM_GENERIC_MEMORY_ATTRIBUTES
>          select KVM_PRIVATE_MEM
>          bool
> +
> +config HAVE_KVM_GMEM_PREPARE
> +       bool
> +       depends on KVM_PRIVATE_MEM
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index f6f1b17a319c..72ff8b7b31d5 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -44,7 +44,40 @@ static struct folio *kvm_gmem_get_huge_folio(struct inode *inode, pgoff_t index)
>   #endif
>   }
>   
> -static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
> +static int kvm_gmem_prepare_folio(struct inode *inode, pgoff_t index, struct folio *folio)
> +{
> +#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
> +	struct list_head *gmem_list = &inode->i_mapping->private_list;
> +	struct kvm_gmem *gmem;
> +
> +	list_for_each_entry(gmem, gmem_list, entry) {
> +		struct kvm_memory_slot *slot;
> +		struct kvm *kvm = gmem->kvm;
> +		struct page *page;
> +		kvm_pfn_t pfn;
> +		gfn_t gfn;
> +		int rc;
> +
> +		slot = xa_load(&gmem->bindings, index);
> +		if (!slot)
> +			continue;
> +
> +		page = folio_file_page(folio, index);
> +		pfn = page_to_pfn(page);
> +		gfn = slot->base_gfn + index - slot->gmem.pgoff;
> +		rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, compound_order(compound_head(page)));
> +		if (rc) {
> +			pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx, error %d.\n",
> +					    index, rc);
> +			return rc;
> +		}
> +	}
> +
> +#endif
> +	return 0;
> +}
> +
> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool prep)
>   {
>   	struct folio *folio;
>   
> @@ -74,6 +107,12 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>   		folio_mark_uptodate(folio);
>   	}
>   
> +	if (prep && kvm_gmem_prepare_folio(inode, index, folio)) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		return NULL;
> +	}
> +
>   	/*
>   	 * Ignore accessed, referenced, and dirty flags.  The memory is
>   	 * unevictable and there is no storage to write back to.
> @@ -178,7 +217,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>   			break;
>   		}
>   
> -		folio = kvm_gmem_get_folio(inode, index);
> +		folio = kvm_gmem_get_folio(inode, index, true);
>   		if (!folio) {
>   			r = -ENOMEM;
>   			break;
> @@ -537,8 +576,8 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
>   	fput(file);
>   }
>   
> -int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> -		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
> +int __kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> +		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prep)
>   {
>   	pgoff_t index, huge_index;
>   	struct kvm_gmem *gmem;
> @@ -559,7 +598,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>   		goto out_fput;
>   	}
>   
> -	folio = kvm_gmem_get_folio(file_inode(file), index);
> +	folio = kvm_gmem_get_folio(file_inode(file), index, prep);
>   	if (!folio) {
>   		r = -ENOMEM;
>   		goto out_fput;
> @@ -600,4 +639,11 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>   
>   	return r;
>   }
> +EXPORT_SYMBOL_GPL(__kvm_gmem_get_pfn);
> +
> +int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> +		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
> +{
> +	return __kvm_gmem_get_pfn(kvm, slot, gfn, pfn, max_order, true);
> +} >   EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);


