Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380891AFF18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 02:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDTAEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 20:04:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41773 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgDTAEj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:04:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id b8so4078516pfp.8;
        Sun, 19 Apr 2020 17:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kh1k2fqld2X6QVBNO1w5sZUDXzr6Qg5ZBK70v1ls5f8=;
        b=bVRAPKNAfAwqNcQ8itSJUvWduZH18kuMHYnuPc/g+htfB5VwmuEYKBffdTpYHp5hkR
         4P8kNX9fYiuGjj5NJilTYJ33eUcnBzEo75yWCGKuZSliX5IG02d0TJaRwoTFmdso9fJW
         B4TamZAegjHChkaj7HuXDLF4OnzIB7lLUPv+dkU/PB4/9DzgwmGV7IH7bN3F7hu7PjH2
         e86xUj5ktIEKwebPPpJo8mAGoxm1QzRob8HHWoN6dTxTMTBJ6IbiPArq322cw6tBlbbw
         YQRAq9u4uCAZmEmNHgZpU8q+bjGyIHHYt5WNW7eOLPk787hCWXTTUIKA3EIL/G3lmnP7
         1oBg==
X-Gm-Message-State: AGi0PuZHFeXpQ+lKOYcgIJpz8uOu68YPJGd6h23OqAZNVWJ2OE92+1i3
        bn+F8gzXxNyjfJ+Sj6YzDNg=
X-Google-Smtp-Source: APiQypKByK9nGxLgzdmeIoOk4RejCW0M5WnXjnSVh+/H8BFqlKseFoMbp59ib8yYPJc/EWdaO7a6pw==
X-Received: by 2002:a63:4d5e:: with SMTP id n30mr14012899pgl.154.1587341078621;
        Sun, 19 Apr 2020 17:04:38 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s10sm25127565pfd.124.2020.04.19.17.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 17:04:37 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7FC2140858; Mon, 20 Apr 2020 00:04:36 +0000 (UTC)
Date:   Mon, 20 Apr 2020 00:04:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 03/10] blktrace: fix debugfs use after free
Message-ID: <20200420000436.GI11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-4-mcgrof@kernel.org>
 <91c82e6a-24ce-0b7d-e6e4-e8aa89f3fb79@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91c82e6a-24ce-0b7d-e6e4-e8aa89f3fb79@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 02:55:42PM -0700, Bart Van Assche wrote:
> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> > +int __must_check blk_queue_debugfs_register(struct request_queue *q)
> > +{
> > +	struct dentry *dir = NULL;
> > +
> > +	/* This can happen if we have a bug in the lower layers */
> 
> What does "this" refer to? Which layers does "lower layers" refer to? Most
> software developers consider a module that calls directly into another
> module as a higher layer (callbacks through function pointers do not count;
> see also https://en.wikipedia.org/wiki/Modular_programming). According to
> that definition block drivers are a software layer immediately above the
> block layer core.
> 
> How about changing that comment into the following to make it unambiguous
> (if this is what you meant)?
> 
> 	/*
> 	 * Check whether the debugfs directory already exists. This can
> 	 * only happen as the result of a bug in a block driver.
> 	 */

But I didn't mean on a block driver. I meant the block core. In our
case, the async request_queue removal is an example. There is nothing
that block drivers could have done to help much with that.

I could just change "lower layers" to "block layer" ?

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
> > +
> > +	return 0;
> > +}
> 
> kobject_name(q->kobj.parent) is used three times in the above function. How
> about introducing a local variable that holds the result of that expression?

Sure.

> > +static bool blk_trace_target_disk(const char *target, const char *diskname)
> > +{
> > +	if (strlen(target) != strlen(diskname))
> > +		return false;
> > +
> > +	if (!strncmp(target, diskname,
> > +		     min_t(size_t, strlen(target), strlen(diskname))))
> > +		return true;
> > +
> > +	return false;
> > +}
> 
> The above code looks weird to me. When the second if-statement is reached,
> it is guaranteed that 'target' and 'diskname' have the same length. So why
> to calculate the minimum length in the second if-statement of two strings
> that have the same length?

True, no need that that point. Will fix.

> Independent of what the purpose of the above code is, can that code be
> rewritten such that it does not depend on the details of how names are
> assigned to disks and partitions? Would disk_get_part() be useful here?

I did try, but couldn't figure out a way. I'll keep looking but likewise
let me know if you find a way.

  Luis
