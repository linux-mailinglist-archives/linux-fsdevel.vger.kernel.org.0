Return-Path: <linux-fsdevel+bounces-41856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B13A38508
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14DA166542
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0332EAE4;
	Mon, 17 Feb 2025 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUESlwcH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4DE35968;
	Mon, 17 Feb 2025 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799970; cv=none; b=c5YZZOOJmeMr/5rQ3suhhvVH6pNJ2AtdDopIhMBrY6NNf5n0SWhmEGYb2DxNm6zFlB40yJ9a9ROnmSg5SaIVsz/Nfe4CvM/EGgZdldGlozrAiLi/KN/w8Of9/UsqY5D+N9snhO3os3zJWmHolVEqqgSAzX5ImMGQrA7qpQIzLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799970; c=relaxed/simple;
	bh=7TxLHOVC3V5bqSKGhlAvU4A9SPRMEy7Rrc14AVYj+q8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPqUCtgUuZX7p6aBDGbTGdc23gypm9c4TYzZsDRepE8vFAU5s8V3Pf8YsnSOjRuimPMOZaVi61tVnrWEHPt0GEJIPT7Bx+rU0YpnRae2y/YZ9jURn9tazfxqrqP0NhwexMTRPbx2ydOL33phzkglNyjhFkqp5s90J61uwzOw//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUESlwcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD41C4CED1;
	Mon, 17 Feb 2025 13:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739799970;
	bh=7TxLHOVC3V5bqSKGhlAvU4A9SPRMEy7Rrc14AVYj+q8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EUESlwcH+AlUnTS0VPqrfhYt/+63Egn0gngYilYFJ29JpgN8LOi6NEu+SwZFOMe8j
	 qUjvmGmvSJAgKRf/xlas04VmkHUPZDxY9Xz34qSij6So8yhQiCc7hsTU9BQ3SSR8Vv
	 lT69Rfs98H1QidcO89h64BW48h0NH8EGluDuyUKiKU9jv8NQUZdYZnZESvKSbJmjB2
	 LUYJHkf7uW4wH9z5tOHgRDNsrnk1Is/yjVHrWKKdCQ3eKWCJxr3OgWXrUT8N7BjPB1
	 SFfIvsxMnIkxEK9+MKm6BKZoCXepvbIHq5YGSj0+GN0hRDDqaHVc7biXDMJEezPk7b
	 9FHCn7JERE1dw==
Message-ID: <60046587aa303d9264b90b66986b2538485270dd.camel@kernel.org>
Subject: Re: [PATCH 2/2] VFS: add common error checks to
 lookup_one_qstr_excl()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Mon, 17 Feb 2025 08:46:08 -0500
In-Reply-To: <20250217003020.3170652-3-neilb@suse.de>
References: <20250217003020.3170652-1-neilb@suse.de>
	 <20250217003020.3170652-3-neilb@suse.de>
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

On Mon, 2025-02-17 at 11:27 +1100, NeilBrown wrote:
> Callers of lookup_one_qstr_excl() often check if the result is negative o=
r
> positive.
> These changes can easily be moved into lookup_one_qstr_excl() by checking=
 the
