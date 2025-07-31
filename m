Return-Path: <linux-fsdevel+bounces-56383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43629B16FA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2320617890B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B733220F25;
	Thu, 31 Jul 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8jo84us"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927B1AD3E5;
	Thu, 31 Jul 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957942; cv=none; b=tRVXkJP4szI2aT7AjZhmt+JPxTEeL1NlXZZhxch/wcoGhhnRQGp6cDxtrdXrs/xr6oiILs2vzxGPDt4fa6DonTn8vkT7A6ZXSEj9XSE47PtDPAPcrh8Md8JcCke8MTZP9/fnbu9AYsmLzcVzrCu5MPi54jNSt3YSojo7dfH7TvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957942; c=relaxed/simple;
	bh=EBwhucV2eDGmZleewnN1Gh/evNc8+O8V+KuI4JuYp6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6u0j4U3hP32bVdw4o0V/veWNjv4XiCVDcz7+/DMQzL0nLui2AyWIdHBFK4eQQk4LA5Rb4anYSwNjIqhgz4+O3h0NiipJAN2Arw7zLkVnzWGy0qL/BDHt2GFVAX7YBBs2NiE0kIOg1a1Dqu506og9sNJfox+DZwaq6Xgz7XAQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8jo84us; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b780bdda21so589331f8f.3;
        Thu, 31 Jul 2025 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753957938; x=1754562738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4QDe8KbBOKLJQJobc6zrBQ/jJOdEvFf9AqsfgSwuAE=;
        b=l8jo84usFx27EEJCk3z1S00UC2lAnY18GeIAb2jHIIGYJe789UKBZqXFxMUXIn2FPA
         GPRNtRFA1ky9ww50gFxUUIJVmqwnrbHiNPKgLqAvNX6hhZc/guRG9PmFnnP/laFRNVVC
         AVpG/Q/WQtJJqnRZxFm7GiKFrFI2KOoBWPAxATa4DZ4VBftoZIfzhrVOZv1jGOumG0Uo
         Sge58i4kXq4lkLEGHgholJxEWoUYDl+oaj/icoDUMQW/vfsEphkGCggCREOaqzm0SRIR
         vrM9JHhiz7LTHM7RUSQ7hVANMEuc6T9yJzps4KEIUDn5urweKWpLQpesZX2T2GHkFLor
         /clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957938; x=1754562738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4QDe8KbBOKLJQJobc6zrBQ/jJOdEvFf9AqsfgSwuAE=;
        b=JeiauPm8aU9dkeR56GshBXJb7s4Uy7tMCopg1PruWf0IJcEX7SEmlPkecYkpDzbpnC
         WR81unzgEoaWvpZ0HLIxagvsNKbvyY2GPVKHXT47GWxwnG3/ykcs8v8tvl1cecI2e880
         KvqmVdMJoVjD/p616C/atgFjqGThQ1Axkf+SyPakRK3ZgwzthjFIaAItjz5jmdlOdaWE
         uCY9Qc0emhTrywbbF3g5eH/Ua7jy0GXvG/6Dfnxi2YDGqbyWV7L+RVH77zVd9cHjZ8vK
         tYKBwtPVFfidPNwGoBjczHe+qQCs/J3q8XPdmIJ0iRzmZ9zb1fKccRjWyK2z6CO0jhsd
         vGnw==
X-Forwarded-Encrypted: i=1; AJvYcCU1SOLwnKW734NRjRb2lXSPc1zxoRyjAHX9QYhfrwPaKp1gIxmM+tlZ3lMQOWh8MKA/42Ft44ruvs591paE@vger.kernel.org, AJvYcCVg2ywebRnFpwWUdCWXHpoRJlq/FgFJUxsdpJPJRW/N8J6F/BOXFqptlXzBA3kpFBgITrQaf78RIYesAHflXA==@vger.kernel.org, AJvYcCWCPdPCdRZm+OzlflX+AixuAv/jtL7ZiSsVH6sp+CsySCBHZt8r9FnR8FT+CyIMFYghwZQmBEyDlMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRk8nYlvMZ0VeqoFif8sU7z732NR9XtlCIZHe28sMVaS8c7xV
	pRTjbngmLc0eNMdPp1swfdVJVe2dpMEhp9zHiBiiNNKxu9Co48yPHEYb
