Return-Path: <linux-fsdevel+bounces-44692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933DDA6B692
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 10:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399153AC337
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D71EF36C;
	Fri, 21 Mar 2025 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e216D3CF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9AB1DDA39
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547803; cv=none; b=oLeaCUVBhnWl+CN1fAsrqI698M+xxFw4cYXyhoTXPNyrNYA2lBRo7Smf8oW6tcXGgC77sf7bWFe7f69RKwfS6BhsfaTOBv6oYX5O7KZKPj3ALjime/W9rM9el3tCFIX4JcsaWOc0qXU8xlozh2d20qLFuGV7TpWJTDu18j24BDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547803; c=relaxed/simple;
	bh=uDmneIw4do2IW2sO9hyJBlhgNYGVhbXvbnbZqO2hgtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0/ag4fL6ovu+9Fon3rCRR/QAjY5Ppu9K8fGIa+KnLYAHF+yv4RT/HJDy0gHnvMmbCsKUoWG4oWXbnMB3mflYtmAG/zl97/6HzBfAJ9UmarUCTVZMqjQUuPu926BMgBs94VihpCiJFgfswikFGVv7JEDNsnsSNhTmsW2sF06lNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e216D3CF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587DEC4CEE8;
	Fri, 21 Mar 2025 09:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742547802;
	bh=uDmneIw4do2IW2sO9hyJBlhgNYGVhbXvbnbZqO2hgtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e216D3CFk5iSkzunFTZJFU30aEhe3jyHx6xTwvwDpqXw5vcyaT+HZ5G4I7k8QK3ec
	 o+OzcIu7Ri0lMudeUkfMwNx6Fwq9MoZjY8vVRezWRkpvM8qxpirBztNlCqtZ9EsgbF
	 AUtKtQqRtyxzco0vvu6lLsr7xa7+r2PQbsmJprY/4TKU8P+T+bT7m9v5DPTtqQhsyL
	 m94CU63wEnKE8DmaPMmXBLOfAfrLaVeayS49b1HI+ow13I9hv7WyNKUfco12izpirj
	 YU95mDvjmcP6rr9nbEzsRdZMemSf0Jdyr/sszugdGhCGf24sTlvI9lzyfPF2SAxWYh
	 BQ/e0LSdDCOHQ==
Date: Fri, 21 Mar 2025 10:03:18 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Pavel Reichl <preichl@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, aivazian.tigran@gmail.com, 
	sandeen@redhat.com
Subject: Re: [PATCH] bfs: convert bfs to use the new mount api
Message-ID: <26jv4m6xr67islbcswhpw2trrqvoz7es7dv2z73o2tt2kqaoen@bimout5aidkm>
References: <zEHUdbaP6cryzwR_ZMnWadBpSDaStDGa5zhyFW-Fq_DDzrLF64GdtEYNZLZ9grQVEbrR7r3NtOOul7-leK3Zig==@protonmail.internalid>
 <20250320204224.181403-1-preichl@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320204224.181403-1-preichl@redhat.com>

On Thu, Mar 20, 2025 at 09:42:24PM +0100, Pavel Reichl wrote:
> Convert the bfs filesystem to use the new mount API.
> 
> Tested using mount and simple writes & reads on ro/rw bfs devices.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>


Looks good,
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>


> ---
>  fs/bfs/inode.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> index db81570c9637..1d41ce477df5 100644
> --- a/fs/bfs/inode.c
> +++ b/fs/bfs/inode.c
> @@ -17,6 +17,7 @@
>  #include <linux/writeback.h>
>  #include <linux/uio.h>
>  #include <linux/uaccess.h>
> +#include <linux/fs_context.h>
>  #include "bfs.h"
> 
>  MODULE_AUTHOR("Tigran Aivazian <aivazian.tigran@gmail.com>");
> @@ -305,7 +306,7 @@ void bfs_dump_imap(const char *prefix, struct super_block *s)
>  #endif
>  }
> 
> -static int bfs_fill_super(struct super_block *s, void *data, int silent)
> +static int bfs_fill_super(struct super_block *s, struct fs_context *fc)
>  {
>  	struct buffer_head *bh, *sbh;
>  	struct bfs_super_block *bfs_sb;
> @@ -314,6 +315,7 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
>  	struct bfs_sb_info *info;
>  	int ret = -EINVAL;
>  	unsigned long i_sblock, i_eblock, i_eoff, s_size;
> +	int silent = fc->sb_flags & SB_SILENT;
> 
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
> @@ -446,18 +448,28 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
>  	return ret;
>  }
> 
> -static struct dentry *bfs_mount(struct file_system_type *fs_type,
> -	int flags, const char *dev_name, void *data)
> +static int bfs_get_tree(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, bfs_fill_super);
> +	return get_tree_bdev(fc, bfs_fill_super);
> +}
> +
> +static const struct fs_context_operations bfs_context_ops = {
> +	.get_tree = bfs_get_tree,
> +};
> +
> +static int bfs_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &bfs_context_ops;
> +
> +	return 0;
>  }
> 
>  static struct file_system_type bfs_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name		= "bfs",
> -	.mount		= bfs_mount,
> -	.kill_sb	= kill_block_super,
> -	.fs_flags	= FS_REQUIRES_DEV,
> +	.owner			= THIS_MODULE,
> +	.name			= "bfs",
> +	.init_fs_context	= bfs_init_fs_context,
> +	.kill_sb		= kill_block_super,
> +	.fs_flags		= FS_REQUIRES_DEV,
>  };
>  MODULE_ALIAS_FS("bfs");
> 
> --
> 2.49.0
> 
> 

