Return-Path: <linux-fsdevel+bounces-65411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02AC04CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 123C234F7EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3292F28FF;
	Fri, 24 Oct 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aw4AYbfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D332F12A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291815; cv=none; b=h+ZKm6vCxsvXtD3R6jz1uB3zGeKl5dS0yQVHk4u/FPDmdgSQovKVBgliSxb+Rvvfiny6y38oIYmseNLM7JpKNBv5rV31KCIWsFpiEd+qUgSPGU2h5gN1jdw2+fpgsBDM27Y5gx/JSo858WP2LxVac5U7xFGX/NrhfKPrCwJepu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291815; c=relaxed/simple;
	bh=RPSEvxeK8W2qEMwlGfeFhP4NAWGF2FELvFTl0EMRVSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+cY8h+THa7ZsbV9sDrysetsGoQmE2FSPeHBI8AygcFBpu+IHmWIwvQ6V16TC/FXA8ovMErDNo+YN3DdOZ8IwrGhYb3VDq9B8VeVm9gRshRziGSG4ZfEL+h4vxfoMr6hihxL04vCUtF+e8zbvZxU5Tqd6bgkwlcEpb4MYpQUcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aw4AYbfC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761291811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ygtMJr7lCz2zBOJcy/xlUwclo5GLonX1M9l6w+G0o/Y=;
	b=Aw4AYbfCSdQp1tE76PpGezDYeiAs51yGShmk0aihKmnsZ5FMCmUnEHIFnMgOD1ZDafyqep
	LJqaEQF+JJHLM7rfzIa8Y01TcMuN8XIGI/dFRWEiZIYHvawaF0/gQ3H/BO5HaIagwoLynv
	0DNvGoeCR7DN5SadoQD1mn9zGarGtIA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-EOA4B16oOZOAc7PUP8rA0g-1; Fri, 24 Oct 2025 03:43:29 -0400
X-MC-Unique: EOA4B16oOZOAc7PUP8rA0g-1
X-Mimecast-MFC-AGG-ID: EOA4B16oOZOAc7PUP8rA0g_1761291808
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42558f501adso1128018f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 00:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291808; x=1761896608;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygtMJr7lCz2zBOJcy/xlUwclo5GLonX1M9l6w+G0o/Y=;
        b=kp0MtCHWNkvThkHDpqslkRR+zjvHlg3vcO7SaXBgfOpAKTKUKuO8Ym4bQkn4/ykozX
         Qz7m1aigKR3mOMo+wchz/vkMk0YaR9A80KjwPG6kLmvQ2+fb2bOKW4cgTGLGtsvWJKKo
         +tika29X/LXB+dstwfvFU28OziwSKqD6WltEybyjv7FNli4qIaq9JSSjSLUwyDqj9xyr
         jtwFPtcMm54d2PC8c75j8Kr2uGfv9m8A8vLKwed5KAbgREfYDN3MbnpOI4BT5a41AyXD
         xizIJOPZKjzPCHVRpaP2vbXi6tvz82ysLFr/B06OrOGsPW1y5t/Wndt+bIAcW5eNZ9Vh
         2zNw==
X-Forwarded-Encrypted: i=1; AJvYcCU0bJnjZXloAuo19pYi5TwRygMZHExLIKssHKFakEUf77cOlaDolP9zyAfeCQpyqCHw/O3QGpAO61vExMWy@vger.kernel.org
X-Gm-Message-State: AOJu0YysJHkYkG1z+3Ko/uJqpKDesjHXbcZt/ktygc37hG87yDS346tL
	vRHnpHtyKdou6k+cS52oH5e7FWbF9fQhpHDaP1RmuP50VEgmQ6jbUHkkcUjVamp03TAFVk1AoXw
	iw0gUHJvkBDIpnUHJjsNrBVoqGq0dszw1Yow94VfNaB1ETHtv7E77d7+wGLaujmFrG4w=
X-Gm-Gg: ASbGncswlBCWXtYBMK6XRT+YDb+azl6fTXVUbC2jylYbC7lwRfPPauVQnBP0sklxszD
	Luvrcj8KSxkoa4Y9n20yoxhB0HiJNMcLEPWAPHq9ELwjcX86n/UXt/leiWzb4REP/jMEU7SNvfR
	UNth4KfkQkyY9tOs29nMrmzOz4WZTSW8v6C3zg7frourcYAKpQ+FntFBr6AqAJq7hFvZXvqQUnl
	j2rh6QDz75GLqNnpdpFXf4EQMe7ivCwV7uoVxc+4l4q7lOHkRoXH/aO2TD3dvlP2bPQVFleG47k
	YSEJCMa/w6UItF/RvFAwONa5GVSk4m62WKiLK0w0csJ/lW+zv5zwNGQ6YMcSgt2ex0mBvziWcGs
	tbAtjSaPjVu0GxoSeO9Q1lePbDvfcBQJsIC2RtsqL9ii4bkTX+gaayrLvfnCPXGVQLonbdK8aD0
	1a/M+tmMve7JTi10UQh+gqyGgx7Qc=
