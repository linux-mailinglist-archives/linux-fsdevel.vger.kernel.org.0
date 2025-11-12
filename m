Return-Path: <linux-fsdevel+bounces-68071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD5CC52FFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 16:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5946230D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9743451CF;
	Wed, 12 Nov 2025 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKdMzWeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC417261E;
	Wed, 12 Nov 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960016; cv=none; b=ZHKto4gzhhC5XT4+XKt89YYUpfBtQlB1xU1F9/ELJ1HieDz5koRkSmBLvOz2YwwfI4zo/KqYnVZJnZOz/qraCtHOJfvh0nklfbxWqQyvXArI21fHcRPm609FTjqSea/A00nK9RvTBlhao1GRa9HM0TesgIsK9vKNZnAbsDKFlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960016; c=relaxed/simple;
	bh=Jp8GAc98lQD1XWw/NpkDMiKoitJJan/TkqVWtdcWHWE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zbo1zEZLUj7I2YJuJO9DPxdODXBNP3mQ7nkXcETwbZvvItKlrAmklgx0P4iKJEvVHdzAl8qHoMXyjJtCxKkNkk9+pHdQwAe7oz859Fc8+5o8xAa1JWLpO3CTwlRSV6UxWqZTOM9E8Pam4w306q19ebnbfwoUjc8pD3Br3ayo7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKdMzWeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A27C4CEF8;
	Wed, 12 Nov 2025 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762960015;
	bh=Jp8GAc98lQD1XWw/NpkDMiKoitJJan/TkqVWtdcWHWE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VKdMzWeo4USPFVKqo6E7eQMiu+MPNaNQOP+ALic4BD4idQzgKTeW3GI4JMzmdiVLQ
	 0Y3xjEoVjTAzgrc4xwIlEFUxLV0JL64tmrkSikoI3/ki9gl/9QArKA9n2/y4g4V72Z
	 BJPbGvxmLelwNbIGsMuW9xvl5xTZMRoM6gjw8WEZfPEu//t4xzpURXKkT1fIGVcmHV
	 XRbtBMsVesjxTuWh+sofrFvINo/xbHxpm62K9sHeQoGBvhOGPIfuCyYQqlKtMtNFU7
	 jznOCLZANhIwIDTHV1hIrX5T/tBeEYPYCGS4mtV2NmLFNjYg2DVo/+kQ6YeeCtpKnV
	 DGVVvv4Qu/ncg==
