Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC1168A2C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 00:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgBUXAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 18:00:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:31741 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgBUXAp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:00:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 15:00:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,470,1574150400"; 
   d="scan'208";a="240468956"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 21 Feb 2020 15:00:44 -0800
Date:   Fri, 21 Feb 2020 15:00:44 -0800
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
Subject: Re: [PATCH V4 02/13] fs/xfs: Clarify lockdep dependency for
 xfs_isilocked()
Message-ID: <20200221230043.GA6762@iweiny-DESK2.sc.intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-3-ira.weiny@intel.com>
 <20200221013451.GU10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221013451.GU10776@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:34:51PM +1100, Dave Chinner wrote:
> On Thu, Feb 20, 2020 at 04:41:23PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > xfs_isilocked() can't work fully without CONFIG_LOCKDEP.  However,
> > making xfs_isilocked() dependant on CONFIG_LOCKDEP is not feasible
> > because it is used for more than the i_rwsem.  Therefore a short-circuit
> > was provided via debug_locks.  However, this caused confusion while
> > working through the xfs locking.
> > 
> > Rather than use debug_locks as a flag specify this clearly using
> > IS_ENABLED(CONFIG_LOCKDEP).
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V3:
> > 	Reordered to be a "pre-cleanup" patch
> > 
> > Changes from V2:
> > 	This patch is new for V3
> > ---
> >  fs/xfs/xfs_inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index c5077e6326c7..35df324875db 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -364,7 +364,7 @@ xfs_isilocked(
> >  
> >  	if (lock_flags & (XFS_IOLOCK_EXCL|XFS_IOLOCK_SHARED)) {
> >  		if (!(lock_flags & XFS_IOLOCK_SHARED))
> > -			return !debug_locks ||
> > +			return !IS_ENABLED(CONFIG_LOCKDEP) ||
> >  				lockdep_is_held_type(&VFS_I(ip)->i_rwsem, 0);
> 
> This breaks expected lockdep behaviour.
> 
> We need to use debug_locks here because lockdep turns off lock
> checking via debug_locks when lockdep encounters a locking
> inconsistency.  We only want to know about the first locking
> problem, not spew cascading lock problems over and over once we
> already know there is a locking problem.

Ah...  ok...  Seems like that should be part of the lockdep interface...

I'll drop the patch for now,
Ira

> 
> IOWs, checking debug_locks is required here for the same reason it
> is used in lockdep_assert_held_{read/write}(). essentially we are
> open coding lockdep_assert_held_write() here because this function
> is only called from within ASSERT() statements and we don't want
> multiple WARN/BUGs being issued when this triggers....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
