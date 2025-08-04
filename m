Return-Path: <linux-fsdevel+bounces-56673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B837B1A857
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD03F7A723F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C9B28B3FD;
	Mon,  4 Aug 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGodQO64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5A2853E7
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327235; cv=none; b=fh2TWY1cGx04KaFiZ2T5iiDgaA0Zg8AiKphzfc19K+IR3pTib8pxl+zrhpXjgi8Ro45N/w2su5e6nFm2XXNTln8UCby0LrD9TM/I/5rO7h9MDBjQCC2cK6ObwGjcZoc/dcer9GON0g+Rv9Lk05LMzXk2KVAkLat0Z0zAtGK0o6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327235; c=relaxed/simple;
	bh=PXcHW/9iucnH/zHKiQhKtocF7xzqOgf+ErnJPfjgHBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvc5XAGMuB9iqrHvjzNLGXs8Xz9kXEO53dHrAPVy58ukttcLiiXt176r+6+XP1e3ZQ9kO7e2i4gWsa5VLW9+OOBeCq9eNByuWbVZLH92ZvPjMo9Z/z+IF8/c2myfJu8VcBOTEqozKzlfVMwNuRJo/bFu7hVLNkr6ECFM135eMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGodQO64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754327232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iVUXeVhevdr3gl8jAkiDzsGcWoOD99m4u+R44+TXhhU=;
	b=VGodQO64YwTBKVdxvAHHCpx0H4NAeXy0xwreyKtB8pTAju6ZZKQu9utO1y3WpbSArNtvEE
	C94J8T8ZDdxJqS3K/UtUb5OBQ9qAzg/qqF7V76vQZvKx4t+svZ4i+1+JZwvho7PR+G/Wb5
	u2Xs6OVoOUNWMg2U0qDTO87ovIP6Oe8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-QX2-gX-oO7WzLQmdcS29aA-1; Mon, 04 Aug 2025 13:07:11 -0400
X-MC-Unique: QX2-gX-oO7WzLQmdcS29aA-1
X-Mimecast-MFC-AGG-ID: QX2-gX-oO7WzLQmdcS29aA_1754327230
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7825a2ca5so2809681f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 10:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327230; x=1754932030;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iVUXeVhevdr3gl8jAkiDzsGcWoOD99m4u+R44+TXhhU=;
        b=dU2UxW0ZZRef/Yta4o9+Yl96VjSvyGme486zW/mgSkcCdAXF9XtQMlBfhA/8eXLx7+
         rT7Oa9uYKSj5AlVyLJjac9zgJHIOXSmlbT3rC4QRJRU8z03EMEEdds2NyHE3NTWROAGf
         KwYjXldSsAKFTbzt9a+PMoMUmX8tqAED7ypF43GFWrvDv8uQvmrJZbkC+zZ1wjOxTtPR
         lN7HCATL+737uoT3/GZRvOiGLu96tJtEzDUF3BOgQSAeDmrKyFrLLF/e5HiN1QKVgkyW
         fCAUpn+o3d01+l4ClMu0GecLVO8ka887v50DYvfPKoohBrUIMLpo/8cnRl7Octe78bSL
         CQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO7w3ZnsZ91VdYEcO2+BObFgEtmkUSvH6RYish2L59F6rVxl66sTzlOTyUXMAVde0tqXp/8L02nbKWAVvr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CH1/VCBo4D9S65cP1NwNjCXh990vDXU5F0GiOMvVjTnnATFZ
	6JNOdi/YHvzqmQ2NjUsh4L5K1SlArk0UT4rCN6CijHBKH/+c1tVxTT/pi9/jMhMrvo74+4A0wZp
	uEsGJogKbSSlBrbuVpC1JPbEkbo77vRfzWrR3r/5/nF2PyvdDiI3E41gCpwIPBs7QjkI=
