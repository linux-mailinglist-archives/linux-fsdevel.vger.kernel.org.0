Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB9E1CDC79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgEKODc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 10:03:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37213 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgEKODc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 10:03:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id d184so4793997pfd.4;
        Mon, 11 May 2020 07:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vf5eO08K8TQtqLIZ8vTORrxsJc6yUCjJkazs1Bh1bj4=;
        b=lc5Z6Brwq+2+DTyJYO5ysev2ojsZw6u4HFj9raKqUv77O9VPTftOtbcZH0+IPaw2Jm
         m/FR5c9f8slMae8IC6y2eDIMtNTybWR+YEgoPVE05tRzGuEsgew8u7V661hXw2jlTVyS
         puJgla520vsq+44Tr4JQsvoxSDN3Ab8NUa9MFtgyXj0Cxmo4OUeHEiKHUBcqN4tdwAxD
         RCiSbqIj1v/ZtzyIx3IfrEMw67GufyyB+6wWF3+G2hYd/kC6BwAY4h18uKTP3ctDQ2dg
         gd1fWPaJ3prjXBazNB19fsmU7t1HvyCkAZAVcR59y95R6xERk6rSRbVHhjg5RCqgag5c
         H+hg==
X-Gm-Message-State: AGi0PubDmXvjqAO6DaS4Bty9IRB9vXj0gz4WnnOrviCYCMz21tMrjx7x
        XqqDbveMM4pllG+7vXlSKIA=
X-Google-Smtp-Source: APiQypLEaFgNrNPd13k7XF1jNCRRMz3QrV3XwtPkQkwwm+0cvcB2J8SaXWT82L5S5cHirPigs0BYhQ==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr16312244pfd.236.1589205810901;
        Mon, 11 May 2020 07:03:30 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x10sm8078137pgq.79.2020.05.11.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 07:03:28 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 12F9040605; Mon, 11 May 2020 14:03:27 +0000 (UTC)
Date:   Mon, 11 May 2020 14:03:27 +0000
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
        Christof Schmitt <christof.schmitt@de.ibm.com>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 3/5] blktrace: fix debugfs use after free
Message-ID: <20200511140327.GO11244@42.do-not-panic.com>
References: <20200509031058.8239-1-mcgrof@kernel.org>
 <20200509031058.8239-4-mcgrof@kernel.org>
 <20200510062636.GA3400311@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510062636.GA3400311@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 10, 2020 at 08:26:36AM +0200, Greg KH wrote:
> On Sat, May 09, 2020 at 03:10:56AM +0000, Luis Chamberlain wrote:
> > diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> > index 19091e1effc0..d40f12aecf8a 100644
> > --- a/block/blk-debugfs.c
> > +++ b/block/blk-debugfs.c
> > +static struct dentry *queue_debugfs_symlink_type(struct request_queue *q,
> > +						 const char *src,
> > +						 const char *dst,
> > +						 enum blk_debugfs_dir_type type)
> > +{
> > +	struct dentry *dentry = ERR_PTR(-EINVAL);
> > +	char *dir_dst;
> > +
> > +	dir_dst = kzalloc(PATH_MAX, GFP_KERNEL);
> > +	if (!dir_dst)
> > +		return dentry;
> > +
> > +	switch (type) {
> > +	case BLK_DBG_DIR_BASE:
> > +		if (dst)
> > +			snprintf(dir_dst, PATH_MAX, "%s", dst);
> > +		else if (!IS_ERR_OR_NULL(q->debugfs_dir))
> > +			snprintf(dir_dst, PATH_MAX, "%s",
> > +				 q->debugfs_dir->d_name.name);
> 
> How can debugfs_dir be NULL/error here?

If someone were to move blk_queue_debugfs_symlink() to sg_add_device(),
this can happen as the sd_probe() will run asynchronously. The comment
in blk_queue_debugfs_symlink() suggest to be mindful of async probes.

I can do-away with this *iff* we add an probe_complete call to the
driver core class interface.

> And grabbing the name of a debugfs file is sketchy, just use the name
> that you think you already have, from the device, don't rely on debugfs
> working here.
> 
> And why a symlink anyway?

As the commit log explains, and the comment to the calling functions
explains, we have a shared request_queue, and this has been the way,
the symlink makes that sharing explicit. The next patch explains why
using two blktraces on two separate devices would fail, the symlink
makes this sharing quite obvious.

It also simplifies the trace/kernel/blktrace.c code to just use the
debugfs_dir only.

> THat's a new addition, what is going to work
> with that in userspace?

This already works in userspace with blktrace. If you see a regression,
please let me know.

> > +#ifdef CONFIG_DEBUG_FS
> > +	p->debugfs_sym = blk_queue_debugfs_symlink(disk->queue, dev_name(pdev),
> > +						   disk->disk_name);
> > +#endif
> 
> No need to #ifdef this, right?

It is needed because of the p->debugfs_sym.

> I feel like this patch series keeps getting more complex and messier
> over time :(

I'm afraid that use of blktrace in scsi-generic is the culprit, the
technical debt of the complexities around how the request_queue is
shared and properly providing backward compatibilty by removing the
debufs_looksup() has caught up to us.

If we were to agree to remove scsi-generic support from blktrace first,
that would simplify things hugely.

  Luis
