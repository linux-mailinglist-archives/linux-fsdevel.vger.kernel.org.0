Return-Path: <linux-fsdevel+bounces-64623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D7BBEE63F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 15:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41D684E4D21
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABE2EAB93;
	Sun, 19 Oct 2025 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1LPUkMC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A6F1A316E;
	Sun, 19 Oct 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760881578; cv=none; b=DZzkdfrSU4MrZbyMEsEPjlNjfA8IpLY4L+GNep4iFlmzLFbn0VMExeM2QJm+8aeNdAnR4RGsKs32HrCOoNwDizyeaJDmeQXVMwJwVxmUmCcYcBypTUTuNxBxZuOANvNiuyctYdXAFV0RBx9pDKZ+4F3Odermd6hOquFRa+ukpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760881578; c=relaxed/simple;
	bh=1Et5jbsBzCEty6NV8s7X7v7I4YLExXGlWahDWTeVnrI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ylm8yCwj4KmvonAOnFodcusUGmV6MLJfRBBRYOs2RuIAVxWYD90u/KNlADSDo2Edm1mmGFGDRwNLKSXqhEAD8mxESZGBBfsMiC0zY5+WRPq1zsdJ5RJyKQglOt26Ut7ZZDKnR8MkK8QkH1Bcub5XFIejMdvAtoNQSlLyO/Zb1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1LPUkMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2639C4CEE7;
	Sun, 19 Oct 2025 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760881578;
	bh=1Et5jbsBzCEty6NV8s7X7v7I4YLExXGlWahDWTeVnrI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=F1LPUkMCPwdpU+zEilvp7jT0d9GkTbTN7f20RphLs54w6edQzXlT8SZjXmhaDTnrj
	 kVZYrEOSEuJcZj2VlPtKawwuF3hJ+C5yBTD8L5W4LxSDT5HbqrUUHXXpUw8EkECQqK
	 AJqUYkb9YMCCaW+vjdFhGeD9fatebT0Cupj+YMzODEuqICJbctGzxAnmZuzl1fJgk9
	 QyBG+muJasV781ouVn3iIFxkxyjANIY1umzpKEKAezdHHkfLeVFX+iEJ9PXCXZwXpV
	 j2wCmmAWxca1WX2IodF8ZFkt+NW+MdcgYKmLuSO5DqRumI4T0WG4/Agw7podzVkHLa
	 mAi20pj4cBeFg==
Message-ID: <9ed1a3c4953032a2c4e1793d5c1a117282008937.camel@kernel.org>
Subject: Re: [PATCH v2 11/11] nfsd: wire up GET_DIR_DELEGATION handling
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Miklos Szeredi
 <miklos@szeredi.hu>,  Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,  Alexander Aring
 <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>,  Steve French <sfrench@samba.org>, Paulo
 Alcantara <pc@manguebit.org>, Ronnie Sahlberg	 <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey	 <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich	 <dakr@kernel.org>, David Howells <dhowells@redhat.com>,
 Tyler Hicks	 <code@tyhicks.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia	 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Amir
 Goldstein	 <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Steve
 French	 <smfrench@gmail.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, "David S. Miller"	 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, 	linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org
Date: Sun, 19 Oct 2025 09:46:13 -0400
In-Reply-To: <cc8a624b-6747-4566-b812-e27caf7861a9@oracle.com>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
	 <20251017-dir-deleg-ro-v2-11-8c8f6dd23c8b@kernel.org>
	 <cc8a624b-6747-4566-b812-e27caf7861a9@oracle.com>
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

