Return-Path: <linux-fsdevel+bounces-27399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710619613A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30CDB24BE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D31CCB2C;
	Tue, 27 Aug 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOZinLr2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860DF64A;
	Tue, 27 Aug 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774824; cv=none; b=hxAj3FvYcngmqvlIz781WWzVNThjXIOc/1/PBncUILSnl9vrOTVdc/OCoBP305fdgjti/lf179eW+8LpVE5iY5+18uhmQ1xHXqT9jTKDJiTAwe1W3f90RXuckc8jTDOoel7vLQn17yxYUjfiSyErdHpCMNu1rOCAMvQmz/t6q5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774824; c=relaxed/simple;
	bh=irhSr4GbFS7N4fmJ/q2uying4I3KUcEzRISTAGoDD8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfPz2PG3ZFomQwfJDkFEx9QCAdVqB2AbKwdTWNHo3epTFf7ADY/zngebfB88M+ajVcVubuZCfb6Gcxr7c2JcycKek8UH+/SyJjwHgFH0lBcykIZLUBnwd4pEEE8ChdGOhZeczWosptGag1rcE0qveWGg7pdY8bpn14t/LwrGE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOZinLr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C626C581B9;
	Tue, 27 Aug 2024 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774824;
	bh=irhSr4GbFS7N4fmJ/q2uying4I3KUcEzRISTAGoDD8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOZinLr2qYYMeGJckzyt3DQnD22ZMIKMwrbOv4W4T3AWq5RNzIvEKd3SMlFdm667u
	 Ww/2lnawO3XJAs4chnspr9qn6rgQ668iTyTW5dy24Xk7J9muLyCxuB8MkMa+1BRCHd
	 rj+sQ7esFUQWTw1POXeZV49gFabcu3woyGVpy6lvE6Ky4ea/zpmAZA2nnw+iwrt+Og
	 Mmuf6bjpD3z/GL0sgA8GhEweIij+N2mFyLoLJLEut6hOS3Ryf1QYD0KlM+Si61ifvD
	 TknzuBT2mAlneqqAgLtczHFVsqNdB3eOi6rxkkLXToIdBbuNKxHe0giuIPgKiqAA0Q
	 E+bAZP0x0TzNQ==
Date: Tue, 27 Aug 2024 09:07:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: refactor xfs_file_fallocate
Message-ID: <20240827160703.GU865349@frogsfrogsfrogs>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-7-hch@lst.de>

