Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0101B45B786
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 10:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbhKXJeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 04:34:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbhKXJel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C85212193C;
        Wed, 24 Nov 2021 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637746290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6j6LEDVSUwaLm4GecVClWhiFQf3A7yswpF/3Msy3S0=;
        b=HFH093Gq3HPtoLoK9FGfao01jmum3I5rgW5GdONDWqEEOQWszK0vySX+M2cn2GOFOySX43
        W4pSM8Im5x81IGFxxEM3Q0J+9qETV+e95fSLRsibzh8JUEdE36xyUGRIqU3fDYUC4LXThz
        YfbClVGA+r76WcY0fy4kC3jgaXMINVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637746290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6j6LEDVSUwaLm4GecVClWhiFQf3A7yswpF/3Msy3S0=;
        b=LBzm5GAXO4gI2fWlLRSZWlBA7gf34GlPuoguDlNScNkMCWvzcpqi7quohKoHpuV+Zy0IEu
        oiOOWDxHHjSuB8Aw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C442CA3B8C;
        Wed, 24 Nov 2021 09:31:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A14EC1E1328; Wed, 24 Nov 2021 10:31:29 +0100 (CET)
Date:   Wed, 24 Nov 2021 10:31:29 +0100
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
Subject: Re: [PATCH v2 9/9] dnotify: move dnotify sysctl to dnotify.c
Message-ID: <20211124093129.GD8583@quack2.suse.cz>
References: <20211123202347.818157-1-mcgrof@kernel.org>
 <20211123202347.818157-10-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123202347.818157-10-mcgrof@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 23-11-21 12:23:47, Luis Chamberlain wrote:
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
> So move dnotify sysctls to dnotify.c and use the new
> register_sysctl_init() to register the sysctl interface.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> [mcgrof: adjust the commit log to justify the move]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks sane. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/dnotify/dnotify.c | 21 ++++++++++++++++++++-
>  include/linux/dnotify.h     |  1 -
>  kernel/sysctl.c             | 10 ----------
>  3 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index e85e13c50d6d..2b04e2296fb6 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -19,7 +19,25 @@
>  #include <linux/fdtable.h>
>  #include <linux/fsnotify_backend.h>
>  
> -int dir_notify_enable __read_mostly = 1;
> +static int dir_notify_enable __read_mostly = 1;
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table dnotify_sysctls[] = {
> +	{
> +		.procname	= "dir-notify-enable",
> +		.data		= &dir_notify_enable,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +	{}
> +};
> +static void __init dnotify_sysctl_init(void)
> +{
> +	register_sysctl_init("fs", dnotify_sysctls);
> +}
> +#else
> +#define dnotify_sysctl_init() do { } while (0)
> +#endif
>  
>  static struct kmem_cache *dnotify_struct_cache __read_mostly;
>  static struct kmem_cache *dnotify_mark_cache __read_mostly;
> @@ -386,6 +404,7 @@ static int __init dnotify_init(void)
>  	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops);
>  	if (IS_ERR(dnotify_group))
>  		panic("unable to allocate fsnotify group for dnotify\n");
> +	dnotify_sysctl_init();
>  	return 0;
>  }
>  
> diff --git a/include/linux/dnotify.h b/include/linux/dnotify.h
> index 0aad774beaec..4f3b25d47436 100644
> --- a/include/linux/dnotify.h
> +++ b/include/linux/dnotify.h
> @@ -29,7 +29,6 @@ struct dnotify_struct {
>  			    FS_CREATE | FS_DN_RENAME |\
>  			    FS_MOVED_FROM | FS_MOVED_TO)
>  
> -extern int dir_notify_enable;
>  extern void dnotify_flush(struct file *, fl_owner_t);
>  extern int fcntl_dirnotify(int, struct file *, unsigned long);
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 20326d67b814..7a90a12b9ea4 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -48,7 +48,6 @@
>  #include <linux/times.h>
>  #include <linux/limits.h>
>  #include <linux/dcache.h>
> -#include <linux/dnotify.h>
>  #include <linux/syscalls.h>
>  #include <linux/vmstat.h>
>  #include <linux/nfs_fs.h>
> @@ -3090,15 +3089,6 @@ static struct ctl_table fs_table[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif
> -#ifdef CONFIG_DNOTIFY
> -	{
> -		.procname	= "dir-notify-enable",
> -		.data		= &dir_notify_enable,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
> -#endif
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_FILE_LOCKING
>  	{
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
