Return-Path: <linux-fsdevel+bounces-42511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB4A42EC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09D5174B7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17DD1C84C1;
	Mon, 24 Feb 2025 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dpx1Ix+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65718E377
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431749; cv=none; b=jfy/PWxR0y7SFD6ITMAJEBQ5Ajpzfn7nLpZc/1MKYdsgnbIM6oRMFpB1pgQ8ohtHXGBqKSFiHOoP6WW2q1p3pAk9QVn3e2AtEI5p+jHazBlGW1nClub1/J/q21m0MDwYkMroIbPv0Mqsv/W+Nv/aqyd5Z91cODvwMLcPml1+chQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431749; c=relaxed/simple;
	bh=eNQ81iRPVWrfdtppZwwL4zCZ/+/X3ML2BCZjwRwBkEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGo+pmpkPmdP7TeX3y36L30bbc6nC8JlOueNc18k2gdbEaKtVRev8CxWttTYYFldKTmAXeQxG3t4ZLk6szT3b+bAEGkWyiLvm8IrJaBB1OXrhpssTDvuBg3bbXz7q/slOtCC41t6g8pBXitewkX7LO5sA7ALTBB4d3W/M+COMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dpx1Ix+w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740431746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nl9OfnZCATAci3TTVMltTTvvcs8HNEZydvEYlH/V0wU=;
	b=Dpx1Ix+wDQ0Sa40hjext2jUrDj4FXwoyn6dDA9T0TJEWvcehhWgVtCIXJBbt4nvoi7oBcd
	gxQp3eQd224THpq/djzepzkTOCu6qZqsY6GUT44ZvLm8bSv9O1Yd7i+WV4kP98i2L0y5+x
	DMp+z+46UYWtUSiydkG4P2IEyJyUvWU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-7UVIYoY-Pq2HCBIwkxZ_rw-1; Mon, 24 Feb 2025 16:15:44 -0500
X-MC-Unique: 7UVIYoY-Pq2HCBIwkxZ_rw-1
X-Mimecast-MFC-AGG-ID: 7UVIYoY-Pq2HCBIwkxZ_rw_1740431743
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43988b9ecfbso23566285e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 13:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431743; x=1741036543;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nl9OfnZCATAci3TTVMltTTvvcs8HNEZydvEYlH/V0wU=;
        b=FfkjmAbwRP7VHCORz+2BBFwpK2tLvkFTzI0P7xqYjgJAbnRv6geiZt0Zpb9Y3z/4od
         Xrp6dzbNLe/QSVg68Xu/S9pq85o55FfMytZ1HsrVxHxsUlP7T0Fwx9tnBQo4Jb+gc77Q
         STOEXCzZYK8G6cYkiOj6pdHJd4zHaXY04USFrfnuyKrxOPsmcbh8midrxI91MwRyqYPB
         vZx5hsz7QHSM0E50Kw6qFAd3OyWeFSEoic3PgH/lFtz4+t2W36TQA1RGgQaoYOlDJKYJ
         WMp2l4LCBAhh6bTQHVm5Xvdu3Xg0g0g1y/zkiK0lwUmIbsAcOiXA3s5yxo5xV2o6cS8Z
         JaLA==
X-Forwarded-Encrypted: i=1; AJvYcCU+3qINpwjgqpXoQnjtDOAm3bPnXUzrLAahWKrEa73g7wRQgLFJwHecp32Up52aKsw5ZQHeFJZL7A3cgvIA@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYli235aXmcKJbzmDRBXtLFr4UP21ThwkuwkRhRYH4AL1B92V
	uxU72kdz+YVJ6HJKd7hCztvjVZyyEYMKExORrblvIA2ScyW0lXOodhxq+gvQ/SaEjIvV4GY92wS
	Tq648+T4a37Iv3nnZy7FP6PrF+yCSzHg3MsKicZo6Oz5PxlR3J1P29t7Xj9M18XQ=
X-Gm-Gg: ASbGncv+q8UyRygq9QOOCJ43IVVbbPfrB6Op3KGm5jM4m/8yGKRusiO4c0fCO8GMIr0
	K0kaLkJYtbGaY4xELic0icyTj4U99LHtr16dLEIMqLlhg4sWOMsbq0WEC1J94pHdL6HUb12uwOy
	9tutW2j7pGBWTJH0JefIju8d4kqlrUhCHOSTQcu2Qj6cUbd1QWiWMOkStnQolA+kNkpMLs8Ijq2
	sBo9Yf+67Od4zGd3G/tZzvYxQDgacY+cqRxePqR0aHDw2dowBMDuMXZoMs4OXLtqCzc3GwPtUgU
	WXQuNY7JhgCKW/cXNy90W3/ThCEtlQZMScSskwq5RbAmPgAYDutNI+RL6mgWIuXXNDB8IAh8ksH
	veaKUKX3S5al1ntZFUuuhHd8sA7auIh1l/E5QZ1r5NgU=
X-Received: by 2002:a05:600c:3b1e:b0:439:9698:d703 with SMTP id 5b1f17b1804b1-439ae212960mr121299425e9.23.1740431743425;
        Mon, 24 Feb 2025 13:15:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgL/G2h33aVa3vwv/T/YUbQPjOTuFE6g17nM71Iq1z6ZD3IzU2a+mLm6L35PZ1eiaHY/3mQg==
X-Received: by 2002:a05:600c:3b1e:b0:439:9698:d703 with SMTP id 5b1f17b1804b1-439ae212960mr121299235e9.23.1740431742943;
        Mon, 24 Feb 2025 13:15:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce60asm119599345e9.7.2025.02.24.13.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 13:15:41 -0800 (PST)
