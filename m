Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB731A2ACB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 23:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgDHVJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 17:09:57 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:53967 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728797AbgDHVJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:09:57 -0400
Received: from dread.disaster.area (pa49-180-125-11.pa.nsw.optusnet.com.au [49.180.125.11])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7E8CB7EBB0D;
        Thu,  9 Apr 2020 07:09:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jMHxG-0004nC-66; Thu, 09 Apr 2020 07:09:50 +1000
Date:   Thu, 9 Apr 2020 07:09:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 7/8] fs/xfs: Change xfs_ioctl_setattr_dax_invalidate()
 to xfs_ioctl_dax_check()
Message-ID: <20200408210950.GL24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-8-ira.weiny@intel.com>
 <20200408022318.GJ24067@dread.disaster.area>
 <20200408095803.GB30172@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408095803.GB30172@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=2h+yFbpuifLtD1c++IMymA==:117 a=2h+yFbpuifLtD1c++IMymA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=yYyG1RkBxaf--jwLynEA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 11:58:03AM +0200, Jan Kara wrote:
> On Wed 08-04-20 12:23:18, Dave Chinner wrote:
> > On Tue, Apr 07, 2020 at 11:29:57AM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > We only support changing FS_XFLAG_DAX on directories.  Files get their
> > > flag from the parent directory on creation only.  So no data
> > > invalidation needs to happen.
> > 
> > Which leads me to ask: how are users and/or admins supposed to
> > remove the flag from regular files once it is set in the filesystem?
> > 
> > Only being able to override the flag via the "dax=never" mount
> > option means that once the flag is set, nobody can ever remove it
> > and they can only globally turn off dax if it gets set incorrectly.
> > It also means a global interrupt because all apps on the filesystem
> > need to be stopped so the filesystem can be unmounted and mounted
> > again with dax=never. This is highly unfriendly to admins and users.
> > 
> > IOWs, we _must_ be able to clear this inode flag on regular inodes
> > in some way. I don't care if it doesn't change the current in-memory
> > state, but we must be able to clear the flags so that the next time
> > the inodes are instantiated DAX is not enabled for those files...
> 
> Well, there's one way to clear the flag: delete the file. If you still care
> about the data, you can copy the data first. It isn't very convenient, I
> agree, and effectively means restarting whatever application that is using
> the file.

Restarting the application is fine. Having to backup/restore or copy
the entire data set just to turn off an inode flag? That's not a
viable management strategy. We could be talking about terabytes of
data here.

I explained how we can safely remove the flag in the other branch of
this thread...

> But it seems like more understandable API than letting user clear
> the on-disk flag but the inode will still use DAX until kernel decides to
> evict the inode

Certainly doesn't seem that way to me. "stop app, clear flags, drop
caches, restart app" is a pretty simple, easy thing to do for an
admin.

Especially compared to process that is effectively "stop app, backup
data set, delete data set, clear flags, restore data set, restart
app"

> - because that often means you need to restart the
> application using the file anyway for the flag change to have any effect.

That's a trivial requirement compared to the downtime and resource
cost of a data set backup/restore just to clear inode flags....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
