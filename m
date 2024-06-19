Return-Path: <linux-fsdevel+bounces-21935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88290F74B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 21:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636CC2847F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C146615958E;
	Wed, 19 Jun 2024 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV5BdIP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E61E77103
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827144; cv=none; b=X1cTtLIBolRHN9LftDRqKcdq96l26SrWYijDvBOcy+jSlV6H1FKKjhZq04CsNsbX4nzczqg5zKBYfuW2XKMKUT8NCX/fbhSd9LATQ4fQuidZWJPzqvCp2zo6bRi4RXmCp/vbEY1DFiIh+9kV+y/5fc4PqbVpYjcx5aYhO7U6cV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827144; c=relaxed/simple;
	bh=duBAs5gzjFgfPQCOjhdXawsgFb18NaldwHTBPH1/ZTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CglShzBRJC11gDg9Hy2Kf2oK1/mySaMeYKfb6qjTKcCcXczY4ezSo571mRaKpTBHYIIMbcR+rHWHl18Z86l/vyusFQTbWrjdR2lQpfylB3TMHuTk8WBSMyP9f2ZVNhfHMmqwgSErlqfMerqfOq2G5KXHw/xg163BLSFSbeO+9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV5BdIP/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718827140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RF16d+mc/aQfj+ax5CELrMPG6TejS0N3t5cXY8n35Iw=;
	b=CV5BdIP/JOKmVRABw6lhTZQoLWwOUf3Bayol+tVWVMOdeuhOFic7A3iGXseI7K9oaqH9Fe
	O0VXJBw8W3iVEM7i+QhIizor9be1kUtY0PI9qFtOt4e2J5kTLv3XQ0MfXLdeRGCDIgv+9a
	Wqpv1loOXP4Ayv5W8T0yYx+p6pitpZ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-iEnXMdP2Ng6BGcuZvHWMjQ-1; Wed, 19 Jun 2024 15:58:58 -0400
X-MC-Unique: iEnXMdP2Ng6BGcuZvHWMjQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4217f941ca8so1174095e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 12:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718827137; x=1719431937;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RF16d+mc/aQfj+ax5CELrMPG6TejS0N3t5cXY8n35Iw=;
        b=sQvSoe3hI9j4sOB/l9U16Ois95xip08/cI1k0H/eHhgoGvvIzJ0328+AKw2Z70d2Jm
         XUvto56hAMo3ALesxlJuFbEPAB4l1sg2WDzcGVQ1/OkSdAGAoGM67C4Z2ZB8+ySB1lFS
         g1Opw0eGrGDeRNr9q1739gBhqjNpljI3z8JEHbBycI6x/dANJ2avvlPMTQfJbBHwnYGX
         q7BO3jitDcnA5Gx5clfPYTQnsBZy2cQU9MeilLNVZfbAzS42QSkAD4xwcknVZTfuhB4C
         NNWM3jI6SNnF/6VoK32ncLYKwj/CZoVZFcG8YD5Og7qVwzSkmb7hkfped4xJV5tCS6XY
         L8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXM+RD70qZFlRKUXpTwT85LgqwKKiQnL6gFTw8/fNTeRNP/p/4S6P7uFaaTAnMuMNHKrd5q8jj9DJbU9L+aPpPmMFKfyZ/qM1jvbvddJg==
X-Gm-Message-State: AOJu0YzOcFsf/1RVBLAZcBGYWtemJJOc4/ZlgVTEr5F4iP/7tRZssti+
	psbvGwB8qzFtv4GHqoSjk6HIR5CtnCGNHh5QFKa2asD5UNUPQp/fAhyyAma5FItHcvNUsgSxO0Q
	gnNV+5+XK3lwI9/XXJAX4qZezA7hQwxhPnEfE/42x0YfE6qt1GSQB9HRjimgOMiY=
