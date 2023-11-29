Return-Path: <linux-fsdevel+bounces-4199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2737FD993
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 15:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681152825E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233C23219A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5742EA8;
	Wed, 29 Nov 2023 05:33:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D4522F4;
	Wed, 29 Nov 2023 05:34:32 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A2BB3F5A1;
	Wed, 29 Nov 2023 05:33:40 -0800 (PST)
Date: Wed, 29 Nov 2023 13:33:37 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 16/27] arm64: mte: Manage tag storage on page
 allocation
Message-ID: <ZWc9sVTCHTBcp2Z2@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <CGME20231119165906epcas2p4c6691d274bec428329b193b99119a8d1@epcas2p4.samsung.com>
 <20231119165721.9849-17-alexandru.elisei@arm.com>
 <20231129091040.GC2988384@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129091040.GC2988384@tiffany>

Hi,

On Wed, Nov 29, 2023 at 06:10:40PM +0900, Hyesoo Yu wrote:
> On Sun, Nov 19, 2023 at 04:57:10PM +0000, Alexandru Elisei wrote:
> > [..]
> > +static int order_to_num_blocks(int order)
> > +{
> > +	return max((1 << order) / 32, 1);
> > +}
> > [..]
> > +int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
> > +{
> > +	unsigned long start_block, end_block;
> > +	struct tag_region *region;
> > +	unsigned long block;
> > +	unsigned long flags;
> > +	unsigned int tries;
> > +	int ret = 0;
> > +
> > +	VM_WARN_ON_ONCE(!preemptible());
> > +
> > +	if (page_tag_storage_reserved(page))
> > +		return 0;
> > +
> > +	/*
> > +	 * __alloc_contig_migrate_range() ignores gfp when allocating the
> > +	 * destination page for migration. Regardless, massage gfp flags and
> > +	 * remove __GFP_TAGGED to avoid recursion in case gfp stops being
> > +	 * ignored.
> > +	 */
> > +	gfp &= ~__GFP_TAGGED;
> > +	if (!(gfp & __GFP_NORETRY))
> > +		gfp |= __GFP_RETRY_MAYFAIL;
> > +
> > +	ret = tag_storage_find_block(page, &start_block, &region);
> > +	if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", page_to_pfn(page)))
> > +		return 0;
> > +	end_block = start_block + order_to_num_blocks(order) * region->block_size;
> > +
> 
> Hello.
> 
> If the page size is 4K,  block size is 2 (block size bytes 8K), and order is 6,
> then we need 2 pages for the tag. However according to the equation, order_to_num_blocks
> is 2 and block_size is also 2, so end block will be incremented by 4.
> 
> However we actually only need 8K of tag, right for 256K ?
> Could you explain order_to_num_blocks * region->block_size more detail ?

I think you are correct, thank you for pointing it out. The formula should
probably be something like:

static int order_to_num_blocks(int order, u32 block_size)
{
	int num_tag_pages = max((1 << order) / 32, 1);

	return DIV_ROUND_UP(num_tag_pages, block_size);
}

and that will make end_block = start_block + 2 in your scenario.

Does that look correct to you?

Thanks,
Alex

> 
> Thanks,
> Regards.
> 
> > +	mutex_lock(&tag_blocks_lock);
> > +
> > +	/* Check again, this time with the lock held. */
> > +	if (page_tag_storage_reserved(page))
> > +		goto out_unlock;
> > +
> > +	/* Make sure existing entries are not freed from out under out feet. */
> > +	xa_lock_irqsave(&tag_blocks_reserved, flags);
> > +	for (block = start_block; block < end_block; block += region->block_size) {
> > +		if (tag_storage_block_is_reserved(block))
> > +			block_ref_add(block, region, order);
> > +	}
> > +	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> > +
> > +	for (block = start_block; block < end_block; block += region->block_size) {
> > +		/* Refcount incremented above. */
> > +		if (tag_storage_block_is_reserved(block))
> > +			continue;
> > +
> > +		tries = 3;
> > +		while (tries--) {
> > +			ret = alloc_contig_range(block, block + region->block_size, MIGRATE_CMA, gfp);
> > +			if (ret == 0 || ret != -EBUSY)
> > +				break;
> > +		}
> > +
> > +		if (ret)
> > +			goto out_error;
> > +
> > +		ret = tag_storage_reserve_block(block, region, order);
> > +		if (ret) {
> > +			free_contig_range(block, region->block_size);
> > +			goto out_error;
> > +		}
> > +
> > +		count_vm_events(CMA_ALLOC_SUCCESS, region->block_size);
> > +	}
> > +
> > +	page_set_tag_storage_reserved(page, order);
> > +out_unlock:
> > +	mutex_unlock(&tag_blocks_lock);
> > +
> > +	return 0;
> > +
> > +out_error:
> > +	xa_lock_irqsave(&tag_blocks_reserved, flags);
> > +	for (block = start_block; block < end_block; block += region->block_size) {
> > +		if (tag_storage_block_is_reserved(block) &&
> > +		    block_ref_sub_return(block, region, order) == 1) {
> > +			__xa_erase(&tag_blocks_reserved, block);
> > +			free_contig_range(block, region->block_size);
> > +		}
> > +	}
> > +	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> > +
> > +	mutex_unlock(&tag_blocks_lock);
> > +
> > +	count_vm_events(CMA_ALLOC_FAIL, region->block_size);
> > +
> > +	return ret;
> > +}
> > +
> > +void free_tag_storage(struct page *page, int order)
> > +{
> > +	unsigned long block, start_block, end_block;
> > +	struct tag_region *region;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	ret = tag_storage_find_block(page, &start_block, &region);
> > +	if (WARN_ONCE(ret, "Missing tag storage block for pfn 0x%lx", page_to_pfn(page)))
> > +		return;
> > +
> > +	end_block = start_block + order_to_num_blocks(order) * region->block_size;
> > +
> > +	xa_lock_irqsave(&tag_blocks_reserved, flags);
> > +	for (block = start_block; block < end_block; block += region->block_size) {
> > +		if (WARN_ONCE(!tag_storage_block_is_reserved(block),
> > +		    "Block 0x%lx is not reserved for pfn 0x%lx", block, page_to_pfn(page)))
> > +			continue;
> > +
> > +		if (block_ref_sub_return(block, region, order) == 1) {
> > +			__xa_erase(&tag_blocks_reserved, block);
> > +			free_contig_range(block, region->block_size);
> > +		}
> > +	}
> > +	xa_unlock_irqrestore(&tag_blocks_reserved, flags);
> > +}
> > diff --git a/fs/proc/page.c b/fs/proc/page.c
> > index 195b077c0fac..e7eb584a9234 100644
> > --- a/fs/proc/page.c
> > +++ b/fs/proc/page.c
> > @@ -221,6 +221,7 @@ u64 stable_page_flags(struct page *page)
> >  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
> >  	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> >  	u |= kpf_copy_bit(k, KPF_ARCH_3,	PG_arch_3);
> > +	u |= kpf_copy_bit(k, KPF_ARCH_4,	PG_arch_4);
> >  #endif
> >  
> >  	return u;
> > diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
> > index 859f4b0c1b2b..4a0d719ffdd4 100644
> > --- a/include/linux/kernel-page-flags.h
> > +++ b/include/linux/kernel-page-flags.h
> > @@ -19,5 +19,6 @@
> >  #define KPF_SOFTDIRTY		40
> >  #define KPF_ARCH_2		41
> >  #define KPF_ARCH_3		42
> > +#define KPF_ARCH_4		43
> >  
> >  #endif /* LINUX_KERNEL_PAGE_FLAGS_H */
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index a88e64acebfe..7915165a51bd 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -135,6 +135,7 @@ enum pageflags {
> >  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
> >  	PG_arch_2,
> >  	PG_arch_3,
> > +	PG_arch_4,
> >  #endif
> >  	__NR_PAGEFLAGS,
> >  
> > diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> > index 6ca0d5ed46c0..ba962fd10a2c 100644
> > --- a/include/trace/events/mmflags.h
> > +++ b/include/trace/events/mmflags.h
> > @@ -125,7 +125,8 @@ IF_HAVE_PG_HWPOISON(hwpoison)						\
> >  IF_HAVE_PG_IDLE(idle)							\
> >  IF_HAVE_PG_IDLE(young)							\
> >  IF_HAVE_PG_ARCH_X(arch_2)						\
> > -IF_HAVE_PG_ARCH_X(arch_3)
> > +IF_HAVE_PG_ARCH_X(arch_3)						\
> > +IF_HAVE_PG_ARCH_X(arch_4)
> >  
> >  #define show_page_flags(flags)						\
> >  	(flags) ? __print_flags(flags, "|",				\
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index f31f02472396..9beead961a65 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2474,6 +2474,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
> >  #ifdef CONFIG_ARCH_USES_PG_ARCH_X
> >  			 (1L << PG_arch_2) |
> >  			 (1L << PG_arch_3) |
> > +			 (1L << PG_arch_4) |
> >  #endif
> >  			 (1L << PG_dirty) |
> >  			 LRU_GEN_MASK | LRU_REFS_MASK));
> > -- 
> > 2.42.1
> > 
> > 



