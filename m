Return-Path: <linux-fsdevel+bounces-55596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4424BB0C4E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 15:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5301D4E79E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DB52DA74C;
	Mon, 21 Jul 2025 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGU8si6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786E2D9EFE;
	Mon, 21 Jul 2025 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103173; cv=none; b=um3oi2Q0VFQyzRh6jCGvAUYjhO/xRZA2EeDdvbgTTO6afy1d2Gtg4wt6l/87FYPPDGz2+oPebiVhAgYNiXEXVXxaN4AynKxJ4gnDJEKJebSsI0QxllLjlCnkZAoQ+dF/D+wCi2YImOXLjw1leJbAaOLjw5pIRxS/pYfNom138S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103173; c=relaxed/simple;
	bh=xyw89wIDKFU4tFQDfgeIs0pqjAgTgF7cZy6rg36LWJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LlXIgojTiVEd6XCifJO03yMlOKmxNHqzqwPeBWZPDRWHfRClJZw6tKtBoIIdTKHrehwpNILkyxHZV4SjiQ0XThtrSTLpHueoNqPrVZ6VeYX7576YrdyPTcOU3FTG/W0YDIyUezFyCvIv52IGwtOaYICQodtx6PHo91FANdb9OC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGU8si6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5A1C4CEED;
	Mon, 21 Jul 2025 13:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753103172;
	bh=xyw89wIDKFU4tFQDfgeIs0pqjAgTgF7cZy6rg36LWJ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EGU8si6AC5gKmeXirsUvt/MIIlUxlYJFZmA5WgcKG05okpCr7zGeFfHHWkyBki/WR
	 cLkMC6nyTUZzOJ/nRg2WOETf14fey3KLA/24Vya0YGC/fwak+PP5vTM03j6BA5UF+R
	 dYHUMNybQCH6MN9IoXtlRC0ktbzgp9cPM/QzNPRkMvcRSU2d3kFIQl510sR7riZC77
	 0srDzziGlsq9IbNMx0AR6ZoZ6iGN13d0qzV6QjeQzgzV8J3gjmX8OO5AGGSk9dmbOY
	 cBJurCu3+6G2/yLn872EUCO6PJ8olghH0A9AfnXkwHGbFgymN9uPJUargYvn86AX2D
	 uqurkY/3R1tCQ==
Message-ID: <c3cd7afa8a319d7e45266d30741acb582b0085b0.camel@kernel.org>
Subject: Re: [PATCH 1/7] VFS: unify old_mnt_idmap and new_mnt_idmap in
 renamedata
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Linus Torvalds
 <torvalds@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 09:06:10 -0400
In-Reply-To: <20250721084412.370258-2-neil@brown.name>
References: <20250721084412.370258-1-neil@brown.name>
	 <20250721084412.370258-2-neil@brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 17:59 +1000, NeilBrown wrote:
