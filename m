Return-Path: <linux-fsdevel+bounces-32482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0739A6960
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D1F1F21017
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726D1F7082;
	Mon, 21 Oct 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLxvVVtF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529F1EF94A;
	Mon, 21 Oct 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515562; cv=none; b=SfM+acOsehAc8GpdZJ7TGP/hOPKdJNd8rMccD+WwWqatISBrVHs+gnjVlyCZnf4GCsMOsdS9QSty4HUIVXZJ6/7Al5bmbIPMuBBxRzkp6D7jx4q0ZZMvtedsRKAIHliPhoNdxLn4VImx8kIE0T+uYi9a7Kn8uB/7OO5VTufgIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515562; c=relaxed/simple;
	bh=zudYUkWpcUzf+HKLpmF9sg0h4oBnCoa/e2+edFK90gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjU1ahDHqH75zl9dA9apizFSr8UmGp6wM/mNCkiovouyvkMMomAvOP7/qMITICzPR0nhriegls2nCSKbTTlZh9g6w8nYSODdWrvfNGsrmJmjy6PePsIEPlW1iXTrAAkK3bLu3MW83+Py8aoucQGv45e590sLh5/R91tkVsrU1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLxvVVtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAD5C4CEC3;
	Mon, 21 Oct 2024 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729515561;
	bh=zudYUkWpcUzf+HKLpmF9sg0h4oBnCoa/e2+edFK90gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLxvVVtFr2uoa/6iwMosidgP4I861ir5hNNHjcTnkR2zIjZMbdZTk3DVxUujSuxnB
	 fgEbNdHGdcthMltFlvR5BEZ1GRISt4xjZsAZ44sn8HMqRVC1lsWm1H7CnHzkSAftND
	 XZaQwmSy4diqJuFPBogmwU6CA73gLNDreI7KwjlmjWxI/ffk5UQtKhW9Te+pZk/PUV
	 LWWVUQvHb+3qOOFi190tmlf900vwVsic9PIVQ7xcjczNU6spL7Q4W5H9ZiYMqrvpps
	 jVsT03HnMVtHGa3kHO5CUPjXacXsbV8P1RqS8H5j15i+Lzb35ZqTUFFw88vOKId/X9
	 +aMzqBob5bH3Q==
Date: Mon, 21 Oct 2024 14:59:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com, 
	kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 6/9] tmpfs: Add casefold lookup support
Message-ID: <20241021-keller-tunnel-c8bebded630c@brauner>
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
 <20241017-tonyk-tmpfs-v7-6-a9c056f8391f@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017-tonyk-tmpfs-v7-6-a9c056f8391f@igalia.com>

