Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D91827D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 01:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfHEXK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 19:10:58 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:34154 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727928AbfHEXK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 19:10:58 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 68C7E43B2AC;
        Tue,  6 Aug 2019 09:10:52 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hum6r-0005DC-3s; Tue, 06 Aug 2019 09:09:45 +1000
Date:   Tue, 6 Aug 2019 09:09:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Mason <clm@fb.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 09/24] xfs: don't allow log IO to be throttled
Message-ID: <20190805230945.GX7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-10-david@fromorbit.com>
 <F1E7CC65-D2CB-4078-9AA3-9D172ECDE17B@fb.com>
 <20190801235849.GO7777@dread.disaster.area>
 <7093F5C3-53D2-4C49-9C0D-64B20C565D18@fb.com>
 <20190802232814.GP7777@dread.disaster.area>
 <C823BAA1-18D5-4C25-9506-59A740817E8C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C823BAA1-18D5-4C25-9506-59A740817E8C@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=7yUhBBlLHTuIPOx24mIA:9 a=GhxPB0XkBjz6INEC:21
        a=iFLSscLS6nnWKZIu:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 06:32:51PM +0000, Chris Mason wrote:
> On 2 Aug 2019, at 19:28, Dave Chinner wrote:
> 
> > On Fri, Aug 02, 2019 at 02:11:53PM +0000, Chris Mason wrote:
> >> On 1 Aug 2019, at 19:58, Dave Chinner wrote:
> >> I can't really see bio->b_ioprio working without the rest of the IO
> >> controller logic creating a sensible system,
> >
> > That's exactly the problem we need to solve. The current situation
> > is ... untenable. Regardless of whether the io.latency controller
> > works well, the fact is that the wbt subsystem is active on -all-
> > configurations and the way it "prioritises" is completely broken.
> 
> Completely broken is probably a little strong.   Before wbt, it was 
> impossible to do buffered IO without periodically saturating the drive 
> in unexpected ways.  We've got a lot of data showing it helping, and 
> it's pretty easy to setup a new A/B experiment to demonstrate it's 
> usefulness in current kernels.  But that doesn't mean it's perfect.

I'm not arguing that wbt is useless, I'm just saying that it's
design w.r.t. IO prioritisation is fundamentally broken. Using
request types to try to infer priority just doesn't work, as I've
been trying to explain.

> >> framework to define weights etc.  My question is if it's worth trying
> >> inside of the wbt code, or if we should just let the metadata go
> >> through.
> >
> > As I said, that doesn't  solve the problem. We /want/ critical
> > journal IO to have higher priority that background metadata
> > writeback. Just ignoring REQ_META doesn't help us there - it just
> > moves the priority inversion to blocking on request queue tags.
> 
> Does XFS background metadata IO ever get waited on by critical journal 
> threads?

No. Background writeback (which, with this series, is the only way
metadata gets written in XFS) is almost entirely non-blocking until
IO submission occurs. It will force the log if pinned items are
prevents the log tail from moving (hence blocking on log IO) but
largely it doesn't block on anything except IO submission.

The only thing that blocks on journal IO is CIL flushing and,
subsequently, anything that is waiting on a journal flush to
complete. CIL flushing happens in it's own workqueue, so it doesn't
block anything directly. The only operations that wait for log IO
require items to be stable in the journal (e.g. fsync()).

Starting a transactional change may block on metadata writeback. If
there isn't space in the log for the new transaction, it will kick
and wait for background metadata writeback to make progress and push
the tail of the log forwards.  And this may wait on journal IO if
pinned items need to be flushed to the log before writeback can
occur.

This is the way we prevent transactions requiring journal IO to
blocking on metadata writeback to make progress - we don't allow a
transaction to start until it is guaranteed that it can complete
without requiring journal IO to flush other metadata to the journal.
That way there is always space available in the log for all pending
journal IO to complete with a dependency no metadata writeback
making progress.

This "block on metadata writeback at transaction start" design means
data writeback can block on metadata writeback because we do
allocation transactions in the IO path. Which means data IO can
block behind metadata IO, which can block behind log IO, and that
largely defines the IO heirarchy in XFS.

Hence the IO priority order is very clear in XFS - it was designed
this way because you can't support things like guaranteed rate IO
storage applications (one of the prime use cases XFS was originally
designed for) without having a clear model for avoiding priority
inversions between data, metadata and the journal.

I'm not guessing about any of this - I know how all this is supposed
to work because I spent years at SGI working with people far smarter
than me supporting real-time IO applications working along with
real-time IO schedulers in a real time kernel (i.e.  Irix). I don't
make this stuff up for fun or to argue, I say stuff because I know
how it's supposed to work.

And, FWIW, Irix also had a block layer writeback throttling
mechanism to prevent bulk data writeback from thrashing disks and
starving higher priority IO. It was also fully IO priority aware -
this stuff isn't rocket science, and Linux is not the first OS to
ever implement this sort of functionality. Linux was not my first
rodeo....

> My understanding is that all of the filesystems do this from 
> time to time.  Without a way to bump the priority of throttled 
> background metadata IO, I can't see how to avoid prio inversions without 
> running background metadata at the same prio as all of the critical 
> journal IO.

Perhaps you just haven't thought about it enough. :)

> > Core infrastructure needs to work without cgroups being configured
> > to confine everything in userspace to "safe" bounds, and right now
> > just running things in the root cgroup doesn't appear to work very
> > well at all.
> 
> I'm not disagreeing with this part, my real point is there isn't a 
> single answer.  It's possible for swap to be critical to the running of 
> the box in some workloads, and totally unimportant in others.

Sure, but that only indicates that we need to be able to adjust the
priority of IO within certain bounds.

The problem is right now is that the default behaviour is pretty
nasty and core functionality is non-functional. It doesn't matter if
swap priority is adjustable or not, users should not have to tune
the kernel to use an esoteric cgroup configuration in order for the
kernel to function correctly out of the box.

I'm not sure when we lost sight of the fact we need to make the
default configurations work correctly first, and only then do we
worry about how tunable somethign is when the default behaviour has
been proven to be insufficient. Hiding bad behaviour behind custom
cgroup configuration does nobody any favours.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
