Return-Path: <linux-fsdevel+bounces-68099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3753BC544D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBCB44E77A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0DC27EFEF;
	Wed, 12 Nov 2025 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAUcLiyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87B24C076;
	Wed, 12 Nov 2025 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976329; cv=none; b=OyHHmPlSHM3WpWECLZIw2NKjVP0U8Ef17d2kNn6u0AKdaE3Zk4TIayom43PvyvMnYJMDyoADvEwM+bM0nsIzu5CwmwiTZj/+/Z3lGKuwW1ZEXcuQJw3N0BlUVZx0iWYL3KlCpS//YIP7eM3CvqfYj8nZ21silqM0A3YmT/FksQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976329; c=relaxed/simple;
	bh=5NFeih4wVntwr/+WrfliojXjVDXW1RoyVUNkfnGCeHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QnwAxer4T14BIGWZKGLodQv9WtwmSKWCXvREljKQmYvWppsLpPwJl8j4nDNxqmPfkKOvJF1F8COKEwfqxN+hdxaSY7E6mxQrzSJF/rSWGxSLMN9qDn3HHPzwykm3xXqTNhx9wU2G093UpI2pORdpU402isFON6DgAdkO0O+zDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAUcLiyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BD8C4CEF1;
	Wed, 12 Nov 2025 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762976326;
	bh=5NFeih4wVntwr/+WrfliojXjVDXW1RoyVUNkfnGCeHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fAUcLiySJpH/ZP0iU2ZSxZMQRXbhjL4TdVQzqamwXlaC0RS6y5oSuRZTJy0e3EpYs
	 5yJKIY33smsmUBiq82NBdNnPJOjzVCBJuRFCGFNcn1iGAQ2aAGY951b8Gm3XgZGOM3
	 qxZCmN9f1S/7eeyBhGVv4QR6r5wMEhVen6yQ2JFTVY9n5vRGZHOUBO/LJ3QHA5div1
	 0aI1XwHDL0+0y8m5oC18SDTbl/sZRW3qY4NeRkzJjN1eqeLms/vn8j8xBbY0vEK9a6
	 hhnjVRQMvAph7xF6gv6TBJdhQgixkySbzYt5sOUiO+NnfwIsLyPyJqn3jAsX1i5d5f
	 KDWcdNVfXJNCA==
