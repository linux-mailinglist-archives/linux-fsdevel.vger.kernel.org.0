Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA41725AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 18:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgB0Rwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 12:52:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:14627 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbgB0Rwb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:52:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 09:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="232269369"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 27 Feb 2020 09:52:30 -0800
Date:   Thu, 27 Feb 2020 09:52:30 -0800
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
Subject: Re: [PATCH V4 01/13] fs/xfs: Remove unnecessary initialization of
 i_rwsem
Message-ID: <20200227175229.GA7072@iweiny-DESK2.sc.intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-2-ira.weiny@intel.com>
 <20200221012625.GT10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221012625.GT10776@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:26:25PM +1100, Dave Chinner wrote:
> On Thu, Feb 20, 2020 at 04:41:22PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > xfs_reinit_inode() -> inode_init_always() already handles calling
> > init_rwsem(i_rwsem).  Doing so again is unneeded.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Except that this inode has been destroyed and freed by the VFS, and
> we are now recycling it back into the VFS before we actually
> physically freed it.
> 
> Hence we have re-initialise the semaphore because the semaphore can
> contain internal state that is specific to it's new life cycle (e.g.
> the lockdep context) that will cause problems if we just assume that
> the inode is the same inode as it was before we recycled it back
> into the VFS caches.
> 
> So, yes, we actually do need to re-initialise the rwsem here.

I'm fine dropping the patch...

But I'm not following how the xfs_reinit_inode() on line 422 does not take care
of this?

fs/xfs/xfs_icache.c:

 422                 error = xfs_reinit_inode(mp, inode);
 423                 if (error) {
 424                         bool wake;
 425                         /*
 426                          * Re-initializing the inode failed, and we are in deep
 427                          * trouble.  Try to re-add it to the reclaim list.
 428                          */
 429                         rcu_read_lock();
 430                         spin_lock(&ip->i_flags_lock);
 431                         wake = !!__xfs_iflags_test(ip, XFS_INEW);
 432                         ip->i_flags &= ~(XFS_INEW | XFS_IRECLAIM);
 433                         if (wake)
 434                                 wake_up_bit(&ip->i_flags, __XFS_INEW_BIT);
 435                         ASSERT(ip->i_flags & XFS_IRECLAIMABLE);
 436                         trace_xfs_iget_reclaim_fail(ip);
 437                         goto out_error;
 438                 }
 439 
 440                 spin_lock(&pag->pag_ici_lock);
 441                 spin_lock(&ip->i_flags_lock);
 442 
 443                 /*
 444                  * Clear the per-lifetime state in the inode as we are now
 445                  * effectively a new inode and need to return to the initial
 446                  * state before reuse occurs.
 447                  */
 448                 ip->i_flags &= ~XFS_IRECLAIM_RESET_FLAGS;
 449                 ip->i_flags |= XFS_INEW;
 450                 xfs_inode_clear_reclaim_tag(pag, ip->i_ino);
 451                 inode->i_state = I_NEW;
 452                 ip->i_sick = 0;
 453                 ip->i_checked = 0;
 454 
 455                 ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 456                 init_rwsem(&inode->i_rwsem);
 457 
 458                 spin_unlock(&ip->i_flags_lock);
 459                 spin_unlock(&pag->pag_ici_lock);

Does this need to be done under one of these locks?

Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
