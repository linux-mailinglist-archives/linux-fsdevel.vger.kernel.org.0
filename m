Return-Path: <linux-fsdevel+bounces-40137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF15A1D1B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 08:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485E93A2C7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 07:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67FF1FC108;
	Mon, 27 Jan 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwiuJtNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59386340
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737963986; cv=none; b=FI/oTWiqCiLAf1fHoq8v98pw+aRuyH7ENClhCv5o5jNSVc2xzWaibLyx424SIk4VZTwYbZSJK+yWevPcC2LN1stshbPMnYnLkMkat85JUSFiHAj4FgCkhoxl2kHLzjKSwfj+RCDEe+RR2j3ykvkPCTEoG6rMdI4D/raTbPmFMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737963986; c=relaxed/simple;
	bh=EoDOgMHNHijeB9Q3C6DZOlxjPSUkCZLm75PNU3kOqns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjYYNsqbesfK5SohVx/mr+vj9tDDIgEgcuJKQqQxSTKAeay2cJmPhigpQRehkeOX3+lE1zXPG4l4GwYY7C8MXr/1hkHJWxlhCHmZ+wCC8J1L/PUvQHvv1RFTsqH/Jzj4ebX/ziZFSmzzvEqiGDiC3REKEQ5k/1wwvq6uLND0Yvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwiuJtNR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737963983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NE7810edLcG5Dqux1w9QrALHPD0lFOR3x32yYOFcGRk=;
	b=YwiuJtNRPSpekbLnL7LBU7fIo+pUdb+1BxhaXtjfaCFVaPYV5OXvRVFdBb/haET6XHFL1k
	1uZ5/ZBAjU1JZHZBKyafiwOa+adnlAD0KwRtd+XCQ9LwZkULz0sm53EmoysVJLWtWl1H85
	ycIagYImG2xYUVlloPRlGv7diCm/Wc0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-cshbxwqjNHeCmbwFmf7SPA-1; Mon, 27 Jan 2025 02:46:21 -0500
X-MC-Unique: cshbxwqjNHeCmbwFmf7SPA-1
X-Mimecast-MFC-AGG-ID: cshbxwqjNHeCmbwFmf7SPA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so23075025e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jan 2025 23:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737963980; x=1738568780;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE7810edLcG5Dqux1w9QrALHPD0lFOR3x32yYOFcGRk=;
        b=CNBiA7O205D4r5gdVpR1GqGL7qa6fSBJTbIpSqSe21Sg7XxTe+cXAhDAQSEyqMl6ay
         JhsPT2migD1s8gtiAVFEKM0WtCudI10r4NF/v95fs8E1guns+K1X2M0/XEe7kuIEfDjF
         Kgljdwpwl/ysPGTX126w0ndx/WTpc+OEgt+zMVlbnr1HeqFzl2jbS8k3psaCq1RLPZ91
         XQtLupoA4xAEQ7zOCzGFde2HQ9fT0XTqJhhTXukxaLnmffVEDVMtLvkOqZt8teeg+snh
         8PzS0jTleUmX8rP++VqsHOfuN7/ZKqAQ42imbMs8pC4VB9m8ObgIGOSpm/VMwMxcPUqC
         4yGw==
X-Forwarded-Encrypted: i=1; AJvYcCWlLx09Jvs3y9KxeVM8SbRweBGMFQ/JRSmEK85ywl12SYUpVXLokRTriEYWgqU6nqWCBnZofVXj7HMRPFGY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6A0WdskvQH4ZJvfXRI516UlTdMUDNp468xkwyrh8ZdYP8mVWJ
	O2qdzfW2QBt0ErtkTtVlDQtxTbKWCgXrPRPvgGZaXmC39fqfw+kbn/zlJZ7TqaZaH41nz7Ah7cb
	mJ/crNsv+DICkwOEhFCSbN2hJw7yBUVYlIkv7SlXeecq1GzEABB5MCatpmojhBhY=
