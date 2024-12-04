Return-Path: <linux-fsdevel+bounces-36472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC899E3E58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A6AB3C9D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5620ADEB;
	Wed,  4 Dec 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfdWr3pI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162D205AB3;
	Wed,  4 Dec 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323632; cv=none; b=L4OQ+QkPIi+37HoN2KznF6o+rUVe/NccWw3Vs6WbytDLVsgbOF/f3i8DGg3PBQfYD+JO6h8a7//jKokBa+AW9DbxQL8q91/mGme8jMKAqKhWj3MZMddUJ2dbzfKQldzl0s++dQ5bywOK8mMsgeYV+2JHtskmaQw8f8CryPQ4Od0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323632; c=relaxed/simple;
	bh=caoMhs0rBOaQ8T+4bg1B4Frs1kuXaZQjsYJdNpinrn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BRHsmTN7uUSE4GfNVMF3T/PaNBNpupVd6LqaS0ZWKZSiUEdJDt2E/sx9Y+EWRx1jVBKN3ybgFORYXO1giQzlUC992YIAKx7O2b30AyjK+0S84snx/lKAXUBavV6FP10K0WOJuRJA2rby/oJiAEypkls7cujmCwTRwq9mvCl0d28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfdWr3pI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2154e3af730so43706245ad.3;
        Wed, 04 Dec 2024 06:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733323630; x=1733928430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXL3lr2/xb1av06HROoqFP+hEFOheIHsOAZhVg1QF4w=;
        b=UfdWr3pI1DWB8ecFk3rSUjfyeyOz8sIhybLWGbrI2zZTntaYkkJ3oUxmqnoW7jZPb2
         KK9QfSOzXfzdB/bBWxEOkdsdwHoqZdW7cAxa3ogtka6PbmI/vT1hfyPxiCOItFEk4c3c
         D0S9fAJwO1obVzo+pLK2t1atlv4p7mfMElVBS9K1jJF5tIgfPRXMpTBqLOzGfYHlxBfg
         BYwp7pjEgCpeyxLVnXRy0EfJ65+syDePuiXw+vCiGYS8JXG1Cq9p5GJgmk2GoVyNwGSA
         vWPclD8WuR9d1+A3oaHqOf6666HatvQ5Xb1jwZziaKAQ5addKoeEE/4gJKCVY3xFCSzv
         EZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323630; x=1733928430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXL3lr2/xb1av06HROoqFP+hEFOheIHsOAZhVg1QF4w=;
        b=ey/FQTWDTMcqmzRnPIbAmlu1L3aO32wcclbicVT8xBcn4PC6QVo//nnnU/q4VXDucw
         VoTcVQ7I67NaDhTsAV/I3Y6oqighZSBb3oSYObs8+Xi6PAGP6T2PIdkp0uSZxSsojqT3
         zrfSURVPr548i6t65KUxRHpcq7FgbDTVeOy8MVYX9tTEKNPu9Sth8phgKaspUnad/f3R
         Z3Ui5j7OsP9i+Fa9yWM+N6RsxXKWfQTZo7USNE6dSJ2rhpa3NnyBgfFNybsUuEL0fMEV
         RJdg2QrR0eIfx1MEayqiQuBBcREvl9JmUp9Rrd9kbzIy1fU9dZTw+mmMQKR3sBc+epzn
         GT/w==
X-Forwarded-Encrypted: i=1; AJvYcCVdQZdBvji23W+j2KLTMWDLp30i0fDBIru1xk4m3gs6MbfczkaqCe/MA6OnyUHOzXiUnfqeYmxTWU9cXHLh@vger.kernel.org, AJvYcCWthm4294EjsLn7qILH2viUeYSL/e48yq/8tYRNqqdCHnQCirg1mkxvgeX1Y9izyKx7fFvXSwJXrMqlaAzl@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQ2qEz5mFJtKUxN1kT/2iHtiqc8/4vKg5xMeXPcROnU8WU8iF
	dikWPSTF8LsVbveLpZF4GJT4sscLxDtbbf1akaDrDPfCs0CyNho7
