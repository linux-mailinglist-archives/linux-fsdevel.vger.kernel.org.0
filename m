Return-Path: <linux-fsdevel+bounces-13737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8F8734D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB671F2387D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582C1605C9;
	Wed,  6 Mar 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY9JtzbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BD605B6
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722208; cv=none; b=aSwTp7fIL1q8wNLwVdTFOh7UMotPdEJHKiuUERcTGN/hz9b0rV4OOBUiE5ry4bvNMH8O3JYHP8RclCp7J1P7jRlNI+hs3QNVvJtZFpNYdtGl7r8UGOQvrEu4iUK5m9BnPoQdc1f/UUfX4UPpGY18/jE+ys3Sr7lWF03Mxsl4cAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722208; c=relaxed/simple;
	bh=Xqh4B+sUDvJ3x+P/Nra1mgdos4mKkL6n6Q6KJJj5LS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1r+BgLEa9Nwl/8OFS/k5U2eC1/yWJrJDctYuhzN2BlS1oni1i3cNHVFown6tU1J0kC0CGZ9v/MTDc259FGfafB/qCUoWjYdC7/JKWzkXtAcfWjij1ZcfaEsY+x4v5+uVPdZiMUTYJ4xirOHhu11Cr0CkyPCGVOskMOTYOqf8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY9JtzbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C3CC433C7;
	Wed,  6 Mar 2024 10:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722208;
	bh=Xqh4B+sUDvJ3x+P/Nra1mgdos4mKkL6n6Q6KJJj5LS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BY9JtzbDUzRsNQt4EJopgg+AAYwwU82lsMaVLxc1eBvp25zBOKDks2MwdeAGlqwU7
	 5LhIk6J1cwxuRdGr96+u76iTOk9r9V6lZmflK+4YLLzB1ZToRQT/FB49xhIpwVvsku
	 K39Xrrq8r9nKt67G+cGYwnfxn8SsHKzmPX/dMYBrK2es7YWaiNJZ9YP68bWc1Af65s
	 ZFOfa+jJWQ7pD0S+Ht2k4gx2EpTIkfOHvvrPzgq628wBoZsKC1FkoWaijRxzQVeDRA
	 SMxwrgMXnfjAnaijIUqtcC9unt0d2TroMHwBq0OQbOecmeX6VIRADXKsOe5w59ngrW
	 ZsuATFd1BM7jg==
Date: Wed, 6 Mar 2024 11:50:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bill O'Donnell <billodo@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] vfs: Convert debugfs to use the new mount API
Message-ID: <20240306-beehrt-abweichen-a9124be7665a@brauner>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
 <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com>

