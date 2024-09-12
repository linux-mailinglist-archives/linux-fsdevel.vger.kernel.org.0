Return-Path: <linux-fsdevel+bounces-29200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E297710B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE72B23CE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C711C1758;
	Thu, 12 Sep 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="CsobTckg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFB1BF7FC;
	Thu, 12 Sep 2024 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167883; cv=none; b=G74E7+gvxjoq3GJaWeReU2h2jrDIFYPMIvu0p5qj3w/dvrszwq6TWha899HgY3SQCMwi6L5Nb8f5FDVtU5gvze0uBeAclPlG7q5qsBYc0764Y5+exxDnKPneONH4L/cPvExOot0qsfnasm7EI8abBXJ+2gZoyZB6XTWxuOqO1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167883; c=relaxed/simple;
	bh=8MKM2klD4hS3pv4ky1dpyosPwvTDwiKHuzZ+MmcWla0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s/xHDpjVnHc1AtJUEaU9D437wc53AqVJDX4+/6dMSBZYdHdX/kuWfdbVYDCWugZ+naxxEWlWYKm9ahAtAQp0N+JXnt0rvRJw9J9qfsU4DbVuK5AhMobISz+/udKOEyxpp28wXARPpAf7YDDhVLw6jqtjDdnwbYdHYrRQjjjE6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=CsobTckg; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89783C0002;
	Thu, 12 Sep 2024 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1726167872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9mSGcS9UoGNA8xUFK+xWajkc6aiw1nttzLrj4qX5Q4=;
	b=CsobTckgSyjRtlO17KQb5//Nn/NdBni25gBX2wrahF2+JOu47Lneu9DDeO/I39LxjBcWnl
	CRPgRlkmTQuvhhRd6aWx+mycCgrL9pFKTes5aNZ7XwI/C1tJl1eM/CxJVkLjCM39uFJ21J
	EdAI379ilb63hTMY13cq6uaKmjgDf7UG9GPcvgAYXF3/kRSnXSLk5C6FN9EmA1MuuH2Kqz
	qbj2Xm+yjqiQW6euAFMKibK9dG83YNuRduYkZP7Z1Ta3XXnDv3aGwE8TslxwonQYlCsdg6
	qiOKvT8M4Bgo2Xj0K/wG8KZReTRlfiywpc78vmY1ApO/4q1Nmmlrlk5I3Vp59A==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 07/10] tmpfs: Add casefold lookup support
In-Reply-To: <20240911144502.115260-8-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 11 Sep 2024 11:44:59 -0300")
References: <20240911144502.115260-1-andrealmeid@igalia.com>
	<20240911144502.115260-8-andrealmeid@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 12 Sep 2024 15:04:27 -0400
Message-ID: <87ed5olmmc.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Enable casefold lookup in tmpfs, based on the encoding defined by
> userspace. That means that instead of comparing byte per byte a file
> name, it compares to a case-insensitive equivalent of the Unicode
> string.

I think this looks much better.

A few things left. First, I'd suggest you merge patch 5 and this
one. There is not much sense in keeping them separate; patch 5 is a
dependency that won't crash the build, but might cause runtime errors if an=
yone
cherry-picks the feature but forgets to pull it.

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5a77acf6ac6a..4fde63596ab3 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -40,6 +40,8 @@
>  #include <linux/fs_parser.h>
>  #include <linux/swapfile.h>
>  #include <linux/iversion.h>
> +#include <linux/unicode.h>

> +#include <linux/parser.h>

I think you don't need this header anymore

