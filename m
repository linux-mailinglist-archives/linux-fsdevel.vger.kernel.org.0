Return-Path: <linux-fsdevel+bounces-10899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC5484F2F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B701C287313
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03762692FF;
	Fri,  9 Feb 2024 10:11:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11167E8A;
	Fri,  9 Feb 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473502; cv=none; b=cgCAp7LMlXR4Vc8cjfmMw8QGHoPm1HApeVJ0l3K4BOoxYyrJqkZLXXdiXL12n0hH64+v4LHjStyRI0btUAhOOHC/+CMciuPX4b8CEn4l6RMjiedN4K/hgDncJOPi7TgryPyyJurNYP6c0pGJkSZqAa0Bi0Jo9krGI3CK1K7A0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473502; c=relaxed/simple;
	bh=sJ+o92d/lwk1g9oSwisR/d0SlJfcelUCjwmiemb5sy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li/Z+NMcDh1qtOEXGLzwQuAv03OzPQwyVQOvh2tWae0SaiTi8d51j8qWYYkwydGSOKza+1V0JebFxGi5n5dDQuBDOThgSOHQxsag0l2eIDatonweTH1Whe38jnn5ikSFmTM9fLPIQf1/JO0yxMFzART0TNZgg4qnbmblGPKGFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9739BDA7;
	Fri,  9 Feb 2024 02:12:20 -0800 (PST)
