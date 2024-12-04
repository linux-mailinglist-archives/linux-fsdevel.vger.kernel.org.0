Return-Path: <linux-fsdevel+bounces-36469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4B59E3CF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95D716365A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D564920A5EA;
	Wed,  4 Dec 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjCXOjFa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB251209F53;
	Wed,  4 Dec 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323249; cv=none; b=rouLkBu91FFCBbjA6nJpFrRB7SAZxqm5T7uYClP57Yh5ytciHfOHD/YfzsYjHJ3w4bL72GLpbmjpOOFNBnTzB3TTsUKtRvP7rfmsxNyZnBAaknSnEZalZT24rar6UhJEZKGaJqnkNdd/lSHI3uQhqRu3yN10GXwEHOcwgz0LeGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323249; c=relaxed/simple;
	bh=iXBVTd9lBypGyg5hBgjghXPtE8LT4SoeeIDKGjt7Mzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fTvwKZitOgJHFHEOw+gvo40Wo/4ONsPbaYxCG8aiaJRxrgHb926vEyajU388K5zqYYFKfn8iYLsLnnhTPXbIWOLO9bFYg9CGicuIPciWBQmCPjjmEJ3y3AkfQrTrmdHv6jMzS6mJvBJfhT/K8JFWlUzkOdpX9jTpWEGS1Qna4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjCXOjFa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724e1742d0dso5812958b3a.0;
        Wed, 04 Dec 2024 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733323247; x=1733928047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8f5DyxCokPWp25cVGU/S/h8a0aME9TNjxCaCS4JaNPM=;
        b=AjCXOjFaCh6ftVDhRMdLqf1AifBwWs+n5sUlCQQ2ID0aEvNvL6r5/nLgRcJ+NTbXVs
         VSwt6LRANo9pds/UmgEdUNhkbKwm1237P6rtEvzNKt73MmKWc+FBANI5g/W1uT3y6TBe
         YugTHTenun/25wXmlXwmjRMPD8Nx6KGLV9p8V/jwZPUkHL58vywNKS/iANVi8vjQgvjS
         OU5xvpqKdxQ8XxwRdOIyh2YxXZFvVR4zB043XXcrkUg+sgio5PUp36Bdwl16xxMRc3va
         DiQB/7UfVuHNkzt52MVXt+IBI3bsYCsAfKfYk8kai0k7bP+n+evAEN+R5445hBr9PXi+
         Gftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323247; x=1733928047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f5DyxCokPWp25cVGU/S/h8a0aME9TNjxCaCS4JaNPM=;
        b=I+lsA15SCVc40kuJzS+KUrjzjF/t2mUrJ4yVXrWGFFEwlAe5Zud6SurHCCMEDrgsom
         X76Hjbc/T/xS4YcqtBtRO0SUVQ8fTjJnRaCPJVKCtChJ7cYT/zqBd8tbhJ2Jo53Tq9o9
         lw8+WyU5B/n0OjZri2PzZoRbZA/DRA5SXc9TN4HUgkM4/W7faRaorgizRXsqJncawe1Q
         nuBjGQIgp52shccyT7/2VpZzpvTzuL/CJ+0ABPMtfoh7jsnXc8aPjrfscV73XBvfcBKf
         +I6EOIANWjzdc8pDRcAjBvtkRLpFDNpVWTcwK5pUqefHZaA+FOhoXK4zqcDaPsOPpis7
         TdQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZUtCByRgTzt6GbvM/6xiG+1gsJnAM9qGECS9ToqPVPg50lLjPOW0OnK9PHV00XD7p6GcuPVPOWt2F1GSV@vger.kernel.org, AJvYcCX9LUsOFQwpazqZdSqXZzkGeioGNlsbn2rAnkaD9QfLCFfGHcpV5T5nWKNjI/TXeccQ2MQxT9oHHbxa4oXR@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKyjypGyazW28hYfYlifFrOl0vmDcp0QgDSyb3LoYxGRVxJRa
	seF97s+m0HjP2Lj2tGBUh1unxpOaL0La9bMX2fysocrV4jTwUolF
