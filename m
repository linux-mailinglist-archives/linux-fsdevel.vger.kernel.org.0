Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489941AB7DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 08:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407698AbgDPGVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 02:21:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39852 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407384AbgDPGU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:20:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id g32so1165396pgb.6;
        Wed, 15 Apr 2020 23:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p15xYOQygHaMZBBF5Y1nnqVE33ZTctQDLOOIp9dIoLE=;
        b=TTox5xiBcelasnIGWX6SIMPF+9VR0ZnaiYHUaJELkhRxLPDLqYtSKxlOiKiBDIqHzo
         cjoFApG69Z/IMJ0cxPAytqe02eyfaI2JlsvMLDuBSXj+vJrfag9qjn/kGwvvqtBR7vPL
         PUY4lhDbHy1gonnlVok4ctW1n52G0rKOhfzFdMSrUM/+Uv2xRXxUz+vW8GnDVqRB+FWf
         YatT0xdjzURqrHrs72Rii0baZeLkls7G9cX2lEgiQGtaRZ3hac1Z/6aPptcVaINvJ4Cu
         FfPwNNWwL1lTy78RuZRJZXsTqOVsn+rob3butyolVRl9P+gFjqtel4xId136ddgzx/f8
         Befw==
X-Gm-Message-State: AGi0PuZsOj47Xje/4cnmXf+AlRlgbfRl7qu2/r1rxwg+jUTWTGZ1KLX4
        OjmVt1TqYlU+YssLRL6FKd4=
X-Google-Smtp-Source: APiQypJdFaXOZeMn73PqeNL3aSMM9FGEv7xVBTPP0KhN6MUn3AMyk3tgHrWRUpkeOX/IOxTaJA/Zuw==
X-Received: by 2002:a62:16d2:: with SMTP id 201mr29586848pfw.295.1587018056780;
        Wed, 15 Apr 2020 23:20:56 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g6sm15692090pfr.56.2020.04.15.23.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 23:20:55 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D4F6F40277; Thu, 16 Apr 2020 06:20:54 +0000 (UTC)
Date:   Thu, 16 Apr 2020 06:20:54 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
Message-ID: <20200416062054.GL11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
 <20200416021036.GA2717677@T590>
 <20200416052524.GH11244@42.do-not-panic.com>
 <20200416054750.GA2723777@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416054750.GA2723777@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 01:47:50PM +0800, Ming Lei wrote:
> On Thu, Apr 16, 2020 at 05:25:24AM +0000, Luis Chamberlain wrote:
> > On Thu, Apr 16, 2020 at 10:10:36AM +0800, Ming Lei wrote:
> > > In theory, multiple partitions can be traced concurrently, but looks
> > > it never works, so it won't cause trouble for multiple partition trace.
> > > 
> > > One userspace visible change is that blktrace debugfs dir name is switched 
> > > to disk name from partition name in case of partition trace, will it
> > > break some utilities?
> > 
> > How is this possible, its not clear to me, we go from:
> > 
> > -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > -					    blk_debugfs_root);
> > 
> > To this:
> > 
> > +	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > +					    blk_debugfs_root);
> > 
> > 
> > Maybe I am overlooking something.
> 
> Your patch removes the blktrace debugfs dir:
> 
> do_blk_trace_setup()
> 
> -       dir = debugfs_lookup(buts->name, blk_debugfs_root);
> -       if (!dir)
> -               bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> -
> 
> Then create blktrace attributes under the dir of q->debugfs_dir.
> 
> However, buts->name could be one partition device name, but

I can see how buts->name is set to bdevname() which expands to
disk_name(bdev->bd_disk, bdev->bd_part->partno, buf).

> q->debugfs_dir has to be disk name.

I can't see this, can you point me to where it is clear the
request_queue kobject's parent is sure to be the disk name?

If it is different, the issue I don't think should be debugfs, but
the bigger issue would be that blktrace on two different partitions
would clash.

Also, the *old* lookup intent on partitions always would fail on mq
and we'd end up creating a directory.

I think we'd need to create a directory per partition, even when we
don't use blktrace. That makes this more complex than I'd hope for.

  Luis
