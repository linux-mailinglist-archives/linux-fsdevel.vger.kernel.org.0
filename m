Return-Path: <linux-fsdevel+bounces-56767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9905B1B695
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F166A177CB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DBB27814F;
	Tue,  5 Aug 2025 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk+WWLhu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910E1A3167
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404371; cv=none; b=TEjV3u60sqrlYrHdljYzRW3zYzzQfU3upa07Jf+7HnI1CAukcKKSPHnCTbvWrJCi+zbDujx/rGWR24n3Jg9JsriPu/qgT7ci2YDw6ymKv4+KJa6v5ohZIWEzLyM7d3qhvPlbDz4fKLdO90tqJv6m+1L3c89qBL+AQHAEGH2P23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404371; c=relaxed/simple;
	bh=YFhQDbQyUvq9nOr/KAP7iSQM+9HaKt7+3cBX30HP2vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJmbd98BxYYwbIwtKXmWEtkO1IjDEFV6jQKr0BgStqnhT8/dMQP2wbLmFPsr5wDk5cnb4Mk7pAmoBHKdSfUaPCy0+pV4yEMo0Y8A6maMbcuA2R4a2hOkRi0msaAUr7EdPLzqGmDrOV/+dbcct/m9Th9/8VPfA+r43EVSGNUoDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xk+WWLhu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754404368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ix3nGBaIbmH4NveMsKrbtk5kqoYYY0SEMHv1/oWenw8=;
	b=Xk+WWLhujQ86Js3pockCTrh6v8MJx+76NUavn9ERD+xdlj29C4/se9vOohqwt81myTVhzy
	iHSSsE+8Y9ub+AutdwmsP1NwvpgYSHTvUoq/Y2k4BsoYfn3szaGv20Ij3RMiXzOHiEexTC
	O5mqA+peEVJybCR6QY4iMWdHvwHyioA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-Gx-egx59PJi33A4cP32OQg-1; Tue, 05 Aug 2025 10:32:47 -0400
X-MC-Unique: Gx-egx59PJi33A4cP32OQg-1
X-Mimecast-MFC-AGG-ID: Gx-egx59PJi33A4cP32OQg_1754404366
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b20f50da27so2756238f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 07:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404366; x=1755009166;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ix3nGBaIbmH4NveMsKrbtk5kqoYYY0SEMHv1/oWenw8=;
        b=lFnOY4DON9TRV67DLZpu7Bh2E3qtX84wPhlAErGQ7162zmZhk8DeSKi8Ggc3B4ljoV
         Kw7audVKzu0yPk7cYVF/NEx3lasKVqNh4NvEeS2YZFH5l0EiGaAdVs1MJfiTjhuWTkn4
         xGhCZ8XS2nUarsRHQDQ5uCscDFvBGe6jmfDeWPxqe+7qNZsunQisbt89GeWXz0SaNMiQ
         JHuNf0N2fzh+uacWWKyGqv/Qi+9cC7yu2WZcMAW6UcR9m6UHNY+KQDfxrjAmXVxDMdp9
         po64b6fBw5VscGxVEg14Fq1UmD1hvndWCMG0zvpumfXqGvT5Q32LqTBez8YAmQPW/K/j
         Kjtw==
X-Gm-Message-State: AOJu0YxF27BfKHFyMd+YGbxyn3P1TsWlE93jjO3jt2tEknprjXdO6mdD
	ZUJsHVbunmRTJcHLCgpsMTp2Wwj3kFZlBkj3cJr8d43VErXs70YcJ7+8aB00lzAI/JQLjH/VXY/
	UatuUa1UsGaHW8oB1c/MHLs/QXYdjW3KYZJoMdSLRkJROkSf3Waq9oFQ0abcL2mm1Iz0=
