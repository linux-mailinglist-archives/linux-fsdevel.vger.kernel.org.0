Return-Path: <linux-fsdevel+bounces-18114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999F98B5E33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6B1F21D98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A2839EA;
	Mon, 29 Apr 2024 15:55:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2F82D69;
	Mon, 29 Apr 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406133; cv=none; b=fag8Kh1D9c5Cx6mzQpVFnVnkC47TUYO/SGAx3udTxgiygKO+vf9y9w8IjlcMcvNJvRM2XeHQL1v5k+JIei23RWj8ZsTCYOFtSyBvy23crI5A+8qi7mIGDYz1GJ95bFpmPpjGKWUO/fKeicb8JkyibUt4NFQzYzrkDjKRsFwuNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406133; c=relaxed/simple;
	bh=IM2jeP9NfCZ5Zo1PURYVUoe8c5QN3TReQSYYBMTgdgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIVKZ58WRJZ8jsFuDUkgytOAfFSJH4R35dhmNx+S5TVPdxJPcIhc7vkANnUdI/0jDhSy7+EjQaDDA2SVaINLr4Nj37iFfRrN0LaZA7cRdKXuPzuOXrV+rxEoTBjB/TBFqSHCui1/Py9Fi3rif5JgKFELlr7Z184h0EJvn3VtuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C08202F4;
	Mon, 29 Apr 2024 08:55:56 -0700 (PDT)
Received: from [10.57.65.53] (unknown [10.57.65.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FD8A3F73F;
	Mon, 29 Apr 2024 08:55:29 -0700 (PDT)
Message-ID: <5f193f0b-7f41-441e-8f98-09a7ddbf4166@arm.com>
Date: Mon, 29 Apr 2024 16:55:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs/proc/task_mmu: Fix uffd-wp confusion in
 pagemap_scan_pmd_entry()
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240429114104.182890-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240429114104.182890-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 12:41, Ryan Roberts wrote:
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

I guess this should have cc'ed stable but I forgot to add it. Are you able to
fix this up when you take it, Andrew, or do I need to repost?

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


