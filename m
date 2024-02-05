Return-Path: <linux-fsdevel+bounces-10356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A6284A7DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5630E1F2B516
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4588131720;
	Mon,  5 Feb 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rikEi0zg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521D495E4;
	Mon,  5 Feb 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164178; cv=none; b=Z5bZsM21LN96hoavyXanjVpMUYbDZ3E86Rqw8khgzJxnQRNgH5yQS3JipcvHhif4/ssG+KjWSY9OhSVQ8QLzLqbyNOiCieIEWAkWC0em43STGoT9NnNOsYfw/gvoS3DHyRD8PT/4/+ZRJxVILTaY8Mdg7Ck7pkbKsA/HkY9CSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164178; c=relaxed/simple;
	bh=4IYi2udH+CE1XQYDGJNcZD5VFH3EBbNypmyvhctmh6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i1zCx43zMAFinlsTFJk7V3J+VkpKRFiJcOE8voy5nRDLty6h3ppDtLsO7XW6/PUSNm5FGrvPo5dXYqFEG2CPPWGFNPPmeK/YMSL7wU4E7CnVzS3dJlMkMG7un9EMPps8bcfprwV6UhW183b/x4uCICh4N0MM+76LgDxpoL/iH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rikEi0zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79474C433C7;
	Mon,  5 Feb 2024 20:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707164177;
	bh=4IYi2udH+CE1XQYDGJNcZD5VFH3EBbNypmyvhctmh6c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rikEi0zgkbaLEuAXk3+05VoLbzHaEwPEQtj0vE+iFt2tj3i/7u6NrvxiX5al2sXHj
	 Yh4w959EbPdL98SAdTWAP/eR5a05QZjnAMRBlJsbksrSkS98y8Z58Bfosf8T06feVN
	 Lkfbi57wZDSvW5cyGW09iiksePZ+nBmCmTuKzWXvFFbqSHxsYBHRtbH9ciwK82qpkO
	 P0SEAAS+xbJ/lkbqbc3iB6LIkoukAgxdpIh5hmhx5hZjcMFGrrMQTRVYCUOEfRx0EB
	 4igJUVrVF/D+mwf7vmP4Gey26y6CPyzxtH0wYZSiIxx85I9FLsAbfAREbXcd/4qRHb
	 LjGm/HC1iiBxw==
Message-ID: <cd3f8b0d2d0c0a58472b9a83b9c89dbbc6ad4e5c.camel@kernel.org>
Subject: Re: [PATCH] filelock: don't do security checks on nfsd setlease
 calls
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever
	 <chuck.lever@oracle.com>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Ondrej =?UTF-8?Q?Mosn=C3=A1=C4=8Dek?=
	 <omosnacek@gmail.com>, Zdenek Pytela <zpytela@redhat.com>
Date: Mon, 05 Feb 2024 15:16:15 -0500
In-Reply-To: <170716318935.13976.13465352731929804157@noble.neil.brown.name>
References: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>
	 <170716318935.13976.13465352731929804157@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 06:59 +1100, NeilBrown wrote:
> On Mon, 05 Feb 2024, Jeff Layton wrote:
> > Zdenek reported seeing some AVC denials due to nfsd trying to set
> > delegations:
> >=20
> >     type=3DAVC msg=3Daudit(09.11.2023 09:03:46.411:496) : avc:  denied =
 { lease } for  pid=3D5127 comm=3Drpc.nfsd capability=3Dlease  scontext=3Ds=
