Return-Path: <linux-fsdevel+bounces-47315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31AA9BC9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 04:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1DA1BA09DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8E1494D9;
	Fri, 25 Apr 2025 02:10:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BA243AA8;
	Fri, 25 Apr 2025 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547001; cv=none; b=Z07qga1AVMBj0xNWNJFAz/lddPQeddi1h9H6FVUbi7RdeJOq1Ae5y4D/DUkxKFmt6YyUcEAa7o8AUCy9ycbVPl14Hj1S6ZKTEkw8knLyZw++3rCGA27IgIXGofFZeqxVs2V7yKfSW+OmSOleFjRnCAk3xFFvTbju6MQnYjpWc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547001; c=relaxed/simple;
	bh=Sg8h68wZWJmyoRmjHkCWm9/Yh/jj4TPX0nNHUOj9eIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKtjxoph1r9285wyDNCpIOAbHwUfWHQ2O5p0vonKjhV5FTe2AliWurvLaFuJyNa4pGVkJSEBDXqG3M5XLCjgQwcSXTg+DZ2U/uoLTpeGCwsmN+0F4yIVsQA9KKCWeTjWAcWTMGntHVEf/QkxnWriaU0VqMMB7bIIFjNj3qWsfQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [124.127.64.69])
	by gateway (Coremail) with SMTP id _____8DxfWvo7gpoB8jFAA--.355S3;
	Fri, 25 Apr 2025 10:09:44 +0800 (CST)
Received: from [192.168.196.221] (unknown [124.127.64.69])
	by front1 (Coremail) with SMTP id qMiowMAxSsTU7gpo_WuUAA--.39219S2;
	Fri, 25 Apr 2025 10:09:27 +0800 (CST)
Message-ID: <bf94e45b-c524-42a0-af11-703f0c5b425d@loongson.cn>
Date: Fri, 25 Apr 2025 10:09:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: Fix crash in smaps_hugetlb_range for non-present
 hugetlb entries
To: David Hildenbrand <david@redhat.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Michal Hocko <mhocko@suse.cz>,
 David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, lixuefeng@loongson.cn,
 Hongchen Zhang <zhanghongchen@loongson.cn>
References: <20250423010359.2030576-1-wangming01@loongson.cn>
 <b64aea02-cc44-433a-8214-854feda2c06d@redhat.com>
 <14bc5d9c-7311-46ae-b46f-314a7ca649d5@loongson.cn>
 <e1f7bfa3-7418-4b4f-9339-c37e7e699c5e@redhat.com>
 <CAAhV-H5SL_aqvx28h+szz1D2Up-m=GMv7KfdW0AFbdzH-TmeQA@mail.gmail.com>
 <5c307270-a5af-4344-89d3-7b79922d28d8@redhat.com>
From: Ming Wang <wangming01@loongson.cn>
Content-Language: en-US
In-Reply-To: <5c307270-a5af-4344-89d3-7b79922d28d8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxSsTU7gpo_WuUAA--.39219S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAgEDEmgKxeYDGgAAsK
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr4rZFWDZr1kJr1xKF1fKrX_yoW7KF4Dpr
	95Ka4jqFZ5Jry8Jwnrtw4jqryYyr1fW3WUXrn8GF1UCr9xtr1jgrWjgrWYgFy5ArWrGw4j
	vrWjqa47Z3WUtFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1q6r43M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20x
	vEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVnNVDUUUU

Hi David, Huacai,

