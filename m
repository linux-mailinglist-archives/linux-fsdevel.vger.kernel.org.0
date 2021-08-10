Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408013E53A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhHJGkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 02:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhHJGkN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:40:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B50DD60238;
        Tue, 10 Aug 2021 06:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628577591;
        bh=Rt8OufpkIbsLyiXRCpS3gkfeWehc9wTsVDBkYN0Fyqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yjvl1922O0SS+tM6M/cH/Wh4ac8k7jnNBYQI3W7s14ozjpLmppXWgCgcwDZmjlBLM
         o+MaylInt6EJVnKD3CsZrxrFU3sPk6A+SW5cQEVZkEspbXEbfD5f4dZe9MSMq6BHla
         A3XuxUgpFM2zg8w5+tyHXXyAV6QREHdO/ehKjJ2t+dAwYvaYaNW8cUyDdsyuJWWFJV
         w61ks7bG17YL0r48We5YJMifOo7sO+ZcnZDyPladHWOYABbCHRR4MPW9Bf/9SyuVHn
         3Dn1LvlTmCYKzxbPAeYKZO2r1r+rG2JozMzYUzO/QJjzzAMq6Di8Gkv50b5sSfCZ1Y
         6hKVXKdBIY4Mw==
Date:   Mon, 9 Aug 2021 23:39:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 19/30] iomap: switch iomap_bmap to use iomap_iter
Message-ID: <20210810063951.GH3601443@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809061244.1196573-20-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 08:12:33AM +0200, Christoph Hellwig wrote:
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

I still feel uncomfortable about this use of "continue" here, because it
really means "call iomap_iter again to clean up and exit even though we
know it won't even look for more iomaps to iterate".

To me that feels subtly broken (I usually associate 'continue' with
'go run the loop body again'), and even though bmap has been a quirky
hot mess for 45 years, we don't need to make it even moreso.

Can't this at least be rephrased as:

	const uint bno_shift = (mapping->host->i_blkbits - SECTOR_SHIFT);

	while ((ret = iomap_iter(&iter, ops)) > 0) {
		if (iter.iomap.type == IOMAP_MAPPED)
			bno = iomap_sector(iomap, iter.pos) << bno_shift;
		/* leave iter.processed unset to stop iteration */
	}

to make the loop exit more explicit?

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