Message-ID: <9887b21b264aaf2b55f7284020b0760e69b3d0ed.camel@kernel.org>
Subject: Re: [PATCH v5 09/14] VFS/nfsd/ovl: introduce start_renaming() and
 end_renaming()
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
Date: Wed, 12 Nov 2025 10:06:51 -0500
In-Reply-To: <20251106005333.956321-10-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
	 <20251106005333.956321-10-neilb@ownmail.net>
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
> start_renaming() combines name lookup and locking to prepare for rename.
> It is used when two names need to be looked up as in nfsd and overlayfs -
> cases where one or both dentries are already available will be handled
> separately.
>=20
> __start_renaming() avoids the inode_permission check and hash
> calculation and is suitable after filename_parentat() in do_renameat2().
> It subsumes quite a bit of code from that function.
>=20
> start_renaming() does calculate the hash and check X permission and is
> suitable elsewhere:
> - nfsd_rename()
> - ovl_rename()
>=20
> In ovl, ovl_do_rename_rd() is factored out of ovl_do_rename(), which
> itself will be gone by the end of the series.
>=20
> Acked-by: Chuck Lever <chuck.lever@oracle.com> (for nfsd parts)
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
>=20
> --
> Changes since v3:
>  - added missig dput() in ovl_rename when "whiteout" is not-NULL.
>=20
> Changes since v2:
>  - in __start_renaming() some label have been renamed, and err
>    is always set before a "goto out_foo" rather than passing the
>    error in a dentry*.
>  - ovl_do_rename() changed to call the new ovl_do_rename_rd() rather
>    than keeping duplicate code
>  - code around ovl_cleanup() call in ovl_rename() restructured.
> ---
>  fs/namei.c               | 197 ++++++++++++++++++++++++++++-----------
>  fs/nfsd/vfs.c            |  73 +++++----------
>  fs/overlayfs/dir.c       |  74 +++++++--------
>  fs/overlayfs/overlayfs.h |  23 +++--
>  include/linux/namei.h    |   3 +
>  5 files changed, 218 insertions(+), 152 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index e70d056b9543..bad6c9d540f9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3667,6 +3667,129 @@ void unlock_rename(struct dentry *p1, struct dent=
ry *p2)
>  }
>  EXPORT_SYMBOL(unlock_rename);
> =20
> +/**
> + * __start_renaming - lookup and lock names for rename
> + * @rd:           rename data containing parent and flags, and
> + *                for receiving found dentries
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + * @old_last:     name of object in @rd.old_parent
> + * @new_last:     name of object in @rd.new_parent
> + *
> + * Look up two names and ensure locks are in place for
> + * rename.
> + *
> + * On success the found dentries are stored in @rd.old_dentry,
> + * @rd.new_dentry.  These references and the lock are dropped by
> + * end_renaming().
> + *
> + * The passed in qstrs must have the hash calculated, and no permission
> + * checking is performed.
> + *
> + * Returns: zero or an error.
> + */
> +static int
> +__start_renaming(struct renamedata *rd, int lookup_flags,
> +		 struct qstr *old_last, struct qstr *new_last)
> +{
> +	struct dentry *trap;
> +	struct dentry *d1, *d2;
> +	int target_flags =3D LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +	int err;
> +
> +	if (rd->flags & RENAME_EXCHANGE)
> +		target_flags =3D 0;
> +	if (rd->flags & RENAME_NOREPLACE)
> +		target_flags |=3D LOOKUP_EXCL;
> +
> +	trap =3D lock_rename(rd->old_parent, rd->new_parent);
> +	if (IS_ERR(trap))
> +		return PTR_ERR(trap);
> +
> +	d1 =3D lookup_one_qstr_excl(old_last, rd->old_parent,
> +				  lookup_flags);
> +	err =3D PTR_ERR(d1);
> +	if (IS_ERR(d1))
> +		goto out_unlock;
> +
> +	d2 =3D lookup_one_qstr_excl(new_last, rd->new_parent,
> +				  lookup_flags | target_flags);
> +	err =3D PTR_ERR(d2);
> +	if (IS_ERR(d2))
> +		goto out_dput_d1;
> +
> +	if (d1 =3D=3D trap) {
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
> +	rd->old_dentry =3D d1;
> +	rd->new_dentry =3D d2;
> +	return 0;
> +
> +out_dput_d2:
> +	dput(d2);
> +out_dput_d1:
> +	dput(d1);
> +out_unlock:
> +	unlock_rename(rd->old_parent, rd->new_parent);
> +	return err;
> +}
> +
> +/**
> + * start_renaming - lookup and lock names for rename with permission che=
cking
> + * @rd:           rename data containing parent and flags, and
> + *                for receiving found dentries
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + * @old_last:     name of object in @rd.old_parent
> + * @new_last:     name of object in @rd.new_parent
> + *
> + * Look up two names and ensure locks are in place for
> + * rename.
> + *
> + * On success the found dentries are stored in @rd.old_dentry,
> + * @rd.new_dentry.  These references and the lock are dropped by
> + * end_renaming().
> + *
> + * The passed in qstrs need not have the hash calculated, and basic
> + * eXecute permission checking is performed against @rd.mnt_idmap.
> + *
> + * Returns: zero or an error.
> + */
> +int start_renaming(struct renamedata *rd, int lookup_flags,
> +		   struct qstr *old_last, struct qstr *new_last)
> +{
> +	int err;
> +
> +	err =3D lookup_one_common(rd->mnt_idmap, old_last, rd->old_parent);
> +	if (err)
> +		return err;
> +	err =3D lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent);
> +	if (err)
> +		return err;
> +	return __start_renaming(rd, lookup_flags, old_last, new_last);
> +}
> +EXPORT_SYMBOL(start_renaming);
> +
> +void end_renaming(struct renamedata *rd)
> +{
> +	unlock_rename(rd->old_parent, rd->new_parent);
> +	dput(rd->old_dentry);
> +	dput(rd->new_dentry);
> +}
> +EXPORT_SYMBOL(end_renaming);
> +
>  /**
>   * vfs_prepare_mode - prepare the mode to be used for a new inode
>   * @idmap:	idmap of the mount the inode was found from
> @@ -5504,14 +5627,11 @@ int do_renameat2(int olddfd, struct filename *fro=
m, int newdfd,
>  		 struct filename *to, unsigned int flags)
>  {
>  	struct renamedata rd;
> -	struct dentry *old_dentry, *new_dentry;
> -	struct dentry *trap;
>  	struct path old_path, new_path;
>  	struct qstr old_last, new_last;
>  	int old_type, new_type;
>  	struct inode *delegated_inode =3D NULL;
> -	unsigned int lookup_flags =3D 0, target_flags =3D
> -		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +	unsigned int lookup_flags =3D 0;
>  	bool should_retry =3D false;
>  	int error =3D -EINVAL;
> =20
> @@ -5522,11 +5642,6 @@ int do_renameat2(int olddfd, struct filename *from=
, int newdfd,
>  	    (flags & RENAME_EXCHANGE))
>  		goto put_names;
> =20
> -	if (flags & RENAME_EXCHANGE)
> -		target_flags =3D 0;
> -	if (flags & RENAME_NOREPLACE)
> -		target_flags |=3D LOOKUP_EXCL;
> -
>  retry:
>  	error =3D filename_parentat(olddfd, from, lookup_flags, &old_path,
>  				  &old_last, &old_type);
> @@ -5556,66 +5671,40 @@ int do_renameat2(int olddfd, struct filename *fro=
m, int newdfd,
>  		goto exit2;
> =20
>  retry_deleg:
> -	trap =3D lock_rename(new_path.dentry, old_path.dentry);
> -	if (IS_ERR(trap)) {
> -		error =3D PTR_ERR(trap);
> +	rd.old_parent	   =3D old_path.dentry;
> +	rd.mnt_idmap	   =3D mnt_idmap(old_path.mnt);
> +	rd.new_parent	   =3D new_path.dentry;
> +	rd.delegated_inode =3D &delegated_inode;
> +	rd.flags	   =3D flags;
> +
> +	error =3D __start_renaming(&rd, lookup_flags, &old_last, &new_last);
> +	if (error)
>  		goto exit_lock_rename;
> -	}
> =20
> -	old_dentry =3D lookup_one_qstr_excl(&old_last, old_path.dentry,
> -					  lookup_flags);
> -	error =3D PTR_ERR(old_dentry);
> -	if (IS_ERR(old_dentry))
> -		goto exit3;
> -	new_dentry =3D lookup_one_qstr_excl(&new_last, new_path.dentry,
> -					  lookup_flags | target_flags);
> -	error =3D PTR_ERR(new_dentry);
> -	if (IS_ERR(new_dentry))
> -		goto exit4;
>  	if (flags & RENAME_EXCHANGE) {
> -		if (!d_is_dir(new_dentry)) {
> +		if (!d_is_dir(rd.new_dentry)) {
>  			error =3D -ENOTDIR;
>  			if (new_last.name[new_last.len])
> -				goto exit5;
> +				goto exit_unlock;
>  		}
>  	}
>  	/* unless the source is a directory trailing slashes give -ENOTDIR */
> -	if (!d_is_dir(old_dentry)) {
> +	if (!d_is_dir(rd.old_dentry)) {
>  		error =3D -ENOTDIR;
>  		if (old_last.name[old_last.len])
> -			goto exit5;
> +			goto exit_unlock;
>  		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
> -			goto exit5;
> -	}
> -	/* source should not be ancestor of target */
> -	error =3D -EINVAL;
> -	if (old_dentry =3D=3D trap)
> -		goto exit5;
> -	/* target should not be an ancestor of source */
> -	if (!(flags & RENAME_EXCHANGE))
> -		error =3D -ENOTEMPTY;
> -	if (new_dentry =3D=3D trap)
> -		goto exit5;
> +			goto exit_unlock;
> +	}
> =20
> -	error =3D security_path_rename(&old_path, old_dentry,
> -				     &new_path, new_dentry, flags);
> +	error =3D security_path_rename(&old_path, rd.old_dentry,
> +				     &new_path, rd.new_dentry, flags);
>  	if (error)
> -		goto exit5;
> +		goto exit_unlock;
> =20
> -	rd.old_parent	   =3D old_path.dentry;
> -	rd.old_dentry	   =3D old_dentry;
> -	rd.mnt_idmap	   =3D mnt_idmap(old_path.mnt);
> -	rd.new_parent	   =3D new_path.dentry;
> -	rd.new_dentry	   =3D new_dentry;
> -	rd.delegated_inode =3D &delegated_inode;
> -	rd.flags	   =3D flags;
>  	error =3D vfs_rename(&rd);
> -exit5:
> -	dput(new_dentry);
> -exit4:
> -	dput(old_dentry);
> -exit3:
> -	unlock_rename(new_path.dentry, old_path.dentry);
> +exit_unlock:
> +	end_renaming(&rd);
>  exit_lock_rename:
>  	if (delegated_inode) {
>  		error =3D break_deleg_wait(&delegated_inode);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 6291c371caa7..a993f1e54182 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1885,11 +1885,12 @@ __be32
>  nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, in=
t flen,
>  			    struct svc_fh *tfhp, char *tname, int tlen)
>  {
> -	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
> +	struct dentry	*fdentry, *tdentry;
>  	int		type =3D S_IFDIR;
> +	struct renamedata rd =3D {};
>  	__be32		err;
>  	int		host_err;
> -	bool		close_cached =3D false;
> +	struct dentry	*close_cached;
> =20
>  	trace_nfsd_vfs_rename(rqstp, ffhp, tfhp, fname, flen, tname, tlen);
> =20
> @@ -1915,15 +1916,22 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
>  		goto out;
> =20
>  retry:
> +	close_cached =3D NULL;
>  	host_err =3D fh_want_write(ffhp);
>  	if (host_err) {
>  		err =3D nfserrno(host_err);
>  		goto out;
>  	}
> =20
> -	trap =3D lock_rename(tdentry, fdentry);
> -	if (IS_ERR(trap)) {
> -		err =3D nfserr_xdev;
> +	rd.mnt_idmap	=3D &nop_mnt_idmap;
> +	rd.old_parent	=3D fdentry;
> +	rd.new_parent	=3D tdentry;
> +
> +	host_err =3D start_renaming(&rd, 0, &QSTR_LEN(fname, flen),
> +				  &QSTR_LEN(tname, tlen));
> +
> +	if (host_err) {
> +		err =3D nfserrno(host_err);
>  		goto out_want_write;
>  	}
>  	err =3D fh_fill_pre_attrs(ffhp);
> @@ -1933,48 +1941,23 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
>  	if (err !=3D nfs_ok)
>  		goto out_unlock;
> =20
> -	odentry =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), fdentry)=
;
> -	host_err =3D PTR_ERR(odentry);
> -	if (IS_ERR(odentry))
> -		goto out_nfserr;
> +	type =3D d_inode(rd.old_dentry)->i_mode & S_IFMT;
> +
> +	if (d_inode(rd.new_dentry))
> +		type =3D d_inode(rd.new_dentry)->i_mode & S_IFMT;
> =20
> -	host_err =3D -ENOENT;
> -	if (d_really_is_negative(odentry))
> -		goto out_dput_old;
> -	host_err =3D -EINVAL;
> -	if (odentry =3D=3D trap)
> -		goto out_dput_old;
> -	type =3D d_inode(odentry)->i_mode & S_IFMT;
> -
> -	ndentry =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(tname, tlen), tdentry)=
;
> -	host_err =3D PTR_ERR(ndentry);
> -	if (IS_ERR(ndentry))
> -		goto out_dput_old;
> -	if (d_inode(ndentry))
> -		type =3D d_inode(ndentry)->i_mode & S_IFMT;
> -	host_err =3D -ENOTEMPTY;
> -	if (ndentry =3D=3D trap)
> -		goto out_dput_new;
> -
> -	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)=
 &&
