Return-Path: <linux-fsdevel+bounces-56521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96396B1853E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF38B1C83637
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E448B27AC35;
	Fri,  1 Aug 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ6bKTLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF527A92B
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063359; cv=none; b=DuLdEs6H7ZyyxTMKfztULynaMvpv4DRbiwV/dPiIqzEwekWkES5OuiCa2myU7lpIufLZzgPHzGxItwrtNn8RbR93c8QiQ7UrydLnpYGm5AZyMb7NXWW9pPkIPUQJQGDWrmpLTDu/MKkwcx3av+be/EBjzv2pxZTH4cLdHOxi6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063359; c=relaxed/simple;
	bh=XU5p7WZyqh3uP1O0X5Eh4WB92edzlxU/5ueYZy2GNkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4Sz2RUFwb3ld/8+0/jAOzMF+RO4LQSzXq3i2OS07HmMD02fU1lQxvXRYCc1L70Utu0XHtkNTpU9F6j1oxXyrmpzfAjIA4btjpsQ2ffd2So6q2QeJq0Bn/HWMhuhbGzOPtHFfkJUwQIFETnV82Q+trAv/tBDcE195h3Bd8zS40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KZ6bKTLA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754063356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Az/lcHresqK+moKhYaM464MNdTcCwiYM0QUDNB9aXcU=;
	b=KZ6bKTLAnQV9yl8LCJA/Y/QnHaBwIIXdX9rSybYCHff26kyxBrnUA2OCZVWjMl7ivuLohe
	/1m6cK7oRS7kxsS67oR3Q9eC7VMAlfYKCJI8Ulvs2rFpMtfpah7mnew3zhCFjiNSBakabb
	N661wbrXFdmdReScYVEI3jGlRc0RKBo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-JLqTxj6JOMCQ9CuQBP4AoQ-1; Fri, 01 Aug 2025 11:49:15 -0400
X-MC-Unique: JLqTxj6JOMCQ9CuQBP4AoQ-1
X-Mimecast-MFC-AGG-ID: JLqTxj6JOMCQ9CuQBP4AoQ_1754063354
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b79ad7b8a5so1556007f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 08:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754063354; x=1754668154;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Az/lcHresqK+moKhYaM464MNdTcCwiYM0QUDNB9aXcU=;
        b=UOqJ7D7UWqyepakIU+YFS+t1yvCqtks+RS5mfjlrbKSuOsD3XqMnpfe21gcEvNvy3M
         uYQokKqeUltpdUmM1hLxidsZO3MUbh7l5KYu0c9RiHZYQNjvs40umlWhRARjErSd3WnZ
         Vz6lpIUWf7glHc4T91sgD0oDMSeNVpl0fYnqfc0tITqAya1l9XEus1YPWWYRVUyEiIP3
         SBi4FszZrmJsq6T1Ua+d2YIUg4OCmOVBM16MDGAY9JyW54hbGlAH6Fa2Y9sLNOJamDrl
         dJDKiZPGulzPbKN3JEm9s8SASOls3Lt8tmAKBDUvMGR8xJSybPNcsvV4t1VQfQ0Cp54k
         bL0A==
X-Forwarded-Encrypted: i=1; AJvYcCVn5nra+SzHwBb9lF0jRD/ME1N3fKX/pP6Bl+0BkXID54+xSZI+4IXVWsbx7cVSYnH/PJ9ASUnfVm1n7IKd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf92VyCS8jTlUIQcw0Q8s1Z+b0ZSsEZL+e1pRpkNNbb1w0AqYs
	O8qmmeM9iLnUqHZPEI32FUyRsH4OrUKCM0648UJj59zY6wInsO1gZ5f4SzVPSDTN5Eaova2VVRy
	4Ddu89PpeLgWjJqFr8hDdoDYom4SmBxqY8IhOPGQXmajXv7mvnJdcRFmXnfwkzr5BISI=
