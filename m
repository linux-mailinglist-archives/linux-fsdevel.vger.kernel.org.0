Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D11B830F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 03:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDYBj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 21:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgDYBj4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 21:39:56 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A7021582;
        Sat, 25 Apr 2020 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587778796;
        bh=ZfCr/tvwAb9Da0oifIEjsLeqPe+mm8Nf8g/RQVqazWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d6nMgbR8j9nLUPiEp0AGRA6T7V07Ox8vG8CCdlP2HaLdxoOMViAYmqPt1NMkhb9c6
         cu7R0/Q/RXPDJHZFomWAT+rp8az/Hmny5uTcqEmqs/+qgD03qin3TWuZTTUO+mDXzb
         8vJRYs+dn/HF1j+YtiW6fEOn5+x2xIfZ27ajqEg4=
Received: by mail-vk1-f170.google.com with SMTP id p5so868266vke.1;
        Fri, 24 Apr 2020 18:39:55 -0700 (PDT)
X-Gm-Message-State: AGi0PuY6ybgvDMck7ckUIYdxGZK0duz1HlzmQN0kHpOonLifD/g0uOAL
        2r0b7tUlusSUnQqfNLJCe9bZJpqT26CjwX/O6Sg=
X-Google-Smtp-Source: APiQypIHNxUyeQJAtEYHURkEGFozifIBxTu/K1wxCq+D2bwJEWxkO0RcpusCChh4V9CKKzU0UfeEwA6hqTqQFJTH9bI=
X-Received: by 2002:a1f:a1d0:: with SMTP id k199mr10445316vke.78.1587778794787;
 Fri, 24 Apr 2020 18:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180102193948.22656-1-bart.vanassche@wdc.com> <20180102193948.22656-2-bart.vanassche@wdc.com>
In-Reply-To: <20180102193948.22656-2-bart.vanassche@wdc.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 24 Apr 2020 19:39:47 -0600
X-Gmail-Original-Message-ID: <CAB=NE6Uhn88Vrymb2x+=7YmieRguGKm9Dk1LiDqw6oggZJpp8g@mail.gmail.com>
Message-ID: <CAB=NE6Uhn88Vrymb2x+=7YmieRguGKm9Dk1LiDqw6oggZJpp8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pktcdvd: Fix pkt_setup_dev() error path
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So I hopped on a time machine to revise some old collateral due to
523e1d399ce ("block: make gendisk hold a reference to its queue")
merged on v3.2 which added the conditional check for the disk->queue
before calling blk_put_queue() on release_disk(). I started wondering
*why* the conditional was added, but I checked the original patch and
I could not find discussion around it.

Tejun, do you call why you added that conditional on

if (disk->queue)
  blk_put_queue(disk->queue);

This patch however struck me as one I should highlight, since I'm
reviewing all this now and dealing with adding error paths on
add_disk(). Below some notes.

On Tue, Jan 2, 2018 at 1:40 PM Bart Van Assche <bart.vanassche@wdc.com> wrote:
>
> Commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
> modified add_disk() and disk_release() but did not update any of the
> error paths that trigger a put_disk() call after disk->queue has been
> assigned. That introduced the following behavior in the pktcdvd driver
> if pkt_new_dev() fails:
>
> Kernel BUG at 00000000e98fd882 [verbose debug info unavailable]
>
> Since disk_release() calls blk_put_queue() anyway if disk->queue != NULL,
> fix this by removing the blk_cleanup_queue() call from the pkt_setup_dev()
> error path.
>
> Fixes: commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Cc: <stable@vger.kernel.org> # v3.2
> ---
>  drivers/block/pktcdvd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index 67974796c350..2659b2534073 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -2745,7 +2745,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
>         pd->pkt_dev = MKDEV(pktdev_major, idx);
>         ret = pkt_new_dev(pd, dev);
>         if (ret)
> -               goto out_new_dev;
> +               goto out_mem2;
>
>         /* inherit events of the host device */
>         disk->events = pd->bdev->bd_disk->events;
> @@ -2763,8 +2763,6 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
>         mutex_unlock(&ctl_mutex);
>         return 0;
>
> -out_new_dev:
> -       blk_cleanup_queue(disk->queue);
>  out_mem2:
>         put_disk(disk);
>  out_mem:
> --

As we have it now drivers *do* call blk_cleanup_queue() on error paths
prior to add_disk(). An example today is on drivers/block/loop.c where
in loop_add(), if alloc_disk() fails we call  blk_cleanup_queue()
*but* this error path *never* called put_disk() as
drivers/block/pktcdvd.c did on error, and that is because it doesn't
need to as the last error-path-induced call was alloc_disk(). So it
doesn't need to free the disk as its not created on the error path of
loop_add().

This will of course change once we make add_disk() return int, and
capture errors, and it brings the question if we want to follow
similar strategy for other drivers, however note that blk_put_queue()
doesn't do everything blk_cleanup_queue() does, and in fact
blk_cleanup_queue() states it sets up "the appropriate flags" *and*
then calls blk_put_queue().

We'll have a a bit more collateral evolutions if we embrace the
strategy in this commit, for those drivers that wish to start taking
advantage of the error checks, but other then considering this, I
thought it would be good to think about the fact that *today* we call
blk_cleanup_queue() on error paths *without* the disk being yet
associated either. This, in spite of the fact that the way we designed
the queue, it sits on top of the disk from a kobject perspective once
registered. Since we call blk_cleanup_queue() on error paths today --
without a disk parent being possible -- it means nothing on
blk_cleanup_queue() should not rely on it having a functional disk. Do
we want to keep it that way? If we keep the practice of drivers using
blk_cleanup_queue() safely on error paths it just means we'll have to
ensure blk_cleanup_queue() never requires the disk moving forward, and
document this. The commit above reflects a case where this was not
preferred and in fact needed, however I think just setting disk-queue
= NULL, would have done it, as then the last disk_release() would not
have called blk_put_queue()

Let me know if folks have a preference, this all new to me, so I'm in
hopes folks have tribal knowledge which would be helpful here.

  Luis
