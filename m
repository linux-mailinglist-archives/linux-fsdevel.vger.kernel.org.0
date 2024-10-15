Return-Path: <linux-fsdevel+bounces-32023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAE99F5A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 20:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139CC2810B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B4D1F582A;
	Tue, 15 Oct 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ivRyMa2C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x1Q+r04Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ivRyMa2C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x1Q+r04Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905841B6CF6;
	Tue, 15 Oct 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017056; cv=none; b=L6J5U9E+u7iP1bk6ONYd7eaYdDnX1NExgun+Hxl+T69owe0m8ivzkpp8p1P2N8qGbZ7pyOYuTmR6Pvy1DX7Ke9Gmes3Ugk8RPiNMyoxMywth7YYGlkCM9mzSr60B1fLXIoJhfNZGGQIQQEmXqIXI04FxLTwflHXHj3/Ye0aU6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017056; c=relaxed/simple;
	bh=pCFW+6F9RofGm9KDUGAQx/Ex961w+9T9xJX30KO/Ca8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vt/p9H5a73caBSwR/TbRM/hyqzGWRFdFg8Mc+UzkaBQ+CNt145ujsEujG8mBDV1w2JoicYOrRC4OVnuwmHJg/hXRSQYXDm+D2laRGJRg12PRu7JdHGD8/gx0IWVNyrEQn1Mcc9a5CoEzwhFS9yf/N5bP3l5CZljbrKy7Exmas78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ivRyMa2C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x1Q+r04Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ivRyMa2C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x1Q+r04Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A871E21E5A;
	Tue, 15 Oct 2024 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729017051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjhuI94FdvOfay+0ixnBu9u4ssjYRvGJ8wWOTcBEAOg=;
	b=ivRyMa2Cqo0snSmBsVqIWU5nR/pm+YNgbxaVvwTWrfjPPV3lU5ZCQZsT7EFjxTGb6wt1/O
	YFMEqhAQLi+nw1jboqgGCB1kEgAv0NOcRghkSdG4HBy4uCKQ1Q0/ZfhgfSWkUala2y8Hcq
	RXY7LecdiMP2bkzezoukJi1WtmeH2F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729017051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjhuI94FdvOfay+0ixnBu9u4ssjYRvGJ8wWOTcBEAOg=;
	b=x1Q+r04Q8nxFMaO8OMYW6ZfUn6RC0YA0C0/52iN0BmQ0oao3SlDfD20M9LTB21Z6R3rn1v
	h2b0BO3rub1KFDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729017051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjhuI94FdvOfay+0ixnBu9u4ssjYRvGJ8wWOTcBEAOg=;
	b=ivRyMa2Cqo0snSmBsVqIWU5nR/pm+YNgbxaVvwTWrfjPPV3lU5ZCQZsT7EFjxTGb6wt1/O
	YFMEqhAQLi+nw1jboqgGCB1kEgAv0NOcRghkSdG4HBy4uCKQ1Q0/ZfhgfSWkUala2y8Hcq
	RXY7LecdiMP2bkzezoukJi1WtmeH2F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729017051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjhuI94FdvOfay+0ixnBu9u4ssjYRvGJ8wWOTcBEAOg=;
	b=x1Q+r04Q8nxFMaO8OMYW6ZfUn6RC0YA0C0/52iN0BmQ0oao3SlDfD20M9LTB21Z6R3rn1v
	h2b0BO3rub1KFDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5815113A53;
	Tue, 15 Oct 2024 18:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qus0Cdu0DmeZTAAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 15 Oct 2024 18:30:51 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>,  Hugh Dickins <hughd@google.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Jonathan Corbet <corbet@lwn.net>,
  smcv@collabora.com,  kernel-dev@igalia.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 07/10] tmpfs: Add casefold lookup support
In-Reply-To: <20241010-tonyk-tmpfs-v6-7-79f0ae02e4c8@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 10 Oct 2024 16:39:42 -0300")
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
	<20241010-tonyk-tmpfs-v6-7-79f0ae02e4c8@igalia.com>
Date: Tue, 15 Oct 2024 14:30:49 -0400
Message-ID: <871q0hrzfq.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Enable casefold lookup in tmpfs, based on the encoding defined by
> userspace. That means that instead of comparing byte per byte a file
> name, it compares to a case-insensitive equivalent of the Unicode
> string.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

Al, can you please comment about the dcache use in this patch?  It seems
reasonable to me now, but it would be good to get your confirmation.

