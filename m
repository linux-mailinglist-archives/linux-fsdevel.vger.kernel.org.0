Return-Path: <linux-fsdevel+bounces-42396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4627CA41B53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97DB1897D5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 10:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A83255E24;
	Mon, 24 Feb 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqKIy7Bo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D2255E20
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393452; cv=none; b=QnSlJxJ25a3e8A6W4ODsSVoM5Fl04wo52Z6mssXEAvpIJ9k2i0TPHxahg3XVMdS210iotCecVzdvwKxUtI4Cj+lGmTTNDc5S92gKFH9hANUMRnBjN1GcYONddZlzzxe8o/8YJkzmZ6wHNTILdu2UWUmlSvrn/tDULKetYYklSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393452; c=relaxed/simple;
	bh=/gRrSz2yXs4vsslQWzBNjKON7715ulGmHecZwULZHRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mN4XnC1fdurFqOzZJiK98dL/fGer/jSANvavvCV2G5MQQfo6s4c6dHDOEG8PihqwTiMPnSQemOsDo+1rKxaKj2gH/Zg2haAiNq/guf7RvQPqG3L2xdhWP1wrAuFk0EJZuK1ANv53bUkM0o6X67fkGAZ3wfjt8tC0pVqL1EO9uj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqKIy7Bo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740393449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rO8lIKV122u8A8FjTVOg2+ZxmXBOIm46qqiWIzi0zUY=;
	b=VqKIy7BohXMJyEIVjDyPFPJDllk01lKm7ll2uMH0j/t1uNycuRg/Lj6HxkWR8pQ3cp1BpJ
	CdAcqd5IeVKuQzXikYvhd9l2txunKaxlv2w0aJZKM/ASOV51JlXnsunTOF4SjmfbGR/Zag
	dT/IYTBn0Q77xdyaSHbei4C0iwomqBE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-M58HcVa2NoW51FVUMENaig-1; Mon, 24 Feb 2025 05:37:28 -0500
X-MC-Unique: M58HcVa2NoW51FVUMENaig-1
X-Mimecast-MFC-AGG-ID: M58HcVa2NoW51FVUMENaig_1740393447
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f338525e1so1721697f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 02:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740393447; x=1740998247;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rO8lIKV122u8A8FjTVOg2+ZxmXBOIm46qqiWIzi0zUY=;
        b=k4qlr0/fr4ewm0f48woR2GtaQGePMOgNhaoj+BMA2tpFQWf2NpkQiSQxKDYDpUfw2N
         A5jrrj/AGe73E74yUvzM8sos3LbqSfFn/mR6CAER8yivf5mJwAfPNWRHKsI6jwaqJn+6
         ZHdNZEdqxVuR1NoVveXXD+mG75npVMDP6nf74IAed6ZH4abXeCNQQF68DVm7SHYmJMDA
         Vwdq3Pmp0rLybxMaUtTDD2ocRuyvNw8ZBDxQJKp7M5zucUHzQXv+bpMBQQw+1o3IHPBD
         BGkNblL/wneMH1qD49KVJ/IapWiiGvGPRezB7nEpJJSYXiAVcYSubRNhgOVXxX1l5KmM
         sQDg==
X-Forwarded-Encrypted: i=1; AJvYcCUj5HhxkhllgzRJYpMAHXIBZPFC1e67NmjwQyW1+Dvobg5/Rq/LUsLN3y39jSsBHMV3PRzKCFJr2tliinGS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6RjX2NglgvSXJZI/Vr/moKHRjljGCVZNQynP/IQm+yAU4Vwxi
	tkTjNzj1cMPbWv4Pq0YkAypHzM/J3FiUtGtUNUnORl/81wig7pVTxRo3L2vEDtSvoKYhtR5BqzP
	iJLxSnCCTVixf2bEODNMDlrc6IUTRClwBa7xlYKKtWgJFa/aCitBnWLTbkPPDKFI=
X-Gm-Gg: ASbGncuE5+JlslxYOZgWuced9WYBBcDBUSkT6JKzMVgk+9lNp+BgF+L3gGrcKFvqs20
	6OTt3dmZAnmU8g7Sv0sVBLNZmfYiySUJ79Bw9/5zMKm2d/LHGMsN5fwX9SqbPC4NxVJIss33ZCC
	jMTZLRmzXbn5chUcW1oldTgDAZlANhJTX4UaHY2ZO3WN+8ifq0s5SP+/s9s193XX/AWYFVVUXzi
	3k418MHdr2HbFCkx8lmUaA3Yha0hqGTS1EKebma3MaKZ9ZKuAItH1ggF79Oy3k1vhGMp5PYXjBU
	7zQOBKP8yOVjcUMh0PmURdvooY/DkSTN45YokGoLYrmc5+ZflFT4Dpl9K3Qlf5E4Ke8ffrkBsef
	aoMijfgkfNH36I0Fw8LWfx/VNVc1gVykT6b0nwwQXurk=
