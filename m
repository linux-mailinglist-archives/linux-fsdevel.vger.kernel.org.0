Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B904C652
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 06:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfFTEsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 00:48:12 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34598 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbfFTEsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 00:48:12 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A9E2E149FBA;
        Thu, 20 Jun 2019 14:48:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hdoya-0000Gg-Dd; Thu, 20 Jun 2019 14:47:08 +1000
Date:   Thu, 20 Jun 2019 14:47:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
Message-ID: <20190620044708.GT14363@dread.disaster.area>
References: <20190618144716.8133-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618144716.8133-1-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=uX0c4KQHmT7z40gRqxMA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 04:47:16PM +0200, Andreas Gruenbacher wrote:
> Remove the mark_inode_dirty call from __generic_write_end and add it to
> generic_write_end and the high-level iomap functions where necessary.
> That way, large writes will only dirty inodes at the end instead of
> dirtying them once per page.  This fixes a performance bottleneck on
> gfs2.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/buffer.c | 26 ++++++++++++++++++--------
>  fs/iomap.c  | 42 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 56 insertions(+), 12 deletions(-)

....

> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 23ef63fd1669..9454568a7f5e 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -881,6 +881,13 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
>  {
>  	struct inode *inode = iocb->ki_filp->f_mapping->host;
>  	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
> +	loff_t old_size;
> +
> +        /*
> +	 * No need to use i_size_read() here, the i_size cannot change under us
> +	 * because we hold i_rwsem.
> +	 */
> +	old_size = inode->i_size;
>  
>  	while (iov_iter_count(iter)) {
>  		ret = iomap_apply(inode, pos, iov_iter_count(iter),
> @@ -891,6 +898,9 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
>  		written += ret;
>  	}
>  
> +	if (old_size != inode->i_size)
> +		mark_inode_dirty(inode);
> +
>  	return written ? written : ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
> @@ -961,18 +971,30 @@ int
>  iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops)
>  {
> +	loff_t old_size;
>  	loff_t ret;
>  
> +        /*
> +	 * No need to use i_size_read() here, the i_size cannot change under us
> +	 * because we hold i_rwsem.
> +	 */
> +	old_size = inode->i_size;
> +
>  	while (len) {
>  		ret = iomap_apply(inode, pos, len, IOMAP_WRITE, ops, NULL,
>  				iomap_dirty_actor);
>  		if (ret <= 0)
> -			return ret;
> +			goto out;
>  		pos += ret;
>  		len -= ret;
>  	}
> +	ret = 0;
>  
> -	return 0;
> +out:
> +	if (old_size != inode->i_size)
> +		mark_inode_dirty(inode);


I don't think we want to do this.

The patches I have that add range locking for XFS allow buffered
writes to run concurrently with operations that change the inode
size as long as the ranges don't overlap. To do this, XFS will not
hold the i_rwsem over any iomap call it makes in future - it will
hold a range lock instead. Hence we can have writes and other IO
operations occurring at the same time some other operation is
changing the size of the file, and that means this code no longer
does what you are intending it to do because the inode->i_size is no
longer constant across these operations...

Hence I think adding code that depends on i_rwsem to be held to
function correctly is the wrong direction to be taking the iomap
infrastructure.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
