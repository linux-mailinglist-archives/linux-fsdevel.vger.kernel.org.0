Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF872474
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 04:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfGXCYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 22:24:20 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56574 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726108AbfGXCYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:24:19 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BD4B01ED9B1;
        Wed, 24 Jul 2019 12:24:16 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hq6vt-0005GG-NF; Wed, 24 Jul 2019 12:23:09 +1000
Date:   Wed, 24 Jul 2019 12:23:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: EIO with io_uring O_DIRECT writes on ext4
Message-ID: <20190724022309.GZ7777@dread.disaster.area>
References: <20190723080701.GA3198@stefanha-x1.localdomain>
 <9a13c3b9-ecf2-6ba7-f0fb-c59a1e1539f3@kernel.dk>
 <20190723220502.GX7777@dread.disaster.area>
 <d875750c-62ce-5773-39a7-74d5bf920aaf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d875750c-62ce-5773-39a7-74d5bf920aaf@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=0zNzEECMAAAA:20 a=u-UUKw4dAAAA:8 a=7-415B0cAAAA:8
        a=dpbPxidW0Cb951tOLkUA:9 a=CjuIK1q_8ugA:10 a=cklHB5Dw1nV-3JPruhv7:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 04:19:31PM -0600, Jens Axboe wrote:
> On 7/23/19 4:05 PM, Dave Chinner wrote:
> > On Tue, Jul 23, 2019 at 09:20:05AM -0600, Jens Axboe wrote:
> >> On 7/23/19 2:07 AM, Stefan Hajnoczi wrote:
> >>> Hi,
> >>> io_uring O_DIRECT writes can fail with EIO on ext4.  Please see the
> >>> function graph trace from Linux 5.3.0-rc1 below for details.  It was
> >>> produced with the following qemu-io command (using Aarushi's QEMU
> >>> patches from https://github.com/rooshm/qemu/commits/io_uring):
> >>>
> >>>     $ qemu-io --cache=none --aio=io_uring --format=qcow2 -c 'writev -P 185 131072 65536' tests/qemu-iotests/scratch/test.qcow2
> >>>
> >>> This issue is specific to ext4.  XFS and the underlying LVM logical
> >>> volume both work.
> >>>
> >>> The storage configuration is an LVM logical volume (device-mapper linear
> >>> target), on top of LUKS, on top of a SATA disk.  The logical volume's
> >>> request_queue does not have mq_ops and this causes
> >>> generic_make_request_checks() to fail:
> >>>
> >>>     if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
> >>>             goto not_supported;
> >>>
> >>> I guess this could be worked around by deferring the request to the
> >>> io_uring work queue to avoid REQ_NOWAIT.  But XFS handles this fine so
> >>> how can io_uring.c detect this case cleanly or is there a bug in ext4?
> >>
> >> I actually think it's XFS that's broken here, it's not passing down
> >> the IOCB_NOWAIT -> IOMAP_NOWAIT -> REQ_NOWAIT. This means we lose that
> >> important request bit, and we just block instead of triggering the
> >> not_supported case.
> > 
> > I wouldn't say XFS is broken, we didn't implement it because it
> > meant that IOCB_NOWAIT did not work on all block devices. i.e. the
> > biggest issue IOCB_NOWAIT is avoiding is blocking on filesytem
> > locks, and blocking in the request queue was largely just noise for
> > the applications RWF_NOWAIT was initially implemented for.
> 
> Blocking due to resource starvation (like requests) is definitely not
> just noise, in some case it's cases it's an equal or larger amount of
> time.

Yes, it can be, but that wasn't what RWF_NOWAIT was targetted at -
it was for non-blocking AIO-based applications like the seastar DB
which was primarily deployed on XFS.

Indeed, it was largely for avoiding latencies in filesystem extent
allocation - having a filesystem block on space allocation means it
might issue and wait synchronously for tens of metadata IOs (which
may all throttled in the block layer individually), block on memory
reclaim trying to allocate the memory for all that metadata, block
on log space whihc might require thousands of IOs to be issued and
complete, etc.

i.e.  the latency of space allocation during IO submission can
be orders of magnitude worse than just submission of a single bio
that hits a congested queue. Blocking in the request queue for a
single IO dispatch is just noise compared to the long tail latencies
RWF_NOWAIT avoids in the filesystem layers.

> > IOWs, if you have the wrong hardware, you can't use RWF_NOWAIT at
> 
> Define wrong...

Wrong as in any hardware that doesn't have a blk_mq driver
interface.

Which means it's not just hardware that is a problem here, it's also
stacked software device configs (e.g. various dm/md configs,
loopback, etc) that can cause RWF_NOWAIT IO to mysteriously fail...

> > level. Hence to say how IOMAP_NOWAIT is implemented (i.e. does not
> > set REQ_NOWAIT) is broken ignores the fact that RWF_NOWAIT was
> > originally intended as a "don't block on contended filesystem locks"
> > directive, not as something that is conditional on block layer
> > functionality...
> 
> RWF_NOWAIT should have nothing to do with the block layer at all, each
> storage layer would have to support it.

Jens, that's -exactly- the problem I'm telling you exists - the
fs/direct-io.c code path sets REQ_NOWAIT unconditionally when
RWF_NOWAIT is set in userspace via:

RWF_NOWAIT -> IOCB_NOWAIT -> fs/direct-io.c -> REQ_NOWAIT

And hence userspace IO fails in very unpredictable ways. Indeed, it
only does this for write direct IOs - why would you want to not
block DIO writes but allow blocking DIO reads is beyond me, but
that's what the code does, and that's why it breaks....

> >> Outside of that, that case needs similar treatment to what I did for
> >> the EAGAIN case here:
> >>
> >> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=893a1c97205a3ece0cbb3f571a3b972080f3b4c7
> > 
> > I don't see REQ_NOWAIT_INLINE in 5.3-rc1.
> 
> That's because it isn't in 5.3-rc1 :-)
> 
> > However, nobody checks the cookie returned by submit_bio() for error
> > status. It's only a recent addition for block polling and so the
> > only time it is checked is if we are polling and it gets passed to
> > blk_poll when RWF_HIPRI is set. So this change, by itself, doesn't
> > solve any problem.
> 
> REQ_NOWAIT wasn't introduced as part of the polling work, it was done
> earlier for libaio.