X-Gm-Gg: ASbGnct1rCZAbnXq9HdTf5acdCtwB3pFv8EFXUiw2wgi98+nUqPiUl8eL9xBWQdkHRV
	X4tuAXljx9GUXYoDmi5dYTHQknpvj4pB/1fU0mkvPzfUEvT1l978qn0Lf4rmxX78EbFBfEE2ajK
	+dbWgydfiWw3RWtd9VD19FmpHIkawcYk1oNbPNkNswqR7xGAYE2ZOBH9X/yRaHJI18Cla+NVzOw
	oObDwhFVqnii3hHX+iafsv9d/ryBIECE0XhbPbY8KkGOSPpHZvimGHwEcmz/wtoAaTzc8nchCjY
	aah4IgDzKnVN35v1eaZ+Jn/DMGPURs2jfguAsrXiqAw48FzfRnLVrR6a3krYLXDyvIPx24owRRQ
	BonD+Mh7hcQ3ywKE0Uik+51VN3lZFymg/v41Fj/m2b/CAAtpAbUAZD+5HmXjgwhuNhY0=
X-Received: by 2002:a05:6000:4312:b0:3b8:de54:6e64 with SMTP id ffacd0b85a97d-3b8ebed0110mr3358746f8f.26.1754404366260;
        Tue, 05 Aug 2025 07:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0eBgMt32IIG2M76/hGwmlKj6yIjDo80GNw04npLTQhTH6LwgB3ZPD9we6BR1M9vQkbIGY7g==
X-Received: by 2002:a05:6000:4312:b0:3b8:de54:6e64 with SMTP id ffacd0b85a97d-3b8ebed0110mr3358701f8f.26.1754404365758;
        Tue, 05 Aug 2025 07:32:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac036sm19299061f8f.15.2025.08.05.07.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 07:32:44 -0700 (PDT)
Message-ID: <be784521-5507-4d6a-8028-2816c1a18325@redhat.com>
Date: Tue, 5 Aug 2025 16:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] selftests: prctl: introduce tests for disabling
 THPs completely
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-6-usamaarif642@gmail.com>
 <66c2b413-fa60-476a-b88f-542bbda9c89c@redhat.com>
 <a22beba8-17ae-4c40-88f0-d4027d17fdbc@gmail.com>
 <e608f766-8750-4781-bd23-8fa95b6d683a@redhat.com>
 <955ed533-dd7e-45e6-a2cb-f379a5878ef7@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <955ed533-dd7e-45e6-a2cb-f379a5878ef7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.08.25 16:26, Usama Arif wrote:
> 
> 
> On 05/08/2025 13:55, David Hildenbrand wrote:
>> On 05.08.25 14:46, Usama Arif wrote:
>>>
>>>
>>> On 05/08/2025 13:39, David Hildenbrand wrote:
>>>>> +FIXTURE_SETUP(prctl_thp_disable_completely)
>>>>> +{
>>>>> +    if (!thp_available())
>>>>> +        SKIP(return, "Transparent Hugepages not available\n");
>>>>> +
>>>>> +    self->pmdsize = read_pmd_pagesize();
>>>>> +    if (!self->pmdsize)
>>>>> +        SKIP(return, "Unable to read PMD size\n");
>>>>> +
>>>>> +    thp_save_settings();
>>>>> +    thp_read_settings(&self->settings);
>>>>> +    self->settings.thp_enabled = variant->thp_policy;
>>>>> +    self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
>>>>
>>>> Oh, one more thing: should we set all other sizes also to THP_INHERIT or (for simplicity) THP_NEVER?
>>>>
>>>
>>> hmm do we need to? I am hoping that we should always get the PMD size THP no matter what the policy
>>> for others is in the scenario we have?
>>
>> Assuming 64K is set to "always", couldn't it mislead us in the "madvise"/"never" test cases in some scenarios?
>>
> 
> I tried it with 64K to always and seems to be ok. check_huge_anon checks AnonHugepages from smaps which
> only indicates the pmd mapped THPs only. So I think should be ok?

Ah, yes. If that's the case, then we can focus on PMD only and not care 
about how the others are configured.

-- 
Cheers,

David / dhildenb


