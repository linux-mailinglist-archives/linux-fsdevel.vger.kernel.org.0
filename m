Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DFA39A23A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFCNcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 09:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFCNcX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:32:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9DD3613DE;
        Thu,  3 Jun 2021 13:30:21 +0000 (UTC)
Date:   Thu, 3 Jun 2021 15:30:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     menglong8.dong@gmail.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        akpm@linux-foundation.org, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, joe@perches.com, hare@suse.de,
        axboe@kernel.dk, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        brho@google.com, mcgrof@kernel.org, palmerdabbelt@google.com,
        arnd@arndb.de, f.fainelli@gmail.com, linux@rasmusvillemoes.dk,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, pmladek@suse.com,
        glider@google.com, chris@chrisdown.name, ebiederm@xmission.com,
        jojing64@gmail.com, mingo@kernel.org, terrelln@fb.com,
        geert@linux-m68k.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeyu@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: Re: [PATCH v4 2/3] init/do_mounts.c: create second mount for
 initramfs
Message-ID: <20210603133015.gvr5wpbotkyhhtqx@wittgenstein>
References: <20210602144630.161982-1-dong.menglong@zte.com.cn>
 <20210602144630.161982-3-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602144630.161982-3-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 10:46:29PM +0800, menglong8.dong@gmail.com wrote:
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
> In order to make pivot_root supported on initramfs, we create a second
> mount with type of rootfs before unpacking cpio, and change root to
> this mount after unpacking.
> 
> While mounting the second rootfs, 'rootflags' is passed, and it means
> that we can set options for the mount of rootfs in boot cmd now.
> For example, the size of tmpfs can be set with 'rootflags=size=1024M'.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---

Thanks for the reworked version a few more comments.

>  init/do_mounts.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++--
>  init/do_mounts.h | 16 ++++++++-
>  init/initramfs.c |  8 +++++
>  usr/Kconfig      | 10 ++++++
>  4 files changed, 119 insertions(+), 4 deletions(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index a78e44ee6adb..5f82db43ac0f 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -617,6 +617,91 @@ void __init prepare_namespace(void)
>  	init_chroot(".");
>  }
>  
> +static inline __init bool check_tmpfs_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
> +		(!root_fs_names || strstr(root_fs_names, "tmpfs"));
> +}
> +
> +#ifdef CONFIG_INITRAMFS_MOUNT
> +
> +static __init bool is_ramfs_enabled(void)
> +{
> +	return true;
> +}
> +
> +static __init bool is_tmpfs_enabled(void)
> +{
> +	return check_tmpfs_enabled();
> +}

This seems unnecessary. You can just introduce rename
check_tmpfs_enabled() to is_tmpfs_enabled() and get rid of this wrapper
around it.

> +
> +struct fs_rootfs_root {
> +	bool (*enabled)(void);
> +	char *dev_name;
> +	char *fs_name;
> +};
> +
> +static struct fs_rootfs_root rootfs_roots[] __initdata = {
> +	{
> +		.enabled  = is_tmpfs_enabled,
> +		.dev_name = "tmpfs",
> +		.fs_name  = "tmpfs",
> +	},
> +	{
> +		.enabled  = is_ramfs_enabled,
> +		.dev_name = "ramfs",
> +		.fs_name  = "ramfs"
> +	}
> +};
> +
> +/*
> + * Give systems running from the initramfs and making use of pivot_root a
> + * proper mount so it can be umounted during pivot_root.
> + */
> +int __init prepare_mount_rootfs(void)
> +{
> +	struct fs_rootfs_root *root = NULL;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(rootfs_roots); i++) {
> +		if (rootfs_roots[i].enabled()) {
> +			root = &rootfs_roots[i];
> +			break;
> +		}
> +	}
> +
> +	if (unlikely(!root))
> +		return -EFAULT;

The errno value is a weird choice. But in any case the check seems
unnecessary since is_ramfs_enabled() always returns true so is always
available apparently.

In fact you seem to be only using this struct you're introducing in this
single place which makes me think that it's not needed at all. So what's
preventing us from doing:

