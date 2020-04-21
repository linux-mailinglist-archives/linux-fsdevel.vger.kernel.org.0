Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A351B1F62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 09:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDUHAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 03:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgDUHAv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:00:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59138206A5;
        Tue, 21 Apr 2020 07:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587452450;
        bh=zj9d9cwdHZ5qHikaJDBubllxAlkLIGcOH7Hj3crnKcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMK6nl0EyaFuaRtNuMsz/e5jUwPHi2u02DWp2g2sLTfVNXzMWYILZOM6BCKprGkE9
         8q8w0L+SDJwuCI+QnBVkBTOjUnHqyH9jqEdAfZdiUJsRrHOgGPo0tmntLaBRl8HKJF
         I1zhcg99WhKMQsTb606k/nO+lmvevgM/peUuU1BI=
Date:   Tue, 21 Apr 2020 09:00:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <20200421070048.GD347130@kroah.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200420201615.GC302402@kroah.com>
 <20200420204156.GO11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420204156.GO11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:41:56PM +0000, Luis Chamberlain wrote:
> On Mon, Apr 20, 2020 at 10:16:15PM +0200, Greg KH wrote:
> > On Sun, Apr 19, 2020 at 07:45:22PM +0000, Luis Chamberlain wrote:
> > 
> > This patch triggered gmail's spam detection, your changelog text is
> > whack...
> 
> Oh? What do you think triggered it?

No idea.

> 
> > > diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> > > index 19091e1effc0..d84038bce0a5 100644
> > > --- a/block/blk-debugfs.c
> > > +++ b/block/blk-debugfs.c
> > > @@ -3,6 +3,9 @@
> > >  /*
> > >   * Shared request-based / make_request-based functionality
> > >   */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > >  #include <linux/kernel.h>
> > >  #include <linux/blkdev.h>
> > >  #include <linux/debugfs.h>
> > > @@ -13,3 +16,30 @@ void blk_debugfs_register(void)
> > >  {
> > >  	blk_debugfs_root = debugfs_create_dir("block", NULL);
> > >  }
> > > +
> > > +int __must_check blk_queue_debugfs_register(struct request_queue *q)
> > > +{
> > > +	struct dentry *dir = NULL;
> > > +
> > > +	/* This can happen if we have a bug in the lower layers */
> > > +	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
> > > +	if (dir) {
> > > +		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
> > > +			kobject_name(q->kobj.parent));
> > > +		dput(dir);
> > > +		return -EALREADY;
> > > +	}
> > > +
> > > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > +					    blk_debugfs_root);
> > > +	if (!q->debugfs_dir)
> > > +		return -ENOMEM;
> > 
> > Why doesn't the directory just live in the request queue, or somewhere
> > else, so that you save it when it is created and then that's it.  No
> > need to "look it up" anywhere else.
> 
> Its already there. And yes, after my changes it is technically possible
> to just re-use it directly. But this is complicated by a few things. One
> is that at this point in time, asynchronous request_queue removal is
> still possible, and so a race was exposed where a requeust_queue may be
> lingering but its old device is gone. That race is fixed by reverting us
> back to synchronous request_queue removal, therefore ensuring that the
> debugfs dir exists so long as the device does.
> 
> I can remove the debugfs_lookup() *after* we revert to synchronous
> request_queue removal, or we just re-order the patches so that the
> revert happens first. That should simplify this patch.
> 
> The code in this patch was designed to help dispute the logic behind
> the CVE, in particular it shows exactly where debugfs_dir *is* the
> one found by debugfs_lookup(), and shows the real issue behind the
> removal.
> 
> But yeah, now that that is done, I hope its clear to all, and I think
> this patch can be simplified if we just revert the async requeust_queue
> removal first.

Don't try to "dispute" crazyness, that's not what kernel code is for.
Just do the right thing, and simply saving off the pointer to the
debugfs file when created is the "correct" thing to do, no matter what.
No race conditions or anything else can happen when you do that.

> > Or do you do that in later patches?  I only see this one at the moment,
> > sorry...
> > 
> > >  static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> > > +					    struct request_queue *q,
> > >  					    struct blk_trace *bt)
> > >  {
> > >  	struct dentry *dir = NULL;
> > >  
> > > +	/* This can only happen if we have a bug on our lower layers */
> > > +	if (!q->kobj.parent) {
> > > +		pr_warn("%s: request_queue parent is gone\n", buts->name);
> > 
> > A kobject always has a parent, unless it has not been registered yet, so
> > I don't know what you are testing could ever happen.
> 
> Or it has been kobject_del()'d?

If that happened, how in the world are you in this function anyway, as
the request_queue is an invalid pointer at that point in time???

> A deferred requeust_queue removal shows this is possible, the parent is
> taken underneath from us because the refcounting of this kobject is
> already kobject_del()'d, and its actual removal scheduled for later.
> The parent is taken underneath from us prior to the scheduled removal
> completing.

No, a parent's reference is always valid while the child pointer is
alive.

There is an odd race condition right now that we are working on fixing
if you notice another lkml thread, but that race will soon be fixed.  So
no need for every single user in the kernel to try to test for something
like this (hint, this check is still wrong as with this logic, what
could prevent parent from going away right _after_ you check it???)

Just remove this invalid check please.

> > > +		return NULL;
> > > +	}
> > > +
> > > +	/*
> > > +	 * From a sysfs kobject perspective, the request_queue sits on top of
> > > +	 * the gendisk, which has the name of the disk. We always create a
> > > +	 * debugfs directory upon init for this gendisk kobject, so we re-use
> > > +	 * that if blktrace is going to be done for it.
> > > +	 */
> > > +	if (blk_trace_target_disk(buts->name, kobject_name(q->kobj.parent))) {
> > > +		if (!q->debugfs_dir) {
> > > +			pr_warn("%s: expected request_queue debugfs_dir is not set\n",
> > > +				buts->name);
> > 
> > What is userspace supposed to be able to do if they see this warning?
> 
> Userspace doesn't parse warnings, but the NULL ensures it won't crash
> the kernel. The warn informs the kernel of a possible block layer bug.

Again, the code should not care if the pointer is NULL, as only debugfs
deals with those pointers (and it can handle a NULL pointer just fine.)

> > > +			return NULL;
> > > +		}
> > > +		/*
> > > +		 * debugfs_lookup() is used to ensure the directory is not
> > > +		 * taken from underneath us. We must dput() it later once
> > > +		 * done with it within blktrace.
> > > +		 */
> > > +		dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > > +		if (!dir) {
> > > +			pr_warn("%s: expected request_queue debugfs_dir dentry is gone\n",
> > > +				buts->name);
> > 
> > Again, can't we just save the pointer when we create it and not have to
> > look it up again?
> 
> Only if we do the revert of the requeust_queue removal first.

Your end goal should be no more debugfs_lookup() calls.  Hopefully by
the end of this patch series, that is the result.

> > > +			return NULL;
> > > +		}
> > > +		 /*
> > > +		 * This is a reaffirmation that debugfs_lookup() shall always
> > > +		 * return the same dentry if it was already set.
> > > +		 */
> > 
> > I'm all for reaffirmation and the like, but really, is this needed???
> 
> To those who were still not sure that the issue was not a debugfs issue
> I hoped this to make it clear. But indeed, if we revert back to
> synchronous request_queue removal, that should simplify this.

Again, don't pander to crazies :)

thanks,

greg k-h
