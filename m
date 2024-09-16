Return-Path: <linux-fsdevel+bounces-29429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC8979A11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 05:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58229B22A05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 03:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B1182B3;
	Mon, 16 Sep 2024 03:16:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DB5A29;
	Mon, 16 Sep 2024 03:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726456574; cv=none; b=BVY3rieU98yqaDgJHvgA8iGU+wNjafiz6NW1WmZMOPLlWwo9jtb/WWMxeSM71d+Cbu6Naxqk4opTuB/ol2lgO8DQoBg1GlXZu165pX8sy6c5bXCiwxMTVWqN3U10ew67n3gi34IzlyKBIf6oTM1L3ndMZPLxt6G/Q3JJawY9l5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726456574; c=relaxed/simple;
	bh=6SSCBBeuPSVazQCubyg4niWqsTWvXTxDLK1LRS4x7b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+k4nBny9i8WiSdIqjRZUCQ2uGA3zx+wmdVpxMTMeS5oXGwmMCiYzB/xY59QbhciWoSRrpt9JlxUlDkp5KoIARFrMvjDxZxZGXkTODCBImBbN16WKsHWtnIb2AknYMtMUP9SF0uZHm3U6ZPqk9wMqjbeQ3cDA3PW/E+H4Pu+A9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1A6D1476;
	Sun, 15 Sep 2024 20:16:41 -0700 (PDT)
Received: from [10.162.16.84] (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6B5E3F64C;
	Sun, 15 Sep 2024 20:16:08 -0700 (PDT)
Message-ID: <357931ba-d059-453b-a91d-1bed7fbe5914@arm.com>
Date: Mon, 16 Sep 2024 08:46:06 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] mm: Use ptep_get() for accessing PTE entries
To: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240913084433.1016256-1-anshuman.khandual@arm.com>
 <20240913084433.1016256-4-anshuman.khandual@arm.com>
 <f7129bab-4def-4d64-8135-b5f0467bf739@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <f7129bab-4def-4d64-8135-b5f0467bf739@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/13/24 15:57, Ryan Roberts wrote:
> On 13/09/2024 09:44, Anshuman Khandual wrote:
>> Convert PTE accesses via ptep_get() helper that defaults as READ_ONCE() but
>> also provides the platform an opportunity to override when required.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  include/linux/pgtable.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 2a6a3cccfc36..05e6995c1b93 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -1060,7 +1060,7 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
>>   */
>>  #define set_pte_safe(ptep, pte) \
>>  ({ \
>> -	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
>> +	WARN_ON_ONCE(pte_present(ptep_get(ptep)) && !pte_same(ptep_get(ptep), pte)); \
> 
> Suggest reading once into a temporary so that the pte can't change between the 2
> gets. In practice, it's not likely to be a huge problem for this instance since
> its under the PTL so can only be racing with HW update of access and dirty. But
> good practice IMHO:
> 
>     pte_t __old = ptep_get(ptep); \
>     WARN_ON_ONCE(pte_present(__old) && !pte_same(__old, pte)); \

Sure, will change as suggested.

> 
> Thanks,
> Ryan
> 
>>  	set_pte(ptep, pte); \
>>  })
>>  
> 

