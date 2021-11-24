Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1776F45D158
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhKXXs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:48:28 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57709 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235851AbhKXXs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:48:27 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 17DD610A06BD;
        Thu, 25 Nov 2021 10:45:12 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mq1wt-00Cr8N-OQ; Thu, 25 Nov 2021 10:45:11 +1100
Date:   Thu, 25 Nov 2021 10:45:11 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <20211124234511.GN418105@dread.disaster.area>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <163772381628.1891.9102201563412921921@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163772381628.1891.9102201563412921921@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=619ece8a
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=laKZI6_TNyetWoYyCsAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 02:16:56PM +1100, NeilBrown wrote:
> On Wed, 24 Nov 2021, Andrew Morton wrote:
> > 
> > I added GFP_NOFAIL back in the mesozoic era because quite a lot of
> > sites were doing open-coded try-forever loops.  I thought "hey, they
> > shouldn't be doing that in the first place, but let's at least
> > centralize the concept to reduce code size, code duplication and so
> > it's something we can now grep for".  But longer term, all GFP_NOFAIL
> > sites should be reworked to no longer need to do the retry-forever
> > thing.  In retrospect, this bright idea of mine seems to have added
> > license for more sites to use retry-forever.  Sigh.
> 
> One of the costs of not having GFP_NOFAIL (or similar) is lots of
> untested failure-path code.
> 
> When does an allocation that is allowed to retry and reclaim ever fail
> anyway? I think the answer is "only when it has been killed by the oom
> killer".  That of course cannot happen to kernel threads, so maybe
> kernel threads should never need GFP_NOFAIL??
> 
> I'm not sure the above is 100%, but I do think that is the sort of
> semantic that we want.  We want to know what kmalloc failure *means*.
> We also need well defined and documented strategies to handle it.
> mempools are one such strategy, but not always suitable.

mempools are not suitable for anything that uses demand paging to
hold an unbounded data set in memory before it can free anything.
This is basically the definition of memory demand in an XFS
transaction, and most transaction based filesystems have similar
behaviour.

> preallocating can also be useful but can be clumsy to implement.  Maybe
> we should support a process preallocating a bunch of pages which can
> only be used by the process - and are auto-freed when the process
> returns to user-space.  That might allow the "error paths" to be simple
> and early, and subsequent allocations that were GFP_USEPREALLOC would be
> safe.

We talked about this years ago at LSFMM (2013 or 2014, IIRC). The
problem is "how much do you preallocate when the worst case
requirement to guarantee forwards progress is at least tens of
megabytes". Considering that there might be thousands of these
contexts running concurrent at any given time and we might be
running through several million preallocation contexts a second,
suddenly preallocation is a great big CPU and memory pit.

Hence preallocation simply doesn't work when the scope to guarantee
forwards progress is in the order of megabytes (even tens of
megabytes) per "no fail" context scope.  In situations like this we
need -memory reservations-, not preallocation.

Have the mm guarantee that there is a certain amount of memory
available (even if it requires reclaim to make available) before we
start the operation that cannot tolerate memory allocation failure,
track the memory usage as it goes, warn if it overruns, and release
the unused part of the reservation when context completes.

[ This is what we already do in XFS for guaranteeing forwards
progress for writing modifications into the strictly bound journal
space. We reserve space up front and use tracking tickets to account
for space used across each transaction context. This avoids
overcommit and all the deadlock and corruption problems that come
from running out of physical log space to write all the changes
we've made into the log. We could simply add memory reservations and
tracking structures to the transaction context and we've pretty much
got everything we need on the XFS side covered... ]

> i.e. we need a plan for how to rework all those no-fail call-sites.

Even if we do make them all the filesystems handle ENOMEM errors
gracefully and pass that back up to userspace, how are applications
going to react to random ENOMEM errors when doing data writes or
file creation or any other operation that accesses filesystems?

Given the way applications handle transient errors (i.e. they
don't!) propagating ENOMEM back up to userspace will result in
applications randomly failing under memory pressure.  That's a much
worse situation than having to manage the _extremely rare_ issues
that occur because of __GFP_NOFAIL usage in the kernel.

Let's keep that in mind here - __GFP_NOFAIL usage is not causing
system failures in the real world, whilst propagating ENOMEM back
out to userspace is potentially very harmful to users....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
