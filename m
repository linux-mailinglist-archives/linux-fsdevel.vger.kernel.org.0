Return-Path: <linux-fsdevel+bounces-50387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB3ACBC5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 22:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543B47A96AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E421C177;
	Mon,  2 Jun 2025 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/QhxY3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486A21128D
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896383; cv=none; b=sOdu/8wMIToHZuKpYXJrGwJXUXw04LbdUtk8fwHl38kF6gMlO99Yuwx8BwnDboSEr7Wj96WEaw8JPdVyc6g8/yN6mHwB7vq81h8FfkmTHKorPhinLi1oznYN1c58RuoCFSqnbmurpNEZJeXxL8zzrRGJgMvtEtRb2boX8NtTVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896383; c=relaxed/simple;
	bh=LdiIhh93dXCCm2PcWMurrWqKc4LYxFEu5GqgNS9PHno=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CFJXDh0iBM5mtdvX3skIFxCIQHXUykzovzGJhBk166JwheUy/F1wSuCJlZ8IVYr6taOjCSYdnf8DibX7DdcDNBwVZhgb1HPMH2pJNJtgLWglLw816e7OWxnoEAVDRGZGdbP3z6+Fw7Bh8R66oZWfpiG2Iq+pxc/m9l90HB92t6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/QhxY3v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748896381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rV/xn46OPX4p3xq3mkWtZ8NGtbJKFadJJeI/QsB8Plk=;
	b=N/QhxY3vRy4yJljpIlQ9WmxNojqy6l0OvlceIpFvV4fOMp4jgZDzgBXS9F8PPAfGjdTnYS
	dG7bIilyAxpqj6O/EvsHHYzDc3jdU8/vz+eufScVC0tKDy2IouaGkojLu9HXEuEGqbBt+g
	Ugbm99U1ev1hqyU6GBIfiXopLGVUDl0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-DgPrN3GEOjSSWiqnIe1TsQ-1; Mon, 02 Jun 2025 16:32:59 -0400
X-MC-Unique: DgPrN3GEOjSSWiqnIe1TsQ-1
X-Mimecast-MFC-AGG-ID: DgPrN3GEOjSSWiqnIe1TsQ_1748896378
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a503f28b09so765966f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 13:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748896378; x=1749501178;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rV/xn46OPX4p3xq3mkWtZ8NGtbJKFadJJeI/QsB8Plk=;
        b=A3YhPbWUlb6SE3REu2+96LeHdmUvBBPRaDMuhRflBtlhjy84jBi7lha8ZZezTjTUVf
         mx2N5hfLuv6U23zagGPAK+n6SRcHyjUynfSUVeSP2WQPjGfcQnIc66E+6A3htevmMYWo
         ABNqIzXH9aSo2CjuHF3LPUrqRU6jbWXP3zyS65rqc7fzCC00iHDpLj+oJHzjvC3ghh0f
         G6JcMjdrf8I9MyX1ailGN/Z7EOo9531X8v8J8Nwh1ol+cRI7LXLgYr8NTO8rwIyI+Bh6
         izcoD3gllFAW11yiSIBFHFpXUVmedihymjWKik9/OrMePI/ucoIBM96xdGOjtEw/zmq1
         /WXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsRbwhoeos/66S7kk/D0XsTjtFxonsh+QfRSTmhCdPx7Zow5oVcb5Hpu8KaLCO7sOF09Mv/ZEBZHYghexT@vger.kernel.org
X-Gm-Message-State: AOJu0YwXe7qf8/GDxJq7KFq5G/8pAVj4asF3D20DiP2K6EJfmOunXL2g
	ofdtvrOJakS5h3LAeDuxC07cVnFeOWc26Nlua27eKV+DcFI64j2j3/1zT18Yd+XReoLIG8NEJIj
	jEJKCrl9JTNr/ordTTspI75cgR6z0N+9L+NI9RAoxzNdBS5h83z7/O/HUHseLDzrSOqM=
X-Gm-Gg: ASbGnctsTZreGkvwFsIFcey3xspdBZBRjbD2/sTAQicbRluEC4dCkA+WCn90qLnJCTH
	KSkmFNkss1iqfLX2+c928u7Uf5h5pNs6RfMbN7xB32F+9K0rvXopYuHMZJUEQVI5SWkuOdoPGIe
	aDO6jKybS6kYH6nokesplrXUWpCPlMLSYMso48FmyjUx4xlZqbA65s7ECuvCTda5QNSijdnNEwm
	GgcD4ELZzM9xKpqOkG0KU1lm3Jc3HepNwZpP5E/m/yuTe19x0WO0USRI8Fhnv/E+MUaFk8kIko5
	aKUsGlV6McnzbkLWcXjY2YoAgdklBL+4EtJ8VyUoy5ECHY4VnmKXKWVH3o3vM3mM6LWmttcRx+2
	Vb3SR37W/QJS0fdU85gcRUPaeTZg8s1oyTKahoNU=
X-Received: by 2002:a05:6000:2507:b0:3a4:f7e7:3630 with SMTP id ffacd0b85a97d-3a51419e594mr6702f8f.15.1748896378414;
        Mon, 02 Jun 2025 13:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKGMuCXnK5YSdjQL2VvSTmgIciOLzGBriUAeXPzCZMHVa3TD18rFDC3ib6WqfRPIEUfRZ+WA==
X-Received: by 2002:a05:6000:2507:b0:3a4:f7e7:3630 with SMTP id ffacd0b85a97d-3a51419e594mr6658f8f.15.1748896377906;
        Mon, 02 Jun 2025 13:32:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73f83sm15508352f8f.49.2025.06.02.13.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 13:32:57 -0700 (PDT)
Message-ID: <842b8b5f-fe0b-436b-b8d7-64b215bdf9d9@redhat.com>
Date: Mon, 2 Jun 2025 22:32:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
From: David Hildenbrand <david@redhat.com>
To: Pankaj Raghav <kernel@pankajraghav.com>, Christoph Hellwig <hch@lst.de>,
 Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
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
 gost.dev@samsung.com
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-3-p.raghav@samsung.com>
 <20250602050307.GC21716@lst.de>
 <aa6fcbdd-5b1f-412c-a5db-f503f8a7af72@pankajraghav.com>
 <04a27029-df1e-43a7-8642-15f351121438@redhat.com>
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
In-Reply-To: <04a27029-df1e-43a7-8642-15f351121438@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.06.25 22:28, David Hildenbrand wrote:
> On 02.06.25 16:49, Pankaj Raghav wrote:
>> On 6/2/25 07:03, Christoph Hellwig wrote:
>>> Should this say FOLIO instead of PAGE in the config option to match
>>> the symbol protected by it?
>>>
>> I am still discussing how the final implementation should be with David. But I will
>> change the _PAGE to _FOLIO as that is what we would like to expose at the end.
> 
> It's a huge page, represented internally as a folio. No strong opinion,
> as ...
> 
> MMF_HUGE_ZERO_PAGE vs. mm_get_huge_zero_folio vs. get_huge_zero_page vs
> ... :)

Just to add, the existing one is exposed (configurable) to the user through

/sys/kernel/mm/transparent_hugepage/use_zero_page

combined with the implicit size through

/sys/kernel/mm/transparent_hugepage/hpage_pmd_size

-- 
Cheers,

David / dhildenb


