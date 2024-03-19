Return-Path: <linux-fsdevel+bounces-14832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975B88063E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40CEB225DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17D3FB01;
	Tue, 19 Mar 2024 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWvVfDhM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3D3BBDE;
	Tue, 19 Mar 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881153; cv=none; b=KZRfv4TSh2IAiQ5AWe0/QYRt6GEmPHUnuT9EzflNwfLzzNusSoz3ueU32l+h6rpQKF3rTYrJ5jd+kmiLQDKzTwj3j/wvyiPxeL8CzwiDUyoaq6AVQSP1+CP7EPmbOxULYOV69HTLw/mZBNgi+uMsNpEYU9rA5q9OPauDmWjR8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881153; c=relaxed/simple;
	bh=PBYhxt35toi1ThSyZy3+p8XNnYJQYPnVo4UhXOcQ4R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up4qtK9aiCLBORWjd4g+ED56MRoJzvOR5NSeLD/4YkYFLDsprup1bDHv1AS5CdKqZR6/Q3LZjDqk5Q66aQQGcVQj36Cgd172Wf9wYBLmtTEvfNWbBMBywjdEi04UV5L00SfHnPSCKy5ZWwsgbMAfepD4/+EqY94+Kx8Pqf/5Dw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWvVfDhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431B2C433C7;
	Tue, 19 Mar 2024 20:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710881153;
	bh=PBYhxt35toi1ThSyZy3+p8XNnYJQYPnVo4UhXOcQ4R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWvVfDhM9fC9sS1202YEVjKTUQYZ/saAlEIxY+PpI+deLVcG8RMPucelG1vXj/K3W
	 CXrGyo0kxNv7NgmpVU6Fc1biMgDc07vCzlWv8vh3mbRhcbOjA1N/ck9c/ij6Pobh/e
	 uh7UQClKks7DB1TKmUMLH41y35G2VGUIZLBZIi+Yw/v6We2DUgb7A6Z8+1OadAdWpH
	 PRLR7TQh3Y5MwIQ7U0nLoB3dQTw9sluzgcfTNeT5mua6hToTIcDzVcM2Z4qaXJR2P7
	 Q9E3SzRVBy0BWiGAkT0e6s4cJUdm9AMsCD6usxIgUcuEtLl40rgeQ8HafxKjq8FDQD
	 Wd13LmupqBAWA==
Date: Tue, 19 Mar 2024 13:45:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/9] xfs: make xfs_bmapi_convert_delalloc() to
 allocate the target offset
Message-ID: <20240319204552.GG1927156@frogsfrogsfrogs>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319011102.2929635-4-yi.zhang@huaweicloud.com>

