Return-Path: <linux-fsdevel+bounces-14218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75048798D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D27F1F21B43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601267E10F;
	Tue, 12 Mar 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3Avj8mx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048C7D3E9;
	Tue, 12 Mar 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260511; cv=none; b=VzGnjkOoKiYFYMbAv1vzToKrCaa6hHX9cXrz3RauK+bU2EZ/b1YJwxJGFbnLwF7f09QHj9joMchBjWRgS0wv9fauCExyMryAf+CZnz4a7BkKCrSEqPJHfyVsA0R8A6Xg4EXfQF2WR5BCPwbtYpfmWZYe6ymD06byEy5kN+K1yuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260511; c=relaxed/simple;
	bh=9gouWIccOcWNOC2Wg5Zduc51A/XGK7M/IeuGTXAVNPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYvlVMxptSDu09AsYMD1BqqrQP8YuR01JXtWyAUaC2ovqvlztTVykrZmDJP14ZOvr33hM4oqJ0pseHTNbdrn9nib10e02Z3/aNg5f/25ud7m7OwHgP7Pl0I+1DCu4Nm9eFt4iUa0ldk3lv8+rldqLSP8pM1ih1A1IKe/JYipPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3Avj8mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A9CC433F1;
	Tue, 12 Mar 2024 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710260511;
	bh=9gouWIccOcWNOC2Wg5Zduc51A/XGK7M/IeuGTXAVNPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3Avj8mxcInDVki81FNuFDqI9wRb4UlzVI1KiH5d6hqGyTHuRl9N0LUMQ7bjp51ah
	 P1mKEguRw8x9PqbEuxpGa6iMlzCcY1OZadVQWNsj5KOWjqmeVX60ZtIN9lWzxIyrKX
	 Ly/NI5INZNUapKVUUc+pl1NSWcp8OY8YhIIavzq1ZxQUcOHHgIJtsX6GGG4XrKtO07
	 sIsDR7A+gKxdlgCBoMa9T7zQ3w2q6zM0pqqEBh0Iy63CP6e0j6zYDAcMflyGeh5ZWE
	 oAP7HyvYBO83/f1xqmzuNGEH8CAAyz0cVHqlrRKpJpUi+7sHMFggkaKZ4NVQThtU6E
	 +zFaMlWjfvjDA==
Date: Tue, 12 Mar 2024 09:21:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/4] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <20240312162150.GB1927156@frogsfrogsfrogs>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-3-yi.zhang@huaweicloud.com>
 <20240311153737.GT1927156@frogsfrogsfrogs>
 <aab454d0-d8f3-61c8-0d14-a5ae4c35746e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab454d0-d8f3-61c8-0d14-a5ae4c35746e@huaweicloud.com>

