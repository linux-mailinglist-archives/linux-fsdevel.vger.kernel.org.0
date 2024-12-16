Return-Path: <linux-fsdevel+bounces-37504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA29F3537
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9DC1884D20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02D1885A5;
	Mon, 16 Dec 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyt8TNEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23214B086;
	Mon, 16 Dec 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364992; cv=none; b=AipFCOhJ8F9H+o+6MqiJ6dlB4TrUlJcHD6NrRAqsGrISB+PxZCjaTKehlGhh1CGInWP34tWdnqhrOHgCo6JU6VQlTE+U0S/6sR+NnTcjLTGXnXFWUIhHqkbEEOPJqx8KWsRrqU0Ot2z74ZOhkX4qXdvWTtYKUkn+6713H003gJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364992; c=relaxed/simple;
	bh=Q/du6zT7+ml5oP8NLxNeB86FKeWQXezTveGjGvOyFKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHESjQD329fITzAy69F8zU09VPG9LvOeTqFHd43mgNoSLZQ+aEJMo9qAI/NAhBYWHTWCfuGDIWQI+FP15yAUui7Qqj19Ujb/geIamBZRaVN7PVzTohfs/4c3Tpkz6QnYod1DFH3jRtZNuyTzB3xRUzTvjt7JcdkWT7UoHn93iss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyt8TNEC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b1f05caso39478645ad.3;
        Mon, 16 Dec 2024 08:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734364991; x=1734969791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uf9egybKI/MKwFIGN0jlMtv9pzalLYkTVpIwCM8w0nA=;
        b=Qyt8TNECgNnu7MALoCCptW9NbITVAuXdxOyEiFuyl+ILMEPayW3m355NnftzJUlZxa
         AdqGVNooty2q1jnmRvk1iOSYgN/Gpd8LE3VxKeSKbNzpLoqlG6g6bgI3NotQIILZ/Cwd
         2w2gNoMwX6d6Yp29Roha7v6Y72vAuqx8eWDzYShuRxjFK4m89t2/xZHxD6suIjR7F/Ba
         j9vF6aC2m7CeHz6up3Ljyh9+jwH6JTQ3C6HoEIktuoWKaqurgA5VjwDThHvjPKt9N4hw
         TwXeTCOtb/EcINRN77QGpsXOO64N7hCwIhM0Jiqopk8aGOofuQ2GQ1rRzRuJfjgp+5Yk
         fkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364991; x=1734969791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf9egybKI/MKwFIGN0jlMtv9pzalLYkTVpIwCM8w0nA=;
        b=WbLcX2qgAR4bFouemC+RpplcTTdHZLtRKz89KSXYUMZNkUGuQNFX3niwjev8wLCRDx
         +tUETWOP3jcivYrK7f8XodKy4pkNHKrRvIBdAhyrhTQwlwv97hsMpIvUvFZrl+obxn2L
         9LU11yXSzR2oHEXapuL6SQ4uO3UvFZJaYoOEaI9OXFzsyoJ8NquBGssLZPSkU62G/4pj
         /82cJRCdsuqvPIt5OIPS6CTstbVX1jLLyLm68Pc67l8tjlqL6AbMmOpAJPdgYW0jlJfh
         lHqpodqlSNyQacm9DP+UPCN9w7/pJTQ8gJGWSKSZI3rVrfjSODfq6tfhrs1ftpBaC/cD
         7pBw==
X-Forwarded-Encrypted: i=1; AJvYcCUMh3QnNcVaeUAYLFQ9uC4D7rKgr32qsgmLIVuvdHAnR7xaz6oX0HoP9Bmbrgo+jn/oa0z737fcVUBF9zrv@vger.kernel.org, AJvYcCWfcpnvfnTG/Png5h+CqfHMaGZP1jq/XXCfPJijs8XTsgx/GcrA1DsWKTtIVSIOzkeSqUO73U8VLEkq1qsI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fxzrWGnfR2WdC4DGfnqMzQJbjYlKHuAX+/SWcJKCHAYHQ93o
	jvtv3+WCdjpTTSThklZW7CXLjoU64gRqYV9CgTmXCPHCDx2J7J5o
X-Gm-Gg: ASbGncsOjyJ0orp0yry7fMMudWPEkBHHFS98IrOaEn5PivASTp3dTKy/HKP8hWXQphK
	Z7Mk60FxCI6028qAzSjXSWMRaTbaBaBnoim7YBOyTQoSaVCgM8k/8g27hpuDHMgXYy2zALOzXHC
	GWCZvNqk+7ZddQrOxIpDCVbn6/EK6tKFVi3aibfxskZgRu908rHZF2F/QiVdPYJqnIG8zAgBsSU
	NXUST+8q/Cv3S8pYfHWEMXNWrB/vl1ugnjmEf21wEFUHguDv4UhV1QkB0vz7mDeyqytrhQYSg==
