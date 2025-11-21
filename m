Return-Path: <linux-fsdevel+bounces-69364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D49A4C77E91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 09:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC2CB4E8DA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375D33ADBE;
	Fri, 21 Nov 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deqqUwZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4AE339B47;
	Fri, 21 Nov 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713461; cv=none; b=TQazoxQdPKmjOYPXQXC8XJ01APiB8tD0ZSUYQW//pzKNrE53DWM+XV+denHDI+YNBPZCTEnk30EO3cLkPmaF4Qsez2c4TCzjZyg31P8nBriaMGstl/Glzx3OB32h+MaDQSaC/BaOe7M3VMysin0vCs0iTtq4sYzNxsJnxRTbGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713461; c=relaxed/simple;
	bh=r3iepQmIuL44wttg1FVL5hu3fjV2x+1BvBfuMfW5rDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8iuUkRhSHcs7TVs5eBk0q5whGwoORg8D9hKm5y/x0RlPpvyeuUp9nHvU8ZhclrgmG0UhQaHcp8wxDEfw4f2Pap7gDn4dPPaQ8m0IK75p97vMQmrqlu5PXxBpheZqkBPIaT0igO9ocoT0k/ViAIP3rB1QXFprnBX27z8R4bIdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deqqUwZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6434C116D0;
	Fri, 21 Nov 2025 08:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763713461;
	bh=r3iepQmIuL44wttg1FVL5hu3fjV2x+1BvBfuMfW5rDw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=deqqUwZdo4qrzs+eFKEe58bB+MT11bEJSEOK0dfHAlBZnzcri2JrQdRU27PyC2fc5
	 W1afd92FJEC7KtpPjXQQJmEDpp8oCUXxPXqpTMNYaiJ9ybFaVerfE6RkO0ocjjFhm2
	 MFRdQoIhdyYRDeVs9Z4ZMSztl47aMEzVeYO2FbaE/UPBO2fb5RSdTJZYKQrzMBU0wb
	 u5ktjYYcNXuuJq+by6wYzrOq9WkKbgqVCib66wpEJR6lViut3C8Gd7y177agjhpL3V
	 5fcWrkD/hAGt7dfWtvvKQ5EsH6+S+2zVmADloCMqbYwAO3QxA0KFkX8cGChiX6/SBr
	 fKGYhc2+ktUPA==
Message-ID: <9910c06a-f613-4c1a-b30b-ad8ad2d75c08@kernel.org>
Date: Fri, 21 Nov 2025 09:24:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
To: David Laight <david.laight.linux@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Christoph Lameter
 <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yuanchu Xie <yuanchu@google.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-40-david.laight.linux@gmail.com>
 <0c264126-b7ff-4509-93a6-582d928769ea@lucifer.local>
 <20251120125505.7ec8dfc6@pumpkin>
 <e06666bf-6d19-4ed7-a870-012dff1fe077@kernel.org>
 <20251120154405.7bcf9a6e@pumpkin>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251120154405.7bcf9a6e@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 16:44, David Laight wrote:
> On Thu, 20 Nov 2025 14:42:24 +0100
> "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
> 
>>>>   
>>>>>
>>>>> Signed-off-by: David Laight <david.laight.linux@gmail.com>
>>>>> ---
>>>>>    mm/gup.c      | 4 ++--
>>>>>    mm/memblock.c | 2 +-
>>>>>    mm/memory.c   | 2 +-
>>>>>    mm/percpu.c   | 2 +-
>>>>>    mm/truncate.c | 3 +--
>>>>>    mm/vmscan.c   | 2 +-
>>>>>    6 files changed, 7 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>> index a8ba5112e4d0..55435b90dcc3 100644
>>>>> --- a/mm/gup.c
>>>>> +++ b/mm/gup.c
>>>>> @@ -237,8 +237,8 @@ static inline struct folio *gup_folio_range_next(struct page *start,
>>>>>    	unsigned int nr = 1;
>>>>>
>>>>>    	if (folio_test_large(folio))
>>>>> -		nr = min_t(unsigned int, npages - i,
>>>>> -			   folio_nr_pages(folio) - folio_page_idx(folio, next));
>>>>> +		nr = min(npages - i,
>>>>> +			 folio_nr_pages(folio) - folio_page_idx(folio, next));
>>>>
>>>> There's no cases where any of these would discard significant bits. But we
>>>> ultimately cast to unisnged int anyway (nr) so not sure this achieves anything.
>>>
>>> The (implicit) cast to unsigned int is irrelevant - that happens after the min().
>>> The issue is that 'npages' is 'unsigned long' so can (in theory) be larger than 4G.
>>> Ok that would be a 16TB buffer, but someone must have decided that npages might
>>> not fit in 32 bits otherwise they wouldn't have used 'unsigned long'.
>>
>> See commit fa17bcd5f65e ("mm: make folio page count functions return
>> unsigned") why that function used to return "long" instead of "unsigned
>> int" and how we changed it to "unsigned long".
>>
>> Until that function actually returns something that large might take a
>> while, so no need to worry about that right now.
> 
> Except that it gives a false positive on a compile-time test that finds a
> few real bugs.
> 
> I've been (slowly) fixing 'allmodconfig' and found 'goodies' like:
> 	min_t(u32, MAX_UINT, expr)
> and
> 	min_t(u8, expr, 255)
> 

:)

> Pretty much all the min_t(unsigned xxx) that compile when changed to min()
> are safe changes and might fix an obscure bug.
> Probably 99% make no difference.
> 
> So I'd like to get rid of the ones that make no difference.

No objection from my side if using min() is the preferred way now and 
introduces no observable changes.

-- 
Cheers

David

