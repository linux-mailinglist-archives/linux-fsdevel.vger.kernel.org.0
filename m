Return-Path: <linux-fsdevel+bounces-60549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB780B49296
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FDB1893AB3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CDC30DD32;
	Mon,  8 Sep 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkRwNQsY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98925309DC5
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344086; cv=none; b=YvIP+/0JIzkBVXdblQRU81JPkcKR41ef/LT0g3fVn4XOSXEHeIB73q947wZ+hoJmLZJKoIhVJdf07pgGgX11W2djdYMa5kmR3jS4lTcttIcXmMewqGx8GiGRn9z8gTJTYcZdF4PSSt/vckNijSuGfKUqCjagJq9k0z4v+w/Ao8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344086; c=relaxed/simple;
	bh=SErWpM2CPGCjvtF4PGxsUSQobXtOk2CdeRydRwakdIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYizPY/CaeteLgvijZwFohIsLCZ/YRZSMJlMmIGz5jRC+/T7K29YUFYkzRwKYPV1YIbi1xppur8AywWLjRRpSWTqUKhgOQwLKek9HMYy8xYC/5islKQZY5xN9KYXEuAvKB/0W/wOtrAVoanj6YMOLY8O46WdR7Enoo46OVDfink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkRwNQsY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757344083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5pKUW/icABhJPZyV0g3yxdIs8s3bqfZdt2XQu7KwBtE=;
	b=fkRwNQsYhNT0GIFXYrP/ib3WalJpzp8/qQ0kO4E9gTgD5YD5Kweozy5U3000pLeEH964KA
	K/7r3mtq3PlIsN3nNJyOdwRg3JLXWejsg+PGYI6wSVPGeSbA2Q25JL61voRkHyEj88XRoP
	Q4NEcLjnVb37AJ8G9ehULkzAmWxHzko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-BrE61fcxNTGD5599seSfeA-1; Mon, 08 Sep 2025 11:08:02 -0400
X-MC-Unique: BrE61fcxNTGD5599seSfeA-1
X-Mimecast-MFC-AGG-ID: BrE61fcxNTGD5599seSfeA_1757344081
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd56f0000so27339905e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Sep 2025 08:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344081; x=1757948881;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pKUW/icABhJPZyV0g3yxdIs8s3bqfZdt2XQu7KwBtE=;
        b=ptMfL5oWvcIOCHYVHuQ1Tcx/X50PlykiSRL/+0u1vF3sDlb0fcQiVFy6Rc7ZBn1b3S
         8a5OgA7HYD+wIJbIwt4ZVUPtDrtA2KFHK9V+EfHsSdRUvyQ9zJ+0r4yCeBR/vnxBazB+
         d6BgtKmpCJD6qPFTsoj1dWdHDIqUm8Hj4+IKL+wNamYv4dnTs7tU/u1U63yv5Sm5FHl2
         91zhrVVNkvuorx/bTNE2wn4mMiC/oBh03q6smD5Ft2HY0er72m9tXCGQ33EYpDMEMcsf
         U8TTdfZwD6Q3XK9UozCEy85qeCJ6OXSGmhYFNPdG2n1NMUzuBlrJOl6ImMzN2/k9Z2/i
         xzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjxuSA2jdeiuC49yTLo4Ndv+30QCTSN7gRBEJ4DqUxKdp6kEwrDrnP/E64NVdCJ80Q3eFT8fV3hTj2UZz0@vger.kernel.org
X-Gm-Message-State: AOJu0YwM4VgC4pVykqKVOXfdsWf6tXQvKY/dxQyiQ1XPrwV3p4kE2ZJI
	AolNJmQZxPHveGi7INLSQMfJyEo7ST2vjjj3XCD9XpAgiAAx1etJ8PhtOYgMuT0tnLrqDg2bp7l
	+ZoMpqEYAyH3lfwdvYe7hxrsYDcM+lklAv7qmr1r6wqb0wdPGoCRJMrsz4/tRoqJHdZc=
X-Gm-Gg: ASbGncuYJxNSxc70tnoACRnI+iK4yhXZy/xSO9CvuvIjMeB42e0F9QtnJttWVDWk+oZ
	vZzjR2e2ooc6Uz4BlX8MZ11nnsrR3KAA6zxYcKK/Ld7cuFWMxy8fS/yvAjyZl8ug8kWKFW6LrAQ
	lDepGR34+V+yvsPZeWuVb1hnprjv/e7dL0ChVLR712YOkosC8/J8/5ZzQwveVfdmFQ03IrcrMZA
	QR5Y/0T0Yt7dVZy2jAY6uDIAeTtV3ymFlnkjdsrVZE6er00vmYjz9SAQyavvDYs8HTxCJKjpmW8
	wLN1SEPPWwgbRq+j1E/tXi/+LuleBpjkQy6RlDg8j0tkn3e+6hzYcDPjlW4IQz4f+KEiXlfcfUG
	egaQvjZm9zTqfZkzIcwN6uJ1uZslZu5SqaYoPzd//Mh8VAFqTOX46M3lzc0qQf9FI
X-Received: by 2002:a05:600c:5299:b0:45d:dd47:b45f with SMTP id 5b1f17b1804b1-45dddef7fdamr66712905e9.31.1757344081172;
        Mon, 08 Sep 2025 08:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Vkq5qu+3/zUjGE8hzCjU/5dhhaUv80YZQC3pknfc7Ya8cxmZvSqhgPFMqrGgKhR5fxqC4A==
X-Received: by 2002:a05:600c:5299:b0:45d:dd47:b45f with SMTP id 5b1f17b1804b1-45dddef7fdamr66712145e9.31.1757344080658;
        Mon, 08 Sep 2025 08:08:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de6e787desm19519385e9.8.2025.09.08.08.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:08:00 -0700 (PDT)
Message-ID: <af3695c3-836a-4418-b18d-96d8ae122f25@redhat.com>
Date: Mon, 8 Sep 2025 17:07:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 16:47, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 11:20:11AM -0300, Jason Gunthorpe wrote:
>> On Mon, Sep 08, 2025 at 03:09:43PM +0100, Lorenzo Stoakes wrote:
>>>> Perhaps
>>>>
>>>> !vma_desc_cowable()
>>>>
>>>> Is what many drivers are really trying to assert.
>>>
>>> Well no, because:
>>>
>>> static inline bool is_cow_mapping(vm_flags_t flags)
>>> {
>>> 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
>>> }
>>>
>>> Read-only means !CoW.
>>
>> What drivers want when they check SHARED is to prevent COW. It is COW
>> that causes problems for whatever the driver is doing, so calling the
>> helper cowable and making the test actually right for is a good thing.
>>
>> COW of this VMA, and no possibilty to remap/mprotect/fork/etc it into
>> something that is COW in future.
> 
> But you can't do that if !VM_MAYWRITE.
> 
> I mean probably the driver's just wrong and should use is_cow_mapping() tbh.
> 
>>
>> Drivers have commonly various things with VM_SHARED to establish !COW,
>> but if that isn't actually right then lets fix it to be clear and
>> correct.
> 
> I think we need to be cautious of scope here :) I don't want to accidentally
> break things this way.
> 
> OK I think a sensible way forward - How about I add desc_is_cowable() or
> vma_desc_cowable() and only set this if I'm confident it's correct?

I'll note that the naming is bad.

Why?

Because the vma_desc is not cowable. The underlying mapping maybe is.

-- 
Cheers

David / dhildenb


