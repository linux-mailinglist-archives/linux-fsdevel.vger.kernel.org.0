Return-Path: <linux-fsdevel+bounces-41381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DBFA2E723
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 10:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50DA3A170B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA271C302E;
	Mon, 10 Feb 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MyyDtAHL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3A155A59
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739178019; cv=none; b=tKP1HlKKpife3WJd+PWwj4QbvMn885ChRZE8FKulf1kLQ3lwMRi1OvneT5h0jvMxCNAN50nW161r+OlHvszrfKvEVNf4sGfiyE7Od4H3GKMMkJGvNha5lNPHC2E37FyotqRYBVjlWZHa7y9dtrwrGgkhJOfrwGI95yYD7dDbJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739178019; c=relaxed/simple;
	bh=Gx3oH7vjpleExwV01JXJCt9QsJcnOyPLBFMdij9kBlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6jQiCxMZp4NpxqJB0rjqtFI2BGaBSIPF94Ve8VwfT1LxEwMZB35LmVSDHQawp6tKcUed9lt1mvurWLyrgG/7213k87mGez+ly3EA5B9qrtyJWCrjrc7XJ/MEQOKoV+GuKI+onqjJcb7qRmqzCHIlGiVRTc/DxJ8BuKgAopfbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MyyDtAHL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f44e7eae4so61477615ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 01:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739178016; x=1739782816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9SV/KBFhD6Fda0VnlvUomEfZ86TEAFjs4kVe2jPYeg=;
        b=MyyDtAHLVcLuWH8zjEZ3mnSyAl3z1T0RXVyajmzCod3CEEAplxK0PS/bi1/a6CvalH
         jirjZUMEgLiqFw1zgyPzwrnc8/sRdZorNEOTIwIGmqlBUueHeH9vQkJNTXwi67BvI2U+
         H9LU0bZ49IMRFUdPpSC+EWkSvDMrwvlkKqtKRn+aOIptpjwmiK9FmvlF8OOu3erAzrhK
         yRev74Zm9wU+SdsUQBGeQrOFbyxuJOWblVmOIwufGnYOD7YHxME1QtuPwFRRKPFP3Tgu
         uvBa6NxlPrxk/lSLpxBaUG6fLTZ6ry7Ij6Z60sMbumQCx2oRQhUS+pTq9+QCoJLBdMmz
         aZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739178016; x=1739782816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9SV/KBFhD6Fda0VnlvUomEfZ86TEAFjs4kVe2jPYeg=;
        b=SV+WGmnby5bSUmB9oPctNaapcZs1xiLL2ULXpL2Nlz/2LpDMJ/irYEUZQsQGxS+4+k
         IV43f2WIrPFTNG7G9DvXvVtcFcO+xwBKO/0kcoYha2yy9+icwFdCV1sdfKFK+Qygkf3x
         V+ePWhE4yFGRPuVkgZ8bnkK5JfWibosJGXKaBTYbIXWR8eAzJnGy2AWziwY9T4saFvih
         b0thbHq1kOHF/k70MT64WMDktd9uLog+fuzDfuqfyUAdSsYZ0i879fQbAYBrn/tm/AQo
         oFihDqfexI3V/ACzkKSvJQVBF08MhWAJvVvGpis6GjjUFOEH/G2NmgcxlKTgTTyiXRzP
         BL1w==
X-Forwarded-Encrypted: i=1; AJvYcCUT0t5clH4JldB4vG+kGm1pI0SWJLoMp5ZlhLSus//jSs5V2aSRbp7NOkcIRK27uYv7RtzafjKQ0KWphXpS@vger.kernel.org
X-Gm-Message-State: AOJu0YxELWICrQcxbcr4y/+hwgWogkcC2W/BEkJN5I5c+UGvkDTSQ1zS
	8xy+8dle1JvdGon25JaqT9UvTIc1Vse3nGcPxjR/HEGQHWxHr1vgy9YQYUnKapE=