Received: from [10.1.37.16] (e122027.cambridge.arm.com [10.1.37.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16773F5A1;
	Fri,  9 Feb 2024 02:11:34 -0800 (PST)
Message-ID: <e7125fcb-52b1-4942-9ae7-c85049e92e5c@arm.com>
Date: Fri, 9 Feb 2024 10:11:32 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC gmem v1 4/8] KVM: x86: Add gmem hook for invalidating
 memory
To: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 "tabba@google.com" <tabba@google.com>
Cc: linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
 isaku.yamahata@intel.com, ackerleytng@google.com, vbabka@suse.cz,
 ashish.kalra@amd.com, nikunj.dadhania@amd.com, jroedel@suse.de,
 pankaj.gupta@amd.com
References: <20231016115028.996656-1-michael.roth@amd.com>
 <20231016115028.996656-5-michael.roth@amd.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20231016115028.996656-5-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2023 12:50, Michael Roth wrote:
> In some cases, like with SEV-SNP, guest memory needs to be updated in a
> platform-specific manner before it can be safely freed back to the host.
> Wire up arch-defined hooks to the .free_folio kvm_gmem_aops callback to
> allow for special handling of this sort when freeing memory in response
> to FALLOC_FL_PUNCH_HOLE operations and when releasing the inode, and go
> ahead and define an arch-specific hook for x86 since it will be needed
> for handling memory used for SEV-SNP guests.

Hi all,

Arm CCA has a similar need to prepare/unprepare memory (granule
delegate/undelegate using our terminology) before it is used for
protected memory.

However I see a problem with the current gmem implementation that the
"invalidations" are not precise enough for our RMI API. When punching a
hole in the memfd the code currently hits the same path (ending in
kvm_unmap_gfn_range()) as if a VMA is modified in the same range (for
the shared version). The Arm CCA architecture doesn't allow the
protected memory to be removed and refaulted without the permission of
the guest (the memory contents would be wiped in this case).

One option that I've considered is to implement a seperate CCA ioctl to
notify KVM whether the memory should be mapped protected. The
invalidations would then be ignored on ranges that are currently
protected for this guest.

This 'solves' the problem nicely except for the case where the VMM
deliberately punches holes in memory which the guest is using.

The issue in this case is that there's no way of failing the punch hole
operation - we can detect that the memory is in use and shouldn't be
freed, but this callback doesn't give the opportunity to actually block
the freeing of the memory.

Sadly there's no easy way to map from a physical page in a gmem back to
which VM (and where in the VM) the page is mapped. So actually ripping
the page out of the appropriate VM isn't really possible in this case.

How is this situation handled on x86? Is it possible to invalidate and
then refault a protected page without affecting the memory contents? My
guess is yes and that is a CCA specific problem - is my understanding
correct?

My current thoughts for CCA are one of three options:

1. Represent shared and protected memory as two separate memslots. This
matches the underlying architecture more closely (the top address bit is
repurposed as a 'shared' flag), but I don't like it because it's a
deviation from other CoCo architectures (notably pKVM).

2. Allow punch-hole to fail on CCA if the memory is mapped into the
guest's protected space. Again, this is CCA being different and also
creates nasty corner cases where the gmem descriptor could have to
outlive the VMM - so looks like a potential source of memory leaks.

3. 'Fix' the invalidation to provide more precise semantics. I haven't
yet prototyped it but it might be possible to simply provide a flag from
kvm_gmem_invalidate_begin specifying that the invalidation is for the
protected memory. KVM would then only unmap the protected memory when
this flag is set (avoiding issues with VMA updates causing spurious unmaps).

Fairly obviously (3) is my preferred option, but it relies on the
guarantees that the "invalidation" is actually a precise set of
addresses where the memory is actually being freed.

Comments, thoughts, objections welcome!

Steve

> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  1 +
>  arch/x86/include/asm/kvm_host.h    |  1 +
>  arch/x86/kvm/x86.c                 |  7 +++++++
>  include/linux/kvm_host.h           |  4 ++++
>  virt/kvm/Kconfig                   |  4 ++++
>  virt/kvm/guest_memfd.c             | 14 ++++++++++++++
>  6 files changed, 31 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 0c113f42d5c7..f1505a5fa781 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -135,6 +135,7 @@ KVM_X86_OP(complete_emulated_msr)
>  KVM_X86_OP(vcpu_deliver_sipi_vector)
>  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
> +KVM_X86_OP_OPTIONAL(gmem_invalidate)
>  
>  #undef KVM_X86_OP
>  #undef KVM_X86_OP_OPTIONAL
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 66fc89d1858f..dbec74783f48 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1754,6 +1754,7 @@ struct kvm_x86_ops {
>  	unsigned long (*vcpu_get_apicv_inhibit_reasons)(struct kvm_vcpu *vcpu);
>  
>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> +	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>  };
>  
>  struct kvm_x86_nested_ops {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 33a4cc33d86d..0e95c3a95e59 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13308,6 +13308,13 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>  }
>  #endif
>  
> +#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
> +void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> +{
> +	static_call_cond(kvm_x86_gmem_invalidate)(start, end);
> +}
> +#endif
> +
>  int kvm_spec_ctrl_test_value(u64 value)
>  {
>  	/*
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c7f82c2f1bcf..840a5be5962a 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2429,4 +2429,8 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
>  int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
>  #endif
>  
> +#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
> +void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
> +#endif
> +
>  #endif
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 992cf6ed86ef..7fd1362a7ebe 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -113,3 +113,7 @@ config KVM_GENERIC_PRIVATE_MEM
>  config HAVE_KVM_GMEM_PREPARE
>         bool
>         depends on KVM_PRIVATE_MEM
> +
> +config HAVE_KVM_GMEM_INVALIDATE
> +       bool
> +       depends on KVM_PRIVATE_MEM
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 72ff8b7b31d5..b4c4df259fb8 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -369,12 +369,26 @@ static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
>  	return MF_DELAYED;
>  }
>  
> +#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
> +static void kvm_gmem_free_folio(struct folio *folio)
> +{
> +	struct page *page = folio_page(folio, 0);
> +	kvm_pfn_t pfn = page_to_pfn(page);
> +	int order = folio_order(folio);
> +
> +	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> +}
> +#endif
> +
>  static const struct address_space_operations kvm_gmem_aops = {
>  	.dirty_folio = noop_dirty_folio,
>  #ifdef CONFIG_MIGRATION
>  	.migrate_folio	= kvm_gmem_migrate_folio,
>  #endif
>  	.error_remove_page = kvm_gmem_error_page,
> +#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
> +	.free_folio = kvm_gmem_free_folio,
> +#endif
>  };
>  
>  static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *path,


