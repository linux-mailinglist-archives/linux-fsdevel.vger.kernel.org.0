Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6306F1A8D04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 22:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633527AbgDNU66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 16:58:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43486 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633447AbgDNU64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:58:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id l1so494778pff.10;
        Tue, 14 Apr 2020 13:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2BFbh/NVyd/nEEqnIV7FAkYPsjDu10E1KJ7JMizEGUs=;
        b=ZWg9atuX4nJmFaJPPy+n7lOuSBx7FEJ8gvZo1CcZo74d88FAoma5A71qE1KOBH/PvC
         DV5Vkof9X6SLYKwo9ORSz80qzDn3LK6aDCrt5IIvD36s0A/1Z+6nq1FiUXwylFO/Xh+b
         CjnbGHZdIjgxWp/2vTphtjenOw2vnr8c/Us3Gr2cqqjvppUOaj8xR5IIhejNomuZpHiw
         1Z3ccIpUfz0eM79HJrNGR/yGx+4F+bHrtYKjaBCxqBIkWO1OOqh6NWRKO3IQqQoWcPDp
         FV2Z0vcA0th/lS+ARwUj6to88XraeBz9oQn9/8pVvtf1oULyC5QeYb6gbdtEheRNEWrl
         qsig==
X-Gm-Message-State: AGi0PuZP3OMe13UFWnBtH2hOsMkorDZ5tzBBAGZNdF8AXpYQ9Xfsxvk/
        2W475FGPTuz3PvZtSPcj420=
X-Google-Smtp-Source: APiQypKmhyUPwU3E+eaaqWqZ9C3MBCiwt3U/HU4Vjk70huVm8L0B8YcyK+w2BA/5pI1GVFdjIpQH2g==
X-Received: by 2002:a63:d454:: with SMTP id i20mr22395308pgj.209.1586897935063;
        Tue, 14 Apr 2020 13:58:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a1sm11817266pfl.188.2020.04.14.13.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:58:53 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DA82440277; Tue, 14 Apr 2020 20:58:52 +0000 (UTC)
Date:   Tue, 14 Apr 2020 20:58:52 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 5/5] block: revert back to synchronous request_queue
 removal
Message-ID: <20200414205852.GP11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-6-mcgrof@kernel.org>
 <20200414154725.GD25765@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414154725.GD25765@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:47:25AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 14, 2020 at 04:19:02AM +0000, Luis Chamberlain wrote:
> > Commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") merged on
> > v4.12 moved the work behind blk_release_queue() into a workqueue after a
> > splat floated around which indicated some work on blk_release_queue()
> > could sleep in blk_exit_rl(). This splat would be possible when a driver
> > called blk_put_queue() or blk_cleanup_queue() (which calls blk_put_queue()
> > as its final call) from an atomic context.
> > 
> > blk_put_queue() decrements the refcount for the request_queue
> > kobject, and upon reaching 0 blk_release_queue() is called. Although
> > blk_exit_rl() is now removed through commit db6d9952356 ("block: remove
> > request_list code"), we reserve the right to be able to sleep within
> > blk_release_queue() context. If you see no other way and *have* be
> > in atomic context when you driver calls the last blk_put_queue()
> > you can always just increase your block device's reference count with
> > bdgrab() as this can be done in atomic context and the request_queue
> > removal would be left to upper layers later. We document this bit of
> > tribal knowledge as well now, and adjust kdoc format a bit.
> > 
> > We revert back to synchronous request_queue removal because asynchronous
> > removal creates a regression with expected userspace interaction with
> > several drivers. An example is when removing the loopback driver and
> > issues ioctl from userspace to do so, upon return and if successful one
> > expects the device to be removed. Moving to asynchronous request_queue
> > removal could have broken many scripts which relied on the removal to
> > have been completed if there was no error.
> > 
> > Using asynchronous request_queue removal however has helped us find
> > other bugs, in the future we can test what could break with this
> > arrangement by enabling CONFIG_DEBUG_KOBJECT_RELEASE.
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Nicolai Stange <nstange@suse.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: yu kuai <yukuai3@huawei.com>
> > Suggested-by: Nicolai Stange <nstange@suse.de>
> > Fixes: dc9edc44de6c ("block: Fix a blk_exit_rl() regression")
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  block/blk-core.c       | 19 ++++++++++++++++++-
> >  block/blk-sysfs.c      | 38 +++++++++++++++++---------------------
> >  include/linux/blkdev.h |  2 --
> >  3 files changed, 35 insertions(+), 24 deletions(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 5aaae7a1b338..8346c7c59ee6 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -301,6 +301,17 @@ void blk_clear_pm_only(struct request_queue *q)
> >  }
> >  EXPORT_SYMBOL_GPL(blk_clear_pm_only);
> >  
> > +/**
> > + * blk_put_queue - decrement the request_queue refcount
> > + *
> > + * Decrements the refcount to the request_queue kobject, when this reaches
> > + * 0 we'll have blk_release_queue() called. You should avoid calling
> > + * this function in atomic context but if you really have to ensure you
> > + * first refcount the block device with bdgrab() / bdput() so that the
> > + * last decrement happens in blk_cleanup_queue().
> > + *
> > + * @q: the request_queue structure to decrement the refcount for
> > + */
> >  void blk_put_queue(struct request_queue *q)
> >  {
> >  	kobject_put(&q->kobj);
> > @@ -328,10 +339,16 @@ EXPORT_SYMBOL_GPL(blk_set_queue_dying);
> >  
> >  /**
> >   * blk_cleanup_queue - shutdown a request queue
> > - * @q: request queue to shutdown
> >   *
> >   * Mark @q DYING, drain all pending requests, mark @q DEAD, destroy and
> >   * put it.  All future requests will be failed immediately with -ENODEV.
> > + *
> > + * You should not call this function in atomic context. If you need to
> > + * refcount a request_queue in atomic context, instead refcount the
> > + * block device with bdgrab() / bdput().
> 
> I think this needs a WARN_ON thrown in to enforece the calling context.

I considered adding a might_sleep() but upon review with Bart, he noted
that this function already has a mutex_lock(), and if you look under the
hood of mutex_lock(), it has a might_sleep() at the very top. The
warning then is implicit.

> > + *
> > + * @q: request queue to shutdown
> 
> Moving the argument documentation seems against the usual kerneldoc
> style.

Would you look at that, Documentation/doc-guide/kernel-doc.rst does
say to keep the argument at the top as it was in place before, OK will
revert that. Sorry, I used include/net/mac80211.h as my base for style.

> Otherwise this look good, I hope it sticks :)

I hope that the kdocs / might_sleep() sprinkled should make it stick now.
But hey, this uncovered wonderful obscure bugs, it was fun. I'll add a
selftest also later to ensure we don't regress on some of this later
once again.

  Luis
