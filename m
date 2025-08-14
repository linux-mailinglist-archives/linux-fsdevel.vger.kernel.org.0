Return-Path: <linux-fsdevel+bounces-57945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D611B26EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42308A2788A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFDE21A44C;
	Thu, 14 Aug 2025 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWE+Szyu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DDF2036E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195706; cv=none; b=Na8q53VoX3A/+32KXwroujWRchoajrBmQEZ/4QwxIUlkXWDYlVioPk+VgUBbADBMnEpoxPsOKsVARcJhQZWYZXNI2bD469Jfs9jx6MEH410JPT/qT+uT+29wbLsVv+mX4CQRgK+JFnvnDnxBSJRvFOSlXkRWRQb9DFgmhjpN0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195706; c=relaxed/simple;
	bh=8e3Mo87/at2sctExwzDP0UBbd8Hgh2ByWzJHjI/8p8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlVEZYBth6Qy8yk9cqf4P6G6nkgL34skoBsr9xS/En7DtG4U/5m0u9AyhdVVR4BJLl4/Dha+3bxguo0kXyksoz+8L7E/I/qQ+koyyGuwondx4tW2UUKRJQ0oE5QX2h5/5lY7RWP2H/8EmMsXvr4NcNR4fNJBV1H8K50y0yeA+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWE+Szyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300CFC4CEED;
	Thu, 14 Aug 2025 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755195706;
	bh=8e3Mo87/at2sctExwzDP0UBbd8Hgh2ByWzJHjI/8p8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWE+SzyuUy+5TNq1fZK8oyx+tl+4JjAxwfQWZhjctbFHOmVVsEKmw5WqbOO6EFzeA
	 APzNKpZPNCervsL/KJAWVRNd/L6LuVZZjnnhmeOGZRVqyNrVO1DSJ8sgyGuQYodBDd
	 0EN4QqN50o1ad7tc/0knn62SnYxkGUNA2N/uEFS1Ylls7YyfEpkF9DbHRn049yRgrM
	 uTnknhLwurDS9VffOZtNJzNNdXLoIfsN0Q8DWmCNEWmRQZIulnvOjgKz4l/Xqa0+vW
	 SzTbLBFuvo8l8jRAbeOHQOJHEc4Evnwn8oiyprstpWz1F51stnO4EJizLONOEcsdJM
	 +3DUv/AoA+HBg==
Date: Thu, 14 Aug 2025 11:21:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] fuse: reflect cached blocksize if blocksize was
 changed
Message-ID: <20250814182145.GX7942@frogsfrogsfrogs>
References: <20250813223521.734817-1-joannelkoong@gmail.com>
 <20250813223521.734817-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813223521.734817-2-joannelkoong@gmail.com>

On Wed, Aug 13, 2025 at 03:35:20PM -0700, Joanne Koong wrote:
> As pointed out by Miklos[1], in the fuse_update_get_attr() path, the
> attributes returned to stat may be cached values instead of fresh ones
> fetched from the server. In the case where the server returned a
> modified blocksize value, we need to cache it and reflect it back to
> stat if values are not re-fetched since we now no longer directly change
> inode->i_blkbits.
> 
> Link: https://lore.kernel.org/linux-fsdevel/CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com/ [1]
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 542ede096e48 ("fuse: keep inode->i_blkbits constant)
> ---
>  fs/fuse/dir.c    | 1 +
>  fs/fuse/fuse_i.h | 6 ++++++
>  fs/fuse/inode.c  | 5 +++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 2d817d7cab26..ebee7e0b1cd3 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1377,6 +1377,7 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
>  		generic_fillattr(idmap, request_mask, inode, stat);
>  		stat->mode = fi->orig_i_mode;
>  		stat->ino = fi->orig_ino;
> +		stat->blksize = 1 << fi->cached_i_blkbits;
>  		if (test_bit(FUSE_I_BTIME, &fi->state)) {
>  			stat->btime = fi->i_btime;
>  			stat->result_mask |= STATX_BTIME;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index ec248d13c8bf..db44d05c8d02 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -210,6 +210,12 @@ struct fuse_inode {
>  	/** Reference to backing file in passthrough mode */
>  	struct fuse_backing *fb;
>  #endif
> +
> +	/*
> +	 * The underlying inode->i_blkbits value will not be modified,
> +	 * so preserve the blocksize specified by the server.
> +	 */
> +	unsigned char cached_i_blkbits;

Ahh, thanks for the comment.  That'll help me keep all this straight
later. :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  };
>  
>  /** FUSE inode state bits */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 67c2318bfc42..3bfd83469d9f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -289,6 +289,11 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>  		}
>  	}
>  
> +	if (attr->blksize)
> +		fi->cached_i_blkbits = ilog2(attr->blksize);
> +	else
> +		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
> +
>  	/*
>  	 * Don't set the sticky bit in i_mode, unless we want the VFS
>  	 * to check permissions.  This prevents failures due to the
> -- 
> 2.47.3
> 
> 

