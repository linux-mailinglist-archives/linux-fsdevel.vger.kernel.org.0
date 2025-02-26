Return-Path: <linux-fsdevel+bounces-42666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81899A4589E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B0F7A1BF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855421E1E1C;
	Wed, 26 Feb 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvR708Yp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87CB5028C
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559255; cv=none; b=aPgPtUeApWovS/yx8VN5xf9OrEF+Ep5HTtwNMMS3GnbFICdtQCPpzqUQaAd6mG+k+Cdyto9vd3syavNPjsTRG1Z3f0Ao0Tnm8JiUNE8AoyNNC6yxLyQBejBhz5la8k39vkn0DX4wNkgQ+PLNYIAIOVupIdWlxbg0WsosO+I/Y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559255; c=relaxed/simple;
	bh=lVSxChzKeGX8Gt/CZuk3NpvEG8yDNP4j022n+4ADeTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhmL14H03mZS6hpRuU4GF6kH/Qqy0yL+wHvvSF7+DunfNztCrvRQ8uCVPBxcKiSikcLnVrcAt1Dy7XdjwDJiPGUBmHHewbJfo0VtRqsLItkb6Ra6MTbKM7NVyNqXlcpeOydNCYqZ3hCew4+PmkGSnTPqXXC0Iw+l2ScSgh+5Cnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvR708Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3ACC4CED6;
	Wed, 26 Feb 2025 08:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559254;
	bh=lVSxChzKeGX8Gt/CZuk3NpvEG8yDNP4j022n+4ADeTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvR708Yp7wbxx/V8r1osy12VC0NzUAcv13Mhkds0lkHNdQftV5LQB3P7UqO+lM0nq
	 vgMeegtJvjp1J5pjEolHPCrMeS/NWIVPJbwZ5rYg5hL725D3mI7owC4JuROmWJCiCb
	 DI2N8wRLujxg7vT4rnjoYrCaMOsceARLJOuUVHUo9LttEMaBlbyaAoxWJjjJkmigs8
	 mnEUJS7SdhXTJyUGOJINwBPKHnyC0b+E5sdvbqHT18L15wFxDbOJG8TgZNmxxLNAJ6
	 gBdriTZlN2xifhPNylheog+RwhYqgfV6Nkh3Q5TXq5frARH8IKE9PlfKI46LSf20cu
	 i0IqNuxq3/jeA==
Date: Wed, 26 Feb 2025 09:40:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 19/21] debugfs: use DCACHE_DONTCACHE
Message-ID: <20250226-allseits-adler-c15aa2d95402@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-19-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-19-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:49PM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/debugfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index f54a8fd960e4..1c71d9932a67 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -258,7 +258,6 @@ static struct vfsmount *debugfs_automount(struct path *path)
>  }
>  
>  static const struct dentry_operations debugfs_dops = {
> -	.d_delete = always_delete_dentry,
>  	.d_release = debugfs_release_dentry,
>  	.d_automount = debugfs_automount,
>  };
> @@ -274,6 +273,7 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	sb->s_op = &debugfs_super_operations;
>  	set_default_d_op(sb, &debugfs_dops);
> +	sb->s_d_flags |= DCACHE_DONTCACHE;
>  
>  	debugfs_apply_options(sb);
>  
> -- 
> 2.39.5
> 

