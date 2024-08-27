Return-Path: <linux-fsdevel+bounces-27397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FBD961391
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B344B22A3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447861CDFC4;
	Tue, 27 Aug 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJsFMc+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E21C86F4;
	Tue, 27 Aug 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774634; cv=none; b=n/Gy1Nr7mIoN4R4DM+vVj7cdX4rDZTGMKzzkxsOaMtkHlj+/kdSMNrXMp+BKnnV/zkQI6pKofepMKesNuW5AVplHCOmS6jUh9W6jRm09jhoV+SJa47GpBSF5IJ6F6Q8be8z7aeyZ2g8InF6qFr9ABJw9seVARy1MtKz9hUWKTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774634; c=relaxed/simple;
	bh=j2K6j335okpZ6K66oy7S+jmdBzIkN4HHqxmSJr07Apw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj+IBsh/8nbi+m/pDnKOBWF0xJhVJk24HH8hbFox+EMjVJsYpBNmCF7vuA/qyPbuv7UeYjxPVqu81Drgwf0LNLWEFThBTkpaTA+xSz0E6W/htTxdmVDi5ItR9upMcmn2WvO4upGY1IioLU7fXW61YEA5CFCuIJuhmMasncFHu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJsFMc+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017FBC5819A;
	Tue, 27 Aug 2024 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774634;
	bh=j2K6j335okpZ6K66oy7S+jmdBzIkN4HHqxmSJr07Apw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJsFMc+4yKBBUG4AYT2rndPxLgjUJIxmijZ2YUgT95oyTEFx/oihNLFCPPgOyYqIT
	 NpY2G+8Sa0DpxmLAHbtTtHqcrOgswSncCFbkAzRpyZt696QFMRup56JjMOcLZChxyV
	 2WMHPkP4Dp1T4m+l6qyC6y/Mq2erMgQSVrtWRpjRLqMYFdpL4D+muzkwdNDSLGKjy6
	 4cT2oK/rPm3db+3HycWWDe7nOh3sM1Xjl/Q5QgfWWG2SjzLUaTR/gS7iIiaYDMEQcG
	 HWWx3aK4OB24erDrIq7lKE2g9dP16wbEn1DB76vaOUpjuVYkWUTQEV3jL8ieiY9Dht
	 leJy6+FDhiRSg==
Date: Tue, 27 Aug 2024 09:03:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/6] xfs: move the xfs_is_always_cow_inode check into
 xfs_alloc_file_space
Message-ID: <20240827160353.GT865349@frogsfrogsfrogs>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-6-hch@lst.de>

On Tue, Aug 27, 2024 at 08:50:49AM +0200, Christoph Hellwig wrote:
> Move the xfs_is_always_cow_inode check from the caller into
> xfs_alloc_file_space to prepare for refactoring of xfs_file_fallocate.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_bmap_util.c | 3 +++
>  fs/xfs/xfs_file.c      | 8 +++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 187a0dbda24fc4..e9fdebaa40ea59 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -653,6 +653,9 @@ xfs_alloc_file_space(
>  	xfs_bmbt_irec_t		imaps[1], *imapp;
>  	int			error;
>  
> +	if (xfs_is_always_cow_inode(ip))
> +		return 0;
> +
>  	trace_xfs_alloc_file_space(ip);
>  
>  	if (xfs_is_shutdown(mp))
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5b9e49da06013c..489bc1b173c268 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -987,11 +987,9 @@ xfs_file_fallocate(
>  			}
>  		}
>  
> -		if (!xfs_is_always_cow_inode(ip)) {
> -			error = xfs_alloc_file_space(ip, offset, len);
> -			if (error)
> -				goto out_unlock;
> -		}
> +		error = xfs_alloc_file_space(ip, offset, len);
> +		if (error)
> +			goto out_unlock;
>  	}
>  
>  	/* Change file size if needed */
> -- 
> 2.43.0
> 
> 

