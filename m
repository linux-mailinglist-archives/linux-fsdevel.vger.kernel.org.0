Return-Path: <linux-fsdevel+bounces-28435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE2F96A3A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 18:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B331F25A38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD15189BB0;
	Tue,  3 Sep 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yjho3fbp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zyRKotJ9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yjho3fbp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zyRKotJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA56188598;
	Tue,  3 Sep 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379734; cv=none; b=tvitu6dh5ZNpkG1UAQkJ9ULwyrgnrdnF0GrKvp9HKlfZUIfKw5sQdJwOO5P8FjOJ15rarPLIInzs4nLTKS+60B4aYGIzt9o+idL5HsPYwYeRTeAYU5ROlpSiEuBJcDC6H1V5bl0zT+nPPnRSrRaed4r7ieW4NzIWWv9fQAk0HsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379734; c=relaxed/simple;
	bh=iaobbTQWL7UO7EQFOVRk8/iFL1TTm5ZoIsUzq5M2wJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T9EYcJEOGYaUoS9bcKPf8qb/1HgRHZepYg/OPH6V8wd/1z+Jwv9zzpknp8C6yuhAFyFuFv8ZkdiW/yP5jK4pBq/LKcLuYDizLulg1O+F8CjXISlPlaT6CgPCoAJ3ZkNGcDiLzNS6P3waLkLqp43gXgJQwehCxCU/Mtm1UE1GOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yjho3fbp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zyRKotJ9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yjho3fbp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zyRKotJ9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 861F01F397;
	Tue,  3 Sep 2024 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725379730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoFSrWjdDNy22qcLidqFmCW1sMDZc4/A6zH8LeBwn6k=;
	b=Yjho3fbpkR4IMGgIED7Wouh0+C2fmvIbh0q/cF7h4fBuh1aRQkT07PlSUZKTbA/GK93vPC
	+H13hk6ZBVtD2YY59UoKnKcmNSmQkICqqwX+14Q3NGczb2IJF1hzDTeDyHSMnlTeRLJVgj
	1NK0+u1tptSZw//ePc5B9ubNyHrXTlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725379730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoFSrWjdDNy22qcLidqFmCW1sMDZc4/A6zH8LeBwn6k=;
	b=zyRKotJ99/NKMgexny5KAWN2jJD5EQjT7CfPtJjxyzhdiOrPSVMZ8Lirlsu1b0srlHiUEt
	d5MKIzrNruTNNMDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725379730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoFSrWjdDNy22qcLidqFmCW1sMDZc4/A6zH8LeBwn6k=;
	b=Yjho3fbpkR4IMGgIED7Wouh0+C2fmvIbh0q/cF7h4fBuh1aRQkT07PlSUZKTbA/GK93vPC
	+H13hk6ZBVtD2YY59UoKnKcmNSmQkICqqwX+14Q3NGczb2IJF1hzDTeDyHSMnlTeRLJVgj
	1NK0+u1tptSZw//ePc5B9ubNyHrXTlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725379730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoFSrWjdDNy22qcLidqFmCW1sMDZc4/A6zH8LeBwn6k=;
	b=zyRKotJ99/NKMgexny5KAWN2jJD5EQjT7CfPtJjxyzhdiOrPSVMZ8Lirlsu1b0srlHiUEt
	d5MKIzrNruTNNMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 455E713A52;
	Tue,  3 Sep 2024 16:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aaYIC5I012ZUewAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 03 Sep 2024 16:08:50 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  krisman@kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 5/8] tmpfs: Add casefold lookup support
In-Reply-To: <20240902225511.757831-6-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Mon, 2 Sep 2024 19:55:07 -0300")
References: <20240902225511.757831-1-andrealmeid@igalia.com>
	<20240902225511.757831-6-andrealmeid@igalia.com>
