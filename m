Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0841B89CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 00:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDYWeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 18:34:21 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40159 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgDYWeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 18:34:21 -0400
Received: by mail-pj1-f68.google.com with SMTP id fu13so4949849pjb.5;
        Sat, 25 Apr 2020 15:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W0EaBCG8GkaS1Wt2Lk9Lc7gE2PE2cC3gQ8S6Fs52+bc=;
        b=dStT8tM/hFtsFO2Q7kU4pr/RqWF7MoSEuz4PDUbE/MEMo6Ktbh0HHkkWwVnVX4M7Hx
         0J68bOiL1+aPwWc3sQEIdaTryqK14tnDjsBovdraU0Ov2tNh+fLPW1EffD+Y0s04OOJQ
         /Hkwz64/n91j39W8RJhhBfYeR8d6E8obn4p3LHktOtJqQNZ6vPsAVu/qA2Jz7wkPo0uz
         5G/PsTnn1lWeqlmuOEZjLj3WXa4vfXz6eG03yzev/aY4XTTAET9jbmqyIM/BLnBEviVC
         OCbaJgLrvtF8GlHDJ5Yu8L/3tVk1NDDuCHBRk5wagqmY3q9euYtjgoB547gaLiugkyRu
         hYiw==
X-Gm-Message-State: AGi0PubXgDifUEV+cEXymD96z9CyE0HY39B2OzXB0bhZXenu4worTYvl
        UEa1x7QFFWRyXWbU6VTqWkqZQgOM2RM=
X-Google-Smtp-Source: APiQypKICq242yMYhwiNjgYFYMPxAio9/JG3lCjWnpzrN64Qe18wgpFZvV2Og6SMcz/xIbCHFZBHEA==
X-Received: by 2002:a17:90a:2281:: with SMTP id s1mr14936556pjc.68.1587854060290;
        Sat, 25 Apr 2020 15:34:20 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g27sm7846864pgn.52.2020.04.25.15.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 15:34:19 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 39061403AB; Sat, 25 Apr 2020 22:34:18 +0000 (UTC)
Date:   Sat, 25 Apr 2020 22:34:18 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] pktcdvd: Fix pkt_setup_dev() error path
Message-ID: <20200425223418.GG11244@42.do-not-panic.com>
References: <20180102193948.22656-1-bart.vanassche@wdc.com>
 <20180102193948.22656-2-bart.vanassche@wdc.com>
 <CAB=NE6Uhn88Vrymb2x+=7YmieRguGKm9Dk1LiDqw6oggZJpp8g@mail.gmail.com>
 <20200425091601.GA492109@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425091601.GA492109@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 25, 2020 at 05:17:00PM +0800, Ming Lei wrote:
> On Fri, Apr 24, 2020 at 07:39:47PM -0600, Luis Chamberlain wrote:
> > So I hopped on a time machine to revise some old collateral due to
> > 523e1d399ce ("block: make gendisk hold a reference to its queue")
> > merged on v3.2 which added the conditional check for the disk->queue
> > before calling blk_put_queue() on release_disk(). I started wondering
> > *why* the conditional was added, but I checked the original patch and
> > I could not find discussion around it.
> > 
> > Tejun, do you call why you added that conditional on
> > 
> > if (disk->queue)
> >   blk_put_queue(disk->queue);
> > 
> > This patch however struck me as one I should highlight, since I'm
> > reviewing all this now and dealing with adding error paths on
> > add_disk(). Below some notes.
> 
> disk->queue is assigned by drivers, I guess that is why the check
> is needed, given the disk may be released in error path before driver
> assigns queue to it.
> 
> Also some driver may only allocate disk and not add disk, then not
> necessary to assign disk->queue, such as drivers/scsi/sg.c

Jeesh. Ugh. Yes I see, thanks this helps.

> > As we have it now drivers *do* call blk_cleanup_queue() on error paths
> > prior to add_disk(). An example today is on drivers/block/loop.c where
> > in loop_add(), if alloc_disk() fails we call  blk_cleanup_queue()
> > *but* this error path *never* called put_disk() as
> > drivers/block/pktcdvd.c did on error, and that is because it doesn't
> > need to as the last error-path-induced call was alloc_disk(). So it
> > doesn't need to free the disk as its not created on the error path of
> > loop_add().
> > 
> > This will of course change once we make add_disk() return int, and
> > capture errors, and it brings the question if we want to follow
> > similar strategy for other drivers, however note that blk_put_queue()
> > doesn't do everything blk_cleanup_queue() does, and in fact
> > blk_cleanup_queue() states it sets up "the appropriate flags" *and*
> > then calls blk_put_queue().
> > 
> > We'll have a a bit more collateral evolutions if we embrace the
> > strategy in this commit, for those drivers that wish to start taking
> > advantage of the error checks, but other then considering this, I
> > thought it would be good to think about the fact that *today* we call
> > blk_cleanup_queue() on error paths *without* the disk being yet
> > associated either. This, in spite of the fact that the way we designed
> 
> Some drivers may have only request queue, and not have disk, such as
> NVMe's admin queue, so I think blk_cleanup_queue() has to cover this
> case.

Alright, also useful, thanks.

> > the queue, it sits on top of the disk from a kobject perspective once
> > registered. Since we call blk_cleanup_queue() on error paths today --
> > without a disk parent being possible -- it means nothing on
> > blk_cleanup_queue() should not rely on it having a functional disk. Do
> > we want to keep it that way? If we keep the practice of drivers using
> 
> Yes, see the reason above.

Alright, the patch I replied to was a case where blk_queue_cleanup() was
removed due to a crash even though this driver both add_disk() and
assigned the queue before. Although this patch didn't come with a full
kernel splat and only:

Kernel BUG at 00000000e98fd882 [verbose debug info unavailable]

I can only guess that this was likely a double put of the queue, once
at blk_cleanup_queue() and another with the last put on disk_release().

I'll consider these things when extending the error paths, thanks for
the feedback.

  Luis
