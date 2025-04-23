Return-Path: <linux-fsdevel+bounces-47057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177E7A982D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7277A442772
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E7927FD65;
	Wed, 23 Apr 2025 08:14:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD427C864;
	Wed, 23 Apr 2025 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396081; cv=none; b=QfLi76bQPUZ3LVdh5FzqLAlca9Ek065tUiVcSYpVZFbnsrpNqSs6Lz9jYDz03E06NtBuZSflbsrWEMirDdbcuKkq1ISZqZ/apnB3wcllOErK9J2yUg+QK9ABuybmEI9ChyGn/H7JMtvKRHQ/XMqx7jWA0b8XASLpbDjC/7pbKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396081; c=relaxed/simple;
	bh=Mpivr1RWx8BaFRRvDOGgtkp3WTYmZ8tEWCgYFTkGq/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7Shz1+bh3TCvlMj1Ve683fkuMwksYTlBQm9RTZxJ/Jt2j8CGo7oZmAF+cHdlm1byBoAj9pnZeEe3kuUEloK0SnkqhS0uXocZRE1Bd6RYCnuLVek+Y3ikwrJSwYSwNT+Nm5o6GCOm4EhCZP2Ll4MdBPIR0zOapYE5eR9HHkaS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8BxnmtkoQho4YbEAA--.63256S3;
	Wed, 23 Apr 2025 16:14:28 +0800 (CST)
Received: from [10.180.13.127] (unknown [111.207.111.194])
	by front1 (Coremail) with SMTP id qMiowMAxHsddoQhoGmuRAA--.41144S2;
	Wed, 23 Apr 2025 16:14:21 +0800 (CST)
Message-ID: <14bc5d9c-7311-46ae-b46f-314a7ca649d5@loongson.cn>
Date: Wed, 23 Apr 2025 16:14:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: Fix crash in smaps_hugetlb_range for non-present
 hugetlb entries
To: David Hildenbrand <david@redhat.com>,
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
Content-Language: en-US
From: Ming Wang <wangming01@loongson.cn>
In-Reply-To: <b64aea02-cc44-433a-8214-854feda2c06d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxHsddoQhoGmuRAA--.41144S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQEBEmgIG+UJiwAAsP
X-Coremail-Antispam: 1Uk129KBj93XoWxZw1rZr1Uur15Kw4UKrWDZFc_yoWrCF1DpF
	9Yg398WFZ5GrykXws7Gw4qqrW5Zr4fW3WUGFn8Gr1Yk3sxJryq9FWFgrWagFyrArZ5Gw42
	9FW2q3srZ3Z8t3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUtVW8ZwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082
	IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0GLvtUUUUU==



On 4/23/25 15:07, David Hildenbrand wrote:
> On 23.04.25 03:03, Ming Wang wrote:
>> When reading /proc/pid/smaps for a process that has mapped a hugetlbfs
>> file with MAP_PRIVATE, the kernel might crash inside 
>> pfn_swap_entry_to_page.
>> This occurs on LoongArch under specific conditions.
>>
>> The root cause involves several steps:
>> 1. When the hugetlbfs file is mapped (MAP_PRIVATE), the initial PMD
>>     (or relevant level) entry is often populated by the kernel during 
>> mmap()
>>     with a non-present entry pointing to the architecture's 
>> invalid_pte_table
>>     On the affected LoongArch system, this address was observed to
>>     be 0x90000000031e4000.
>> 2. The smaps walker (walk_hugetlb_range -> smaps_hugetlb_range) reads
>>     this entry.
>> 3. The generic is_swap_pte() macro checks `!pte_present() && ! 
>> pte_none()`.
>>     The entry (invalid_pte_table address) is not present. Crucially,
>>     the generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
>>     returns false because the invalid_pte_table address is non-zero.
>>     Therefore, is_swap_pte() incorrectly returns true.
>> 4. The code enters the `else if (is_swap_pte(...))` block.
>> 5. Inside this block, it checks `is_pfn_swap_entry()`. Due to a bit
>>     pattern coincidence in the invalid_pte_table address on LoongArch,
>>     the embedded generic `is_migration_entry()` check happens to return
>>     true (misinterpreting parts of the address as a migration type).
>> 6. This leads to a call to pfn_swap_entry_to_page() with the bogus
>>     swap entry derived from the invalid table address.
>> 7. pfn_swap_entry_to_page() extracts a meaningless PFN, finds an
>>     unrelated struct page, checks its lock status (unlocked), and hits
>>     the `BUG_ON(is_migration_entry(entry) && !PageLocked(p))` assertion.
>>
>> The original code's intent in the `else if` block seems aimed at handling
>> potential migration entries, as indicated by the inner 
>> `is_pfn_swap_entry()`
>> check. The issue arises because the outer `is_swap_pte()` check 
>> incorrectly
>> includes the invalid table pointer case on LoongArch.
> 
> This has a big loongarch smell to it.
> 
> If we end up passing !pte_present() && !pte_none(), then loongarch must 
> be fixed to filter out these weird non-present entries.
> 
> is_swap_pte() must not succeed on something that is not an actual swap pte.
> 

Hi David,

Thanks a lot for your feedback and insightful analysis!

You're absolutely right, the core issue here stems from how the generic 
is_swap_pte() macro interacts with the specific value of 
invalid_pte_table (or the equivalent invalid table entries for PMD) on 
the LoongArch architecture. I agree that this has a strong LoongArch 
characteristic.

On the affected LoongArch system, the address used for invalid_pte_table 
(observed as 0x90000000031e4000 in the vmcore) happens to satisfy both 
!pte_present() and !pte_none() conditions. This is because:
1. It lacks the _PAGE_PRESENT and _PAGE_PROTNONE bits (correct for an 
invalid entry).
2. The generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`) 
returns false, as the address value itself is non-zero and doesn't match 
the all-zero (except global bit) pattern.
This causes is_swap_pte() to incorrectly return true for these 
non-mapped, initial entries set up during mmap().

The reason my proposed patch changes the condition in 
smaps_hugetlb_range() from is_swap_pte(ptent) to 
is_hugetlb_entry_migration(pte) is precisely to leverage an 
**architecture-level filtering mechanism**, as you suggested LoongArch 
should provide.

This works because is_hugetlb_entry_migration() internally calls 
`huge_pte_none()`. LoongArch **already provides** an 
architecture-specific override for huge_pte_none() (via 
`__HAVE_ARCH_HUGE_PTE_NONE`), which is defined as follows in 
arch/loongarch/include/asm/pgtable.h:

```
static inline int huge_pte_none(pte_t pte)
{
     unsigned long val = pte_val(pte) & ~_PAGE_GLOBAL;
     /* Check for all zeros (except global) OR if it points to 
invalid_pte_table */
     return !val || (val == (unsigned long)invalid_pte_table);
}
```


