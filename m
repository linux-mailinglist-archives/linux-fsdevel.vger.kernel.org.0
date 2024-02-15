Return-Path: <linux-fsdevel+bounces-11774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892E18570B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC74B23187
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341921419A9;
	Thu, 15 Feb 2024 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DARco0iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6513B298;
	Thu, 15 Feb 2024 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037331; cv=none; b=Z505DMCScV6sJoGH4Wqz5QfRHgpG3v5BgUIMSrKkHDFoSYHitw7kSzWOBhnRHWIqr4xnrHYEJWczXU7JrTNMnpo1ij1UPZi+r/2+0U/N4WbOApky1G7QQYhmBPYglW//INSqTtz4+yVcVSXe3Ff73tZEVZ0/7vj8QP6lYlomuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037331; c=relaxed/simple;
	bh=O2YipuwbWV1YLastP336dH3q8Zkm6CgW4TI5yh0PFMM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WHPx1FoG366V3821XzheezXPF93ie1i6xihgrFVwPi0kY62swn8u3dJeY5PezE89l+r3JVhCHEGkR57JUyQ7Ypsvlm8nGqCbFFY/Jrcz9fqf68jztXQB6NpnVpjVKiidcqjxFwlc0BdUXD8G4uMRJwQZ4Lirtx4hd1JASR1spvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DARco0iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9DAC433C7;
	Thu, 15 Feb 2024 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708037331;
	bh=O2YipuwbWV1YLastP336dH3q8Zkm6CgW4TI5yh0PFMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DARco0iCdfuae92XExh7ksU1jOCySljoFJvUjTDn6qsullpN+UZD19SQnJFqhMYAZ
	 oOm+fymLMFt8D+F9JZKcJYJsu3fAkB0Xfg6t5w4Y8bHGlrMdP//45q1dE8IjOYoDXb
	 P21Fkvnul+Og6eWw2GUVO+Duw3g99sqJQjsFXikQ=
Date: Thu, 15 Feb 2024 14:48:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand
 <david@redhat.com>, Barry Song <21cnbao@gmail.com>, John Hubbard
 <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/filemap: Allow arch to request folio size for
 exec memory
Message-Id: <20240215144849.aba06863acc08b8ded09a187@linux-foundation.org>
In-Reply-To: <20240215154059.2863126-1-ryan.roberts@arm.com>
References: <20240215154059.2863126-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 15:40:59 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Change the readahead config so that if it is being requested for an
> executable mapping, do a synchronous read of an arch-specified size in a
> naturally aligned manner.

Some nits:

> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1115,6 +1115,18 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
>   */
>  #define arch_wants_old_prefaulted_pte	cpu_has_hw_af
> 
> +/*
> + * Request exec memory is read into pagecache in at least 64K folios. The
> + * trade-off here is performance improvement due to storing translations more
> + * effciently in the iTLB vs the potential for read amplification due to reading

"efficiently"

> + * data from disk that won't be used. The latter is independent of base page
> + * size, so we set a page-size independent block size of 64K. This size can be
> + * contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB entry),
> + * and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base pages are in
> + * use.
> + */
> +#define arch_wants_exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
> +

To my eye, "arch_wants_foo" and "arch_want_foo" are booleans.  Either
this arch wants a particular treatment or it does not want it.

I suggest a better name would be "arch_exec_folio_order".

>  static inline bool pud_sect_supported(void)
>  {
>  	return PAGE_SIZE == SZ_4K;
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index aab227e12493..6cdd145cbbb9 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -407,6 +407,18 @@ static inline bool arch_has_hw_pte_young(void)
>  }
>  #endif
> 
> +#ifndef arch_wants_exec_folio_order
> +/*
> + * Returns preferred minimum folio order for executable file-backed memory. Must
> + * be in range [0, PMD_ORDER]. Negative value implies that the HW has no
> + * preference and mm will not special-case executable memory in the pagecache.
> + */

I think this comment contains material which would be useful above the
other arch_wants_exec_folio_order() implementation - the "must be in
range" part.  So I suggest all this material be incorporated into a
single comment which describes arch_wants_exec_folio_order().  Then
this comment can be removed entirely.  Assume the reader knows to go
seek the other definition for the commentary.

> +static inline int arch_wants_exec_folio_order(void)
> +{
> +	return -1;
> +}
> +#endif
> +
>  #ifndef arch_check_zapped_pte
>  static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
>  					 pte_t pte)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 142864338ca4..7954274de11c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3118,6 +3118,25 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	}
>  #endif
> 
> +	/*
> +	 * Allow arch to request a preferred minimum folio order for executable
> +	 * memory. This can often be beneficial to performance if (e.g.) arm64
> +	 * can contpte-map the folio. Executable memory rarely benefits from
> +	 * read-ahead anyway, due to its random access nature.

"readahead"

> +	 */
> +	if (vm_flags & VM_EXEC) {
> +		int order = arch_wants_exec_folio_order();
> +
> +		if (order >= 0) {
> +			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> +			ra->size = 1UL << order;
> +			ra->async_size = 0;
> +			ractl._index &= ~((unsigned long)ra->size - 1);
> +			page_cache_ra_order(&ractl, ra, order);
> +			return fpin;
> +		}
> +	}
> +
>  	/* If we don't want any read-ahead, don't bother */
>  	if (vm_flags & VM_RAND_READ)
>  		return fpin;


