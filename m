Return-Path: <linux-fsdevel+bounces-42509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4059A42EB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F437AACBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B41957FC;
	Mon, 24 Feb 2025 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhcrhRoq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD3193404
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431425; cv=none; b=NgvvXiroecciJyX5k9bTVKnLnQN8F6M11VaF2tjJVHXPbcn2fjQzMGLiKNzK/bO1ZD65T/KtQecLBbiTk5Ae4B71w5arrm1IcA5jvy5sJv6FD3lZ20fsYp6YJfxuFg+zBcgJy8Lhf/IyfLTHVT6YS8S2qunA2WewD5ROOrnXDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431425; c=relaxed/simple;
	bh=8ShZRzfgtCGLnrqMvTxM31tyjSi2afUVsge5F4qJXAE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jbdbyandPIw6lLVXTwFnbFKzItwK8evFpP0qtwFPJtHp2B0S3z96xzahkeekggimmZ4yRC1Zzgi5m4kZ4SmlKJJyGZLu/5ueAyzfdNlV6us+rneWaq2sUFwz7A6iMU7oWULpnrDH+UeNW6uFENVh6P0TOiNL0UTZYU5i7kk1uS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhcrhRoq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740431422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fzSTxledaSV06nALv2dcRKnCIBvTt88ZTAw50245vSk=;
	b=OhcrhRoqgfruin7bTHpf0JGl43sIspaIIMF2Y9bfKm9bc4C09td/3+Pr5oeKwOKJ6158KT
	EZv+zb+Jnlkzm5S75cFSnKDjCNZzSmkugg55FLJTvBkTgKv6j2NPw6B3m9V0MHFb2dQbZb
	Et5SnJ13Y7eGFJpFHIIXoO5WUJIM2nU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-R0Ezhh70MmC2c9R3FwDqNw-1; Mon, 24 Feb 2025 16:10:20 -0500
X-MC-Unique: R0Ezhh70MmC2c9R3FwDqNw-1
X-Mimecast-MFC-AGG-ID: R0Ezhh70MmC2c9R3FwDqNw_1740431419
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso1990732f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 13:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431419; x=1741036219;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fzSTxledaSV06nALv2dcRKnCIBvTt88ZTAw50245vSk=;
        b=DffTxynIv5bXUCL3qZ+avJNuKptlC7jxAO9KcFiAd89vAj1G5MSwKMhbbeRdAfv9Rd
         XXihaCQzRViOOvDxtnB81BbDYCKDZZQm24Bai5v9sd4kaUhe5Ou1ZxFaqM3Mo+EX2KoC
         0mmj5+40uh9xRkk9FDsNONCzioWwKigAMMUJVTc1KNC8Mrq0EJ/Pw8xiaYCfBEGvTe2+
         87JUL0/13eUbbCIwXMq99yfO1YMZUzfBulzv7+mNXQI6pnaRD2E+VwASEAAIfgSAaxfA
         Ke3X8NZgFbIyQTovMx5IZqDclQEIo3bZf7ZcDYlfiRRGCb2u0neiXKzg3tNT1646p/lh
         /U9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe87+ktt/Bj/yaVXXaQTKYEOnU78OOZonRdvu/EpRUf0Bd2mWeNJPwL46a2ftZpyK0CWy3cPjub0vsYYi0@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuQjQVT76vNevhChHA9cGS1euOk7uCT3uHZiv50uK79BhMrYZ
	7mreddUZw+HVcp7UfP2fL671gc4DEEKoZyZiwjl7H7RwImV4iH8JGrdV4XmPZ3571Gj76RnCbSU
	5dzDcgp4ZTcwI+F/yvkpSVNjYllqftVjETRyyHSiQDYwihXbariW0VQDlCQ7p8HM=
X-Gm-Gg: ASbGncsIEbny5JSf+bYUd9bBbpAH5Hq3esXvMJU7JmqjKZih8mPDxJdNcemEhITtcRJ
	WrslT+8AwlTOA2fl5ir+i9kBfctU+I3695hn27fp0OxPid4OPaf9/uQKpxqLmuceYk313ejjXKd
	WW8swfjveHpLvzi388worYUQBX29sPuCfVufSYrnnZAh+xpPgsjKpFv0oQrawQq5dsKLPq62iWd
	HPHZ+XFmWjGjz+FUxrBBBYjzNXNS6gQnUUbXSGWWkwfF2dE3mYC1HSfbXcTzn7wqBHriPvXd1kA
	wV8fF/7KBxLHWAyNOYVFdVTmOUUWy7jAweBZd2MC3AinhQV+vGmjsZ0hWCG2WKUi9UCxajyrgAX
	GFWBWh5GTge948nNUZkO30FO4F0NlDQbM+qPPZhPvt9E=
X-Received: by 2002:a05:6000:154b:b0:38f:2726:bc0e with SMTP id ffacd0b85a97d-390cc632329mr508260f8f.44.1740431419243;
        Mon, 24 Feb 2025 13:10:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0pfDUvAW4Xj762TXmpEfVTdueKZApc8ywd+tnC/XOKYVKmUOws9JdRuwbCwap5XWge/5ONw==
X-Received: by 2002:a05:6000:154b:b0:38f:2726:bc0e with SMTP id ffacd0b85a97d-390cc632329mr508228f8f.44.1740431418811;
        Mon, 24 Feb 2025 13:10:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce60asm119493485e9.7.2025.02.24.13.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 13:10:17 -0800 (PST)
