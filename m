Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FABA3CE795
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350001AbhGSQ2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 12:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351613AbhGSQZG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:25:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF94960FE9;
        Mon, 19 Jul 2021 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626714346;
        bh=uaJLBcPxPyyL97FgKTT/vro/wXFDlgPcaE9Brc4Rhiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjIHr0+lyPx33HFHDELaosXCzm+e4f8UqdigJsrysx6QqwO/s1FPhv1SCykxNgZ7D
         sCWfEfnXrQhrh79gOXtDCZUX/SpQEZPmwTOddDbAYf4ZteB/orlfdOnr7/lCXFB1LO
         DwlN80sef/NdAK9NNzbe/qQzptINwKrmUxBkbMqZdyCbstBofI+wBxnBKxfDO4T19o
         gGxJ9rjbwLZQGzMTDRPAbyUz/4mmeKl/0g1nxtzRlhhKOeBti9G+9ymL7Sfn+cTZ9E
         VzleIInjJh0gMvx2xTDbZ8qicNbH+WYqWTILcuFK0afeM0xXBa4n/4VRMDlrHButvU
         QjKjZgrT4JAwA==
Date:   Mon, 19 Jul 2021 10:05:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 16/27] iomap: switch iomap_bmap to use iomap_iter
Message-ID: <20210719170545.GF22402@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-17-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:35:09PM +0200, Christoph Hellwig wrote:
> Rewrite the ->bmap implementation based on iomap_iter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/fiemap.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index acad09a8c188df..60daadba16c149 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -92,35 +92,30 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
>  }
>  EXPORT_SYMBOL_GPL(iomap_fiemap);
>  
> -static loff_t
> -iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap, struct iomap *srcmap)
> -{
> -	sector_t *bno = data, addr;
> -
> -	if (iomap->type == IOMAP_MAPPED) {
> -		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
> -		*bno = addr;
> -	}
> -	return 0;
> -}
> -
>  /* legacy ->bmap interface.  0 is the error return (!) */
>  sector_t
>  iomap_bmap(struct address_space *mapping, sector_t bno,
>  		const struct iomap_ops *ops)
>  {
> -	struct inode *inode = mapping->host;
> -	loff_t pos = bno << inode->i_blkbits;
> -	unsigned blocksize = i_blocksize(inode);
> +	struct iomap_iter iter = {
> +		.inode	= mapping->host,
> +		.pos	= (loff_t)bno << mapping->host->i_blkbits,
> +		.len	= i_blocksize(mapping->host),
> +		.flags	= IOMAP_REPORT,
> +	};
>  	int ret;
>  
>  	if (filemap_write_and_wait(mapping))
>  		return 0;
>  
>  	bno = 0;
> -	ret = iomap_apply(inode, pos, blocksize, 0, ops, &bno,
> -			  iomap_bmap_actor);
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +		if (iter.iomap.type != IOMAP_MAPPED)
> +			continue;

There isn't a mapped extent, so return 0 here, right?

--D

> +		bno = (iter.pos - iter.iomap.offset + iter.iomap.addr) >>
> +				mapping->host->i_blkbits;
> +	}
> +
>  	if (ret)
>  		return 0;
>  	return bno;
> -- 
> 2.30.2
> 
