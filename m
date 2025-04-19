Return-Path: <linux-fsdevel+bounces-46721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18355A9449B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3491D7A6F55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A91DF75D;
	Sat, 19 Apr 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5P6BBL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787691C862F
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745079968; cv=none; b=hPMYTjj2Lz1OsmG7GTk5xVbmHmY2MZ5qRjPp/x2O1GdPlyW+DhhyTEybMy62bkj1hC+gU3VQmHJ88cWeDO8DUdGuwmEq2AOnEqgPaCLot9xYH//cKBzoPhIgPdRhNXDK+DwTqLBOcN028CSIiJBEeCkV3c8kEeeftvu5yQX9RM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745079968; c=relaxed/simple;
	bh=FMushhhSW32sAwXhnfajho1R3JCBR54xyn2fpUXU21c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFge44aVDydcshl401EcawclsxTTqonuq0u8AE8EkagInKJzQHEEAowvGBrBR8oYWA4K6n8NTnCcJWp52qlsUyxzz59XAYHmR3MyZ9mZU9HPD2Nzixt6ckEB2WoASFpPBAyXzrNVXEd/EwxQerw5SgsANjKHNpJ0xe50Ee5BZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5P6BBL6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745079964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dga5qQLT3pW4UP2UHTM4SfCCr6ilk2JUJIkWjvE/AMc=;
	b=L5P6BBL6DQD+8D8lnf6syyruS7ZelbmKswixP64do6DZwFDOf4UZRcRa8TMtz+pjN2z5S+
	dlNFEfgAN/8bSidCJNLQzXuzjluVXrxOkg0G/TH+MOp+ExaMkFXKpk4cv2vkQwTyOwhygR
	8LBMYn3CLPSxCEEbBLQdmcpBNcvkVVI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-1fdvVv5MNDazPjUbpaRfzQ-1; Sat, 19 Apr 2025 12:26:02 -0400
X-MC-Unique: 1fdvVv5MNDazPjUbpaRfzQ-1
X-Mimecast-MFC-AGG-ID: 1fdvVv5MNDazPjUbpaRfzQ_1745079961
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso10932105e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 09:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745079961; x=1745684761;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dga5qQLT3pW4UP2UHTM4SfCCr6ilk2JUJIkWjvE/AMc=;
        b=QsF53XxdkmYu0aJiIU17l1bq4bf1hFHy/+RTsG0Swg3e3KhRaQvpZxPkaViC+ntcmS
         3dHCd/y3QgGkwYSqz/Lc69UhyKOgWtnRB4d0nnxNLZR7bi+qITzfNsJzTB9R84vOTjgI
         eUkhDb+B83XSIWvIUaTvuIVT3A947HpBdZGj4bDi/FeicuOlw4yKDSHx7sylsQr3fYUp
         0e6tc+ffiTsaZmEQrSRngh9j0ZBnj+bvNGYqH2avW30ZmRxgME6omYJBCVxA+q/qv5aN
         qBB3f5g6yOWuVZvqmVxKsvuguPXdGd57KCAmb9uARyG2ih7GIRh58DbYa+PUmHqL5uf4
         uAow==
X-Forwarded-Encrypted: i=1; AJvYcCUopXqqFjjGQ33/mQLGl8xAibHlCYwlRN9+kmXgmNHZelC7SAT/AIBabq2GIacaCvy3Z6msqQg2Ex0PXxxd@vger.kernel.org
X-Gm-Message-State: AOJu0YxkhzzGqnFBhW/Xc1+G57LJ/y79yguYC428IVMU48iOFoIPinaH
	V++q8tbxTlmXPXq5X1+MthmpvKg/tM6crdcLvL2+7y3wsQAZFUw4IMq7HDfP1qNOUfrk9TzHCXp
	4wGG/K5sjijEjG/crA7KG0bReJc59NpsLWTXWZ0CXob85XSMUO0lP2Ohln1STQMQ=
