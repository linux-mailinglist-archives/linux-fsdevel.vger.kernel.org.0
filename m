Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A7383507
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbhEQPPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 11:15:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240508AbhEQPMm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 11:12:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4455AF59;
        Mon, 17 May 2021 15:11:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B61FA1F2C63; Mon, 17 May 2021 17:11:23 +0200 (CEST)
Date:   Mon, 17 May 2021 17:11:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     menglong8.dong@gmail.com
Cc:     axboe@kernel.dk, hare@suse.de, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, dong.menglong@zte.com.cn,
        song@kernel.org, neilb@suse.de, akpm@linux-foundation.org,
        f.fainelli@gmail.com, linux@rasmusvillemoes.dk,
        palmerdabbelt@google.com, mcgrof@kernel.org, arnd@arndb.de,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        rostedt@goodmis.org, keescook@chromium.org, vbabka@suse.cz,
        pmladek@suse.com, glider@google.com, chris@chrisdown.name,
        ebiederm@xmission.com, jojing64@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] init/initramfs.c: add a new mount as root file system
Message-ID: <20210517151123.GD25760@quack2.suse.cz>
References: <20210517142542.187574-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517142542.187574-1-dong.menglong@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the patch! Although you've CCed a wide set of people, I don't
think you've addressed the most relevant ones. For this I'd CC
linux-fsdevel mailing list and Al Viro as a VFS maintainer - added.

								Honza

On Mon 17-05-21 07:25:42, menglong8.dong@gmail.com wrote:
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
> 
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
> 
> Maybe dockerd can umount the unnecessary mountpoints that inherited
> for the host before do 'chroot()', but that is not a graceful way.
> I think the best way is to make 'pivot_root()' support initramfs.
> 
> After this patch, initramfs is supported by 'pivot_root()' perfectly.
> I just create a new rootfs and mount it to the mount-tree before
> unpack cpio. Therefore, the rootfs used by users has a parent mount,
> and can use 'pivot_root()'.
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
>  	.kill_sb	= kill_litter_super,
>  };
>  
>  void __init init_rootfs(void)
>  {
> -	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
> -		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
> -		is_tmpfs = true;
> +	struct fs_user_root *root;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(user_roots); i++) {
> +		root = &user_roots[i];
> +		if (root->enabled()) {
> +			user_root = root;
> +			break;
> +		}
> +	}
>  }
> diff --git a/init/do_mounts.h b/init/do_mounts.h
> index 7a29ac3e427b..34978b17454a 100644
> --- a/init/do_mounts.h
> +++ b/init/do_mounts.h
> @@ -13,6 +13,7 @@
>  void  mount_block_root(char *name, int flags);
>  void  mount_root(void);
>  extern int root_mountflags;
> +int   mount_user_root(void);
>  
>  static inline __init int create_dev(char *name, dev_t dev)
>  {
> diff --git a/init/initramfs.c b/init/initramfs.c
> index af27abc59643..c883379673c0 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -15,6 +15,11 @@
>  #include <linux/mm.h>
>  #include <linux/namei.h>
>  #include <linux/init_syscalls.h>
> +#include <uapi/linux/mount.h>
> +
> +#include "do_mounts.h"
> +
> +extern bool ramdisk_exec_exist(bool abs);
>  
>  static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
>  		loff_t *pos)
> @@ -667,6 +672,27 @@ static void __init populate_initrd_image(char *err)
>  }
>  #endif /* CONFIG_BLK_DEV_RAM */
>  
> +/*
> + * This function is used to chroot to new initramfs root that
> + * we unpacked.
> + */
> +static void __init end_mount_user_root(bool succeed)
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
> +	init_umount("/root", 0);
> +}
> +
>  static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
>  {
>  	/* Load the built in initramfs */
> @@ -682,15 +708,21 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
>  	else
>  		printk(KERN_INFO "Unpacking initramfs...\n");
>  
> +	if (mount_user_root())
> +		panic("Failed to create user root");
> +
>  	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
>  	if (err) {
> +		end_mount_user_root(false);
>  #ifdef CONFIG_BLK_DEV_RAM
>  		populate_initrd_image(err);
>  #else
>  		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
>  #endif
> +		goto done;
>  	}
>  
> +	end_mount_user_root(true);
>  done:
>  	/*
>  	 * If the initrd region is overlapped with crashkernel reserved region,
> diff --git a/init/main.c b/init/main.c
> index eb01e121d2f1..431da5f01f11 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -607,6 +607,21 @@ static inline void setup_nr_cpu_ids(void) { }
>  static inline void smp_prepare_cpus(unsigned int maxcpus) { }
>  #endif
>  
> +bool __init ramdisk_exec_exist(bool abs)
> +{
> +	char *tmp_command = ramdisk_execute_command;
> +
> +	if (!tmp_command)
> +		return false;
> +
> +	if (!abs) {
> +		while (*tmp_command == '/' || *tmp_command == '.')
> +			tmp_command++;
> +	}
> +
> +	return init_eaccess(tmp_command) == 0;
> +}
> +
>  /*
>   * We need to store the untouched command line for future reference.
>   * We also need to store the touched command line since the parameter
> @@ -1568,7 +1583,7 @@ static noinline void __init kernel_init_freeable(void)
>  	 * check if there is an early userspace init.  If yes, let it do all
>  	 * the work
>  	 */
> -	if (init_eaccess(ramdisk_execute_command) != 0) {
> +	if (!ramdisk_exec_exist(true)) {
>  		ramdisk_execute_command = NULL;
>  		prepare_namespace();
>  	}
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