> -	    nfsd_has_cached_files(ndentry)) {
> -		close_cached =3D true;
> -		goto out_dput_old;
> +	if ((rd.new_dentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_U=
NLINK) &&
> +	    nfsd_has_cached_files(rd.new_dentry)) {
> +		close_cached =3D dget(rd.new_dentry);
> +		goto out_unlock;
>  	} else {
> -		struct renamedata rd =3D {
> -			.mnt_idmap	=3D &nop_mnt_idmap,
> -			.old_parent	=3D fdentry,
> -			.old_dentry	=3D odentry,
> -			.new_parent	=3D tdentry,
> -			.new_dentry	=3D ndentry,
> -		};
>  		int retries;
> =20
>  		for (retries =3D 1;;) {
>  			host_err =3D vfs_rename(&rd);
>  			if (host_err !=3D -EAGAIN || !retries--)
>  				break;
> -			if (!nfsd_wait_for_delegreturn(rqstp, d_inode(odentry)))
> +			if (!nfsd_wait_for_delegreturn(rqstp, d_inode(rd.old_dentry)))
>  				break;
>  		}
>  		if (!host_err) {
> @@ -1983,11 +1966,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh =
*ffhp, char *fname, int flen,
>  				host_err =3D commit_metadata(ffhp);
>  		}
>  	}
> - out_dput_new:
> -	dput(ndentry);
> - out_dput_old:
> -	dput(odentry);
> - out_nfserr:
>  	if (host_err =3D=3D -EBUSY) {
>  		/*
>  		 * See RFC 8881 Section 18.26.4 para 1-3: NFSv4 RENAME
> @@ -2006,7 +1984,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>  		fh_fill_post_attrs(tfhp);
>  	}
>  out_unlock:
> -	unlock_rename(tdentry, fdentry);
> +	end_renaming(&rd);
>  out_want_write:
>  	fh_drop_write(ffhp);
> =20
> @@ -2017,9 +1995,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>  	 * until this point and then reattempt the whole shebang.
>  	 */
>  	if (close_cached) {
> -		close_cached =3D false;
> -		nfsd_close_cached_files(ndentry);
> -		dput(ndentry);
> +		nfsd_close_cached_files(close_cached);
> +		dput(close_cached);
>  		goto retry;
>  	}
>  out:
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6d1d0e94e287..cf6fc48459f3 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1124,9 +1124,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>  	int err;
>  	struct dentry *old_upperdir;
>  	struct dentry *new_upperdir;
> -	struct dentry *olddentry =3D NULL;
> -	struct dentry *newdentry =3D NULL;
> -	struct dentry *trap, *de;
> +	struct renamedata rd =3D {};
>  	bool old_opaque;
>  	bool new_opaque;
>  	bool cleanup_whiteout =3D false;
> @@ -1136,6 +1134,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>  	bool new_is_dir =3D d_is_dir(new);
>  	bool samedir =3D olddir =3D=3D newdir;
>  	struct dentry *opaquedir =3D NULL;
> +	struct dentry *whiteout =3D NULL;
>  	const struct cred *old_cred =3D NULL;
>  	struct ovl_fs *ofs =3D OVL_FS(old->d_sb);
>  	LIST_HEAD(list);
> @@ -1233,29 +1232,21 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>  		}
>  	}
> =20
> -	trap =3D lock_rename(new_upperdir, old_upperdir);
> -	if (IS_ERR(trap)) {
> -		err =3D PTR_ERR(trap);
> -		goto out_revert_creds;
> -	}
> +	rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> +	rd.old_parent =3D old_upperdir;
> +	rd.new_parent =3D new_upperdir;
> +	rd.flags =3D flags;
> =20
> -	de =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
> -			      old->d_name.len);
> -	err =3D PTR_ERR(de);
> -	if (IS_ERR(de))
> -		goto out_unlock;
> -	olddentry =3D de;
> +	err =3D start_renaming(&rd, 0,
> +			     &QSTR_LEN(old->d_name.name, old->d_name.len),
> +			     &QSTR_LEN(new->d_name.name, new->d_name.len));
> =20
> -	err =3D -ESTALE;
> -	if (!ovl_matches_upper(old, olddentry))
> -		goto out_unlock;
> +	if (err)
> +		goto out_revert_creds;
> =20
> -	de =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
> -			      new->d_name.len);
> -	err =3D PTR_ERR(de);
> -	if (IS_ERR(de))
> +	err =3D -ESTALE;
> +	if (!ovl_matches_upper(old, rd.old_dentry))
>  		goto out_unlock;
> -	newdentry =3D de;
> =20
>  	old_opaque =3D ovl_dentry_is_opaque(old);
>  	new_opaque =3D ovl_dentry_is_opaque(new);
> @@ -1263,15 +1254,15 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>  	err =3D -ESTALE;
>  	if (d_inode(new) && ovl_dentry_upper(new)) {
>  		if (opaquedir) {
> -			if (newdentry !=3D opaquedir)
> +			if (rd.new_dentry !=3D opaquedir)
>  				goto out_unlock;
>  		} else {
> -			if (!ovl_matches_upper(new, newdentry))
> +			if (!ovl_matches_upper(new, rd.new_dentry))
>  				goto out_unlock;
>  		}
>  	} else {
> -		if (!d_is_negative(newdentry)) {
> -			if (!new_opaque || !ovl_upper_is_whiteout(ofs, newdentry))
> +		if (!d_is_negative(rd.new_dentry)) {
> +			if (!new_opaque || !ovl_upper_is_whiteout(ofs, rd.new_dentry))
>  				goto out_unlock;
>  		} else {
>  			if (flags & RENAME_EXCHANGE)
> @@ -1279,19 +1270,14 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>  		}
>  	}
> =20
> -	if (olddentry =3D=3D trap)
> -		goto out_unlock;
> -	if (newdentry =3D=3D trap)
> -		goto out_unlock;
> -
> -	if (olddentry->d_inode =3D=3D newdentry->d_inode)
> +	if (rd.old_dentry->d_inode =3D=3D rd.new_dentry->d_inode)
>  		goto out_unlock;
> =20
>  	err =3D 0;
>  	if (ovl_type_merge_or_lower(old))
>  		err =3D ovl_set_redirect(old, samedir);
>  	else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
> -		err =3D ovl_set_opaque_xerr(old, olddentry, -EXDEV);
> +		err =3D ovl_set_opaque_xerr(old, rd.old_dentry, -EXDEV);
>  	if (err)
>  		goto out_unlock;
> =20
> @@ -1299,18 +1285,24 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>  		err =3D ovl_set_redirect(new, samedir);
>  	else if (!overwrite && new_is_dir && !new_opaque &&
>  		 ovl_type_merge(old->d_parent))
> -		err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
> +		err =3D ovl_set_opaque_xerr(new, rd.new_dentry, -EXDEV);
>  	if (err)
>  		goto out_unlock;
> =20
> -	err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
> -			    new_upperdir, newdentry, flags);
> -	unlock_rename(new_upperdir, old_upperdir);
> +	err =3D ovl_do_rename_rd(&rd);
> +
> +	if (!err && cleanup_whiteout)
> +		whiteout =3D dget(rd.new_dentry);
> +
> +	end_renaming(&rd);
> +
>  	if (err)
>  		goto out_revert_creds;
> =20
> -	if (cleanup_whiteout)
> -		ovl_cleanup(ofs, old_upperdir, newdentry);
> +	if (whiteout) {
> +		ovl_cleanup(ofs, old_upperdir, whiteout);
> +		dput(whiteout);
> +	}
> =20
>  	if (overwrite && d_inode(new)) {
>  		if (new_is_dir)
> @@ -1336,14 +1328,12 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>  	else
>  		ovl_drop_write(old);
>  out:
> -	dput(newdentry);
> -	dput(olddentry);
>  	dput(opaquedir);
>  	ovl_cache_free(&list);
>  	return err;
> =20
>  out_unlock:
> -	unlock_rename(new_upperdir, old_upperdir);
> +	end_renaming(&rd);
>  	goto out_revert_creds;
>  }
> =20
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 49ad65f829dc..3cc85a893b5c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -355,11 +355,24 @@ static inline int ovl_do_remove_acl(struct ovl_fs *=
ofs, struct dentry *dentry,
>  	return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name);
>  }
> =20
> +static inline int ovl_do_rename_rd(struct renamedata *rd)
> +{
> +	int err;
> +
> +	pr_debug("rename(%pd2, %pd2, 0x%x)\n", rd->old_dentry, rd->new_dentry,
> +		 rd->flags);
> +	err =3D vfs_rename(rd);
> +	if (err) {
> +		pr_debug("...rename(%pd2, %pd2, ...) =3D %i\n",
> +			 rd->old_dentry, rd->new_dentry, err);
> +	}
> +	return err;
> +}
> +
>  static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddi=
r,
>  				struct dentry *olddentry, struct dentry *newdir,
>  				struct dentry *newdentry, unsigned int flags)
>  {
> -	int err;
>  	struct renamedata rd =3D {
>  		.mnt_idmap	=3D ovl_upper_mnt_idmap(ofs),
>  		.old_parent	=3D olddir,
> @@ -369,13 +382,7 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, =
struct dentry *olddir,
>  		.flags		=3D flags,
>  	};
> =20
> -	pr_debug("rename(%pd2, %pd2, 0x%x)\n", olddentry, newdentry, flags);
> -	err =3D vfs_rename(&rd);
> -	if (err) {
> -		pr_debug("...rename(%pd2, %pd2, ...) =3D %i\n",
> -			 olddentry, newdentry, err);
> -	}
> -	return err;
> +	return ovl_do_rename_rd(&rd);
>  }
> =20
>  static inline int ovl_do_whiteout(struct ovl_fs *ofs,
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 196c66156a8a..7fdd9fdcbd2b 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -157,6 +157,9 @@ extern int follow_up(struct path *);
>  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
>  extern struct dentry *lock_rename_child(struct dentry *, struct dentry *=
);
>  extern void unlock_rename(struct dentry *, struct dentry *);
> +int start_renaming(struct renamedata *rd, int lookup_flags,
> +		   struct qstr *old_last, struct qstr *new_last);
> +void end_renaming(struct renamedata *rd);
> =20
>  /**
>   * mode_strip_umask - handle vfs umask stripping


Reviewed-by: Jeff Layton <jlayton@kernel.org>

