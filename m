Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E221B1753
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDTUmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:42:00 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53302 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDTUmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:42:00 -0400
Received: by mail-pj1-f66.google.com with SMTP id hi11so392321pjb.3;
        Mon, 20 Apr 2020 13:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W70HODHvPGy2tybwv11DFoJ/NeBLhWW5ThLnvqLq4jw=;
        b=eb8zlzSL6tus+C3+TZcbLqFKdwfa5hEJDHF2PYriyHB+N2NDeZ18TBmwr+hBf7RqP9
         qs+rJKmiwVrFZTc2g3IjLlsbnoLsrvPujOirPjKlU+x/jnyhzMrmyL1Vkf/humbuOmL4
         qrmeuHapgqI9TLvTNE8GNicIZnKryfZTT6B8o9QhgYRCG2O1jSsNjp7Zvlmizex6wBLL
         Ctliuil7f1Pc3Z7qxp55M83rwnZljNNh8qsooiuS2KLFzG8VjgNwmY4QZKH7bHRLZEKf
         q0uSdV3BV6oSOlp+6FpkTzR8fnuOlNIMgidLNgZLxyrsBiXqhxhe5kooJYXKTR5qwSeM
         4DpA==
X-Gm-Message-State: AGi0PuZdJkxQhTKaMVsZjyED0x5mPLE4qQMnkk5Ip69wYwNeGluGYsYe
        IhJ3mhhYPqyS9e+/13AhDYk=
X-Google-Smtp-Source: APiQypJ4sR9R+DlVxqQS0MoSp3x92ejjwbDh/Pdx52htFHQWU9alTiU9j5K9HouA86h3GL82FtnQHQ==
X-Received: by 2002:a17:902:8487:: with SMTP id c7mr16757665plo.251.1587415318778;
        Mon, 20 Apr 2020 13:41:58 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n16sm369107pfq.61.2020.04.20.13.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:41:57 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DCAF84028E; Mon, 20 Apr 2020 20:41:56 +0000 (UTC)
Date:   Mon, 20 Apr 2020 20:41:56 +0000
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
Message-ID: <20200420204156.GO11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <20200420201615.GC302402@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420201615.GC302402@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 10:16:15PM +0200, Greg KH wrote:
> On Sun, Apr 19, 2020 at 07:45:22PM +0000, Luis Chamberlain wrote:
> 
> This patch triggered gmail's spam detection, your changelog text is
> whack...

Oh? What do you think triggered it?

> > diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> > index 19091e1effc0..d84038bce0a5 100644
> > --- a/block/blk-debugfs.c
> > +++ b/block/blk-debugfs.c
> > @@ -3,6 +3,9 @@
> >  /*
> >   * Shared request-based / make_request-based functionality
> >   */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> >  #include <linux/kernel.h>
> >  #include <linux/blkdev.h>
> >  #include <linux/debugfs.h>
> > @@ -13,3 +16,30 @@ void blk_debugfs_register(void)
> >  {
> >  	blk_debugfs_root = debugfs_create_dir("block", NULL);
> >  }
> > +
> > +int __must_check blk_queue_debugfs_register(struct request_queue *q)
> > +{
> > +	struct dentry *dir = NULL;
> > +
> > +	/* This can happen if we have a bug in the lower layers */
> > +	dir = debugfs_lookup(kobject_name(q->kobj.parent), blk_debugfs_root);
> > +	if (dir) {
> > +		pr_warn("%s: registering request_queue debugfs directory twice is not allowed\n",
> > +			kobject_name(q->kobj.parent));
> > +		dput(dir);
> > +		return -EALREADY;
> > +	}
> > +
> > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > +					    blk_debugfs_root);
> > +	if (!q->debugfs_dir)
> > +		return -ENOMEM;
> 
> Why doesn't the directory just live in the request queue, or somewhere
> else, so that you save it when it is created and then that's it.  No
> need to "look it up" anywhere else.

Its already there. And yes, after my changes it is technically possible
to just re-use it directly. But this is complicated by a few things. One
is that at this point in time, asynchronous request_queue removal is
still possible, and so a race was exposed where a requeust_queue may be
lingering but its old device is gone. That race is fixed by reverting us
back to synchronous request_queue removal, therefore ensuring that the
debugfs dir exists so long as the device does.

I can remove the debugfs_lookup() *after* we revert to synchronous
request_queue removal, or we just re-order the patches so that the
revert happens first. That should simplify this patch.

