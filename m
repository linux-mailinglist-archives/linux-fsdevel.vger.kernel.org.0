Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B53F45B7AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 10:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhKXJrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 04:47:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60648 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhKXJrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:47:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 57BF02193C;
        Wed, 24 Nov 2021 09:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637747050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xjctS9e3aLk//fWwNzII/UY4G5OnovggWZdyEKD1t34=;
        b=Fa3DfqPoxkPRyFtLFipUAPsRoQ7583RIvIkjGcirn+ZDIVuZJxTkgHZCWQWJkaYcgx/XTF
        6Tg+qvMREmzgGwP+y0PqF0I8yljZj0emBD/1N75E2fyVfhSwuHdlW27Cq87y3T4+dKDpTg
        m3CDIAdfVxCay7j/D++92R/TIMACYbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637747050;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xjctS9e3aLk//fWwNzII/UY4G5OnovggWZdyEKD1t34=;
        b=jBk0LyCfiE1g4jR+z/f8PsVbXLRirmoGyBWY3eutEhQ8eC54ZtfGnQdZjQkRNSqRSaajn0
        YL6WjUHTxaO0ZHAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A4AA0A3B8E;
        Wed, 24 Nov 2021 09:44:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 844E41E14AC; Wed, 24 Nov 2021 10:44:09 +0100 (CET)
Date:   Wed, 24 Nov 2021 10:44:09 +0100
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        clemens@ladisch.de, arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, benh@kernel.crashing.org, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, jack@suse.cz,
        amir73il@gmail.com, phil@philpotter.co.uk, viro@zeniv.linux.org.uk,
        julia.lawall@inria.fr, ocfs2-devel@oss.oracle.com,
        linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] inotify: simplify subdirectory registration with
 register_sysctl()
Message-ID: <20211124094409.GF8583@quack2.suse.cz>
References: <20211123202422.819032-1-mcgrof@kernel.org>
 <20211123202422.819032-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123202422.819032-7-mcgrof@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 23-11-21 12:24:20, Luis Chamberlain wrote:
> From: Xiaoming Ni <nixiaoming@huawei.com>
> 
> There is no need to user boiler plate code to specify a set of base
> directories we're going to stuff sysctls under. Simplify this by using
> register_sysctl() and specifying the directory path directly.
> 
> Move inotify_user sysctl to inotify_user.c while at it to remove clutter
> from kernel/sysctl.c.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> [mcgrof: update commit log to reflect new path we decided to take]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

This looks fishy. You register inotify_table but not fanotify_table and
remove both...

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 11 ++++++++++-
>  include/linux/inotify.h          |  3 ---
>  kernel/sysctl.c                  | 21 ---------------------
>  3 files changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 29fca3284bb5..54583f62dc44 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -58,7 +58,7 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
>  static long it_zero = 0;
>  static long it_int_max = INT_MAX;
>  
> -struct ctl_table inotify_table[] = {
> +static struct ctl_table inotify_table[] = {
>  	{
>  		.procname	= "max_user_instances",
>  		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
> @@ -87,6 +87,14 @@ struct ctl_table inotify_table[] = {
>  	},
>  	{ }
>  };
> +
> +static void __init inotify_sysctls_init(void)
> +{
> +	register_sysctl("fs/inotify", inotify_table);
> +}
> +
> +#else
> +#define inotify_sysctls_init() do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>  
>  static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
> @@ -849,6 +857,7 @@ static int __init inotify_user_setup(void)
>  	inotify_max_queued_events = 16384;
>  	init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
>  	init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = watches_max;
> +	inotify_sysctls_init();
>  
>  	return 0;
>  }
> diff --git a/include/linux/inotify.h b/include/linux/inotify.h
> index 6a24905f6e1e..8d20caa1b268 100644
> --- a/include/linux/inotify.h
> +++ b/include/linux/inotify.h
> @@ -7,11 +7,8 @@
>  #ifndef _LINUX_INOTIFY_H
>  #define _LINUX_INOTIFY_H
>  
> -#include <linux/sysctl.h>
>  #include <uapi/linux/inotify.h>
>  
> -extern struct ctl_table inotify_table[]; /* for sysctl */
> -
>  #define ALL_INOTIFY_BITS (IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
>  			  IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
>  			  IN_MOVED_TO | IN_CREATE | IN_DELETE | \
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 7a90a12b9ea4..6aa67c737e4e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -125,13 +125,6 @@ static const int maxolduid = 65535;
>  static const int ngroups_max = NGROUPS_MAX;
>  static const int cap_last_cap = CAP_LAST_CAP;
>  
> -#ifdef CONFIG_INOTIFY_USER
> -#include <linux/inotify.h>
> -#endif
> -#ifdef CONFIG_FANOTIFY
> -#include <linux/fanotify.h>
> -#endif
> -
>  #ifdef CONFIG_PROC_SYSCTL
>  
>  /**
> @@ -3099,20 +3092,6 @@ static struct ctl_table fs_table[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif
> -#ifdef CONFIG_INOTIFY_USER
> -	{
> -		.procname	= "inotify",
> -		.mode		= 0555,
> -		.child		= inotify_table,
> -	},
> -#endif
> -#ifdef CONFIG_FANOTIFY
> -	{
> -		.procname	= "fanotify",
> -		.mode		= 0555,
> -		.child		= fanotify_table,
> -	},
> -#endif
>  #ifdef CONFIG_EPOLL
>  	{
>  		.procname	= "epoll",
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
