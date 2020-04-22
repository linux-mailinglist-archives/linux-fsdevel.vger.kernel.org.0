Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D7F1B3EC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 12:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgDVKbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 06:31:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43084 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgDVKb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:31:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id x26so852675pgc.10;
        Wed, 22 Apr 2020 03:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sU5xzgRL9RpSHNkAgLs8EtgXTwr6bOsubaD2iUSY1Fs=;
        b=I0qyr+FslyFMwqVlZGTwCF8eGulhQ+Sla4hkwuDKlPpeh30mpTXOndmylfv+y/1KXb
         gtuzYM6hVqZvDnZnuHbCNeof99l4s3M4Dq3CaXr6cyrZfHeWXRBkb1MCWqGWMimWCeyY
         QUbct7h1ggnF3By4fRltGdEkWoFo2StVqaOv/THeTMVYDCkKl9vKhoQSs7HaVWVpqib5
         65AlGNIGnJeaOerlHFIWoznCYfG5D4SqAEVBkFpPUEimk9bkfK5lz+CouA+5Wg+3jgIj
         hA1qm0gr/BS98SsCzNCJialErzMHv3MbL3WgvOtAuwAFyl18xiNtkbLC/Pd6r6nYON3b
         wp6g==
X-Gm-Message-State: AGi0PuZh8LsImmDRCyRhgLjhZVnLdgQE3yc9OYVjkU3BxRR+Yg4Q0TY8
        /vVTbiYtKfDSsSZ/mORkaaQ=
X-Google-Smtp-Source: APiQypIV81fj+bXglVsbtncDM9L75Hd8mImMYXT3HWlSXBskgXvCbUNjOqpLlZfJQBjJpx92UT03pA==
X-Received: by 2002:a62:3784:: with SMTP id e126mr26417473pfa.303.1587551487018;
        Wed, 22 Apr 2020 03:31:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g3sm4809475pgd.64.2020.04.22.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:31:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1F267402A1; Wed, 22 Apr 2020 10:31:25 +0000 (UTC)
Date:   Wed, 22 Apr 2020 10:31:25 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, rostedt@goodmis.org,
        mingo@redhat.com, jack@suse.cz, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200422103124.GX11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200420201615.GC302402@kroah.com>
 <20200420204156.GO11244@42.do-not-panic.com>
 <20200421070048.GD347130@kroah.com>
 <20200422072859.GQ11244@42.do-not-panic.com>
 <20200422094320.GH299948@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422094320.GH299948@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:43:20PM +0800, Ming Lei wrote:
