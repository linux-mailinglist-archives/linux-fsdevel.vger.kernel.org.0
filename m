Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993B3D8813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 07:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfJPFZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 01:25:24 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:37730 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727988AbfJPFZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:25:23 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 07C153632E8;
        Wed, 16 Oct 2019 16:25:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iKboE-0003i6-7Y; Wed, 16 Oct 2019 16:25:18 +1100
Date:   Wed, 16 Oct 2019 16:25:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: iomap that extends beyond EOF should be marked
 dirty
Message-ID: <20191016052518.GG16973@dread.disaster.area>
References: <20191016051101.12620-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016051101.12620-1-david@fromorbit.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=23z82uEZCymmQQJ0s0IA:9
        a=SETBJbZGng6XYx8z:21 a=OyeSVzJ-OoM_jwlt:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:11:01PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When doing a direct IO that spans the current EOF, and there are
> written blocks beyond EOF that extend beyond the current write, the
> only metadata update that needs to be done is a file size extension.
> 
> However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
> there is IO completion metadata updates required, and hence we may
> fail to correctly sync file size extensions made in IO completion
> when O_DSYNC writes are beingt used and the hardware supports FUA.
> 
> Hence when setting IOMAP_F_DIRTY, we need to also take into account
> whether the iomap spans the current EOF. If it does, then we need to
> mark it dirty so that IO completion will call generic_write_sync()
> to flush the inode size update to stable storage correctly.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/ext4/inode.c       | 9 ++++++++-
>  fs/xfs/xfs_iomap.c    | 8 ++++++++
>  include/linux/iomap.h | 2 ++
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..e9dc52537e5b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3523,9 +3523,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			return ret;
>  	}
>  
> +	/*
> +	 * Writes that span EOF might trigger an IO size update on completion,
> +	 * so consider them to be dirty for the purposes of O_DSYNC even if
> +	 * there is no other metadata changes being made or are pending here.
> +	 */
>  	iomap->flags = 0;
> -	if (ext4_inode_datasync_dirty(inode))
> +	if (ext4_inode_datasync_dirty(inode) ||
> +	    offset + length > i_size_read(inode))
>  		iomap->flags |= IOMAP_F_DIRTY;
> +
>  	iomap->bdev = inode->i_sb->s_bdev;
>  	iomap->dax_dev = sbi->s_daxdev;
>  	iomap->offset = (u64)first_block << blkbits;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index f780e223b118..38be06f19ea2 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -722,6 +722,14 @@ xfs_file_iomap_begin_delay(
>  		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
>  		shared = true;
>  	}
> +
> +	/*
> +	 * Writes that span EOF might trigger an IO size update on completion,
> +	 * so consider them to be dirty for the purposes of O_DSYNC even if
> +	 * there is no other metadata changes being made or are pending here.
> +	 */
> +	if (offset + count > i_size_read(inode))
> +		iomap->flags |= IOMAP_F_DIRTY;
>  	error = xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);

Urk, self-nack.

I put this in the wrong function. Too much spaghetti that all looks
similar in the XFS iomap code now. Will repost in a minute.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