Date: Tue, 03 Sep 2024 12:08:41 -0400
Message-ID: <87plpkhg8m.fsf@mailhost.krisman.be>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Enable casefold lookup in tmpfs, based on the enconding defined by
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
> $ mount -t tmpfs -o casefold=3Dutf8-12.1.0 fs_name mount_dir/
>
> Userspace must set what Unicode standard is aiming to. The available
> options depends on what the kernel Unicode subsystem supports.
>
> And for strict encoding:
>
> $ mount -t tmpfs -o casefold=3Dutf8-12.1.0,strict_encoding fs_name mount_=
dir/
>
> Strict encoding means that tmpfs will refuse to create invalid UTF-8
> sequences. When this option is not enabled, any invalid sequence will be
> treated as an opaque byte sequence, ignoring the encoding thus not being
> able to be looked up in a case-insensitive way.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  mm/shmem.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 111 insertions(+), 4 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5a77acf6ac6a..0f918010bc54 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -40,6 +40,8 @@
>  #include <linux/fs_parser.h>
>  #include <linux/swapfile.h>
>  #include <linux/iversion.h>
> +#include <linux/unicode.h>
> +#include <linux/parser.h>
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
> @@ -3427,6 +3431,11 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (!utf8_check_strict_name(dir, &dentry->d_name))
> +		return -EINVAL;
> +#endif

Please, fold it into the code when possible:

if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))

> +
>  	error =3D simple_acl_create(dir, inode);
>  	if (error)
>  		goto out_iput;
> @@ -3442,7 +3451,12 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>  	dir->i_size +=3D BOGO_DIRENT_SIZE;
>  	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>  	inode_inc_iversion(dir);
> -	d_instantiate(dentry, inode);
> +
> +	if (IS_CASEFOLDED(dir))

If you have if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))

It can be  optimized out when CONFIG_UNICODE=3Dn.

> +		d_add(dentry, inode);
> +	else
> +		d_instantiate(dentry, inode);
>  	dget(dentry); /* Extra count - pin the dentry in core */
>  	return error;
>=20=20
> @@ -3533,7 +3547,10 @@ static int shmem_link(struct dentry *old_dentry, s=
truct inode *dir,
>  	inc_nlink(inode);
>  	ihold(inode);	/* New dentry reference */
>  	dget(dentry);	/* Extra pinning count for the created dentry */
> -	d_instantiate(dentry, inode);
> +	if (IS_CASEFOLDED(dir))
> +		d_add(dentry, inode);
> +	else
> +		d_instantiate(dentry, inode);
>  out:
>  	return ret;
>  }
> @@ -3553,6 +3570,14 @@ static int shmem_unlink(struct inode *dir, struct =
dentry *dentry)
>  	inode_inc_iversion(dir);
>  	drop_nlink(inode);
>  	dput(dentry);	/* Undo the count from "create" - does all the work */
> +
> +	/*
> +	 * For now, VFS can't deal with case-insensitive negative dentries, so
> +	 * we invalidate them
> +	 */
> +	if (IS_CASEFOLDED(dir))
> +		d_invalidate(dentry);
> +

likewise and also below.

