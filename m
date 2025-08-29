Return-Path: <linux-fsdevel+bounces-59602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A588BB3B07B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 03:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9E7583B9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE351E3769;
	Fri, 29 Aug 2025 01:27:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B97288A2;
	Fri, 29 Aug 2025 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430858; cv=none; b=s6GTPMprDVnNeYHIfr+EPsxWNJEUiVbxAcxIPCM6nmykZcut7UTq0yvzC3ewvKg7ADc+Ktg6A8YYhlj488i5Ncld/cUtZ6Kd/zeYi2R7/ENxujSxJrdInjOE70fT4GXCnf9P1/xy2//IBSTzBNAZly7yFQIOx5LjSJds4ApeD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430858; c=relaxed/simple;
	bh=qDucb++wbXkYYanQTjKbsVv7wwjV5r+NQhGtCLLjIt0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rip6rvBECWrLqvdS+AeGHucf3lOnITAgdYiPGudkIRMVSNkYMm1hezL6+aQUgjO6riEyKTdnBa8VjeyjOwY350ef2QiGXM+gq6Pgr8oiayA2vUIbZw+GnbUAU5z1Jzus/KMMCMBx7bQKyb+Al1k+Ovy0FaG9k7Yev+pBLlUGIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1urntp-007XjZ-Il;
	Fri, 29 Aug 2025 01:27:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: =?utf-8?q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Theodore Tso" <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 kernel-dev@igalia.com, "Gabriel Krisman Bertazi" <gabriel@krisman.be>
Subject:
 Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
In-reply-to:
 <CAOQ4uxhGmTbCJMz8C2gKzU5hjBBzKqR2eOtRJz4J83AxSD5djg@mail.gmail.com>
References:
 <>, <CAOQ4uxhGmTbCJMz8C2gKzU5hjBBzKqR2eOtRJz4J83AxSD5djg@mail.gmail.com>
Date: Fri, 29 Aug 2025 11:27:30 +1000
Message-id: <175643085095.2234665.7900009371607929733@noble.neil.brown.name>

On Fri, 29 Aug 2025, Amir Goldstein wrote:
>=20
> commit 32786370148617766043f6d054ff40758ce79f21 (HEAD -> ovl_casefold)
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Wed Aug 27 19:55:26 2025 +0200
>=20
>     ovl: make sure that ovl_create_real() returns a hashed dentry
>=20
>     e8bd877fb76bb9f3 ("ovl: fix possible double unlink") added a sanity
>     check of !d_unhashed(child) to try to verify that child dentry was not
>     unlinked while parent dir was unlocked.
>=20
>     This "was not unlink" check has a false positive result in the case of
>     casefolded parent dir, because in that case, ovl_create_temp() returns
>     an unhashed dentry after ovl_create_real() gets an unhashed dentry from
>     ovl_lookup_upper() and makes it positive.
>=20
>     To avoid returning unhashed dentry from ovl_create_temp(), let
>     ovl_create_real() lookup again after making the newdentry positive,
>     so it always returns a hashed positive dentry (or an error).
>=20
>     This fixes the error in ovl_parent_lock() in ovl_check_rename_whiteout()
>     after ovl_create_temp() and allows mount of overlayfs with casefolding
>     enabled layers.
>=20
>     Reported-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>     Closes: https://lore.kernel.org/r/18704e8c-c734-43f3-bc7c-b8be345e1bf5@=
igalia.com/
>     Suggested-by: Neil Brown <neil@brown.name>
>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>=20
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 538a1b2dbb387..a5e9ddf3023b3 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -212,12 +212,32 @@ struct dentry *ovl_create_real(struct ovl_fs
> *ofs, struct dentry *parent,
>                         err =3D -EPERM;
>                 }
>         }
> -       if (!err && WARN_ON(!newdentry->d_inode)) {
> +       if (err)
> +               goto out;
> +
> +       if (WARN_ON(!newdentry->d_inode)) {
>                 /*
>                  * Not quite sure if non-instantiated dentry is legal or no=
t.
>                  * VFS doesn't seem to care so check and warn here.
>                  */
>                 err =3D -EIO;
> +       } else if (d_unhashed(newdentry)) {
> +               struct dentry *d;
> +               /*
> +                * Some filesystems (i.e. casefolded) may return an unhashed
> +                * negative dentry from the ovl_lookup_upper() call before
> +                * ovl_create_real().
> +                * In that case, lookup again after making the newdentry
> +                * positive, so ovl_create_upper() always returns a hashed
> +                * positive dentry.
> +                */
> +               d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, parent,
> +                                    newdentry->d_name.len);
> +               dput(newdentry);
> +               if (IS_ERR_OR_NULL(d))
> +                       err =3D d ? PTR_ERR(d) : -ENOENT;
> +               else
> +                       return d;
>         }
>  out:
>         if (err) {
>=20


