Return-Path: <linux-fsdevel+bounces-44535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60183A6A375
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F24246DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ABC223324;
	Thu, 20 Mar 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+VP6CH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770962147ED;
	Thu, 20 Mar 2025 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465960; cv=none; b=uLDvp/vkNM4gRWTR4uQWHn+jgzqSVBhK6efVehXaL1cm/ujA7kNC83P+yc8efNCHqvojFsoibVwSkF4B9gn5RfimZ2fPxnSs/suuGjBXYtskJ4n6KW4dR/3ETFnN9QLL4Lc1RfZuw/nAzvwMLHa9LRIeKMcLssunxZkyJ/5E4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465960; c=relaxed/simple;
	bh=ZPEde+uHmF4UzZQdP7U4Byp2kzSIZW9KgXxgewPeY1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgxMgeiU3G+/Pf2Npl8YcbpqjW8VgPLewtR0hkI3CY4/I2SccVD5XPZexMaEYF0ruCXbwfB78DB0flwKPyh7h4Gd3YO3xAo/r9ZilTzpv3SzvT7GNPjl6cmia5C7vb4my8pkBZ2iNGnPAfh/tPy4gBjav3FpCsBFjhXW0BJhLuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+VP6CH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851B0C4CEE8;
	Thu, 20 Mar 2025 10:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742465960;
	bh=ZPEde+uHmF4UzZQdP7U4Byp2kzSIZW9KgXxgewPeY1E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=h+VP6CH+2SDWMS/F7aFhuK5Q1da7CrBtQzC+NhHojzxfay28iL0B6Gcnto4tSiKGe
	 dX8pXML5kiljyXeqVgQTfGpJDiqTwqaYQqncD2KVEL8icHMBpiqHSDeRkT1jLfc52h
	 ObKlsbo9uqMSi+FhJHfEmWg23t7ZnIaQXVDpU/4mcdDQIEdO4tFIHCLdooEmrTT/Gl
	 oOrQUOhUD+bqK6AJVhf46DtVY+bx1FoFjqsuGlghOe5Ac0Qfw41lriAYc53XiWzIE/
	 CSOzboFnuAMKNDUrRs2FFywSVMggcs1YK0jmKPrZsNgVQTp/J7otngZAyjSi+biHP6
	 SusE/nOsTPz0A==
Message-ID: <d96f0fd97103452fb46f1804a34048e5d33036c9.camel@kernel.org>
Subject: Re: [PATCH 2/6] nfsd: Use lookup_one() rather than lookup_one_len()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David
 Howells <dhowells@redhat.com>,  Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Date: Thu, 20 Mar 2025 06:19:18 -0400
In-Reply-To: <20250319031545.2999807-3-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name>
	 <20250319031545.2999807-3-neil@brown.name>
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

