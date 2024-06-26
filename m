Return-Path: <linux-fsdevel+bounces-22480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D818917AD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 10:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D391C21DDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF531166304;
	Wed, 26 Jun 2024 08:24:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A413B78F;
	Wed, 26 Jun 2024 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390248; cv=none; b=UpcFEgz7mU5BKtHNNsvRs5xWOCFZxtSXSVJLzgOhzC76MO7nfV3ads6o92+gInqEvYSfHqTb7CBH5lPK+ROGtG13IkAdHcnpBxlU7BcuJ+FuUZxg0Lpe+rvl4mrcPEjhwVyHapWI/EXoa8zjuk3O85wk0Veu5xf+vhIwix7oiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390248; c=relaxed/simple;
	bh=zrtO+oHwabHOiLzEO4R1ux9fryKlfAw9TrMbRa0tlXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHl/HAtFC0euYBPyskElwUn41IUZ+kOzb3rA7ScS/1I0ZMNSaDCHG7ARzwNu3QPmQdN+CDkjmmDItJsU4UM1Fg1qk4nwcNzr67zG5JXCs9kZOU4rJEJbBEikhBZMfGOR9JcydLtB8CoWR++BFcKv6w8iWaCthJD+IKwjP92HWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FDE9339;
	Wed, 26 Jun 2024 01:24:29 -0700 (PDT)
Received: from [10.57.73.149] (unknown [10.57.73.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 438303F766;
	Wed, 26 Jun 2024 01:24:02 -0700 (PDT)
Message-ID: <44750ae2-eb47-42aa-80f9-2660c1a3676a@arm.com>
Date: Wed, 26 Jun 2024 09:24:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm/shmem: Disable PMD-sized page cache if needed
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Gavin Shan <gshan@redhat.com>,
 linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
 hughd@google.com, torvalds@linux-foundation.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625090646.1194644-5-gshan@redhat.com>
 <f14a1ff2-6c25-4cf7-abf7-1428e62272b0@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f14a1ff2-6c25-4cf7-abf7-1428e62272b0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/06/2024 19:50, David Hildenbrand wrote:
> On 25.06.24 11:06, Gavin Shan wrote:
>> For shmem files, it's possible that PMD-sized page cache can't be
>> supported by xarray. For example, 512MB page cache on ARM64 when
>> the base page size is 64KB can't be supported by xarray. It leads
>> to errors as the following messages indicate when this sort of xarray
>> entry is split.
>>
>> WARNING: CPU: 34 PID: 7578 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
>> Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6   \
>> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject        \
>> nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4  \
>> ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm fuse xfs  \
>> libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_net \
>> net_failover virtio_console virtio_blk failover dimlib virtio_mmio
>> CPU: 34 PID: 7578 Comm: test Kdump: loaded Tainted: G W 6.10.0-rc5-gavin+ #9
>> Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
>> pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>> pc : xas_split_alloc+0xf8/0x128
>> lr : split_huge_page_to_list_to_order+0x1c4/0x720
>> sp : ffff8000882af5f0
>> x29: ffff8000882af5f0 x28: ffff8000882af650 x27: ffff8000882af768
>> x26: 0000000000000cc0 x25: 000000000000000d x24: ffff00010625b858
>> x23: ffff8000882af650 x22: ffffffdfc0900000 x21: 0000000000000000
>> x20: 0000000000000000 x19: ffffffdfc0900000 x18: 0000000000000000
>> x17: 0000000000000000 x16: 0000018000000000 x15: 52f8004000000000
>> x14: 0000e00000000000 x13: 0000000000002000 x12: 0000000000000020
>> x11: 52f8000000000000 x10: 52f8e1c0ffff6000 x9 : ffffbeb9619a681c
>> x8 : 0000000000000003 x7 : 0000000000000000 x6 : ffff00010b02ddb0
>> x5 : ffffbeb96395e378 x4 : 0000000000000000 x3 : 0000000000000cc0
>> x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
>> Call trace:
>>   xas_split_alloc+0xf8/0x128
>>   split_huge_page_to_list_to_order+0x1c4/0x720
>>   truncate_inode_partial_folio+0xdc/0x160
>>   shmem_undo_range+0x2bc/0x6a8
>>   shmem_fallocate+0x134/0x430
>>   vfs_fallocate+0x124/0x2e8
>>   ksys_fallocate+0x4c/0xa0
>>   __arm64_sys_fallocate+0x24/0x38
>>   invoke_syscall.constprop.0+0x7c/0xd8
>>   do_el0_svc+0xb4/0xd0
>>   el0_svc+0x44/0x1d8
>>   el0t_64_sync_handler+0x134/0x150
>>   el0t_64_sync+0x17c/0x180
>>
>> Fix it by disabling PMD-sized page cache when HPAGE_PMD_ORDER is
>> larger than MAX_PAGECACHE_ORDER.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   mm/shmem.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index a8b181a63402..5453875e3810 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -541,8 +541,9 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>>     static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>>   -bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
>> -           struct mm_struct *mm, unsigned long vm_flags)
>> +static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
>> +                bool shmem_huge_force, struct mm_struct *mm,
>> +                unsigned long vm_flags)
>>   {
>>       loff_t i_size;
>>   @@ -573,6 +574,16 @@ bool shmem_is_huge(struct inode *inode, pgoff_t index,
>> bool shmem_huge_force,
>>       }
>>   }
>>   +bool shmem_is_huge(struct inode *inode, pgoff_t index,
>> +           bool shmem_huge_force, struct mm_struct *mm,
>> +           unsigned long vm_flags)
>> +{
>> +    if (!__shmem_is_huge(inode, index, shmem_huge_force, mm, vm_flags))
>> +        return false;
>> +
>> +    return HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER;

Sorry I don't have the context of the original post, but this seems odd to me,
given that MAX_PAGECACHE_ORDER is defined as HPAGE_PMD_ORDER (unless you changed
this in an earlier patch in the series?)

at least v6.10-rc4 has:

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
#else
#define MAX_PAGECACHE_ORDER	8
#endif

> 
> Why not check for that upfront?
> 
>> +}
>> +
>>   #if defined(CONFIG_SYSFS)
>>   static int shmem_parse_huge(const char *str)
>>   {
> 
> This should make __thp_vma_allowable_orders() happy for shmem, and consequently,
> also khugepaged IIRC.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> 
> @Ryan,
> 
> should we do something like the following on top? The use of PUD_ORDER for
> ordinary pagecache is
> wrong. Really only DAX is special and can support that in its own weird ways.

I'll take your word for that. If correct, then I agree we should change this.
Note that arm64 doesn't support PUD THP mappings at all.

> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2aa986a5cd1b..ac63233fed6c 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -72,14 +72,25 @@ extern struct kobj_attribute shmem_enabled_attr;
>  #define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>  
>  /*
> - * Mask of all large folio orders supported for file THP.
> + * Mask of all large folio orders supported for FSDAX THP.
>   */
> -#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
> +#define THP_ORDERS_ALL_DAX     (BIT(PMD_ORDER) | BIT(PUD_ORDER))
> +
> +
> +/*
> + * Mask of all large folio orders supported for ordinary pagecache (file/shmem)
> + * THP.
> + */
> +#if PMD_ORDER <= MAX_PAGECACHE_ORDER

Shouldn't this be ">="? (assuming MAX_PAGECACHE_ORDER is now defined
independently of PMD_ORDER, as per above).

