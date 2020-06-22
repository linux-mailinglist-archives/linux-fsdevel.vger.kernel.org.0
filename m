Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB82036B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgFVM1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 08:27:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37560 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFVM1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:27:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id j1so8354480pfe.4;
        Mon, 22 Jun 2020 05:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EywcY6vS9cylelIV1NX4lE8fuwIV3UqzEJ1KluaxKEQ=;
        b=MrAhikw59itfNsVas1+eC2lpwabDyRyOmgu2ur9Uk7WNWHJAOLfCxqhpa5ZdFioZ0c
         oJfACHIzXEBxvjWnAC8tDqYYPw5RUSC/xCY3eVtuVhhrLBSHAxn9k7d+pePqUGe1/u9T
         Urz/YZqypudYqrZFq5cII39zNrE358/y1N2wn7EUSFg1IrLWLWiPLEBlScZ6dls9Y65g
         sAiYKjz34xjouS4xBeG1TwQiIxtO8Fc8e5MWbYBxzhAtNwCDh8TbD8o9wCEkmrU9HaOe
         caD0nwXPkrzYmy8eXeK84oDQTLlhzJ02pb0tpd8en7whJBG2+8Md0rwkVaogOhMXwmQi
         kiRA==
X-Gm-Message-State: AOAM5320CCH8lYZCJ1tGOsq2cX7PWJ8vUIWo29W4TqNBtP+1mIDj8WWh
        hX2td72fGmcpChjwvoRTCZg=
X-Google-Smtp-Source: ABdhPJyTiqAV+V55lsVYMa3ppMo+Ee9nBX4Ii6+mVgydtVh78CU8KmXFOKHKPtJwrv4kquV9O7DWLw==
X-Received: by 2002:a63:2a8a:: with SMTP id q132mr12273112pgq.279.1592828865482;
        Mon, 22 Jun 2020 05:27:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v8sm13526689pfn.217.2020.06.22.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 05:27:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A280840430; Mon, 22 Jun 2020 12:27:42 +0000 (UTC)
Date:   Mon, 22 Jun 2020 12:27:42 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 5/8] loop: be paranoid on exit and prevent new
 additions / removals
Message-ID: <20200622122742.GU11244@42.do-not-panic.com>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-6-mcgrof@kernel.org>
 <7e76d892-b5fd-18ec-c96e-cf4537379eba@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e76d892-b5fd-18ec-c96e-cf4537379eba@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 10:11:46AM -0700, Bart Van Assche wrote:
> On 2020-06-19 13:47, Luis Chamberlain wrote:
> > Be pedantic on removal as well and hold the mutex.
> > This should prevent uses of addition while we exit.
> > 
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  drivers/block/loop.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index c33bbbfd1bd9..d55e1b52f076 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -2402,6 +2402,8 @@ static void __exit loop_exit(void)
> >  
> >  	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
> >  
> > +	mutex_lock(&loop_ctl_mutex);
> > +
> >  	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
> >  	idr_destroy(&loop_index_idr);
> >  
> > @@ -2409,6 +2411,8 @@ static void __exit loop_exit(void)
> >  	unregister_blkdev(LOOP_MAJOR, "loop");
> >  
> >  	misc_deregister(&loop_misc);
> > +
> > +	mutex_unlock(&loop_ctl_mutex);
> >  }
> >  
> >  module_init(loop_init);
> 
> Is try_module_get(fops->owner) called before a loop device is opened and
> is module_put(fops->owner) called after a loop device is closed? Does
> that mean that it is impossible to unload the loop driver while a loop
> device is open? Does that mean that the above patch is not necessary or
> did I perhaps miss something?

That's not the only way to add or remove the loop module though.

You may add/remove it manually. And again, as mentioned in the commit log,
I couldn't trigger a race myself, however this seemed the more pedantic
and careful strategy we can take.

Note: this will bring you sanity if you try to figure out *why* we still
get:

[235530.144343] debugfs: Directory 'loop0' with parent 'block' already present!
[235530.149477] blktrace: debugfs_dir not present for loop0 so skipping
[235530.232328] debugfs: Directory 'loop0' with parent 'block' already present!
[235530.238962] blktrace: debugfs_dir not present for loop0 so skipping

If you run run_0004.sh from break-blktrace [0]. Even with all my patches
merged we still run into this. And so the bug lies within the block
layer or on the driver. I haven't been able to find the issue yet.

[0] https://github.com/mcgrof/break-blktrace

  Luis
