Return-Path: <linux-fsdevel+bounces-56734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C1B1B254
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A342F180EA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A96241691;
	Tue,  5 Aug 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFMdW2Wx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3241E5B78
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391329; cv=none; b=g9IiJiNVmQ4pNQ6YAks58LnZ/2zSjgBJby4OEEXlHQidtPJpf1PGhr5Z4VQrvfwLk9xberW5cXSL5YPsBdjCXDjQmcoZfXsa+WOCYV5DEKSEMi3qUNg8XAUYTDrrwzUYDE55cghs1Tyof43rUq/GpUySzPOlrOUIt+tMO4bwxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391329; c=relaxed/simple;
	bh=VpIuLO4zDxNyZE1PHSOAIYGLr+cZdU0TXVbN/O6zHvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMe1DXk8N4h2lI7lwUU9TeqMM99Wwo4ExMGfn27/s+otrvJjn5gSh3pqYuOCqzFKmHS7NV7/D1R/QQcQCHUBTyXWiuonz7w+4IWk2ct1pVwlTKo1NCRLJXM5ZQpzt9Ja7tDl64XYt4CNjRXkhN7C/rNOBD0nqvyUuEyijtpkokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFMdW2Wx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754391326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XQZDklFzgIg/VRMnloECBcZkyVf0Gj6nmHNcIi06hAc=;
	b=CFMdW2WxjnLZ4HNKMpP5RsMsx9AtFzS1tTg/ikyKpXxwvFHNKutg6fOAd77xNa+toPm4HP
	QB/CW3sQvyqrm9wJpeYGYlqqLBgUgwkPn7NtjxAc4FX35vCY8n7YWDaFW5dsfcLrbfl+6A
	74cOonUAHjoKpWx3i/HC9NS6Pv95ZQ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-YOyKCASjMxy4ukH_jQBIiw-1; Tue, 05 Aug 2025 06:55:25 -0400
X-MC-Unique: YOyKCASjMxy4ukH_jQBIiw-1
X-Mimecast-MFC-AGG-ID: YOyKCASjMxy4ukH_jQBIiw_1754391324
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4538f375e86so42455795e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 03:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754391324; x=1754996124;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XQZDklFzgIg/VRMnloECBcZkyVf0Gj6nmHNcIi06hAc=;
        b=AOE8Qu53JciOwQh8Rvm2vF57Bx63o4uaKsEnoTPgIUXvH+jKH952DLrXMKDEXgHvRb
         265vXTyVXCMNNo2DVHDqkdcaJVqsJKTf0/RVsjFV0e0X5yqI/97uoAPX5R/5+Tau9Nqg
         8idj4cSuIkBMbcMKCIJGz3r4VTEQTpMptcHgpmYU2Llra8b2En3YtQiGbwWDgpU4iPUW
         EjHD1JPoMMFeZl9fe2NJqd4jX+9sWg0S9hYClFkLScuuENT5UO80/MEMmHAL51ow2VE8
         6difiq8EPHYkR6tMdPp9Prdvg5dup3K34NbAHjjAXM8ikP717VcWl0B45kZp5C3CMuZQ
         tpGg==
X-Forwarded-Encrypted: i=1; AJvYcCW6BWVzy4poT9cwjSsLCmyAE1ORbTqKG1ci5Hg1BC5TNSKDi+a6dhupI1GzRdF06I/LvLuTQrzz+wvTB2jV@vger.kernel.org
X-Gm-Message-State: AOJu0YxUcb7DBxsdnNuBfKhpIdLlRChko0IwrWfi5NjQiNRce45Bcfhs
	UEK9xCyeaPXZSeUvgHDAZHcOseLVJM0v0xkJybIZvmGG84Uz7G85HqTlzudZNoidObRdz4gVa2Y
	ZS4JicKlO+3VdkpfsebRKUyjou9pAmj/opuzEc7oSCQdMcwmIBVMqvl8pFPb28Wjd9Jo=
X-Gm-Gg: ASbGncvRmBQwwC+q2+Woqf0cEchlYlIlf5L+W/RbbY1eP6WLqqL0l9d10o291K8lciE
	GUN8FCZxlcfLbtmmdjPAX/TW/AxeqGRQ1CmM46zL79A2NZn8xkFHEqb6LTAlzSFxZ45UC00WgFB
	KPkLI8VuHGP3bzz9ImS7fZEQcpfJtqvOghKdeFlk2O+2jGnIUUCBgNMuwYcqE5zEyN5r1VO4HgU
	XIzEQAsGMpILjLopjNGjm4AsGLCizRsFKah7cksfZoV0SLb/14XMp4TPfI9dCBYX71ybnH9aHKp
	AU2BGbZVcWwyBKISajKqaX1KHOqcIinfqoPsGRrlDnFqRoB4sCqd32QeYoojsmhLqinxk49t6kj
	NM5Pwhc/WvUsmre+sdp5dDiXpstDBUc5dNuPsaVXHcsea/zCtNUx72AD5Q6xKA5Qt2hQ=
