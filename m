Return-Path: <linux-fsdevel+bounces-52869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01907AE7B01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976513BF997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3654286424;
	Wed, 25 Jun 2025 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlfKMd+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B727991E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841760; cv=none; b=LvqtvX7ThNjoY700aKGnZkJ0ebhflXu/xBQtWpWAWoUbbNCQt33BA3caOIp/ZeLQx8Mv9DbZSmVMFzqj1tzt6r/t5MmrTyCjPfR2/2aiRAnb4wkJUzSU13bhAwqe8UvLoaNqKWm/pWtCOEPoFneaw0gDVycjNW+YWASQgzHtZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841760; c=relaxed/simple;
	bh=tf35KtTzA5mss8fmiNEjVbGmUAJ95Y55dIVbi+StKhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFlnypVWMe0Ls7URKMi7ovgAGwOUfeMRJZW4+DBWXKC2+4FY1Dpqss17QV4WkfPGgfVkb0/aReHFhm3hF1ujShs8C97HB0w0MWzq1eUiPApXihjj7kQgaCIu2wcOlKCMpV4XEQepNIklAh6uEWrRnkGhbKoTBnjXMPHi3wdmdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlfKMd+H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750841757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NintfTGRzXfaHVuSILiqulIMZ5CqmzdFP+2lgyyhAjk=;
	b=RlfKMd+HmGB8h/WoHq+U9f2Oc7cVnURUHUBG4d96IYxQfSKsIMWUxPrTDYVuJZNii2Mad/
	QBgpPYBs4FXIyJbtcFsRGvruEwRqltTShVLv8cQygqbHgZAAzAyVTK05EFWGsjc3CI4qam
	QWpF9rK88528NBKFGpjh9yz8wwtkmLw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-FNTkvQwyNAGXkxkUgAqSng-1; Wed, 25 Jun 2025 04:55:54 -0400
X-MC-Unique: FNTkvQwyNAGXkxkUgAqSng-1
X-Mimecast-MFC-AGG-ID: FNTkvQwyNAGXkxkUgAqSng_1750841753
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450df53d461so46444765e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 01:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841753; x=1751446553;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NintfTGRzXfaHVuSILiqulIMZ5CqmzdFP+2lgyyhAjk=;
        b=UqpduXARg2dOT1xzIxqImW9VE3uSXo4BpEDh0aRVZekXP44vA0DgqVNogWcahHnnkR
         90vF8M8jsfuSDLZQfQvBWyq50z0VX1PHXFaXRqLr+kZbtWfcVXBCk0+WE72VLvVEI7/C
         ndwVv6QyzuXzK6yrsFh1x52SjPy1CZlMY+ncSIoA0sGlIliJY4E9bGdjN41cC83dcK4e
         HboPYurfDMhYR17JhBAEa/HTjU+BNAK3zBH1AHpy9HaXEtdr/bpA2c3dJ3cIYdTMwpK6
         rQiJE4uSyJq9ycGkUuxi8QTnEPb6F7yEKO5s/YxGhwx4YbxMrFcbrYV44QfbVDMA2ZQf
         hTdw==
X-Forwarded-Encrypted: i=1; AJvYcCW1kWSeAIbHdj2FLaLQvq8AVZKTqiTOcRNEzPEgm2rBHqqYT85WVS/zXk8nm2RLlWGuoJu3a2PAQU0oj3rc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9QesnIwzqheVCe+j/GBQI+f7/px7KNhSwQ+Y7b1B1OooSlU+p
	952q/PhggaRx5Ac98Un9DZWiI+1ZWsfX08CRS0/cyexNnzY7FgrqCEgTQSPpBwHzJV6FY97M2Mt
	qTxyqePGK+nNsx7zwuSAC++facONDZCu5dXcagW7+4B8uIfccKpryz0SnDFI8D+u4kfM=
X-Gm-Gg: ASbGncuTWfwA5UwW88N4TEwUhckESR7rrc7f4yqoXzWO2nRq+68wQ+AH69N+T3fGMho
	OlUvVuVtpohZzT5g+GJluXpS9YXjnLXDwsw7BqeQG+5sDocPawXbvGXKsSJpNgvyzZsidBagy/u
	0iDmCfdlf7pFADBZlIYg4TwtjdFMFSDArNWrb+8pa/kIW6ybBaVWI4IJazJaMP/KyOozpgO3ejI
	ty6iwaZL+xU6U+qJcbQh1xnTuyOVdSP0E9oXAG4NZgmFCA7mQNIK1n3up5AlC5mNWAXJ1DdhM3H
	4dZ4Wd2uxU+kdWDqQJ0TGXV317X/rBHW8su/EtsUnUeJYUhfBaBrLdls7SfA2E5s5WlO6n6hfVv
	Dn6Mff9NwF+UJCxwreZ6ABChw89+H/MXbk0ovP3nooqsI
X-Received: by 2002:a05:600c:8283:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-45381a9cb93mr19105775e9.6.1750841752683;
        Wed, 25 Jun 2025 01:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn9Ma24frP1Xh9SKWBbPl9V+zUB9RWKKedqyriMy2JgojdvqahW4a1Ef0ehUqtLxBkknO9Uw==
X-Received: by 2002:a05:600c:8283:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-45381a9cb93mr19105395e9.6.1750841752253;
        Wed, 25 Jun 2025 01:55:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:1b00:5d6b:db26:e2b7:12? (p200300d82f121b005d6bdb26e2b70012.dip0.t-ipconnect.de. [2003:d8:2f12:1b00:5d6b:db26:e2b7:12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8051001sm3982593f8f.1.2025.06.25.01.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 01:55:51 -0700 (PDT)
Message-ID: <dc34a5ad-376f-4509-91c1-e220f88f97e8@redhat.com>
Date: Wed, 25 Jun 2025 10:55:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/14] mm: vm_normal_page*() + CoW PFNMAP improvements
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Alistair Popple
 <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250617154345.2494405-1-david@redhat.com>
 <06a2d665-0f1b-4e7f-9747-b4c782395dc0@lucifer.local>
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
In-Reply-To: <06a2d665-0f1b-4e7f-9747-b4c782395dc0@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 10:49, Lorenzo Stoakes wrote:
> David, are you planning a v2 of this soon? If so I'll hold off review until
> then, if not I can get stuck in when I have time?

There will probably be a v1 called "mm: vm_normal_page*()" where I drop 
the problematic bit, and respin the problematic bit as a new RFC once I 
have a better understanding.

So, no need to review right now.

-- 
Cheers,

David / dhildenb


