Return-Path: <linux-fsdevel+bounces-48949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9267AB6703
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 11:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DC33A816C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 09:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6C221F0D;
	Wed, 14 May 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPUJYg+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D81DFE8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213890; cv=none; b=NBmVB+HFV48LPMQd8aYp2ADbBA3h31VN5MMM6Yy7Wn41IfukPY5B2RVDL2Ex4xpcHOL8lVQwLE/ZwtUsB2Nlvo8Eey6EqJnwBVfkYZscXYfF5k/5Pwz19Ddo7BCI9vZVLobNJOlkyr89ETJlb+UsSJjjbDFgKSofOrquLCZISOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213890; c=relaxed/simple;
	bh=HvyjCbzUd5/Mp1b55Kqz/7qNG+fmJl75hwbZe6oyT5c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bdt7ZU/JO/4AGI5zYzEnv5K4UhvuBJuQcd49i6vwwuCg3ShXBrLidmbZfAI6Cdi0RNE3qpihItK8NxboAe9ElIoR6A+FqL5yJf3TuPsb+xot6+XZ8X6z2/cITLiGE/bmw3mpgfaEOD1YVIqd9ukLcimWkZ8QhvlDvtvwJzdMfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPUJYg+R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747213887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mbjkb6JTJAsuy38qD4oeTgqwyUosO6GgDAb+t/G8/WQ=;
	b=ZPUJYg+RfJi7YUdp+BCS7E6eZ2oMePJ6nNRaA1lqvFPFRWBTo51nLJVV0Zt33YusZh9RLc
	U57kAKIBMMLXLmy2rNhwQErxSZQo88mgYzuB4ZhpiPa7xfjXqmcfTztOiplyADyml+Pd4t
	n5HJ4+Ir23qaTZJjhYkz5R036uqo6Uk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-281uheiLOBqS6wGkg49TWw-1; Wed, 14 May 2025 05:11:25 -0400
X-MC-Unique: 281uheiLOBqS6wGkg49TWw-1
X-Mimecast-MFC-AGG-ID: 281uheiLOBqS6wGkg49TWw_1747213885
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a2057d164bso1176703f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 02:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747213884; x=1747818684;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mbjkb6JTJAsuy38qD4oeTgqwyUosO6GgDAb+t/G8/WQ=;
        b=GAYopZUWaGotqG08SsbzvPQ0kc9TXRHQSbwARwPnRQUmxKTNx0/VDzlLGjAdPTdR1Y
         F1WO9AZwEGGKWdz9tU1lokHTPpf0KjpqJZg8ujXtw8XLcgwl1kAVk3nrYn2nB1RSau7k
         UEptay+6yA96ay692eF4Z6LWYGTHE+o2bg0fJzZoFiruY6OH6QlEhKgVJuPhu+iJbtrA
         QdzVEzUsjf98EeNYwaLcLYAJt4RdpbwC64enCYd1cNWVV3B0PpVoZ5RCE1CbWgllPkoc
         GEtAPTTTrCncCM1i5L2bUK8kBz0iFu8vmgMbsSRiBjbxCUFW2sDOtEh5Q8Z1rIwwUbEV
         d9zA==
X-Forwarded-Encrypted: i=1; AJvYcCVAWFVUsy2g0oWFjuo1T5ybCfxLqpyfMzPDxujjGdmwOlIfr3qxmlzlfVTwMg+UEQQR2ZcpIqUVvUScgLgX@vger.kernel.org
X-Gm-Message-State: AOJu0YyF50tgz1s0RWIcmppu4y9evBtFsmjRrl/XMuVJprWIM6wX2oi6
	E2rtNauiTZU1XA9qr9STG8rHo/mLJYSCUCVc8t78x9YdxP5UJ6fs8SjRWxZl+zuzy2IwHn+pDDJ
	8z5AAIfgxj+8/ZGxBeO2Ahxbe7wFuAJ93SBgZxQALq88q+mRRcKCQJfDnaun9L8E=
