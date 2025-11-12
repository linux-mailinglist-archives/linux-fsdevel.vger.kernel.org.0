Return-Path: <linux-fsdevel+bounces-68098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC53C54378
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3224A34DF09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C89134A78C;
	Wed, 12 Nov 2025 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXFkZ64S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFFF19F137;
	Wed, 12 Nov 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976192; cv=none; b=dEepY1xZ860dPWkk9iWqZodzs8Axn77WkWuMjymfgdWEYiZZaGlOMP6+tTFlZnZjoJAl7Hb83LB0tk+Ewh9Uc58K2uArw6Q8ABaUVkl0cVO7wXIvO3uzD5fp9GV8/KogqbAAjzpPHZE0YKmatCLmO4q52td/Qw5BKGX7VFEc84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976192; c=relaxed/simple;
	bh=p9hYXB8ZS+HmnDb4dTYqYkw5CEH2Z5Ksj0/1/HguPyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3kuvARgojsJ2l5bDEWudlE5/PHvNJrW0WRqrnzBVeHzHFwawNHikliVg4n/CeQD8RsIF7yaMU729e4CnPx4CNynnEFpkEDZMZlFJtdpNTCfzhA5MYqFtbdmDXYCn/RFTQHMTKSaAXXwQhNup/9p8w2usceTOd5l0OMcP4uS6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXFkZ64S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB12DC4CEF8;
	Wed, 12 Nov 2025 19:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762976192;
	bh=p9hYXB8ZS+HmnDb4dTYqYkw5CEH2Z5Ksj0/1/HguPyw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SXFkZ64SoYG2qFTcvGq/xOnFtJG7gAz2v/4A3U4j0dETnvH67Jj1Wh4G8hPBlN7Re
	 /AKGM+pmc6ktFBxd9lczLCVVWLXT7NC/3XF3iXGnY6rSze/D1YSjBB53d1LItSyxRy
	 sPd1T0c2vSjKP1Dk16XHmijAQxaOyEOPU3wr1PTyVT4lTY6t4wCh5WwBGxQpxogQtq
	 5z61cFt03JFdG+/uqffbAYxtZc8sZOg+fNABhX97YTRYohRVBkoIeBTQ5hNYzK+RJW
	 TqfEW9d7xODzA05mvybuk+pnQfhCqFEdSatO5HJEphazueIvBlTQV/C0lj5F5OV6oU
	 DM/u3zH8SlSjQ==