On Wed, 2025-03-19 at 14:01 +1100, NeilBrown wrote:
> nfsd uses some VFS interfaces (such as vfs_mkdir) which take an explicit
> mnt_idmap, and it passes &nop_mnt_idmap as nfsd doesn't yet support
> idmapped mounts.
>=20
> It also uses the lookup_one_len() family of functions which implicitly
> use &nop_mnt_idmap.  This mixture of implicit and explicit could be
> confusing.  When we eventually update nfsd to support idmap mounts it
> would be best if all places which need an idmap determined from the
> mount point were similar and easily found.
>=20
> So this patch changes nfsd to use lookup_one(), lookup_one_unlocked(),
> and lookup_one_positive_unlocked(), passing &nop_mnt_idmap.
>=20
> This has the benefit of removing some uses of the lookup_one_len
> functions where permission checking is actually needed.  Many callers
> don't care about permission checking and using these function only where
> permission checking is needed is a valuable simplification.
>=20
> This change requires passing the name in a qstr.  Currently this is a
> little clumsy, but if nfsd is changed to use qstr more broadly it will
> result in a net improvement.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs3proc.c    |  4 +++-
>  fs/nfsd/nfs3xdr.c     |  4 +++-
>  fs/nfsd/nfs4proc.c    |  4 +++-
>  fs/nfsd/nfs4recover.c | 13 +++++++------
>  fs/nfsd/nfs4xdr.c     |  4 +++-
>  fs/nfsd/nfsproc.c     |  6 ++++--
>  fs/nfsd/vfs.c         | 17 +++++++++--------
>  7 files changed, 32 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 372bdcf5e07a..9fa8ad08b1cd 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -284,7 +284,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> =20
>  	inode_lock_nested(inode, I_MUTEX_PARENT);
> =20
> -	child =3D lookup_one_len(argp->name, parent, argp->len);
> +	child =3D lookup_one(&nop_mnt_idmap,
> +			   QSTR_LEN(argp->name, argp->len),
> +			   parent);
>  	if (IS_ERR(child)) {
>  		status =3D nfserrno(PTR_ERR(child));
>  		goto out;
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index a7a07470c1f8..5a626e24a334 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -1001,7 +1001,9 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struc=
t svc_fh *fhp,
>  		} else
>  			dchild =3D dget(dparent);
>  	} else
> -		dchild =3D lookup_positive_unlocked(name, dparent, namlen);
> +		dchild =3D lookup_one_positive_unlocked(&nop_mnt_idmap,
> +						      QSTR_LEN(name, namlen),
> +						      dparent);
>  	if (IS_ERR(dchild))
>  		return rv;
>  	if (d_mountpoint(dchild))
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f6e06c779d09..5860f3825be2 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -266,7 +266,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> =20
>  	inode_lock_nested(inode, I_MUTEX_PARENT);
> =20
> -	child =3D lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> +	child =3D lookup_one(&nop_mnt_idmap, QSTR_LEN(open->op_fname,
> +						    open->op_fnamelen),
> +			   parent);
>  	if (IS_ERR(child)) {
>  		status =3D nfserrno(PTR_ERR(child));
>  		goto out;
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index c1d9bd07285f..5c1cb5c3c13e 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -218,7 +218,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  	/* lock the parent */
>  	inode_lock(d_inode(dir));
> =20
> -	dentry =3D lookup_one_len(dname, dir, HEXDIR_LEN-1);
> +	dentry =3D lookup_one(&nop_mnt_idmap, QSTR(dname), dir);
>  	if (IS_ERR(dentry)) {
>  		status =3D PTR_ERR(dentry);
>  		goto out_unlock;
> @@ -316,7 +316,8 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *n=
n)
>  	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
>  		if (!status) {
>  			struct dentry *dentry;
> -			dentry =3D lookup_one_len(entry->name, dir, HEXDIR_LEN-1);
> +			dentry =3D lookup_one(&nop_mnt_idmap,
> +					    QSTR(entry->name), dir);
>  			if (IS_ERR(dentry)) {
>  				status =3D PTR_ERR(dentry);
>  				break;
> @@ -339,16 +340,16 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net =
*nn)
>  }
> =20
>  static int
> -nfsd4_unlink_clid_dir(char *name, int namlen, struct nfsd_net *nn)
> +nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
>  {
>  	struct dentry *dir, *dentry;
>  	int status;
> =20
> -	dprintk("NFSD: nfsd4_unlink_clid_dir. name %.*s\n", namlen, name);
> +	dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
> =20
>  	dir =3D nn->rec_file->f_path.dentry;
>  	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> -	dentry =3D lookup_one_len(name, dir, namlen);
> +	dentry =3D lookup_one(&nop_mnt_idmap, QSTR(name), dir);
>  	if (IS_ERR(dentry)) {
>  		status =3D PTR_ERR(dentry);
>  		goto out_unlock;
> @@ -408,7 +409,7 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
>  	if (status < 0)
>  		goto out_drop_write;
> =20
> -	status =3D nfsd4_unlink_clid_dir(dname, HEXDIR_LEN-1, nn);
> +	status =3D nfsd4_unlink_clid_dir(dname, nn);
>  	nfs4_reset_creds(original_cred);
>  	if (status =3D=3D 0) {
>  		vfs_fsync(nn->rec_file, 0);
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index e67420729ecd..16be860b1f79 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3812,7 +3812,9 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd,=
 const char *name,
>  	__be32 nfserr;
>  	int ignore_crossmnt =3D 0;
> =20
> -	dentry =3D lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen=
);
> +	dentry =3D lookup_one_positive_unlocked(&nop_mnt_idmap,
> +					      QSTR_LEN(name, namlen),
> +					      cd->rd_fhp->fh_dentry);
>  	if (IS_ERR(dentry))
>  		return nfserrno(PTR_ERR(dentry));
> =20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 6dda081eb24c..ac7d7f858846 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -312,7 +312,9 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  	}
> =20
>  	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
> -	dchild =3D lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
> +	dchild =3D lookup_one(&nop_mnt_idmap, QSTR_LEN(argp->name,
> +						     argp->len),
> +			    dirfhp->fh_dentry);
>  	if (IS_ERR(dchild)) {
>  		resp->status =3D nfserrno(PTR_ERR(dchild));
>  		goto out_unlock;
> @@ -331,7 +333,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		 */
>  		resp->status =3D nfserr_acces;
>  		if (!newfhp->fh_dentry) {
> -			printk(KERN_WARNING=20
> +			printk(KERN_WARNING
>  				"nfsd_proc_create: file handle not verified\n");
>  			goto out_unlock;
>  		}
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 34d7aa531662..c0c94619af92 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -265,7 +265,8 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>  				goto out_nfserr;
>  		}
>  	} else {
> -		dentry =3D lookup_one_len_unlocked(name, dparent, len);
> +		dentry =3D lookup_one_unlocked(&nop_mnt_idmap,
> +					     QSTR_LEN(name, len), dparent);
>  		host_err =3D PTR_ERR(dentry);
>  		if (IS_ERR(dentry))
>  			goto out_nfserr;
> @@ -923,7 +924,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp,=
 umode_t type,
>  	 * directories, but we never have and it doesn't seem to have
>  	 * caused anyone a problem.  If we were to change this, note
>  	 * also that our filldir callbacks would need a variant of
> -	 * lookup_one_len that doesn't check permissions.
> +	 * lookup_one_positive_unlocked() that doesn't check permissions.
>  	 */
>  	if (type =3D=3D S_IFREG)
>  		may_flags |=3D NFSD_MAY_OWNER_OVERRIDE;
> @@ -1555,7 +1556,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>  		return nfserrno(host_err);
> =20
>  	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> -	dchild =3D lookup_one_len(fname, dentry, flen);
> +	dchild =3D lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), dentry);
>  	host_err =3D PTR_ERR(dchild);
>  	if (IS_ERR(dchild)) {
>  		err =3D nfserrno(host_err);
> @@ -1660,7 +1661,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
> =20
>  	dentry =3D fhp->fh_dentry;
>  	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> -	dnew =3D lookup_one_len(fname, dentry, flen);
> +	dnew =3D lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), dentry);
>  	if (IS_ERR(dnew)) {
>  		err =3D nfserrno(PTR_ERR(dnew));
>  		inode_unlock(dentry->d_inode);
> @@ -1726,7 +1727,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ff=
hp,
>  	dirp =3D d_inode(ddir);
>  	inode_lock_nested(dirp, I_MUTEX_PARENT);
> =20
> -	dnew =3D lookup_one_len(name, ddir, len);
> +	dnew =3D lookup_one(&nop_mnt_idmap, QSTR_LEN(name, len), ddir);
>  	if (IS_ERR(dnew)) {
>  		err =3D nfserrno(PTR_ERR(dnew));
>  		goto out_unlock;
> @@ -1839,7 +1840,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>  	if (err !=3D nfs_ok)
>  		goto out_unlock;
> =20
> -	odentry =3D lookup_one_len(fname, fdentry, flen);
> +	odentry =3D lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), fdentry);
>  	host_err =3D PTR_ERR(odentry);
>  	if (IS_ERR(odentry))
>  		goto out_nfserr;
> @@ -1851,7 +1852,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
>  	if (odentry =3D=3D trap)
>  		goto out_dput_old;
> =20
> -	ndentry =3D lookup_one_len(tname, tdentry, tlen);
> +	ndentry =3D lookup_one(&nop_mnt_idmap, QSTR_LEN(tname, tlen), tdentry);
>  	host_err =3D PTR_ERR(ndentry);
>  	if (IS_ERR(ndentry))
>  		goto out_dput_old;
> @@ -1948,7 +1949,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  	dirp =3D d_inode(dentry);
>  	inode_lock_nested(dirp, I_MUTEX_PARENT);
> =20
> -	rdentry =3D lookup_one_len(fname, dentry, flen);
> +	rdentry =3D lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), dentry);
>  	host_err =3D PTR_ERR(rdentry);
>  	if (IS_ERR(rdentry))
>  		goto out_unlock;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

