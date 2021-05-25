Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0964038F71A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 02:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhEYAy3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 20:54:29 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44546 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYAy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 20:54:28 -0400
Received: by mail-pl1-f178.google.com with SMTP id h12so3332812plf.11;
        Mon, 24 May 2021 17:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcQxMftnSz7s6EWbot8gOKQkZnXr0DmaHaJzWBROQA4=;
        b=CVADwi3jePxRj0ME/zNlt62Vs9h9VUNfbjNOqTqIFcnLI+O3IkUiONx478NXZi3p7t
         nJsbWNUXEdRyfes3UuGVcoetVzXWHTt670ALR8M7itrWgNCKVoM6OoLSAnwl8H1Sh/WE
         RTHgKCpBgzP02zIz39Sn/GrP3iwpcWgT7gxZcUR37Uj+IEpcTPVH7K1+nshQ8ne6l5FD
         prYJbpecqny0Qo398cRwjxE2rd62FojekYKjax7iaR/mxZuLqr8vyy2L5Z0kAxXhn3bX
         5+o1wITBIP4ssCmU3CC0a5Ynhg54FUJEtQuhyAkaW1FIdkxIWSdL+CNaaj/8sQm+HFsA
         O+Tw==
X-Gm-Message-State: AOAM530Sas72QqLKoG+zRDN+uosjtyCwSzJAxXKKKyzLOC+wONDWcCqY
        zFOmYN7Ki8vf25vmruK8QeQ=
X-Google-Smtp-Source: ABdhPJxmcyxKGZmtfMlITGfQFqFGst08qJ81/qG37wZDZWL3YxLYph+8Lb4zN/xd6LHxa7p43gUPTQ==
X-Received: by 2002:a17:902:6b4a:b029:fb:7b8e:56f8 with SMTP id g10-20020a1709026b4ab02900fb7b8e56f8mr3386275plt.46.1621903978522;
        Mon, 24 May 2021 17:52:58 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y66sm12128446pgb.14.2021.05.24.17.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 17:52:57 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 774434025E; Tue, 25 May 2021 00:52:56 +0000 (UTC)
Date:   Tue, 25 May 2021 00:52:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        jeyu@kernel.org, joe@perches.com, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, jack@suse.cz, axboe@kernel.dk, hare@suse.de,
        gregkh@linuxfoundation.org, tj@kernel.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, brho@google.com,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        ebiederm@xmission.com, jojing64@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/3] init/do_mounts.c: fix rootfs_fs_type with ramfs
Message-ID: <20210525005256.GF4332@42.do-not-panic.com>
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
 <20210522113155.244796-4-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522113155.244796-4-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 22, 2021 at 07:31:55PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> As for the existence of 'user root' which is introduced in previous
> patch, 'rootfs_fs_type', which is used as the root of mount tree,
> is not used directly any more. So it make no sense to switch it
> between ramfs and tmpfs, just fix it with ramfs to simplify the
> code.

You also noted this could be arbitrary. I don't see why its true that
the context used for init_mount_tree() can be arbitrary. And if it can
be, then why remove it / replace it with something more NULL like?

  Luis

> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
>  fs/namespace.c       |  2 --
>  include/linux/init.h |  1 -
>  init/do_mounts.c     | 18 +-----------------
>  3 files changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index f63337828e1c..8d2b57938e3a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -17,7 +17,6 @@
>  #include <linux/security.h>
>  #include <linux/cred.h>
>  #include <linux/idr.h>
> -#include <linux/init.h>		/* init_rootfs */
>  #include <linux/fs_struct.h>	/* get_fs_root et.al. */
>  #include <linux/fsnotify.h>	/* fsnotify_vfsmount_delete */
>  #include <linux/file.h>
> @@ -4241,7 +4240,6 @@ void __init mnt_init(void)
>  	if (!fs_kobj)
>  		printk(KERN_WARNING "%s: kobj create error\n", __func__);
>  	shmem_init();
> -	init_rootfs();
>  	init_mount_tree();
>  }
>  
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 045ad1650ed1..86bd92bb9550 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -148,7 +148,6 @@ extern unsigned int reset_devices;
>  /* used by init/main.c */
>  void setup_arch(char **);
>  void prepare_namespace(void);
> -void __init init_rootfs(void);
>  extern struct file_system_type rootfs_fs_type;
>  
>  #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 943cb58846fb..6d1253f75bb0 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -689,24 +689,8 @@ void __init init_user_rootfs(void)
>  	}
>  }
>  
> -static bool is_tmpfs;
> -static int rootfs_init_fs_context(struct fs_context *fc)
> -{
> -	if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
> -		return shmem_init_fs_context(fc);
> -
> -	return ramfs_init_fs_context(fc);
> -}
> -
>  struct file_system_type rootfs_fs_type = {
>  	.name		= "rootfs",
> -	.init_fs_context = rootfs_init_fs_context,
> +	.init_fs_context = ramfs_init_fs_context,
>  	.kill_sb	= kill_litter_super,
>  };

You mentioned 
> -
> -void __init init_rootfs(void)
> -{
> -	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
> -		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
> -		is_tmpfs = true;
> -}
> -- 
> 2.31.1
> 
