Return-Path: <linux-fsdevel+bounces-69228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8509C745E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 14:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D983C32C55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C24341072;
	Thu, 20 Nov 2025 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3rtIRyF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C00340A76;
	Thu, 20 Nov 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646150; cv=none; b=c/r70we/sqC6AuV+C5a73qyJnTPV8KmP9K8bq6Qon90eGMmEZeo7T+Hl2zPIrEzdVlO8GOc3TOet60yCfK3i7jora8gka3g9DwVCnSfLC+f7kHFOWDI2xLbsR0jkY9Zd2x7s383+OdWhkQda//xQYNLZu/fNpfFEgkquSNwV7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646150; c=relaxed/simple;
	bh=Ht1OIK/aZGwiLrXboc7wimNOH1Dr30vWNH61iqtkHFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qM4Gg40gg1p0rbYkCBHp8o123q7YEpD7n4YHQu1HPrzOkvhxvWk/nvZJyPpVdic1kTScf9TYEvH0TvQ+nvYsoDLp3HPdeOiPjpq+IPBsYS4zX3RQVDu260WPGOf+HPauTQEJPkr5iNofm0G+Au13bcZ7F9g2WiRvgRxP4qvjV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3rtIRyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14026C4CEF1;
	Thu, 20 Nov 2025 13:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763646150;
	bh=Ht1OIK/aZGwiLrXboc7wimNOH1Dr30vWNH61iqtkHFo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K3rtIRyFY5JuIVHZJScwFQEdOsxo4+WVC17Jgy5iyfDYh51Dnc6qWfB3+Z2p0x2Pc
	 oEnBSdvoeVKyaVlrSk7FgwNjKZJfl0hWn22itFLBFE3yxZtm9nByrhhrTWWNxQvEOt
	 mKRJMafCuiiEAjaqje8pVbI1aDOegIRC8QX0SuvzxPnIMiiqkZfG+6wm0a5INqxHBL
	 K4oZe/c0DFh8etEw85g+lIsF76/TcryeoTLtsTJj5pNC4ASwD1ZQq0GHrRqadVTOvo
	 qHWkjtoFAla14tWGK4jVgwFFpHBaiFES25MkgV49IvxHoPSBVxWWcEn7EMGebVbcdu
	 po6wOXnw9m4IQ==
Message-ID: <e06666bf-6d19-4ed7-a870-012dff1fe077@kernel.org>
Date: Thu, 20 Nov 2025 14:42:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
To: David Laight <david.laight.linux@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251120125505.7ec8dfc6@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>>>
>>> Signed-off-by: David Laight <david.laight.linux@gmail.com>
>>> ---
>>>   mm/gup.c      | 4 ++--
>>>   mm/memblock.c | 2 +-
>>>   mm/memory.c   | 2 +-
>>>   mm/percpu.c   | 2 +-
>>>   mm/truncate.c | 3 +--
>>>   mm/vmscan.c   | 2 +-
>>>   6 files changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index a8ba5112e4d0..55435b90dcc3 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -237,8 +237,8 @@ static inline struct folio *gup_folio_range_next(struct page *start,
>>>   	unsigned int nr = 1;
>>>
>>>   	if (folio_test_large(folio))
>>> -		nr = min_t(unsigned int, npages - i,
>>> -			   folio_nr_pages(folio) - folio_page_idx(folio, next));
>>> +		nr = min(npages - i,
>>> +			 folio_nr_pages(folio) - folio_page_idx(folio, next));
>>
>> There's no cases where any of these would discard significant bits. But we
>> ultimately cast to unisnged int anyway (nr) so not sure this achieves anything.
> 
> The (implicit) cast to unsigned int is irrelevant - that happens after the min().
> The issue is that 'npages' is 'unsigned long' so can (in theory) be larger than 4G.
> Ok that would be a 16TB buffer, but someone must have decided that npages might
> not fit in 32 bits otherwise they wouldn't have used 'unsigned long'.

See commit fa17bcd5f65e ("mm: make folio page count functions return 
unsigned") why that function used to return "long" instead of "unsigned 
int" and how we changed it to "unsigned long".

Until that function actually returns something that large might take a 
while, so no need to worry about that right now.



-- 
Cheers

David

