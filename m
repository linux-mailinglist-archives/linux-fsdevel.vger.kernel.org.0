Return-Path: <linux-fsdevel+bounces-29203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C9C977145
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD9B21F04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461C1C1ABE;
	Thu, 12 Sep 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="hnX0DScJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54671C1AA2;
	Thu, 12 Sep 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168238; cv=none; b=RLbHnjNLHYScbLXx9BOhUfFCE30xqJm/3J6KBpCWbbjQwYzmTbG9ezo+Ksk5CeWja+i1oxOmLFeOTT77BlreeTC6qFeUzOIDP90vk2Ai0OpBtt8TakRutktxmV6HLFVH4gDMUl8svWOFkshzaDFTo+MqaA3R+pcwbVpyxkLcF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168238; c=relaxed/simple;
	bh=b7UOdguusXvpIYtl4ZK9SkS97+KsMc1YfH8xKYakKUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=undRW8WmyEqyM0YkUaVwFBJANnh5kQbWZeBE7DmJe528cfMTmlqE13JdYUq4H5oE5nQMEMYiUlShx4kQL72C5JvZZflStdVxl1Cww1FwjZVQGqCLY4MOyUfCsBkLSfVTKlrrYC4mmH+xf477UCm1qS3PBZISnmDmlCB1gE2plAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=hnX0DScJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FCB11C0005;
	Thu, 12 Sep 2024 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1726168233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PfYOgXccETc0xeXGIJ6ax3RKeDSTRkDESxyw9QEpx8=;
	b=hnX0DScJNYDebHvMBNSv7fKjiJCxlvmQqPFZVpgHi9ak6wdPqR8EhN3TYFy2O90wDvWhsU
	FrWKJazTv9qPXEmeBOo8FXLpYlw03QHbImpzUE2UdJsBOMHbBP/YLgZRUrYoZgjbGyJQBy
	/omnXC+Cg7gpBikSuAlxtzo2u43xuVg1PJt21jNJJcVr4bT+7J4DNt+yE75vo67edR4AIW
	r3mSr5Na0EAQvurEMqlKU0oT4GnTOEdtgp9wz7dWq6ZQ1jRiy7t+tA/mQMvyu87Be+3/KP
	2DjtYFDlbRgbuHZ39Lxn78wk6wuynoI50YOHrM5InkIleyOqXvefdcvZtIo8hA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 08/10] tmpfs: Add flag FS_CASEFOLD_FL support for
 tmpfs dirs
In-Reply-To: <20240911144502.115260-9-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 11 Sep 2024 11:45:00 -0300")
References: <20240911144502.115260-1-andrealmeid@igalia.com>
	<20240911144502.115260-9-andrealmeid@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 12 Sep 2024 15:10:29 -0400
Message-ID: <87wmjgk7ru.fsf@mailhost.krisman.be>
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

