Return-Path: <linux-fsdevel+bounces-42245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E39A3F639
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA681897F48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687720E001;
	Fri, 21 Feb 2025 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkhOsIiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6461FF7C2;
	Fri, 21 Feb 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145173; cv=none; b=tgtLT1HmaQjN88Ei8fRA/Kie46UoLsw+4ZjX7Q3Zqb4FYVcYij2xvzBKWR7xuaGl2UwVYUfq8HL9TPY5qJFjyktMcLYamnYTIe6estqw/GiHzYJm5vDKHyg4N6602aoTaGUwMHofLgrjrx2/WU3szYmKfhPgNpVlrJTFhizWFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145173; c=relaxed/simple;
	bh=z1Z9OZJropC063FqC/Jwhzp+2Ycqe4yTzD/qrq/ji6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aG01RG48Xu9+tR4MFTaxCNffd8o2gdY5px93Jtzxy81AEo3jjFteI09fZoNTUoEp4TcSvCTKMGZXlsyYGxcDXs0vDISfT30MmzLTxiXNLv83H+RBXN2rL9aznUzXU70ASqYq32wBzj0ypXxjPjwppQHNCmH11fBerN6JW2KoGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkhOsIiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF15C4CED6;
	Fri, 21 Feb 2025 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740145172;
	bh=z1Z9OZJropC063FqC/Jwhzp+2Ycqe4yTzD/qrq/ji6g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PkhOsIiCVeijgpnNW6hVcuKSkWAtwH1WzHmk6fqj+DfI9WZMhYutNI0YwFdFBNQhG
	 i1QqErkQW/+EIfLaD4Zu8FtDfgYKSvN/0DsZHZ28D1gyD/UI6RWdHdzC1AhwEqrv2v
	 OEfkNfDmQRCbw0/p94Us/X5Qf2RoQtuXeGLlF+8qs575HEYeJ7/bbeO+W9+ZbcN99/
	 kVhhSAsV4ZTiP7mose44i95+KXcHEOAXszVcMfrUMqeDDZFvwfKwUMuEOoQpJiUv7b
	 COaYwsZAcBMgD8r8bNEsPcdUGqU+gPZD8/qJ2Q7mvu9Q2YzTsFMIEyARUjg1rmDg7/
	 aqjKJf3s9qH1g==
Message-ID: <0542f4a777bb3fc1ef49fc879ac5f12030aa788a.camel@kernel.org>
Subject: Re: [PATCH 4/6] fuse: return correct dentry for ->mkdir
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos
 Szeredi <miklos@szeredi.hu>,  Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
 <idryomov@gmail.com>, Richard Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Trond Myklebust	 <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, Chuck Lever	 <chuck.lever@oracle.com>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo	 <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Sergey Senozhatsky	 <senozhatsky@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
 netfs@lists.linux.dev
Date: Fri, 21 Feb 2025 08:39:29 -0500
In-Reply-To: <20250220234630.983190-5-neilb@suse.de>
References: <20250220234630.983190-1-neilb@suse.de>
	 <20250220234630.983190-5-neilb@suse.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-21 at 10:36 +1100, NeilBrown wrote:
