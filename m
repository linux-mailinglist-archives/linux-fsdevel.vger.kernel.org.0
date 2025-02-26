Return-Path: <linux-fsdevel+bounces-42656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B19FA45884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EED3A7F82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55261E1DFD;
	Wed, 26 Feb 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WegaEW2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13828258CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559098; cv=none; b=TkIkwijNLDwmoniXdWwxbDx8xlr6N//nmTZUFNAmHYCrtFxBW8kLvme794heLXRS+jr4I5q8IpcQPXwkvytrKjBJp3pr3z4FAvoax+ROBpeeRkNkiILtUSbd/W01qNmcPNDAj0afNce6LWDUUl0x2rRxjZZtpFJhqVeyQEpQEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559098; c=relaxed/simple;
	bh=iIVS6Qg6yKRu5g1Fn5hkMFbH9URABHwkItdxyLmB3qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkZgAaUnwPJwiVEGgxh1QRXZwmU9NcgqAbftrp4cr1lTJH043qGSvHKoH6W4AA7aF4FqbGRflSLoSMNCVNbSZCs34xnZQRNJLs3jR92/4XM9PQyYC3RaopSN5+8Kjdc4AbuqBMcVMU0cr/unK00XBjod3CVXgewnq7CzqYnl5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WegaEW2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA6CC4CED6;
	Wed, 26 Feb 2025 08:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559094;
	bh=iIVS6Qg6yKRu5g1Fn5hkMFbH9URABHwkItdxyLmB3qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WegaEW2R6qQ8zT0J/vt2OOcz0MdnhbTVnOCNjyBJHgd2qvp71RhAiYp0jF+ra6qeh
	 n5ifruJQNtu22Lp63MtNnbKquq/Fit3BCJLzaiZMz+we8r2ycLYxbOsANnXXK9vIm4
	 YYxyKNE+3sbBOEn41GYR6/TPXc9slzl3KlBHTq/2OLGNg/T8/PEr4IEcjaprdx5kJI
	 bykkQh/Qd5g88ZBGB8+ciXK6wxAh0mDq+qb8krAvPuEjPqVwpF7z+VTdKufBKhXVrj
	 xtcScdoOp90KnxwOBU9rvPHldsWK3DDp1UJ9XZejLp3e0D+sVFABDXXQ2M7eQn8TDq
	 aL/rF4B3cFx2w==
Date: Wed, 26 Feb 2025 09:38:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 12/21] shmem: no dentry retention past the refcount
 reaching zero
Message-ID: <20250226-uferpromenade-waldhaus-3866b661cab8@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-12-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-12-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:42PM +0000, Al Viro wrote:
> Just set DCACHE_DONTCACHE in ->s_d_flags and be done with that.
> Dentries there live for as long as they are pinned; once the
> refcount hits zero, that's it.  The same, of course, goes for
> other tree-in-dcache filesystems - more in the next commits...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0ecb49113bb2..dd84b1c554a8 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4971,7 +4971,6 @@ static void shmem_put_super(struct super_block *sb)
>  static const struct dentry_operations shmem_ci_dentry_ops = {
>  	.d_hash = generic_ci_d_hash,
>  	.d_compare = generic_ci_d_compare,
> -	.d_delete = always_delete_dentry,
>  };
>  #endif
>  
> @@ -5028,6 +5027,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  #else
>  	sb->s_flags |= SB_NOUSER;
>  #endif /* CONFIG_TMPFS */
> +	sb->s_d_flags |= DCACHE_DONTCACHE;
>  	sbinfo->max_blocks = ctx->blocks;
>  	sbinfo->max_inodes = ctx->inodes;
>  	sbinfo->free_ispace = sbinfo->max_inodes * BOGO_INODE_SIZE;
> -- 
> 2.39.5
> 

