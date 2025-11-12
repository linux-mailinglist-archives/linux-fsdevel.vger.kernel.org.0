Return-Path: <linux-fsdevel+bounces-68100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E5FC54408
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5884342807
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504534DB63;
	Wed, 12 Nov 2025 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB/2F25h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C1265CA2;
	Wed, 12 Nov 2025 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976500; cv=none; b=ByGvVMZiFcXvaE3HtHLhV5drdW3v4nLtdyZynEtRZ7+WBsdC/kOZMIiEwVo3xBN+iPCJn9JONl+0NrbBsQyIze9y111g0dCkVoi5OYon8b3vkjL8Hk9JWZG7a0xP+oHVft/DnwWmrHRKJs94xlcb/QjBauFnpvXe1sq9ch2RAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976500; c=relaxed/simple;
	bh=Hj3j3OT3s1rQpHHI3xOj05x8VeFVMmrBY6TBTRy5mGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jd5RzNGTnZaSMxa2imVqweJqx+/k33xcCWtRXGMsCBAUe3yo0GjCmQ18DvIg6AuzfYT7kHrmdWgpYVLVZRD9qSWZ6YYgMMcnoBgIv8Pnb5SHvWbbVs6TlJJgac9iXLeZi6UHoLd0CzZBsbBAOfbpDq8RDXyMSBAUyatSKB/bOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB/2F25h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD71CC4CEF1;
	Wed, 12 Nov 2025 19:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762976499;
	bh=Hj3j3OT3s1rQpHHI3xOj05x8VeFVMmrBY6TBTRy5mGk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TB/2F25h56FgcDh7VSajolPQGA1DbS25embWOeauSgyZKAdgGgXsPYvrsiR8jdKXM
	 uUWC7zawJ9KeZDZBlh6Xfhv6ChhF5hhMIVjWWyNQLBVR3zwiZ+BAD0JpB//2Grq490
	 83mdpcyIzE0AiwMlDDwExsoBZvQOj4pNTwYlkKadRyjoo2qDimlBA//Ux6P4n2iQ0h
	 4bWueJdf5KQpHl9OeVeibp4lCzY1zLfZADgOkwgAt5rizZvQI288KsVg5JxSXO/bRk
	 OC5v9oj2TwYtReAhawAj5Ndld+OvAkSNgvCwQTFS1Ze83BDZ0dEjt3rpiSWLY8DXkl
	 W4ofwrza3r0Eg==