On Sat, 2025-10-18 at 15:46 -0400, Chuck Lever wrote:
> On 10/17/25 7:32 AM, Jeff Layton wrote:
> > Add a new routine for acquiring a read delegation on a directory. These
> > are recallable-only delegations with no support for CB_NOTIFY. That wil=
l
> > be added in a later phase.
> >=20
> > Since the same CB_RECALL/DELEGRETURN infrastrure is used for regular an=
d
> > directory delegations, a normal nfs4_delegation is used to represent a
> > directory delegation.
>=20
> s/infrastrure/infrastructure/
>=20
>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c  |  21 ++++++++++-
> >  fs/nfsd/nfs4state.c | 100 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  fs/nfsd/state.h     |   5 +++
> >  3 files changed, 125 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 7f7e6bb23a90d9a1cafd154c0f09e236df75b083..527f8dc5215980377096470=
0170473509ec328ed 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2342,6 +2342,13 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
> >  			 union nfsd4_op_u *u)
> >  {
> >  	struct nfsd4_get_dir_delegation *gdd =3D &u->get_dir_delegation;
> > +	struct nfs4_delegation *dd;
> > +	struct nfsd_file *nf;
> > +	__be32 status;
> > +
> > +	status =3D nfsd_file_acquire_dir(rqstp, &cstate->current_fh, &nf);
> > +	if (status !=3D nfs_ok)
> > +		return status;
> > =20
> >  	/*
> >  	 * RFC 8881, section 18.39.3 says:
> > @@ -2355,7 +2362,19 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
> >  	 * return NFS4_OK with a non-fatal status of GDD4_UNAVAIL in this
> >  	 * situation.
> >  	 */
> > -	gdd->gddrnf_status =3D GDD4_UNAVAIL;
> > +	dd =3D nfsd_get_dir_deleg(cstate, gdd, nf);
> > +	if (IS_ERR(dd)) {
> > +		int err =3D PTR_ERR(dd);
> > +
> > +		if (err !=3D -EAGAIN)
> > +			return nfserrno(err);
> > +		gdd->gddrnf_status =3D GDD4_UNAVAIL;
> > +		return nfs_ok;
> > +	}
>=20
> These error flows might leak the nf acquired just above.
>=20

Good catch. I'll fix that.

>=20
> > +
> > +	gdd->gddrnf_status =3D GDD4_OK;
> > +	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_=
stateid));
> > +	nfs4_put_stid(&dd->dl_stid);
> >  	return nfs_ok;
> >  }
> > =20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index b06591f154aa372db710e071c69260f4639956d7..a63e8c885291fc377163f32=
55f26f5f693704437 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -9359,3 +9359,103 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *r=
qstp, struct dentry *dentry,
> >  	nfs4_put_stid(&dp->dl_stid);
> >  	return status;
> >  }
> > +
> > +/**
> > + * nfsd_get_dir_deleg - attempt to get a directory delegation
> > + * @cstate: compound state
> > + * @gdd: GET_DIR_DELEGATION arg/resp structure
> > + * @nf: nfsd_file opened on the directory
> > + *
> > + * Given a GET_DIR_DELEGATION request @gdd, attempt to acquire a deleg=
ation
> > + * on the directory to which @nf refers. Note that this does not set u=
p any
> > + * sort of async notifications for the delegation.
> > + */
> > +struct nfs4_delegation *
> > +nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
> > +		   struct nfsd4_get_dir_delegation *gdd,
> > +		   struct nfsd_file *nf)
> > +{
> > +	struct nfs4_client *clp =3D cstate->clp;
> > +	struct nfs4_delegation *dp;
> > +	struct file_lease *fl;
> > +	struct nfs4_file *fp, *rfp;
> > +	int status =3D 0;
> > +
> > +	fp =3D nfsd4_alloc_file();
> > +	if (!fp)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	nfsd4_file_init(&cstate->current_fh, fp);
> > +
> > +	rfp =3D nfsd4_file_hash_insert(fp, &cstate->current_fh);
> > +	if (unlikely(!rfp)) {
> > +		put_nfs4_file(fp);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	if (rfp !=3D fp) {
> > +		put_nfs4_file(fp);
> > +		fp =3D rfp;
> > +	}
> > +
> > +	/* if this client already has one, return that it's unavailable */
> > +	spin_lock(&state_lock);
> > +	spin_lock(&fp->fi_lock);
> > +	/* existing delegation? */
> > +	if (nfs4_delegation_exists(clp, fp)) {
> > +		status =3D -EAGAIN;
> > +	} else if (!fp->fi_deleg_file) {
> > +		fp->fi_deleg_file =3D nf;
> > +		fp->fi_delegees =3D 1;
> > +	} else {
> > +		++fp->fi_delegees;
>=20
> The new nf is unused in this arm. Does it need to be released?
>=20

Yes. Good catch!

>=20
> > +	}
> > +	spin_unlock(&fp->fi_lock);
> > +	spin_unlock(&state_lock);
> > +
> > +	if (status) {
> > +		put_nfs4_file(fp);
> > +		return ERR_PTR(status);
> > +	}
> > +
> > +	/* Try to set up the lease */
> > +	status =3D -ENOMEM;
> > +	dp =3D alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
> > +	if (!dp)
> > +		goto out_delegees;
> > +
> > +	fl =3D nfs4_alloc_init_lease(dp);
> > +	if (!fl)
> > +		goto out_put_stid;
> > +
> > +	status =3D kernel_setlease(nf->nf_file,
> > +				 fl->c.flc_type, &fl, NULL);
> > +	if (fl)
> > +		locks_free_lease(fl);
> > +	if (status)
> > +		goto out_put_stid;
> > +
> > +	/*
> > +	 * Now, try to hash it. This can fail if we race another nfsd task
> > +	 * trying to set a delegation on the same file. If that happens,
> > +	 * then just say UNAVAIL.
> > +	 */
> > +	spin_lock(&state_lock);
> > +	spin_lock(&clp->cl_lock);
> > +	spin_lock(&fp->fi_lock);
> > +	status =3D hash_delegation_locked(dp, fp);
> > +	spin_unlock(&fp->fi_lock);
> > +	spin_unlock(&clp->cl_lock);
> > +	spin_unlock(&state_lock);
> > +
> > +	if (!status)
> > +		return dp;
> > +
> > +	/* Something failed. Drop the lease and clean up the stid */
> > +	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&=
dp);
> > +out_put_stid:
> > +	nfs4_put_stid(&dp->dl_stid);
> > +out_delegees:
> > +	put_deleg_file(fp);
> > +	return ERR_PTR(status);
> > +}
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 1e736f4024263ffa9c93bcc9ec48f44566a8cc77..b052c1effdc5356487c610d=
b9728df8ecfe851d4 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -867,4 +867,9 @@ static inline bool try_to_expire_client(struct nfs4=
_client *clp)
> > =20
> >  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
> >  		struct dentry *dentry, struct nfs4_delegation **pdp);
> > +
> > +struct nfsd4_get_dir_delegation;
> > +struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state=
 *cstate,
> > +						struct nfsd4_get_dir_delegation *gdd,
> > +						struct nfsd_file *nf);
> >  #endif   /* NFSD4_STATE_H */
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

