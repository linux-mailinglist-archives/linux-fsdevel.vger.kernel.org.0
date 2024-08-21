Return-Path: <linux-fsdevel+bounces-26529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEE695A4E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DDC1C22C74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774001B3B1D;
	Wed, 21 Aug 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr+6UeEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20CD1D131A;
	Wed, 21 Aug 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724266227; cv=none; b=Yv2e45Zk9XooeBNAG9VGKMMRdDxlbQnBCzeU5gPkXvsqzyzBgLOae3JS8uJTQ+xoBtlW65ork8F2fN+qfzK4kXGGYNUA1jI1BGGqk0n+h44Q1ah/DjRyyXuYmMK76Yqxg2PkITjo+tYkbq7lp4Ofr7p8K1OCcUFXQ5KUWHCrI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724266227; c=relaxed/simple;
	bh=YgMtYK0sRL2dmfM1r4U4cZeaLinRFKkn2BjE6sDjG/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jjy2iC8DeHpf++/dSupSAdmwSPqJK9WE1kxE/AUoktJI/wYBCQQXdiqoySTyXuLA0n4rgfEji1kGJqwj7YkhcMCbR9HYbDHpU8EdqILtPNXTrH09J2wxnNfq7grEXSJ6EtPqm8hN6F35EEq1yoF+eaP91n55e+NMudLl6es6hcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr+6UeEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C0AC32781;
	Wed, 21 Aug 2024 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724266227;
	bh=YgMtYK0sRL2dmfM1r4U4cZeaLinRFKkn2BjE6sDjG/c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Xr+6UeEv3tlp+oHlTD0dFKrGiA1srB6DNwx8PRSqDqd+0E4ism0oyjMvpkA4MTdGN
	 1qrAyhrbOq5s3nlKPkQ7y7vum6qkoa4cKsjz9qRsYMBkHYeCvwbz61+37HDbQybPrl
	 +njkTvzrtK8KYRuOjC4MZEilgpIdYAmyH3OW7gwcduC6DAMefj6Y2LdmQO7NGhuWFF
	 O+nzS7NOkmaAdhK4px8XknfOkcNRjSPPyQMUk6tPfEUhDkfKIBfZltU0HqhjAf36Ks
	 MwCfrsU3echD1CgxDQqj4W6fe5rL1kfk5kyQu4d51h1buUwls7FBNZLSWDOZTEF+SQ
	 eD9L2CgZXZoCQ==
Message-ID: <5bb9611676a73ae5341c0cb18714d7fdb5bce0b6.camel@kernel.org>
Subject: Re: [PATCH v12 22/24] nfs: push localio nfsd_file_put call out to
 client
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Wed, 21 Aug 2024 14:50:25 -0400
In-Reply-To: <20240819181750.70570-23-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
	 <20240819181750.70570-23-snitzer@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 14:17 -0400, Mike Snitzer wrote:
> Change nfsd_open_local_fh() to return an nfsd_file, instead of file,
> and move associated reference counting to the nfs client's
> nfs_local_open_fh().
>=20
> This is the first step in allowing proper use of nfsd_file for localio
> (such that the benefits of nfsd's filecache can be realized).
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfs/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 7 +++++--
> =C2=A0fs/nfs_common/nfslocalio.c |=C2=A0 2 +-
> =C2=A0fs/nfsd/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 11 ++++-------
> =C2=A0fs/nfsd/vfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0include/linux/nfslocalio.h |=C2=A0 2 +-
> =C2=A05 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 38303427e0b3..7d63d7e34643 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -237,13 +237,14 @@ nfs_local_open_fh(struct nfs_client *clp, const str=
uct cred *cred,
> =C2=A0		=C2=A0 struct nfs_fh *fh, const fmode_t mode)
> =C2=A0{
> =C2=A0	struct file *filp;
> +	struct nfsd_file *nf;
> =C2=A0	int status;
> =C2=A0
> =C2=A0	if (mode & ~(FMODE_READ | FMODE_WRITE))
> =C2=A0		return ERR_PTR(-EINVAL);
> =C2=A0
> =C2=A0	status =3D nfs_to.nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_n=
fssvc_dom,
> -					=C2=A0=C2=A0 clp->cl_rpcclient, cred, fh, mode, &filp);
> +					=C2=A0=C2=A0 clp->cl_rpcclient, cred, fh, mode, &nf);
> =C2=A0	if (status < 0) {
> =C2=A0		trace_nfs_local_open_fh(fh, mode, status);
> =C2=A0		switch (status) {
> @@ -255,8 +256,10 @@ nfs_local_open_fh(struct nfs_client *clp, const stru=
ct cred *cred,
> =C2=A0		case -ETIMEDOUT:
> =C2=A0			status =3D -EAGAIN;
> =C2=A0		}
> -		filp =3D ERR_PTR(status);
> +		return ERR_PTR(status);
> =C2=A0	}
> +	filp =3D get_file(nfs_to.nfsd_file_file(nf));
> +	nfs_to.nfsd_file_put(nf);
> =C2=A0	return filp;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(nfs_local_open_fh);
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 087649911b52..f59167e596d3 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -98,7 +98,7 @@ static void put_##NFSD_SYMBOL(void)			\
> =C2=A0/* The nfs localio code needs to call into nfsd to map filehandle -=
> struct nfsd_file */
> =C2=A0extern int nfsd_open_local_fh(struct net *, struct auth_domain *, s=
truct rpc_clnt *,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cred *, const struct=
 nfs_fh *,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const fmode_t, struct file **);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const fmode_t, struct nfsd_file **);