>
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 7b290404c5f9901010ada2f921a214dbc94eb5fa..a168ece5cc61b74114f537f5b=
7b8a07f2d48b2aa 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -77,6 +77,10 @@ struct dentry *simple_lookup(struct inode *dir, struct=
 dentry *dentry, unsigned
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
> index 162d68784309bdfb8772aa9ba3ccc360780395fd..935e824990799d927098fd88e=
baba384a6284f42 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -40,6 +40,7 @@
>  #include <linux/fs_parser.h>
>  #include <linux/swapfile.h>
>  #include <linux/iversion.h>
> +#include <linux/unicode.h>
>  #include "swap.h"
>=20=20
>  static struct vfsmount *shm_mnt __ro_after_init;
> @@ -123,6 +124,8 @@ struct shmem_options {
>  	bool noswap;
>  	unsigned short quota_types;
>  	struct shmem_quota_limits qlimits;
> +	struct unicode_map *encoding;
> +	bool strict_encoding;
>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
> @@ -3574,6 +3577,9 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *=
dir,
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>=20=20
> +	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
> +		return -EINVAL;
> +
>  	error =3D simple_acl_create(dir, inode);
>  	if (error)
>  		goto out_iput;
> @@ -3589,7 +3595,12 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode =
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
> @@ -3680,7 +3691,10 @@ static int shmem_link(struct dentry *old_dentry, s=
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
> @@ -3700,6 +3714,14 @@ static int shmem_unlink(struct inode *dir, struct =
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
> @@ -3844,7 +3866,10 @@ static int shmem_symlink(struct mnt_idmap *idmap, =
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
> @@ -4197,6 +4222,9 @@ enum shmem_param {
>  	Opt_usrquota_inode_hardlimit,
>  	Opt_grpquota_block_hardlimit,
>  	Opt_grpquota_inode_hardlimit,
> +	Opt_casefold_version,
> +	Opt_casefold,
> +	Opt_strict_encoding,
>  };
>=20=20
>  static const struct constant_table shmem_param_enums_huge[] =3D {
> @@ -4228,9 +4256,54 @@ const struct fs_parameter_spec shmem_fs_parameters=
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
> +			       unicode_major(version), unicode_minor(version),
> +			       unicode_rev(version));
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
> @@ -4389,6 +4462,13 @@ static int shmem_parse_one(struct fs_context *fc, =
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
> +		break;
>  	}
>  	return 0;
>=20=20
> @@ -4618,6 +4698,11 @@ static void shmem_put_super(struct super_block *sb)
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
> @@ -4628,6 +4713,14 @@ static void shmem_put_super(struct super_block *sb)
>  	sb->s_fs_info =3D NULL;
>  }
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_TMPFS)
> +static const struct dentry_operations shmem_ci_dentry_ops =3D {
> +	.d_hash =3D generic_ci_d_hash,
> +	.d_compare =3D generic_ci_d_compare,
> +	.d_delete =3D always_delete_dentry,
> +};
> +#endif
> +
>  static int shmem_fill_super(struct super_block *sb, struct fs_context *f=
c)
>  {
>  	struct shmem_options *ctx =3D fc->fs_private;
> @@ -4663,10 +4756,24 @@ static int shmem_fill_super(struct super_block *s=
b, struct fs_context *fc)
>  	sb->s_export_op =3D &shmem_export_ops;
>  	sb->s_flags |=3D SB_NOSEC | SB_I_VERSION;
>=20=20
> -	sb->s_d_op =3D &simple_dentry_operations;
> +	if (!ctx->encoding && ctx->strict_encoding) {
> +		pr_err("tmpfs: strict_encoding option without encoding is forbidden\n"=
);
> +		error =3D -EINVAL;
> +		goto failed;
> +	}
> +
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (ctx->encoding) {
> +		sb->s_encoding =3D ctx->encoding;
> +		sb->s_d_op =3D &shmem_ci_dentry_ops;
> +		if (ctx->strict_encoding)
> +			sb->s_encoding_flags =3D SB_ENC_STRICT_MODE_FL;
> +	}
> +#endif
> +
>  #else
>  	sb->s_flags |=3D SB_NOUSER;
> -#endif
> +#endif /* CONFIG_TMPFS */
>  	sbinfo->max_blocks =3D ctx->blocks;
>  	sbinfo->max_inodes =3D ctx->inodes;
>  	sbinfo->free_ispace =3D sbinfo->max_inodes * BOGO_INODE_SIZE;
> @@ -4940,6 +5047,8 @@ int shmem_init_fs_context(struct fs_context *fc)
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

