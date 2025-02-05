Return-Path: <linux-fsdevel+bounces-40977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2595A29A9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330797A1E88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E716720F09B;
	Wed,  5 Feb 2025 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf2nO994"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D44204092;
	Wed,  5 Feb 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785918; cv=none; b=FPUyeA6p757Tf9HNEKfGHFIRvpKVlZBlbTdqihmfajDNFKqaT92eeJ5mrAYmeZUNazQjbdVfR5L/j4ibIYpU3cmcNw7kn8L6tXoGy/LSN6RcO9Hbn302tk/5zWPFfw3ag9KsaoJGHEeaSyhGCD9/amCTTp0zxZginYjZpMHmbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785918; c=relaxed/simple;
	bh=FFwFNn5iA2ll4w2bavbJH1n0QsSgFHdVLfFyEJw242U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0MAxvK4Fb72p7+IxUMka7ukBge9hvlgl4lap0+RUSyy4pQ0ERtDqEL69lWrbeKCXY1+LhFcxoK8jCsDZbUxsWpFn+c1o0aWXyylD/1rlvcilonGUwzc7txz/Uy8cYrgs3EXj+MriW/604rMoRWBn2r1EG+bk2kGLKoQriRKIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf2nO994; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3AEC4CED1;
	Wed,  5 Feb 2025 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738785917;
	bh=FFwFNn5iA2ll4w2bavbJH1n0QsSgFHdVLfFyEJw242U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mf2nO994EQAuAigF4VlKpWnpG979tIt9dnEoc1KGCrdIoJ2OIBm77J21GDUa2Ofli
	 quJqfh2rJVimEZMWfzqAJk/rFg4sMIviL3/2W6LelDro51sdkLEZLG4iI5W8SghI05
	 3SP8EkzDUgp6V8K54Pox2W4DhJEWs/n48L2t97bEmczXJ5eKf8hNhy73LIR33or5DO
	 5ZqwGJbwV0Hfonqy6oCUJ5MibJ5iYgDC52XJJ8WTmOZjt9PKFAzqAANdpvi73XpDcb
	 zQy2ZRgYK7nmyUqazLdcxIST7FGdpHurR6Jrn1rCFIQZ42OitpSEa87dp/4iKz7Kcu
	 hvGzQ7Qy167lQ==
Date: Wed, 5 Feb 2025 12:05:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 06/10] xfs: iomap CoW-based atomic write support
Message-ID: <20250205200517.GZ21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204120127.2396727-7-john.g.garry@oracle.com>

On Tue, Feb 04, 2025 at 12:01:23PM +0000, John Garry wrote:
> In cases of an atomic write occurs for misaligned or discontiguous disk
> blocks, we will use a CoW-based method to issue the atomic write.
> 
> So, for that case, return -EAGAIN to request that the write be issued in
> CoW atomic write mode. The dio write path should detect this, similar to
> how misaligned regalar DIO writes are handled.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iomap.c | 68 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ae3755ed00e6..2c2867d728e4 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -809,9 +809,12 @@ xfs_direct_write_iomap_begin(
>  	struct xfs_bmbt_irec	imap, cmap;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> +	bool			atomic = flags & IOMAP_ATOMIC;
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
> +	bool			found = false;
>  	u16			iomap_flags = 0;
> +	bool			need_alloc;
>  	unsigned int		lockmode;
>  	u64			seq;
>  
> @@ -832,7 +835,7 @@ xfs_direct_write_iomap_begin(
>  	 * COW writes may allocate delalloc space or convert unwritten COW
>  	 * extents, so we need to make sure to take the lock exclusively here.
>  	 */
> -	if (xfs_is_cow_inode(ip))
> +	if (xfs_is_cow_inode(ip) || atomic)
>  		lockmode = XFS_ILOCK_EXCL;
>  	else
>  		lockmode = XFS_ILOCK_SHARED;
> @@ -857,12 +860,73 @@ xfs_direct_write_iomap_begin(
>  	if (error)
>  		goto out_unlock;
>  
> +
> +	if (flags & IOMAP_ATOMIC_COW) {
> +		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> +				&lockmode,
> +				(flags & IOMAP_DIRECT) || IS_DAX(inode), true);

Weird nit not relate to this patch: Is there ever a case where
IS_DAX(inode) and (flags & IOMAP_DAX) disagree?  I wonder if this odd
construction could be simplified to:

	(flags & (IOMAP_DIRECT | IOMAP_DAX))

?

> +		if (error)
> +			goto out_unlock;
> +
> +		end_fsb = imap.br_startoff + imap.br_blockcount;
> +		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
> +
> +		if (imap.br_startblock != HOLESTARTBLOCK) {
> +			seq = xfs_iomap_inode_sequence(ip, 0);
> +
> +			error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags,
> +				iomap_flags | IOMAP_F_ATOMIC_COW, seq);
> +			if (error)
> +				goto out_unlock;
> +		}
> +		seq = xfs_iomap_inode_sequence(ip, 0);
> +		xfs_iunlock(ip, lockmode);
> +		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
> +					iomap_flags | IOMAP_F_ATOMIC_COW, seq);
> +	}

/me wonders if this should be a separate helper so that the main
xfs_direct_write_iomap_begin doesn't get even longer... but otherwise
the logic in here looks sane.

> +
> +	need_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
> +
> +	if (atomic) {
> +		/* Use CoW-based method if any of the following fail */
> +		error = -EAGAIN;
> +
> +		/*
> +		 * Lazily use CoW-based method for initial alloc of data.
> +		 * Check br_blockcount for FSes which do not support atomic
> +		 * writes > 1x block.
> +		 */
> +		if (need_alloc && imap.br_blockcount > 1)
> +			goto out_unlock;
> +
> +		/* Misaligned start block wrt size */
> +		if (!IS_ALIGNED(imap.br_startblock, imap.br_blockcount))
> +			goto out_unlock;
> +
> +		/* Discontiguous or mixed extents */
> +		if (!imap_spans_range(&imap, offset_fsb, end_fsb))
> +			goto out_unlock;
> +	}

(Same two comments here.)

> +
>  	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
>  		error = -EAGAIN;
>  		if (flags & IOMAP_NOWAIT)
>  			goto out_unlock;
>  
> +		if (atomic) {
> +			/* Detect whether we're already covered in a cow fork */
> +			error  = xfs_find_trim_cow_extent(ip, &imap, &cmap, &shared, &found);
> +			if (error)
> +				goto out_unlock;
> +
> +			if (shared) {
> +				error = -EAGAIN;
> +				goto out_unlock;

What is this checking?  That something else already created a mapping in
the COW fork, so we want to bail out to get rid of it?

--D

> +			}
> +		}
> +
>  		/* may drop and re-acquire the ilock */
> +		shared = false;
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
>  				&lockmode,
>  				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
> @@ -874,7 +938,7 @@ xfs_direct_write_iomap_begin(
>  		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>  	}
>  
> -	if (imap_needs_alloc(inode, flags, &imap, nimaps))
> +	if (need_alloc)
>  		goto allocate_blocks;
>  
>  	/*
> -- 
> 2.31.1
> 
> 