X-Gm-Gg: ASbGncuCod4JCAbXa8lwhBuqEiins+qWYkmF5q2aLEqm6DtX1JhdShLpIwoh7sZAZKc
	Ga8stNvti7Y2M9bfDwXCF30BCtW+6jXHUuub8IsWh9r30tzD9rF/83I9Eb5iv0PGO+t2CgmRWk4
	QVMvYjWH4WWgnFiNeoYWEckD2fw5AMY4zNtLYpWDAh7Gtt57hXF8W/7FUU9JsOs532/AyvWEjij
	vnfOO9v0jvs5bBAuCzL32x5lQ8VZ/EME11nMrfzyplZg1rduxVrNmX3QIldvsb5fQmZ5h5K6LZo
	JvXrAP7FMA0L9IhjhsldD2S9XtqCTVXpSoYsVAB/l+/ee7tN1ZB4Jx3YzRwOUm/EW7azJ99okOG
	JmZvaUNZ3BcTdlCMOKXfE1fXDBfb68Mq8tK5PBPOG+Uq0JxDReIB7uq2LDh47QkhBLk4=
X-Received: by 2002:a05:6000:4029:b0:3b7:76ac:8b9f with SMTP id ffacd0b85a97d-3b8ebecd615mr288284f8f.25.1754327229883;
        Mon, 04 Aug 2025 10:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXL5Q7R7x+qykA4AqgeHN6GKBjyGrzBzZugMIOacb9uCyM/F14SxoZVFPy/Vyg60jnHkWW/A==
X-Received: by 2002:a05:6000:4029:b0:3b7:76ac:8b9f with SMTP id ffacd0b85a97d-3b8ebecd615mr288237f8f.25.1754327229290;
        Mon, 04 Aug 2025 10:07:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47b10asm15861583f8f.60.2025.08.04.10.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 10:07:08 -0700 (PDT)