X-Gm-Gg: ASbGncv/Tk0BtpIEp8UrtqyPA5cGHwHuFYW34G1Mix+HsxGBMtuFWXi7h3hZMj3ptlG
	zL0ZeO53AXEBkTtNVcR458187fnsJTrouYfCbGVDedgR4slyXEC9xfoY3sTOaGhxSsOvYg9tE4o
	8cxBf8vdQxJ/wL/m//QSEvLJ+Ua/CLAMHqdVhYXKJofHjkWPTtq6dn1bTQnZiXnj+4lSd7PsM8j
	qW5YK1SlsvCEHwQ3GIaTB1C9UHoDoSpvhx50eJPLaRstVmvF7JHLR7Pr2dLb+ik04ggW3GjN4iu
	PharEWbsFQ1W8/aBplZHQ+yRCs3PdrXhwpiZIqRlAQ==
X-Google-Smtp-Source: AGHT+IFEOkC+0/zuM1UD849y9ikHusLLu7U7zyLrYxwfstCH1IFRakpOJpQGWn8u85whPC18PpHlew==
X-Received: by 2002:a17:902:e547:b0:215:9f5a:a236 with SMTP id d9443c01a7336-21f4e6a5751mr173530685ad.6.1739178015698;
        Mon, 10 Feb 2025 01:00:15 -0800 (PST)
Received: from [10.84.150.121] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa5312f4c5sm4281921a91.8.2025.02.10.01.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 01:00:15 -0800 (PST)
Message-ID: <81834761-5537-41dc-813d-63c947bba5a5@bytedance.com>
Date: Mon, 10 Feb 2025 17:00:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xfs/folio splat with v6.14-rc1
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Jann Horn <jannh@google.com>,
 "Darrick J . Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
 <Z6aGaYkeoveytgo_@casper.infradead.org>
 <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
 <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
 <dda6b378-c344-4de6-9a55-8571df3149a7@bytedance.com>
 <669898c1-e998-461d-9381-9143a3cb39c2@gmx.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <669898c1-e998-461d-9381-9143a3cb39c2@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/10 16:50, Qu Wenruo wrote:
> 
> 
> 在 2025/2/10 18:48, Qi Zheng 写道:
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
>> @@ -1721,7 +1721,7 @@ static unsigned long zap_pte_range(struct 
>> mmu_gather *tlb,
>>          pmd_t pmdval;
>>          unsigned long start = addr;
>>          bool can_reclaim_pt = reclaim_pt_is_enabled(start, end, 
>> details);
>> -       bool direct_reclaim = false;
>> +       bool direct_reclaim = true;
>>          int nr;
>>
>>   retry:
>> @@ -1736,8 +1736,10 @@ static unsigned long zap_pte_range(struct 
>> mmu_gather *tlb,
>>          do {
>>                  bool any_skipped = false;
>>
>> -               if (need_resched())
>> +               if (need_resched()) {
>> +                       direct_reclaim = false;
>>                          break;
>> +               }
>>
>>                  nr = do_zap_pte_range(tlb, vma, pte, addr, end, 
>> details, rss,
>>                                        &force_flush, &force_break, 
>> &any_skipped);
>> @@ -1745,11 +1747,12 @@ static unsigned long zap_pte_range(struct 
>> mmu_gather *tlb,
>>                          can_reclaim_pt = false;
>>                  if (unlikely(force_break)) {
>>                          addr += nr * PAGE_SIZE;
>> +                       direct_reclaim = false;
>>                          break;
>>                  }
>>          } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
>>
>> -       if (can_reclaim_pt && addr == end)
>> +       if (can_reclaim_pt && direct_reclaim && addr == end)
>>                  direct_reclaim = try_get_and_clear_pmd(mm, pmd, 
>> &pmdval);
>>
>>          add_mm_rss_vec(mm, rss);
>>
>> I tested the above code and no bugs were reported for a while. Does it
>> work for you?
> 
> Tested 128 generic/437 runs with CONFIG_PT_RECLAIM on btrfs.
> No more crash, will do a longer run, but it looks like to get the bug 
> fixed.

Thank you for testing so quickly!

> 
> Before the fix merged, I'll deselect PT_RECLAIM as a workaround for my 
> runs on btrfs/for-next branch.

Sorry for the inconvenience. I will submit a formal fix patch after
testing it for a longer period of time.

Thanks,
Qi

> 
> Thanks,
> Qu
> 
>>
>> Thanks,
>> Qi
>>
>>>
>>> Thanks!
>>>
>>>>
>>>> -- 
>>>> Best Regards,
>>>> Yan, Zi
> 

