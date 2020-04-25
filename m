Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB131B8521
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgDYJRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 05:17:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27713 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgDYJRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587806239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvEI1720n3vEl4/2KLPpHW4NO4oKTsPUQdAdAubauvI=;
        b=Os7k+xsSmLCa+2pckIQaixXPwBkGZ8rD1UwVgY3z0XqiJwLQRcUNK7rahQKyP//nO9HNtX
        Ry6ZPSF36Dh0SUInOyuAWHkHx/fFIK9gEwAl8MYxcudeiM8uOwHqPlXOpDRlodgkdzb20V
        VpP2zz9f9E8wMDJFDccKq6R6sgR28lI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-xssfc_K4OwiLHKClQQmcQw-1; Sat, 25 Apr 2020 05:17:15 -0400
X-MC-Unique: xssfc_K4OwiLHKClQQmcQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AA37800580;
        Sat, 25 Apr 2020 09:17:13 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BED71001DC2;
        Sat, 25 Apr 2020 09:17:05 +0000 (UTC)
Date:   Sat, 25 Apr 2020 17:17:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Tejun Heo <tj@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] pktcdvd: Fix pkt_setup_dev() error path
Message-ID: <20200425091601.GA492109@T590>
References: <20180102193948.22656-1-bart.vanassche@wdc.com>
 <20180102193948.22656-2-bart.vanassche@wdc.com>
 <CAB=NE6Uhn88Vrymb2x+=7YmieRguGKm9Dk1LiDqw6oggZJpp8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=NE6Uhn88Vrymb2x+=7YmieRguGKm9Dk1LiDqw6oggZJpp8g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 07:39:47PM -0600, Luis Chamberlain wrote:
> So I hopped on a time machine to revise some old collateral due to
> 523e1d399ce ("block: make gendisk hold a reference to its queue")
> merged on v3.2 which added the conditional check for the disk->queue
> before calling blk_put_queue() on release_disk(). I started wondering
> *why* the conditional was added, but I checked the original patch and
> I could not find discussion around it.
> 
> Tejun, do you call why you added that conditional on
> 
> if (disk->queue)
>   blk_put_queue(disk->queue);
> 
> This patch however struck me as one I should highlight, since I'm
> reviewing all this now and dealing with adding error paths on
> add_disk(). Below some notes.

disk->queue is assigned by drivers, I guess that is why the check
is needed, given the disk may be released in error path before driver
assigns queue to it.

Also some driver may only allocate disk and not add disk, then not
necessary to assign disk->queue, such as drivers/scsi/sg.c

> 
> On Tue, Jan 2, 2018 at 1:40 PM Bart Van Assche <bart.vanassche@wdc.com> wrote:
> >
> > Commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
> > modified add_disk() and disk_release() but did not update any of the
> > error paths that trigger a put_disk() call after disk->queue has been
> > assigned. That introduced the following behavior in the pktcdvd driver
> > if pkt_new_dev() fails:
> >
> > Kernel BUG at 00000000e98fd882 [verbose debug info unavailable]
> >
> > Since disk_release() calls blk_put_queue() anyway if disk->queue != NULL,
> > fix this by removing the blk_cleanup_queue() call from the pkt_setup_dev()
> > error path.
> >
> > Fixes: commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
> > Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > Cc: <stable@vger.kernel.org> # v3.2
> > ---
> >  drivers/block/pktcdvd.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> > index 67974796c350..2659b2534073 100644
> > --- a/drivers/block/pktcdvd.c
> > +++ b/drivers/block/pktcdvd.c
> > @@ -2745,7 +2745,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
> >         pd->pkt_dev = MKDEV(pktdev_major, idx);
> >         ret = pkt_new_dev(pd, dev);
> >         if (ret)
> > -               goto out_new_dev;
> > +               goto out_mem2;
> >
> >         /* inherit events of the host device */
> >         disk->events = pd->bdev->bd_disk->events;
> > @@ -2763,8 +2763,6 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
> >         mutex_unlock(&ctl_mutex);
> >         return 0;
> >
> > -out_new_dev:
> > -       blk_cleanup_queue(disk->queue);
> >  out_mem2:
> >         put_disk(disk);
> >  out_mem:
> > --
> 
> As we have it now drivers *do* call blk_cleanup_queue() on error paths
> prior to add_disk(). An example today is on drivers/block/loop.c where
> in loop_add(), if alloc_disk() fails we call  blk_cleanup_queue()
> *but* this error path *never* called put_disk() as
> drivers/block/pktcdvd.c did on error, and that is because it doesn't
> need to as the last error-path-induced call was alloc_disk(). So it
> doesn't need to free the disk as its not created on the error path of
> loop_add().
> 
> This will of course change once we make add_disk() return int, and
> capture errors, and it brings the question if we want to follow
> similar strategy for other drivers, however note that blk_put_queue()
> doesn't do everything blk_cleanup_queue() does, and in fact
> blk_cleanup_queue() states it sets up "the appropriate flags" *and*
> then calls blk_put_queue().
> 
> We'll have a a bit more collateral evolutions if we embrace the
> strategy in this commit, for those drivers that wish to start taking
> advantage of the error checks, but other then considering this, I
> thought it would be good to think about the fact that *today* we call
> blk_cleanup_queue() on error paths *without* the disk being yet
> associated either. This, in spite of the fact that the way we designed

Some drivers may have only request queue, and not have disk, such as
NVMe's admin queue, so I think blk_cleanup_queue() has to cover this
case.

> the queue, it sits on top of the disk from a kobject perspective once
> registered. Since we call blk_cleanup_queue() on error paths today --
> without a disk parent being possible -- it means nothing on
> blk_cleanup_queue() should not rely on it having a functional disk. Do
> we want to keep it that way? If we keep the practice of drivers using

Yes, see the reason above.


Thanks,
Ming

