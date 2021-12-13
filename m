Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFC4472CAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 13:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbhLMM7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 07:59:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53720 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhLMM7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:59:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3326AB80EC1;
        Mon, 13 Dec 2021 12:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D279C34602;
        Mon, 13 Dec 2021 12:59:10 +0000 (UTC)
Date:   Mon, 13 Dec 2021 13:59:06 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH - regression] devtmpfs: reconfigure on each mount
Message-ID: <20211213125906.ngqbjsywxwibvcuq@wittgenstein>
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:12:26PM +1100, NeilBrown wrote:
> 
> Prior to Linux v5.4 devtmpfs used mount_single() which treats the given
> mount options as "remount" options, updating the configuration of the
> single super_block on each mount.
> Since that was changed, the mount options used for devtmpfs are ignored.
> This is a regression which affects systemd - which mounts devtmpfs
> with "-o mode=755,size=4m,nr_inodes=1m".
> 
> This patch restores the "remount" effect by calling reconfigure_single()
> 
> Fixes: d401727ea0d7 ("devtmpfs: don't mix {ramfs,shmem}_fill_super() with mount_single()")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---

Hey Neil,

So far this hasn't been an issue for us in systemd upstream. Is there a
specific use-case where this is causing issues? I'm mostly asking
because this change is fairly old.

What I actually find more odd is that there's no .reconfigure for
devtmpfs for non-vfs generic mount options it supports.

So it's possible to change vfs generic stuff like

mount -o remount,ro,nosuid /dev

but none of the other mount options it supports and there's no word lost
anywhere about whether or not that's on purpose.

It feels odd because it uses the fs parameters from shmem/ramfs

const struct fs_parameter_spec shmem_fs_parameters[] = {
	fsparam_u32   ("gid",		Opt_gid),
	fsparam_enum  ("huge",		Opt_huge,  shmem_param_enums_huge),
	fsparam_u32oct("mode",		Opt_mode),
	fsparam_string("mpol",		Opt_mpol),
	fsparam_string("nr_blocks",	Opt_nr_blocks),
	fsparam_string("nr_inodes",	Opt_nr_inodes),
	fsparam_string("size",		Opt_size),
	fsparam_u32   ("uid",		Opt_uid),
	fsparam_flag  ("inode32",	Opt_inode32),
	fsparam_flag  ("inode64",	Opt_inode64),
	{}
}

but doesn't allow to actually change them neither with your fix or with
the old way of doing things. But afaict, all of them could be set via
the "devtmpfs.mount" kernel command line option. So I could set gid=,
uid=, and mpol= for devtmpfs via devtmpfs.mount but wouldn't be able to
change it through remount or - in your case - with a mount with new
parameters?

Just wondering whether that's on purpose or an oversight.

>  drivers/base/devtmpfs.c    | 7 +++++++
>  fs/super.c                 | 4 ++--
>  include/linux/fs_context.h | 2 ++
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 8be352ab4ddb..fa13ad49d211 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -59,8 +59,15 @@ static struct dentry *public_dev_mount(struct file_system_type *fs_type, int fla
>  		      const char *dev_name, void *data)
>  {
>  	struct super_block *s = mnt->mnt_sb;
> +	int err;
> +
>  	atomic_inc(&s->s_active);
>  	down_write(&s->s_umount);
> +	err = reconfigure_single(s, flags, data);
> +	if (err < 0) {
> +		deactivate_locked_super(s);
> +		return ERR_PTR(err);
> +	}
>  	return dget(s->s_root);
>  }
>  
> diff --git a/fs/super.c b/fs/super.c
> index 3bfc0f8fbd5b..a6405d44d4ca 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1423,8 +1423,8 @@ struct dentry *mount_nodev(struct file_system_type *fs_type,
>  }
>  EXPORT_SYMBOL(mount_nodev);
>  
> -static int reconfigure_single(struct super_block *s,
> -			      int flags, void *data)
> +int reconfigure_single(struct super_block *s,
> +		       int flags, void *data)
>  {
>  	struct fs_context *fc;
>  	int ret;
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index 6b54982fc5f3..13fa6f3df8e4 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -142,6 +142,8 @@ extern void put_fs_context(struct fs_context *fc);
>  extern int vfs_parse_fs_param_source(struct fs_context *fc,
>  				     struct fs_parameter *param);
>  extern void fc_drop_locked(struct fs_context *fc);
> +int reconfigure_single(struct super_block *s,
> +		       int flags, void *data);
>  
>  /*
>   * sget() wrappers to be called from the ->get_tree() op.
> -- 
> 2.34.1
> 
