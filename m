Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF23AD53FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 05:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfJMDO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Oct 2019 23:14:57 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41907 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727492AbfJMDO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Oct 2019 23:14:57 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 965C443E15C;
        Sun, 13 Oct 2019 14:14:51 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iJULK-0001Bd-QX; Sun, 13 Oct 2019 14:14:50 +1100
Date:   Sun, 13 Oct 2019 14:14:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191013031450.GT16973@dread.disaster.area>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191011123939.GD61257@bfoster>
 <20191011231323.GK16973@dread.disaster.area>
 <20191012120558.GA3307@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012120558.GA3307@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=E0tKC5H96g8Zf4X1ZPUA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 12, 2019 at 08:05:58AM -0400, Brian Foster wrote:
> On Sat, Oct 12, 2019 at 10:13:23AM +1100, Dave Chinner wrote:
> > On Fri, Oct 11, 2019 at 08:39:39AM -0400, Brian Foster wrote:
> > > On Wed, Oct 09, 2019 at 02:21:02PM +1100, Dave Chinner wrote:
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > The buffer cache shrinker frees more than just the xfs_buf slab
> > > > objects - it also frees the pages attached to the buffers. Make sure
> > > > the memory reclaim code accounts for this memory being freed
> > > > correctly, similar to how the inode shrinker accounts for pages
> > > > freed from the page cache due to mapping invalidation.
> > > > 
> > > > We also need to make sure that the mm subsystem knows these are
> > > > reclaimable objects. We provide the memory reclaim subsystem with a
> > > > a shrinker to reclaim xfs_bufs, so we should really mark the slab
> > > > that way.
> > > > 
> > > > We also have a lot of xfs_bufs in a busy system, spread them around
> > > > like we do inodes.
> > > > 
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > ---
> > > 
> > > Seems reasonable, but for inodes we also spread the ili zone. Should we
> > > not be consistent with bli's as well?
> > 
> > bli's are reclaimed when the buffer is cleaned. ili's live for the
> > live of the inode in cache. Hence bli's are short term allocations
> > (much shorter than xfs_bufs they attach to) and are reclaimed much
> > faster than inodes and their ilis. There's also a lot less blis than
> > ili's, so the spread of their footprint across memory nodes doesn't
> > matter that much. Local access for the memcpy during formatting is
> > probably more important than spreading the memory usage of them
> > these days, anyway.
> > 
> 
> Yes, the buffer/inode lifecycle difference is why why I presume bli
> zones are not ZONE_RECLAIM like ili zones.

No, that is not the case. IO completion cleaning the buffer is what
frees the bli. The ili can only be freed by reclaiming the inode, so
it's memory that can only be returned to the free pool by running a
shrinker. Hence ilis are ZONE_RECLAIM to account them as memory that
can be reclaimed through shrinker invocation, while BLIs are not
because memory reclaim can't directly cause them to be freed.

> This doesn't tell me anything about why buffers should be spread
> around as such and buffer log items not, though..

xfs_bufs are long lived, are global structures, and can accumulate
in the millions if the workload requires it. IOWs, we should spread
xfs_bufs for exactly the same reasons inodes are spread.

As for BLIs, they are short term structures - a single xfs_buf might
have thousands of different blis attached to it over it's life in
the cache because the BLI is freed when the buffer is cleaned.

We don't need to spread small short term structures around NUMA
memory nodes because they don't present a long term memory imbalance
vector. In general it is better to have them allocated local to the
process that is using them where the memory access latency is
lowest, knowing that they will be freed shortly and not contribute
to long term memory usage.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
