Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167D92BA57E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgKTJI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:08:27 -0500
Received: from verein.lst.de ([213.95.11.211]:42057 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgKTJIZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:08:25 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DA3867373; Fri, 20 Nov 2020 10:08:21 +0100 (CET)
Date:   Fri, 20 Nov 2020 10:08:20 +0100
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
Subject: Re: [PATCH 14/20] block: remove the nr_sects field in struct
 hd_struct
Message-ID: <20201120090820.GD21715@lst.de>
References: <20201118084800.2339180-1-hch@lst.de> <20201118084800.2339180-15-hch@lst.de> <20201119120525.GW1981@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119120525.GW1981@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:05:25PM +0100, Jan Kara wrote:
> > @@ -613,7 +613,7 @@ void guard_bio_eod(struct bio *bio)
> >  	rcu_read_lock();
> >  	part = __disk_get_part(bio->bi_disk, bio->bi_partno);
> >  	if (part)
> > -		maxsector = part_nr_sects_read(part);
> > +		maxsector = bdev_nr_sectors(part->bdev);
> >  	else
> >  		maxsector = get_capacity(bio->bi_disk);
> 
> I have to say that after these changes I find it a bit confusing that we
> have get/set_capacity() and bdev_nr_sectors() / bdev_set_nr_sectors() and
> they are all the same thing (i_size of the bdev). Is there a reason for the
> distinction?

get_capacity/set_capacity are the existing unchanged interfaces that
work on struct gendisk, and unchanged from what we had before.  They also
have lots of users which makes them kinda awkward to touch.

bdev_nr_sectors is the public interface to query the size for any
kind of struct block device, to be used by consumers of the block
device interface.

bdev_set_nr_sectors is a private helper for the partitions core that
avoids duplicating a bit of code, and works on partitions.



> > @@ -38,6 +38,16 @@ static void disk_add_events(struct gendisk *disk);
> >  static void disk_del_events(struct gendisk *disk);
> >  static void disk_release_events(struct gendisk *disk);
> >  
> > +void set_capacity(struct gendisk *disk, sector_t sectors)
> > +{
> > +	struct block_device *bdev = disk->part0.bdev;
> > +
> > +	spin_lock(&bdev->bd_size_lock);
> > +	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
> > +	spin_unlock(&bdev->bd_size_lock);
> 
> AFAICT bd_size_lock is pointless after these changes so we can just remove
> it?

I don't think it is, as reuqiring bd_mutex for size updates leads to
rather awkward lock ordering problems.

> >  	if (capacity != size && capacity != 0 && size != 0) {
> >  		char *envp[] = { "RESIZE=1", NULL };
> >  
> > +		pr_info("%s: detected capacity change from %lld to %lld\n",
> > +		       disk->disk_name, size, capacity);
> 
> So we are now missing above message for transitions from / to 0 capacity?
> Is there any other notification in the kernel log when e.g. media is
> inserted into a CD-ROM drive? I remember using these messages for detecting
> that...

True, I guess we should keep the messages for that case at least under
some circumstances.  Let me take a closer look at what could make sense.

> Also what about GENHD_FL_HIDDEN devices? Are we sure we never set capacity
> for them?

We absolutely set the capacity for them, as we have to.  And even use
this interface.  But yes, I think we should skip sending the uevent for
them.

> > @@ -1158,8 +1169,7 @@ ssize_t part_size_show(struct device *dev,
> >  {
> >  	struct hd_struct *p = dev_to_part(dev);
> >  
> > -	return sprintf(buf, "%llu\n",
> > -		(unsigned long long)part_nr_sects_read(p));
> > +	return sprintf(buf, "%llu\n", bdev_nr_sectors(p->bdev));
> 
> Is sector_t really guaranteed to be unsigned long long?

Yes, it is these days, ever since I removed the option to have a 32-bit
one on 32-bit platforms a while ago.
