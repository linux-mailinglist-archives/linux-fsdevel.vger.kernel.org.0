Return-Path: <linux-fsdevel+bounces-13941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE8875A04
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C97C2832AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D011413DB9A;
	Thu,  7 Mar 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlY4h/zy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484312D744;
	Thu,  7 Mar 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849469; cv=none; b=sqfbAyVTrJfjLzCrltK3F4lw0aU3hld6cq1L9WdeEFMOAZ/l5vfShUI5ha0F00iCAAlZ01Hlt+jXbQFKkC9zlEukoW/40dcolATjNVy+wTYLpuAUchEql8EMnDY2GiGU+eQBU1A/el0thfNzzJaR1h8fPjUZcwATC4yz7n3xMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849469; c=relaxed/simple;
	bh=I103/99kJJXvHo77iv+oFIxQdUpHf6e7cTioE7wauVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDhnD50979FlAz3C9a04QB6WpjSOrHpdDuWpfmLG9OZ4m84FBZ/kNuOFdMULzqWWMw5JErUsHiWRDY5JLdL8PbF4osY45K/IofmaEHpC6I7f7wXq+E0QaYUoMd0nMyl9skRW1qkBbUfTU5GBcYMkP9mKC9PakHu0ILThwz6FsNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlY4h/zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3803C433F1;
	Thu,  7 Mar 2024 22:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849468;
	bh=I103/99kJJXvHo77iv+oFIxQdUpHf6e7cTioE7wauVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlY4h/zy2nVHWcrQxkAmkLmm3aBky1EahjjuCPGZNRwhwEA/rDYxwUv46IDIqIKjm
	 mII3qxV21/CJcvb0NtGBTsSRNPp9iGuWvkMnxN64rDj4KwngnZCfnBB5rlpyCZbrGc
	 BrDkOXw6yMF7GmIKVuLKLHBfSJUD9p2jr7LHJ+cI35WEVWqeoJdmQsmskCHru4h2U7
	 janhIM6l6EDcT3KHjKy7jqNnaWyIdWnmRBG5X1+yauCt4q/yuVwiixyA9pallpcJ8l
	 V5flfDUfnmR1QLG+0UEM0Qmk0vivi/OB+gYXECBKlfhOZQrGD3ZXczL9GgFsINZQtK
	 xVYCqDGORUzaQ==
Date: Thu, 7 Mar 2024 14:11:08 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 20/24] xfs: disable direct read path for fs-verity
 files
Message-ID: <20240307221108.GX1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-22-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-22-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:43PM +0100, Andrey Albershteyn wrote:
> The direct path is not supported on verity files. Attempts to use direct
> I/O path on such files should fall back to buffered I/O path.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 17404c2e7e31..af3201075066 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -281,7 +281,8 @@ xfs_file_dax_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
> -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> +	struct xfs_inode	*ip = XFS_I(inode);
>  	ssize_t			ret = 0;
>  
>  	trace_xfs_file_dax_read(iocb, to);
> @@ -334,10 +335,18 @@ xfs_file_read_iter(
>  
>  	if (IS_DAX(inode))
>  		ret = xfs_file_dax_read(iocb, to);
> -	else if (iocb->ki_flags & IOCB_DIRECT)
> +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
>  		ret = xfs_file_dio_read(iocb, to);
> -	else
> +	else {

I think the earlier cases need curly braces {} too.

> +		/*
> +		 * In case fs-verity is enabled, we also fallback to the
> +		 * buffered read from the direct read path. Therefore,
> +		 * IOCB_DIRECT is set and need to be cleared (see
> +		 * generic_file_read_iter())
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;

I'm curious that you added this flag here; how have we gotten along
this far without clearing it?

--D

>  		ret = xfs_file_buffered_read(iocb, to);
> +	}
>  
>  	if (ret > 0)
>  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> -- 
> 2.42.0
> 
> 