X-Gm-Gg: ASbGncuq4LsilI6dQ7wPbBew1qm92sRAxxF8Lv+3FnSBwJGbet7BszfdyVi/WF4oUbP
	1Tw+kXbDOQ3XlzlrwTILKqm7DXX2Uy01k3QmuA3UoAfTXH1EfdppSawBvgZlz22qMF0A0v75LWJ
	UbaOxWZ2qvPZfNl88553LLHCPzIw/wMyqf4tVKuVHJTgrTdhFhIB4qlPKk0s4NCXBSH2mjVvfKn
	exQI9ukwm1RrpbFT1nOca/gMYhcYdzny/kaGtJ5N7uEYrw7+zOHFGwFJ/YJYqydhzYBzQOjy6Qq
	KigJ8Zbu/k/78w/yVV5cb7w7m0zZQ6pHau8tht3hDOQES+VpAH29QYHuXAuFiL4DDfzNB/EE3xR
	49Gwx7MFOxxQSzkqdczTqQbSY/itMWrFrQ2IVjVs=
X-Received: by 2002:a05:600c:43d4:b0:440:67d4:ec70 with SMTP id 5b1f17b1804b1-44069732095mr50829855e9.8.1745079961413;
        Sat, 19 Apr 2025 09:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv9FA2yzEGzZa3elXFirsRR2kMXfl1QfiO65SD+kmp5eZmIyqM29ero1shFEHHZxVTLAnYRg==
