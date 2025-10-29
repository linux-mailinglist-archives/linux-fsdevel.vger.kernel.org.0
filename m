Return-Path: <linux-fsdevel+bounces-66298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C5C1B70B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D3358458A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2524129AB1D;
	Wed, 29 Oct 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6/nCtv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018653469F5;
	Wed, 29 Oct 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745048; cv=none; b=CQ833mFuyrFkSYYR4TiQwSDj/RY4SQ6kNpUMeMcNz0NzljC+LfSDMhpfk2sE9GZrQifGO5x13pGXClaO3efszV3r9ZE6knx4cYVGkn6MEx00eVN+dSYZLEBhe/m14333Kt0KHygNbel4eTLuS3ezPQoOIAE8WOXqLds6/hcTWPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745048; c=relaxed/simple;
	bh=jm0LFQ3meINuKhZjXiBCxjHpF3qRB5StByMZRa3WjgU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MF5gIRS1IR6O6sOYetoD3vXtHu1HZgCLIL8UzTEOrlQrkCEQUbODpFqJIuXuFcodKZBTYT0CEErgNdcsWuJUrnFT8D0t2ALMtWT2HkbkR5ZAVkNI8f5glRUQeNe2crXMLR6g4mznQ2nrgE3xdRd1w10DJYPVzimMMEKwQ2Q69T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6/nCtv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B6C19424;
	Wed, 29 Oct 2025 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761745047;
	bh=jm0LFQ3meINuKhZjXiBCxjHpF3qRB5StByMZRa3WjgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=h6/nCtv4iu6jgUlSuycqXEYEZOgdikq1/ziOhpuFa0k7zm9Oz6pRR1FdVEd2vGz95
	 jVW+6/rSGqfioZmQQ6vByKeVRi3KNCEZfo2iwCHGgszU6kc/dTGsVXaefxDk4r9p6H
	 nn/QDfOWQyktcyH/OBKNIyssajIZzO94scAvSTf1wo6G1hVOBn0q8Bave7xcqhG77A
	 Ofqnokg7QRRun9ntJIBSHhLskHDs/EEK2J1fI324rlztLOKWcXuTRiPH0PpkUbZ0bb
	 gD8QMwjW85um1MVIx8iLpTJEZC7lYpR0WoNKYCrERzbjJiI5jUQCtk/UvM2PpIvWp/
	 I6GEcEou57J7g==
Message-ID: <77e357c346ac9dce543fea9c22168f4a53dded5d.camel@kernel.org>
Subject: Re: [PATCH v3 03/13] vfs: allow mkdir to wait for delegation break
 on parent
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>, Chuck Lever
 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>,  Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Steve
 French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Ronnie
 Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N	
 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM	
 <bharathsm@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki"	 <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, David Howells	 <dhowells@redhat.com>, Tyler Hicks
 <code@tyhicks.com>, NeilBrown <neil@brown.name>,  Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein
 <amir73il@gmail.com>, Namjae Jeon	 <linkinjeon@kernel.org>, Steve French
 <smfrench@gmail.com>, Sergey Senozhatsky	 <senozhatsky@chromium.org>,
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima	 <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, 	linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 29 Oct 2025 09:37:22 -0400
In-Reply-To: <20251029-zeltlager-auspuff-0e3070d1a9c3@brauner>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
	 <20251021-dir-deleg-ro-v3-3-a08b1cde9f4c@kernel.org>
	 <20251029-zeltlager-auspuff-0e3070d1a9c3@brauner>
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