X-Gm-Gg: ASbGnctsOBT3Vtd5ZK6gsrkuqhHSuzm/tzvUdqwGVY50KLgrSQmL20Aju2ntj77MI3k
	oCzEj3ElmzV7p9XRLLcCm7+FPoy5A4VvKoX/ptWVJ8fz+ThOTP8nqiPvs7HAoFwrZgyFnjBdQOx
	OG7ppV3irargR0oLc6mUHigP0+JPTwntHKc+/bBIObAPG6Igzf/yKQumwMLgRN99SmOC5yd/54W
	Nq5HWGIjm6agamptXZbc8zdxyzH4bFyItJkXc4tBIdDAdI3sHzXdlufi9FR0WPnhv7XNSFEz4TB
	axXGgsmdFJA9SAjXz6NvQWmv49/EL4ZAKWXkdQldZD5HYiAgqZlyY6BoNZs8qFcJYC9UurF8qTA
	lwLqpdrxT17bhsoBTnnlf0KyWnqHTS8CCT76lZFA=
X-Received: by 2002:a5d:5f91:0:b0:3a0:7017:61f6 with SMTP id ffacd0b85a97d-3a3496a40f6mr2274306f8f.14.1747213884683;
        Wed, 14 May 2025 02:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzKwUpB8LZoEPItaEpiT42Rn95TAirv2fF/YHfvGZfDLHpm/T3BLxuSWtpEUruW+FjHC9Emg==
X-Received: by 2002:a5d:5f91:0:b0:3a0:7017:61f6 with SMTP id ffacd0b85a97d-3a3496a40f6mr2274276f8f.14.1747213884315;
        Wed, 14 May 2025 02:11:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ec8f1sm18679910f8f.26.2025.05.14.02.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 02:11:23 -0700 (PDT)
Message-ID: <8d11bb04-2feb-4189-adbd-5f27819d2095@redhat.com>
Date: Wed, 14 May 2025 11:11:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove WARN_ON_ONCE() in file_has_valid_mmap_hooks()
From: David Hildenbrand <david@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
 <357de3b3-6f70-49c4-87d4-f6e38e7bec11@redhat.com>
 <f7dddb21-25cb-4de4-8c6e-d588dbc8a7c5@lucifer.local>
 <f3d52fe7-991f-4fd1-a326-6e8bfe54ddec@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f3d52fe7-991f-4fd1-a326-6e8bfe54ddec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.05.25 11:10, David Hildenbrand wrote:
> On 14.05.25 10:56, Lorenzo Stoakes wrote:
>> On Wed, May 14, 2025 at 10:49:57AM +0200, David Hildenbrand wrote:
>>> On 14.05.25 10:40, Lorenzo Stoakes wrote:
>>>> Having encountered a trinity report in linux-next (Linked in the 'Closes'
>>>> tag) it appears that there are legitimate situations where a file-backed
>>>> mapping can be acquired but no file->f_op->mmap or file->f_op->mmap_prepare
>>>> is set, at which point do_mmap() should simply error out with -ENODEV.
>>>>
>>>> Since previously we did not warn in this scenario and it appears we rely
>>>> upon this, restore this situation, while retaining a WARN_ON_ONCE() for the
>>>> case where both are set, which is absolutely incorrect and must be
>>>> addressed and thus always requires a warning.
>>>>
>>>> If further work is required to chase down precisely what is causing this,
>>>> then we can later restore this, but it makes no sense to hold up this
>>>> series to do so, as this is existing and apparently expected behaviour.
>>>>
>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>> Closes: https://lore.kernel.org/oe-lkp/202505141434.96ce5e5d-lkp@intel.com
>>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> ---
>>>>
>>>> Andrew -
>>>>
>>>> Since this series is in mm-stable we should take this fix there asap (and
>>>> certainly get it to -next to fix any further error reports). I didn't know
>>>> whether it was best for it to be a fix-patch or not, so have sent
>>>> separately so you can best determine what to do with it :)
>>>
>>> A couple more days in mm-unstable probably wouldn't have hurt here,
>>> especially given that I recall reviewing + seeing review yesterday?
>>>
>>
>> We're coming close to end of cycle, and the review commentary is essentially
>> style stuff or follow up stuff, and also the series has a ton of tags now, so I
>> - respectfully (you know I love you man :>) - disagree with this assessment :)
>>
>> This situation that arose here is just extremely weird, there's really no reason
>> anybody should rely on this scenario (yes we should probably try and chase this
>> down actually, perhaps though a driver somehow sets f_op->mmap to NULL somewhere
>> in some situation?)
>>
>> So I think this (easily fixed) situation doesn't argue _too_ much against that
>> :)
> 
> Again, I am talking about a couple more days, not weeks or months ;)
> 
> At least looking at the report it sounds like something the test bots
> would usually find given a bit more time on -next. I might be wrong.
> 
> next-20250500 had the old version without WARN

^ for completeness, next-20250509

-- 
Cheers,

David / dhildenb


