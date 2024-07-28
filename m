Return-Path: <linux-fsdevel+bounces-24375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D8693E51F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 14:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFC51C2122E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5963F9FB;
	Sun, 28 Jul 2024 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKSOfRoy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860D2562E;
	Sun, 28 Jul 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722170862; cv=none; b=PqGVS48ehURadkizRablp5RPqRiahrkUPxu5/wDyrjLovCvZoBJd/gh6+oSviI9ZKuoSWoapLk6nF7x5FnjD8iXSsTDwdPIKOepiUbTLkssIJAsVzijr7ELd8NS6cEiGhgviE8oc0fGQ6/HEbMvCdaAUsdreX0ojDV1QGIVdVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722170862; c=relaxed/simple;
	bh=7DAw1bh/7KLG2aowoCQ2qKx/EFyJdeQ1d+TtPaE81w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1G/s40lZWjiHnYTnz6NHWg7e6IXrRHlT85HBS7wGCP1xoS6zDTGdk/UNlY0lxiPGGX/gUYP3Ly1YvH0KgyPxh9yotPLAr1CkOu8UcfGWQWhXt93l7xz1qaC8f9mUHXbHxQleWLPzn5yWa9r+9oapqlZIDk5bz1TFAjfnrF6kpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKSOfRoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1214EC116B1;
	Sun, 28 Jul 2024 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722170862;
	bh=7DAw1bh/7KLG2aowoCQ2qKx/EFyJdeQ1d+TtPaE81w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKSOfRoyAcagm/ZCjuUtmZe1LP1/m3qOMpkt+Ja038rI7l8A3gAIiS9vTlhyRlcph
	 q9W3Gs/md02my2rqjor8RoVRuhKeRng2CLjeuQpPwElHl4VIJ1PE8mhHy3nlfCsgPo
	 diba//3nG7207nq7Hoz29mmSrKFjel41IEd1K+OUbqJ9ji9TOMZcPpMQo+WMhANpud
	 6Q847BLXlRgpdKyKpfoIprH/01r3UrVLIMjJqRG5P1sgBD0Z0nzmDaGOzqSAcDzpJq
	 76zEEQv9n49HVtrhliR31CW/giJaLvR0UAqUXFsYST53aU5H48QgjliObfxaz9+zTj
	 RELQP2y7z3fMw==
Date: Sun, 28 Jul 2024 15:47:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 2/3] mm/hugetlb: enforce that PMD PT sharing has split
 PMD PT locks
Message-ID: <ZqY918UEsmkbIGOn@kernel.org>
References: <20240726150728.3159964-1-david@redhat.com>
 <20240726150728.3159964-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726150728.3159964-3-david@redhat.com>

On Fri, Jul 26, 2024 at 05:07:27PM +0200, David Hildenbrand wrote:
> Sharing page tables between processes but falling back to per-MM page
> table locks cannot possibly work.
> 
> So, let's make sure that we do have split PMD locks by adding a new
> Kconfig option and letting that depend on CONFIG_SPLIT_PMD_PTLOCKS.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  fs/Kconfig              | 4 ++++
>  include/linux/hugetlb.h | 5 ++---
>  mm/hugetlb.c            | 8 ++++----
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a46b0cbc4d8f6..0e4efec1d92e6 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -288,6 +288,10 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>  	depends on SPARSEMEM_VMEMMAP
>  
> +config HUGETLB_PMD_PAGE_TABLE_SHARING
> +	def_bool HUGETLB_PAGE
> +	depends on ARCH_WANT_HUGE_PMD_SHARE && SPLIT_PMD_PTLOCKS
> +
>  config ARCH_HAS_GIGANTIC_PAGE
>  	bool
>  
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index da800e56fe590..4d2f3224ff027 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1243,7 +1243,7 @@ static inline __init void hugetlb_cma_reserve(int order)
>  }
>  #endif
>  
> -#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>  static inline bool hugetlb_pmd_shared(pte_t *pte)
>  {
>  	return page_count(virt_to_page(pte)) > 1;
> @@ -1279,8 +1279,7 @@ bool __vma_private_lock(struct vm_area_struct *vma);
>  static inline pte_t *
>  hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
>  {
> -#if defined(CONFIG_HUGETLB_PAGE) && \
> -	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
> +#if defined(CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING) && defined(CONFIG_LOCKDEP)
>  	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  	/*
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0858a18272073..c4d94e122c41f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7211,7 +7211,7 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>  static unsigned long page_table_shareable(struct vm_area_struct *svma,
>  				struct vm_area_struct *vma,
>  				unsigned long addr, pgoff_t idx)
> @@ -7373,7 +7373,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return 1;
>  }
>  
> -#else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> +#else /* !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
>  
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  		      unsigned long addr, pud_t *pud)
> @@ -7396,7 +7396,7 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	return false;
>  }
> -#endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> +#endif /* CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
>  
>  #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> @@ -7494,7 +7494,7 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
>  /* See description above.  Architectures can provide their own version. */
>  __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>  {
> -#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>  	if (huge_page_size(h) == PMD_SIZE)
>  		return PUD_SIZE - PMD_SIZE;
>  #endif
> -- 
> 2.45.2
> 
> 

-- 
Sincerely yours,
Mike.