> =C2=A0DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
> =C2=A0
> =C2=A0/* The nfs localio code needs to call into nfsd to acquire the nfsd=
_file */
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 008b935a3a6c..2ceab49f3cb6 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -32,13 +32,13 @@
> =C2=A0 * @cred: cred that the client established
> =C2=A0 * @nfs_fh: filehandle to lookup
> =C2=A0 * @fmode: fmode_t to use for open
> - * @pfilp: returned file pointer that maps to @nfs_fh
> + * @pnf: returned nfsd_file pointer that maps to @nfs_fh
> =C2=A0 *
> =C2=A0 * This function maps a local fh to a path on a local filesystem.
> =C2=A0 * This is useful when the nfs client has the local server mounted =
- it can
> =C2=A0 * avoid all the NFS overhead with reads, writes and commits.
> =C2=A0 *
> - * On successful return, caller is responsible for calling path_put. Als=
o
> + * On successful return, caller is responsible for calling nfsd_file_put=
. Also
> =C2=A0 * note that this is called from nfs.ko via find_symbol() to avoid =
an explicit
> =C2=A0 * dependency on knfsd. So, there is no forward declaration in a he=
ader file
> =C2=A0 * for it that is shared with the client.
> @@ -49,7 +49,7 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
> =C2=A0			 const struct cred *cred,
> =C2=A0			 const struct nfs_fh *nfs_fh,
> =C2=A0			 const fmode_t fmode,
> -			 struct file **pfilp)
> +			 struct nfsd_file **pnf)

I think I'd prefer to see this change made earlier in the series, when
nfsd_open_local_fh is first introduced (patch #10), and then just adapt
the later patches to deal with the change.

> =C2=A0{
> =C2=A0	int mayflags =3D NFSD_MAY_LOCALIO;
> =C2=A0	int status =3D 0;
> @@ -57,7 +57,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
> =C2=A0	const struct cred *save_cred;
> =C2=A0	struct svc_cred rq_cred;
> =C2=A0	struct svc_fh fh;
> -	struct nfsd_file *nf;
> =C2=A0	__be32 beres;
> =C2=A0
> =C2=A0	if (nfs_fh->size > NFS4_FHSIZE)
> @@ -91,13 +90,11 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
> =C2=A0	rpcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> =C2=A0
> =C2=A0	beres =3D nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, rpc_cln=
t->cl_vers,
> -					cl_nfssvc_dom, &fh, mayflags, &nf);
> +					cl_nfssvc_dom, &fh, mayflags, pnf);
> =C2=A0	if (beres) {
> =C2=A0		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> =C2=A0		goto out_fh_put;
> =C2=A0	}
> -	*pfilp =3D get_file(nf->nf_file);
> -	nfsd_file_put(nf);

I do like eliminating the unnecessary refcount shuffle here. Much
simpler.

> =C2=A0out_fh_put:
> =C2=A0	fh_put(&fh);
> =C2=A0	if (rq_cred.cr_group_info)
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 9720951c49a0..ec8a8aae540b 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -166,7 +166,7 @@ int		nfsd_open_local_fh(struct net *net,
> =C2=A0				=C2=A0=C2=A0 const struct cred *cred,
> =C2=A0				=C2=A0=C2=A0 const struct nfs_fh *nfs_fh,
> =C2=A0				=C2=A0=C2=A0 const fmode_t fmode,
> -				=C2=A0=C2=A0 struct file **pfilp);
> +				=C2=A0=C2=A0 struct nfsd_file **pnf);
> =C2=A0
> =C2=A0static inline int fh_want_write(struct svc_fh *fh)
> =C2=A0{
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 6302d36f9112..7e09ff621d93 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -35,7 +35,7 @@ struct nfsd_file;
> =C2=A0typedef int (*nfs_to_nfsd_open_local_fh_t)(struct net *, struct aut=
h_domain *,
> =C2=A0				struct rpc_clnt *, const struct cred *,
> =C2=A0				const struct nfs_fh *, const fmode_t,
> -				struct file **);
> +				struct nfsd_file **);
> =C2=A0typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_fi=
le *);
> =C2=A0typedef void (*nfs_to_nfsd_file_put_t)(struct nfsd_file *);
> =C2=A0typedef struct file * (*nfs_to_nfsd_file_file_t)(struct nfsd_file *=
);

--=20
Jeff Layton <jlayton@kernel.org>