On Tue, Mar 05, 2024 at 05:08:39PM -0600, Eric Sandeen wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Convert the debugfs filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.txt for more information.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-developed-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> [sandeen: forward port to modern kernel, fix remounting]
> cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  fs/debugfs/inode.c | 198 +++++++++++++++++++++------------------------
>  1 file changed, 93 insertions(+), 105 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 034a617cb1a5..c2adfb272da8 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -14,7 +14,8 @@
>  
>  #include <linux/module.h>
>  #include <linux/fs.h>
> -#include <linux/mount.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/pagemap.h>
>  #include <linux/init.h>
>  #include <linux/kobject.h>
> @@ -23,7 +24,6 @@
>  #include <linux/fsnotify.h>
>  #include <linux/string.h>
>  #include <linux/seq_file.h>
> -#include <linux/parser.h>
>  #include <linux/magic.h>
>  #include <linux/slab.h>
>  #include <linux/security.h>
> @@ -77,7 +77,7 @@ static struct inode *debugfs_get_inode(struct super_block *sb)
>  	return inode;
>  }
>  
> -struct debugfs_mount_opts {
> +struct debugfs_fs_info {
>  	kuid_t uid;
>  	kgid_t gid;
>  	umode_t mode;
> @@ -89,68 +89,51 @@ enum {
>  	Opt_uid,
>  	Opt_gid,
>  	Opt_mode,
> -	Opt_err
>  };
>  
> -static const match_table_t tokens = {
> -	{Opt_uid, "uid=%u"},
> -	{Opt_gid, "gid=%u"},
> -	{Opt_mode, "mode=%o"},
> -	{Opt_err, NULL}
> +static const struct fs_parameter_spec debugfs_param_specs[] = {
> +	fsparam_u32	("gid",		Opt_gid),
> +	fsparam_u32oct	("mode",	Opt_mode),
> +	fsparam_u32	("uid",		Opt_uid),
> +	{}
>  };
>  
> -struct debugfs_fs_info {
> -	struct debugfs_mount_opts mount_opts;
> -};
> -
> -static int debugfs_parse_options(char *data, struct debugfs_mount_opts *opts)
> +static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> -	substring_t args[MAX_OPT_ARGS];
> -	int option;
> -	int token;
> +	struct debugfs_fs_info *opts = fc->s_fs_info;
> +	struct fs_parse_result result;
>  	kuid_t uid;
>  	kgid_t gid;
> -	char *p;
> -
> -	opts->opts = 0;
> -	opts->mode = DEBUGFS_DEFAULT_MODE;
> -
> -	while ((p = strsep(&data, ",")) != NULL) {
> -		if (!*p)
> -			continue;
> -
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case Opt_uid:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			uid = make_kuid(current_user_ns(), option);
> -			if (!uid_valid(uid))
> -				return -EINVAL;
> -			opts->uid = uid;
> -			break;
> -		case Opt_gid:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			gid = make_kgid(current_user_ns(), option);
> -			if (!gid_valid(gid))
> -				return -EINVAL;
> -			opts->gid = gid;
> -			break;
> -		case Opt_mode:
> -			if (match_octal(&args[0], &option))
> -				return -EINVAL;
> -			opts->mode = option & S_IALLUGO;
> -			break;
> -		/*
> -		 * We might like to report bad mount options here;
> -		 * but traditionally debugfs has ignored all mount options
> -		 */
> -		}
> -
> -		opts->opts |= BIT(token);
> +	int opt;
> +
> +	opt = fs_parse(fc, debugfs_param_specs, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_uid:
> +		uid = make_kuid(current_user_ns(), result.uint_32);
> +		if (!uid_valid(uid))
> +			return invalf(fc, "Unknown uid");

Fwiw, Opt_{g,u}d I would like to see that either moved completely to the
VFS or we need to provide standardized helpers.

The issue is that for a userns mountable filesytems the validation done
here isn't enough and that's easy to miss (Obviously, debugfs isn't
relevant as it's not userns mountable but still.). For example, for
in tmpfs I recently fixed a bug where validation was wrong:

        case Opt_uid:
                kuid = make_kuid(current_user_ns(), result.uint_32);
                if (!uid_valid(kuid))
                        goto bad_value;

                /*
                 * The requested uid must be representable in the
                 * filesystem's idmapping.
                 */
                if (!kuid_has_mapping(fc->user_ns, kuid))
                        goto bad_value;

                ctx->uid = kuid;
                break;

The crucial step where the {g,u}id must also be representable in the
superblock's namespace not just in the caller's was missing. So really
we should have a generic helper that we can reycle for all Opt_{g,u}id
mount options or move that Opt_{g,u}id to the VFS itself. There was some
nastiness involved in this when I last looked at this though. And all
that invalfc() reporting should then also be identical across
filesystems.

So that's a ToDo for the future.

> +		opts->uid = uid;
> +		break;
> +	case Opt_gid:
> +		gid = make_kgid(current_user_ns(), result.uint_32);
> +		if (!gid_valid(gid))
> +			return invalf(fc, "Unknown gid");
> +		opts->gid = gid;
> +		break;
> +	case Opt_mode:
> +		opts->mode = result.uint_32 & S_IALLUGO;
> +		break;
> +	/*
> +	 * We might like to report bad mount options here;
> +	 * but traditionally debugfs has ignored all mount options
> +	 */
>  	}

We can actually differentiate this. During superblock creation and
remount we're now setting fc->oldapi e.g., what I've done for btrfs in
fs/btrfs/super.c:btrfs_reconfigure_for_mount() or what I did for
fs/overlayfs/params.c:ovl_parse_param().

There's a tiny wrinkle though. We currently have no way of letting
userspace know whether a filesystem supports the new mount API or not
(see that mount option probing systemd does we recently discussed). So
if say mount(8) remounts debugfs with mount options that were ignored in
the old mount api that are now rejected in the new mount api users now
see failures they didn't see before.

For the user it's completely intransparent why that failure happens. For
them nothing changed from util-linux's perspective. So really, we should
probably continue to ignore old mount options for backward compatibility.

>  
> +	opts->opts |= BIT(opt);
> +
>  	return 0;
>  }
>  
> @@ -158,23 +141,22 @@ static void _debugfs_apply_options(struct super_block *sb, bool remount)
>  {
>  	struct debugfs_fs_info *fsi = sb->s_fs_info;
>  	struct inode *inode = d_inode(sb->s_root);
> -	struct debugfs_mount_opts *opts = &fsi->mount_opts;
>  
>  	/*
>  	 * On remount, only reset mode/uid/gid if they were provided as mount
>  	 * options.
>  	 */
>  
> -	if (!remount || opts->opts & BIT(Opt_mode)) {
> +	if (!remount || fsi->opts & BIT(Opt_mode)) {
>  		inode->i_mode &= ~S_IALLUGO;
> -		inode->i_mode |= opts->mode;
> +		inode->i_mode |= fsi->mode;
>  	}
>  
> -	if (!remount || opts->opts & BIT(Opt_uid))
> -		inode->i_uid = opts->uid;
> +	if (!remount || fsi->opts & BIT(Opt_uid))
> +		inode->i_uid = fsi->uid;
>  
> -	if (!remount || opts->opts & BIT(Opt_gid))
> -		inode->i_gid = opts->gid;
> +	if (!remount || fsi->opts & BIT(Opt_gid))
> +		inode->i_gid = fsi->gid;
>  }
>  
>  static void debugfs_apply_options(struct super_block *sb)
> @@ -187,35 +169,33 @@ static void debugfs_apply_options_remount(struct super_block *sb)
>  	_debugfs_apply_options(sb, true);
>  }
>  
> -static int debugfs_remount(struct super_block *sb, int *flags, char *data)
> +static int debugfs_reconfigure(struct fs_context *fc)
>  {
> -	int err;
> -	struct debugfs_fs_info *fsi = sb->s_fs_info;
> +	struct super_block *sb = fc->root->d_sb;
> +	struct debugfs_fs_info *sb_opts = sb->s_fs_info;
> +	struct debugfs_fs_info *new_opts = fc->s_fs_info;
>  
>  	sync_filesystem(sb);
> -	err = debugfs_parse_options(data, &fsi->mount_opts);
> -	if (err)
> -		goto fail;
>  
> +	/* structure copy of new mount options to sb */
> +	*sb_opts = *new_opts;
>  	debugfs_apply_options_remount(sb);
>  
> -fail:
> -	return err;
> +	return 0;
>  }
>  
>  static int debugfs_show_options(struct seq_file *m, struct dentry *root)
>  {
>  	struct debugfs_fs_info *fsi = root->d_sb->s_fs_info;
> -	struct debugfs_mount_opts *opts = &fsi->mount_opts;
>  
> -	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
> +	if (!uid_eq(fsi->uid, GLOBAL_ROOT_UID))
>  		seq_printf(m, ",uid=%u",
> -			   from_kuid_munged(&init_user_ns, opts->uid));
> -	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
> +			   from_kuid_munged(&init_user_ns, fsi->uid));
> +	if (!gid_eq(fsi->gid, GLOBAL_ROOT_GID))
>  		seq_printf(m, ",gid=%u",
> -			   from_kgid_munged(&init_user_ns, opts->gid));
> -	if (opts->mode != DEBUGFS_DEFAULT_MODE)
> -		seq_printf(m, ",mode=%o", opts->mode);
> +			   from_kgid_munged(&init_user_ns, fsi->gid));
> +	if (fsi->mode != DEBUGFS_DEFAULT_MODE)
> +		seq_printf(m, ",mode=%o", fsi->mode);
>  
>  	return 0;
>  }
> @@ -229,7 +209,6 @@ static void debugfs_free_inode(struct inode *inode)
>  
>  static const struct super_operations debugfs_super_operations = {
>  	.statfs		= simple_statfs,
> -	.remount_fs	= debugfs_remount,
>  	.show_options	= debugfs_show_options,
>  	.free_inode	= debugfs_free_inode,
>  };
> @@ -263,26 +242,14 @@ static const struct dentry_operations debugfs_dops = {
>  	.d_automount = debugfs_automount,
>  };
>  
> -static int debug_fill_super(struct super_block *sb, void *data, int silent)
> +static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	static const struct tree_descr debug_files[] = {{""}};
> -	struct debugfs_fs_info *fsi;
>  	int err;
>  
> -	fsi = kzalloc(sizeof(struct debugfs_fs_info), GFP_KERNEL);
> -	sb->s_fs_info = fsi;
> -	if (!fsi) {
> -		err = -ENOMEM;
> -		goto fail;
> -	}
> -
> -	err = debugfs_parse_options(data, &fsi->mount_opts);
> +	err = simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
>  	if (err)
> -		goto fail;
> -
> -	err  =  simple_fill_super(sb, DEBUGFS_MAGIC, debug_files);
> -	if (err)
> -		goto fail;
> +		return err;
>  
>  	sb->s_op = &debugfs_super_operations;
>  	sb->s_d_op = &debugfs_dops;
> @@ -290,27 +257,48 @@ static int debug_fill_super(struct super_block *sb, void *data, int silent)
>  	debugfs_apply_options(sb);
>  
>  	return 0;
> -
> -fail:
> -	kfree(fsi);
> -	sb->s_fs_info = NULL;
> -	return err;
>  }
>  
> -static struct dentry *debug_mount(struct file_system_type *fs_type,
> -			int flags, const char *dev_name,
> -			void *data)
> +static int debugfs_get_tree(struct fs_context *fc)
>  {
>  	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
> -		return ERR_PTR(-EPERM);
> +		return -EPERM;
> +
> +	return get_tree_single(fc, debugfs_fill_super);
> +}
> +
> +static void debugfs_free_fc(struct fs_context *fc)
> +{
> +	kfree(fc->s_fs_info);
> +}
>  
> -	return mount_single(fs_type, flags, data, debug_fill_super);
> +static const struct fs_context_operations debugfs_context_ops = {
> +	.free		= debugfs_free_fc,
> +	.parse_param	= debugfs_parse_param,
> +	.get_tree	= debugfs_get_tree,
> +	.reconfigure	= debugfs_reconfigure,
> +};
> +
> +static int debugfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct debugfs_fs_info *fsi;
> +
> +	fsi = kzalloc(sizeof(struct debugfs_fs_info), GFP_KERNEL);
> +	if (!fsi)
> +		return -ENOMEM;
> +
> +	fsi->mode = DEBUGFS_DEFAULT_MODE;
> +
> +	fc->s_fs_info = fsi;
> +	fc->ops = &debugfs_context_ops;
> +	return 0;
>  }
>  
>  static struct file_system_type debug_fs_type = {
>  	.owner =	THIS_MODULE,
>  	.name =		"debugfs",
> -	.mount =	debug_mount,
> +	.init_fs_context = debugfs_init_fs_context,
> +	.parameters =	debugfs_param_specs,
>  	.kill_sb =	kill_litter_super,
>  };
>  MODULE_ALIAS_FS("debugfs");
> -- 
> 2.43.0
> 
> 

