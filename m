Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220481A929E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 07:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393399AbgDOFmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 01:42:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35285 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393395AbgDOFmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:42:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id t11so1012574pgg.2;
        Tue, 14 Apr 2020 22:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVRGT38XUU6swRwzPEXLZ5k+G+eQg7kh7o2o1EiB+e0=;
        b=BURb0KoXrGq3CeMemEwS/w7sasWpNmr4obb6UxIeGSij1vZZnTlbGq+ZriFI8wfwzj
         R7k3hiH2aFVm0SAUK3/dAptHSG+x60ITAmgvTgnEXxzLXIKI97hckoZUhBhkDUrtTOVt
         x2QNqTlLnLb7PpJSuuB3G9iIeY8mVtY/5m2m7LuI8wtgVaCINSi9Gc0JpzxYq6PVCuUj
         OdLXBuSoTlQYf1T2Luy5aZAqHWaX/l8h/hsD3YLSm3Mwinz2OMlqftmFRwnpqhvLfDTV
         s2QWHHKGcvyInT9KLQFCaW4jF+E6ao6tG5H1eV5QW6A5qoEE5lpAWkzCofuJ3hOJMrsw
         f2Ug==
X-Gm-Message-State: AGi0PuYC5+ADKGwXBniX2eHnYfqF54vF2Uu7pLcwy8+Xap4a0kG5oH9Q
        aMuCqQcid7hvRA7oLTBxQhw=
X-Google-Smtp-Source: APiQypLmh/Lgdr/B3ZY1buelbusFHBjMg4/XhSao7YfVHnutpJiQaiLvOKzKUkf7C36e2nFiqFgLgw==
X-Received: by 2002:a63:602:: with SMTP id 2mr25278301pgg.383.1586929356466;
        Tue, 14 Apr 2020 22:42:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p1sm13349461pjr.40.2020.04.14.22.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 22:42:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1E49F40277; Wed, 15 Apr 2020 05:42:34 +0000 (UTC)
Date:   Wed, 15 Apr 2020 05:42:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 4/5] mm/swapfile: refcount block and queue before using
 blkcg_schedule_throttle()
Message-ID: <20200415054234.GQ11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-5-mcgrof@kernel.org>
 <20200414154447.GC25765@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414154447.GC25765@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:44:47AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 14, 2020 at 04:19:01AM +0000, Luis Chamberlain wrote:
> > block devices are refcounted so to ensure once its final user goes away it
> > can be cleaned up by the lower layers properly. The block device's
> > request_queue structure is also refcounted, however, if the last
> > blk_put_queue() is called under atomic context the block layer has
> > to defer removal.
> > 
> > By refcounting the block device during the use of blkcg_schedule_throttle(),
> > we ensure ensure two things:
> > 
> > 1) the block device remains available during the call
> > 2) we ensure avoid having to deal with the fact we're using the
> >    request_queue structure in atomic context, since the last
> >    blk_put_queue() will be called upon disk_release(), *after*
> >    our own bdput().
> > 
> > This means this code path is *not* going to remove the request_queue
> > structure, as we are ensuring some later upper layer disk_release()
> > will be the one to release the request_queue structure for us.
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Nicolai Stange <nstange@suse.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: yu kuai <yukuai3@huawei.com>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  mm/swapfile.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 6659ab563448..9285ff6030ca 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3753,6 +3753,7 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
> >  void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
> >  				  gfp_t gfp_mask)
> >  {
> > +	struct block_device *bdev;
> >  	struct swap_info_struct *si, *next;
> >  	if (!(gfp_mask & __GFP_IO) || !memcg)
> >  		return;
> > @@ -3771,8 +3772,17 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
> >  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
> >  				  avail_lists[node]) {
> >  		if (si->bdev) {
> > -			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
> > -						true);
> > +			bdev = bdgrab(si->bdev);
> > +			if (!bdev)
> > +				continue;
> > +			/*
> > +			 * By adding our own bdgrab() we ensure the queue
> > +			 * sticks around until disk_release(), and so we ensure
> > +			 * our release of the request_queue does not happen in
> > +			 * atomic context.
> > +			 */
> > +			blkcg_schedule_throttle(bdev_get_queue(bdev), true);
> > +			bdput(bdev);
> 
> I don't understand the atomic part of the comment.  How does
> bdgrab/bdput help us there?

The commit log above did a better job at explaining this in terms of our
goal to use the request_queue and how this use would prevent the risk of
releasing the request_queue, which could sleep.

If its not clear still, at least why we'd escape the sleep potential
of the request_queue, we can just see its up to the disk_release()
to call the last blk_put_queue():

static void __device_add_disk(struct device *parent, struct gendisk disk,      
			      const struct attribute_group **groups,            
			      bool register_queue)                              
{   
	...
        /*                                                                      
	 * Take an extra ref on queue which will be put on disk_release()
	 * so that it sticks around as long as @disk is there.                  
	 */                                                                     
	WARN_ON_ONCE(!blk_get_queue(disk->queue));

	disk_add_events(disk);
	blk_integrity_add(disk);
}

static void disk_release(struct device *dev)                                    
{                                                                               
	struct gendisk *disk = dev_to_disk(dev);

	blk_free_devt(dev->devt);
	disk_release_events(disk);
	kfree(disk->random);
	disk_replace_part_tbl(disk, NULL);
	hd_free_part(&disk->part0);
	if (disk->queue)
		blk_put_queue(disk->queue);
	kfree(disk);
}     

I admit that all this however it did a poor job at explaining why
bdgrab()/bdput() was safe in atomic context other than the implicit
reasoning that we already do that elsewhere in atomic context.

bdgrab() specifically was added to be able to refcount a block device in
atomic context via commit dddac6a7b445 ("("PM / Hibernate: Replace bdget
call with simple atomic_inc of i_count"). In its latest incarnation we
have:

/**
 * bdgrab -- Grab a reference to an already referenced block device
 * @bdev:       Block device to grab a reference to.                            
 */
struct block_device *bdgrab(struct block_device *bdev)
{
	ihold(bdev->bd_inode);                                                  
	return bdev;                                                            
}                                                                               
EXPORT_SYMBOL(bdgrab); 

And this in turn:

/*                                                                              
 * get additional reference to inode; caller must already hold one.
 */
void ihold(struct inode *inode)                                                 
{                                                                               
	WARN_ON(atomic_inc_return(&inode->i_count) < 2);                        
}                                                                               
EXPORT_SYMBOL(ihold);

However... I'd eventure to say we don't have tribal knowledge documented
about why bdput() is safe in atomic context when used with bdgrab(),
including the commit log which added it. So the only thing backing its
safety is that we already use this combo in atomic context, and if its
incorrect, other areas would be incorrect as well.

But looking underneath the hood, I see at the end of __blkdev_get():

static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)  
{
	...
	disk = bdev_get_gendisk(bdev, &partno);
	...
        /* only one opener holds refs to the module and disk */                 
	if (!first_open)                                                        
		put_disk_and_module(disk); 
	...
}

So ihold() seems like a way to ensure the caller of bdgrab() won't be
this first opener. If only one opener holds the ref to the disk and it
was not us, we musn't be the one to decrease it, and if the disk is
held, it should mean the block device should be refcounted by it as
well. More review on this later part is appreciated though.

  Luis
