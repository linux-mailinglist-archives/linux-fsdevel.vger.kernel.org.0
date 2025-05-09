Return-Path: <linux-fsdevel+bounces-48604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B34AB152B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8CF7B4723
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B129188C;
	Fri,  9 May 2025 13:30:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A828F528;
	Fri,  9 May 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797431; cv=none; b=nrNj6b/JEtbZ6xoHas4vzZwBmI4DR0AulPFRlfStsOFZ/j6S8pcfUo6bsP1lYFAHEd939mbf9R9/+vjFv815ZLtOj9uWrZNKpbedMxTp4bOyJUQ790coOghA+kfqLxRwl3lwNsAZUkxgj3mO3ZOLJKr5/9bSdOR4GrYerXihEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797431; c=relaxed/simple;
	bh=6DCqltFURM6kY0sDNWpiBkzcIsJ2ZZizFmYSaZG2D+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqqmP1AgIhrfDQXbmcGvAzvXDDSPsCL6pFPb74np38nBOPD2VKFxIGRia7uGZ1+jwNLBOvWSefSNLe5Xmw3OuaRFDOBvzsI2eYyJcUdhovMeOxx3hFuhl48iMoxCKvw80mpWWCb1oWP/me1pWLsqRCbEfs+f4jhUB2GklqIb9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C665D175D;
	Fri,  9 May 2025 06:30:17 -0700 (PDT)
Received: from [10.57.90.222] (unknown [10.57.90.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CA773F58B;
	Fri,  9 May 2025 06:30:26 -0700 (PDT)
Message-ID: <22e4167a-6ed0-4bda-86b8-a11c984f0a71@arm.com>
Date: Fri, 9 May 2025 14:30:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/5] mm/readahead: Honour new_order in
 page_cache_ra_order()
Content-Language: en-GB
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-2-ryan.roberts@arm.com>
 <nepi5e74wtghvr6a6n26rdgqaa7tzitylyoamfnzoqu6s5gq4h@zqtve2irigd6>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <nepi5e74wtghvr6a6n26rdgqaa7tzitylyoamfnzoqu6s5gq4h@zqtve2irigd6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Pankaj,

Thanks for the review! ...


On 08/05/2025 13:55, Pankaj Raghav (Samsung) wrote:
> Hey Ryan,
> 
> On Wed, Apr 30, 2025 at 03:59:14PM +0100, Ryan Roberts wrote:
>> FOLIO  0x0001a000  0x0001b000       4096       26       27      1      0
>> FOLIO  0x0001b000  0x0001c000       4096       27       28      1      0
>> FOLIO  0x0001c000  0x0001d000       4096       28       29      1      0
>> FOLIO  0x0001d000  0x0001e000       4096       29       30      1      0
>> FOLIO  0x0001e000  0x0001f000       4096       30       31      1      0
>> FOLIO  0x0001f000  0x00020000       4096       31       32      1      0
>> FOLIO  0x00020000  0x00024000      16384       32       36      4      2
>> FOLIO  0x00024000  0x00028000      16384       36       40      4      2
>> FOLIO  0x00028000  0x0002c000      16384       40       44      4      2
>> FOLIO  0x0002c000  0x00030000      16384       44       48      4      2
>> ...
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/readahead.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/mm/readahead.c b/mm/readahead.c
>> index 6a4e96b69702..8bb316f5a842 100644
>> --- a/mm/readahead.c
>> +++ b/mm/readahead.c
>> @@ -479,9 +479,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
>>  
> 
> So we always had a fallback to do_page_cache_ra() if the size of the
> readahead is less than 4 pages (16k). I think this was there because we
> were adding `2` to the new_order:

If this is the reason for the magic number 4, then it's a bug in itself IMHO. 4
pages is only 16K when the page size is 4K; arm64 supports other page sizes. But
additionally, it's not just ra->size that dictates the final order of the folio;
it also depends on alignment in the file, EOF, etc.

If we remove the fallback condition completely, things will still work out. So
unless someone can explain the reason for that condition (Matthew?), my vote
would be to remove it entirely.

> 
> unsigned int min_ra_size = max(4, mapping_min_folio_nrpages(mapping));
> 
> /*
>  * Fallback when size < min_nrpages as each folio should be
>  * at least min_nrpages anyway.
>  */
> if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size)
> 	goto fallback;
> 
>>  	limit = min(limit, index + ra->size - 1);
>>  
>> -	if (new_order < mapping_max_folio_order(mapping))
>> -		new_order += 2;
> 
> Now that you have moved this, we could make the lhs of the max to be 2
> (8k) instead of 4(16k).

I don't really understand why magic number 2 would now be correct?

> 
> - unsigned int min_ra_size = max(4, mapping_min_folio_nrpages(mapping));
> + unsigned int min_ra_size = max(2, mapping_min_folio_nrpages(mapping));
> 
> I think if we do that, we might ramp up to 8k sooner rather than jumping
> from 4k to 16k directly?

In practice I don't think so; This would only give us order-1 where we didn't
have it before if new_order >= 1 and ra->size is 3 or 4 pages.

But as I said, my vote would be to remove this fallback condition entirely. What
do you think?

Thanks,
Ryan

> 
>> -
>>  	new_order = min(mapping_max_folio_order(mapping), new_order);
>>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>>  	new_order = max(new_order, min_order);
>> @@ -683,6 +680,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
>>  	ra->size = get_next_ra_size(ra, max_pages);
>>  	ra->async_size = ra->size;
>>  readit:
>> +	order += 2;
>>  	ractl->_index = ra->start;
>>  	page_cache_ra_order(ractl, ra, order);
>>  }
>> -- 
>> 2.43.0
>>
> 
> --
> Pankaj


