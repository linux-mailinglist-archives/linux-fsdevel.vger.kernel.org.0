Return-Path: <linux-fsdevel+bounces-49997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD53AC724D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6034E098C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 20:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D4221262;
	Wed, 28 May 2025 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oztmj3Iq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1198F6B
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464602; cv=none; b=SpzpS6Y0p0IuqL5agY++yy01nqDKRFQ1l370q2enWIHvR/1r0NgTHzR2j3/WJzqI2sL0aqJLIZRgvMl1I3bduCDLi1cgl1ITMIKZTCgkYmSxsvuTJxu5f4DPz2d/Ial/MMjPdfoADg20X9ZqTa91xz03qsE8RzovEn0uYKG4gK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464602; c=relaxed/simple;
	bh=LKuuiFod4XXbTge4GHdm/9QLj8tPwgj0K7XcZn50K68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L16ZCkIIFLeFjXaymrZ7cM5mGy9No6AFz2SLBCjT6CIskUcEenyw3aRb7mivWRrGcksK9A758p8HMges5A23ikl++aGVnAVNknFlC5jK+7IUlm4slxzg6gWZvy7+Jzr0TPI5HpFpJwzA/RZyi6I8YbdDMrqcr9BdzEMu1AOPKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oztmj3Iq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748464600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iDHOfDzbDRVpg69jsOvmjB9r5MFng2zhSkjSqjMHIqA=;
	b=Oztmj3IqT5GbWXsHkSJIsGBUjq3xXCieXLyg9tezDNsV9pHWNax7+PzDJkXymUUseJcOJr
	aJ5Wxl/JCc10ge22V1sNLX7lqDNBjZ7yMnSQvUD0BhrCPokbntJyeu7Q/Ru+2ObL0EgEAa
	S/LjThnpwV/lFjmN+S3VOGHORqwidW8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-lmXFfmGON-yR2WnIGe58Zg-1; Wed, 28 May 2025 16:36:38 -0400
X-MC-Unique: lmXFfmGON-yR2WnIGe58Zg-1
X-Mimecast-MFC-AGG-ID: lmXFfmGON-yR2WnIGe58Zg_1748464597
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4d81f7adeso124576f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 13:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748464597; x=1749069397;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iDHOfDzbDRVpg69jsOvmjB9r5MFng2zhSkjSqjMHIqA=;
        b=gd2DW/z8/805otY163D/3NmKbAR9vOMgJsXecWoZwA5ZB7zAvZ1ZiiWTV8XIfnXqlI
         peU2sg1wxk9rX60gImtavUtuQ59qBA4Mbwv/EQnNyOgJZ925zvLM8nK1NJ0lAIbajbfZ
         LXAQYibwAfJhjNgeU1pjTfh+XrVWjLBPKBTmJlk9NfqHZhTpH7rYTvtZKe33JOIY8W1H
         EK9XSk/dtaVE58aSgxXmWvtA4TIuWM4LsqJCsa+j96ZrQhaeOc0HihRKvcMn+ty1FiIM
         amqzrAO7PNaZFKlP9m2v06Alvtg2zaKoRFqUGRHCRyiDRbFsL65oMtO77GR827vFPhDk
         jt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWONBd2tI89fiSsq3I5LzQw5jMfIb7UGONLdTTf09+j0e/q4GKR7ld9GeK6m94rDPNVu46aJWVicbwhq+fN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4OrpOQGRQhaGkY0FgzxNxCTA2wA4IFjqAAj+IC4ePUpNbH29
	mLDFXYu213JaWaaraLAvW3YBHae0DqjEi/sjWi4JsGWLvr2pXbjLBZ7N9/B65504wQh1L9fqocO
	YA2YNQf51S4gon0BNL4E/MCOajrxq1mx7cLpaSjI8WfJL3PzhlrQWdy4SVUKHIs2ji90=
