Return-Path: <linux-fsdevel+bounces-32665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201E9ACB31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C104AB21E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B61B4F24;
	Wed, 23 Oct 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqvWcfxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478D1AE001
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690137; cv=none; b=e8JbR5y3/OTGdef2CgJNRLQlpZsbUaaw9iKzciecJYNYysRnSas9zQVJ2+5oob20RGggy9Ou106jQoiN22Eh6LN/ZOQ9wA90rpqytj1C8UvTiGWj93aDHyNdmCURzvWqY1M4DTuAvNjn+jYwsuLjI8ys+a0F8hz9A+dnNIdIfPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690137; c=relaxed/simple;
	bh=+E/YEtxrGSZNp6dkyy8skjc7DVmXHMmNvhNzuiPDxZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cG1DP/abbTOQu/M5Y5JdLXP1siBfHkgqUqfrTHEHKRm6GhjyjnH6p7nSCo+NrQfTVPAWIU7E+LbcqxQJ9W4kPP28OZYgblvcpH6wYY30C4J/RvFg/r31S2EhamqMQqJ74LxiaeuyUVu+Qt8olht85l5KzKhbRe95wsjLM9IhKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqvWcfxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729690135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/VMCM3iNuHgER47S096YPsUEHOLaXLeZRdSkfr4eiFg=;
	b=FqvWcfxmRWd+pay2VhV0ZKwMCj3wYpTWLDxKkQrIUoAWOIHJRoR7qmRJJcdEsfvSt7B+GA
	tSgaD/iKeZG+a0M6pzkblCFxJV3YVY9mHlTrgXQSpeLste/Eay51WiSDnYMAObEiDGSE2z
	aN/ltNXLe5udRV62HaaoVD/FYyyfTc4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-1MJKYhZFNiSR4aAk0noKFw-1; Wed, 23 Oct 2024 09:28:52 -0400
X-MC-Unique: 1MJKYhZFNiSR4aAk0noKFw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso3426311f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 06:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690131; x=1730294931;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/VMCM3iNuHgER47S096YPsUEHOLaXLeZRdSkfr4eiFg=;
        b=cSQf2TCV+a1NQrswfC3c+kmIgk3HRz//aKm1okssJmTt2s4iMAFI7odT5NwHVfX7Zk
         +wrE8WKXr8W9qEec5+yVONKsy5YynGaoA1H5uHy7TiMp0Xuu/OIeDaV/GftJp6FEfiMW
         7/PKPKZHdq0koIJH5jYqkmfKi6HAU2olEqp1uk71NWpSCNN7vU1VT6/CDHZi06LDlsnN
         H7Re1RlQXjrD32o+GeqnonrqooREF8mcpMWg3QGHfhkLbEdaa8GBAO50juuZPW8pz5ww
         fB1Am7OJYnCD3RrOxPKiGq4YG1kCgUQIPhn+rQch4sXonhdzaE7vN6XmBooINFv0fk+4
         lUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQlxMxpPHVhqvCYdRADwgmRQk8pcFBIW1vKHBURoZlPEmme1tHruTL6t9fJ42eOqowXIWGCNdN3EcZX4c1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+bW2ztsLBfeRA1TR55YJIHjGqW8bWsfIVEGK3xUxxfYDh3ew
	g6VHTsX5qJSjfB5use+mtLW7eApmQlRFFkemUZmNCq+Vr9edNtQTCic26KZbo5F3vX5RaTpo8Ks
	6sF2vwl6jSY09Fhbob+E4FSCtwp6lrXcCU0JCU0fv5W7XH1E5oRt6fVnWeCyAhnk=
X-Received: by 2002:a5d:4ac7:0:b0:37e:f4ae:987d with SMTP id ffacd0b85a97d-37efcf4d04amr1667953f8f.29.1729690131115;
        Wed, 23 Oct 2024 06:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDD6AkMvRh9LWvp20lyY9Wdm9PDu+wXJKfUHsaQwzeBWjkyYSwZGDmf0nC2yFn6geOABCd/w==
X-Received: by 2002:a5d:4ac7:0:b0:37e:f4ae:987d with SMTP id ffacd0b85a97d-37efcf4d04amr1667937f8f.29.1729690130779;
        Wed, 23 Oct 2024 06:28:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5? (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de. [2003:cb:c70c:cd00:c139:924e:3595:3b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b384sm8872404f8f.57.2024.10.23.06.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 06:28:50 -0700 (PDT)
Message-ID: <7f49ac72-1868-4dcf-b73d-343c0d523a11@redhat.com>
Date: Wed, 23 Oct 2024 15:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/17] mm/rmap: initial MM owner tracking for large
 folios (!hugetlb)
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
References: <20240829165627.2256514-1-david@redhat.com>
 <20240829165627.2256514-9-david@redhat.com>
 <v2lzmdkpdzuwwdnpgncitxenx7aalcjm5zokjgcienshdjfbrr@alnz7zseqxp3>
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
In-Reply-To: <v2lzmdkpdzuwwdnpgncitxenx7aalcjm5zokjgcienshdjfbrr@alnz7zseqxp3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.24 15:08, Kirill A. Shutemov wrote:
> On Thu, Aug 29, 2024 at 06:56:11PM +0200, David Hildenbrand wrote:
>> +#ifdef CONFIG_MM_ID
>> +/*
>> + * For init_mm and friends, we don't allocate an ID and use the dummy value
>> + * instead. Limit ourselves to 1M MMs for now: even though we might support
>> + * up to 4M PIDs, having more than 1M MM instances is highly unlikely.
>> + */
> 
> Hm. Should we lower PID_MAX_LIMIT limit then?

Note that each thread gets a PID, but all threads share a MM struct. 
Also we are concerned about PID reuse, but not for MM IDs.

So I don't think we should be touching PID_MAX_LIMIT.

> 
> Also, do we really need IDA? Can't we derive the ID from mm_struct
> address?

Yes, that's the whole purpose of it. We need something < 30bit to save 
space in struct page.

The description touches on that:

"As we have to squeeze this information into the "struct folio" of even
folios of order-1 (2 pages), and we generally want to reduce the 
required metadata, we'll assign each MM a unique ID that consumes less 
than 32 bit. We'll limit the IDs to 20bit / 1M for now: we could allow 
for up to 30bit, but getting even 1M IDs is unlikely in practice. If 
required, we could raise the limit later, and the 1M limit might come in 
handy in the future with other tracking approaches."

-- 
Cheers,

David / dhildenb


