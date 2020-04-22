Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B085B1B3BA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 11:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgDVJnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 05:43:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgDVJns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587548625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ngmo1v7UlTjBtHXkdIAR6CVQRH0Anc2j7dfZIJYp0bk=;
        b=SMXjhCaOkrEFJVJeZC+/luPzTq9FPlQfae5aApsNVp7a/hwJxJWOB4vjgN/LUi2atfCPs0
        Y2JxPvQaEw97UCqczixXPEQVLAJO1C2WSwvqd1oB5Tisbb3sUv9t879CvyW9drpQOeEstY
        n436TngaImeRmy8R8xCTWIebCFu8Ubk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-n5JIfCLNOYCNCKOtqlm7Iw-1; Wed, 22 Apr 2020 05:43:41 -0400
X-MC-Unique: n5JIfCLNOYCNCKOtqlm7Iw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4937190B2A0;
        Wed, 22 Apr 2020 09:43:38 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DA465C1D4;
        Wed, 22 Apr 2020 09:43:25 +0000 (UTC)
Date:   Wed, 22 Apr 2020 17:43:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <20200422094320.GH299948@T590>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200420201615.GC302402@kroah.com>
 <20200420204156.GO11244@42.do-not-panic.com>
 <20200421070048.GD347130@kroah.com>
 <20200422072859.GQ11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422072859.GQ11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 07:28:59AM +0000, Luis Chamberlain wrote:
> On Tue, Apr 21, 2020 at 09:00:48AM +0200, Greg KH wrote:
> > On Mon, Apr 20, 2020 at 08:41:56PM +0000, Luis Chamberlain wrote:
> > > On Mon, Apr 20, 2020 at 10:16:15PM +0200, Greg KH wrote:
> > > > On Sun, Apr 19, 2020 at 07:45:22PM +0000, Luis Chamberlain wrote:
> > > > 
> > > > This patch triggered gmail's spam detection, your changelog text is
> > > > whack...
> > > 
> > > Oh? What do you think triggered it?
> > 
> > No idea.
> 
> Alright, well I'm going to move most of the analysis to the bug report
> and be as concise as possible on the commit log.
> 
> > > > > diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> > > > > index 19091e1effc0..d84038bce0a5 100644
> > > > > --- a/block/blk-debugfs.c
> > > > > +++ b/block/blk-debugfs.c
> > > > > @@ -3,6 +3,9 @@
> > > > >  /*
> > > > >   * Shared request-based / make_request-based functionality
> > > > >   */
> > > > > +
> > > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > > +
> > > > >  #include <linux/kernel.h>
> > > > >  #include <linux/blkdev.h>
> > > > >  #include <linux/debugfs.h>
> > > > > @@ -13,3 +16,30 @@ void blk_debugfs_register(void)
> > > > >  {
> > > > >  	blk_debugfs_root = debugfs_create_dir("block", NULL);
> > > > >  }
> > > > > +
> > > > > +int __must_check blk_queue_debugfs_register(struct request_queue *q)
> > > > > +{
> > > > > +	struct dentry *dir = NULL;
> > > > > +
> > > > > +	/* This can happen if we have a bug in the lower layers */
> > > > > +	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
> > > > > +	if (dir) {
> > > > > +		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
> > > > > +			kobject_name(q->kobj.parent));
> > > > > +		dput(dir);
> > > > > +		return -EALREADY;
> > > > > +	}
> > > > > +
> > > > > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > > > +					    blk_debugfs_root);
> > > > > +	if (!q->debugfs_dir)
> > > > > +		return -ENOMEM;
> > > > 
> > > > Why doesn't the directory just live in the request queue, or somewhere
> > > > else, so that you save it when it is created and then that's it.  No
> > > > need to "look it up" anywhere else.
> > > 
> > > Its already there. And yes, after my changes it is technically possible
> > > to just re-use it directly. But this is complicated by a few things. One
> > > is that at this point in time, asynchronous request_queue removal is
> > > still possible, and so a race was exposed where a requeust_queue may be
> > > lingering but its old device is gone. That race is fixed by reverting us
> > > back to synchronous request_queue removal, therefore ensuring that the
> > > debugfs dir exists so long as the device does.
> > > 
> > > I can remove the debugfs_lookup() *after* we revert to synchronous
> > > request_queue removal, or we just re-order the patches so that the
> > > revert happens first. That should simplify this patch.
> > > 
> > > The code in this patch was designed to help dispute the logic behind
> > > the CVE, in particular it shows exactly where debugfs_dir *is* the
> > > one found by debugfs_lookup(), and shows the real issue behind the
> > > removal.
> > > 
> > > But yeah, now that that is done, I hope its clear to all, and I think
> > > this patch can be simplified if we just revert the async requeust_queue
> > > removal first.
> > 
> > Don't try to "dispute" crazyness, that's not what kernel code is for.
> > Just do the right thing, and simply saving off the pointer to the
> > debugfs file when created is the "correct" thing to do, no matter what.
> > No race conditions or anything else can happen when you do that.
> 
> Nope, races are still possible even if we move revert back to sync
> request_queue removal, but I do believe that just reveals a bug
> elsewhere, which I'll just fix as I think I know where this is.
> 
> > > > Or do you do that in later patches?  I only see this one at the moment,
> > > > sorry...
> > > > 
> > > > >  static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> > > > > +					    struct request_queue *q,
> > > > >  					    struct blk_trace *bt)
> > > > >  {
> > > > >  	struct dentry *dir = NULL;
> > > > >  
> > > > > +	/* This can only happen if we have a bug on our lower layers */
> > > > > +	if (!q->kobj.parent) {
> > > > > +		pr_warn("%s: request_queue parent is gone\n", buts->name);
> > > > 
> > > > A kobject always has a parent, unless it has not been registered yet, so
> > > > I don't know what you are testing could ever happen.
> > > 
> > > Or it has been kobject_del()'d?
> > 
> > If that happened, how in the world are you in this function anyway, as
> > the request_queue is an invalid pointer at that point in time???
> 
> Nope, the block layer still finishes some work on it.
> 
> Drivers are allowed to cleanup a block device in this order, this
> example,  is from the loop block driver:
> 
> static void loop_remove(struct loop_device *lo)                                 
> {
> 	del_gendisk(lo->lo_disk);
> 	blk_cleanup_queue(lo->lo_queue);
> 	blk_mq_free_tag_set(&lo->tag_set);
> 	put_disk(lo->lo_disk);
> 	kfree(lo);
> }   
> 
> At this point in time patch-wise we still haven't reverted back to
> synchronous request_queue removal. Considering this, a race with the
> parent disappearing can happen because the request_queue removal is
> deferred, that is, the request_queue's kobject's release() call used
> schedule_work() to finish off its removal. We expect the last
> blk_put_queue() to be called at the end of blk_cleanup_queue(). Since

Actually no, we expect that request queue is released after disk is
released. Don't forget that gendisk does hold one extra refcount of
request queue.

> that is deferred and device_del() is called also at the end of
> del_gendisk(), it means the release of the queue can happen in a
> context where the disk is gone.
> 
> Although this issue is triggerable easily with the current async
> request_queue removal, I can think of other ways to trigger an issue
> here and one of them was suggested as possible by Christoph on the last
> v1 patch series.
> 
> blk_queue_get() is not atomic and so what it returns can be incorrect:
> 
> bool blk_get_queue(struct request_queue *q)
> {
> 	if (likely(!blk_queue_dying(q))) {
> 		__blk_get_queue(q);
> 		return true;
> 	}
> 	----> we can schedule here easily and move the queue to dying
> 	----> and race with blk_cleanup_queue() which will then allow
> 	----> code paths to incorrectly trigger the release of the queue
> 	----> in places we don't want

Right, actually caller of blk_get_queue() has to guarantee that
the request queue is alive.

Some users of blk_get_queue() aren't necessary, such as rbd and mmc.

> 	return false;
> }
> EXPORT_SYMBOL(blk_get_queue);
> 
> Another area of concern I am seeing through code inspection is that
> since the request_queue life depends on the disk, it seemse odd we call
> device_del() before we remove the request_queue. If this is indeed
> wrong, we could move the device_del() from del_gendisk() to
> disk_release() triggered by the last put_disk().

Why do you think it is odd and want to change this way? Disk has to be
removed first for draining dirty pages to queue, then we can cleanup
queue. Once we start to clean up request queue, all data may not land
disk any more.

> 
> I have a test now which shows that even if we revert back to synchronous
> request_queue removal I can trigger a panic on the same use-after-free
> case on debugfs on blktrace, and this is because we are overwriting the
> same debugfs directory, and I think the above are its root causes.

The reason should be shared debugfs dir between blktrace and blk-mq
debugfs.

> 
> I can fix this bug, but that just moves the bug to conflicts within
> two sysfs objects already existing, and this is because add_disk()
> (which calls __device_add_disk() doesn't return errors). This is both
> a blk layer bug in the sense we never check for error and a driver bug
> for allowing conflicts. All this just needs to be fixed, and although I
> thought this could be done later, I think I'm just going to fix all this
> now.

Yeah, we talked that several times, looks no one tries to post patch to
fix that.


Thanks, 
Ming