X-Gm-Gg: ASbGncv64RuTQTAmRs7fgJxaotyER9m/fSYOIQynrT4IfM9qI9Ce2xH+iizc0INJ2KT
	rebnItJMLiiaxyHF44pl6jdM9+4FR357+pW118raYbK7ltZ7hqTG8LQ0MEyGBXOBTAy/eI3BJO2
	I8xEiUg/f45clG0WkyFPFWdr6Sgv/D1Jh1K0FlkkGQq9gUrXf/T0kKorg6Ad8/Xm7aSmmyE/DoD
	Vxh22BOWg9IFvmuHZCsBVROn09qTRgmBMHEEjSR1qi8Uj91Ie3Lnn7bHXM=
X-Google-Smtp-Source: AGHT+IEf8AURcCKrmVMH+suyut8NUqPd6mYZzY8B7a/jkx/LPgrSN1NEodCLukf6DgsTLlCThZ6nsg==
X-Received: by 2002:a17:902:f712:b0:215:b9a7:526c with SMTP id d9443c01a7336-215d0050c00mr68142695ad.25.1733323629616;
        Wed, 04 Dec 2024 06:47:09 -0800 (PST)
Received: from [10.239.15.156] ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152191dcc9sm112802355ad.112.2024.12.04.06.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:47:09 -0800 (PST)
Message-ID: <605e5e98-863f-41fe-9a84-071c1843d684@gmail.com>
Date: Wed, 4 Dec 2024 22:47:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Peter Xu <peterx@redhat.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
 <e6199ca4-1f87-4ec5-b886-11482b082931@gmail.com>
 <f002188e-8990-4c72-ad84-966518279dce@redhat.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <f002188e-8990-4c72-ad84-966518279dce@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/12/4 22:37, David Hildenbrand wrote:
> On 04.12.24 15:30, Wenchao Hao wrote:
>> On 2024/12/3 22:17, David Hildenbrand wrote:
>>> On 03.12.24 14:49, Wenchao Hao wrote:
>>>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>>>> each VMA, but it does not include large pages smaller than PMD size.
>>>>
>>>> This patch adds the statistics of anonymous huge pages allocated by
>>>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>>>
>>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>>> ---
>>>>    fs/proc/task_mmu.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index 38a5a3e9cba2..b655011627d8 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/vim @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>>>            if (!folio_test_swapbacked(folio) && !dirty &&
>>>>                !folio_test_dirty(folio))
>>>>                mss->lazyfree += size;
>>>> +
>>>> +        /*
>>>> +         * Count large pages smaller than PMD size to anonymous_thp
>>>> +         */
>>>> +        if (!compound && PageHead(page) && folio_order(folio))
>>>> +            mss->anonymous_thp += folio_size(folio);
>>>>        }
>>>>          if (folio_test_ksm(folio))
>>>
>>>
>>> I think we decided to leave this (and /proc/meminfo) be one of the last
>>> interfaces where this is only concerned with PMD-sized ones:
>>>
>>
>> Could you explain why?
>>
>> When analyzing the impact of mTHP on performance, we need to understand
>> how many pages in the process are actually present as large pages.
>> By comparing this value with the actual memory usage of the process,
>> we can analyze the large page allocation success rate of the process,
>> and further investigate the situation of khugepaged. If the actual
>> proportion of large pages is low, the performance of the process may
>> be affected, which could be directly reflected in the high number of
>> TLB misses and page faults.
>>
>> However, currently, only PMD-sized large pages are being counted,
>> which is insufficient.
> 
> As Ryan said, we have scripts to analyze that. We did not come to a conclusion yet how to handle smaps stats differently -- and whether we want to at all.
> 

Hi David,

I replied Ryan about few disadvantages of the scripts. The scripts
is not helpful for my scenario.

>>
>>> Documentation/admin-guide/mm/transhuge.rst:
>>>
>>> The number of PMD-sized anonymous transparent huge pages currently used by the
>>> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>>> To identify what applications are using PMD-sized anonymous transparent huge
>>> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
>>> fields for each mapping. (Note that AnonHugePages only applies to traditional
>>> PMD-sized THP for historical reasons and should have been called
>>> AnonHugePmdMapped).
>>>
>>
>> Maybe rename this field, then AnonHugePages contains huge page of mTHP?
> 
> It has the potential of breaking existing user space, which is why we didn't look into that yet.
> 

Got it.

> AnonHugePmdMapped would be a lot cleaner, and could be added independently. It would be required as a first step.
> 

While, if the meaning of AnonHugePages remains unchanged, simply adding a new field doesn't
seem to have any practical significance.

Thanks


