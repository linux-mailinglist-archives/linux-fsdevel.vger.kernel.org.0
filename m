Return-Path: <linux-fsdevel+bounces-10871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A827284EECE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 03:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB11F26B67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080C6139E;
	Fri,  9 Feb 2024 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA+ybCGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674CFEA4
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444603; cv=none; b=PIdwJ0XE6Bk7R77CvGIyhzAohFzGX4Ll4UcOGfUKs3ZRSyLIC4N5n1+ASf/mimw5FaNSD1e4ZCgbMjB+2XWgBVmJtDGZk9WRUKU7hR8kL57PdCDCH4UX9sqb4Rnjhw6MKFlX4sSY8/09BVX33/xlsNctluWsp4SSGG9LPXZCbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444603; c=relaxed/simple;
	bh=eRU+btySBBf/pGfbLVhsX9184UgOj7DoBXE9c/WbYrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KGF2Kfy+YmJfe8qNZ/5r+AaIz5ag5/uPbkUkU46K4BjDyKVV/i0zsUQgVlL7VLF3xlBg0i0R1T61j6JYU9PEqxkF+RZu4p/od2v03KFMIgqgQddWwX+EhjXFkLixZwaK30NOyzEG0PIXjrwp5ZltnOVNiKSimyakIprTxw0EAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA+ybCGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71065C433C7;
	Fri,  9 Feb 2024 02:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707444602;
	bh=eRU+btySBBf/pGfbLVhsX9184UgOj7DoBXE9c/WbYrw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=OA+ybCGL5b2KPcPfPPwFtzUF+PV8JpfcwhFTrg3fOiC25hqbqYOmwCWsQvdb+xqkA
	 yXFbzX+at1HsdMbuv4mnBwypxC6ozeEtBlD3bhhWMGqJDE5kWluoeKg1A4fs4eQl9y
	 orPuTCRvkGxGi3pXsChJCN51QzmSjuMmpr8dix7d2FeMyN2L0ULBO6U5ueEjCS6eqk
	 shIurSIvuauYpmWGwI4/zXO4Trwga1X7meqsHY9rvpVYahc5dqsJoLrCOQ8C0/urGZ
	 lw5QRQN8/UQsZWfA2xCZwd7wzJRbhlWXFNmh9K+bUvghKB89ayzWCfXVclF3Cusm1b
	 VREUj6/58Zudw==
Message-ID: <54dca606-e67f-4933-b8ca-a5e2095193ae@kernel.org>
Date: Fri, 9 Feb 2024 11:10:00 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: convert zonefs to use the new mount api
Content-Language: en-US
To: Bill O'Donnell <bodonnel@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20240209000857.21040-1-bodonnel@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240209000857.21040-1-bodonnel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 09:08, Bill O'Donnell wrote:
> Convert the zonefs filesystem to use the new mount API.
> Tested using the zonefs test suite from:
> https://github.com/damien-lemoal/zonefs-tools
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>

Thanks for doing this. I will run tests on this but I do have a few nits below.

> ---
>  fs/zonefs/super.c | 156 ++++++++++++++++++++++++++--------------------
>  1 file changed, 90 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index e6a75401677d..6b8ecd2e55b8 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -15,13 +15,13 @@
>  #include <linux/writeback.h>
>  #include <linux/quotaops.h>
>  #include <linux/seq_file.h>
> -#include <linux/parser.h>
>  #include <linux/uio.h>
>  #include <linux/mman.h>
>  #include <linux/sched/mm.h>
>  #include <linux/crc32.h>
>  #include <linux/task_io_accounting_ops.h>
> -
> +#include <linux/fs_parser.h>
> +#include <linux/fs_context.h>

Please keep the whiteline here.

