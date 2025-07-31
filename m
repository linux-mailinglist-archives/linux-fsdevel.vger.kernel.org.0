Return-Path: <linux-fsdevel+bounces-56373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E7B16DB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D7162183B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2815C2BD005;
	Thu, 31 Jul 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9G1bwpw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34A2957AD
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951139; cv=none; b=On2JUJ7QYvCCGb+EcyTda2CtYDodevSIX8J5mI27WB8SqIL5Zv3EK7XmEGH1gEwhzPoO4pY2OuVQjRSY48CVe4pYscIW89Rp6PzdFsd4f+AcWxQEH+dwOZaYX9tXCMPI3ptDdthyary6jWtQaMLhFaI+001MBZucwx0wvq69m2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951139; c=relaxed/simple;
	bh=DEKs5ILtjXtFyM0lb3ddcFDQrFQmEuDWUhDF2C4j0zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXIjyRFg3KPjzKdKZaxzIeGui05m4mWiD7H4O6jN3etIZMWFuCL2cKE6T0x81CgB3CFxygOGT0gqZReHvSBND6mO0srqcRQasAFp+gPnrwNhc4bMfE3kGlXYB/dLa2GcCamN/RHA9Iax15n1vPpCjrlwn6BfX8neP3j0+1Xe1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9G1bwpw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753951135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AA41OZkq4L+02/o/hLRiV452c66z8cfHQCn8I1NCXJw=;
	b=G9G1bwpwrsPP6KF5g357qOI/yMSxEjOsRfrtniVQtHI7cFX7AKyPjT4AN+v5ovXmUE+BaI
	e5Td+61ei0zLWZg/PdPD8Rw0lCnh5XgWBPIKZoHHd8iBetoGGcLECB0R2qqNimfw95nked
	SbzHvN1hc+RphIfQuLw6/8SbQJ+uLI4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-vbs1KNpiOMC3riaE5PHG8w-1; Thu, 31 Jul 2025 04:38:53 -0400
X-MC-Unique: vbs1KNpiOMC3riaE5PHG8w-1
X-Mimecast-MFC-AGG-ID: vbs1KNpiOMC3riaE5PHG8w_1753951132
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45600d19a2aso4637345e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 01:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753951132; x=1754555932;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AA41OZkq4L+02/o/hLRiV452c66z8cfHQCn8I1NCXJw=;
        b=BrsqHx+mTM9usc3pEUCCnVbPAYbf72jhY6bRvyrSPuCn54Xy9JOkiRGkZoCcB+HsZM
         dQEsOP0E5M817w498RnzXQoL9xbutuiR2nc9jM6gk+eIy25Dtt1d4cYd3WknCLwzSG6f
         fp+uJFZudmZ9E0klGOPaEfzcJ7f09n3HBpHD4nygPBcz8qv5jOR0IvgqAYqGkkQVSeVB
         0y2N0kI6vV0wqQhAA2KcwkFGfzd+XFyPoUBs1CjkE+bSaVU2A2IHE8nUKSlbHeuM1tLH
         rPDfyE7hXOl8btfl/82p02b480ld2I+f6IJM7Oyh9O7+Np86FN64A68yUFKdXZLjwkNX
         P/zw==
X-Forwarded-Encrypted: i=1; AJvYcCVkX+8zjuz9SRlOetriRD/yLenDLOYfteOxiaZAJpRCN9SDpPOkIR3oODYdA/5AOKG8hHjXy45bfNv8lnh3@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqUGXeMfZNV553+pnC/quz2Y2o4Y2JQW18HMZvgn+hFruLLPl
	T4gNvgsuMk5wfU2Sz62SnSi+UkU9rrmsL6rTjvgG+wq4jjEBsXX8Az6/rp6AD73QYPxCiME+wFP
	sdFe0BqljZPyNBvzeOyX97/GCVxv4Z1WuGHdPZ8Hx3HaUhuH8+miqSUeyQSMXwWrHrmo=
