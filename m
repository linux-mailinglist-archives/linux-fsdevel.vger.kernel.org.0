Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704BB38F70F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 02:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhEYApz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 20:45:55 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:46078 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYApz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 20:45:55 -0400
Received: by mail-pj1-f46.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so10984130pjb.4;
        Mon, 24 May 2021 17:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6UpttTrEDW//beA5f8aGYwgPBwdFr5w0s1WSkdYBoYE=;
        b=LxOEmZQjFVCpuMQEBwWre3LWFWTPYjVcgNUdqhYe7ln8U6WMxKcarxBUTIxrZjc1Yt
         nwR6BTwFB6jziBK0lwAc9FxUl+b8OIpCdEt/PG2orvWGmFg3iPJfHCeYlFzWgQQTqhEL
         oZAq/erWX/y93+AadNOn4r59tlyHi92ngHP6yHzr42N/+XyYrcV64SEyYvTg9aGO3K4d
         r/l+dY3a6+1fPCGp+0tWOdGwQGdB4Nwe1NkfxdMNh8bOhxhTIH+Hv5e/XkY3GOMUILgq
         d+s8Lny1y9DVpHYrHol6FdbS7AMNbBkPqmWRAqEPeqza0sR0jL+irSCCbexKsNm6kMk9
         1YYg==
X-Gm-Message-State: AOAM531stfHFS3StdFvEZIcNYjZoxaLQa6HNefvWBi6BlNvzI48DG6N5
        tNUy+lO6C+MHUkzc1ezHlkU=
X-Google-Smtp-Source: ABdhPJyQ1C8ZJbK+nxXRDB7eADNt7MKeNqY08J+MYJsc1ruAwnIuzivaLbUbjWyBnkHHjL/Mrn9ibA==
X-Received: by 2002:a17:90b:8c5:: with SMTP id ds5mr28440147pjb.127.1621903465074;
        Mon, 24 May 2021 17:44:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u12sm10871089pfm.2.2021.05.24.17.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 17:44:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B25B44025E; Tue, 25 May 2021 00:44:22 +0000 (UTC)
Date:   Tue, 25 May 2021 00:44:22 +0000
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
Subject: Re: [PATCH 2/3] init/do_cmounts.c: introduce 'user_root' for
 initramfs
Message-ID: <20210525004422.GB4332@42.do-not-panic.com>
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
 <20210522113155.244796-3-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522113155.244796-3-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc'ing Josh as I think he might be interested in this.

On Sat, May 22, 2021 at 07:31:54PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> During the kernel initialization, the root of the mount tree is
> created with file system type of ramfs or tmpfs.

ramfs (initrd) 

> While using initramfs as the root file system, cpio file is unpacked
> into the rootfs. Thus, this rootfs is exactly what users see in user
> space, and some problems arose: this rootfs has no parent mount,
> which make it can't be umounted or pivot_root.
> 'pivot_root' is used to change the rootfs and clean the old mounts,
> and it is essential for some users, such as docker. Docker use
> 'pivot_root' to change the root fs of a process if the current root
> fs is a block device of initrd. However, when it comes to initramfs,
> things is different: docker has to use 'chroot()' to change the root
> fs, as 'pivot_root()' is not supported in initramfs.
> 
> The usage of 'chroot()' to create root fs for a container introduced
> a lot problems.
> 
> First, 'chroot()' can't clean the old mountpoints which inherited
> from the host. It means that the mountpoints in host will have a
> duplicate in every container. Users may remove a USB after it
> is umounted successfully in the host. However, the USB may still
> be mounted in containers, although it can't be seen by the 'mount'
> commond. This means the USB is not released yet, and data may not
> write back. Therefore, data lose arise.
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