> +
> +	return do_mount_root(root->dev_name,
> +			     root->fs_name,
> +			     root_mountflags & ~MS_RDONLY,
> +			     root_mount_data);
> +}

int __init prepare_mount_rootfs(void)
{
	if (is_tmpfs_enabled())
		return do_mount_root("tmpfs", "tmpfs",
				     root_mountflags & ~MS_RDONLY,
				     root_mount_data);

	return do_mount_root("ramfs", "ramfs",
			     root_mountflags & ~MS_RDONLY,
			     root_mount_data);
}

> +
> +/*
> + * Change root to the new rootfs that mounted in prepare_mount_rootfs()
> + * if cpio is unpacked successfully and 'ramdisk_execute_command' exist.
> + * Otherwise, umount the new rootfs.
> + */
> +void __init finish_mount_rootfs(bool success)
> +{
> +	if (!success)
> +		goto on_fail;
> +
> +	init_mount(".", "/", NULL, MS_MOVE, NULL);
> +	if (!ramdisk_exec_exist())
> +		goto on_fail;
> +
> +	init_chroot(".");
> +	return;
> +
> +on_fail:
> +	init_chdir("/");
> +	init_umount(".", 0);
> +}
> +#endif

This is convoluted imho. I would simply use two tiny helpers:

void __init finish_mount_rootfs(void)
{
	init_mount(".", "/", NULL, MS_MOVE, NULL);

	if (ramdisk_exec_exist())
		init_chroot(".");
}

void __init revert_mount_rootfs(void)
{
	init_chdir("/");
	init_umount(".", 0);
}