Message-ID: <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
Date: Mon, 4 Aug 2025 19:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 18:46, Lorenzo Stoakes wrote:
> On Mon, Aug 04, 2025 at 02:13:54PM +0200, Pankaj Raghav (Samsung) wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> There are many places in the kernel where we need to zeroout larger
>> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
>> is limited by PAGE_SIZE.
>>
>> This is especially annoying in block devices and filesystems where we
>> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
>> bvec support in block layer, it is much more efficient to send out
>> larger zero pages as a part of single bvec.
>>
>> This concern was raised during the review of adding LBS support to
>> XFS[1][2].
>>
>> Usually huge_zero_folio is allocated on demand, and it will be
>> deallocated by the shrinker if there are no users of it left. At moment,
>> huge_zero_folio infrastructure refcount is tied to the process lifetime
>> that created it. This might not work for bio layer as the completions
>> can be async and the process that created the huge_zero_folio might no
>> longer be alive. And, one of the main point that came during discussion
>> is to have something bigger than zero page as a drop-in replacement.
>>
>> Add a config option STATIC_HUGE_ZERO_FOLIO that will result in allocating
>> the huge zero folio on first request, if not already allocated, and turn
>> it static such that it can never get freed. This makes using the
>> huge_zero_folio without having to pass any mm struct and does not tie the
>> lifetime of the zero folio to anything, making it a drop-in replacement
>> for ZERO_PAGE.
>>
>> If STATIC_HUGE_ZERO_FOLIO config option is enabled, then
>> mm_get_huge_zero_folio() will simply return this page instead of
>> dynamically allocating a new PMD page.
>>
>> This option can waste memory in small systems or systems with 64k base
>> page size. So make it an opt-in and also add an option from individual
>> architecture so that we don't enable this feature for larger base page
>> size systems. Only x86 is enabled as a part of this series. Other
>> architectures shall be enabled as a follow-up to this series.
>>
>> [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
>> [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
>>
>> Co-developed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>   arch/x86/Kconfig        |  1 +
>>   include/linux/huge_mm.h | 18 ++++++++++++++++
>>   mm/Kconfig              | 21 +++++++++++++++++++
>>   mm/huge_memory.c        | 46 ++++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 85 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 0ce86e14ab5e..8e2aa1887309 100644
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
>> index 7748489fde1b..78ebceb61d0e 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -476,6 +476,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
>>
>>   extern struct folio *huge_zero_folio;
>>   extern unsigned long huge_zero_pfn;
>> +extern atomic_t huge_zero_folio_is_static;
> 
> Really don't love having globals like this, please can we have a helper
> function that tells you this and not extern it?
> 
> Also we're not checking CONFIG_STATIC_HUGE_ZERO_FOLIO but still exposing
> this value which a helper function would avoid also.
> 
>>
>>   static inline bool is_huge_zero_folio(const struct folio *folio)
>>   {
>> @@ -494,6 +495,18 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
>>
>>   struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
>>   void mm_put_huge_zero_folio(struct mm_struct *mm);
>> +struct folio *__get_static_huge_zero_folio(void);
> 
> Why are we declaring a static inline function prototype that we then
> implement immediately below?
> 
>> +
>> +static inline struct folio *get_static_huge_zero_folio(void)
>> +{
>> +	if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
>> +		return NULL;
>> +
>> +	if (likely(atomic_read(&huge_zero_folio_is_static)))
>> +		return huge_zero_folio;
>> +
>> +	return __get_static_huge_zero_folio();
>> +}
>>
>>   static inline bool thp_migration_supported(void)
>>   {
>> @@ -685,6 +698,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
>>   {
>>   	return 0;
>>   }
>> +
>> +static inline struct folio *get_static_huge_zero_folio(void)
>> +{
>> +	return NULL;
>> +}
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>
>>   static inline int split_folio_to_list_to_order(struct folio *folio,
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index e443fe8cd6cf..366a6d2d771e 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -823,6 +823,27 @@ config ARCH_WANT_GENERAL_HUGETLB
>>   config ARCH_WANTS_THP_SWAP
>>   	def_bool n
>>
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
>> +	  it is still allocated on demand, but never freed, allowing for more
>> +	  wide-spread use, for example, when performing I/O similar to the
>> +	  traditional shared zeropage.
>> +
>> +	  Not suitable for memory constrained systems.
>> +
>>   config MM_ID
>>   	def_bool n
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index ff06dee213eb..e117b280b38d 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -75,6 +75,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>   static bool split_underused_thp = true;
>>
>>   static atomic_t huge_zero_refcount;
>> +atomic_t huge_zero_folio_is_static __read_mostly;
>>   struct folio *huge_zero_folio __read_mostly;
>>   unsigned long huge_zero_pfn __read_mostly = ~0UL;
>>   unsigned long huge_anon_orders_always __read_mostly;
>> @@ -266,6 +267,45 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
>>   		put_huge_zero_folio();
>>   }
>>
>> +#ifdef CONFIG_STATIC_HUGE_ZERO_FOLIO
>> +
> 
> Extremely tiny silly nit - there's a blank line below this, but not under the
> #endif, let's remove this line.
> 
>> +struct folio *__get_static_huge_zero_folio(void)
>> +{
>> +	static unsigned long fail_count_clear_timer;
>> +	static atomic_t huge_zero_static_fail_count __read_mostly;
>> +
>> +	if (unlikely(!slab_is_available()))
>> +		return NULL;
>> +
>> +	/*
>> +	 * If we failed to allocate a huge zero folio, just refrain from
>> +	 * trying for one minute before retrying to get a reference again.
>> +	 */
>> +	if (atomic_read(&huge_zero_static_fail_count) > 1) {
>> +		if (time_before(jiffies, fail_count_clear_timer))
>> +			return NULL;
>> +		atomic_set(&huge_zero_static_fail_count, 0);
>> +	}
> 
> Yeah I really don't like this. This seems overly complicated and too
> fiddly. Also if I want a static PMD, do I want to wait a minute for next
> attempt?
> 
> Also doing things this way we might end up:
> 
> 0. Enabling CONFIG_STATIC_HUGE_ZERO_FOLIO
> 1. Not doing anything that needs a static PMD for a while + get fragmentation.
> 2. Do something that needs it - oops can't get order-9 page, and waiting 60
>     seconds between attempts
> 3. This is silent so you think you have it switched on but are actually getting
>     bad performance.
> 
> I appreciate wanting to reuse this code, but we need to find a way to do this
> really really early, and get rid of this arbitrary time out. It's very aribtrary
> and we have no easy way of tracing how this might behave under workload.
> 
> Also we end up pinning an order-9 page either way, so no harm in getting it
> first thing?

What we could do, to avoid messing with memblock and two ways of initializing a huge zero folio early, and just disable the shrinker.

Downside is that the page is really static (not just when actually used at least once). I like it:


diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0ce86e14ab5e1..8e2aa18873098 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -153,6 +153,7 @@ config X86
  	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
  	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
  	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO if X86_64
  	select ARCH_HAS_PARANOID_L1D_FLUSH
  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
  	select BUILDTIME_TABLE_SORT
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b7..ccfa5c95f14b1 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -495,6 +495,17 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
  void mm_put_huge_zero_folio(struct mm_struct *mm);
  
+static inline struct folio *get_static_huge_zero_folio(void)
+{
+	if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
+		return NULL;
+
+	if (unlikely(!huge_zero_folio))
+		return NULL;
+
+	return huge_zero_folio;
+}
+
  static inline bool thp_migration_supported(void)
  {
  	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
@@ -685,6 +696,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
  {
  	return 0;
  }
+
+static inline struct folio *get_static_huge_zero_folio(void)
+{
+	return NULL;
+}
  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
  
  static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/mm/Kconfig b/mm/Kconfig
index e443fe8cd6cf2..366a6d2d771e3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -823,6 +823,27 @@ config ARCH_WANT_GENERAL_HUGETLB
  config ARCH_WANTS_THP_SWAP
  	def_bool n
  
+config ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
+	def_bool n
+
+config STATIC_HUGE_ZERO_FOLIO
+	bool "Allocate a PMD sized folio for zeroing"
+	depends on ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO && TRANSPARENT_HUGEPAGE
+	help
+	  Without this config enabled, the huge zero folio is allocated on
+	  demand and freed under memory pressure once no longer in use.
+	  To detect remaining users reliably, references to the huge zero folio
+	  must be tracked precisely, so it is commonly only available for mapping
+	  it into user page tables.
+
+	  With this config enabled, the huge zero folio can also be used
+	  for other purposes that do not implement precise reference counting:
+	  it is allocated statically and never freed, allowing for more
+	  wide-spread use, for example, when performing I/O similar to the
+	  traditional shared zeropage.
+
+	  Not suitable for memory constrained systems.
+
  config MM_ID
  	def_bool n
  
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ff06dee213eb2..f65ba3e6f0824 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -866,9 +866,14 @@ static int __init thp_shrinker_init(void)
  	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
  	shrinker_register(huge_zero_folio_shrinker);
  
-	deferred_split_shrinker->count_objects = deferred_split_count;
-	deferred_split_shrinker->scan_objects = deferred_split_scan;
-	shrinker_register(deferred_split_shrinker);
+	if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO)) {
+		if (!get_huge_zero_folio())
+			pr_warn("Allocating static huge zero folio failed\n");
+	} else {
+		deferred_split_shrinker->count_objects = deferred_split_count;
+		deferred_split_shrinker->scan_objects = deferred_split_scan;
+		shrinker_register(deferred_split_shrinker);
+	}
  
  	return 0;
  }
-- 
2.50.1


Now, one thing I do not like is that we have "ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO" but
then have a user-selectable option.

Should we just get rid of ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO?

-- 
Cheers,

David / dhildenb


