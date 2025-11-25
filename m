Return-Path: <linux-fsdevel+bounces-69775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960AC84BD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B4FD3500F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D828626C39E;
	Tue, 25 Nov 2025 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDZo0Njf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7AB225775
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070218; cv=none; b=hsg7exJvneOjSCAg9NHNIsh7dzqvvAc6uyt5MGM34yk7uqKY2sCmfEEuxJpq2nCcCfsAUtDDLWomPN8tMFsfOgKTbg78QY6QO23C+bkziGck0UXs9tenS3MmBnJR6H0tI+JRiQ0PEmea81aHtf/+ZstzdxvgTQuTCyrew4gC4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070218; c=relaxed/simple;
	bh=zQxI42St1bE6QaY4Pmo6/wGCPv1ZmadJzXGAAcfsnWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKQjKs+Dq1kfhAl1LqFGJECcI4img06M7VmQgrWHEs1naOHOL/y78L64MnD32voQVw0AeOqrsg26sS2AYdpSnj4CuQTsTNaF79LlTL4uhOH4fpql2H6kEtuWSOIDxVH8IQiEtdTKfmRgvUrl023oUxaxLVH3AQ3lwJi4w9SyBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDZo0Njf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27C7C4CEF1;
	Tue, 25 Nov 2025 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764070217;
	bh=zQxI42St1bE6QaY4Pmo6/wGCPv1ZmadJzXGAAcfsnWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDZo0NjffN2g3RSj+kxcCn9yWxR6QZSwU17zZiHX7EQ3Lue9a2UHy7n2cgXi5p54/
	 0j3yLuZ81uwhXiVh/J2/BEqb2KyOwC0CNDvMX+j/YtTkdpZp7z0AhVsHcw/dfwZP8v
	 fyyXxLlqb8TzCcwolQfHTDo3mxClK26SVPxWXx7i0cLBwqSF24bitnydW9n+myKno4
	 qTjFlEBBOmS0BRuFVTLCQCh61aT29dM2fXu5MOf2nFzt4y+fu3EI3Dzs4+hQGihZOe
	 DD33sOE+97zuLEZewi/tFQ8Xf0sZhxq0Gw/1ASYMqfAUZYc5lR7LoyF8FdM22HCfCK
	 IPjnEFm5URx3g==
Date: Tue, 25 Nov 2025 13:30:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 25/47] memfd: convert memfd_create() to FD_PREPARE()
Message-ID: <aSWTQzMj7MpjdiFB@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-25-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-25-b6efa1706cfd@kernel.org>

On Sun, Nov 23, 2025 at 05:33:43PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/memfd.c | 29 +++++------------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 1d109c1acf21..2a6614b7c4ea 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -470,9 +470,9 @@ SYSCALL_DEFINE2(memfd_create,
>  		const char __user *, uname,
>  		unsigned int, flags)
>  {
> -	struct file *file;
> -	int fd, error;
> -	char *name;
> +	char *name __free(kfree) = NULL;
> +	unsigned int fd_flags;
> +	int error;
>  
>  	error = sanitize_flags(&flags);
>  	if (error < 0)
> @@ -482,25 +482,6 @@ SYSCALL_DEFINE2(memfd_create,
>  	if (IS_ERR(name))
>  		return PTR_ERR(name);
>  
> -	fd = get_unused_fd_flags((flags & MFD_CLOEXEC) ? O_CLOEXEC : 0);
> -	if (fd < 0) {
> -		error = fd;
> -		goto err_free_name;
> -	}
> -
> -	file = alloc_file(name, flags);
> -	if (IS_ERR(file)) {
> -		error = PTR_ERR(file);
> -		goto err_free_fd;
> -	}
> -
> -	fd_install(fd, file);
> -	kfree(name);
> -	return fd;
> -
> -err_free_fd:
> -	put_unused_fd(fd);
> -err_free_name:
> -	kfree(name);
> -	return error;
> +	fd_flags = (flags & MFD_CLOEXEC) ? O_CLOEXEC : 0;
> +	return FD_ADD(fd_flags, alloc_file(name, flags));
>  }
> 
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

