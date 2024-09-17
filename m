Return-Path: <linux-fsdevel+bounces-29576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C1D97AEB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 12:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D0428278A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E311165F08;
	Tue, 17 Sep 2024 10:27:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D115B54F;
	Tue, 17 Sep 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568875; cv=none; b=XE3mpbZnExsXRdXPrcLnAOjIRhfEGDsrCWcVRZZ/O7J8U0p2htrC0xg5skJBmVtdNun0WF+/QqCfoeUDxLAWqh3dI2xH/DeTMl22YqjBMEQjTvCIxk2ZZQx+YpERRvQExkxakAZVZDOWqbxmfkjqr2C/EYdjjvrPMeINBGVSv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568875; c=relaxed/simple;
	bh=2HVdrGR1eXf+GNnUU3v+HBuFx+xtJm0DzRrb41BDCKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSZR1fQxW6VrvXu2we+VuoDOvPAdJuVRmXTGANJDxllKreI1pJh7T8CyUBxnDfbulGOB4EqZdkSJ4/r9vmBZU63h4yx0zyIeA9Nbv6Jd3u89iSv4aELzAndmpN36HFFfhvBQsHnnOcbqQ+YJU1Wp3tHgN80b+MdNI7TglavL/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49E8F1007;
	Tue, 17 Sep 2024 03:28:22 -0700 (PDT)
Received: from [10.57.83.157] (unknown [10.57.83.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1A063F64C;
	Tue, 17 Sep 2024 03:27:50 -0700 (PDT)
Message-ID: <a35f99b6-1510-443c-bb6f-7e312cbd4f79@arm.com>
Date: Tue, 17 Sep 2024 11:27:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/7] m68k/mm: Change pmd_val()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-2-anshuman.khandual@arm.com>
 <4ced9211-2bd7-4257-a9fc-32c775ceffef@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <4ced9211-2bd7-4257-a9fc-32c775ceffef@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/09/2024 11:20, David Hildenbrand wrote:
> On 17.09.24 09:31, Anshuman Khandual wrote:
>> This changes platform's pmd_val() to access the pmd_t element directly like
>> other architectures rather than current pointer address based dereferencing
>> that prevents transition into pmdp_get().
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Guo Ren <guoren@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-m68k@lists.linux-m68k.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/m68k/include/asm/page.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
>> index 8cfb84b49975..be3f2c2a656c 100644
>> --- a/arch/m68k/include/asm/page.h
>> +++ b/arch/m68k/include/asm/page.h
>> @@ -19,7 +19,7 @@
>>    */
>>   #if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
>>   typedef struct { unsigned long pmd; } pmd_t;
>> -#define pmd_val(x)    ((&x)->pmd)
>> +#define pmd_val(x)    ((x).pmd)
>>   #define __pmd(x)    ((pmd_t) { (x) } )
>>   #endif
>>   
> 
> Trying to understand what's happening here, I stumbled over
> 
> commit ef22d8abd876e805b604e8f655127de2beee2869
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Fri Jan 31 13:45:36 2020 +0100
> 
>     m68k: mm: Restructure Motorola MMU page-table layout
>         The Motorola 68xxx MMUs, 040 (and later) have a fixed 7,7,{5,6}
>     page-table setup, where the last depends on the page-size selected (8k
>     vs 4k resp.), and head.S selects 4K pages. For 030 (and earlier) we
>     explicitly program 7,7,6 and 4K pages in %tc.
>         However, the current code implements this mightily weird. What it does
>     is group 16 of those (6 bit) pte tables into one 4k page to not waste
>     space. The down-side is that that forces pmd_t to be a 16-tuple
>     pointing to consecutive pte tables.
>         This breaks the generic code which assumes READ_ONCE(*pmd) will be
>     word sized.
> 
> Where we did
> 
>  #if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
> -typedef struct { unsigned long pmd[16]; } pmd_t;
> -#define pmd_val(x)     ((&x)->pmd[0])
> -#define __pmd(x)       ((pmd_t) { { (x) }, })
> +typedef struct { unsigned long pmd; } pmd_t;
> +#define pmd_val(x)     ((&x)->pmd)
> +#define __pmd(x)       ((pmd_t) { (x) } )
>  #endif
> 
> So I assume this should be fine

I think you're implying that taking the address then using arrow operator was
needed when pmd was an array? I don't really understand that if so? Surely:

  ((x).pmd[0])

would have worked too? I traced back further, and a version of that macro exists
with the "address of" and arrow operator since the beginning of (git) time.

> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


