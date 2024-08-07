Return-Path: <linux-fsdevel+bounces-25252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F994A4D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686B91F22399
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6A81D0DC8;
	Wed,  7 Aug 2024 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQpjA40t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA21C9DF1
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024647; cv=none; b=C+xLl88MCdZrvIQmJUbJMq3HOs8Ntr8AeJIzS2Lu4g/3e6UevbXMq3Mqz/WDdFlqBaIx/DrTQgFMSFJNC3jXw/7edyf/8uSc6llSLsOUZsc21/a1UXYpQmv1u4uohZ0Dc7Wr5P5s/c/rKCoiNylPZ4JV99XdVLueeSROsU3Ncx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024647; c=relaxed/simple;
	bh=/g/ZZBUWUCDmIebaIcxyRJ/+V1joRJfSKEwLEKzaum4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGlMPSmEwFvyIAPiCb6lrdKbZvVNer6dHauKLmDFFLikR3MBS4XS72R+7XQJmPW34gBgqU8J8tn1zKioZpztoCorYlT/BdfRR2bZi+qSjKbqKzk5iJdCr1QvcQzjWcGieCUDAT7WvR5Moxiv9Ho91zIYLcDg7/oN2Sg+CFR/NNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQpjA40t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723024644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QhYDHmXmJQi46+6UhfMma7vbUjGkXIsu5WZQ+uaDpWE=;
	b=GQpjA40t4oRc9pPJtQL5wfLiw7CCkqmSZXsfNvGKe46iS1TF2CXUwwoiJu1q1RrYhkQ5fK
	AKTHfDtrgcum14IeD6t4bhLeElWGTrzX02PxRgaTr00US78jhC7qy3vrGoohB9xh98z6Fo
	KO63MSJXHqbLk7287pl1ZP0H7TC2EGc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-ZabWUPBbP3Ow4duq9toSNw-1; Wed, 07 Aug 2024 05:57:23 -0400
X-MC-Unique: ZabWUPBbP3Ow4duq9toSNw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42820c29a76so11557785e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 02:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024642; x=1723629442;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QhYDHmXmJQi46+6UhfMma7vbUjGkXIsu5WZQ+uaDpWE=;
        b=D3j5NB6lGHfQEkSZplZKuw8ry8W4JlzG8NJ35QASbjHhnV+jNjhzQiY0ovUWGUI0+s
         R5kycCZ9wnGrqtPEFC6yRnLZ9Kc87m93L7uq1cmoAFpG3oYw5HgM4z2/vv71eU6uA5mO
         VUyowGc+dIN8TOswQMxbnZ/Y5tjFG14d8xsPjsy7vveZm21yHnNEmwCJ3kDCWasEAUY4
         sRU47V0pzFjR21wo8fR2Oy43CskB0wxKQ3UGXc81iUX3L7U1e4JOZVJ8B+IU+M1GMPCd
         zB/h36JcsGp6AbxOLC1toGTT2FfNT3T8FJ3M5UA+aM/rYnhHKEB+5J6oI5FHq5/JO46+
         Cu0w==
X-Forwarded-Encrypted: i=1; AJvYcCW+sD5Jhk1QhI9e4fgkNhx1fJ/Nj491qExsbsxJvNtOojx7h320D4LGGJc6nN5TB1AKmWt5kyn2m1SyU0Ls24P/ubS5YGg6f4Kdyw3oNQ==
X-Gm-Message-State: AOJu0Yxqx/ETF8gtp+76kcIWyilD4k5fIRByCru5HDIKMUBi6wRp8SXQ
	tWSdANKBUa0KJol0UXbd0P52FQ+tKRhKPxNrypv+Mo/Tn12F1pq1buUjjiRlAedIVNw8O+iaFJq
	aUdBRYG/M0hPlfxmG50aYDSMT45+fxHBmHAhRHRf8vGPdAjmO1fhn+eVYzf+lkUc=
X-Received: by 2002:a5d:47ae:0:b0:366:e31a:500e with SMTP id ffacd0b85a97d-36bbc1d7791mr11661201f8f.63.1723024642093;
        Wed, 07 Aug 2024 02:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKIx+UH5dY/dVRyBapAk0Th6PLBq9S/ArQBuC3qjkAHZvhs3V3G3ABB3G0VEJbKGtXsfMI5w==
X-Received: by 2002:a5d:47ae:0:b0:366:e31a:500e with SMTP id ffacd0b85a97d-36bbc1d7791mr11661166f8f.63.1723024641470;
        Wed, 07 Aug 2024 02:57:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0597ddsm15632741f8f.77.2024.08.07.02.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 02:57:20 -0700 (PDT)
