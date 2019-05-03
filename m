Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9F5126AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 06:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfECERf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 00:17:35 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47883 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbfECERf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 00:17:35 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5C68810C7FA;
        Fri,  3 May 2019 14:17:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hMPdX-0007M4-4d; Fri, 03 May 2019 14:17:27 +1000
Date:   Fri, 3 May 2019 14:17:27 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Davidlohr Bueso <dbueso@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <20190503041727.GL29573@dread.disaster.area>
References: <20190404165737.30889-1-amir73il@gmail.com>
 <20190404211730.GD26298@dastard>
 <20190408103303.GA18239@quack2.suse.cz>
 <1554741429.3326.43.camel@suse.com>
 <20190411011117.GC29573@dread.disaster.area>
 <20190416122240.GN29573@dread.disaster.area>
 <20190418031013.GX29573@dread.disaster.area>
 <1555611694.18313.12.camel@suse.com>
 <20190420235412.GY29573@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420235412.GY29573@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=UJetJGXy c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=D79AUM_G46nmkUiCrisA:9 a=p9yrIyJAQYQFRsFV:21
        a=oE2srWebBFOnxU3x:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 21, 2019 at 09:54:12AM +1000, Dave Chinner wrote:
> On Thu, Apr 18, 2019 at 11:21:34AM -0700, Davidlohr Bueso wrote:
> > On Thu, 2019-04-18 at 13:10 +1000, Dave Chinner wrote:
> > > Now the stuff I've been working on has the same interface as
> > > Davidlohr's patch, so I can swap and change them without thinking
> > > about it. It's still completely unoptimised, but:
> > > 
> > > 			IOPS read/write (direct IO)
> > > processes	rwsem		DB rangelock	XFS
> > > rangelock
> > >  1		78k / 78k	75k / 75k	72k / 72k
> > >  2		131k / 131k	123k / 123k	133k / 133k
> > >  4		267k / 267k	183k / 183k	237k / 237k
> > >  8		372k / 372k	177k / 177k	265k / 265k
> > >  16		315k / 315k	135k / 135k	228k / 228k
> > > 
> > > It's still substantially faster than the interval tree code.
....
> > > /me goes off and thinks more about adding optimistic lock coupling
> > > to the XFS iext btree to get rid of the need for tree-wide
> > > locking altogether
> > 
> > I was not aware of this code.
> 
> It's relatively new, and directly tailored to the needs of caching
> the XFS extent tree - it's not really a generic btree in that it's
> record store format is the XFS on-disk extent record. i.e. it
> only stores 54 bits of start offset and 21 bits of length in it's 16
> byte records, and the rest of the space is for the record data.

SO now I have a mostly working OLC btree based on this tree which is
plumbed into xfsprogs userspace and some testing code. I think I can
say now that the code will actually work, and it /should/ scale
better than a rwsem.

The userspace test harness that I have ran a "thread profile" to
indicated scalability. Basically it ran each thread in a different
offset range and locked a hundred ranges and then unlocked them, and
then looped over this. The btree is a single level for the first 14
locks, 2-level for up to 210 locks, and 3-level for up to 3150
locks. Hence most of this testing results in the btree being 2-3
levels and so largely removes the global root node lock as a point
of contention. It's "best case" for concurrency for an OLC btree.

On a 16p machine:

		     Range lock/unlock ops/s
threads		mutex btree		OLC btree
  1		  5239442		  949487
  2		  1014466		 1398539
  4		   985940		 2405275
  8		   733195		 3288435
  16		   653429		 2809225

When looking at these numbers, remember that the mutex btree kernel
range lock performed a lot better than the interval tree range lock,
and they were only ~30% down on an rwsem. The mutex btree code shows
cache residency effects for the single threaded load, hence it looks
much faster than it is for occasional and multithreaded access.

However, at 2 threads (where hot CPU caches don't affect the
performance), the OLC btree is 40% faster, and at 8 threads it is
4.5x faster than the mutex btree. The OLC btree starts slowing down
at 16 threads, largely because the tree itself doesn't have enough
depth to provide the interior nodes to scale to higher concurrency
levels without contention, but it's still running at 4.5x faster
than the mutex btree....

The best part is when I run worse case threaded workloads on the
OLC btree. If I run the same 100-lock loops, but this time change
the offsets of each thread so they interleave into adjacent records
in the btree (i.e. every thread touches every leaf), then the
performance is still pretty damn good:

		     Range lock/unlock ops/s
threads		Worst Case		Best Case
  1		  1045991		  949487
  2		  1530212		 1398539
  4		  1147099		 2405275
  8		  1602114		 3288435
  16		  1731890		 2809225

IOWs, performance is down and somewhat variable around tree
height changes (4 threads straddles the 2-3 level tree height
threshold), but it's still a massive improvement on the mutex_btree
and it's not going backwards as threads are added.

Concept proven.

Next steps are:

	- separate the OLC btree from the XFS iext btree
	  implementation. It will still have a similar interface
	  (i.e. can't manipulate the btree records directly), but
	  there's sufficient difference in structure for them to be
	  separate implementations.
	- expand records out to full 64bit extents. The iext tree
	  memory usage constraints no longer apply, so the record
	  size can go up a little bit.
	- work out whether RCU read locking and kfree_rcu() will
	  work with the requirement to do memory allocation while
	  holding rcu_read_lock(). Alternative is an internal
	  garbage collector mechanism, kinda like I've hacked up to
	  simulate kfree_rcu() in userspace.
	- fix all the little bugs that still exist in the code.
	- Think about structural optimisations like parent pointers
	  to avoid costly path walks to find parents for 
	  modifications.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
