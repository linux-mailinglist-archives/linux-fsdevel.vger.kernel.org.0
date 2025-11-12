Return-Path: <linux-fsdevel+bounces-68070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA437C52F23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 16:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11743350319
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DE733BBC4;
	Wed, 12 Nov 2025 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSPBb516"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E0338931;
	Wed, 12 Nov 2025 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959713; cv=none; b=QI/94osqJNJx7V7CYg9RyPj7XgqfAHPDZKRePqiA9JdEP+fuk+63w1PuYa1R8YP2cnMuiCfywUGVhtE0aKDANJNUPCMrfClOzvWAotXZ1RzHIvxZW2t4+GiJ4iYjQ6XgVMI+Nw0Eoq1ejeE5vbnYX0r3ESlDbMRreDOdswUgxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959713; c=relaxed/simple;
	bh=tayKidNgtaY6pxZsm4DyMV+Bgmlb1U0dE3JcZxYSgvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eG37dBQj8foRcWMaewDX+V3cDE2/bjpbvnbJ3QmgbTKf+Iuz70wbvhDvlFMi/QtNS3eVbSO1r1tceKV7B4Q+4uXGlVevPqVGcRq7ohF8ohkWbsZag+inmllFpbFgdz5xu1RWAcVHwiPU2StTLO7G6K+tDu3hihUAbBCkKA+t0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSPBb516; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3422FC4CEF1;
	Wed, 12 Nov 2025 15:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762959713;
	bh=tayKidNgtaY6pxZsm4DyMV+Bgmlb1U0dE3JcZxYSgvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WSPBb516MWVdmkiqvFGBfI1FA5tAQVTSSlpiKtlby0DXsfFNUJEbfq0SreQp7+MOH
	 P+h7mZWEZAITD31QqNOfaPN0Aq1FRIUyCaW7qvoo8H2hO84Vy9lkTgQXsUWcrXePsn
	 m2oOV7SA5XQqNOi+yQKdU3PfUZKkZMpRSndLpD+WkiSQXO9RGkyMnt5k8kLJ4OcGUt
	 wHgAmubqHRREiEkVmYqy/PbVm17EHc/vEzdy1BnW2uCCLsRtAOGq4mzm1T/QvcjUUu
	 eAxCUyDpM+oj4aKMCSvsq0N0CC2M0wlLynRQL6O3h8yc6wEvw61Lxtx6/aQSRXkgI5
	 e3oOOhqoFDLOg==
