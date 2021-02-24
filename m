Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD18324325
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 18:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhBXR0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 12:26:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:50584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233399AbhBXR0H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:26:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84718ADDB;
        Wed, 24 Feb 2021 17:25:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5EA371E14EE; Wed, 24 Feb 2021 18:25:24 +0100 (CET)
Date:   Wed, 24 Feb 2021 18:25:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 3/3] iomap: use filemap_range_needs_writeback() for
 O_DIRECT reads
Message-ID: <20210224172524.GF849@quack2.suse.cz>
References: <20210224164455.1096727-1-axboe@kernel.dk>
 <20210224164455.1096727-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224164455.1096727-4-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-02-21 09:44:55, Jens Axboe wrote:
> For reads, use the better variant of checking for the need to call
> filemap_write_and_wait_range() when doing O_DIRECT. This avoids falling
> back to the slow path for IOCB_NOWAIT, if there are no pages to wait for
> (or write out).
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap/direct-io.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index e2c4991833b8..8c35a0041f0f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -487,12 +487,28 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		if (pos >= dio->i_size)
>  			goto out_free_dio;
>  
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
> +			if (filemap_range_needs_writeback(mapping, pos, end)) {
> +				ret = -EAGAIN;
> +				goto out_free_dio;
> +			}
> +			iomap_flags |= IOMAP_NOWAIT;
> +		}
> +
>  		if (iter_is_iovec(iter))
>  			dio->flags |= IOMAP_DIO_DIRTY;
>  	} else {
>  		iomap_flags |= IOMAP_WRITE;
>  		dio->flags |= IOMAP_DIO_WRITE;
>  
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
> +			if (filemap_range_has_page(mapping, pos, end)) {
> +				ret = -EAGAIN;
> +				goto out_free_dio;
> +			}
> +			iomap_flags |= IOMAP_NOWAIT;
> +		}
> +
>  		/* for data sync or sync, we need sync completion processing */
>  		if (iocb->ki_flags & IOCB_DSYNC)
>  			dio->flags |= IOMAP_DIO_NEED_SYNC;
> @@ -507,14 +523,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			dio->flags |= IOMAP_DIO_WRITE_FUA;
>  	}
>  
> -	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (filemap_range_has_page(mapping, pos, end)) {
> -			ret = -EAGAIN;
> -			goto out_free_dio;
> -		}
> -		iomap_flags |= IOMAP_NOWAIT;
> -	}
> -
>  	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
>  		ret = -EAGAIN;
>  		if (pos >= dio->i_size || pos + count > dio->i_size)
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
