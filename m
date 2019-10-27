Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD038E69E0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2019 23:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfJ0WKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Oct 2019 18:10:47 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57349 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726931AbfJ0WKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Oct 2019 18:10:47 -0400
Received: from dread.disaster.area (pa49-181-161-154.pa.nsw.optusnet.com.au [49.181.161.154])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0A0EF3A0432;
        Mon, 28 Oct 2019 09:10:40 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iOqkB-0006QW-Bo; Mon, 28 Oct 2019 09:10:39 +1100
Date:   Mon, 28 Oct 2019 09:10:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Boaz Harrosh <boaz@plexistor.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
Message-ID: <20191027221039.GL4614@dread.disaster.area>
References: <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
 <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
 <20191023221332.GE2044@dread.disaster.area>
 <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
 <20191024073446.GA4614@dread.disaster.area>
 <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
 <20191024213508.GB4614@dread.disaster.area>
 <ab101f90-6ec1-7527-1859-5f6309640cfa@plexistor.com>
 <20191025003603.GE4614@dread.disaster.area>
 <20191025204926.GA26184@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025204926.GA26184@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=l3vQdJ1SkhDHY1nke8Lmag==:117 a=l3vQdJ1SkhDHY1nke8Lmag==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=7H7ooxU6e5Yfb1tYggsA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 01:49:26PM -0700, Ira Weiny wrote:
> On Fri, Oct 25, 2019 at 11:36:03AM +1100, Dave Chinner wrote:
> > On Fri, Oct 25, 2019 at 02:29:04AM +0300, Boaz Harrosh wrote:
> > > On 25/10/2019 00:35, Dave Chinner wrote:
> > 
> > If something like a find or backup program brings the inode into
> > cache, the app may not even get the behaviour it wants, and it can't
> > change it until the inode is evicted from cache, which may be never.
> 
> Why would this be never?

Because only unreferenced inodes can be removed from cache. As long
as something holds a reference or repeatedly accesses the inode such
that reclaim always skips it because it is referenced, it will never
get evicted from the cache.

IOWs, "never" in the practical sense, not "never" in the theoretical
sense.

> > Nobody wants implicit/random/uncontrollable/unchangeable behaviour
> > like this.
> 
> I'm thinking this could work with a bit of effort on the users part.  While the
> behavior does have a bit of uncertainty, I feel like there has to be a way to
> get the inode to drop from the cache when a final iput() happens on the inode.

Keep in mind that the final iput()->evict() process doesn't mean the
inode is going to get removed from all filesystem inode caches, just
the VFS level cache. The filesystem can still have internal
references to the inode, and still be doing work on the inode that
the VFS knows nothing about. XFS definitely fits into this category.

XFS will, however, re-initialise the inode aops structure if the VFS
then does another lookup on the inode while it is in this
"reclaimed" state, so from the VFS perspective it looks like a
newly instantiated inodes on the next lookup. We don't actually need
to do this for large parts of the inode as it is already still in
the valid state from the evict() call. It's an implementation
simplification that means we always re-init the ops vectors attached
to the inode rather than just the fields that need to be
re-initialised.

IOWs, evict/reinit changing the aops vector because the on disk dax
flag changed on XFS works by luck right now, not intent....

> Admin programs should not leave files open forever, without the users knowing
> about it.  So I don't understand why the inode could not be evicted from the
> cache if the FS knew that this change had been made and the inode needs to be
> "re-loaded".  See below...

Doesn't need to be an open file - inodes are pinned in memory by the
reference the dentry holds on it. Hence as long as there are
actively referenced dentries that point at the inode, the inode
cannot be reclaimed. Hard links mean multiple dentries could pin the
inode, too.

> > > (And never change the flag on the fly)
> > > (Just brain storming here)
> > 
> > We went over all this ground when we disabled the flag in the first
> > place. We disabled the flag because we couldn't come up with a sane
> > way to flip the ops vector short of tracking the number of aops
> > calls in progress at any given time. i.e. reference counting the
> > aops structure, but that's hard to do with a const ops structure,
> > and so it got disabled rather than allowing users to crash
> > kernels....
> 
> Agreed.  We can't change the a_ops without some guarantee that no one is using
> the file.  Which means we need all fds to close and a final iput().  I thought
> that would mean an eviction of the inode and a subsequent reload.
> 
> Yesterday I coded up the following (applies on top of this series) but I can't
> seem to get it to work because I believe xfs is keeping a reference on the
> inode.  What am I missing?  I think if I could get xfs to recognize that the
> inode needs to be cleared from it's cache this would work, with some caveats.

You are missing the fact that dentries hold an active reference to
inodes. So a path lookup (access(), stat(), etc) will pin the inode
just as effectively as holding an open file because they instantiate
a dentry that holds a reference to the inode....

> Currently this works if I remount the fs or if I use <procfs>/drop_caches like
> Boaz mentioned.

drop_caches frees all the dentries that don't have an active
references before it iterates over inodes, thereby dropping the
cached reference(s) to the inode that pins it in memory before it
iterates the inode LRU.

> Isn't there a way to get xfs to do that on it's own?

Not reliably. Killing all the dentries doesn't guarantee the inode
will be reclaimed immediately. The ioctl() itself requires an open
file reference to the inode, and there's no telling how many other
references there are to the inode that the filesystem a) can't find,
and b) even if it can find them, it is illegal to release them.

IOWs, if you are relying on being able to force eviction of inode
from the cache for correct operation of a user controlled flag, then
it's just not going to work.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
