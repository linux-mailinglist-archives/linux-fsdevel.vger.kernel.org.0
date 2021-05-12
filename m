Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E1837EE94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbhELVxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 17:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1391865AbhELVdv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 17:33:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 539DD61352;
        Wed, 12 May 2021 21:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620855154;
        bh=m4zYFt9qsjR5CpKrONf2H7NpIJ88zehjuQ/jbBnlStY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxzzzZr3Di3w/5k8P8MV+P16/Tzk+8Mr8iJOrCqrTIWPf9DmRLy/oSYb7/yLO7Dfs
         MIsLsylIYciGF1QUZZON5L5QjgLj1FJZ8L3LgmFW5vHdqJxHSJWF7x0orrHNOcX5t8
         tgm9YcMUwc4WwyfotuRigZ9eWt1jokOv9K8NjKkVYv/+jja6ddVTRgGnenRW++g01u
         dUeuamRTr+xRCKLKxHXUCNVGi7OnItKqLuVTeGZkhfYdiVQxnVbBiGKp5WZKxsUfJV
         8A2hfF2u2T7JQyM6wslxE4X8ilYdUYLv9SrL/PLv0LzsNUKXIxTAYT4/bDQPjXUPiI
         1wXF5j59KO8ow==
Date:   Wed, 12 May 2021 14:32:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 03/15] iomap: don't try to poll multi-bio I/Os in
 __iomap_dio_rw
Message-ID: <20210512213230.GB8543@magnolia>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512131545.495160-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 03:15:33PM +0200, Christoph Hellwig wrote:
> If an iocb is split into multiple bios we can't poll for both.  So don't
> bother to even try to poll in that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ahh the fun of reviewing things like iopoll that I'm not all /that/
familiar with...

> ---
>  fs/iomap/direct-io.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..d5637f467109 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -282,6 +282,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	if (!iov_iter_count(dio->submit.iter))
>  		goto out;
>  
> +	/*
> +	 * We can only poll for single bio I/Os.
> +	 */
> +	if (need_zeroout ||
> +	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))

Hm, is this logic here to catch the second iomap_dio_zero below the
zero_tail: label?  What happens if we have an unaligned direct write
that starts below EOF but (for whatever reason) ends the loop with pos
now above EOF but not on a block boundary?

> +		dio->iocb->ki_flags &= ~IOCB_HIPRI;
> +
>  	if (need_zeroout) {
>  		/* zero out from the start of the block to the write offset */
>  		pad = pos & (fs_block_size - 1);
> @@ -339,6 +346,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
>  						 BIO_MAX_VECS);
> +		/*
> +		 * We can only poll for single bio I/Os.
> +		 */
> +		if (nr_pages)
> +			dio->iocb->ki_flags &= ~IOCB_HIPRI;
>  		iomap_dio_submit_bio(dio, iomap, bio, pos);
>  		pos += n;
>  	} while (nr_pages);
> @@ -579,6 +591,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			iov_iter_revert(iter, pos - dio->i_size);
>  			break;
>  		}
> +
> +		/*
> +		 * We can only poll for single bio I/Os.
> +		 */
> +		iocb->ki_flags &= ~IOCB_HIPRI;

Hmm, why is this here?  Won't this clear IOCB_HIPRI even if the first
iomap_apply call successfully creates a polled bio for the entire iovec
such that we exit the loop one line later because count becomes zero?
How does the upper layer (io_uring, I surmise?) know that there's
a bio that it should poll for?

<shrug> Unless the only effect that this has is making it so that the
subsequent calls to iomap_apply don't have the polling mode set?  I see
enough places in io_uring.c that check (iocb->ki_flags & IOCB_HIPRI) to
make me wonder if the lifetime of that flag ends as soon as we get to
->{read,write}_iter?

--D

>  	} while ((count = iov_iter_count(iter)) > 0);
>  	blk_finish_plug(&plug);
>  
> -- 
> 2.30.2
> 
