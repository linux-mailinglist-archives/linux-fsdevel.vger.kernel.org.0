Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC99440D0A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 02:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhIPAKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 20:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhIPAKe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:10:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6010761164;
        Thu, 16 Sep 2021 00:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631750954;
        bh=1GLkZYrQ9JcJycVqwmmU7hYi0ILuTB1I20PfYrCv3mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQukCslu83VpTBuY/KDFf7r9dFwP7LFhqIc7lNwB0bm1GI592vfpCG3CGS/Sty24Y
         TzcOzv2y5oF69EWmDf3pMRAEmvyIrEIH8lrRpjAt731/uN8G9/fJc8JaKmpL6QVz5h
         17JI7ys+E+dHFfcVki2he1O+72ph0uWYlbex8QtHqC+6WdhFFV8D/y/lbIz49V1QSR
         /HltPfN0o9uyLh7BqtYDCJ5FTqgIdiNDpBT/aiYrSq60aEiEMNC1bAreAxG8hWnqys
         onc0S04hoh537z5lGyscDCL4W6tNyJEnHKZ6mhpqvWB7nDNsL64R0xwx0VM129ROPh
         nkxENJMDmteMg==
Date:   Wed, 15 Sep 2021 17:09:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     hch@lst.de, linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        rgoldwyn@suse.de, viro@zeniv.linux.org.uk, willy@infradead.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v9 1/8] fsdax: Output address in dax_iomap_pfn() and
 rename it
Message-ID: <20210916000914.GB34830@magnolia>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
 <20210915104501.4146910-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915104501.4146910-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 06:44:54PM +0800, Shiyang Ruan wrote:
> Add address output in dax_iomap_pfn() in order to perform a memcpy() in
> CoW case.  Since this function both output address and pfn, rename it to
> dax_iomap_direct_access().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Could've sworn I reviewed this a few revisions ago...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 4e3e5a283a91..8b482a58acae 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1010,8 +1010,8 @@ static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
>  	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
>  }
>  
> -static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
> -			 pfn_t *pfnp)
> +static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
> +		size_t size, void **kaddr, pfn_t *pfnp)
>  {
>  	const sector_t sector = dax_iomap_sector(iomap, pos);
>  	pgoff_t pgoff;
> @@ -1023,11 +1023,13 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>  		return rc;
>  	id = dax_read_lock();
>  	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> -				   NULL, pfnp);
> +				   kaddr, pfnp);
>  	if (length < 0) {
>  		rc = length;
>  		goto out;
>  	}
> +	if (!pfnp)
> +		goto out_check_addr;
>  	rc = -EINVAL;
>  	if (PFN_PHYS(length) < size)
>  		goto out;
> @@ -1037,6 +1039,12 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
>  	if (length > 1 && !pfn_t_devmap(*pfnp))
>  		goto out;
>  	rc = 0;
> +
> +out_check_addr:
> +	if (!kaddr)
> +		goto out;
> +	if (!*kaddr)
> +		rc = -EFAULT;
>  out:
>  	dax_read_unlock(id);
>  	return rc;
> @@ -1401,7 +1409,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>  		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
>  	}
>  
> -	err = dax_iomap_pfn(&iter->iomap, pos, size, &pfn);
> +	err = dax_iomap_direct_access(&iter->iomap, pos, size, NULL, &pfn);
>  	if (err)
>  		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
>  
> -- 
> 2.33.0
> 
> 
> 