> lookup flags:
> LOOKUP_CREATE means it is NOT an error if the name doesn't exist.
> LOOKUP_EXCL means it IS an error if the name DOES exist.
>=20
> This patch adds these checks, then removes error checks from callers,
> and ensures that appropriate flags are passed.
>=20
> This subtly changes the meaning of LOOKUP_EXCL.  Previously it could
> only accompany LOOKUP_CREATE.  Now it can accompany LOOKUP_RENAME_TARGET
> as well.  A couple of small changes are needed to accommodate this.  The
> NFS change is functionally a no-op but ensures nfs_is_exclusive_create() =
does
> exactly what the name says.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> Link: https://lore.kernel.org/r/20250207034040.3402438-3-neilb@suse.de
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  Documentation/filesystems/porting.rst | 12 ++++++
>  fs/namei.c                            | 61 +++++++++------------------
>  fs/nfs/dir.c                          |  3 +-
>  fs/smb/server/vfs.c                   | 26 +++++-------
>  4 files changed, 45 insertions(+), 57 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 2ead47e20677..3b6622fbd66b 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1165,3 +1165,15 @@ magic.
>  kern_path_locked() and user_path_locked() no longer return a negative
>  dentry so this doesn't need to be checked.  If the name cannot be found,
>  ERR_PTR(-ENOENT) is returned.
> +
> +** recommend**
> +
> +lookup_one_qstr_excl() is changed to return errors in more cases, so
> +these conditions don't require explicit checks.
> + - if LOOKUP_CREATE is NOT given, then the dentry won't be negative,
> +   ERR_PTR(-ENOENT) is returned instead
> + - if LOOKUP_EXCL IS given, then the dentry won't be positive,
> +   ERR_PTR(-EEXIST) is rreturned instread
> +
> +LOOKUP_EXCL now means "target must not exist".  It can be combined with=
=20
> +LOOK_CREATE or LOOKUP_RENAME_TARGET.
> diff --git a/fs/namei.c b/fs/namei.c
> index fb6da3ca0ca5..b7cdca902803 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1670,6 +1670,8 @@ static struct dentry *lookup_dcache(const struct qs=
tr *name,
>   * dentries - as the matter of fact, this only gets called
>   * when directory is guaranteed to have no in-lookup children
>   * at all.
> + * Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't pass=
ed.
> + * Will return -EEXIST if name is found and LOOKUP_EXCL was passed.
>   */
>  struct dentry *lookup_one_qstr_excl(const struct qstr *name,
>  				    struct dentry *base,
> @@ -1680,7 +1682,7 @@ struct dentry *lookup_one_qstr_excl(const struct qs=
tr *name,
>  	struct inode *dir =3D base->d_inode;
> =20
>  	if (dentry)
> -		return dentry;
> +		goto found;
> =20
>  	/* Don't create child dentry for a dead directory. */
>  	if (unlikely(IS_DEADDIR(dir)))
> @@ -1695,6 +1697,17 @@ struct dentry *lookup_one_qstr_excl(const struct q=
str *name,
>  		dput(dentry);
>  		dentry =3D old;
>  	}
> +found:
> +	if (IS_ERR(dentry))
> +		return dentry;
> +	if (d_is_negative(dentry) && !(flags & LOOKUP_CREATE)) {
> +		dput(dentry);
> +		return ERR_PTR(-ENOENT);
> +	}
> +	if (d_is_positive(dentry) && (flags & LOOKUP_EXCL)) {
> +		dput(dentry);
> +		return ERR_PTR(-EEXIST);
> +	}
>  	return dentry;
>  }
>  EXPORT_SYMBOL(lookup_one_qstr_excl);
> @@ -2741,10 +2754,6 @@ static struct dentry *__kern_path_locked(int dfd, =
struct filename *name, struct
>  	}
>  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
>  	d =3D lookup_one_qstr_excl(&last, path->dentry, 0);
> -	if (!IS_ERR(d) && d_is_negative(d)) {
> -		dput(d);
> -		d =3D ERR_PTR(-ENOENT);
> -	}
>  	if (IS_ERR(d)) {
>  		inode_unlock(path->dentry->d_inode);
>  		path_put(path);
> @@ -4082,27 +4091,13 @@ static struct dentry *filename_create(int dfd, st=
ruct filename *name,
>  	 * '/', and a directory wasn't requested.
>  	 */
>  	if (last.name[last.len] && !want_dir)
> -		create_flags =3D 0;
> +		create_flags &=3D ~LOOKUP_CREATE;
>  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
>  	dentry =3D lookup_one_qstr_excl(&last, path->dentry,
>  				      reval_flag | create_flags);
>  	if (IS_ERR(dentry))
>  		goto unlock;
> =20
> -	error =3D -EEXIST;
> -	if (d_is_positive(dentry))
> -		goto fail;
> -
> -	/*
> -	 * Special case - lookup gave negative, but... we had foo/bar/
> -	 * From the vfs_mknod() POV we just have a negative dentry -
> -	 * all is fine. Let's be bastards - you had / on the end, you've
> -	 * been asking for (non-existent) directory. -ENOENT for you.
> -	 */
> -	if (unlikely(!create_flags)) {
> -		error =3D -ENOENT;
> -		goto fail;
> -	}
>  	if (unlikely(err2)) {
>  		error =3D err2;
>  		goto fail;
> @@ -4449,10 +4444,6 @@ int do_rmdir(int dfd, struct filename *name)
>  	error =3D PTR_ERR(dentry);
>  	if (IS_ERR(dentry))
>  		goto exit3;
> -	if (!dentry->d_inode) {
> -		error =3D -ENOENT;
> -		goto exit4;
> -	}
>  	error =3D security_path_rmdir(&path, dentry);
>  	if (error)
>  		goto exit4;
> @@ -4583,7 +4574,7 @@ int do_unlinkat(int dfd, struct filename *name)
>  	if (!IS_ERR(dentry)) {
> =20
>  		/* Why not before? Because we want correct error value */
> -		if (last.name[last.len] || d_is_negative(dentry))
> +		if (last.name[last.len])
>  			goto slashes;
>  		inode =3D dentry->d_inode;
>  		ihold(inode);
> @@ -4617,9 +4608,7 @@ int do_unlinkat(int dfd, struct filename *name)
>  	return error;
> =20
>  slashes:
> -	if (d_is_negative(dentry))
> -		error =3D -ENOENT;
> -	else if (d_is_dir(dentry))
> +	if (d_is_dir(dentry))
>  		error =3D -EISDIR;
>  	else
>  		error =3D -ENOTDIR;
> @@ -5119,7 +5108,8 @@ int do_renameat2(int olddfd, struct filename *from,=
 int newdfd,
>  	struct qstr old_last, new_last;
>  	int old_type, new_type;
>  	struct inode *delegated_inode =3D NULL;
> -	unsigned int lookup_flags =3D 0, target_flags =3D LOOKUP_RENAME_TARGET;
> +	unsigned int lookup_flags =3D 0, target_flags =3D
> +		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
>  	bool should_retry =3D false;
>  	int error =3D -EINVAL;
> =20
> @@ -5132,6 +5122,8 @@ int do_renameat2(int olddfd, struct filename *from,=
 int newdfd,
> =20
>  	if (flags & RENAME_EXCHANGE)
>  		target_flags =3D 0;
> +	if (flags & RENAME_NOREPLACE)
> +		target_flags |=3D LOOKUP_EXCL;
> =20
>  retry:
>  	error =3D filename_parentat(olddfd, from, lookup_flags, &old_path,
> @@ -5173,23 +5165,12 @@ int do_renameat2(int olddfd, struct filename *fro=
m, int newdfd,
>  	error =3D PTR_ERR(old_dentry);
>  	if (IS_ERR(old_dentry))
>  		goto exit3;
> -	/* source must exist */
> -	error =3D -ENOENT;
> -	if (d_is_negative(old_dentry))
> -		goto exit4;
>  	new_dentry =3D lookup_one_qstr_excl(&new_last, new_path.dentry,
>  					  lookup_flags | target_flags);
>  	error =3D PTR_ERR(new_dentry);
>  	if (IS_ERR(new_dentry))
>  		goto exit4;
> -	error =3D -EEXIST;
> -	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry))
> -		goto exit5;
>  	if (flags & RENAME_EXCHANGE) {
> -		error =3D -ENOENT;
> -		if (d_is_negative(new_dentry))
> -			goto exit5;
> -
>  		if (!d_is_dir(new_dentry)) {
>  			error =3D -ENOTDIR;
>  			if (new_last.name[new_last.len])
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 2b04038b0e40..56cf16a72334 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1532,7 +1532,8 @@ static int nfs_is_exclusive_create(struct inode *di=
r, unsigned int flags)
>  {
>  	if (NFS_PROTO(dir)->version =3D=3D 2)
>  		return 0;
> -	return flags & LOOKUP_EXCL;
> +	return (flags & (LOOKUP_CREATE | LOOKUP_EXCL)) =3D=3D
> +		(LOOKUP_CREATE | LOOKUP_EXCL);
>  }
> =20
>  /*
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 6890016e1923..fe29acef5872 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -113,11 +113,6 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd=
_share_config *share_conf,
>  	if (IS_ERR(d))
>  		goto err_out;
> =20
> -	if (d_is_negative(d)) {
> -		dput(d);
> -		goto err_out;
> -	}
> -
>  	path->dentry =3D d;
>  	path->mnt =3D mntget(parent_path->mnt);
> =20
> @@ -693,6 +688,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const s=
truct path *old_path,
>  	struct ksmbd_file *parent_fp;
>  	int new_type;
>  	int err, lookup_flags =3D LOOKUP_NO_SYMLINKS;
> +	int target_lookup_flags =3D LOOKUP_RENAME_TARGET;
> =20
>  	if (ksmbd_override_fsids(work))
>  		return -ENOMEM;
> @@ -703,6 +699,14 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const =
struct path *old_path,
>  		goto revert_fsids;
>  	}
> =20
> +	/*
> +	 * explicitly handle file overwrite case, for compatibility with
> +	 * filesystems that may not support rename flags (e.g: fuse)
> +	 */
> +	if (flags & RENAME_NOREPLACE)
> +		target_lookup_flags |=3D LOOKUP_EXCL;
> +	flags &=3D ~(RENAME_NOREPLACE);
> +
>  retry:
>  	err =3D vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
>  				     &new_path, &new_last, &new_type,
> @@ -743,7 +747,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const s=
truct path *old_path,
>  	}
> =20
>  	new_dentry =3D lookup_one_qstr_excl(&new_last, new_path.dentry,
> -					  lookup_flags | LOOKUP_RENAME_TARGET);
> +					  lookup_flags | target_lookup_flags);
>  	if (IS_ERR(new_dentry)) {
>  		err =3D PTR_ERR(new_dentry);
>  		goto out3;
> @@ -754,16 +758,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const =
struct path *old_path,
>  		goto out4;
>  	}
> =20
> -	/*
> -	 * explicitly handle file overwrite case, for compatibility with
> -	 * filesystems that may not support rename flags (e.g: fuse)
> -	 */
> -	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
> -		err =3D -EEXIST;
> -		goto out4;
> -	}
> -	flags &=3D ~(RENAME_NOREPLACE);
> -
>  	if (old_child =3D=3D trap) {
>  		err =3D -EINVAL;
>  		goto out4;

Nice simplification.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

