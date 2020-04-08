Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7681A2C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 01:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDHXsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 19:48:23 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:39449 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgDHXsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:48:23 -0400
Received: from dread.disaster.area (pa49-180-167-53.pa.nsw.optusnet.com.au [49.180.167.53])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C6BD83A367F;
        Thu,  9 Apr 2020 09:48:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jMKQb-0005ii-LU; Thu, 09 Apr 2020 09:48:17 +1000
Date:   Thu, 9 Apr 2020 09:48:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 7/8] fs/xfs: Change xfs_ioctl_setattr_dax_invalidate()
 to xfs_ioctl_dax_check()
Message-ID: <20200408234817.GP24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-8-ira.weiny@intel.com>
 <20200408022318.GJ24067@dread.disaster.area>
 <20200408095803.GB30172@quack2.suse.cz>
 <20200408210950.GL24067@dread.disaster.area>
 <20200408222636.GC664132@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408222636.GC664132@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=2xmR08VVv0jSFCMMkhec0Q==:117 a=2xmR08VVv0jSFCMMkhec0Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=xAaa-ZnbheYG_JgLh6MA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 03:26:36PM -0700, Ira Weiny wrote:
> On Thu, Apr 09, 2020 at 07:09:50AM +1000, Dave Chinner wrote:
> > On Wed, Apr 08, 2020 at 11:58:03AM +0200, Jan Kara wrote:
> > I explained how we can safely remove the flag in the other branch of
> > this thread...
> > 
> > > But it seems like more understandable API than letting user clear
> > > the on-disk flag but the inode will still use DAX until kernel decides to
> > > evict the inode
> > 
> > Certainly doesn't seem that way to me. "stop app, clear flags, drop
> > caches, restart app" is a pretty simple, easy thing to do for an
> > admin.
> 
> I want to be clear here: I think this is reasonable.  However, I don't see
> consensus for that interface.
> 
> Christoph in particular said that a 'lazy change' is: "... straight from
> the playbook for arcane and confusing API designs."
> 
> 	"But returning an error and doing a lazy change anyway is straight from
> 	the playbook for arcane and confusing API designs."
> 
> 	-- https://lore.kernel.org/lkml/20200403072731.GA24176@lst.de/
> 
> Did I somehow misunderstand this?

Yes. Clearing the on-disk flag successfully should not return an
error.

What is wrong is having it clear the flag successfully and returning
an error because the operation doesn't take immediate effect, then
having the change take effect later after telling the application
there was an error.

That's what Christoph was saying is "straight from the playbook for
arcane and confusing API designs."

There's absolutely nothing wrong with setting/clearing the on-disk
flag and having the change take effect some time later depending on
some external context. We've done this sort of thing for a -long
time- and it's not XFS specific at all.

e.g.  changing the on-disk APPEND flag doesn't change the write
behaviour of currently open files - it only affects the behaviour of
future file opens. IOWs, we can have the flag set on disk, but we
can still write randomly to the inode as long as we have a file
descriptor that was opened before the APPEND on disk flag was set.

That's exactly the same class of behaviour as we are talking about
here for the on-disk DAX flag.

> > Especially compared to process that is effectively "stop app, backup
> > data set, delete data set, clear flags, restore data set, restart
> > app"
> > 
> > > - because that often means you need to restart the
> > > application using the file anyway for the flag change to have any effect.
> > 
> > That's a trivial requirement compared to the downtime and resource
> > cost of a data set backup/restore just to clear inode flags....
> 
> I agree but others do not.  This still provides a baby step forward and some

It's not a baby step forward. We can't expose a behaviour to
userspace and then decide to change it completely at some later
date.  We have to think through the entire admin model before
setting it in concrete.

If an admin operation can set an optional persistent feature flags
on a file, then there *must* be admin operations that can remove
that persistent feature flag from said files. This has *nothing to
do with DAX* - it's a fundamental principle of balanced system
design.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
