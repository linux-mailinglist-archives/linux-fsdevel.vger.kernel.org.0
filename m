Return-Path: <linux-fsdevel+bounces-49275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AC2AB9F00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB567AB8EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421C1A08CA;
	Fri, 16 May 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEU7Gbn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822F13C914
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407297; cv=none; b=eiuhn+JnChFlpyWCHtcTAFgQcFRE+q3m/uZcY/BZeNo6r7T9b4IYNbVbOLrLppHyLsz16s6Obm5FiDjx64+tRmTFiqPVVKBE/P5oIQHANJJuue8zobsqtohbd8RNL+AImEBKijjiAhg8CJ/ulZO1suCDBXC2OvIY8poO4awY82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407297; c=relaxed/simple;
	bh=UHaRZLFxOoiECXC/Zb+yha+9n150Lp7dBDDd1l29OLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAtQhh2GgzygIll+rr3TYcZuIJShpNTy7lis0+cMxtlDJe01talxVsKrKkHVqWRqm7niW8sds9m2cvVL3lh93cp9KDq6Gd7xNTLyP2sUXaoSahcNfJttq7cdpSa4+K6THmBcsyck5vUgEr1sskIUtuJNYjnsyga308vtTbjJvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEU7Gbn2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747407295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LD4o5M1xb49Wzg+l8iYWhHX8QQJZuE63lxcgIPd7AkI=;
	b=SEU7Gbn283jZLjiKwRAEdaMG2RZuz7FsqW15RdAuo6xYEv8Ig1rPh9d8SbQz4bm0UoZ0xy
	hGpWOnS/g5cCtEmBmbrV6Z9t51WKF9+E3Yop5yzsi+X6BOXix/zWU+J6rAM9A/5gdLMEH3
	7iUkuWxEwQ1cM137Vk/KDw4kAr5fvWg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-OJnwtIyTMK-pV9HrQhNicA-1; Fri, 16 May 2025 10:54:54 -0400
X-MC-Unique: OJnwtIyTMK-pV9HrQhNicA-1
X-Mimecast-MFC-AGG-ID: OJnwtIyTMK-pV9HrQhNicA_1747407293
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so12956735e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 07:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407293; x=1748012093;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LD4o5M1xb49Wzg+l8iYWhHX8QQJZuE63lxcgIPd7AkI=;
        b=wYPHtO4pCwZDO56RdJxNYwUICMf1lKdYdBe7wHlO8j6b0Dq0YRNLty/6gkIUTSwltM
         M2GQCX/+NO/HcFwdCoLKf0+Oimbo6EDNsbaL2rt6E3riB/fHNGxGEL/DjgaRqUaGzPBL
         /S9W5enWKlM75uN0l8pjiQNflRxd/oGwR0QKjhfuofExglaXnjztZHSy7DmpEr1Fg3cC
         966E9CtpuEAntTuaT1eNmFKO7hByUlhwHnzqn68+Oc6pSwA2IM1Z5ASGmkMa5vnlFrQ8
         /nXp3a7+GiJe4vuzO/NLF+JnCdd2riv9RoCe09gKligtJQS49hfmfAR/XQNZo3tuWGEB
         RdkA==
X-Forwarded-Encrypted: i=1; AJvYcCW0HW1rKi9KQNsVbT8+FMuSAQxXuAYul8jRyqIqa2Cc5u9GR5iVVF3uDPoG8UMlrkMh97XUs49KaeRvaoX9@vger.kernel.org
X-Gm-Message-State: AOJu0YwGiP0iTz+C67Q4T//Ym0Aj7iXAtryTzJDFRynA2VS1PESOM8mx
	UOtsglrf3sqIjB9gq3alENlzX4Qg98gEPI9biJhWYlfZGTT2j3NmoxeoGYme2ECb/9Y7LShghVR
	1XErxnemTWCXIU4vwTxBDhuKr9a8X3HSny5jpAz2t9IausqmOasK2SXoJYdaqx5dcjlw=
