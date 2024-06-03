Return-Path: <linux-fsdevel+bounces-20832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA728D847B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF151C224CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE312DDB3;
	Mon,  3 Jun 2024 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG0rmC6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4F12DD9F
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423005; cv=none; b=GMC6W9V8q5+0qv01w1RiWXg1W9zlRzwyJ6d+bz/zvQtzNZ2JBk/LzZoQ86/1DIXtBLdUfERP155aWN2VwAQli0VAluCUG3iZf3X0+WhCiqhl9NE6pECPdSMjM8iT9B4/xp1srXxhQPGoOU0IVevAgpf1HmSkkMS0D89uBqdp99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423005; c=relaxed/simple;
	bh=eoXoJIXMQYzDNyedyplY1qFrKgHLm1khvEKgzmUux4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7O+9UV5pzvVF5kUAaBATtT5RbJD10UIuw20QEsbzrAuceYTYd8ACFc91tERz4VNgQ1LVJ6UKIBytyU6q8VwC9kZHdfa6zGNG2235NS/1k7SgkALszgt4IIqRJ1rnNxH3xoJ5U8VY/Aqj47Z5YtOvA/atU7MjXg32WWn0ErSRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG0rmC6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D42C2BD10;
	Mon,  3 Jun 2024 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717423004;
	bh=eoXoJIXMQYzDNyedyplY1qFrKgHLm1khvEKgzmUux4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IG0rmC6JlVMvwhPV4tMmwvlOBk6rXEyP7fwWTKVHCaA3AAG4pB1tS3QgaOLsGPYFm
	 PiL8P11hNdbA7i9ikCeQPiQW2sYbLic6r60NX+Fl5NPp5Sgg+rYkZp/MxDqhW3gG8n
	 j5JzCyAEbIzCRodxnlgrhXdo66Qb39Q2n6wWNUsFY24BZL3UImZElTNiqjFckG0oCI
	 Cfn7qFHwlMzvLNiZSxV2xrdn5o2S8U1fVHjQ8def/2sSDqTevZLWRsphUVHVlHbMW2
	 f0FyjIF9i1NupRbAMfi9xWn9IupPu9BKv8stLaE3j7QeuDgKrtwbHMYsvzJ2SW8Uw/
	 N9aW2DzJkHUGQ==
Date: Mon, 3 Jun 2024 15:56:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] move close_range(2) into fs/file.c, fold
 __close_range() into it
Message-ID: <20240603-fallpauschalen-abmahnung-96be1cf0063c@brauner>
References: <20240602204238.GD1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240602204238.GD1629371@ZenIV>

On Sun, Jun 02, 2024 at 09:42:38PM +0100, Al Viro wrote:
> 	We never had callers for __close_range() except for close_range(2)
> itself.  Nothing of that sort has appeared in four years and if any users
> do show up, we can always separate those suckers again.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Note, that the __close_range() solely existed (iirc) because want
close(2) and close_range(2) shouldn't end up in two separate files
because it is royally annoying to have to switch files for system calls
that conceptually do very similar things.

But I don't care enough so,
Reviewed-by: Christian Brauner <brauner@kernel.org>

> diff --git a/fs/file.c b/fs/file.c
> index 8076aef9c210..f9fcebc7c838 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -732,7 +732,7 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
>  }
>  
>  /**
> - * __close_range() - Close all file descriptors in a given range.
> + * sys_close_range() - Close all file descriptors in a given range.
>   *
>   * @fd:     starting file descriptor to close
>   * @max_fd: last file descriptor to close
> @@ -740,8 +740,10 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
>   *
>   * This closes a range of file descriptors. All file descriptors
>   * from @fd up to and including @max_fd are closed.
> + * Currently, errors to close a given file descriptor are ignored.
>   */
> -int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
> +SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
> +		unsigned int, flags)
>  {
>  	struct task_struct *me = current;
>  	struct files_struct *cur_fds = me->files, *fds = NULL;
> diff --git a/fs/open.c b/fs/open.c
> index 89cafb572061..7ee11c4de4ca 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1564,23 +1564,6 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
>  	return retval;
>  }
>  
> -/**
> - * sys_close_range() - Close all file descriptors in a given range.
> - *
> - * @fd:     starting file descriptor to close
> - * @max_fd: last file descriptor to close
> - * @flags:  reserved for future extensions
> - *
> - * This closes a range of file descriptors. All file descriptors
> - * from @fd up to and including @max_fd are closed.
> - * Currently, errors to close a given file descriptor are ignored.
> - */
> -SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
> -		unsigned int, flags)
> -{
> -	return __close_range(fd, max_fd, flags);
> -}
> -
>  /*
>   * This routine simulates a hangup on the tty, to arrange that users
>   * are given clean terminals at login time.
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index 2944d4aa413b..4e7d1bcca5b7 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -113,7 +113,6 @@ int iterate_fd(struct files_struct *, unsigned,
>  		const void *);
>  
>  extern int close_fd(unsigned int fd);
> -extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
>  extern struct file *file_close_fd(unsigned int fd);
>  extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
>  		      struct files_struct **new_fdp);

