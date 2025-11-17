Return-Path: <linux-fsdevel+bounces-68705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED91C63839
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9158A35B23B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913D324707;
	Mon, 17 Nov 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj45fOEU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D32882BB;
	Mon, 17 Nov 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374465; cv=none; b=BVSd69+wXpq7DHTDiCdzrsUG+3GiL/XcPsOan2Yxajg2fkjQzUtCeprB45XPkf63FgSZH1r4dtbxqKAM9pat9gIJiX/ONoeEgk89zZ24L0lJS+jVly2ZpZxb9CEWgizAQTxzuGLLK9RYA1nsn8/36/vY70JGnbhttPabpg7CVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374465; c=relaxed/simple;
	bh=EBfzAfm80HruebuGq2p7cOO/sNrPnXAIz69VkAF8qRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrpuhCXPL9Q8OPLtkbry7iCe5TqAzbGaJX0Lu/QoyPe83Hcs4Eoozk3nFsQ7zGKjg6FF4AitXBBRDQc3q5sRnzKPQmNSePEMGarz30ssD/vxHrniIj5Ztv0WuAB9Cn0Izth5tWeYt0BVeVOEqKzJMFChJjNO8dkNrKJsneMXMeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj45fOEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE50FC19425;
	Mon, 17 Nov 2025 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763374465;
	bh=EBfzAfm80HruebuGq2p7cOO/sNrPnXAIz69VkAF8qRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xj45fOEUh1b4zxSnuffzv/I652kMh8I1mGK/g9DiGY1P+OpG5UGAfjIYotdBU9Syd
	 kjeGSbhNhewRynba4fT0Dnb4Z90P2Z5QgKN9pANo3fVipvwzL3dVbAV+VHF+Nx+M4H
	 LCqSUvA33EbgaNqvcTdRaDQfY9aFmbarjcKuW58f2UkZVzWH38FdApKDB6GOkKKHPc
	 GI32lOu2/CcojdQx7HGuVbVTKzKVsykpEbo6fOCEF0TrQN66OVP2Kt555LAvcM+dJt
	 gF+RvTLz3jF8uFpYRGcwF7cufr2udpC7X/OslgFQKRSjh1cvwwcj2B53ESd2bkFSNp
	 eC4X1HNOyFmow==
Date: Mon, 17 Nov 2025 12:14:03 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v6 13/20] mm: shmem: export some functions to internal.h
Message-ID: <aRr1aw45EYSFTCw9@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-14-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-14-pasha.tatashin@soleen.com>

On Sat, Nov 15, 2025 at 06:33:59PM -0500, Pasha Tatashin wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> shmem_inode_acct_blocks(), shmem_recalc_inode(), and
> shmem_add_to_page_cache() are used by shmem_alloc_and_add_folio(). This
> functionality will also be used in the future by Live Update
> Orchestrator (LUO) to recreate memfd files after a live update.

I'd rephrase this a bit to say that it will be used by memfd integration
into LUO to emphasize this stays inside mm.

Other than that

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> 
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/internal.h |  6 ++++++
>  mm/shmem.c    | 10 +++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 1561fc2ff5b8..4ba155524f80 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1562,6 +1562,12 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
>  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>  			  int priority);
>  
> +int shmem_add_to_page_cache(struct folio *folio,
> +			    struct address_space *mapping,
> +			    pgoff_t index, void *expected, gfp_t gfp);
> +int shmem_inode_acct_blocks(struct inode *inode, long pages);
> +bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped);
> +
>  #ifdef CONFIG_SHRINKER_DEBUG
>  static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
>  			struct shrinker *shrinker, const char *fmt, va_list ap)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 05c3db840257..c3dc4af59c14 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -219,7 +219,7 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
>  		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
>  }
>  
> -static int shmem_inode_acct_blocks(struct inode *inode, long pages)
> +int shmem_inode_acct_blocks(struct inode *inode, long pages)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> @@ -435,7 +435,7 @@ static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
>   *
>   * Return: true if swapped was incremented from 0, for shmem_writeout().
>   */
> -static bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
> +bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
>  {
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	bool first_swapped = false;
> @@ -861,9 +861,9 @@ static void shmem_update_stats(struct folio *folio, int nr_pages)
>  /*
>   * Somewhat like filemap_add_folio, but error if expected item has gone.
>   */
> -static int shmem_add_to_page_cache(struct folio *folio,
> -				   struct address_space *mapping,
> -				   pgoff_t index, void *expected, gfp_t gfp)
> +int shmem_add_to_page_cache(struct folio *folio,
> +			    struct address_space *mapping,
> +			    pgoff_t index, void *expected, gfp_t gfp)
>  {
>  	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
>  	unsigned long nr = folio_nr_pages(folio);
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

-- 
Sincerely yours,
Mike.