Message-ID: <4a5c4bf1a299f487c4f97e0054293cbeff139fa7.camel@kernel.org>
Subject: Re: [PATCH v5 08/14] VFS: add start_creating_killable() and
 start_removing_killable()
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
Date: Wed, 12 Nov 2025 10:01:49 -0500
In-Reply-To: <20251106005333.956321-9-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
	 <20251106005333.956321-9-neilb@ownmail.net>
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
> These are similar to start_creating() and start_removing(), but allow a
> fatal signal to abort waiting for the lock.
>=20
> They are used in btrfs for subvol creation and removal.
>=20
> btrfs_may_create() no longer needs IS_DEADDIR() and
> start_creating_killable() includes that check.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/btrfs/ioctl.c      | 41 +++++++---------------
>  fs/namei.c            | 80 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/namei.h |  6 ++++
>  3 files changed, 95 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 8cb7d5a462ef..d0c3bb0423bb 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -904,14 +904,9 @@ static noinline int btrfs_mksubvol(struct dentry *pa=
rent,
>  	struct fscrypt_str name_str =3D FSTR_INIT((char *)qname->name, qname->l=
en);
>  	int ret;
> =20
> -	ret =3D down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
> -	if (ret =3D=3D -EINTR)
> -		return ret;
> -
> -	dentry =3D lookup_one(idmap, qname, parent);
> -	ret =3D PTR_ERR(dentry);
> +	dentry =3D start_creating_killable(idmap, parent, qname);
>  	if (IS_ERR(dentry))
> -		goto out_unlock;
> +		return PTR_ERR(dentry);
> =20
>  	ret =3D btrfs_may_create(idmap, dir, dentry);
>  	if (ret)
> @@ -940,9 +935,7 @@ static noinline int btrfs_mksubvol(struct dentry *par=
ent,
>  out_up_read:
>  	up_read(&fs_info->subvol_sem);
>  out_dput:
> -	dput(dentry);
> -out_unlock:
> -	btrfs_inode_unlock(BTRFS_I(dir), 0);
> +	end_creating(dentry, parent);
>  	return ret;
>  }
> =20
> @@ -2417,18 +2410,10 @@ static noinline int btrfs_ioctl_snap_destroy(stru=
ct file *file,
>  		goto free_subvol_name;
>  	}
> =20
> -	ret =3D down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
> -	if (ret =3D=3D -EINTR)
> -		goto free_subvol_name;
> -	dentry =3D lookup_one(idmap, &QSTR(subvol_name), parent);
> +	dentry =3D start_removing_killable(idmap, parent, &QSTR(subvol_name));
>  	if (IS_ERR(dentry)) {
>  		ret =3D PTR_ERR(dentry);
> -		goto out_unlock_dir;
> -	}
> -
> -	if (d_really_is_negative(dentry)) {
> -		ret =3D -ENOENT;
> -		goto out_dput;
> +		goto out_end_removing;
>  	}
> =20
>  	inode =3D d_inode(dentry);
> @@ -2449,7 +2434,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct=
 file *file,
>  		 */
>  		ret =3D -EPERM;
>  		if (!btrfs_test_opt(fs_info, USER_SUBVOL_RM_ALLOWED))
> -			goto out_dput;
> +			goto out_end_removing;
> =20
>  		/*
>  		 * Do not allow deletion if the parent dir is the same
> @@ -2460,21 +2445,21 @@ static noinline int btrfs_ioctl_snap_destroy(stru=
ct file *file,
>  		 */
>  		ret =3D -EINVAL;
>  		if (root =3D=3D dest)
> -			goto out_dput;
> +			goto out_end_removing;
> =20
>  		ret =3D inode_permission(idmap, inode, MAY_WRITE | MAY_EXEC);
>  		if (ret)
> -			goto out_dput;
> +			goto out_end_removing;
>  	}
> =20
>  	/* check if subvolume may be deleted by a user */
>  	ret =3D btrfs_may_delete(idmap, dir, dentry, 1);
>  	if (ret)
> -		goto out_dput;
> +		goto out_end_removing;
> =20
>  	if (btrfs_ino(BTRFS_I(inode)) !=3D BTRFS_FIRST_FREE_OBJECTID) {
>  		ret =3D -EINVAL;
> -		goto out_dput;
> +		goto out_end_removing;
>  	}
> =20
>  	btrfs_inode_lock(BTRFS_I(inode), 0);
> @@ -2483,10 +2468,8 @@ static noinline int btrfs_ioctl_snap_destroy(struc=
t file *file,
>  	if (!ret)
>  		d_delete_notify(dir, dentry);
> =20
> -out_dput:
> -	dput(dentry);
> -out_unlock_dir:
> -	btrfs_inode_unlock(BTRFS_I(dir), 0);
> +out_end_removing:
> +	end_removing(dentry);
>  free_subvol_name:
>  	kfree(subvol_name_ptr);
>  free_parent:
> diff --git a/fs/namei.c b/fs/namei.c
> index 729b42fb143b..e70d056b9543 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2778,19 +2778,33 @@ static int filename_parentat(int dfd, struct file=
name *name,
>   * Returns: a locked dentry, or an error.
>   *
>   */
> -struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> -			   unsigned int lookup_flags)
> +static struct dentry *__start_dirop(struct dentry *parent, struct qstr *=
name,
> +				    unsigned int lookup_flags,
> +				    unsigned int state)
>  {
>  	struct dentry *dentry;
>  	struct inode *dir =3D d_inode(parent);
> =20
> -	inode_lock_nested(dir, I_MUTEX_PARENT);
> +	if (state =3D=3D TASK_KILLABLE) {
> +		int ret =3D down_write_killable_nested(&dir->i_rwsem,
> +						     I_MUTEX_PARENT);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	} else {
> +		inode_lock_nested(dir, I_MUTEX_PARENT);
> +	}
>  	dentry =3D lookup_one_qstr_excl(name, parent, lookup_flags);
>  	if (IS_ERR(dentry))
>  		inode_unlock(dir);
>  	return dentry;
>  }
> =20
> +struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> +			   unsigned int lookup_flags)
> +{
> +	return __start_dirop(parent, name, lookup_flags, TASK_NORMAL);
> +}
> +
>  /**
>   * end_dirop - signal completion of a dirop
>   * @de: the dentry which was returned by start_dirop or similar.
> @@ -3275,6 +3289,66 @@ struct dentry *start_removing(struct mnt_idmap *id=
map, struct dentry *parent,
>  }
>  EXPORT_SYMBOL(start_removing);
> =20
> +/**
> + * start_creating_killable - prepare to create a given name with permiss=
ion checking
> + * @idmap:  idmap of the mount
> + * @parent: directory in which to prepare to create the name
> + * @name:   the name to be created
> + *
> + * Locks are taken and a lookup in performed prior to creating
> + * an object in a directory.  Permission checking (MAY_EXEC) is performe=
d
> + * against @idmap.
> + *
> + * If the name already exists, a positive dentry is returned.
> + *
> + * If a signal is received or was already pending, the function aborts
> + * with -EINTR;
> + *
> + * Returns: a negative or positive dentry, or an error.
> + */
> +struct dentry *start_creating_killable(struct mnt_idmap *idmap,
> +				       struct dentry *parent,
> +				       struct qstr *name)
> +{
> +	int err =3D lookup_one_common(idmap, name, parent);
> +
> +	if (err)
> +		return ERR_PTR(err);
> +	return __start_dirop(parent, name, LOOKUP_CREATE, TASK_KILLABLE);
> +}
> +EXPORT_SYMBOL(start_creating_killable);
> +
> +/**
> + * start_removing_killable - prepare to remove a given name with permiss=
ion checking
> + * @idmap:  idmap of the mount
> + * @parent: directory in which to find the name
> + * @name:   the name to be removed
> + *
> + * Locks are taken and a lookup in performed prior to removing
> + * an object from a directory.  Permission checking (MAY_EXEC) is perfor=
med
> + * against @idmap.
> + *
> + * If the name doesn't exist, an error is returned.
> + *
> + * end_removing() should be called when removal is complete, or aborted.
> + *
> + * If a signal is received or was already pending, the function aborts
> + * with -EINTR;
> + *
> + * Returns: a positive dentry, or an error.
> + */
> +struct dentry *start_removing_killable(struct mnt_idmap *idmap,
> +				       struct dentry *parent,
> +				       struct qstr *name)
> +{
> +	int err =3D lookup_one_common(idmap, name, parent);
> +
> +	if (err)
> +		return ERR_PTR(err);
> +	return __start_dirop(parent, name, 0, TASK_KILLABLE);
> +}
> +EXPORT_SYMBOL(start_removing_killable);
> +
>  /**
>   * start_creating_noperm - prepare to create a given name without permis=
sion checking
>   * @parent: directory in which to prepare to create the name
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index d089e4e8fdd0..196c66156a8a 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -93,6 +93,12 @@ struct dentry *start_creating(struct mnt_idmap *idmap,=
 struct dentry *parent,
>  			      struct qstr *name);
>  struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
>  			      struct qstr *name);
> +struct dentry *start_creating_killable(struct mnt_idmap *idmap,
> +				       struct dentry *parent,
> +				       struct qstr *name);
> +struct dentry *start_removing_killable(struct mnt_idmap *idmap,
> +				       struct dentry *parent,
> +				       struct qstr *name);
>  struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
>  struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
>  struct dentry *start_removing_dentry(struct dentry *parent,

Nice. Maybe we can start using the killable versions in more places
this way!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

