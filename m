Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A062C3F32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 12:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgKYLkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 06:40:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:51604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgKYLkq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:40:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F6BDAC41;
        Wed, 25 Nov 2020 11:40:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D8B791E130F; Wed, 25 Nov 2020 12:40:44 +0100 (CET)
Date:   Wed, 25 Nov 2020 12:40:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 11/20] block: reference struct block_device from struct
 hd_struct
Message-ID: <20201125114044.GC16944@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-12-hch@lst.de>
 <X708BTJ5njtbC2z1@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X708BTJ5njtbC2z1@mtj.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello!

On Tue 24-11-20 11:59:49, Tejun Heo wrote:
> > diff --git a/block/partitions/core.c b/block/partitions/core.c
> > index a02e224115943d..0ba0bf44b88af3 100644
> > --- a/block/partitions/core.c
> > +++ b/block/partitions/core.c
> > @@ -340,12 +340,11 @@ void delete_partition(struct hd_struct *part)
> >  	device_del(part_to_dev(part));
> >  
> >  	/*
> > -	 * Remove gendisk pointer from idr so that it cannot be looked up
> > -	 * while RCU period before freeing gendisk is running to prevent
> > -	 * use-after-free issues. Note that the device number stays
> > -	 * "in-use" until we really free the gendisk.
> > +	 * Remove the block device from the inode hash, so that it cannot be
> > +	 * looked up while waiting for the RCU grace period.
> >  	 */
> > -	blk_invalidate_devt(part_devt(part));
> > +	remove_inode_hash(part->bdev->bd_inode);
> 
> I don't think this is necessary now that the bdev and inode lifetimes are
> one. Before, punching out the association early was necessary because we
> could be in a situation where we can successfully look up a part from idr
> and then try to pin the associated disk which may already be freed. With the
> new code, the lookup is through the inode whose lifetime is one and the same
> with gendisk, so use-after-free isn't possible and __blkdev_get() will
> reliably reject such open attempts.

I think the remove_inode_hash() call is actually still needed. Consider a
situation when the disk is unplugged, gendisk gets destroyed, bdev still
lives on (e.g. because it is still open). Device gets re-plugged, gendisk
for the same device number gets created. But we really need new bdev for
this because from higher level POV this is completely new device. And the
old bdev needs to live on as long as it is open. So IMO we still need to
just unhash the inode and leave it lingering in the background.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