>  	return 0;
>  }
>=20=20
> @@ -3697,7 +3722,10 @@ static int shmem_symlink(struct mnt_idmap *idmap, =
struct inode *dir,
>  	dir->i_size +=3D BOGO_DIRENT_SIZE;
>  	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>  	inode_inc_iversion(dir);
> -	d_instantiate(dentry, inode);
> +	if (IS_CASEFOLDED(dir))
> +		d_add(dentry, inode);
> +	else
> +		d_instantiate(dentry, inode);
>  	dget(dentry);
>  	return 0;
>=20=20
> @@ -4050,6 +4078,8 @@ enum shmem_param {
>  	Opt_usrquota_inode_hardlimit,
>  	Opt_grpquota_block_hardlimit,
>  	Opt_grpquota_inode_hardlimit,
> +	Opt_casefold,
> +	Opt_strict_encoding,
>  };
>=20=20
>  static const struct constant_table shmem_param_enums_huge[] =3D {
> @@ -4081,9 +4111,47 @@ const struct fs_parameter_spec shmem_fs_parameters=
[] =3D {
>  	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit=
),
>  	fsparam_string("grpquota_inode_hardlimit", Opt_grpquota_inode_hardlimit=
),
>  #endif
> +	fsparam_string("casefold",	Opt_casefold),
> +	fsparam_flag  ("strict_encoding", Opt_strict_encoding),
>  	{}
>  };
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_par=
ameter *param)
> +{
> +	struct shmem_options *ctx =3D fc->fs_private;
> +	unsigned int maj =3D 0, min =3D 0, rev =3D 0, version_number;
> +	char version[10];
> +	int ret;
> +	struct unicode_map *encoding;
> +
> +	if (strncmp(param->string, "utf8-", 5))
> +		return invalfc(fc, "Only utf8 encondings are supported");
> +	ret =3D strscpy(version, param->string + 5, sizeof(version));

the extra buffer and the copy seem unnecessary.  It won't live past this
function anyway. Can you just pass the offseted param->string to
utf8_parse_version?

> +	if (ret < 0)
> +		return invalfc(fc, "Invalid enconding argument: %s",
> +			       param->string);

enconding=3D>encoding

> +
> +	ret =3D utf8_parse_version(version, &maj, &min, &rev);
> +	if (ret)
> +		return invalfc(fc, "Invalid utf8 version: %s", version);
> +	version_number =3D UNICODE_AGE(maj, min, rev);
> +	encoding =3D utf8_load(version_number);

utf8_load(UNICODE_AGE(maj, min, rev));

and drop version_number.

> +	if (IS_ERR(encoding))
> +		return invalfc(fc, "Invalid utf8 version: %s", version);
> +	pr_info("tmpfs: Using encoding provided by mount options: %s\n",
> +		param->string);
> +	ctx->encoding =3D encoding;
> +
> +	return 0;
> +}
> +#else
> +static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_par=
ameter *param)
> +{
> +	return invalfc(fc, "tmpfs: No kernel support for casefold filesystems\n=
");
> +}
> +#endif
> +
>  static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *p=
aram)
>  {
>  	struct shmem_options *ctx =3D fc->fs_private;
> @@ -4242,6 +4310,11 @@ static int shmem_parse_one(struct fs_context *fc, =
struct fs_parameter *param)
>  				       "Group quota inode hardlimit too large.");
>  		ctx->qlimits.grpquota_ihardlimit =3D size;
>  		break;
> +	case Opt_casefold:
> +		return shmem_parse_opt_casefold(fc, param);
> +	case Opt_strict_encoding:
> +		ctx->strict_encoding =3D true;
> +		break;
>  	}
>  	return 0;
>=20=20
> @@ -4471,6 +4544,11 @@ static void shmem_put_super(struct super_block *sb)
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
> @@ -4515,6 +4593,16 @@ static int shmem_fill_super(struct super_block *sb=
, struct fs_context *fc)
>  	}
>  	sb->s_export_op =3D &shmem_export_ops;
>  	sb->s_flags |=3D SB_NOSEC | SB_I_VERSION;
> +
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (ctx->encoding) {
> +		sb->s_encoding =3D ctx->encoding;
> +		generic_set_sb_d_ops(sb);
> +		if (ctx->strict_encoding)
> +			sb->s_encoding_flags =3D SB_ENC_STRICT_MODE_FL;
> +	}
> +#endif
> +
>  #else
>  	sb->s_flags |=3D SB_NOUSER;
>  #endif
> @@ -4704,11 +4792,28 @@ static const struct inode_operations shmem_inode_=
operations =3D {
>  #endif
>  };
>=20=20
> +static struct dentry *shmem_lookup(struct inode *dir, struct dentry *den=
try, unsigned int flags)
> +{
> +	if (dentry->d_name.len > NAME_MAX)
> +		return ERR_PTR(-ENAMETOOLONG);
> +
> +	/*
> +	 * For now, VFS can't deal with case-insensitive negative dentries, so
> +	 * we prevent them from being created
> +	 */
> +	if (IS_CASEFOLDED(dir))
> +		return NULL;
> +
> +	d_add(dentry, NULL);
> +
> +	return NULL;
> +}
> +
>  static const struct inode_operations shmem_dir_inode_operations =3D {
>  #ifdef CONFIG_TMPFS
>  	.getattr	=3D shmem_getattr,
>  	.create		=3D shmem_create,
> -	.lookup		=3D simple_lookup,
> +	.lookup		=3D shmem_lookup,

simple_lookup sets the dentry operations to enable a custom d_delete,
but this disables that. Without it, negative dentries will linger after
the filesystem is gone.

We want to preserve the current behavior both for normal and casefolding
directories.  You need a new flavor of generic_ci_dentry_ops with that
hook for casefolding shmem, as well as ensure &simple_dentry_operations
is still set for every dentry in non-casefolding volumes.

>  	.link		=3D shmem_link,
>  	.unlink		=3D shmem_unlink,
>  	.symlink	=3D shmem_symlink,
> @@ -4791,6 +4896,8 @@ int shmem_init_fs_context(struct fs_context *fc)
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

