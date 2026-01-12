Return-Path: <linux-fsdevel+bounces-73328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBBD15A25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F696300DDBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7B28C866;
	Mon, 12 Jan 2026 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ2nKweH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAB2BDC10;
	Mon, 12 Jan 2026 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258193; cv=none; b=PSIxjLT90qJKb8ZyFYCIk3FR5+mKf8etH85vR0Rc3sXBgmVUXUHq3EyFwI+5Vwr4Q1LFeb5uOVDEBUKdpNmc9+6AOE/H0OmMEtB5nmkMLhu88HAOxC16rrE4UuInqTcK1r169qJB50IfwNW18OnfPFHhqUXDun7J97uQoKphT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258193; c=relaxed/simple;
	bh=CoapY2ka3VUy0IwpGxd6MdQ/PjkpqV0DqLB6nbEYHVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA1fz9VVdyHthMTExb4ariKSpR51yuBcVSehSUDOsxO7bIse2BvM8FX0JY+aCfrklPxdhxsLifT2R8YDBKkJu5YJYp3rLV+W/fSUWOdJdJygMySgDLXWRidv97uhakIbrHyGoocJps8tFkHJdsoYj3zK8bXnLcQOBDyZYE4bsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ2nKweH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B61C116D0;
	Mon, 12 Jan 2026 22:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768258192;
	bh=CoapY2ka3VUy0IwpGxd6MdQ/PjkpqV0DqLB6nbEYHVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZ2nKweHKrrzAXPB6OwqUNOJuzkd+Ypx/naoH6WTZfbQuaeJrrbYKZE5UhPXtLY1Z
	 kxL9TQBqEOC24gi8YxhS92mqSuSiA89rt2dkUKEWfHVstumbjmlypRG32HOiNALUkI
	 8+OicLpvaG129jlSiFqDlKs0PIwIuSTuAPyoWjHCnm1JZlUi1RHkDNyaxkImHPkh6b
	 4a0oQc8gV1guqMLMFrmzNEGgCpaqRwjoXrlkkjxs0EpPjHyUc9eh74Uzk8ZxFvRaVW
	 0+P/xpkJwjYk4fmqiUS8iZPy84RPkB8zqFecMwrcQSU/5hTudhO88J9wCqRHx58tR2
	 r753rl/VRwoOA==
Date: Mon, 12 Jan 2026 14:49:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 14/22] xfs: disable preallocations for fsverity Merkle
 tree writes
Message-ID: <20260112224952.GP15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <h5rtbef7rnkc7kooimncgxjefge7bybzujkxy3yrwbfkaiqiya@4n64b7spvy46>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h5rtbef7rnkc7kooimncgxjefge7bybzujkxy3yrwbfkaiqiya@4n64b7spvy46>

On Mon, Jan 12, 2026 at 03:51:30PM +0100, Andrey Albershteyn wrote:
> While writing Merkle tree, file is read-only and there's no further
> writes except Merkle tree building. The file is truncated beforehand to
> remove any preallocated extents.
> 
> The Merkle tree is the only data XFS will write. As we don't want XFS to
> truncate file after we done writing, let's also skip truncation on
> fsverity files. Therefore, we also need to disable preallocations while
> writing merkle tree as we don't want any unused extents past the tree.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/xfs/xfs_iomap.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 04f39ea158..61aab5617f 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1938,7 +1938,9 @@
>  		 * Determine the initial size of the preallocation.
>  		 * We clean up any extra preallocation when the file is closed.
>  		 */
> -		if (xfs_has_allocsize(mp))
> +		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> +			prealloc_blocks = 0;
> +		else if (xfs_has_allocsize(mp))
>  			prealloc_blocks = mp->m_allocsize_blocks;
>  		else if (allocfork == XFS_DATA_FORK)
>  			prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork,
> @@ -2065,6 +2067,13 @@
>  	if (flags & IOMAP_FAULT)
>  		return 0;
>  
> +	/*
> +	 * While writing Merkle tree to disk we would not have any other
> +	 * delayed allocations
> +	 */
> +	if (xfs_iflags_test(XFS_I(inode), XFS_VERITY_CONSTRUCTION))
> +		return 0;
> +
>  	/* Nothing to do if we've written the entire delalloc extent */
>  	start_byte = iomap_last_written_block(inode, offset, written);
>  	end_byte = round_up(offset + length, i_blocksize(inode));
> @@ -2109,6 +2118,7 @@
>  	bool			shared = false;
>  	unsigned int		lockmode = XFS_ILOCK_SHARED;
>  	u64			seq;
> +	int			iomap_flags;
>  
>  	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
>  
> @@ -2128,8 +2138,20 @@
>  	if (error)
>  		return error;
>  	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
> -				 shared ? IOMAP_F_SHARED : 0, seq);
> +	iomap_flags = shared ? IOMAP_F_SHARED : 0;
> +
> +	/*
> +	 * We can not use fsverity_active() here. fsverity_active() checks for
> +	 * verity info attached to inode. This info is based on data from a
> +	 * verity descriptor. But to read verity descriptor we need to go
> +	 * through read iomap path (this function). So, when descriptor is read
> +	 * we will not set IOMAP_F_BEYOND_EOF and descriptor page will be empty
> +	 * (post EOF hole).
> +	 */
> +	if ((offset >= XFS_FSVERITY_REGION_START) && IS_VERITY(inode))

(Ok so XFS_FSVERITY_REGION_START is in units of bytes.  Maybe cast it to
loff_t to make that clearer?)

#define XFS_FSVERITY_REGION_START ((loff_t)1ULL << 53)

> +		iomap_flags |= IOMAP_F_BEYOND_EOF;

Ok, this answers my question.  IOMAP_F_BEYOND_EOF is indeed only
intended to be set for mappings who are completely beyond EOF.  IOWs,
for the fsverity metadata but not the regular file data.

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> +
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
>  }
>  
>  const struct iomap_ops xfs_read_iomap_ops = {
> 
> -- 
> - Andrey
> 
> 

