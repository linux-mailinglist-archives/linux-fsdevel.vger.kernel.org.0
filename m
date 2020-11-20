Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035C82BA8E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 12:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgKTLVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 06:21:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:57330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbgKTLVX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:21:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4C79AED9;
        Fri, 20 Nov 2020 11:21:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2825E1E130B; Fri, 20 Nov 2020 12:21:21 +0100 (CET)
Date:   Fri, 20 Nov 2020 12:21:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 14/20] block: remove the nr_sects field in struct
 hd_struct
Message-ID: <20201120112121.GB15537@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-15-hch@lst.de>
 <20201119120525.GW1981@quack2.suse.cz>
 <20201120090820.GD21715@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120090820.GD21715@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 10:08:20, Christoph Hellwig wrote:
> On Thu, Nov 19, 2020 at 01:05:25PM +0100, Jan Kara wrote:
> > > @@ -613,7 +613,7 @@ void guard_bio_eod(struct bio *bio)
> > >  	rcu_read_lock();
> > >  	part = __disk_get_part(bio->bi_disk, bio->bi_partno);
> > >  	if (part)
> > > -		maxsector = part_nr_sects_read(part);
> > > +		maxsector = bdev_nr_sectors(part->bdev);
> > >  	else
> > >  		maxsector = get_capacity(bio->bi_disk);
> > 
> > I have to say that after these changes I find it a bit confusing that we
> > have get/set_capacity() and bdev_nr_sectors() / bdev_set_nr_sectors() and
> > they are all the same thing (i_size of the bdev). Is there a reason for the
> > distinction?
> 
> get_capacity/set_capacity are the existing unchanged interfaces that
> work on struct gendisk, and unchanged from what we had before.  They also
> have lots of users which makes them kinda awkward to touch.
> 
> bdev_nr_sectors is the public interface to query the size for any
> kind of struct block device, to be used by consumers of the block
> device interface.
> 
> bdev_set_nr_sectors is a private helper for the partitions core that
> avoids duplicating a bit of code, and works on partitions.

OK, I guess I'll get used to this...

> > > @@ -38,6 +38,16 @@ static void disk_add_events(struct gendisk *disk);
> > >  static void disk_del_events(struct gendisk *disk);
> > >  static void disk_release_events(struct gendisk *disk);
> > >  
> > > +void set_capacity(struct gendisk *disk, sector_t sectors)
> > > +{
> > > +	struct block_device *bdev = disk->part0.bdev;
> > > +
> > > +	spin_lock(&bdev->bd_size_lock);
> > > +	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
> > > +	spin_unlock(&bdev->bd_size_lock);
> > 
> > AFAICT bd_size_lock is pointless after these changes so we can just remove
> > it?
> 
> I don't think it is, as reuqiring bd_mutex for size updates leads to
> rather awkward lock ordering problems.

OK, let me ask differently: What is bd_size_lock protecting now? Ah, I see,
on 32-bit it is needed to prevent torn writes to i_size, right?

> > >  	if (capacity != size && capacity != 0 && size != 0) {
> > >  		char *envp[] = { "RESIZE=1", NULL };
> > >  
> > > +		pr_info("%s: detected capacity change from %lld to %lld\n",
> > > +		       disk->disk_name, size, capacity);
> > 
> > So we are now missing above message for transitions from / to 0 capacity?
> > Is there any other notification in the kernel log when e.g. media is
> > inserted into a CD-ROM drive? I remember using these messages for detecting
> > that...
> 
> True, I guess we should keep the messages for that case at least under
> some circumstances.  Let me take a closer look at what could make sense.
> 
> > Also what about GENHD_FL_HIDDEN devices? Are we sure we never set capacity
> > for them?
> 
> We absolutely set the capacity for them, as we have to.  And even use
> this interface.  But yes, I think we should skip sending the uevent for
> them.

Also previously we were not printing any messages for hidden devices and
now we do. I'm not sure whether that's intended or not.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