Message-ID: <78514a914be35c0ae84574c998f982bc73fdd4cf.camel@kernel.org>
Subject: Re: [PATCH v5 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner
	 <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, Chris Mason	
 <clm@fb.com>, David Sterba <dsterba@suse.com>, David Howells
 <dhowells@redhat.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich	
 <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, Miklos Szeredi	
 <miklos@szeredi.hu>, Chuck Lever <chuck.lever@oracle.com>, Olga
 Kornievskaia	 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Namjae
 Jeon	 <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, Sergey
 Senozhatsky	 <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>,
 John Johansen	 <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris	 <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Stephen Smalley	 <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,  Mateusz Guzik <mjguzik@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger	
 <stefanb@linux.ibm.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, 	linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Date: Wed, 12 Nov 2025 14:36:27 -0500
In-Reply-To: <20251106005333.956321-11-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
	 <20251106005333.956321-11-neilb@ownmail.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 11:50 +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
>=20
> Several callers perform a rename on a dentry they already have, and only
> require lookup for the target name.  This includes smb/server and a few
> different places in overlayfs.
>=20
> start_renaming_dentry() performs the required lookup and takes the
> required lock using lock_rename_child()
>=20
> It is used in three places in overlayfs and in ksmbd_vfs_rename().
>=20
> In the ksmbd case, the parent of the source is not important - the
> source must be renamed from wherever it is.  So start_renaming_dentry()
> allows rd->old_parent to be NULL and only checks it if it is non-NULL.
> On success rd->old_parent will be the parent of old_dentry with an extra
> reference taken.  Other start_renaming function also now take the extra
> reference and end_renaming() now drops this reference as well.
>=20
> ovl_lookup_temp(), ovl_parent_lock(), and ovl_parent_unlock() are
> all removed as they are no longer needed.
>=20
> OVL_TEMPNAME_SIZE and ovl_tempname() are now declared in overlayfs.h so
> that ovl_check_rename_whiteout() can access them.
>=20
> ovl_copy_up_workdir() now always cleans up on error.
>=20
> Reviewed-by: Namjae Jeon <linkinjeon@kernel.org> (for ksmbd part)
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c               | 108 ++++++++++++++++++++++++++++++++++++---
>  fs/overlayfs/copy_up.c   |  54 +++++++++-----------
>  fs/overlayfs/dir.c       |  19 +------
>  fs/overlayfs/overlayfs.h |   8 +--
>  fs/overlayfs/super.c     |  22 ++++----
>  fs/overlayfs/util.c      |  11 ----
>  fs/smb/server/vfs.c      |  60 ++++------------------
>  include/linux/namei.h    |   2 +
>  8 files changed, 150 insertions(+), 134 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index bad6c9d540f9..4b740048df97 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3669,7 +3669,7 @@ EXPORT_SYMBOL(unlock_rename);
> =20
>  /**
>   * __start_renaming - lookup and lock names for rename
> - * @rd:           rename data containing parent and flags, and
> + * @rd:           rename data containing parents and flags, and
>   *                for receiving found dentries
>   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
>   *                LOOKUP_NO_SYMLINKS etc).
> @@ -3680,8 +3680,8 @@ EXPORT_SYMBOL(unlock_rename);
>   * rename.
>   *
>   * On success the found dentries are stored in @rd.old_dentry,
> - * @rd.new_dentry.  These references and the lock are dropped by
> - * end_renaming().
> + * @rd.new_dentry and an extra ref is taken on @rd.old_parent.
> + * These references and the lock are dropped by end_renaming().
>   *
>   * The passed in qstrs must have the hash calculated, and no permission
>   * checking is performed.
> @@ -3735,6 +3735,7 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
> =20
>  	rd->old_dentry =3D d1;
>  	rd->new_dentry =3D d2;
> +	dget(rd->old_parent);
>  	return 0;
> =20
>  out_dput_d2:
> @@ -3748,7 +3749,7 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
> =20
>  /**
>   * start_renaming - lookup and lock names for rename with permission che=
cking
> - * @rd:           rename data containing parent and flags, and
> + * @rd:           rename data containing parents and flags, and
>   *                for receiving found dentries
>   * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
>   *                LOOKUP_NO_SYMLINKS etc).
> @@ -3759,8 +3760,8 @@ __start_renaming(struct renamedata *rd, int lookup_=
flags,
>   * rename.
>   *
>   * On success the found dentries are stored in @rd.old_dentry,
> - * @rd.new_dentry.  These references and the lock are dropped by
> - * end_renaming().
> + * @rd.new_dentry.  Also the refcount on @rd->old_parent is increased.
> + * These references and the lock are dropped by end_renaming().
>   *
>   * The passed in qstrs need not have the hash calculated, and basic
>   * eXecute permission checking is performed against @rd.mnt_idmap.
> @@ -3782,11 +3783,106 @@ int start_renaming(struct renamedata *rd, int lo=
okup_flags,
>  }
>  EXPORT_SYMBOL(start_renaming);
> =20
> +static int
> +__start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> +			struct dentry *old_dentry, struct qstr *new_last)
> +{
> +	struct dentry *trap;
> +	struct dentry *d2;
> +	int target_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +	int err;
> +
> +	if (rd->flags & RENAME_EXCHANGE)
> +		target_flags =3D 0;
> +	if (rd->flags & RENAME_NOREPLACE)
> +		target_flags |=3D LOOKUP_EXCL;
> +
> +	/* Already have the dentry - need to be sure to lock the correct parent=
 */
> +	trap =3D lock_rename_child(old_dentry, rd->new_parent);
> +	if (IS_ERR(trap))
> +		return PTR_ERR(trap);
> +	if (d_unhashed(old_dentry) ||
> +	    (rd->old_parent && rd->old_parent !=3D old_dentry->d_parent)) {
> +		/* dentry was removed, or moved and explicit parent requested */
> +		err =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	d2 =3D lookup_one_qstr_excl(new_last, rd->new_parent,
> +				  lookup_flags | target_flags);
> +	err =3D PTR_ERR(d2);
> +	if (IS_ERR(d2))
> +		goto out_unlock;
> +
> +	if (old_dentry =3D=3D trap) {
> +		/* source is an ancestor of target */
> +		err =3D -EINVAL;
> +		goto out_dput_d2;
> +	}
> +
> +	if (d2 =3D=3D trap) {
> +		/* target is an ancestor of source */
> +		if (rd->flags & RENAME_EXCHANGE)
> +			err =3D -EINVAL;
> +		else
> +			err =3D -ENOTEMPTY;
> +		goto out_dput_d2;
> +	}
> +
> +	rd->old_dentry =3D dget(old_dentry);
> +	rd->new_dentry =3D d2;
> +	rd->old_parent =3D dget(old_dentry->d_parent);
> +	return 0;
> +
> +out_dput_d2:
> +	dput(d2);
> +out_unlock:
> +	unlock_rename(old_dentry->d_parent, rd->new_parent);
> +	return err;
> +}
> +
> +/**
> + * start_renaming_dentry - lookup and lock name for rename with permissi=
on checking
> + * @rd:           rename data containing parents and flags, and
> + *                for receiving found dentries
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + * @old_dentry:   dentry of name to move
> + * @new_last:     name of target in @rd.new_parent
> + *
> + * Look up target name and ensure locks are in place for
> + * rename.
> + *
> + * On success the found dentry is stored in @rd.new_dentry and
> + * @rd.old_parent is confirmed to be the parent of @old_dentry.  If it
> + * was originally %NULL, it is set.  In either case a reference is taken
> + * so that end_renaming() can have a stable reference to unlock.
> + *
> + * References and the lock can be dropped with end_renaming()
> + *
> + * The passed in qstr need not have the hash calculated, and basic
> + * eXecute permission checking is performed against @rd.mnt_idmap.
> + *
> + * Returns: zero or an error.
> + */
> +int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> +			  struct dentry *old_dentry, struct qstr *new_last)
> +{
> +	int err;
> +
> +	err =3D lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent);
> +	if (err)
> +		return err;
> +	return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_last);
> +}
> +EXPORT_SYMBOL(start_renaming_dentry);
> +
>  void end_renaming(struct renamedata *rd)
>  {
>  	unlock_rename(rd->old_parent, rd->new_parent);
>  	dput(rd->old_dentry);
>  	dput(rd->new_dentry);
> +	dput(rd->old_parent);
>  }
>  EXPORT_SYMBOL(end_renaming);
> =20
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index e2bdac4317e7..9911a346b477 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -523,8 +523,8 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>  {
>  	struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>  	struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> -	struct dentry *index =3D NULL;
>  	struct dentry *temp =3D NULL;
> +	struct renamedata rd =3D {};
>  	struct qstr name =3D { };
>  	int err;
> =20
> @@ -556,17 +556,15 @@ static int ovl_create_index(struct dentry *dentry, =
const struct ovl_fh *fh,
>  	if (err)
>  		goto out;
> =20
> -	err =3D ovl_parent_lock(indexdir, temp);
> +	rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +	rd.old_parent =3D indexdir;
> +	rd.new_parent =3D indexdir;
> +	err =3D start_renaming_dentry(&rd, 0, temp, &name);
>  	if (err)
>  		goto out;
> -	index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> -	if (IS_ERR(index)) {
> -		err =3D PTR_ERR(index);
> -	} else {
> -		err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
> -		dput(index);
> -	}
> -	ovl_parent_unlock(indexdir);
> +
> +	err =3D ovl_do_rename_rd(&rd);
> +	end_renaming(&rd);
>  out:
>  	if (err)
>  		ovl_cleanup(ofs, indexdir, temp);
> @@ -763,7 +761,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>  	struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>  	struct inode *inode;
>  	struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
> -	struct dentry *temp, *upper, *trap;
> +	struct renamedata rd =3D {};
> +	struct dentry *temp;
>  	struct ovl_cu_creds cc;
>  	int err;
>  	struct ovl_cattr cattr =3D {
> @@ -807,29 +806,24 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>  	 * ovl_copy_up_data(), so lock workdir and destdir and make sure that
>  	 * temp wasn't moved before copy up completion or cleanup.
>  	 */
> -	trap =3D lock_rename(c->workdir, c->destdir);
> -	if (trap || temp->d_parent !=3D c->workdir) {
> -		/* temp or workdir moved underneath us? abort without cleanup */
> -		dput(temp);
> +	rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +	rd.old_parent =3D c->workdir;
> +	rd.new_parent =3D c->destdir;
> +	rd.flags =3D 0;
> +	err =3D start_renaming_dentry(&rd, 0, temp,
> +				    &QSTR_LEN(c->destname.name, c->destname.len));
> +	if (err) {
> +		/* temp or workdir moved underneath us? map to -EIO */
>  		err =3D -EIO;
> -		if (!IS_ERR(trap))
> -			unlock_rename(c->workdir, c->destdir);
> -		goto out;
>  	}
> -
> -	err =3D ovl_copy_up_metadata(c, temp);
>  	if (err)
> -		goto cleanup;
> +		goto cleanup_unlocked;
> =20
> -	upper =3D ovl_lookup_upper(ofs, c->destname.name, c->destdir,
> -				 c->destname.len);
> -	err =3D PTR_ERR(upper);
> -	if (IS_ERR(upper))
> -		goto cleanup;
> +	err =3D ovl_copy_up_metadata(c, temp);
> +	if (!err)
> +		err =3D ovl_do_rename_rd(&rd);
> +	end_renaming(&rd);
> =20
> -	err =3D ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
> -	unlock_rename(c->workdir, c->destdir);
> -	dput(upper);
>  	if (err)
>  		goto cleanup_unlocked;
> =20
> @@ -850,8 +844,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
> =20
>  	return err;
> =20
> -cleanup:
> -	unlock_rename(c->workdir, c->destdir);
>  cleanup_unlocked:
>  	ovl_cleanup(ofs, c->workdir, temp);
>  	dput(temp);
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index cf6fc48459f3..6b2f88edb497 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -57,8 +57,7 @@ int ovl_cleanup(struct ovl_fs *ofs, struct dentry *work=
dir,
>  	return 0;
>  }
> =20
> -#define OVL_TEMPNAME_SIZE 20
> -static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
> +void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  {
>  	static atomic_t temp_id =3D ATOMIC_INIT(0);
> =20
> @@ -66,22 +65,6 @@ static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  	snprintf(name, OVL_TEMPNAME_SIZE, "#%x", atomic_inc_return(&temp_id));
>  }
> =20
> -struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
> -{
> -	struct dentry *temp;
> -	char name[OVL_TEMPNAME_SIZE];
> -
> -	ovl_tempname(name);
> -	temp =3D ovl_lookup_upper(ofs, name, workdir, strlen(name));
> -	if (!IS_ERR(temp) && temp->d_inode) {
> -		pr_err("workdir/%s already exists\n", name);
> -		dput(temp);
> -		temp =3D ERR_PTR(-EIO);
> -	}
> -
> -	return temp;
> -}
> -
>  static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
>  					      struct dentry *workdir)
>  {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 3cc85a893b5c..746bc4ad7b37 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -447,11 +447,6 @@ static inline bool ovl_open_flags_need_copy_up(int f=
lags)
>  }
> =20
>  /* util.c */
> -int ovl_parent_lock(struct dentry *parent, struct dentry *child);
> -static inline void ovl_parent_unlock(struct dentry *parent)
> -{
> -	inode_unlock(parent->d_inode);
> -}
>  int ovl_get_write_access(struct dentry *dentry);
>  void ovl_put_write_access(struct dentry *dentry);
>  void ovl_start_write(struct dentry *dentry);
> @@ -888,7 +883,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
>  			       struct dentry *parent, struct dentry *newdentry,
>  			       struct ovl_cattr *attr);
>  int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir, struct dentr=
y *dentry);
> -struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r);
> +#define OVL_TEMPNAME_SIZE 20
> +void ovl_tempname(char name[OVL_TEMPNAME_SIZE]);
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
>  			       struct ovl_cattr *attr);
> =20
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 6e0816c1147a..a721ef2b90e8 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -566,9 +566,10 @@ static int ovl_check_rename_whiteout(struct ovl_fs *=
ofs)
>  {
>  	struct dentry *workdir =3D ofs->workdir;
>  	struct dentry *temp;
> -	struct dentry *dest;
>  	struct dentry *whiteout;
>  	struct name_snapshot name;
> +	struct renamedata rd =3D {};
> +	char name2[OVL_TEMPNAME_SIZE];
>  	int err;
> =20
>  	temp =3D ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
> @@ -576,23 +577,21 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
>  	if (IS_ERR(temp))
>  		return err;
> =20
> -	err =3D ovl_parent_lock(workdir, temp);
> +	rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +	rd.old_parent =3D workdir;
> +	rd.new_parent =3D workdir;
> +	rd.flags =3D RENAME_WHITEOUT;
> +	ovl_tempname(name2);
> +	err =3D start_renaming_dentry(&rd, 0, temp, &QSTR(name2));
>  	if (err) {
>  		dput(temp);
>  		return err;
>  	}
> -	dest =3D ovl_lookup_temp(ofs, workdir);
> -	err =3D PTR_ERR(dest);
> -	if (IS_ERR(dest)) {
> -		dput(temp);
> -		ovl_parent_unlock(workdir);
> -		return err;
> -	}
> =20
>  	/* Name is inline and stable - using snapshot as a copy helper */
>  	take_dentry_name_snapshot(&name, temp);
> -	err =3D ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_WHITEOU=
T);
> -	ovl_parent_unlock(workdir);
> +	err =3D ovl_do_rename_rd(&rd);
> +	end_renaming(&rd);
>  	if (err) {
>  		if (err =3D=3D -EINVAL)
>  			err =3D 0;
> @@ -616,7 +615,6 @@ static int ovl_check_rename_whiteout(struct ovl_fs *o=
fs)
>  	ovl_cleanup(ofs, workdir, temp);
>  	release_dentry_name_snapshot(&name);
>  	dput(temp);
> -	dput(dest);
> =20
>  	return err;
>  }
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 2da1c035f716..fffc22859211 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1548,14 +1548,3 @@ void ovl_copyattr(struct inode *inode)
>  	i_size_write(inode, i_size_read(realinode));
>  	spin_unlock(&inode->i_lock);
>  }
> -
> -int ovl_parent_lock(struct dentry *parent, struct dentry *child)
> -{
> -	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> -	if (!child ||
> -	    (!d_unhashed(child) && child->d_parent =3D=3D parent))
> -		return 0;
> -
> -	inode_unlock(parent->d_inode);
> -	return -EINVAL;
> -}
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 7c4ddc43ab39..f54b5b0aaba2 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -663,7 +663,6 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const cha=
r *oldname,
>  int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_pat=
h,
>  		     char *newname, int flags)
>  {
> -	struct dentry *old_parent, *new_dentry, *trap;
>  	struct dentry *old_child =3D old_path->dentry;
>  	struct path new_path;
>  	struct qstr new_last;
> @@ -673,7 +672,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const s=
truct path *old_path,
>  	struct ksmbd_file *parent_fp;
>  	int new_type;
>  	int err, lookup_flags =3D LOOKUP_NO_SYMLINKS;
> -	int target_lookup_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> =20
>  	if (ksmbd_override_fsids(work))
>  		return -ENOMEM;
> @@ -684,14 +682,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const =
struct path *old_path,
>  		goto revert_fsids;
>  	}
> =20
> -	/*
> -	 * explicitly handle file overwrite case, for compatibility with
> -	 * filesystems that may not support rename flags (e.g: fuse)
> -	 */
> -	if (flags & RENAME_NOREPLACE)
> -		target_lookup_flags |=3D LOOKUP_EXCL;
> -	flags &=3D ~(RENAME_NOREPLACE);
> -
>  retry:
>  	err =3D vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
>  				     &new_path, &new_last, &new_type,
> @@ -708,17 +698,14 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const=
 struct path *old_path,
