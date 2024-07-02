Return-Path: <linux-fsdevel+bounces-22914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7395491EFDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 09:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B8C1C220CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 07:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59614291E;
	Tue,  2 Jul 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKXWLHBC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE87D405
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719904594; cv=none; b=B9foxtF2fx/qdtbum039QmEMxAs4MAkT/m2NZctztV8bvuixWOVvU5dBfwLogUohaXZLRe9WScZYBCdgYFhC1OHh6F9sdTT0A4lTgHQGXGlK+A0BiG0a4cVgk5cAHXquIg82KaG2FqIsjqQahGl8esQYOaTS/pHt7H/FLeFnV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719904594; c=relaxed/simple;
	bh=hNk8P7frBgquGt6kQACNyumrV+5mP5wFDBGJ2vt/lxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxKljHZHQiv0ZwIa3JDICBYeL3GJFIPJXBaBreuuSWy50WGVr+8lONK2a5iIyfdmtcAPXpTk91ndKRk7FvbMEGD8/N2+sYIlfZ2N/SAXNB3X1326jV4NBv2xtW7mkwNs9qgbKXNE4s0+ghpmOom9Arkv4hh3tvTSRFTa4b4IaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKXWLHBC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719904588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=THPgxYYie/sQY58xXcz3AEaUmfYRCcFXiKgZmNLUlT8=;
	b=PKXWLHBCCIThR74THKXM5yd8Z34GUhJs+9kVvDvuGV3Msi0cLl0cLac1WmG6OwP/5AydSf
	b7TIXGLvDrvNsjVqADHasdeukTZYhIAM24vcGP1g9SWTV5gcaFiJ0L0mhNU+M8sKOKal++
	t4S+3k+o2Z5yhCxF6sqb8yATT1o67ww=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-YP4MAD4oOVOzLJXjSUdbDA-1; Tue, 02 Jul 2024 03:16:26 -0400
X-MC-Unique: YP4MAD4oOVOzLJXjSUdbDA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52cda76173dso3282145e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 00:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719904585; x=1720509385;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=THPgxYYie/sQY58xXcz3AEaUmfYRCcFXiKgZmNLUlT8=;
        b=LA9qw9e6yOjZQJkFUStQGAA5hsoGUKNGjHVGG5Q7kTTcksy2f7dPmoTVUthMqKjWQf
         k7A+a8HWlzITsi+dmCjzwUKyBPKpTs0bPxJ0jk68FbFH5SgRESOWZxxGJoJjGRQXbtW6
         4S4aW0jcZC5rJHMmdPQeh9huSwqNtsxNPeuCTPqK501Llumy2m7kfMzhQayhS06a0Qn+
         VK3vNOVLI4gtEKHiC98MFgXRpwKFf0yZx2i1yfzwq12jzpGubqP1A6uis2Mp+xUrwSA5
         a9kmKY2nGZCZom4bLEqefkrjPVBJwOtiNXGUnxHM8DdeS/Sb9dROZH72LsjyJHXsi20A
         rT/g==
X-Forwarded-Encrypted: i=1; AJvYcCX2aGenGFx9SB7BzJjOngX+hH/W4P3LWZ7YcEUel+/BMXkNptwpq/Q6FR9ciTF/vZ/vqQtGYEIwWIM0ESz6l6cISOVW4Bqve1NtEeRNuA==
X-Gm-Message-State: AOJu0YxPN1Z0PnGARCNIeW482t6lVE03SIT6RvQlAsI32LP9yKt3q0n9
	5MXXDqgpnKWhQU8LayYLwFDFhNs3eae6gEYvvcdPNOh+i5275sBql1P1SV+oZZwpocAqCpSo93q
	M5VNDuUpicapx2TRojkadun0o7rycXGZutuV6oJHSi3Li92fGTHwXFElidsU/GMo=
X-Received: by 2002:a05:6512:b1c:b0:52c:e54e:f84b with SMTP id 2adb3069b0e04-52e82648e0fmr5797425e87.14.1719904584865;
        Tue, 02 Jul 2024 00:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPXrEdPBuf5zhp9prHvkeXcvRHabYz3pU1YFpQpMtW5xNn0ykKqaLHsvOJk0yStaW8FvoIKQ==
