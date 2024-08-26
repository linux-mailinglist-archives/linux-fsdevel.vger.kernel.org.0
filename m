Return-Path: <linux-fsdevel+bounces-27212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F8195F97D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F042815C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95A1991DB;
	Mon, 26 Aug 2024 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="GLBS+gR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FA8172D;
	Mon, 26 Aug 2024 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699781; cv=none; b=W1gzDJuyob8wa/7d+1W4sSrdeW2xR4XNSNkXwJ/JlIjPfhgeaQHvsxzaBm3O6z992T29EP05i8I/8bM3mUjoEv7gsZhXB0FqsZZRrgp9aIWqrPeFyMwfpQ9zAQHXxV6t3fEj1Npmv8CLTGSXbvZykxDQnWtMrhFTjkVr9wbAp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699781; c=relaxed/simple;
	bh=cx468KJ08rlmZd4wLEzE3TVaVa41wb+HjrHLhhigw4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dt/8N3IQRT2c9pSU7vJpQDpxwMsyVkDU/5N+7lonK3TcKm6uboP4no7Mja7bYtI1g6YkOK+PsWXEQDdavcazQKmYPsfwDGBnAfkQTIvpSyt1zCSo09UeQftG3ifqokXz5ki5C7+olATc+8GtP3wfbrp9kPNLF5HhHKihgnYwEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=GLBS+gR2; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id BCB4240005;
	Mon, 26 Aug 2024 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1724699776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0VEqc8BYGwvTO4wyQo53jv3gizHDf8cXhhgy61CCnM=;
	b=GLBS+gR2PhYxpT3tU4PmPMQS8KVT06tkCf4EC7RPqeaRnrP6Mhzzq9nz6URF4Yzu9S5pO4
	1LVGpJVKcUwIEXq/vRpeYZc2QKlY8QTfDpj+NgCQVwYmPmWBnPHAgHz++iaM1jFNsTkJsv
	NjoUXHbq/KpIy2g+lcFX3XbEj97XkKh68unmBVfRKKpAcY/KhpixH60bN/Y9Rb+xNGtfiH
	rxysY4bypf+NbR33J+s57EfRMv6OI6DorkgMbgokVnUArnSPoJHWTCkAcBhQl/wdUSSolZ
	3iP7hrTBZBmYal6iR9bKouTjZ/R3vSBK5HQg8GGyP30tBvcqp+tS9kwKFhwMPw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,
  krisman@kernel.org,  Daniel Rosenberg <drosen@google.com>,
  smcv@collabora.com
Subject: Re: [PATCH 1/5] tmpfs: Add casefold lookup support
In-Reply-To: <20240823173332.281211-2-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 23 Aug 2024 14:33:28 -0300")
References: <20240823173332.281211-1-andrealmeid@igalia.com>
	<20240823173332.281211-2-andrealmeid@igalia.com>
Date: Mon, 26 Aug 2024 15:16:13 -0400
Message-ID: <871q2bf62q.fsf@mailhost.krisman.be>
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

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Enable casefold lookup in tmpfs, based on the enconding defined by
> userspace. That means that instead of comparing byte per byte a file
> name, it compares to a case-insensitive equivalent of the Unicode
> string.

Hey,
>
> * dcache handling
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

Right. Hopefully we can lift the limitation once we get the negative
dentry support for casefolded directories merged.

> And would be perceived as inconsistency from userspace point of view,
> because even that we match files in a case-insensitive manner, we still
> honor whatever is the initial filename.
>
> Along with that, tmpfs stores only the first equivalent name dentry used
> in the dcache, preventing duplications of dentries in the dcache. The
> d_compare() version for casefold files stores a normalized string, and
> before every lookup, the filename is normalized as well, achieving a
> casefolded lookup.

This is a bit misleading, because d_compare doesn't store
anything. d_compare does a case-insensitive comparison of the
filename-under-lookup with the dentry name, but it doesn't store
filename-under-lookup.

