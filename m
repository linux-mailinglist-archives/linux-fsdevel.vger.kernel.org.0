Return-Path: <linux-fsdevel+bounces-62183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F394FB873FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 00:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C8E1C26A53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 22:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB992FD7CE;
	Thu, 18 Sep 2025 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbK03NQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A478BEE;
	Thu, 18 Sep 2025 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234942; cv=none; b=ukyEcPPwyCjg4OmeDxnBVXLAYfW3ZDI4Bv3Q6fTV8e9xfPjUXdwuceqvVByuBkzPr3Y6U7aE1uXJYyhWULYSxSzrRajYWeyHM2cPOFrdkH4nNpS1/EQyRLi+/0ucfwVKDkozE3hV3E1ogxVU45qJa/1f66wGyosQ6CdxhAWCj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234942; c=relaxed/simple;
	bh=e/b85KMA9IEr5mWBMqN3kAA+ZPj41wquStIM9LSDZk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsqQT08Zq/ZPGHtUvzr5Uh3sh64kccdQCUd3w10B+rn2Op+3Xkonc82vsZ9sF7h5HgbEkNXhlNLyzayeSuk0qJZkMv2lhNHf8p+53ZNRl9/BgPnrEzL44rC1wmCoo5KcurNxoT+dJli5YQHuSK2gdXNdKABqZmNDtEdz8vLPtkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbK03NQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD28C4CEE7;
	Thu, 18 Sep 2025 22:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758234941;
	bh=e/b85KMA9IEr5mWBMqN3kAA+ZPj41wquStIM9LSDZk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbK03NQIk5j0WPXeFpQwmfse0lHyNOUvTVl8vzwkscCIwSc8d+irM0Tx6iDcwC5sN
	 mBLHQF4xx12FhEHR78Ia/HlzqIFKeqOnMF6UXX75LwLxFp1H0xFGrK80HQoMVKHKZ6
	 1wSNdHdrn/1EOLDksVNooCWTj1XoWuCkR4meISrfZr3dvJrmAiqtK/d4aQEnX19Lef
	 UBFHCC8mrytjxEI+yFHeJ/49CxVbHneOXCBdtwFD9c96d8KoyRtRKpTpjCgZMIgWIl
	 +EDSOi/fLUkrtXWIkeho2jda9VKAbmbYuta1l413/6g3uWfKe3RB8W338CJipXML4U
	 K/5EsuPpbyERg==
Date: Thu, 18 Sep 2025 15:35:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 15/15] fuse: remove fc->blkbits workaround for partial
 writes
Message-ID: <20250918223541.GB1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-16-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-16-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:25PM -0700, Joanne Koong wrote:
> Now that fuse is integrated with iomap for read/readahead, we can remove
> the workaround that was added in commit bd24d2108e9c ("fuse: fix fuseblk
> i_blkbits for iomap partial writes"), which was previously needed to
> avoid a race condition where an iomap partial write may be overwritten
> by a read if blocksize < PAGE_SIZE. Now that fuse does iomap
> read/readahead, this is protected against since there is granular
> uptodate tracking of blocks, which means this workaround can be removed.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Oh goody!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/dir.c    |  2 +-
>  fs/fuse/fuse_i.h |  8 --------
>  fs/fuse/inode.c  | 13 +------------
>  3 files changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 5c569c3cb53f..ebee7e0b1cd3 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1199,7 +1199,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
>  	if (attr->blksize != 0)
>  		blkbits = ilog2(attr->blksize);
>  	else
> -		blkbits = fc->blkbits;
> +		blkbits = inode->i_sb->s_blocksize_bits;
>  
>  	stat->blksize = 1 << blkbits;
>  }
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index cc428d04be3e..1647eb7ca6fa 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -975,14 +975,6 @@ struct fuse_conn {
>  		/* Request timeout (in jiffies). 0 = no timeout */
>  		unsigned int req_timeout;
>  	} timeout;
> -
> -	/*
> -	 * This is a workaround until fuse uses iomap for reads.
> -	 * For fuseblk servers, this represents the blocksize passed in at
> -	 * mount time and for regular fuse servers, this is equivalent to
> -	 * inode->i_blkbits.
> -	 */
> -	u8 blkbits;
>  };
>  
>  /*
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index fdecd5a90dee..5899a47faaef 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -292,7 +292,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>  	if (attr->blksize)
>  		fi->cached_i_blkbits = ilog2(attr->blksize);
>  	else
> -		fi->cached_i_blkbits = fc->blkbits;
> +		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
>  
>  	/*
>  	 * Don't set the sticky bit in i_mode, unless we want the VFS
> @@ -1810,21 +1810,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  		err = -EINVAL;
>  		if (!sb_set_blocksize(sb, ctx->blksize))
>  			goto err;
> -		/*
> -		 * This is a workaround until fuse hooks into iomap for reads.
> -		 * Use PAGE_SIZE for the blocksize else if the writeback cache
> -		 * is enabled, buffered writes go through iomap and a read may
> -		 * overwrite partially written data if blocksize < PAGE_SIZE
> -		 */
> -		fc->blkbits = sb->s_blocksize_bits;
> -		if (ctx->blksize != PAGE_SIZE &&
> -		    !sb_set_blocksize(sb, PAGE_SIZE))
> -			goto err;
>  #endif
>  	} else {
>  		sb->s_blocksize = PAGE_SIZE;
>  		sb->s_blocksize_bits = PAGE_SHIFT;
> -		fc->blkbits = sb->s_blocksize_bits;
>  	}
>  
>  	sb->s_subtype = ctx->subtype;
> -- 
> 2.47.3
> 
> 

