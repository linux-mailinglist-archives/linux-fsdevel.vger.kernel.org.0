Return-Path: <linux-fsdevel+bounces-54913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A95B050DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 07:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF5F3B2A14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BFB2D3751;
	Tue, 15 Jul 2025 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQS/lahF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3D9460;
	Tue, 15 Jul 2025 05:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557086; cv=none; b=pX8HbnEsQT52eAS/whpGrxb0fJx5RJGCIN/hyqvkFp+/KntNezdpcYu3+1eNDYRF+IWw00Y6YJpiYxxvpbi5+1YjVIEt0gBSlRO4N4vU5sAnWI2pVukT2ITwBEuQblWsrvcYxmzKfl1eTDLPn929kkdtxTYyYVFs3F4EaYoVotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557086; c=relaxed/simple;
	bh=Y8QDFCLNe7huxVz/T2FtbyuCf7tVqCtXCDHmrvgYseM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjDTQzT6ITY7KnL1mq9V2ROoo+uIJ2ZNqKsPgY3aJdd9QDjG0iFkZ6URiABf1/6iIGEmXPDcU/H1HIQ3dUR3ywdkwnURexfGjqNDZDKxksWFY8ejL+hGcPg5NMuOZuiDyXLlXzj8MQtrrtWnHAOHh8/0vCpPK867Ehi/PNGqeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQS/lahF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92989C4CEE3;
	Tue, 15 Jul 2025 05:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752557084;
	bh=Y8QDFCLNe7huxVz/T2FtbyuCf7tVqCtXCDHmrvgYseM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQS/lahFX1CrZjmtX9is+pM96MWVMFMX5jW9i7mlTkF19O6zm+9uiKcDK5TG/XsQg
	 t9aO1sBJ/fJp6jmnr5W6AAttL472j0tygLrUjjWbeFyxr7/tF31v/bX4WiqsGNyOnH
	 HOUs23bUddApYDFGz+vN3hxwL6uQD7G3maxbqM+lJ2sTPvDji2z5PBPrheXfdl9s54
	 Cic0/C7k6optol5Pma+vfLvwmM8hCCSmgAgTtzShOQdxLH5dZCbhKS61T6Zqwsamp/
	 cWkCricgQj3Gc66Ers5F8CuUziOeuZ2nKV6VoXVXgez14u1qm40yvB6vqxPI/imtz0
	 1J1rZ5q69GO/w==
Date: Mon, 14 Jul 2025 22:24:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 7/7] xfs: error tag to force zeroing on debug kernels
Message-ID: <20250715052444.GP2672049@frogsfrogsfrogs>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-8-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714204122.349582-8-bfoster@redhat.com>

