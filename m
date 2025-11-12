Return-Path: <linux-fsdevel+bounces-68065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 892C6C52E08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 16:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4D03353BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EEA345759;
	Wed, 12 Nov 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daaqerkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D4345757;
	Wed, 12 Nov 2025 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958793; cv=none; b=Hkbl/5VMPuuKSD0BcbG74ZqWOOQwzXt8DL+R1SWsssvH4y998GljXUWko/4Xgupd5IEzcRHa7CWKqHKV17Sc9siHCgs0X6BIDiBHQXW18kIfmm2NdYI4EdFZDFNiNl3xQALnYMUhQxAd611BHUQsbd+8S+L4Ojra917XrIDb/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958793; c=relaxed/simple;
	bh=W09oq+HYxVgVN/kosChQDcZ+ebdWtAbR+9uFU7ZwbLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QT7hXbcgd7Iget85biBwR1ENfTXqV5goRml2q88sW+FDNZBPs8lpTGXG6TQsPqXKppFBQYXf+JN91bbGaYnnZR/XXWO9LguiHau+wonBqkokxDXjSlcsJnChmgZVOrFTx1mBgK5uPVVYqJBWF6J9BQuXnrC5VTP039U1Vble1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daaqerkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8509AC4CEF5;
	Wed, 12 Nov 2025 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958791;
	bh=W09oq+HYxVgVN/kosChQDcZ+ebdWtAbR+9uFU7ZwbLc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=daaqerkF6xj5TaEr/77ce8B3DNX8JX+Dus7t1apkIl0GhPUei/291tbqIexB+BB0p
	 /KyoISnE0t4xdRZpcMs2CoZOiudDrK3GHCcgq2yTHfzHeln2cpGxm/+npJ6AOX/yDA
	 opHo54wDKao8o8/BwHwKA3SJkdsD2N/5bCmm21v7zgrRNps5sj4UsJ5U7rhh1VrE0R
	 +GPXdxqc/Y7ui4Bh0kd0DS1ZceyVKxs4UX2f9XcTV6++mn1yYXr9t9x7Ng0VW3r09u
	 A7YTdwC64Tkume+ZmW0WRawFCOwySmDmjGb7G3zZJRsCWEL9ZZ5m6Gc+U8yWq8ble0
	 ys72mKLOArnPg==
