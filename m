Return-Path: <linux-fsdevel+bounces-48615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4DAB15E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5D717C03B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BEE2918EB;
	Fri,  9 May 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPga8wPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE615E96;
	Fri,  9 May 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798751; cv=none; b=SSKvg+J1fqQDdnSs3Ymthi9YHE+k9du0IftkDJ5r5VDdExvpz2+MfgyyGPenXzoPkB3JmXqIeOqottO3h78XvAt7O7MgCCjoCJ3sFbRNshdymmZavFVkXMlAZhj/RgkaVgmFcMJsL1YyD49Pd9nfnBfm3NaXl2s4cirSqBCxSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798751; c=relaxed/simple;
	bh=08z/fA4ndGXl+5Zu9henL1jr4DrNeoyJNAHGe5fOiKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+f1MX5zqi/SNKrU6f2uGq61oOpNvAkQH4fetWg14Fo+8qsksF/n69KnkVpcsZ1zsHMDvf6X/i+fCcrQ1RDa01Sxzur0TkDQh7tbqVIA2gZvNjPAI3vLYbBphVRLGd900ft1OFBYGDJqkMKjSJVQ8MT9svXLzzEGmKovSGC5k4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPga8wPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3F8C4CEE4;
	Fri,  9 May 2025 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746798750;
	bh=08z/fA4ndGXl+5Zu9henL1jr4DrNeoyJNAHGe5fOiKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPga8wPk30SBCjyT2PEUpAYxWoTbCCCa51yC3+AyjqVwUqmbgf8l5BZGzU50nqgKO
	 T/SbQqEFoNjRGxPWMrUpgxEAUiuavHUVGS9kV4yQEJ/XhIdS89Bc2EN2IArxQcAxwJ
	 +rcfywS+2pEzDvkl2yjYifY85o+FKATLxPkT6cuVESvyw7VmGs13D6MI7YEVWlcuvc
	 T99kz01ZuvAObUCGDlslJ4D7PEfNSa98Yw9ZX+FGfp1Eq4BfgUUEg8RBWOD981D2C0
	 qRZYPd1NmVpZ0b+Enh2uKqfOKs3j90id1gG9RjeCtFUuGpabtO/JLz3TOUX+gre7ja
	 LB9GEVxkaxeog==
Date: Fri, 9 May 2025 14:52:24 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 5/5] mm/filemap: Allow arch to request folio size
 for exec memory