> +
>  static bool is_tmpfs;
>  static int rootfs_init_fs_context(struct fs_context *fc)
>  {
> @@ -634,7 +719,5 @@ struct file_system_type rootfs_fs_type = {
>  
>  void __init init_rootfs(void)
>  {
> -	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
> -		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
> -		is_tmpfs = true;
> +	is_tmpfs = check_tmpfs_enabled();
>  }
> diff --git a/init/do_mounts.h b/init/do_mounts.h
> index 7a29ac3e427b..6a878c09a801 100644
> --- a/init/do_mounts.h
> +++ b/init/do_mounts.h
> @@ -10,9 +10,23 @@
>  #include <linux/root_dev.h>
>  #include <linux/init_syscalls.h>
>  
> +extern int root_mountflags;
> +
>  void  mount_block_root(char *name, int flags);
>  void  mount_root(void);
> -extern int root_mountflags;
> +bool  ramdisk_exec_exist(void);

Feels like that declaration belongs with the previous commit?

> +
> +#ifdef CONFIG_INITRAMFS_MOUNT
> +
> +int   prepare_mount_rootfs(void);
> +void  finish_mount_rootfs(bool success);
> +
> +#else
> +
> +static inline int   prepare_mount_rootfs(void) { return 0; }
> +static inline void  finish_mount_rootfs(bool success) { }
> +
> +#endif
>  
>  static inline __init int create_dev(char *name, dev_t dev)
>  {
> diff --git a/init/initramfs.c b/init/initramfs.c
> index af27abc59643..59c8e54bebad 100644
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
> @@ -682,15 +684,21 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
>  	else
>  		printk(KERN_INFO "Unpacking initramfs...\n");
>  
> +	if (prepare_mount_rootfs())
> +		panic("Failed to mount rootfs");
> +
>  	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
>  	if (err) {
> +		finish_mount_rootfs(false);

This then becomes
		revert_mount_rootfs();

>  #ifdef CONFIG_BLK_DEV_RAM
>  		populate_initrd_image(err);
>  #else
>  		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
>  #endif
> +		goto done;

This becomes unnecessary if you do:

>  	} else {
		finish_mount_rootfs(true);
	}

So overall you'd end up with something like this which should be way
shorter (__completely untested__):

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..e6c82c7c931f 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -459,7 +459,7 @@ void __init mount_block_root(char *name, int flags)
 out:
 	put_page(page);
 }
  
 #ifdef CONFIG_ROOT_NFS
 
 #define NFSROOT_TIMEOUT_MIN	5
@@ -617,6 +617,50 @@ void __init prepare_namespace(void)
 	init_chroot(".");
 }
 
+static inline __init bool is_tmpfs_enabled(void)
+{
+	return IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
+		(!root_fs_names || strstr(root_fs_names, "tmpfs"));
+}
+
+#ifdef CONFIG_INITRAMFS_MOUNT
+
+/*
+ * Give systems running from the initramfs and making use of pivot_root a
+ * proper mount so it can be umounted during pivot_root.
+ */
+int __init prepare_mount_rootfs(void)
+{
+	if (is_tmpfs_enabled())
+		return do_mount_root("tmpfs", "tmpfs",
+				     root_mountflags & ~MS_RDONLY,
+				     root_mount_data);
+
+	return do_mount_root("ramfs", "ramfs",
+			     root_mountflags & ~MS_RDONLY,
+			     root_mount_data);
+}
+
+/*
+ * Change root to the new rootfs that mounted in prepare_mount_rootfs()
+ * if cpio is unpacked successfully and 'ramdisk_execute_command' exist.
+ * Otherwise, umount the new rootfs.
+ */
+void __init finish_mount_rootfs(void)
+{
+	init_mount(".", "/", NULL, MS_MOVE, NULL);
+
+	if (ramdisk_exec_exist())
+		init_chroot(".");
+}
+
+void __init revert_mount_rootfs(void)
+{
+	init_chdir("/");
+	init_umount(".", 0);
+}
+#endif
+
 static bool is_tmpfs;
 static int rootfs_init_fs_context(struct fs_context *fc)
 {
@@ -634,7 +678,5 @@ struct file_system_type rootfs_fs_type = {
 
 void __init init_rootfs(void)
 {
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
-		is_tmpfs = true;
+	is_tmpfs = is_tmpfs_enabled();
 }
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 7a29ac3e427b..1724fd072dae 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -10,9 +10,25 @@
 #include <linux/root_dev.h>
 #include <linux/init_syscalls.h>
 
+extern int root_mountflags;
+
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
-extern int root_mountflags;
+bool  ramdisk_exec_exist(void);
+
+#ifdef CONFIG_INITRAMFS_MOUNT
+
+int   prepare_mount_rootfs(void);
+void  finish_mount_rootfs(void);
+void __init revert_mount_rootfs(void);
+
+#else
+
+static inline int   prepare_mount_rootfs(void) { return 0; }
+static inline void  finish_mount_rootfs() { }
+static inline void  revert_mount_rootfs() { }
+
+#endif
 
 static inline __init int create_dev(char *name, dev_t dev)
 {
diff --git a/init/initramfs.c b/init/initramfs.c
index af27abc59643..f49d29de4fd9 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -16,6 +16,8 @@
 #include <linux/namei.h>
 #include <linux/init_syscalls.h>
 
+#include "do_mounts.h"
+
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
 		loff_t *pos)
 {
@@ -682,15 +684,20 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	else
 		printk(KERN_INFO "Unpacking initramfs...\n");
 
+	if (prepare_mount_rootfs())
+		panic("Failed to mount rootfs");
+
 	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
 	if (err) {
+		revert_mount_rootfs();
 #ifdef CONFIG_BLK_DEV_RAM
 		populate_initrd_image(err);
 #else
 		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 #endif
+	} else {
+		finish_mount_rootfs();
 	}
-
 done:
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
diff --git a/usr/Kconfig b/usr/Kconfig
index 8bbcf699fe3b..4f6ac12eafe9 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -52,6 +52,16 @@ config INITRAMFS_ROOT_GID
 
 	  If you are not sure, leave it set to "0".
 
+config INITRAMFS_MOUNT
+	bool "Create second mount to make pivot_root() supported"
+	default y
+	help
+	  Before unpacking cpio, create a second mount and make it become
+	  the root filesystem. Therefore, initramfs will be supported by
+	  pivot_root().
+
+	  If container platforms is used with initramfs, say Y.
+
 config RD_GZIP
 	bool "Support initial ramdisk/ramfs compressed using gzip"
 	default y
-- 
2.27.0

