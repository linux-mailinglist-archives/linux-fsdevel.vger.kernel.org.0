Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B849038B913
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhETVmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 17:42:37 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:41759 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhETVmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 17:42:36 -0400
Received: by mail-pj1-f53.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso6035336pji.0;
        Thu, 20 May 2021 14:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vCLJpK+9hXa8f0bVbGyOkYYmlU11+GJfZDKiKDK5uNk=;
        b=gMHC6WFyGFtdf+6GDy1sFhLkkV7JZM+wO7G561h/skxQs2oENWFajx+ksqPmL6R9Qj
         Moc4KQRXVSSEixbsqUtUsAV+ffxR6CeMdkPuulX+WT0N+BuHNsQBPdg5Cp48x6AU2qYp
         /VeJo/bAW1VtD4GBTKQoWFzfJ10+BuR1LKTf3m3Z0r7d0CJtE865LrtqXhaTmf2rTMBt
         RYHcRKUh91dbkWvnGmrAmeA9tYS32hka0i/adQg8MM8wtcxYtSAeauFsHtg1gDDVkgql
         +/QsjrAZ+vaW/SXckgFlHqVoYp0xN61WW9CJ5wJjwtUcYsMHSIk1BV2dw2DLpBaW2PWQ
         /0DQ==
X-Gm-Message-State: AOAM533huEqyBzSKwE8h56yKEw/bjhBsyRfbU5awvT9iNtn1IA90nyvo
        0P/PQ7aMgQ/GtxfulIAvecA=
X-Google-Smtp-Source: ABdhPJypnMZcKE+4PZpH/eI52iPE7m1xo2fa+65z1SiPABfV6H6SzH1nlEe4KcQ6G7d5xLc9xTGFaA==
X-Received: by 2002:a17:903:248e:b029:ec:9c4f:765e with SMTP id p14-20020a170903248eb02900ec9c4f765emr8359201plw.17.1621546874093;
        Thu, 20 May 2021 14:41:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l20sm2604431pjq.38.2021.05.20.14.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:41:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EF45340321; Thu, 20 May 2021 21:41:11 +0000 (UTC)
Date:   Thu, 20 May 2021 21:41:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     jack@suse.cz, axboe@kernel.dk, hare@suse.de,
        gregkh@linuxfoundation.org, tj@kernel.org,
        dong.menglong@zte.com.cn, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        f.fainelli@gmail.com, arnd@arndb.de, brho@google.com,
        linux@rasmusvillemoes.dk, mhiramat@kernel.org, rostedt@goodmis.org,
        keescook@chromium.org, vbabka@suse.cz, glider@google.com,
        pmladek@suse.com, chris@chrisdown.name, ebiederm@xmission.com,
        jojing64@gmail.com, linux-kernel@vger.kernel.org,
        palmerdabbelt@google.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH RESEND] init/initramfs.c: make initramfs support
 pivot_root
Message-ID: <20210520214111.GV4332@42.do-not-panic.com>
References: <20210520154244.20209-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520154244.20209-1-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 11:42:44PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> During the kernel initialization, the mount tree, which is used by the
> kernel, is created, and 'rootfs' is mounted as the root file system.
> 
> While using initramfs as the root file system, cpio file is unpacked
> into the rootfs. Thus, this rootfs is exactly what users see in user
> space, and some problems arose: this rootfs has no parent mount,
> which make it can't be umounted or pivot_root.
> 
> 'pivot_root' is used to change the rootfs and clean the old mountpoints,
> and it is essential for some users, such as docker. Docker use
> 'pivot_root' to change the root fs of a process if the current root
> fs is a block device of initrd. However, when it comes to initramfs,
> things is different: docker has to use 'chroot()' to change the root
> fs, as 'pivot_root()' is not supported in initramfs.

OK so this seems to be a long winded way of saying you can't efficiently
use containers today when using initramfs. And then you explain why.