Message-ID: <20250509135223.GB5707@willie-the-truck>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-6-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430145920.3748738-6-ryan.roberts@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 30, 2025 at 03:59:18PM +0100, Ryan Roberts wrote:
> Change the readahead config so that if it is being requested for an
> executable mapping, do a synchronous read into a set of folios with an
> arch-specified order and in a naturally aligned manner. We no longer
> center the read on the faulting page but simply align it down to the
> previous natural boundary. Additionally, we don't bother with an
> asynchronous part.
> 
> On arm64 if memory is physically contiguous and naturally aligned to the
> "contpte" size, we can use contpte mappings, which improves utilization
> of the TLB. When paired with the "multi-size THP" feature, this works
> well to reduce dTLB pressure. However iTLB pressure is still high due to
> executable mappings having a low likelihood of being in the required
> folio size and mapping alignment, even when the filesystem supports
> readahead into large folios (e.g. XFS).
> 
> The reason for the low likelihood is that the current readahead
> algorithm starts with an order-0 folio and increases the folio order by
> 2 every time the readahead mark is hit. But most executable memory tends
> to be accessed randomly and so the readahead mark is rarely hit and most
> executable folios remain order-0.
> 
> So let's special-case the read(ahead) logic for executable mappings. The
> trade-off is performance improvement (due to more efficient storage of
> the translations in iTLB) vs potential for making reclaim more difficult
> (due to the folios being larger so if a part of the folio is hot the
> whole thing is considered hot). But executable memory is a small portion
> of the overall system memory so I doubt this will even register from a
> reclaim perspective.
> 
> I've chosen 64K folio size for arm64 which benefits both the 4K and 16K
> base page size configs. Crucially the same amount of data is still read
> (usually 128K) so I'm not expecting any read amplification issues. I
> don't anticipate any write amplification because text is always RO.
> 
> Note that the text region of an ELF file could be populated into the
> page cache for other reasons than taking a fault in a mmapped area. The
> most common case is due to the loader read()ing the header which can be
> shared with the beginning of text. So some text will still remain in
> small folios, but this simple, best effort change provides good
> performance improvements as is.
> 
> Confine this special-case approach to the bounds of the VMA. This
> prevents wasting memory for any padding that might exist in the file
> between sections. Previously the padding would have been contained in
> order-0 folios and would be easy to reclaim. But now it would be part of
> a larger folio so more difficult to reclaim. Solve this by simply not
> reading it into memory in the first place.
> 
> Benchmarking
> ============
> TODO: NUMBERS ARE FOR V3 OF SERIES. NEED TO RERUN FOR THIS VERSION.
> 
> The below shows nginx and redis benchmarks on Ampere Altra arm64 system.
> 
> First, confirmation that this patch causes more text to be contained in
> 64K folios:
> 
> | File-backed folios     |   system boot   |      nginx      |      redis      |
> | by size as percentage  |-----------------|-----------------|-----------------|
> | of all mapped text mem | before |  after | before |  after | before |  after |
> |========================|========|========|========|========|========|========|
> | base-page-4kB          |    26% |     9% |    27% |     6% |    21% |     5% |
> | thp-aligned-8kB        |     4% |     2% |     3% |     0% |     4% |     1% |
> | thp-aligned-16kB       |    57% |    21% |    57% |     6% |    54% |    10% |
> | thp-aligned-32kB       |     4% |     1% |     4% |     1% |     3% |     1% |
> | thp-aligned-64kB       |     7% |    65% |     8% |    85% |     9% |    72% |
> | thp-aligned-2048kB     |     0% |     0% |     0% |     0% |     7% |     8% |
> | thp-unaligned-16kB     |     1% |     1% |     1% |     1% |     1% |     1% |
> | thp-unaligned-32kB     |     0% |     0% |     0% |     0% |     0% |     0% |
> | thp-unaligned-64kB     |     0% |     0% |     0% |     1% |     0% |     1% |
> | thp-partial            |     1% |     1% |     0% |     0% |     1% |     1% |
> |------------------------|--------|--------|--------|--------|--------|--------|
> | cont-aligned-64kB      |     7% |    65% |     8% |    85% |    16% |    80% |
> 
> The above shows that for both workloads (each isolated with cgroups) as
> well as the general system state after boot, the amount of text backed
> by 4K and 16K folios reduces and the amount backed by 64K folios
> increases significantly. And the amount of text that is contpte-mapped
> significantly increases (see last row).
> 
> And this is reflected in performance improvement:
> 
> | Benchmark                                     |          Improvement |
> +===============================================+======================+
> | pts/nginx (200 connections)                   |                8.96% |
> | pts/nginx (1000 connections)                  |                6.80% |
> +-----------------------------------------------+----------------------+
> | pts/redis (LPOP, 50 connections)              |                5.07% |
> | pts/redis (LPUSH, 50 connections)             |                3.68% |
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h |  8 +++++++
>  include/linux/pgtable.h          | 11 +++++++++
>  mm/filemap.c                     | 40 ++++++++++++++++++++++++++------
>  3 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2a77f11b78d5..9eb35af0d3cf 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1537,6 +1537,14 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
>   */
>  #define arch_wants_old_prefaulted_pte	cpu_has_hw_af
>  
> +/*
> + * Request exec memory is read into pagecache in at least 64K folios. This size
> + * can be contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB
> + * entry), and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base
> + * pages are in use.
> + */
> +#define exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
> +
>  static inline bool pud_sect_supported(void)
>  {
>  	return PAGE_SIZE == SZ_4K;
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index b50447ef1c92..1dd539c49f90 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -456,6 +456,17 @@ static inline bool arch_has_hw_pte_young(void)
>  }
>  #endif
>  
> +#ifndef exec_folio_order
> +/*
> + * Returns preferred minimum folio order for executable file-backed memory. Must
> + * be in range [0, PMD_ORDER). Default to order-0.
> + */
> +static inline unsigned int exec_folio_order(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #ifndef arch_check_zapped_pte
>  static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
>  					 pte_t pte)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index e61f374068d4..37fe4a55c00d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3252,14 +3252,40 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	if (mmap_miss > MMAP_LOTSAMISS)
>  		return fpin;
>  
> -	/*
> -	 * mmap read-around
> -	 */
>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> -	ra->size = ra->ra_pages;
> -	ra->async_size = ra->ra_pages / 4;
> -	ra->order = 0;
> +	if (vm_flags & VM_EXEC) {
> +		/*
> +		 * Allow arch to request a preferred minimum folio order for
> +		 * executable memory. This can often be beneficial to
> +		 * performance if (e.g.) arm64 can contpte-map the folio.
> +		 * Executable memory rarely benefits from readahead, due to its
> +		 * random access nature, so set async_size to 0.

In light of this observation (about randomness of instruction fetch), do
you think it's worth ignoring VM_RAND_READ for VM_EXEC?

Either way, I was looking at this because it touches arm64 and it looks
fine to me:

Acked-by: Will Deacon <will@kernel.org>

Will

