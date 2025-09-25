Return-Path: <linux-fsdevel+bounces-62785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1699BA0C73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 19:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1333AEB79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B1130C613;
	Thu, 25 Sep 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvgPAcRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEA830ACEC;
	Thu, 25 Sep 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820434; cv=none; b=pGuAhztjwnBh/djHWC+ImFgg6qJ9KHoO8egRvfzuhgLmwbAkOnJl8aeJjs5iGEKa9q3qX+VyI58K3l7xOPiyefPG5VjKm98eA5s8zAiUvSGV4sbc1lnIfcDL/P34cieWdHvFeq1BsHQVDm0NblqiL25uNZYRYNY7UHqbIYGg8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820434; c=relaxed/simple;
	bh=5eJ4xJy2YsIUNbtCnDVHJz0ZvNav85P1yeKen4Lh940=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okaiz3pqKR7mdQi658J0muOXuErBHz8/IEAcFXXuyczyZMOeM6zKEPC8eich5MIh7A9GH/E/wZoHtZt76Cp67/ieEeCmEUoo+RczPIfIbsVvdMRYmNkTsl5/D4AUZu5UE9OJICjsit0saP8OkuD5e3ybWZasNr6Yah+wJrEyF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvgPAcRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0DDC116B1;
	Thu, 25 Sep 2025 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758820433;
	bh=5eJ4xJy2YsIUNbtCnDVHJz0ZvNav85P1yeKen4Lh940=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PvgPAcRNh1V4EAn9JxwSRHQ1uvlRA6u3Oe9FPG/t93wKPQ8OzPCZD4Pmkh+to1wHq
	 QGMucr9rw0GBGwxwaqsMNf90M8PVmVukleoXGmtSa/SW+nL5ZbL7YgKaooQOk5A47a
	 YWpDDly0/g1a+4tv4ktjpWY7Ex42LMnYyJcQMfLeyY/Qh3gQkEsxvKZnD4eRSLtLwc
	 gwHP+TUmHoSIahCtlxAlKFkMdDqFVWBbtnD8Oj5BcKzNVN9lF9cRZ7shhTfkFw/8PL
	 27lSbXFXtmE/z1BQd/1/nXWdjGTVl0fdbFo4NArRSLKgFMhEq88qnrL+zgOTY0ZGfG
	 eE6O7bfuFcM0g==
Message-ID: <f39798ab980e546a822fc83d7f2c5d2b619e6c2a.camel@kernel.org>
Subject: Re: [PATCH v3 05/38] vfs: allow rmdir to wait for delegation break
 on parent
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever	
 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Steve
 French <sfrench@samba.org>,  Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>,  Dai Ngo <Dai.Ngo@oracle.com>, Jonathan
 Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>,  Miklos
 Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich	 <dakr@kernel.org>, David Howells
 <dhowells@redhat.com>, Tyler Hicks	 <code@tyhicks.com>, Namjae Jeon
 <linkinjeon@kernel.org>, Steve French	 <smfrench@gmail.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu	
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Thu, 25 Sep 2025 13:13:49 -0400
In-Reply-To: <20250924-dir-deleg-v3-5-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
	 <20250924-dir-deleg-v3-5-9f3af8bc5c40@kernel.org>
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

On Wed, 2025-09-24 at 14:05 -0400, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
>=20
> Rename vfs_rmdir as __vfs_rmdir, make it static and add a new
> delegated_inode parameter. Add a vfs_rmdir wrapper that passes in a NULL
> pointer for it. Add the necessary try_break_deleg calls to
> __vfs_rmdir(). Convert do_rmdir to use __vfs_rmdir and wait for the
> delegation break to complete before proceeding.
>=20

I've fixed this patch along the lines of the vfs_mkdir() patch
(eliminating the wrapper and just adding the extra parameter). The
updated patch is in my dir-deleg branch.

> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/namei.c | 51 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index c939a58f16f9c4edded424475aff52f2c423d301..4e058b00208c1663ba828c6f8=
ed1f82c26a4f136 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4433,22 +4433,8 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathna=
me, umode_t, mode)
>  	return do_mkdirat(AT_FDCWD, getname(pathname), mode);
>  }
> =20
> -/**
> - * vfs_rmdir - remove directory
> - * @idmap:	idmap of the mount the inode was found from
> - * @dir:	inode of the parent directory
> - * @dentry:	dentry of the child directory
> - *
> - * Remove a directory.
> - *
> - * If the inode has been found through an idmapped mount the idmap of
> - * the vfsmount must be passed through @idmap. This function will then t=
ake
> - * care to map the inode according to @idmap before checking permissions=
.
> - * On non-idmapped mounts or if permission checking is to be performed o=
n the
> - * raw inode simply pass @nop_mnt_idmap.
> - */
> -int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> -		     struct dentry *dentry)
> +static int __vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> +		       struct dentry *dentry, struct inode **delegated_inode)
>  {
>  	int error =3D may_delete(idmap, dir, dentry, 1);
> =20
> @@ -4470,6 +4456,10 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inod=
e *dir,
>  	if (error)
>  		goto out;
> =20
> +	error =3D try_break_deleg(dir, delegated_inode);
> +	if (error)
> +		goto out;
> +
>  	error =3D dir->i_op->rmdir(dir, dentry);
>  	if (error)
>  		goto out;
> @@ -4486,6 +4476,26 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inod=
e *dir,
>  		d_delete_notify(dir, dentry);
>  	return error;
>  }
> +
> +/**
> + * vfs_rmdir - remove directory
> + * @idmap:	idmap of the mount the inode was found from
> + * @dir:	inode of the parent directory
> + * @dentry:	dentry of the child directory
> + *
> + * Remove a directory.
> + *
> + * If the inode has been found through an idmapped mount the idmap of
> + * the vfsmount must be passed through @idmap. This function will then t=
ake
> + * care to map the inode according to @idmap before checking permissions=
.
> + * On non-idmapped mounts or if permission checking is to be performed o=
n the
> + * raw inode simply pass @nop_mnt_idmap.
> + */
> +int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> +		     struct dentry *dentry)
> +{
> +	return __vfs_rmdir(idmap, dir, dentry, NULL);
> +}
>  EXPORT_SYMBOL(vfs_rmdir);
> =20
>  int do_rmdir(int dfd, struct filename *name)
> @@ -4496,6 +4506,7 @@ int do_rmdir(int dfd, struct filename *name)
>  	struct qstr last;
>  	int type;
>  	unsigned int lookup_flags =3D 0;
> +	struct inode *delegated_inode =3D NULL;
>  retry:
>  	error =3D filename_parentat(dfd, name, lookup_flags, &path, &last, &typ=
e);
>  	if (error)
> @@ -4525,7 +4536,8 @@ int do_rmdir(int dfd, struct filename *name)
>  	error =3D security_path_rmdir(&path, dentry);
>  	if (error)
>  		goto exit4;
> -	error =3D vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
> +	error =3D __vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> +			    dentry, &delegated_inode);
>  exit4:
>  	dput(dentry);
>  exit3:
> @@ -4533,6 +4545,11 @@ int do_rmdir(int dfd, struct filename *name)
>  	mnt_drop_write(path.mnt);
>  exit2:
>  	path_put(&path);
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

