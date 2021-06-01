Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5513975A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhFAOlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 10:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234160AbhFAOlV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:41:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 596F161375;
        Tue,  1 Jun 2021 14:39:31 +0000 (UTC)
Date:   Tue, 1 Jun 2021 16:39:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     menglong8.dong@gmail.com
Cc:     mhiramat@kernel.org, mcgrof@kernel.org, josh@joshtriplett.org,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        jeyu@kernel.org, masahiroy@kernel.org, dong.menglong@zte.com.cn,
        joe@perches.com, axboe@kernel.dk, jack@suse.cz, hare@suse.de,
        tj@kernel.org, gregkh@linuxfoundation.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, brho@google.com, rostedt@goodmis.org,
        vbabka@suse.cz, pmladek@suse.com, glider@google.com,
        chris@chrisdown.name, jojing64@gmail.com, ebiederm@xmission.com,
        mingo@kernel.org, terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v3 2/3] init/do_cmounts.c: introduce 'user_root' for
 initramfs
Message-ID: <20210601143928.b2t2xwxnqma5h6li@wittgenstein>
References: <20210528143802.78635-1-dong.menglong@zte.com.cn>
 <20210528143802.78635-3-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210528143802.78635-3-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 28, 2021 at 10:38:01PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> If using container platforms such as Docker, upon initialization it
> wants to use pivot_root() so that currently mounted devices do not
> propagate to containers. An example of value in this is that
> a USB device connected prior to the creation of a containers on the
> host gets disconnected after a container is created; if the
> USB device was mounted on containers, but already removed and
> umounted on the host, the mount point will not go away until all
> containers unmount the USB device.
> 
> Another reason for container platforms such as Docker to use pivot_root
> is that upon initialization the net-namspace is mounted under
> /var/run/docker/netns/ on the host by dockerd. Without pivot_root
> Docker must either wait to create the network namespace prior to
> the creation of containers or simply deal with leaking this to each
> container.
> 
> pivot_root is supported if the rootfs is a initrd or block device, but
> it's not supported if the rootfs uses an initramfs (tmpfs). This means
> container platforms today must resort to using block devices if
> they want to pivot_root from the rootfs. A workaround to use chroot()
> is not a clean viable option given every container will have a
> duplicate of every mount point on the host.
> 
> In order to support using container platforms such as Docker on
> all the supported rootfs types we must extend Linux to support
> pivot_root on initramfs as well. This patch does the work to do
> just that.
> 
> pivot_root will unmount the mount of the rootfs from its parent mount
> and mount the new root to it. However, when it comes to initramfs, it
> donesn't work, because the root filesystem has not parent mount, which
> makes initramfs not supported by pivot_root.
> 
> In order to support pivot_root on initramfs we introduce a second
> "user_root" mount which is created before we do the cpio unpacking.
> The filesystem of the "user_root" mount is the same the rootfs.
> 
> While mounting the 'user_root', 'rootflags' is passed to it, and it means
> that we can set options for the mount of rootfs in boot cmd now.
> For example, the size of tmpfs can be set with 'rootflags=size=1024M'.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
>  init/do_mounts.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++
>  init/do_mounts.h |  18 ++++++++-
>  init/initramfs.c |  10 +++++
>  usr/Kconfig      |  10 +++++
>  4 files changed, 138 insertions(+), 1 deletion(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index a78e44ee6adb..2fd168cca480 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -617,6 +617,107 @@ void __init prepare_namespace(void)
>  	init_chroot(".");
>  }
>  
> +#ifdef CONFIG_INITRAMFS_USER_ROOT
> +#ifdef CONFIG_TMPFS
> +static __init bool is_tmpfs_enabled(void)
> +{
> +	return (!root_fs_names || strstr(root_fs_names, "tmpfs")) &&
> +	       !saved_root_name[0];
> +}
> +#endif

This code is duplicated below in this file

void __init init_rootfs(void)
{
	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
		is_tmpfs = true;
}
                                        
so you should add a tiny inline helper that can be called in both
places. Will also allow you to get rid of one ifdef and makes the patch
smaller.

> +
> +static __init bool is_ramfs_enabled(void)
> +{
> +	return true;
> +}
> +
> +struct fs_user_root {
> +	bool (*enabled)(void);
> +	char *dev_name;
> +	char *fs_name;
> +};
> +
> +static struct fs_user_root user_roots[] __initdata = {
> +#ifdef CONFIG_TMPFS
> +	{
> +		.enabled  = is_tmpfs_enabled,
> +		.dev_name = "tmpfs",
> +		.fs_name  = "tmpfs",
> +	},
> +#endif
> +	{
> +		.enabled  = is_ramfs_enabled,
> +		.dev_name = "ramfs",
> +		.fs_name  = "ramfs"
> +	}
> +};
> +static struct fs_user_root * __initdata user_root;
> +
> +/*
> + * The syscall 'pivot_root' is used to change root and it is able to
> + * clean the old mounts, which make it preferred by container platforms
> + * such as Docker. However, initramfs is not supported by pivot_root,
> + * and 'chroot()' has to be used, which is unable to clean the mounts
> + * that propagate from HOST. These useless mounts make the release of
> + * removable device or network namespace a big problem.
> + *
> + * To make initramfs supported by pivot_root, the mount of the root
> + * filesystem should have a parent, which will make it unmountable. In
> + * this function, the second mount, which is called 'user root', is
> + * created and mounted on '/root', and it will be made the root filesystem
> + * in end_mount_user_root() by init_chroot().
> + *
> + * The 'user root' has a parent mount, which makes it unmountable and
> + * pivot_root work.
> + *
> + * What's more, root_mountflags and root_mount_data are used here, which
> + * makes the 'rootflags' in boot cmd work for 'user root'.

I appreciate the detail but most of that should go in the commit
message it also repeats some info a couple of times. :) Here sm like the
following should suffice, I think:

/*
 * Give systems running from the initramfs and making use of pivot_root a
 * proper mount so it can be umounted during pivot_root.
 */