X-Received: by 2002:a05:6000:2409:b0:3b6:17c0:f094 with SMTP id ffacd0b85a97d-3b8d9471798mr11284834f8f.14.1754391323776;
        Tue, 05 Aug 2025 03:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXZZ49K+DE6A9wsCyzXFzTDhqAI2hR0tkMmhgQXu6JP+pyCF9/xS8ilZrR1y0iOzvUgnMF0g==
X-Received: by 2002:a05:6000:2409:b0:3b6:17c0:f094 with SMTP id ffacd0b85a97d-3b8d9471798mr11284803f8f.14.1754391323277;
        Tue, 05 Aug 2025 03:55:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc900606sm62407115e9.15.2025.08.05.03.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:55:22 -0700 (PDT)
Message-ID: <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
Date: Tue, 5 Aug 2025 12:55:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
 linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
 <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 0ce86e14ab5e1..8e2aa18873098 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -153,6 +153,7 @@ config X86
>>   	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>>   	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>>   	select ARCH_WANTS_THP_SWAP		if X86_64
>> +	select ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO if X86_64
>>   	select ARCH_HAS_PARANOID_L1D_FLUSH
>>   	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>>   	select BUILDTIME_TABLE_SORT
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 7748489fde1b7..ccfa5c95f14b1 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -495,6 +495,17 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
>>   struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
>>   void mm_put_huge_zero_folio(struct mm_struct *mm);
>> +static inline struct folio *get_static_huge_zero_folio(void)
>> +{
>> +	if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
>> +		return NULL;
>> +
>> +	if (unlikely(!huge_zero_folio))
>> +		return NULL;
>> +
>> +	return huge_zero_folio;
>> +}
>> +
>>   static inline bool thp_migration_supported(void)
>>   {
>>   	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
>> @@ -685,6 +696,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
>>   {
>>   	return 0;
>>   }
>> +
>> +static inline struct folio *get_static_huge_zero_folio(void)
>> +{
>> +	return NULL;
>> +}
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>   static inline int split_folio_to_list_to_order(struct folio *folio,
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index e443fe8cd6cf2..366a6d2d771e3 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -823,6 +823,27 @@ config ARCH_WANT_GENERAL_HUGETLB
>>   config ARCH_WANTS_THP_SWAP
>>   	def_bool n
>> +config ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
>> +	def_bool n
>> +
>> +config STATIC_HUGE_ZERO_FOLIO
>> +	bool "Allocate a PMD sized folio for zeroing"
>> +	depends on ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO && TRANSPARENT_HUGEPAGE
>> +	help
>> +	  Without this config enabled, the huge zero folio is allocated on
>> +	  demand and freed under memory pressure once no longer in use.
>> +	  To detect remaining users reliably, references to the huge zero folio
>> +	  must be tracked precisely, so it is commonly only available for mapping
>> +	  it into user page tables.
>> +
>> +	  With this config enabled, the huge zero folio can also be used
>> +	  for other purposes that do not implement precise reference counting:
>> +	  it is allocated statically and never freed, allowing for more
>> +	  wide-spread use, for example, when performing I/O similar to the
>> +	  traditional shared zeropage.
>> +
>> +	  Not suitable for memory constrained systems.
>> +
>>   config MM_ID
>>   	def_bool n
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index ff06dee213eb2..f65ba3e6f0824 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -866,9 +866,14 @@ static int __init thp_shrinker_init(void)
>>   	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
>>   	shrinker_register(huge_zero_folio_shrinker);
>> -	deferred_split_shrinker->count_objects = deferred_split_count;
>> -	deferred_split_shrinker->scan_objects = deferred_split_scan;
>> -	shrinker_register(deferred_split_shrinker);
>> +	if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO)) {
>> +		if (!get_huge_zero_folio())
>> +			pr_warn("Allocating static huge zero folio failed\n");
>> +	} else {
>> +		deferred_split_shrinker->count_objects = deferred_split_count;
>> +		deferred_split_shrinker->scan_objects = deferred_split_scan;
>> +		shrinker_register(deferred_split_shrinker);
>> +	}
>>   	return 0;
>>   }
>> --
>> 2.50.1
>>
>>
>> Now, one thing I do not like is that we have "ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO" but
>> then have a user-selectable option.
>>
>> Should we just get rid of ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO?
> 
> Yeah, though I guess we probably need to make it need CONFIG_MMU if so?
> Probably don't want to provide it if it might somehow break things?

It would still depend on THP, and THP is !MMU. So that should just work.

We could go one step further and special case in 
mm_get_huge_zero_folio() + mm_put_huge_zero_folio() on 
CONFIG_STATIC_HUGE_ZERO_FOLIO.

Something like

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c38a95e9f091..9b87884e5f299 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -248,6 +248,9 @@ static void put_huge_zero_page(void)

  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
  {
+       if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
+               return huge_zero_folio;
+
         if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
                 return READ_ONCE(huge_zero_folio);

@@ -262,6 +265,9 @@ struct folio *mm_get_huge_zero_folio(struct 
mm_struct *mm)

  void mm_put_huge_zero_folio(struct mm_struct *mm)
  {
+       if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
+               return huge_zero_folio;
+
         if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
                 put_huge_zero_page();
  }


-- 
Cheers,

David / dhildenb


