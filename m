Return-Path: <linux-fsdevel+bounces-56047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED2B121FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 18:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA897175BEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF762EE99C;
	Fri, 25 Jul 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWCt5nni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCC1F0E26;
	Fri, 25 Jul 2025 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460771; cv=none; b=vABtCasoUXYe6ISLegSwHnvwKKMoa1t+gk5waQuQXTPl+8SYPZshAFuyfqHyxriMW8a4UuJKfASPd7y0iKlF51NwjrnXIIzyy5hn0F7vvlPAThTbr3q/neuDAHDMpuAFqGlzXu6t+9k7z9YMivkxbTpRE2LlnmIxV+vehsX8Rm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460771; c=relaxed/simple;
	bh=dETcVUaIVCTFbY7bxKdABRSno5fhI5TLjsgWPikj068=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAJtDga0FdVdfzgTzxadnk4lw7BnWI2fPKU7iZ47pkV0ea+wp7M03YQ5mZZbEAQJNryy4EaI8i8gG5beJe2U/fwyK7ZIjBRsWO2TmrKSxVYHHqRf5CD3E3UVn0ih2VZXYnH9BBwe74slcfmozeL0gp8xE8OUEsI6eWxX/Yf/Z6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWCt5nni; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45555e3317aso13132975e9.3;
        Fri, 25 Jul 2025 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753460768; x=1754065568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbOyNiEiIJ2e1ejjmOvHbBcnLLMVK4Jw6hEou8tajqo=;
        b=XWCt5nnigdE7liF0/dg/QtB+e1GxvFFVRQZdyhBCQ3RL+m813LfgqCErcqnmAaBzLy
         CwkDDvJyCgkg5FY+HrKHVw4yxhU6rWmxEtk8P4H3RiE6rMQ/oVCO7LqPuD+vO0jTyidK
         5TxShmQ0Wk3ICObyAwThFh79O4zf82NR4Gq9GXRWmaItBxuTLKAgd7mfrpnmMWDiAghZ
         n7P2xzRB4K3wxtp9MhxuSpfzXRNasiRJZI7K/Bk2o/9z3V4g3lwSVcDiMi0hCZwb8miX
         NRRdgqQ3WNOyIkCjBwywnps09teeP7UJdFdD1hwkhSf9pnUIb8VOMO+oM7fKbJbTMCpj
         5g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460768; x=1754065568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbOyNiEiIJ2e1ejjmOvHbBcnLLMVK4Jw6hEou8tajqo=;
        b=LU3VuEYRxCezluI8HisyDnm9Yt4lBG3Ppo85bfX6KOQZHn83Apa0RT95zhuLf3/lDF
         OXaXE9+TWWYMiBziN4rw8zJvRF731bwMPmTKelJWiJMEozbE7/8YCiXYykBXFJU6C2+h
         wABm4R2gawm7UmF6iSDV96eXeLv8OcysSd8L4zvCTvpVLpR9ucqj+QHt1EIWGbZnv2S8
         6fvPrYdBh0RIdgFqXdNSSkCgL2OwVBSzdM+x+OGoL4m4ufl8XIZ3wC3lLOARLe3jbwSt
         qi6e5yXWejl9AvHpzm+6G7dGrpuNOmhrESi2zM1JafrGqlBYEInfLigsbd74b60ZM1C5
         1fSw==
X-Forwarded-Encrypted: i=1; AJvYcCUnz/CIsg0+8OTMmcAK/ZXWSVx5CJeUTZlMznRXgeZTda5IlGThU7I1g3I6ZD+yLv8ixXl9rZk58m8=@vger.kernel.org, AJvYcCW/ScpMzcrPTof4XNY5jizwDmB3vxlfZk9ttdqrCeWYDlKSDC6VYDXZl6HiRF0osxcLrrr9nSqWAE5rLltm@vger.kernel.org, AJvYcCWVxg0p2OJAGIjajddLneLnypflMSFkad7pUiBJs2O0EsCfqXC3PnYRX/5Sgncpo4Ggq6DhL2D0njQ48scmog==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFBkKAmf+YCGM3NxIOXNRJx0XBlDNVo7Ss/D7V3M5HD2WmQBC
	28zd9pwb0opyVrnsakJdlMKiEHB+7k4Bt1q2/F4BqcQIdaL/fXWP7FiW
X-Gm-Gg: ASbGncsnJXjg3n08ak6YZYbxFiB/eWqLGpEPOjVC0efIo+pebudvyO3wDW5Ep1i4T0K
	bQ5ts0V364BZtm6IPwbKc0UE2T+sCwxHYrMZFl0Y7rHYpLTLqVYzA0tVoe5w2Vptuy5osf2JUkU
	+cwuRPOtUkCgqXtl0047cGruwLny0pkEiAj+xYpx53JckH99BgK2iQ9potrL9RKPrehvLW69Agx
	DH4OG+JriG8mLb+DL7J7hf3GTu46A4lwe1N8+a+AHRwRlIfTZsd/JjKJv3+IBecqmREtj+i3MoL
	cskchWyeO8hbPw9yC4/AJm6IGHM5LF/er+iAK9tNaIUkfrN2rtapMoSv8kBBHtk9V0m7RcGRhGT
	Mcdl30RE36/N5kk1/VMMiBdz2ljcn4k9hBpDhVCpzHORsGUVzPtQU4SBVcO90t/lGuV6IGp2ND2
	Lk9x0+HQGi5A==
