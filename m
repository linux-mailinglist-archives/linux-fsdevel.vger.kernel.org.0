Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46657191D0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 23:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgCXWqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 18:46:01 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:37229 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727554AbgCXWqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:46:00 -0400
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7EF203A3AC5;
        Wed, 25 Mar 2020 09:45:54 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jGsIy-00059z-Fk; Wed, 25 Mar 2020 09:45:52 +1100
Date:   Wed, 25 Mar 2020 09:45:52 +1100
From:   Dave Chinner <david@fromorbit.com>
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
Message-ID: <20200324224552.GI10737@dread.disaster.area>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324152454.4954-11-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=JF9118EUAAAA:8 a=7-415B0cAAAA:8 a=fhFG6ulkHv1obGMw_aYA:9
        a=yGqnPYzZc3v0PLXM:21 a=XexlqDWkxv1Qk9gv:21 a=CjuIK1q_8ugA:10
        a=SUkNg17ZEekA:10 a=xVlTc564ipvMDusKsbsT:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:24:53AM +0900, Johannes Thumshirn wrote:
> Use REQ_OP_ZONE_APPEND for direct I/O write BIOs, instead of REQ_OP_WRITE
> if the file-system requests it. The file system can make this request
> by setting the new flag IOCB_ZONE_APPEND for a direct I/O kiocb before
> calling iompa_dio_rw(). Using this information, this function propagates
> the zone append flag using IOMAP_ZONE_APPEND to the file system
> iomap_begin() method. The BIOs submitted for the zone append DIO will be
> set to use the REQ_OP_ZONE_APPEND operation.
> 
> Since zone append operations cannot be split, the iomap_apply() and
> iomap_dio_rw() internal loops are executed only once, which may result
> in short writes.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/iomap/direct-io.c  | 80 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/fs.h    |  1 +
>  include/linux/iomap.h | 22 ++++++------
>  3 files changed, 79 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 23837926c0c5..b3e2aadce72f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -17,6 +17,7 @@
>   * Private flags for iomap_dio, must not overlap with the public ones in
>   * iomap.h:
>   */
> +#define IOMAP_DIO_ZONE_APPEND	(1 << 27)
>  #define IOMAP_DIO_WRITE_FUA	(1 << 28)
>  #define IOMAP_DIO_NEED_SYNC	(1 << 29)
>  #define IOMAP_DIO_WRITE		(1 << 30)
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
> +
>  	if (atomic_dec_and_test(&dio->ref)) {
>  		if (dio->wait_for_completion) {
>  			struct task_struct *waiter = dio->submit.waiter;
> @@ -194,6 +199,21 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  	iomap_dio_submit_bio(dio, iomap, bio);
>  }
>  
> +static sector_t
> +iomap_dio_bio_sector(struct iomap_dio *dio, struct iomap *iomap, loff_t pos)
> +{
> +	sector_t sector = iomap_sector(iomap, pos);
> +
> +	/*
> +	 * For zone append writes, the BIO needs to point at the start of the
> +	 * zone to append to.
> +	 */
> +	if (dio->flags & IOMAP_DIO_ZONE_APPEND)
> +		sector = ALIGN_DOWN(sector, bdev_zone_sectors(iomap->bdev));
> +
> +	return sector;
> +}

This seems to me like it should be done by the ->iomap_begin
implementation when mapping the IO. I don't see why this needs to be
specially handled by the iomap dio code.

> +
>  static loff_t
>  iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		struct iomap_dio *dio, struct iomap *iomap)
> @@ -204,6 +224,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	struct bio *bio;
>  	bool need_zeroout = false;
>  	bool use_fua = false;
> +	bool zone_append = false;
>  	int nr_pages, ret = 0;
>  	size_t copied = 0;
>  	size_t orig_count;
> @@ -235,6 +256,9 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  			use_fua = true;
>  	}
>  
> +	if (dio->flags & IOMAP_DIO_ZONE_APPEND)
> +		zone_append = true;
> +
>  	/*
>  	 * Save the original count and trim the iter to just the extent we
>  	 * are operating on right now.  The iter will be re-expanded once
> @@ -266,12 +290,28 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  		bio = bio_alloc(GFP_KERNEL, nr_pages);
>  		bio_set_dev(bio, iomap->bdev);
> -		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> +		bio->bi_iter.bi_sector = iomap_dio_bio_sector(dio, iomap, pos);
>  		bio->bi_write_hint = dio->iocb->ki_hint;
>  		bio->bi_ioprio = dio->iocb->ki_ioprio;
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> +		if (dio->flags & IOMAP_DIO_WRITE) {
> +			bio->bi_opf = REQ_SYNC | REQ_IDLE;
> +			if (zone_append)
> +				bio->bi_opf |= REQ_OP_ZONE_APPEND;
> +			else
> +				bio->bi_opf |= REQ_OP_WRITE;
> +			if (use_fua)
> +				bio->bi_opf |= REQ_FUA;
> +			else
> +				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
> +		} else {
> +			bio->bi_opf = REQ_OP_READ;
> +			if (dio->flags & IOMAP_DIO_DIRTY)
> +				bio_set_pages_dirty(bio);
> +		}

Why move all this code? If it's needed, please split it into a
separate patchi to separate it from the new functionality...

> +
>  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
>  		if (unlikely(ret)) {
>  			/*
> @@ -284,19 +324,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  			goto zero_tail;
>  		}
>  
> -		n = bio->bi_iter.bi_size;
> -		if (dio->flags & IOMAP_DIO_WRITE) {
> -			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
> -			if (use_fua)
> -				bio->bi_opf |= REQ_FUA;
> -			else
> -				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
> +		if (dio->flags & IOMAP_DIO_WRITE)
>  			task_io_account_write(n);
> -		} else {
> -			bio->bi_opf = REQ_OP_READ;
> -			if (dio->flags & IOMAP_DIO_DIRTY)
> -				bio_set_pages_dirty(bio);
> -		}
> +
> +		n = bio->bi_iter.bi_size;
>  
>  		dio->size += n;
>  		pos += n;
> @@ -304,6 +335,15 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  
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

I don't think this sort of functionality should be tied to "zone
append". If there is a need for "issue a single (short) bio only" it
should be a flag to iomap_dio_rw() set by the filesystem, which can
then handle the short read/write that is returned.

> +		/*
> +		 * Zone append writes cannot be split and be shorted. Break
> +		 * here to let the user know instead of sending more IOs which
> +		 * could get reordered and corrupt the written data.
> +		 */
> +		if (flags & IOMAP_ZONE_APPEND)
> +			break;

ditto.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
