Return-Path: <linux-fsdevel+bounces-29205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B000A977155
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413A11F24B40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8302D1C32F8;
	Thu, 12 Sep 2024 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="LmAG0Uum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF991C2DC2;
	Thu, 12 Sep 2024 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168393; cv=none; b=hhOWVWxYBRd5TUz4sooaNGNeH7wj5WBLpGzB9fWsr5KJeNFIZ7JBYpbiHwrklCpmyIZ+N0CGySzlmJkNuRTc0Z0hFH1/wVzOnkOSSKVE9rvIL4OEmuApYRmA3QtZHytXkFKHjvx4mYki9CQBlt5xkz4XEGY0oYqu3KEav4rNCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168393; c=relaxed/simple;
	bh=yHFRb8bX8hM6uJBLmW2HEQiO92SILpa8Lwpt0NwK9mE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hTOgVGy54u0NLwQeZTpeBy/Xc1hpy6U9AK/GrvQKfaWEWofhquH//3sM7LqVHhnEeoJgwuvPK3SLTPj+ht3AZP9vqqwMnk1Prjv0xQhysN8c58w2Zvct3p/LGRjszRLwKroBgf0ojXumHqnQpp6w4KWfybhVnBTZZnwGuOmyuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=LmAG0Uum; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 249AF60007;
	Thu, 12 Sep 2024 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1726168388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XbDAFIYWOpDf3ZnvtGpz/tr6vdDYFyvODcLblGyUz4=;
	b=LmAG0Uumy+pzxdRemWcJZnhzrBS14qCGI9iW4PzzjlsYJcExHrzujLCwEsmAnCuOVInMbw
	FSe+CBAo4PN2BGOcTdmtQDqnKs8qdqzK0SynIEDSp+riEDU11YgWN/YI+KoFLENLrn9GZH
	Pvj19z6zwrNlgf8GDsckrz8VKZs+mPHQUi8KL7LovTME5NSETwHpq++Mmca9+M1ROeyaA1
	RnkVy/N/vCPILCQcIw+ZQky8EMsb6+cx/kBVwWI8HkN0c1/pVmHjC9AuO2rb3cuydUG6yX
	QKUE4PLQ3Z11IEYw+L87bFfyE7xS4ZTpbOmBCF76f624Fkr3KAd5Vv4WlbtyDQ==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 06/10] libfs: Export generic_ci_ dentry functions
In-Reply-To: <20240911144502.115260-7-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 11 Sep 2024 11:44:58 -0300")
References: <20240911144502.115260-1-andrealmeid@igalia.com>
	<20240911144502.115260-7-andrealmeid@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 12 Sep 2024 15:13:05 -0400
Message-ID: <87r09ok7ni.fsf@mailhost.krisman.be>
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

> Export generic_ci_ dentry functions so they can be used by
> case-insensitive filesystems that need something more custom than the
> default one set by `struct generic_ci_dentry_ops`.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v3:
> - New patch
> ---
>  fs/libfs.c         | 8 +++++---
>  include/linux/fs.h | 3 +++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 838524314b1b..c09254ecdcdd 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1783,8 +1783,8 @@ bool is_empty_dir_inode(struct inode *inode)
>   *
>   * Return: 0 if names match, 1 if mismatch, or -ERRNO
>   */
> -static int generic_ci_d_compare(const struct dentry *dentry, unsigned in=
t len,
> -				const char *str, const struct qstr *name)
> +int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
> +			 const char *str, const struct qstr *name)
>  {
>  	const struct dentry *parent;
>  	const struct inode *dir;
> @@ -1827,6 +1827,7 @@ static int generic_ci_d_compare(const struct dentry=
 *dentry, unsigned int len,
>=20=20
>  	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
>  }
> +EXPORT_SYMBOL(generic_ci_d_compare);
>=20=20
>  /**
>   * generic_ci_d_hash - generic d_hash implementation for casefolding fil=
esystems
> @@ -1835,7 +1836,7 @@ static int generic_ci_d_compare(const struct dentry=
 *dentry, unsigned int len,
>   *
>   * Return: 0 if hash was successful or unchanged, and -EINVAL on error
>   */
> -static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *s=
tr)
> +int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
>  {
>  	const struct inode *dir =3D READ_ONCE(dentry->d_inode);
>  	struct super_block *sb =3D dentry->d_sb;
> @@ -1850,6 +1851,7 @@ static int generic_ci_d_hash(const struct dentry *d=
entry, struct qstr *str)
>  		return -EINVAL;
>  	return 0;
>  }
> +EXPORT_SYMBOL(generic_ci_d_hash);
>=20=20
>  static const struct dentry_operations generic_ci_dentry_ops =3D {
>  	.d_hash =3D generic_ci_d_hash,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 937142950dfe..4cd86d36c03d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3386,6 +3386,9 @@ extern int generic_ci_match(const struct inode *par=
ent,
>  			    const struct qstr *folded_name,
>  			    const u8 *de_name, u32 de_name_len);
>  bool generic_ci_validate_strict_name(struct inode *dir, struct qstr *nam=
e);
> +int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
> +int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
> +			 const char *str, const struct qstr *name);

guard these with:

#if IS_ENABLED(CONFIG_UNICODE)
#endif


>=20=20
>  static inline bool sb_has_encoding(const struct super_block *sb)
>  {

--=20
Gabriel Krisman Bertazi

