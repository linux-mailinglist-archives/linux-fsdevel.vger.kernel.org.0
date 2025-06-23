Return-Path: <linux-fsdevel+bounces-52623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95667AE48E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0273BE2AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8620278172;
	Mon, 23 Jun 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a803YZ1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185425E839
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693082; cv=none; b=ePCeEpvGbkMXJjvel4RCjpF+mZc9ygOq2zkLilQkoi03b7fsZCKl1AoX4TVQChzaznfsSfKKaocxNe32K9MtHxfU3U3zG2sTMBZzxEXCLFRU85jwbxqbV9RaGMKeljf0rnWLyyU0mRNPyg3HtWq0FDQ0RzQdS+/eld23BsEv1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693082; c=relaxed/simple;
	bh=bS2LEiehQHAQ8md5Caf5xXTI/g/ImM/+PBSHzX236OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORVEXXDLhaNvVt/9Z5rDSDq9o0/B3+Y1GdZvQZn1kg9YZwgmj9MSlQZoVfBp7d6PDyALDT0L0+EK7g/E5B8fXpfcAY/ZpEX2KpqA5wjeEE/pi4j1eX5ApHl4WQ9YIxYizHD8GK4nog+bQ7UsbfJLy12hwGeUY37laSL4mPP9GNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a803YZ1Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750693079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LicB6aTt8ax5xPgeYdYrlMm/Y9HO/56RSPqPiL4WYFk=;
	b=a803YZ1ZSPlRYNoWTdE0o0gp0/RacvhF6xiEIgvY31J3u2Ua2RzQCMc98h1V7xwLqwaot+
	5mRCEydxlgiKVwqov3YUSTv1DcO38jYU/4KIvi5L11XL1QhYsAAVImoADXC2tKlfGAF8lK
	8v6Lq1zEVJTnUYm1j2zHLDG+iqRUR8A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-B9zN-SEHP7ugzrPkaI1PQw-1; Mon, 23 Jun 2025 11:37:58 -0400
X-MC-Unique: B9zN-SEHP7ugzrPkaI1PQw-1
X-Mimecast-MFC-AGG-ID: B9zN-SEHP7ugzrPkaI1PQw_1750693077
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816cc58so1821824f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 08:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750693077; x=1751297877;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LicB6aTt8ax5xPgeYdYrlMm/Y9HO/56RSPqPiL4WYFk=;
        b=Iba71XEUCtey35d9wY4X2hnbJrAlYwV0GZOKjNaEh8jAPy7xAK6ytBq6QznADMk1wg
         pJ63cuFOm4GP9rBlAb0kxvjWwljlE3CYz9dvg//WCc9+P64KjKJNp/5S1j/YQjwU9+rW
         LRzcFSgIeZGUaSf9tSxb06MXrqtLHK6NDCEjLqlO4D5Sn9DDctblxjKKfJXa5yfStL4V
         ivGMqMF4rTy/zmro0dkH7hgYtc2P4IqFJBGZyIBeZnkDh4sL+kfobXK1geefwFm91/Ev
         QQezWrchb7QEinT2ar8mquzCfJ4gn6DTe6xMr4vJAWiEwcFQqqQ5io+r8seWFYNKLMiI
         rCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuDN4OUsuefK/KeNHQzeDx72Qr69xLe0hVDlQYIZKn7TwaQC15ysEDbEYRvnKNWDehEdQoZj6oUK71JBkL@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcTpieh8BICxzLpq3zO3EzQezHq/z2TwhaQxW+AZtimWLsf3b
	Ap1PZ5Gxq1V8Yqh9EVnpfvFrfze/CQiyXCOSJB9f0g4FoIfAunYo29RGWQ5MhsgjzLxLWnGU3ti
	5xRKziksXyi37L/P/j2H3ETIfDjqo9HEyN/72qGoZDWRKp1TdXo90PLcq6WExXlRIHzk=