>  #include "swap.h"
>=20=20
>  static struct vfsmount *shm_mnt __ro_after_init;
> @@ -123,6 +125,8 @@ struct shmem_options {
>  	bool noswap;
>  	unsigned short quota_types;
>  	struct shmem_quota_limits qlimits;
> +	struct unicode_map *encoding;
> +	bool strict_encoding;
>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
> @@ -3427,6 +3431,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>=20=20
> +	if (IS_ENABLED(CONFIG_UNICODE) &&
> +	    !generic_ci_validate_strict_name(dir, &dentry->d_name))
> +		return -EINVAL;
> +

Commenting here, but this is about generic_ci_validate_strict_name.  Can
you make it an inline function in the header file instead? This way you
can fold the IS_ENABLED into it and also avoid the function call.

>  	error =3D simple_acl_create(dir, inode);
>  	if (error)
>  		goto out_iput;
> @@ -3442,7 +3450,12 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>  	dir->i_size +=3D BOGO_DIRENT_SIZE;
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
>=20=20
> @@ -3533,7 +3546,10 @@ static int shmem_link(struct dentry *old_dentry, s=
truct inode *dir,
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
> @@ -3553,6 +3569,14 @@ static int shmem_unlink(struct inode *dir, struct =
dentry *dentry)
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
>=20=20
> @@ -3697,7 +3721,10 @@ static int shmem_symlink(struct mnt_idmap *idmap, =
struct inode *dir,
>  	dir->i_size +=3D BOGO_DIRENT_SIZE;
>  	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>  	inode_inc_iversion(dir);
> -	d_instantiate(dentry, inode);
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
> +		d_add(dentry, inode);
> +	else
> +		d_instantiate(dentry, inode);
>  	dget(dentry);
>  	return 0;
>=20=20
> @@ -4050,6 +4077,9 @@ enum shmem_param {
>  	Opt_usrquota_inode_hardlimit,
>  	Opt_grpquota_block_hardlimit,
>  	Opt_grpquota_inode_hardlimit,
> +	Opt_casefold_version,
> +	Opt_casefold,
> +	Opt_strict_encoding,
>  };
>=20=20
>  static const struct constant_table shmem_param_enums_huge[] =3D {
> @@ -4081,9 +4111,53 @@ const struct fs_parameter_spec shmem_fs_parameters=
[] =3D {
>  	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit=
),
>  	fsparam_string("grpquota_inode_hardlimit", Opt_grpquota_inode_hardlimit=
),
>  #endif
> +	fsparam_string("casefold",	Opt_casefold_version),
> +	fsparam_flag  ("casefold",	Opt_casefold),
> +	fsparam_flag  ("strict_encoding", Opt_strict_encoding),
>  	{}
>  };
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_par=
ameter *param,
> +				    bool latest_version)
> +{
> +	struct shmem_options *ctx =3D fc->fs_private;
> +	unsigned int version =3D UTF8_LATEST;
> +	struct unicode_map *encoding;
> +	char *version_str =3D param->string + 5;
> +
> +	if (!latest_version) {
> +		if (strncmp(param->string, "utf8-", 5))
> +			return invalfc(fc, "Only UTF-8 encodings are supported "
> +				       "in the format: utf8-<version number>");
> +
> +		version =3D utf8_parse_version(version_str);
> +		if (version < 0)
> +			return invalfc(fc, "Invalid UTF-8 version: %s", version_str);
> +	}
> +
> +	encoding =3D utf8_load(version);
> +
> +	if (IS_ERR(encoding)) {
> +		return invalfc(fc, "Failed loading UTF-8 version: utf8-%u.%u.%u\n",
> +		unicode_major(version), unicode_minor(version), unicode_rev(version));

bad indentation?

> +	}
> +
> +	pr_info("tmpfs: Using encoding : utf8-%u.%u.%u\n",
> +		unicode_major(version), unicode_minor(version), unicode_rev(version));
> +
> +	ctx->encoding =3D encoding;
> +
> +	return 0;
> +}
> +#else
> +static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_par=
ameter *param,
> +				    bool latest_version)
> +{
> +	return invalfc(fc, "tmpfs: Kernel not built with CONFIG_UNICODE\n");
> +}
> +#endif
> +
>  static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *p=
aram)
>  {
>  	struct shmem_options *ctx =3D fc->fs_private;
> @@ -4242,6 +4316,13 @@ static int shmem_parse_one(struct fs_context *fc, =
struct fs_parameter *param)
>  				       "Group quota inode hardlimit too large.");
>  		ctx->qlimits.grpquota_ihardlimit =3D size;
>  		break;
> +	case Opt_casefold_version:
> +		return shmem_parse_opt_casefold(fc, param, false);
> +	case Opt_casefold:
> +		return shmem_parse_opt_casefold(fc, param, true);
> +	case Opt_strict_encoding:
> +		ctx->strict_encoding =3D true;

Using strict_encoding without encoding should be explicitly forbidden.

> +		break;
>  	}
>  	return 0;
>=20=20
> @@ -4471,6 +4552,11 @@ static void shmem_put_super(struct super_block *sb)
>  {
>  	struct shmem_sb_info *sbinfo =3D SHMEM_SB(sb);
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (sb->s_encoding)
> +		utf8_unload(sb->s_encoding);
> +#endif
> +
>  #ifdef CONFIG_TMPFS_QUOTA
>  	shmem_disable_quotas(sb);
>  #endif
> @@ -4481,6 +4567,17 @@ static void shmem_put_super(struct super_block *sb)
>  	sb->s_fs_info =3D NULL;
>  }
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +static const struct dentry_operations shmem_ci_dentry_ops =3D {
> +	.d_hash =3D generic_ci_d_hash,
> +	.d_compare =3D generic_ci_d_compare,
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.d_revalidate =3D fscrypt_d_revalidate,
> +#endif
> +	.d_delete =3D always_delete_dentry,
> +};
> +#endif
> +
>  static int shmem_fill_super(struct super_block *sb, struct fs_context *f=
c)
>  {
>  	struct shmem_options *ctx =3D fc->fs_private;
> @@ -4515,9 +4612,21 @@ static int shmem_fill_super(struct super_block *sb=
, struct fs_context *fc)
>  	}
>  	sb->s_export_op =3D &shmem_export_ops;
>  	sb->s_flags |=3D SB_NOSEC | SB_I_VERSION;
> +
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (ctx->encoding) {
> +		sb->s_encoding =3D ctx->encoding;
> +		sb->s_d_op =3D &shmem_ci_dentry_ops;
> +		if (ctx->strict_encoding)
> +			sb->s_encoding_flags =3D SB_ENC_STRICT_MODE_FL;
> +	}
>  #else
> -	sb->s_flags |=3D SB_NOUSER;
> +	sb->s_d_op =3D &simple_dentry_operations;

Moving simple_dentry_operations to be set at s_d_op should be a separate
patch.

It is a change that has non-obvious side effects (i.e. the way we
treat the root dentry) so it needs proper review by itself.  It is
also not related to the rest of the case-insensitive patch.

Also, why is it done only for CONFIG_UNICODE=3Dn?

>  #endif
> +
> +#else
> +	sb->s_flags |=3D SB_NOUSER;
> +#endif /* CONFIG_TMPFS */
>  	sbinfo->max_blocks =3D ctx->blocks;
>  	sbinfo->max_inodes =3D ctx->inodes;
>  	sbinfo->free_ispace =3D sbinfo->max_inodes * BOGO_INODE_SIZE;
> @@ -4791,6 +4900,8 @@ int shmem_init_fs_context(struct fs_context *fc)
>  	ctx->uid =3D current_fsuid();
>  	ctx->gid =3D current_fsgid();
>=20=20
> +	ctx->encoding =3D NULL;
> +
>  	fc->fs_private =3D ctx;
>  	fc->ops =3D &shmem_fs_context_ops;
>  	return 0;

--=20
Gabriel Krisman Bertazi