Message-ID: <9466df6c-b169-4b98-8721-5722ff4284a6@redhat.com>
Date: Mon, 24 Feb 2025 22:10:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] fs/proc/page: remove per-page mapcount
 dependency for /proc/kpagecount (CONFIG_NO_PAGE_MAPCOUNT)
From: David Hildenbrand <david@redhat.com>
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
 <8a5e94a2-8cd7-45f5-a2be-525242c0cd16@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8a5e94a2-8cd7-45f5-a2be-525242c0cd16@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 22:02, David Hildenbrand wrote:
> On 24.02.25 21:40, Zi Yan wrote:
>> On Mon Feb 24, 2025 at 11:55 AM EST, David Hildenbrand wrote:
>>> Let's implement an alternative when per-page mapcounts in large folios
>>> are no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>>
>>> For large folios, we'll return the per-page average mapcount within the
>>> folio, except when the average is 0 but the folio is mapped: then we
>>> return 1.
>>>
>>> For hugetlb folios and for large folios that are fully mapped
>>> into all address spaces, there is no change.
>>>
>>> As an alternative, we could simply return 0 for non-hugetlb large folios,
>>> or disable this legacy interface with CONFIG_NO_PAGE_MAPCOUNT.
>>>
>>> But the information exposed by this interface can still be valuable, and
>>> frequently we deal with fully-mapped large folios where the average
>>> corresponds to the actual page mapcount. So we'll leave it like this for
>>> now and document the new behavior.
>>>
>>> Note: this interface is likely not very relevant for performance. If
>>> ever required, we could try doing a rather expensive rmap walk to collect
>>> precisely how often this folio page is mapped.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    Documentation/admin-guide/mm/pagemap.rst |  7 +++++-
>>>    fs/proc/internal.h                       | 31 ++++++++++++++++++++++++
>>>    fs/proc/page.c                           | 19 ++++++++++++---
>>>    3 files changed, 53 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
>>> index caba0f52dd36c..49590306c61a0 100644
>>> --- a/Documentation/admin-guide/mm/pagemap.rst
>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
>>> @@ -42,7 +42,12 @@ There are four components to pagemap:
>>>       skip over unmapped regions.
>>>    
>>>     * ``/proc/kpagecount``.  This file contains a 64-bit count of the number of
>>> -   times each page is mapped, indexed by PFN.
>>> +   times each page is mapped, indexed by PFN. Some kernel configurations do
>>> +   not track the precise number of times a page part of a larger allocation
>>> +   (e.g., THP) is mapped. In these configurations, the average number of
>>> +   mappings per page in this larger allocation is returned instead. However,
>>> +   if any page of the large allocation is mapped, the returned value will
>>> +   be at least 1.
>>>    
>>>    The page-types tool in the tools/mm directory can be used to query the
>>>    number of times a page is mapped.
>>> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
>>> index 1695509370b88..16aa1fd260771 100644
>>> --- a/fs/proc/internal.h
>>> +++ b/fs/proc/internal.h
>>> @@ -174,6 +174,37 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
>>>    	return mapcount;
>>>    }
>>>    
>>> +/**
>>> + * folio_average_page_mapcount() - Average number of mappings per page in this
>>> + *				   folio
>>> + * @folio: The folio.
>>> + *
>>> + * The average number of present user page table entries that reference each
>>> + * page in this folio as tracked via the RMAP: either referenced directly
>>> + * (PTE) or as part of a larger area that covers this page (e.g., PMD).
>>> + *
>>> + * Returns: The average number of mappings per page in this folio. 0 for
>>> + * folios that are not mapped to user space or are not tracked via the RMAP
>>> + * (e.g., shared zeropage).
>>> + */
>>> +static inline int folio_average_page_mapcount(struct folio *folio)
>>> +{
>>> +	int mapcount, entire_mapcount;
>>> +	unsigned int adjust;
>>> +
>>> +	if (!folio_test_large(folio))
>>> +		return atomic_read(&folio->_mapcount) + 1;
>>> +
>>> +	mapcount = folio_large_mapcount(folio);
>>> +	entire_mapcount = folio_entire_mapcount(folio);
>>> +	if (mapcount <= entire_mapcount)
>>> +		return entire_mapcount;
>>> +	mapcount -= entire_mapcount;
>>> +
>>> +	adjust = folio_large_nr_pages(folio) / 2;
> 
> Thanks for the review!
> 
>>
>> Is there any reason for choosing this adjust number? A comment might be
>> helpful in case people want to change it later, either with some reasoning
>> or just saying it is chosen empirically.
> 
> We're dividing by folio_large_nr_pages(folio) (shifting by
> folio_large_order(folio)), so this is not a magic number at all.
> 
> So this should be "ordinary" rounding.
> 
> Assume nr_pages = 512.
> 
> With 255 we want to round down, with 256 we want to round up.
> 
> 255 / 512 = 0 :)
> 256 / 512 = 0 :(
> 
> Compared to:
> 
> (255 + (512 / 2)) / 512 = (255 + 256) / 512 = 0 :)
> (256 + (512 / 2)) / 512 = (256 + 256) / 512 = 1 :)

I think adding to the function doc:

"The average is calculated by rounding to the nearest integer."

might make it clearer.

-- 
Cheers,

David / dhildenb


