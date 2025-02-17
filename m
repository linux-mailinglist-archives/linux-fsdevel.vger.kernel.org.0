Return-Path: <linux-fsdevel+bounces-41893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87709A38CC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 20:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835C03A48C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4192376F5;
	Mon, 17 Feb 2025 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jG46r1Xo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE2187858
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821961; cv=none; b=FZ85tOsjLpF6IEHQ90kKhpNDDNf4P76wwY7FWK8JKE+G7OXtXvXeUs7uSmFo1QrzFZP1EAib3d/R8EcL21pcx5UVwrUhAPXesHfTqkCc20OIoxqmTg5bkN9Q2JwsnANcCb359VLntemzB6DcUOMdFpQC1keDli7h6DYuk+cV/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821961; c=relaxed/simple;
	bh=DJMKpnTHwr+LdItMMSCGe47GOiJK1Uk52r2+n37U+lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0V3yUJO3kIQELK5GfoI5velpDCSNNUg4z4GsKBWlFgxx6O9jnshuD2YklJ+GaaP+amFlPLM0ZE7GuF7m+ymqGZ8nMNp0cjyVcKetBrMAdAXC/FcBe2bV3a8LmevvMoswdgVZH8YPafPMelbIvsI3xVyd1gvGW8ktbEia6uMCvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jG46r1Xo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739821958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dSgud9IFu9zBU2/yrWAzazkl9insW+YrIX8GunCoEkA=;
	b=jG46r1XowxG6lmGwyssqQ77VLRCQdhEoV4HRZs7UbJHpIQ7MZ9ox2JEhtRRRAjfz4zib64
	dInZ1ST5MTVZfKpsJtz0E3YbVfgnhlyyVR5Ek25XUHDdJH2zZLSr+r9Q4pj9Cr8Z//7wtr
	Nj65w0pnyBCoOn68cvX0u0UukXdgyXo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-DNoLSOWbPluX5kopiuuIsg-1; Mon, 17 Feb 2025 14:52:37 -0500
X-MC-Unique: DNoLSOWbPluX5kopiuuIsg-1
X-Mimecast-MFC-AGG-ID: DNoLSOWbPluX5kopiuuIsg_1739821956
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43933b8d9b1so25580565e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 11:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821956; x=1740426756;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dSgud9IFu9zBU2/yrWAzazkl9insW+YrIX8GunCoEkA=;
        b=RZiAkf9r3rFUMUyYQE6jqaQgxt+1bgRNfhymWqhy+iPXe1m8X0tYSSFxzE9FkrCW77
         PwPUeH4EPLo/MtWbVWa/MVBXaX8aWZT1BDp4INRe14CdwUr5TRfgf7FH0m8HUG16uRgW
         C0WGwW2OXYd7loQLjrPNcV8HzgWgxvouZcM9Cz7mx+ScBmUg8zchwvncxnMDQ2qw+6MP
         2yNAsE/ZcCF6scjmjplYlqfOif9EBm5lzPTCqjQX7OgxI7sGTVw6wCThEUTi0Lph6kxa
         Qwd9Ubf/GU/IfPNL7+H9mDohRoXSOhHSeo1DTwaJLM5fddx0edQEwiJPLBZJLi/1cuju
         DgBQ==
X-Gm-Message-State: AOJu0YxHpWhD1a0o/aCqaRCibOQ/s9OAAE+S7UdbgkmL4fM7Soeh2URI
	KFq2lJgc1aquzU9QJeCLc2kZ/jzvqRNshBU00o7bvDzqqLtrmelnFyD9Ap1LHbDHd1xlFdtiiu5
	yZnP5RHuht/TqOKBmU+7qer3EKaRrOUTek4tDr4dpbWyTTYJG09lJffoIepAKDPw=
X-Gm-Gg: ASbGncsXqCjovTTZBpUwTrW2uNVVY97MhxJf6DiclAZ8XwDtGI/VWVVuLJkt5foJJg+
	3ydNv5uCXQpJLcK3diz1ABZI9Up8ZSW/tl3E7lrQWPZuTxPsgjkFluF9QJD56D6OTVvJ3+isnoP
	J3ana7Yg0eau7a82ErBAMCHkJwZEE0J5J3mLiDiVSK6LP4fayuWLRrBSskaMFLyaIxIuXPhBE6o
	PQUZI1WvbpW75DLgS/3u36HVdJno9gYcLCSczBVTttnAHmR8fiHGAJNLXlRgvxZ3yQo4j/0k6/b
	lZV+tSydtpb/DrXYNbh+vPu2/CKpBUArqHzzaQpJDQYnJoHsXusU8fIGXTN7VZbygkrMJiQNuD0
	wj4OYqq0CTH+bk065rc3PpqR5mGzSeA==