I think you can clarify this a bit more with:

  If using container platforms such as Docker, upon initialization it
  wants to use pivot_root() so that currently mounted devices do not
  propagate to containers. An example of value in this is that
  a USB device connected prior to the creation of a containers on the
  host gets disconnected after a container is created; if the
  USB device was mounted on containers, but already removed and
  umounted on the host, the mount point will not go away untill all
  containers unmount the USB device.

  Another reason for container platforms such as Docker to use pivot_root
  is that upon initialization the net-namspace is mounted under
  /var/run/docker/netns/ on the host by dockerd. Without pivot_root
  Docker must either wait to create the network namespace prior to
  the creation of containers or simply deal with leaking this to each
  container.

  pivot_root is supported if the rootfs is a ramfs (initrd), but its
  not supported if the rootfs uses an initramfs (tmpfs). This means
  container platforms today must resort to using ramfs (initrd) if
  they want to pivot_root from the rootfs. A workaround to use chroot()
  is not a clean viable option given every container will have a
  duplicate of every mount point on the host.

  In order to support using container platforms such as Docker on
  all the supported rootfs types we must extend Linux to support
  pivot_root on initramfs as well. This patch does the work to do
  just that.

So remind me.. so it would seem that if the rootfs uses a ramfs (initrd)
that pivot_root works just fine. Why is that? Did someone add support
for that? Has that always been the case that it works? If not, was it a
consequence of how ramfs (initrd) works?

And finally, why can't we share the same mechanism used for ramfs
(initrd) for initramfs (tmpfs)?

> In this patch, a second mount, which is called 'user root', is
> created before 'cpio' unpacking. The file system of 'user root'
> is exactly the same as rootfs, and both ramfs and tmpfs are
> supported. Then, the 'cpio' is unpacked into the 'user root'.
> Now, the rootfs has a parent mount, and pivot_root() will be
> supported for initramfs.

How about something like:

  In order to support pivot_root on initramfs we introduce a second
  "user_root" mount  which is created before we do the cpio unpacking.
  The filesystem of the "user_root" mount is the same the rootfs.

It begs the question, why add this infrastructure to suppor this for
ramfs (initrd) if we only need this hack for initramfs (tmpfs)?

> What's more, after this patch, 'rootflags' in boot cmd is supported
> by initramfs. Therefore, users can set the size of tmpfs with
> 'rootflags=size=1024M'.

Why is that exactly?

> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
>  init/do_mounts.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
>  init/do_mounts.h |  7 ++++-
>  init/initramfs.c | 10 +++++++
>  3 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index a78e44ee6adb..943cb58846fb 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -617,6 +617,78 @@ void __init prepare_namespace(void)
>  	init_chroot(".");
>  }
>  
> +#ifdef CONFIG_TMPFS
> +static __init bool is_tmpfs_enabled(void)
> +{
> +	return (!root_fs_names || strstr(root_fs_names, "tmpfs")) &&
> +	       !saved_root_name[0];
> +}
> +#endif
> +
> +static __init bool is_ramfs_enabled(void)
> +{
> +	return true;
> +}
> +
> +struct fs_user_root {
> +	bool (*enabled)(void);
> +	char *dev_name;

What's the point of dev_name if its never set?

> +	char *fs_name;
> +};
> +
> +static struct fs_user_root user_roots[] __initdata = {
> +#ifdef CONFIG_TMPFS
> +	{.fs_name = "tmpfs", .enabled = is_tmpfs_enabled },
> +#endif
> +	{.fs_name = "ramfs", .enabled = is_ramfs_enabled }
> +};
> +static struct fs_user_root * __initdata user_root;
> +
> +/* Mount the user_root on '/'. */
> +int __init mount_user_root(void)
> +{
> +	return do_mount_root(user_root->dev_name,

See, isn't dev_name here always NULL?

> +			     user_root->fs_name,
> +			     root_mountflags & ~MS_RDONLY,
> +			     root_mount_data);
> +}
> +
> +/*
> + * This function is used to chroot to new initramfs root that
> + * we unpacked on success.

Might be a good place to document that we do this so folks can
pivot_root on rootfs, and why that is desirable (mentioned above on the
commit log edits I suggested). Otherwise I don't think its easy for a
reader of the code to understand why we are doing all this work.

> It will chdir to '/' and umount
> + * the secound mount on failure.
> + */
> +void __init end_mount_user_root(bool succeed)
> +{
> +	if (!succeed)
> +		goto on_failed;
> +
> +	if (!ramdisk_exec_exist(false))
> +		goto on_failed;
> +
> +	init_mount(".", "/", NULL, MS_MOVE, NULL);
> +	init_chroot(".");
> +	return;
> +
> +on_failed:
> +	init_chdir("/");
> +	init_umount("/..", 0);
> +}

Is anything extra needed on shutdown / reboot?

  Luis