The code in this patch was designed to help dispute the logic behind
the CVE, in particular it shows exactly where debugfs_dir *is* the
one found by debugfs_lookup(), and shows the real issue behind the
removal.

But yeah, now that that is done, I hope its clear to all, and I think
this patch can be simplified if we just revert the async requeust_queue
removal first.

> Or do you do that in later patches?  I only see this one at the moment,
> sorry...
> 
> >  static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> > +					    struct request_queue *q,
> >  					    struct blk_trace *bt)
> >  {
> >  	struct dentry *dir = NULL;
> >  
> > +	/* This can only happen if we have a bug on our lower layers */
> > +	if (!q->kobj.parent) {
> > +		pr_warn("%s: request_queue parent is gone\n", buts->name);
> 
> A kobject always has a parent, unless it has not been registered yet, so
> I don't know what you are testing could ever happen.

Or it has been kobject_del()'d?

A deferred requeust_queue removal shows this is possible, the parent is
taken underneath from us because the refcounting of this kobject is
already kobject_del()'d, and its actual removal scheduled for later.
The parent is taken underneath from us prior to the scheduled removal
completing.

> 
> > +		return NULL;
> > +	}
> > +
> > +	/*
> > +	 * From a sysfs kobject perspective, the request_queue sits on top of
> > +	 * the gendisk, which has the name of the disk. We always create a
> > +	 * debugfs directory upon init for this gendisk kobject, so we re-use
> > +	 * that if blktrace is going to be done for it.
> > +	 */
> > +	if (blk_trace_target_disk(buts->name, kobject_name(q->kobj.parent))) {
> > +		if (!q->debugfs_dir) {
> > +			pr_warn("%s: expected request_queue debugfs_dir is not set\n",
> > +				buts->name);
> 
> What is userspace supposed to be able to do if they see this warning?

Userspace doesn't parse warnings, but the NULL ensures it won't crash
the kernel. The warn informs the kernel of a possible block layer bug.

> > +			return NULL;
> > +		}
> > +		/*
> > +		 * debugfs_lookup() is used to ensure the directory is not
> > +		 * taken from underneath us. We must dput() it later once
> > +		 * done with it within blktrace.
> > +		 */
> > +		dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > +		if (!dir) {
> > +			pr_warn("%s: expected request_queue debugfs_dir dentry is gone\n",
> > +				buts->name);
> 
> Again, can't we just save the pointer when we create it and not have to
> look it up again?

Only if we do the revert of the requeust_queue removal first.

> > +			return NULL;
> > +		}
> > +		 /*
> > +		 * This is a reaffirmation that debugfs_lookup() shall always
> > +		 * return the same dentry if it was already set.
> > +		 */
> 
> I'm all for reaffirmation and the like, but really, is this needed???

To those who were still not sure that the issue was not a debugfs issue
I hoped this to make it clear. But indeed, if we revert back to
synchronous request_queue removal, that should simplify this.

> > +		if (dir != q->debugfs_dir) {
> > +			dput(dir);
> > +			pr_warn("%s: expected dentry dir != q->debugfs_dir\n",
> > +				buts->name);
> > +			return NULL;
> 
> Why are you testing to see if debugfs really is working properly?
> SHould all users do crazy things like this (hint, rhetorical
> question...)

No, this can happen with the race I mentioned above.

> > +		}
> > +		bt->backing_dir = q->debugfs_dir;
> > +		return bt->backing_dir;
> > +	}
> > +
> > +	/*
> > +	 * If not using blktrace on the gendisk, we are going to create a
> > +	 * temporary debugfs directory for it, however this cannot be shared
> > +	 * between two concurrent blktraces since the path is not unique, so
> > +	 * ensure this is only done once.
> > +	 */
> >  	dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > -	if (!dir)
> > -		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > +	if (dir) {
> > +		pr_warn("%s: temporary blktrace debugfs directory already present\n",
> > +			buts->name);
> > +		dput(dir);
> > +		return NULL;
> > +	}
> > +
> > +	bt->dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > +	if (!bt->dir) {
> > +		pr_warn("%s: temporary blktrace debugfs directory could not be created\n",
> > +			buts->name);
> 
> Again, do not test the return value, you do not care.  I've been
> removing these checks from everywhere.

Sure, the question still stands on what *should* the kernel do if the
blktrace setup failed to create the debugfs files.

  Luis