Although Gavin's commit log only mentions shmem as being a problem with really
big PMD. Is it also a problem for regular files?

> +#define THP_ORDERS_ALL_FILE    0
> +#else
> +#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER))
> +#endif
>  
>  /*
>   * Mask of all large folio orders supported for THP.
>   */
> -#define THP_ORDERS_ALL         (THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
> +#define THP_ORDERS_ALL         (THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE )

And I think this needs to include THP_ORDERS_ALL_DAX so that THPeligible in
show_smap() continues to work for DAX VMAs?

>  
>  #define TVA_SMAPS              (1 << 0)        /* Will be used for procfs */
>  #define TVA_IN_PF              (1 << 1)        /* Page fault handler */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 89932fd0f62e..95d4a2edae39 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -88,9 +88,15 @@ unsigned long __thp_vma_allowable_orders(struct
> vm_area_struct *vma,
>         bool smaps = tva_flags & TVA_SMAPS;
>         bool in_pf = tva_flags & TVA_IN_PF;
>         bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
> +
>         /* Check the intersection of requested and supported orders. */
> -       orders &= vma_is_anonymous(vma) ?
> -                       THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
> +       if (vma_is_anonymous(vma))
> +               orders &= THP_ORDERS_ALL_ANON;
> +       else if (vma_is_dax(vma))
> +               orders &= THP_ORDERS_ALL_DAX;
> +       else
> +               orders &= THP_ORDERS_ALL_FILE;
> +
>         if (!orders)
>                 return 0;
>  
> 
> 
> 


