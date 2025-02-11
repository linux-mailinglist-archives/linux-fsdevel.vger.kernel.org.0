Return-Path: <linux-fsdevel+bounces-41502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24831A301A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 03:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578487A28B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 02:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E51CD1FD;
	Tue, 11 Feb 2025 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NnIqdFut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4B26BDBF
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241793; cv=none; b=aPRl9tZ1UdofUCOLtR7W0W/hUDdCkzAgRUfHezL6GnNesHbCLztgXmp19KUkGfNjocaC9epd6HOH1ROMTxDycSMnUuFA66ygwAkZzfgublD3zZ5KvgA+lJQDrXeMbI/fTsU5Otxa0gG/8MA4CcZOJlEr9SK+PB2hdgK6/kBvdro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241793; c=relaxed/simple;
	bh=SnrILxBvVbQ0cRNiroVouG4W+Eu+lgpyCFoKaXn2Nck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=neV8tisNmz0Az201+b8AZ32E4YlHVGPuW9mK8TiCrcTTSkJKnS7+d2FV+k4faNNvaZz1sF5ImqGtCfl0JMiJb4TmU3vyuvSVw0U7pX7t1vIO0quwDygHz5LdTAmiJmHXCGc7IlVZFo/mJpsQJludHPvCdKiGA84IH5T2szT0eMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NnIqdFut; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f61b01630so50580025ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 18:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739241790; x=1739846590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKziBAtg1HbGc0JeoxKdx+SKqD36Jtb1BCQ3ewTgytY=;
        b=NnIqdFutHYTXD/ZSYT262ogBJR2LVzqI1BOyB8mymKwwjaKldgosFH4t+MiM7QPQlY
         p5PYmiXXCzce8waZIDAx/StIC3ki2rQUXkKZG5oImXjLbf3qH63iat/ZMF/jEHkZANm+
         8Uo448CYDS7h6Ie44xmc9R9YkWaMIXFN/zUlTDYTIgzIZljDDhQBQyZs2kWloXBU/R8/
         E1qSUIu/PG6ZwHA7u4bjsxuSjYWumopj1RMuD6i+c/0WFPNYu3nJPIejZlNfa4g8FQzC
         SP34lUw2USXAyEXsxoD5FtCcHONFxH2PRE/OOXj28f/i7GJptN7rswErbsS5jWCSaY9s
         H51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739241790; x=1739846590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKziBAtg1HbGc0JeoxKdx+SKqD36Jtb1BCQ3ewTgytY=;
        b=MIet1Fsp/YR9vKIcVDnlCT1tbnAzuhcIsoJKWrJhF+e1kwCy1xGsy9hPADnXZwz31d
         L355pH/iitrfEDg6crdeMxi0xY3g1OXxt2+9Gp091rv2usExXO7zEK3/g9mffG+958s3
         7TIKPs8by3vtCYfBp2Q0lrP80qoctjE902GQK1J721GC4xe+6ZldHxXXMETlaNoAjvjb
         QUIdX9/XvPAKLU0vGa6qHbZ73LCKLnqP50ir59bDr5pxiGwHASdjzzxdi0sVnGqG0XnB
         ZA/vU0AZe5C7EWQ5rqKDUgQgDiDWQx/aEF9sxKLcU0gHeab0V+azFAq1V90yoPDxpdgv
         fjOA==
X-Forwarded-Encrypted: i=1; AJvYcCU4R9g5sranKXnx9SGZxvHzLtYLcKmynKWzABcEx1IGbn5QVpl8QT7QuoiCDXmKZD97geLoRk1dZtx8pWSS@vger.kernel.org
X-Gm-Message-State: AOJu0YzhKuJe0UOlEoArC29fZBts7aB0CzhcJKzj0HU7Ce3umo7/6+mz
	yTB/xZKI6gC2tTWNtxKqasBEOantNgqF2LKbX695Hq48/qBTBmeZxRX2DE6SFiJbmqMr1JoxZy1
	O
X-Gm-Gg: ASbGncuaI7m32cM+YprBfc3apNhNWcsCUd4aoXJpRTvNAOvIuD9ms4kM5puuPdwGYgm
	l6u1TUYH0Y6HQNPQ2fSyx8mCOYIDh8oFMcUvxCGxGNCI29C/ggoUbJ6E4m4kSQfSwux1fJ/S4rx
	ngs7juQkDrEInxSi+d+BguCsZ5Bo7Va6XnEKw5DlYX0PLvnqAfc8+yxlyC62suEerBR6ZFe7dmI
	TE8+vQWlAAD+LyPVJyca17nGgjr9B1EAa3lzgkIERmMXLRpcXnDSzD3dWlmj+QYxV3fMnqLsxzK
	gYHRPwTdazFeCzKgeoUf1YbrK+yITxUX5vJQH9eiDw==
