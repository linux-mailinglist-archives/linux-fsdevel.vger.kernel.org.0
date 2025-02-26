Return-Path: <linux-fsdevel+bounces-42651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB0A4586A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7DE1893789
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605BA27702;
	Wed, 26 Feb 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgPy4K5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7C1E1E07
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558801; cv=none; b=YnJmMXvHnkC+XphwzZ5yJROVAQXYcIxz9HEsXnPhkDf1bDwSTmSVNsngm/UvuD6fc8d2Xta7v/oGHdCDvSdyQunVodqYy66+jDVDEhEoVfKAd/oM7S/pXkE3dIzltXmDkLfZhB0yyu/k2IMIhC71eCW99rTLC4f0ijRSphIU+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558801; c=relaxed/simple;
	bh=xh+btimtYFym7Y5lE70FuIAYEzG0PrBaSSeVA4yfwlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRVeL1s+f7JAlCNKXS0Wcfg7aT/8FOCg4LrlYXBi4TWESn2WuDrQaNyAO5INt4LNeX+XjXWDGgLQRSqgOuQthiIMizB6yNIwe/OUpeVtQjgRJG9LCdaDne6K72YAoVkvvdJCrKPG7gisj2Pa9y/kCSDaXv66ZPlyl8CJ6UgrqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgPy4K5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C06C4CED6;
	Wed, 26 Feb 2025 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558801;
	bh=xh+btimtYFym7Y5lE70FuIAYEzG0PrBaSSeVA4yfwlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgPy4K5t0QmaWFlsgenLtUAMh+zvq+MU43FgNXAlFY38aDkilyYVmxNNCrOwqPJ4G
	 b7HbIr1xu33rOtEdIhaIs6PyF5Og900oJiS7n3VDwAVIZQtj5wdoSbLlC+1E28jX+s
	 5FuSikU5MZ1kOS6q6pXikj66ytftIbCB9FepOFz2NyhHTKnKspD+eX5t1bUy+jxyF9
	 xMtLmuVDm6vINNSUMXx2wBhFp7qhMbfxp/lPtfMnowhuKg3C7y0MetJwfBV1aOZkDl
	 sPrtDrJVCqgNrfYwdsIBZ66binJG7TzcvHyALN3n/IWsOazh8ItJF/FS7cgHD0XWGl
	 cZ5NuqvmZbbOA==
Date: Wed, 26 Feb 2025 09:33:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 07/21] set_default_d_op(): calculate the matching value
 for ->d_flags
Message-ID: <20250226-graustufen-raufen-9d678a5d2e36@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-7-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-7-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:37PM +0000, Al Viro wrote:
> ... and store it in ->s_d_flags, to be used in __d_alloc()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/dcache.c        | 6 ++++--
>  include/linux/fs.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 1201149e1e2c..a4795617c3db 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1705,14 +1705,14 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  	dentry->d_inode = NULL;
>  	dentry->d_parent = dentry;
>  	dentry->d_sb = sb;
> -	dentry->d_op = NULL;
> +	dentry->d_op = sb->__s_d_op;
> +	dentry->d_flags = sb->s_d_flags;
>  	dentry->d_fsdata = NULL;
>  	INIT_HLIST_BL_NODE(&dentry->d_hash);
>  	INIT_LIST_HEAD(&dentry->d_lru);
>  	INIT_HLIST_HEAD(&dentry->d_children);
>  	INIT_HLIST_NODE(&dentry->d_u.d_alias);
>  	INIT_HLIST_NODE(&dentry->d_sib);
> -	d_set_d_op(dentry, dentry->d_sb->__s_d_op);
>  
>  	if (dentry->d_op && dentry->d_op->d_init) {
>  		err = dentry->d_op->d_init(dentry);
> @@ -1850,7 +1850,9 @@ EXPORT_SYMBOL(d_set_d_op);
>  
>  void set_default_d_op(struct super_block *s, const struct dentry_operations *ops)
>  {
> +	unsigned int flags = d_op_flags(ops);
>  	s->__s_d_op = ops;
> +	s->s_d_flags = (s->s_d_flags & ~DCACHE_OP_FLAGS) | flags;
>  }
>  EXPORT_SYMBOL(set_default_d_op);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 23fd8b0d4e81..473a9de5fc8f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1392,6 +1392,7 @@ struct super_block {
>  	char			s_sysfs_name[UUID_STRING_LEN + 1];
>  
>  	unsigned int		s_max_links;
> +	unsigned int		s_d_flags;
>  
>  	/*
>  	 * The next field is for VFS *only*. No filesystems have any business
> -- 
> 2.39.5
> 

