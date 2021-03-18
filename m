Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA6834064A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 14:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhCRNEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhCRNEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:04:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9FC06174A;
        Thu, 18 Mar 2021 06:04:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616072642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUo0pnrIu4/NM6F8XGKwZ513P9YRR38qmO59HlUlp4A=;
        b=0GW4AlhVwH9khxUuWMHyt2hyBp30Ar34eL59LcHtIpBsIVViPP3QLkJ9GPogTEYQtyNvIz
        wgb4MgvnHrV6hz4jFFksz08cu/+dTP64bgylMNE00zU1fglgYi7px3n7A6kMhv/kkyvL3u
        TvG5+LYN/Sv+Z5xUKvlYRl9my2z14MoxWmX+D5gnkXro4ceOamt2Owt/kYzleEoAPVYqDE
        pthAPgqaaaNwKx+ZKdiGGzV8AdpFblAGYHCIj/X+B0R30dg+81Ls2JUJb1I+79zMzkh/xy
        E+0xByLpxPAgwlG8ienWrxkig6b+9feXV1bZZfVrmOB05NVzgbzke9i6EL9uAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616072642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUo0pnrIu4/NM6F8XGKwZ513P9YRR38qmO59HlUlp4A=;
        b=a8iJDDRx0fVVMC/k6hbMWyyG0Dy9NcWQ+m5802FVaXT7BJGRkwYF6TOFTUP2PA0iS1vphp
        Z5J4Zs2vX5z8x7Dw==
To:     Manish Varma <varmam@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manish Varma <varmam@google.com>,
        Kelly Rossmoyer <krossmo@google.com>
Subject: Re: [PATCH] fs: Improve eventpoll logging to stop indicting timerfd
In-Reply-To: <20210302034928.3761098-1-varmam@google.com>
References: <20210302034928.3761098-1-varmam@google.com>
Date:   Thu, 18 Mar 2021 14:04:01 +0100
Message-ID: <87pmzw7gvy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Manish,

On Mon, Mar 01 2021 at 19:49, Manish Varma wrote:

> All together, that will give us names like the following:
>
> 1) timerfd file descriptor: [timerfd14:system_server]
> 2) eventpoll top-level per-process wakesource: epoll:system_server
> 3) eventpoll-on-timerfd per-descriptor wakesource:
> epollitem:system_server.[timerfd14:system_server]

All together that should be splitted up into a change to eventpoll and
timerfd.

> diff --git a/fs/timerfd.c b/fs/timerfd.c
> index c5509d2448e3..4249e8c9a38c 100644
> --- a/fs/timerfd.c
> +++ b/fs/timerfd.c
> @@ -46,6 +46,8 @@ struct timerfd_ctx {
>  	bool might_cancel;
>  };
>  
> +static atomic_t instance_count = ATOMIC_INIT(0);

instance_count is misleading as it does not do any accounting of
instances as the name suggests.

>  static LIST_HEAD(cancel_list);
>  static DEFINE_SPINLOCK(cancel_lock);
>  
> @@ -391,6 +393,9 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
>  {
>  	int ufd;
>  	struct timerfd_ctx *ctx;
> +	char task_comm_buf[sizeof(current->comm)];
> +	char file_name_buf[32];
> +	int instance;
>  
>  	/* Check the TFD_* constants for consistency.  */
>  	BUILD_BUG_ON(TFD_CLOEXEC != O_CLOEXEC);
> @@ -427,7 +432,11 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
>  
>  	ctx->moffs = ktime_mono_to_real(0);
>  
> -	ufd = anon_inode_getfd("[timerfd]", &timerfd_fops, ctx,
> +	instance = atomic_inc_return(&instance_count);
> +	get_task_comm(task_comm_buf, current);

How is current->comm supposed to be unique? And with a wrapping counter
like the above you can end up with identical file descriptor names.

What's wrong with simply using the PID which is guaranteed to be unique
for the life time of a process/task?

> +	snprintf(file_name_buf, sizeof(file_name_buf), "[timerfd%d:%s]",
> +		 instance, task_comm_buf);
> +	ufd = anon_inode_getfd(file_name_buf, &timerfd_fops, ctx,
>  			       O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
>  	if (ufd < 0)
>  		kfree(ctx);

I actually wonder, whether this should be part of anon_inode_get*().

Aside of that this is a user space visible change both for eventpoll and
timerfd.

Have you carefully investigated whether there is existing user space
which might depend on the existing naming conventions?

The changelog is silent about this...

Thanks,

        tglx
