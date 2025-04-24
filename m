Return-Path: <linux-fsdevel+bounces-47226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482AA9AD2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483771947450
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0939122F75E;
	Thu, 24 Apr 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ig27+Y1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2E157A67
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497304; cv=none; b=eRYjGX20JWpKUHpTn5VIK10H2tCHtJBnzhIp4A6BzgtN3nx4yAYc97bfagbJrpulOoxm28rOlgNy6M5cJUGwMJJvMmpzvnLsPSBUZNCR88YbnZI18tGy1ndQfy5UypvzY9gPK1EZKLlrbtTVLJTBLCjtQSni9vuR+n3EOKJE8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497304; c=relaxed/simple;
	bh=u6VaX9FmVre91NBsXEpP2iol7RMMq4zMEBRg6Dz3fuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWs1vR0ouLUMP0TQ/uq083Y2X4RPJKjrOoo12nxT7odPLmYMgt0J4GIvDns53kxk836NTlO1qYZ1vm0RzT1fw58YU5URFfDKg8B0ItiHh7724txsZeiHpHPE4uLQ6HQfnuf6tzTo1Caw8EZjyPG224C+wvcSQTQG2hKyotFyv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ig27+Y1w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745497301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VVdIwiW6bvK7p2++Q43ZpEHcNGoRLkSia0sgyUo/YWE=;
	b=ig27+Y1wPaqSSdP5Kc3PFp1b/hkbr0WOGDvE/Ofy2IXEcX8mz3Pf4kzc9/Ofkk3UizdXF1
	eDMfGGYuQaxLdL7F7Os+1J6+sP4L3JnravDoFGBWncf3k96y/EDuuucaWN73m4bNu1a7Tj
	cDHN8ir+LnRIHFOeK452xFO2lbM/21A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-AEmjK6hxOYakVAFFb-RNlA-1; Thu, 24 Apr 2025 08:21:38 -0400
X-MC-Unique: AEmjK6hxOYakVAFFb-RNlA-1
X-Mimecast-MFC-AGG-ID: AEmjK6hxOYakVAFFb-RNlA_1745497297
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso424796f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 05:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745497297; x=1746102097;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVdIwiW6bvK7p2++Q43ZpEHcNGoRLkSia0sgyUo/YWE=;
        b=kLQaM3zoCafDql24djO9PJb8DQ2IDoHfSvq/eaeZC0KkRixFv6cBU3EIFtl6lm4cxn
         YwrhELnDCnHWOyCgVCdhGrAHq/3y/aviN3i2dsS4O2tzY27JlB/qZTwPN8yIqzTiMlTW
         ag/rV3UcI0pce4+R8qA1FVLDr9N8k5ht19taJboNpT9K94esJd33IqN8kXIiAeZvA7w/
         r9L+k6NzU6tqmLB3JNOG6jSp3A/zjskd2sgkTDS1aS1b3yuar5fXfviZQMGt68cPvg/j
         PfI8HIZhikJG4nmdbjlLB1O0j9rA92wThQw4GpUY45UEMB2S0ZizHYPF6oqrhLA2JxOP
         S9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF5nK/qF+MwSXGJoDnNBNzRpCdBiR6fitLg+UT8dM02cPAeVFJ4Zij9Q+5x1XNR0oB0u0bCphk3T4ltL9u@vger.kernel.org
X-Gm-Message-State: AOJu0YysoBLXxqG908EjY9/u6qhIggYMAi1DkLakkTRFc7dxCL11xBNA
	iL5UCjNZPp1v7fOWuCbcTE7cvOKCqRIMZw93yYe5dZfOcwMU1udU5ei+G91M8lVtA94oRgKdSYY
	YlQQ8bjA4h8NUamW/68uqrasL5+i3GsW8aJpXiiUabtTVmt5YZncK/wMECg5wTwQ=
X-Gm-Gg: ASbGncs+vxGGCMfVH0OD/oEHCFqSAsNNH4f3+La4I+GkpuKi1sqjSIWGwJOfO44oh6V
	/gkW061D6gJJQXPFSVy8SebcPZ4xlXOIZ2lJpAC7VBtG3yIWwiDA8CYLoHpII06G9lGgyC2mgyh
	CyrNuJH1PkOzpikHDuSI9ooEYA4YB24hi7VFDHoLxh8IsRQFVdqxoaqasALUboRNlFjjY5YC71m
	+eCqxDtaQQYK+dUmoOaZsSU9WcW50pAFpZ0B/KjmyaHNljr6lN+sR+oQKN7hsDHy+HYfmRSiZmc
	41+/5DrCLcA+1yyyFIFGI/bsQQonNtmVy8dpbVmvc47rpCFTz3JC6wwMLFlYC25gmjFGExPPzFd
	9BH+S9MAVNHGJojeGYpgGYjKj1bmOvy4ZfrTU
X-Received: by 2002:a05:6000:1863:b0:39f:fe3:32e9 with SMTP id ffacd0b85a97d-3a06cf502b9mr2008929f8f.8.1745497297166;
        Thu, 24 Apr 2025 05:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHTNr8j/QtNofw7LjshD1Ub4Z7jJh1e+VnV5Zqu4CXj7hn3iGB1nrUmy8UY+p+VaeqoSzuYA==