>  #include "zonefs.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -460,58 +460,47 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  }
>  
>  enum {
> -	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,
> -	Opt_explicit_open, Opt_err,
> +	Opt_errors, Opt_explicit_open,
>  };
>  
> -static const match_table_t tokens = {
> -	{ Opt_errors_ro,	"errors=remount-ro"},
> -	{ Opt_errors_zro,	"errors=zone-ro"},
> -	{ Opt_errors_zol,	"errors=zone-offline"},
> -	{ Opt_errors_repair,	"errors=repair"},
> -	{ Opt_explicit_open,	"explicit-open" },
> -	{ Opt_err,		NULL}
> +struct zonefs_context {
> +	unsigned long s_mount_opts;
>  };
>  
> -static int zonefs_parse_options(struct super_block *sb, char *options)
> -{
> -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> -	substring_t args[MAX_OPT_ARGS];
> -	char *p;
> -
> -	if (!options)
> -		return 0;
> -
> -	while ((p = strsep(&options, ",")) != NULL) {
> -		int token;
> +static const struct constant_table zonefs_param_errors[] = {
> +	{"remount-ro",		ZONEFS_MNTOPT_ERRORS_RO},
> +	{"zone-ro",		ZONEFS_MNTOPT_ERRORS_ZRO},
> +	{"zone-offline",	ZONEFS_MNTOPT_ERRORS_ZOL},
> +	{"repair", 		ZONEFS_MNTOPT_ERRORS_REPAIR},
> +	{}
> +};
>  
> -		if (!*p)
> -			continue;
> +static const struct fs_parameter_spec zonefs_param_spec[] = {
> +	fsparam_enum	("errors",		Opt_errors, zonefs_param_errors),
> +	fsparam_flag	("explicit-open",	Opt_explicit_open),
> +	{}
> +};
>  
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case Opt_errors_ro:
> -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_RO;
> -			break;
> -		case Opt_errors_zro:
> -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_ZRO;
> -			break;
> -		case Opt_errors_zol:
> -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_ZOL;
> -			break;
> -		case Opt_errors_repair:
> -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_REPAIR;
> -			break;
> -		case Opt_explicit_open:
> -			sbi->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +static int zonefs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct zonefs_context *ctx = fc->fs_private;
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	opt = fs_parse(fc, zonefs_param_spec, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_errors:
> +		ctx->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> +		ctx->s_mount_opts |= result.uint_32;
> +		break;
> +	case Opt_explicit_open:
> +		ctx->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
>  	return 0;
> @@ -533,11 +522,19 @@ static int zonefs_show_options(struct seq_file *seq, struct dentry *root)
>  	return 0;
>  }
>  
> -static int zonefs_remount(struct super_block *sb, int *flags, char *data)
> +static int zonefs_get_tree(struct fs_context *fc);

Why the forward definition ? It seems that you could define this function here
directly.

> +
> +static int zonefs_reconfigure(struct fs_context *fc)
>  {
> -	sync_filesystem(sb);
> +	struct zonefs_context *ctx = fc->fs_private;
> +	struct super_block *sb = fc->root->d_sb;
> +	struct zonefs_sb_info *sbi = sb->s_fs_info;
>  
> -	return zonefs_parse_options(sb, data);
> +	sync_filesystem(fc->root->d_sb);
> +	/* Copy new options from ctx into sbi. */
> +	sbi->s_mount_opts = ctx->s_mount_opts;
> +
> +	return 0;
>  }
>  
>  static int zonefs_inode_setattr(struct mnt_idmap *idmap,
> @@ -1197,7 +1194,6 @@ static const struct super_operations zonefs_sops = {
>  	.alloc_inode	= zonefs_alloc_inode,
>  	.free_inode	= zonefs_free_inode,
>  	.statfs		= zonefs_statfs,
> -	.remount_fs	= zonefs_remount,
>  	.show_options	= zonefs_show_options,
>  };
>  
> @@ -1242,9 +1238,10 @@ static void zonefs_release_zgroup_inodes(struct super_block *sb)
>   * sub-directories and files according to the device zone configuration and
>   * format options.
>   */
> -static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
> +static int zonefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct zonefs_sb_info *sbi;
> +	struct zonefs_context *ctx = fc->fs_private;
>  	struct inode *inode;
>  	enum zonefs_ztype ztype;
>  	int ret;
> @@ -1281,21 +1278,17 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->s_uid = GLOBAL_ROOT_UID;
>  	sbi->s_gid = GLOBAL_ROOT_GID;
>  	sbi->s_perm = 0640;
> -	sbi->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
> -
> +	sbi->s_mount_opts = ctx->s_mount_opts;

Please keep the white line here...

>  	atomic_set(&sbi->s_wro_seq_files, 0);
>  	sbi->s_max_wro_seq_files = bdev_max_open_zones(sb->s_bdev);
>  	atomic_set(&sbi->s_active_seq_files, 0);
> +

...and remove this one. The initializations here are "grouped" together byt
"theme" (sbi standard stuff first and zone resource accounting in a second
"paragraph". I like to keep it that way.

>  	sbi->s_max_active_seq_files = bdev_max_active_zones(sb->s_bdev);
>  
>  	ret = zonefs_read_super(sb);
>  	if (ret)
>  		return ret;
>  
> -	ret = zonefs_parse_options(sb, data);
> -	if (ret)
> -		return ret;
> -
>  	zonefs_info(sb, "Mounting %u zones", bdev_nr_zones(sb->s_bdev));
>  
>  	if (!sbi->s_max_wro_seq_files &&
> @@ -1356,12 +1349,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	return ret;
>  }
>  
> -static struct dentry *zonefs_mount(struct file_system_type *fs_type,
> -				   int flags, const char *dev_name, void *data)
> -{
> -	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);
> -}
> -
>  static void zonefs_kill_super(struct super_block *sb)
>  {
>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> @@ -1376,17 +1363,54 @@ static void zonefs_kill_super(struct super_block *sb)
>  	kfree(sbi);
>  }
>  
> +static void zonefs_free_fc(struct fs_context *fc)
> +{
> +	struct zonefs_context *ctx = fc->fs_private;

I do not think you need this variable.

> +
> +	kfree(ctx);

Is it safe to not set fc->fs_private to NULL ?

> +}
> +
> +static const struct fs_context_operations zonefs_context_ops = {
> +	.parse_param    = zonefs_parse_param,
> +	.get_tree       = zonefs_get_tree,
> +	.reconfigure	= zonefs_reconfigure,
> +	.free           = zonefs_free_fc,
> +};
> +
> +/*
> + * Set up the filesystem mount context.
> + */
> +static int zonefs_init_fs_context(struct fs_context *fc)
> +{
> +	struct zonefs_context *ctx;
> +
> +	ctx = kzalloc(sizeof(struct zonefs_context), GFP_KERNEL);
> +	if (!ctx)
> +		return 0;

return 0 ? Shouldn't this be "return -ENOMEM" ?

> +	ctx->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
> +	fc->ops = &zonefs_context_ops;
> +	fc->fs_private = ctx;
> +
> +	return 0;
> +}
> +
>  /*
>   * File system definition and registration.
>   */
>  static struct file_system_type zonefs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "zonefs",
> -	.mount		= zonefs_mount,
>  	.kill_sb	= zonefs_kill_super,
>  	.fs_flags	= FS_REQUIRES_DEV,
> +	.init_fs_context	= zonefs_init_fs_context,
> +	.parameters	= zonefs_param_spec,

Please re-align everything together.

>  };
>  
> +static int zonefs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_bdev(fc, zonefs_fill_super);
> +}
> +
>  static int __init zonefs_init_inodecache(void)
>  {
>  	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",

-- 
Damien Le Moal
Western Digital Research