On Wed, 2025-10-29 at 14:04 +0100, Christian Brauner wrote:
> On Tue, Oct 21, 2025 at 11:25:38AM -0400, Jeff Layton wrote:
> > In order to add directory delegation support, we need to break
> > delegations on the parent whenever there is going to be a change in the
> > directory.
> >=20
> > Add a new delegated_inode parameter to vfs_mkdir. All of the existing
> > callers set that to NULL for now, except for do_mkdirat which will
> > properly block until the lease is gone.
> >=20
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: NeilBrown <neil@brown.name>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  drivers/base/devtmpfs.c  |  2 +-
> >  fs/cachefiles/namei.c    |  2 +-
> >  fs/ecryptfs/inode.c      |  2 +-
> >  fs/init.c                |  2 +-
> >  fs/namei.c               | 24 ++++++++++++++++++------
> >  fs/nfsd/nfs4recover.c    |  2 +-
> >  fs/nfsd/vfs.c            |  2 +-
> >  fs/overlayfs/overlayfs.h |  2 +-
> >  fs/smb/server/vfs.c      |  2 +-
> >  fs/xfs/scrub/orphanage.c |  2 +-
> >  include/linux/fs.h       |  2 +-
> >  11 files changed, 28 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> > index 9d4e46ad8352257a6a65d85526ebdbf9bf2d4b19..0e79621cb0f79870003b867=
ca384199171ded4e0 100644
> > --- a/drivers/base/devtmpfs.c
> > +++ b/drivers/base/devtmpfs.c
> > @@ -180,7 +180,7 @@ static int dev_mkdir(const char *name, umode_t mode=
)
> >  	if (IS_ERR(dentry))
> >  		return PTR_ERR(dentry);
> > =20
> > -	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mo=
de);
> > +	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mo=
de, NULL);
> >  	if (!IS_ERR(dentry))
> >  		/* mark as kernel-created inode */
> >  		d_inode(dentry)->i_private =3D &thread;
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index d1edb2ac38376c4f9d2a18026450bb3c774f7824..50c0f9c76d1fd4c05db90d7=
d0d1bad574523ead0 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -130,7 +130,7 @@ struct dentry *cachefiles_get_directory(struct cach=
efiles_cache *cache,
> >  			goto mkdir_error;
> >  		ret =3D cachefiles_inject_write_error();
> >  		if (ret =3D=3D 0)
> > -			subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> > +			subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700, NU=
LL);
> >  		else
> >  			subdir =3D ERR_PTR(ret);
> >  		if (IS_ERR(subdir)) {
> > diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> > index ed1394da8d6bd7065f2a074378331f13fcda17f9..35830b3144f8f71374a78b3=
e7463b864f4fc216e 100644
> > --- a/fs/ecryptfs/inode.c
> > +++ b/fs/ecryptfs/inode.c
> > @@ -508,7 +508,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idm=
ap *idmap, struct inode *dir,
> >  		goto out;
> > =20
> >  	lower_dentry =3D vfs_mkdir(&nop_mnt_idmap, lower_dir,
> > -				 lower_dentry, mode);
> > +				 lower_dentry, mode, NULL);
> >  	rc =3D PTR_ERR(lower_dentry);
> >  	if (IS_ERR(lower_dentry))
> >  		goto out;
> > diff --git a/fs/init.c b/fs/init.c
> > index 07f592ccdba868509d0f3aaf9936d8d890fdbec5..895f8a09a71acfd03e11164=
e3b441a7d4e2de146 100644
> > --- a/fs/init.c
> > +++ b/fs/init.c
> > @@ -233,7 +233,7 @@ int __init init_mkdir(const char *pathname, umode_t=
 mode)
