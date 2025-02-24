Return-Path: <linux-fsdevel+bounces-42507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC44A42E84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2723B30E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F205B197558;
	Mon, 24 Feb 2025 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPp3PUe+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC118FC9F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430977; cv=none; b=jcvaRDu+zS1aBSONoTHRfRzkjtc9DGJW9bXgCzlFaTjtOesKOQcbtr7BRhnL+Gd0yE81Nro7Q7ls6USisY5vHQcEbo1gqXAhjthuIzk2o+5nI71aVku44Cf6Dx/lZZ77QhWFOZ8RYeNEbe0UQ/bMwI9N2BsJHtR8mgRqrxKvrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430977; c=relaxed/simple;
	bh=jrRlas3sR28nhO1StZe2efTCXjXjKEzGdCiq1JvIBDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/V9rRE1VY5tJ5Nv1eDoqk0KCyHMBgz4sTTrqM9QyFKd1mO9+k6e39VePlojv09T2Tg8OdnCt5zaY2oEe3uWN3CKwI4H72Edo782SwZJMueIKs0GoOSkSuT7VJjDENXcvpn31vBz7awx0t2QnSl7arGfQhuMwKXSluCLmt8SKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPp3PUe+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740430973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3dbboeKWPl1cjoSZgYSulAmSpYK3PjpAQTkZ7zdmf3s=;
	b=KPp3PUe+7yONqcXLF/woNSHoyPL60NLTIJQxC36jLjXrMp9VZvNnJPnQ7rbcy0WzHTCFtC
	bb7doMxkcLPNPZCz5/SxcRYy2AM0bAZQ4doD+KI9BfSpSm75wEk+BYmxt7hiNjjLfum/qO
	g7DZrXgauHfrq3qc4dZtOnQ+DW2YIM4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-al8e6br4OomOashlRkLaYg-1; Mon, 24 Feb 2025 16:02:50 -0500
X-MC-Unique: al8e6br4OomOashlRkLaYg-1
X-Mimecast-MFC-AGG-ID: al8e6br4OomOashlRkLaYg_1740430969
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f31e96292so3172145f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 13:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740430969; x=1741035769;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3dbboeKWPl1cjoSZgYSulAmSpYK3PjpAQTkZ7zdmf3s=;
        b=VmraIk7U9XOrzbDo+0BiwI+juqd12M6NCBAsv7yrbCFCZaXr6WXj4oA34JuhEz+Xbo
         Cz+/GGyE4EbEFi9NJqj1voNt41sv+XLQwmf+LKEDcfWaiQkA0ydcO6lSmCbRziEG5V0U
         CWV3OIV4SJTf60/90Rx2rCO6jpU1CtyMsA5QvdpTsNViU7+iicWoWm9QVF0RHMjBUldM
         VnLfn6B5PJjUxnUBo4J2XDiILvcgPTN5Q632r/RUcgx9iT19l6fLu1/HOwsoIyjWCD/R
         Ifc/yPnQ2/7pFS7ekYhEllx4kBpxLyu8JK0UxBaGt58NMGHGzFFVS9osOMwU6I4mbl3k
         AuZg==
X-Forwarded-Encrypted: i=1; AJvYcCWefitgbkLOPCrWPqPcuL3oe/SGUPwjnnWIqft/6KwU2MyPdwZQoIh4c0Ca7VUGk92mSXdnXsjfiGky3sbN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3n/E2N7YvaThgpwrbndQ46QWclBtxPYamOmPH23WkRXYZQPSl
	2r///ulHD0qW1rweCWioooWo6r3ycyUl8kY9BKV8XD8r+g2MkoMiWdcFsWNL7fSKzAiyTz6JkBm
	ftznpsMWOzs67V1yFFOcK/2qTUq/QSyFpkQpQv1AD448MYjBy0jQBQcQ50xLAhoFIzVfbbTcejw
	==
