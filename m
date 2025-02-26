Return-Path: <linux-fsdevel+bounces-42665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B061A4589D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881717A919A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BC1E1DF3;
	Wed, 26 Feb 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXLQrjIU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB101A9B34
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559242; cv=none; b=qq9toT7exJLjEo467pjFLBxTIiXdycsI4l1mxvlMf3itbzzsQoSQd+052EMBDIG6mmcB89DPmjhQBJoJuYMD3xZlA/TNvu0c92fKIA73HE14rTynjNoyH8KJfKjtcdTI88Z2n4Zptwb7w2IkyAfDbZuqjyjdAzPNgKNqLXSsrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559242; c=relaxed/simple;
	bh=Ztrz5XdWdOvlqXjC4dFSnQkkc69FYpK82o93cLwS4Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJlNtvWQHrvc0JwJFJ0GbdNEap4SZsQF6mQPlFMCz61b+XYRYUfaBtLT1g4HFWDN0I9RxCjl82IgoWfPj98dVN1WO2QXy2PQoUwBhjSGCY8FTnGN5pYLkqz2UbldX3VF++2hSpNtizbplAlXyYCNWBbXIgxkkxZWm146pUvnexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXLQrjIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1386FC4CED6;
	Wed, 26 Feb 2025 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559241;
	bh=Ztrz5XdWdOvlqXjC4dFSnQkkc69FYpK82o93cLwS4Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXLQrjIUefdSrKH0wQ7uFQmnUk4UL0CbR0yAjZEMfdQy3nrfo2T7PyVYJhoATpiot
	 ambgDS7V8FFuLrqaToUbTxGIe+qu/9YoShtSU08XTWOVbm6oEdApNHoqX0b8aON3ax
	 1vq1HcyOkViDEbmSiliMP5RLGjq2YXWhvy7Sp6E71H7lgmkF4alILmTlgV6DeQ928W
	 w+RsWl1AAHAlMP5B97rkJotzdmPw+D6UeTHN1+6Oyd040bH3LE66jg0A1fdlmls3gC
	 xMOQ37JJXRAk1T1p5F+Zeq4l1K0XEXPTkzfxszXX3TKrL+tU1OEa+4SqCoIKtnL/CU
	 Q8yrRQ9LJqTOw==
Date: Wed, 26 Feb 2025 09:40:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 20/21] configfs: use DCACHE_DONTCACHE
Message-ID: <20250226-erleben-frohnatur-948238c4ed4d@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-20-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-20-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:50PM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/configfs/dir.c   | 1 -
>  fs/configfs/mount.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 7d10278db30d..637267a76ad8 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -67,7 +67,6 @@ static void configfs_d_iput(struct dentry * dentry,
>  
>  const struct dentry_operations configfs_dentry_ops = {
>  	.d_iput		= configfs_d_iput,
> -	.d_delete	= always_delete_dentry,
>  };
>  
>  #ifdef CONFIG_LOCKDEP
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index 20412eaca972..740f18b60c9d 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -93,6 +93,7 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	root->d_fsdata = &configfs_root;
>  	sb->s_root = root;
>  	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
> +	sb->s_d_flags |= DCACHE_DONTCACHE;
>  	return 0;
>  }
>  
> -- 
> 2.39.5
> 