Message-ID: <c8e194d04c0d1debbaa367a0727cc5b412c73842.camel@kernel.org>
Subject: Re: [PATCH v5 12/14] ecryptfs: use new
 start_creating/start_removing APIs
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
Date: Wed, 12 Nov 2025 14:41:35 -0500
In-Reply-To: <20251106005333.956321-13-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
	 <20251106005333.956321-13-neilb@ownmail.net>
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
> This requires the addition of start_creating_dentry() which is given the
> dentry which has already been found, and asks for it to be locked and
> its parent validated.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
>=20
> ---
> changes since v4
> - two places in ecryptfs uses dget_parent(dentry->d_parent),
>   thus incorrectly. getting grandparent.  Changed to
>   dget_parent(dentry).
> ---
>  fs/ecryptfs/inode.c   | 153 ++++++++++++++++++++----------------------
>  fs/namei.c            |  33 +++++++++
>  include/linux/namei.h |   2 +
>  3 files changed, 107 insertions(+), 81 deletions(-)
>=20
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index fc6d37419753..37d6293600c7 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -24,18 +24,26 @@
>  #include <linux/unaligned.h>
>  #include "ecryptfs_kernel.h"
> =20
> -static int lock_parent(struct dentry *dentry,
> -		       struct dentry **lower_dentry,
> -		       struct inode **lower_dir)
> +static struct dentry *ecryptfs_start_creating_dentry(struct dentry *dent=
ry)
>  {
> -	struct dentry *lower_dir_dentry;
> +	struct dentry *parent =3D dget_parent(dentry);
> +	struct dentry *ret;
> =20
> -	lower_dir_dentry =3D ecryptfs_dentry_to_lower(dentry->d_parent);
> -	*lower_dir =3D d_inode(lower_dir_dentry);
> -	*lower_dentry =3D ecryptfs_dentry_to_lower(dentry);
> +	ret =3D start_creating_dentry(ecryptfs_dentry_to_lower(parent),
> +				    ecryptfs_dentry_to_lower(dentry));
> +	dput(parent);
> +	return ret;
> +}
> =20
> -	inode_lock_nested(*lower_dir, I_MUTEX_PARENT);
> -	return (*lower_dentry)->d_parent =3D=3D lower_dir_dentry ? 0 : -EINVAL;
> +static struct dentry *ecryptfs_start_removing_dentry(struct dentry *dent=
ry)
> +{
> +	struct dentry *parent =3D dget_parent(dentry);
> +	struct dentry *ret;
> +
> +	ret =3D start_removing_dentry(ecryptfs_dentry_to_lower(parent),
> +				    ecryptfs_dentry_to_lower(dentry));
> +	dput(parent);
> +	return ret;
>  }
> =20
>  static int ecryptfs_inode_test(struct inode *inode, void *lower_inode)
> @@ -141,15 +149,12 @@ static int ecryptfs_do_unlink(struct inode *dir, st=
ruct dentry *dentry,
>  	struct inode *lower_dir;
>  	int rc;
> =20
> -	rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -	dget(lower_dentry);	// don't even try to make the lower negative
> -	if (!rc) {
> -		if (d_unhashed(lower_dentry))
> -			rc =3D -EINVAL;
> -		else
> -			rc =3D vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry,
> -					NULL);
> -	}
> +	lower_dentry =3D ecryptfs_start_removing_dentry(dentry);
> +	if (IS_ERR(lower_dentry))
> +		return PTR_ERR(lower_dentry);
> +
> +	lower_dir =3D lower_dentry->d_parent->d_inode;
> +	rc =3D vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
>  	if (rc) {
>  		printk(KERN_ERR "Error in vfs_unlink; rc =3D [%d]\n", rc);
>  		goto out_unlock;
> @@ -158,8 +163,7 @@ static int ecryptfs_do_unlink(struct inode *dir, stru=
ct dentry *dentry,
>  	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
>  	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
>  out_unlock:
> -	dput(lower_dentry);
> -	inode_unlock(lower_dir);
> +	end_removing(lower_dentry);
>  	if (!rc)
>  		d_drop(dentry);
>  	return rc;
> @@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_inode,
>  	struct inode *lower_dir;
>  	struct inode *inode;
> =20
> -	rc =3D lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
> -	if (!rc)
> -		rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> -				lower_dentry, mode, true);
> +	lower_dentry =3D ecryptfs_start_creating_dentry(ecryptfs_dentry);
> +	if (IS_ERR(lower_dentry))
> +		return ERR_CAST(lower_dentry);
> +	lower_dir =3D lower_dentry->d_parent->d_inode;
> +	rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> +			lower_dentry, mode, true);
>  	if (rc) {
>  		printk(KERN_ERR "%s: Failure to create dentry in lower fs; "
>  		       "rc =3D [%d]\n", __func__, rc);
> @@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
>  	fsstack_copy_attr_times(directory_inode, lower_dir);
>  	fsstack_copy_inode_size(directory_inode, lower_dir);
>  out_lock:
> -	inode_unlock(lower_dir);
> +	end_creating(lower_dentry, NULL);
>  	return inode;
>  }
> =20
> @@ -433,10 +439,12 @@ static int ecryptfs_link(struct dentry *old_dentry,=
 struct inode *dir,
> =20
>  	file_size_save =3D i_size_read(d_inode(old_dentry));
>  	lower_old_dentry =3D ecryptfs_dentry_to_lower(old_dentry);
> -	rc =3D lock_parent(new_dentry, &lower_new_dentry, &lower_dir);
> -	if (!rc)
> -		rc =3D vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
> -			      lower_new_dentry, NULL);
> +	lower_new_dentry =3D ecryptfs_start_creating_dentry(new_dentry);
> +	if (IS_ERR(lower_new_dentry))
> +		return PTR_ERR(lower_new_dentry);
> +	lower_dir =3D lower_new_dentry->d_parent->d_inode;
> +	rc =3D vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
> +		      lower_new_dentry, NULL);
>  	if (rc || d_really_is_negative(lower_new_dentry))
>  		goto out_lock;
>  	rc =3D ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb);
> @@ -448,7 +456,7 @@ static int ecryptfs_link(struct dentry *old_dentry, s=
truct inode *dir,
>  		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
>  	i_size_write(d_inode(new_dentry), file_size_save);
>  out_lock:
> -	inode_unlock(lower_dir);
> +	end_creating(lower_new_dentry, NULL);
>  	return rc;
>  }
> =20
> @@ -468,9 +476,11 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
>  	size_t encoded_symlen;
>  	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =3D NULL;
> =20
> -	rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -	if (rc)
> -		goto out_lock;
> +	lower_dentry =3D ecryptfs_start_creating_dentry(dentry);
> +	if (IS_ERR(lower_dentry))
> +		return PTR_ERR(lower_dentry);
> +	lower_dir =3D lower_dentry->d_parent->d_inode;
> +
>  	mount_crypt_stat =3D &ecryptfs_superblock_to_private(
>  		dir->i_sb)->mount_crypt_stat;
>  	rc =3D ecryptfs_encrypt_and_encode_filename(&encoded_symname,
> @@ -490,7 +500,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
>  	fsstack_copy_attr_times(dir, lower_dir);
>  	fsstack_copy_inode_size(dir, lower_dir);
>  out_lock:
> -	inode_unlock(lower_dir);
> +	end_creating(lower_dentry, NULL);
>  	if (d_really_is_negative(dentry))
>  		d_drop(dentry);
>  	return rc;
> @@ -501,12 +511,14 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idm=
ap *idmap, struct inode *dir,
>  {
>  	int rc;
>  	struct dentry *lower_dentry;
> +	struct dentry *lower_dir_dentry;
>  	struct inode *lower_dir;
> =20
> -	rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -	if (rc)
> -		goto out;
> -
> +	lower_dentry =3D ecryptfs_start_creating_dentry(dentry);
> +	if (IS_ERR(lower_dentry))
> +		return lower_dentry;
> +	lower_dir_dentry =3D dget(lower_dentry->d_parent);
> +	lower_dir =3D lower_dir_dentry->d_inode;
>  	lower_dentry =3D vfs_mkdir(&nop_mnt_idmap, lower_dir,
>  				 lower_dentry, mode);
>  	rc =3D PTR_ERR(lower_dentry);
> @@ -522,7 +534,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
>  	fsstack_copy_inode_size(dir, lower_dir);
>  	set_nlink(dir, lower_dir->i_nlink);
>  out:
> -	inode_unlock(lower_dir);
> +	end_creating(lower_dentry, lower_dir_dentry);
>  	if (d_really_is_negative(dentry))
>  		d_drop(dentry);
>  	return ERR_PTR(rc);
> @@ -534,21 +546,18 @@ static int ecryptfs_rmdir(struct inode *dir, struct=
 dentry *dentry)
>  	struct inode *lower_dir;
>  	int rc;
> =20
> -	rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -	dget(lower_dentry);	// don't even try to make the lower negative
> -	if (!rc) {
> -		if (d_unhashed(lower_dentry))
> -			rc =3D -EINVAL;
> -		else
> -			rc =3D vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
> -	}
> +	lower_dentry =3D ecryptfs_start_removing_dentry(dentry);
> +	if (IS_ERR(lower_dentry))
> +		return PTR_ERR(lower_dentry);
> +	lower_dir =3D lower_dentry->d_parent->d_inode;
> +
> +	rc =3D vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
>  	if (!rc) {
>  		clear_nlink(d_inode(dentry));
>  		fsstack_copy_attr_times(dir, lower_dir);
>  		set_nlink(dir, lower_dir->i_nlink);
>  	}
> -	dput(lower_dentry);
> -	inode_unlock(lower_dir);
> +	end_removing(lower_dentry);
>  	if (!rc)
>  		d_drop(dentry);
>  	return rc;
> @@ -562,10 +571,12 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inod=
e *dir,
>  	struct dentry *lower_dentry;
>  	struct inode *lower_dir;
> =20
> -	rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -	if (!rc)
> -		rc =3D vfs_mknod(&nop_mnt_idmap, lower_dir,
> -			       lower_dentry, mode, dev);
> +	lower_dentry =3D ecryptfs_start_creating_dentry(dentry);
> +	if (IS_ERR(lower_dentry))
> +		return PTR_ERR(lower_dentry);
> +	lower_dir =3D lower_dentry->d_parent->d_inode;
> +
> +	rc =3D vfs_mknod(&nop_mnt_idmap, lower_dir, lower_dentry, mode, dev);
>  	if (rc || d_really_is_negative(lower_dentry))
>  		goto out;
>  	rc =3D ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
> @@ -574,7 +585,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>  	fsstack_copy_attr_times(dir, lower_dir);
>  	fsstack_copy_inode_size(dir, lower_dir);
>  out:
> -	inode_unlock(lower_dir);
> +	end_removing(lower_dentry);
>  	if (d_really_is_negative(dentry))
>  		d_drop(dentry);
>  	return rc;
> @@ -590,7 +601,6 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode=
 *old_dir,
>  	struct dentry *lower_new_dentry;
>  	struct dentry *lower_old_dir_dentry;
>  	struct dentry *lower_new_dir_dentry;
> -	struct dentry *trap;
>  	struct inode *target_inode;
>  	struct renamedata rd =3D {};
> =20
> @@ -605,31 +615,13 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct ino=
de *old_dir,
> =20
>  	target_inode =3D d_inode(new_dentry);
> =20
> -	trap =3D lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
> -	if (IS_ERR(trap))
> -		return PTR_ERR(trap);
> -	dget(lower_new_dentry);
> -	rc =3D -EINVAL;
> -	if (lower_old_dentry->d_parent !=3D lower_old_dir_dentry)
> -		goto out_lock;
> -	if (lower_new_dentry->d_parent !=3D lower_new_dir_dentry)
> -		goto out_lock;
> -	if (d_unhashed(lower_old_dentry) || d_unhashed(lower_new_dentry))
> -		goto out_lock;
> -	/* source should not be ancestor of target */
> -	if (trap =3D=3D lower_old_dentry)
> -		goto out_lock;
> -	/* target should not be ancestor of source */
> -	if (trap =3D=3D lower_new_dentry) {
> -		rc =3D -ENOTEMPTY;
> -		goto out_lock;
> -	}
> +	rd.mnt_idmap  =3D &nop_mnt_idmap;
> +	rd.old_parent =3D lower_old_dir_dentry;
> +	rd.new_parent =3D lower_new_dir_dentry;
> +	rc =3D start_renaming_two_dentries(&rd, lower_old_dentry, lower_new_den=
try);
> +	if (rc)
> +		return rc;
> =20
> -	rd.mnt_idmap		=3D &nop_mnt_idmap;
> -	rd.old_parent		=3D lower_old_dir_dentry;
> -	rd.old_dentry		=3D lower_old_dentry;
> -	rd.new_parent		=3D lower_new_dir_dentry;
> -	rd.new_dentry		=3D lower_new_dentry;
>  	rc =3D vfs_rename(&rd);
>  	if (rc)
>  		goto out_lock;
> @@ -640,8 +632,7 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode=
 *old_dir,
>  	if (new_dir !=3D old_dir)
>  		fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dentry));
>  out_lock:
> -	dput(lower_new_dentry);
> -	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
> +	end_renaming(&rd);
>  	return rc;
>  }
> =20
> diff --git a/fs/namei.c b/fs/namei.c
> index 7f0384ceb976..2444c7ddb926 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3397,6 +3397,39 @@ struct dentry *start_removing_noperm(struct dentry=
 *parent,
>  }
>  EXPORT_SYMBOL(start_removing_noperm);
> =20
> +/**
> + * start_creating_dentry - prepare to create a given dentry
> + * @parent: directory from which dentry should be removed
> + * @child:  the dentry to be removed
> + *
> + * A lock is taken to protect the dentry again other dirops and
> + * the validity of the dentry is checked: correct parent and still hashe=
d.
> + *
> + * If the dentry is valid and negative a reference is taken and
> + * returned.  If not an error is returned.
> + *
> + * end_creating() should be called when creation is complete, or aborted=
.
> + *
> + * Returns: the valid dentry, or an error.
> + */
> +struct dentry *start_creating_dentry(struct dentry *parent,
> +				     struct dentry *child)
> +{
> +	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> +	if (unlikely(IS_DEADDIR(parent->d_inode) ||
> +		     child->d_parent !=3D parent ||
> +		     d_unhashed(child))) {
> +		inode_unlock(parent->d_inode);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	if (d_is_positive(child)) {
> +		inode_unlock(parent->d_inode);
> +		return ERR_PTR(-EEXIST);
> +	}
> +	return dget(child);
> +}
> +EXPORT_SYMBOL(start_creating_dentry);
> +
>  /**
>   * start_removing_dentry - prepare to remove a given dentry
>   * @parent: directory from which dentry should be removed
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 9104c7104191..0e6b1b9afc26 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -101,6 +101,8 @@ struct dentry *start_removing_killable(struct mnt_idm=
ap *idmap,
>  				       struct qstr *name);
>  struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
>  struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
> +struct dentry *start_creating_dentry(struct dentry *parent,
> +				     struct dentry *child);
>  struct dentry *start_removing_dentry(struct dentry *parent,
>  				     struct dentry *child);
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