ystem_u:system_r:nfsd_t:s0 tcontext=3Dsystem_u:system_r:nfsd_t:s0 tclass=3D=
capability permissive=3D0
> >=20
> > When setting delegations on behalf of nfsd, we don't want to do all of
> > the normal capabilty and LSM checks. nfsd is a kernel thread and runs
> > with CAP_LEASE set, so the uid checks end up being a no-op in most case=
s
> > anyway.
> >=20
> > Some nfsd functions can end up running in normal process context when
> > tearing down the server. At that point, the CAP_LEASE check can fail an=
d
> > cause the client to not tear down delegations when expected.
> >=20
> > Also, the way the per-fs ->setlease handlers work today is a little
> > convoluted. The non-trivial ones are wrappers around generic_setlease,
> > so when they fail due to permission problems they usually they end up
> > doing a little extra work only to determine that they can't set the
> > lease anyway. It would be more efficient to do those checks earlier.
> >=20
> > Transplant the permission checking from generic_setlease to
> > vfs_setlease, which will make the permission checking happen earlier on
> > filesystems that have a ->setlease operation. Add a new kernel_setlease
> > function that bypasses these checks, and switch nfsd to use that instea=
d
> > of vfs_setlease.
> >=20
> > There is one behavioral change here: prior this patch the
> > setlease_notifier would fire even if the lease attempt was going to fai=
l
> > the security checks later. With this change, it doesn't fire until the
> > caller has passed them. I think this is a desirable change overall. nfs=
d
> > is the only user of the setlease_notifier and it doesn't benefit from
> > being notified about failed attempts.
> >=20
> > Cc: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > Reported-by: Zdenek Pytela <zpytela@redhat.com>
> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2248830
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> It definitely nice to move all the security and sanity check early.
> This patch allows a minor clean-up in cifs which could possibly be
> included:
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 2a4a4e3a8751..0f142d1ec64f 100644
>=20
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1094,9 +1094,6 @@ cifs_setlease(struct file *file, int arg, struct fi=
le_lock **lease, void **priv)
>  	struct inode *inode =3D file_inode(file);
>  	struct cifsFileInfo *cfile =3D file->private_data;
> =20
> -	if (!(S_ISREG(inode->i_mode)))
> -		return -EINVAL;
> -
>  	/* Check if file is oplocked if this is request for new lease */
>  	if (arg =3D=3D F_UNLCK ||
>  	    ((arg =3D=3D F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||
>=20
>=20
> as ->setlease() is now never called for non-ISREG files.
>=20
> NeilBrown
>=20
>=20

Ahh yeah. Good point. I'm fine with including that if Christian wants to
fold it in.

Thanks for the review!


> > ---
> > This patch is based on top of a merge of Christian's vfs.file branch
> > (which has the file_lock/lease split). There is a small merge confict
> > with Chuck's nfsd-next patch, but it should be fairly simple to resolve=
.
> > ---
> >  fs/locks.c               | 43 +++++++++++++++++++++++++---------------=
---
> >  fs/nfsd/nfs4layouts.c    |  5 ++---
> >  fs/nfsd/nfs4state.c      |  8 ++++----
> >  include/linux/filelock.h |  7 +++++++
> >  4 files changed, 38 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 33c7f4a8c729..26d52ef5314a 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -1925,18 +1925,6 @@ static int generic_delete_lease(struct file *fil=
p, void *owner)
> >  int generic_setlease(struct file *filp, int arg, struct file_lease **f=
lp,
> >  			void **priv)
> >  {
> > -	struct inode *inode =3D file_inode(filp);
> > -	vfsuid_t vfsuid =3D i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
> > -	int error;
> > -
> > -	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE)=
)
> > -		return -EACCES;
> > -	if (!S_ISREG(inode->i_mode))
> > -		return -EINVAL;
> > -	error =3D security_file_lock(filp, arg);
> > -	if (error)
> > -		return error;
> > -
> >  	switch (arg) {
> >  	case F_UNLCK:
> >  		return generic_delete_lease(filp, *priv);
> > @@ -1987,6 +1975,19 @@ void lease_unregister_notifier(struct notifier_b=
lock *nb)
> >  }
> >  EXPORT_SYMBOL_GPL(lease_unregister_notifier);
> > =20
> > +
> > +int
> > +kernel_setlease(struct file *filp, int arg, struct file_lease **lease,=
 void **priv)
> > +{
> > +	if (lease)
> > +		setlease_notifier(arg, *lease);
> > +	if (filp->f_op->setlease)
> > +		return filp->f_op->setlease(filp, arg, lease, priv);
> > +	else
> > +		return generic_setlease(filp, arg, lease, priv);
> > +}
> > +EXPORT_SYMBOL_GPL(kernel_setlease);
> > +
> >  /**
> >   * vfs_setlease        -       sets a lease on an open file
> >   * @filp:	file pointer
> > @@ -2007,12 +2008,18 @@ EXPORT_SYMBOL_GPL(lease_unregister_notifier);
> >  int
> >  vfs_setlease(struct file *filp, int arg, struct file_lease **lease, vo=
id **priv)
> >  {
> > -	if (lease)
> > -		setlease_notifier(arg, *lease);
> > -	if (filp->f_op->setlease)
> > -		return filp->f_op->setlease(filp, arg, lease, priv);
> > -	else
> > -		return generic_setlease(filp, arg, lease, priv);
> > +	struct inode *inode =3D file_inode(filp);
> > +	vfsuid_t vfsuid =3D i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
> > +	int error;
> > +
> > +	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE)=
)
> > +		return -EACCES;
> > +	if (!S_ISREG(inode->i_mode))
> > +		return -EINVAL;
> > +	error =3D security_file_lock(filp, arg);
> > +	if (error)
> > +		return error;
> > +	return kernel_setlease(filp, arg, lease, priv);
> >  }
> >  EXPORT_SYMBOL_GPL(vfs_setlease);
> > =20
> > diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> > index 4fa21b74a981..4c0d00bdfbb1 100644
> > --- a/fs/nfsd/nfs4layouts.c
> > +++ b/fs/nfsd/nfs4layouts.c
> > @@ -170,7 +170,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
> >  	spin_unlock(&fp->fi_lock);
> > =20
> >  	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> > -		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
> > +		kernel_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
> >  	nfsd_file_put(ls->ls_file);
> > =20
> >  	if (ls->ls_recalled)
> > @@ -199,8 +199,7 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *l=
s)
> >  	fl->c.flc_pid =3D current->tgid;
> >  	fl->c.flc_file =3D ls->ls_file->nf_file;
> > =20
> > -	status =3D vfs_setlease(fl->c.flc_file, fl->c.flc_type, &fl,
> > -			      NULL);
> > +	status =3D kernel_setlease(fl->c.flc_file, fl->c.flc_type, &fl, NULL)=
;
> >  	if (status) {
> >  		locks_free_lease(fl);
> >  		return status;
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index b2c8efb5f793..6d52ecba8e9c 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1249,7 +1249,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_d=
elegation *dp)
> > =20
> >  	WARN_ON_ONCE(!fp->fi_delegees);
> > =20
> > -	vfs_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
> > +	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
> >  	put_deleg_file(fp);
> >  }
> > =20
> > @@ -5532,8 +5532,8 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> >  	if (!fl)
> >  		goto out_clnt_odstate;
> > =20
> > -	status =3D vfs_setlease(fp->fi_deleg_file->nf_file,
> > -			      fl->c.flc_type, &fl, NULL);
> > +	status =3D kernel_setlease(fp->fi_deleg_file->nf_file,
> > +				      fl->c.flc_type, &fl, NULL);
> >  	if (fl)
> >  		locks_free_lease(fl);
> >  	if (status)
> > @@ -5571,7 +5571,7 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> > =20
> >  	return dp;
> >  out_unlock:
> > -	vfs_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp)=
;
> > +	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&=
dp);
> >  out_clnt_odstate:
> >  	put_clnt_odstate(dp->dl_clnt_odstate);
> >  	nfs4_put_stid(&dp->dl_stid);
> > diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> > index 4a5ad26962c1..cd6c1c291de9 100644
> > --- a/include/linux/filelock.h
> > +++ b/include/linux/filelock.h
> > @@ -208,6 +208,7 @@ struct file_lease *locks_alloc_lease(void);
> >  int __break_lease(struct inode *inode, unsigned int flags, unsigned in=
t type);
> >  void lease_get_mtime(struct inode *, struct timespec64 *time);
> >  int generic_setlease(struct file *, int, struct file_lease **, void **=
priv);
> > +int kernel_setlease(struct file *, int, struct file_lease **, void **)=
;
> >  int vfs_setlease(struct file *, int, struct file_lease **, void **);
> >  int lease_modify(struct file_lease *, int, struct list_head *);
> > =20
> > @@ -357,6 +358,12 @@ static inline int generic_setlease(struct file *fi=
lp, int arg,
> >  	return -EINVAL;
> >  }
> > =20
> > +static inline int kernel_setlease(struct file *filp, int arg,
> > +			       struct file_lease **lease, void **priv)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> >  static inline int vfs_setlease(struct file *filp, int arg,
> >  			       struct file_lease **lease, void **priv)
> >  {
> >=20
> > ---
> > base-commit: 1499e59af376949b062cdc039257f811f6c1697f
> > change-id: 20240202-bz2248830-03e6c7506705
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