X-Received: by 2002:a05:6000:1445:b0:429:8d0f:e91 with SMTP id ffacd0b85a97d-4298d0f101fmr2145788f8f.3.1761291808128;
        Fri, 24 Oct 2025 00:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuzdzaDgFKtnHrcm/Lod7mOzyuAWHQUr2N7K0uuanDY4JiUSZCT2EploISrXTL5ZI5AMbDFw==
X-Received: by 2002:a05:6000:1445:b0:429:8d0f:e91 with SMTP id ffacd0b85a97d-4298d0f101fmr2145765f8f.3.1761291807710;
        Fri, 24 Oct 2025 00:43:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898adda1sm7943559f8f.29.2025.10.24.00.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:43:27 -0700 (PDT)
Message-ID: <9c1450ba-ade4-4236-8d3e-c5658a3a26c3@redhat.com>
Date: Fri, 24 Oct 2025 09:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
To: Dave Chinner <david@fromorbit.com>, Andreas Dilger <adilger@dilger.ca>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
 <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>
 <aPoTw1qaEhU5CYmI@dread.disaster.area>
 <AF891D9F-C006-411C-BC4C-3787622AB189@dilger.ca>
 <aPshzHsqp2Srau5T@dread.disaster.area>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <aPshzHsqp2Srau5T@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.25 08:50, Dave Chinner wrote:
> On Thu, Oct 23, 2025 at 09:48:58AM -0600, Andreas Dilger wrote:
>>> On Oct 23, 2025, at 5:38 AM, Dave Chinner <david@fromorbit.com> wrote:
>>> On Tue, Oct 21, 2025 at 07:16:26AM +0100, Kiryl Shutsemau wrote:
>>>> On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
>>>>> In critical paths like truncate, correctness and safety come first.
>>>>> Performance is only a secondary consideration.  The overlap of
>>>>> mmap() and truncate() is an area where we have had many, many bugs
>>>>> and, at minimum, the current POSIX behaviour largely shields us from
>>>>> serious stale data exposure events when those bugs (inevitably)
>>>>> occur.
>>>>
>>>> How do you prevent writes via GUP racing with truncate()?
>>>>
>>>> Something like this:
>>>>
>>>> 	CPU0				CPU1
>>>> fd = open("file")
>>>> p = mmap(fd)
>>>> whatever_syscall(p)
>>>>   get_user_pages(p, &page)
>>>>   				truncate("file");
>>>>   <write to page>
>>>>   put_page(page);
>>>
>>> Forget about truncate, go look at the comment above
>>> writable_file_mapping_allowed() about using GUP this way.
>>>
>>> i.e. file-backed mmap/GUP is a known broken anti-pattern. We've
>>> spent the past 15+ years telling people that it is unfixably broken
>>> and they will crash their kernel or corrupt there data if they do
>>> this.
>>>
>>> This is not supported functionality because real world production
>>> use ends up exposing problems with sync and background writeback
>>> races, truncate races, fallocate() races, writes into holes, writes
>>> into preallocated regions, writes over shared extents that require
>>> copy-on-write, etc, etc, ad nausiem.
>>>
>>> If anyone is using filebacked mappings like this, then when it
>>> breaks they get to keep all the broken pieces to themselves.
>>
>> Should ftruncate("file") return ETXTBUSY in this case, so that users
>> and applications know this doesn't work/isn't safe?
> 
> No, it is better to block waiting for the GUP to release the
> reference (see below), but the general problem is that we cannot
> reliably discriminate GUP references from other page cache based
> references just by looking at the folio resident in the page cache.

Right. folio_maybe_dma_pinned() can have false positives for small 
folios, but also temporarily for large folios (speculative pins from 
GUP-fast).

In the future it might get more reliable at least for small folios when 
we are able to have a dedicated pincount.

(there is still the issue that some mechanisms that should be using 
pin_user_pages() are still using get_user_pages())

> 
> However, when FSDAX is being used, trucate does, in fact, block
> waiting for GUP references to be release. fsdax does not use page
> references to track in use pages - the filesystem metadata tracks
> allocated and free pages, not the mm/ subsystem. There are no
> page cache references to the pages, because there is no page
> cache. Hence we can use the difference between the map count and the
> reference count to determine if there are any references we cannot
> forcibly unmap (e.g. GUP) just by looking at the backing store folio
> state.

We can do the same for other folios as well. See folio_expected_ref_count().

Unexpected references can be from GUP, lru caches or other temporary 
ones from page migration etc.

As we document for folio_expected_ref_count() it's racy for mapped 
folios, though: "Calling this function on a mapped folio will not result 
in a stable result, because nothing stops additional page table mappings 
from coming (e.g.,fork()) or going (e.g., munmap())."

It only works reliably on unmapped folios when holding the folio lock.


-- 
Cheers

David / dhildenb