On Mon, Jul 14, 2025 at 04:41:22PM -0400, Brian Foster wrote:
> iomap_zero_range() has to cover various corner cases that are
> difficult to test on production kernels because it is used in fairly
> limited use cases. For example, it is currently only used by XFS and
> mostly only in partial block zeroing cases.
> 
> While it's possible to test most of these functional cases, we can
> provide more robust test coverage by co-opting fallocate zero range
> to invoke zeroing of the entire range instead of the more efficient
> block punch/allocate sequence. Add an errortag to occasionally
> invoke forced zeroing.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_errortag.h |  4 +++-
>  fs/xfs/xfs_error.c           |  3 +++
>  fs/xfs/xfs_file.c            | 26 ++++++++++++++++++++------
>  3 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
> index a53c5d40e084..33ca3fc2ca88 100644
> --- a/fs/xfs/libxfs/xfs_errortag.h
> +++ b/fs/xfs/libxfs/xfs_errortag.h
> @@ -65,7 +65,8 @@
>  #define XFS_ERRTAG_WRITE_DELAY_MS			43
>  #define XFS_ERRTAG_EXCHMAPS_FINISH_ONE			44
>  #define XFS_ERRTAG_METAFILE_RESV_CRITICAL		45
> -#define XFS_ERRTAG_MAX					46
> +#define XFS_ERRTAG_FORCE_ZERO_RANGE			46
> +#define XFS_ERRTAG_MAX					47
>  
>  /*
>   * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
> @@ -115,5 +116,6 @@
>  #define XFS_RANDOM_WRITE_DELAY_MS			3000
>  #define XFS_RANDOM_EXCHMAPS_FINISH_ONE			1
>  #define XFS_RANDOM_METAFILE_RESV_CRITICAL		4
> +#define XFS_RANDOM_FORCE_ZERO_RANGE			4
>  
>  #endif /* __XFS_ERRORTAG_H_ */
> diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
> index dbd87e137694..00c0c391c329 100644
> --- a/fs/xfs/xfs_error.c
> +++ b/fs/xfs/xfs_error.c
> @@ -64,6 +64,7 @@ static unsigned int xfs_errortag_random_default[] = {
>  	XFS_RANDOM_WRITE_DELAY_MS,
>  	XFS_RANDOM_EXCHMAPS_FINISH_ONE,
>  	XFS_RANDOM_METAFILE_RESV_CRITICAL,
> +	XFS_RANDOM_FORCE_ZERO_RANGE,
>  };
>  
>  struct xfs_errortag_attr {
> @@ -183,6 +184,7 @@ XFS_ERRORTAG_ATTR_RW(wb_delay_ms,	XFS_ERRTAG_WB_DELAY_MS);
>  XFS_ERRORTAG_ATTR_RW(write_delay_ms,	XFS_ERRTAG_WRITE_DELAY_MS);
>  XFS_ERRORTAG_ATTR_RW(exchmaps_finish_one, XFS_ERRTAG_EXCHMAPS_FINISH_ONE);
>  XFS_ERRORTAG_ATTR_RW(metafile_resv_crit, XFS_ERRTAG_METAFILE_RESV_CRITICAL);
> +XFS_ERRORTAG_ATTR_RW(force_zero_range, XFS_ERRTAG_FORCE_ZERO_RANGE);
>  
>  static struct attribute *xfs_errortag_attrs[] = {
>  	XFS_ERRORTAG_ATTR_LIST(noerror),
> @@ -230,6 +232,7 @@ static struct attribute *xfs_errortag_attrs[] = {
>  	XFS_ERRORTAG_ATTR_LIST(write_delay_ms),
>  	XFS_ERRORTAG_ATTR_LIST(exchmaps_finish_one),
>  	XFS_ERRORTAG_ATTR_LIST(metafile_resv_crit),
> +	XFS_ERRORTAG_ATTR_LIST(force_zero_range),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(xfs_errortag);
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 0b41b18debf3..c865f9555b77 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -27,6 +27,8 @@
>  #include "xfs_file.h"
>  #include "xfs_aops.h"
>  #include "xfs_zone_alloc.h"
> +#include "xfs_error.h"
> +#include "xfs_errortag.h"
>  
>  #include <linux/dax.h>
>  #include <linux/falloc.h>
> @@ -1269,13 +1271,25 @@ xfs_falloc_zero_range(
>  	if (error)
>  		return error;
>  
> -	error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
> -	if (error)
> -		return error;
> +	/*
> +	 * Zero range implements a full zeroing mechanism but is only used in
> +	 * limited situations. It is more efficient to allocate unwritten
> +	 * extents than to perform zeroing here, so use an errortag to randomly
> +	 * force zeroing on DEBUG kernels for added test coverage.
> +	 */
> +	if (XFS_TEST_ERROR(false, XFS_I(inode)->i_mount,
> +			   XFS_ERRTAG_FORCE_ZERO_RANGE)) {
> +		error = xfs_zero_range(XFS_I(inode), offset, len, ac, NULL);

Isn't this basically the ultra slow version fallback version of
FALLOC_FL_WRITE_ZEROES ?

--D

> +	} else {
> +		error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
> +		if (error)
> +			return error;
>  
> -	len = round_up(offset + len, blksize) - round_down(offset, blksize);
> -	offset = round_down(offset, blksize);
> -	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> +		len = round_up(offset + len, blksize) -
> +			round_down(offset, blksize);
> +		offset = round_down(offset, blksize);
> +		error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> +	}
>  	if (error)
>  		return error;
>  	return xfs_falloc_setsize(file, new_size);
> -- 
> 2.50.0
> 
> 

