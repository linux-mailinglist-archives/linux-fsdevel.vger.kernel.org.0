Return-Path: <linux-fsdevel+bounces-43936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FEA5FEC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 19:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824087AA6B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D251EBFE4;
	Thu, 13 Mar 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIuuieoy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86218C937;
	Thu, 13 Mar 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889013; cv=none; b=YvkHnJPaV9tmTTgLKRlDfnJsglDBsPwnTAAjwzBwWHI31vSBeWphcXuIGhhLQwlpk3YE1g2/ZUKT4fqDK5IZUZm0nDs/FTvW6Gmd+hafsWMivokxL5KBYLa93ouaD/v3vp8bm4h1djelRpSQ4RwmuTeu8vfa0ZJ40393NUqBM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889013; c=relaxed/simple;
	bh=vDUTFucENehaO2/dGws27eo3GkBWJKTnEa3Wd3e6NSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J40j6RRFEEqaxpQ4csX8DwBQ+niBWDhlMMNIgO2jzqVZDevsrxcbsb0BmJOk6tK9Vsq4LexjYMoGQiJsdb4TMFoFuFMjVTfEUucUbQQ3BEtGTutiApxQT9hCdAraOP3zRmfUPyxlIM9bkzjRY4s5KZMeyFq1Jptvcpvq9uiYyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIuuieoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2902C4CEEA;
	Thu, 13 Mar 2025 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741889012;
	bh=vDUTFucENehaO2/dGws27eo3GkBWJKTnEa3Wd3e6NSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIuuieoy6ezhHOOiLjQtLrKmNN5YG0ilUYQQm8bcik750zk+PtW9ztnJtqL2Y7TAn
	 WYK8YKuxS2RBW3yN3h4FmXoj/Wz+xyL399VPmpYllceyvmWfT0Kj48dIcE3v1oPDad
	 Sqq+92I2Q+akBWvNcxM6UkZv2cBxgqaBdxOuHp1o14sFza2dTIa1ngxYVl2mEaVXJC
	 V+8IdYPfbI+6Z8guPtx7XapUgmJIfBxkumeib2dBJy3N+j1xGREFAs6HrPCQGcKmt4
	 u34m4Ykplgzr47t06U0st9WqONABxytd+I2Prtum4M7vp4Sq6gY1/AqV50pWhaLj8r
	 ag1kJziDnVhEw==
Date: Thu, 13 Mar 2025 11:03:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 09/13] xfs: add XFS_REFLINK_ALLOC_EXTSZALIGN
Message-ID: <20250313180332.GY2803749@frogsfrogsfrogs>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-10-john.g.garry@oracle.com>

On Thu, Mar 13, 2025 at 05:13:06PM +0000, John Garry wrote:
> Add a flag for the xfs_reflink_allocate_cow() API to allow the caller
> indirectly set XFS_BMAPI_EXTSZALIGN.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks pretty straightforward to me...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_reflink.c | 8 ++++++--
>  fs/xfs/xfs_reflink.h | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 690b1eefeb0e..9a419af89949 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -444,6 +444,11 @@ xfs_reflink_fill_cow_hole(
>  	int			nimaps;
>  	int			error;
>  	bool			found;
> +	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
> +					      XFS_BMAPI_PREALLOC;
> +
> +	 if (flags & XFS_REFLINK_ALLOC_EXTSZALIGN)
> +		bmapi_flags |= XFS_BMAPI_EXTSZALIGN;
>  
>  	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
>  		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
> @@ -477,8 +482,7 @@ xfs_reflink_fill_cow_hole(
>  	/* Allocate the entire reservation as unwritten blocks. */
>  	nimaps = 1;
>  	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
> -			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
> -			&nimaps);
> +			bmapi_flags, 0, cmap, &nimaps);
>  	if (error)
>  		goto out_trans_cancel;
>  
> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> index f4115836064b..0ab1857074e5 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -13,6 +13,8 @@
>  #define XFS_REFLINK_CONVERT_UNWRITTEN		(1u << 0)
>  /* force a new COW mapping to be allocated */
>  #define XFS_REFLINK_FORCE_COW			(1u << 1)
> +/* request block allocations aligned to extszhint */
> +#define XFS_REFLINK_ALLOC_EXTSZALIGN		(1u << 2)
>  
>  /*
>   * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
> -- 
> 2.31.1
> 
> 