X-Gm-Gg: ASbGncu2ZnqQw5W6sE8VI1ZGoluN9BCrRuAgB4P/D1wavFkMdnZb7qVRDV/SBLwSFbS
	XZCLNLnJAzhN36IdMUWiz1GygMMTnt+sCp3Dliozon/cBmTX53WrAF4JQGjFgtlfAOAgVnnDBZI
	tVX6jpu8M6DqiJTuUXbY+dEb4bimmdX3o+Hh/5KnhQm7LMn08dBHwpXnfLH/8fqqYOgrGEzL705
	hu1z3vxMDuClFBQLU/+JlYNNQ9im0BDSRCDZNk9tyba1pzygNCQ/pOBSGVUQX+Qz5ESZ8qSKtex
	VjxTWnNpUVp0gKdWt8jdU1y7Zc5B9e546/BaNOzE6XNaYXfXVqRvIHj04M2r5VCWSar3I1psJhp
	+uuXr9K5Momnf9HNSyGLVqUToQfyR6+GbVl5OiBh3Yc6cYfZXEYcqvEZ68OBPbZBr
X-Received: by 2002:a5d:5d0e:0:b0:3b7:89c2:464b with SMTP id ffacd0b85a97d-3b8d946ac69mr243868f8f.5.1754063353682;
        Fri, 01 Aug 2025 08:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2DBedDYQ23+gwq7i61urTwz0CARF2LptKXy1Zi0AMl+j8e9WYtV69W+oHsDf1pQvk2OOq0w==
X-Received: by 2002:a5d:5d0e:0:b0:3b7:89c2:464b with SMTP id ffacd0b85a97d-3b8d946ac69mr243821f8f.5.1754063353088;
        Fri, 01 Aug 2025 08:49:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4818c1sm6216272f8f.65.2025.08.01.08.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 08:49:12 -0700 (PDT)
Message-ID: <d8899e72-5735-4779-9222-5f27f8c16b80@redhat.com>
Date: Fri, 1 Aug 2025 17:49:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/4] mm: add static huge zero folio
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250724145001.487878-1-kernel@pankajraghav.com>
 <20250724145001.487878-3-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250724145001.487878-3-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 16:49, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
> 
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of single bvec.
> 
> This concern was raised during the review of adding LBS support to
> XFS[1][2].
> 
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive. And, one of the main point that came during discussion
> is to have something bigger than zero page as a drop-in replacement.
> 
> Add a config option STATIC_HUGE_ZERO_FOLIO that will always allocate

"... will result in allocating the huge zero folio on first request, if not already allocated, and turn it static such that it can never get freed."

