Return-Path: <linux-fsdevel+bounces-57946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A4AB26ED1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17963AA3575
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F38221703;
	Thu, 14 Aug 2025 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB3EcjhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61631984B
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195907; cv=none; b=ZvmLx3AAMHCioQcqZrE4UPCn93kAP6YcgoBQBL+yG8PMw1mwvtUS0ljOT4FXzIAM+QQFWZRoQStGCOYSLHPjK4WbOZZomoNuB0Ab6s/sC7DcaWbILhwKgYzgjCSanM+WkPdUdkW71xTpI/jlrvU1xl4B2n3/uzPsw4MVrkKj5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195907; c=relaxed/simple;
	bh=DO9clH1jAjZAkdISrTQaD5KAkxRnURsiLLtk4S8e7Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0VAECLU7oPjPK/oj6fYqx0/o8GWM/+cgYmJY7vkfhg3l971ReEH6QA39VYchCWbul+5HjloabDmFlFPozDQeABJbMQ7juF6QlHQSXfXhcB83T187sWh/g6Wo8OjdO6TIy5duJUYNFw0k5YbYXjA16AAVZc6C6a09RKJpcXqShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB3EcjhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0246C4CEED;
	Thu, 14 Aug 2025 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755195906;
	bh=DO9clH1jAjZAkdISrTQaD5KAkxRnURsiLLtk4S8e7Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UB3EcjhNjZg2etv920xwEnfJEdPZ1svjGpk150CnGrJgb5UcSJ7LVWfN+vz2zSvNJ
	 F0qs7k90Dd50Aa1rKNP9qgTsGGKzMSEx14f25jSBilmARuw3WiEYwNHE3rh2tZe25X
	 M9FpL5KbICEEn7VvczcWUDZcVaV7/YjUd+pIbgiTQQyugkNIKvwNaj/LbfiIUg+z4G
	 tnKM9ZlNtG3cGv0/K/QctlUbX3Z1yv1prf8zaGiBAJWu0k0Ag7n0eqLDNHEgKRTnfb
	 ApO6HA4yH0Zyad4bPPUdf76RdwWP9A3TZAb3bFtcrhzNVnEZWfttvpeTAn8nX+L5Vt
	 6y7H1/52sRtng==
Date: Thu, 14 Aug 2025 11:25:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: fix fuseblk i_blkbits for iomap partial
 writes
Message-ID: <20250814182506.GY7942@frogsfrogsfrogs>
References: <20250813223521.734817-1-joannelkoong@gmail.com>
 <20250813223521.734817-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813223521.734817-3-joannelkoong@gmail.com>

On Wed, Aug 13, 2025 at 03:35:21PM -0700, Joanne Koong wrote:
> On regular fuse filesystems, i_blkbits is set to PAGE_SHIFT which means
> any iomap partial writes will mark the entire folio as uptodate. However
> fuseblk filesystems work differently and allow the blocksize to be less
> than the page size. As such, this may lead to data corruption if fuseblk
> sets its blocksize to less than the page size, uses the writeback cache,
> and does a partial write, then a read and the read happens before the
> write has undergone writeback, since the folio will not be marked
> uptodate from the partial write so the read will read in the entire
> folio from disk, which will overwrite the partial write.
> 
> The long-term solution for this, which will also be needed for fuse to
> enable large folios with the writeback cache on, is to have fuse also
> use iomap for folio reads, but until that is done, the cleanest
> workaround is to use the page size for fuseblk's internal kernel inode
> blksize/blkbits values while maintaining current behavior for stat().
> 
> This was verified using ntfs-3g:
> $ sudo mkfs.ntfs -f -c 512 /dev/vdd1
> $ sudo ntfs-3g /dev/vdd1 ~/fuseblk
> $ stat ~/fuseblk/hi.txt
> IO Block: 512
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: a4c9ab1d4975 ("fuse: use iomap for buffered writes")
> ---
>  fs/fuse/dir.c    |  2 +-
>  fs/fuse/fuse_i.h |  8 ++++++++
>  fs/fuse/inode.c  | 13 ++++++++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ebee7e0b1cd3..5c569c3cb53f 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1199,7 +1199,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
>  	if (attr->blksize != 0)
>  		blkbits = ilog2(attr->blksize);
>  	else
> -		blkbits = inode->i_sb->s_blocksize_bits;
> +		blkbits = fc->blkbits;
>  
>  	stat->blksize = 1 << blkbits;
>  }
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index db44d05c8d02..a6aa16422c30 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -975,6 +975,14 @@ struct fuse_conn {
>  		/* Request timeout (in jiffies). 0 = no timeout */
>  		unsigned int req_timeout;
>  	} timeout;
> +
> +	/*
> +	 * This is a workaround until fuse uses iomap for reads.
> +	 * For fuseblk servers, this represents the blocksize passed in at
> +	 * mount time and for regular fuse servers, this is equivalent to
> +	 * inode->i_blkbits.
> +	 */
> +	unsigned char blkbits;

uint8_t, since the value is an integer quantity, not a character.

>  };
>  
>  /*
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3bfd83469d9f..7ddfd2b3cc9c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -292,7 +292,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>  	if (attr->blksize)
>  		fi->cached_i_blkbits = ilog2(attr->blksize);
>  	else
> -		fi->cached_i_blkbits = inode->i_sb->s_blocksize_bits;
> +		fi->cached_i_blkbits = fc->blkbits;
>  
>  	/*
>  	 * Don't set the sticky bit in i_mode, unless we want the VFS
> @@ -1810,10 +1810,21 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  		err = -EINVAL;
>  		if (!sb_set_blocksize(sb, ctx->blksize))
>  			goto err;
> +		/*
> +		 * This is a workaround until fuse hooks into iomap for reads.
> +		 * Use PAGE_SIZE for the blocksize else if the writeback cache
> +		 * is enabled, buffered writes go through iomap and a read may
> +		 * overwrite partially written data if blocksize < PAGE_SIZE
> +		 */
> +		fc->blkbits = sb->s_blocksize_bits;
> +		if (ctx->blksize != PAGE_SIZE &&
> +		    !sb_set_blocksize(sb, PAGE_SIZE))
> +			goto err;
>  #endif
>  	} else {
>  		sb->s_blocksize = PAGE_SIZE;
>  		sb->s_blocksize_bits = PAGE_SHIFT;
> +		fc->blkbits = sb->s_blocksize_bits;
>  	}

Heh. :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

(How long until readahead? ;))

--D

>  	sb->s_subtype = ctx->subtype;
> -- 
> 2.47.3
> 
> 

