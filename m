Return-Path: <linux-fsdevel+bounces-22160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B756F912EA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 22:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618C31F22526
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD7117B4E8;
	Fri, 21 Jun 2024 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFjC5+pF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFF16849B;
	Fri, 21 Jun 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002287; cv=none; b=DeGx1YHvMqZY3Qz5wzWszzHifHWgcyfX52UzLcadLqBAFHjYEmWeNCnWugCNJNrULUVH8sLXbXQloq4JNuXVLDwyM6qXdWeTVl0pSgs3y6/j2gznzvcC8T70pr4CWe1Y2T/SKKJ5WTcEU6mstzTAVrmYZmiTnSE+0HQD2ydy0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002287; c=relaxed/simple;
	bh=4NZsF7nKIUwjaD/dldJqTXyP3vrorwabNNaT8yPSQ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDELbWkYabSPWU1KnqVQIssjJvBNJZKzVvZCS6cFy6d1V+4Z1IBn0BdkHl5q5rN/slaA1ReMjnyjrn999o+vIMYIKdDaZno138ECsG9Du1SM77lWefzruhsz72FrdWFeCw6X/iluLCcL59XN/nmohn6FFvoB7oN3Iw0m6OlE2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFjC5+pF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C116CC2BBFC;
	Fri, 21 Jun 2024 20:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719002286;
	bh=4NZsF7nKIUwjaD/dldJqTXyP3vrorwabNNaT8yPSQ/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFjC5+pFFHdzlmU9o0j0kFyLYWdQQw1CBO7m8mW8AFE0+AYe1EdtCwzkcuOsuWEH5
	 H2+ZEyOvJgsjSSm4EJWWX/9gGsRrpbsJSCDSRL6bkWMkYV5ZUi7khZMlCe+rA/NkUY
	 D3uPmRdGFbKmNYSoPDOcI/iE8lNnRlmLUAi+UX2gD2dV+BuYoZoekpna8xVpsgkCyJ
	 SxOLxGddKr9wyhu5+Ni8/czwIPfWGvoJNaCfE+PD6ylEhzECixfaQidHCcMSBim8DN
	 sjDtp0CGMnXqTJEhBrNgUj9rCDOdjdcyvOV9CAnS6RK6tBLiPJo54IDosaBIeJZLOb
	 Y69V7Ulq6atUQ==
Date: Fri, 21 Jun 2024 13:38:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 06/13] xfs: align args->minlen for forced allocation
 alignment
Message-ID: <20240621203806.GW3058325@frogsfrogsfrogs>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621100540.2976618-7-john.g.garry@oracle.com>

On Fri, Jun 21, 2024 at 10:05:33AM +0000, John Garry wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> If args->minlen is not aligned to the constraints of forced
> alignment, we may do minlen allocations that are not aligned when we
> approach ENOSPC. Avoid this by always aligning args->minlen
> appropriately. If alignment of minlen results in a value smaller
> than the alignment constraint, fail the allocation immediately.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_bmap.c | 45 +++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 9131ba8113a6..c9cf138e13c4 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3278,33 +3278,48 @@ xfs_bmap_longest_free_extent(
>  	return 0;
>  }
>  
> -static xfs_extlen_t
> +static int
>  xfs_bmap_select_minlen(
>  	struct xfs_bmalloca	*ap,
>  	struct xfs_alloc_arg	*args,
>  	xfs_extlen_t		blen)
>  {
> -
>  	/* Adjust best length for extent start alignment. */
>  	if (blen > args->alignment)
>  		blen -= args->alignment;
>  
>  	/*
>  	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
> -	 * possible that there is enough contiguous free space for this request.
> +	 * possible that there is enough contiguous free space for this request
> +	 * even if best length is less that the minimum length we need.
> +	 *
> +	 * If the best length won't satisfy the maximum length we requested,
> +	 * then use it as the minimum length so we get as large an allocation
> +	 * as possible.
>  	 */
>  	if (blen < ap->minlen)
> -		return ap->minlen;
> +		blen = ap->minlen;
> +	else if (blen > args->maxlen)
> +		blen = args->maxlen;
>  
>  	/*
> -	 * If the best seen length is less than the request length,
> -	 * use the best as the minimum, otherwise we've got the maxlen we
> -	 * were asked for.
> +	 * If we have alignment constraints, round the minlen down to match the
> +	 * constraint so that alignment will be attempted. This may reduce the
> +	 * allocation to smaller than was requested, so clamp the minimum to
> +	 * ap->minlen to allow unaligned allocation to succeed. If we are forced
> +	 * to align the allocation, return ENOSPC at this point because we don't
> +	 * have enough contiguous free space to guarantee aligned allocation.
>  	 */
> -	if (blen < args->maxlen)
> -		return blen;
> -	return args->maxlen;
> -
> +	if (args->alignment > 1) {
> +		blen = rounddown(blen, args->alignment);
> +		if (blen < ap->minlen) {
> +			if (args->datatype & XFS_ALLOC_FORCEALIGN)
> +				return -ENOSPC;
> +			blen = ap->minlen;
> +		}
> +	}
> +	args->minlen = blen;
> +	return 0;
>  }
>  
>  static int
> @@ -3340,8 +3355,7 @@ xfs_bmap_btalloc_select_lengths(
>  	if (pag)
>  		xfs_perag_rele(pag);
>  
> -	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
> -	return error;
> +	return xfs_bmap_select_minlen(ap, args, blen);
>  }
>  
>  /* Update all inode and quota accounting for the allocation we just did. */
> @@ -3661,7 +3675,10 @@ xfs_bmap_btalloc_filestreams(
>  		goto out_low_space;
>  	}
>  
> -	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
> +	error = xfs_bmap_select_minlen(ap, args, blen);
> +	if (error)
> +		goto out_low_space;
> +
>  	if (ap->aeof && ap->offset)
>  		error = xfs_bmap_btalloc_at_eof(ap, args);
>  
> -- 
> 2.31.1
> 
> 

