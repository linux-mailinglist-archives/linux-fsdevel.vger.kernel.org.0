Return-Path: <linux-fsdevel+bounces-59622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565CBB3B4BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79823BD9E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7A2853FD;
	Fri, 29 Aug 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+0UgLMf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8E10F2;
	Fri, 29 Aug 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453968; cv=none; b=X48Vx8zIUNjyrLA6RoWmTfozxCDJcX4288gRQIEMdgwixxjGWHhrmoa9/g/zBY75FYn6iTxpI2zXZu6fp9SFq0zrx0d7VSz7nc92VbOfkRteAcgdk02oG0AeoWdlfJJb3IG1rNA2poGEUhyLQneAgvPTKdyW0IrSAarJrHafCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453968; c=relaxed/simple;
	bh=XKKh6vmQgZrVGvhfLYWocD5neq7EDN5bw78C/kveJDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9PnJHvDky2jrwdh15ETToSXiK1aRdTkbOCn08Oso2Q+LwJcQBF6ge+PCNkFEN6UyiUuW8T8Ml7E8zR2ftkOt9Lr2034atfIrYUb9JEVERMdEdrllEzvF+xA2RoebEMgECmKIllrrLHFE9T9jsbV+UzkDCCl3qV4QnEkyJJsZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+0UgLMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EBFC4CEF4;
	Fri, 29 Aug 2025 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756453968;
	bh=XKKh6vmQgZrVGvhfLYWocD5neq7EDN5bw78C/kveJDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+0UgLMf8A/MhicYpFluTzvfDXIhzs3533ihd8NFYrDTfrcZwAeYMq134XMHM/WKa
	 fOUiINoT9Et2zYbr1R1BPsH6JA4FOuEiM/XSRyOKJMJsQWb/87YNGWe8CRKoo4ZVGk
	 yv2yxMJvbMdiJ/gJzd0xIGqnRP14E49g4wkSPlgRqsrv6zQnZ2sTld+vahFusM1JHq
	 BIqxQCiBaUN7RQkxN9gIb+ZsJUW3pPf3u3fw7SbSyr+RQ3/Cr9xKrP0PYHdUv72vo3
	 +yyXhiv040MCzO94z66tGo0qvbC2LBrlxB42FW4tMltjlq5UHDdLqsKhBDL/5CChaR
	 QTWIkDJ4b62Sg==
Date: Fri, 29 Aug 2025 09:52:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lauri Vasama <git@vasama.org>, Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] Add RWF_NOSIGNAL flag for pwritev2
Message-ID: <20250829-kiesel-bruder-313d38b294b8@brauner>
References: <20250827133901.1820771-1-git@vasama.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827133901.1820771-1-git@vasama.org>

On Wed, Aug 27, 2025 at 04:39:00PM +0300, Lauri Vasama wrote:
> For a user mode library to avoid generating SIGPIPE signals (e.g.
> because this behaviour is not portable across operating systems) is
> cumbersome. It is generally bad form to change the process-wide signal
> mask in a library, so a local solution is needed instead.
> 
> For I/O performed directly using system calls (synchronous or readiness
> based asynchronous) this currently involves applying a thread-specific
> signal mask before the operation and reverting it afterwards. This can be
> avoided when it is known that the file descriptor refers to neither a
> pipe nor a socket, but a conservative implementation must always apply
> the mask. This incurs the cost of two additional system calls. In the
> case of sockets, the existing MSG_NOSIGNAL flag can be used with send.
> 
> For asynchronous I/O performed using io_uring, currently the only option
> (apart from MSG_NOSIGNAL for sockets), is to mask SIGPIPE entirely in the
> call to io_uring_enter. Thankfully io_uring_enter takes a signal mask, so
> only a single syscall is needed. However, copying the signal mask on
> every call incurs a non-zero performance penalty. Furthermore, this mask
> applies to all completions, meaning that if the non-signaling behaviour
> is desired only for some subset of operations, the desired signals must
> be raised manually from user-mode depending on the completed operation.
> 
> Add RWF_NOSIGNAL flag for pwritev2. This flag prevents the SIGPIPE signal
> from being raised when writing on disconnected pipes or sockets. The flag
> is handled directly by the pipe filesystem and converted to the existing
> MSG_NOSIGNAL flag for sockets.
> 
> Signed-off-by: Lauri Vasama <git@vasama.org>
> ---

So this makes sense to me.
I'll wait for @Jens to chime in, too, before I apply it.

>  fs/pipe.c               | 6 ++++--
>  include/linux/fs.h      | 1 +
>  include/uapi/linux/fs.h | 5 ++++-
>  net/socket.c            | 3 +++
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 731622d0738d..42fead1efe52 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -458,7 +458,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  	mutex_lock(&pipe->mutex);
>  
>  	if (!pipe->readers) {
> -		send_sig(SIGPIPE, current, 0);
> +		if ((iocb->ki_flags & IOCB_NOSIGNAL) == 0)
> +			send_sig(SIGPIPE, current, 0);
>  		ret = -EPIPE;
>  		goto out;
>  	}
> @@ -498,7 +499,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  
>  	for (;;) {
>  		if (!pipe->readers) {
> -			send_sig(SIGPIPE, current, 0);
> +			if ((iocb->ki_flags & IOCB_NOSIGNAL) == 0)
> +				send_sig(SIGPIPE, current, 0);
>  			if (!ret)
>  				ret = -EPIPE;
>  			break;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7ab4f96d705..e440c5ae5d99 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -356,6 +356,7 @@ struct readahead_control;
>  #define IOCB_APPEND		(__force int) RWF_APPEND
>  #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
>  #define IOCB_DONTCACHE		(__force int) RWF_DONTCACHE
> +#define IOCB_NOSIGNAL		(__force int) RWF_NOSIGNAL
>  
>  /* non-RWF related bits - start at 16 */
>  #define IOCB_EVENTFD		(1 << 16)
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 0bd678a4a10e..beb4c2d1e41c 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -430,10 +430,13 @@ typedef int __bitwise __kernel_rwf_t;
>  /* buffered IO that drops the cache after reading or writing data */
>  #define RWF_DONTCACHE	((__force __kernel_rwf_t)0x00000080)
>  
> +/* prevent pipe and socket writes from raising SIGPIPE */
> +#define RWF_NOSIGNAL	((__force __kernel_rwf_t)0x00000100)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>  			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
> -			 RWF_DONTCACHE)
> +			 RWF_DONTCACHE | RWF_NOSIGNAL)
>  
>  #define PROCFS_IOCTL_MAGIC 'f'
>  
> diff --git a/net/socket.c b/net/socket.c
> index 682969deaed3..bac335ecee4c 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1176,6 +1176,9 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (sock->type == SOCK_SEQPACKET)
>  		msg.msg_flags |= MSG_EOR;
>  
> +	if (iocb->ki_flags & IOCB_NOSIGNAL)
> +		msg.msg_flags |= MSG_NOSIGNAL;
> +
>  	res = __sock_sendmsg(sock, &msg);
>  	*from = msg.msg_iter;
>  	return res;
> 
> base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
> -- 
> 2.43.0
> 

