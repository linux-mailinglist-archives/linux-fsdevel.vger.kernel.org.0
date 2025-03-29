Return-Path: <linux-fsdevel+bounces-45265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C00A755AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 11:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF72A3AF2B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 10:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570581B3927;
	Sat, 29 Mar 2025 10:08:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCE0DDBC;
	Sat, 29 Mar 2025 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743242886; cv=none; b=S6eD5rk3ZfaetI0Zf7to+KquVivJlr/A4G1wQHtLSXLsGIAUYshH+Vmmm2/544+yCwp+RTsZwTY9GyCQHTBkCQY2FVtXelcwOXSSDtRBalKePMCuYfaB1gcOh/Vd38Hwufd3xI8zYHa1xWeSABJ5kf1/7mEdhafSpsUfbpcTE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743242886; c=relaxed/simple;
	bh=geHv+XKbUv8yf942M+ooDuuafZKdJCTWjjk1ign4pLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hykEiUdA0PICqmaMTKSp5CxhAtha58/i1W6YgDP9Xp9Hw8dpgt0CXHIIECm2dJGpFGFmWaMAXWXmLGkABa9ZlgQ990dBnyEkQCZ7KN/nZyGl4dU6upNBoYBPUTAT4xC8/9C7xmMbNkkPv1E149C5Q9/SvPMGTOmINezedXX4fYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6505D152B;
	Sat, 29 Mar 2025 03:08:07 -0700 (PDT)
Received: from [10.57.87.112] (unknown [10.57.87.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BA713F694;
	Sat, 29 Mar 2025 03:08:01 -0700 (PDT)
Message-ID: <ee11907a-5bd7-44ec-844c-8f10ff406b46@arm.com>
Date: Sat, 29 Mar 2025 10:07:59 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/filemap: Allow arch to request folio size for exec
 memory
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Kalesh Singh <kaleshsingh@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250327160700.1147155-1-ryan.roberts@arm.com>
 <Z-WAbWfZzG1GA-4n@casper.infradead.org>
 <5131c7ad-cc37-44fc-8672-5866ecbef65b@arm.com>
 <Z-b1FmZ5nHzh5huL@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z-b1FmZ5nHzh5huL@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2025 15:14, Matthew Wilcox wrote:
> On Thu, Mar 27, 2025 at 04:23:14PM -0400, Ryan Roberts wrote:
>> + Kalesh
>>
>> On 27/03/2025 12:44, Matthew Wilcox wrote:
>>> On Thu, Mar 27, 2025 at 04:06:58PM +0000, Ryan Roberts wrote:
>>>> So let's special-case the read(ahead) logic for executable mappings. The
>>>> trade-off is performance improvement (due to more efficient storage of
>>>> the translations in iTLB) vs potential read amplification (due to
>>>> reading too much data around the fault which won't be used), and the
>>>> latter is independent of base page size. I've chosen 64K folio size for
>>>> arm64 which benefits both the 4K and 16K base page size configs and
>>>> shouldn't lead to any read amplification in practice since the old
>>>> read-around path was (usually) reading blocks of 128K. I don't
>>>> anticipate any write amplification because text is always RO.
>>>
>>> Is there not also the potential for wasted memory due to ELF alignment?
>>
>> I think this is an orthogonal issue? My change isn't making that any worse.
> 
> To a certain extent, it is.  If readahead was doing order-2 allocations
> before and is now doing order-4, you're tying up 0-12 extra pages which
> happen to be filled with zeroes due to being used to cache the contents
> of a hole.

Well we would still have read them in before, nothing has changed there. But I
guess your point is more about reclaim? Because those pages are now contained in
a larger folio, if part of the folio is in use then all of it remains active.
Whereas before, if the folio was fully contained in the pad area and never
accessed, it would fall down the LRU quickly and get reclaimed.

> 
>>> Kalesh talked about it in the MM BOF at the same time that Ted and I
>>> were discussing it in the FS BOF.  Some coordination required (like
>>> maybe Kalesh could have mentioned it to me rathere than assuming I'd be
>>> there?)
>>
>> I was at Kalesh's talk. David H suggested that a potential solution might be for
>> readahead to ask the fs where the next hole is and then truncate readahead to
>> avoid reading the hole. Given it's padding, nothing should directly fault it in
>> so it never ends up in the page cache. Not sure if you discussed anything like
>> that if you were talking in parallel?
> 
> Ted said that he and Kalesh had talked about that solution.  I have a
> more bold solution in mind which lifts the ext4 extent cache to the
> VFS inode so that the readahead code can interrogate it.
> 
>> Anyway, I'm not sure if you're suggesting these changes need to be considered as
>> one somehow or if you're just mentioning it given it is loosely related? My view
>> is that this change is an improvement indepently and could go in much sooner.
> 
> This is not a reason to delay this patch.  It's just a downside which
> should be mentioned in the commit message.

Fair point; I'll add a paragraph about the potential reclaim issue.

> 
>>>> +static inline int arch_exec_folio_order(void)
>>>> +{
>>>> +	return -1;
>>>> +}
>>>
>>> This feels a bit fragile.  I often expect to be able to store an order
>>> in an unsigned int.  Why not return 0 instead?
>>
>> Well 0 is a valid order, no? I think we have had the "is order signed or
>> unsigned" argument before. get_order() returns a signed int :)
> 
> But why not always return a valid order?  I don't think we need a
> sentinel.  The default value can be 0 to do what we do today.
> 

But a single order-0 folio is not what we do today. Note that my change as
currently implemented requests to read a *single* folio of the specified order.
And note that we only get the order we request to page_cache_ra_order() because
the size is limited to a single folio. If the size were bigger, that function
would actually expand the requested order by 2. (although the parameter is
called "new_order", it's actually interpretted as "old_order").

The current behavior is effectively to read 128K in order-2 folios (with smaller
folios for boundary alignment).

So I see a few options:

  - Continue to allow non-opted in arches to use the existing behaviour; in this
case we need a sentinel. This could be -1, UINT_MAX or 0. But in the latter case
you are preventing an opted-in arch from specifying that they want order-0 -
it's meaning is overridden.

  - Force all arches to use the new approach with a default folio order (and
readahead size) of order-0. (The default can be overridden per-arch). Personally
I'd be nervous about making this change.

  - Decouple the read size from the folio order size; continue to use the 128K
read size and only allow opting-in to a specific folio order. The default order
would be 2 (or 0). We would need to fix page_cache_async_ra() to call
page_cache_ra_order() with "order + 2" (the new order) and fix
page_cache_ra_order() to treat its order parameter as the *new* order.

Perhaps we should do those fixes anyway (and then actually start with a folio
order of 0 - which I think you said in the past was your original intention?).

Thanks,
Ryan


