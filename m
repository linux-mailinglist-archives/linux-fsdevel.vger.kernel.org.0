Return-Path: <linux-fsdevel+bounces-29436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526AD979B0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 08:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F224D1F23E3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 06:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00A18288C;
	Mon, 16 Sep 2024 06:15:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC55482EB;
	Mon, 16 Sep 2024 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467315; cv=none; b=dxPjaZOka7cjxkyIasKFyPF+vDKfTTxm3FLaqw2z/3Dhu9VW3vRmhNWsXmDVSBPlnTL6GQhQS43IQkHrkhFTavCI4iZqrSBcqEbefbiIjiHlQ9ovOecRuTrwCq22l0RaQyNikBptNaHB67AzL9YMuXu1geKt7k7D9XVyR8VxuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467315; c=relaxed/simple;
	bh=D8j5Hk0CkaLEX7dXTn/2QhcETJs4MStq2/5OBrQQL24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nl1Bu0x95fDp0zOdJmfXyQSqq681xcLcRp+oO+VzV8pzRnJayYr6Ka7luEeIprlthj/PW+6l/b58xK4iUB37yFmnOQBZ4EKg4SkP3D/QrUY6ONTxbAcXfoIg7y0tz56DSrwSfVkBHSFINzovls9Skj/UCgElSx3+akqYInyhLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF0D11FB;
	Sun, 15 Sep 2024 23:15:40 -0700 (PDT)
Received: from [10.162.16.84] (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7AD03F66E;
	Sun, 15 Sep 2024 23:15:04 -0700 (PDT)
Message-ID: <61dafb6a-6212-40a6-8382-0d1b0dae57ac@arm.com>
Date: Mon, 16 Sep 2024 11:45:00 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] mm: Use pmdp_get() for accessing PMD entries
To: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Muchun Song <muchun.song@linux.dev>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>
References: <20240913084433.1016256-1-anshuman.khandual@arm.com>
 <20240913084433.1016256-5-anshuman.khandual@arm.com>
 <f918bd00-c6a4-498a-bd17-9f5b32f7d6a7@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <f918bd00-c6a4-498a-bd17-9f5b32f7d6a7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/13/24 16:08, Ryan Roberts wrote:
> On 13/09/2024 09:44, Anshuman Khandual wrote:
>> Convert PMD accesses via pmdp_get() helper that defaults as READ_ONCE() but
>> also provides the platform an opportunity to override when required.
>>
>> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
>> Cc: Muchun Song <muchun.song@linux.dev>
>> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Dennis Zhou <dennis@kernel.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Christoph Lameter <cl@linux.com>
>> Cc: Uladzislau Rezki <urezki@gmail.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: kasan-dev@googlegroups.com
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/misc/sgi-gru/grufault.c |  4 +--
>>  fs/proc/task_mmu.c              | 26 +++++++-------
>>  include/linux/huge_mm.h         |  3 +-
>>  include/linux/mm.h              |  2 +-
>>  include/linux/pgtable.h         | 14 ++++----
>>  mm/gup.c                        | 14 ++++----
>>  mm/huge_memory.c                | 60 ++++++++++++++++-----------------
>>  mm/hugetlb_vmemmap.c            |  4 +--
>>  mm/kasan/init.c                 | 10 +++---
>>  mm/kasan/shadow.c               |  4 +--
>>  mm/khugepaged.c                 |  4 +--
>>  mm/madvise.c                    |  6 ++--
>>  mm/memory-failure.c             |  6 ++--
>>  mm/memory.c                     | 25 +++++++-------
>>  mm/mempolicy.c                  |  4 +--
>>  mm/migrate.c                    |  4 +--
>>  mm/migrate_device.c             | 10 +++---
>>  mm/mlock.c                      |  6 ++--
>>  mm/mprotect.c                   |  2 +-
>>  mm/mremap.c                     |  4 +--
>>  mm/page_table_check.c           |  2 +-
>>  mm/pagewalk.c                   |  4 +--
>>  mm/percpu.c                     |  2 +-
>>  mm/pgtable-generic.c            | 16 ++++-----
>>  mm/ptdump.c                     |  2 +-
>>  mm/rmap.c                       |  2 +-
>>  mm/sparse-vmemmap.c             |  4 +--
>>  mm/vmalloc.c                    | 12 +++----
>>  28 files changed, 129 insertions(+), 127 deletions(-)
>>
>> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
>> index 3557d78ee47a..f3d6249b7dfb 100644
>> --- a/drivers/misc/sgi-gru/grufault.c
>> +++ b/drivers/misc/sgi-gru/grufault.c
>> @@ -224,10 +224,10 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
>>  		goto err;
>>  
>>  	pmdp = pmd_offset(pudp, vaddr);
>> -	if (unlikely(pmd_none(*pmdp)))
>> +	if (unlikely(pmd_none(pmdp_get(pmdp))))
>>  		goto err;
>>  #ifdef CONFIG_X86_64
>> -	if (unlikely(pmd_leaf(*pmdp)))
>> +	if (unlikely(pmd_leaf(pmdp_get(pmdp))))
> Just a general comment about multiple gets; before, the compiler most likely
> turned multiple '*pmdp' dereferences into a single actual load. But READ_ONCE()
> inside pmdp_get() ensures you get a load for every call to pmdp_get(). This has
> 2 potential problems:
> 
>  - More loads could potentially regress speed in some hot paths
> 
>  - In paths that don't hold an appropriate PTL the multiple loads could race
> with a writer, meaning each load gets a different value. The intent of the code
> is usually that each check is operating on the same value.

Makes sense, above two concerns are potential problems I guess.

> 
> For the ptep_get() conversion, I solved this by reading into a temporary once
> then using the temporary for the comparisons.

Alright.

> 
> I'm not sure if these are real problems in practice, but seems safest to
> continue to follow this established pattern?

Yes, will make the necessary changes across the series which might create some
amount of code churn but seems like it would be worth. Planning to add old_pxd
local variables when required and load them from the address, as soon as 'pxd'
pointer becomes valid.

