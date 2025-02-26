Return-Path: <linux-fsdevel+bounces-42662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D398FA45892
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA923A9803
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65C1E1DF9;
	Wed, 26 Feb 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQBvEqev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57C1A83FB
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559212; cv=none; b=aJijiKCi8wP20j1CQYiVA37o9MH5IkjlCxB89T2/lX3EClJBXXKqy5Hu4enPkdjD3h6ORc863Y2hzhJkOHFNAtcPxhMSAhCpQjOjVUdH8nCFIxW9Y9Zq+S5VwVCveogooXhABxNxSyh1Wt9qTxjBuSQ44kdQmFssHuz5JPrRZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559212; c=relaxed/simple;
	bh=dMAy/fms9O2tttHECor8U6FvpOK33+PNqrLNExoPNFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIO9YAcU5OFqkYCWO/8PTjPyQPvPuoRLA5zHeV4D9UzOAfAVIDJ49qgnEJKleh4MggyjJLubzZ8yt5u8k26bE5dARVjGYv+YWdoSAB02z5kDB7Bi59Vbh/AW3oTL6iD9AMy8dceN+KZCVBZj6Nuc9WiIb8DLvDKRF5GqE+A/A7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQBvEqev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FFAC4CEE7;
	Wed, 26 Feb 2025 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559211;
	bh=dMAy/fms9O2tttHECor8U6FvpOK33+PNqrLNExoPNFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQBvEqev6BbCKenR585b8xQii+CA/Jy9cIyO77nnhOtQMCxPfVgHY8ksrigNreBJX
	 FaYrXs08nfHeVeQ2sifpBACmx5iTCm4IENsAis792gebjyjLj08pRX1tf2q/Phtez5
	 nyL6C1ohgMWdSN1Zd83kgwrw58p43oqSf0E4YaLJr+Zc768I2Dew2ERnZ64gs2Tv6v
	 pJrGciyu64EXdELZ9tuBXuwbi/R4jdz0CwVIs6kxDLnIkdYkAI99hIXnXlh6BA/N3V
	 3eej65ik5QUGmfbylOc7ThTGf/zQLpiNLuMAxUU22jgN/rlI10RJuB/oaGqFdUB7LB
	 rGNglCWRLXcHA==
Date: Wed, 26 Feb 2025 09:40:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 17/21] 9p: don't bother with always_delete_dentry
Message-ID: <20250226-eheprobleme-nachverfolgen-cc966a6f6c7f@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-17-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-17-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:47PM +0000, Al Viro wrote:
> just set DCACHE_DONTCACHE for "don't cache" mounts...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/9p/vfs_dentry.c | 1 -
>  fs/9p/vfs_super.c  | 6 ++++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
> index 5061f192eafd..04795508a795 100644
> --- a/fs/9p/vfs_dentry.c
> +++ b/fs/9p/vfs_dentry.c
> @@ -127,7 +127,6 @@ const struct dentry_operations v9fs_cached_dentry_operations = {
>  };
>  
>  const struct dentry_operations v9fs_dentry_operations = {
> -	.d_delete = always_delete_dentry,
>  	.d_release = v9fs_dentry_release,
>  	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
>  	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> index 5c3dc3efb909..795c6388744c 100644
> --- a/fs/9p/vfs_super.c
> +++ b/fs/9p/vfs_super.c
> @@ -134,10 +134,12 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
>  	if (retval)
>  		goto release_sb;
>  
> -	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
> +	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
>  		set_default_d_op(sb, &v9fs_cached_dentry_operations);
> -	else
> +	} else {
>  		set_default_d_op(sb, &v9fs_dentry_operations);
> +		sb->s_d_flags |= DCACHE_DONTCACHE;
> +	}
>  
>  	inode = v9fs_get_new_inode_from_fid(v9ses, fid, sb);
>  	if (IS_ERR(inode)) {
> -- 
> 2.39.5
> 

