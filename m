Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC11983E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgC3TDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 15:03:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgC3TDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=TQ9cYkWVRMY5HM+PVzYLu4H7z2n9HAf8wAGBPwbykN4=; b=n2UiTkYaKNMRkhxvNvOONgFBJX
        tKGNJfEho4dR45vF9PtV8trcvHo+CGSa6Ux8eCcbOWCyelt2DIHyBm6bxCjWQl2xt8iFFWdVOnl5t
        sFqyUn6q/JIrdOv/lI2VsJfjy2KLn18LgHylbdACnFpJmoI1ctBOnA5W6EyWt4kYh9CkQnDpihITV
        1GqprvOK95H7ueJ4mcj0dVCAh+rEnyFJeN3EuSDFWyn+OgKl48o2AIS6KI0k/KOkVDReCOhCBqinY
        k7K2oXZqA3kcMCDxvz0rwMndL+cNi3hHfVVEXzBrHXZUEY1BbLFftE8QsxcPxNHzXBKY0QpM5zYfP
        eZQAz3BA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIzhD-00011g-HA; Mon, 30 Mar 2020 19:03:39 +0000
Subject: Re: [PATCH 1/1] mnt: add support for non-rootfs initramfs
To:     Ignat Korchagin <ignat@cloudflare.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com
References: <20200330131439.2405-1-ignat@cloudflare.com>
 <20200330131439.2405-2-ignat@cloudflare.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f96ad8b8-0a26-448a-4a27-8712a82001c4@infradead.org>
Date:   Mon, 30 Mar 2020 12:03:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330131439.2405-2-ignat@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/20 6:14 AM, Ignat Korchagin wrote:
> The main need for this is to support container runtimes on stateless Linux
> system (pivot_root system call from initramfs).
> 
> Normally, the task of initramfs is to mount and switch to a "real" root
> filesystem. However, on stateless systems (booting over the network) it is just
> convenient to have your "real" filesystem as initramfs from the start.
> 
> This, however, breaks different container runtimes, because they usually use
> pivot_root system call after creating their mount namespace. But pivot_root does
> not work from initramfs, because initramfs runs form rootfs, which is the root
> of the mount tree and can't be unmounted.
> 
> One workaround is to do:
> 
>   mount --bind / /
> 
> However, that defeats one of the purposes of using pivot_root in the cloned
> containers: get rid of host root filesystem, should the code somehow escapes the
> chroot.
> 
> There is a way to solve this problem from userspace, but it is much more
> cumbersome:
>   * either have to create a multilayered archive for initramfs, where the outer
>     layer creates a tmpfs filesystem and unpacks the inner layer, switches root
>     and does not forget to properly cleanup the old rootfs
>   * or we need to use keepinitrd kernel cmdline option, unpack initramfs to
>     rootfs, run a script to create our target tmpfs root, unpack the same
>     initramfs there, switch root to it and again properly cleanup the old root,
>     thus unpacking the same archive twice and also wasting memory, because
>     the kernel stores compressed initramfs image indefinitely.
> 
> With this change we can ask the kernel (by specifying nonroot_initramfs kernel
> cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
> before the initramfs handling code, so initramfs gets unpacked directly into
> the "leaf" tmpfs with rootfs being empty and no need to clean up anything.
> 
> This also bring the behaviour in line with the older style initrd, where the
> initrd is located on some leaf filesystem in the mount tree and rootfs remaining
> empty.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  fs/namespace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Hi,
Please document "nonroot_initramfs" in
Documentation/admin-guide/kernel-parameters.txt.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 85b5f7bea82e..a1ec862e8146 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3701,6 +3701,49 @@ static void __init init_mount_tree(void)
>  	set_fs_root(current->fs, &root);
>  }
>  
> +#if IS_ENABLED(CONFIG_TMPFS)
> +static int __initdata nonroot_initramfs;
> +
> +static int __init nonroot_initramfs_param(char *str)
> +{
> +	if (*str)
> +		return 0;
> +	nonroot_initramfs = 1;
> +	return 1;
> +}
> +__setup("nonroot_initramfs", nonroot_initramfs_param);
> +
> +static void __init init_nonroot_initramfs(void)
> +{
> +	int err;
> +
> +	if (!nonroot_initramfs)
> +		return;
> +
> +	err = ksys_mkdir("/root", 0700);
> +	if (err < 0)
> +		goto out;
> +
> +	err = do_mount("tmpfs", "/root", "tmpfs", 0, NULL);
> +	if (err)
> +		goto out;
> +
> +	err = ksys_chdir("/root");
> +	if (err)
> +		goto out;
> +
> +	err = do_mount(".", "/", NULL, MS_MOVE, NULL);
> +	if (err)
> +		goto out;
> +
> +	err = ksys_chroot(".");
> +	if (!err)
> +		return;
> +out:
> +	printk(KERN_WARNING "Failed to create a non-root filesystem for initramfs\n");
> +}
> +#endif /* IS_ENABLED(CONFIG_TMPFS) */
> +
>  void __init mnt_init(void)
>  {
>  	int err;
> @@ -3734,6 +3777,10 @@ void __init mnt_init(void)
>  	shmem_init();
>  	init_rootfs();
>  	init_mount_tree();
> +
> +#if IS_ENABLED(CONFIG_TMPFS)
> +	init_nonroot_initramfs();
> +#endif
>  }
>  
>  void put_mnt_ns(struct mnt_namespace *ns)
> 

thanks.
-- 
~Randy

