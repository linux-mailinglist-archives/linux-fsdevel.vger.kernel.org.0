Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476E6195C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgC0RKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:10:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0RKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WYm/P7NI9gWWu9ABo8IAp+qUHk06SsyjTGo2J5TCG6I=; b=lZcn4J+z7a1xgQZhZYCAK6gHrO
        tV1iiKXLT/k8RzCmI30D78o9jjuPm/xhYSuAMFFF+3b4Klm8LlZw4IZjlz9JhAusQv4+0sJyK4qoU
        3Fwf3d/pzFrirC66mI0c5DHVq1XwurVyqVKmMsHiWcqIZPCpjOSqGVKfU3Ij8JM2os8SRxxbJNlz/
        /7P2mgCp1F8rPunD8roHHJL8pJRO4NiI7wWG7yD54chBEan3r/6kmOAGsHFWDrPcw1Q8yRIO2J8oZ
        EZmiQhIJTwKe8hswJTqR3mnb7eNzQZ9ZE50coK13dTtbz9KBLDEvbeqjIFuaEeJlIUoK9yexTcV/x
        YcG2c/hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHsUh-0004I2-9K; Fri, 27 Mar 2020 17:10:07 +0000
Date:   Fri, 27 Mar 2020 10:10:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
Message-ID: <20200327171007.GB11524@infradead.org>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-11-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165012.34443-11-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 01:50:12AM +0900, Johannes Thumshirn wrote:
> Synchronous direct I/O to a sequential write only zone can be issued using
> the new REQ_OP_ZONE_APPEND request operation. As dispatching multiple
> BIOs can potentially result in reordering, we cannot support asynchronous
> IO via this interface.

We trivially can if the write size is smaller than the supported zone
append size.  We could slightly less trivially by chaining a new
submission after the first bio completes.

> +static void zonefs_zone_append_bio_endio(struct bio *bio)
> +{
> +	struct task_struct *waiter = bio->bi_private;
> +
> +	WRITE_ONCE(bio->bi_private, NULL);
> +	blk_wake_io_task(waiter);
> +
> +	bio_release_pages(bio, false);
> +	bio_put(bio);
> +}
> +
> +static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	struct block_device *bdev = inode->i_sb->s_bdev;
> +	ssize_t ret = 0;
> +	ssize_t size;
> +	struct bio *bio;
> +	unsigned max;
> +	int nr_pages;
> +	blk_qc_t qc;
> +
> +	nr_pages = iov_iter_npages(from, BIO_MAX_PAGES);
> +	if (!nr_pages)
> +		return 0;
> +
> +	max = queue_max_zone_append_sectors(bdev_get_queue(bdev)) << 9;
> +	max = ALIGN_DOWN(max, inode->i_sb->s_blocksize);
> +	iov_iter_truncate(from, max);
> +
> +	bio = bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);
> +	if (!bio)
> +		return -ENOMEM;
> +
> +	bio_set_dev(bio, bdev);
> +	bio->bi_iter.bi_sector = zi->i_zsector;
> +	bio->bi_write_hint = iocb->ki_hint;
> +	bio->bi_private = current;
> +	bio->bi_end_io = zonefs_zone_append_bio_endio;
> +	bio->bi_ioprio = iocb->ki_ioprio;
> +	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
> +	if (iocb->ki_flags & IOCB_DSYNC)
> +		bio->bi_opf |= REQ_FUA;
> +
> +	ret = bio_iov_iter_get_pages(bio, from);
> +	if (unlikely(ret)) {
> +		bio->bi_status = BLK_STS_IOERR;
> +		bio_endio(bio);
> +		return ret;
> +	}
> +	size = bio->bi_iter.bi_size;
> +	task_io_account_write(ret);
> +
> +	if (iocb->ki_flags & IOCB_HIPRI)
> +		bio_set_polled(bio, iocb);
> +
> +	bio_get(bio);
> +	qc = submit_bio(bio);
> +	for (;;) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (!READ_ONCE(bio->bi_private))
> +			break;
> +		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> +		    !blk_poll(bdev_get_queue(bdev), qc, true))
> +			io_schedule();
> +	}
> +	__set_current_state(TASK_RUNNING);
> +
> +	if (unlikely(bio->bi_status))
> +		ret = blk_status_to_errno(bio->bi_status);
> +
> +	bio_put(bio);
> +
> +	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
> +	if (ret >= 0) {
> +		iocb->ki_pos += size;
> +		return size;
> +	}
> +
> +	return ret;

This looks like no one waits for I/O completion?   Also it looks
like it silently causes a short write, which probably needs to be
documented..
