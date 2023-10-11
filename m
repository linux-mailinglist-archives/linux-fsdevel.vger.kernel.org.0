Return-Path: <linux-fsdevel+bounces-121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C9B7C5D61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 21:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13B0283012
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE94E12E4D;
	Wed, 11 Oct 2023 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbzwVOO1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22F12E4A;
	Wed, 11 Oct 2023 19:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418E6C433C7;
	Wed, 11 Oct 2023 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050965;
	bh=oMzXkjxA3unXfKGtJD03jI+dq4ZP8nkrRSfYX2Zg/8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbzwVOO1rZF+Rmk/7wPNIxo/1a9vz4yEBUfthqJ5lxlqWcHpA11NX42pvzA3tPVmT
	 1DJPuru8mtHY+74bAxJdFcPix9HujyqTOXs7GOoAa0RkIn/N/Rn327VSILTOJs3sAH
	 E5N76smjBPHvrk1dq424ad2waRQj1SFS0jfs+PuasL7V/RdB4Ym1GQIuWEwkjt8WGE
	 vVsJGERlQ3lLeYnPK0Is9S9QSYR4ppQt0GFusAkn1l0cDo/ym2ogz5Deahg889Jm+z
	 GbNW7FZBmY2Xw5EnpHfA9/Z162ykD7bEduIHZOvKOsfKj42t/XqzTIou5aysDr8ELg
	 1FeyIxcBXhzpw==
Date: Wed, 11 Oct 2023 12:02:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 24/28] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <20231011190244.GW21298@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-25-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-25-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:18PM +0200, Andrey Albershteyn wrote:
> The direct path is not supported on verity files. Attempts to use direct
> I/O path on such files should fall back to buffered I/O path.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a92c8197c26a..7363cbdff803 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -244,7 +244,8 @@ xfs_file_dax_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
> -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> +	struct xfs_inode	*ip = XFS_I(inode);
>  	ssize_t			ret = 0;
>  
>  	trace_xfs_file_dax_read(iocb, to);
> @@ -297,10 +298,17 @@ xfs_file_read_iter(
>  
>  	if (IS_DAX(inode))
>  		ret = xfs_file_dax_read(iocb, to);
> -	else if (iocb->ki_flags & IOCB_DIRECT)
> +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
>  		ret = xfs_file_dio_read(iocb, to);
> -	else
> +	else {
> +		/*
> +		 * In case fs-verity is enabled, we also fallback to the
> +		 * buffered read from the direct read path. Therefore,
> +		 * IOCB_DIRECT is set and need to be cleared
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;

We don't clear IOCB_DIRECT when directio writes fall back to buffered
writes; why is it necessary here?

--D

>  		ret = xfs_file_buffered_read(iocb, to);
> +	}
>  
>  	if (ret > 0)
>  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> -- 
> 2.40.1
> 

