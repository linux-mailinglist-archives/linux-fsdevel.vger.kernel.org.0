Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD7390C28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhEYW2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhEYW2a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:28:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB2816124C;
        Tue, 25 May 2021 22:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621981619;
        bh=E8cYpBLdMcQcPG6UqetY1NN+U2qgqU1+kmWV18A4lyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/oP8Qv8ZQsbm+B2+tuZFGBhtViukxn95cCMQ/6npEeG/5J6qbOKN+FMSTqSyX+j+
         bHjxvew9GWG1GrqDG2GzQivipSVBcQtWjmGdSBCueKMNC/9QHwEWL0GCJ8p/7n6h6l
         oQe3yCze2iQLltj1RprWwDtvYfIQEgbzV2hgJWrmTbIiCd4PKdueIY3d/GMx/6lp3O
         dAkIdupVCDfWexJDXpvJpBbenKCXFrnZqvswCsyug8OSIRplw+PDcHkG0ajf64CYb4
         9GufzZQblLrpfeQNtCJnk+7xKq4YniO2aTOt0vlARPIsu2fFcTY/kIQCrnI9L7GbYm
         1ulwytALs06JQ==
Date:   Tue, 25 May 2021 15:26:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
Message-ID: <20210525222659.GB202078@locust>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
 <20210422134501.1596266-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422134501.1596266-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:44:59PM +0800, Shiyang Ruan wrote:
> The dax page fault code is too long and a bit difficult to read. And it
> is hard to understand when we trying to add new features. Some of the
> PTE/PMD codes have similar logic. So, factor them as helper functions to
> simplify the code.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks reasonably straightforward.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 153 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 84 insertions(+), 69 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index b3d27fdc6775..f843fb8fbbf1 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1244,6 +1244,53 @@ static bool dax_fault_is_synchronous(unsigned long flags,
>  		&& (iomap->flags & IOMAP_F_DIRTY);
>  }
>  
> +/*
> + * If we are doing synchronous page fault and inode needs fsync, we can insert
> + * PTE/PMD into page tables only after that happens. Skip insertion for now and
> + * return the pfn so that caller can insert it after fsync is done.
> + */
> +static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
> +{
> +	if (WARN_ON_ONCE(!pfnp))
> +		return VM_FAULT_SIGBUS;
> +
> +	*pfnp = pfn;
> +	return VM_FAULT_NEEDDSYNC;
> +}
> +
> +static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf, struct iomap *iomap,
> +		loff_t pos)
> +{
> +	int error = 0;
> +	vm_fault_t ret;
> +	unsigned long vaddr = vmf->address;
> +	sector_t sector = dax_iomap_sector(iomap, pos);
> +
> +	switch (iomap->type) {
> +	case IOMAP_HOLE:
> +	case IOMAP_UNWRITTEN:
> +		clear_user_highpage(vmf->cow_page, vaddr);
> +		break;
> +	case IOMAP_MAPPED:
> +		error = copy_cow_page_dax(iomap->bdev, iomap->dax_dev,
> +						sector, vmf->cow_page, vaddr);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		error = -EIO;
> +		break;
> +	}
> +
> +	if (error)
> +		return dax_fault_return(error);
> +
> +	__SetPageUptodate(vmf->cow_page);
> +	ret = finish_fault(vmf);
> +	if (!ret)
> +		ret = VM_FAULT_DONE_COW;
> +	return ret;
> +}
> +
>  static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  			       int *iomap_errp, const struct iomap_ops *ops)
>  {
> @@ -1312,30 +1359,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	}
>  
>  	if (vmf->cow_page) {
> -		sector_t sector = dax_iomap_sector(&iomap, pos);
> -
> -		switch (iomap.type) {
> -		case IOMAP_HOLE:
> -		case IOMAP_UNWRITTEN:
> -			clear_user_highpage(vmf->cow_page, vaddr);
> -			break;
> -		case IOMAP_MAPPED:
> -			error = copy_cow_page_dax(iomap.bdev, iomap.dax_dev,
> -						  sector, vmf->cow_page, vaddr);
> -			break;
> -		default:
> -			WARN_ON_ONCE(1);
> -			error = -EIO;
> -			break;
> -		}
> -
> -		if (error)
> -			goto error_finish_iomap;
> -
> -		__SetPageUptodate(vmf->cow_page);
> -		ret = finish_fault(vmf);
> -		if (!ret)
> -			ret = VM_FAULT_DONE_COW;
> +		ret = dax_fault_cow_page(vmf, &iomap, pos);
>  		goto finish_iomap;
>  	}
>  
> @@ -1355,19 +1379,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
>  						 0, write && !sync);
>  
> -		/*
> -		 * If we are doing synchronous page fault and inode needs fsync,
> -		 * we can insert PTE into page tables only after that happens.
> -		 * Skip insertion for now and return the pfn so that caller can
> -		 * insert it after fsync is done.
> -		 */
>  		if (sync) {
> -			if (WARN_ON_ONCE(!pfnp)) {
> -				error = -EIO;
> -				goto error_finish_iomap;
> -			}
> -			*pfnp = pfn;
> -			ret = VM_FAULT_NEEDDSYNC | major;
> +			ret = dax_fault_synchronous_pfnp(pfnp, pfn);
>  			goto finish_iomap;
>  		}
>  		trace_dax_insert_mapping(inode, vmf, entry);
> @@ -1466,13 +1479,45 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  	return VM_FAULT_FALLBACK;
>  }
>  
> +static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
> +		pgoff_t max_pgoff)
> +{
> +	unsigned long pmd_addr = vmf->address & PMD_MASK;
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +
> +	/*
> +	 * Make sure that the faulting address's PMD offset (color) matches
> +	 * the PMD offset from the start of the file.  This is necessary so
> +	 * that a PMD range in the page table overlaps exactly with a PMD
> +	 * range in the page cache.
> +	 */
> +	if ((vmf->pgoff & PG_PMD_COLOUR) !=
> +	    ((vmf->address >> PAGE_SHIFT) & PG_PMD_COLOUR))
> +		return true;
> +
> +	/* Fall back to PTEs if we're going to COW */
> +	if (write && !(vmf->vma->vm_flags & VM_SHARED))
> +		return true;
> +
> +	/* If the PMD would extend outside the VMA */
> +	if (pmd_addr < vmf->vma->vm_start)
> +		return true;
> +	if ((pmd_addr + PMD_SIZE) > vmf->vma->vm_end)
> +		return true;
> +
> +	/* If the PMD would extend beyond the file size */
> +	if ((xas->xa_index | PG_PMD_COLOUR) >= max_pgoff)
> +		return true;
> +
> +	return false;
> +}
> +
>  static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  			       const struct iomap_ops *ops)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct address_space *mapping = vma->vm_file->f_mapping;
>  	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
> -	unsigned long pmd_addr = vmf->address & PMD_MASK;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	bool sync;
>  	unsigned int iomap_flags = (write ? IOMAP_WRITE : 0) | IOMAP_FAULT;
> @@ -1495,33 +1540,12 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  
>  	trace_dax_pmd_fault(inode, vmf, max_pgoff, 0);
>  
> -	/*
> -	 * Make sure that the faulting address's PMD offset (color) matches
> -	 * the PMD offset from the start of the file.  This is necessary so
> -	 * that a PMD range in the page table overlaps exactly with a PMD
> -	 * range in the page cache.
> -	 */
> -	if ((vmf->pgoff & PG_PMD_COLOUR) !=
> -	    ((vmf->address >> PAGE_SHIFT) & PG_PMD_COLOUR))
> -		goto fallback;
> -
> -	/* Fall back to PTEs if we're going to COW */
> -	if (write && !(vma->vm_flags & VM_SHARED))
> -		goto fallback;
> -
> -	/* If the PMD would extend outside the VMA */
> -	if (pmd_addr < vma->vm_start)
> -		goto fallback;
> -	if ((pmd_addr + PMD_SIZE) > vma->vm_end)
> -		goto fallback;
> -
>  	if (xas.xa_index >= max_pgoff) {
>  		result = VM_FAULT_SIGBUS;
>  		goto out;
>  	}
>  
> -	/* If the PMD would extend beyond the file size */
> -	if ((xas.xa_index | PG_PMD_COLOUR) >= max_pgoff)
> +	if (dax_fault_check_fallback(vmf, &xas, max_pgoff))
>  		goto fallback;
>  
>  	/*
> @@ -1573,17 +1597,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
>  						DAX_PMD, write && !sync);
>  
> -		/*
> -		 * If we are doing synchronous page fault and inode needs fsync,
> -		 * we can insert PMD into page tables only after that happens.
> -		 * Skip insertion for now and return the pfn so that caller can
> -		 * insert it after fsync is done.
> -		 */
>  		if (sync) {
> -			if (WARN_ON_ONCE(!pfnp))
> -				goto finish_iomap;
> -			*pfnp = pfn;
> -			result = VM_FAULT_NEEDDSYNC;
> +			result = dax_fault_synchronous_pfnp(pfnp, pfn);
>  			goto finish_iomap;
>  		}
>  
> -- 
> 2.31.1
> 
> 
> 