X-Received: by 2002:a5d:494f:0:b0:363:1a1:10d1 with SMTP id ffacd0b85a97d-36319a85dbfmr2465008f8f.58.1718827137393;
        Wed, 19 Jun 2024 12:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvvpq6xSJeHz1RTg0F73mLCmRqdckSJzJJiZSAhv6hEadDizab5847wMQY9j2IhyerzAz7SQ==
X-Received: by 2002:a5d:494f:0:b0:363:1a1:10d1 with SMTP id ffacd0b85a97d-36319a85dbfmr2464996f8f.58.1718827136997;
        Wed, 19 Jun 2024 12:58:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ab00:f9b6:da12:cad4:6642? (p200300cbc705ab00f9b6da12cad46642.dip0.t-ipconnect.de. [2003:cb:c705:ab00:f9b6:da12:cad4:6642])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-363c795febfsm2138938f8f.104.2024.06.19.12.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 12:58:56 -0700 (PDT)
Message-ID: <75c1936b-bb08-423d-9a17-0da133cbee01@redhat.com>
Date: Wed, 19 Jun 2024 21:58:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Gavin Shan <gshan@redhat.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>, Linux XFS <linux-xfs@vger.kernel.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shaoqin Huang <shahuang@redhat.com>, Chandan Babu R
 <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me> <ZRci1L6qneuZA4mo@casper.infradead.org>
 <91bceeda-7964-2509-a1f1-4a2be49ebc60@redhat.com>
 <6d3687fd-e11b-4d78-9944-536bb1d731de@redhat.com>
 <ZnLrq4vJnfSNZ0wg@casper.infradead.org>
 <CAHk-=who82OKiXyTiCG3rUaiicO_OB9prVvZQBzg6GDGhdp+Ew@mail.gmail.com>
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
In-Reply-To: <CAHk-=who82OKiXyTiCG3rUaiicO_OB9prVvZQBzg6GDGhdp+Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.06.24 17:48, Linus Torvalds wrote:
> On Wed, 19 Jun 2024 at 07:31, Matthew Wilcox <willy@infradead.org> wrote:
>>
>> Actually, it's 11.  We can't split an order-12 folio because we'd have
>> to allocate two levels of radix tree, and I decided that was too much
>> work.  Also, I didn't know that ARM used order-13 PMD size at the time.
>>
>> I think this is the best fix (modulo s/12/11/).
> 
> Can we use some more descriptive thing than the magic constant 11 that
> is clearly very subtle.
> 
> Is it "XA_CHUNK_SHIFT * 2 - 1"

That's my best guess as well :)

> 
> IOW, something like
> 
>     #define MAX_XAS_ORDER (XA_CHUNK_SHIFT * 2 - 1)
>     #define MAX_PAGECACHE_ORDER min(HPAGE_PMD_ORDER,12)
> 
> except for the non-TRANSPARENT_HUGEPAGE case where it currently does
> 
>    #define MAX_PAGECACHE_ORDER    8
> 
> and I assume that "8" is just "random round value, smaller than 11"?

Yes, that matches my understanding.

Maybe to be safe for !THP as well, something ike:

+++ b/include/linux/pagemap.h
@@ -354,11 +354,18 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
   * a good order (that's 1MB if you're using 4kB pages)
   */
  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
+#define WANTED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
  #else
-#define MAX_PAGECACHE_ORDER	8
+#define WANTED_MAX_PAGECACHE_ORDER	8
  #endif
  
+/*
+ * xas_split_alloc() does not support arbitrary orders yet. This implies no
+ * 512MB THP on arm64 with 64k.
+ */
+#define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
+#define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, WANTED_MAX_PAGECACHE_ORDER)
+
  /**
   * mapping_set_large_folios() - Indicate the file supports large folios.
   * @mapping: The file.
-- 
2.45.2


@Gavin, do you have capacity to test+prepare an official patch? Also,
please double-check whether shmem must be fenced as well (very likely).

This implies no PMD-sized THPs in the pagecache/shmem on arm64 with 64k.
Could be worse, because as Willy said, they are rather rare and extremely
unpredictable.

-- 
Cheers,

David / dhildenb


