Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9687519F8A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgDFPO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 11:14:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43121 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgDFPO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:14:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id s4so43372pgk.10;
        Mon, 06 Apr 2020 08:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C1rj6tqouMSzYr123O6MG7Kb2JqCCN96dtKjirMsApo=;
        b=G2HTg+7C/uYDd+HC2P1uzdm4RzbvrsPnDh4/CHz0eRv9AR14+UgPxPTmLKCL/yoTzi
         kjM9DUp4cQ5wLv3YMXfxZvAMTi/mk+WOIu8qXCItNlevNXJX2gXTfGHW4707G5GZwiQr
         j+s0u02NTvGSGbjmCqCl70ZFJ/fWdV/r7oqpqpRGOMwAy2aSOYzGoRoTD0pbH2rexn8t
         9pm+Psq4cHaQZVpZX04bZ/+/46MiRF1HVVDrqTdEEkbDzA3pvk9/IsHKMY6CIueItiH6
         GiVg3Br0gMFH6lFSM10HnvZr88aGJoGI4cRTL5/SqZLxN+7y+qgF1DNe8Rew7VgUdO1+
         CPMg==
X-Gm-Message-State: AGi0Pub6nL9WJF3s3MMGi9sbpeHMRhtL33p2eZw3BjFPnqPUOA68OqKP
        9fDPA77tp4TM4dphC6WyY0E=
X-Google-Smtp-Source: APiQypIc2HttsxKQxguvtP/5pcNclwUmIYd7LwuujxsGlIkCzwp/T9+mNTtdb2Y3OGmhZhRkuqdyyw==
X-Received: by 2002:a63:c345:: with SMTP id e5mr1399506pgd.403.1586186064972;
        Mon, 06 Apr 2020 08:14:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g11sm11850281pjs.17.2020.04.06.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:14:22 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 43FAF40246; Mon,  6 Apr 2020 15:14:22 +0000 (UTC)
Date:   Mon, 6 Apr 2020 15:14:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [RFC 2/3] blktrace: fix debugfs use after free
Message-ID: <20200406151422.GC11244@42.do-not-panic.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-3-mcgrof@kernel.org>
 <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3640b16b-abda-5160-301a-6a0ee67365b4@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 04, 2020 at 08:39:47PM -0700, Bart Van Assche wrote:
> On 2020-04-01 17:00, Luis Chamberlain wrote:
> > korg#205713 then was used to create CVE-2019-19770 and claims that
> > the bug is in a use-after-free in the debugfs core code. The
> > implications of this being a generic UAF on debugfs would be
> > much more severe, as it would imply parent dentries can sometimes
> > not be possitive, which is something claim is not possible.
>          ^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          positive?  is there perhaps a word missing here?

Sorry yeah, this was supposed to say:

it would imply parent dentries can sometimes not be positive, which
is just not possible.

> > It turns out that the issue actually is a mis-use of debugfs for
> > the multiqueue case, and the fragile nature of how we free the
> > directory used to keep track of blktrace debugfs files. Omar's
> > commit assumed the parent directory would be kept with
> > debugfs_lookup() but this is not the case, only the dentry is
> > kept around. We also special-case a solution for multiqueue
> > given that for multiqueue code we always instantiate the debugfs
> > directory for the request queue. We were leaving it only to chance,
> > if someone happens to use blktrace, on single queue block devices
> > for the respective debugfs directory be created.
> 
> Since the legacy block layer is gone, the above explanation may have to
> be rephrased.

Will do.

> > We can fix the UAF by simply using a debugfs directory which is
> > always created for singlequeue and multiqueue block devices. This
> > simplifies the code considerably, with the only penalty now being
> > that we're always creating the request queue directory debugfs
> > directory for the block device on singlequeue block devices.
> 
> Same comment here - the legacy block layer is gone. I think that today
> all block drivers are either request-based and multiqueue or so-called
> make_request drivers. See also the output of git grep -nHw
> blk_alloc_queue for examples of the latter category.

Will adjust.

> > This patch then also contends the severity of CVE-2019-19770 as
> > this issue is only possible using root to shoot yourself in the
> > foot by also misuing blktrace.
>                ^^^^^^^
>                misusing?
> 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index b3f2ba483992..bda9378eab90 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -823,9 +823,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
> >  	struct blk_mq_hw_ctx *hctx;
> >  	int i;
> >  
> > -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > -					    blk_debugfs_root);
> > -
> >  	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
> >  
> >  	/*
> 
> [ ... ]
> 
> >  static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index fca9b158f4a0..20f20b0fa0b9 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -895,6 +895,7 @@ static void __blk_release_queue(struct work_struct *work)
> >  
> >  	blk_trace_shutdown(q);
> >  
> > +	blk_q_debugfs_unregister(q);
> >  	if (queue_is_mq(q))
> >  		blk_mq_debugfs_unregister(q);
> 
> Does this patch change the behavior of the block layer from only
> registering a debugfs directory for request-based block devices to
> registering a debugfs directory for request-based and make_request based
> block devices? Is that behavior change an intended behavior change?

Yes, specifically this was already done, however for request-based block
devices this was done upon init, and for make_request based devices this
was only instantiated *iff* blktrace was used at least once. It is
actually a bit difficult to see the later, given the rq->debugfs_dir was
not used per se for make_request based block devices, but instead
the debugfs_create_dir(buts->name, blk_debugfs_root) call was made
directly, which happens to end up being the same directory as
debugfs_create_dir(kobject_name(q->kobj.parent), blk_debugfs_root)
called on block/blk-mq-debugfs.c.

This changes the block layer so that the rq->debugfs_dir is always created
now if debugfs is enabled.

Note that blktrace already depends on debugfs. What was missing in this
patch too was this hunk:

--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -569,8 +569,10 @@ struct request_queue {
	struct list_head        tag_set_list;
	struct bio_set          bio_split;

-#ifdef CONFIG_BLK_DEBUG_FS
+#ifdef CONFIG_DEBUG_FS
	struct dentry           *debugfs_dir;
+#endif
+#ifdef CONFIG_BLK_DEBUG_FS
	struct dentry
	*sched_debugfs_dir;
	struct dentry
	*rqos_debugfs_dir;
#endif

