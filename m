Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF3D6353
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 15:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfJNNFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 09:05:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbfJNNFM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:05:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DA5AC024B08;
        Mon, 14 Oct 2019 13:05:12 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1D0B608C2;
        Mon, 14 Oct 2019 13:05:11 +0000 (UTC)
Date:   Mon, 14 Oct 2019 09:05:09 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191014130509.GA12380@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
 <20191011123939.GD61257@bfoster>
 <20191011231323.GK16973@dread.disaster.area>
 <20191012120558.GA3307@bfoster>
 <20191013031450.GT16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013031450.GT16973@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 14 Oct 2019 13:05:12 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 13, 2019 at 02:14:50PM +1100, Dave Chinner wrote:
> On Sat, Oct 12, 2019 at 08:05:58AM -0400, Brian Foster wrote:
> > On Sat, Oct 12, 2019 at 10:13:23AM +1100, Dave Chinner wrote:
> > > On Fri, Oct 11, 2019 at 08:39:39AM -0400, Brian Foster wrote:
> > > > On Wed, Oct 09, 2019 at 02:21:02PM +1100, Dave Chinner wrote:
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > 
> > > > > The buffer cache shrinker frees more than just the xfs_buf slab
> > > > > objects - it also frees the pages attached to the buffers. Make sure
> > > > > the memory reclaim code accounts for this memory being freed
> > > > > correctly, similar to how the inode shrinker accounts for pages
> > > > > freed from the page cache due to mapping invalidation.
> > > > > 
> > > > > We also need to make sure that the mm subsystem knows these are
> > > > > reclaimable objects. We provide the memory reclaim subsystem with a
> > > > > a shrinker to reclaim xfs_bufs, so we should really mark the slab
> > > > > that way.
> > > > > 
> > > > > We also have a lot of xfs_bufs in a busy system, spread them around
> > > > > like we do inodes.
> > > > > 
> > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > ---
> > > > 
> > > > Seems reasonable, but for inodes we also spread the ili zone. Should we
> > > > not be consistent with bli's as well?
> > > 
> > > bli's are reclaimed when the buffer is cleaned. ili's live for the
> > > live of the inode in cache. Hence bli's are short term allocations
> > > (much shorter than xfs_bufs they attach to) and are reclaimed much
> > > faster than inodes and their ilis. There's also a lot less blis than
> > > ili's, so the spread of their footprint across memory nodes doesn't
> > > matter that much. Local access for the memcpy during formatting is
> > > probably more important than spreading the memory usage of them
> > > these days, anyway.
> > > 
> > 
> > Yes, the buffer/inode lifecycle difference is why why I presume bli
> > zones are not ZONE_RECLAIM like ili zones.
> 
> No, that is not the case. IO completion cleaning the buffer is what
> frees the bli. The ili can only be freed by reclaiming the inode, so
> it's memory that can only be returned to the free pool by running a
> shrinker. Hence ilis are ZONE_RECLAIM to account them as memory that
> can be reclaimed through shrinker invocation, while BLIs are not
> because memory reclaim can't directly cause them to be freed.
> 

That is pretty much what I said. I think we're in agreement.

> > This doesn't tell me anything about why buffers should be spread
> > around as such and buffer log items not, though..
> 
> xfs_bufs are long lived, are global structures, and can accumulate
> in the millions if the workload requires it. IOWs, we should spread
> xfs_bufs for exactly the same reasons inodes are spread.
> 
> As for BLIs, they are short term structures - a single xfs_buf might
> have thousands of different blis attached to it over it's life in
> the cache because the BLI is freed when the buffer is cleaned.
> 

Short term relative to the ILI perhaps, but these are still memory
allocations that outlive the allocating task returning to userspace, are
reused (across tasks) commonly enough and have an I/O bound life cycle.
That's also not considering page/slab buildup in the kmem cache beyond
the lifetime of individual allocations..

> We don't need to spread small short term structures around NUMA
> memory nodes because they don't present a long term memory imbalance
> vector. In general it is better to have them allocated local to the
> process that is using them where the memory access latency is
> lowest, knowing that they will be freed shortly and not contribute
> to long term memory usage.
> 

Hmm.. doesn't this all depend on enablement of a cgroup knob in the
first place? It looks to me that this behavior is tied to a per-task
state (not a per-mount or zone setting, which just allows such behavior
on the zone) where the controller has explicitly requested us to not
perform sustained allocations in the local node if possible. Instead,
spread slab allocations around at the cost of bypassing this local
allocation heuristic, presumably because $application wants prioritized
access to that memory. What am I missing?

BTW, it also looks like this is only relevant for slab. I don't see any
references in slub (or slob), but I haven't dug too deeply..

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
