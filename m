Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0508C14E5CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 00:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgA3W7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 17:59:35 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60534 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727656AbgA3W7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:59:35 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 180C43A3C38;
        Fri, 31 Jan 2020 09:59:22 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ixImP-0005Mg-7O; Fri, 31 Jan 2020 09:59:21 +1100
Date:   Fri, 31 Jan 2020 09:59:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hare@suse.de" <hare@suse.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "jth@kernel.org" <jth@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] fs: New zonefs file system
Message-ID: <20200130225921.GR18610@dread.disaster.area>
References: <20200127100521.53899-1-damien.lemoal@wdc.com>
 <20200127100521.53899-2-damien.lemoal@wdc.com>
 <20200128174608.GR3447196@magnolia>
 <b404c1cd7a0c8ccbabcbd3c8aed440542750706e.camel@wdc.com>
 <20200129213318.GM18610@dread.disaster.area>
 <069a9841bc2a6fc9baee05847812720eb1f6517e.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <069a9841bc2a6fc9baee05847812720eb1f6517e.camel@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=x1mIa0GL801llPKVRlUA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 03:00:32AM +0000, Damien Le Moal wrote:
> On Thu, 2020-01-30 at 08:33 +1100, Dave Chinner wrote:
> > On Wed, Jan 29, 2020 at 01:06:29PM +0000, Damien Le Moal wrote:
> > > Exactly. This is how the ZBC & ZAC (and upcoming ZNS) specifications
> > > define the write pointer behavior. That makes error recovery a lot
> > > easier and does not result in stale data accesses. Just notice the one-
> > > off difference for the WP position from your example as WP will be
> > > pointing at the error location, not the last written location. Indexing
> > > from 0, we get (wp - zone start) always being isize with all written
> > > and readable data in the sector range between zone start and zone write
> > > pointer.
> > 
> > Ok, I'm going throw a curve ball here: volatile device caches.
> > 
> > How does the write pointer updates interact with device write
> > caches? i.e.  the first write could be sitting in the device write
> > cache, and the OS write pointer has been advanced. Then another write
> > occurs, the device decides to write both to physical media, and it
> > gets a write error in the area of the first write that only hit the
> > volatile cache.
> > 
> > So does this mean that, from the POV of the OS, the device zone
> > write pointer has gone backwards?
> 
> You are absolutely correct. Forgot to consider this case.
> Nice pitching :)

Potentially adverse IO ordering interactions with volatile device
caches are never that far from the mind of filesystem engineers...
:)

> > Unless there's some other magic that ensures device cached writes
> > that have been signalled as successfully completed to the OS
> > can never fail or that sequential zone writes are never cached in
> > volatile memory in drives, I can't see how the above guarantees
> > can be provided.
> 
> There not, at least from the standards point of view. Such guarantees
> would be device implementation dependent and so we cannot rely on
> anything in this regard. The write pointer ending up below the position
> of the last issue direct IO is thus a possibility and not necessarily
> indicative of an external action (and we actually cannot distinguish
> which case it really is).

*nod*

> > > It is hard to decide on the best action to take here considering the
> > > simple nature of zonefs (i.e. another better interface to do raw block
> > > device file accesses). Including your comments on mount options, I cam
> > > up with these actions that the user can choose with mount options:
> > > * repair: Truncate the inode size only, nothing else
> > > * remount-ro (default): Truncate the inode size and remount read-only
> > > * zone-ro: Truncate the inode size and set the inode read-only
> > > * zone-offline: Truncate the inode size to 0 and assume that its zone 
> > > is offline (no reads nor writes possible).
> > > 
> > > This gives I think a good range of possible behaviors that the user may
> > > want, from almost nothing (repair) to extreme to avoid accessing bad
> > > data (zone-offline).
> > 
> > I would suggest that this is something that can be added later as it
> > is not critical to supporting the underlying functionality.  Right
> > now I'd just pick the safest option: shutdown to protect what data
> > is on the storage right now and then let the user take action to
> > recover/fix the issue.
> 
> By shutdown, do you mean remounting read-only ? Or do you mean
> something more aggressive like preventing all accesses and changes to
> files, i.e. assuming all zones are offline ? The former is already
> there and is the default.

"shutdown" in this context means "do whatever is necessary to
prevent the problem getting worse". So, at minimum, it would be to
prevent further writes to the zone that has gone bad.

If there's potential for other zones to be affected, then moving to
a global read-only state is the right thing to do.

If there's potential for the error to expose stale data, propagate
the error further into currently good on-disk structures, or walk
off the end of corrupt structures (kernel crash and/or memory
corruption), then an aggressive "error out as early as possible"
shutdown is the right solution....

I suspect that zonefs really only needs to go as far as remounting
read-only as long as the hardware write pointers prevent reading the
zone beyond that point....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