X-Gm-Gg: ASbGncsMeiGyZoSKHBwcwMrNZUSKW0KMJP2f+UszOBP6OJ8rQflipxPcQrLR/myuJ2J
	pLfJLB67UJx0zdpGSUBqOtXH+n5CHh37lPFMTNt0NNNGBmyBB1gGVGAYxkC50iAUcx2p84JXj2b
	eg7hLzDAFoRLwpjUt8NS/MHWaSfDVdjeWh9somiAR2q5we7wsFcSVx1VfIus14TMTwqVifS1Gbv
	bh2mcn2uo0hBwBsSsw5pluXvG3+q+rM1bxMUenyyVWSJmlvPEKXZvzKrCOx+Wv7zUM/pB/ckjJU
	dyKVI6n+cuD6vQfrD3cUn3Lc1boGfxRMSLl8gDh/joSR2cN7TCfGX1EV8WtZOEDaCSgWmiu/Wbu
	C4ttEFHMEgpEuX5YVh3OAssDPpi6GyC4EKRKANvY=
X-Received: by 2002:a05:600c:ccd:b0:43b:c7f0:6173 with SMTP id 5b1f17b1804b1-442fd93ce92mr37193245e9.4.1747407292674;
        Fri, 16 May 2025 07:54:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq5Gdy3Qhjo8HXYvMMt4++cpmafTe237v1vk7ja2/lEEeZn4qAZfPbeL+gGW5mKrjS9TsanQ==
X-Received: by 2002:a05:600c:ccd:b0:43b:c7f0:6173 with SMTP id 5b1f17b1804b1-442fd93ce92mr37192955e9.4.1747407292284;
        Fri, 16 May 2025 07:54:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:4700:e6f9:f453:9ece:7602? (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de. [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50ee03sm36155655e9.14.2025.05.16.07.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 07:54:51 -0700 (PDT)
Message-ID: <1e571419-9709-4898-9349-3d2eef0f8709@redhat.com>
Date: Fri, 16 May 2025 16:54:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] mm: add large zero page for efficient zeroing of larger
 segments
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, "Darrick J . Wong"
 <djwong@kernel.org>, hch@lst.de, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250516101054.676046-1-p.raghav@samsung.com>
 <20250516101054.676046-2-p.raghav@samsung.com>
 <cb52312d-348b-49d5-b0d7-0613fb38a558@redhat.com>
 <d2gqsc55wnzckszesku3xsa33nseueul4vnwfpjcb37flm5su4@xx6nahf5h3vu>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d2gqsc55wnzckszesku3xsa33nseueul4vnwfpjcb37flm5su4@xx6nahf5h3vu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.25 15:03, Pankaj Raghav (Samsung) wrote:
> On Fri, May 16, 2025 at 02:21:04PM +0200, David Hildenbrand wrote:
>> On 16.05.25 12:10, Pankaj Raghav wrote:
>>> Introduce LARGE_ZERO_PAGE of size 2M as an alternative to ZERO_PAGE of
>>> size PAGE_SIZE.
>>>
>>> There are many places in the kernel where we need to zeroout larger
>>> chunks but the maximum segment we can zeroout at a time is limited by
>>> PAGE_SIZE.
>>>
>>> This is especially annoying in block devices and filesystems where we
>>> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
>>> bvec support in block layer, it is much more efficient to send out
>>> larger zero pages as a part of single bvec.
>>>
>>> While there are other options such as huge_zero_page, they can fail
>>> based on the system memory pressure requiring a fallback to ZERO_PAGE[3].
>>
>> Instead of adding another one, why not have a config option that will always
>> allocate the huge zeropage, and never free it?
>>
>> I mean, the whole thing about dynamically allocating/freeing it was for
>> memory-constrained systems. For large systems, we just don't care.
> 
> That sounds like a good idea. I was just worried about wasting too much
> memory with a huge page in systems with 64k page size. But it can always be
> disabled by putting it behind a config.

Exactly. If the huge zero page is larger than 2M, we probably don't want 
it in any case.

On arm64k it could be 512 of MiBs. Full of zeroes.

I'm wondering why nobody ever complained about that before, and I don't 
see anything immediate that would disable the huge zero page in such 
environments. Well, we can just leave that as it is.

In any case, the idea would be to have a Kconfig where we statically 
allocate the huge zero page and disable all the refcounting / shrinking.

Then, we can make this Kconfig specific to sane environments (e.g., 4 
KiB page size).

 From other MM code, we can then simply reuse that single huge zero page.

> 
> Thanks, David. I will wait to see what others think but what you
> suggested sounds like a good idea on how to proceed.

In particular, it wouldn't be arch specific, and we wouldn't waste on 
x86 2x 2MB for storing zeroes ...

-- 
Cheers,

David / dhildenb


