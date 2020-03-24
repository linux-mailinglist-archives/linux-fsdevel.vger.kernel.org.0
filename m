Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FE319151F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgCXPlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:41:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbgCXPlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yRyMm7QNGa1QxyqAit0ud9YfLLzAXR0cCnyVzb5F8I8=; b=ncaTsK1BPjoxPIAZ6eyo+jvHwE
        7uAo4fj8KfRTyNga+ATC0T0xGPy736fZ8Yc8Ofzd6t9j4ZrkcA664IFJtQvy9Vtol7N8JFThDuA0R
        gbuEFl2WddJh4s/W0CfrCFFoIxgehbcEZLo0Xu48NyXsGXV3XkF1ly3M4NAn/dGczyrq6nGWZigKw
        g6n94oeHiFm8oj4rMJhKqfajfwfeX88RrzV7kagZRqdD6TWTrgYS6lKhxfmUOn7IMwa70M2k6luCT
        o0/rBE3zPHMt+K5zakWYPCWobpQ4Yb3Fvu4Gxq9ercdFi0q+huSSwV3pRIKGVo0bSEA+XAzNREjnw
        6z7ZVe2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGlgJ-0002uc-6w; Tue, 24 Mar 2020 15:41:31 +0000
Date:   Tue, 24 Mar 2020 08:41:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 10/11] iomap: Add support for zone append writes
Message-ID: <20200324154131.GA32087@infradead.org>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324152454.4954-11-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:24:53AM +0900, Johannes Thumshirn wrote:
> @@ -39,6 +40,7 @@ struct iomap_dio {
>  			struct task_struct	*waiter;
>  			struct request_queue	*last_queue;
>  			blk_qc_t		cookie;
> +			sector_t		sector;
>  		} submit;
>  
>  		/* used for aio completion: */
> @@ -151,6 +153,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  	if (bio->bi_status)
>  		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
>  
> +	if (dio->flags & IOMAP_DIO_ZONE_APPEND)
> +		dio->submit.sector = bio->bi_iter.bi_sector;

The submit member in struct iomap_dio is for submit-time information,
while this is used in the completion path..

>  		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
>  		iomap_dio_submit_bio(dio, iomap, bio);
> +
> +		/*
> +		 * Issuing multiple BIOs for a large zone append write can
> +		 * result in reordering of the write fragments and to data
> +		 * corruption. So always stop after the first BIO is issued.
> +		 */
> +		if (zone_append)
> +			break;

At least for a normal file system that is absolutely not true.  If
zonefs is so special it might be better of just using a slightly tweaked
copy of blkdev_direct_IO rather than using iomap.

> @@ -446,6 +486,11 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		flags |= IOMAP_WRITE;
>  		dio->flags |= IOMAP_DIO_WRITE;
>  
> +		if (iocb->ki_flags & IOCB_ZONE_APPEND) {
> +			flags |= IOMAP_ZONE_APPEND;
> +			dio->flags |= IOMAP_DIO_ZONE_APPEND;
> +		}
> +
>  		/* for data sync or sync, we need sync completion processing */
>  		if (iocb->ki_flags & IOCB_DSYNC)
>  			dio->flags |= IOMAP_DIO_NEED_SYNC;
> @@ -516,6 +561,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			iov_iter_revert(iter, pos - dio->i_size);
>  			break;
>  		}
> +
> +		/*
> +		 * Zone append writes cannot be split and be shorted. Break
> +		 * here to let the user know instead of sending more IOs which
> +		 * could get reordered and corrupt the written data.
> +		 */
> +		if (flags & IOMAP_ZONE_APPEND)
> +			break;

But that isn't what we do here.  You exit after a single apply iteration
which is perfectly fine - at at least for a normal file system, zonefs
is rather weird.

> +
>  	} while ((count = iov_iter_count(iter)) > 0);
>  	blk_finish_plug(&plug);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..aa4ad705e549 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -314,6 +314,7 @@ enum rw_hint {
>  #define IOCB_SYNC		(1 << 5)
>  #define IOCB_WRITE		(1 << 6)
>  #define IOCB_NOWAIT		(1 << 7)
> +#define IOCB_ZONE_APPEND	(1 << 8)

I don't think the iocb is the right interface for passing this
kind of information.  We currently pass a bool wait to iomap_dio_rw
which really should be flags.  I have a pending patch for that.

> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b09463dae0d..16c17a79e53d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -68,7 +68,6 @@ struct vm_fault;
>   */
>  #define IOMAP_F_PRIVATE		0x1000
>  
> -

Spurious whitespace change.

>  /*
>   * Magic value for addr:
>   */
> @@ -95,6 +94,17 @@ iomap_sector(struct iomap *iomap, loff_t pos)
>  	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>  }
>  
> +/*
> + * Flags for iomap_begin / iomap_end.  No flag implies a read.
> + */
> +#define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */
> +#define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
> +#define IOMAP_REPORT		(1 << 2) /* report extent status, e.g. FIEMAP */
> +#define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
> +#define IOMAP_DIRECT		(1 << 4) /* direct I/O */
> +#define IOMAP_NOWAIT		(1 << 5) /* do not block */
> +#define IOMAP_ZONE_APPEND	(1 << 6) /* Use zone append for writes */

Why is this moved around?
