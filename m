Return-Path: <linux-fsdevel+bounces-36060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD69DB57E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EE3166AEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4729018B495;
	Thu, 28 Nov 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7u8njAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D20D15D5B7
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789387; cv=none; b=chH44OspNDCiK8iRssiXLls1yltGLiMTKluITHvxtowruM1WzVh1bWcOZGZowDLEfTiOdGjBqx8NszXIxhlDmqZ4iLF550Kabekwcdd54MR/jPzaJw0VsRWh4wgD0aAedhfVq3TZ1ijAFMbBp5m1XFyr4cMWqUo2lobeI73JRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789387; c=relaxed/simple;
	bh=mnLk4kl0uNJckf1t8LwyXm0cjxkNT/73ZL3aYBrdwJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjVKR/1x8nyIZvBfIheRjA/v0EC2VftfaKu1tTCgGEO1yC5pVf7c6wrCNnokj1kB0bSxwW7j9jf0oLMnqfd7MnSX0TvT7a3Huy1v/vjU9HFQGIuxcaNHrPe6dr+yrnvsnBwJfuvhbwloQ93bYMgUHWVW5i4Rn2YwQFLpRJJe9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7u8njAe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732789384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W3SlFdlaRjeqRhVtJa7K1KovNV/PwaBA3j0dMUeS6A0=;
	b=g7u8njAeZFgqYC/a9TzCQw3hy01jlh3yuITzg4m6k1rY1WnDYVojIrZGSi9kj/T8kndHX2
	OZjhoegEdUUNCvM41KNuvJQLnUvzN1GfzRwaaM9IjyU377tkAocw6avfWU8hZf3EUZdoXo
	QVkExGuVtkMzAftXjOFaL0pNgaOiZgA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-s7o9sLf2PL2fzj84RvF_PA-1; Thu, 28 Nov 2024 05:23:02 -0500
X-MC-Unique: s7o9sLf2PL2fzj84RvF_PA-1
X-Mimecast-MFC-AGG-ID: s7o9sLf2PL2fzj84RvF_PA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43498af79a6so4097285e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 02:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789381; x=1733394181;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W3SlFdlaRjeqRhVtJa7K1KovNV/PwaBA3j0dMUeS6A0=;
        b=pK7H5MEModlQ4JeMtzwHW7bZ39r/FJzUmsxwFp1itRA+4zPLNBRkt9+Y3sHMODQ1fa
         8DLPvosoWofjmbRTqoKR0XDA0cEXsu9wtEKFJ+ivvK2XdssH8Z5mvFBjEefod+y/U5S7
         ogdZEstD6+9nGfnnFg8CfIN4GQeJroZfNch8RGo202waD6F4bv11fgP4vUf3iSWIiVIF
         VjgE0QoZCPSeQbcTWpdHv/uLdEd7nLqyMXUPZL5vjZms0VutLHcWK4qoYraxWb8uwgSB
         hTEIND1RdtTunFMh89HsrchWwjgdfo/Lj6Ekq9v2M3syAgv/3Z8QD03beAEWiRiIugEz
         CEgw==
X-Gm-Message-State: AOJu0Yzi7c6eUASYtjsN909ttAfl1Pu6ExMvF3WtsRd/h8edvhKv9Yq7
	kUvZyGHx2RwGOX/wa2uZsIAPN5EYv+XSRt+AUcVTEm/JKzjanfqVN7MRLc17ANnQcL8ptaHry6b
	PqpykS/RwdC5U3IbxgfzqbxjChqEg+9o8cahsZw9pWcAlwFNOVAObFeqjLaysmuo=
X-Gm-Gg: ASbGncug4n2A9XyEcouSdFVqrpYEK7cYo7pX7RcUC8N1pqBfImII1jGTZhaUbUfyS1M
	zxpRit49N7PrPu4i5X6ffiHgbe/GXHsB+ahSds7UEjeMO8TnyRH+oSGg9U6yT1X15wTE9IBrASV
	Cm1rjXNrjvu9lfFo83Jq4OXj6V/46M8+3EvtQAhEmaY3nHV96TSNn8yaR4b39jl6vwHYctRpHCB
	fRUry1K6zL1tmdelOiKWKUfFcRfLxBN4y1qb6aaAaxR8TnohYfKh4QYlPmNfXQCxkL4hmj441Qj
	FQukmhASEABeGujriOWHCvjBrUoKLHVAhXl5crtrVKb89qpoaswwZ6a8s7SfTReF0DyMpIou4vs
	=
