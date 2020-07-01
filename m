Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72A21057D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgGAHxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 03:53:14 -0400
Received: from verein.lst.de ([213.95.11.211]:39050 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbgGAHxN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:53:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 755A968B02; Wed,  1 Jul 2020 09:53:10 +0200 (CEST)
Date:   Wed, 1 Jul 2020 09:53:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, david@fromorbit.com,
        darrick.wong@oracle.com, hch@lst.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: always fall back to buffered I/O after invalidation failures, was:
 Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if
 page invalidation fails
Message-ID: <20200701075310.GB29884@lst.de>
References: <20200629192353.20841-1-rgoldwyn@suse.de> <20200629192353.20841-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629192353.20841-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:23:49PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> For direct I/O, add the flag IOMAP_DIO_RWF_NO_STALE_PAGECACHE to indicate
> that if the page invalidation fails, return back control to the
> filesystem so it may fallback to buffered mode.
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

I'd like to start a discussion of this shouldn't really be the
default behavior.  If we have page cache that can't be invalidated it
actually makes a whole lot of sense to not do direct I/O, avoid the
warnings, etc.

Adding all the relevant lists.

> ---
>  fs/iomap/direct-io.c  |  8 +++++++-
>  include/linux/iomap.h | 14 ++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index fd22bff61569..2459c76e41ab 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -484,8 +484,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	 */
>  	ret = invalidate_inode_pages2_range(mapping,
>  			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> -	if (ret)
> +	if (ret) {
> +		if (dio_flags & IOMAP_DIO_RWF_NO_STALE_PAGECACHE) {
> +			if (ret == -EBUSY)
> +				ret = 0;
> +			goto out_free_dio;
> +		}
>  		dio_warn_stale_pagecache(iocb->ki_filp);
> +	}
>  	ret = 0;
>  
>  	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8a4ba1635202..2ebb8a298cd8 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -262,7 +262,21 @@ struct iomap_dio_ops {
>  /*
>   * Wait for completion of DIO
>   */
> +
>  #define IOMAP_DIO_RWF_SYNCIO			(1 << 0)
> +/*
> + * Direct IO will attempt to keep the page cache coherent by
> + * invalidating the inode's page cache over the range of the DIO.
> + * That can fail if something else is actively using the page cache.
> + * If this happens and the DIO continues, the data in the page
> + * cache will become stale.
> + *
> + * Set this flag if you want the DIO to abort without issuing any IO
> + * or error if it fails to invalidate the page cache successfully.
> + * This allows the IO submitter to fallback to buffered IO to resubmit
> + * IO
> + */
> +#define IOMAP_DIO_RWF_NO_STALE_PAGECACHE	(1 << 1)
>  
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -- 
> 2.26.2
---end quoted text---