> The usage of 'chroot()' to create root fs for a container introduced
> a lot problems.
> 
> First, 'chroot()' can't clean the old mountpoints which inherited
> from the host. It means that the mountpoints in host will have a
> duplicate in every container. Let's image that there are 100
> containers in host, and there will be 100 duplicates of every
> mountpoints, which makes resource release an issue. User may
> remove a USB after he (or she) umount it successfully in the
> host. However, the USB may still be mounted in containers, although
> it can't be seen by the 'mount' commond in the container. This
> means the USB is not released yet, and data may not write back.
> Therefore, data lose arise.
> 
> Second, net-namespace leak is another problem. The net-namespace
> of containers will be mounted in /var/run/docker/netns/ in host
> by dockerd. It means that the net-namespace of a container will
> be mounted in containers which are created after it. Things
> become worse now, as the net-namespace can't be remove after
> the destroy of that container, as it is still mounted in other
> containers. If users want to recreate that container, he will
> fail if a certain mac address is to be binded with the container,
> as it is not release yet.

That seems like a chicken and egg problem on Docker, in that...

> Maybe dockerd can umount the unnecessary mountpoints that inherited
> for the host before do 'chroot()',

Can't docker instead allow to create containers prior to creating
your local docker network namespace? Not that its a great solution,
but just worth noting.

> but that is not a graceful way.
> I think the best way is to make 'pivot_root()' support initramfs.
> 
> After this patch, initramfs is supported by 'pivot_root()' perfectly.
> I just create a new rootfs and mount it to the mount-tree before
> unpack cpio. Therefore, the rootfs used by users has a parent mount,
> and can use 'pivot_root()'.
> 
> What's more, after this patch, 'rootflags' in boot cmd is supported
> by initramfs. Therefore, users can set the size of tmpfs with
> 'rootflags=size=1024M'.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
>  init/do_mounts.c | 53 +++++++++++++++++++++++++++++++++++++++---------
>  init/do_mounts.h |  1 +
>  init/initramfs.c | 32 +++++++++++++++++++++++++++++
>  init/main.c      | 17 +++++++++++++++-
>  4 files changed, 92 insertions(+), 11 deletions(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index a78e44ee6adb..a156b0d28b43 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -459,7 +459,7 @@ void __init mount_block_root(char *name, int flags)
>  out:
>  	put_page(page);
>  }
> - 
> +
>  #ifdef CONFIG_ROOT_NFS
>  
>  #define NFSROOT_TIMEOUT_MIN	5
> @@ -617,24 +617,57 @@ void __init prepare_namespace(void)
>  	init_chroot(".");
>  }
>  
> -static bool is_tmpfs;
> -static int rootfs_init_fs_context(struct fs_context *fc)
> +#ifdef CONFIG_TMPFS
> +static __init bool is_tmpfs_enabled(void)
> +{
> +	return (!root_fs_names || strstr(root_fs_names, "tmpfs")) &&
> +	       !saved_root_name[0];
> +}
> +#endif
> +
> +static __init bool is_ramfs_enabled(void)
>  {
> -	if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
> -		return shmem_init_fs_context(fc);
> +	return true;
> +}
> +
> +struct fs_user_root {
> +	bool (*enabled)(void);
> +	char *dev_name;
> +	char *fs_name;
> +};
>  
> -	return ramfs_init_fs_context(fc);
> +static struct fs_user_root user_roots[] __initdata = {
> +#ifdef CONFIG_TMPFS
> +	{.fs_name = "tmpfs", .enabled = is_tmpfs_enabled },
> +#endif
> +	{.fs_name = "ramfs", .enabled = is_ramfs_enabled }
> +};
> +static struct fs_user_root * __initdata user_root;
> +
> +int __init mount_user_root(void)
> +{
> +	return do_mount_root(user_root->dev_name,
> +			     user_root->fs_name,
> +			     root_mountflags,
> +			     root_mount_data);
>  }
>  
>  struct file_system_type rootfs_fs_type = {
>  	.name		= "rootfs",
> -	.init_fs_context = rootfs_init_fs_context,
> +	.init_fs_context = ramfs_init_fs_context,

Why is this always static now? Why is that its correct
now for init_mount_tree() always to use the ramfs context?

  Luis
