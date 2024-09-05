Return-Path: <linux-fsdevel+bounces-28795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4996E515
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 23:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025FC1F2561E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B814F121;
	Thu,  5 Sep 2024 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="mzg3OvN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F21A3026;
	Thu,  5 Sep 2024 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571748; cv=none; b=etTR398/v5EU2X53G7MWG1uGJkcHWwb9ClBppYmi8Lq4vrFX/zlpahk57twGNqK0qTh1SFN+S77qbwYBhTShjgbo45k+4HPsX1OlfPH++R07In2NF/7NZVZ5uONeCo0OVkQsatMoWm4E7PU7sqEtYnBuMBjkeqbgVHi12iM+TXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571748; c=relaxed/simple;
	bh=Fzm9rG8J5EQG45EuA0XlCocu1pSDrtGSnpx8iPULDYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=td/RAZC19aIzQJwawEvMa9471baoAviZ0D4v8BGaKQIoLWWNIX8uhGqEFZ0odaWg9qY56hqftwNsXfcM4gBnczgs4ah05m3KaBfEUfMLbFeBJYBfLFkk7e/VtwBP27W6acOV3trLaNnM3wllhCIGZaFPWiYzw791WcK2UBmFFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=mzg3OvN7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31B5420003;
	Thu,  5 Sep 2024 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1725571743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDsRbYbLqFB4B0nmxpbXiNrnJ8uSYv3Op+Q13MZehUY=;
	b=mzg3OvN7W/aRpX/2o+c4lwP7zBzhXom27cj4rmDf6Pi74rJ5rDXKgJTZ/OGHbBiPeZnUD2
	3KJFgrPHOVjusMtEjE601spTHSvPvXrhk7gOB1ylro5zBQ4XKkbr1wjzRoG6ZsH9FVxPLy
	ll6Hsn7V/2/5R8WnMcc4hF2uil5Xi+ldFPp48Pe9HGhOKbuu0Esc+NhoPcYJcKYi5GoVaM
	jCsrw9RS+Zvoq2Dl9Gp7VmfryRD7he4O+np1qSqvu89fLcAu4Z+CP4bouaABEGKSjYyVJI
	EWsHMBRoFdgJbC+SPJmuXI7qd0jH23nniOzI8MPgQ/VbG1zIXwadqLVFfFTV6A==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  krisman@kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 6/9] tmpfs: Add casefold lookup support
In-Reply-To: <20240905190252.461639-7-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 5 Sep 2024 16:02:49 -0300")
References: <20240905190252.461639-1-andrealmeid@igalia.com>
	<20240905190252.461639-7-andrealmeid@igalia.com>
Date: Thu, 05 Sep 2024 17:28:53 -0400
Message-ID: <87zfoln622.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be


Hi,

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
> @@ -3427,6 +3431,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>=20=20
> +	if (IS_ENABLED(CONFIG_UNICODE))
> +		if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
> +			return -EINVAL;
> +

if (IS_ENABLED(CONFIG_UNICODE) &&
    generic_ci_validate_strict_name(dir, &dentry->d_name))

>  static const struct constant_table shmem_param_enums_huge[] =3D {
> @@ -4081,9 +4111,62 @@ const struct fs_parameter_spec shmem_fs_parameters=
[] =3D {
>  	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit=
),
>  	fsparam_string("grpquota_inode_hardlimit", Opt_grpquota_inode_hardlimit=
),
>  #endif
> +	fsparam_string("casefold",	Opt_casefold_version),
> +	fsparam_flag  ("casefold",	Opt_casefold),
> +	fsparam_flag  ("strict_encoding", Opt_strict_encoding),

I don't know if it is possible, but can we do it with a single parameter?

> +static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_par=
ameter *param,
> +				    bool latest_version)

Instead of the boolean, can't you check if param->string !=3D NULL? (real
question, I never used fs_parameter.

