Return-Path: <linux-fsdevel+bounces-9395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE5840A36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FF31F24219
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93726154436;
	Mon, 29 Jan 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze1ez7QB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1840151CF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542763; cv=none; b=JNbDh8z7u0/isAJK5MCN24Jx/nzPmg7tNqXqUHxTtiLmkVLddD78a8f9IrnehdAgPw0g+fIiy+RHXzZko/ZnHgJq+X1pVEzPlMWstgvB1szGUhfzjp12BdvqNyzktK2n1Aej/jyd8TpOaSW/X2IldlDDhHa66/Vzd+3RnwgMiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542763; c=relaxed/simple;
	bh=Tw6qCP0p8Yfy1xot19g/dg5ds3oGwrzbp6v9krVGkCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDR1yrWDYUzGS3YrteGtJCKh+FHhZhM5oTDTJ6TxE8cWpNOftH0lTbcXN0R9aIaj4OeBiPyoxzUNPMcV7dLH57046FPP0sHoP8b15jDHi46itTUpdXSbOMLVEi2vqzANeAoNTJ34j9QWQ2UUPzQHSvYMIvXd5EoFoztOckbuunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze1ez7QB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F326C433C7;
	Mon, 29 Jan 2024 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706542762;
	bh=Tw6qCP0p8Yfy1xot19g/dg5ds3oGwrzbp6v9krVGkCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ze1ez7QB7tDnTcG7azEhKHG0DgsrSWTZ4SUG4Ygvcr9COyprqyHymPQcKJZcpA9dl
	 sauTKP5IhuiuhVwKXltlqGd3Z7/nNVRliPXJ6eZw9PE0APUQ4a8b/XAOd8odJ/SjpJ
	 dRWqEkzth4B0Sl6zNjSjs8nvIRP3C4IvF1pUsSsdl6CCvRWr50ihp/aD6L7BfcFQnN
	 eCPgyDsc6OGtHIr5DKbe70ysBYWh7DjNYEAG35JJjzo4hPF0eLx6osAV0pk+quQkIN
	 uHa+yz1fEA5295SKPfkt18FIkPxjlPAj9hBbyMHsgMJdzEOPZ862yewJt9U/STw4cQ
	 bYlXgVeAbcnmw==
Date: Mon, 29 Jan 2024 16:39:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tony Solomonik <tony.solomonik@gmail.com>
Cc: willy@infradead.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] Add do_ftruncate that truncates a struct file
Message-ID: <20240129-freischaffend-gefeuert-18ccf4cd5f01@brauner>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240129151507.14885-1-tony.solomonik@gmail.com>
 <20240129151507.14885-2-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129151507.14885-2-tony.solomonik@gmail.com>

On Mon, Jan 29, 2024 at 05:15:06PM +0200, Tony Solomonik wrote:
> do_sys_ftruncate receives a file descriptor, fgets the struct file, and
> finally actually truncates the file.
> 
> do_ftruncate allows for passing in a file directly, with the caller
> already holding a reference to it.
> 
> Signed-off-by: Tony Solomonik <tony.solomonik@gmail.com>
> ---
>  fs/internal.h |  1 +
>  fs/open.c     | 52 ++++++++++++++++++++++++++++-----------------------
>  2 files changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 58e43341aebf..d35b1c05cf6d 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -182,6 +182,7 @@ extern struct open_how build_open_how(int flags, umode_t mode);
>  extern int build_open_flags(const struct open_how *how, struct open_flags *op);
>  extern struct file *__close_fd_get_file(unsigned int fd);
>  
> +long do_ftruncate(struct file *file, loff_t length);
>  long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
>  int chmod_common(const struct path *path, umode_t mode);
>  int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
> diff --git a/fs/open.c b/fs/open.c
> index 02dc608d40d8..6d608ff4a3f7 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -154,49 +154,55 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
>  }
>  #endif
>  
> -long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
> +long do_ftruncate(struct file *file, loff_t length)
>  {
>  	struct inode *inode;
>  	struct dentry *dentry;
> +	int error;
> +
> +	dentry = file->f_path.dentry;
> +	inode = dentry->d_inode;
> +	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
> +		return -EINVAL;
> +
> +	/* Check IS_APPEND on real upper inode */
> +	if (IS_APPEND(file_inode(file)))
> +		return -EPERM;
> +	sb_start_write(inode->i_sb);
> +	error = security_file_truncate(file);
> +	if (!error)
> +		error = do_truncate(file_mnt_idmap(file), dentry, length,
> +				    ATTR_MTIME | ATTR_CTIME, file);
> +	sb_end_write(inode->i_sb);
> +
> +	return error;
> +}
> +
> +long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
> +{
>  	struct fd f;
>  	int error;
>  
> -	error = -EINVAL;
>  	if (length < 0)
> -		goto out;
> -	error = -EBADF;
> +		return -EINVAL;
>  	f = fdget(fd);
>  	if (!f.file)
> -		goto out;
> +		return -EBADF;
>  
>  	/* explicitly opened as large or we are on 64-bit box */
>  	if (f.file->f_flags & O_LARGEFILE)
>  		small = 0;

Why is the O_LARGEFILE handling not needed when used from io_uring?

