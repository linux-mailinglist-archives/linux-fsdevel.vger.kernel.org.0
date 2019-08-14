Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078668D0F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfHNKoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 06:44:24 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47358 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbfHNKoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:44:23 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9F7EB43D394;
        Wed, 14 Aug 2019 20:44:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hxqkI-0001pY-Aq; Wed, 14 Aug 2019 20:43:10 +1000
Date:   Wed, 14 Aug 2019 20:43:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <msnitzer@redhat.com>, junxiao.bi@oracle.com,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        honglei.wang@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] direct-io: use GFP_NOIO to avoid deadlock
Message-ID: <20190814104310.GN6129@dread.disaster.area>
References: <alpine.LRH.2.02.1908080540240.15519@file01.intranet.prod.int.rdu2.redhat.com>
 <20190809013403.GY7777@dread.disaster.area>
 <alpine.LRH.2.02.1908090725290.31061@file01.intranet.prod.int.rdu2.redhat.com>
 <20190809215733.GZ7777@dread.disaster.area>
 <alpine.LRH.2.02.1908131231010.6852@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1908131231010.6852@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=B-2tCdbVYXm3Rcn1sc0A:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:35:49PM -0400, Mikulas Patocka wrote:
> 
> 
> On Sat, 10 Aug 2019, Dave Chinner wrote:
> 
> > No, you misunderstand. I'm talking about blocking kswapd being
> > wrong.  i.e. Blocking kswapd in shrinkers causes problems
> > because th ememory reclaim code does not expect kswapd to be
> > arbitrarily delayed by waiting on IO. We've had this problem with
> > the XFS inode cache shrinker for years, and there are many reports
> > of extremely long reclaim latencies for both direct and kswapd
> > reclaim that result from kswapd not making progress while waiting
> > in shrinkers for IO to complete.
> > 
> > The work I'm currently doing to fix this XFS problem can be found
> > here:
> > 
> > https://lore.kernel.org/linux-fsdevel/20190801021752.4986-1-david@fromorbit.com/
> > 
> > 
> > i.e. the point I'm making is that waiting for IO in kswapd reclaim
> > context is considered harmful - kswapd context shrinker reclaim
> > should be as non-blocking as possible, and any back-off to wait for
> > IO to complete should be done by the high level reclaim core once
> > it's completed an entire reclaim scan cycle of everything....
> > 
> > What follows from that, and is pertinent for in this situation, is
> > that if you don't block kswapd, then other reclaim contexts are not
> > going to get stuck waiting for it regardless of the reclaim context
> > they use.
> > 
> > Cheers,
> > 
> > Dave.
> 
> So, what do you think the dm-bufio shrinker should do?

I'm not familiar with the constraints the code operates under, so
I can't guarantee that I have an answer for you... :/

> Currently it tries to free buffers on the clean list and if there are not 
> enough buffers on the clean list, it goes into the dirty list - it writes 
> the buffers back and then frees them.
> 
> What should it do? Should it just start writeback of the dirty list 
> without waiting for it? What should it do if all the buffers are under 
> writeback?

For kswapd, it should do what it can without blocking. e.g. kicking
an async writer thread rather than submitting the IO itself. That's
what I changes XFS to do.

And if you look at the patchset in the above link, it also
introduced a mechanism for shrinkers to communicate back to the high
level reclaim code that kswapd needs to back off
(reclaim_state->need_backoff).

With these mechanism, the shrinker can start IO without blocking
kswapd on congested request queues and tell memory reclaim to wait
before calling this shrinker again. This allows kswapd to aggregate
all the waits that shrinkers and page reclaim require to all
progress to be made into a single backoff event. That means kswapd
does other scanning work while background writeback goes on, and
once everythign is scanned it does a single wait for everything that
needs time to make progress...

I think that should also work for the dm-bufio shrinker, and the the
direct reclaim backoff parts of the patchset should work for
non-blocking direct reclaim scanning as well, like it now does for
XFS.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
