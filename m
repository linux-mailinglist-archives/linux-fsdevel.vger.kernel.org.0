Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0A159A61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbgBKUQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 15:16:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:1609 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbgBKUQd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:16:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 12:14:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="222052366"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2020 12:14:31 -0800
Date:   Tue, 11 Feb 2020 12:14:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 07/12] fs: Add locking for a dynamic DAX state
Message-ID: <20200211201430.GE12866@iweiny-DESK2.sc.intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-8-ira.weiny@intel.com>
 <20200211080035.GI10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211080035.GI10776@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 07:00:35PM +1100, Dave Chinner wrote:
> On Sat, Feb 08, 2020 at 11:34:40AM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DAX requires special address space operations but many other functions
> > check the IS_DAX() state.
> > 
> > While DAX is a property of the inode we perfer a lock at the super block
> > level because of the overhead of a rwsem within the inode.
> > 
> > Define a vfs per superblock percpu rs semaphore to lock the DAX state
> 
> ????

oops...  I must have forgotten to update the commit message when I did the
global RW sem.  I implemented the per-SB, percpu rwsem first but it was
suggested that the percpu nature of the lock combined with the anticipated
infrequent use of the write side made using a global easier.

But before I proceed on V4 I'd like to get consensus on which of the 2 locking
models to go with.

	1) percpu per superblock lock
	2) per inode rwsem

Depending on my mood I can convince myself of both being performant but the
percpu is very attractive because I don't anticipate many changes of state
during run time.  OTOH concurrent threads accessing the same file at run time
may also be low so there is likely to be little read contention across CPU's on
the per-inode lock?

Opinions?

> 
> > while performing various VFS layer operations.  Write lock calls are
> > provided here but are used in subsequent patches by the file systems
> > themselves.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V2
> > 
> > 	Rebase on linux-next-08-02-2020
> > 
> > 	Fix locking order
> > 	Change all references from mode to state where appropriate
> > 	add CONFIG_FS_DAX requirement for state change
> > 	Use a static branch to enable locking only when a dax capable
> > 		device has been seen.
> > 
> > 	Move the lock to a global vfs lock
> > 
> > 		this does a few things
> > 			1) preps us better for ext4 support
> > 			2) removes funky callbacks from inode ops
> > 			3) remove complexity from XFS and probably from
> > 			   ext4 later
> > 
> > 		We can do this because
> > 			1) the locking order is required to be at the
> > 			   highest level anyway, so why complicate xfs
> > 			2) We had to move the sem to the super_block
> > 			   because it is too heavy for the inode.
> > 			3) After internal discussions with Dan we
> > 			   decided that this would be easier, just as
> > 			   performant, and with slightly less overhead
> > 			   than in the VFS SB.
> > 
> > 		We also change the functions names to up/down;
> > 		read/write as appropriate.  Previous names were over
> > 		simplified.
> 
> This, IMO, is a bit of a train wreck.
> 
> This patch has nothing to do with "DAX state", it's about
> serialising access to the aops vector.

It is a bit more than just the aops vector.  It also has to protect against
checks of IS_DAX() which occur through many of the file operations.

>
> There should be zero
> references to DAX in this patch at all, except maybe to say
> "switching DAX on dynamically requires atomic switching of address
> space ops".

I'm ok with removing the dax references.  However, it very specifically
protects against IS_DAX checks.  Adding in protection for other states will
require care IMO.  This is why I preserved the dax naming because I did not
want to over step what is protected with the locking.  I do _want_ it to
protect more.  But I can't guarantee it, have not tested it, and so made the
calls specific to dax.

> 
> Big problems I see here:
> 
> 1. static key to turn it on globally.
>   - just a gross hack around doing it properly with a per-sb
>     mechanism and enbaling it only on filesystems that are on DAX
>     capable block devices.

Fair enough.  This was a reaction to Darricks desire to get this out of the way
when DAX was not in the system.  The static branch seemed like a good thing for
users who don't have DAX capable hardware while running kernels and FS's which
have DAX enabled.

http://lkml.iu.edu/hypermail/linux/kernel/2001.1/05691.html

>   - you're already passing in an inode to all these functions. It's
>     trivial to do:
> 
> 	if (!inode->i_sb->s_flags & S_DYNAMIC_AOPS)
> 		return
> 	/* do sb->s_aops_lock manipulation */

Yea that would be ok IMO.

Darrick would just having this be CONFIG_FS_DAX as per this patch be ok with
you.  I guess the static key may have been a bit of overkill?

> 
> 2. global lock
>   - OMG!

I know.  The thinking on this is that the locking is percpu which is near
0 overhead in the read case and we are rarely going to take exclusive access.

>   - global lock will cause entire system IO/page fault stalls
>     when someone does recursive/bulk DAX flag modification
>     operations. Per-cpu rwsem Contention on  large systems will be
>     utterly awful.

Yea that is probably bad...  I certainly did not test the responsiveness of
this.  FWIW if the system only has 1 FS the per-SB lock is not going to be any
different from the global which was part of our thinking.

>   - ext4's use case almost never hits the exclusive lock side of the
>     percpu-rwsem - only when changing the journal mode flag on the
>     inode. And it only affects writeback in progress, so it's not
>     going to have massive concurrency on it like a VFS level global
>     lock has. -> Bad model to follow.

I admit I did not research the ext4's journal mode locking that much.

>   - per-sb lock is trivial - see #1 - which limits scope to single
>     filesystem

I agree and...  well the commit message shows I actually implemented it that
way at first...  :-/

>   - per-inode rwsem would make this problem go away entirely.

But would that be ok for concurrent read performance which is going to be used
99.99% of the time?  Maybe Darricks comments made me panic a little bit too
much overhead WRT locking and its potential impact on users not using DAX?

> 
> 3. If we can use a global per-cpu rwsem, why can't we just use a
>    per-inode rwsem?

Per-cpu lock was attractive because of its near 0 overhead to take the read
lock which happens a lot during normal operations.

>   - locking context rules are the same
>   - rwsem scales pretty damn well for shared ops

Does it?  I'm not sure.

>   - no "global" contention problems
>   - small enough that we can put another rwsem in the inode.

Everything else I agree with...  :-D

> 
> 4. "inode_dax_state_up_read"
>   - Eye bleeds.
>   - this is about the aops structure serialisation, not dax.
>   - The name makes no sense in the places that it has been added.

Again it is about more than just the aops.  IS_DAX() needs to be protected in
all the file operations calls as well or we can get races with the logic in
those calls and a state switch.

> 
> 5. We already have code that does almost exactly what we need: the
>    superblock freezing infrastructure.

I think freeze does a lot more than we need.

>   - freezing implements a "hold operations on this superblock until
>     further notice" model we can easily follow.
>   - sb_start_write/sb_end_write provides a simple API model and a
>     clean, clear and concise naming convention we can use, too.

Ok as a model...  If going with the per-SB lock.  After working through my
response I'm leaning toward a per-inode lock again.  This was the way I did
this to begin with.

I want feedback before reworking for V4, please.

> 
> Really, I'm struggling to understand how we got to "global locking
> that stops the world" from "need to change per-inode state
> atomically". Can someone please explain to me why this patch isn't
> just a simple set of largely self-explanitory functions like this:
> 
> XX_start_aop()
> XX_end_aop()
> 
> XX_lock_aops()
> XX_switch_aops(aops)
> XX_unlock_aops()
> 
> where "XX" is "sb" or "inode" depending on what locking granularity
> is used...

Because failing to protect the logic around IS_DAX() results in failures in the
read/write and direct IO paths.

So we need to lock the file operations as well.

Thanks for the review, :-D
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