X-Gm-Gg: ASbGncumzWFu8ugU4QTCV0P404rZZSCIsPnV9lS3euwZ47XAiyHlPjAKknklh+6hAxM
	Uy5v7oCMpBgVHdKrj67bOadWSB+BtIAo0OlY8FG23kWI3TuT7qqehbHe1eAc1BG27zGLvS7L3Hk
	y0hHvx9DVM3Dz/Z+UVmw6Q9nttJACvSbqEkOfH0fgjyOt6hKnWa65+4TNDh8xolNLAvzky7Hndp
	IMVqQwP9G28ndH8aeYg4pLz1ZzwsvxZcZGmKwr3Gze4e80CGT/jRpG1p6Q=
X-Google-Smtp-Source: AGHT+IEnhtP6WRH6k5VaZ2PMbJ7zWCCzAczeTtcxW6pREPco+S5rDahgTDDh1nrxHPbVIrmrV+7H+A==
X-Received: by 2002:a17:90b:4a52:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-2ef011e37f6mr8932384a91.8.1733323246764;
        Wed, 04 Dec 2024 06:40:46 -0800 (PST)
Received: from [10.239.15.156] ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef270696afsm1477056a91.53.2024.12.04.06.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:40:46 -0800 (PST)
Message-ID: <31158c3e-bf1b-47e8-a41b-0417c538b62e@gmail.com>
Date: Wed, 4 Dec 2024 22:40:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand
 <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Peter Xu <peterx@redhat.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
 <f2d58d57-df38-42eb-a00c-a993ca7299ba@arm.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <f2d58d57-df38-42eb-a00c-a993ca7299ba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/12/3 22:42, Ryan Roberts wrote:
> On 03/12/2024 14:17, David Hildenbrand wrote:
>> On 03.12.24 14:49, Wenchao Hao wrote:
>>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>>> each VMA, but it does not include large pages smaller than PMD size.
>>>
>>> This patch adds the statistics of anonymous huge pages allocated by
>>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>>
>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>> ---
>>>   fs/proc/task_mmu.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 38a5a3e9cba2..b655011627d8 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss,
>>> struct page *page,
>>>           if (!folio_test_swapbacked(folio) && !dirty &&
>>>               !folio_test_dirty(folio))
>>>               mss->lazyfree += size;
>>> +
>>> +        /*
>>> +         * Count large pages smaller than PMD size to anonymous_thp
>>> +         */
>>> +        if (!compound && PageHead(page) && folio_order(folio))
>>> +            mss->anonymous_thp += folio_size(folio);
>>>       }
>>>         if (folio_test_ksm(folio))
>>
>>
>> I think we decided to leave this (and /proc/meminfo) be one of the last
>> interfaces where this is only concerned with PMD-sized ones:
>>
>> Documentation/admin-guide/mm/transhuge.rst:
>>
>> The number of PMD-sized anonymous transparent huge pages currently used by the
>> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>> To identify what applications are using PMD-sized anonymous transparent huge
>> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
>> fields for each mapping. (Note that AnonHugePages only applies to traditional
>> PMD-sized THP for historical reasons and should have been called
>> AnonHugePmdMapped).
>>
> 
> Agreed. If you need per-process metrics for mTHP, we have a python script at
> tools/mm/thpmaps which does a fairly good job of parsing pagemap. --help gives
> you all the options.
> 

I tried this tool, and it is very powerful and practical IMO.
However, thereare two disadvantages:

- This tool is heavily dependent on Python and Python libraries.
  After installing several libraries with the pip command, I was able to
  get it running.
  In practice, the environment we need to analyze may be a mobile or
  embedded environment, where it is very difficult to deploy these
  libraries.
- It seems that this tool only counts file-backed large pages? During
  the actual test, I mapped a region of anonymous pages and mapped it
  as large pages, but the tool did not display those large pages.
  Below is my test file(mTHP related sysfs interface is set to "always"
  to make sure using large pages):

int main()
{
        int i;
        char *c;
        unsigned long *p;

        p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if (!p) {
                perror("fail to get memory");
                exit(-1);
        }

        c = (unsigned char *)p;

        for (i = 0; i < SIZE / 8; i += 8)
                *(p + i) = 0xffff + i;

        while (1)
                sleep(10);

        return 0;
}

Thanks,
wenchao


