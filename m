Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95539ECBA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 23:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfKAWrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 18:47:25 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:52248 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727751AbfKAWrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:47:25 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1A8E043E42B;
        Sat,  2 Nov 2019 09:47:17 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQfhL-00070m-Nv; Sat, 02 Nov 2019 09:47:15 +1100
Date:   Sat, 2 Nov 2019 09:47:15 +1100
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
Message-ID: <20191101224715.GY4614@dread.disaster.area>
References: <20191023221332.GE2044@dread.disaster.area>
 <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
 <20191024073446.GA4614@dread.disaster.area>
 <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
 <20191024213508.GB4614@dread.disaster.area>
 <ab101f90-6ec1-7527-1859-5f6309640cfa@plexistor.com>
 <20191025003603.GE4614@dread.disaster.area>
 <20191025204926.GA26184@iweiny-DESK2.sc.intel.com>
 <20191027221039.GL4614@dread.disaster.area>
 <20191031161757.GA14771@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031161757.GA14771@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=DDk79rDXCmxeI5gZc_4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:17:58AM -0700, Ira Weiny wrote:
> On Mon, Oct 28, 2019 at 09:10:39AM +1100, Dave Chinner wrote:
> > On Fri, Oct 25, 2019 at 01:49:26PM -0700, Ira Weiny wrote:
> 
> [snip]
> 
> > 
> > > Currently this works if I remount the fs or if I use <procfs>/drop_caches like
> > > Boaz mentioned.
> > 
> > drop_caches frees all the dentries that don't have an active
> > references before it iterates over inodes, thereby dropping the
> > cached reference(s) to the inode that pins it in memory before it
> > iterates the inode LRU.
> > 
> > > Isn't there a way to get xfs to do that on it's own?
> > 
> > Not reliably. Killing all the dentries doesn't guarantee the inode
> > will be reclaimed immediately. The ioctl() itself requires an open
> > file reference to the inode, and there's no telling how many other
> > references there are to the inode that the filesystem a) can't find,
> > and b) even if it can find them, it is illegal to release them.
> > 
> > IOWs, if you are relying on being able to force eviction of inode
> > from the cache for correct operation of a user controlled flag, then
> > it's just not going to work.
> 
> Agree, I see the difficulty of forcing the effective flag to change in this
> path.  However, the only thing I am relying on is that the ioctl will change
> the physical flag.
> 
> IOW I am proposing that the semantic be that changing the physical flag does
> _not_ immediately change the effective flag.  With that clarified up front the
> user can adjust accordingly.

Which makes it useless from an admin perspective. i.e. to change the
way the application uses DAX now, admins are going to have to end up
rebooting the machine to guarantee that the kernel has picked up the
change in the on-disk flag.

> After thinking about this more I think there is a strong use case to be able to
> change the physical flag on a non-zero length file.  That use case is to be
> able to restore files from backups.

Why does that matter? Backup programs need to set the flag before
the data is written into the destination file, just like they do
with restoring other flags that influence data placement like the RT
device bit and extent size hints...

Basically, all these issues you keep trying to work around go away
if we can come up with a way of swapping the aops vector safely.
That's the problem we need to solve, anything else results in
largely unacceptible user visible admin warts.

> I propose the user has no direct control over this event and it is mainly used
> to restore files from backups which is mainly an admin operation where a
> remount is a reasonable thing to do.

As soon as users understand that they flag can be changed, they are
going to want to do that and they are going to want it to work
reliably.

> Users direct control of the effective flag is through inheritance.  The user
> needs to create the file in a DAX enable dir and they get effective operation
> right away.

Until they realise the application is slow or broken because it is
using DAX, and they want to turn DAX off for that application. Then
they have *no control*. You cannot have it both ways - being able to
turn something on but not turn it off is not "effective operation"
or user friendly.

> If in the future we can determine a safe way to trigger the a_ops change we can
> add that to the semantic as an alternative for users.

No, the flag does not get turned on until we've solved the problems
that resulted in us turning it off. We've gone over this mutliple
times, and nobody has solved the issues that need solving - everyone
seems to just hack around the issues rather than solving it
properly. If we thought taking some kind of shortcut full of
compromises and gotchas was the right solution, we would have never
turned the flag off in the first place.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