> fuse already uses d_splice_alias() to ensure an appropriate dentry is
> found for a newly created dentry.  Now that ->mkdir can return that
> dentry we do so.
>=20
> This requires changing create_new_entry() to return a dentry and
> handling that change in all callers.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/fuse/dir.c | 55 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 5bb65f38bfb8..8c44c9c73c38 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -781,9 +781,9 @@ static int fuse_atomic_open(struct inode *dir, struct=
 dentry *entry,
>  /*
>   * Code shared between mknod, mkdir, symlink and link
>   */
> -static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *=
fm,
> -			    struct fuse_args *args, struct inode *dir,
> -			    struct dentry *entry, umode_t mode)
> +static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct f=
use_mount *fm,
> +				       struct fuse_args *args, struct inode *dir,
> +				       struct dentry *entry, umode_t mode)
>  {
>  	struct fuse_entry_out outarg;
>  	struct inode *inode;
> @@ -792,11 +792,11 @@ static int create_new_entry(struct mnt_idmap *idmap=
, struct fuse_mount *fm,
>  	struct fuse_forget_link *forget;
> =20
>  	if (fuse_is_bad(dir))
> -		return -EIO;
> +		return ERR_PTR(-EIO);
> =20
>  	forget =3D fuse_alloc_forget();
>  	if (!forget)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	memset(&outarg, 0, sizeof(outarg));
>  	args->nodeid =3D get_node_id(dir);
> @@ -826,29 +826,27 @@ static int create_new_entry(struct mnt_idmap *idmap=
, struct fuse_mount *fm,
>  			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
>  	if (!inode) {
>  		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  	kfree(forget);
> =20
>  	d_drop(entry);
>  	d =3D d_splice_alias(inode, entry);
>  	if (IS_ERR(d))
> -		return PTR_ERR(d);
> +		return d;
> =20
> -	if (d) {
> +	if (d)
>  		fuse_change_entry_timeout(d, &outarg);
> -		dput(d);
> -	} else {
> +	else
>  		fuse_change_entry_timeout(entry, &outarg);
> -	}
>  	fuse_dir_changed(dir);
> -	return 0;
> +	return d;
> =20
>   out_put_forget_req:
>  	if (err =3D=3D -EEXIST)
>  		fuse_invalidate_entry(entry);
>  	kfree(forget);
> -	return err;
> +	return ERR_PTR(err);
>  }
> =20
>  static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
> @@ -856,6 +854,7 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct=
 inode *dir,
>  {
>  	struct fuse_mknod_in inarg;
>  	struct fuse_mount *fm =3D get_fuse_mount(dir);
> +	struct dentry *de;
>  	FUSE_ARGS(args);
> =20
>  	if (!fm->fc->dont_mask)
> @@ -871,7 +870,12 @@ static int fuse_mknod(struct mnt_idmap *idmap, struc=
t inode *dir,
>  	args.in_args[0].value =3D &inarg;
>  	args.in_args[1].size =3D entry->d_name.len + 1;
>  	args.in_args[1].value =3D entry->d_name.name;
> -	return create_new_entry(idmap, fm, &args, dir, entry, mode);
> +	de =3D create_new_entry(idmap, fm, &args, dir, entry, mode);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de)
> +		dput(de);
> +	return 0;
>  }
> =20
>  static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
> @@ -917,7 +921,7 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *id=
map, struct inode *dir,
>  	args.in_args[0].value =3D &inarg;
>  	args.in_args[1].size =3D entry->d_name.len + 1;
>  	args.in_args[1].value =3D entry->d_name.name;
> -	return ERR_PTR(create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR))=
;
> +	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
>  }
> =20
>  static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> @@ -925,6 +929,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, stru=
ct inode *dir,
>  {
>  	struct fuse_mount *fm =3D get_fuse_mount(dir);
>  	unsigned len =3D strlen(link) + 1;
> +	struct dentry *de;
>  	FUSE_ARGS(args);
> =20
>  	args.opcode =3D FUSE_SYMLINK;
> @@ -934,7 +939,12 @@ static int fuse_symlink(struct mnt_idmap *idmap, str=
uct inode *dir,
>  	args.in_args[1].value =3D entry->d_name.name;
>  	args.in_args[2].size =3D len;
>  	args.in_args[2].value =3D link;
> -	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> +	de =3D create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de)
> +		dput(de);
> +	return 0;
>  }
> =20
>  void fuse_flush_time_update(struct inode *inode)
> @@ -1117,7 +1127,7 @@ static int fuse_rename2(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>  static int fuse_link(struct dentry *entry, struct inode *newdir,
>  		     struct dentry *newent)
>  {
> -	int err;
> +	struct dentry *de;
>  	struct fuse_link_in inarg;
>  	struct inode *inode =3D d_inode(entry);
>  	struct fuse_mount *fm =3D get_fuse_mount(inode);
> @@ -1131,13 +1141,16 @@ static int fuse_link(struct dentry *entry, struct=
 inode *newdir,
>  	args.in_args[0].value =3D &inarg;
>  	args.in_args[1].size =3D newent->d_name.len + 1;
>  	args.in_args[1].value =3D newent->d_name.name;
> -	err =3D create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent,=
 inode->i_mode);
> -	if (!err)
> +	de =3D create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, =
inode->i_mode);
> +	if (!IS_ERR(de)) {
> +		if (de)
> +			dput(de);
> +		de =3D NULL;
>  		fuse_update_ctime_in_cache(inode);
> -	else if (err =3D=3D -EINTR)
> +	} else if (PTR_ERR(de) =3D=3D -EINTR)
>  		fuse_invalidate_attr(inode);
> =20
> -	return err;
> +	return PTR_ERR(de);
>  }
> =20
>  static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,

Pretty straightforward.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

