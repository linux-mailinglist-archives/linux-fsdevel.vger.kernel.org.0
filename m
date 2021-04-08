Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03929358EFF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 23:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhDHVKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 17:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhDHVKp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:10:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9496C61181;
        Thu,  8 Apr 2021 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617916233;
        bh=6cyexa/jJS9YlQ5KjgH5H7k3BZIre76aRfBUVZDdGDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaftSOrhzXcAZ8pHdaGjwQG89icGigZ83+rHNhrTa8mlbwUrF2f18dl0HHKyG61Nc
         whEeGwxLN1FPz9ejfHYNn3bcnqKER3F/kLoaF4McsLEEuxlcixWW352DSZM4AJWi5Y
         sMrnsK9ewcxAilxb0nJszao3sBkxaqq+5hN3XaeM3mPm0NdrZ/CosmboGvx3aezXOU
         8TyOlD91oGiOgAGjYpt3r3/SF+qIfGKzKYCNtAhzOMkNHLk1DX7XDLXEna93Q1TJbV
         OnoMOjgoPcdS42273VthX70IBY1fB1XPpTPrec15+3h3IcRDqWQm+CD7fFsAbbiNBx
         OPE1AT0lQlFAQ==
Date:   Thu, 8 Apr 2021 14:10:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] fsdax: Factor helper: dax_fault_actor()
Message-ID: <20210408211032.GX3957620@magnolia>
References: <20210407133823.828176-1-ruansy.fnst@fujitsu.com>
 <20210407133823.828176-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407133823.828176-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:38:22PM +0800, Shiyang Ruan wrote:
> The core logic in the two dax page fault functions is similar. So, move
> the logic into a common helper function. Also, to facilitate the
> addition of new features, such as CoW, switch-case is no longer used to
> handle different iomap types.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/dax.c | 294 ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 148 insertions(+), 146 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index f843fb8fbbf1..6dea1fc11b46 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1054,6 +1054,66 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_FS_DAX_PMD
> +static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> +		struct iomap *iomap, void **entry)
> +{
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	unsigned long pmd_addr = vmf->address & PMD_MASK;
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct inode *inode = mapping->host;
> +	pgtable_t pgtable = NULL;
> +	struct page *zero_page;
> +	spinlock_t *ptl;
> +	pmd_t pmd_entry;
> +	pfn_t pfn;
> +
> +	zero_page = mm_get_huge_zero_page(vmf->vma->vm_mm);
> +
> +	if (unlikely(!zero_page))
> +		goto fallback;
> +
> +	pfn = page_to_pfn_t(zero_page);
> +	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> +			DAX_PMD | DAX_ZERO_PAGE, false);
> +
> +	if (arch_needs_pgtable_deposit()) {
> +		pgtable = pte_alloc_one(vma->vm_mm);
> +		if (!pgtable)
> +			return VM_FAULT_OOM;
> +	}
> +
> +	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
> +	if (!pmd_none(*(vmf->pmd))) {
> +		spin_unlock(ptl);
> +		goto fallback;
> +	}
> +
> +	if (pgtable) {
> +		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> +		mm_inc_nr_ptes(vma->vm_mm);
> +	}
> +	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
> +	pmd_entry = pmd_mkhuge(pmd_entry);
> +	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
> +	spin_unlock(ptl);
> +	trace_dax_pmd_load_hole(inode, vmf, zero_page, *entry);
> +	return VM_FAULT_NOPAGE;
> +
> +fallback:
> +	if (pgtable)
> +		pte_free(vma->vm_mm, pgtable);
> +	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_page, *entry);
> +	return VM_FAULT_FALLBACK;
> +}
> +#else
> +static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> +		struct iomap *iomap, void **entry)
> +{
> +	return VM_FAULT_FALLBACK;
> +}
> +#endif /* CONFIG_FS_DAX_PMD */
> +
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  {
>  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
> @@ -1291,6 +1351,64 @@ static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf, struct iomap *iomap,
>  	return ret;
>  }
>  
> +/**
> + * dax_fault_actor - Common actor to handle pfn insertion in PTE/PMD fault.
> + * @vmf:	vm fault instance
> + * @pfnp:	pfn to be returned
> + * @xas:	the dax mapping tree of a file
> + * @entry:	an unlocked dax entry to be inserted
> + * @pmd:	distinguish whether it is a pmd fault
> + * @flags:	iomap flags
> + * @iomap:	from iomap_begin()
> + * @srcmap:	from iomap_begin(), not equal to iomap if it is a CoW
> + */
> +static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
> +		struct xa_state *xas, void **entry, bool pmd,
> +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
> +	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
> +	unsigned long entry_flags = pmd ? DAX_PMD : 0;
> +	int err = 0;
> +	pfn_t pfn;
> +
> +	/* if we are reading UNWRITTEN and HOLE, return a hole. */
> +	if (!write &&
> +	    (iomap->type == IOMAP_UNWRITTEN || iomap->type == IOMAP_HOLE)) {
> +		if (!pmd)
> +			return dax_load_hole(xas, mapping, entry, vmf);
> +		else
> +			return dax_pmd_load_hole(xas, vmf, iomap, entry);
> +	}
> +
> +	if (iomap->type != IOMAP_MAPPED) {
> +		WARN_ON_ONCE(1);
> +		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
> +	}
> +
> +	err = dax_iomap_pfn(iomap, pos, size, &pfn);
> +	if (err)
> +		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
> +
> +	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
> +				  write && !sync);
> +
> +	if (sync)
> +		return dax_fault_synchronous_pfnp(pfnp, pfn);
> +
> +	/* insert PMD pfn */
> +	if (pmd)
> +		return vmf_insert_pfn_pmd(vmf, pfn, write);
> +
> +	/* insert PTE pfn */
> +	if (write)
> +		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
> +	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> +}
> +
>  static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  			       int *iomap_errp, const struct iomap_ops *ops)
>  {
> @@ -1298,17 +1416,14 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	struct address_space *mapping = vma->vm_file->f_mapping;
>  	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
>  	struct inode *inode = mapping->host;
> -	unsigned long vaddr = vmf->address;
>  	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
>  	struct iomap iomap = { .type = IOMAP_HOLE };
>  	struct iomap srcmap = { .type = IOMAP_HOLE };
>  	unsigned flags = IOMAP_FAULT;
>  	int error, major = 0;

Hmm, shouldn't major be vm_fault_t since we assign VM_FAULT_MAJOR to it?

--D

>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> -	bool sync;
>  	vm_fault_t ret = 0;
>  	void *entry;
> -	pfn_t pfn;
>  
>  	trace_dax_pte_fault(inode, vmf, ret);
>  	/*
> @@ -1354,8 +1469,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		goto unlock_entry;
>  	}
>  	if (WARN_ON_ONCE(iomap.offset + iomap.length < pos + PAGE_SIZE)) {
> -		error = -EIO;	/* fs corruption? */
> -		goto error_finish_iomap;
> +		ret = VM_FAULT_SIGBUS;	/* fs corruption? */
> +		goto finish_iomap;
>  	}
>  
>  	if (vmf->cow_page) {
> @@ -1363,49 +1478,19 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		goto finish_iomap;
>  	}
>  
> -	sync = dax_fault_is_synchronous(flags, vma, &iomap);
> -
> -	switch (iomap.type) {
> -	case IOMAP_MAPPED:
> -		if (iomap.flags & IOMAP_F_NEW) {
> -			count_vm_event(PGMAJFAULT);
> -			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> -			major = VM_FAULT_MAJOR;
> -		}
> -		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn);
> -		if (error < 0)
> -			goto error_finish_iomap;
> -
> -		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
> -						 0, write && !sync);
> -
> -		if (sync) {
> -			ret = dax_fault_synchronous_pfnp(pfnp, pfn);
> -			goto finish_iomap;
> -		}
> -		trace_dax_insert_mapping(inode, vmf, entry);
> -		if (write)
> -			ret = vmf_insert_mixed_mkwrite(vma, vaddr, pfn);
> -		else
> -			ret = vmf_insert_mixed(vma, vaddr, pfn);
> -
> +	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, false, flags,
> +			      &iomap, &srcmap);
> +	if (ret == VM_FAULT_SIGBUS)
>  		goto finish_iomap;
> -	case IOMAP_UNWRITTEN:
> -	case IOMAP_HOLE:
> -		if (!write) {
> -			ret = dax_load_hole(&xas, mapping, &entry, vmf);
> -			goto finish_iomap;
> -		}
> -		fallthrough;
> -	default:
> -		WARN_ON_ONCE(1);
> -		error = -EIO;
> -		break;
> +
> +	/* read/write MAPPED, CoW UNWRITTEN */
> +	if (iomap.flags & IOMAP_F_NEW) {
> +		count_vm_event(PGMAJFAULT);
> +		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> +		major = VM_FAULT_MAJOR;
>  	}
>  
> - error_finish_iomap:
> -	ret = dax_fault_return(error);
> - finish_iomap:
> +finish_iomap:
>  	if (ops->iomap_end) {
>  		int copied = PAGE_SIZE;
>  
> @@ -1419,66 +1504,14 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		 */
>  		ops->iomap_end(inode, pos, PAGE_SIZE, copied, flags, &iomap);
>  	}
> - unlock_entry:
> +unlock_entry:
>  	dax_unlock_entry(&xas, entry);
> - out:
> +out:
>  	trace_dax_pte_fault_done(inode, vmf, ret);
>  	return ret | major;
>  }
>  
>  #ifdef CONFIG_FS_DAX_PMD
> -static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> -		struct iomap *iomap, void **entry)
> -{
> -	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> -	unsigned long pmd_addr = vmf->address & PMD_MASK;
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct inode *inode = mapping->host;
> -	pgtable_t pgtable = NULL;
> -	struct page *zero_page;
> -	spinlock_t *ptl;
> -	pmd_t pmd_entry;
> -	pfn_t pfn;
> -
> -	zero_page = mm_get_huge_zero_page(vmf->vma->vm_mm);
> -
> -	if (unlikely(!zero_page))
> -		goto fallback;
> -
> -	pfn = page_to_pfn_t(zero_page);
> -	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -			DAX_PMD | DAX_ZERO_PAGE, false);
> -
> -	if (arch_needs_pgtable_deposit()) {
> -		pgtable = pte_alloc_one(vma->vm_mm);
> -		if (!pgtable)
> -			return VM_FAULT_OOM;
> -	}
> -
> -	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
> -	if (!pmd_none(*(vmf->pmd))) {
> -		spin_unlock(ptl);
> -		goto fallback;
> -	}
> -
> -	if (pgtable) {
> -		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> -		mm_inc_nr_ptes(vma->vm_mm);
> -	}
> -	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
> -	pmd_entry = pmd_mkhuge(pmd_entry);
> -	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
> -	spin_unlock(ptl);
> -	trace_dax_pmd_load_hole(inode, vmf, zero_page, *entry);
> -	return VM_FAULT_NOPAGE;
> -
> -fallback:
> -	if (pgtable)
> -		pte_free(vma->vm_mm, pgtable);
> -	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_page, *entry);
> -	return VM_FAULT_FALLBACK;
> -}
> -
>  static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
>  		pgoff_t max_pgoff)
>  {
> @@ -1519,17 +1552,15 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	struct address_space *mapping = vma->vm_file->f_mapping;
>  	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> -	bool sync;
> -	unsigned int iomap_flags = (write ? IOMAP_WRITE : 0) | IOMAP_FAULT;
> +	unsigned int flags = (write ? IOMAP_WRITE : 0) | IOMAP_FAULT;
>  	struct inode *inode = mapping->host;
> -	vm_fault_t result = VM_FAULT_FALLBACK;
> +	vm_fault_t ret = VM_FAULT_FALLBACK;
>  	struct iomap iomap = { .type = IOMAP_HOLE };
>  	struct iomap srcmap = { .type = IOMAP_HOLE };
>  	pgoff_t max_pgoff;
>  	void *entry;
>  	loff_t pos;
>  	int error;
> -	pfn_t pfn;
>  
>  	/*
>  	 * Check whether offset isn't beyond end of file now. Caller is
> @@ -1541,7 +1572,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	trace_dax_pmd_fault(inode, vmf, max_pgoff, 0);
>  
>  	if (xas.xa_index >= max_pgoff) {
> -		result = VM_FAULT_SIGBUS;
> +		ret = VM_FAULT_SIGBUS;
>  		goto out;
>  	}
>  
> @@ -1556,7 +1587,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 */
>  	entry = grab_mapping_entry(&xas, mapping, PMD_ORDER);
>  	if (xa_is_internal(entry)) {
> -		result = xa_to_internal(entry);
> +		ret = xa_to_internal(entry);
>  		goto fallback;
>  	}
>  
> @@ -1568,7 +1599,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 */
>  	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
>  			!pmd_devmap(*vmf->pmd)) {
> -		result = 0;
> +		ret = 0;
>  		goto unlock_entry;
>  	}
>  
> @@ -1578,49 +1609,21 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 * to look up our filesystem block.
>  	 */
>  	pos = (loff_t)xas.xa_index << PAGE_SHIFT;
> -	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap,
> -			&srcmap);
> +	error = ops->iomap_begin(inode, pos, PMD_SIZE, flags, &iomap, &srcmap);
>  	if (error)
>  		goto unlock_entry;
>  
>  	if (iomap.offset + iomap.length < pos + PMD_SIZE)
>  		goto finish_iomap;
>  
> -	sync = dax_fault_is_synchronous(iomap_flags, vma, &iomap);
> -
> -	switch (iomap.type) {
> -	case IOMAP_MAPPED:
> -		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn);
> -		if (error < 0)
> -			goto finish_iomap;
> +	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, true, flags,
> +			      &iomap, &srcmap);
>  
> -		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
> -						DAX_PMD, write && !sync);
> -
> -		if (sync) {
> -			result = dax_fault_synchronous_pfnp(pfnp, pfn);
> -			goto finish_iomap;
> -		}
> -
> -		trace_dax_pmd_insert_mapping(inode, vmf, PMD_SIZE, pfn, entry);
> -		result = vmf_insert_pfn_pmd(vmf, pfn, write);
> -		break;
> -	case IOMAP_UNWRITTEN:
> -	case IOMAP_HOLE:
> -		if (WARN_ON_ONCE(write))
> -			break;
> -		result = dax_pmd_load_hole(&xas, vmf, &iomap, &entry);
> -		break;
> -	default:
> -		WARN_ON_ONCE(1);
> -		break;
> -	}
> -
> - finish_iomap:
> +finish_iomap:
>  	if (ops->iomap_end) {
>  		int copied = PMD_SIZE;
>  
> -		if (result == VM_FAULT_FALLBACK)
> +		if (ret == VM_FAULT_FALLBACK)
>  			copied = 0;
>  		/*
>  		 * The fault is done by now and there's no way back (other
> @@ -1628,19 +1631,18 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		 * Just ignore error from ->iomap_end since we cannot do much
>  		 * with it.
>  		 */
> -		ops->iomap_end(inode, pos, PMD_SIZE, copied, iomap_flags,
> -				&iomap);
> +		ops->iomap_end(inode, pos, PMD_SIZE, copied, flags, &iomap);
>  	}
> - unlock_entry:
> +unlock_entry:
>  	dax_unlock_entry(&xas, entry);
> - fallback:
> -	if (result == VM_FAULT_FALLBACK) {
> +fallback:
> +	if (ret == VM_FAULT_FALLBACK) {
>  		split_huge_pmd(vma, vmf->pmd, vmf->address);
>  		count_vm_event(THP_FAULT_FALLBACK);
>  	}
>  out:
> -	trace_dax_pmd_fault_done(inode, vmf, max_pgoff, result);
> -	return result;
> +	trace_dax_pmd_fault_done(inode, vmf, max_pgoff, ret);
> +	return ret;
>  }
>  #else
>  static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
> -- 
> 2.31.0
> 
> 
> 
