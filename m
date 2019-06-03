Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11C132764
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 06:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfFCEZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 00:25:50 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47714 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfFCEZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:25:50 -0400
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au [49.180.144.61])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 58010105E579;
        Mon,  3 Jun 2019 14:25:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hXeXU-0003gB-Ot; Mon, 03 Jun 2019 14:25:40 +1000
Date:   Mon, 3 Jun 2019 14:25:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
Message-ID: <20190603042540.GH29573@dread.disaster.area>
References: <20190527172655.9287-1-amir73il@gmail.com>
 <20190528202659.GA12412@mit.edu>
 <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
 <CAOQ4uxgj94WR82iHE4PDGSD0UDxG5sCtr+Sv+t1sOHHmnXFYzQ@mail.gmail.com>
 <20190531164136.GA3066@mit.edu>
 <20190531224549.GF29573@dread.disaster.area>
 <20190531232852.GG29573@dread.disaster.area>
 <CAOQ4uxi99NDYMrz-Q7xKta4beQiYFX3-MipZ_RxFNktFTA=vMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi99NDYMrz-Q7xKta4beQiYFX3-MipZ_RxFNktFTA=vMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=07d9gI8wAAAA:8 a=hbhAGIz_z3R__8BJwpYA:9
        a=8xQTuTa32-gkxqBk:21 a=k5YJsRp0j8SCPEeh:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=e2CUPOnPG4QKp8I52DXD:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 01, 2019 at 11:01:42AM +0300, Amir Goldstein wrote:
> On Sat, Jun 1, 2019 at 2:28 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Sat, Jun 01, 2019 at 08:45:49AM +1000, Dave Chinner wrote:
> > > Given that we can already use AIO to provide this sort of ordering,
> > > and AIO is vastly faster than synchronous IO, I don't see any point
> > > in adding complex barrier interfaces that can be /easily implemented
> > > in userspace/ using existing AIO primitives. You should start
> > > thinking about expanding libaio with stuff like
> > > "link_after_fdatasync()" and suddenly the whole problem of
> > > filesystem data vs metadata ordering goes away because the
> > > application directly controls all ordering without blocking and
> > > doesn't need to care what the filesystem under it does....
> >
> > And let me point out that this is also how userspace can do an
> > efficient atomic rename - rename_after_fdatasync(). i.e. on
> > completion of the AIO_FSYNC, run the rename. This guarantees that
> > the application will see either the old file of the complete new
> > file, and it *doesn't have to wait for the operation to complete*.
> > Once it is in flight, the file will contain the old data until some
> > point in the near future when will it contain the new data....
> 
> What I am looking for is a way to isolate the effects of "atomic rename/link"
> from the rest of the users.  Sure there is I/O bandwidth and queued
> bios, but at least isolate other threads working on other files or metadata
> from contending with the "atomic rename" thread of journal flushes and
> the like.

That's not a function of the kernel API. That's a function of the
implementation behind the kernel API. i.e. The API requires data to
be written before the rename/link is committed, how that is achieved
is up to the filesystem. And some filesystems will not be able to
isolate the API behavioural requirement from other users....

> Actually, one of my use cases is "atomic rename" of files with
> no data (looking for atomicity w.r.t xattr and mtime), so this "atomic rename"
> thread should not be interfering with other workloads at all.

Which should already guaranteed because a) rename is supposed to be
atomic, and b) metadata ordering requirements in journalled
filesystems. If they lose xattrs across rename, there's something
seriously wrong with the filesystem implementation.  I'm really not
sure what you think filesystems are actually doing with metadata
across rename operations....

> > Seriously, sit down and work out all the "atomic" data vs metadata
> > behaviours you want, and then tell me how many of them cannot be
> > implemented as "AIO_FSYNC w/ completion callback function" in
> > userspace. This mechanism /guarantees ordering/ at the application
> > level, the application does not block waiting for these data
> > integrity operations to complete, and you don't need any new kernel
> > side functionality to implement this.
> 
> So I think what I could have used is AIO_BATCH_FSYNC, an interface
> that was proposed by Ric Wheeler and discussed on LSF:
> https://lwn.net/Articles/789024/
> Ric was looking for a way to efficiently fsync a "bunch of files".
> Submitting several AIO_FSYNC calls is not the efficient way of doing that.

/me sighs.

That's not what I just suggested, and I've already addressed this
"AIO_FSYNC sucks" FUD in multiple separate threads.  You do realise
you can submit multiple AIO operations with a single io_submit()
call, right?

	struct iocb	ioc[10];
	struct io_event ev[10];

	for (i = 0; i < 10; i++) {
		io_prep_fsync(&ioc[i], fd[i]);
		ioc[i]->data = callback_arg[i];
	}

	io_submit(aio_ctx, 10, &ioc);
	io_getevents(aio_ctx, 10, 10, ev, NULL);

	for (i = 0; i < 10; i++)
		post_fsync_callback(&ev[i]);


There's your single syscall AIO_BATCH_FSYNC functionality, and it
implements a per-fd post-fsync callback function. This isn't rocket
science....

[snip]

> I am trying to reduce the number of fsyncs from applications
> and converting fsync to AIO_FSYNC is not going to help with that.

Your whole argument is "fsync is inefficient because cache flushes,
therefore AIO_FSYNC must be inefficient." IOWs, you've already
decided what is wrong, how it can and can't be fixed and the
solution you want regardless of whether your assertions are correct
or not. You haven't provided any evidence that a new kernel API is
the only viable solution, nor that the existing ones cannot provide
the functionality you require.

So, in the interests of /informed debate/, please implement what you
want using batched AIO_FSYNC + rename/linkat completion callback and
measure what it acheives. Then implement a sync_file_range/linkat
thread pool that provides the same functionality to the application
(i.e. writeback concurrency in userspace) and measure it. Then we
can discuss what the relative overhead is with numbers and can
perform analysis to determine what the cause of the performance
differential actually is.

Neither of these things require kernel modifications, but you need
to provide the evidence that existing APIs are insufficient.
Indeed, we now have the new async ioring stuff that can run async
sync_file_range calls, so you probably need to benchmark replacing
AIO_FSYNC with that interface as well. This new API likely does
exactly what you want without the journal/device cache flush
overhead of AIO_FSYNC....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