X-Received: by 2002:a05:600c:43d4:b0:440:67d4:ec70 with SMTP id 5b1f17b1804b1-44069732095mr50829595e9.8.1745079960899;
        Sat, 19 Apr 2025 09:26:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:8100:123f:e62f:1361:e4eb? (p200300cbc7178100123fe62f1361e4eb.dip0.t-ipconnect.de. [2003:cb:c717:8100:123f:e62f:1361:e4eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acdd4sm65877295e9.14.2025.04.19.09.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 09:26:00 -0700 (PDT)
Message-ID: <c7e85336-5e34-4dd9-950f-173f48ff0be1@redhat.com>
Date: Sat, 19 Apr 2025 18:25:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/20] mm: Copy-on-Write (COW) reuse support for
 PTE-mapped THP
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-14-david@redhat.com>
 <CAMgjq7D+ea3eg9gRCVvRnto3Sv3_H3WVhupX4e=k8T5QAfBHbw@mail.gmail.com>
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
In-Reply-To: <CAMgjq7D+ea3eg9gRCVvRnto3Sv3_H3WVhupX4e=k8T5QAfBHbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.04.25 18:02, Kairui Song wrote:
> On Tue, Mar 4, 2025 at 12:46 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Currently, we never end up reusing PTE-mapped THPs after fork. This
>> wasn't really a problem with PMD-sized THPs, because they would have to
>> be PTE-mapped first, but it's getting a problem with smaller THP
>> sizes that are effectively always PTE-mapped.
>>
>> With our new "mapped exclusively" vs "maybe mapped shared" logic for
>> large folios, implementing CoW reuse for PTE-mapped THPs is straight
>> forward: if exclusively mapped, make sure that all references are
>> from these (our) mappings. Add some helpful comments to explain the
>> details.
>>
>> CONFIG_TRANSPARENT_HUGEPAGE selects CONFIG_MM_ID. If we spot an anon
>> large folio without CONFIG_TRANSPARENT_HUGEPAGE in that code, something
>> is seriously messed up.
>>
>> There are plenty of things we can optimize in the future: For example, we
>> could remember that the folio is fully exclusive so we could speedup
>> the next fault further. Also, we could try "faulting around", turning
>> surrounding PTEs that map the same folio writable. But especially the
>> latter might increase COW latency, so it would need further
>> investigation.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memory.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 75 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 73b783c7d7d51..bb245a8fe04bc 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3729,19 +3729,86 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
>>          return ret;
>>   }
>>
>> -static bool wp_can_reuse_anon_folio(struct folio *folio,
>> -                                   struct vm_area_struct *vma)
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
>> +               struct vm_area_struct *vma)
>>   {
>> +       bool exclusive = false;
>> +
>> +       /* Let's just free up a large folio if only a single page is mapped. */
>> +       if (folio_large_mapcount(folio) <= 1)
>> +               return false;
>> +
>>          /*
>> -        * We could currently only reuse a subpage of a large folio if no
>> -        * other subpages of the large folios are still mapped. However,
>> -        * let's just consistently not reuse subpages even if we could
>> -        * reuse in that scenario, and give back a large folio a bit
>> -        * sooner.
>> +        * The assumption for anonymous folios is that each page can only get
>> +        * mapped once into each MM. The only exception are KSM folios, which
>> +        * are always small.
>> +        *
>> +        * Each taken mapcount must be paired with exactly one taken reference,
>> +        * whereby the refcount must be incremented before the mapcount when
>> +        * mapping a page, and the refcount must be decremented after the
>> +        * mapcount when unmapping a page.
>> +        *
>> +        * If all folio references are from mappings, and all mappings are in
>> +        * the page tables of this MM, then this folio is exclusive to this MM.
>>           */
>> -       if (folio_test_large(folio))
>> +       if (folio_test_large_maybe_mapped_shared(folio))
>> +               return false;
>> +
>> +       VM_WARN_ON_ONCE(folio_test_ksm(folio));
>> +       VM_WARN_ON_ONCE(folio_mapcount(folio) > folio_nr_pages(folio));
>> +       VM_WARN_ON_ONCE(folio_entire_mapcount(folio));
>> +
>> +       if (unlikely(folio_test_swapcache(folio))) {
>> +               /*
>> +                * Note: freeing up the swapcache will fail if some PTEs are
>> +                * still swap entries.
>> +                */
>> +               if (!folio_trylock(folio))
>> +                       return false;
>> +               folio_free_swap(folio);
>> +               folio_unlock(folio);
>> +       }
>> +
>> +       if (folio_large_mapcount(folio) != folio_ref_count(folio))
>>                  return false;
>>
>> +       /* Stabilize the mapcount vs. refcount and recheck. */
>> +       folio_lock_large_mapcount(folio);
>> +       VM_WARN_ON_ONCE(folio_large_mapcount(folio) < folio_ref_count(folio));
> 
> Hi David, I'm seeing this WARN_ON being triggered on my test machine:

Hi!

So I assume the following will not sort out the issue for you, correct?

https://lore.kernel.org/all/20250415095007.569836-1-david@redhat.com/T/#u

> 
> I'm currently working on my swap table series and testing heavily with
> swap related workloads. I thought my patch may break the kernel, but
> after more investigation and reverting to current mm-unstable, it
> still occurs (with a much lower chance though, I think my series
> changed the timing so it's more frequent in my case).
> 
> The test is simple, I just enable all mTHP sizes and repeatedly build
> linux kernel in a 1G memcg using tmpfs.
> 
> The WARN is reproducible with current mm-unstable
> (dc683247117ee018e5da6b04f1c499acdc2a1418):
> 
> [ 5268.100379] ------------[ cut here ]------------
> [ 5268.105925] WARNING: CPU: 2 PID: 700274 at mm/memory.c:3792
> do_wp_page+0xfc5/0x1080
> [ 5268.112437] Modules linked in: zram virtiofs
> [ 5268.115507] CPU: 2 UID: 0 PID: 700274 Comm: cc1 Kdump: loaded Not
> tainted 6.15.0-rc2.ptch-gdc683247117e #1434 PREEMPT(voluntary)
> [ 5268.120562] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
> [ 5268.123025] RIP: 0010:do_wp_page+0xfc5/0x1080
> [ 5268.124807] Code: 0d 80 77 32 02 0f 85 3e f1 ff ff 0f 1f 44 00 00
> e9 34 f1 ff ff 48 0f ba 75 00 1f 65 ff 0d 63 77 32 02 0f 85 21 f1 ff
> ff eb e1 <0f> 0b e9 10 fd ff ff 65 ff 00 f0 48 0f b
> a 6d 00 1f 0f 83 ec fc ff
> [ 5268.132034] RSP: 0000:ffffc900234efd48 EFLAGS: 00010297
> [ 5268.134002] RAX: 0000000000000080 RBX: 0000000000000000 RCX: 000fffffffe00000
> [ 5268.136609] RDX: 0000000000000081 RSI: 00007f009cbad000 RDI: ffffea0012da0000
> [ 5268.139371] RBP: ffffea0012da0068 R08: 80000004b682d025 R09: 00007f009c7c0000
> [ 5268.142183] R10: ffff88839c48b8c0 R11: 0000000000000000 R12: ffff88839c48b8c0
> [ 5268.144738] R13: ffffea0012da0000 R14: 00007f009cbadf10 R15: ffffc900234efdd8
> [ 5268.147540] FS:  00007f009d1fdac0(0000) GS:ffff88a07ae14000(0000)
> knlGS:0000000000000000
> [ 5268.150715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5268.153270] CR2: 00007f009cbadf10 CR3: 000000016c7c0001 CR4: 0000000000770eb0
> [ 5268.155674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 5268.158100] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 5268.160613] PKRU: 55555554
> [ 5268.161662] Call Trace:
> [ 5268.162609]  <TASK>
> [ 5268.163438]  ? ___pte_offset_map+0x1b/0x110
> [ 5268.165309]  __handle_mm_fault+0xa51/0xf00
> [ 5268.166848]  ? update_load_avg+0x80/0x760
> [ 5268.168376]  handle_mm_fault+0x13d/0x360
> [ 5268.169930]  do_user_addr_fault+0x2f2/0x7f0
> [ 5268.171630]  exc_page_fault+0x6a/0x140
> [ 5268.173278]  asm_exc_page_fault+0x26/0x30
> [ 5268.174866] RIP: 0033:0x120e8e4
> [ 5268.176272] Code: 84 a9 00 00 00 48 39 c3 0f 85 ae 00 00 00 48 8b
> 43 20 48 89 45 38 48 85 c0 0f 85 b7 00 00 00 48 8b 43 18 48 8b 15 6c
> 08 42 01 <0f> 11 43 10 48 89 1d 61 08 42 01 48 89 53 18 0f 11 03 0f 11
> 43 20
> [ 5268.184121] RSP: 002b:00007fff8a855160 EFLAGS: 00010246
> [ 5268.186343] RAX: 00007f009cbadbd0 RBX: 00007f009cbadf00 RCX: 0000000000000000
> [ 5268.189209] RDX: 00007f009cbba030 RSI: 00000000000006f4 RDI: 0000000000000000
> [ 5268.192145] RBP: 00007f009cbb6460 R08: 00007f009d10f000 R09: 000000000000016c
> [ 5268.194687] R10: 0000000000000000 R11: 0000000000000010 R12: 00007f009cf97660
> [ 5268.197172] R13: 00007f009756ede0 R14: 00007f0097582348 R15: 0000000000000002
> [ 5268.199419]  </TASK>
> [ 5268.200227] ---[ end trace 0000000000000000 ]---
> 
> I also once changed the WARN_ON to WARN_ON_FOLIO and I got more info here:
> 
> [ 3994.907255] page: refcount:9 mapcount:1 mapping:0000000000000000
> index:0x7f90b3e98 pfn:0x615028
> [ 3994.914449] head: order:3 mapcount:8 entire_mapcount:0
> nr_pages_mapped:8 pincount:0
> [ 3994.924534] memcg:ffff888106746000
> [ 3994.927868] anon flags:
> 0x17ffffc002084c(referenced|uptodate|owner_2|head|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
> [ 3994.933479] raw: 0017ffffc002084c ffff88816edd9128 ffffea000beac108
> ffff8882e8ba6bc9
> [ 3994.936251] raw: 00000007f90b3e98 0000000000000000 0000000900000000
> ffff888106746000
> [ 3994.939466] head: 0017ffffc002084c ffff88816edd9128
> ffffea000beac108 ffff8882e8ba6bc9
> [ 3994.943355] head: 00000007f90b3e98 0000000000000000
> 0000000900000000 ffff888106746000
> [ 3994.946988] head: 0017ffffc0000203 ffffea0018540a01
> 0000000800000007 00000000ffffffff
> [ 3994.950328] head: ffffffff00000007 00000000800000a3
> 0000000000000000 0000000000000008
> [ 3994.953684] page dumped because:
> VM_WARN_ON_FOLIO(folio_large_mapcount(folio) < folio_ref_count(folio))
> [ 3994.957534] ------------[ cut here ]------------
> [ 3994.959917] WARNING: CPU: 16 PID: 555282 at mm/memory.c:3794
> do_wp_page+0x10c0/0x1110
> [ 3994.963069] Modules linked in: zram virtiofs
> [ 3994.964726] CPU: 16 UID: 0 PID: 555282 Comm: sh Kdump: loaded Not
> tainted 6.15.0-rc1.ptch-ge39aef85f4c0-dirty #1431 PREEMPT(voluntary)
> [ 3994.969985] Hardware name: Red Hat KVM/RHEL-AV, BIOS 0.0.0 02/06/2015
> [ 3994.972905] RIP: 0010:do_wp_page+0x10c0/0x1110
> [ 3994.974477] Code: fe ff 0f 0b bd f5 ff ff ff e9 16 fb ff ff 41 83
> a9 bc 12 00 00 01 e9 2f fb ff ff 48 c7 c6 90 c2 49 82 4c 89 ef e8 40
> fd fe ff <0f> 0b e9 6a fc ff ff 65 ff 00 f0 48 0f b
> a 6d 00 1f 0f 83 46 fc ff
> [ 3994.981033] RSP: 0000:ffffc9002b3c7d40 EFLAGS: 00010246
> [ 3994.982636] RAX: 000000000000005b RBX: 0000000000000000 RCX: 0000000000000000
> [ 3994.984778] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff889ffea16a80
> [ 3994.986865] RBP: ffffea0018540a68 R08: 0000000000000000 R09: c0000000ffff7fff
> [ 3994.989316] R10: 0000000000000001 R11: ffffc9002b3c7b80 R12: ffff88810cfd7d40
> [ 3994.991654] R13: ffffea0018540a00 R14: 00007f90b3e9d620 R15: ffffc9002b3c7dd8
> [ 3994.994076] FS:  00007f90b3caa740(0000) GS:ffff88a07b194000(0000)
> knlGS:0000000000000000
> [ 3994.996939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3994.998902] CR2: 00007f90b3e9d620 CR3: 0000000104088004 CR4: 0000000000770eb0
> [ 3995.001314] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 3995.003746] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 3995.006173] PKRU: 55555554
> [ 3995.007117] Call Trace:
> [ 3995.007988]  <TASK>
> [ 3995.008755]  ? __pfx_default_wake_function+0x10/0x10
> [ 3995.010490]  ? ___pte_offset_map+0x1b/0x110
> [ 3995.011929]  __handle_mm_fault+0xa51/0xf00
> [ 3995.013346]  handle_mm_fault+0x13d/0x360
> [ 3995.014796]  do_user_addr_fault+0x2f2/0x7f0
> [ 3995.016331]  ? sigprocmask+0x77/0xa0
> [ 3995.017656]  exc_page_fault+0x6a/0x140
> [ 3995.018978]  asm_exc_page_fault+0x26/0x30
> [ 3995.020309] RIP: 0033:0x7f90b3d881a7
> [ 3995.021461] Code: e8 4e b1 f8 ff 66 66 2e 0f 1f 84 00 00 00 00 00
> 0f 1f 00 f3 0f 1e fa 55 31 c0 ba 01 00 00 00 48 89 e5 53 48 89 fb 48
> 83 ec 08 <f0> 0f b1 15 71 54 11 00 0f 85 3b 01 00 0
> 0 48 8b 35 84 54 11 00 48
> [ 3995.028091] RSP: 002b:00007ffc33632c90 EFLAGS: 00010206
> [ 3995.029992] RAX: 0000000000000000 RBX: 0000560cfbfc0a40 RCX: 0000000000000000
> [ 3995.032456] RDX: 0000000000000001 RSI: 0000000000000005 RDI: 0000560cfbfc0a40
> [ 3995.034794] RBP: 00007ffc33632ca0 R08: 00007ffc33632d50 R09: 00007ffc33632cff
> [ 3995.037534] R10: 00007ffc33632c70 R11: 00007ffc33632d00 R12: 0000560cfbfc0a40
> [ 3995.041063] R13: 00007f90b3e97fd0 R14: 00007f90b3e97fa8 R15: 0000000000000000
> [ 3995.044390]  </TASK>
> [ 3995.045510] ---[ end trace 0000000000000000 ]---
> 
> My guess is folio_ref_count is not a reliable thing to check here,
> anything can increase the folio's ref account even without locking it,
> for example, a swap cache lookup or maybe anything iterating the LRU.

It is reliable, we are holding the mapcount lock, so for each mapcount 
we must have a corresponding refcount. If that is not the case, we have 
an issue elsewhere.

Other reference may only increase the refcount, but not violate the 
mapcount vs. refcount condition.

Can you reproduce also with swap disabled?

-- 
Cheers,

David / dhildenb


