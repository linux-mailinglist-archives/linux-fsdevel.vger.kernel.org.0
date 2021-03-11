Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19944336AC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCKDgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 22:36:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhCKDg0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 22:36:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C52964FAF;
        Thu, 11 Mar 2021 03:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615433786;
        bh=Zxwd7DTkciPGBdLygL/oeuaaFjTMgubrYOAr2J2wqEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQ+XHh8x7zoBBp7KqMg0/iIoe82e6UmXkpSE28kSwkeDgU1tn2WrVQHThi0nTpgnk
         qRFyf+YesvmnVWr/vqe13Z6+YYHTYFSivMsX5dBAiBQomdBbhlJQIn6IhVl54W/1GH
         Q2xdZezxnvGfAq/PKwhOSVrGZmQZ+AW1k2/RDGpbUwAxXrZZk2Xxw2D3g/2Y2LhGfy
         QzHQQEVrckRGKWqJaAdW+XJdfcCgi2d4+IXdUM901vlxt0dInn8wO85gQuE24rzo2e
         llfztaZBy1M+4PDWWnTRDVT4TAgrS4qjrCqVmzcJmp9rQsO3hPBdB9hwsnDaBQPwdJ
         HkhMT7ZVOCUGQ==
Date:   Wed, 10 Mar 2021 19:36:24 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] zonefs: Fix O_APPEND async write handling
Message-ID: <20210311033624.GE7267@magnolia>
References: <20210311032230.159925-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311032230.159925-1-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:22:30PM +0900, Damien Le Moal wrote:
> zonefs updates the size of a sequential zone file inode only on
> completion of direct writes. When executing asynchronous append writes
> (with a file open with O_APPEND or using RWF_APPEND), the use of the
> current inode size in generic_write_checks() to set an iocb offset thus
> leads to unaligned write if an application issues an append write
> operation with another write already being executed.

Ah, I /had/ wondered if setting i_size to the zone size (instead of the
write pointer) would have side effects...

> Fix this problem by introducing zonefs_write_checks() as a modified
> version of generic_write_checks() using the file inode wp_offset for an
> append write iocb offset. Also introduce zonefs_write_check_limits() to
> replace generic_write_check_limits() call. This zonefs special helper
> makes sure that the maximum file limit used is the maximum size of the
> file being accessed.
> 
> Since zonefs_write_checks() already truncates the iov_iter, the calls
> to iov_iter_truncate() in zonefs_file_dio_write() and
> zonefs_file_buffered_write() are removed.
> 
> Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  fs/zonefs/super.c | 76 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index b6ff4a21abac..11aa990b3a4c 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -727,6 +727,68 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
>  	return ret;
>  }
>  
> +/*
> + * Do not exceed the LFS limits nor the file zone size. If pos is under the
> + * limit it becomes a short access. If it exceeds the limit, return -EFBIG.
> + */
> +static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
> +					loff_t count)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	loff_t limit = rlimit(RLIMIT_FSIZE);
> +	loff_t max_size = zi->i_max_size;
> +
> +	if (limit != RLIM_INFINITY) {
> +		if (pos >= limit) {
> +			send_sig(SIGXFSZ, current, 0);
> +			return -EFBIG;
> +		}
> +		count = min(count, limit - pos);
> +	}
> +
> +	if (!(file->f_flags & O_LARGEFILE))
> +		max_size = min_t(loff_t, MAX_NON_LFS, max_size);
> +
> +	if (unlikely(pos >= max_size))
> +		return -EFBIG;
> +
> +	return min(count, max_size - pos);
> +}
> +
> +static ssize_t zonefs_write_checks(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file_inode(file);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	loff_t count;
> +
> +	if (IS_SWAPFILE(inode))
> +		return -ETXTBSY;

...but can zonefs really do swap files now?

--D

> +
> +	if (!iov_iter_count(from))
> +		return 0;
> +
> +	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
> +		return -EINVAL;
> +
> +	if (iocb->ki_flags & IOCB_APPEND) {
> +		if (zi->i_ztype != ZONEFS_ZTYPE_SEQ)
> +			return -EINVAL;
> +		mutex_lock(&zi->i_truncate_mutex);
> +		iocb->ki_pos = zi->i_wpoffset;
> +		mutex_unlock(&zi->i_truncate_mutex);
> +	}
> +
> +	count = zonefs_write_check_limits(file, iocb->ki_pos,
> +					  iov_iter_count(from));
> +	if (count < 0)
> +		return count;
> +
> +	iov_iter_truncate(from, count);
> +	return iov_iter_count(from);
> +}
> +
>  /*
>   * Handle direct writes. For sequential zone files, this is the only possible
>   * write path. For these files, check that the user is issuing writes
> @@ -744,8 +806,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
>  	struct super_block *sb = inode->i_sb;
>  	bool sync = is_sync_kiocb(iocb);
>  	bool append = false;
> -	size_t count;
> -	ssize_t ret;
> +	ssize_t ret, count;
>  
>  	/*
>  	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT
> @@ -763,13 +824,10 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
>  		inode_lock(inode);
>  	}
>  
> -	ret = generic_write_checks(iocb, from);
> -	if (ret <= 0)
> +	count = zonefs_write_checks(iocb, from);
> +	if (count <= 0)
>  		goto inode_unlock;
>  
> -	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
> -	count = iov_iter_count(from);
> -
>  	if ((iocb->ki_pos | count) & (sb->s_blocksize - 1)) {
>  		ret = -EINVAL;
>  		goto inode_unlock;
> @@ -828,12 +886,10 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
>  		inode_lock(inode);
>  	}
>  
> -	ret = generic_write_checks(iocb, from);
> +	ret = zonefs_write_checks(iocb, from);
>  	if (ret <= 0)
>  		goto inode_unlock;
>  
> -	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
> -
>  	ret = iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);
>  	if (ret > 0)
>  		iocb->ki_pos += ret;
> -- 
> 2.29.2
> 
