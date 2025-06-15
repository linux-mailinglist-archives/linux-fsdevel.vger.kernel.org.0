Return-Path: <linux-fsdevel+bounces-51692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCBAADA42A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 23:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C11916D6D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F817A2E3;
	Sun, 15 Jun 2025 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tYyptyTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB32E11CF
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750023971; cv=none; b=Qq8cNEsnlY0wEaIP+NuMrBQTex/TPPj72GAG+1f6qUuuNNoLg+tGayXyz6tYeiQgM0SjSvfYgV3lu/kH+ctaZQqCd/3FjL6lzjypOomQXw98BS58oVwLJ1dONzJ/R7slhKLAdivZzx2yAA0Yhbt7pGHTsXf8sbsXpvEmx4WjXHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750023971; c=relaxed/simple;
	bh=MESuP3iFWRLD+gb+seZ7E0vCR9GURSRghvyHCvk538M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m1KvrYbxHH0RNYBEIFRy1RZRfzAP/fbTHSo53gJ2cosWdIOL5z2Brc3U6Hiy/AamA8+fgEjECy3PqLDBZcW9Gx5zrKfRPY7aqFogHff7phMK+oPysEduCN5RWc1F00wHAWXdv2AwtYja8XaYaS51SJ8I/wwMNv2nIl+uad5b9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tYyptyTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DF1C4CEE3;
	Sun, 15 Jun 2025 21:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750023971;
	bh=MESuP3iFWRLD+gb+seZ7E0vCR9GURSRghvyHCvk538M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tYyptyTx1HN7c9yiNpdUIc/bjZtYMKtb//wv4moYOuY0o6nQp5QAAZ5BcxBbkSynV
	 OK3GENS1i3uRgsnF8jUOCEUCxPbmHSpAW4eR30D41Rj71ho8vvxMLIXEkZg1kXUt37
	 bD+33WR3qYtb3uA6bNdksDNIFb3uunF0TWWxOl9Q=
Date: Sun, 15 Jun 2025 14:46:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] secretmem: move setting O_LARGEFILE and bumping users'
 count to the place where we create the file
Message-Id: <20250615144610.49c561aebe464f617a262343@linux-foundation.org>
In-Reply-To: <20250615003507.GD3011112@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
	<20250615003110.GA3011112@ZenIV>
	<20250615003216.GB3011112@ZenIV>
	<20250615003321.GC3011112@ZenIV>
	<20250615003507.GD3011112@ZenIV>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Jun 2025 01:35:07 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:

> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]

(cc Mike)

> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -208,7 +208,7 @@ static struct file *secretmem_file_create(unsigned long flags)
>  	}
>  
>  	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
> -				 O_RDWR, &secretmem_fops);
> +				 O_RDWR | O_LARGEFILE, &secretmem_fops);
>  	if (IS_ERR(file))
>  		goto err_free_inode;
>  
> @@ -222,6 +222,8 @@ static struct file *secretmem_file_create(unsigned long flags)
>  	inode->i_mode |= S_IFREG;
>  	inode->i_size = 0;
>  
> +	atomic_inc(&secretmem_users);
> +
>  	return file;
>  
>  err_free_inode:
> @@ -255,9 +257,6 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>  		goto err_put_fd;
>  	}
>  
> -	file->f_flags |= O_LARGEFILE;
> -
> -	atomic_inc(&secretmem_users);
>  	fd_install(fd, file);
>  	return fd;
>  

Acked-by: Andrew Morton <akpm@linux-foundation.org>

Please retain this in the vfs tree.

