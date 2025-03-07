Return-Path: <linux-fsdevel+bounces-43401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47107A55F23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 05:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DCE3B32C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 04:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BC190485;
	Fri,  7 Mar 2025 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8jusahW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDFC2940D;
	Fri,  7 Mar 2025 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320268; cv=none; b=m6mIlsi4WiZulAE47Y8wvVqT9qzQG/8rhEt71fqvZeB7ABCk2Eb1vyaaeF5bvl29iwwFmjfwSkesi0yql+mLnHUxw/eSoWqxYPysn2YfKjHE0WtpRv14KqGRInsJX3vOvGhuwO3n39sJUH/qe0IjVuWw0r1ekTb62W74umBiXqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320268; c=relaxed/simple;
	bh=y2UGWXanHbw1Q8YHsRPT1smCsNKw0xaD6pJ/xMnKtxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W515xDiwtNgpwhLwcsjlcB93E4TO8N2UlxX6MVm5Nfu4kGPzxGep4FEERNylq8Lfj+T+5Cv3iTmYQp8BNIsMTEjE33+9SDqwkL1t4vpYFKuNlBN1o8rkcv4LvOTcC+9XzZY1GlGwGXfnbfHEZ72P5fgBuetjrPdf1KgPLNKXpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8jusahW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4898C4CED1;
	Fri,  7 Mar 2025 04:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741320267;
	bh=y2UGWXanHbw1Q8YHsRPT1smCsNKw0xaD6pJ/xMnKtxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8jusahWPJj9LUP6hz+WNCcpkGBXYxDv/vAgeurtFnBinqx8f3rq7/8JGf53axrNB
	 RKY0V3PEi7m71rqaddvSnJ2XyNKiZHYOhjDzB8N+IZZlW45nERBllODEzQIV3lXnjL
	 5RT4MsKvGIPCPzZj6WCEkYoUw9HA4yxesq3SURblzd5B1YlfIl5F50QynrUTcloJJa
	 NtaTqrqRQYZ/SxaHzMTyd6cKpwWy7rA+II1vtw9fQAggEWIUZBt6Y/+gpBzH0dxZS0
	 A27BLyLchA+04hJao+wHpI+hM+k0erqib1UzeCBFXrU5S7/tj4l4XhjiswjH7DSxTp
	 7mP44Vg2rG0Ww==
Date: Thu, 6 Mar 2025 20:04:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, hare@suse.de, willy@infradead.org,
	david@fromorbit.com, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v2] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()
Message-ID: <20250307040426.GG2803771@frogsfrogsfrogs>
References: <20250307020403.3068567-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307020403.3068567-1-mcgrof@kernel.org>

On Thu, Mar 06, 2025 at 06:04:03PM -0800, Luis Chamberlain wrote:
> The commit titled "block/bdev: lift block size restrictions to 64k"
> lifted the block layer's max supported block size to 64k inside the
> helper blk_validate_block_size() now that we support large folios.
> However in lifting the block size we also removed the silly use
> cases many filesystems have to use sb_set_blocksize() to *verify*
> that the block size <= PAGE_SIZE. The call to sb_set_blocksize() was
> used to check the block size <= PAGE_SIZE since historically we've
> always supported userspace to create for example 64k block size
> filesystems even on 4k page size systems, but what we didn't allow
> was mounting them. Older filesystems have been using the check with
> sb_set_blocksize() for years.
> 
> While, we could argue that such checks should be filesystem specific,
> there are much more users of sb_set_blocksize() than LBS enabled
> filesystem on upstream, so just do the easier thing and bring back
> the PAGE_SIZE check for sb_set_blocksize() users and only skip it
> for LBS enabled filesystems.
> 
> This will ensure that tests such as generic/466 when run in a loop
> against say, ext4, won't try to try to actually mount a filesystem with
> a block size larger than your filesystem supports given your PAGE_SIZE
> and in the worst case crash.
> 
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good to me!  Now we can support sector size > 32K XFS.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bdev.c       | 2 ++
>  fs/bcachefs/fs.c   | 2 +-
>  fs/xfs/xfs_super.c | 3 ++-
>  include/linux/fs.h | 1 +
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 3bd948e6438d..4844d1e27b6f 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -181,6 +181,8 @@ EXPORT_SYMBOL(set_blocksize);
>  
>  int sb_set_blocksize(struct super_block *sb, int size)
>  {
> +	if (!(sb->s_type->fs_flags & FS_LBS) && size > PAGE_SIZE)
> +		return 0;
>  	if (set_blocksize(sb->s_bdev_file, size))
>  		return 0;
>  	/* If we get here, we know size is validated */
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 8b3be33a1f7a..8624b3b1601f 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -2414,7 +2414,7 @@ static struct file_system_type bcache_fs_type = {
>  	.name			= "bcachefs",
>  	.init_fs_context	= bch2_init_fs_context,
>  	.kill_sb		= bch2_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_LBS,
>  };
>  
>  MODULE_ALIAS_FS("bcachefs");
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 37898f89b3ea..54a353f52ffb 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -2134,7 +2134,8 @@ static struct file_system_type xfs_fs_type = {
>  	.init_fs_context	= xfs_init_fs_context,
>  	.parameters		= xfs_fs_parameters,
>  	.kill_sb		= xfs_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
> +				  FS_LBS,
>  };
>  MODULE_ALIAS_FS("xfs");
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 110d95d04299..62440a9383dc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2614,6 +2614,7 @@ struct file_system_type {
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
>  #define FS_MGTIME		64	/* FS uses multigrain timestamps */
> +#define FS_LBS			128	/* FS supports LBS */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
> -- 
> 2.47.2
> 