> A rename can only rename with a single mount.  Callers of vfs_rename()
> must and do ensure this is the case.
>=20
> So there is no point in having two mnt_idmaps in renamedata as they are
> always the same.  Only of of them is passed to ->rename in any case.
>=20
> This patch replaces both with a single "mnt_idmap" and changes all
> callers.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/namei.c    |  3 +--
>  fs/ecryptfs/inode.c      |  3 +--
>  fs/namei.c               | 17 ++++++++---------
>  fs/nfsd/vfs.c            |  3 +--
>  fs/overlayfs/overlayfs.h |  3 +--
>  fs/smb/server/vfs.c      |  3 +--
>  include/linux/fs.h       |  6 ++----
>  7 files changed, 15 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 91dfd0231877..d1edb2ac3837 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -387,10 +387,9 @@ int cachefiles_bury_object(struct cachefiles_cache *=
cache,
>  		cachefiles_io_error(cache, "Rename security error %d", ret);
>  	} else {
>  		struct renamedata rd =3D {
> -			.old_mnt_idmap	=3D &nop_mnt_idmap,
> +			.mnt_idmap	=3D &nop_mnt_idmap,
>  			.old_parent	=3D dir,
>  			.old_dentry	=3D rep,
> -			.new_mnt_idmap	=3D &nop_mnt_idmap,
>  			.new_parent	=3D cache->graveyard,
>  			.new_dentry	=3D grave,
>  		};
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 72fbe1316ab8..abd954c6a14e 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -634,10 +634,9 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inod=
e *old_dir,
>  		goto out_lock;
>  	}
> =20
> -	rd.old_mnt_idmap	=3D &nop_mnt_idmap;
> +	rd.mnt_idmap		=3D &nop_mnt_idmap;
>  	rd.old_parent		=3D lower_old_dir_dentry;
>  	rd.old_dentry		=3D lower_old_dentry;
> -	rd.new_mnt_idmap	=3D &nop_mnt_idmap;
>  	rd.new_parent		=3D lower_new_dir_dentry;
>  	rd.new_dentry		=3D lower_new_dentry;
>  	rc =3D vfs_rename(&rd);
> diff --git a/fs/namei.c b/fs/namei.c
> index cd43ff89fbaa..1c80445693d4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5024,20 +5024,20 @@ int vfs_rename(struct renamedata *rd)
>  	if (source =3D=3D target)
>  		return 0;
> =20
> -	error =3D may_delete(rd->old_mnt_idmap, old_dir, old_dentry, is_dir);
> +	error =3D may_delete(rd->mnt_idmap, old_dir, old_dentry, is_dir);
>  	if (error)
>  		return error;
> =20
>  	if (!target) {
> -		error =3D may_create(rd->new_mnt_idmap, new_dir, new_dentry);
> +		error =3D may_create(rd->mnt_idmap, new_dir, new_dentry);
>  	} else {
>  		new_is_dir =3D d_is_dir(new_dentry);
> =20
>  		if (!(flags & RENAME_EXCHANGE))
> -			error =3D may_delete(rd->new_mnt_idmap, new_dir,
> +			error =3D may_delete(rd->mnt_idmap, new_dir,
>  					   new_dentry, is_dir);
>  		else
> -			error =3D may_delete(rd->new_mnt_idmap, new_dir,
> +			error =3D may_delete(rd->mnt_idmap, new_dir,
>  					   new_dentry, new_is_dir);
>  	}
>  	if (error)
> @@ -5052,13 +5052,13 @@ int vfs_rename(struct renamedata *rd)
>  	 */
>  	if (new_dir !=3D old_dir) {
>  		if (is_dir) {
> -			error =3D inode_permission(rd->old_mnt_idmap, source,
> +			error =3D inode_permission(rd->mnt_idmap, source,
>  						 MAY_WRITE);
>  			if (error)
>  				return error;
>  		}
>  		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
> -			error =3D inode_permission(rd->new_mnt_idmap, target,
> +			error =3D inode_permission(rd->mnt_idmap, target,
>  						 MAY_WRITE);
>  			if (error)
>  				return error;
> @@ -5126,7 +5126,7 @@ int vfs_rename(struct renamedata *rd)
>  		if (error)
>  			goto out;
>  	}
> -	error =3D old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
> +	error =3D old_dir->i_op->rename(rd->mnt_idmap, old_dir, old_dentry,
>  				      new_dir, new_dentry, flags);
>  	if (error)
>  		goto out;
> @@ -5269,10 +5269,9 @@ int do_renameat2(int olddfd, struct filename *from=
, int newdfd,
> =20
>  	rd.old_parent	   =3D old_path.dentry;
>  	rd.old_dentry	   =3D old_dentry;
> -	rd.old_mnt_idmap   =3D mnt_idmap(old_path.mnt);
> +	rd.mnt_idmap	   =3D mnt_idmap(old_path.mnt);
>  	rd.new_parent	   =3D new_path.dentry;
>  	rd.new_dentry	   =3D new_dentry;
> -	rd.new_mnt_idmap   =3D mnt_idmap(new_path.mnt);
>  	rd.delegated_inode =3D &delegated_inode;
>  	rd.flags	   =3D flags;
>  	error =3D vfs_rename(&rd);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 7d522e426b2d..a21940cadede 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1940,10 +1940,9 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh =
*ffhp, char *fname, int flen,
>  		goto out_dput_old;
>  	} else {
>  		struct renamedata rd =3D {
> -			.old_mnt_idmap	=3D &nop_mnt_idmap,
> +			.mnt_idmap	=3D &nop_mnt_idmap,
>  			.old_parent	=3D fdentry,
>  			.old_dentry	=3D odentry,
> -			.new_mnt_idmap	=3D &nop_mnt_idmap,
>  			.new_parent	=3D tdentry,
>  			.new_dentry	=3D ndentry,
>  		};
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index bb0d7ded8e76..4f84abaa0d68 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -361,10 +361,9 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, =
struct dentry *olddir,
>  {
>  	int err;
>  	struct renamedata rd =3D {
> -		.old_mnt_idmap	=3D ovl_upper_mnt_idmap(ofs),
> +		.mnt_idmap	=3D ovl_upper_mnt_idmap(ofs),
>  		.old_parent	=3D olddir,
>  		.old_dentry	=3D olddentry,
> -		.new_mnt_idmap	=3D ovl_upper_mnt_idmap(ofs),
>  		.new_parent	=3D newdir,
>  		.new_dentry	=3D newdentry,
>  		.flags		=3D flags,
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 49e731dd0529..bfd62a21e75c 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -770,10 +770,9 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const =
struct path *old_path,
>  		goto out4;
>  	}
> =20
> -	rd.old_mnt_idmap	=3D mnt_idmap(old_path->mnt),
> +	rd.mnt_idmap		=3D mnt_idmap(old_path->mnt),
>  	rd.old_parent		=3D old_parent,
>  	rd.old_dentry		=3D old_child,
> -	rd.new_mnt_idmap	=3D mnt_idmap(new_path.mnt),
>  	rd.new_parent		=3D new_path.dentry,
>  	rd.new_dentry		=3D new_dentry,
>  	rd.flags		=3D flags,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1948b2c828d3..d3e27da8a6aa 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2005,20 +2005,18 @@ int vfs_unlink(struct mnt_idmap *, struct inode *=
, struct dentry *,
> =20
>  /**
>   * struct renamedata - contains all information required for renaming
> - * @old_mnt_idmap:     idmap of the old mount the inode was found from
> + * @mnt_idmap:     idmap of the mount in which the rename is happening.
>   * @old_parent:        parent of source
>   * @old_dentry:                source
> - * @new_mnt_idmap:     idmap of the new mount the inode was found from
>   * @new_parent:        parent of destination
>   * @new_dentry:                destination
>   * @delegated_inode:   returns an inode needing a delegation break
>   * @flags:             rename flags
>   */
>  struct renamedata {
> -	struct mnt_idmap *old_mnt_idmap;
> +	struct mnt_idmap *mnt_idmap;
>  	struct dentry *old_parent;
>  	struct dentry *old_dentry;
> -	struct mnt_idmap *new_mnt_idmap;
>  	struct dentry *new_parent;
>  	struct dentry *new_dentry;
>  	struct inode **delegated_inode;

Nice cleanup.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