Message-ID: <567b02b0-3e39-4e3c-ba41-1bc59217a421@redhat.com>
Date: Mon, 24 Feb 2025 22:15:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] fs/proc/page: remove per-page mapcount
 dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-17-david@redhat.com>
 <D80YSXJPTL7M.2GZLUFXVP2ZCC@nvidia.com>
 <8a5e94a2-8cd7-45f5-a2be-525242c0cd16@redhat.com>
 <9010E213-9FC5-4900-B971-D032CB879F2E@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9010E213-9FC5-4900-B971-D032CB879F2E@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 22:10, Zi Yan wrote:
> On 24 Feb 2025, at 16:02, David Hildenbrand wrote:
> 
>> On 24.02.25 21:40, Zi Yan wrote:
>>> On Mon Feb 24, 2025 at 11:55 AM EST, David Hildenbrand wrote:
>>>> Let's implement an alternative when per-page mapcounts in large folios
>>>> are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>>>
>>>> For large folios, we'll return the per-page average mapcount within the
>>>> folio, except when the average is 0 but the folio is mapped: then we
>>>> return 1.
>>>>
>>>> For hugetlb folios and for large folios that are fully mapped
>>>> into all address spaces, there is no change.
>>>>
>>>> As an alternative, we could simply return 0 for non-hugetlb large folios,
>>>> or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.
>>>>
>>>> But the information exposed by this interface can still be valuable, and
>>>> frequently we deal with fully-mapped large folios where the average
>>>> corresponds to the actual page mapcount. So we'll leave it like this for
>>>> now and document the new behavior.
>>>>
>>>> Note: this interface is likely not very relevant for performance. If
>>>> ever required, we could try doing a rather expensive rmap walk to collect
>>>> precisely how often this folio page is mapped.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    Documentation/admin-guide/mm/pagemap.rst |  7 +++++-
>>>>    fs/proc/internal.h                       | 31 ++++++++++++++++++++++++
>>>>    fs/proc/page.c                           | 19 ++++++++++++---
>>>>    3 files changed, 53 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
>>>> index caba0f52dd36c..49590306c61a0 100644
>>>> --- a/Documentation/admin-guide/mm/pagemap.rst
>>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>>>> @@ -42,7 +42,12 @@ There are four components to pagemap:
>>>>       skip over unmapped regions.
>>>>      * ``/proc/kpagecount``.  This file contains a 64-bit count of the number of
>>>> -   times each page is mapped, indexed by PFN.
>>>> +   times each page is mapped, indexed by PFN. Some kernel configurations do
>>>> +   not track the precise number of times a page part of a larger allocation
>>>> +   (e.g., THP) is mapped. In these configurations, the average number of
>>>> +   mappings per page in this larger allocation is returned instead. However,
>>>> +   if any page of the large allocation is mapped, the returned value will
>>>> +   be at least 1.
>>>>     The page-types tool in the tools/mm directory can be used to query the
>>>>    number of times a page is mapped.
>>>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>>>> index 1695509370b88..16aa1fd260771 100644
>>>> --- a/fs/proc/internal.h
>>>> +++ b/fs/proc/internal.h
>>>> @@ -174,6 +174,37 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
>>>>    	return mapcount;
>>>>    }
>>>>   +/**
>>>> + * folio_average_page_mapcount() - Average number of mappings per page in this
>>>> + *				   folio
>>>> + * @folio: The folio.
>>>> + *
>>>> + * The average number of present user page table entries that reference each
>>>> + * page in this folio as tracked via the RMAP: either referenced directly
>>>> + * (PTE) or as part of a larger area that covers this page (e.g., PMD).
>>>> + *
>>>> + * Returns: The average number of mappings per page in this folio. 0 for
>>>> + * folios that are not mapped to user space or are not tracked via the RMAP
>>>> + * (e.g., shared zeropage).
>>>> + */
>>>> +static inline int folio_average_page_mapcount(struct folio *folio)
>>>> +{
>>>> +	int mapcount, entire_mapcount;
>>>> +	unsigned int adjust;
>>>> +
>>>> +	if (!folio_test_large(folio))
>>>> +		return atomic_read(&folio->_mapcount) + 1;
>>>> +
>>>> +	mapcount = folio_large_mapcount(folio);
>>>> +	entire_mapcount = folio_entire_mapcount(folio);
>>>> +	if (mapcount <= entire_mapcount)
>>>> +		return entire_mapcount;
>>>> +	mapcount -= entire_mapcount;
>>>> +
>>>> +	adjust = folio_large_nr_pages(folio) / 2;
>>
>> Thanks for the review!
>>
>>>
>>> Is there any reason for choosing this adjust number? A comment might be
>>> helpful in case people want to change it later, either with some reasoning
>>> or just saying it is chosen empirically.
>>
>> We're dividing by folio_large_nr_pages(folio) (shifting by folio_large_order(folio)), so this is not a magic number at all.
>>
>> So this should be "ordinary" rounding.
> 
> I thought the rounding would be (mapcount + 511) / 512.

Yes, that's "rounding up".

> But
> that means if one subpage is mapped, the average will be 1.
> Your rounding means if at least half of the subpages is mapped,
> the average will be 1. Others might think 1/3 is mapped,
> the average will be 1. That is why I think adjust looks like
> a magic number.

I think all callers could tolerate (or benefit) from 
folio_average_page_mapcount() returning at least 1 in case any page is 
mapped.

There was a reason why I decided to round to the nearest integer instead.

Let me think about this once more, I went back and forth a couple of 
times on this.

-- 
Cheers,

David / dhildenb