On Thu, Oct 17, 2024 at 06:14:16PM -0300, André Almeida wrote:
> Enable casefold lookup in tmpfs, based on the encoding defined by
> userspace. That means that instead of comparing byte per byte a file
> name, it compares to a case-insensitive equivalent of the Unicode
> string.
> 
> * Dcache handling
> 
> There's a special need when dealing with case-insensitive dentries.
> First of all, we currently invalidated every negative casefold dentries.
> That happens because currently VFS code has no proper support to deal
> with that, giving that it could incorrectly reuse a previous filename
> for a new file that has a casefold match. For instance, this could
> happen:
> 
> $ mkdir DIR
> $ rm -r DIR
> $ mkdir dir
> $ ls
> DIR/
> 
> And would be perceived as inconsistency from userspace point of view,
> because even that we match files in a case-insensitive manner, we still
> honor whatever is the initial filename.
> 
> Along with that, tmpfs stores only the first equivalent name dentry used
> in the dcache, preventing duplications of dentries in the dcache. The
> d_compare() version for casefold files uses a normalized string, so the
> filename under lookup will be compared to another normalized string for
> the existing file, achieving a casefolded lookup.
> 
> * Enabling casefold via mount options
> 
> Most filesystems have their data stored in disk, so casefold option need
> to be enabled when building a filesystem on a device (via mkfs).
> However, as tmpfs is a RAM backed filesystem, there's no disk
> information and thus no mkfs to store information about casefold.
> 
> For tmpfs, create casefold options for mounting. Userspace can then
> enable casefold support for a mount point using:
> 
> $ mount -t tmpfs -o casefold=utf8-12.1.0 fs_name mount_dir/
> 
> Userspace must set what Unicode standard is aiming to. The available
> options depends on what the kernel Unicode subsystem supports.
> 
> And for strict encoding:
> 
> $ mount -t tmpfs -o casefold=utf8-12.1.0,strict_encoding fs_name mount_dir/
> 
> Strict encoding means that tmpfs will refuse to create invalid UTF-8
> sequences. When this option is not enabled, any invalid sequence will be
> treated as an opaque byte sequence, ignoring the encoding thus not being
> able to be looked up in a case-insensitive way.
> 
> * Check for casefold dirs on simple_lookup()
> 
> On simple_lookup(), do not create dentries for casefold directories.
> Currently, VFS does not support case-insensitive negative dentries and
> can create inconsistencies in the filesystem. Prevent such dentries to
> being created in the first place.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> Changes from v7:
> - Dropped patch "tmpfs: Always set simple_dentry_operations as dentry ops"
> - Re-place generic_ci_validate_strict_name() before inode creation
> 
> Changes from v4:
> - Squash commit Check for casefold dirs on simple_lookup() here
> - Fails to mount if strict_encoding is used without encoding
> - tmpfs doesn't support fscrypt, so I dropped d_revalidate line
> 
> Changes from v3:
> - Simplified shmem_parse_opt_casefold()
> - sb->s_d_op is set to shmem_ci_dentry_ops during mount time
> - got rid of shmem_lookup(), modified simple_lookup()
> 
> Changes from v2:
> - simple_lookup() now sets d_ops
> - reworked shmem_parse_opt_casefold()
> - if `mount -o casefold` has no param, load latest UTF-8 version
> - using (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir) when possible
> ---
>  fs/libfs.c |   4 +++
>  mm/shmem.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 119 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 7b290404c5f9901010ada2f921a214dbc94eb5fa..a168ece5cc61b74114f537f5b7b8a07f2d48b2aa 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -77,6 +77,10 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
>  		return ERR_PTR(-ENAMETOOLONG);
>  	if (!dentry->d_sb->s_d_op)
>  		d_set_d_op(dentry, &simple_dentry_operations);
> +
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
> +		return NULL;
> +
>  	d_add(dentry, NULL);
>  	return NULL;
>  }
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4f11b55063631976af81e4221c7366b768db6690..ea4eff41eef35c9c253092f39402db142baa741b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -40,6 +40,7 @@
>  #include <linux/fs_parser.h>
>  #include <linux/swapfile.h>
>  #include <linux/iversion.h>
> +#include <linux/unicode.h>
>  #include "swap.h"
>  
>  static struct vfsmount *shm_mnt __ro_after_init;
> @@ -123,6 +124,8 @@ struct shmem_options {
>  	bool noswap;
>  	unsigned short quota_types;
>  	struct shmem_quota_limits qlimits;
> +	struct unicode_map *encoding;
> +	bool strict_encoding;

I'm a bit confused here because there seem to be codepaths where access
to these fields is guarded by IS_ENABLED(CONFIG_UNICODE) and then theres
one where it's not.

Can't you make this consistent so that all access and the definition of
the members are guarded by CONFIG_UNICODE?

>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
> @@ -3570,6 +3573,9 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	struct inode *inode;
>  	int error;
>  
> +	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
> +		return -EINVAL;
> +
>  	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
> @@ -3589,7 +3595,12 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	dir->i_size += BOGO_DIRENT_SIZE;
>  	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>  	inode_inc_iversion(dir);
> -	d_instantiate(dentry, inode);
> +
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
> +		d_add(dentry, inode);
> +	else
> +		d_instantiate(dentry, inode);
> +
>  	dget(dentry); /* Extra count - pin the dentry in core */
>  	return error;
>  
> @@ -3680,7 +3691,10 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir,
>  	inc_nlink(inode);
>  	ihold(inode);	/* New dentry reference */
>  	dget(dentry);	/* Extra pinning count for the created dentry */
> -	d_instantiate(dentry, inode);
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
> +		d_add(dentry, inode);
> +	else
> +		d_instantiate(dentry, inode);
>  out:
>  	return ret;
>  }
> @@ -3700,6 +3714,14 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
>  	inode_inc_iversion(dir);
>  	drop_nlink(inode);
>  	dput(dentry);	/* Undo the count from "create" - does all the work */
> +
> +	/*
> +	 * For now, VFS can't deal with case-insensitive negative dentries, so
> +	 * we invalidate them
> +	 */
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
> +		d_invalidate(dentry);
> +
>  	return 0;
>  }
>  
> @@ -3844,7 +3866,10 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	dir->i_size += BOGO_DIRENT_SIZE;
>  	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>  	inode_inc_iversion(dir);
> -	d_instantiate(dentry, inode);
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
> +		d_add(dentry, inode);
> +	else
> +		d_instantiate(dentry, inode);
>  	dget(dentry);
>  	return 0;
>  
> @@ -4197,6 +4222,9 @@ enum shmem_param {
>  	Opt_usrquota_inode_hardlimit,
>  	Opt_grpquota_block_hardlimit,
>  	Opt_grpquota_inode_hardlimit,
> +	Opt_casefold_version,
> +	Opt_casefold,
> +	Opt_strict_encoding,
>  };
>  
>  static const struct constant_table shmem_param_enums_huge[] = {
> @@ -4228,9 +4256,54 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
>  	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit),
>  	fsparam_string("grpquota_inode_hardlimit", Opt_grpquota_inode_hardlimit),
>  #endif
> +	fsparam_string("casefold",	Opt_casefold_version),
> +	fsparam_flag  ("casefold",	Opt_casefold),
> +	fsparam_flag  ("strict_encoding", Opt_strict_encoding),
>  	{}
>  };
>  
> +#if IS_ENABLED(CONFIG_UNICODE)
> +static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param,
> +				    bool latest_version)
> +{
> +	struct shmem_options *ctx = fc->fs_private;
> +	unsigned int version = UTF8_LATEST;
> +	struct unicode_map *encoding;
> +	char *version_str = param->string + 5;
> +
> +	if (!latest_version) {
> +		if (strncmp(param->string, "utf8-", 5))
> +			return invalfc(fc, "Only UTF-8 encodings are supported "
> +				       "in the format: utf8-<version number>");
> +
> +		version = utf8_parse_version(version_str);
> +		if (version < 0)
> +			return invalfc(fc, "Invalid UTF-8 version: %s", version_str);
> +	}
> +
> +	encoding = utf8_load(version);
> +
> +	if (IS_ERR(encoding)) {
> +		return invalfc(fc, "Failed loading UTF-8 version: utf8-%u.%u.%u\n",
> +			       unicode_major(version), unicode_minor(version),
> +			       unicode_rev(version));
> +	}
> +
> +	pr_info("tmpfs: Using encoding : utf8-%u.%u.%u\n",
> +		unicode_major(version), unicode_minor(version), unicode_rev(version));
> +
> +	ctx->encoding = encoding;
> +
> +	return 0;
> +}
> +#else
> +static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param,
> +				    bool latest_version)
> +{
> +	return invalfc(fc, "tmpfs: Kernel not built with CONFIG_UNICODE\n");
> +}
> +#endif
> +
>  static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  {
>  	struct shmem_options *ctx = fc->fs_private;
> @@ -4389,6 +4462,13 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  				       "Group quota inode hardlimit too large.");
>  		ctx->qlimits.grpquota_ihardlimit = size;
>  		break;
> +	case Opt_casefold_version:
> +		return shmem_parse_opt_casefold(fc, param, false);
> +	case Opt_casefold:
> +		return shmem_parse_opt_casefold(fc, param, true);
> +	case Opt_strict_encoding:
> +		ctx->strict_encoding = true;
> +		break;
>  	}
>  	return 0;
>  
> @@ -4618,6 +4698,11 @@ static void shmem_put_super(struct super_block *sb)
>  {
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
>  
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (sb->s_encoding)
> +		utf8_unload(sb->s_encoding);
> +#endif
> +
>  #ifdef CONFIG_TMPFS_QUOTA
>  	shmem_disable_quotas(sb);
>  #endif
> @@ -4628,6 +4713,14 @@ static void shmem_put_super(struct super_block *sb)
>  	sb->s_fs_info = NULL;
>  }
>  
> +#if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_TMPFS)
> +static const struct dentry_operations shmem_ci_dentry_ops = {
> +	.d_hash = generic_ci_d_hash,
> +	.d_compare = generic_ci_d_compare,
> +	.d_delete = always_delete_dentry,
> +};
> +#endif
> +
>  static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct shmem_options *ctx = fc->fs_private;
> @@ -4662,9 +4755,25 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  	}
>  	sb->s_export_op = &shmem_export_ops;
>  	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
> +
> +	if (!ctx->encoding && ctx->strict_encoding) {
> +		pr_err("tmpfs: strict_encoding option without encoding is forbidden\n");
> +		error = -EINVAL;
> +		goto failed;
> +	}
> +
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (ctx->encoding) {
> +		sb->s_encoding = ctx->encoding;
> +		sb->s_d_op = &shmem_ci_dentry_ops;
> +		if (ctx->strict_encoding)
> +			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
> +	}
> +#endif
> +
>  #else
>  	sb->s_flags |= SB_NOUSER;
> -#endif
> +#endif /* CONFIG_TMPFS */
>  	sbinfo->max_blocks = ctx->blocks;
>  	sbinfo->max_inodes = ctx->inodes;
>  	sbinfo->free_ispace = sbinfo->max_inodes * BOGO_INODE_SIZE;
> @@ -4938,6 +5047,8 @@ int shmem_init_fs_context(struct fs_context *fc)
>  	ctx->uid = current_fsuid();
>  	ctx->gid = current_fsgid();
>  
> +	ctx->encoding = NULL;
> +
>  	fc->fs_private = ctx;
>  	fc->ops = &shmem_fs_context_ops;
>  	return 0;
> 
> -- 
> 2.47.0
> 