X-Gm-Gg: ASbGnctUMv24RAD+aDiQ/okK3yo9eBGEHZZ9KL4rzHhiU22IS6zyVSqkIR4kDQj0LLj
	HcW9EGaFg+RxdtWXOG7YP0qv/MRornE+KwA1tG85j20SWcV/veSwwIIzPgWLZvtgekJJdRMv4Vg
	FEuCwD1l2W+hxMuTl9FGn9760L1u3P7yJkWIZP+LtdXLp9xTOq5c/3dzBVun1lkkyVV9bt3drlx
	mR+uLKMb8V6TgBZxO9eFHnEb1CTuzGigbIef9V9oX+JYJI+HMz7PLIF4f0NfZrZRpt5zhNJYyug
	z8yKStw0z9wlpvyphL2H99iWvyrL6QIzEKZt/DaXHq+Ca4AsWwcxYQoYUsab8DKkTYWPpsiv+Ur
	iCvX4hv/nGzxkslQVzFRGRw6QkiQkMJhjYTk/QoLzi5ajf8+EV6upf8VtY0V/Seld6NM=
X-Received: by 2002:a05:600c:1f8d:b0:456:1d93:4365 with SMTP id 5b1f17b1804b1-45892bb8915mr51541725e9.5.1753951132296;
        Thu, 31 Jul 2025 01:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWD95wueftWd+w+Ju5Zdgm6ricJYeJUQ7nAZmLx6k10XU4lqB1FnCitjG3I7CTz+spdVnJqQ==
X-Received: by 2002:a05:600c:1f8d:b0:456:1d93:4365 with SMTP id 5b1f17b1804b1-45892bb8915mr51541305e9.5.1753951131670;
        Thu, 31 Jul 2025 01:38:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3700:be07:9a67:67f7:24e6? (p200300d82f443700be079a6767f724e6.dip0.t-ipconnect.de. [2003:d8:2f44:3700:be07:9a67:67f7:24e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abedesm1647621f8f.3.2025.07.31.01.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 01:38:50 -0700 (PDT)
Message-ID: <36cae7e8-97d0-4d53-968b-7f39b34fa5c0@redhat.com>
Date: Thu, 31 Jul 2025 10:38:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Usama Arif <usamaarif642@gmail.com>
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <41d8154f-7646-4cca-8b65-218827c1e7e4@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Lorenzo for the review, I'll leave handling all that to Usama 
from this point :)

On 31.07.25 10:29, Lorenzo Stoakes wrote:
> Just a ping on the man page stuff - you will do that right? :>)
> 

I'm hoping that Usama can take over that part. If not, I'll handle it 
(had planned it for once it's in mm-stable / going upstream).

[ ... ]

>>>> +/*
>>>> + * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
>>>> + * VM_HUGEPAGE).
>>>> + */
>>>> +# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
>>>
>>> NO space after # please.
>>>
>>
>> I think this is following the file convention, the space is there in other flags
>> all over this file. I dont like the space as well.
> 
> Yeah yuck. It's not a big deal, but ideally I'd prefer us to be sane even
> if the rest of the header is less so here.

I'm afraid us doing something different here will not make prctl() any 
better as a whole, so let's keep it consistent in this questionable file.

> 
>>
>>>>   #define PR_GET_THP_DISABLE	42
>>>>
>>>>   /*
>>>> diff --git a/kernel/sys.c b/kernel/sys.c
>>>> index b153fb345ada..b87d0acaab0b 100644
>>>> --- a/kernel/sys.c
>>>> +++ b/kernel/sys.c
>>>> @@ -2423,6 +2423,50 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
>>>>   	return sizeof(mm->saved_auxv);
>>>>   }
>>>>
>>>> +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
>>>> +				 unsigned long arg4, unsigned long arg5)
>>>> +{
>>>> +	unsigned long *mm_flags = &current->mm->flags;
>>>> +
>>>> +	if (arg2 || arg3 || arg4 || arg5)
>>>> +		return -EINVAL;
>>>> +
>>>
>>> Can we have a comment here about what we're doing below re: the return
>>> value?
>>>
>>
>> Do you mean add returning 1 for MMF_DISABLE_THP_COMPLETELY and 3 for MMF_DISABLE_THP_EXCEPT_ADVISED?
> 
> Well more so something about we return essentially flags indicating what is
> enabled or not, if bit 0 is set then it's disabled, if bit 1 is set then
> it's that with the exception of VM_HUGEPAGE VMAs.

We have that documented above the defines for flags etc. Maybe simply here:

/* If disabled, we return "1 | flags", otherwise 0. */

-- 
Cheers,

David / dhildenb


