Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC790158AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 09:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBKIAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 03:00:41 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:52470 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727613AbgBKIAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:00:41 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E14517E80BF;
        Tue, 11 Feb 2020 19:00:36 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j1QTE-0006r3-0q; Tue, 11 Feb 2020 19:00:36 +1100
Date:   Tue, 11 Feb 2020 19:00:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 07/12] fs: Add locking for a dynamic DAX state
Message-ID: <20200211080035.GI10776@dread.disaster.area>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208193445.27421-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=h3PP_tJamRO6jpvV3pwA:9
        a=WmZtUv9hpVdxJtTz:21 a=_coJ81u7d_13xe0U:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 08, 2020 at 11:34:40AM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> DAX requires special address space operations but many other functions
> check the IS_DAX() state.
> 
> While DAX is a property of the inode we perfer a lock at the super block
> level because of the overhead of a rwsem within the inode.
> 
> Define a vfs per superblock percpu rs semaphore to lock the DAX state

????

> while performing various VFS layer operations.  Write lock calls are
> provided here but are used in subsequent patches by the file systems
> themselves.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V2
> 
> 	Rebase on linux-next-08-02-2020
> 
> 	Fix locking order
> 	Change all references from mode to state where appropriate
> 	add CONFIG_FS_DAX requirement for state change
> 	Use a static branch to enable locking only when a dax capable
> 		device has been seen.
> 
> 	Move the lock to a global vfs lock
> 
> 		this does a few things
> 			1) preps us better for ext4 support
> 			2) removes funky callbacks from inode ops
> 			3) remove complexity from XFS and probably from
> 			   ext4 later
> 
> 		We can do this because
> 			1) the locking order is required to be at the
> 			   highest level anyway, so why complicate xfs
> 			2) We had to move the sem to the super_block
> 			   because it is too heavy for the inode.
> 			3) After internal discussions with Dan we
> 			   decided that this would be easier, just as
> 			   performant, and with slightly less overhead
> 			   than in the VFS SB.
> 
> 		We also change the functions names to up/down;
> 		read/write as appropriate.  Previous names were over
> 		simplified.

This, IMO, is a bit of a train wreck.

This patch has nothing to do with "DAX state", it's about
serialising access to the aops vector. There should be zero
references to DAX in this patch at all, except maybe to say
"switching DAX on dynamically requires atomic switching of address
space ops".

Big problems I see here:

1. static key to turn it on globally.
  - just a gross hack around doing it properly with a per-sb
    mechanism and enbaling it only on filesystems that are on DAX
    capable block devices.
  - you're already passing in an inode to all these functions. It's
    trivial to do:

	if (!inode->i_sb->s_flags & S_DYNAMIC_AOPS)
		return
	/* do sb->s_aops_lock manipulation */

2. global lock
  - OMG!
  - global lock will cause entire system IO/page fault stalls
    when someone does recursive/bulk DAX flag modification
    operations. Per-cpu rwsem Contention on  large systems will be
    utterly awful.
  - ext4's use case almost never hits the exclusive lock side of the
    percpu-rwsem - only when changing the journal mode flag on the
    inode. And it only affects writeback in progress, so it's not
    going to have massive concurrency on it like a VFS level global
    lock has. -> Bad model to follow.
  - per-sb lock is trivial - see #1 - which limits scope to single
    filesystem
  - per-inode rwsem would make this problem go away entirely.

3. If we can use a global per-cpu rwsem, why can't we just use a
   per-inode rwsem?
  - locking context rules are the same
  - rwsem scales pretty damn well for shared ops
  - no "global" contention problems
  - small enough that we can put another rwsem in the inode.

4. "inode_dax_state_up_read"
  - Eye bleeds.
  - this is about the aops structure serialisation, not dax.
  - The name makes no sense in the places that it has been added.

5. We already have code that does almost exactly what we need: the
   superblock freezing infrastructure.
  - freezing implements a "hold operations on this superblock until
    further notice" model we can easily follow.
  - sb_start_write/sb_end_write provides a simple API model and a
    clean, clear and concise naming convention we can use, too.


Really, I'm struggling to understand how we got to "global locking
that stops the world" from "need to change per-inode state
atomically". Can someone please explain to me why this patch isn't
just a simple set of largely self-explanitory functions like this:

XX_start_aop()
XX_end_aop()

XX_lock_aops()
XX_switch_aops(aops)
XX_unlock_aops()

where "XX" is "sb" or "inode" depending on what locking granularity
is used...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