X-Received: by 2002:a05:600c:4e86:b0:434:9f90:2583 with SMTP id 5b1f17b1804b1-434afc1d39amr21807755e9.11.1732789381370;
        Thu, 28 Nov 2024 02:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNH4lTL5kOzRuPOaGKN9oTjxReer6rtPv6632jFBZHiXY1vJbiKWArhNTuY3yITyLkjx6qtg==
X-Received: by 2002:a05:600c:4e86:b0:434:9f90:2583 with SMTP id 5b1f17b1804b1-434afc1d39amr21807485e9.11.1732789381030;
        Thu, 28 Nov 2024 02:23:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:1600:f3b:67cc:3b88:620e? (p200300cbc71416000f3b67cc3b88620e.dip0.t-ipconnect.de. [2003:cb:c714:1600:f3b:67cc:3b88:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7644c3sm48705575e9.13.2024.11.28.02.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 02:23:00 -0800 (PST)
Message-ID: <b517e896-7c04-4f9d-b529-bf9063e69eb4@redhat.com>
Date: Thu, 28 Nov 2024 11:22:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Add support for File Based Memory Management
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Bijan Tabatabai <bijan311@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, btabatabai@wisc.edu,
 akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 mingo@redhat.com, Liam Howlett <liam.howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20241122203830.2381905-1-btabatabai@wisc.edu>
 <b33f00ed-9c63-48b3-943d-50f517644486@lucifer.local>
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
In-Reply-To: <b33f00ed-9c63-48b3-943d-50f517644486@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.11.24 13:23, Lorenzo Stoakes wrote:
> + VMA guys, it's important to run scripts/get_maintainers.pl on your
> changes so the right people are pinged :)
> 
> On Fri, Nov 22, 2024 at 02:38:26PM -0600, Bijan Tabatabai wrote:
>> This patch set implements file based memory management (FBMM) [1], a
>> research project from the University of Wisconsin-Madison where a process's
>> memory can be transparently managed by memory managers which are written as
>> filesystems. When using FBMM, instead of using the traditional anonymous
>> memory path, a process's memory is managed by mapping files from a memory
>> management filesystem (MFS) into its address space. The MFS implements the
>> memory management related callback functions provided by the VFS to
>> implement the desired memory management functionality. After presenting
>> this work at a conference, a handful of people asked if we were going to
>> upstream the work, so we decided to see if the Linux community would be
>> interested in this functionality as well.
>>
> 
> While it's a cool project, I don't think it's upstreamable in its current
> form - it essentially bypasses core mm functionality and 'does mm'
> somewhere else (which strikes me, in effect, as the entire purpose of the
> series).
> 
> mm is a subsystem that is in constant flux with many assumptions that one
> might make about it being changed, which make it wholly unsuited to having
> its functionality exported like this.
> 
> So in in effect it, by its nature, has to export internals somewhere else,
> and that somewhere else now assumes things about mm that might change at
> any point, additionally bypassing a great deal of highly sensitive and
> purposeful logic.
> 
> This series also adds a lot of if (fbmm) { ... } changes to core logic
> which is really not how we want to do things. hugetlbfs does this kind of
> thing, but it is more or less universally seen as a _bad thing_ and
> something we are trying to refactor.
> 
> So any upstreamable form of this would need to a. be part of mm, b. use
> existing extensible mechanisms or create them, and c. not have _core_ mm
> tasks or activities be performed 'elsewhere'.
> 
> Sadly I think the latter part may make a refactoring in this direction
> infeasible, as it seems to me this is sort of the point of this.
> 
> This also means it's not acceptable to export highly sensitive mm internals
> as you do in patch 3/4. Certainly in 1/4, as a co-maintainer of the mmap
> logic, I can't accept the changes you suggest to brk() and mmap(), sorry.
> 
> There are huge subtleties in much of mm, including very very sensitive lock
> mechanisms, and keeping such things within mm means we can have confidence
> they work, and that fixes resolve issues.
> 
> I hope this isn't too discouraging, the fact you got this functioning is
> amazing and as an out-of-tree research and experimentation project it looks
> really cool, but for me, I don't think this is for upstream.

I agreed with this sentiment. It looks like something a research OS 
might want to consider as it's way of dealing with anonymous memory in 
general, but nothing on squeezes into an existing MM implementation.

I'm also not 100% sure on statements like "Providing this transparency" 
-- what about fork() and COW? What about memory statistics? 
"Transparency" is a strong word :)

-- 
Cheers,

David / dhildenb