On Tue, Aug 27, 2024 at 08:50:50AM +0200, Christoph Hellwig wrote:
> Refactor xfs_file_fallocate into separate helpers for each mode,
> two factors for i_size handling and a single switch statement over the
> supported modes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Much less complicated now! :)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 330 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 208 insertions(+), 122 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 489bc1b173c268..f6e4912769a0d5 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -852,6 +852,192 @@ static inline bool xfs_file_sync_writes(struct file *filp)
>  	return false;
>  }
>  
> +static int
> +xfs_falloc_newsize(
> +	struct file		*file,
> +	int			mode,
> +	loff_t			offset,
> +	loff_t			len,
> +	loff_t			*new_size)
> +{
> +	struct inode		*inode = file_inode(file);
> +
> +	if ((mode & FALLOC_FL_KEEP_SIZE) || offset + len <= i_size_read(inode))
> +		return 0;
> +	*new_size = offset + len;
> +	return inode_newsize_ok(inode, *new_size);
> +}
> +
> +static int
> +xfs_falloc_setsize(
> +	struct file		*file,
> +	loff_t			new_size)
> +{
> +	struct iattr iattr = {
> +		.ia_valid	= ATTR_SIZE,
> +		.ia_size	= new_size,
> +	};
> +
> +	if (!new_size)
> +		return 0;
> +	return xfs_vn_setattr_size(file_mnt_idmap(file), file_dentry(file),
> +			&iattr);
> +}
> +
> +static int
> +xfs_falloc_collapse_range(
> +	struct file		*file,
> +	loff_t			offset,
> +	loff_t			len)
> +{
> +	struct inode		*inode = file_inode(file);
> +	loff_t			new_size = i_size_read(inode) - len;
> +	int			error;
> +
> +	if (!xfs_is_falloc_aligned(XFS_I(inode), offset, len))
> +		return -EINVAL;
> +
> +	/*
> +	 * There is no need to overlap collapse range with EOF, in which case it
> +	 * is effectively a truncate operation
> +	 */
> +	if (offset + len >= i_size_read(inode))
> +		return -EINVAL;
> +
> +	error = xfs_collapse_file_space(XFS_I(inode), offset, len);
> +	if (error)
> +		return error;
> +	return xfs_falloc_setsize(file, new_size);
> +}
> +
> +static int
> +xfs_falloc_insert_range(
> +	struct file		*file,
> +	loff_t			offset,
> +	loff_t			len)
> +{
> +	struct inode		*inode = file_inode(file);
> +	loff_t			isize = i_size_read(inode);
> +	int			error;
> +
> +	if (!xfs_is_falloc_aligned(XFS_I(inode), offset, len))
> +		return -EINVAL;
> +
> +	/*
> +	 * New inode size must not exceed ->s_maxbytes, accounting for
> +	 * possible signed overflow.
> +	 */
> +	if (inode->i_sb->s_maxbytes - isize < len)
> +		return -EFBIG;
> +
> +	/* Offset should be less than i_size */
> +	if (offset >= isize)
> +		return -EINVAL;
> +
> +	error = xfs_falloc_setsize(file, isize + len);
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * Perform hole insertion now that the file size has been updated so
> +	 * that if we crash during the operation we don't leave shifted extents
> +	 * past EOF and hence losing access to the data that is contained within

"...and hence lose access to the data..."

> +	 * them.
> +	 */
> +	return xfs_insert_file_space(XFS_I(inode), offset, len);
> +}
> +
> +/*
> + * Punch a hole and prealloc the range.  We use a hole punch rather than
> + * unwritten extent conversion for two reasons:
> + *
> + *   1.) Hole punch handles partial block zeroing for us.
> + *   2.) If prealloc returns ENOSPC, the file range is still zero-valued by
> + *	 virtue of the hole punch.
> + */
> +static int
> +xfs_falloc_zero_range(
> +	struct file		*file,
> +	int			mode,
> +	loff_t			offset,
> +	loff_t			len)
> +{
> +	struct inode		*inode = file_inode(file);
> +	unsigned int		blksize = i_blocksize(inode);
> +	loff_t			new_size = 0;
> +	int			error;
> +
> +	trace_xfs_zero_file_space(XFS_I(inode));
> +
> +	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
> +	if (error)
> +		return error;
> +
> +	error = xfs_free_file_space(XFS_I(inode), offset, len);
> +	if (error)
> +		return error;
> +
> +	len = round_up(offset + len, blksize) - round_down(offset, blksize);
> +	offset = round_down(offset, blksize);
> +	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> +	if (error)
> +		return error;
> +	return xfs_falloc_setsize(file, new_size);
> +}
> +
> +static int
> +xfs_falloc_unshare_range(
> +	struct file		*file,
> +	int			mode,
> +	loff_t			offset,
> +	loff_t			len)
> +{
> +	struct inode		*inode = file_inode(file);
> +	loff_t			new_size = 0;
> +	int			error;
> +
> +	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
> +	if (error)
> +		return error;
> +
> +	error = xfs_reflink_unshare(XFS_I(inode), offset, len);
> +	if (error)
> +		return error;
> +
> +	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> +	if (error)
> +		return error;
> +	return xfs_falloc_setsize(file, new_size);
> +}
> +
> +static int
> +xfs_falloc_allocate_range(
> +	struct file		*file,
> +	int			mode,
> +	loff_t			offset,
> +	loff_t			len)
> +{
> +	struct inode		*inode = file_inode(file);
> +	loff_t			new_size = 0;
> +	int			error;
> +
> +	/*
> +	 * If always_cow mode we can't use preallocations and thus should not
> +	 * create them.
> +	 */
> +	if (xfs_is_always_cow_inode(XFS_I(inode)))
> +		return -EOPNOTSUPP;
> +
> +	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
> +	if (error)
> +		return error;
> +
> +	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> +	if (error)
> +		return error;
> +	return xfs_falloc_setsize(file, new_size);
> +}
> +
>  #define	XFS_FALLOC_FL_SUPPORTED						\
>  		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
>  		 FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |	\
> @@ -868,8 +1054,6 @@ xfs_file_fallocate(
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	long			error;
>  	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> -	loff_t			new_size = 0;
> -	bool			do_file_insert = false;
>  
>  	if (!S_ISREG(inode->i_mode))
>  		return -EINVAL;
> @@ -894,129 +1078,31 @@ xfs_file_fallocate(
>  	if (error)
>  		goto out_unlock;
>  
> -	if (mode & FALLOC_FL_PUNCH_HOLE) {
> +	switch (mode & FALLOC_FL_MODE_MASK) {
> +	case FALLOC_FL_PUNCH_HOLE:
>  		error = xfs_free_file_space(ip, offset, len);
> -		if (error)
> -			goto out_unlock;
> -	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
> -		if (!xfs_is_falloc_aligned(ip, offset, len)) {
> -			error = -EINVAL;
> -			goto out_unlock;
> -		}
> -
> -		/*
> -		 * There is no need to overlap collapse range with EOF,
> -		 * in which case it is effectively a truncate operation
> -		 */
> -		if (offset + len >= i_size_read(inode)) {
> -			error = -EINVAL;
> -			goto out_unlock;
> -		}
> -
> -		new_size = i_size_read(inode) - len;
> -
> -		error = xfs_collapse_file_space(ip, offset, len);
> -		if (error)
> -			goto out_unlock;
> -	} else if (mode & FALLOC_FL_INSERT_RANGE) {
> -		loff_t		isize = i_size_read(inode);
> -
> -		if (!xfs_is_falloc_aligned(ip, offset, len)) {
> -			error = -EINVAL;
> -			goto out_unlock;
> -		}
> -
> -		/*
> -		 * New inode size must not exceed ->s_maxbytes, accounting for
> -		 * possible signed overflow.
> -		 */
> -		if (inode->i_sb->s_maxbytes - isize < len) {
> -			error = -EFBIG;
> -			goto out_unlock;
> -		}
> -		new_size = isize + len;
> -
> -		/* Offset should be less than i_size */
> -		if (offset >= isize) {
> -			error = -EINVAL;
> -			goto out_unlock;
> -		}
> -		do_file_insert = true;
> -	} else {
> -		if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> -		    offset + len > i_size_read(inode)) {
> -			new_size = offset + len;
> -			error = inode_newsize_ok(inode, new_size);
> -			if (error)
> -				goto out_unlock;
> -		}
> -
> -		if (mode & FALLOC_FL_ZERO_RANGE) {
> -			/*
> -			 * Punch a hole and prealloc the range.  We use a hole
> -			 * punch rather than unwritten extent conversion for two
> -			 * reasons:
> -			 *
> -			 *   1.) Hole punch handles partial block zeroing for us.
> -			 *   2.) If prealloc returns ENOSPC, the file range is
> -			 *       still zero-valued by virtue of the hole punch.
> -			 */
> -			unsigned int blksize = i_blocksize(inode);
> -
> -			trace_xfs_zero_file_space(ip);
> -
> -			error = xfs_free_file_space(ip, offset, len);
> -			if (error)
> -				goto out_unlock;
> -
> -			len = round_up(offset + len, blksize) -
> -			      round_down(offset, blksize);
> -			offset = round_down(offset, blksize);
> -		} else if (mode & FALLOC_FL_UNSHARE_RANGE) {
> -			error = xfs_reflink_unshare(ip, offset, len);
> -			if (error)
> -				goto out_unlock;
> -		} else {
> -			/*
> -			 * If always_cow mode we can't use preallocations and
> -			 * thus should not create them.
> -			 */
> -			if (xfs_is_always_cow_inode(ip)) {
> -				error = -EOPNOTSUPP;
> -				goto out_unlock;
> -			}
> -		}
> -
> -		error = xfs_alloc_file_space(ip, offset, len);
> -		if (error)
> -			goto out_unlock;
> -	}
> -
> -	/* Change file size if needed */
> -	if (new_size) {
> -		struct iattr iattr;
> -
> -		iattr.ia_valid = ATTR_SIZE;
> -		iattr.ia_size = new_size;
> -		error = xfs_vn_setattr_size(file_mnt_idmap(file),
> -					    file_dentry(file), &iattr);
> -		if (error)
> -			goto out_unlock;
> -	}
> -
> -	/*
> -	 * Perform hole insertion now that the file size has been
> -	 * updated so that if we crash during the operation we don't
> -	 * leave shifted extents past EOF and hence losing access to
> -	 * the data that is contained within them.
> -	 */
> -	if (do_file_insert) {
> -		error = xfs_insert_file_space(ip, offset, len);
> -		if (error)
> -			goto out_unlock;
> +		break;
> +	case FALLOC_FL_COLLAPSE_RANGE:
> +		error = xfs_falloc_collapse_range(file, offset, len);
> +		break;
> +	case FALLOC_FL_INSERT_RANGE:
> +		error = xfs_falloc_insert_range(file, offset, len);
> +		break;
> +	case FALLOC_FL_ZERO_RANGE:
> +		error = xfs_falloc_zero_range(file, mode, offset, len);
> +		break;
> +	case FALLOC_FL_UNSHARE_RANGE:
> +		error = xfs_falloc_unshare_range(file, mode, offset, len);
> +		break;
> +	case FALLOC_FL_ALLOCATE_RANGE:
> +		error = xfs_falloc_allocate_range(file, mode, offset, len);
> +		break;
> +	default:
> +		error = -EOPNOTSUPP;
> +		break;
>  	}
>  
> -	if (xfs_file_sync_writes(file))
> +	if (!error && xfs_file_sync_writes(file))
>  		error = xfs_log_force_inode(ip);
>  
>  out_unlock:
> -- 
> 2.43.0
> 
> 