On Tue, Mar 19, 2024 at 09:10:56AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since xfs_bmapi_convert_delalloc() only attempts to allocate the entire
> delalloc extent and require multiple invocations to allocate the target
> offset. So xfs_convert_blocks() add a loop to do this job and we call it
> in the write back path, but xfs_convert_blocks() isn't a common helper.
> Let's do it in xfs_bmapi_convert_delalloc() and drop
> xfs_convert_blocks(), preparing for the post EOF delalloc blocks
> converting in the buffered write begin path.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 34 +++++++++++++++++++++++--
>  fs/xfs/xfs_aops.c        | 54 +++++++++++-----------------------------
>  2 files changed, 46 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 07dc35de8ce5..042e8d3ab0ba 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -4516,8 +4516,8 @@ xfs_bmapi_write(
>   * invocations to allocate the target offset if a large enough physical extent
>   * is not available.
>   */
> -int
> -xfs_bmapi_convert_delalloc(
> +static int

static inline?

> +__xfs_bmapi_convert_delalloc(

Double underscore prefixes read to me like "do this without grabbing
a lock or a resource", not just one step in a loop.

Would you mind changing it to xfs_bmapi_convert_one_delalloc() ?
Then the callsite looks like:

xfs_bmapi_convert_delalloc(...)
{
	...
	do {
		error = xfs_bmapi_convert_one_delalloc(ip, whichfork, offset,
					iomap, seq);
		if (error)
			return error;
	} while (iomap->offset + iomap->length <= offset);
}

With that renamed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  	struct xfs_inode	*ip,
>  	int			whichfork,
>  	xfs_off_t		offset,
> @@ -4648,6 +4648,36 @@ xfs_bmapi_convert_delalloc(
>  	return error;
>  }
>  
> +/*
> + * Pass in a dellalloc extent and convert it to real extents, return the real
> + * extent that maps offset_fsb in iomap.
> + */
> +int
> +xfs_bmapi_convert_delalloc(
> +	struct xfs_inode	*ip,
> +	int			whichfork,
> +	loff_t			offset,
> +	struct iomap		*iomap,
> +	unsigned int		*seq)
> +{
> +	int			error;
> +
> +	/*
> +	 * Attempt to allocate whatever delalloc extent currently backs offset
> +	 * and put the result into iomap.  Allocate in a loop because it may
> +	 * take several attempts to allocate real blocks for a contiguous
> +	 * delalloc extent if free space is sufficiently fragmented.
> +	 */
> +	do {
> +		error = __xfs_bmapi_convert_delalloc(ip, whichfork, offset,
> +					iomap, seq);
> +		if (error)
> +			return error;
> +	} while (iomap->offset + iomap->length <= offset);
> +
> +	return 0;
> +}
> +
>  int
>  xfs_bmapi_remap(
>  	struct xfs_trans	*tp,
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 813f85156b0c..6479e0dac69d 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -233,45 +233,6 @@ xfs_imap_valid(
>  	return true;
>  }
>  
> -/*
> - * Pass in a dellalloc extent and convert it to real extents, return the real
> - * extent that maps offset_fsb in wpc->iomap.
> - *
> - * The current page is held locked so nothing could have removed the block
> - * backing offset_fsb, although it could have moved from the COW to the data
> - * fork by another thread.
> - */
> -static int
> -xfs_convert_blocks(
> -	struct iomap_writepage_ctx *wpc,
> -	struct xfs_inode	*ip,
> -	int			whichfork,
> -	loff_t			offset)
> -{
> -	int			error;
> -	unsigned		*seq;
> -
> -	if (whichfork == XFS_COW_FORK)
> -		seq = &XFS_WPC(wpc)->cow_seq;
> -	else
> -		seq = &XFS_WPC(wpc)->data_seq;
> -
> -	/*
> -	 * Attempt to allocate whatever delalloc extent currently backs offset
> -	 * and put the result into wpc->iomap.  Allocate in a loop because it
> -	 * may take several attempts to allocate real blocks for a contiguous
> -	 * delalloc extent if free space is sufficiently fragmented.
> -	 */
> -	do {
> -		error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
> -				&wpc->iomap, seq);
> -		if (error)
> -			return error;
> -	} while (wpc->iomap.offset + wpc->iomap.length <= offset);
> -
> -	return 0;
> -}
> -
>  static int
>  xfs_map_blocks(
>  	struct iomap_writepage_ctx *wpc,
> @@ -289,6 +250,7 @@ xfs_map_blocks(
>  	struct xfs_iext_cursor	icur;
>  	int			retries = 0;
>  	int			error = 0;
> +	unsigned int		*seq;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -386,7 +348,19 @@ xfs_map_blocks(
>  	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
>  	return 0;
>  allocate_blocks:
> -	error = xfs_convert_blocks(wpc, ip, whichfork, offset);
> +	/*
> +	 * Convert a dellalloc extent to a real one. The current page is held
> +	 * locked so nothing could have removed the block backing offset_fsb,
> +	 * although it could have moved from the COW to the data fork by another
> +	 * thread.
> +	 */
> +	if (whichfork == XFS_COW_FORK)
> +		seq = &XFS_WPC(wpc)->cow_seq;
> +	else
> +		seq = &XFS_WPC(wpc)->data_seq;
> +
> +	error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
> +				&wpc->iomap, seq);
>  	if (error) {
>  		/*
>  		 * If we failed to find the extent in the COW fork we might have
> -- 
> 2.39.2
> 
> 