X-Gm-Gg: ASbGncsXrrL3oS+k9GMBTV02bVfdIe+ltgjNlewAgX1wkxxDcwMuvdDRe9cMDCtRERE
	6EQ5smxvQseFAynK9kkPSbj7trN07hEmCmHxlJm3nYgJZXBs9GKOWAhRBVFx3gSuX0TvZWs0yYE
	BSuUk72oDLTnpF80fo9/LhKh3louvakIcUCKJ8wMQ7R3waSOLhmOzETW5VYni12RVB/wns5yhLu
	fGxbQY/sjzCNKKB1zPknUrqaEYpBZx/NdmC6nio9xXLiNNALKY4trOitKAQRC2IUTYKTgaqJiT5
	te8wocoubrgeNKd1ojdvAiW/pPhdqKDnBGEGS7502tL+FYrnDO2macfsq3crC+VYY/Y6Xd8YA91
	AkPIyas5diPHHBD+Y+K0pMwsWxSxz/4G17RjJqMs=
X-Received: by 2002:a05:6000:144b:b0:3a4:eda1:f64f with SMTP id ffacd0b85a97d-3a4eda1f745mr1926639f8f.30.1748464597153;
        Wed, 28 May 2025 13:36:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyw2FecFHjr2FE4rwo6929V09lCFuPkawv9vWLWEm5i38UkYZ4QCg7UaqjU3X8Av1gnPqQNQ==
X-Received: by 2002:a05:6000:144b:b0:3a4:eda1:f64f with SMTP id ffacd0b85a97d-3a4eda1f745mr1926619f8f.30.1748464596733;
        Wed, 28 May 2025 13:36:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfbf4966sm1450355e9.6.2025.05.28.13.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 13:36:36 -0700 (PDT)
Message-ID: <31dd1efc-ccf3-4908-a06f-20dabac86ce1@redhat.com>
Date: Wed, 28 May 2025 22:36:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, willy@infradead.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
 <626be90e-fa54-4ae9-8cad-d3b7eb3e59f7@intel.com>
 <5dv5hsfvbdwyjlkxaeo2g43v6n4xe6ut7pjf6igrv7b25y2m5a@blllpcht5euu>
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
In-Reply-To: <5dv5hsfvbdwyjlkxaeo2g43v6n4xe6ut7pjf6igrv7b25y2m5a@blllpcht5euu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.05.25 20:00, Pankaj Raghav (Samsung) wrote:
> On Tue, May 27, 2025 at 09:37:50AM -0700, Dave Hansen wrote:
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 055204dc211d..96f99b4f96ea 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -152,6 +152,7 @@ config X86
>>>   	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>>>   	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>>>   	select ARCH_WANTS_THP_SWAP		if X86_64
>>> +	select ARCH_WANTS_STATIC_PMD_ZERO_PAGE if X86_64
>>
>> I don't think this should be the default. There are lots of little
>> x86_64 VMs sitting around and 2MB might be significant to them.
> 
> This is the feedback I wanted. I will make it optional.
> 
>>> +config ARCH_WANTS_STATIC_PMD_ZERO_PAGE
>>> +	bool
>>> +
>>> +config STATIC_PMD_ZERO_PAGE
>>> +	def_bool y
>>> +	depends on ARCH_WANTS_STATIC_PMD_ZERO_PAGE
>>> +	help
>>> +	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
>>> +	  on demand and deallocated when not in use. This option will always
>>> +	  allocate huge_zero_folio for zeroing and it is never deallocated.
>>> +	  Not suitable for memory constrained systems.
>>
>> "Static" seems like a weird term to use for this. I was really expecting
>> to see a 2MB object that gets allocated in .bss or something rather than
>> a dynamically allocated page that's just never freed.
> 
> My first proposal was along those lines[0] (sorry I messed up version
> while sending the patches). David Hilderbrand suggested to leverage the
> infrastructure we already have in huge_memory.

Sorry, maybe I was not 100% clear.

We could either

a) Allocate it statically in bss and reuse it for huge_memory purposes

(static vs. dynamic is a good fit)

b) Allocate it during early boot and never free it.

Assuming we allocate it from memblock, it's almost static ... :)


I would not allocate it at runtime later when requested. Then, "static" 
is really a suboptimal fit.

-- 
Cheers,

David / dhildenb