Message-ID: <a612c83f-071e-437f-99e1-d1fb157b62d7@redhat.com>
Date: Wed, 7 Aug 2024 11:57:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid()
 from follow_page() to folio_walk
To: Zi Yan <ziy@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Mark Brown <broonie@kernel.org>
References: <20240802155524.517137-1-david@redhat.com>
 <20240802155524.517137-8-david@redhat.com>
 <e1d44e36-06e4-4d1c-8daf-315d149ea1b3@arm.com>
 <ac97ccdc-ee1e-4f07-8902-6360de80c2a0@redhat.com>
 <a5f059a0-32d6-453e-9d18-1f3bfec3a762@redhat.com>
 <c75d1c6c-8ea6-424f-853c-1ccda6c77ba2@redhat.com>
 <5BEF38E0-359C-4927-98EF-A0EE7DC81251@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5BEF38E0-359C-4927-98EF-A0EE7DC81251@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.24 17:36, Zi Yan wrote:
> On 6 Aug 2024, at 6:24, David Hildenbrand wrote:
> 
>> On 06.08.24 12:03, David Hildenbrand wrote:
>>> On 06.08.24 11:56, David Hildenbrand wrote:
>>>> On 06.08.24 11:46, Ryan Roberts wrote:
>>>>> On 02/08/2024 16:55, David Hildenbrand wrote:
>>>>>> Let's remove yet another follow_page() user. Note that we have to do the
>>>>>> split without holding the PTL, after folio_walk_end(). We don't care
>>>>>> about losing the secretmem check in follow_page().
>>>>>
>>>>> Hi David,
>>>>>
>>>>> Our (arm64) CI is showing a regression in split_huge_page_test from mm selftests from next-20240805 onwards. Navigating around a couple of other lurking bugs, I was able to bisect to this change (which smells about right).
>>>>>
>>>>> Newly failing test:
>>>>>
>>>>> # # ------------------------------
>>>>> # # running ./split_huge_page_test
>>>>> # # ------------------------------
>>>>> # # TAP version 13
>>>>> # # 1..12
>>>>> # # Bail out! Still AnonHugePages not split
>>>>> # # # Planned tests != run tests (12 != 0)
>>>>> # # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>>> # # [FAIL]
>>>>> # not ok 52 split_huge_page_test # exit=1
>>>>>
>>>>> It's trying to split some pmd-mapped THPs then checking and finding that they are not split. The split is requested via /sys/kernel/debug/split_huge_pages, which I believe ends up in this function you are modifying here. Although I'll admit that looking at the change, there is nothing obviously wrong! Any ideas?
>>>>
>>>> Nothing jumps at me as well. Let me fire up the debugger :)
>>>
>>> Ah, very likely the can_split_folio() check expects a raised refcount
>>> already.
>>
>> Indeed, the following does the trick! Thanks Ryan, I could have sworn
>> I ran that selftest as well.
>>
>> TAP version 13
>> 1..12
>> ok 1 Split huge pages successful
>> ok 2 Split PTE-mapped huge pages successful
>> # Please enable pr_debug in split_huge_pages_in_file() for more info.
>> # Please check dmesg for more information
>> ok 3 File-backed THP split test done
>>
>> ...
>>
>>
>> @Andrew, can you squash the following?
>>
>>
>>  From e5ea585de3e089ea89bf43d8447ff9fc9b371286 Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Tue, 6 Aug 2024 12:08:17 +0200
>> Subject: [PATCH] fixup: mm/huge_memory: convert split_huge_pages_pid() from
>>   follow_page() to folio_walk
>>
>> We have to teach can_split_folio() that we are not holding an additional
>> reference.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/huge_mm.h | 4 ++--
>>   mm/huge_memory.c        | 8 ++++----
>>   mm/vmscan.c             | 2 +-
>>   3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index e25d9ebfdf89..ce44caa40eed 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -314,7 +314,7 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>>   		unsigned long len, unsigned long pgoff, unsigned long flags,
>>   		vm_flags_t vm_flags);
>>   -bool can_split_folio(struct folio *folio, int *pextra_pins);
>> +bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>>   int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>   		unsigned int new_order);
>>   static inline int split_huge_page(struct page *page)
>> @@ -470,7 +470,7 @@ thp_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
>>   }
>>    static inline bool
>> -can_split_folio(struct folio *folio, int *pextra_pins)
>> +can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>>   {
>>   	return false;
>>   }
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 697fcf89f975..c40b0dcc205b 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3021,7 +3021,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>   }
>>    /* Racy check whether the huge page can be split */
>> -bool can_split_folio(struct folio *folio, int *pextra_pins)
>> +bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>>   {
>>   	int extra_pins;
>>   @@ -3033,7 +3033,7 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
>>   		extra_pins = folio_nr_pages(folio);
>>   	if (pextra_pins)
>>   		*pextra_pins = extra_pins;
>> -	return folio_mapcount(folio) == folio_ref_count(folio) - extra_pins - 1;
>> +	return folio_mapcount(folio) == folio_ref_count(folio) - extra_pins - caller_pins;
>>   }
>>    /*
>> @@ -3201,7 +3201,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>   	 * Racy check if we can split the page, before unmap_folio() will
>>   	 * split PMDs
>>   	 */
>> -	if (!can_split_folio(folio, &extra_pins)) {
>> +	if (!can_split_folio(folio, 1, &extra_pins)) {
>>   		ret = -EAGAIN;
>>   		goto out_unlock;
>>   	}
>> @@ -3537,7 +3537,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>>   		 * can be split or not. So skip the check here.
>>   		 */
>>   		if (!folio_test_private(folio) &&
>> -		    !can_split_folio(folio, NULL))
>> +		    !can_split_folio(folio, 0, NULL))
>>   			goto next;
>>    		if (!folio_trylock(folio))
> 
> The diff below can skip a folio with private and extra pin(s) early instead
> of trying to lock and split it then failing at can_split_folio() inside
> split_huge_page_to_list_to_order().
> 
> Maybe worth applying on top of yours?
> 
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a218320a9233..ce992d54f1da 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3532,13 +3532,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>                          goto next;
> 
>                  total++;
> -               /*
> -                * For folios with private, split_huge_page_to_list_to_order()
> -                * will try to drop it before split and then check if the folio
> -                * can be split or not. So skip the check here.
> -                */
> -               if (!folio_test_private(folio) &&
> -                   !can_split_folio(folio, 0, NULL))
> +
> +               if (!can_split_folio(folio,
> +                                    folio_test_private(folio) ? 1 : 0,
> +                                    NULL))

