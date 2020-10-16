Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC27A290561
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405074AbgJPMjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 08:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395004AbgJPMjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602851984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C0uj9cetJrhx8j6PK21cc9c8R84HWVVjoVhboDa35KU=;
        b=Cpp3zt8jDLT7IaoDQyOyxHTxfAf5WyDzvURFq6K3ADRB6iVX2uSU12vWJxTuallLhFGJor
        YfJuXKJX7u6CYW7MN6o/3FZlhvm+FH0VRVn2adtkdo11KFf8TBfzfgvA5SvrpVGBOVSd37
        PJVxIkGrnezTw8Jmnsfyh9n29i8GuKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-QG-3ExoaMmqLlKUbD7Tj6w-1; Fri, 16 Oct 2020 08:39:41 -0400
X-MC-Unique: QG-3ExoaMmqLlKUbD7Tj6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC1F18A0775;
        Fri, 16 Oct 2020 12:39:38 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C9AA7667D;
        Fri, 16 Oct 2020 12:39:30 +0000 (UTC)
Date:   Fri, 16 Oct 2020 20:39:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com
Subject: Re: [PATCH v3 2/2] block,iomap: disable iopoll when split needed
Message-ID: <20201016123925.GB1218835@T590>
References: <20201016091851.93728-1-jefflexu@linux.alibaba.com>
 <20201016091851.93728-3-jefflexu@linux.alibaba.com>
 <20201016102625.GA1218835@T590>
 <d6d6b80b-6b16-637a-fac3-7f5a161b8f51@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d6b80b-6b16-637a-fac3-7f5a161b8f51@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 07:02:44PM +0800, JeffleXu wrote:
> 
> On 10/16/20 6:26 PM, Ming Lei wrote:
> > On Fri, Oct 16, 2020 at 05:18:51PM +0800, Jeffle Xu wrote:
> > > Both blkdev fs and iomap-based fs (ext4, xfs, etc.) currently support
> > > sync iopoll. One single bio can contain at most BIO_MAX_PAGES, i.e. 256
> > > bio_vec. If the input iov_iter contains more than 256 segments, then
> > > one dio will be split into multiple bios, which may cause potential
> > > deadlock for sync iopoll.
> > > 
> > > When it comes to sync iopoll, the bio is submitted without REQ_NOWAIT
> > > flag set and the process may hang in blk_mq_get_tag() if the dio needs
> > > to be split into multiple bios and thus can rapidly exhausts the queue
> > > depth. The process has to wait for the completion of the previously
> > > allocated requests, which should be reaped by the following sync
> > > polling, and thus causing a deadlock.
> > > 
> > > In fact there's a subtle difference of handling of HIPRI IO between
> > > blkdev fs and iomap-based fs, when dio need to be split into multiple
> > > bios. blkdev fs will set REQ_HIPRI for only the last split bio, leaving
> > > the previous bios queued into normal hardware queues, and not causing
> > > the trouble described above. iomap-based fs will set REQ_HIPRI for all
> > > split bios, and thus may cause the potential deadlock decribed above.
> > > 
> > > Thus disable iopoll when one dio need to be split into multiple bios.
> > > Though blkdev fs may not suffer this issue, still it may not make much
> > > sense to iopoll for big IO, since iopoll is initially for small size,
> > > latency sensitive IO.
> > > 
> > > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > > ---
> > >   fs/block_dev.c       | 7 +++++++
> > >   fs/iomap/direct-io.c | 8 ++++++++
> > >   2 files changed, 15 insertions(+)
> > > 
> > > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > > index 9e84b1928b94..1b56b39e35b5 100644
> > > --- a/fs/block_dev.c
> > > +++ b/fs/block_dev.c
> > > @@ -436,6 +436,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
> > >   			break;
> > >   		}
> > > +		/*
> > > +		 * The current dio need to be split into multiple bios here.
> > > +		 * iopoll is initially for small size, latency sensitive IO,
> > > +		 * and thus disable iopoll if split needed.
> > > +		 */
> > > +		iocb->ki_flags &= ~IOCB_HIPRI;
> > > +
> > Not sure if it is good to clear IOCB_HIPRI of iocb, since it is usually
> > maintained by upper layer code(io_uring, aio, ...) and we shouldn't
> > touch this flag here.
> 
> If we queue bios into the DEFAULT hardware queue, but leaving the
> corresponding kiocb->ki_flags's
> 
> IOCB_HIPRI set (exactly what the first patch does), is this another
> inconsistency?

My question is that if it is good for this code to clear IOCB_HIPRI of iocb,
given this is the 1st such usage. And does io_uring implementation expect
the flag to be cleared by lower layer?

> 
> Please consider the following code snippet from __blkdev_direct_IO()
> 
> ```
> 	for (;;) {
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 		if (!READ_ONCE(dio->waiter))
> 			break;
> 
> 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> 		    !blk_poll(bdev_get_queue(bdev), qc, true))
> 			blk_io_schedule();
> 	}
> ```
> 
> The IOCB_HIPRI flag is still set in iocb->ki_flags, but the corresponding
> bios are queued into DEFAULT hardware queue since the first patch.
> blk_poll() is still called in this case.

It may be handled in the following way:

 		if (!((iocb->ki_flags & IOCB_HIPRI) && !dio->multi_bio) ||
 		    !blk_poll(bdev_get_queue(bdev), qc, true))
 				blk_io_schedule();

BTW, even for single bio with IOCB_HIPRI, the single fs bio can still be
splitted, and blk_poll() will be called too.


Thanks, 
Ming

