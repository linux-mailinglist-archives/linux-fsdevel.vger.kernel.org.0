Return-Path: <linux-fsdevel+bounces-14138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A5B8783F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03697B23191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 15:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF12443AAF;
	Mon, 11 Mar 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWf70wnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B6E41C92;
	Mon, 11 Mar 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171458; cv=none; b=IxTod+S5Ji/vWpMDKCHT6amz7WW8RT7ov/slBPshI2wHVjE7Xp8MH1OC5XXn/UXdMBkNzO95QSk1srQzKXQKjZtXsly4X0oGkLQxOU3nqvGMMqzpwyg98RU0O9nvipRLkZtKtjqBSe3o0uH2OMC85643uP+P2V+fnJgzSctuqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171458; c=relaxed/simple;
	bh=LQcdiCTC36GrmbF/Aarge8Ouhfrl/F5lC6nrPd2ehTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMjbBLA9uh4sXihbF34hmgt9oM8N//aOL0LXoHPvqdLuKS58pn7pwtfUbkBLdT7tSI7odc+xD9A0TWx7U/CqdTVkYToR6Cdqx/diHijDFrPO/fLyLy8DnenpGj8D1jz0Kg38Mbo9vshF0UcxrQVay4cHljPNm+56E1s+oohzTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWf70wnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E606C433C7;
	Mon, 11 Mar 2024 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710171457;
	bh=LQcdiCTC36GrmbF/Aarge8Ouhfrl/F5lC6nrPd2ehTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWf70wnQqKd+K1pxiLfkPG0sbOlhXmEzmJ0z8v8wEyYVuA76tac5necE1DxVR56dy
	 Lp4Npvi+RFCU0VgvPs91dnREsOhdPppGInqNSEPLZLyiKhpMc1y4eXgkjGvQe/2SbX
	 jTPM98xuKL1Wq3/yPckZJCJSQq79uH+TQueILc/Jeq75X0S3N9hwAQB5qnZFEZW455
	 gjgqdecOSLH3GT2GhoX4IKyI+pxQ4D2G7sxO1U9HP9sCaV4O3l4go5dlrOAT66ZRMO
	 0QvXuN4zFaBg1D8c0OXgbO/SANReWsIQu2QOGsONvQNLVWwDzpOlDFIpaEcmUyk3Xp
	 QLEylOEm2FCcg==
Date: Mon, 11 Mar 2024 08:37:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/4] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <20240311153737.GT1927156@frogsfrogsfrogs>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311122255.2637311-3-yi.zhang@huaweicloud.com>

On Mon, Mar 11, 2024 at 08:22:53PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current clone operation could be non-atomic if the destination of a file
> is beyond EOF, user could get a file with corrupted (zeroed) data on
> crash.
> 
> The problem is about to pre-alloctions. If you write some data into a
> file [A, B) (the position letters are increased one by one), and xfs
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
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ccf83e72d8ca..2b2aace25355 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -957,6 +957,7 @@ xfs_buffered_write_iomap_begin(
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> +	xfs_fileoff_t		eof_fsb = XFS_B_TO_FSBT(mp, XFS_ISIZE(ip));
>  	struct xfs_bmbt_irec	imap, cmap;
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
> @@ -1035,6 +1036,22 @@ xfs_buffered_write_iomap_begin(
>  	}
>  
>  	if (imap.br_startoff <= offset_fsb) {
> +		/*
> +		 * For zeroing out delayed allocation extent, we trim it if
> +		 * it's partial beyonds EOF block, or convert it to unwritten
> +		 * extent if it's all beyonds EOF block.
> +		 */
> +		if ((flags & IOMAP_ZERO) &&
> +		    isnullstartblock(imap.br_startblock)) {
> +			if (offset_fsb > eof_fsb)
> +				goto convert_delay;
> +			if (end_fsb > eof_fsb) {
> +				end_fsb = eof_fsb + 1;
> +				xfs_trim_extent(&imap, offset_fsb,
> +						end_fsb - offset_fsb);
> +			}
> +		}
> +
>  		/*
>  		 * For reflink files we may need a delalloc reservation when
>  		 * overwriting shared extents.   This includes zeroing of
> @@ -1158,6 +1175,18 @@ xfs_buffered_write_iomap_begin(
>  	xfs_iunlock(ip, lockmode);
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
>  
> +convert_delay:
> +	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
> +	xfs_iunlock(ip, lockmode);
> +	truncate_pagecache_range(inode, offset, XFS_FSB_TO_B(mp, end_fsb));
> +	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
> +				       flags, &imap, &seq);

I expected this to be a direct call to xfs_bmapi_convert_delalloc.
What was the reason not for using that?

--D

> +	if (error)
> +		return error;
> +
> +	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
> +
>  found_cow:
>  	seq = xfs_iomap_inode_sequence(ip, 0);
>  	if (imap.br_startoff <= offset_fsb) {
> -- 
> 2.39.2
> 
> 

