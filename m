Return-Path: <linux-fsdevel+bounces-42660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC145A4588D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E400C1884FF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1C1E1DFA;
	Wed, 26 Feb 2025 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEhuPQ1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD3258CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559157; cv=none; b=l1S4CucnIG8Q6EJHQbfpj8IL7BIEuMaBE1/21MUG+MjYmvvd5sNUG1zvh9cI1l7VKSjUzA4wNPtT8t/JWTaBBYdmjjzlRpUrR0C9XuXWgB67veEDrQeN5C29jif0QBvHvtyobA5gH2lXkifWcQQ1Tkk0W7gwCLLhxCPaUomUFoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559157; c=relaxed/simple;
	bh=jQKYrXsLE+SJGMseoZ4j6+Q+13JRrG8ANAuqumIRUFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk13Hig9Rhthl5oBMt/6y2W7YhoRsGkTDgpnOL0XtYSs+SvEz3uCE3cKKYK1l5pE9ZmgKtQcEaZdt6pQcT3cP3iFX1uyi/GirNo1G75a5xGNtk0FXssBjZrtGhm6iGzvWXrsLpUlfuxO3Ucvx5o60zvBkE5XLPUN1BI1Ec9W1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEhuPQ1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE03DC4CEE7;
	Wed, 26 Feb 2025 08:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559157;
	bh=jQKYrXsLE+SJGMseoZ4j6+Q+13JRrG8ANAuqumIRUFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEhuPQ1pHI6yapno2eDPw98ieNzRms5U3mfCx+U6spvNRl0IZdPnLJIh+INMGDO8C
	 65We+6o/IkcXqrZePv51aq79eBLYXW5zZgtVpEFnooH16su/vf8zLvrs2vKrnj6tN6
	 iThXbEzEbz/p4YeFYqENoKcyJiJkt7p+jkcWO2ngRHsNREk4qzHZnsovaavt10Cwxk
	 56aNK64IF4+CZXzcHC/uxvVgXwvy+njcFhaL8GsnmmXojYNbg74i+ImkGC4YhYlPOG
	 1lIohV7jW5BvfXTmR+KFqOgKqftq22CfiIgu14wVFqOQbwDIfzDXyRYPWpT0xJStZo
	 wxsN+2D4Hp6pQ==
Date: Wed, 26 Feb 2025 09:39:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 15/21] kill simple_dentry_operations
Message-ID: <20250226-unheil-handumdrehen-e6d838f1a022@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-15-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-15-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:45PM +0000, Al Viro wrote:
> No users left and anything that wants it would be better off just
> setting DCACHE_DONTCACHE in their ->s_d_flags.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/libfs.c         | 5 -----
>  include/linux/fs.h | 1 -
>  2 files changed, 6 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index b15a2148714e..7eebaee9d082 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -62,11 +62,6 @@ int always_delete_dentry(const struct dentry *dentry)
>  }
>  EXPORT_SYMBOL(always_delete_dentry);
>  
> -const struct dentry_operations simple_dentry_operations = {
> -	.d_delete = always_delete_dentry,
> -};
> -EXPORT_SYMBOL(simple_dentry_operations);
> -
>  /*
>   * Lookup the data. This is trivial - if the dentry didn't already
>   * exist, we know it is negative.  Set d_op to delete negative dentries.
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 473a9de5fc8f..bdaf2f85e1ad 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3540,7 +3540,6 @@ extern const struct address_space_operations ram_aops;
>  extern int always_delete_dentry(const struct dentry *);
>  extern struct inode *alloc_anon_inode(struct super_block *);
>  extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
> -extern const struct dentry_operations simple_dentry_operations;
>  
>  extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
>  extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
> -- 
> 2.39.5
> 