X-Google-Smtp-Source: AGHT+IHhNdOmIfe4WNpSFZkqbTMp/z+SfeJeZ8rB9+dD41oswN6PiNS5ukRlgiyh6NBjpGwjucyF1w==
X-Received: by 2002:a17:902:e808:b0:216:4c88:d939 with SMTP id d9443c01a7336-21892a41d6fmr170574275ad.38.1734364989268;
        Mon, 16 Dec 2024 08:03:09 -0800 (PST)
Received: from [10.234.7.32] ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e7227asm44452215ad.272.2024.12.16.08.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 08:03:08 -0800 (PST)
Message-ID: <edfc9b39-52d8-4c4c-8c81-53dd5b35ba6e@gmail.com>
Date: Tue, 17 Dec 2024 00:03:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
 <CABzRoyZOJJKWyx4Aj0CQ17Om3wZPixJYMgZ24VSVQ5BRh2EdJw@mail.gmail.com>
 <CAGsJ_4z_nQXrnjWFODhhNPW4Q0KjeF+p+bXL5D0=CxskWo1_Jg@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <CAGsJ_4z_nQXrnjWFODhhNPW4Q0KjeF+p+bXL5D0=CxskWo1_Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/12/8 14:06, Barry Song wrote:
> On Fri, Dec 6, 2024 at 7:16 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> On Tue, Dec 3, 2024 at 10:17 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 03.12.24 14:49, Wenchao Hao wrote:
>>>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>>>> each VMA, but it does not include large pages smaller than PMD size.
>>>>
>>>> This patch adds the statistics of anonymous huge pages allocated by
>>>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>>>
>>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>>> ---
>>>>   fs/proc/task_mmu.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index 38a5a3e9cba2..b655011627d8 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>>>               if (!folio_test_swapbacked(folio) && !dirty &&
>>>>                   !folio_test_dirty(folio))
>>>>                       mss->lazyfree += size;
>>>> +
>>>> +             /*
>>>> +              * Count large pages smaller than PMD size to anonymous_thp
>>>> +              */
>>>> +             if (!compound && PageHead(page) && folio_order(folio))
>>>> +                     mss->anonymous_thp += folio_size(folio);
>>>>       }
>>>>
>>>>       if (folio_test_ksm(folio))
>>>
>>>
>>> I think we decided to leave this (and /proc/meminfo) be one of the last
>>> interfaces where this is only concerned with PMD-sized ones:
>>>
>>> Documentation/admin-guide/mm/transhuge.rst:
>>>
>>> The number of PMD-sized anonymous transparent huge pages currently used by the
>>> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>>> To identify what applications are using PMD-sized anonymous transparent huge
>>> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
>>> fields for each mapping. (Note that AnonHugePages only applies to traditional
>>> PMD-sized THP for historical reasons and should have been called
>>> AnonHugePmdMapped).
>>
>> Yeah, I think we need to keep AnonHugePages unchanged within these interfaces
>> due to historical reasons ;)
>>
>> Perhaps, there might be another way to count all THP allocated for each process.
> 
> My point is that counting the THP allocations per process doesn't seem
> as important
> when compared to the overall system's status. We already have
> interfaces to track
> the following:
> 
> * The number of mTHPs allocated or fallback events;
> * The total number of anonymous mTHP folios in the system.
> * The total number of partially unmapped mTHP folios in the system.
> 
> To me, knowing the details for each process doesn’t seem particularly
> critical for
> profiling.  To be honest, I don't see a need for this at all, except perhaps for
> debugging to verify if mTHP is present.
> 
> If feasible, we could explore converting Ryan's Python script into a native
> C program. I believe this would be more than sufficient for embedded systems
> and Android.
> 

Hi Barry,

Yes, the reason I want to use smap to collect this data is that I wasn’t familiar
with this tool before. When analyzing the performance impact of enabling mTHP, I want
to understand the actual memory usage of the process being analyzed, including the
proportions of anonymous pages, swap pages, large pages and so on.
This helps determine whether the test results align with expectations.

Indeed, the main purpose of adding this is to make debugging more convenient.
For now, I’ll perform the analysis and testing on the Fedora distribution, so I
can use the pyrhon tool directly.

If it becomes unavoidable to run this tool on embedded devices in the future, I may
take the time to create a simplified version of the analysis tool in C based on this
script.

>>
>> Thanks,
>> Lance
>>
>>
>>>
>>>
>>>
>>> --
>>> Cheers,
>>>
>>> David / dhildenb
> 
> Thanks
> Barry


