Return-Path: <linux-fsdevel+bounces-29698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82F97C6DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 11:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215EB1F27718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047C199933;
	Thu, 19 Sep 2024 09:20:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0349FC0C;
	Thu, 19 Sep 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737609; cv=none; b=M7IUT9F5RRYJeS+BzIo9PvXSWPSgumSRoWCqDvUkq6fhfW5EY3+wKlMspTF+rjU3cyrqO0cNLtz2nQNNNiShZa7Hy/q69agFS4fvzunz0WSv/f2wE1KsNnEhRXRbLsRW7g2VWxY37cJS0ai5aCO0c54/QYKYCf8+QWG2woBTpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737609; c=relaxed/simple;
	bh=n5Rx+jCPXNPBsbohpMGGCsuuhUhyJlKgwV4w8Xic3es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXhehbohdladaH6twgpSuFysGUn7UD2rfR0uLPCbiXSug6IGFWJzRtOtoJFBT/CJknVd4j52UqCAkIv1udz60ew5G1oWZHY4P7Lg/k1B0vGoI8XzOmXXzCT1Fl0PmbJZdF0xFHnBvpb8EMRvOmhSedCJqHkamVWuYlIe1uns+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9BC71007;
	Thu, 19 Sep 2024 02:20:36 -0700 (PDT)
Received: from [10.163.34.169] (unknown [10.163.34.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 402293F86F;
	Thu, 19 Sep 2024 02:20:02 -0700 (PDT)
Message-ID: <3ac8c39c-e842-41e4-960a-6b41cd83848d@arm.com>
Date: Thu, 19 Sep 2024 14:50:00 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] mm: Use ptep_get() for accessing PTE entries
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-4-anshuman.khandual@arm.com>
 <f9a7ebb4-3d7c-403e-b818-29a6a3b12adc@redhat.com>
 <8cafe140-35cf-4e9d-8218-dfbfc156ca69@arm.com>
 <d32136d4-94ab-432a-89ae-5f41935404ff@redhat.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <d32136d4-94ab-432a-89ae-5f41935404ff@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/19/24 13:34, David Hildenbrand wrote:
> On 18.09.24 08:32, Anshuman Khandual wrote:
>>
>>
>> On 9/17/24 15:58, David Hildenbrand wrote:
>>> On 17.09.24 09:31, Anshuman Khandual wrote:
>>>> Convert PTE accesses via ptep_get() helper that defaults as READ_ONCE() but
>>>> also provides the platform an opportunity to override when required. This
>>>> stores read page table entry value in a local variable which can be used in
>>>> multiple instances there after. This helps in avoiding multiple memory load
>>>> operations as well possible race conditions.
>>>>
>>>
>>> Please make it clearer in the subject+description that this really only involves set_pte_safe().
>>
>> I will update the commit message with some thing like this.
>>
>> mm: Use ptep_get() in set_pte_safe()
>>
>> This converts PTE accesses in set_pte_safe() via ptep_get() helper which
>> defaults as READ_ONCE() but also provides the platform an opportunity to
>> override when required. This stores read page table entry value in a local
>> variable which can be used in multiple instances there after. This helps
>> in avoiding multiple memory load operations as well as some possible race
>> conditions.
>>
>>>
>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>    include/linux/pgtable.h | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index 2a6a3cccfc36..547eeae8c43f 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -1060,7 +1060,8 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>>>>     */
>>>>    #define set_pte_safe(ptep, pte) \
>>>>    ({ \
>>>> -    WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
>>>> +    pte_t __old = ptep_get(ptep); \
>>>> +    WARN_ON_ONCE(pte_present(__old) && !pte_same(__old, pte)); \
>>>>        set_pte(ptep, pte); \
>>>>    })
>>>>    
>>>
>>> I don't think this is necessary. PTE present cannot flip concurrently, that's the whole reason of the "safe" part after all.
>>
>> Which is not necessary ? Converting de-references to ptep_get() OR caching
>> the page table read value in a local variable ? ptep_get() conversion also
>> serves the purpose providing an opportunity for platform to override.
> 
> Which arch override are you thinking of where this change here would make a real difference? Would it even make a difference with cont-pte on arm?

As we figured out already this code is not used any where other than x86 platform.
So changing this, won't make a difference for arm64 unless I am missing something.
The idea behind the series is to ensure that, there are no direct de-referencing
of page table entries in generic MM code and all accesses should go via available
helpers instead. But if we move these set_pxd_safe() helpers into platform code as
you have suggested earlier, those changes will not be necessary anymore.

> 
>>
>>>
>>> Can we just move these weird set_pte/pmd_safe() stuff to x86 init code and be done with it? Then it's also clear *where* it is getting used and for which reason.
>>>
>> set_pte/pmd_safe() can be moved to x86 platform - as that is currently the
>> sole user for these helpers. But because set_pgd_safe() gets used in riscv
>> platform, just wondering would it be worth moving only the pte/pmd helpers
>> but not the pgd one ?
> 
> My take would be just to move them where they are used, and possibly even inlining them.
> 
> The point is that it's absolutely underdocumented what "_safe" is supposed to be here, and I don't really see the reason to have this in common code (making the common API more complicated).

Agreed, it makes sense for these helpers to be in the platform code instead where
they get used (x86, riscv). Will move them as required.

