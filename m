Return-Path: <linux-fsdevel+bounces-16764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A298A23CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 04:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F225C1F23B65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 02:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99012E63;
	Fri, 12 Apr 2024 02:33:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B936125CC
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889188; cv=none; b=iFGzb0djaDfTAHefwcISkAngjwnyEy0WUBCqBI5KrXGlOGKism3v0TCK/5s5svOwWj4x9W63IRjb89r3Cl/+ip8NAZNBqpm8W1r7r5KKYgmI23ypBvhNV4I6VEnklIpXFhdr2Dhr6p/bhZ1z+DD2eqQbF6RwdNEruTNYTkBjX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889188; c=relaxed/simple;
	bh=lAa8YyqTjAZK+Dx7Ry7eFQRXQNC1mXRTh7G8S/+q/5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NDPgq2WPj09QJ3liemmnS3ZLByqV8JY21VxnfMwRClEuJzyxRvcvrSNpcO3RomSCubWIrQ4vk5rHzYmeyH0YIi86U5VD1wGfPgUjoaItYosnSrZ8A9Z5iKrPfODj1iiA0Y0pGvmb+dTVsceOx9tm9KEd+WR0BomJHSjPSshy8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VG0sP65DCz1R5gh;
	Fri, 12 Apr 2024 10:30:17 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 49258140124;
	Fri, 12 Apr 2024 10:33:03 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:33:02 +0800
Message-ID: <53922b32-1bba-45f1-8f4a-5891a74233fa@huawei.com>
Date: Fri, 12 Apr 2024 10:33:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: move mm counter updating out of set_pte_range()
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20240412025704.53245-1-wangkefeng.wang@huawei.com>
 <20240412025704.53245-2-wangkefeng.wang@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240412025704.53245-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/12 10:57, Kefeng Wang wrote:
> In order to support batch mm counter updating in filemap_map_pages(),
> move mm counter updating out of set_pte_range(), the folios are file
> from filemap, and distinguish folios type by vmf->flags and vma->vm_flags
> from another caller finish_fault().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/filemap.c | 4 ++++
>   mm/memory.c  | 8 +++++---
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 92e2d43e4c9d..04b813f0146c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3540,6 +3540,8 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>   skip:
>   		if (count) {
>   			set_pte_range(vmf, folio, page, count, addr);
> +			add_mm_counter(vmf->vma->vm_mm, mm_counter_file(folio),
> +				       count);
>   			folio_ref_add(folio, count);
>   			if (in_range(vmf->address, addr, count * PAGE_SIZE))
>   				ret = VM_FAULT_NOPAGE;
> @@ -3554,6 +3556,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>   
>   	if (count) {
>   		set_pte_range(vmf, folio, page, count, addr);
> +		add_mm_counter(vmf->vma->vm_mm, mm_counter_file(folio), count);
>   		folio_ref_add(folio, count);
>   		if (in_range(vmf->address, addr, count * PAGE_SIZE))
>   			ret = VM_FAULT_NOPAGE;
> @@ -3590,6 +3593,7 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>   		ret = VM_FAULT_NOPAGE;
>   
>   	set_pte_range(vmf, folio, page, 1, addr);
> +	add_mm_counter(vmf->vma->vm_mm, mm_counter_file(folio), 1);
>   	folio_ref_inc(folio);
>   
>   	return ret;
> diff --git a/mm/memory.c b/mm/memory.c
> index 78422d1c7381..69bc63a5d6c8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4685,12 +4685,10 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>   		entry = pte_mkuffd_wp(entry);
>   	/* copy-on-write page */
>   	if (write && !(vma->vm_flags & VM_SHARED)) {
> -		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr);
>   		VM_BUG_ON_FOLIO(nr != 1, folio);
>   		folio_add_new_anon_rmap(folio, vma, addr);
>   		folio_add_lru_vma(folio, vma);
>   	} else {
> -		add_mm_counter(vma->vm_mm, mm_counter_file(folio), nr);
>   		folio_add_file_rmap_ptes(folio, page, nr, vma);
>   	}
>   	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
> @@ -4727,9 +4725,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct page *page;
>   	vm_fault_t ret;
> +	int is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
> +		     !(vma->vm_flags & VM_SHARED);

oops, bool is enough.

>   
>   	/* Did we COW the page? */
> -	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED))
> +	if (is_cow)
>   		page = vmf->cow_page;
>   	else
>   		page = vmf->page;
> @@ -4765,8 +4765,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   	/* Re-check under ptl */
>   	if (likely(!vmf_pte_changed(vmf))) {
>   		struct folio *folio = page_folio(page);
> +		int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
>   
>   		set_pte_range(vmf, folio, page, 1, vmf->address);
> +		add_mm_counter(vma->vm_mm, type, 1);
>   		ret = 0;
>   	} else {
>   		update_mmu_tlb(vma, vmf->address, vmf->pte);

