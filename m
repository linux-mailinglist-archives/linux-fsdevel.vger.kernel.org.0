Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B650545B78A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 10:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhKXJfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 04:35:55 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59762 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhKXJfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:35:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CB62A2195F;
        Wed, 24 Nov 2021 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637746364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/uW7MJN3rhPFVxkm32uMhoUslwYHeNCVx+tPrO2ACg=;
        b=dmH49AZCCae3gZ7D++2UKgwe8p2ozZgOZz3frfpjsglFBpCsy4bRFZxgl0Epxr2xU/dSb1
        YKCAjPL6atBSN2COy4mfLrogAz6BGY5rVJUARd+uoJzsBLhV9dbpC7tZjb9iDAS9uY+AhU
        UzjaYFIU0ANyIJni6CSEp2cclxVDcMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637746364;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/uW7MJN3rhPFVxkm32uMhoUslwYHeNCVx+tPrO2ACg=;
        b=qoXa/myQ7B9ruayouiIOM155q4YVoCmbwiCICNeU9d8fim90R0YBxAz7tjBJBOW79wnmMe
        vtPbvOvj2dlVd4CA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B2848A3B81;
        Wed, 24 Nov 2021 09:32:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A12881E1328; Wed, 24 Nov 2021 10:32:44 +0100 (CET)
Date:   Wed, 24 Nov 2021 10:32:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] aio: move aio sysctl to aio.c
Message-ID: <20211124093244.GE8583@quack2.suse.cz>
References: <20211123202347.818157-1-mcgrof@kernel.org>
 <20211123202347.818157-9-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123202347.818157-9-mcgrof@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 23-11-21 12:23:46, Luis Chamberlain wrote:
> From: Xiaoming Ni <nixiaoming@huawei.com>
> 
> The kernel/sysctl.c is a kitchen sink where everyone leaves
> their dirty dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to
> places where they actually belong. The proc sysctl maintainers
> do not want to know what sysctl knobs you wish to add for your own
> piece of code, we just care about the core logic.
> 
> Move aio sysctl to aio.c and use the new register_sysctl_init() to
> register the sysctl interface for aio.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> [mcgrof: adjust commit log to justify the move]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c            | 31 +++++++++++++++++++++++++++++--
>  include/linux/aio.h |  4 ----
>  kernel/sysctl.c     | 17 -----------------
>  3 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 9c81cf611d65..83ef2341e73f 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -219,9 +219,35 @@ struct aio_kiocb {
>  
>  /*------ sysctl variables----*/
>  static DEFINE_SPINLOCK(aio_nr_lock);
> -unsigned long aio_nr;		/* current system wide number of aio requests */
> -unsigned long aio_max_nr = 0x10000; /* system wide maximum number of aio requests */
> +static unsigned long aio_nr;		/* current system wide number of aio requests */
> +static unsigned long aio_max_nr = 0x10000; /* system wide maximum number of aio requests */
>  /*----end sysctl variables---*/
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table aio_sysctls[] = {
> +	{
> +		.procname	= "aio-nr",
> +		.data		= &aio_nr,
> +		.maxlen		= sizeof(aio_nr),
> +		.mode		= 0444,
> +		.proc_handler	= proc_doulongvec_minmax,
> +	},
> +	{
> +		.procname	= "aio-max-nr",
> +		.data		= &aio_max_nr,
> +		.maxlen		= sizeof(aio_max_nr),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +	},
> +	{}
> +};
> +
> +static void __init aio_sysctl_init(void)
> +{
> +	register_sysctl_init("fs", aio_sysctls);
> +}
> +#else
> +#define aio_sysctl_init() do { } while (0)
> +#endif
>  
>  static struct kmem_cache	*kiocb_cachep;
>  static struct kmem_cache	*kioctx_cachep;
> @@ -274,6 +300,7 @@ static int __init aio_setup(void)
>  
>  	kiocb_cachep = KMEM_CACHE(aio_kiocb, SLAB_HWCACHE_ALIGN|SLAB_PANIC);
>  	kioctx_cachep = KMEM_CACHE(kioctx,SLAB_HWCACHE_ALIGN|SLAB_PANIC);
> +	aio_sysctl_init();
>  	return 0;
>  }
>  __initcall(aio_setup);
> diff --git a/include/linux/aio.h b/include/linux/aio.h
> index b83e68dd006f..86892a4fe7c8 100644
> --- a/include/linux/aio.h
> +++ b/include/linux/aio.h
> @@ -20,8 +20,4 @@ static inline void kiocb_set_cancel_fn(struct kiocb *req,
>  				       kiocb_cancel_fn *cancel) { }
>  #endif /* CONFIG_AIO */
>  
> -/* for sysctl: */
> -extern unsigned long aio_nr;
> -extern unsigned long aio_max_nr;
> -
>  #endif /* __LINUX__AIO_H */
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 597ab5ad4879..20326d67b814 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -20,7 +20,6 @@
>   */
>  
>  #include <linux/module.h>
> -#include <linux/aio.h>
>  #include <linux/mm.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> @@ -3110,22 +3109,6 @@ static struct ctl_table fs_table[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif
> -#ifdef CONFIG_AIO
> -	{
> -		.procname	= "aio-nr",
> -		.data		= &aio_nr,
> -		.maxlen		= sizeof(aio_nr),
> -		.mode		= 0444,
> -		.proc_handler	= proc_doulongvec_minmax,
> -	},
> -	{
> -		.procname	= "aio-max-nr",
> -		.data		= &aio_max_nr,
> -		.maxlen		= sizeof(aio_max_nr),
> -		.mode		= 0644,
> -		.proc_handler	= proc_doulongvec_minmax,
> -	},
> -#endif /* CONFIG_AIO */
>  #ifdef CONFIG_INOTIFY_USER
>  	{
>  		.procname	= "inotify",
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
