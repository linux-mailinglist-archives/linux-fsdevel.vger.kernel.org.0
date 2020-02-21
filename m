Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0467A166C5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 02:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgBUBe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 20:34:56 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54386 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729516AbgBUBez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:34:55 -0500
Received: from dread.disaster.area (pa49-195-185-106.pa.nsw.optusnet.com.au [49.195.185.106])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9D2FA820B9F;
        Fri, 21 Feb 2020 12:34:52 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4xDP-0005DD-UK; Fri, 21 Feb 2020 12:34:51 +1100
Date:   Fri, 21 Feb 2020 12:34:51 +1100
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
Subject: Re: [PATCH V4 02/13] fs/xfs: Clarify lockdep dependency for
 xfs_isilocked()
Message-ID: <20200221013451.GU10776@dread.disaster.area>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221004134.30599-3-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=bkRQb8bsQZKWSSj4M57YXw==:117 a=bkRQb8bsQZKWSSj4M57YXw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=GGKX1iC3Kp7g_2JCx8gA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:41:23PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> xfs_isilocked() can't work fully without CONFIG_LOCKDEP.  However,
> making xfs_isilocked() dependant on CONFIG_LOCKDEP is not feasible
> because it is used for more than the i_rwsem.  Therefore a short-circuit
> was provided via debug_locks.  However, this caused confusion while
> working through the xfs locking.
> 
> Rather than use debug_locks as a flag specify this clearly using
> IS_ENABLED(CONFIG_LOCKDEP).
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V3:
> 	Reordered to be a "pre-cleanup" patch
> 
> Changes from V2:
> 	This patch is new for V3
> ---
>  fs/xfs/xfs_inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index c5077e6326c7..35df324875db 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -364,7 +364,7 @@ xfs_isilocked(
>  
>  	if (lock_flags & (XFS_IOLOCK_EXCL|XFS_IOLOCK_SHARED)) {
>  		if (!(lock_flags & XFS_IOLOCK_SHARED))
> -			return !debug_locks ||
> +			return !IS_ENABLED(CONFIG_LOCKDEP) ||
>  				lockdep_is_held_type(&VFS_I(ip)->i_rwsem, 0);

This breaks expected lockdep behaviour.

We need to use debug_locks here because lockdep turns off lock
checking via debug_locks when lockdep encounters a locking
inconsistency.  We only want to know about the first locking
problem, not spew cascading lock problems over and over once we
already know there is a locking problem.

IOWs, checking debug_locks is required here for the same reason it
is used in lockdep_assert_held_{read/write}(). essentially we are
open coding lockdep_assert_held_write() here because this function
is only called from within ASSERT() statements and we don't want
multiple WARN/BUGs being issued when this triggers....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
