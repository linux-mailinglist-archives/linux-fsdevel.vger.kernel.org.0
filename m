Return-Path: <linux-fsdevel+bounces-64018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6561FBD6229
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 22:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A715F3A1700
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D74730C62D;
	Mon, 13 Oct 2025 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKswOP3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D530C605;
	Mon, 13 Oct 2025 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387607; cv=none; b=M8DIpmkcnQbsZY+Lmh56WsFWhh8L9uv78AWQ0VllGNr5yVcCPNtHgksBbvTyHKZwqg94J+CvTK9m7HPM181VyOqkf7BES/NFlh1oyA61ON3UlGLnd1fuCntpStm1ogLTv+9qqbxQfwN3XMWXxyzupH9+1Xg5rXNMIlufCQfzHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387607; c=relaxed/simple;
	bh=7AKYyDo9YRgfWjkjqDCsr+AI5gn+xU6nxrB2mhKrsmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVNEPc/9yBqVYwfKA4hJSvvJUM1eGUFvx7hw1cV+5ispTEe/pY7WBT2FJYWszLs2oXRjo/sFhxDioZvwx3uS9SUW/rF35Eq4pKW9hm9EhJxv0t4NnraOlsGDhiDSGDoIEZ5M0+xVWhjOy0GjvGEwY2Qu63Ki/UUBTrRT2FufxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKswOP3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EE8C4CEE7;
	Mon, 13 Oct 2025 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387607;
	bh=7AKYyDo9YRgfWjkjqDCsr+AI5gn+xU6nxrB2mhKrsmQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DKswOP3J8KzmwjB6+tH1MMhzGvvpE8+q92VjjxZkb96+E516W8xA7OrNtnBwwy//5
	 18zobh8/DhxMT753geoFpyUsyo3ycP8SEih6FhDAl0RzJUC0Cu9MWKgZdqdtrZ9Axe
	 1E/3myAM34j3ZUXGc6gXHEzyO8qaWJyW4s898JKqPHTWIjp8MJIvu/HBUsBfVSVosz
	 9yBkJKfmmtYADA3aLJtWhpPirpuyKsdnPYOukwMPW5qYoLRjFNh0z1nLc24MkyHbof
	 x13XGa/d4ccZvJMw0onY3D1PGn8vLUTRbT7Thv95JiYizOWN+yV0nYCXy1qoR1DX7g
	 UdEAn6CZUpLBQ==
Message-ID: <4c582926e3996a6582e29fd4e51e926fb9d2c537.camel@kernel.org>
Subject: Re: [PATCH 07/13] vfs: make vfs_create break delegations on parent
 directory
From: Jeff Layton <jlayton@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner	 <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Chuck Lever	 <chuck.lever@oracle.com>, Alexander Aring
 <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,  Paulo
 Alcantara	 <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N	 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM	 <bharathsm@microsoft.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, David Howells	 <dhowells@redhat.com>,
 Tyler Hicks <code@tyhicks.com>, NeilBrown <neil@brown.name>,  Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Amir
 Goldstein <amir73il@gmail.com>, Namjae Jeon	 <linkinjeon@kernel.org>, Steve
 French <smfrench@gmail.com>, Sergey Senozhatsky	
 <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, Kuniyuki
 Iwashima	 <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, 	linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 13 Oct 2025 16:33:22 -0400
In-Reply-To: <20251013-dir-deleg-ro-v1-7-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
	 <20251013-dir-deleg-ro-v1-7-406780a70e5e@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-13 at 10:48 -0400, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
>=20
> Rename vfs_create as __vfs_create, make it static, and add a new
> delegated_inode parameter. Fix do_mknodat to call __vfs_create and wait
> for a delegation break if there is one. Add a new exported vfs_create
> wrapper that passes in NULL for delegated_inode.
>=20

My apologies. I meant to change this to just add the extra parameter to
vfs_create() without all of the wrapper nonsense. I'll plan to re-post
at least once more, but I'll wait a bit in case there are other changes
needed.

> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/namei.c | 55 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 786f42bd184b5dbf6d754fa1fb6c94c0f75429f2..1427c53e13978e70adefdc572=
b71247536985430 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3458,6 +3458,32 @@ static inline umode_t vfs_prepare_mode(struct mnt_=
idmap *idmap,
>  	return mode;
>  }
> =20
> +static int __vfs_create(struct mnt_idmap *idmap, struct inode *dir,
> +			struct dentry *dentry, umode_t mode, bool want_excl,
> +			struct inode **delegated_inode)
> +{
> +	int error;
> +
> +	error =3D may_create(idmap, dir, dentry);
> +	if (error)
> +		return error;
> +
> +	if (!dir->i_op->create)
> +		return -EACCES;	/* shouldn't it be ENOSYS? */
> +
> +	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> +	error =3D security_inode_create(dir, dentry, mode);
> +	if (error)
> +		return error;
> +	error =3D try_break_deleg(dir, delegated_inode);
> +	if (error)
> +		return error;
> +	error =3D dir->i_op->create(idmap, dir, dentry, mode, want_excl);
> +	if (!error)
> +		fsnotify_create(dir, dentry);
> +	return error;
> +}
> +
>  /**
>   * vfs_create - create new file
>   * @idmap:	idmap of the mount the inode was found from
> @@ -3477,23 +3503,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_=
idmap *idmap,
>  int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	       struct dentry *dentry, umode_t mode, bool want_excl)
>  {
> -	int error;
> -
> -	error =3D may_create(idmap, dir, dentry);
> -	if (error)
> -		return error;
> -
> -	if (!dir->i_op->create)
> -		return -EACCES;	/* shouldn't it be ENOSYS? */
> -
> -	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> -	error =3D security_inode_create(dir, dentry, mode);
> -	if (error)
> -		return error;
> -	error =3D dir->i_op->create(idmap, dir, dentry, mode, want_excl);
> -	if (!error)
> -		fsnotify_create(dir, dentry);
> -	return error;
> +	return __vfs_create(idmap, dir, dentry, mode, want_excl, NULL);
>  }
>  EXPORT_SYMBOL(vfs_create);
> =20
> @@ -4365,6 +4375,7 @@ static int do_mknodat(int dfd, struct filename *nam=
e, umode_t mode,
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags =3D 0;
> +	struct inode *delegated_inode =3D NULL;
> =20
>  	error =3D may_mknod(mode);
>  	if (error)
> @@ -4383,8 +4394,9 @@ static int do_mknodat(int dfd, struct filename *nam=
e, umode_t mode,
>  	idmap =3D mnt_idmap(path.mnt);
>  	switch (mode & S_IFMT) {
>  		case 0: case S_IFREG:
> -			error =3D vfs_create(idmap, path.dentry->d_inode,
> -					   dentry, mode, true);
> +			error =3D __vfs_create(idmap, path.dentry->d_inode,
> +					     dentry, mode, true,
> +					     &delegated_inode);
>  			if (!error)
>  				security_path_post_mknod(idmap, dentry);
>  			break;
> @@ -4399,6 +4411,11 @@ static int do_mknodat(int dfd, struct filename *na=
me, umode_t mode,
>  	}
>  out2:
>  	end_creating_path(&path, dentry);
> +	if (delegated_inode) {
> +		error =3D break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry;
> +	}
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |=3D LOOKUP_REVAL;
>  		goto retry;

--=20
Jeff Layton <jlayton@kernel.org>

