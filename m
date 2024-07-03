Return-Path: <linux-fsdevel+bounces-22995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A949252E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 07:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA951F25CDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 05:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8783A1B5;
	Wed,  3 Jul 2024 05:20:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4522EE8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984003; cv=none; b=ksy9hWJYUvWXXpzYKKXizJTpOD83tmBrKUe3PD/WkFhX/dJBcEMTTACW39LGD7LlEv2FwIGXi6fyei50vkt2vAK40Bodyl72jZ4YjrCkAvcF+9tvr0uyglcgemf6seUSwJre8vof7/PxTT7bMLhLbGxAfDU/H1UcMgrA3FGiP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984003; c=relaxed/simple;
	bh=ZMQmKU5ZnRzvn/Xnsl7dllgq/bvV2d1Wkk+Aadup6XA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AsjnGc/YFBEkQyhOingLuR1GansraJ6LVlRY9jVfxiRlnx4byt4IPbkxPSZAqGrqffideka2WvnGcDC3eUeHCnLwVSaxqaS9ZJXEsBldOlR9x0QOgQpijHns84gNDUPLvrdOYnitXfygjdXPLWvwd23WYkibPzcPZZ6GYmxhV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B317C2055FA2;
	Wed,  3 Jul 2024 14:19:58 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 4635JvEP114149
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 14:19:58 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 4635Jvwq681129
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 14:19:57 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4635JvM2681128;
	Wed, 3 Jul 2024 14:19:57 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH V2 2/3] fat: Convert to new mount api
In-Reply-To: <a9411b02-5f8e-4e1e-90aa-0c032d66c312@redhat.com> (Eric Sandeen's
	message of "Tue, 2 Jul 2024 17:44:27 -0500")
References: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
	<a9411b02-5f8e-4e1e-90aa-0c032d66c312@redhat.com>
Date: Wed, 03 Jul 2024 14:19:57 +0900
Message-ID: <87ed8brr0i.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sandeen <sandeen@redhat.com> writes:

> vfat and msdos share a common set of options, with additional, unique
> options for each filesystem.
>
> Each filesystem calls common fc initialization and parsing routines,
> with an "is_vfat" parameter. For parsing, if the option is not found
> in the common parameter_spec, parsing is retried with the fs-specific
> parameter_spec.
>
> This patch leaves nls loading to fill_super, so the codepage and charset
> options are not validated as they are requested. This matches current
> behavior. It would be possible to test-load as each option is parsed,
> but that would make i.e.
>
> mount -o "iocharset=nope,iocharset=iso8859-1"
>
> fail, where it does not fail today because only the last iocharset
> option is considered.
>
> The obsolete "conv=" option is set up with an enum of acceptable values;
> currently invalid "conv=" options are rejected as such, even though the
> option is obsolete, so this patch preserves that behavior.
>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.

