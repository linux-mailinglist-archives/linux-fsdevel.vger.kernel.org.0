Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328821AFFBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 04:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDTCQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 22:16:04 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54005 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgDTCQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:16:04 -0400
Received: from dread.disaster.area (pa49-180-0-232.pa.nsw.optusnet.com.au [49.180.0.232])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id AD41D3A27EA;
        Mon, 20 Apr 2020 12:15:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jQLyV-0007cs-ML; Mon, 20 Apr 2020 12:15:55 +1000
Date:   Mon, 20 Apr 2020 12:15:55 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 04/11] fs/xfs: Change XFS_MOUNT_DAX to
 XFS_MOUNT_DAX_ALWAYS
Message-ID: <20200420021555.GB9800@dread.disaster.area>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064523.2244712-5-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=XYjVcjsg+1UI/cdbgX7I7g==:117 a=XYjVcjsg+1UI/cdbgX7I7g==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8
        a=Da-RZNcOfLzo3qPRYjUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:45:16PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> In prep for the new tri-state mount option which then introduces
> XFS_MOUNT_DAX_NEVER.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/xfs/xfs_iops.c  | 2 +-
>  fs/xfs/xfs_mount.h | 2 +-
>  fs/xfs/xfs_super.c | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 81f2f93caec0..a6e634631da8 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1248,7 +1248,7 @@ xfs_inode_supports_dax(
>  		return false;
>  
>  	/* DAX mount option or DAX iflag must be set. */
> -	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
> +	if (!(mp->m_flags & XFS_MOUNT_DAX_ALWAYS) &&
>  	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
>  		return false;
>  
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 88ab09ed29e7..54bd74088936 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -233,7 +233,7 @@ typedef struct xfs_mount {
>  						   allocator */
>  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
>  
> -#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
> +#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 62)	/* TEST ONLY! */

As this is going to be permanent, please remove the "Test only"
comment and renumber the bits used down to 26. - the high bit was
used only to keep it out of the ranges that permanent mount option
flags used...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