X-Google-Smtp-Source: AGHT+IGZSDeAO48D3tedMyY+HBSJI/Xp2VnirJeIrAQRbOY2s8lt8ukKFjvdpK871/HD7tUSd8Lkrw==
X-Received: by 2002:a05:600c:a08d:b0:455:f6cd:8703 with SMTP id 5b1f17b1804b1-4587852b2e9mr17701705e9.31.1753460768023;
        Fri, 25 Jul 2025 09:26:08 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4? ([2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abc2804sm2320855e9.5.2025.07.25.09.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 09:26:07 -0700 (PDT)
Message-ID: <2655eea8-e598-4c26-a7dc-a8c6b494a68b@gmail.com>
Date: Fri, 25 Jul 2025 17:26:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
 Jann Horn <jannh@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250721090942.274650-1-david@redhat.com>
 <3ec01250-0ff3-4d04-9009-7b85b6058e41@gmail.com>
 <601e015b-1f61-45e8-9db8-4e0d2bc1505e@redhat.com>
 <99e25828-641b-490b-baab-35df860760b4@gmail.com>
 <0905a63e-420e-484f-a98b-19e85fc851fa@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <0905a63e-420e-484f-a98b-19e85fc851fa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/07/2025 14:08, David Hildenbrand wrote:
> On 25.07.25 00:27, Usama Arif wrote:
>>
>>> Hi!
>>>
>>>>
>>>> Over here, with MMF_DISABLE_THP_EXCEPT_ADVISED, MADV_HUGEPAGE will succeed as vm_flags has
>>>> VM_HUGEPAGE set, but MADV_COLLAPSE will fail to give a hugepage (as VM_HUGEPAGE is not set
>>>> and MMF_DISABLE_THP_EXCEPT_ADVISED is set) which I feel might not be the right behaviour
>>>> as MADV_COLLAPSE is "advise" and the prctl flag is PR_THP_DISABLE_EXCEPT_ADVISED?
>>>
>>> THPs are disabled for these regions, so it's at least consistent with the "disable all", but ...
>>>
>>>>
>>>> This will be checked in multiple places in madvise_collapse: thp_vma_allowable_order,
>>>> hugepage_vma_revalidate which calls thp_vma_allowable_order and hpage_collapse_scan_pmd
>>>> which also ends up calling hugepage_vma_revalidate.
>>>>> A hacky way would be to save and overwrite vma->vm_flags with VM_HUGEPAGE at the start of madvise_collapse
>>>> if VM_NOHUGEPAGE is not set, and reset vma->vm_flags to its original value at the end of madvise_collapse
>>>> (Not something I am recommending, just throwing it out there).
>>>
>>> Gah.
>>>
>>>>
>>>> Another possibility is to pass the fact that you are in madvise_collapse to these functions
>>>> as an argument, this might look ugly, although maybe not as ugly as hugepage_vma_revalidate
>>>> already has collapse control arg, so just need to take care of thp_vma_allowable_orders.
>>>
>>> Likely this.
>>>
>>>>
>>>> Any preference or better suggestions?
>>>
>>> What you are asking for is not MMF_DISABLE_THP_EXCEPT_ADVISED as I planned it, but MMF_DISABLE_THP_EXCEPT_ADVISED_OR_MADV_COLLAPSE.
>>>
>>> Now, one could consider MADV_COLLAPSE an "advise". (I am not opposed to that change)
>>>
>>
>> lol yeah I always think of MADV_COLLAPSE as an extreme version of MADV_HUGE (more of a demand
>> than an advice :)), eventhough its not persistant.
>> Which is why I think might be unexpected if MADV_HUGE gives hugepages but MADV_COLLAPSE doesn't
>> (But could just be my opinion).
>>
>>> Indeed, the right way might be telling vma_thp_disabled() whether we are in collapse.
>>>
>>> Can you try implementing that on top of my patch to see how it looks?
>>>
>>
>> My reasoning is that a process that is running with system policy always but with
>> PR_THP_DISABLE_EXCEPT_ADVISED gets THPs in exactly the same behaviour as a process that is running
>> with system policy madvise. This will help us achieve (3) that you mentioned in the
>> commit message:
>> (3) Switch from THP=madvise to THP=always, but keep the old behavior
>>       (THP only when advised) for selected workloads.
>>
>>
>> I have written quite a few selftests now for prctl SET_THP_DISABLE, both with and without
>> PR_THP_DISABLE_EXCEPT_ADVISED set incorporating your feedback on it. I have all of them passing
>> with the below diff. The diff is slightly ugly, but very simple and hopefully acceptable. If it
>> looks good, I can send a series with everything. Probably make the below diff as a separate patch
>> on top of this patch as its mostly adding an extra arg to functions and would keep the review easier?
> 
> Yes, we should do it as a separate patch, makes our life easier, because that requires more work.
> 
> We require a cleanup first, the boolean parameter for __thp_vma_allowable_orders() is no good.
> 
> I just pushed something untested to my branch (slightly adjusted patch#1 + 2 more patches), can you have a look at that? (untested ... :) )
> 

Thanks for this!
I tested it and its good, have sent it for review.