> ---
>
> V2: address review comments:
>
> - remove unused buf variable in fat_parse_param
> - remove unnecessary externs in new prototypes
> - mark deprecated options with fs_param_deprecated
> - fix double-free of opts->codepage
> - change is_vfat parameters to boolsw
>
>  fs/fat/fat.h         |  15 +-
>  fs/fat/inode.c       | 683 ++++++++++++++++++++++---------------------
>  fs/fat/namei_msdos.c |  38 ++-
>  fs/fat/namei_vfat.c  |  38 ++-
>  4 files changed, 419 insertions(+), 355 deletions(-)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 37ced7bb06d5..d3e426de5f01 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -7,6 +7,8 @@
>  #include <linux/hash.h>
>  #include <linux/ratelimit.h>
>  #include <linux/msdos_fs.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  
>  /*
>   * vfat shortname flags
> @@ -416,12 +418,21 @@ extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
>  extern struct inode *fat_build_inode(struct super_block *sb,
>  			struct msdos_dir_entry *de, loff_t i_pos);
>  extern int fat_sync_inode(struct inode *inode);
> -extern int fat_fill_super(struct super_block *sb, void *data, int silent,
> -			  int isvfat, void (*setup)(struct super_block *));
> +extern int fat_fill_super(struct super_block *sb, struct fs_context *fc,
> +			  void (*setup)(struct super_block *));
>  extern int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de);
>  
>  extern int fat_flush_inodes(struct super_block *sb, struct inode *i1,
>  			    struct inode *i2);
> +
> +extern const struct fs_parameter_spec fat_param_spec[];
> +int fat_init_fs_context(struct fs_context *fc, bool is_vfat);
> +void fat_free_fc(struct fs_context *fc);
> +
> +int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
> +		    bool is_vfat);
> +int fat_reconfigure(struct fs_context *fc);
> +
>  static inline unsigned long fat_dir_hash(int logstart)
>  {
>  	return hash_32(logstart, FAT_HASH_BITS);
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 2a6537ba0d49..b83b39f2f69b 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -16,7 +16,6 @@
>  #include <linux/mpage.h>
>  #include <linux/vfs.h>
>  #include <linux/seq_file.h>
> -#include <linux/parser.h>
>  #include <linux/uio.h>
>  #include <linux/blkdev.h>
>  #include <linux/backing-dev.h>
> @@ -804,16 +803,17 @@ static void __exit fat_destroy_inodecache(void)
>  	kmem_cache_destroy(fat_inode_cachep);
>  }
>  
> -static int fat_remount(struct super_block *sb, int *flags, char *data)
> +int fat_reconfigure(struct fs_context *fc)
>  {
>  	bool new_rdonly;
> +	struct super_block *sb = fc->root->d_sb;
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> -	*flags |= SB_NODIRATIME | (sbi->options.isvfat ? 0 : SB_NOATIME);
> +	fc->sb_flags |= SB_NODIRATIME | (sbi->options.isvfat ? 0 : SB_NOATIME);
>  
>  	sync_filesystem(sb);
>  
>  	/* make sure we update state on remount. */
> -	new_rdonly = *flags & SB_RDONLY;
> +	new_rdonly = fc->sb_flags & SB_RDONLY;
>  	if (new_rdonly != sb_rdonly(sb)) {
>  		if (new_rdonly)
>  			fat_set_state(sb, 0, 0);
> @@ -822,6 +822,7 @@ static int fat_remount(struct super_block *sb, int *flags, char *data)
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fat_reconfigure);
>  
>  static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
> @@ -939,8 +940,6 @@ static const struct super_operations fat_sops = {
>  	.evict_inode	= fat_evict_inode,
>  	.put_super	= fat_put_super,
>  	.statfs		= fat_statfs,
> -	.remount_fs	= fat_remount,
> -
>  	.show_options	= fat_show_options,
>  };
>  
> @@ -1037,355 +1036,290 @@ static int fat_show_options(struct seq_file *m, struct dentry *root)
>  }
>  
>  enum {
> -	Opt_check_n, Opt_check_r, Opt_check_s, Opt_uid, Opt_gid,
> -	Opt_umask, Opt_dmask, Opt_fmask, Opt_allow_utime, Opt_codepage,
> -	Opt_usefree, Opt_nocase, Opt_quiet, Opt_showexec, Opt_debug,
> -	Opt_immutable, Opt_dots, Opt_nodots,
> -	Opt_charset, Opt_shortname_lower, Opt_shortname_win95,
> -	Opt_shortname_winnt, Opt_shortname_mixed, Opt_utf8_no, Opt_utf8_yes,
> -	Opt_uni_xl_no, Opt_uni_xl_yes, Opt_nonumtail_no, Opt_nonumtail_yes,
> -	Opt_obsolete, Opt_flush, Opt_tz_utc, Opt_rodir, Opt_err_cont,
> -	Opt_err_panic, Opt_err_ro, Opt_discard, Opt_nfs, Opt_time_offset,
> -	Opt_nfs_stale_rw, Opt_nfs_nostale_ro, Opt_err, Opt_dos1xfloppy,
> +	Opt_check, Opt_uid, Opt_gid, Opt_umask, Opt_dmask, Opt_fmask,
> +	Opt_allow_utime, Opt_codepage, Opt_usefree, Opt_nocase, Opt_quiet,
> +	Opt_showexec, Opt_debug, Opt_immutable, Opt_dots, Opt_dotsOK,
> +	Opt_charset, Opt_shortname, Opt_utf8, Opt_utf8_bool,
> +	Opt_uni_xl, Opt_uni_xl_bool, Opt_nonumtail, Opt_nonumtail_bool,
> +	Opt_obsolete, Opt_flush, Opt_tz, Opt_rodir, Opt_errors, Opt_discard,
> +	Opt_nfs, Opt_nfs_enum, Opt_time_offset, Opt_dos1xfloppy,
>  };
>  
> -static const match_table_t fat_tokens = {
> -	{Opt_check_r, "check=relaxed"},
> -	{Opt_check_s, "check=strict"},
> -	{Opt_check_n, "check=normal"},
> -	{Opt_check_r, "check=r"},
> -	{Opt_check_s, "check=s"},
> -	{Opt_check_n, "check=n"},
> -	{Opt_uid, "uid=%u"},
> -	{Opt_gid, "gid=%u"},
> -	{Opt_umask, "umask=%o"},
> -	{Opt_dmask, "dmask=%o"},
> -	{Opt_fmask, "fmask=%o"},
> -	{Opt_allow_utime, "allow_utime=%o"},
> -	{Opt_codepage, "codepage=%u"},
> -	{Opt_usefree, "usefree"},
> -	{Opt_nocase, "nocase"},
> -	{Opt_quiet, "quiet"},
> -	{Opt_showexec, "showexec"},
> -	{Opt_debug, "debug"},
> -	{Opt_immutable, "sys_immutable"},
> -	{Opt_flush, "flush"},
> -	{Opt_tz_utc, "tz=UTC"},
> -	{Opt_time_offset, "time_offset=%d"},
> -	{Opt_err_cont, "errors=continue"},
> -	{Opt_err_panic, "errors=panic"},
> -	{Opt_err_ro, "errors=remount-ro"},
> -	{Opt_discard, "discard"},
> -	{Opt_nfs_stale_rw, "nfs"},
> -	{Opt_nfs_stale_rw, "nfs=stale_rw"},
> -	{Opt_nfs_nostale_ro, "nfs=nostale_ro"},
> -	{Opt_dos1xfloppy, "dos1xfloppy"},
> -	{Opt_obsolete, "conv=binary"},
> -	{Opt_obsolete, "conv=text"},
> -	{Opt_obsolete, "conv=auto"},
> -	{Opt_obsolete, "conv=b"},
> -	{Opt_obsolete, "conv=t"},
> -	{Opt_obsolete, "conv=a"},
> -	{Opt_obsolete, "fat=%u"},
> -	{Opt_obsolete, "blocksize=%u"},
> -	{Opt_obsolete, "cvf_format=%20s"},
> -	{Opt_obsolete, "cvf_options=%100s"},
> -	{Opt_obsolete, "posix"},
> -	{Opt_err, NULL},
> -};
> -static const match_table_t msdos_tokens = {
> -	{Opt_nodots, "nodots"},
> -	{Opt_nodots, "dotsOK=no"},
> -	{Opt_dots, "dots"},
> -	{Opt_dots, "dotsOK=yes"},
> -	{Opt_err, NULL}
> -};
> -static const match_table_t vfat_tokens = {
> -	{Opt_charset, "iocharset=%s"},
> -	{Opt_shortname_lower, "shortname=lower"},
> -	{Opt_shortname_win95, "shortname=win95"},
> -	{Opt_shortname_winnt, "shortname=winnt"},
> -	{Opt_shortname_mixed, "shortname=mixed"},
> -	{Opt_utf8_no, "utf8=0"},		/* 0 or no or false */
> -	{Opt_utf8_no, "utf8=no"},
> -	{Opt_utf8_no, "utf8=false"},
> -	{Opt_utf8_yes, "utf8=1"},		/* empty or 1 or yes or true */
> -	{Opt_utf8_yes, "utf8=yes"},
> -	{Opt_utf8_yes, "utf8=true"},
> -	{Opt_utf8_yes, "utf8"},
> -	{Opt_uni_xl_no, "uni_xlate=0"},		/* 0 or no or false */
> -	{Opt_uni_xl_no, "uni_xlate=no"},
> -	{Opt_uni_xl_no, "uni_xlate=false"},
> -	{Opt_uni_xl_yes, "uni_xlate=1"},	/* empty or 1 or yes or true */
> -	{Opt_uni_xl_yes, "uni_xlate=yes"},
> -	{Opt_uni_xl_yes, "uni_xlate=true"},
> -	{Opt_uni_xl_yes, "uni_xlate"},
> -	{Opt_nonumtail_no, "nonumtail=0"},	/* 0 or no or false */
> -	{Opt_nonumtail_no, "nonumtail=no"},
> -	{Opt_nonumtail_no, "nonumtail=false"},
> -	{Opt_nonumtail_yes, "nonumtail=1"},	/* empty or 1 or yes or true */
> -	{Opt_nonumtail_yes, "nonumtail=yes"},
> -	{Opt_nonumtail_yes, "nonumtail=true"},
> -	{Opt_nonumtail_yes, "nonumtail"},
> -	{Opt_rodir, "rodir"},
> -	{Opt_err, NULL}
> +static const struct constant_table fat_param_check[] = {
> +	{"relaxed",	'r'},
> +	{"r",		'r'},
> +	{"strict",	's'},
> +	{"s",		's'},
> +	{"normal",	'n'},
> +	{"n",		'n'},
> +	{}
>  };
>  
> -static int parse_options(struct super_block *sb, char *options, int is_vfat,
> -			 int silent, struct fat_mount_options *opts)
> -{
> -	char *p;
> -	substring_t args[MAX_OPT_ARGS];
> -	int option;
> -	char *iocharset;
> +static const struct constant_table fat_param_tz[] = {
> +	{"UTC",		0},
> +	{}
> +};
>  
> -	opts->isvfat = is_vfat;
> +static const struct constant_table fat_param_errors[] = {
> +	{"continue",	FAT_ERRORS_CONT},
> +	{"panic",	FAT_ERRORS_PANIC},
> +	{"remount-ro",	FAT_ERRORS_RO},
> +	{}
> +};
>  
> -	opts->fs_uid = current_uid();
> -	opts->fs_gid = current_gid();
> -	opts->fs_fmask = opts->fs_dmask = current_umask();
> -	opts->allow_utime = -1;
> -	opts->codepage = fat_default_codepage;
> -	fat_reset_iocharset(opts);
> -	if (is_vfat) {
> -		opts->shortname = VFAT_SFN_DISPLAY_WINNT|VFAT_SFN_CREATE_WIN95;
> -		opts->rodir = 0;
> -	} else {
> -		opts->shortname = 0;
> -		opts->rodir = 1;
> -	}
> -	opts->name_check = 'n';
> -	opts->quiet = opts->showexec = opts->sys_immutable = opts->dotsOK =  0;
> -	opts->unicode_xlate = 0;
> -	opts->numtail = 1;
> -	opts->usefree = opts->nocase = 0;
> -	opts->tz_set = 0;
> -	opts->nfs = 0;
> -	opts->errors = FAT_ERRORS_RO;
> -	opts->debug = 0;
>  
> -	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
> +static const struct constant_table fat_param_nfs[] = {
> +	{"stale_rw",	FAT_NFS_STALE_RW},
> +	{"nostale_ro",	FAT_NFS_NOSTALE_RO},
> +	{}
> +};
>  
> -	if (!options)
> -		goto out;
> +/*
> + * These are all obsolete but we still reject invalid options.
> + * The corresponding values are therefore meaningless.
> + */
> +static const struct constant_table fat_param_conv[] = {
> +	{"binary",	0},
> +	{"text",	0},
> +	{"auto",	0},
> +	{"b",		0},
> +	{"t",		0},
> +	{"a",		0},
> +	{}
> +};
>  
> -	while ((p = strsep(&options, ",")) != NULL) {
> -		int token;
> -		if (!*p)
> -			continue;
> +/* Core options. See below for vfat and msdos extras */
> +const struct fs_parameter_spec fat_param_spec[] = {
> +	fsparam_enum	("check",	Opt_check, fat_param_check),
> +	fsparam_u32	("uid",		Opt_uid),
> +	fsparam_u32	("gid",		Opt_gid),
> +	fsparam_u32oct	("umask",	Opt_umask),
> +	fsparam_u32oct	("dmask",	Opt_dmask),
> +	fsparam_u32oct	("fmask",	Opt_fmask),
> +	fsparam_u32oct	("allow_utime",	Opt_allow_utime),
> +	fsparam_u32	("codepage",	Opt_codepage),
> +	fsparam_flag	("usefree",	Opt_usefree),
> +	fsparam_flag	("nocase",	Opt_nocase),
> +	fsparam_flag	("quiet",	Opt_quiet),
> +	fsparam_flag	("showexec",	Opt_showexec),
> +	fsparam_flag	("debug",	Opt_debug),
> +	fsparam_flag	("sys_immutable", Opt_immutable),
> +	fsparam_flag	("flush",	Opt_flush),
> +	fsparam_enum	("tz",		Opt_tz, fat_param_tz),
> +	fsparam_s32	("time_offset",	Opt_time_offset),
> +	fsparam_enum	("errors",	Opt_errors, fat_param_errors),
> +	fsparam_flag	("discard",	Opt_discard),
> +	fsparam_flag	("nfs",		Opt_nfs),
> +	fsparam_enum	("nfs",		Opt_nfs_enum, fat_param_nfs),
> +	fsparam_flag	("dos1xfloppy",	Opt_dos1xfloppy),
> +	__fsparam(fs_param_is_enum,	"conv",
> +		  Opt_obsolete, fs_param_deprecated, fat_param_conv),
> +	__fsparam(fs_param_is_u32,	"fat",
> +		  Opt_obsolete, fs_param_deprecated, NULL),
> +	__fsparam(fs_param_is_u32,	"blocksize",
> +		  Opt_obsolete, fs_param_deprecated, NULL),
> +	__fsparam(fs_param_is_string,	"cvf_format",
> +		  Opt_obsolete, fs_param_deprecated, NULL),
> +	__fsparam(fs_param_is_string,	"cvf_options",
> +		  Opt_obsolete, fs_param_deprecated, NULL),
> +	__fsparam(NULL,			"posix",
> +		  Opt_obsolete, fs_param_deprecated, NULL),
> +	{}
> +};
> +EXPORT_SYMBOL_GPL(fat_param_spec);
>  
> -		token = match_token(p, fat_tokens, args);
> -		if (token == Opt_err) {
> -			if (is_vfat)
> -				token = match_token(p, vfat_tokens, args);
> -			else
> -				token = match_token(p, msdos_tokens, args);
> -		}
> -		switch (token) {
> -		case Opt_check_s:
> -			opts->name_check = 's';
> -			break;
> -		case Opt_check_r:
> -			opts->name_check = 'r';
> -			break;
> -		case Opt_check_n:
> -			opts->name_check = 'n';
> -			break;
> -		case Opt_usefree:
> -			opts->usefree = 1;
> -			break;
> -		case Opt_nocase:
> -			if (!is_vfat)
> -				opts->nocase = 1;
> -			else {
> -				/* for backward compatibility */
> -				opts->shortname = VFAT_SFN_DISPLAY_WIN95
> -					| VFAT_SFN_CREATE_WIN95;
> -			}
> -			break;
> -		case Opt_quiet:
> -			opts->quiet = 1;
> -			break;
> -		case Opt_showexec:
> -			opts->showexec = 1;
> -			break;
> -		case Opt_debug:
> -			opts->debug = 1;
> -			break;
> -		case Opt_immutable:
> -			opts->sys_immutable = 1;
> -			break;
> -		case Opt_uid:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_uid = make_kuid(current_user_ns(), option);
> -			if (!uid_valid(opts->fs_uid))
> -				return -EINVAL;
> -			break;
> -		case Opt_gid:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_gid = make_kgid(current_user_ns(), option);
> -			if (!gid_valid(opts->fs_gid))
> -				return -EINVAL;
> -			break;
> -		case Opt_umask:
> -			if (match_octal(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_fmask = opts->fs_dmask = option;
> -			break;
> -		case Opt_dmask:
> -			if (match_octal(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_dmask = option;
> -			break;
> -		case Opt_fmask:
> -			if (match_octal(&args[0], &option))
> -				return -EINVAL;
> -			opts->fs_fmask = option;
> -			break;
> -		case Opt_allow_utime:
> -			if (match_octal(&args[0], &option))
> -				return -EINVAL;
> -			opts->allow_utime = option & (S_IWGRP | S_IWOTH);
> -			break;
> -		case Opt_codepage:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			opts->codepage = option;
> -			break;
> -		case Opt_flush:
> -			opts->flush = 1;
> -			break;
> -		case Opt_time_offset:
> -			if (match_int(&args[0], &option))
> -				return -EINVAL;
> -			/*
> -			 * GMT+-12 zones may have DST corrections so at least
> -			 * 13 hours difference is needed. Make the limit 24
> -			 * just in case someone invents something unusual.
> -			 */
> -			if (option < -24 * 60 || option > 24 * 60)
> -				return -EINVAL;
> -			opts->tz_set = 1;
> -			opts->time_offset = option;
> -			break;
> -		case Opt_tz_utc:
> -			opts->tz_set = 1;
> -			opts->time_offset = 0;
> -			break;
> -		case Opt_err_cont:
> -			opts->errors = FAT_ERRORS_CONT;
> -			break;
> -		case Opt_err_panic:
> -			opts->errors = FAT_ERRORS_PANIC;
> -			break;
> -		case Opt_err_ro:
> -			opts->errors = FAT_ERRORS_RO;
> -			break;
> -		case Opt_nfs_stale_rw:
> -			opts->nfs = FAT_NFS_STALE_RW;
> -			break;
> -		case Opt_nfs_nostale_ro:
> -			opts->nfs = FAT_NFS_NOSTALE_RO;
> -			break;
> -		case Opt_dos1xfloppy:
> -			opts->dos1xfloppy = 1;
> -			break;
> +static const struct fs_parameter_spec msdos_param_spec[] = {
> +	fsparam_flag_no	("dots",	Opt_dots),
> +	fsparam_bool	("dotsOK",	Opt_dotsOK),
> +	{}
> +};
>  
> -		/* msdos specific */
> -		case Opt_dots:
> -			opts->dotsOK = 1;
> -			break;
> -		case Opt_nodots:
> -			opts->dotsOK = 0;
> -			break;
> +static const struct constant_table fat_param_shortname[] = {
> +	{"lower",	VFAT_SFN_DISPLAY_LOWER | VFAT_SFN_CREATE_WIN95},
> +	{"win95",	VFAT_SFN_DISPLAY_WIN95 | VFAT_SFN_CREATE_WIN95},
> +	{"winnt",	VFAT_SFN_DISPLAY_WINNT | VFAT_SFN_CREATE_WINNT},
> +	{"mixed",	VFAT_SFN_DISPLAY_WINNT | VFAT_SFN_CREATE_WIN95},
> +	{}
> +};
>  
> -		/* vfat specific */
> -		case Opt_charset:
> -			fat_reset_iocharset(opts);
> -			iocharset = match_strdup(&args[0]);
> -			if (!iocharset)
> -				return -ENOMEM;
> -			opts->iocharset = iocharset;
> -			break;
> -		case Opt_shortname_lower:
> -			opts->shortname = VFAT_SFN_DISPLAY_LOWER
> -					| VFAT_SFN_CREATE_WIN95;
> -			break;
> -		case Opt_shortname_win95:
> -			opts->shortname = VFAT_SFN_DISPLAY_WIN95
> -					| VFAT_SFN_CREATE_WIN95;
> -			break;
> -		case Opt_shortname_winnt:
> -			opts->shortname = VFAT_SFN_DISPLAY_WINNT
> -					| VFAT_SFN_CREATE_WINNT;
> -			break;
> -		case Opt_shortname_mixed:
> -			opts->shortname = VFAT_SFN_DISPLAY_WINNT
> -					| VFAT_SFN_CREATE_WIN95;
> -			break;
> -		case Opt_utf8_no:		/* 0 or no or false */
> -			opts->utf8 = 0;
> -			break;
> -		case Opt_utf8_yes:		/* empty or 1 or yes or true */
> -			opts->utf8 = 1;
> -			break;
> -		case Opt_uni_xl_no:		/* 0 or no or false */
> -			opts->unicode_xlate = 0;
> -			break;
> -		case Opt_uni_xl_yes:		/* empty or 1 or yes or true */
> -			opts->unicode_xlate = 1;
> -			break;
> -		case Opt_nonumtail_no:		/* 0 or no or false */
> -			opts->numtail = 1;	/* negated option */
> -			break;
> -		case Opt_nonumtail_yes:		/* empty or 1 or yes or true */
> -			opts->numtail = 0;	/* negated option */
> -			break;
> -		case Opt_rodir:
> -			opts->rodir = 1;
> -			break;
> -		case Opt_discard:
> -			opts->discard = 1;
> -			break;
> +static const struct fs_parameter_spec vfat_param_spec[] = {
> +	fsparam_string	("iocharset",	Opt_charset),
> +	fsparam_enum	("shortname",	Opt_shortname, fat_param_shortname),
> +	fsparam_flag	("utf8",	Opt_utf8),
> +	fsparam_bool	("utf8",	Opt_utf8_bool),
> +	fsparam_flag	("uni_xlate",	Opt_uni_xl),
> +	fsparam_bool	("uni_xlate",	Opt_uni_xl_bool),
> +	fsparam_flag	("nonumtail",	Opt_nonumtail),
> +	fsparam_bool	("nonumtail",	Opt_nonumtail_bool),
> +	fsparam_flag	("rodir",	Opt_rodir),
> +	{}
> +};
>  
> -		/* obsolete mount options */
> -		case Opt_obsolete:
> -			fat_msg(sb, KERN_INFO, "\"%s\" option is obsolete, "
> -			       "not supported now", p);
> -			break;
> -		/* unknown option */
> -		default:
> -			if (!silent) {
> -				fat_msg(sb, KERN_ERR,
> -				       "Unrecognized mount option \"%s\" "
> -				       "or missing value", p);
> -			}
> -			return -EINVAL;
> -		}
> -	}
> +int fat_parse_param(struct fs_context *fc, struct fs_parameter *param,
> +			   bool is_vfat)
> +{
> +	struct fat_mount_options *opts = fc->fs_private;
> +	struct fs_parse_result result;
> +	int opt;
> +	kuid_t uid;
> +	kgid_t gid;
> +
> +	/* remount options have traditionally been ignored */
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
> +		return 0;
>  
> -out:
> -	/* UTF-8 doesn't provide FAT semantics */
> -	if (!strcmp(opts->iocharset, "utf8")) {
> -		fat_msg(sb, KERN_WARNING, "utf8 is not a recommended IO charset"
> -		       " for FAT filesystems, filesystem will be "
> -		       "case sensitive!");
> +	opt = fs_parse(fc, fat_param_spec, param, &result);
> +	/* If option not found in fat_param_spec, try vfat/msdos options */
> +	if (opt == -ENOPARAM) {
> +		if (is_vfat)
> +			opt = fs_parse(fc, vfat_param_spec, param, &result);
> +		else
> +			opt = fs_parse(fc, msdos_param_spec, param, &result);
>  	}
>  
> -	/* If user doesn't specify allow_utime, it's initialized from dmask. */
> -	if (opts->allow_utime == (unsigned short)-1)
> -		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
> -	if (opts->unicode_xlate)
> -		opts->utf8 = 0;
> -	if (opts->nfs == FAT_NFS_NOSTALE_RO) {
> -		sb->s_flags |= SB_RDONLY;
> -		sb->s_export_op = &fat_export_ops_nostale;
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_check:
> +		opts->name_check = result.uint_32;
> +		break;
> +	case Opt_usefree:
> +		opts->usefree = 1;
> +		break;
> +	case Opt_nocase:
> +		if (!is_vfat)
> +			opts->nocase = 1;
> +		else {
> +			/* for backward compatibility */
> +			opts->shortname = VFAT_SFN_DISPLAY_WIN95
> +				| VFAT_SFN_CREATE_WIN95;
> +		}
> +		break;
> +	case Opt_quiet:
> +		opts->quiet = 1;
> +		break;
> +	case Opt_showexec:
> +		opts->showexec = 1;
> +		break;
> +	case Opt_debug:
> +		opts->debug = 1;
> +		break;
> +	case Opt_immutable:
> +		opts->sys_immutable = 1;
> +		break;
> +	case Opt_uid:
> +		uid = make_kuid(current_user_ns(), result.uint_32);
> +		if (!uid_valid(uid))
> +			return -EINVAL;
> +		opts->fs_uid = uid;
> +		break;
> +	case Opt_gid:
> +		gid = make_kgid(current_user_ns(), result.uint_32);
> +		if (!gid_valid(gid))
> +			return -EINVAL;
> +		opts->fs_gid = gid;
> +		break;
> +	case Opt_umask:
> +		opts->fs_fmask = opts->fs_dmask = result.uint_32;
> +		break;
> +	case Opt_dmask:
> +		opts->fs_dmask = result.uint_32;
> +		break;
> +	case Opt_fmask:
> +		opts->fs_fmask = result.uint_32;
> +		break;
> +	case Opt_allow_utime:
> +		opts->allow_utime = result.uint_32 & (S_IWGRP | S_IWOTH);
> +		break;
> +	case Opt_codepage:
> +		opts->codepage = result.uint_32;
> +		break;
> +	case Opt_flush:
> +		opts->flush = 1;
> +		break;
> +	case Opt_time_offset:
> +		/*
> +		 * GMT+-12 zones may have DST corrections so at least
> +		 * 13 hours difference is needed. Make the limit 24
> +		 * just in case someone invents something unusual.
> +		 */
> +		if (result.int_32 < -24 * 60 || result.int_32 > 24 * 60)
> +			return -EINVAL;
> +		opts->tz_set = 1;
> +		opts->time_offset = result.int_32;
> +		break;
> +	case Opt_tz:
> +		opts->tz_set = 1;
> +		opts->time_offset = result.uint_32;
> +		break;
> +	case Opt_errors:
> +		opts->errors = result.uint_32;
> +		break;
> +	case Opt_nfs:
> +		opts->nfs = FAT_NFS_STALE_RW;
> +		break;
> +	case Opt_nfs_enum:
> +		opts->nfs = result.uint_32;
> +		break;
> +	case Opt_dos1xfloppy:
> +		opts->dos1xfloppy = 1;
> +		break;
> +
> +	/* msdos specific */
> +	case Opt_dots:	/* dots / nodots */
> +		opts->dotsOK = !result.negated;
> +		break;
> +	case Opt_dotsOK:	/* dotsOK = yes/no */
> +		opts->dotsOK = result.boolean;
> +		break;
> +
> +	/* vfat specific */
> +	case Opt_charset:
> +		fat_reset_iocharset(opts);
> +		opts->iocharset = param->string;
> +		param->string = NULL;	/* Steal string */
> +		break;
> +	case Opt_shortname:
> +		opts->shortname = result.uint_32;
> +		break;
> +	case Opt_utf8:
> +		opts->utf8 = 1;
> +		break;
> +	case Opt_utf8_bool:
> +		opts->utf8 = result.boolean;
> +		break;
> +	case Opt_uni_xl:
> +		opts->unicode_xlate = 1;
> +		break;
> +	case Opt_uni_xl_bool:
> +		opts->unicode_xlate = result.boolean;
> +		break;
> +	case Opt_nonumtail:
> +		opts->numtail = 0;	/* negated option */
> +		break;
> +	case Opt_nonumtail_bool:
> +		opts->numtail = !result.boolean; /* negated option */
> +		break;
> +	case Opt_rodir:
> +		opts->rodir = 1;
> +		break;
> +	case Opt_discard:
> +		opts->discard = 1;
> +		break;
> +
> +	/* obsolete mount options */
> +	case Opt_obsolete:
> +		printk(KERN_INFO "FAT-fs: \"%s\" option is obsolete, "
> +			"not supported now", param->key);
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(fat_parse_param);
>  
>  static int fat_read_root(struct inode *inode)
>  {
> @@ -1604,9 +1538,11 @@ static int fat_read_static_bpb(struct super_block *sb,
>  /*
>   * Read the super block of an MS-DOS FS.
>   */
> -int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
> +int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>  		   void (*setup)(struct super_block *))
>  {
> +	struct fat_mount_options *opts = fc->fs_private;
> +	int silent = fc->sb_flags & SB_SILENT;
>  	struct inode *root_inode = NULL, *fat_inode = NULL;
>  	struct inode *fsinfo_inode = NULL;
>  	struct buffer_head *bh;
> @@ -1642,9 +1578,27 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
>  	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
>  			     DEFAULT_RATELIMIT_BURST);
>  
> -	error = parse_options(sb, data, isvfat, silent, &sbi->options);
> -	if (error)
> -		goto out_fail;
> +	/* UTF-8 doesn't provide FAT semantics */
> +	if (!strcmp(opts->iocharset, "utf8")) {
> +		fat_msg(sb, KERN_WARNING, "utf8 is not a recommended IO charset"
> +		       " for FAT filesystems, filesystem will be"
> +		       " case sensitive!");
> +	}
> +
> +	/* If user doesn't specify allow_utime, it's initialized from dmask. */
> +	if (opts->allow_utime == (unsigned short)-1)
> +		opts->allow_utime = ~opts->fs_dmask & (S_IWGRP | S_IWOTH);
> +	if (opts->unicode_xlate)
> +		opts->utf8 = 0;
> +	if (opts->nfs == FAT_NFS_NOSTALE_RO) {
> +		sb->s_flags |= SB_RDONLY;
> +		sb->s_export_op = &fat_export_ops_nostale;
> +	}
> +
> +	/* Apply parsed options to sbi (structure copy) */
> +	sbi->options = *opts;
> +	/* Transfer ownership of iocharset to sbi->options */
> +	opts->iocharset = NULL;
>  
>  	setup(sb); /* flavour-specific stuff that needs options */
>  
> @@ -1949,6 +1903,57 @@ int fat_flush_inodes(struct super_block *sb, struct inode *i1, struct inode *i2)
>  }
>  EXPORT_SYMBOL_GPL(fat_flush_inodes);
>  
> +int fat_init_fs_context(struct fs_context *fc, bool is_vfat)
> +{
> +	struct fat_mount_options *opts;
> +
> +	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +	if (!opts)
> +		return -ENOMEM;
> +
> +	opts->isvfat = is_vfat;
> +	opts->fs_uid = current_uid();
> +	opts->fs_gid = current_gid();
> +	opts->fs_fmask = opts->fs_dmask = current_umask();
> +	opts->allow_utime = -1;
> +	opts->codepage = fat_default_codepage;
> +	fat_reset_iocharset(opts);
> +	if (is_vfat) {
> +		opts->shortname = VFAT_SFN_DISPLAY_WINNT|VFAT_SFN_CREATE_WIN95;
> +		opts->rodir = 0;
> +	} else {
> +		opts->shortname = 0;
> +		opts->rodir = 1;
> +	}
> +	opts->name_check = 'n';
> +	opts->quiet = opts->showexec = opts->sys_immutable = opts->dotsOK =  0;
> +	opts->unicode_xlate = 0;
> +	opts->numtail = 1;
> +	opts->usefree = opts->nocase = 0;
> +	opts->tz_set = 0;
> +	opts->nfs = 0;
> +	opts->errors = FAT_ERRORS_RO;
> +	opts->debug = 0;
> +
> +	opts->utf8 = IS_ENABLED(CONFIG_FAT_DEFAULT_UTF8) && is_vfat;
> +
> +	fc->fs_private = opts;
> +	/* fc->ops assigned by caller */
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fat_init_fs_context);
> +
> +void fat_free_fc(struct fs_context *fc)
> +{
> +	struct fat_mount_options *opts = fc->fs_private;
> +
> +	if (opts->iocharset != fat_default_iocharset)
> +		kfree(opts->iocharset);
> +	kfree(fc->fs_private);
> +}
> +EXPORT_SYMBOL_GPL(fat_free_fc);
> +
>  static int __init init_fat_fs(void)
>  {
>  	int err;
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index 2116c486843b..f06f6ba643cc 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -650,24 +650,48 @@ static void setup(struct super_block *sb)
>  	sb->s_flags |= SB_NOATIME;
>  }
>  
> -static int msdos_fill_super(struct super_block *sb, void *data, int silent)
> +static int msdos_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
> -	return fat_fill_super(sb, data, silent, 0, setup);
> +	return fat_fill_super(sb, fc, setup);
>  }
>  
> -static struct dentry *msdos_mount(struct file_system_type *fs_type,
> -			int flags, const char *dev_name,
> -			void *data)
> +static int msdos_get_tree(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
> +	return get_tree_bdev(fc, msdos_fill_super);
> +}
> +
> +static int msdos_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	return fat_parse_param(fc, param, false);
> +}
> +
> +static const struct fs_context_operations msdos_context_ops = {
> +	.parse_param	= msdos_parse_param,
> +	.get_tree	= msdos_get_tree,
> +	.reconfigure	= fat_reconfigure,
> +	.free		= fat_free_fc,
> +};
> +
> +static int msdos_init_fs_context(struct fs_context *fc)
> +{
> +	int err;
> +
> +	/* Initialize with is_vfat == false */
> +	err = fat_init_fs_context(fc, false);
> +	if (err)
> +		return err;
> +
> +	fc->ops = &msdos_context_ops;
> +	return 0;
>  }
>  
>  static struct file_system_type msdos_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "msdos",
> -	.mount		= msdos_mount,
>  	.kill_sb	= kill_block_super,
>  	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.init_fs_context = msdos_init_fs_context,
> +	.parameters	= fat_param_spec,
>  };
>  MODULE_ALIAS_FS("msdos");
>  
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index c4d00999a433..6423e1dedf14 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -1195,24 +1195,48 @@ static void setup(struct super_block *sb)
>  		sb->s_d_op = &vfat_dentry_ops;
>  }
>  
> -static int vfat_fill_super(struct super_block *sb, void *data, int silent)
> +static int vfat_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
> -	return fat_fill_super(sb, data, silent, 1, setup);
> +	return fat_fill_super(sb, fc, setup);
>  }
>  
> -static struct dentry *vfat_mount(struct file_system_type *fs_type,
> -		       int flags, const char *dev_name,
> -		       void *data)
> +static int vfat_get_tree(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
> +	return get_tree_bdev(fc, vfat_fill_super);
> +}
> +
> +static int vfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	return fat_parse_param(fc, param, true);
> +}
> +
> +static const struct fs_context_operations vfat_context_ops = {
> +	.parse_param	= vfat_parse_param,
> +	.get_tree	= vfat_get_tree,
> +	.reconfigure	= fat_reconfigure,
> +	.free		= fat_free_fc,
> +};
> +
> +static int vfat_init_fs_context(struct fs_context *fc)
> +{
> +	int err;
> +
> +	/* Initialize with is_vfat == true */
> +	err = fat_init_fs_context(fc, true);
> +	if (err)
> +		return err;
> +
> +	fc->ops = &vfat_context_ops;
> +	return 0;
>  }
>  
>  static struct file_system_type vfat_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "vfat",
> -	.mount		= vfat_mount,
>  	.kill_sb	= kill_block_super,
>  	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.init_fs_context = vfat_init_fs_context,
> +	.parameters     = fat_param_spec,
>  };
>  MODULE_ALIAS_FS("vfat");

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