Message-ID: <574cd3d283754497da280b0ee3248a84cd95dce4.camel@kernel.org>
Subject: Re: [PATCH v5 11/14] Add start_renaming_two_dentries()
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
Date: Wed, 12 Nov 2025 14:38:42 -0500
In-Reply-To: <20251106005333.956321-12-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
	 <20251106005333.956321-12-neilb@ownmail.net>
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
> A few callers want to lock for a rename and already have both dentries.
> Also debugfs does want to perform a lookup but doesn't want permission
> checking, so start_renaming_dentry() cannot be used.
>=20
> This patch introduces start_renaming_two_dentries() which is given both
> dentries.  debugfs performs one lookup itself.  As it will only continue
> with a negative dentry and as those cannot be renamed or unlinked, it is
> safe to do the lookup before getting the rename locks.
>=20
> overlayfs uses start_renaming_two_dentries() in three places and  selinux
> uses it twice in sel_make_policy_nodes().
>=20
> In sel_make_policy_nodes() we now lock for rename twice instead of just
> once so the combined operation is no longer atomic w.r.t the parent
> directory locks.  As selinux_state.policy_mutex is held across the whole
> operation this does open up any interesting races.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
>=20
> ---
> changes since v3:
>  added missing assignment to rd.mnt_idmap in ovl_cleanup_and_whiteout
> ---
>  fs/debugfs/inode.c           | 48 ++++++++++++--------------
>  fs/namei.c                   | 65 ++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/dir.c           | 43 ++++++++++++++++--------
>  include/linux/namei.h        |  2 ++
>  security/selinux/selinuxfs.c | 27 ++++++++++-----
>  5 files changed, 136 insertions(+), 49 deletions(-)
>=20
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index f241b9df642a..532bd7c46baf 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -842,7 +842,8 @@ int __printf(2, 3) debugfs_change_name(struct dentry =
*dentry, const char *fmt, .
>  	int error =3D 0;
>  	const char *new_name;
>  	struct name_snapshot old_name;
> -	struct dentry *parent, *target;
> +	struct dentry *target;
> +	struct renamedata rd =3D {};
>  	struct inode *dir;
>  	va_list ap;
> =20
> @@ -855,36 +856,31 @@ int __printf(2, 3) debugfs_change_name(struct dentr=
y *dentry, const char *fmt, .
>  	if (!new_name)
>  		return -ENOMEM;
> =20
> -	parent =3D dget_parent(dentry);
> -	dir =3D d_inode(parent);
> -	inode_lock(dir);
> +	rd.old_parent =3D dget_parent(dentry);
> +	rd.new_parent =3D rd.old_parent;
> +	rd.flags =3D RENAME_NOREPLACE;
> +	target =3D lookup_noperm_unlocked(&QSTR(new_name), rd.new_parent);
> +	if (IS_ERR(target))
> +		return PTR_ERR(target);
> =20
> -	take_dentry_name_snapshot(&old_name, dentry);
> -
> -	if (WARN_ON_ONCE(dentry->d_parent !=3D parent)) {
> -		error =3D -EINVAL;
> -		goto out;
> -	}
> -	if (strcmp(old_name.name.name, new_name) =3D=3D 0)
> -		goto out;
> -	target =3D lookup_noperm(&QSTR(new_name), parent);
> -	if (IS_ERR(target)) {
> -		error =3D PTR_ERR(target);
> -		goto out;
> -	}
> -	if (d_really_is_positive(target)) {
> -		dput(target);
> -		error =3D -EINVAL;
> +	error =3D start_renaming_two_dentries(&rd, dentry, target);
> +	if (error) {
> +		if (error =3D=3D -EEXIST && target =3D=3D dentry)
> +			/* it isn't an error to rename a thing to itself */
> +			error =3D 0;
>  		goto out;
>  	}
> -	simple_rename_timestamp(dir, dentry, dir, target);
> -	d_move(dentry, target);
> -	dput(target);
> +
> +	dir =3D d_inode(rd.old_parent);
> +	take_dentry_name_snapshot(&old_name, dentry);
> +	simple_rename_timestamp(dir, dentry, dir, rd.new_dentry);
> +	d_move(dentry, rd.new_dentry);
>  	fsnotify_move(dir, dir, &old_name.name, d_is_dir(dentry), NULL, dentry)=
;
> -out:
>  	release_dentry_name_snapshot(&old_name);
> -	inode_unlock(dir);
> -	dput(parent);
> +	end_renaming(&rd);
> +out:
> +	dput(rd.old_parent);
> +	dput(target);
>  	kfree_const(new_name);
>  	return error;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 4b740048df97..7f0384ceb976 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3877,6 +3877,71 @@ int start_renaming_dentry(struct renamedata *rd, i=
nt lookup_flags,
>  }
>  EXPORT_SYMBOL(start_renaming_dentry);
> =20
> +/**
> + * start_renaming_two_dentries - Lock to dentries in given parents for r=
ename
> + * @rd:           rename data containing parent
> + * @old_dentry:   dentry of name to move
> + * @new_dentry:   dentry to move to
> + *
> + * Ensure locks are in place for rename and check parentage is still cor=
rect.
> + *
> + * On success the two dentries are stored in @rd.old_dentry and
> + * @rd.new_dentry and @rd.old_parent and @rd.new_parent are confirmed to
> + * be the parents of the dentries.
> + *
> + * References and the lock can be dropped with end_renaming()
> + *
> + * Returns: zero or an error.
> + */
> +int
> +start_renaming_two_dentries(struct renamedata *rd,
> +			    struct dentry *old_dentry, struct dentry *new_dentry)
> +{
> +	struct dentry *trap;
> +	int err;
> +
> +	/* Already have the dentry - need to be sure to lock the correct parent=
 */
> +	trap =3D lock_rename_child(old_dentry, rd->new_parent);
> +	if (IS_ERR(trap))
> +		return PTR_ERR(trap);
> +	err =3D -EINVAL;
> +	if (d_unhashed(old_dentry) ||
> +	    (rd->old_parent && rd->old_parent !=3D old_dentry->d_parent))
> +		/* old_dentry was removed, or moved and explicit parent requested */
> +		goto out_unlock;
> +	if (d_unhashed(new_dentry) ||
> +	    rd->new_parent !=3D new_dentry->d_parent)
> +		/* new_dentry was removed or moved */
> +		goto out_unlock;
> +
> +	if (old_dentry =3D=3D trap)
> +		/* source is an ancestor of target */
> +		goto out_unlock;
> +
> +	if (new_dentry =3D=3D trap) {
> +		/* target is an ancestor of source */
> +		if (rd->flags & RENAME_EXCHANGE)
> +			err =3D -EINVAL;
> +		else
> +			err =3D -ENOTEMPTY;
> +		goto out_unlock;
> +	}
> +
> +	err =3D -EEXIST;
> +	if (d_is_positive(new_dentry) && (rd->flags & RENAME_NOREPLACE))
> +		goto out_unlock;
> +
> +	rd->old_dentry =3D dget(old_dentry);
> +	rd->new_dentry =3D dget(new_dentry);
> +	rd->old_parent =3D dget(old_dentry->d_parent);
> +	return 0;
> +
> +out_unlock:
> +	unlock_rename(old_dentry->d_parent, rd->new_parent);
> +	return err;
> +}
> +EXPORT_SYMBOL(start_renaming_two_dentries);
> +
>  void end_renaming(struct renamedata *rd)
>  {
>  	unlock_rename(rd->old_parent, rd->new_parent);
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6b2f88edb497..61e9484e4ab8 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -123,6 +123,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, stru=
ct dentry *dir,
>  			     struct dentry *dentry)
>  {
>  	struct dentry *whiteout;
> +	struct renamedata rd =3D {};
>  	int err;
>  	int flags =3D 0;
> =20
> @@ -134,10 +135,14 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
>  	if (d_is_dir(dentry))
>  		flags =3D RENAME_EXCHANGE;
> =20
> -	err =3D ovl_lock_rename_workdir(ofs->workdir, whiteout, dir, dentry);
> +	rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +	rd.old_parent =3D ofs->workdir;
> +	rd.new_parent =3D dir;
> +	rd.flags =3D flags;
> +	err =3D start_renaming_two_dentries(&rd, whiteout, dentry);
>  	if (!err) {
> -		err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, flags)=
;
> -		unlock_rename(ofs->workdir, dir);
> +		err =3D ovl_do_rename_rd(&rd);
> +		end_renaming(&rd);
>  	}
>  	if (err)
>  		goto kill_whiteout;
> @@ -388,6 +393,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>  	struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>  	struct dentry *workdir =3D ovl_workdir(dentry);
>  	struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> +	struct renamedata rd =3D {};
>  	struct path upperpath;
>  	struct dentry *upper;
>  	struct dentry *opaquedir;
> @@ -413,7 +419,11 @@ static struct dentry *ovl_clear_empty(struct dentry =
*dentry,
>  	if (IS_ERR(opaquedir))
>  		goto out;
> =20
> -	err =3D ovl_lock_rename_workdir(workdir, opaquedir, upperdir, upper);
> +	rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +	rd.old_parent =3D workdir;
> +	rd.new_parent =3D upperdir;
> +	rd.flags =3D RENAME_EXCHANGE;
> +	err =3D start_renaming_two_dentries(&rd, opaquedir, upper);
>  	if (err)
>  		goto out_cleanup_unlocked;
> =20
> @@ -431,8 +441,8 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>  	if (err)
>  		goto out_cleanup;
> =20
> -	err =3D ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_=
EXCHANGE);
> -	unlock_rename(workdir, upperdir);
> +	err =3D ovl_do_rename_rd(&rd);
> +	end_renaming(&rd);
>  	if (err)
>  		goto out_cleanup_unlocked;
> =20
> @@ -445,7 +455,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>  	return opaquedir;
> =20
>  out_cleanup:
> -	unlock_rename(workdir, upperdir);
> +	end_renaming(&rd);
>  out_cleanup_unlocked:
>  	ovl_cleanup(ofs, workdir, opaquedir);
>  	dput(opaquedir);
> @@ -468,6 +478,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>  	struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>  	struct dentry *workdir =3D ovl_workdir(dentry);
>  	struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> +	struct renamedata rd =3D {};
>  	struct dentry *upper;
>  	struct dentry *newdentry;
>  	int err;
> @@ -499,7 +510,11 @@ static int ovl_create_over_whiteout(struct dentry *d=
entry, struct inode *inode,
>  	if (IS_ERR(newdentry))
>  		goto out_dput;
> =20
> -	err =3D ovl_lock_rename_workdir(workdir, newdentry, upperdir, upper);
> +	rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +	rd.old_parent =3D workdir;
> +	rd.new_parent =3D upperdir;
> +	rd.flags =3D 0;
> +	err =3D start_renaming_two_dentries(&rd, newdentry, upper);
>  	if (err)
>  		goto out_cleanup_unlocked;
> =20
> @@ -536,16 +551,16 @@ static int ovl_create_over_whiteout(struct dentry *=
dentry, struct inode *inode,
>  		if (err)
>  			goto out_cleanup;
> =20
> -		err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, upper,
> -				    RENAME_EXCHANGE);
> -		unlock_rename(workdir, upperdir);
> +		rd.flags =3D RENAME_EXCHANGE;
> +		err =3D ovl_do_rename_rd(&rd);
> +		end_renaming(&rd);
>  		if (err)
>  			goto out_cleanup_unlocked;
> =20
>  		ovl_cleanup(ofs, workdir, upper);
>  	} else {
> -		err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
> -		unlock_rename(workdir, upperdir);
> +		err =3D ovl_do_rename_rd(&rd);
> +		end_renaming(&rd);
>  		if (err)
>  			goto out_cleanup_unlocked;
>  	}
> @@ -565,7 +580,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>  	return err;
> =20
>  out_cleanup:
> -	unlock_rename(workdir, upperdir);
> +	end_renaming(&rd);
>  out_cleanup_unlocked:
>  	ovl_cleanup(ofs, workdir, newdentry);
>  	dput(newdentry);
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index c47713e9867c..9104c7104191 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -161,6 +161,8 @@ int start_renaming(struct renamedata *rd, int lookup_=
flags,
>  		   struct qstr *old_last, struct qstr *new_last);
>  int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
>  			  struct dentry *old_dentry, struct qstr *new_last);
> +int start_renaming_two_dentries(struct renamedata *rd,
> +				struct dentry *old_dentry, struct dentry *new_dentry);
>  void end_renaming(struct renamedata *rd);
> =20
>  /**
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 232e087bce3e..a224ef9bb831 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -506,6 +506,7 @@ static int sel_make_policy_nodes(struct selinux_fs_in=
fo *fsi,
>  {
>  	int ret =3D 0;
>  	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir;
> +	struct renamedata rd =3D {};
>  	unsigned int bool_num =3D 0;
>  	char **bool_names =3D NULL;
>  	int *bool_values =3D NULL;
> @@ -539,22 +540,30 @@ static int sel_make_policy_nodes(struct selinux_fs_=
info *fsi,
>  	if (ret)
>  		goto out;
> =20
> -	lock_rename(tmp_parent, fsi->sb->s_root);
> +	rd.old_parent =3D tmp_parent;
> +	rd.new_parent =3D fsi->sb->s_root;
> =20
>  	/* booleans */
> -	d_exchange(tmp_bool_dir, fsi->bool_dir);
> +	ret =3D start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->bool_dir);
> +	if (!ret) {
> +		d_exchange(tmp_bool_dir, fsi->bool_dir);
> =20
> -	swap(fsi->bool_num, bool_num);
> -	swap(fsi->bool_pending_names, bool_names);
> -	swap(fsi->bool_pending_values, bool_values);
> +		swap(fsi->bool_num, bool_num);
> +		swap(fsi->bool_pending_names, bool_names);
> +		swap(fsi->bool_pending_values, bool_values);
> =20
> -	fsi->bool_dir =3D tmp_bool_dir;
> +		fsi->bool_dir =3D tmp_bool_dir;
> +		end_renaming(&rd);
> +	}
> =20
>  	/* classes */
> -	d_exchange(tmp_class_dir, fsi->class_dir);
> -	fsi->class_dir =3D tmp_class_dir;
> +	ret =3D start_renaming_two_dentries(&rd, tmp_class_dir, fsi->class_dir)=
;
> +	if (ret =3D=3D 0) {
> +		d_exchange(tmp_class_dir, fsi->class_dir);
> +		fsi->class_dir =3D tmp_class_dir;
> =20
> -	unlock_rename(tmp_parent, fsi->sb->s_root);
> +		end_renaming(&rd);
> +	}
> =20
>  out:
>  	sel_remove_old_bool_data(bool_num, bool_names, bool_values);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

