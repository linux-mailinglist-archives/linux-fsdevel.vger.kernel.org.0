Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97BF885AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 00:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfHIWOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 18:14:03 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38798 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfHIWOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:14:03 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6AD0036420D;
        Sat, 10 Aug 2019 08:13:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hwD7w-000108-Ua; Sat, 10 Aug 2019 08:12:48 +1000
Date:   Sat, 10 Aug 2019 08:12:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] block: annotate refault stalls from IO submission
Message-ID: <20190809221248.GK7689@dread.disaster.area>
References: <20190808190300.GA9067@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808190300.GA9067@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=tU5beferOtS2JaHV9NYA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:03:00PM -0400, Johannes Weiner wrote:
> psi tracks the time tasks wait for refaulting pages to become
> uptodate, but it does not track the time spent submitting the IO. The
> submission part can be significant if backing storage is contended or
> when cgroup throttling (io.latency) is in effect - a lot of time is

Or the wbt is throttling.

> spent in submit_bio(). In that case, we underreport memory pressure.
> 
> Annotate submit_bio() to account submission time as memory stall when
> the bio is reading userspace workingset pages.

PAtch looks fine to me, but it raises another question w.r.t. IO
stalls and reclaim pressure feedback to the vm: how do we make use
of the pressure stall infrastructure to track inode cache pressure
and stalls?

With the congestion_wait() and wait_iff_congested() being entire
non-functional for block devices since 5.0, there is no IO load
based feedback going into memory reclaim from shrinkers that might
require IO to free objects before they can be reclaimed. This is
directly analogous to page reclaim writing back dirty pages from
the LRU, and as I understand it one of things the PSI is supposed
to be tracking.

Lots of workloads create inode cache pressure and often it can
dominate the time spent in memory reclaim, so it would seem to me
that having PSI only track/calculate pressure and stalls from LRU
pages misses a fair chunk of the memory pressure and reclaim stalls
that can be occurring.

Any thoughts of how we might be able to integrate more of the system
caches into the PSI infrastructure, Johannes?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