X-Received: by 2002:a05:6000:1863:b0:39f:fe3:32e9 with SMTP id ffacd0b85a97d-3a06cf502b9mr2008902f8f.8.1745497296708;
        Thu, 24 Apr 2025 05:21:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:ff00:f734:227:6936:cdab? (p200300cbc74eff00f73402276936cdab.dip0.t-ipconnect.de. [2003:cb:c74e:ff00:f734:227:6936:cdab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4c30d7sm1935223f8f.44.2025.04.24.05.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 05:21:36 -0700 (PDT)
Message-ID: <e1f7bfa3-7418-4b4f-9339-c37e7e699c5e@redhat.com>
Date: Thu, 24 Apr 2025 14:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: Fix crash in smaps_hugetlb_range for non-present
 hugetlb entries
To: Ming Wang <wangming01@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Michal Hocko <mhocko@suse.cz>,
 David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>, lixuefeng@loongson.cn,
 Hongchen Zhang <zhanghongchen@loongson.cn>
References: <20250423010359.2030576-1-wangming01@loongson.cn>
 <b64aea02-cc44-433a-8214-854feda2c06d@redhat.com>
 <14bc5d9c-7311-46ae-b46f-314a7ca649d5@loongson.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <14bc5d9c-7311-46ae-b46f-314a7ca649d5@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.04.25 10:14, Ming Wang wrote:
> 
> 
> On 4/23/25 15:07, David Hildenbrand wrote:
>> On 23.04.25 03:03, Ming Wang wrote:
>>> When reading /proc/pid/smaps for a process that has mapped a hugetlbfs
>>> file with MAP_PRIVATE, the kernel might crash inside
>>> pfn_swap_entry_to_page.
>>> This occurs on LoongArch under specific conditions.
>>>
>>> The root cause involves several steps:
>>> 1. When the hugetlbfs file is mapped (MAP_PRIVATE), the initial PMD
>>>      (or relevant level) entry is often populated by the kernel during
>>> mmap()
>>>      with a non-present entry pointing to the architecture's
>>> invalid_pte_table
>>>      On the affected LoongArch system, this address was observed to
>>>      be 0x90000000031e4000.
>>> 2. The smaps walker (walk_hugetlb_range -> smaps_hugetlb_range) reads
>>>      this entry.
>>> 3. The generic is_swap_pte() macro checks `!pte_present() && !
>>> pte_none()`.
>>>      The entry (invalid_pte_table address) is not present. Crucially,
>>>      the generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
>>>      returns false because the invalid_pte_table address is non-zero.
>>>      Therefore, is_swap_pte() incorrectly returns true.
>>> 4. The code enters the `else if (is_swap_pte(...))` block.
>>> 5. Inside this block, it checks `is_pfn_swap_entry()`. Due to a bit
>>>      pattern coincidence in the invalid_pte_table address on LoongArch,
>>>      the embedded generic `is_migration_entry()` check happens to return
>>>      true (misinterpreting parts of the address as a migration type).
>>> 6. This leads to a call to pfn_swap_entry_to_page() with the bogus
>>>      swap entry derived from the invalid table address.
>>> 7. pfn_swap_entry_to_page() extracts a meaningless PFN, finds an
>>>      unrelated struct page, checks its lock status (unlocked), and hits
>>>      the `BUG_ON(is_migration_entry(entry) && !PageLocked(p))` assertion.
>>>
>>> The original code's intent in the `else if` block seems aimed at handling
>>> potential migration entries, as indicated by the inner
>>> `is_pfn_swap_entry()`
>>> check. The issue arises because the outer `is_swap_pte()` check
>>> incorrectly
>>> includes the invalid table pointer case on LoongArch.
>>
>> This has a big loongarch smell to it.
>>
>> If we end up passing !pte_present() && !pte_none(), then loongarch must
>> be fixed to filter out these weird non-present entries.
>>
>> is_swap_pte() must not succeed on something that is not an actual swap pte.
>>
> 
> Hi David,
> 
> Thanks a lot for your feedback and insightful analysis!
> 
> You're absolutely right, the core issue here stems from how the generic
> is_swap_pte() macro interacts with the specific value of
> invalid_pte_table (or the equivalent invalid table entries for PMD) on
> the LoongArch architecture. I agree that this has a strong LoongArch
> characteristic.
> 
> On the affected LoongArch system, the address used for invalid_pte_table
> (observed as 0x90000000031e4000 in the vmcore) happens to satisfy both
> !pte_present() and !pte_none() conditions. This is because:
> 1. It lacks the _PAGE_PRESENT and _PAGE_PROTNONE bits (correct for an
> invalid entry).
> 2. The generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
> returns false, as the address value itself is non-zero and doesn't match
> the all-zero (except global bit) pattern.
> This causes is_swap_pte() to incorrectly return true for these
> non-mapped, initial entries set up during mmap().
> 
> The reason my proposed patch changes the condition in
> smaps_hugetlb_range() from is_swap_pte(ptent) to
> is_hugetlb_entry_migration(pte) is precisely to leverage an
> **architecture-level filtering mechanism**, as you suggested LoongArch
> should provide.
> 
> This works because is_hugetlb_entry_migration() internally calls
> `huge_pte_none()`. LoongArch **already provides** an
> architecture-specific override for huge_pte_none() (via
> `__HAVE_ARCH_HUGE_PTE_NONE`), which is defined as follows in
> arch/loongarch/include/asm/pgtable.h:
> 
> ```
> static inline int huge_pte_none(pte_t pte)
> {
>       unsigned long val = pte_val(pte) & ~_PAGE_GLOBAL;
>       /* Check for all zeros (except global) OR if it points to
> invalid_pte_table */
>       return !val || (val == (unsigned long)invalid_pte_table);
> }
> ```

There is now an alternative fix on the list, right?

https://lore.kernel.org/loongarch/20250424083037.2226732-1-wangming01@loongson.cn/T/#u

-- 
Cheers,

David / dhildenb