X-Gm-Gg: ASbGncsuZFTd6yhannRuUauh2hsftv1nW/mmq6dwR2p2klLq8IuHAZhF7033oEJMTWV
	JNLx/EF3hJ/8yXZ1eOjiTQ0R3QdVHMqILFLbAgUbzw1Xr5BtUVMNORqTU/N411OH5eSi5ApvRO0
	TR20XmpAvT6jB4ks+tE8WgLwM4YOZiyUz4dUSgUH4Epst8Xu1mjpYYy+1Kj097DlZTR2zGNgyRr
	Bfi01gbTrTNaICNtkbsgDpXpJSRgQIgHVAat/zCyU38dkLO9NJqYL7gOgGfgkeJcauvM7/zUYz6
	1qG1C9oZkBsOoOXIun4f4zTA7T897rrrpZ9U6ouENI7TXNir8nbkXjkYomFRTAXzh9vcE+ne4k8
	DU9E9y4Fuawf/Zs1Zf3iKzWxNJqSW2DAO7a32racz12BiSDRIQnVE/FvDTmDQe0P7Qzyzs4uevL
	hnalN6iw==
X-Google-Smtp-Source: AGHT+IFodhEvytOPDh6mSNjWVs7q0+m5DzyaOr1Qj+ffoHQglGyK9LooYmMshusN83lCfsEblfcqCw==
X-Received: by 2002:a05:6000:144b:b0:3b5:f8b3:d4fc with SMTP id ffacd0b85a97d-3b7950190e7mr6335576f8f.53.1753957938232;
        Thu, 31 Jul 2025 03:32:18 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::4:3f35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57922sm21572575e9.22.2025.07.31.03.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 03:32:17 -0700 (PDT)
Message-ID: <85a85f3d-8c3e-4159-b186-d1f9f0c5530d@gmail.com>
Date: Thu, 31 Jul 2025 11:32:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
 <20250725162258.1043176-2-usamaarif642@gmail.com>
 <8c5d607d-498e-4a34-a781-faafb3a5fdef@lucifer.local>
 <6eab6447-d9cb-4bad-aecc-cc5a5cd192bb@gmail.com>
 <41d8154f-7646-4cca-8b65-218827c1e7e4@lucifer.local>
 <36cae7e8-97d0-4d53-968b-7f39b34fa5c0@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <36cae7e8-97d0-4d53-968b-7f39b34fa5c0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 31/07/2025 09:38, David Hildenbrand wrote:
> Thanks Lorenzo for the review, I'll leave handling all that to Usama from this point :)
> 
> On 31.07.25 10:29, Lorenzo Stoakes wrote:
>> Just a ping on the man page stuff - you will do that right? :>)
>>
> 
> I'm hoping that Usama can take over that part. If not, I'll handle it (had planned it for once it's in mm-stable / going upstream).


Yes, plan to take care of man page, systemd, etc once the patch makes it to mm-stable. 

> 
> [ ... ]
> 
>>>>> +/*
>>>>> + * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
>>>>> + * VM_HUGEPAGE).
>>>>> + */
>>>>> +# define PR_THP_DISABLE_EXCEPT_ADVISED    (1 << 1)
>>>>
>>>> NO space after # please.
>>>>
>>>
>>> I think this is following the file convention, the space is there in other flags
>>> all over this file. I dont like the space as well.
>>
>> Yeah yuck. It's not a big deal, but ideally I'd prefer us to be sane even
>> if the rest of the header is less so here.
> 
> I'm afraid us doing something different here will not make prctl() any better as a whole, so let's keep it consistent in this questionable file.
> 
>>
>>>
>>>>>   #define PR_GET_THP_DISABLE    42
>>>>>
>>>>>   /*
>>>>> diff --git a/kernel/sys.c b/kernel/sys.c
>>>>> index b153fb345ada..b87d0acaab0b 100644
>>>>> --- a/kernel/sys.c
>>>>> +++ b/kernel/sys.c
>>>>> @@ -2423,6 +2423,50 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
>>>>>       return sizeof(mm->saved_auxv);
>>>>>   }
>>>>>
>>>>> +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
>>>>> +                 unsigned long arg4, unsigned long arg5)
>>>>> +{
>>>>> +    unsigned long *mm_flags = &current->mm->flags;
>>>>> +
>>>>> +    if (arg2 || arg3 || arg4 || arg5)
>>>>> +        return -EINVAL;
>>>>> +
>>>>
>>>> Can we have a comment here about what we're doing below re: the return
>>>> value?
>>>>
>>>
>>> Do you mean add returning 1 for MMF_DISABLE_THP_COMPLETELY and 3 for MMF_DISABLE_THP_EXCEPT_ADVISED?
>>
>> Well more so something about we return essentially flags indicating what is
>> enabled or not, if bit 0 is set then it's disabled, if bit 1 is set then
>> it's that with the exception of VM_HUGEPAGE VMAs.
> 
> We have that documented above the defines for flags etc. Maybe simply here:
> 
> /* If disabled, we return "1 | flags", otherwise 0. */
> 

Thanks, will add this to next revision.