> >  	error =3D security_path_mkdir(&path, dentry, mode);
> >  	if (!error) {
> >  		dentry =3D vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> > -				  dentry, mode);
> > +				  dentry, mode, NULL);
> >  		if (IS_ERR(dentry))
> >  			error =3D PTR_ERR(dentry);
> >  	}
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 6e61e0215b34134b1690f864e2719e3f82cf71a8..86cf6eca1f485361c673297=
4e4103cf5ea721539 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4407,10 +4407,11 @@ SYSCALL_DEFINE3(mknod, const char __user *, fil=
ename, umode_t, mode, unsigned, d
> > =20
> >  /**
> >   * vfs_mkdir - create directory returning correct dentry if possible
> > - * @idmap:	idmap of the mount the inode was found from
> > - * @dir:	inode of the parent directory
> > - * @dentry:	dentry of the child directory
> > - * @mode:	mode of the child directory
> > + * @idmap:		idmap of the mount the inode was found from
> > + * @dir:		inode of the parent directory
> > + * @dentry:		dentry of the child directory
> > + * @mode:		mode of the child directory
> > + * @delegated_inode:	returns parent inode, if the inode is delegated.
>=20
> I wonder if it would be feasible and potentially elegant if delegated
> inodes were returned as separate type like struct delegated_inode
> similar to the vfsuid_t just a struct wrapper around the inode itself.
> The advantage is that it's not possible to accidently abuse this thing
> as we're passing that stuff around to try_break_deleg() and so on.
>=20

I have a patch that does exactly that:

https://lore.kernel.org/linux-nfs/20250924-dir-deleg-v3-15-9f3af8bc5c40@ker=
nel.org/

I didn't submit it here since it wasn't strictly required for this
patchset. If we get around to implementing CB_NOTIFY support however,
it will be since we'll need to pass back other information than just
the inode.

I could move that into this series if you prefer. If we do that though,
then it might also be cleaner to take the previous patch in the series
that cleans up __break_lease() arguments:

https://lore.kernel.org/linux-nfs/20250924-dir-deleg-v3-14-9f3af8bc5c40@ker=
nel.org/

Let me know what you'd prefer.

> >   *
> >   * Create a directory.
> >   *
> > @@ -4427,7 +4428,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filen=
ame, umode_t, mode, unsigned, d
> >   * In case of an error the dentry is dput() and an ERR_PTR() is return=
ed.
> >   */
> >  struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> > -			 struct dentry *dentry, umode_t mode)
> > +			 struct dentry *dentry, umode_t mode,
> > +			 struct inode **delegated_inode)
> >  {
> >  	int error;
> >  	unsigned max_links =3D dir->i_sb->s_max_links;
> > @@ -4450,6 +4452,10 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap=
, struct inode *dir,
> >  	if (max_links && dir->i_nlink >=3D max_links)
> >  		goto err;
> > =20
> > +	error =3D try_break_deleg(dir, delegated_inode);
> > +	if (error)
> > +		goto err;
> > +
> >  	de =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> >  	error =3D PTR_ERR(de);
> >  	if (IS_ERR(de))
> > @@ -4473,6 +4479,7 @@ int do_mkdirat(int dfd, struct filename *name, um=
ode_t mode)
> >  	struct path path;
> >  	int error;
> >  	unsigned int lookup_flags =3D LOOKUP_DIRECTORY;
> > +	struct inode *delegated_inode =3D NULL;
> > =20
> >  retry:
> >  	dentry =3D filename_create(dfd, name, &path, lookup_flags);
> > @@ -4484,11 +4491,16 @@ int do_mkdirat(int dfd, struct filename *name, =
umode_t mode)
> >  			mode_strip_umask(path.dentry->d_inode, mode));
> >  	if (!error) {
> >  		dentry =3D vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> > -				  dentry, mode);
> > +				   dentry, mode, &delegated_inode);
> >  		if (IS_ERR(dentry))
> >  			error =3D PTR_ERR(dentry);
> >  	}
> >  	end_creating_path(&path, dentry);
> > +	if (delegated_inode) {
> > +		error =3D break_deleg_wait(&delegated_inode);
> > +		if (!error)
> > +			goto retry;
> > +	}
> >  	if (retry_estale(error, lookup_flags)) {
> >  		lookup_flags |=3D LOOKUP_REVAL;
> >  		goto retry;
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index b1005abcb9035b2cf743200808a251b00af7e3f4..423dd102b51198ea7c447be=
2b9a0a5020c950dba 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -202,7 +202,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
> >  		 * as well be forgiving and just succeed silently.
> >  		 */
> >  		goto out_put;
> > -	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
> > +	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, 0700, NULL=
);
> >  	if (IS_ERR(dentry))
> >  		status =3D PTR_ERR(dentry);
> >  out_put:
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 8b2dc7a88aab015d1e39da0dd4e6daf7e276aabe..5f24af289d509bea54a324b=
8851fa06de6050353 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1645,7 +1645,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> >  			nfsd_check_ignore_resizing(iap);
> >  		break;
> >  	case S_IFDIR:
> > -		dchild =3D vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
> > +		dchild =3D vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode, NUL=
L);
> >  		if (IS_ERR(dchild)) {
> >  			host_err =3D PTR_ERR(dchild);
> >  		} else if (d_is_negative(dchild)) {
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index c8fd5951fc5ece1ae6b3e2a0801ca15f9faf7d72..0f65f9a5d54d4786b39e4f4=
f30f416d5b9016e70 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -248,7 +248,7 @@ static inline struct dentry *ovl_do_mkdir(struct ov=
l_fs *ofs,
> >  {
> >  	struct dentry *ret;
> > =20
> > -	ret =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> > +	ret =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, NULL);
> >  	pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZERO(r=
et));
> >  	return ret;
> >  }
> > diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> > index 891ed2dc2b7351a5cb14a2241d71095ffdd03f08..3d2190f26623b23ea79c634=
10905a3c3ad684048 100644
> > --- a/fs/smb/server/vfs.c
> > +++ b/fs/smb/server/vfs.c
> > @@ -230,7 +230,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const =
char *name, umode_t mode)
> >  	idmap =3D mnt_idmap(path.mnt);
> >  	mode |=3D S_IFDIR;
> >  	d =3D dentry;
> > -	dentry =3D vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> > +	dentry =3D vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode, NULL)=
;
> >  	if (IS_ERR(dentry))
> >  		err =3D PTR_ERR(dentry);
> >  	else if (d_is_negative(dentry))
> > diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> > index 9c12cb8442311ca26b169e4d1567939ae44a5be0..91c9d07b97f306f57aebb9b=
69ba564b0c2cb8c17 100644
> > --- a/fs/xfs/scrub/orphanage.c
> > +++ b/fs/xfs/scrub/orphanage.c
> > @@ -167,7 +167,7 @@ xrep_orphanage_create(
> >  	 */
> >  	if (d_really_is_negative(orphanage_dentry)) {
> >  		orphanage_dentry =3D vfs_mkdir(&nop_mnt_idmap, root_inode,
> > -					     orphanage_dentry, 0750);
> > +					     orphanage_dentry, 0750, NULL);
> >  		error =3D PTR_ERR(orphanage_dentry);
> >  		if (IS_ERR(orphanage_dentry))
> >  			goto out_unlock_root;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index c895146c1444be36e0a779df55622cc38c9419ff..1040df3792794cd353b8655=
8b41618294e25b8a6 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2113,7 +2113,7 @@ bool inode_owner_or_capable(struct mnt_idmap *idm=
ap,
> >  int vfs_create(struct mnt_idmap *, struct inode *,
> >  	       struct dentry *, umode_t, bool);
> >  struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
> > -			 struct dentry *, umode_t);
> > +			 struct dentry *, umode_t, struct inode **);
> >  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
> >                umode_t, dev_t);
> >  int vfs_symlink(struct mnt_idmap *, struct inode *,
> >=20
> > --=20
> > 2.51.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

