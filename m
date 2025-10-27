Return-Path: <linux-fsdevel+bounces-65732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED622C0F39B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A115B500BFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5B33126A0;
	Mon, 27 Oct 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oszKXlMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0463311C2F;
	Mon, 27 Oct 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581712; cv=none; b=ajB28XsvhSFjYv4L3fR7qWnSC7MFTCtmr19YvBz6EU5MB2DpnarFvC88qjsj9aQehrD38HkuHxIp3fCwzpA6wOVy2JEgL4d6Tnb5aHZIQ8QO+sRLFwMh6ymgc2sa1tJC32QmsMzGOwcsMXWlq2CzwT3mBhqBqqkDRxhlCQSSRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581712; c=relaxed/simple;
	bh=NdT1jkC23JnBvxtRRwkDTa4qlSTbEIWr/v8GRoJ7g9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6jYOwC+uubmNhX8oLvecz/vneRrCCBtnhBapMDfEMfM2JR90QiaWecy4VhyWb1LyKmue4NulSJtB1EPGK1FNaVAG66ukIZLajJUAWkm5DGNgYpUw9UuBbo6NSgjpWwKVkCDaHCQNm2ICkJskxP1hCgdnM4u4GnPCOMU+njJxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oszKXlMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2905BC4CEF1;
	Mon, 27 Oct 2025 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581712;
	bh=NdT1jkC23JnBvxtRRwkDTa4qlSTbEIWr/v8GRoJ7g9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oszKXlMbbHnFVI7yd6IcfM6W0fdrD9IJRXIgRgEkTfYWbAtOj5uQoebrXDjdSiY8e
	 idm9YzVwbARhqkiEWxeT/vgyIVP7hqBq4IhnYgzJZ2tlwLj2InRmjOnYVzQDiFORl4
	 t5pNJzhGUPvYcXx+eRatj8ZKj2i+fes8VThrpo0Mc/dqryNI67lLv+4J6O3ZociUu7
	 NG5c8GSwPVZSJMYs9+Iwvm0OpAz3wqsUCm2u/WTHqw6O6XFZeuOgZ02nw0VUn6utDG
	 0V41Z5vkTFqJS7cBJ/YUqi+LwRam49viDUG8eL5rZw8CdageJutXFiNE9tjGF1UavC
	 mTF+ETyouZ2Pw==
Date: Mon, 27 Oct 2025 09:15:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: support sub-block aligned vectors in always COW
 mode
Message-ID: <20251027161511.GV3356773@frogsfrogsfrogs>
References: <20251023135559.124072-1-hch@lst.de>
 <20251023135559.124072-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023135559.124072-5-hch@lst.de>

On Thu, Oct 23, 2025 at 03:55:45PM +0200, Christoph Hellwig wrote:
> Now that the block layer and iomap have grown support to indicate
> the bio sector size explicitly instead of assuming the device sector
> size, we can ask for logical block size alignment and thus support
> direct I/O writes where the overall size is logical block size
> aligned, but the boundaries between vectors might not be.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 2702fef2c90c..f2ac4115c18b 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -674,8 +674,17 @@ xfs_file_dio_write_aligned(
>  	struct xfs_zone_alloc_ctx *ac)
>  {
>  	unsigned int		iolock = XFS_IOLOCK_SHARED;
> +	unsigned int		dio_flags = 0;
>  	ssize_t			ret;
>  
> +	/*
> +	 * For always COW inodes, each bio must be aligned to the file system
> +	 * block size and not just the device sector size because we need to
> +	 * allocate a block-aligned amount of space for each write.
> +	 */
> +	if (xfs_is_always_cow_inode(ip))
> +		dio_flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
> +
>  	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
>  	if (ret)
>  		return ret;
> @@ -693,7 +702,7 @@ xfs_file_dio_write_aligned(
>  		iolock = XFS_IOLOCK_SHARED;
>  	}
>  	trace_xfs_file_direct_write(iocb, from);
> -	ret = iomap_dio_rw(iocb, from, ops, dops, 0, ac, 0);
> +	ret = iomap_dio_rw(iocb, from, ops, dops, dio_flags, ac, 0);
>  out_unlock:
>  	xfs_iunlock(ip, iolock);
>  	return ret;
> @@ -890,15 +899,7 @@ xfs_file_dio_write(
>  	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
>  		return -EINVAL;
>  
> -	/*
> -	 * For always COW inodes we also must check the alignment of each
> -	 * individual iovec segment, as they could end up with different
> -	 * I/Os due to the way bio_iov_iter_get_pages works, and we'd
> -	 * then overwrite an already written block.
> -	 */
> -	if (((iocb->ki_pos | count) & ip->i_mount->m_blockmask) ||
> -	    (xfs_is_always_cow_inode(ip) &&
> -	     (iov_iter_alignment(from) & ip->i_mount->m_blockmask)))
> +	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
>  		return xfs_file_dio_write_unaligned(ip, iocb, from);
>  	if (xfs_is_zoned_inode(ip))
>  		return xfs_file_dio_write_zoned(ip, iocb, from);
> -- 
> 2.47.3
> 
> 

