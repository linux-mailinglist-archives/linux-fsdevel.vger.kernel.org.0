Return-Path: <linux-fsdevel+bounces-18106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578AE8B59E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 15:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E11C24477
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D46E5EF;
	Mon, 29 Apr 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gjh+jVlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3A56768;
	Mon, 29 Apr 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397276; cv=none; b=Fjd6+4FczwdbuP0piPczTrTyMjFRaIjOSxOmLk38h6jrexHcQWXW8iGVALnOoFZHrvGG+7FjvrM4SsmHguRTylYs+9xI8uL9SeIEsZe5dQmTPISS0qwGi2wOv/xwrhhSLqIatiJ7RACOO/pKt5wcJTsnec2iMtNaYjBsigC1c/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397276; c=relaxed/simple;
	bh=uu+beZKI3o95LC0DBDGmU+b7eBp2cD9rZyXroXh6L0Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=owqfQiOddXpaxg/gPycMKQANUJP7H59UdIMJ3m/AIUi80BegGvUJ71E0ViJBYPz0huBe/1lOLdfCGya5v6C9ii878coQh4OBZWPPaXKvuPtmPT7tY0DJVO7IZmIAaDhPrAo1hCMaISXFr3SefYQO56oyOo4SLF7mK3mS94bUYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gjh+jVlS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714397273;
	bh=uu+beZKI3o95LC0DBDGmU+b7eBp2cD9rZyXroXh6L0Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Gjh+jVlSPSai+JANWfpL6b2N4ly11fetxM6hx+ZDtsVQn+yrw8y7tDYNDvvSJ7nkf
	 PcTe/2BBdENnU8q4wsJS8VpIaOs2AVGiUEgZGp/qr1pjqqDCNljRYYRR3nxOHRvmQJ
	 QlqwiLxJgd4RfYjnrwandAcui3TlV4gjhaMk/Lghva32zDQt6TAg3IYjJAGpVzcnQs
	 FPuTxUgC2o1NQLYp3o0zeSlo1fIq/thKXduGYYLjrf4+pXpPwR9YWRfcWlIaZW5ztY
	 eCLm/Rs/dTFCa3mjMf2Rrr2RR0hRZylvmSmMAQfugxw3o7eIiNCoQ/hMqaiDgMvg5D
	 ecyr7i8gzrCEQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2F3C53780C22;
	Mon, 29 Apr 2024 13:27:50 +0000 (UTC)
Message-ID: <256aa75f-abaa-45b5-8615-537e50a5077a@collabora.com>
Date: Mon, 29 Apr 2024 18:28:20 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] fs/proc/task_mmu: Fix uffd-wp confusion in
 pagemap_scan_pmd_entry()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20240429114104.182890-1-ryan.roberts@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240429114104.182890-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for finding and fixing Ryan!

On 4/29/24 4:41 PM, Ryan Roberts wrote:
> pagemap_scan_pmd_entry() checks if uffd-wp is set on each pte to avoid
> unnecessary if set. However it was previously checking with
> `pte_uffd_wp(ptep_get(pte))` without first confirming that the pte was
> present. It is only valid to call pte_uffd_wp() for present ptes. For
> swap ptes, pte_swp_uffd_wp() must be called because the uffd-wp bit may
> be kept in a different position, depending on the arch.
> 
> This was leading to test failures in the pagemap_ioctl mm selftest, when
> bringing up uffd-wp support on arm64 due to incorrectly interpretting
> the uffd-wp status of migration entries.
> 
> Let's fix this by using the correct check based on pte_present(). While
> we are at it, let's pass the pte to make_uffd_wp_pte() to avoid the
> pointless extra ptep_get() which can't be optimized out due to
> READ_ONCE() on many arches.
> 
> Closes: https://lore.kernel.org/linux-arm-kernel/ZiuyGXt0XWwRgFh9@x1n/
> Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  fs/proc/task_mmu.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index af4bc1da0c01..102f48668c35 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1817,10 +1817,8 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
>  }
> 
>  static void make_uffd_wp_pte(struct vm_area_struct *vma,
> -			     unsigned long addr, pte_t *pte)
> +			     unsigned long addr, pte_t *pte, pte_t ptent)
>  {
> -	pte_t ptent = ptep_get(pte);
> -
>  	if (pte_present(ptent)) {
>  		pte_t old_pte;
> 
> @@ -2175,9 +2173,12 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>  	if ((p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out) {
>  		/* Fast path for performing exclusive WP */
>  		for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
> -			if (pte_uffd_wp(ptep_get(pte)))
> +			pte_t ptent = ptep_get(pte);
> +
> +			if ((pte_present(ptent) && pte_uffd_wp(ptent)) ||
> +			    pte_swp_uffd_wp_any(ptent))
>  				continue;
> -			make_uffd_wp_pte(vma, addr, pte);
> +			make_uffd_wp_pte(vma, addr, pte, ptent);
>  			if (!flush_end)
>  				start = addr;
>  			flush_end = addr + PAGE_SIZE;
> @@ -2190,8 +2191,10 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>  	    p->arg.return_mask == PAGE_IS_WRITTEN) {
>  		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
>  			unsigned long next = addr + PAGE_SIZE;
> +			pte_t ptent = ptep_get(pte);
> 
> -			if (pte_uffd_wp(ptep_get(pte)))
> +			if ((pte_present(ptent) && pte_uffd_wp(ptent)) ||
> +			    pte_swp_uffd_wp_any(ptent))
>  				continue;
>  			ret = pagemap_scan_output(p->cur_vma_category | PAGE_IS_WRITTEN,
>  						  p, addr, &next);
> @@ -2199,7 +2202,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>  				break;
>  			if (~p->arg.flags & PM_SCAN_WP_MATCHING)
>  				continue;
> -			make_uffd_wp_pte(vma, addr, pte);
> +			make_uffd_wp_pte(vma, addr, pte, ptent);
>  			if (!flush_end)
>  				start = addr;
>  			flush_end = next;
> @@ -2208,8 +2211,9 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>  	}
> 
>  	for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
> +		pte_t ptent = ptep_get(pte);
>  		unsigned long categories = p->cur_vma_category |
> -					   pagemap_page_category(p, vma, addr, ptep_get(pte));
> +					   pagemap_page_category(p, vma, addr, ptent);
>  		unsigned long next = addr + PAGE_SIZE;
> 
>  		if (!pagemap_scan_is_interesting_page(categories, p))
> @@ -2224,7 +2228,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>  		if (~categories & PAGE_IS_WRITTEN)
>  			continue;
> 
> -		make_uffd_wp_pte(vma, addr, pte);
> +		make_uffd_wp_pte(vma, addr, pte, ptent);
>  		if (!flush_end)
>  			start = addr;
>  		flush_end = next;
> --
> 2.25.1
> 

-- 
BR,
Muhammad Usama Anjum

