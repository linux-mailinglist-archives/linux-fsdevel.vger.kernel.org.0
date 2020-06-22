Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA02036EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgFVMhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 08:37:04 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37863 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgFVMhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:37:03 -0400
Received: by mail-pj1-f65.google.com with SMTP id m2so8557643pjv.2;
        Mon, 22 Jun 2020 05:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XBnvpozQh8NlbXbb2Id9vk4JGCe+27nJySmmknsgIeQ=;
        b=mcEXm759s4PueCz78P9k2X48Nki1maAlVrRxBHyaIXYy1URODH6qaj00RCb6YQ8MZ2
         P+xbx+Fd97fqikveIhcsmLAypu2rj5k5CB/BwUM8LEwWDjrpxRq+eZGtp3q9lwuuzd+9
         mV7Ttcy2Rqt3drm0lqH7NC3/Ve5uuyWW/FqKY8Cni8/qffMRqownVCfxMImaturncwLV
         07/RSIi7/+RYdI3SEovUHqp1vNmGvBEelB8KrBJGZwJKIJBDSRIbZShoB+1p/aqkLWdl
         UA50vDNukSvvgXxwZeNKKc0Bx/HY/V/lwqrcA10z51EIemWONSGDzMayJBo050Py/8ow
         OKiQ==
X-Gm-Message-State: AOAM531TAnJm2Z7ZDherPlJaElECNBAPE0cLNZCswGyeRNhcQQYtJ0jW
        K6OMbqKGWpwhKpTKi0KeQ9Q=
X-Google-Smtp-Source: ABdhPJyrKfaLQ3639cZrtv1SHn9cay5HXy5MKWY132MuQMsHcqSjbmonrxxCryowUAKdi5d5SomNKg==
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr17854178pjr.181.1592829422425;
        Mon, 22 Jun 2020 05:37:02 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y4sm13839956pfr.182.2020.06.22.05.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 05:37:00 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9C42940430; Mon, 22 Jun 2020 12:36:59 +0000 (UTC)
Date:   Mon, 22 Jun 2020 12:36:59 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v7 6/8] blktrace: fix debugfs use after free
Message-ID: <20200622123659.GV11244@42.do-not-panic.com>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-7-mcgrof@kernel.org>
 <75c3a94d-dcd1-05e4-47c6-db65f074136a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75c3a94d-dcd1-05e4-47c6-db65f074136a@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 10:31:51AM -0700, Bart Van Assche wrote:
> On 2020-06-19 13:47, Luis Chamberlain wrote:
> > This goes tested with:
>        ^^^^
>        got?
> 
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index 7ff2ea5cd05e..e6e2d25fdbd6 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -524,10 +524,18 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >  	if (!bt->msg_data)
> >  		goto err;
> >  
> > -	ret = -ENOENT;
> > -
> > -	dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > -	if (!dir)
> > +#ifdef CONFIG_BLK_DEBUG_FS
> > +	/*
> > +	 * When tracing whole make_request drivers (multiqueue) block devices,
> > +	 * reuse the existing debugfs directory created by the block layer on
> > +	 * init. For request-based block devices, all partitions block devices,
>                                                   ^^^^^^^^^^^^^^^^^^^^^
> It seems like a word is missing from the comment? Or did you perhaps
> want to refer to "all partition block devices"?

Yes, the later.

> > +	 * and scsi-generic block devices we create a temporary new debugfs
> > +	 * directory that will be removed once the trace ends.
> > +	 */
> > +	if (queue_is_mq(q) && bdev && bdev == bdev->bd_contains)
> > +		dir = q->debugfs_dir;
> > +	else
> > +#endif
> >  		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> 
> Can it happen that two different threads each try to set up block
> tracing and hence that debugfs_create_dir() fails because a directory
> with name buts->name already exists?

Great question, the answer is no. The reason is that we first use the
mutex and then we check for q->blk_trace. If you hold the lock *and*
you have checked for q->blk_trace and its NULL, you are sure you should
not have a duplicate.

Its why the commit log mentioned:

  The new clarifications on relying on the q->blk_trace_mutex *and* also
  checking for q->blk_trace *prior* to processing a blktrace ensures the
  debugfs directories are only created if no possible directory name
  clashes are possible.

These clarifications were prompted through discussions with Jan Kara
on the patches he posted which you CC'd me on. I agreed with his
patch *but* I suggested it would hold true only if check for the
q->blk_trace first, and this is why my patch titled "blktrace: break
out of blktrace setup on concurrent calls" got merged prior to Jan
Kara's "blktrace: Avoid sparse warnings when assigning q->blk_trace".

> >  	bt->dev = dev;
> > @@ -565,8 +573,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
> >  
> >  	ret = 0;
> >  err:
> > -	if (dir && !bt->dir)
> > -		dput(dir);
> >  	if (ret)
> >  		blk_trace_free(bt);
> >  	return ret;
> 
> Shouldn't bt->dir be removed in this error path for make_request drivers?

If there is an error, bt->dir will be removed still, as I never modified
the removal of bt->dir in this patch.

  Luis