X-Gm-Gg: ASbGnctfUGXk6864wiTH4jdk9RuY8XqT/z5kgF5vWyBlgAB7hnn2bv9cyJCZt7PNtb4
	o5DI77IR17X0pbh3wqWBteUCvVSPQ5PoSKbnlRWxFIxhjxZh00VgDVMPWEmtFPxoVtSneRxEko/
	wdM/wPtgrFa03JE41c8SqzJf66NSUI1MrfCUbWzCt9J9cZWv4TzXxuZSjyYP+H7VLy3w/84ivbL
	hGhynY721kG+N/bIb8sQ/WVrTjW1L2J+wEBLN7HsCdBh1fYDdXSgfeLvO3SCHfTHNlPeLGyuvAy
	EQC+xhpQ9fkWBvEOGcFKeQFxlKK9uma6diKYMVWAwwC/UMUEbgewDq/qtBJn0fHctcNgWRYd7Sz
	zdRjobURaC0i/UANCzahGdDVkqsvcw5Ll
X-Received: by 2002:a5d:47cf:0:b0:38c:1270:f961 with SMTP id ffacd0b85a97d-38c1270fabemr24316532f8f.46.1737963980244;
        Sun, 26 Jan 2025 23:46:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEem3mJZWuKfyu7HCVvWKP2KnEnp2acnJWkeu9cplWyo/gcjcvQ5GQVZUAWDDf523oogYEt1g==
X-Received: by 2002:a5d:47cf:0:b0:38c:1270:f961 with SMTP id ffacd0b85a97d-38c1270fabemr24316506f8f.46.1737963979864;
        Sun, 26 Jan 2025 23:46:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c? (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de. [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a189283sm10379549f8f.59.2025.01.26.23.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 23:46:18 -0800 (PST)
Message-ID: <a6d76f2d-1fab-4120-8497-2ce67db5c4cb@redhat.com>
Date: Mon, 27 Jan 2025 08:46:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: page_ref tracepoints
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-fsdevel@vger.kernel.org
References: <Z5KerEzWmu61hFDU@casper.infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <Z5KerEzWmu61hFDU@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.01.25 20:55, Matthew Wilcox wrote:
> The page reference count tracepoints currently look like this:
> 
>                  __entry->pfn = page_to_pfn(page);
>                  __entry->flags = page->flags;
>                  __entry->count = page_ref_count(page);
>                  __entry->mapcount = atomic_read(&page->_mapcount);
>                  __entry->mapping = page->mapping;
>                  __entry->mt = get_pageblock_migratetype(page);
>          TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",
> 
> 
> Soon, pages will not have a ->mapping, nor a ->mapcount [1].  But they will
> still have a refcount, at least for now.  put_page() will move out of
> line and look something like this:
> 
> void put_page(struct page *page)
> {
>          unsigned long memdesc = page->memdesc;
>          if (memdesc_is_folio(memdesc))
>                  return folio_put(memdesc_folio(memdesc));
>          BUG_ON(memdesc_is_slab(memdesc));
>          ... handle other memdesc types here ...
> 	if (memdesc_is_compound_head(memdesc))
> 		page = memdesc_head_page(memdesc);
> 
>          if (put_page_testzero(page))
>                  __put_page(page);
> }
> 
> What I'm thinking is:
> 
>   - Define a set of folio_ref_* tracepoints which dump exactly the same info
>     as page_ref does today
>   - Remove mapping & mapcount from page_ref_* functions.

Yes, I did not completely remove the mapcount in 
6eca32567455db2db38b1126e0d6ad8f0e5c3ed9, but likely I just should have. 
We're dumping raw values of flags/mappings/mapcount right now, and 
probably we should drop them all here.

I also once thought about introducing folio variants on my todo list to 
dump actual per-folio fields instead of raw values.

One "problematic" part in the current usage are things like 
page_ref_sub_and_test(), where we end up calling 
__page_ref_mod_and_test() on something with a refcount of 0 (or could 
even have been reallocated? not sure)



-- 
Cheers,

David / dhildenb


