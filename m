Return-Path: <linux-fsdevel+bounces-69772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26BC84B5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98A95350B8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37F13195FB;
	Tue, 25 Nov 2025 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOzq5buA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA83191C6
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069676; cv=none; b=eHimm4LvYYwa33BdSPqHz4HQ0Q+0YbtB0xinBe3vkWewuIg986bgP0++J70+U9f3pL1J2uO7NDCknRZjPdZF9As4yHewK6V3OOg6ZiRh0zM0QjJCee64U/lxsD3ytwkVMgIGC1MLl5QRpNZ63EKPZj4NCiDPxDsBQzlsfTMbDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069676; c=relaxed/simple;
	bh=sT8+WSdwq6DIj/VaEmw4QXMSgNyNWcLIdcmky0KxLOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i038xdpTpQhFWIzs9fqFibHnAevgPdz+9wJv/plZtrdQruvRLBZFCWvy3l1Z2QJU2OCedlM9J/fggN4dLzMiGjkk+HCLmsz/El6f1rN1iqormUQCiCR3QGRjsT+tHzyw18gSm7r8yK2lEAxGXATrONlfVI7XiashOdA/+v2CUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOzq5buA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73C9C4CEF1;
	Tue, 25 Nov 2025 11:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764069675;
	bh=sT8+WSdwq6DIj/VaEmw4QXMSgNyNWcLIdcmky0KxLOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOzq5buAx1IsTpu1XP0LYuyHt1MgcYFBfcV6kO1RBQHRIJx0H4hHk3lxfgp66WwSL
	 br09Zy5WZIS+KlJVM9AHY1WOujDxO1nNyucvEfLj6FVnuB26vhM3F4TENerTbYQmyP
	 Tb4f8QoeAFWp6A9Vh25f+7aVD9HKS5gsvQRxzhZ1GUXGKqh3AATMjnY4S/HNCH/xSk
	 0j9GBJ7VnsSQw/Z1Z23ZENcOKxYrNOynSpdDL/IlGFFDaSIvd4BeeAFJ7CpGczyZN1
	 9M+lbMgDAhoWGv4qvTvqLFMi9ibCQFxrTz56S4hS5Hv9feMyDoRqwBhEaNqpUd2jfJ
	 MlNS8fOpJN3CA==
Date: Tue, 25 Nov 2025 13:21:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 26/47] secretmem: convert memfd_secret() to
 FD_PREPARE()
Message-ID: <aSWRJa_1kTNuQa6g@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-26-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-26-b6efa1706cfd@kernel.org>

On Sun, Nov 23, 2025 at 05:33:44PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/secretmem.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 60137305bc20..eb950f8193c9 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -224,9 +224,6 @@ static struct file *secretmem_file_create(unsigned long flags)
>  
>  SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>  {
> -	struct file *file;
> -	int fd, err;
> -
>  	/* make sure local flags do not confict with global fcntl.h */
>  	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
>  
> @@ -238,22 +235,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>  	if (atomic_read(&secretmem_users) < 0)
>  		return -ENFILE;
>  
> -	fd = get_unused_fd_flags(flags & O_CLOEXEC);
> -	if (fd < 0)
> -		return fd;
> -
> -	file = secretmem_file_create(flags);
> -	if (IS_ERR(file)) {
> -		err = PTR_ERR(file);
> -		goto err_put_fd;
> -	}
> -
> -	fd_install(fd, file);
> -	return fd;
> -
> -err_put_fd:
> -	put_unused_fd(fd);
> -	return err;
> +	return FD_ADD(flags & O_CLOEXEC, secretmem_file_create(flags));
>  }
>  
>  static int secretmem_init_fs_context(struct fs_context *fc)
> 
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