X-Received: by 2002:a05:6000:1789:b0:38f:3de0:d16 with SMTP id ffacd0b85a97d-38f7085dc1dmr7386623f8f.52.1740393446881;
        Mon, 24 Feb 2025 02:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYBbwlOwYkjd2sSmfgkM5zkQutF43Ts1I4C5qCYdEua9tWy0/1u+3jppjIwy2SkS/Xjj4zJw==
X-Received: by 2002:a05:6000:1789:b0:38f:3de0:d16 with SMTP id ffacd0b85a97d-38f7085dc1dmr7386582f8f.52.1740393446413;
        Mon, 24 Feb 2025 02:37:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddba7sm31622272f8f.38.2025.02.24.02.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 02:37:25 -0800 (PST)
Message-ID: <09d7ca19-e6cc-4aa9-8474-8975373bdebd@redhat.com>
Date: Mon, 24 Feb 2025 11:37:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kalesh Singh
 <kaleshsingh@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
 <857b2c3f-7be7-44e8-a825-82a7353665fb@redhat.com>
 <cd57ed04-c6b1-4df3-a5cb-a33078a08e74@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cd57ed04-c6b1-4df3-a5cb-a33078a08e74@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 11:18, Lorenzo Stoakes wrote:
> On Mon, Feb 24, 2025 at 10:27:28AM +0100, David Hildenbrand wrote:
>> On 21.02.25 13:05, Lorenzo Stoakes wrote:
>>> Currently there is no means by which users can determine whether a given
>>> page in memory is in fact a guard region, that is having had the
>>> MADV_GUARD_INSTALL madvise() flag applied to it.
>>>
>>> This is intentional, as to provide this information in VMA metadata would
>>> contradict the intent of the feature (providing a means to change fault
>>> behaviour at a page table level rather than a VMA level), and would require
>>> VMA metadata operations to scan page tables, which is unacceptable.
>>>
>>> In many cases, users have no need to reflect and determine what regions
>>> have been designated guard regions, as it is the user who has established
>>> them in the first place.
>>>
>>> But in some instances, such as monitoring software, or software that relies
>>> upon being able to ascertain the nature of mappings within a remote process
>>> for instance, it becomes useful to be able to determine which pages have
>>> the guard region marker applied.
>>>
>>> This patch makes use of an unused pagemap bit (58) to provide this
>>> information.
>>>
>>> This patch updates the documentation at the same time as making the change
>>> such that the implementation of the feature and the documentation of it are
>>> tied together.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks! :)
>>
>> Something that might be interesting is also extending the PAGEMAP_SCAN
>> ioctl.
> 
> Yeah, funny you should mention that, I did see that, but on reading the man
> page it struck me that it requires the region to be uffd afaict? All the
> tests seem to establish uffd, and the man page implies it:
> 
>         To start tracking the written state (flag) of a page or range of
>         memory, the UFFD_FEATURE_WP_ASYNC must be enabled by UFFDIO_API
>         ioctl(2) on userfaultfd and memory range must be registered with
>         UFFDIO_REGISTER ioctl(2) in UFFDIO_REGISTER_MODE_WP mode.
> 
> It would be a bit of a weird edge case to add support there. I was excited
> when I first saw this ioctl, then disappointed afterwards... but maybe I
> got it wrong?
> 

I never managed to review that fully, but I thing that 
UFFD_FEATURE_WP_ASYNC thingy is only required for PM_SCAN_CHECK_WPASYNC 
and PM_SCAN_WP_MATCHING.

See pagemap_scan_test_walk().

I do recall that it works on any VMA.

Ah yes, tools/testing/selftests/mm/vm_util.c ends up using it for 
pagemap_is_swapped() and friends via page_entry_is() to sanity check 
that what pagemap gives us is consistent with what pagemap_scan gives us.

So it should work independent of the uffd magic.
I might be wrong, though ...

>>
>>
>> See do_pagemap_scan().
>>
>> The benefit here might be that one could effectively search/filter for guard
>> regions without copying 64bit per base-page to user space.
>>
>> But the idea would be to indicate something like PAGE_IS_GUARD_REGION as a
>> category when we hit a guard region entry in pagemap_page_category().
>>
>> (the code is a bit complicated, and I am not sure why we indicate
>> PAGE_IS_SWAPPED for non-swap entries, likely wrong ...)
> 
> Yeah, I could go on here about how much I hate how uffd does a 'parallel
> implementation' of a ton of stuff and then chucks in if (uffd) { go do
> something weird + wonderful } but I'll resist the urge :P :))
> 
> Do you think, if it were uffd-specific, this would be useful?

If it really is completely uffd-specific for now, I agree that we should 
rather leave it alone.

> 
> At any rate, I'm not sure it's _hugely_ beneficial in this form as pagemap
> is binary in any case so you're not having to deal with overhead of parsing
> a text file at least!

My thinking was, that if you have a large VMA, with ordinary pagemap you 
have to copy 8byte per entry (and have room for that somewhere in user 
space). In theory, with the scanning feature, you can leave that ... 
scanning to the kernel and don't have to do any copying/allocate space 
for it in user space etc.

-- 
Cheers,

David / dhildenb