X-Received: by 2002:a05:600c:5487:b0:439:8a8c:d3d8 with SMTP id 5b1f17b1804b1-4398a8cd568mr31393925e9.29.1739821955821;
        Mon, 17 Feb 2025 11:52:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyDxt9ziBk25VblfQc1zoKMTJeD5SerjisAnql1pNBHcQPqv9b6CUDpFtmZRLpJojsitSOKg==
X-Received: by 2002:a05:600c:5487:b0:439:8a8c:d3d8 with SMTP id 5b1f17b1804b1-4398a8cd568mr31393715e9.29.1739821955440;
        Mon, 17 Feb 2025 11:52:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:900:900f:3c9e:2f7b:5d0a? (p200300cbc7390900900f3c9e2f7b5d0a.dip0.t-ipconnect.de. [2003:cb:c739:900:900f:3c9e:2f7b:5d0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d8dd6sm13231254f8f.62.2025.02.17.11.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 11:52:34 -0800 (PST)
Message-ID: <f880cf51-8703-444c-ac7e-b89cc5816931@redhat.com>
Date: Mon, 17 Feb 2025 20:52:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/3] mm/filemap: add mempolicy support to the
 filemap layer
To: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
 willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, vbabka@suse.cz, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, Shivansh Dhiman <shivansh.dhiman@amd.com>,
 baolin.wang@linux.alibaba.com
References: <20250210063227.41125-1-shivankg@amd.com>
 <20250210063227.41125-2-shivankg@amd.com>
 <76537454-272b-4fbb-b073-5387bbaaf28d@redhat.com>
 <d504979a-3f25-4a57-9632-5c17cbc2acda@amd.com>
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
In-Reply-To: <d504979a-3f25-4a57-9632-5c17cbc2acda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> (1) As you noted later, shmem has unique requirements due to handling swapin.
> It does considerable open-coding.
> Initially, I was considering simplifying the shmem but it was not possible due
> to above constraints.
> One option would be to add shmem's special cases in the filemap and check for
> themusing shmem_mapping()?
> But, I don't understand the shmem internals well enough to determine if it is
> feasible.
> 

Okay, thanks for looking into this.

> (2) I considered handling it manually in guest_memfd like shmem does, but this
> would lead to code duplication and more open-coding in guest_memfd. The current
> approach seems cleaner.

Okay, thanks.

> 
>> Two tabs indent on second parameter line, please.
>>
> ..
>>
>> This should go below the variable declaration. (and indentation on second parameter line should align with the first parameter)
>>
> ..
>> "The mempolicy to apply when allocating a new folio." ?
>>
> 
> I'll address all the formatting and documentation issues in next posting.
> 
>>
>> For guest_memfd, where pages are un-movable and un-swappable, the memory policy will never change later.
>>
>> shmem seems to handle the swap-in case, because it keeps care of allocating pages in that case itself.
>>
>> For ordinary pagecache pages (movable), page migration would likely not be aware of the specified mpol; I assume the same applies to shmem?
>>
>> alloc_migration_target() seems to prefer the current nid (nid = folio_nid(src)), but apart from that, does not lookup any mempolicy.
> 
> Page migration does handle the NUMA mempolicy using mtc (struct migration_target_control *)
> which takes node ID input and allocates on the "preferred" node id.
> The target node in migrate_misplaced_folio() is obtained using get_vma_policy(), so the
> per-VMA policy handles proper node placement for mapped pages.
> It use current nid (folio_nid(src)) only if NUMA_NO_NODE is passed.
> 
> mempolicy.c provides the alloc_migration_target_by_mpol() that allocates according to
> NUMA mempolicy, which is used by do_mbind().
> 
>>
>> compaction likely handles this by comapcting within a node/zone.
>>
>> Maybe migration to the right target node on misplacement is handled on a higher level lagter (numa hinting faults -> migrate_misplaced_folio). Likely at least for anon memory, not sure about unmapped shmem.
> 
> Yes.

Thanks, LGTM.

-- 
Cheers,

David / dhildenb


