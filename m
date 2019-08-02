Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4580338
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 01:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbfHBX3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 19:29:31 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36086 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389372AbfHBX3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:29:30 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0D1457E4EA2;
        Sat,  3 Aug 2019 09:29:21 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1htgy6-0003vE-9w; Sat, 03 Aug 2019 09:28:14 +1000
Date:   Sat, 3 Aug 2019 09:28:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Chris Mason <clm@fb.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 09/24] xfs: don't allow log IO to be throttled
Message-ID: <20190802232814.GP7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-10-david@fromorbit.com>
 <F1E7CC65-D2CB-4078-9AA3-9D172ECDE17B@fb.com>
 <20190801235849.GO7777@dread.disaster.area>
 <7093F5C3-53D2-4C49-9C0D-64B20C565D18@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7093F5C3-53D2-4C49-9C0D-64B20C565D18@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=clMkuYwxY4VUjy_4T2YA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 02:11:53PM +0000, Chris Mason wrote:
> On 1 Aug 2019, at 19:58, Dave Chinner wrote:
> I can't really see bio->b_ioprio working without the rest of the IO 
> controller logic creating a sensible system,

That's exactly the problem we need to solve. The current situation
is ... untenable. Regardless of whether the io.latency controller
works well, the fact is that the wbt subsystem is active on -all-
configurations and the way it "prioritises" is completely broken.

> framework to define weights etc.  My question is if it's worth trying 
> inside of the wbt code, or if we should just let the metadata go 
> through.

As I said, that doesn't  solve the problem. We /want/ critical
journal IO to have higher priority that background metadata
writeback. Just ignoring REQ_META doesn't help us there - it just
moves the priority inversion to blocking on request queue tags.

> Tejun reminded me that in a lot of ways, swap is user IO and it's 
> actually fine to have it prioritized at the same level as user IO.  We 

I think that's wrong. Swap *in* could have user priority but swap
*out* is global as there is no guarantee that the page being swapped
belongs to the user context that is reclaiming memory.

Lots of other user and kernel reclaim contexts may be waiting on
that swap to complete, so it's important that swap out is not
arbitrarily delayed or susceptible to priority inversions. i.e. swap
out must take priority over swap-in and other user IO because that
IO may require allocation to make progress via swapping to free
"user" file data cached in memory....

> don't want to let a low prio app thrash the drive swapping things in and 
> out all the time,

Low priority apps will be throttled on *swap in* IO - i.e. by their
incoming memory demand. High priority apps should be swapping out
low priority app memory if there are shortages - that's what priority
defines....

> other higher priority processes aren't waiting for the memory.  This 
> depends on the cgroup config, so wrt your current patches it probably 
> sounds crazy, but we have a lot of data around this from the fleet.

I'm not using cgroups.

Core infrastructure needs to work without cgroups being configured
to confine everything in userspace to "safe" bounds, and right now
just running things in the root cgroup doesn't appear to work very
well at all.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
