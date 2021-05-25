Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29842390CD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 01:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhEYXOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 19:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEYXOZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 19:14:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 028576128B;
        Tue, 25 May 2021 23:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621984375;
        bh=p5zs9AFpKvm2gJ3wOHz8HK6dqERf9W6OPzdt/UtnSZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFkhYnypq9J5CIvc9qM9+goufTIQs8wZOya5HVGKzlep5Hh88uulPCiLVs1XuEy//
         f2ZcODbhONRp3FMmL5uSLpMRRTXX9E0ESxLzvS9IIMCOcYBKBugD8Qtq/bJlBeoa6n
         xyiWaN8nzv2rkllsMJhZZ0KQ5qBvRdjrobtH/HifDm17H4Y9VK8SaHCjxQeImSOuG/
         EQ5z7v22TgggLa27t2AuQR9eaIT5jS7DrqDuq4k+U2tw47e6spQGwS6p1k1h4H2W0d
         /k53pWsda612hxG8K2zf4GOfKjsn6EexHSe+G53YIqAT6lnViDYbdI7ROviRzT4YNj
         TXyfJqDOJ9nAg==
Date:   Tue, 25 May 2021 16:12:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] fsdax: Output address in dax_iomap_pfn() and
 rename it
Message-ID: <20210525231254.GD202078@locust>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
 <20210422134501.1596266-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422134501.1596266-4-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:45:01PM +0800, Shiyang Ruan wrote:
> Add address output in dax_iomap_pfn() in order to perform a memcpy() in
> CoW case.  Since this function both output address and pfn, rename it to
> dax_iomap_direct_access().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks pretty simple to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index f99e33de2036..48a97905c0c3 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -998,8 +998,8 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
>  	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
>  }
>  
> -static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> -			 pfn_t *pfnp)
> +static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
> +		void **kaddr, pfn_t *pfnp)
>  {
>  	const sector_t sector = dax_iomap_sector(iomap, pos);
>  	pgoff_t pgoff;
> @@ -1011,11 +1011,13 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
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
> @@ -1025,6 +1027,12 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
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
> @@ -1389,7 +1397,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
>  		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
>  	}
>  
> -	err = dax_iomap_pfn(iomap, pos, size, &pfn);
> +	err = dax_iomap_direct_access(iomap, pos, size, NULL, &pfn);
>  	if (err)
>  		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
>  
> -- 
> 2.31.1
> 
> 
> 