>  2 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 1d06b1e5408a..1a1196b077a6 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -73,6 +73,7 @@ struct shmem_sb_info {
>  	struct list_head shrinklist;  /* List of shinkable inodes */
>  	unsigned long shrinklist_len; /* Length of shrinklist */
>  	struct shmem_quota_limits qlimits; /* Default quota limits */
> +	bool casefold;

This is redundant. you can just check sb->s_encoding !=3D NULL.
>  };
>=20=20
>  static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5a77acf6ac6a..aa272c62f811 100644
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
> @@ -3427,6 +3431,12 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (sb_has_strict_encoding(dir->i_sb) && IS_CASEFOLDED(dir) &&
> +	    dir->i_sb->s_encoding && utf8_validate(dir->i_sb->s_encoding, &dent=
ry->d_name))
> +		return -EINVAL;
> +#endif

Can you made this a helper that other filesystems can use?  Also,
sorting it to check IS_CASEFOLDED(dir) first would be a good idea.

> +
>  	error =3D simple_acl_create(dir, inode);
>  	if (error)
>  		goto out_iput;
> @@ -3435,6 +3445,9 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *=
dir,
>  	if (error && error !=3D -EOPNOTSUPP)
>  		goto out_iput;
>=20=20
> +	if (IS_CASEFOLDED(dir))
> +		d_add(dentry, NULL);
> +

I get why you do this here and elsewhere: Since we disable negative
dentries in case-insensitive directories, you have an unhashed dentry
here.  We can get away with it in ext4/f2fs because the next lookup will
find the file on disk and create the dentry, but in shmem we need to
hash it.

But it is not the right way to do it. you are effectively creating a
negative dentry to turn it positive right below. One problem with that
is that if simple_offset_add() fails, you left an illegal negative
dentry in a case-insensitive directory. Another, is that a parallel
lookup will be able to find the negative dentry temporarily.  fsnotify
will also behave weirdly.

What I think you should do is call d_add once with the proper inode and
never call d_instantiate for it.

> +	/*
> +	 * For now, VFS can't deal with case-insensitive negative dentries, so
> +	 * we destroy them
> +	 */
> +	if (IS_CASEFOLDED(dir))
> +		d_invalidate(dentry);
> +
>  	return 0;
>  }

s/destroy/invalidate/


> @@ -4471,6 +4497,11 @@ static void shmem_put_super(struct super_block *sb)
>  {
>  	struct shmem_sb_info *sbinfo =3D SHMEM_SB(sb);
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (sbinfo->casefold)
> +		utf8_unload(sb->s_encoding);
> +#endif

if (sb->s_encoding)
  utf8_unload(sb->s_encoding);

> +#if IS_ENABLED(CONFIG_UNICODE)
> +	if (ctx->encoding) {
> +		sb->s_encoding =3D ctx->encoding;
> +		generic_set_sb_d_ops(sb);
> +		if (ctx->strict_encoding)
> +			sb->s_encoding_flags =3D SB_ENC_STRICT_MODE_FL;
> +		sbinfo->casefold =3D true;
> +	}
> +#endif
> +
>  #else
>  	sb->s_flags |=3D SB_NOUSER;
>  #endif
> @@ -4704,11 +4746,28 @@ static const struct inode_operations shmem_inode_=
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
>  	.link		=3D shmem_link,
>  	.unlink		=3D shmem_unlink,
>  	.symlink	=3D shmem_symlink,
> @@ -4791,6 +4850,8 @@ int shmem_init_fs_context(struct fs_context *fc)
>  	ctx->uid =3D current_fsuid();
>  	ctx->gid =3D current_fsgid();
>=20=20
> +	ctx->encoding =3D NULL;
> +

I find the organization of this patchset a bit weird because the other
part of the init_fs_context is only done in patch 3.  Perhaps 1 and 3
should be merged together to make review easier.


--=20
Gabriel Krisman Bertazi

