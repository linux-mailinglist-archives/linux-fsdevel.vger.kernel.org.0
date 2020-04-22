Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CDD1B38F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 09:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDVH3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 03:29:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36415 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgDVH3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:29:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id g30so649302pfr.3;
        Wed, 22 Apr 2020 00:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A3e0HviKM50W86dBXvHeRO1MivA7OYpbQFJS+clP/Nw=;
        b=Py1lV30A4GluJHUzWIQe7BHtIGY0mMy7DAkjcNRK1Df6fqpN2IZJ+uDW4z0U9Zt2vr
         QAl5uRYrqa6gJBogROH6UXdE1EhnpfFhBsm5ah2/qqFtLET1l8l6+RsWw3N7GIlA3Bhw
         K7QVUqrYZKPijTKMTFzr09ScYQe52fSAzygyuftBDWL1bJ4ddh8kVSbGO9b0yeM+zulm
         8c+HQ562WmzlietozIVLAuuDX0RJ6MrlA07CacNcYUXeMs/O1UsRKX1wb0vxkP9lrjaF
         55O8KPMDLlpAFjjmpx++u2KH5GX0r7bvBg3cV7V13Iwz5eP+spNtCuTc+yrzB2gmbiPv
         rppw==
X-Gm-Message-State: AGi0PuYj5WAl8YkRR+iXuVxZpZL++R+o6PvsvDAWB9Xe9S5nznSQUPqF
        58CJrBdUcSOvlKCSZxdM8zM=
X-Google-Smtp-Source: APiQypKIbTsG8MH/rRArgG+/oZOpJyciQKBwZDqLUDm9jCy/k5BU2kBmvjR3t7VNTX65gG8W7GNZsg==
X-Received: by 2002:aa7:9f48:: with SMTP id h8mr15020001pfr.147.1587540541665;
        Wed, 22 Apr 2020 00:29:01 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p66sm4393025pfb.65.2020.04.22.00.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 00:29:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 31FCB402A1; Wed, 22 Apr 2020 07:28:59 +0000 (UTC)
Date:   Wed, 22 Apr 2020 07:28:59 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200422072859.GQ11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200420201615.GC302402@kroah.com>
 <20200420204156.GO11244@42.do-not-panic.com>
 <20200421070048.GD347130@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421070048.GD347130@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:00:48AM +0200, Greg KH wrote:
> On Mon, Apr 20, 2020 at 08:41:56PM +0000, Luis Chamberlain wrote:
> > On Mon, Apr 20, 2020 at 10:16:15PM +0200, Greg KH wrote:
> > > On Sun, Apr 19, 2020 at 07:45:22PM +0000, Luis Chamberlain wrote:
> > > 
> > > This patch triggered gmail's spam detection, your changelog text is
> > > whack...
> > 
> > Oh? What do you think triggered it?
> 
> No idea.

Alright, well I'm going to move most of the analysis to the bug report
and be as concise as possible on the commit log.

> > > > diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> > > > index 19091e1effc0..d84038bce0a5 100644
> > > > --- a/block/blk-debugfs.c
> > > > +++ b/block/blk-debugfs.c
> > > > @@ -3,6 +3,9 @@
> > > >  /*
> > > >   * Shared request-based / make_request-based functionality
> > > >   */
> > > > +
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > +
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/blkdev.h>
> > > >  #include <linux/debugfs.h>
> > > > @@ -13,3 +16,30 @@ void blk_debugfs_register(void)
> > > >  {
> > > >  	blk_debugfs_root = debugfs_create_dir("block", NULL);
> > > >  }
> > > > +
> > > > +int __must_check blk_queue_debugfs_register(struct request_queue *q)
> > > > +{
> > > > +	struct dentry *dir = NULL;
> > > > +
> > > > +	/* This can happen if we have a bug in the lower layers */
> > > > +	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
> > > > +	if (dir) {
> > > > +		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
> > > > +			kobject_name(q->kobj.parent));
> > > > +		dput(dir);
> > > > +		return -EALREADY;
> > > > +	}
> > > > +
> > > > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > > +					    blk_debugfs_root);
> > > > +	if (!q->debugfs_dir)
> > > > +		return -ENOMEM;
> > > 
> > > Why doesn't the directory just live in the request queue, or somewhere
> > > else, so that you save it when it is created and then that's it.  No
> > > need to "look it up" anywhere else.
> > 
> > Its already there. And yes, after my changes it is technically possible
> > to just re-use it directly. But this is complicated by a few things. One
> > is that at this point in time, asynchronous request_queue removal is
> > still possible, and so a race was exposed where a requeust_queue may be
> > lingering but its old device is gone. That race is fixed by reverting us
> > back to synchronous request_queue removal, therefore ensuring that the
> > debugfs dir exists so long as the device does.
> > 
> > I can remove the debugfs_lookup() *after* we revert to synchronous
> > request_queue removal, or we just re-order the patches so that the
> > revert happens first. That should simplify this patch.
> > 
> > The code in this patch was designed to help dispute the logic behind
> > the CVE, in particular it shows exactly where debugfs_dir *is* the
> > one found by debugfs_lookup(), and shows the real issue behind the
> > removal.
> > 
> > But yeah, now that that is done, I hope its clear to all, and I think
> > this patch can be simplified if we just revert the async requeust_queue
> > removal first.
> 
> Don't try to "dispute" crazyness, that's not what kernel code is for.
> Just do the right thing, and simply saving off the pointer to the
> debugfs file when created is the "correct" thing to do, no matter what.
> No race conditions or anything else can happen when you do that.

Nope, races are still possible even if we move revert back to sync
request_queue removal, but I do believe that just reveals a bug
elsewhere, which I'll just fix as I think I know where this is.

