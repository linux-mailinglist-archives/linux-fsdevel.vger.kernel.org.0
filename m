Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B57270B76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 09:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgISHbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 03:31:49 -0400
Received: from verein.lst.de ([213.95.11.211]:35136 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgISHbt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 03:31:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 544E068BEB; Sat, 19 Sep 2020 09:31:45 +0200 (CEST)
Date:   Sat, 19 Sep 2020 09:31:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 06/12] block: lift setting the readahead size into the
 block layer
Message-ID: <20200919073145.GA8514@lst.de>
References: <20200910144833.742260-1-hch@lst.de> <20200910144833.742260-7-hch@lst.de> <20200917103540.GL7347@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917103540.GL7347@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:35:40PM +0200, Jan Kara wrote:
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index 81722cdcf0cb21..95eb35324e1a61 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -245,7 +245,6 @@ queue_max_sectors_store(struct request_queue *q, const char *page, size_t count)
> >  
> >  	spin_lock_irq(&q->queue_lock);
> >  	q->limits.max_sectors = max_sectors_kb << 1;
> > -	q->backing_dev_info->io_pages = max_sectors_kb >> (PAGE_SHIFT - 10);
> >  	spin_unlock_irq(&q->queue_lock);
> 
> So do I get it right that readahead won't now be limited if you store lower
> value to max_sectors? Why? I'd consider io_pages a "cached value" of
> max_sectors and thus expect it to change together with max_sectors...

Most to start untangling the bdi from the queue.  But I had to peddle
back on that in the follow on series anyway, so I can add this back.

> > @@ -812,7 +813,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
> >  		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
> >  		disk->flags |= GENHD_FL_NO_PART_SCAN;
> >  	} else {
> > -		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
> > +		struct backing_dev_info *bdi = q->backing_dev_info;
> >  		struct device *dev = disk_to_dev(disk);
> >  		int ret;
> 
> Not sure how/why these changes got here... Not that I care too much :)

Because more changes in this area in earlier versions of the patches.
But yes, this shouldn't be here, so I'll drop it.

> > @@ -407,7 +406,6 @@ aoeblk_gdalloc(void *vp)
> >  	WARN_ON(d->gd);
> >  	WARN_ON(d->flags & DEVFL_UP);
> >  	blk_queue_max_hw_sectors(q, BLK_DEF_MAX_SECTORS);
> > -	q->backing_dev_info->ra_pages = READ_AHEAD / PAGE_SIZE;
> >  	d->bufpool = mp;
> >  	d->blkq = gd->queue = q;
> >  	q->queuedata = d;
> 
> Shouldn't AOE set 2MB optimal IO size so that readahead is equivalent to
> previous behavior?

Sure, I'll add a separate patch just for that.

> > diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> > index 1bbdc410ee3c51..ff2101d56cd7f1 100644
> > --- a/drivers/md/bcache/super.c
> > +++ b/drivers/md/bcache/super.c
> > @@ -1427,10 +1427,6 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
> >  	if (ret)
> >  		return ret;
> >  
> > -	dc->disk.disk->queue->backing_dev_info->ra_pages =
> > -		max(dc->disk.disk->queue->backing_dev_info->ra_pages,
> > -		    q->backing_dev_info->ra_pages);
> > -
> 
> So bcache is basically stacking readahead here on top of underlying cache
> device. I don't see this being replicated by your patch so it is lost now?
> Probably this should be replaced by properly inheriting optimal IO size?

Yes, I'll add another patch.