X-Google-Smtp-Source: AGHT+IFlEAc+CgziEvPOi9yauHYGiTs+Qr4sD978MXRUIfJA2SzIAo/wb3fB3Fzd3ri1y7dsaJ0SWA==
X-Received: by 2002:a05:6a20:430b:b0:1e1:9e9f:ae4 with SMTP id adf61e73a8af0-1ee4b6eb26dmr2442064637.13.1739241790209;
        Mon, 10 Feb 2025 18:43:10 -0800 (PST)
Received: from [10.84.150.121] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73089afd0cdsm3307414b3a.134.2025.02.10.18.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 18:43:09 -0800 (PST)
Message-ID: <7bc425c1-2b4a-4221-afa5-5c7230e85a0a@bytedance.com>
Date: Tue, 11 Feb 2025 10:43:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xfs/folio splat with v6.14-rc1
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Jann Horn <jannh@google.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
 <Z6aGaYkeoveytgo_@casper.infradead.org>
 <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
 <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
 <dda6b378-c344-4de6-9a55-8571df3149a7@bytedance.com>
 <CD159586-D306-478B-8E73-AEDA90088619@nvidia.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CD159586-D306-478B-8E73-AEDA90088619@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/10 22:12, Zi Yan wrote:
> On 10 Feb 2025, at 3:18, Qi Zheng wrote:
> 
>> Hi all,
>>
>> On 2025/2/10 12:02, Qi Zheng wrote:
>>> Hi Zi,
>>>
>>> On 2025/2/10 11:35, Zi Yan wrote:
>>>> On 7 Feb 2025, at 17:17, Matthew Wilcox wrote:
>>>>
>>>>> On Fri, Feb 07, 2025 at 04:29:36PM +0100, Christian Brauner wrote:
>>>>>> while true; do ./xfs.run.sh "generic/437"; done
>>>>>>
>>>>>> allows me to reproduce this fairly quickly.
>>>>>
>>>>> on holiday, back monday
>>>>
>>>> git bisect points to commit
>>>> 4817f70c25b6 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64").
>>>> Qi is cc'd.
>>>>
>>>> After deselect PT_RECLAIM on v6.14-rc1, the issue is gone.
>>>> At least, no splat after running for more than 300s,
>>>> whereas the splat is usually triggered after ~20s with
>>>> PT_RECLAIM set.
>>>
>>> The PT_RECLAIM mainly made the following two changes:
>>>
>>> 1) try to reclaim page table pages during madvise(MADV_DONTNEED)
>>> 2) Unconditionally select MMU_GATHER_RCU_TABLE_FREE
>>>
>>> Will ./xfs.run.sh "generic/437" perform the madvise(MADV_DONTNEED)?
>>>
>>> Anyway, I will try to reproduce it locally and troubleshoot it.
>>
>> I reproduced it locally and it was indeed caused by PT_RECLAIM.
>>
>> The root cause is that the pte lock may be released midway in
>> zap_pte_range() and then retried. In this case, the originally none pte
>> entry may be refilled with physical pages.
>>
>> So we should recheck all pte entries in this case:
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index a8196ae72e9ae..ca1b133a288b5 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1721,7 +1721,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>          pmd_t pmdval;
>>          unsigned long start = addr;
>>          bool can_reclaim_pt = reclaim_pt_is_enabled(start, end, details);
>> -       bool direct_reclaim = false;
>> +       bool direct_reclaim = true;
>>          int nr;
>>
>>   retry:
>> @@ -1736,8 +1736,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>          do {
>>                  bool any_skipped = false;
>>
>> -               if (need_resched())
>> +               if (need_resched()) {
>> +                       direct_reclaim = false;
>>                          break;
>> +               }
>>
>>                  nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, rss,
>>                                        &force_flush, &force_break, &any_skipped);
>> @@ -1745,11 +1747,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>                          can_reclaim_pt = false;
>>                  if (unlikely(force_break)) {
>>                          addr += nr * PAGE_SIZE;
>> +                       direct_reclaim = false;
>>                          break;
>>                  }
>>          } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
>>
>> -       if (can_reclaim_pt && addr == end)
>> +       if (can_reclaim_pt && direct_reclaim && addr == end)
>>                  direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
>>
>>          add_mm_rss_vec(mm, rss);
>>
>> I tested the above code and no bugs were reported for a while. Does it
>> work for you?
> 
> It also fixed the issue I see on xfs as well.

Got it. And my local test reported no more issues overnight.

> 
> Tested-by: Zi Yan <ziy@nvidia.com>

Thanks! Will send a formal fix patch.

> 
> --
> Best Regards,
> Yan, Zi

