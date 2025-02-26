Return-Path: <linux-fsdevel+bounces-42648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE2A45839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8DC1889F8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2537B22424F;
	Wed, 26 Feb 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g01dZ33u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89917224226
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558582; cv=none; b=rQ3QS4URJXrc7t4sitTOVMx6dz1uS1MOm44BgrgwZHO1nS/ThLrpEf2gGxMwtmoJmYa/dVqNkxIQ3qOdMnx56zvOha7kP+67HiRKcFgTLxgti4rrEWGpucT096PwfDJ/62GuCzl8gI0O2rhXUjd/VpCJGl6o7Qz9rYr4+4QIJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558582; c=relaxed/simple;
	bh=X+HPbTh4GucGRKtkO6ZfO6ujVw1C2EqnMdh4MvLVrh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWF7qA8lZQ+PxVY7mLdNQokzr2brpAMp9e5KKHzvwrvxYt/Ig2b3bdUqJ047pKJFJ+Qe3Bu9gdmsA1qNYIoWlvQv+uhlMzO/GE74hGbpjd8our1KyhCnszSB1Eu828oLiv1q5xijZ+zFqNyWP7AlCKPWAE3W8iwuf2i8c3bhaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g01dZ33u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FD0C4CEEA;
	Wed, 26 Feb 2025 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558580;
	bh=X+HPbTh4GucGRKtkO6ZfO6ujVw1C2EqnMdh4MvLVrh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g01dZ33ux5K7UG0uAkHsqwJGQmlypizVWCC9cGOznBpi2Pvas9BlDDjD/OcgCvNPR
	 OUC4vWAIkMfRj+FA526UVj5KHGdK7K9m+R5MI20desfiHxcXXsVVm0wfO8hhkr142j
	 Vl21Gp8ilyr5/7V8xq8TZgvz3k9KZa5Css8ptjNpQUJ/jxKioeI8BMxUBVXQpP8y2/
	 v4Aixn0Ifv+PlH86N4AsB4G6Yt1NQMhtHO4QzfWnlTed3UacAEsWqZmZ4SMw6Nt//V
	 AahCGPzR+q8vd5oXCE6Dd0KPGSYNONnQk+Y1QoOb6bhtplOZSycJDcK5RE6i5V+cKj
	 xSjKuOEf+Xw/w==
Date: Wed, 26 Feb 2025 09:29:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 04/21] fuse: no need for special dentry_operations for
 root dentry
Message-ID: <20250226-belangen-trial-4af2a1474fe4@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-4-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:34PM +0000, Al Viro wrote:
> ->d_revalidate() is never called for root anyway...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/fuse/dir.c    | 7 -------
>  fs/fuse/fuse_i.h | 1 -
>  fs/fuse/inode.c  | 4 +---
>  3 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 198862b086ff..24979d5413fa 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -336,13 +336,6 @@ const struct dentry_operations fuse_dentry_operations = {
>  	.d_automount	= fuse_dentry_automount,
>  };
>  
> -const struct dentry_operations fuse_root_dentry_operations = {
> -#if BITS_PER_LONG < 64
> -	.d_init		= fuse_dentry_init,
> -	.d_release	= fuse_dentry_release,
> -#endif
> -};
> -
>  int fuse_valid_type(int m)
>  {
>  	return S_ISREG(m) || S_ISDIR(m) || S_ISLNK(m) || S_ISCHR(m) ||
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index fee96fe7887b..71a2b3900854 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1069,7 +1069,6 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
>  extern const struct file_operations fuse_dev_operations;
>  
>  extern const struct dentry_operations fuse_dentry_operations;
> -extern const struct dentry_operations fuse_root_dentry_operations;
>  
>  /**
>   * Get a filled in inode
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e9db2cb8c150..57a1ee016b73 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1800,12 +1800,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  
>  	err = -ENOMEM;
>  	root = fuse_get_root_inode(sb, ctx->rootmode);
> -	sb->s_d_op = &fuse_root_dentry_operations;
> +	sb->s_d_op = &fuse_dentry_operations;
>  	root_dentry = d_make_root(root);
>  	if (!root_dentry)
>  		goto err_dev_free;
> -	/* Root dentry doesn't have .d_revalidate */
> -	sb->s_d_op = &fuse_dentry_operations;
>  
>  	mutex_lock(&fuse_mutex);
>  	err = -EINVAL;
> -- 
> 2.39.5
> 