X-Received: by 2002:a05:6512:b1c:b0:52c:e54e:f84b with SMTP id 2adb3069b0e04-52e82648e0fmr5797404e87.14.1719904584307;
        Tue, 02 Jul 2024 00:16:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3cf90sm183791075e9.5.2024.07.02.00.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:16:23 -0700 (PDT)
Message-ID: <cf572c69-a754-4d41-b9c4-7a079b25b3c3@redhat.com>
Date: Tue, 2 Jul 2024 09:16:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] huge_memory: Allow mappings of PUD sized pages
To: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca
Cc: catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
 willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com,
 peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com,
 hch@lst.de, david@fromorbit.com
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <bd332b0d3971b03152b3541f97470817c5147b51.1719386613.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bd332b0d3971b03152b3541f97470817c5147b51.1719386613.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.06.24 02:54, Alistair Popple wrote:
> Currently DAX folio/page reference counts are managed differently to
> normal pages. To allow these to be managed the same as normal pages
> introduce dax_insert_pfn_pud. This will map the entire PUD-sized folio
> and take references as it would for a normally mapped page.
> 
> This is distinct from the current mechanism, vmf_insert_pfn_pud, which
> simply inserts a special devmap PUD entry into the page table without
> holding a reference to the page for the mapping.

Do we really have to involve mapcounts/rmap for daxfs pages at this 
point? Or is this only "to make it look more like other pages" ?

I'm asking this because:

(A) We don't support mixing PUD+PMD mappings yet. I have plans to change
     that in the future, but for now you can only map using a single PUD
     or by PTEs. I suspect that's good enoug for now for dax fs?
(B) As long as we have subpage mapcounts, this prevents vmemmap
     optimizations [1]. Is that only used for device-dax for now and are
     there no plans to make use of that for fs-dax?
(C) We managed without so far :)


Having that said, with folio->_large_mapcount things like 
folio_mapcount() are no longer terribly slow once we weould PTE-map a 
PUD-sized folio.

Also, all ZONE_DEVICE pages should currently be marked PG_reserved, 
translating to "don't touch the memmap". I think we might want to tackle 
that first.

[1] https://lwn.net/Articles/860218/
[2] 
https://lkml.kernel.org/r/b0adbb0c-ad59-4bc5-ba0b-0af464b94557@redhat.com

> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   include/linux/huge_mm.h |   4 ++-
>   include/linux/rmap.h    |  14 +++++-
>   mm/huge_memory.c        | 108 ++++++++++++++++++++++++++++++++++++++---
>   mm/rmap.c               |  48 ++++++++++++++++++-
>   4 files changed, 168 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2aa986a..b98a3cc 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   
>   vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>   vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
> +vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>   
>   enum transparent_hugepage_flag {
>   	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
> @@ -106,6 +107,9 @@ extern struct kobj_attribute shmem_enabled_attr;
>   #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
>   #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
>   
> +#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
> +#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
> +
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   
>   extern unsigned long transparent_hugepage_flags;
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 7229b9b..c5a0205 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
>   enum rmap_level {
>   	RMAP_LEVEL_PTE = 0,
>   	RMAP_LEVEL_PMD,
> +	RMAP_LEVEL_PUD,
>   };
>   
>   static inline void __folio_rmap_sanity_checks(struct folio *folio,
> @@ -225,6 +226,13 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
>   		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
>   		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
>   		break;
> +	case RMAP_LEVEL_PUD:
> +		/*
> +		 * Asume that we are creating * a single "entire" mapping of the folio.
> +		 */
> +		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
> +		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
> +		break;
>   	default:
>   		VM_WARN_ON_ONCE(true);
>   	}
> @@ -248,12 +256,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
>   	folio_add_file_rmap_ptes(folio, page, 1, vma)
>   void folio_add_file_rmap_pmd(struct folio *, struct page *,
>   		struct vm_area_struct *);
> +void folio_add_file_rmap_pud(struct folio *, struct page *,
> +		struct vm_area_struct *);
>   void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
>   		struct vm_area_struct *);
>   #define folio_remove_rmap_pte(folio, page, vma) \
>   	folio_remove_rmap_ptes(folio, page, 1, vma)
>   void folio_remove_rmap_pmd(struct folio *, struct page *,
>   		struct vm_area_struct *);
> +void folio_remove_rmap_pud(struct folio *, struct page *,
> +		struct vm_area_struct *);
>   
>   void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>   		unsigned long address, rmap_t flags);
> @@ -338,6 +350,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
>   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>   		break;
>   	case RMAP_LEVEL_PMD:
> +	case RMAP_LEVEL_PUD:
>   		atomic_inc(&folio->_entire_mapcount);
>   		atomic_inc(&folio->_large_mapcount);
>   		break;
> @@ -434,6 +447,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
>   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>   		break;
>   	case RMAP_LEVEL_PMD:
> +	case RMAP_LEVEL_PUD:
>   		if (PageAnonExclusive(page)) {
>   			if (unlikely(maybe_pinned))
>   				return -EBUSY;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index db7946a..e1f053e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1283,6 +1283,70 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
>   	return VM_FAULT_NOPAGE;
>   }
>   EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
> +
> +/**
> + * dax_insert_pfn_pud - insert a pud size pfn backed by a normal page
> + * @vmf: Structure describing the fault
> + * @pfn: pfn of the page to insert
> + * @write: whether it's a write fault
> + *
> + * Return: vm_fault_t value.
> + */
> +vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	unsigned long addr = vmf->address & PUD_MASK;
> +	pud_t *pud = vmf->pud;
> +	pgprot_t prot = vma->vm_page_prot;
> +	struct mm_struct *mm = vma->vm_mm;
> +	pud_t entry;
> +	spinlock_t *ptl;
> +	struct folio *folio;
> +	struct page *page;
> +
> +	if (addr < vma->vm_start || addr >= vma->vm_end)
> +		return VM_FAULT_SIGBUS;
> +
> +	track_pfn_insert(vma, &prot, pfn);
> +
> +	ptl = pud_lock(mm, pud);
> +	if (!pud_none(*pud)) {
> +		if (write) {
> +			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
> +				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
> +				goto out_unlock;
> +			}
> +			entry = pud_mkyoung(*pud);
> +			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
> +			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
> +				update_mmu_cache_pud(vma, addr, pud);
> +		}
> +		goto out_unlock;
> +	}
> +
> +	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
> +	if (pfn_t_devmap(pfn))
> +		entry = pud_mkdevmap(entry);
> +	if (write) {
> +		entry = pud_mkyoung(pud_mkdirty(entry));
> +		entry = maybe_pud_mkwrite(entry, vma);
> +	}
> +
> +	page = pfn_t_to_page(pfn);
> +	folio = page_folio(page);
> +	folio_get(folio);
> +	folio_add_file_rmap_pud(folio, page, vma);
> +	add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
> +
> +	set_pud_at(mm, addr, pud, entry);
> +	update_mmu_cache_pud(vma, addr, pud);
> +
> +out_unlock:
> +	spin_unlock(ptl);
> +
> +	return VM_FAULT_NOPAGE;
> +}
> +EXPORT_SYMBOL_GPL(dax_insert_pfn_pud);
>   #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>   
>   void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
> @@ -1836,7 +1900,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   			zap_deposited_table(tlb->mm, pmd);
>   		spin_unlock(ptl);
>   	} else if (is_huge_zero_pmd(orig_pmd)) {
> -		zap_deposited_table(tlb->mm, pmd);
> +		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
> +			zap_deposited_table(tlb->mm, pmd);
>   		spin_unlock(ptl);
>   	} else {
>   		struct folio *folio = NULL;
> @@ -2268,20 +2333,34 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
>   int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		 pud_t *pud, unsigned long addr)
>   {
> +	pud_t orig_pud;
>   	spinlock_t *ptl;
>   
>   	ptl = __pud_trans_huge_lock(pud, vma);
>   	if (!ptl)
>   		return 0;
>   
> -	pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
> +	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
>   	tlb_remove_pud_tlb_entry(tlb, pud, addr);
> -	if (vma_is_special_huge(vma)) {
> +	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
>   		spin_unlock(ptl);
>   		/* No zero page support yet */
>   	} else {
> -		/* No support for anonymous PUD pages yet */
> -		BUG();
> +		struct page *page = NULL;
> +		struct folio *folio;
> +
> +		/* No support for anonymous PUD pages or migration yet */
> +		BUG_ON(vma_is_anonymous(vma) || !pud_present(orig_pud));
> +
> +		page = pud_page(orig_pud);
> +		folio = page_folio(page);
> +		folio_remove_rmap_pud(folio, page, vma);
> +		VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
> +		VM_BUG_ON_PAGE(!PageHead(page), page);
> +		add_mm_counter(tlb->mm, mm_counter_file(folio), -HPAGE_PUD_NR);
> +
> +		spin_unlock(ptl);
> +		tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
>   	}
>   	return 1;
>   }
> @@ -2289,6 +2368,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>   		unsigned long haddr)
>   {
> +	pud_t old_pud;
> +
>   	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
>   	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
>   	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
> @@ -2296,7 +2377,22 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>   
>   	count_vm_event(THP_SPLIT_PUD);
>   
> -	pudp_huge_clear_flush(vma, haddr, pud);
> +	old_pud = pudp_huge_clear_flush(vma, haddr, pud);
> +	if (is_huge_zero_pud(old_pud))
> +		return;
> +
> +	if (vma_is_dax(vma)) {
> +		struct page *page = pud_page(old_pud);
> +		struct folio *folio = page_folio(page);
> +
> +		if (!folio_test_dirty(folio) && pud_dirty(old_pud))
> +			folio_mark_dirty(folio);
> +		if (!folio_test_referenced(folio) && pud_young(old_pud))
> +			folio_set_referenced(folio);
> +		folio_remove_rmap_pud(folio, page, vma);
> +		folio_put(folio);
> +		add_mm_counter(vma->vm_mm, mm_counter_file(folio), -HPAGE_PUD_NR);
> +	}
>   }
>   
>   void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
> diff --git a/mm/rmap.c b/mm/rmap.c
> index e8fc5ec..e949e4f 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1165,6 +1165,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
>   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>   		break;
>   	case RMAP_LEVEL_PMD:
> +	case RMAP_LEVEL_PUD:
>   		first = atomic_inc_and_test(&folio->_entire_mapcount);
>   		if (first) {
>   			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
> @@ -1306,6 +1307,12 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>   		case RMAP_LEVEL_PMD:
>   			SetPageAnonExclusive(page);
>   			break;
> +		case RMAP_LEVEL_PUD:
> +			/*
> +			 * Keep the compiler happy, we don't support anonymous PUD mappings.
> +			 */
> +			WARN_ON_ONCE(1);
> +			break;
>   		}
>   	}
>   	for (i = 0; i < nr_pages; i++) {
> @@ -1489,6 +1496,26 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>   #endif
>   }
>   
> +/**
> + * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
> + * @folio:	The folio to add the mapping to
> + * @page:	The first page to add
> + * @vma:	The vm area in which the mapping is added
> + *
> + * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
> + *
> + * The caller needs to hold the page table lock.
> + */
> +void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
> +		struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
> +#else
> +	WARN_ON_ONCE(true);
> +#endif
> +}
> +
>   static __always_inline void __folio_remove_rmap(struct folio *folio,
>   		struct page *page, int nr_pages, struct vm_area_struct *vma,
>   		enum rmap_level level)
> @@ -1521,6 +1548,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   		partially_mapped = nr && atomic_read(mapped);
>   		break;
>   	case RMAP_LEVEL_PMD:
> +	case RMAP_LEVEL_PUD:
>   		atomic_dec(&folio->_large_mapcount);
>   		last = atomic_add_negative(-1, &folio->_entire_mapcount);
>   		if (last) {
> @@ -1615,6 +1643,26 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
>   #endif
>   }
>   
> +/**
> + * folio_remove_rmap_pud - remove a PUD mapping from a page range of a folio
> + * @folio:	The folio to remove the mapping from
> + * @page:	The first page to remove
> + * @vma:	The vm area from which the mapping is removed
> + *
> + * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
> + *
> + * The caller needs to hold the page table lock.
> + */
> +void folio_remove_rmap_pud(struct folio *folio, struct page *page,
> +		struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
> +#else
> +	WARN_ON_ONCE(true);
> +#endif
> +}
> +
>   /*
>    * @arg: enum ttu_flags will be passed to this argument
>    */

-- 
Cheers,

David / dhildenb