Message-ID: <32e65149e7678ac3cbc7f8dbed26429fd9c7ae78.camel@kernel.org>
Subject: Re: [PATCH v5 02/14] VFS: introduce start_dirop() and end_dirop()
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
Date: Wed, 12 Nov 2025 09:46:27 -0500
In-Reply-To: <20251106005333.956321-3-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
	 <20251106005333.956321-3-neilb@ownmail.net>
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
> The fact that directory operations (create,remove,rename) are protected
> by a lock on the parent is known widely throughout the kernel.
> In order to change this - to instead lock the target dentry  - it is
> best to centralise this knowledge so it can be changed in one place.
>=20
> This patch introduces start_dirop() which is local to VFS code.
> It performs the required locking for create and remove.  Rename
> will be handled separately.
>=20
> Various functions with names like start_creating() or start_removing_path=
(),
> some of which already exist, will export this functionality beyond the VF=
S.
>=20
> end_dirop() is the partner of start_dirop().  It drops the lock and
> releases the reference on the dentry.
> It *is* exported so that various end_creating etc functions can be inline=
.
>=20
> As vfs_mkdir() drops the dentry on error we cannot use end_dirop() as
> that won't unlock when the dentry IS_ERR().  For now we need an explicit
> unlock when dentry IS_ERR().  I hope to change vfs_mkdir() to unlock
> when it drops a dentry so that explicit unlock can go away.
>=20
> end_dirop() can always be called on the result of start_dirop(), but not
> after vfs_mkdir().  After a vfs_mkdir() we still may need the explicit
> unlock as seen in end_creating_path().
>=20
> As well as adding start_dirop() and end_dirop()
> this patch uses them in:
>  - simple_start_creating (which requires sharing lookup_noperm_common()
>         with libfs.c)
>  - start_removing_path / start_removing_user_path_at
>  - filename_create / end_creating_path()
>  - do_rmdir(), do_unlinkat()
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/internal.h      |  3 ++
>  fs/libfs.c         | 36 ++++++++---------
>  fs/namei.c         | 98 ++++++++++++++++++++++++++++++++++------------
>  include/linux/fs.h |  2 +
>  4 files changed, 95 insertions(+), 44 deletions(-)
>=20
> diff --git a/fs/internal.h b/fs/internal.h
> index 9b2b4d116880..d08d5e2235e9 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -67,6 +67,9 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
>  		const struct path *parentpath,
>  		struct file *file, umode_t mode);
>  struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
> +struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> +			   unsigned int lookup_flags);
> +int lookup_noperm_common(struct qstr *qname, struct dentry *base);
> =20
>  /*
>   * namespace.c
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 1661dcb7d983..2d6657947abd 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2290,27 +2290,25 @@ void stashed_dentry_prune(struct dentry *dentry)
>  	cmpxchg(stashed, dentry, NULL);
>  }
> =20
> -/* parent must be held exclusive */
> +/**
> + * simple_start_creating - prepare to create a given name
> + * @parent: directory in which to prepare to create the name
> + * @name:   the name to be created
> + *
> + * Required lock is taken and a lookup in performed prior to creating an
> + * object in a directory.  No permission checking is performed.
> + *
> + * Returns: a negative dentry on which vfs_create() or similar may
> + *  be attempted, or an error.
> + */
>  struct dentry *simple_start_creating(struct dentry *parent, const char *=
name)
>  {
> -	struct dentry *dentry;
> -	struct inode *dir =3D d_inode(parent);
> +	struct qstr qname =3D QSTR(name);
> +	int err;
> =20
> -	inode_lock(dir);
> -	if (unlikely(IS_DEADDIR(dir))) {
> -		inode_unlock(dir);
> -		return ERR_PTR(-ENOENT);
> -	}
> -	dentry =3D lookup_noperm(&QSTR(name), parent);
> -	if (IS_ERR(dentry)) {
> -		inode_unlock(dir);
> -		return dentry;
> -	}
> -	if (dentry->d_inode) {
> -		dput(dentry);
> -		inode_unlock(dir);
> -		return ERR_PTR(-EEXIST);
> -	}
> -	return dentry;
> +	err =3D lookup_noperm_common(&qname, parent);
> +	if (err)
> +		return ERR_PTR(err);
> +	return start_dirop(parent, &qname, LOOKUP_CREATE | LOOKUP_EXCL);
>  }
>  EXPORT_SYMBOL(simple_start_creating);
> diff --git a/fs/namei.c b/fs/namei.c
> index 39c4d52f5b54..231e1ffd4b8d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2765,6 +2765,48 @@ static int filename_parentat(int dfd, struct filen=
ame *name,
>  	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
>  }
> =20
> +/**
> + * start_dirop - begin a create or remove dirop, performing locking and =
lookup
> + * @parent:       the dentry of the parent in which the operation will o=
ccur
> + * @name:         a qstr holding the name within that parent
> + * @lookup_flags: intent and other lookup flags.
> + *
> + * The lookup is performed and necessary locks are taken so that, on suc=
cess,
> + * the returned dentry can be operated on safely.
> + * The qstr must already have the hash value calculated.
> + *
> + * Returns: a locked dentry, or an error.
> + *
> + */
> +struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> +			   unsigned int lookup_flags)
> +{
> +	struct dentry *dentry;
> +	struct inode *dir =3D d_inode(parent);
> +
> +	inode_lock_nested(dir, I_MUTEX_PARENT);
> +	dentry =3D lookup_one_qstr_excl(name, parent, lookup_flags);
> +	if (IS_ERR(dentry))
> +		inode_unlock(dir);
> +	return dentry;
> +}
> +
> +/**
> + * end_dirop - signal completion of a dirop
> + * @de: the dentry which was returned by start_dirop or similar.
> + *
> + * If the de is an error, nothing happens. Otherwise any lock taken to
> + * protect the dentry is dropped and the dentry itself is release (dput(=
)).
> + */
> +void end_dirop(struct dentry *de)
> +{
> +	if (!IS_ERR(de)) {
> +		inode_unlock(de->d_parent->d_inode);
> +		dput(de);
> +	}
> +}
> +EXPORT_SYMBOL(end_dirop);
> +
>  /* does lookup, returns the object with parent locked */
>  static struct dentry *__start_removing_path(int dfd, struct filename *na=
me,
>  					   struct path *path)
> @@ -2781,10 +2823,9 @@ static struct dentry *__start_removing_path(int df=
d, struct filename *name,
>  		return ERR_PTR(-EINVAL);
>  	/* don't fail immediately if it's r/o, at least try to report other err=
ors */
>  	error =3D mnt_want_write(parent_path.mnt);
> -	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
> -	d =3D lookup_one_qstr_excl(&last, parent_path.dentry, 0);
> +	d =3D start_dirop(parent_path.dentry, &last, 0);
>  	if (IS_ERR(d))
> -		goto unlock;
> +		goto drop;
>  	if (error)
>  		goto fail;
>  	path->dentry =3D no_free_ptr(parent_path.dentry);
> @@ -2792,10 +2833,9 @@ static struct dentry *__start_removing_path(int df=
d, struct filename *name,
>  	return d;
> =20
>  fail:
> -	dput(d);
> +	end_dirop(d);
>  	d =3D ERR_PTR(error);
> -unlock:
> -	inode_unlock(parent_path.dentry->d_inode);
> +drop:
>  	if (!error)
>  		mnt_drop_write(parent_path.mnt);
>  	return d;
> @@ -2910,7 +2950,7 @@ int vfs_path_lookup(struct dentry *dentry, struct v=
fsmount *mnt,
>  }
>  EXPORT_SYMBOL(vfs_path_lookup);
> =20
> -static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
> +int lookup_noperm_common(struct qstr *qname, struct dentry *base)
>  {
>  	const char *name =3D qname->name;
>  	u32 len =3D qname->len;
> @@ -4223,21 +4263,18 @@ static struct dentry *filename_create(int dfd, st=
ruct filename *name,
>  	 */
>  	if (last.name[last.len] && !want_dir)
>  		create_flags &=3D ~LOOKUP_CREATE;
> -	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
> -	dentry =3D lookup_one_qstr_excl(&last, path->dentry,
> -				      reval_flag | create_flags);
> +	dentry =3D start_dirop(path->dentry, &last, reval_flag | create_flags);
>  	if (IS_ERR(dentry))
> -		goto unlock;
> +		goto out_drop_write;
> =20
>  	if (unlikely(error))
>  		goto fail;
> =20
>  	return dentry;
>  fail:
> -	dput(dentry);
> +	end_dirop(dentry);
>  	dentry =3D ERR_PTR(error);
> -unlock:
> -	inode_unlock(path->dentry->d_inode);
> +out_drop_write:
>  	if (!error)
>  		mnt_drop_write(path->mnt);
>  out:
> @@ -4256,11 +4293,26 @@ struct dentry *start_creating_path(int dfd, const=
 char *pathname,
>  }
>  EXPORT_SYMBOL(start_creating_path);
> =20
> +/**
> + * end_creating_path - finish a code section started by start_creating_p=
ath()
> + * @path: the path instantiated by start_creating_path()
> + * @dentry: the dentry returned by start_creating_path()
> + *
> + * end_creating_path() will unlock and locks taken by start_creating_pat=
h()
> + * and drop an references that were taken.  It should only be called
> + * if start_creating_path() returned a non-error.
> + * If vfs_mkdir() was called and it returned an error, that error *shoul=
d*
> + * be passed to end_creating_path() together with the path.
> + */
>  void end_creating_path(const struct path *path, struct dentry *dentry)
>  {
> -	if (!IS_ERR(dentry))
> -		dput(dentry);
> -	inode_unlock(path->dentry->d_inode);
> +	if (IS_ERR(dentry))
> +		/* The parent is still locked despite the error from
> +		 * vfs_mkdir() - must unlock it.
> +		 */
> +		inode_unlock(path->dentry->d_inode);
> +	else
> +		end_dirop(dentry);
>  	mnt_drop_write(path->mnt);
>  	path_put(path);
>  }
> @@ -4592,8 +4644,7 @@ int do_rmdir(int dfd, struct filename *name)
>  	if (error)
>  		goto exit2;
> =20
> -	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
> -	dentry =3D lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
> +	dentry =3D start_dirop(path.dentry, &last, lookup_flags);
>  	error =3D PTR_ERR(dentry);
>  	if (IS_ERR(dentry))
>  		goto exit3;
> @@ -4602,9 +4653,8 @@ int do_rmdir(int dfd, struct filename *name)
>  		goto exit4;
>  	error =3D vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
>  exit4:
> -	dput(dentry);
> +	end_dirop(dentry);
>  exit3:
> -	inode_unlock(path.dentry->d_inode);
>  	mnt_drop_write(path.mnt);
>  exit2:
>  	path_put(&path);
> @@ -4721,8 +4771,7 @@ int do_unlinkat(int dfd, struct filename *name)
>  	if (error)
>  		goto exit2;
>  retry_deleg:
> -	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
> -	dentry =3D lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
> +	dentry =3D start_dirop(path.dentry, &last, lookup_flags);
>  	error =3D PTR_ERR(dentry);
>  	if (!IS_ERR(dentry)) {
> =20
> @@ -4737,9 +4786,8 @@ int do_unlinkat(int dfd, struct filename *name)
>  		error =3D vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
>  				   dentry, &delegated_inode);
>  exit3:
> -		dput(dentry);
> +		end_dirop(dentry);
>  	}
> -	inode_unlock(path.dentry->d_inode);
>  	if (inode)
>  		iput(inode);	/* truncate the inode here */
>  	inode =3D NULL;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 03e450dd5211..9e7556e79d19 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3196,6 +3196,8 @@ extern void iterate_supers_type(struct file_system_=
type *,
>  void filesystems_freeze(void);
>  void filesystems_thaw(void);
> =20
> +void end_dirop(struct dentry *de);
> +
>  extern int dcache_dir_open(struct inode *, struct file *);
>  extern int dcache_dir_close(struct inode *, struct file *);
>  extern loff_t dcache_dir_lseek(struct file *, loff_t, int);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

