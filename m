Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98C31E778E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgE2H5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 03:57:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41696 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2H5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 03:57:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id a13so790113pls.8;
        Fri, 29 May 2020 00:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hn24moIzo14qUHjFch/YhFZPAu5T32rKC5I7T78qYmY=;
        b=IxdgOWLq/uMOkGdcW2TIh3IOYAc30SCnuUDVZWGnAW1v1NubdmGF+5Rvv7TOAXzTb2
         xdmVrbvHDIWxoyg+F01ROs3gF+xoGLQH2/eyzqO2XcdxQkM9wBvwT2ml+UdJ+I1epZyP
         wpaKMohkmxI0Vq6IORfFtUOr3TQR6jvak7ImzE+1N7XsNfjgGEU7DBdOA56yTqJLz8H9
         KqOYIoj4KgQ/ZDkzy05Yd562B5NVVN94dYBNxPc8twOkD0CKtEX1CgtxhA0TJeO10Dcw
         XZ0l5x3gRhKyYFlk42Ez0EAdFWOyXkSmuTeK+fTKhCZjebyxOr5eg83ROeftrV2s7+4s
         Ap3w==
X-Gm-Message-State: AOAM533TdBbZbGrsP04L+vkqsmJBKMW0IRRwvgYMfOzzEVslJ4xRdqQT
        zGwJbtAj82RZJy2Aj1gKszI=
X-Google-Smtp-Source: ABdhPJwxARlVoHH0Su6e+5Jf5BxTRVI1nExrFSZSd/kWOBH71l4xEKk5iFNvR0597rAujGhX2mS4lA==
X-Received: by 2002:a17:90a:f493:: with SMTP id bx19mr7526345pjb.45.1590739020618;
        Fri, 29 May 2020 00:57:00 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r18sm6739288pjz.43.2020.05.29.00.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:56:59 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 125E34046C; Fri, 29 May 2020 07:56:58 +0000 (UTC)
Date:   Fri, 29 May 2020 07:56:57 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 5/7] blktrace: fix debugfs use after free
Message-ID: <20200529075657.GX11244@42.do-not-panic.com>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
 <20200519163713.GA29944@infradead.org>
 <20200527031202.GT11244@42.do-not-panic.com>
 <3e5e75d4-56ad-19c6-fbc3-b8c78283ec54@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5e75d4-56ad-19c6-fbc3-b8c78283ec54@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 06:15:10PM -0700, Bart Van Assche wrote:
> On 2020-05-26 20:12, Luis Chamberlain wrote:
> > +	/*
> > +	 * Blktrace needs a debugsfs name even for queues that don't register
> > +	 * a gendisk, so it lazily registers the debugfs directory.  But that
> > +	 * can get us into a situation where a SCSI device is found, with no
> > +	 * driver for it (yet).  Then blktrace is used on the device, creating
> > +	 * the debugfs directory, and only after that a drivers is loaded. In
>                                                         ^^^^^^^
>                                                         driver?

Fixed.

> > @@ -494,6 +490,38 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >  	 */
> >  	strreplace(buts->name, '/', '_');
> >  
> > +	/*
> > +	 * We also have to use a partition directory if a partition is
> > +	 * being worked on, even though the same request_queue is shared.
> > +	 */
> > +	if (bdev && bdev != bdev->bd_contains)
> > +		dir = bdev->bd_part->debugfs_dir;
> 
> Please balance braces in if-statements as required by the kernel coding style.

Sure thing.

> > +	else {
> > +		/*
> > +		 * For queues that do not have a gendisk attached to them, the
> > +		 * debugfs directory will not have been created at setup time.
> > +		 * Create it here lazily, it will only be removed when the
> > +		 * queue is torn down.
> > +		 */
> 
> Is the above comment perhaps a reference to blk_register_queue()? If so, please
> mention the name of that function explicitly.

No, it actually is in reference to *add_disk()* helpers, so I'll add
that there. scsi-generic is the ugly child we have which we don't talk
too much about, not sure if we have a proper name for *non* add_disk()
related use of the request_queue... oh and mmc I think?

I've changed this to (ignore spaces, I'll adjust):

* For queues that do not have a gendisk attached to them, that is those
* which do not use *add_disk*() or similar, the debugfs directory will
* not have been created at setup time.  This is the case for
* scsi-generic drivers.  Create it here lazily, it will only be removed
* when the queue is torn down.

> > +		if (!q->debugfs_dir) {
> > +			q->debugfs_dir =
> > +				debugfs_create_dir(buts->name,
> > +						   blk_debugfs_root);
> > +		}
> > +		dir = q->debugfs_dir;
> > +	}
> > +
> > +	/*
> > +	 * As blktrace relies on debugfs for its interface the debugfs directory
> > +	 * is required, contrary to the usual mantra of not checking for debugfs
> > +	 * files or directories.
> > +	 */
> > +	if (IS_ERR_OR_NULL(q->debugfs_dir)) {
> > +		pr_warn("debugfs_dir not present for %s so skipping\n",
> > +			buts->name);
> > +		return -ENOENT;
> > +	}
> 
> How are do_blk_trace_setup() calls serialized against the debugfs directory
> creation code in blk_register_queue()? Perhaps via q->blk_trace_mutex?

Yes, hence the mutex lock that Christoph added as an alternative to
the whole symlink stuff for scsi-generic and addressing this on the
class interface driver.

> Are
> mutex lock and unlock calls for that mutex perhaps missing from
> compat_blk_trace_setup()?

No, because that is called from blk_trace_ioctl(), and that holds the
mutex.

> How about adding a lockdep_assert_held(&q->blk_trace_mutex) statement in
> do_blk_trace_setup()?

Sure, however that doesn't seem part of the fix. How about adding that
as a separat patch?

  Luis