X-Gm-Gg: ASbGncvVlrEFPOIsl+MaiDTtdeh/KMGBk7mzYjuA9G1l7GJv1uPjLaN8uYfkqqHdYOy
	gexWSQgciuADP4qZR9ptPBI8Me8SJrfP3iVG1Xo1xV9JxU1WiEgSCkjZ6CQs1Sdt4e4fnt1iv+P
	OTKmt1cn/zXgfl98N8LYkvl+6UjcEZU1YP6A29yGDVeG6DmKHgkZpfjMTKP1BJ5AZ+hrJ1CmHRK
	w+4SU6qmaByBqSpIFoVPHemzzuYruSsNfNzxLlAG41wE7wqB7unm2pGcGbv06TL4g+E2f0RPJDn
	dV87n4q5KQql4/DwHP8qX8eQiMynV0zOHQ2zpx1bQNhRCRj5bz+LgvVhi2SvWJ0rH2L4g3N409G
	U8DRzzZ0TETF/ndQnjL6itaZ8AgJ8/heRVQaGHxXQH18=
X-Received: by 2002:a5d:5254:0:b0:38e:65d8:b677 with SMTP id ffacd0b85a97d-38f6f05183bmr11712823f8f.33.1740430968908;
        Mon, 24 Feb 2025 13:02:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwnjhXnr514/DED6xj7P4paRvrIZHceGnHUX+kXTLuAQZyzQbefHRr5wLPrc8a//y+OvLr7w==
X-Received: by 2002:a5d:5254:0:b0:38e:65d8:b677 with SMTP id ffacd0b85a97d-38f6f05183bmr11712783f8f.33.1740430968473;
        Mon, 24 Feb 2025 13:02:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882af4sm116185f8f.47.2025.02.24.13.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 13:02:47 -0800 (PST)
Message-ID: <8a5e94a2-8cd7-45f5-a2be-525242c0cd16@redhat.com>
Date: Mon, 24 Feb 2025 22:02:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] fs/proc/page: remove per-page mapcount
 dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
To: Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 owner-linux-mm@kvack.org
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-17-david@redhat.com>
 <D80YSXJPTL7M.2GZLUFXVP2ZCC@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D80YSXJPTL7M.2GZLUFXVP2ZCC@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 21:40, Zi Yan wrote:
> On Mon Feb 24, 2025 at 11:55 AM EST, David Hildenbrand wrote:
>> Let's implement an alternative when per-page mapcounts in large folios
>> are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>
>> For large folios, we'll return the per-page average mapcount within the
>> folio, except when the average is 0 but the folio is mapped: then we
>> return 1.
>>
>> For hugetlb folios and for large folios that are fully mapped
>> into all address spaces, there is no change.
>>
>> As an alternative, we could simply return 0 for non-hugetlb large folios,
>> or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.
>>
>> But the information exposed by this interface can still be valuable, and
>> frequently we deal with fully-mapped large folios where the average
>> corresponds to the actual page mapcount. So we'll leave it like this for
>> now and document the new behavior.
>>
>> Note: this interface is likely not very relevant for performance. If
>> ever required, we could try doing a rather expensive rmap walk to collect
>> precisely how often this folio page is mapped.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   Documentation/admin-guide/mm/pagemap.rst |  7 +++++-
>>   fs/proc/internal.h                       | 31 ++++++++++++++++++++++++
>>   fs/proc/page.c                           | 19 ++++++++++++---
>>   3 files changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
>> index caba0f52dd36c..49590306c61a0 100644
>> --- a/Documentation/admin-guide/mm/pagemap.rst
>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>> @@ -42,7 +42,12 @@ There are four components to pagemap:
>>      skip over unmapped regions.
>>   
>>    * ``/proc/kpagecount``.  This file contains a 64-bit count of the number of
>> -   times each page is mapped, indexed by PFN.
>> +   times each page is mapped, indexed by PFN. Some kernel configurations do
>> +   not track the precise number of times a page part of a larger allocation
>> +   (e.g., THP) is mapped. In these configurations, the average number of
>> +   mappings per page in this larger allocation is returned instead. However,
>> +   if any page of the large allocation is mapped, the returned value will
>> +   be at least 1.
>>   
>>   The page-types tool in the tools/mm directory can be used to query the
>>   number of times a page is mapped.
>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>> index 1695509370b88..16aa1fd260771 100644
>> --- a/fs/proc/internal.h
>> +++ b/fs/proc/internal.h
>> @@ -174,6 +174,37 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
>>   	return mapcount;
>>   }
>>   
>> +/**
>> + * folio_average_page_mapcount() - Average number of mappings per page in this
>> + *				   folio
>> + * @folio: The folio.
>> + *
>> + * The average number of present user page table entries that reference each
>> + * page in this folio as tracked via the RMAP: either referenced directly
>> + * (PTE) or as part of a larger area that covers this page (e.g., PMD).
>> + *
>> + * Returns: The average number of mappings per page in this folio. 0 for
>> + * folios that are not mapped to user space or are not tracked via the RMAP
>> + * (e.g., shared zeropage).
>> + */
>> +static inline int folio_average_page_mapcount(struct folio *folio)
>> +{
>> +	int mapcount, entire_mapcount;
>> +	unsigned int adjust;
>> +
>> +	if (!folio_test_large(folio))
>> +		return atomic_read(&folio->_mapcount) + 1;
>> +
>> +	mapcount = folio_large_mapcount(folio);
>> +	entire_mapcount = folio_entire_mapcount(folio);
>> +	if (mapcount <= entire_mapcount)
>> +		return entire_mapcount;
>> +	mapcount -= entire_mapcount;
>> +
>> +	adjust = folio_large_nr_pages(folio) / 2;

Thanks for the review!

> 
> Is there any reason for choosing this adjust number? A comment might be
> helpful in case people want to change it later, either with some reasoning
> or just saying it is chosen empirically.

We're dividing by folio_large_nr_pages(folio) (shifting by 
folio_large_order(folio)), so this is not a magic number at all.

So this should be "ordinary" rounding.

Assume nr_pages = 512.

With 255 we want to round down, with 256 we want to round up.

255 / 512 = 0 :)
256 / 512 = 0 :(

Compared to:

(255 + (512 / 2)) / 512 = (255 + 256) / 512 = 0 :)
(256 + (512 / 2)) / 512 = (256 + 256) / 512 = 1 :)

> 
>> +	return ((mapcount + adjust) >> folio_large_order(folio)) +
>> +		entire_mapcount;
>> +}
>>   /*
>>    * array.c
>>    */
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index a55f5acefa974..4d3290cc69667 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -67,9 +67,22 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>>   		 * memmaps that were actually initialized.
>>   		 */
>>   		page = pfn_to_online_page(pfn);
>> -		if (page)
>> -			mapcount = folio_precise_page_mapcount(page_folio(page),
>> -							       page);
>> +		if (page) {
>> +			struct folio *folio = page_folio(page);
>> +
>> +			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
>> +				mapcount = folio_precise_page_mapcount(folio, page);
>> +			} else {
>> +				/*
>> +				 * Indicate the per-page average, but at least "1" for
>> +				 * mapped folios.
>> +				 */
>> +				mapcount = folio_average_page_mapcount(folio);
>> +				if (!mapcount && folio_test_large(folio) &&
>> +				    folio_mapped(folio))
>> +					mapcount = 1;
> 
> This should be part of folio_average_page_mapcount() right?

No, that's not desired.

> Otherwise, the comment on folio_average_page_mapcount() is not correct,
> since it can return 0 when a folio is mapped to user space.

It's misleading. I'll clarify the comment, probably simply saying:

Returns: The average number of mappings per page in this folio.

Thanks!

-- 
Cheers,

David / dhildenb