Hmm, it does look a bit odd. It's not something from the caller (caller_pins), but a
folio property. Likely should be handled differently.

In vmscan code, we only call can_split_folio() on anon folios where
folio_test_private() does not apply.

But indeed, in split_huge_page_to_list_to_order() we'd have to fail if
folio_test_private() still applies after

Not sure if that is really better:


diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c40b0dcc205b..7cb743047566 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3026,11 +3026,14 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
         int extra_pins;
  
         /* Additional pins from page cache */
-       if (folio_test_anon(folio))
+       if (folio_test_anon(folio)) {
                 extra_pins = folio_test_swapcache(folio) ?
                                 folio_nr_pages(folio) : 0;
-       else
+       } else {
                 extra_pins = folio_nr_pages(folio);
+               if (unlikely(folio_test_private(folio)))
+                       extra_pins++;
+       }
         if (pextra_pins)
                 *pextra_pins = extra_pins;
         return folio_mapcount(folio) == folio_ref_count(folio) - extra_pins - caller_pins;
@@ -3199,9 +3202,11 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
  
         /*
          * Racy check if we can split the page, before unmap_folio() will
-        * split PMDs
+        * split PMDs. filemap_release_folio() will try to free buffer; if that
+        * fails, filemap_release_folio() fails.
          */
-       if (!can_split_folio(folio, 1, &extra_pins)) {
+       if (WARN_ON_ONCE(folio_test_private(folio)) ||
+           !can_split_folio(folio, 1, &extra_pins)) {
                 ret = -EAGAIN;
                 goto out_unlock;
         }
@@ -3531,13 +3536,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
                         goto next;
  
                 total++;
-               /*
-                * For folios with private, split_huge_page_to_list_to_order()
-                * will try to drop it before split and then check if the folio
-                * can be split or not. So skip the check here.
-                */
-               if (!folio_test_private(folio) &&
-                   !can_split_folio(folio, 0, NULL))
+               if (!can_split_folio(folio, 0, NULL))
                         goto next;
  
                 if (!folio_trylock(folio))


It assumes that folio_set_private() is impossible after filemap_release_folio() succeeded
and we're still holding the folio lock. Then we could even get rid of the WARN_ON_ONCE().

-- 
Cheers,

David / dhildenb


