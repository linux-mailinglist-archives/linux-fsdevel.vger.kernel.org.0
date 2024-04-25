Return-Path: <linux-fsdevel+bounces-17816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8558B2826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3DC1C209A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C715099C;
	Thu, 25 Apr 2024 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzEl2DPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9837152;
	Thu, 25 Apr 2024 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714069745; cv=none; b=o4zXg68unLlCrpgb+AMBlqQNapfvbfZehY/V2nnosMozkzifwCf2pzLCBKj1PFrv2JtOOwWPjERthviScikZOft++YMOpIouWHBty2dm52UEBEb3xgv7+kCySKra8vp5abtg6hECmqWeqsG7s3MnKXhlZtqAWVQxOK9Ek2i5MXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714069745; c=relaxed/simple;
	bh=OjxtnIQqi9aFP14zSB3IGsqrO8gHisSDjKe8KENwCio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efGnblDlSh133lar6S8DYChUHZhU1LTjN2LUKi/RywHtcBA3pVbHaK4QHr2OfxRbDI8+ESa+iP+hyIZyCVs4aU08ybVPZZkEEqU3ve74TUsUckhRRMeCzI1DO8O0344QEEBVWNFu32KIqcc3qeEkapiuZJ1B5Agdwv+O3+UXBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzEl2DPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5A7C113CC;
	Thu, 25 Apr 2024 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714069745;
	bh=OjxtnIQqi9aFP14zSB3IGsqrO8gHisSDjKe8KENwCio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzEl2DPBRHB0UySCs9wigyeH0aWNCdavF127izSUNeOSg1PrSkI3v6OzhS8zMYTLH
	 C+Ca9cJNPgeZOIcmwB2swbAPB+oclc7ibWYLIYKd8Hper5KPXVNOzEsLo/cNtJFgRg
	 Nbqa4g6DHAI/yzRZnOhZ6X0vJ7rpzRtmTMNUpxWosQ50HLhe7LaF3R1wjuPb+kB0WN
	 oYnmIbE9asaNG+OR9TOg5t/5JhPy0ciLw69L1ZeUlwpBKuoljQwFMgDPkDYXDb9vPF
	 cYTkvZWnbUBGKsQebiJxSAWjPKYXUcR1iytGkFHAFnuvQYepz5+9WzN0TZZ6NtA4+C
	 q2q32WLJaHbtQ==
Date: Thu, 25 Apr 2024 11:29:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, chandanbabu@kernel.org, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <20240425182904.GA360919@frogsfrogsfrogs>
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
 <20240425131335.878454-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425131335.878454-5-yi.zhang@huaweicloud.com>

On Thu, Apr 25, 2024 at 09:13:30PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current clone operation could be non-atomic if the destination of a file
> is beyond EOF, user could get a file with corrupted (zeroed) data on
> crash.
> 
> The problem is about preallocations. If you write some data into a file:
> 
> 	[A...B)
> 
> and XFS decides to preallocate some post-eof blocks, then it can create
> a delayed allocation reservation:
> 
> 	[A.........D)
> 
> The writeback path tries to convert delayed extents to real ones by
> allocating blocks. If there aren't enough contiguous free space, we can
> end up with two extents, the first real and the second still delalloc:
> 
> 	[A....C)[C.D)
> 
> After that, both the in-memory and the on-disk file sizes are still B.
> If we clone into the range [E...F) from another file:
> 
> 	[A....C)[C.D)      [E...F)
> 
> then xfs_reflink_zero_posteof() calls iomap_zero_range() to zero out the
> range [B, E) beyond EOF and flush it. Since [C, D) is still a delalloc
> extent, its pagecache will be zeroed and both the in-memory and on-disk
> size will be updated to D after flushing but before cloning. This is
> wrong, because the user can see the size change and read the zeroes
> while the clone operation is ongoing.
> 
> We need to keep the in-memory and on-disk size before the clone
> operation starts, so instead of writing zeroes through the page cache
> for delayed ranges beyond EOF, we convert these ranges to unwritten and
> invalidate any cached data over that range beyond EOF.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> Changes since v4:
> 
> Move the delalloc converting hunk before searching the COW fork. Because
> if the file has been reflinked and copied on write,
> xfs_bmap_extsize_align() aligned the range of COW delalloc extent, after
> the writeback, there might be some unwritten extents left over in the
> COW fork that overlaps the delalloc extent we found in data fork.
> 
>   data fork  ...wwww|dddddddddd...
>   cow fork          |uuuuuuuuuu...
>                     ^
>                   i_size
> 
> In my v4, we search the COW fork before checking the delalloc extent,
> goto found_cow tag and return unconverted delalloc srcmap in the above
> case, so the delayed extent in the data fork will have no chance to
> convert to unwritten, it will lead to delalloc extent residue and break
> generic/522 after merging patch 6.

Hmmm.  I suppose that works, but it feels a little funny to convert the
delalloc mapping in the data fork to unwritten /while/ there's unwritten
extents in the cow fork too.  Would it make more sense to remap the cow
fork extents here?

OTOH unwritten extents in the cow fork get changed to written ones by
all the cow remapping functions.  Soooo maybe we don't want to go
digging /that/ deep into the system.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
>  fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 236ee78aa75b..2857ef1b0272 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1022,6 +1022,24 @@ xfs_buffered_write_iomap_begin(
>  		goto out_unlock;
>  	}
>  
> +	/*
> +	 * For zeroing, trim a delalloc extent that extends beyond the EOF
> +	 * block.  If it starts beyond the EOF block, convert it to an
> +	 * unwritten extent.
> +	 */
> +	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
> +	    isnullstartblock(imap.br_startblock)) {
> +		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> +
> +		if (offset_fsb >= eof_fsb)
> +			goto convert_delay;
> +		if (end_fsb > eof_fsb) {
> +			end_fsb = eof_fsb;
> +			xfs_trim_extent(&imap, offset_fsb,
> +					end_fsb - offset_fsb);
> +		}
> +	}
> +
>  	/*
>  	 * Search the COW fork extent list even if we did not find a data fork
>  	 * extent.  This serves two purposes: first this implements the
> @@ -1167,6 +1185,17 @@ xfs_buffered_write_iomap_begin(
>  	xfs_iunlock(ip, lockmode);
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
>  
> +convert_delay:
> +	xfs_iunlock(ip, lockmode);
> +	truncate_pagecache(inode, offset);
> +	error = xfs_bmapi_convert_delalloc(ip, XFS_DATA_FORK, offset,
> +					   iomap, NULL);
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

