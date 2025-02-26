Return-Path: <linux-fsdevel+bounces-42661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E6FA45890
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA63A9716
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2C1E1DFD;
	Wed, 26 Feb 2025 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/Oc6UPd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58075028C
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559196; cv=none; b=uatvQbK+WOPHthqR7JI9XAVTxrKdAef+jUEibm/nduEhFZO0gXClU8KZqiyQomZhfo6fn+R7mmsVTsvwPj599VhAJZfNYSHWAH5YsCPFrV6JNbk2ahRLSrTACBPQf5pJt4nkNTUaO7SrdgoYVbq0w7wf7BMoM2x0xmWeCvEN7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559196; c=relaxed/simple;
	bh=MCi7384hwwKLT4OR1dz92YehFcrcsJZ8+JLhNoiFKE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNqbeUXzlwZOAYfQXhiMHDekTbc0E3RZGU7+nxs5R78Id0ZPu2BEEhqSPuAd81+lqO3Nh+gX8pqh7LNDnM4kKHeIU2OP3W8oECj1B5P7UPuqEJ2kyqM/PvKWSxPXp27ttV0iTQXzgClV2vjWS7XYc/zcJFB/NMGqaYBrJI3Rc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/Oc6UPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF61C4CED6;
	Wed, 26 Feb 2025 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559196;
	bh=MCi7384hwwKLT4OR1dz92YehFcrcsJZ8+JLhNoiFKE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/Oc6UPdiLctWaNYjXRagtFlZvOvOrrcEI21DTDg1hnS2l2XMRxVqp5YJrNm3pZqa
	 M2zjNz7t2j52jC7A1/x/qeu9s4owxHP/ACith0ZwAPbqDj/t2ZGHaKqCDYGPr3iCxx
	 0hphrNI7nFcHrv6qvFrZsZGDVPl0mHKz9XqmyBfNjJUNAyXy0QWazzCrWmuinEaZW9
	 1RcFOOUKt8D4UluP/Vy1HuV1YRqHShJ/reKK9HU6AJdlDbifnlyYWU90zkyd+44VQp
	 4RcuEt8CdgEU1JmSQUHpgbhEBj6TI0Lb3++goyI2pY4KtAdk1MutUigWePuNnTCetV
	 I8/Yldx4pGRHg==
Date: Wed, 26 Feb 2025 09:39:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 16/21] ramfs, hugetlbfs, mqueue: set DCACHE_DONTCACHE
Message-ID: <20250226-ergreifen-bauruine-425261bdd8af@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-16-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-16-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:46PM +0000, Al Viro wrote:
> makes simple_lookup() slightly cheaper there.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/hugetlbfs/inode.c | 1 +
>  fs/ramfs/inode.c     | 1 +
>  ipc/mqueue.c         | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 0fc179a59830..205dd7562be1 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1431,6 +1431,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize_bits = huge_page_shift(ctx->hstate);
>  	sb->s_magic = HUGETLBFS_MAGIC;
>  	sb->s_op = &hugetlbfs_ops;
> +	sb->s_d_flags = DCACHE_DONTCACHE;
>  	sb->s_time_gran = 1;
>  
>  	/*
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 8006faaaf0ec..c4ee67870c4b 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -269,6 +269,7 @@ static int ramfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize_bits	= PAGE_SHIFT;
>  	sb->s_magic		= RAMFS_MAGIC;
>  	sb->s_op		= &ramfs_ops;
> +	sb->s_d_flags		= DCACHE_DONTCACHE;
>  	sb->s_time_gran		= 1;
>  
>  	inode = ramfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 35b4f8659904..dbd5c74eecb2 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -411,6 +411,7 @@ static int mqueue_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_blocksize_bits = PAGE_SHIFT;
>  	sb->s_magic = MQUEUE_MAGIC;
>  	sb->s_op = &mqueue_super_ops;
> +	sb->s_d_flags = DCACHE_DONTCACHE;
>  
>  	inode = mqueue_get_inode(sb, ns, S_IFDIR | S_ISVTX | S_IRWXUGO, NULL);
>  	if (IS_ERR(inode))
> -- 
> 2.39.5
> 

