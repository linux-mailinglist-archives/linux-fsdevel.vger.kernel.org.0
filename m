Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF69A1B3A3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgDVIhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 04:37:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgDVIhX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:37:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 48B61AC6E;
        Wed, 22 Apr 2020 08:37:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 042ED1E0E5A; Wed, 22 Apr 2020 10:37:21 +0200 (CEST)
Date:   Wed, 22 Apr 2020 10:37:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 02/11] fs: Remove unneeded IS_DAX() check in
 io_is_direct()
Message-ID: <20200422083720.GA8775@quack2.suse.cz>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421191754.3372370-3-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-04-20 12:17:44, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Remove the check because DAX now has it's own read/write methods and
> file systems which support DAX check IS_DAX() prior to IOCB_DIRECT on
> their own.  Therefore, it does not matter if the file state is DAX when
> the iocb flags are created.
> 
> Also remove io_is_direct() as it is just a simple flag check.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes from v8:
> 	Rebase to latest Linus tree
> 
> Changes from v6:
> 	remove io_is_direct() as well.
> 	Remove Reviews since this is quite a bit different.
> 
> Changes from v3:
> 	Reword commit message.
> 	Reordered to be a 'pre-cleanup' patch
> ---
>  drivers/block/loop.c | 6 +++---
>  include/linux/fs.h   | 7 +------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index da693e6a834e..14372df0f354 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -634,8 +634,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  
>  static inline void loop_update_dio(struct loop_device *lo)
>  {
> -	__loop_update_dio(lo, io_is_direct(lo->lo_backing_file) |
> -			lo->use_dio);
> +	__loop_update_dio(lo, (lo->lo_backing_file->f_flags & O_DIRECT) |
> +				lo->use_dio);
>  }
>  
>  static void loop_reread_partitions(struct loop_device *lo,
> @@ -1028,7 +1028,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
>  		blk_queue_write_cache(lo->lo_queue, true, false);
>  
> -	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
> +	if ((lo->lo_backing_file->f_flags & O_DIRECT) && inode->i_sb->s_bdev) {
>  		/* In case of direct I/O, match underlying block size */
>  		unsigned short bsize = bdev_logical_block_size(
>  			inode->i_sb->s_bdev);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4f6f59b4f22a..a87cc5845a02 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3394,11 +3394,6 @@ extern void setattr_copy(struct inode *inode, const struct iattr *attr);
>  
>  extern int file_update_time(struct file *file);
>  
> -static inline bool io_is_direct(struct file *filp)
> -{
> -	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
> -}
> -
>  static inline bool vma_is_dax(const struct vm_area_struct *vma)
>  {
>  	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
> @@ -3423,7 +3418,7 @@ static inline int iocb_flags(struct file *file)
>  	int res = 0;
>  	if (file->f_flags & O_APPEND)
>  		res |= IOCB_APPEND;
> -	if (io_is_direct(file))
> +	if (file->f_flags & O_DIRECT)
>  		res |= IOCB_DIRECT;
>  	if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
>  		res |= IOCB_DSYNC;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
