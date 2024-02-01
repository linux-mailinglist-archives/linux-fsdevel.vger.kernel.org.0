Return-Path: <linux-fsdevel+bounces-9810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083FE845277
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4A91C25E3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26329159568;
	Thu,  1 Feb 2024 08:12:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11031586D3;
	Thu,  1 Feb 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775151; cv=none; b=e+tEzq9r2Q9+kbbb16auwBc1G1Dqi2dN4UteYbKU3Lzpz96Q+m6n8uf4ZLYYx5F2ALu+pJy3xPgBvh9cyuqbGeeutUh2jdi7LeX7Tk/UHmSKqJLemsynX4PnMjpLw4kpy6w1ElHOEyc7dF91/A65FYp/w1WIfOlgBQRuZiW+vo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775151; c=relaxed/simple;
	bh=XWgkDI5LEjWrVN67JCy6YWdGvZ06tRRPL0Okk7aKAww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcLyjfYzqndazkpj8lafKfk/Dn9ulQQR3dSFd5n1Aev8tbRQ11nstL/5rQGHTW79DbUFW/7G/kAnGsPpZTrCH5LjyfPl0a5lU3KocrkU4XmmCrjCO4O4GBCX3S3zNhSKKU9LVz5jTDTbvoA66x7yQhH4j6g7TB4OWnP3JoSjfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F301DA7;
	Thu,  1 Feb 2024 00:13:05 -0800 (PST)
Received: from [10.162.42.11] (a077893.blr.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8267D3F738;
	Thu,  1 Feb 2024 00:12:11 -0800 (PST)
Message-ID: <599769c3-0aef-4c5b-ac98-f109649862f7@arm.com>
Date: Thu, 1 Feb 2024 13:42:08 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 31/35] khugepaged: arm64: Don't collapse MTE
 enabled VMAs
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 mhiramat@kernel.org, rppt@kernel.org, hughd@google.com
Cc: pcc@google.com, steven.price@arm.com, vincenzo.frascino@arm.com,
 david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-32-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-32-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 22:12, Alexandru Elisei wrote:
> copy_user_highpage() will do memory allocation if there are saved tags for
> the destination page, and the page is missing tag storage.
> 
> After commit a349d72fd9ef ("mm/pgtable: add rcu_read_lock() and
> rcu_read_unlock()s"), collapse_huge_page() calls
> __collapse_huge_page_copy() -> .. -> copy_user_highpage() with the RCU lock
> held, which means that copy_user_highpage() can only allocate memory using
> GFP_ATOMIC or equivalent.
> 
> Get around this by refusing to collapse pages into a transparent huge page
> if the VMA is MTE-enabled.

Makes sense when copy_user_highpage() will allocate memory for tag storage.

> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> 
> Changes since rfc v2:
> 
> * New patch. I think an agreement on whether copy*_user_highpage() should be
> always allowed to sleep, or should not be allowed, would be useful.

This is a good question ! Even after preventing the collapse of MTE VMA here,
there still might be more paths where a sleeping (i.e memory allocating)
copy*_user_highpage() becomes problematic ?

> 
>  arch/arm64/include/asm/pgtable.h    | 3 +++
>  arch/arm64/kernel/mte_tag_storage.c | 5 +++++
>  include/linux/khugepaged.h          | 5 +++++
>  mm/khugepaged.c                     | 4 ++++
>  4 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 87ae59436162..d0473538c926 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1120,6 +1120,9 @@ static inline bool arch_alloc_cma(gfp_t gfp_mask)
>  	return true;
>  }
>  
> +bool arch_hugepage_vma_revalidate(struct vm_area_struct *vma, unsigned long address);
> +#define arch_hugepage_vma_revalidate arch_hugepage_vma_revalidate
> +
>  #endif /* CONFIG_ARM64_MTE_TAG_STORAGE */
>  #endif /* CONFIG_ARM64_MTE */
>  
> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> index ac7b9c9c585c..a99959b70573 100644
> --- a/arch/arm64/kernel/mte_tag_storage.c
> +++ b/arch/arm64/kernel/mte_tag_storage.c
> @@ -636,3 +636,8 @@ void arch_alloc_page(struct page *page, int order, gfp_t gfp)
>  	if (tag_storage_enabled() && alloc_requires_tag_storage(gfp))
>  		reserve_tag_storage(page, order, gfp);
>  }
> +
> +bool arch_hugepage_vma_revalidate(struct vm_area_struct *vma, unsigned long address)
> +{
> +	return !(vma->vm_flags & VM_MTE);
> +}
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index f68865e19b0b..461e4322dff2 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -38,6 +38,11 @@ static inline void khugepaged_exit(struct mm_struct *mm)
>  	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
>  		__khugepaged_exit(mm);
>  }
> +
> +#ifndef arch_hugepage_vma_revalidate
> +#define arch_hugepage_vma_revalidate(vma, address) 1

Please replace s/1/true as arch_hugepage_vma_revalidate() returns bool ?

> +#endif

Right, above construct is much better than __HAVE_ARCH_XXXX based one.

> +
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2b219acb528e..cb9a9ddb4d86 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -935,6 +935,10 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  	 */
>  	if (expect_anon && (!(*vmap)->anon_vma || !vma_is_anonymous(*vmap)))
>  		return SCAN_PAGE_ANON;
> +
> +	if (!arch_hugepage_vma_revalidate(vma, address))
> +		return SCAN_VMA_CHECK;
> +
>  	return SCAN_SUCCEED;
>  }
>  

Otherwise this LGTM.