On 4/24/25 20:39, David Hildenbrand wrote:
> On 24.04.25 14:36, Huacai Chen wrote:
>> On Thu, Apr 24, 2025 at 8:21 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 23.04.25 10:14, Ming Wang wrote:
>>>>
>>>>
>>>> On 4/23/25 15:07, David Hildenbrand wrote:
>>>>> On 23.04.25 03:03, Ming Wang wrote:
>>>>>> When reading /proc/pid/smaps for a process that has mapped a hugetlbfs
>>>>>> file with MAP_PRIVATE, the kernel might crash inside
>>>>>> pfn_swap_entry_to_page.
>>>>>> This occurs on LoongArch under specific conditions.
>>>>>>
>>>>>> The root cause involves several steps:
>>>>>> 1. When the hugetlbfs file is mapped (MAP_PRIVATE), the initial PMD
>>>>>>       (or relevant level) entry is often populated by the kernel during
>>>>>> mmap()
>>>>>>       with a non-present entry pointing to the architecture's
>>>>>> invalid_pte_table
>>>>>>       On the affected LoongArch system, this address was observed to
>>>>>>       be 0x90000000031e4000.
>>>>>> 2. The smaps walker (walk_hugetlb_range -> smaps_hugetlb_range) reads
>>>>>>       this entry.
>>>>>> 3. The generic is_swap_pte() macro checks `!pte_present() && !
>>>>>> pte_none()`.
>>>>>>       The entry (invalid_pte_table address) is not present. Crucially,
>>>>>>       the generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
>>>>>>       returns false because the invalid_pte_table address is non-zero.
>>>>>>       Therefore, is_swap_pte() incorrectly returns true.
>>>>>> 4. The code enters the `else if (is_swap_pte(...))` block.
>>>>>> 5. Inside this block, it checks `is_pfn_swap_entry()`. Due to a bit
>>>>>>       pattern coincidence in the invalid_pte_table address on LoongArch,
>>>>>>       the embedded generic `is_migration_entry()` check happens to return
>>>>>>       true (misinterpreting parts of the address as a migration type).
>>>>>> 6. This leads to a call to pfn_swap_entry_to_page() with the bogus
>>>>>>       swap entry derived from the invalid table address.
>>>>>> 7. pfn_swap_entry_to_page() extracts a meaningless PFN, finds an
>>>>>>       unrelated struct page, checks its lock status (unlocked), and hits
>>>>>>       the `BUG_ON(is_migration_entry(entry) && !PageLocked(p))` assertion.
>>>>>>
>>>>>> The original code's intent in the `else if` block seems aimed at handling
>>>>>> potential migration entries, as indicated by the inner
>>>>>> `is_pfn_swap_entry()`
>>>>>> check. The issue arises because the outer `is_swap_pte()` check
>>>>>> incorrectly
>>>>>> includes the invalid table pointer case on LoongArch.
>>>>>
>>>>> This has a big loongarch smell to it.
>>>>>
>>>>> If we end up passing !pte_present() && !pte_none(), then loongarch must
>>>>> be fixed to filter out these weird non-present entries.
>>>>>
>>>>> is_swap_pte() must not succeed on something that is not an actual swap pte.
>>>>>
>>>>
>>>> Hi David,
>>>>
>>>> Thanks a lot for your feedback and insightful analysis!
>>>>
>>>> You're absolutely right, the core issue here stems from how the generic
>>>> is_swap_pte() macro interacts with the specific value of
>>>> invalid_pte_table (or the equivalent invalid table entries for PMD) on
>>>> the LoongArch architecture. I agree that this has a strong LoongArch
>>>> characteristic.
>>>>
>>>> On the affected LoongArch system, the address used for invalid_pte_table
>>>> (observed as 0x90000000031e4000 in the vmcore) happens to satisfy both
>>>> !pte_present() and !pte_none() conditions. This is because:
>>>> 1. It lacks the _PAGE_PRESENT and _PAGE_PROTNONE bits (correct for an
>>>> invalid entry).
>>>> 2. The generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
>>>> returns false, as the address value itself is non-zero and doesn't match
>>>> the all-zero (except global bit) pattern.
>>>> This causes is_swap_pte() to incorrectly return true for these
>>>> non-mapped, initial entries set up during mmap().
>>>>
>>>> The reason my proposed patch changes the condition in
>>>> smaps_hugetlb_range() from is_swap_pte(ptent) to
>>>> is_hugetlb_entry_migration(pte) is precisely to leverage an
>>>> **architecture-level filtering mechanism**, as you suggested LoongArch
>>>> should provide.
>>>>
>>>> This works because is_hugetlb_entry_migration() internally calls
>>>> `huge_pte_none()`. LoongArch **already provides** an
>>>> architecture-specific override for huge_pte_none() (via
>>>> `__HAVE_ARCH_HUGE_PTE_NONE`), which is defined as follows in
>>>> arch/loongarch/include/asm/pgtable.h:
>>>>
>>>> ```
>>>> static inline int huge_pte_none(pte_t pte)
>>>> {
>>>>        unsigned long val = pte_val(pte) & ~_PAGE_GLOBAL;
>>>>        /* Check for all zeros (except global) OR if it points to
>>>> invalid_pte_table */
>>>>        return !val || (val == (unsigned long)invalid_pte_table);
>>>> }
>>>> ```
>>>
>>> There is now an alternative fix on the list, right?
>>>
>>> https://lore.kernel.org/loongarch/20250424083037.2226732-1-wangming01@loongson.cn/T/#u
>> Yes, that one is better.
> 
> We do now have page table walkers that walk hugetlb tables without any hugetlb specifics.
> 
> Examples are GUP and folio_walk_start().
> 
> I assume these will be working as expected, because they would be checking pmd_none() / pmd_present() natively, correct?
> 

Thanks for the clarification, David. Your point about generic page table walkers like GUP and folio_walk_start() 
relying on native pmd_none()/pmd_present() checks makes perfect sense.

Therefore, I'll withdraw the patch modifying smaps_hugetlb_range(). We should proceed with the alternative fix 
at the LoongArch architecture level.
Thanks again for guiding this towards the correct architectural solution!

Best regards,
Ming


