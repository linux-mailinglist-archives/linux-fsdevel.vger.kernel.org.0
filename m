Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2593469B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 21:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCWUTQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 16:19:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54200 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhCWUSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:18:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 988EC1F40FE7
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, smcv@collabora.com,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Rosenberg <drosen@google.com>
Subject: Re: [RFC PATCH 2/4] mm: shmem: Support case-insensitive file name
 lookups
Organization: Collabora
References: <20210323195941.69720-1-andrealmeid@collabora.com>
        <20210323195941.69720-3-andrealmeid@collabora.com>
Date:   Tue, 23 Mar 2021 16:18:43 -0400
In-Reply-To: <20210323195941.69720-3-andrealmeid@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Tue, 23 Mar 2021 16:59:39 -0300")
Message-ID: <877dlxd3oc.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

> This patch implements the support for case-insensitive file name lookups
> in tmpfs, based on the encoding passed in the mount options.

Thanks for doing this.

>  
> +#ifdef CONFIG_UNICODE
> +static const struct dentry_operations casefold_dentry_ops = {
> +	.d_hash = generic_ci_d_hash,
> +	.d_compare = generic_ci_d_compare,
> +};
> +#endif

Why not reuse struct generic_ci_dentry_ops ?

> +
>  /*
>   * shmem_file_setup pre-accounts the whole fixed size of a VM object,
>   * for shared memory and for shared anonymous (/dev/zero) mappings
> @@ -2859,8 +2869,18 @@ shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>  	struct inode *inode;
>  	int error = -ENOSPC;
>  
> +#ifdef CONFIG_UNICODE
> +	struct super_block *sb = dir->i_sb;
> +
> +	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
> +	    sb->s_encoding && utf8_validate(sb->s_encoding, &dentry->d_name))
> +		return -EINVAL;
> +#endif
> +
>  	inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE);
>  	if (inode) {
> +		inode->i_flags |= dir->i_flags;
> +
>  		error = simple_acl_create(dir, inode);
>  		if (error)
>  			goto out_iput;
> @@ -2870,6 +2890,9 @@ shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>  		if (error && error != -EOPNOTSUPP)
>  			goto out_iput;
>  
> +		if (IS_CASEFOLDED(dir))
> +			d_add(dentry, NULL);
> +
>  		error = 0;
>  		dir->i_size += BOGO_DIRENT_SIZE;
>  		dir->i_ctime = dir->i_mtime = current_time(dir);
> @@ -2925,6 +2948,19 @@ static int shmem_create(struct user_namespace *mnt_userns, struct inode *dir,
>  	return shmem_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
>  }
>  
> +static struct dentry *shmem_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
> +{
> +	if (dentry->d_name.len > NAME_MAX)
> +		return ERR_PTR(-ENAMETOOLONG);
> +
> +	if (IS_CASEFOLDED(dir))
> +		return NULL;

I think this deserves a comment explaining why it is necessary.

> +
> +	d_add(dentry, NULL);
> +
> +	return NULL;
> +}
> +
>  /*
>   * Link a file..
>   */
> @@ -2946,6 +2982,9 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
>  			goto out;
>  	}
>  
> +	if (IS_CASEFOLDED(dir))
> +		d_add(dentry, NULL);
> +
>  	dir->i_size += BOGO_DIRENT_SIZE;
>  	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
>  	inc_nlink(inode);
> @@ -2967,6 +3006,10 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
>  	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
>  	drop_nlink(inode);
>  	dput(dentry);	/* Undo the count from "create" - this does all the work */
> +
> +	if (IS_CASEFOLDED(dir))
> +		d_invalidate(dentry);
> +
>  	return 0;
>  }
>  
> @@ -3128,6 +3171,8 @@ static int shmem_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>  	}
>  	dir->i_size += BOGO_DIRENT_SIZE;
>  	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	if (IS_CASEFOLDED(dir))
> +		d_add(dentry, NULL);
>  	d_instantiate(dentry, inode);
>  	dget(dentry);
>  	return 0;
> @@ -3364,6 +3409,8 @@ enum shmem_param {
>  	Opt_uid,
>  	Opt_inode32,
>  	Opt_inode64,
> +	Opt_casefold,
> +	Opt_cf_strict,
>  };
>  
>  static const struct constant_table shmem_param_enums_huge[] = {
> @@ -3385,6 +3432,8 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
>  	fsparam_u32   ("uid",		Opt_uid),
>  	fsparam_flag  ("inode32",	Opt_inode32),
>  	fsparam_flag  ("inode64",	Opt_inode64),
> +	fsparam_string("casefold",	Opt_casefold),
> +	fsparam_flag  ("cf_strict",	Opt_cf_strict),
>  	{}
>  };
>  
> @@ -3392,9 +3441,11 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  {
>  	struct shmem_options *ctx = fc->fs_private;
>  	struct fs_parse_result result;
> +	struct unicode_map *encoding;
>  	unsigned long long size;
> +	char version[10];
>  	char *rest;
> -	int opt;
> +	int opt, ret;
>  
>  	opt = fs_parse(fc, shmem_fs_parameters, param, &result);
>  	if (opt < 0)
> @@ -3468,6 +3519,23 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->full_inums = true;
>  		ctx->seen |= SHMEM_SEEN_INUMS;
>  		break;
> +	case Opt_casefold:
> +		if (strncmp(param->string, "utf8-", 5))
> +			return invalfc(fc, "Only utf8 encondings are supported");
> +		ret = strscpy(version, param->string + 5, sizeof(version));

Ugh.  Now we are doing two strscpy for the parse api (in unicode_load).
Can change the unicode_load api to reuse it?

thanks,

-- 
Gabriel Krisman Bertazi
