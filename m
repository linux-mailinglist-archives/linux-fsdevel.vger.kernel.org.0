Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEE33ED7B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhHPNlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 09:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239294AbhHPNlH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C10906324D;
        Mon, 16 Aug 2021 13:40:33 +0000 (UTC)
Date:   Mon, 16 Aug 2021 15:40:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 1/4] fs/ntfs3: Use new api for mounting
Message-ID: <20210816134030.r63djan72nbrx66k@wittgenstein>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
 <20210816024703.107251-2-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210816024703.107251-2-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:47:00AM +0300, Kari Argillander wrote:
> We have now new mount api as described in Documentation/filesystems. We
> should use it as it gives us some benefits which are desribed here
> https://lore.kernel.org/linux-fsdevel/159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk/
> 
> Nls loading is changed a little bit because new api not have default
> optioni for mount parameters. So we need to load nls table before and
> change that if user specifie someting else.
> 
> Also try to use fsparam_flag_no as much as possible. This is just nice
> little touch and is not mandatory but it should not make any harm. It
> is just convenient that we can use example acl/noacl mount options.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  fs/ntfs3/super.c | 382 ++++++++++++++++++++++++-----------------------
>  1 file changed, 193 insertions(+), 189 deletions(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 6be13e256c1a..d805e0b31404 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -28,10 +28,11 @@
>  #include <linux/buffer_head.h>
>  #include <linux/exportfs.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/iversion.h>
>  #include <linux/module.h>
>  #include <linux/nls.h>
> -#include <linux/parser.h>
>  #include <linux/seq_file.h>
>  #include <linux/statfs.h>
>  
> @@ -197,6 +198,30 @@ void *ntfs_put_shared(void *ptr)
>  	return ret;
>  }
>  
> +/*
> + * ntfs_load_nls
> + *
> + * Load nls table or if @nls is utf8 then return NULL because
> + * nls=utf8 is totally broken.
> + */
> +static struct nls_table *ntfs_load_nls(char *nls)
> +{
> +	struct nls_table *ret;
> +
> +	if (!nls)
> +		return ERR_PTR(-EINVAL);
> +	if (strcmp(nls, "utf8"))
> +		return NULL;
> +	if (strcmp(nls, CONFIG_NLS_DEFAULT))
> +		return load_nls_default();
> +
> +	ret = load_nls(nls);
> +	if (!ret)
> +		return ERR_PTR(-EINVAL);
> +
> +	return ret;
> +}
> +
>  static inline void clear_mount_options(struct ntfs_mount_options *options)
>  {
>  	unload_nls(options->nls);
> @@ -222,208 +247,164 @@ enum Opt {
>  	Opt_err,
>  };
>  
> -static const match_table_t ntfs_tokens = {
> -	{ Opt_uid, "uid=%u" },
> -	{ Opt_gid, "gid=%u" },
> -	{ Opt_umask, "umask=%o" },
> -	{ Opt_dmask, "dmask=%o" },
> -	{ Opt_fmask, "fmask=%o" },
> -	{ Opt_immutable, "sys_immutable" },
> -	{ Opt_discard, "discard" },
> -	{ Opt_force, "force" },
> -	{ Opt_sparse, "sparse" },
> -	{ Opt_nohidden, "nohidden" },
> -	{ Opt_acl, "acl" },
> -	{ Opt_noatime, "noatime" },
> -	{ Opt_showmeta, "showmeta" },
> -	{ Opt_nls, "nls=%s" },
> -	{ Opt_prealloc, "prealloc" },
> -	{ Opt_no_acs_rules, "no_acs_rules" },
> -	{ Opt_err, NULL },
> +// clang-format off
> +static const struct fs_parameter_spec ntfs_fs_parameters[] = {
> +	fsparam_u32("uid",			Opt_uid),
> +	fsparam_u32("gid",			Opt_gid),
> +	fsparam_u32oct("umask",			Opt_umask),
> +	fsparam_u32oct("dmask",			Opt_dmask),
> +	fsparam_u32oct("fmask",			Opt_fmask),
> +	fsparam_flag_no("sys_immutable",	Opt_immutable),
> +	fsparam_flag_no("discard",		Opt_discard),
> +	fsparam_flag_no("force",		Opt_force),
> +	fsparam_flag_no("sparse",		Opt_sparse),
> +	fsparam_flag("nohidden",		Opt_nohidden),
> +	fsparam_flag_no("acl",			Opt_acl),
> +	fsparam_flag("noatime",			Opt_noatime),
> +	fsparam_flag_no("showmeta",		Opt_showmeta),
> +	fsparam_string("nls",			Opt_nls),
> +	fsparam_flag_no("prealloc",		Opt_prealloc),
> +	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
> +	{}
>  };
> +// clang-format on
>  
> -static noinline int ntfs_parse_options(struct super_block *sb, char *options,
> -				       int silent,
> -				       struct ntfs_mount_options *opts)
> +static void ntfs_default_options(struct ntfs_mount_options *opts)
>  {
> -	char *p;
> -	substring_t args[MAX_OPT_ARGS];
> -	int option;
> -	char nls_name[30];
> -	struct nls_table *nls;
> -
>  	opts->fs_uid = current_uid();
>  	opts->fs_gid = current_gid();
> -	opts->fs_fmask_inv = opts->fs_dmask_inv = ~current_umask();
> -	nls_name[0] = 0;
> -
> -	if (!options)
> -		goto out;
> +	opts->fs_fmask_inv = ~current_umask();
> +	opts->fs_dmask_inv = ~current_umask();
> +	opts->nls = ntfs_load_nls(CONFIG_NLS_DEFAULT);
> +}
>  
> -	while ((p = strsep(&options, ","))) {
> -		int token;
> +static int ntfs_fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct ntfs_sb_info *sbi = fc->s_fs_info;
> +	struct ntfs_mount_options *opts = &sbi->options;
> +	struct fs_parse_result result;
> +	int opt;
>  
> -		if (!*p)
> -			continue;
> +	opt = fs_parse(fc, ntfs_fs_parameters, param, &result);
> +	if (opt < 0)
> +		return opt;
>  
> -		token = match_token(p, ntfs_tokens, args);
> -		switch (token) {
> -		case Opt_immutable:
> -			opts->sys_immutable = 1;
> -			break;
> -		case Opt_uid:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_uid = make_kuid(current_user_ns(), option);
> -			if (!uid_valid(opts->fs_uid))
> -				return -EINVAL;
> -			opts->uid = 1;
> -			break;
> -		case Opt_gid:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_gid = make_kgid(current_user_ns(), option);
> -			if (!gid_valid(opts->fs_gid))
> -				return -EINVAL;
> -			opts->gid = 1;
> -			break;
> -		case Opt_umask:
> -			if (match_octal(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_fmask_inv = opts->fs_dmask_inv = ~option;
> -			opts->fmask = opts->dmask = 1;
> -			break;
> -		case Opt_dmask:
> -			if (match_octal(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_dmask_inv = ~option;
> -			opts->dmask = 1;
> -			break;
> -		case Opt_fmask:
> -			if (match_octal(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_fmask_inv = ~option;
> -			opts->fmask = 1;
> -			break;
> -		case Opt_discard:
> -			opts->discard = 1;
> -			break;
> -		case Opt_force:
> -			opts->force = 1;
> -			break;
> -		case Opt_sparse:
> -			opts->sparse = 1;
> -			break;
> -		case Opt_nohidden:
> -			opts->nohidden = 1;
> -			break;
> -		case Opt_acl:
> +	switch (opt) {
> +	case Opt_uid:
> +		opts->fs_uid = make_kuid(current_user_ns(), result.uint_32);
> +		if (!uid_valid(opts->fs_uid))
> +			return -EINVAL;
> +		opts->uid = 1;
> +		break;
> +	case Opt_gid:
> +		opts->fs_gid = make_kgid(current_user_ns(), result.uint_32);
> +		if (!gid_valid(opts->fs_gid))
> +			return -EINVAL;
> +		opts->gid = 1;
> +		break;
> +	case Opt_umask:
> +		opts->fs_fmask_inv = ~result.uint_32;
> +		opts->fs_dmask_inv = ~result.uint_32;
> +		opts->fmask = 1;
> +		opts->dmask = 1;
> +		break;
> +	case Opt_dmask:
> +		opts->fs_dmask_inv = ~result.uint_32;
> +		opts->dmask = 1;
> +		break;
> +	case Opt_fmask:
> +		opts->fs_fmask_inv = ~result.uint_32;
> +		opts->fmask = 1;
> +		break;
> +	case Opt_immutable:
> +		opts->sys_immutable = result.negated ? 0 : 1;
> +		break;
> +	case Opt_discard:
> +		opts->discard = result.negated ? 0 : 1;
> +		break;
> +	case Opt_force:
> +		opts->force = result.negated ? 0 : 1;
> +		break;
> +	case Opt_sparse:
> +		opts->sparse = result.negated ? 0 : 1;
> +		break;
> +	case Opt_nohidden:
> +		opts->nohidden = 1;
> +		break;
> +	case Opt_acl:
> +		if (!result.negated)
>  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
> -			sb->s_flags |= SB_POSIXACL;
> -			break;
> +			fc->sb_flags |= SB_POSIXACL;
>  #else
> -			ntfs_err(sb, "support for ACL not compiled in!");
> -			return -EINVAL;
> +			return invalf(fc, "ntfs3: Support for ACL not compiled in!");
>  #endif
> -		case Opt_noatime:
> -			sb->s_flags |= SB_NOATIME;
> -			break;
> -		case Opt_showmeta:
> -			opts->showmeta = 1;
> -			break;
> -		case Opt_nls:
> -			match_strlcpy(nls_name, &args[0], sizeof(nls_name));
> -			break;
> -		case Opt_prealloc:
> -			opts->prealloc = 1;
> -			break;
> -		case Opt_no_acs_rules:
> -			opts->no_acs_rules = 1;
> -			break;
> -		default:
> -			if (!silent)
> -				ntfs_err(
> -					sb,
> -					"Unrecognized mount option \"%s\" or missing value",
> -					p);
> -			//return -EINVAL;
> +		else
> +			fc->sb_flags &= ~SB_POSIXACL;
> +		break;
> +	case Opt_noatime:
> +		fc->sb_flags |= SB_NOATIME;
> +		break;
> +	case Opt_showmeta:
> +		opts->showmeta = result.negated ? 0 : 1;
> +		break;
> +	case Opt_nls:
> +		unload_nls(opts->nls);
> +
> +		opts->nls = ntfs_load_nls(param->string);
> +		if (IS_ERR(opts->nls)) {
> +			return invalf(fc, "ntfs3: Cannot load nls %s",
> +				      param->string);
>  		}
> -	}
>  
> -out:
> -	if (!strcmp(nls_name[0] ? nls_name : CONFIG_NLS_DEFAULT, "utf8")) {
> -		/* For UTF-8 use utf16s_to_utf8s/utf8s_to_utf16s instead of nls */
> -		nls = NULL;
> -	} else if (nls_name[0]) {
> -		nls = load_nls(nls_name);
> -		if (!nls) {
> -			ntfs_err(sb, "failed to load \"%s\"", nls_name);
> -			return -EINVAL;
> -		}
> -	} else {
> -		nls = load_nls_default();
> -		if (!nls) {
> -			ntfs_err(sb, "failed to load default nls");
> -			return -EINVAL;
> -		}
> +		param->string = NULL;
> +		break;
> +	case Opt_prealloc:
> +		opts->prealloc = result.negated ? 0 : 1;
> +		break;
> +	case Opt_no_acs_rules:
> +		opts->no_acs_rules = 1;
> +		break;
> +	default:
> +		/* Should not be here unless we forget add case. */
> +		return -EINVAL;
>  	}
> -	opts->nls = nls;
> -
>  	return 0;
>  }
>  
> -static int ntfs_remount(struct super_block *sb, int *flags, char *data)
> +static int ntfs_fs_reconfigure(struct fs_context *fc)
>  {
> -	int err, ro_rw;
> +	int ro_rw;
> +	struct super_block *sb = fc->root->d_sb;
>  	struct ntfs_sb_info *sbi = sb->s_fs_info;
> -	struct ntfs_mount_options old_opts;
> -	char *orig_data = kstrdup(data, GFP_KERNEL);
> -
> -	if (data && !orig_data)
> -		return -ENOMEM;
> -
> -	/* Store  original options */
> -	memcpy(&old_opts, &sbi->options, sizeof(old_opts));
> -	clear_mount_options(&sbi->options);
> -	memset(&sbi->options, 0, sizeof(sbi->options));
> -
> -	err = ntfs_parse_options(sb, data, 0, &sbi->options);
> -	if (err)
> -		goto restore_opts;
> +	struct ntfs_mount_options *new_opts = fc->s_fs_info;
> +	int *flags = &fc->sb_flags;

Afaict this doesn't need to be a pointer anymore.
fscontext->reconfigure() doesn't have a int *flags parameter.

>  
>  	ro_rw = sb_rdonly(sb) && !(*flags & SB_RDONLY);
>  	if (ro_rw && (sbi->flags & NTFS_FLAGS_NEED_REPLAY)) {
> -		ntfs_warn(
> -			sb,
> +		ntfs_warn(sb,
>  			"Couldn't remount rw because journal is not replayed. Please umount/remount instead\n");
> -		err = -EINVAL;
> -		goto restore_opts;
> +		goto clear_new_mount;
>  	}
>  
>  	sync_filesystem(sb);
>  
>  	if (ro_rw && (sbi->volume.flags & VOLUME_FLAG_DIRTY) &&
> -	    !sbi->options.force) {
> +	    !new_opts->force) {
>  		ntfs_warn(sb, "volume is dirty and \"force\" flag is not set!");
> -		err = -EINVAL;
> -		goto restore_opts;
> +		goto clear_new_mount;
>  	}
>  
> -	clear_mount_options(&old_opts);
> +	*flags |= (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME) |
> +		  SB_NODIRATIME | SB_NOATIME;
>  
> -	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME) |
> -		 SB_NODIRATIME | SB_NOATIME;
> -	ntfs_info(sb, "re-mounted. Opts: %s", orig_data);
> -	err = 0;
> -	goto out;
> -
> -restore_opts:
>  	clear_mount_options(&sbi->options);
> -	memcpy(&sbi->options, &old_opts, sizeof(old_opts));
> +	sbi->options = *new_opts;
>  
> -out:
> -	kfree(orig_data);
> -	return err;
> +	return 0;
> +
> +clear_new_mount:
> +	clear_mount_options(new_opts);
> +	return -EINVAL;
>  }
>  
>  static struct kmem_cache *ntfs_inode_cachep;
> @@ -628,7 +609,6 @@ static const struct super_operations ntfs_sops = {
>  	.statfs = ntfs_statfs,
>  	.show_options = ntfs_show_options,
>  	.sync_fs = ntfs_sync_fs,
> -	.remount_fs = ntfs_remount,
>  	.write_inode = ntfs3_write_inode,
>  };
>  
> @@ -892,10 +872,10 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>  }
>  
>  /* try to mount*/
> -static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
> +static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	int err;
> -	struct ntfs_sb_info *sbi;
> +	struct ntfs_sb_info *sbi = sb->s_fs_info;
>  	struct block_device *bdev = sb->s_bdev;
>  	struct inode *bd_inode = bdev->bd_inode;
>  	struct request_queue *rq = bdev_get_queue(bdev);
> @@ -914,11 +894,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	ref.high = 0;
>  
> -	sbi = ntfs_zalloc(sizeof(struct ntfs_sb_info));
> -	if (!sbi)
> -		return -ENOMEM;
> -
> -	sb->s_fs_info = sbi;
>  	sbi->sb = sb;
>  	sb->s_flags |= SB_NODIRATIME;
>  	sb->s_magic = 0x7366746e; // "ntfs"
> @@ -930,10 +905,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
>  	ratelimit_state_init(&sbi->msg_ratelimit, DEFAULT_RATELIMIT_INTERVAL,
>  			     DEFAULT_RATELIMIT_BURST);
>  
> -	err = ntfs_parse_options(sb, data, silent, &sbi->options);
> -	if (err)
> -		goto out;
> -
>  	if (!rq || !blk_queue_discard(rq) || !rq->limits.discard_granularity) {
>  		;
>  	} else {
> @@ -1409,19 +1380,52 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
>  	return err;
>  }
>  
> -static struct dentry *ntfs_mount(struct file_system_type *fs_type, int flags,
> -				 const char *dev_name, void *data)
> +static int ntfs_fs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_bdev(fc, ntfs_fill_super);
> +}
> +
> +static void ntfs_fs_free(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, ntfs_fill_super);
> +	struct ntfs_sb_info *sbi = fc->s_fs_info;
> +
> +	if (sbi)
> +		put_ntfs(sbi);
> +}
> +
> +static const struct fs_context_operations ntfs_context_ops = {
> +	.parse_param	= ntfs_fs_parse_param,
> +	.get_tree	= ntfs_fs_get_tree,
> +	.reconfigure	= ntfs_fs_reconfigure,
> +	.free		= ntfs_fs_free,
> +};
> +
> +/*
> + * Set up the filesystem mount context.
> + */
> +static int ntfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct ntfs_sb_info *sbi;
> +
> +	sbi = ntfs_zalloc(sizeof(struct ntfs_sb_info));
> +	if (!sbi)
> +		return -ENOMEM;
> +
> +	ntfs_default_options(&sbi->options);
> +
> +	fc->s_fs_info = sbi;
> +	fc->ops = &ntfs_context_ops;
> +	return 0;
>  }
>  
>  // clang-format off
>  static struct file_system_type ntfs_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name		= "ntfs3",
> -	.mount		= ntfs_mount,
> -	.kill_sb	= kill_block_super,
> -	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.owner			= THIS_MODULE,
> +	.name			= "ntfs3",
> +	.init_fs_context	= ntfs_init_fs_context,
> +	.parameters		= ntfs_fs_parameters,
> +	.kill_sb		= kill_block_super,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,

If you add idmapped mount support right away please try to make sure and
enable ntfs3 with xfstests if that's all possible.

Christian
