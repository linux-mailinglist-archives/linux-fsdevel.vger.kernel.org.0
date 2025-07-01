Return-Path: <linux-fsdevel+bounces-53429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDFCAEF094
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6BC3E2744
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F526A0B3;
	Tue,  1 Jul 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSvhskD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D22698AE
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357479; cv=none; b=kFd6TOdXpaMXZAWdCYafxz94yezz62kyHF/YmP3reCiLtBE2QJDJJMRrVCsOMRH/5v5YZDYz1eIxKkZsbtWzxwOgnilbbBLs4aKOnBcZLxdEJSDZsIZUqb8S0k+uS++XW/rVJi4BudV6xQI0OAydNieMz5Dr890o7LSjiTXlZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357479; c=relaxed/simple;
	bh=xlvxWap5VmqOuFD+5gWUxQuiw4f6r8mbXdJEkaDMaUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4/BLRAuJ3vZ4Q4G5ujB0Kcf7TPzA18u59PV7EHLMxeZ7Z7/zMN4ihS/sRyBmyt188HYC7xlzGUDfis1wIiLy+QgXbICl2bhKVDwWn9sC9kskhQP41D6v4mMVAbPTh55PL3YvY8wk3U0V1L2fDmnAK+fkhWMLixOg2bixrchcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSvhskD3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751357476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YrqKfOfhORr/5vproY5ovuBEQCam7Cslax8BPi13vvQ=;
	b=VSvhskD3ixSpAjRFM02YDXA5fQr7by/BiCvONyik4YO5M+obxsQBND9uN9d0R1rrJhpZR6
	/LsVoWojvody9M/fg7mx/Ok03WDxOF6/UN0V2cQ1v0/egGuIiAlA/8THcjJInABZ+PeK5E
	nm5xFMGVqILktuw7Uh0NTNVwiWWeqHY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-pZ6kfA6QM8uAwSFWWIPQEQ-1; Tue, 01 Jul 2025 04:11:15 -0400
X-MC-Unique: pZ6kfA6QM8uAwSFWWIPQEQ-1
X-Mimecast-MFC-AGG-ID: pZ6kfA6QM8uAwSFWWIPQEQ_1751357474
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so3413854f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 01:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751357474; x=1751962274;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YrqKfOfhORr/5vproY5ovuBEQCam7Cslax8BPi13vvQ=;
        b=wMwsPLZSKp3XeDpEvIcH80I7kUCqDNgQ7rzcXJG5GbHvrO8zM20vp42BXa7G4XVXKT
         iVR9wUshj6tPBwKTv0iWx9A3vBX8734oEome77ANA27l/ABoqyWHjpzr4tC4hpV5euAU
         dMbt/eGrwpB1NQkvwxs0FdbQh2KT9m0q6A5Rq7P+8pooCNNb7P+pnDfxds45IIhDsDNx
         HaERM/QH6St1mEtyaZv1zMYUHKKRCurrdl7pDnzCbILjSMKCPvREWYieY+N7LMItbDir
         XWHv8PWLWyjR4e/5QEWXrRtrezwm2lTmQhBlBkuK+dHDwLm4mjfXnfAwQjDisih2QFjN
         YbNA==
X-Forwarded-Encrypted: i=1; AJvYcCUZKwTc2N5BCDqcSJWdbdVsiqlQuTxaiqF4KUG3EbyItiXO4+Bq8WLbIkbzcRz4sB7S/r+94TuGtMDAwPBG@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUTgz/B7a+cI3fbIlihSwXt1iWHwt63vfvy4q4kBceksgRQuy
	mxr7m+Q4JEMeRAdM8k4a2yyQneLPqETTwhtq7Mmw331FSf4sJc4Y71if2xyfyU274mv4w9Uvvr8
	A+kSqbmFuouti3WgydOBHn6Yv4UOsRLE+k0gbBdWdc2LJVbbiX8PtcQsU/IW2d0VohyA=
X-Gm-Gg: ASbGnctZHfo16BwQyI14K1d/wWfbe9CJ7cYX8TJedfM3VTl7mqUTMpuZgUlWlgy2itR
	AMXrrijewWIIxYO2h0f75YwquB2dBj5vUqF9KQI7lFkdgoe+ANELTnTsJAHGGkiccL2sS3fslVP
	rsEK88cg270O79VaCXmVCF8s8zutjQD7dBUDntq2vpeEW80KSuWJsrQsYrWrWz+A78udmy7z1I/
	uLXSj5MaiZGgl8WQCcNOPMv+Z34SXbAx6bP056QGNgaMsJeTCLigcqLB11tKGsGmDoZRX3+EHQk
	YRmkO01cWBQSeXNJ5/VCNEn89YH/idiD5MiazJrVOUSR4u3P3k6pfXcEM1aPQvpNDDfn4wUmr45
	t0Jz77gHs2vjm9i03FrdZm7UVHX4Y5yFqP4FdqYxAYQnAamVyNA==
X-Received: by 2002:adf:fdca:0:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a90d5a7cfemr12842276f8f.15.1751357473978;
        Tue, 01 Jul 2025 01:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPya9SzQYm2Gmxkryry4rcIJONguISr6QtHQb7EIzTCLPQ+9unHQuu9F1m9XhBP7UVfQjAGg==
X-Received: by 2002:adf:fdca:0:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a90d5a7cfemr12842232f8f.15.1751357473490;
        Tue, 01 Jul 2025 01:11:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52bb3sm12734059f8f.56.2025.07.01.01.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:11:12 -0700 (PDT)
Message-ID: <bac3664f-a961-48bd-b642-368b128bb174@redhat.com>
Date: Tue, 1 Jul 2025 10:11:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/29] mm/balloon_compaction: make PageOffline sticky
 until the page is freed
To: Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-6-david@redhat.com>
 <6a6cde69-23de-4727-abd7-bae4c0918643@lucifer.local>
 <595C96DA-C652-455F-91DB-F7893B95124B@nvidia.com> <aGN8l3-a7GeFhFlz@hyeyoo>
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
In-Reply-To: <aGN8l3-a7GeFhFlz@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 08:13, Harry Yoo wrote:
> On Mon, Jun 30, 2025 at 12:14:01PM -0400, Zi Yan wrote:
>> On 30 Jun 2025, at 12:01, Lorenzo Stoakes wrote:
>>
>>> On Mon, Jun 30, 2025 at 02:59:46PM +0200, David Hildenbrand wrote:
>>>> Let the page freeing code handle clearing the page type.
>>>
>>> Why is this advantageous? We want to keep the page marked offline for longer?
>>>
>>>>
>>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> On assumption this UINT_MAX stuff is sane :)) I mean this is straightforward I
>>> guess:
>>
>> This is how page type is cleared.
>> See: https://elixir.bootlin.com/linux/v6.15.4/source/include/linux/page-flags.h#L1013.
>>
>> I agree with you that patch 4 should have a comment in free_pages_prepare()
>> about what the code is for and why UINT_MAX is used.
> 
> Or instead of comment, maybe something like this:
> 
> /* Clear any page type */
> static __always_inline void __ClearPageType(struct page *page)
> {
> 	VM_WARN_ON_ONCE_PAGE(!page_has_type(page), page);
> 	page->page_type = UINT_MAX;
> }
> 
> in patch 4:
> 
> if (unlikely(page_has_type(page)))
> 	__ClearPageType(page);
> 

I don't think we should do that. It's very specialized code that nobody 
should be reusing.

And it will all change once Willy reworks the page_type vs. _mapcount 
overlay.

-- 
Cheers,

David / dhildenb