> +{
> +	struct shmem_options *ctx =3D fc->fs_private;
> +	unsigned int maj =3D 0, min =3D 0, rev =3D 0, version =3D 0;
> +	struct unicode_map *encoding;
> +	char *version_str =3D param->string + 5;
> +	int ret;

unsigned int version =3D UTF8_LATEST;

and kill the if/else below:
> +
> +	if (latest_version) {
> +		version =3D UTF8_LATEST;
> +	} else {
> +		if (strncmp(param->string, "utf8-", 5))
> +			return invalfc(fc, "Only UTF-8 encodings are supported "
> +				       "in the format: utf8-<version number>");
> +
> +		ret =3D utf8_parse_version(version_str, &maj, &min, &rev);

utf8_parse_version interface could return UNICODE_AGE() already, so we hide=
 the details
from the caller. wdyt?

> +		if (ret)
> +			return invalfc(fc, "Invalid UTF-8 version: %s", version_str);
> +
> +		version =3D UNICODE_AGE(maj, min, rev);
> +	}
> +
> +	encoding =3D utf8_load(version);
> +
> +	if (IS_ERR(encoding)) {
> +		if (latest_version)
> +			return invalfc(fc, "Failed loading latest UTF-8 version");
> +		else
> +			return invalfc(fc, "Failed loading UTF-8 version: %s", version_str);

The following covers both legs (untested):

if (IS_ERR(encoding))
  return invalfc(fc, "Failed loading UTF-8 version: utf8-%u.%u.%u\n"",
	           unicode_maj(version), unicode_min(version), unicode_rev(version=
));

> +	if (latest_version)
> +		pr_info("tmpfs: Using the latest UTF-8 version available");
> +	else
> +		pr_info("tmpfs: Using encoding provided by mount
> options: %s\n", param->string);

The following covers both legs (untested):

pr_info (fc, "tmpfs: Using encoding : utf8-%u.%u.%u\n"
         unicode_maj(version), unicode_min(version), unicode_rev(version));

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
> +	return invalfc(fc, "tmpfs: No kernel support for casefold filesystems\n=
");
> +}

A message like "Kernel not built with CONFIG_UNICODE" immediately tells
you how to fix it.

> @@ -4515,6 +4610,16 @@ static int shmem_fill_super(struct super_block *sb=
, struct fs_context *fc)
>  	}
>  	sb->s_export_op =3D &shmem_export_ops;
>  	sb->s_flags |=3D SB_NOSEC | SB_I_VERSION;
> +
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (ctx->encoding) {
> +		sb->s_encoding =3D ctx->encoding;
> +		generic_set_sb_d_ops(sb);

This is the right place for setting d_ops (see the next comment), but you
should be loading generic_ci_always_del_dentry_ops, right?

Also, since generic_ci_always_del_dentry_ops is only used by this one,
can you move it to this file?

> +static struct dentry *shmem_lookup(struct inode *dir, struct dentry *den=
try, unsigned int flags)
> +{
> +	const struct dentry_operations *d_ops =3D &simple_dentry_operations;
> +
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (dentry->d_sb->s_encoding)
> +		d_ops =3D &generic_ci_always_del_dentry_ops;
> +#endif

This needs to be done at mount time through sb->s_d_op. See

https://lore.kernel.org/all/20240221171412.10710-1-krisman@suse.de/

I suppose we can do it at mount-time for
generic_ci_always_del_dentry_ops and simple_dentry_operations.

> +
> +	if (dentry->d_name.len > NAME_MAX)
> +		return ERR_PTR(-ENAMETOOLONG);
> +
> +	if (!dentry->d_sb->s_d_op)
> +		d_set_d_op(dentry, d_ops);
> +
> +	/*
> +	 * For now, VFS can't deal with case-insensitive negative dentries, so
> +	 * we prevent them from being created
> +	 */
> +	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
> +		return NULL;

Thinking out loud:

I misunderstood always_delete_dentry before.  It removes negative
dentries right after the lookup, since ->d_delete is called on dput.

But you still need this check here, IMO, to prevent the negative dentry
from ever being hashed. Otherwise it can be found by a concurrent
lookup.  And you cannot drop ->d_delete from the case-insensitive
operations too, because we still wants it for !IS_CASEFOLDED(dir).

The window is that, without this code, the negative dentry dentry would
be hashed in d_add() and a concurrent lookup might find it between that
time and the d_put, where it is removed at the end of the concurrent
lookup.

All of this would hopefully go away with the negative dentry for
casefolded directories.

> +
> +	d_add(dentry, NULL);
> +
> +	return NULL;
> +}

The sole reason you are doing this custom function is to exclude negative
dentries from casefolded directories. I doubt we care about the extra
check being done.  Can we just do it in simple_lookup?

> +
>  static const struct inode_operations shmem_dir_inode_operations =3D {
>  #ifdef CONFIG_TMPFS
>  	.getattr	=3D shmem_getattr,
>  	.create		=3D shmem_create,
> -	.lookup		=3D simple_lookup,
> +	.lookup		=3D shmem_lookup,
>  	.link		=3D shmem_link,
>  	.unlink		=3D shmem_unlink,
>  	.symlink	=3D shmem_symlink,
> @@ -4791,6 +4923,8 @@ int shmem_init_fs_context(struct fs_context *fc)
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

