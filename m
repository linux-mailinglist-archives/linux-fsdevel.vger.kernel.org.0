Return-Path: <linux-fsdevel+bounces-41352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43923A2E327
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 05:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252B23A69B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 04:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2873D2AE95;
	Mon, 10 Feb 2025 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FlO6h95I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627717591
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739162129; cv=none; b=fk17v1i6hLBtKYAbslP16/v6ebvYHouw2k5WFlUFRxtoEtAqxH9Mw3o2D/xXizWGuNy0ru0h+OKtMtxuKOKDsUii8SnljZuhvN1AIfq6Xp7AeS65CQV5blhO3wqiW6oAzodcufknuwzYr42HPJB3oIVK8I7iMjAAgWcOGDekHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739162129; c=relaxed/simple;
	bh=6zXA2nICixTsXvoRh3y3rP4oz/t/6aD2ARbIp7m6vcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9zErWSzJrPO/NQ4bWNaJsybukf/Cf17KqDnOgHl7v/Pvi7u3fdfUhmO3/oMFwaAo3oGv5guHH84AWdJKcgiwPBAWMZwL0oEXGm7L1JRXKwfSagugb7HOofSCPdaED1LH7C5EZOVfdrtQykk7lpJB25+/9yYd7MPFUBvvPRiK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FlO6h95I; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21fa56e1583so1376695ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 20:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739162127; x=1739766927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4k+2eKN7MR4K/4ZDf+BKX5koeLl+w9WZxMDBzA9nIzw=;
        b=FlO6h95I1GNztOB7Z9zC4m1Z6CRmobMdOC3/q4Ow/U+INCHRcbM0ZkLNIO3/+PE70E
         RFZn5vs5gckTteD3haoj2LK2CMKAb3X8FiJIKP2ARPv52U+yDcI6Q+KFn9QSf6p0+Lka
         5SgpVESsNC++riACMMY0Rckw79I/fBJ5uFpgdTMlTakspdCpa8lorfriGCq1f8dfr0DF
         TaW2gLsr+iruUdpxbkXTG0aCiXHeFWAzWUvVv2udSlpYrIyuORliVQOO2iKXIGOq5ywE
         A3NOneflnOvQ2hC1sNHyrE8jcoW7uC+P74opSskKTtkNyClemAubLYjKIYG9tSwGqa7k
         5OKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739162127; x=1739766927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4k+2eKN7MR4K/4ZDf+BKX5koeLl+w9WZxMDBzA9nIzw=;
        b=mBTdTRF159Shnvb1QwTqFZi+r3zHWmNXzsC82HjMpp67OC8a8hMZe77NeTsDQxwZvf
         BoTRoNw+rdkvvApdyRvlRGeIGp1fzWg/TPqRHYwA5FgvVfv3ety/3Zw5Gblf1BXUSa+9
         oLXJeJ5SBza8MwK06TbEmWaVygrS3Bh2JoTUON+v4h26+7Ia6hNYW5fMxs+YJ8Aza+67
         BAR6d/xeTv5DcPnYG9N5sylWPE5BUp9+8oaQv+RZ6op8dpYLfVC9YUmXA29uaRpNurbN
         sWPG6lj3ODx07Y6+vn5Nne04u6tOn+wJajMLqDtLI9X8wmiR7AqCp3hO6cW66SbTDGa+
         nvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyeSBdDRfguQKk7i9rACbybwcReb4koqQykCAIpV5pmQ6elb+lHYqSNrvIGagIs5BlphPOoIRj0hVH/FcL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyugdf1hNjL0/mdqxUdbx5TRmWe8uvVToJQKqCKUojYK2evy0I0
	sAhiu2cJxuBXpHuf99wGRAoWNG1QEAZsww9WMkggV/awbX4uNlg0F0eoVyiNY2I=
X-Gm-Gg: ASbGncvaWqMeFVYUw3/pGcstLTli/1f43bRinsnQws5PRkw1lTnXvmzGKzICS0m/jED
	GXAwN+IaUeeIPS6CbGUejZO/rW8uskCdU635i5x6pdbqzm1Kk5AFAKfrmiF80DT1KQ4KcsRq6WQ
	A28B8h6MGHatuALe8Pw5SiSlmYDs4mgvkx0TQEcXgQeZDE/TkfkDuBBTjALRbMLl69957agSaln
	GylYIm5mJ5GWlDCPgwxgJzoiB4+CGOZ//4Q5gIE8EBUSSlwDDRmeFLTc5twdjlgZVdYnj0HIchc
	luXUiqx+i/7MmQxO+epgPkieWwd6UjHqpn6JvR2A3A==
X-Google-Smtp-Source: AGHT+IGj0Tsny1gbgtf4jJeZ3T2wO3uBzl26/s92Vc6vCYy4nk+04NyXUv1q0+u2fRpURAl3hdxpPg==
X-Received: by 2002:a17:902:f687:b0:21f:9c7:2d2e with SMTP id d9443c01a7336-21f4e72dcb3mr192643605ad.40.1739162127353;
        Sun, 09 Feb 2025 20:35:27 -0800 (PST)
Received: from [10.84.150.121] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36551885sm67619525ad.88.2025.02.09.20.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 20:35:26 -0800 (PST)
Message-ID: <42ee133a-870c-4d7b-afc5-f551d259db9c@bytedance.com>
Date: Mon, 10 Feb 2025 12:35:23 +0800
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
 Christian Brauner <brauner@kernel.org>, "Darrick J . Wong"
 <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
 <Z6aGaYkeoveytgo_@casper.infradead.org>
 <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
 <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
 <AD32F66E-777A-43D4-8DFB-F2D5402AD3F4@nvidia.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <AD32F66E-777A-43D4-8DFB-F2D5402AD3F4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/10 12:18, Zi Yan wrote:
> On 9 Feb 2025, at 23:02, Qi Zheng wrote:
> 
>> Hi Zi,
>>
>> On 2025/2/10 11:35, Zi Yan wrote:
>>> On 7 Feb 2025, at 17:17, Matthew Wilcox wrote:
>>>
>>>> On Fri, Feb 07, 2025 at 04:29:36PM +0100, Christian Brauner wrote:
>>>>> while true; do ./xfs.run.sh "generic/437"; done
>>>>>
>>>>> allows me to reproduce this fairly quickly.
>>>>
>>>> on holiday, back monday
>>>
>>> git bisect points to commit
>>> 4817f70c25b6 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64").
>>> Qi is cc'd.
>>>
>>> After deselect PT_RECLAIM on v6.14-rc1, the issue is gone.
>>> At least, no splat after running for more than 300s,
>>> whereas the splat is usually triggered after ~20s with
>>> PT_RECLAIM set.
>>
>> The PT_RECLAIM mainly made the following two changes:
>>
>> 1) try to reclaim page table pages during madvise(MADV_DONTNEED)
>> 2) Unconditionally select MMU_GATHER_RCU_TABLE_FREE
>>
>> Will ./xfs.run.sh "generic/437" perform the madvise(MADV_DONTNEED)?
> 
> Yes. See: https://github.com/kdave/xfstests/blob/master/src/t_mmap_cow_race.c#L34

Got it.

> 
>>
>> Anyway, I will try to reproduce it locally and troubleshoot it.
> 
> You will need xfstests and run "while true; do sudo ./check "generic/437"; done".
> 
> The local.config for xfstests is at:
> https://lore.kernel.org/linux-mm/20250207-anbot-bankfilialen-acce9d79a2c7@brauner/

OK, will do. Thanks!

> 
> 
> --
> Best Regards,
> Yan, Zi

