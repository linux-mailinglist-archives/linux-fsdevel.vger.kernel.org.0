Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718BB2BA563
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKTJBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:01:47 -0500
Received: from verein.lst.de ([213.95.11.211]:42034 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgKTJBq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:01:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C98067373; Fri, 20 Nov 2020 10:01:42 +0100 (CET)
Date:   Fri, 20 Nov 2020 10:01:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 13/20] block: remove ->bd_contains
Message-ID: <20201120090142.GC21715@lst.de>
References: <20201118084800.2339180-1-hch@lst.de> <20201118084800.2339180-14-hch@lst.de> <20201119103253.GV1981@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119103253.GV1981@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:32:53AM +0100, Jan Kara wrote:
> > @@ -1521,7 +1510,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
> >  		if (bdev->bd_bdi == &noop_backing_dev_info)
> >  			bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
> >  	} else {
> > -		if (bdev->bd_contains == bdev) {
> > +		if (!bdev->bd_partno) {
> 
> This should be !bdev_is_partition(bdev) for consistency, right?

Yes.  Same for the same check further up for the !bdev->bd_openers
case.

> > +#define bdev_whole(_bdev) \
> > +	((_bdev)->bd_disk->part0.bdev)
> > +
> >  #define bdev_kobj(_bdev) \
> >  	(&part_to_dev((_bdev)->bd_part)->kobj)
> 
> I'd somewhat prefer if these helpers could actually be inline functions and
> not macros. I guess they are macros because hd_struct isn't in blk_types.h.
> But if we moved helpers to blkdev.h, we'd have all definitions we need...
> Is that a problem for some users?

As you pointed out the reason these are macros is that the obvious
placement doesn't work.  My plan was to look into cleaning up the block
headers, which are a complete mess between blk_types.h, bio.h, blkdev.h
and genhd.h after I'm done making sense of the data structures, so for
now I didn't want to move too much around.  Hopefully we'll be able to
convert these helpers to inlines once I'm done.