> the huge_zero_folio, and it will never drop the reference. This makes
> using the huge_zero_folio without having to pass any mm struct and does
> not tie the lifetime of the zero folio to anything, making it a drop-in
> replacement for ZERO_PAGE.
> 
> If STATIC_HUGE_ZERO_FOLIO config option is enabled, then
> mm_get_huge_zero_folio() will simply return this page instead of
> dynamically allocating a new PMD page.
> 
> This option can waste memory in small systems or systems with 64k base
> page size. So make it an opt-in and also add an option from individual
> architecture so that we don't enable this feature for larger base page
> size systems.
> > [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
> [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
> 
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   arch/x86/Kconfig        |  1 +
>   include/linux/huge_mm.h | 18 ++++++++++++++++++
>   mm/Kconfig              | 21 +++++++++++++++++++++
>   mm/huge_memory.c        | 42 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 82 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0ce86e14ab5e..8e2aa1887309 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -153,6 +153,7 @@ config X86
>   	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
>   	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
>   	select ARCH_WANTS_THP_SWAP		if X86_64
> +	select ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO if X86_64
>   	select ARCH_HAS_PARANOID_L1D_FLUSH
>   	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>   	select BUILDTIME_TABLE_SORT
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..78ebceb61d0e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -476,6 +476,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
>   
>   extern struct folio *huge_zero_folio;
>   extern unsigned long huge_zero_pfn;
> +extern atomic_t huge_zero_folio_is_static;
>   
>   static inline bool is_huge_zero_folio(const struct folio *folio)
>   {
> @@ -494,6 +495,18 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
>   
>   struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
>   void mm_put_huge_zero_folio(struct mm_struct *mm);
> +struct folio *__get_static_huge_zero_folio(void);
> +
> +static inline struct folio *get_static_huge_zero_folio(void)
> +{
> +	if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
> +		return NULL;
> +
> +	if (likely(atomic_read(&huge_zero_folio_is_static)))
> +		return huge_zero_folio;
> +
> +	return __get_static_huge_zero_folio();
> +}
>   
>   static inline bool thp_migration_supported(void)
>   {
> @@ -685,6 +698,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
>   {
>   	return 0;
>   }
> +
> +static inline struct folio *get_static_huge_zero_folio(void)
> +{
> +	return NULL;
> +}
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   
>   static inline int split_folio_to_list_to_order(struct folio *folio,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0287e8d94aea..e2132fcf2ccb 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -835,6 +835,27 @@ config ARCH_WANT_GENERAL_HUGETLB
>   config ARCH_WANTS_THP_SWAP
>   	def_bool n
>   
> +config ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
> +	def_bool n
> +
> +config STATIC_HUGE_ZERO_FOLIO
> +	bool "Allocate a PMD sized folio for zeroing"
> +	depends on ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO && TRANSPARENT_HUGEPAGE
> +	help
> +	  Without this config enabled, the huge zero folio is allocated on
> +	  demand and freed under memory pressure once no longer in use.
> +	  To detect remaining users reliably, references to the huge zero folio
> +	  must be tracked precisely, so it is commonly only available for mapping
> +	  it into user page tables.
> +
> +	  With this config enabled, the huge zero folio can also be used
> +	  for other purposes that do not implement precise reference counting:
> +	  it is still allocated on demand, but never freed, allowing for more
> +	  wide-spread use, for example, when performing I/O similar to the
> +	  traditional shared zeropage.
> +
> +	  Not suitable for memory constrained systems.
> +
>   config MM_ID
>   	def_bool n
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5d8365d1d3e9..c160c37f4d31 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -75,6 +75,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   static bool split_underused_thp = true;
>   
>   static atomic_t huge_zero_refcount;
> +atomic_t huge_zero_folio_is_static __read_mostly;
>   struct folio *huge_zero_folio __read_mostly;
>   unsigned long huge_zero_pfn __read_mostly = ~0UL;
>   unsigned long huge_anon_orders_always __read_mostly;
> @@ -266,6 +267,47 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
>   		put_huge_zero_page();
>   }
>   
> +#ifdef CONFIG_STATIC_HUGE_ZERO_FOLIO
> +#define FAIL_COUNT_LIMIT 2
> +
> +struct folio *__get_static_huge_zero_folio(void)
> +{
> +	static unsigned long fail_count_clear_timer;
> +	static atomic_t huge_zero_static_fail_count __read_mostly;
> +
> +	if (unlikely(!slab_is_available()))
> +		return NULL;
> +
> +	/*
> +	 * If we failed to allocate a huge zero folio multiple times,
> +	 * just refrain from trying for one minute before retrying to get
> +	 * a reference again.
> +	 */

Is this "try twice" really worth it? Just try once, and if it fails, try only again in the future.

I guess we'll learn how that will behave in practice, and how we'll have to fine-tune it :)


In shrink_huge_zero_page_scan(), should we probably warn if something buggy happens?

Something like

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b4ea5a2ce7d2..b1109f8699a24 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -277,7 +277,11 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
                                        struct shrink_control *sc)
  {
         if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-               struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
+               struct folio *zero_folio;
+
+               if (WARN_ON_ONCE(atomic_read(&huge_zero_folio_is_static)))
+                       return 0;
+               zero_folio = xchg(&huge_zero_folio, NULL);
                 BUG_ON(zero_folio == NULL);
                 WRITE_ONCE(huge_zero_pfn, ~0UL);
                 folio_put(zero_folio);


-- 
Cheers,

David / dhildenb