On Tue, Mar 12, 2024 at 08:31:58PM +0800, Zhang Yi wrote:
> On 2024/3/11 23:37, Darrick J. Wong wrote:
> > On Mon, Mar 11, 2024 at 08:22:53PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Current clone operation could be non-atomic if the destination of a file
> >> is beyond EOF, user could get a file with corrupted (zeroed) data on
> >> crash.
> >>
> >> The problem is about to pre-alloctions. If you write some data into a
> >> file [A, B) (the position letters are increased one by one), and xfs
> >> could pre-allocate some blocks, then we get a delayed extent [A, D).
> >> Then the writeback path allocate blocks and convert this delayed extent
> >> [A, C) since lack of enough contiguous physical blocks, so the extent
> >> [C, D) is still delayed. After that, both the in-memory and the on-disk
> >> file size are B. If we clone file range into [E, F) from another file,
> >> xfs_reflink_zero_posteof() would call iomap_zero_range() to zero out the
> >> range [B, E) beyond EOF and flush range. Since [C, D) is still a delayed
> >> extent, it will be zeroed and the file's in-memory && on-disk size will
> >> be updated to D after flushing and before doing the clone operation.
> >> This is wrong, because user can user can see the size change and read
> >> zeros in the middle of the clone operation.
> >>
> >> We need to keep the in-memory and on-disk size before the clone
> >> operation starts, so instead of writing zeroes through the page cache
> >> for delayed ranges beyond EOF, we convert these ranges to unwritten and
> >> invalidating any cached data over that range beyond EOF.
> >>
> >> Suggested-by: Dave Chinner <david@fromorbit.com>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>
> >> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> >> index ccf83e72d8ca..2b2aace25355 100644
> >> --- a/fs/xfs/xfs_iomap.c
> >> +++ b/fs/xfs/xfs_iomap.c
> >> @@ -957,6 +957,7 @@ xfs_buffered_write_iomap_begin(
> >>  	struct xfs_mount	*mp = ip->i_mount;
> >>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> >>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> >> +	xfs_fileoff_t		eof_fsb = XFS_B_TO_FSBT(mp, XFS_ISIZE(ip));
> >>  	struct xfs_bmbt_irec	imap, cmap;
> >>  	struct xfs_iext_cursor	icur, ccur;
> >>  	xfs_fsblock_t		prealloc_blocks = 0;
> >> @@ -1035,6 +1036,22 @@ xfs_buffered_write_iomap_begin(
> >>  	}
> >>  
> >>  	if (imap.br_startoff <= offset_fsb) {
> >> +		/*
> >> +		 * For zeroing out delayed allocation extent, we trim it if
> >> +		 * it's partial beyonds EOF block, or convert it to unwritten
> >> +		 * extent if it's all beyonds EOF block.
> >> +		 */
> >> +		if ((flags & IOMAP_ZERO) &&
> >> +		    isnullstartblock(imap.br_startblock)) {
> >> +			if (offset_fsb > eof_fsb)
> >> +				goto convert_delay;
> >> +			if (end_fsb > eof_fsb) {
> >> +				end_fsb = eof_fsb + 1;
> >> +				xfs_trim_extent(&imap, offset_fsb,
> >> +						end_fsb - offset_fsb);
> >> +			}
> >> +		}
> >> +
> >>  		/*
> >>  		 * For reflink files we may need a delalloc reservation when
> >>  		 * overwriting shared extents.   This includes zeroing of
> >> @@ -1158,6 +1175,18 @@ xfs_buffered_write_iomap_begin(
> >>  	xfs_iunlock(ip, lockmode);
> >>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
> >>  
> >> +convert_delay:
> >> +	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
> >> +	xfs_iunlock(ip, lockmode);
> >> +	truncate_pagecache_range(inode, offset, XFS_FSB_TO_B(mp, end_fsb));
> >> +	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
> >> +				       flags, &imap, &seq);
> > 
> > I expected this to be a direct call to xfs_bmapi_convert_delalloc.
> > What was the reason not for using that?
> > 
> 
> It's because xfs_bmapi_convert_delalloc() isn't guarantee to convert
> enough blocks once a time, it may convert insufficient blocks since lack
> of enough contiguous free physical blocks. If we are going to use it, I
> suppose we need to introduce a new helper something like
> xfs_convert_blocks(), add a loop to do the conversion.

I thought xfs_bmapi_convert_delalloc passes out (via @iomap) the extent
that xfs_bmapi_allocate (or anyone else) allocated (bma.got).  If that
mapping is shorter, won't xfs_buffered_write_iomap_begin pass the
shortened mapping out to the iomap machinery?  In which case that
iomap_iter loop will call ->iomap_begin on the unfinished delalloc
conversion work?

> xfs_iomap_write_direct() has done all the work of converting, but the
> name of this function is non-obviousness than xfs_bmapi_convert_delalloc(),
> I can change to use it if you think xfs_bmapi_convert_delalloc() is
> better. :)

Yes.

--D

> Thanks,
> Yi.
> 
> > --D
> > 
> >> +	if (error)
> >> +		return error;
> >> +
> >> +	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
> >> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
> >> +
> >>  found_cow:
> >>  	seq = xfs_iomap_inode_sequence(ip, 0);
> >>  	if (imap.br_startoff <= offset_fsb) {
> >> -- 
> >> 2.39.2
> >>
> >>
> 
> 

