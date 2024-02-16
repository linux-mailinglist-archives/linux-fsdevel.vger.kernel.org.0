Return-Path: <linux-fsdevel+bounces-11842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FBB857ACC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 11:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F9E281F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E5955E56;
	Fri, 16 Feb 2024 10:59:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C31EA73;
	Fri, 16 Feb 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081172; cv=none; b=lFUBoD5EaMQYkhAry51liSdOp+RQYkDoNCebkz+iXWASRHBjaeNsMndMsq9ZOZ+Kt5j5GFejo9VO2LOsNw9isdKP3Bn+YFHBCVJX+psbetzDApYqOKieV6hfP39vcNUaV5M2R9zH5Q6w8NAUsPX8ooUZphNktCVY1QYGqBHk8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081172; c=relaxed/simple;
	bh=uLoh1fA7+KxUZ+aSmp5HZ3rjZuo+r7L8js30YHxUnWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtjouBDR/ZP/fBjZSsrEIyJknDwexOYYvHJJxvYuM6akS6ORqw23irD5aLmjqsuKS5L5x4KyRsRidNxZ6sXez/xZwPKnXOjk+V9H2Dxg5efoQsMKBZxRH/avwyN3mLKZkpDiyT3n1biaRVBuOfctb6VEyU253NLVP0R5Jz867AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 910E11FB;
	Fri, 16 Feb 2024 03:00:09 -0800 (PST)
Received: from [192.168.68.110] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2F263F766;
	Fri, 16 Feb 2024 02:59:26 -0800 (PST)
Message-ID: <af3a7c1f-f054-47b8-b257-d11e877631e9@arm.com>
Date: Fri, 16 Feb 2024 10:59:25 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/filemap: Allow arch to request folio size for exec
 memory
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240215154059.2863126-1-ryan.roberts@arm.com>
 <20240215144849.aba06863acc08b8ded09a187@linux-foundation.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240215144849.aba06863acc08b8ded09a187@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 22:48, Andrew Morton wrote:
> On Thu, 15 Feb 2024 15:40:59 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> Change the readahead config so that if it is being requested for an
>> executable mapping, do a synchronous read of an arch-specified size in a
>> naturally aligned manner.
> 
> Some nits:

Thanks for taking a look, Andrew!

> 
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -1115,6 +1115,18 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
>>   */
>>  #define arch_wants_old_prefaulted_pte	cpu_has_hw_af
>>
>> +/*
>> + * Request exec memory is read into pagecache in at least 64K folios. The
>> + * trade-off here is performance improvement due to storing translations more
>> + * effciently in the iTLB vs the potential for read amplification due to reading
> 
> "efficiently"

ACK; will fix if there is a v3

> 
>> + * data from disk that won't be used. The latter is independent of base page
>> + * size, so we set a page-size independent block size of 64K. This size can be
>> + * contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB entry),
>> + * and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base pages are in
>> + * use.
>> + */
>> +#define arch_wants_exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
>> +
> 
> To my eye, "arch_wants_foo" and "arch_want_foo" are booleans.  Either
> this arch wants a particular treatment or it does not want it.
> 
> I suggest a better name would be "arch_exec_folio_order".

ACK; will fix if there is a v3

> 
>>  static inline bool pud_sect_supported(void)
>>  {
>>  	return PAGE_SIZE == SZ_4K;
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index aab227e12493..6cdd145cbbb9 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -407,6 +407,18 @@ static inline bool arch_has_hw_pte_young(void)
>>  }
>>  #endif
>>
>> +#ifndef arch_wants_exec_folio_order
>> +/*
>> + * Returns preferred minimum folio order for executable file-backed memory. Must
>> + * be in range [0, PMD_ORDER]. Negative value implies that the HW has no
>> + * preference and mm will not special-case executable memory in the pagecache.
>> + */
> 
> I think this comment contains material which would be useful above the
> other arch_wants_exec_folio_order() implementation - the "must be in
> range" part.  So I suggest all this material be incorporated into a
> single comment which describes arch_wants_exec_folio_order().  Then
> this comment can be removed entirely.  Assume the reader knows to go
> seek the other definition for the commentary.

Hmm... The approach I've been taking for other arch-overridable helpers is to
put the API spec against the default implementation (i.e. here) then put
comments about the specific implementation against the override. If anything I
would prefer to formalize this comment into proper doc header comment and leave
it here (see for example set_ptes(), and in recent patches now in mm-unstable;
get_and_clear_full_ptes(), wrprotect_ptes(), etc).

I'll move all of this to the arm64 code if you really think that's the right
approach, but that's not my personal preference.

Thanks,
Ryan

> 
>> +static inline int arch_wants_exec_folio_order(void)
>> +{
>> +	return -1;
>> +}
>> +#endif
>> +
>>  #ifndef arch_check_zapped_pte
>>  static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
>>  					 pte_t pte)
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 142864338ca4..7954274de11c 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3118,6 +3118,25 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>>  	}
>>  #endif
>>
>> +	/*
>> +	 * Allow arch to request a preferred minimum folio order for executable
>> +	 * memory. This can often be beneficial to performance if (e.g.) arm64
>> +	 * can contpte-map the folio. Executable memory rarely benefits from
>> +	 * read-ahead anyway, due to its random access nature.
> 
> "readahead"
> 
>> +	 */
>> +	if (vm_flags & VM_EXEC) {
>> +		int order = arch_wants_exec_folio_order();
>> +
>> +		if (order >= 0) {
>> +			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>> +			ra->size = 1UL << order;
>> +			ra->async_size = 0;
>> +			ractl._index &= ~((unsigned long)ra->size - 1);
>> +			page_cache_ra_order(&ractl, ra, order);
>> +			return fpin;
>> +		}
>> +	}
>> +
>>  	/* If we don't want any read-ahead, don't bother */
>>  	if (vm_flags & VM_RAND_READ)
>>  		return fpin;
> 