> On Wed, Apr 22, 2020 at 07:28:59AM +0000, Luis Chamberlain wrote:
> > On Tue, Apr 21, 2020 at 09:00:48AM +0200, Greg KH wrote:
> > > On Mon, Apr 20, 2020 at 08:41:56PM +0000, Luis Chamberlain wrote:
> > > > On Mon, Apr 20, 2020 at 10:16:15PM +0200, Greg KH wrote:
> > > > > On Sun, Apr 19, 2020 at 07:45:22PM +0000, Luis Chamberlain wrote:
> > > > > 
> > > > > This patch triggered gmail's spam detection, your changelog text is
> > > > > whack...
> > > > 
> > > > Oh? What do you think triggered it?
> > > 
> > > No idea.
> > 
> > Alright, well I'm going to move most of the analysis to the bug report
> > and be as concise as possible on the commit log.
> > 
> > > > > > diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> > > > > > index 19091e1effc0..d84038bce0a5 100644
> > > > > > --- a/block/blk-debugfs.c
> > > > > > +++ b/block/blk-debugfs.c
> > > > > > @@ -3,6 +3,9 @@
> > > > > >  /*
> > > > > >   * Shared request-based / make_request-based functionality
> > > > > >   */
> > > > > > +
> > > > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > > > +
> > > > > >  #include <linux/kernel.h>
> > > > > >  #include <linux/blkdev.h>
> > > > > >  #include <linux/debugfs.h>
> > > > > > @@ -13,3 +16,30 @@ void blk_debugfs_register(void)
> > > > > >  {
> > > > > >  	blk_debugfs_root = debugfs_create_dir("block", NULL);
> > > > > >  }
> > > > > > +
> > > > > > +int __must_check blk_queue_debugfs_register(struct request_queue *q)
> > > > > > +{
> > > > > > +	struct dentry *dir = NULL;
> > > > > > +
> > > > > > +	/* This can happen if we have a bug in the lower layers */
> > > > > > +	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
> > > > > > +	if (dir) {
> > > > > > +		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
> > > > > > +			kobject_name(q->kobj.parent));
> > > > > > +		dput(dir);
> > > > > > +		return -EALREADY;
> > > > > > +	}
> > > > > > +
> > > > > > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > > > > +					    blk_debugfs_root);
> > > > > > +	if (!q->debugfs_dir)
> > > > > > +		return -ENOMEM;
> > > > > 
> > > > > Why doesn't the directory just live in the request queue, or somewhere
> > > > > else, so that you save it when it is created and then that's it.  No
> > > > > need to "look it up" anywhere else.
> > > > 
> > > > Its already there. And yes, after my changes it is technically possible
> > > > to just re-use it directly. But this is complicated by a few things. One
> > > > is that at this point in time, asynchronous request_queue removal is
> > > > still possible, and so a race was exposed where a requeust_queue may be
> > > > lingering but its old device is gone. That race is fixed by reverting us
> > > > back to synchronous request_queue removal, therefore ensuring that the
> > > > debugfs dir exists so long as the device does.
> > > > 
> > > > I can remove the debugfs_lookup() *after* we revert to synchronous
> > > > request_queue removal, or we just re-order the patches so that the
> > > > revert happens first. That should simplify this patch.
> > > > 
> > > > The code in this patch was designed to help dispute the logic behind
> > > > the CVE, in particular it shows exactly where debugfs_dir *is* the
> > > > one found by debugfs_lookup(), and shows the real issue behind the
> > > > removal.
> > > > 
> > > > But yeah, now that that is done, I hope its clear to all, and I think
> > > > this patch can be simplified if we just revert the async requeust_queue
> > > > removal first.
> > > 
> > > Don't try to "dispute" crazyness, that's not what kernel code is for.
> > > Just do the right thing, and simply saving off the pointer to the
> > > debugfs file when created is the "correct" thing to do, no matter what.
> > > No race conditions or anything else can happen when you do that.
> > 
> > Nope, races are still possible even if we move revert back to sync
> > request_queue removal, but I do believe that just reveals a bug
> > elsewhere, which I'll just fix as I think I know where this is.
> > 
> > > > > Or do you do that in later patches?  I only see this one at the moment,
> > > > > sorry...
> > > > > 
> > > > > >  static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> > > > > > +					    struct request_queue *q,
> > > > > >  					    struct blk_trace *bt)
> > > > > >  {
> > > > > >  	struct dentry *dir = NULL;
> > > > > >  
> > > > > > +	/* This can only happen if we have a bug on our lower layers */
> > > > > > +	if (!q->kobj.parent) {
> > > > > > +		pr_warn("%s: request_queue parent is gone\n", buts->name);
> > > > > 
> > > > > A kobject always has a parent, unless it has not been registered yet, so
> > > > > I don't know what you are testing could ever happen.
> > > > 
> > > > Or it has been kobject_del()'d?
> > > 
> > > If that happened, how in the world are you in this function anyway, as
> > > the request_queue is an invalid pointer at that point in time???
> > 
> > Nope, the block layer still finishes some work on it.
> > 
> > Drivers are allowed to cleanup a block device in this order, this
> > example,  is from the loop block driver:
> > 
> > static void loop_remove(struct loop_device *lo)                                 
> > {
> > 	del_gendisk(lo->lo_disk);
> > 	blk_cleanup_queue(lo->lo_queue);
> > 	blk_mq_free_tag_set(&lo->tag_set);
> > 	put_disk(lo->lo_disk);
> > 	kfree(lo);
> > }   
> > 
> > At this point in time patch-wise we still haven't reverted back to
> > synchronous request_queue removal. Considering this, a race with the
> > parent disappearing can happen because the request_queue removal is
> > deferred, that is, the request_queue's kobject's release() call used
> > schedule_work() to finish off its removal. We expect the last
> > blk_put_queue() to be called at the end of blk_cleanup_queue(). Since
> 
> Actually no, we expect that request queue is released after disk is
> released. Don't forget that gendisk does hold one extra refcount of
> request queue.

Ah yes.

Still the device_del() occurs before, this means the sysfs path
is cleared for a new device to come in as well, and this can happen
even with synchronous request_queue removal.

I have some changes to try to help address this now.

> > that is deferred and device_del() is called also at the end of
> > del_gendisk(), it means the release of the queue can happen in a
> > context where the disk is gone.
> > 
> > Although this issue is triggerable easily with the current async
> > request_queue removal, I can think of other ways to trigger an issue
> > here and one of them was suggested as possible by Christoph on the last
> > v1 patch series.
> > 
> > blk_queue_get() is not atomic and so what it returns can be incorrect:
> > 
> > bool blk_get_queue(struct request_queue *q)
> > {
> > 	if (likely(!blk_queue_dying(q))) {
> > 		__blk_get_queue(q);
> > 		return true;
> > 	}
> > 	----> we can schedule here easily and move the queue to dying
> > 	----> and race with blk_cleanup_queue() which will then allow
> > 	----> code paths to incorrectly trigger the release of the queue
> > 	----> in places we don't want
> 
> Right, actually caller of blk_get_queue() has to guarantee that
> the request queue is alive.

Sure.

> Some users of blk_get_queue() aren't necessary, such as rbd and mmc.

Are you saying we can remove those calls on rbd / mmc or something else?

> 
> > 	return false;
> > }
> > EXPORT_SYMBOL(blk_get_queue);
> > 
> > Another area of concern I am seeing through code inspection is that
> > since the request_queue life depends on the disk, it seemse odd we call
> > device_del() before we remove the request_queue. If this is indeed
> > wrong, we could move the device_del() from del_gendisk() to
> > disk_release() triggered by the last put_disk().
> 
> Why do you think it is odd and want to change this way? Disk has to be
> removed first for draining dirty pages to queue, then we can cleanup
> queue. Once we start to clean up request queue, all data may not land
> disk any more.

I think that all that can be done as-is today, an issue I suspect exists
is that we remove the disk from syfs hierarchy prior to the request
queue, whereas we expect this to be in the inverse order.

> > I have a test now which shows that even if we revert back to synchronous
> > request_queue removal I can trigger a panic on the same use-after-free
> > case on debugfs on blktrace, and this is because we are overwriting the
> > same debugfs directory, and I think the above are its root causes.
> 
> The reason should be shared debugfs dir between blktrace and blk-mq
> debugfs.

I think its something else.

> > I can fix this bug, but that just moves the bug to conflicts within
> > two sysfs objects already existing, and this is because add_disk()
> > (which calls __device_add_disk() doesn't return errors). This is both
> > a blk layer bug in the sense we never check for error and a driver bug
> > for allowing conflicts. All this just needs to be fixed, and although I
> > thought this could be done later, I think I'm just going to fix all this
> > now.
> 
> Yeah, we talked that several times, looks no one tries to post patch to
> fix that.

Consider this done, just need to brush it up now and send for review.

  Luis