I know that.

I was talking about the introduction of returning of errors from
submit_bio() - that came with RWF_HIPRI, not the introduction of
REQ_NOWAIT. Two different things altogether, and that means there is
no support anywhere for REQ_NOWAIT_INLINE error handling except
the block polling code.

> > In fact, the way the direct IO code is right now a multi-bio DIO
> > submission will overwrite the submit cookie repeatedly and hence may
> > end up only doing partial submission but still report success
> > because the last bio in the chain didn't block and REQ_NOWAIT_INLINE
> > doesn't actually mark the bio itself with an error, so the bio
> > completion function won't report it, either.
> 
> Agree, details around multi-bio was largely ignored for the polling,
> since multi-bio implies larger IO and that was somewhat ignored (as less
> interesting).

So it was never tested and so nobody developing that functionality
noticed that block device congestion can result in random data
corruption when RWF_HIPRI is used.

I have absolutely nothing good to say in response to this
relevation.

> > Indeed, I think REQ_NOWAIT is largely redundant, because if we care
> > about IO submission blocking because the request queue is full, then
> > we simply use the existing bdi_congested() interface to check.
> > That works for all types of block devices - not just random mq
> > devices - and matches code we have all over the kernel to avoid
> > blocking async IO submission on congested reuqest queues...
> 
> No... The congestion logic is silly and I think a design mistake from
> way back when. There's no race free way to answer that question and
> utilize the answer safely,

We don't care that it's racy - RWF_NOWAIT is best effort only, so if
we occasionally get it wrong and block it's not the end of the
world. Perfect is the enemy of good; having something that is good
that works for everything is far, far better than having something
perfect that only works for certain configurations.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
