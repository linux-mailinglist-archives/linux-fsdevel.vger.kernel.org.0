Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7336E3F39A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 10:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhHUI7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 04:59:05 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59476 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUI7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:59:05 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 74B4E72C8F8;
        Sat, 21 Aug 2021 11:58:24 +0300 (MSK)
Received: from example.org (ip-94-112-79-42.net.upcbroadband.cz [94.112.79.42])
        by imap.altlinux.org (Postfix) with ESMTPSA id BA67E4A46F1;
        Sat, 21 Aug 2021 11:58:23 +0300 (MSK)
Date:   Sat, 21 Aug 2021 10:58:22 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     cgel.zte@gmail.com
Cc:     viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com,
        jamorris@linux.microsoft.com, yang.yang29@zte.com.cn,
        tj@kernel.org, paul.gortmaker@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] proc: prevent mount proc on same mountpoint in one pid
 namespace
Message-ID: <20210821085822.lhjtyoeboodqnyz7@example.org>
References: <20210821083105.30336-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821083105.30336-1-yang.yang29@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 21, 2021 at 01:31:05AM -0700, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Patch "proc: allow to mount many instances of proc in one pid namespace"
> aims to mount many instances of proc on different mountpoint, see
> tools/testing/selftests/proc/proc-multiple-procfs.c.
> 
> But there is a side-effects, user can mount many instances of proc on
> the same mountpoint in one pid namespace, which is not allowed before.

It is not true. Even before this patch, it was possible to mount procfs
multiple times. The instance was the same, but the opportunity was
_always_ there.

If you forbid procfs from mounting multiple times, you get a huge
regression.

> This duplicate mount makes no sense but wastes memory and CPU, and user
> may be confused why kernel allows it.

You may need to mount procfs in one mount namespace if you are doing
chroot and want to grant him access to not the entire pid space.

$ mount -o hidpid=2 -t proc proc /path/to/chroot/proc
$ chroot /path/to/chroot
<switch to user>

> The logic of this patch is: when try to mount proc on /mnt, check if
> there is a proc instance mount on /mnt in the same pid namespace. If
> answer is yes, return -EBUSY.
> 
> Since this check can't be done in proc_get_tree(), which call
> get_tree_nodev() and will create new super_block unconditionally.
> And other nodev fs may faces the same case, so add a new hook in
> fs_context_operations.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  fs/namespace.c             |  9 +++++++++
>  fs/proc/root.c             | 15 +++++++++++++++
>  include/linux/fs_context.h |  1 +
>  3 files changed, 25 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index f79d9471cb76..84da649a70c5 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2878,6 +2878,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
>  static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
>  			int mnt_flags, const char *name, void *data)
>  {
> +	int (*check_mntpoint)(struct fs_context *fc, struct path *path);
>  	struct file_system_type *type;
>  	struct fs_context *fc;
>  	const char *subtype = NULL;
> @@ -2906,6 +2907,13 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
>  	if (IS_ERR(fc))
>  		return PTR_ERR(fc);
>  
> +	/* check if there is a same super_block mount on path*/
> +	check_mntpoint = fc->ops->check_mntpoint;
> +	if (check_mntpoint)
> +		err = check_mntpoint(fc, path);
> +	if (err < 0)
> +		goto err_fc;
> +
>  	if (subtype)
>  		err = vfs_parse_fs_string(fc, "subtype",
>  					  subtype, strlen(subtype));
> @@ -2920,6 +2928,7 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
>  	if (!err)
>  		err = do_new_mount_fc(fc, path, mnt_flags);
>  
> +err_fc:
>  	put_fs_context(fc);
>  	return err;
>  }
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index c7e3b1350ef8..0971d6b0bec2 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -237,11 +237,26 @@ static void proc_fs_context_free(struct fs_context *fc)
>  	kfree(ctx);
>  }
>  
> +static int proc_check_mntpoint(struct fs_context *fc, struct path *path)
> +{
> +	struct super_block *mnt_sb = path->mnt->mnt_sb;
> +	struct proc_fs_info *fs_info;
> +
> +	if (strcmp(mnt_sb->s_type->name, "proc") == 0) {
> +		fs_info = mnt_sb->s_fs_info;
> +		if (fs_info->pid_ns == task_active_pid_ns(current) &&
> +		    path->mnt->mnt_root == path->dentry)
> +			return -EBUSY;
> +	}
> +	return 0;
> +}
> +
>  static const struct fs_context_operations proc_fs_context_ops = {
>  	.free		= proc_fs_context_free,
>  	.parse_param	= proc_parse_param,
>  	.get_tree	= proc_get_tree,
>  	.reconfigure	= proc_reconfigure,
> +	.check_mntpoint	= proc_check_mntpoint,
>  };
>  
>  static int proc_init_fs_context(struct fs_context *fc)
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index 6b54982fc5f3..090a05fb2d7d 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -119,6 +119,7 @@ struct fs_context_operations {
>  	int (*parse_monolithic)(struct fs_context *fc, void *data);
>  	int (*get_tree)(struct fs_context *fc);
>  	int (*reconfigure)(struct fs_context *fc);
> +	int (*check_mntpoint)(struct fs_context *fc, struct path *path);
>  };
>  
>  /*
> -- 
> 2.25.1
> 

-- 
Rgrds, legion

