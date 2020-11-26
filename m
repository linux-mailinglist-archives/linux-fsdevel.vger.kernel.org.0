Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF0A2C5B46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbgKZSAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 13:00:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:59130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391576AbgKZSAu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:00:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52B7BABD2;
        Thu, 26 Nov 2020 18:00:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BB5021E10D0; Thu, 26 Nov 2020 19:00:48 +0100 (CET)
Date:   Thu, 26 Nov 2020 19:00:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 36/44] block: allocate struct hd_struct as part of struct
 bdev_inode
Message-ID: <20201126180048.GA422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-37-hch@lst.de>
 <20201126173518.GV422@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126173518.GV422@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 18:35:18, Jan Kara wrote:
> On Thu 26-11-20 14:04:14, Christoph Hellwig wrote:
> > Allocate hd_struct together with struct block_device to pre-load
> > the lifetime rule changes in preparation of merging the two structures.
> > 
> > Note that part0 was previously embedded into struct gendisk, but is
> > a separate allocation now, and already points to the block_device instead
> > of the hd_struct.  The lifetime of struct gendisk is still controlled by
> > the struct device embedded in the part0 hd_struct.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Just one comment below. With that fixed feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > diff --git a/block/partitions/core.c b/block/partitions/core.c
> > index f397ec9922bd6e..9c7e6730fa6098 100644
> > --- a/block/partitions/core.c
> > +++ b/block/partitions/core.c
> > @@ -265,9 +265,9 @@ static const struct attribute_group *part_attr_groups[] = {
> >  static void part_release(struct device *dev)
> >  {
> >  	struct hd_struct *p = dev_to_part(dev);
> > +
> >  	blk_free_devt(dev->devt);
> > -	hd_free_part(p);
> > -	kfree(p);
> > +	bdput(p->bdev);
> >  }
> 
> I don't think hd_struct holds a reference to block_device, does it?
> bdev_alloc() now just assigns bdev->bd_part->bdev = bdev...

Now I understood this is probably correct - each partition (including
gendisk as 0 partition) holds the initial bdev reference and only when
corresponding kobject is getting destroyed we stop holding onto that
reference. Right?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