>  	if (err)
>  		goto out2;
> =20
> -	trap =3D lock_rename_child(old_child, new_path.dentry);
> -	if (IS_ERR(trap)) {
> -		err =3D PTR_ERR(trap);
> +	rd.mnt_idmap		=3D mnt_idmap(old_path->mnt);
> +	rd.old_parent		=3D NULL;
> +	rd.new_parent		=3D new_path.dentry;
> +	rd.flags		=3D flags;
> +	rd.delegated_inode	=3D NULL,
> +	err =3D start_renaming_dentry(&rd, lookup_flags, old_child, &new_last);
> +	if (err)
>  		goto out_drop_write;
> -	}
> -
> -	old_parent =3D dget(old_child->d_parent);
> -	if (d_unhashed(old_child)) {
> -		err =3D -EINVAL;
> -		goto out3;
> -	}
> =20
>  	parent_fp =3D ksmbd_lookup_fd_inode(old_child->d_parent);
>  	if (parent_fp) {
> @@ -731,44 +718,17 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const=
 struct path *old_path,
>  		ksmbd_fd_put(work, parent_fp);
>  	}
> =20
> -	new_dentry =3D lookup_one_qstr_excl(&new_last, new_path.dentry,
> -					  lookup_flags | target_lookup_flags);
> -	if (IS_ERR(new_dentry)) {
> -		err =3D PTR_ERR(new_dentry);
> -		goto out3;
> -	}
> -
> -	if (d_is_symlink(new_dentry)) {
> +	if (d_is_symlink(rd.new_dentry)) {
>  		err =3D -EACCES;
> -		goto out4;
> -	}
> -
> -	if (old_child =3D=3D trap) {
> -		err =3D -EINVAL;
> -		goto out4;
> -	}
> -
> -	if (new_dentry =3D=3D trap) {
> -		err =3D -ENOTEMPTY;
> -		goto out4;
> +		goto out3;
>  	}
> =20
> -	rd.mnt_idmap		=3D mnt_idmap(old_path->mnt),
> -	rd.old_parent		=3D old_parent,
> -	rd.old_dentry		=3D old_child,
> -	rd.new_parent		=3D new_path.dentry,
> -	rd.new_dentry		=3D new_dentry,
> -	rd.flags		=3D flags,
> -	rd.delegated_inode	=3D NULL,
>  	err =3D vfs_rename(&rd);
>  	if (err)
>  		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
> =20
> -out4:
> -	dput(new_dentry);
>  out3:
> -	dput(old_parent);
> -	unlock_rename(old_parent, new_path.dentry);
> +	end_renaming(&rd);
>  out_drop_write:
>  	mnt_drop_write(old_path->mnt);
>  out2:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 7fdd9fdcbd2b..c47713e9867c 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -159,6 +159,8 @@ extern struct dentry *lock_rename_child(struct dentry=
 *, struct dentry *);
>  extern void unlock_rename(struct dentry *, struct dentry *);
>  int start_renaming(struct renamedata *rd, int lookup_flags,
>  		   struct qstr *old_last, struct qstr *new_last);
> +int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> +			  struct dentry *old_dentry, struct qstr *new_last);
>  void end_renaming(struct renamedata *rd);
> =20
>  /**

Reviewed-by: Jeff Layton <jlayton@kernel.org>

