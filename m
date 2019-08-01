Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261317E6F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 02:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfHBAAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 20:00:02 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56173 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731376AbfHBAAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 20:00:02 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 7201F363416;
        Fri,  2 Aug 2019 09:59:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1htKy9-0003Va-4v; Fri, 02 Aug 2019 09:58:49 +1000
Date:   Fri, 2 Aug 2019 09:58:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Mason <clm@fb.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 09/24] xfs: don't allow log IO to be throttled
Message-ID: <20190801235849.GO7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-10-david@fromorbit.com>
 <F1E7CC65-D2CB-4078-9AA3-9D172ECDE17B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F1E7CC65-D2CB-4078-9AA3-9D172ECDE17B@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=j1scD-lSN6Y4ri9hJcUA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 01:39:34PM +0000, Chris Mason wrote:
> On 31 Jul 2019, at 22:17, Dave Chinner wrote:
> 
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Running metadata intensive workloads, I've been seeing the AIL
> > pushing getting stuck on pinned buffers and triggering log forces.
> > The log force is taking a long time to run because the log IO is
> > getting throttled by wbt_wait() - the block layer writeback
> > throttle. It's being throttled because there is a huge amount of
> > metadata writeback going on which is filling the request queue.
> >
> > IOWs, we have a priority inversion problem here.
> >
> > Mark the log IO bios with REQ_IDLE so they don't get throttled
> > by the block layer writeback throttle. When we are forcing the CIL,
> > we are likely to need to to tens of log IOs, and they are issued as
> > fast as they can be build and IO completed. Hence REQ_IDLE is
> > appropriate - it's an indication that more IO will follow shortly.
> >
> > And because we also set REQ_SYNC, the writeback throttle will no
> > treat log IO the same way it treats direct IO writes - it will not
> > throttle them at all. Hence we solve the priority inversion problem
> > caused by the writeback throttle being unable to distinguish between
> > high priority log IO and background metadata writeback.
> >
>   [ cc Jens ]
> 
> We spent a lot of time getting rid of these inversions in io.latency 
> (and the new io.cost), where REQ_META just blows through the throttling 
> and goes into back charging instead.

Which simply reinforces the fact that that request type based
throttling is a fundamentally broken architecture.

> It feels awkward to have one set of prio inversion workarounds for io.* 
> and another for wbt.  Jens, should we make an explicit one that doesn't 
> rely on magic side effects, or just decide that metadata is meta enough 
> to break all the rules?

The problem isn't REQ_META blows throw the throttling, the problem
is that different REQ_META IOs have different priority.

IOWs, the problem here is that we are trying to infer priority from
the request type rather than an actual priority assigned by the
submitter. There is no way direct IO has higher priority in a
filesystem than log IO tagged with REQ_META as direct IO can require
log IO to make progress. Priority is a policy determined by the
submitter, not the mechanism doing the throttling.

Can we please move this all over to priorites based on
bio->b_ioprio? And then document how the range of priorities are
managed, such as:

(99 = highest prio to 0 = lowest)

swap out
swap in				>90
User hard RT max		89
User hard RT min		80
filesystem max			79
ionice max			60
background data writeback	40
ionice min			20
filesystem min			10
idle				0

So that we can appropriately prioritise different types of kernel
internal IO w.r.t user controlled IO priorities? This way we can
still tag the bios with the type of data they contain, but we
no longer use that to determine whether to throttle that IO or not -
throttling/scheduling should be done entirely on a priority basis.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