> + */
> +int __init mount_user_root(void)
> +{
> +	return do_mount_root(user_root->dev_name,
> +			     user_root->fs_name,
> +			     root_mountflags & ~MS_RDONLY,
> +			     root_mount_data);
> +}
> +
> +/*
> + * This function is used to chroot to new initramfs root that
> + * we unpacked on success. It will chdir to '/' and umount
> + * the secound mount on failure.
> + */
> +void __init end_mount_user_root(bool succeed)
> +{
> +	init_chdir("/");
> +	if (!succeed) {
> +		init_umount("/root", 0);
> +		return;
> +	}
> +
> +	init_mount("/root", "/", NULL, MS_MOVE, NULL);
> +	if (!ramdisk_exec_exist()) {
> +		init_umount("/..", 0);
> +		return;
> +	}
> +
> +	init_chroot("/..");
> +}
> +
> +void __init init_user_rootfs(void)
> +{
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
> +}
> +#endif
> +
>  static bool is_tmpfs;
>  static int rootfs_init_fs_context(struct fs_context *fc)
>  {
> diff --git a/init/do_mounts.h b/init/do_mounts.h
> index 7a29ac3e427b..3802c7a3ba91 100644
> --- a/init/do_mounts.h
> +++ b/init/do_mounts.h
> @@ -10,9 +10,25 @@
>  #include <linux/root_dev.h>
>  #include <linux/init_syscalls.h>
>  
> +extern int root_mountflags;
> +
>  void  mount_block_root(char *name, int flags);
>  void  mount_root(void);
> -extern int root_mountflags;
> +bool  ramdisk_exec_exist(void);
> +
> +#ifdef CONFIG_INITRAMFS_USER_ROOT
> +
> +int   mount_user_root(void);
> +void  end_mount_user_root(bool succeed);
> +void  init_user_rootfs(void);
> +
> +#else
> +
> +static inline int   mount_user_root(void) { return 0; }
> +static inline void  end_mount_user_root(bool succeed) { }
> +static inline void  init_user_rootfs(void) { }
> +
> +#endif
>  
>  static inline __init int create_dev(char *name, dev_t dev)
>  {
> diff --git a/init/initramfs.c b/init/initramfs.c
> index af27abc59643..ffa78932ae65 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -16,6 +16,8 @@
>  #include <linux/namei.h>
>  #include <linux/init_syscalls.h>
>  
> +#include "do_mounts.h"
> +
>  static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
>  		loff_t *pos)
>  {
> @@ -682,15 +684,23 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
>  	else
>  		printk(KERN_INFO "Unpacking initramfs...\n");
>  
> +	init_user_rootfs();
> +
> +	if (mount_user_root())

I would call this sm like

prepare_mount_rootfs()
finish_mount_rootfs()

> +		panic("Failed to create user root");

I don't think you need to call init_user_rootfs() separately? You could
just move it into the prepare_mount_rootfs()/mount_user_root() call.

> +
>  	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
>  	if (err) {
> +		end_mount_user_root(false);

This boolean argument to end_mount_user_root() is a bit strange. Just
call init_umount() directly here?

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
> diff --git a/usr/Kconfig b/usr/Kconfig
> index 8bbcf699fe3b..f9c96de539c3 100644
> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -52,6 +52,16 @@ config INITRAMFS_ROOT_GID
>  
>  	  If you are not sure, leave it set to "0".
>  
> +config INITRAMFS_USER_ROOT

I think the naming isn't great. Just call it INITRAMFS_MOUNT. The "user"
part in all the function and variabe names seems confusing to me at
least it doesn't convey a lot of useful info. So I'd just drop it and
try to stick with plain rootfs/initramfs terminology.

> +	bool "Create 'user root' to make pivot_root supported"
> +	default y
> +	help
> +	  Before unpacking cpio, create a second mount and make it become
> +	  the root filesystem. Therefore, initramfs will be supported by
> +	  pivot_root().
> +
> +	  If container platforms is used with initramfs, say Y.
> +
>  config RD_GZIP
>  	bool "Support initial ramdisk/ramfs compressed using gzip"
>  	default y
> -- 
> 2.32.0.rc0
> 
> 