X-Gm-Gg: ASbGncs0S2K+jfqI2Pnx7XULy1WZKlEETQGCL+kXERnj94C3RbrAohNrDDYDTlE6K03
	fVU3kvt28mEqn/lZtyvQMrgla3/EBjyDdWBFcdOn4U2VkfbB/SY0cwnqPUkEzvmtONi6gN//4H0
	ieAQTvXBa/cC4/apwGO/slpzAISQ7IB2u293hoD8xxtU7N+aVIN9WoP4joy7eSArM4w6S1U20t5
	uUjx70pkiuFkg+ErIhcuhMgu0ZX1JRpSbX5/lOJBKxZqk+YYr3iubcL10/lL93RwnlVixWfKciL
	QgbCY4TivwMOus020jVruwEplbjPNu29DKrLsBPCbqksN6+08K4j24t/0+GezelVYwYt7U0po19
	Do2/vkOgT3jmWsHUD5oIhc/6YCUdDrDmoUjzO3oM0ULA6UCNjxQ==
X-Received: by 2002:a05:6000:144e:b0:3a4:f520:8bfc with SMTP id ffacd0b85a97d-3a6d1322c05mr10926214f8f.36.1750693076849;
        Mon, 23 Jun 2025 08:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnHfiFTC2ctHK0b/URPEZQLv2MoweNgFEhgPjLIeowyO7+RFR4pWrjKqMuwlyrsxqk2Ekvug==
X-Received: by 2002:a05:6000:144e:b0:3a4:f520:8bfc with SMTP id ffacd0b85a97d-3a6d1322c05mr10926168f8f.36.1750693076380;
        Mon, 23 Jun 2025 08:37:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1d902sm9524926f8f.43.2025.06.23.08.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:37:54 -0700 (PDT)
Message-ID: <6406fd6e-907e-4c7a-96d1-def6a9a69a49@redhat.com>
Date: Mon, 23 Jun 2025 17:37:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/29] mm/migrate: rename putback_movable_folio() to
 putback_movable_ops_page()
To: Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-9-david@redhat.com>
 <AD158968-D369-4884-806A-18AEE2293C8B@nvidia.com>
 <aFMQ65hUoOoLaXms@casper.infradead.org>
 <DABB8764-8656-44A8-B252-0240F53BC0E3@nvidia.com>
 <aFMbsdPYhcL8fyOo@casper.infradead.org>
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
In-Reply-To: <aFMbsdPYhcL8fyOo@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.25 22:04, Matthew Wilcox wrote:
> On Wed, Jun 18, 2025 at 03:25:46PM -0400, Zi Yan wrote:
>> On 18 Jun 2025, at 15:18, Matthew Wilcox wrote:
>>>> Why not use page version of lock, unlock, and put? Especially you are
>>>> thinking about not using folio for these pages. Just a question,
>>>> I am OK with current patch.
>>>
>>> That would reintroduce unnecessary calls to compound_head().

Right. And I want to make it clear that everything that uses "folio" 
here must be reworked: not necessarily switching to the "page" variant, 
but actually by implementing it entirely differently.

(e.g., store them in an array instead of a list, get rid of the lock 
bit, try getting rid of the refcount as well)

>>
>> Got it. But here page is not folio, so it cannot be a compound page.
>> Then, we will need page versions without compound_head() for
>> non compound pages. Could that happen in the future when only folio
>> can be compound and page is only order-0?
> 
> I think the assumption that we'll only see compound pages as part of
> folios is untrue.  For example, slabs will still allocate multiple
> pages (though slabs aren't migratable at this point).  The sketch at
> https://kernelnewbies.org/MatthewWilcox/Memdescs supports "misc pages"
> with an order stored in bits 12-17 of the memdesc.  I don't know
> how useful that will turn out to be; maybe we'll never implement that.

Once we have to support that for movable_ops, it will be an interesting 
question how to handle that. Most certainly, these things will not be 
folios. :)

-- 
Cheers,

David / dhildenb


