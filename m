Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8066878308B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjHUS4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 14:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHUS4n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:56:43 -0400
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4EC26AB;
        Mon, 21 Aug 2023 11:55:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id C46B985;
        Mon, 21 Aug 2023 11:54:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id pHdO9yB_7Ztq; Mon, 21 Aug 2023 11:54:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id 0215745;
        Mon, 21 Aug 2023 11:54:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 0215745
Date:   Mon, 21 Aug 2023 11:54:04 -0700 (PDT)
From:   Eric Wheeler <bcache@lists.ewheeler.net>
To:     Jan Kara <jack@suse.cz>
cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-bcache@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Subject: Re: [PATCH 09/29] bcache: Convert to bdev_open_by_path()
In-Reply-To: <20230821175053.osjvbwnubr2k6q5q@quack3>
Message-ID: <4c14b62-22a-e9b4-ab2d-3272d0c0495e@ewheeler.net>
References: <20230810171429.31759-1-jack@suse.cz> <20230811110504.27514-9-jack@suse.cz> <fd7fc9e-8d24-972-4b63-7eae3d2931e2@ewheeler.net> <20230821175053.osjvbwnubr2k6q5q@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Aug 2023, Jan Kara wrote:
> On Sun 20-08-23 18:06:01, Eric Wheeler wrote:
> > On Fri, 11 Aug 2023, Jan Kara wrote:
> > > Convert bcache to use bdev_open_by_path() and pass the handle around.
> > > 
> > > CC: linux-bcache@vger.kernel.org
> > > CC: Coly Li <colyli@suse.de
> > > CC: Kent Overstreet <kent.overstreet@gmail.com>
> > > Acked-by: Coly Li <colyli@suse.de>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  drivers/md/bcache/bcache.h |  2 +
> > >  drivers/md/bcache/super.c  | 78 ++++++++++++++++++++------------------
> > >  2 files changed, 43 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> > > index 5a79bb3c272f..2aa3f2c1f719 100644
> > > --- a/drivers/md/bcache/bcache.h
> > > +++ b/drivers/md/bcache/bcache.h
> > > @@ -299,6 +299,7 @@ struct cached_dev {
> > >  	struct list_head	list;
> > >  	struct bcache_device	disk;
> > >  	struct block_device	*bdev;
> > > +	struct bdev_handle	*bdev_handle;
> > 
> > It looks like you've handled most if not all of the `block_device *bdev` 
> > refactor.  Can we drop `block_device *bdev` and fixup any remaining 
> > references?  More below.
> 
> Well, we could but it's a lot of churn - like 53 dereferences in bcache.
> So if bcache maintainer wants to go this way, sure we can do it. But
> preferably as a separate cleanup patch on top of this series because the
> series generates enough conflicts as is and this will make it considerably
> worse.

A separate cleanup patch seems reasonable, I'll defer to Coly on this one 
since he's the maintainer.  I just wanted to point out the possible issue.  
Thanks for your work on this.

--
Eric Wheeler



> 
> > > @@ -421,6 +422,7 @@ struct cache {
> > >  
> > >  	struct kobject		kobj;
> > >  	struct block_device	*bdev;
> > > +	struct bdev_handle	*bdev_handle;
> > 
> > ditto.
> > 
> > >  
> > >  	struct task_struct	*alloc_thread;
> > >  
> > > diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> > > index 0ae2b3676293..c11ac86be72b 100644
> > > --- a/drivers/md/bcache/super.c
> > > +++ b/drivers/md/bcache/super.c
> > > @@ -1368,8 +1368,8 @@ static void cached_dev_free(struct closure *cl)
> > >  	if (dc->sb_disk)
> > >  		put_page(virt_to_page(dc->sb_disk));
> > >  
> > > -	if (!IS_ERR_OR_NULL(dc->bdev))
> > > -		blkdev_put(dc->bdev, dc);
> > > +	if (dc->bdev_handle)
> > > +		bdev_release(dc->bdev_handle);
> > 
> > bdev_release does not reset dc->bdev, which could leave a hanging 
> > reference.
> 
> So after this, dc->bdev may reference freed block device that is true. But
> the original code did not cleanup dc->bdev either so things just stay as
> they were.
> 
> > > @@ -1444,7 +1444,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
> > >  /* Cached device - bcache superblock */
> > >  
> > >  static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
> > > -				 struct block_device *bdev,
> > > +				 struct bdev_handle *bdev_handle,
> > >  				 struct cached_dev *dc)
> > >  {
> > >  	const char *err = "cannot allocate memory";
> > > @@ -1452,14 +1452,15 @@ static int register_bdev(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
> > >  	int ret = -ENOMEM;
> > >  
> > >  	memcpy(&dc->sb, sb, sizeof(struct cache_sb));
> > > -	dc->bdev = bdev;
> > > +	dc->bdev_handle = bdev_handle;
> > > +	dc->bdev = bdev_handle->bdev;
> > 
> > If I understand correctly, this patch duplicates the dc->bdev reference to 
> > exist as dc->bdev_handle->bdev _and_ dc->bdev. (Same for changes related 
> > to `struct cache`.)
> 
> Well, dc->bdev isn't a reference anymore, just a shortcut so that people
> don't have to write the long dc->bdev_handle->bdev (plus it limits the
> churn this series generates as I've mentioned above). I can see why some
> people needn't like this duplication so sure we can clean it up if that's
> the concensus of bcache developers.
>  
> > This would mean future developers have to understand they are the same 
> > thing, and someone may not manage it correctly.
> > 
> > If block core is moving to `struct bdev_handle`, then can we drop 
> > `dc->bdev` and replace all occurances of `dc->bdev` with 
> > `bdev_handle->bdev`?  Or make an accessor macro/function like 
> > bdev_handle_get_bdev(dc->bdev_handle)?
> 
> Accessor is making things even longer and I don't see the benefit. So I'd
> just go with dc->bdev_handle->bdev.
> 
> > Unless I misunderstand something here, I would NACK this as written 
> > because it increases the liklihood of future developer error.  
> > 
> > I've added a few other comments below, but my comments are not exhaustive:
> > 
> > >  	dc->sb_disk = sb_disk;
> > >  
> > >  	if (cached_dev_init(dc, sb->block_size << 9))
> > >  		goto err;
> > >  
> > >  	err = "error creating kobject";
> > > -	if (kobject_add(&dc->disk.kobj, bdev_kobj(bdev), "bcache"))
> > > +	if (kobject_add(&dc->disk.kobj, bdev_kobj(dc->bdev), "bcache"))
> > >  		goto err;
> > >  	if (bch_cache_accounting_add_kobjs(&dc->accounting, &dc->disk.kobj))
> > >  		goto err;
> > > @@ -2216,8 +2217,8 @@ void bch_cache_release(struct kobject *kobj)
> > >  	if (ca->sb_disk)
> > >  		put_page(virt_to_page(ca->sb_disk));
> > >  
> > > -	if (!IS_ERR_OR_NULL(ca->bdev))
> > > -		blkdev_put(ca->bdev, ca);
> > > +	if (ca->bdev_handle)
> > > +		bdev_release(ca->bdev_handle);
> > >  
> > 
> > ca->bdev is not cleaned up
> 
> Well, same comment as with dc->bdev - the old code didn't cleanup the
> pointer either. Furthermore the structure is kfree()d in the line below so
> there is really no point in zeroing the pointer.
> 
> > >  	kfree(ca);
> > >  	module_put(THIS_MODULE);
> > > @@ -2337,16 +2338,18 @@ static int cache_alloc(struct cache *ca)
> > >  }
> > >  
> > >  static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
> > > -				struct block_device *bdev, struct cache *ca)
> > > +				struct bdev_handle *bdev_handle,
> > > +				struct cache *ca)
> > >  {
> > >  	const char *err = NULL; /* must be set for any error case */
> > >  	int ret = 0;
> > >  
> > >  	memcpy(&ca->sb, sb, sizeof(struct cache_sb));
> > > -	ca->bdev = bdev;
> > > +	ca->bdev_handle = bdev_handle;
> > > +	ca->bdev = bdev_handle->bdev;
> > >  	ca->sb_disk = sb_disk;
> > >  
> > > -	if (bdev_max_discard_sectors((bdev)))
> > > +	if (bdev_max_discard_sectors((bdev_handle->bdev)))
> > >  		ca->discard = CACHE_DISCARD(&ca->sb);
> > >  
> > >  	ret = cache_alloc(ca);
> > > @@ -2354,10 +2357,10 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
> > >  		/*
> > >  		 * If we failed here, it means ca->kobj is not initialized yet,
> > >  		 * kobject_put() won't be called and there is no chance to
> > > -		 * call blkdev_put() to bdev in bch_cache_release(). So we
> > > -		 * explicitly call blkdev_put() here.
> > > +		 * call bdev_release() to bdev in bch_cache_release(). So
> > > +		 * we explicitly call bdev_release() here.
> > >  		 */
> > > -		blkdev_put(bdev, ca);
> > > +		bdev_release(bdev_handle);
> > 
> > ca->bdev is not cleaned up
> 
> So ca->bdev doesn't really need to be cleaned up here and the original code
> wasn't cleaning it up either. So I don't see a problem here either... But
> maybe I miss something.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