> > > Or do you do that in later patches?  I only see this one at the moment,
> > > sorry...
> > > 
> > > >  static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> > > > +					    struct request_queue *q,
> > > >  					    struct blk_trace *bt)
> > > >  {
> > > >  	struct dentry *dir = NULL;
> > > >  
> > > > +	/* This can only happen if we have a bug on our lower layers */
> > > > +	if (!q->kobj.parent) {
> > > > +		pr_warn("%s: request_queue parent is gone\n", buts->name);
> > > 
> > > A kobject always has a parent, unless it has not been registered yet, so
> > > I don't know what you are testing could ever happen.
> > 
> > Or it has been kobject_del()'d?
> 
> If that happened, how in the world are you in this function anyway, as
> the request_queue is an invalid pointer at that point in time???

Nope, the block layer still finishes some work on it.

Drivers are allowed to cleanup a block device in this order, this
example,  is from the loop block driver:

static void loop_remove(struct loop_device *lo)                                 
{
	del_gendisk(lo->lo_disk);
	blk_cleanup_queue(lo->lo_queue);
	blk_mq_free_tag_set(&lo->tag_set);
	put_disk(lo->lo_disk);
	kfree(lo);
}   

At this point in time patch-wise we still haven't reverted back to
synchronous request_queue removal. Considering this, a race with the
parent disappearing can happen because the request_queue removal is
deferred, that is, the request_queue's kobject's release() call used
schedule_work() to finish off its removal. We expect the last
blk_put_queue() to be called at the end of blk_cleanup_queue(). Since
that is deferred and device_del() is called also at the end of
del_gendisk(), it means the release of the queue can happen in a
context where the disk is gone.

Although this issue is triggerable easily with the current async
request_queue removal, I can think of other ways to trigger an issue
here and one of them was suggested as possible by Christoph on the last
v1 patch series.

blk_queue_get() is not atomic and so what it returns can be incorrect:

bool blk_get_queue(struct request_queue *q)
{
	if (likely(!blk_queue_dying(q))) {
		__blk_get_queue(q);
		return true;
	}
	----> we can schedule here easily and move the queue to dying
	----> and race with blk_cleanup_queue() which will then allow
	----> code paths to incorrectly trigger the release of the queue
	----> in places we don't want
	return false;
}
EXPORT_SYMBOL(blk_get_queue);

Another area of concern I am seeing through code inspection is that
since the request_queue life depends on the disk, it seemse odd we call
device_del() before we remove the request_queue. If this is indeed
wrong, we could move the device_del() from del_gendisk() to
disk_release() triggered by the last put_disk().

I have a test now which shows that even if we revert back to synchronous
request_queue removal I can trigger a panic on the same use-after-free
case on debugfs on blktrace, and this is because we are overwriting the
same debugfs directory, and I think the above are its root causes.

I can fix this bug, but that just moves the bug to conflicts within
two sysfs objects already existing, and this is because add_disk()
(which calls __device_add_disk() doesn't return errors). This is both
a blk layer bug in the sense we never check for error and a driver bug
for allowing conflicts. All this just needs to be fixed, and although I
thought this could be done later, I think I'm just going to fix all this
now.

I have reproducer now which enables the same race with synchronous
request_queue removal, I'll work my way towards fixing all this...

> > A deferred requeust_queue removal shows this is possible, the parent is
> > taken underneath from us because the refcounting of this kobject is
> > already kobject_del()'d, and its actual removal scheduled for later.
> > The parent is taken underneath from us prior to the scheduled removal
> > completing.
> 
> No, a parent's reference is always valid while the child pointer is
> alive.

OK I'll keep thsi in mind then.

> There is an odd race condition right now that we are working on fixing
> if you notice another lkml thread, but that race will soon be fixed.

Got a pointer?

> So
> no need for every single user in the kernel to try to test for something
> like this (hint, this check is still wrong as with this logic, what
> could prevent parent from going away right _after_ you check it???)
> 
> Just remove this invalid check please.

Yeah sure, make sense.

> > > > +		return NULL;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * From a sysfs kobject perspective, the request_queue sits on top of
> > > > +	 * the gendisk, which has the name of the disk. We always create a
> > > > +	 * debugfs directory upon init for this gendisk kobject, so we re-use
> > > > +	 * that if blktrace is going to be done for it.
> > > > +	 */
> > > > +	if (blk_trace_target_disk(buts->name, kobject_name(q->kobj.parent))) {
> > > > +		if (!q->debugfs_dir) {
> > > > +			pr_warn("%s: expected request_queue debugfs_dir is not set\n",
> > > > +				buts->name);
> > > 
> > > What is userspace supposed to be able to do if they see this warning?
> > 
> > Userspace doesn't parse warnings, but the NULL ensures it won't crash
> > the kernel. The warn informs the kernel of a possible block layer bug.
> 
> Again, the code should not care if the pointer is NULL, as only debugfs
> deals with those pointers (and it can handle a NULL pointer just fine.)

Alright.

> > > > +			return NULL;
> > > > +		}
> > > > +		/*
> > > > +		 * debugfs_lookup() is used to ensure the directory is not
> > > > +		 * taken from underneath us. We must dput() it later once
> > > > +		 * done with it within blktrace.
> > > > +		 */
> > > > +		dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > > > +		if (!dir) {
> > > > +			pr_warn("%s: expected request_queue debugfs_dir dentry is gone\n",
> > > > +				buts->name);
> > > 
> > > Again, can't we just save the pointer when we create it and not have to
> > > look it up again?
> > 
> > Only if we do the revert of the requeust_queue removal first.
> 
> Your end goal should be no more debugfs_lookup() calls.  Hopefully by
> the end of this patch series, that is the result.

Alrighty.

> > > > +			return NULL;
> > > > +		}
> > > > +		 /*
> > > > +		 * This is a reaffirmation that debugfs_lookup() shall always
> > > > +		 * return the same dentry if it was already set.
> > > > +		 */
> > > 
> > > I'm all for reaffirmation and the like, but really, is this needed???
> > 
> > To those who were still not sure that the issue was not a debugfs issue
> > I hoped this to make it clear. But indeed, if we revert back to
> > synchronous request_queue removal, that should simplify this.
> 
> Again, don't pander to crazies :)

At least I didn't say it :)

  Luis
