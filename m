Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27EF293E9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408020AbgJTO0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 10:26:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47990 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407899AbgJTO0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:26:34 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kUsau-0000Dv-Ju; Tue, 20 Oct 2020 14:26:32 +0000
Date:   Tue, 20 Oct 2020 16:26:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux@rasmusvillemoes.dk,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Message-ID: <20201020142632.7wllfigtfgqzoou4@wittgenstein>
References: <20201019102654.16642-1-gscrivan@redhat.com>
 <20201019102654.16642-2-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019102654.16642-2-gscrivan@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:26:53PM +0200, Giuseppe Scrivano wrote:
> When the flag CLOSE_RANGE_CLOEXEC is set, close_range doesn't
> immediately close the files but it sets the close-on-exec bit.
> 
> It is useful for e.g. container runtimes that usually install a
> seccomp profile "as late as possible" before execv'ing the container
> process itself.  The container runtime could either do:
>   1                                  2
> - install_seccomp_profile();       - close_range(MIN_FD, MAX_INT, 0);
> - close_range(MIN_FD, MAX_INT, 0); - install_seccomp_profile();
> - execve(...);                     - execve(...);
> 
> Both alternative have some disadvantages.
> 
> In the first variant the seccomp_profile cannot block the close_range
> syscall, as well as opendir/read/close/... for the fallback on older
> kernels).
> In the second variant, close_range() can be used only on the fds
> that are not going to be needed by the runtime anymore, and it must be
> potentially called multiple times to account for the different ranges
> that must be closed.
> 
> Using close_range(..., ..., CLOSE_RANGE_CLOEXEC) solves these issues.
> The runtime is able to use the open fds and the seccomp profile could
> block close_range() and the syscalls used for its fallback.

I see, so you want those fds to be closed after exec but still use them
before. Yeah, this is a good use-case. (I proposed this extension quite a
while ago when we started discussing this syscall. Thanks for working
ont this!)

> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  fs/file.c                        | 44 ++++++++++++++++++++++++--------
>  include/uapi/linux/close_range.h |  3 +++
>  2 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 21c0893f2f1d..0295d4f7c5ef 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -672,6 +672,35 @@ int __close_fd(struct files_struct *files, unsigned fd)
>  }
>  EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
>  
> +static inline void __range_cloexec(struct files_struct *cur_fds,
> +				   unsigned int fd, unsigned int max_fd)
> +{
> +	struct fdtable *fdt;
> +
> +        if (fd > max_fd)
> +		return;

Looks like formatting issues here.

> +
> +	spin_lock(&cur_fds->file_lock);
> +	fdt = files_fdtable(cur_fds);
> +	bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);

I think that this is ok and that there's no reason to make this anymore
complex unless we somehow really see performance issues which I doubt.

If Al is ok with doing it this way and doesn't see any obvious issues
I'll be taking this for some testing and would come back to ack this and
pick it up.

> +	spin_unlock(&cur_fds->file_lock);
> +}
> +
> +static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
> +				 unsigned int max_fd)
> +{
> +	while (fd <= max_fd) {
> +		struct file *file;
> +
> +		file = pick_file(cur_fds, fd++);
> +		if (!file)
> +			continue;
> +
> +		filp_close(file, cur_fds);
> +		cond_resched();
> +	}
> +}
> +
>  /**
>   * __close_range() - Close all file descriptors in a given range.
>   *
> @@ -687,7 +716,7 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>  	struct task_struct *me = current;
>  	struct files_struct *cur_fds = me->files, *fds = NULL;
>  
> -	if (flags & ~CLOSE_RANGE_UNSHARE)
> +	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC))
>  		return -EINVAL;
>  
>  	if (fd > max_fd)
> @@ -725,16 +754,11 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>  	}
>  
>  	max_fd = min(max_fd, cur_max);
> -	while (fd <= max_fd) {
> -		struct file *file;
>  
> -		file = pick_file(cur_fds, fd++);
> -		if (!file)
> -			continue;
> -
> -		filp_close(file, cur_fds);
> -		cond_resched();
> -	}
> +	if (flags & CLOSE_RANGE_CLOEXEC)
> +		__range_cloexec(cur_fds, fd, max_fd);
> +	else
> +		__range_close(cur_fds, fd, max_fd);
>  
>  	if (fds) {
>  		/*
> diff --git a/include/uapi/linux/close_range.h b/include/uapi/linux/close_range.h
> index 6928a9fdee3c..2d804281554c 100644
> --- a/include/uapi/linux/close_range.h
> +++ b/include/uapi/linux/close_range.h
> @@ -5,5 +5,8 @@
>  /* Unshare the file descriptor table before closing file descriptors. */
>  #define CLOSE_RANGE_UNSHARE	(1U << 1)
>  
> +/* Set the FD_CLOEXEC bit instead of closing the file descriptor. */
> +#define CLOSE_RANGE_CLOEXEC	(1U << 2)
> +
>  #endif /* _UAPI_LINUX_CLOSE_RANGE_H */
>  
> -- 
> 2.26.2
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
