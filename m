Return-Path: <linux-fsdevel+bounces-14833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A425880662
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513BF28335D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B923FE2A;
	Tue, 19 Mar 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLP/h6K6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0BB3FB99;
	Tue, 19 Mar 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882020; cv=none; b=TDUvqsOPTJ+wqO/OwuM/ZP3iGUjY84gxZBTK/FNoeAVgD3k3vnQPVNgQh+nGxCRoX+BeoNxS+Kzm0fjuKbpfwj3gVeS9f4Z4spZv6VGw6Q5JJIrC/iEE8j617q6p1uJdyf32Kb73Tba64QK8cQMKqcHoIusRfPb7rMzMuAZaET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882020; c=relaxed/simple;
	bh=bhy84YlengXETx08r7sse1M0VWl1v653zOdsuGcwMCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDhuIu0ifPiOiYV03HPZywu0PzLJ6nkBPtGEKGROpO/96zGjlOMlFyLlin1LB+f3Y6ZwlhbveP+M+0Do01nVBBXNTiQmaghaIQUFqxpVsBmo9MxWTcpSXxXqC5Gx1biTc1DcgrPFl25V3PBpNLU48fD6IE9szwMDv6Fi76OlkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLP/h6K6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833E8C433C7;
	Tue, 19 Mar 2024 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710882019;
	bh=bhy84YlengXETx08r7sse1M0VWl1v653zOdsuGcwMCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLP/h6K6AKNx77IvHJsSYlLIRrloVJhj4AO4/P3PUxRWgmdRFwtNpFskdh50lZ5P5
	 PB9WDMb43x1ifdBmMlVdQ6BglEsaNXwyrU2V0XOHnQR61/HniTlggpq9pwmhRU2O/v
	 Mmlas5hxNwcinCHVvvUtZnXx53AMIqiLjFTZo0vMCsqQzCPLH3JsGYknrAlnkoASCE
	 FssbFzOpJW5HkOx6hUtfKz0Q0VPOMGFC3H+MmpkcVAFNyslSnIsBcn98Y5Kg8kziEL
	 mhncQcU5sMLTDMZtSqSJOItmClZ3aFqptdnp0U+8ReCCU538yYSNyhRgvUrwitt3le
	 uqcUG2e2adPHA==
Date: Tue, 19 Mar 2024 14:00:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <20240319210019.GH1927156@frogsfrogsfrogs>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319011102.2929635-5-yi.zhang@huaweicloud.com>

On Tue, Mar 19, 2024 at 09:10:57AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current clone operation could be non-atomic if the destination of a file
> is beyond EOF, user could get a file with corrupted (zeroed) data on
> crash.
> 
> The problem is about to pre-alloctions. If you write some data into a

"...is about preallocations."

> file [A, B) (the position letters are increased one by one), and xfs

I think it would help with understandability if you'd pasted the ascii
art from the previous thread(s) into this commit message:

"The problem is about preallocations.  If you write some data into a
file:

	[A...B)

and XFS decides to preallocate some post-eof blocks, then it can create
a delayed allocation reservation:

	[A.........D)

The writeback path tries to convert delayed extents to real ones by
allocating blocks.  If there aren't enough contiguous free space, we can
end up with two extents, the first real and the second still delalloc:

	[A....C)[C.D)

After that, both the in-memory and the on-disk file sizes are still B.
If we clone into the range [E...F) from another file:

	[A....C)[C.D)      [E...F)

then xfs_reflink_zero_posteof calls iomap_zero_range to zero out the
range [B, E) beyond EOF and flush it.  Since [C, D) is still a delalloc
extent, its pagecache will be zeroed and both the in-memory and on-disk
size will be updated to D after flushing but before cloning.  This is
wrong, because the user can see the size change and read the zeroes
while the clone operation is ongoing."

> could pre-allocate some blocks, then we get a delayed extent [A, D).
> Then the writeback path allocate blocks and convert this delayed extent
> [A, C) since lack of enough contiguous physical blocks, so the extent
> [C, D) is still delayed. After that, both the in-memory and the on-disk
> file size are B. If we clone file range into [E, F) from another file,
> xfs_reflink_zero_posteof() would call iomap_zero_range() to zero out the
> range [B, E) beyond EOF and flush range. Since [C, D) is still a delayed
> extent, it will be zeroed and the file's in-memory && on-disk size will
> be updated to D after flushing and before doing the clone operation.
> This is wrong, because user can user can see the size change and read
> zeros in the middle of the clone operation.
> 
> We need to keep the in-memory and on-disk size before the clone
> operation starts, so instead of writing zeroes through the page cache
> for delayed ranges beyond EOF, we convert these ranges to unwritten and
> invalidating any cached data over that range beyond EOF.

"...and invalidate any cached data..."

> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ccf83e72d8ca..1a6d05830433 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1035,6 +1035,24 @@ xfs_buffered_write_iomap_begin(
>  	}
>  
>  	if (imap.br_startoff <= offset_fsb) {
> +		/*
> +		 * For zeroing out delayed allocation extent, we trim it if
> +		 * it's partial beyonds EOF block, or convert it to unwritten
> +		 * extent if it's all beyonds EOF block.

"Trim a delalloc extent that extends beyond the EOF block.  If it starts
beyond the EOF block, convert it to an unwritten extent."

> +		 */
> +		if ((flags & IOMAP_ZERO) &&
> +		    isnullstartblock(imap.br_startblock)) {
> +			xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> +
> +			if (offset_fsb >= eof_fsb)
> +				goto convert_delay;
> +			if (end_fsb > eof_fsb) {
> +				end_fsb = eof_fsb;
> +				xfs_trim_extent(&imap, offset_fsb,
> +						end_fsb - offset_fsb);
> +			}
> +		}
> +
>  		/*
>  		 * For reflink files we may need a delalloc reservation when
>  		 * overwriting shared extents.   This includes zeroing of
> @@ -1158,6 +1176,17 @@ xfs_buffered_write_iomap_begin(
>  	xfs_iunlock(ip, lockmode);
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
>  
> +convert_delay:
> +	xfs_iunlock(ip, lockmode);
> +	truncate_pagecache(inode, offset);
> +	error = xfs_bmapi_convert_delalloc(ip, XFS_DATA_FORK, offset,
> +					iomap, NULL);

Either indent this two tabs (XFS style), or make the second line of
arguments line up with the start of the arguments on the first line
(kernel style).

With those improvements applied,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +	if (error)
> +		return error;
> +
> +	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
> +	return 0;
> +
>  found_cow:
>  	seq = xfs_iomap_inode_sequence(ip, 0);
>  	if (imap.br_startoff <= offset_fsb) {
> -- 
> 2.39.2
> 
> 