> Enable setting flag FS_CASEFOLD_FL for tmpfs directories, when tmpfs is
> mounted with casefold support. A special check is need for this flag,
> since it can't be set for non-empty directories.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v2:
> - Fixed bug when adding a non-casefold flag in a non-empty dir
> ---
>  include/linux/shmem_fs.h |  6 ++--
>  mm/shmem.c               | 70 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 67 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 1d06b1e5408a..8367ca2b99d9 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -42,10 +42,10 @@ struct shmem_inode_info {
>  	struct inode		vfs_inode;
>  };
>=20=20
> -#define SHMEM_FL_USER_VISIBLE		FS_FL_USER_VISIBLE
> +#define SHMEM_FL_USER_VISIBLE		(FS_FL_USER_VISIBLE | FS_CASEFOLD_FL)
>  #define SHMEM_FL_USER_MODIFIABLE \
> -	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL)
> -#define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL)
> +	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL | FS_CAS=
EFOLD_FL)
> +#define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL | FS_CASEFOLD_=
FL)
>=20=20
>  struct shmem_quota_limits {
>  	qsize_t usrquota_bhardlimit; /* Default user quota block hard limit */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4fde63596ab3..fc0e0cd46146 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2613,13 +2613,62 @@ static int shmem_file_open(struct inode *inode, s=
truct file *file)
>  #ifdef CONFIG_TMPFS_XATTR
>  static int shmem_initxattrs(struct inode *, const struct xattr *, void *=
);
>=20=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +/*
> + * shmem_inode_casefold_flags - Deal with casefold file attribute flag
> + *
> + * The casefold file attribute needs some special checks. I can just be =
added to
> + * an empty dir, and can't be removed from a non-empty dir.
> + */
> +static int shmem_inode_casefold_flags(struct inode *inode, unsigned int =
fsflags,
> +				      struct dentry *dentry, unsigned int *i_flags)
> +{
> +	unsigned int old =3D inode->i_flags;
> +	struct super_block *sb =3D inode->i_sb;
> +
> +	if (fsflags & FS_CASEFOLD_FL) {
> +		if (!(old & S_CASEFOLD)) {
> +			if (!sb->s_encoding)
> +				return -EOPNOTSUPP;
> +
> +			if (!S_ISDIR(inode->i_mode))
> +				return -ENOTDIR;
> +
> +			if (dentry && !simple_empty(dentry))
> +				return -ENOTEMPTY;
> +		}
> +
> +		*i_flags =3D *i_flags | S_CASEFOLD;
> +	} else if (old & S_CASEFOLD) {
> +		if (dentry && !simple_empty(dentry))
> +			return -ENOTEMPTY;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int shmem_inode_casefold_flags(struct inode *inode, unsigned int =
fsflags,
> +				      struct dentry *dentry, unsigned int *i_flags)
> +{
> +	if (fsflags & FS_CASEFOLD_FL)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * chattr's fsflags are unrelated to extended attributes,
>   * but tmpfs has chosen to enable them under the same config option.
>   */
> -static void shmem_set_inode_flags(struct inode *inode, unsigned int fsfl=
ags)
> +static int shmem_set_inode_flags(struct inode *inode, unsigned int fsfla=
gs, struct dentry *dentry)
>  {
>  	unsigned int i_flags =3D 0;
> +	int ret;
> +
> +	ret =3D shmem_inode_casefold_flags(inode, fsflags, dentry, &i_flags);
> +	if (ret)
> +		return ret;
>=20=20
>  	if (fsflags & FS_NOATIME_FL)
>  		i_flags |=3D S_NOATIME;
> @@ -2630,10 +2679,12 @@ static void shmem_set_inode_flags(struct inode *i=
node, unsigned int fsflags)
>  	/*
>  	 * But FS_NODUMP_FL does not require any action in i_flags.
>  	 */
> -	inode_set_flags(inode, i_flags, S_NOATIME | S_APPEND | S_IMMUTABLE);
> +	inode_set_flags(inode, i_flags, S_NOATIME | S_APPEND | S_IMMUTABLE | S_=
CASEFOLD);
> +
> +	return 0;
>  }
>  #else
> -static void shmem_set_inode_flags(struct inode *inode, unsigned int fsfl=
ags)
> +static void shmem_set_inode_flags(struct inode *inode, unsigned int fsfl=
ags, struct dentry *dentry)
>  {
>  }
>  #define shmem_initxattrs NULL
> @@ -2680,7 +2731,7 @@ static struct inode *__shmem_get_inode(struct mnt_i=
dmap *idmap,
>  	info->fsflags =3D (dir =3D=3D NULL) ? 0 :
>  		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
>  	if (info->fsflags)
> -		shmem_set_inode_flags(inode, info->fsflags);
> +		shmem_set_inode_flags(inode, info->fsflags, NULL);
>  	INIT_LIST_HEAD(&info->shrinklist);
>  	INIT_LIST_HEAD(&info->swaplist);
>  	simple_xattrs_init(&info->xattrs);
> @@ -3789,16 +3840,23 @@ static int shmem_fileattr_set(struct mnt_idmap *i=
dmap,
>  {
>  	struct inode *inode =3D d_inode(dentry);
>  	struct shmem_inode_info *info =3D SHMEM_I(inode);
> +	int ret, flags;
>=20=20
>  	if (fileattr_has_fsx(fa))
>  		return -EOPNOTSUPP;
>  	if (fa->flags & ~SHMEM_FL_USER_MODIFIABLE)
>  		return -EOPNOTSUPP;
>=20=20
> -	info->fsflags =3D (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
> +	flags =3D (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
>  		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
>=20=20
> -	shmem_set_inode_flags(inode, info->fsflags);
> +	ret =3D shmem_set_inode_flags(inode, flags, dentry);
> +
> +	if (ret)
> +		return ret;
> +
> +	info->fsflags =3D flags;
> +
>  	inode_set_ctime_current(inode);
>  	inode_inc_iversion(inode);
>  	return 0;

--=20
Gabriel Krisman Bertazi

