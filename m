Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87176390C06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhEYWSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhEYWSv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:18:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06024613F5;
        Tue, 25 May 2021 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621981041;
        bh=M2lRYy8u4f8zVD9Cxvaj5twIjqKGVeZ2DFiOuO/QQnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9GSiuxzKKzi6EjTQq+eB8f3KNwZDcGIlpE5k1mmT6optmrUwvT2XSb09mJtUWkPN
         +vs38iDKNiLGnUf+oXtMBsjqv4w1OZaMSoDNPLXXXLffXRaFVFL9xNzZXVqsivvNna
         bIL6XJgsYpyGeloKNaEoE40pSj4ngXa2Qrf25bx5oC5TJxkw+uHByIVSWF6K81sA8R
         fh8Ysi5CgBYcwtEmiJVhte7BgRANlVIt5lp6I/NgWlHppJsXVP1mfTnIt8YGwMOZDP
         7yznWfOYGrACAMWil/g+ZFZUaeIi2pHkQnqoBaPlEW7AP53Vw6acFFpr9KJ7rKVUIL
         sXefyMSr9lHng==
Date:   Tue, 25 May 2021 15:17:20 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com,
        hch@lst.de, rgoldwyn@suse.de,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v6 3/7] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Message-ID: <20210525221720.GD202144@locust>
References: <20210519060045.1051226-1-ruansy.fnst@fujitsu.com>
 <20210519060045.1051226-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519060045.1051226-4-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 02:00:41PM +0800, Shiyang Ruan wrote:
> Punch hole on a reflinked file needs dax_copy_edge() too.  Otherwise,
> data in not aligned area will be not correct.  So, add the srcmap to
> dax_iomap_zero() and replace memset() as dax_copy_edge().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c               | 25 +++++++++++++++----------
>  fs/iomap/buffered-io.c |  2 +-
>  include/linux/dax.h    |  3 ++-
>  3 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 98531c53d613..baee584cb8ae 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1197,7 +1197,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>  
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> +		struct iomap *srcmap)
>  {
>  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  	pgoff_t pgoff;
> @@ -1219,19 +1220,23 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  
>  	if (page_aligned)
>  		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> -	else
> +	else {
>  		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> -	if (rc < 0) {
> -		dax_read_unlock(id);
> -		return rc;
> -	}
> -
> -	if (!page_aligned) {
> -		memset(kaddr + offset, 0, size);
> +		if (rc < 0)
> +			goto out;
> +		if (iomap->addr != srcmap->addr) {
> +			rc = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap,
> +						kaddr);
> +			if (rc < 0)
> +				goto out;
> +		} else
> +			memset(kaddr + offset, 0, size);
>  		dax_flush(iomap->dax_dev, kaddr + offset, size);
>  	}
> +
> +out:
>  	dax_read_unlock(id);
> -	return size;
> +	return rc < 0 ? rc : size;
>  }
>  
>  static loff_t
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9023717c5188..fdaac4ba9b9d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -933,7 +933,7 @@ static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
>  		s64 bytes;
>  
>  		if (IS_DAX(inode))
> -			bytes = dax_iomap_zero(pos, length, iomap);
> +			bytes = dax_iomap_zero(pos, length, iomap, srcmap);
>  		else
>  			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
>  		if (bytes < 0)
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b52f084aa643..3275e01ed33d 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -237,7 +237,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
> +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> +		struct iomap *srcmap);
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
> -- 
> 2.31.1
> 
> 
> 
