Return-Path: <linux-fsdevel+bounces-27897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0B964BF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF11F226C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC91B5EDA;
	Thu, 29 Aug 2024 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq64UJzR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439EB1B3B39;
	Thu, 29 Aug 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950165; cv=none; b=nLHyRjo5HVuS6yG2srPODeg9kxIR2yPtzKw3Nvx79BWqL9uMTTxAokzR7Be7eHQZQfB/WyYgWTNxSSaucqa7/km8hH5v7wg9TSHBItr2lcXyHfRGDMz+c0HBLh8i8sGIk72ReuUgClolPqiKelRhOIdfe/MpIIsRakSVYhmjqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950165; c=relaxed/simple;
	bh=DI3wG2LXaYGvWnzwxAX1FCXXpTijGT2kAuzO9cEBPw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GtyaKBL6Ykp9YopKgu0sSXaC15YSAvA3Ncdh1vCRiyZjQM1J32oxGWy0FK0WqLyEfdKDlilbCGOUkqJAo/9NmTVoJPXgOCQvsBYZp1bYWPwyaTuBM/OA9ljZ1f9VAHX22Wps5TZJmz0DnMmWwCIFV3wOLdC83KqGsNrVERIRQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq64UJzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3018AC4CEC1;
	Thu, 29 Aug 2024 16:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724950164;
	bh=DI3wG2LXaYGvWnzwxAX1FCXXpTijGT2kAuzO9cEBPw8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lq64UJzRWcLp2vEROpX4GwYrRRWSSNOW/lrZ1Zp2GahtnBTU9eqzT1yQMa8glFqfW
	 2x5MSXLebdxgv0eU67ItiB73h31DwYwcuuExDmQSqT/g6E5iFS0VtaoanPcu+BCVh4
	 aZSjQ197pYyHnLvf6YPktxMTLPhfvn0DSnoa7gQlLbFaJJbko6mshYTwou/3Okm5h+
	 N1IiLBtedG0GX3C1HaqchGqcTB2TtQM2LNae6og4bNtrfqi5tQuqqdj+O6p0pnVlVE
	 IKtwmHzf7Mu0YlAfBl3t8zLhYkVfIxMiagdWX0RBxHs8m24BQmnBboRZfhogdcBdEg
	 SETehyMa1yxhw==
Message-ID: <30842ebcf33e97f2f9af8eb57b2eeaec05e7dea6.camel@kernel.org>
Subject: Re: [PATCH v14 16/25] nfsd: add localio support
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 12:49:23 -0400
In-Reply-To: <20240829010424.83693-17-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-17-snitzer@kernel.org>
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

On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> Add server support for bypassing NFS for localhost reads, writes, and
> commits. This is only useful when both the client and server are
> running on the same host.
>=20
> If nfsd_open_local_fh() fails then the NFS client will both retry and
> fallback to normal network-based read, write and commit operations if
> localio is no longer supported.
>=20
> Care is taken to ensure the same NFS security mechanisms are used
> (authentication, etc) regardless of whether localio or regular NFS
> access is used.  The auth_domain established as part of the traditional
> NFS client access to the NFS server is also used for localio.  Store
> auth_domain for localio in nfsd_uuid_t and transfer it to the client
> if it is local to the server.
>=20
> Relative to containers, localio gives the client access to the network
> namespace the server has.  This is required to allow the client to
> access the server's per-namespace nfsd_net struct.
>=20
> CONFIG_NFSD_LOCALIO controls the server enablement for localio.
> A later commit will add CONFIG_NFS_LOCALIO to allow the client
> enablement.

Do we need separate CONFIG options? Surely if you have one, you'll
always want the other.

>=20
> This commit also introduces the use of nfsd's percpu_ref to interlock
> nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> not destroyed while in use by nfsd_open_local_fh, and warrants a more
> detailed explanation:
>=20
> nfsd_open_local_fh uses nfsd_serv_try_get before opening its file
> handle and then the reference must be dropped by the caller using
> nfsd_serv_put (via nfs_localio_ctx_free).
>=20
> This "interlock" working relies heavily on nfsd_open_local_fh()'s
> maybe_get_net() safely dealing with the possibility that the struct
> net (and nfsd_net by association) may have been destroyed by
> nfsd_destroy_serv() via nfsd_shutdown_net().
>=20
> Verified to fix an easy to hit crash that would occur if an nfsd
> instance running in a container, with a localio client mounted, is
> shutdown. Upon restart of the container and associated nfsd the client
> would go on to crash due to NULL pointer dereference that occuured due
> to the nfs client's localio attempting to nfsd_open_local_fh(), using
> nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
>=20

Maybe transplant a version of the above 4 paragraphs to the patch that
adds the percpu_ref handling?


> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/Kconfig          |   3 ++
>  fs/nfsd/Kconfig     |  16 +++++++
>  fs/nfsd/Makefile    |   1 +
>  fs/nfsd/filecache.c |   2 +-
>  fs/nfsd/localio.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/trace.h     |   3 +-
>  fs/nfsd/vfs.h       |   7 +++
>  7 files changed, 135 insertions(+), 2 deletions(-)
>  create mode 100644 fs/nfsd/localio.c
>=20
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a46b0cbc4d8f..1b8a5edbddff 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
>  	tristate
>  	select FS_POSIX_ACL
> =20
> +config NFS_COMMON_LOCALIO_SUPPORT
> +	bool
> +
>  config NFS_COMMON
>  	bool
>  	depends on NFSD || NFS_FS || LOCKD
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index c0bd1509ccd4..e6fa7eaa1db0 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -90,6 +90,22 @@ config NFSD_V4
> =20
>  	  If unsure, say N.
> =20
> +config NFSD_LOCALIO
> +	bool "NFS server support for the LOCALIO auxiliary protocol"
> +	depends on NFSD
> +	select NFS_COMMON_LOCALIO_SUPPORT
> +	default n
> +	help
> +	  Some NFS servers support an auxiliary NFS LOCALIO protocol
> +	  that is not an official part of the NFS protocol.
> +
> +	  This option enables support for the LOCALIO protocol in the
> +	  kernel's NFS server.  Enable this to permit local NFS clients
> +	  to bypass the network when issuing reads and writes to the
> +	  local NFS server.
> +
> +	  If unsure, say N.
> +
>  config NFSD_PNFS
>  	bool
> =20
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..78b421778a79 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilelayoutx=
dr.o
> +nfsd-$(CONFIG_NFSD_LOCALIO) +=3D localio.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a83d469bca6b..49f4aab3208a 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -53,7 +53,7 @@
>  #define NFSD_FILE_CACHE_UP		     (0)
> =20
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALI=
O)
> =20
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..4b65c66be129
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS server support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/sunrpc/svcauth.h>
> +#include <linux/sunrpc/clnt.h>
> +#include <linux/nfs.h>
> +#include <linux/nfs_common.h>
> +#include <linux/nfslocalio.h>
> +#include <linux/string.h>
> +
> +#include "nfsd.h"
> +#include "vfs.h"
> +#include "netns.h"
> +#include "filecache.h"
> +
> +/**
> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfs=
d_file
> + *
> + * @cl_nfssvc_net: the 'struct net' to use to get the proper nfsd_net
> + * @cl_nfssvc_dom: the 'struct auth_domain' required for localio access
> + * @rpc_clnt: rpc_clnt that the client established, used for sockaddr an=
d cred
> + * @cred: cred that the client established
> + * @nfs_fh: filehandle to lookup
> + * @fmode: fmode_t to use for open
> + *
> + * This function maps a local fh to a path on a local filesystem.
> + * This is useful when the nfs client has the local server mounted - it =
can
> + * avoid all the NFS overhead with reads, writes and commits.
> + *
> + * On successful return, returned nfs_localio_ctx will have its nfsd_fil=
e and
> + * nfsd_net members set. Caller is responsible for calling nfsd_file_put=
 and
> + * nfsd_serv_put (via nfs_localio_ctx_free).
> + */
> +struct nfs_localio_ctx *
> +nfsd_open_local_fh(struct net *cl_nfssvc_net, struct auth_domain *cl_nfs=
svc_dom,
> +		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> +		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> +{
> +	int mayflags =3D NFSD_MAY_LOCALIO;
> +	int status =3D 0;
> +	struct nfsd_net *nn;
> +	struct svc_cred rq_cred;
> +	struct svc_fh fh;
> +	struct nfs_localio_ctx *localio;
> +	__be32 beres;
> +
> +	if (nfs_fh->size > NFS4_FHSIZE)
> +		return ERR_PTR(-EINVAL);
> +
> +	localio =3D nfs_localio_ctx_alloc();
> +	if (!localio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Not running in nfsd context, so must safely get reference on nfsd_se=
rv.
> +	 * But the server may already be shutting down, if so disallow new loca=
lio.
> +	 */
> +	nn =3D net_generic(cl_nfssvc_net, nfsd_net_id);
> +	if (unlikely(!nfsd_serv_try_get(nn))) {
> +		status =3D -ENXIO;
> +		goto out_nfsd_serv;
> +	}
> +
> +	/* nfs_fh -> svc_fh */
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size =3D nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
> +	if (fmode & FMODE_READ)
> +		mayflags |=3D NFSD_MAY_READ;
> +	if (fmode & FMODE_WRITE)
> +		mayflags |=3D NFSD_MAY_WRITE;
> +
> +	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> +
> +	beres =3D nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, cl_nfssvc_do=
m,
> +					&fh, mayflags, &localio->nf);
> +	if (beres) {
> +		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> +		goto out_fh_put;
> +	}
> +	localio->nn =3D nn;
> +
> +out_fh_put:
> +	fh_put(&fh);
> +	if (rq_cred.cr_group_info)
> +		put_group_info(rq_cred.cr_group_info);
> +out_nfsd_serv:
> +	if (status) {
> +		nfs_localio_ctx_free(localio);
> +		return ERR_PTR(status);
> +	}
> +	return localio;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typ=
echeck =3D nfsd_open_local_fh;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d22027e23761..82bcefcd1f21 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
>  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
>  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
> =20
>  TRACE_EVENT(nfsd_compound,
>  	TP_PROTO(
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 01947561d375..e12310dd5f4c 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -33,6 +33,8 @@
> =20
>  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >=3D=
 NFSv3 */
> =20
> +#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio u=
sed */
> +
>  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
>  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
> =20
> @@ -158,6 +160,11 @@ __be32		nfsd_permission(struct svc_cred *cred, struc=
t svc_export *exp,
> =20
>  void		nfsd_filp_close(struct file *fp);
> =20
> +struct nfs_localio_ctx *
> +nfsd_open_local_fh(struct net *, struct auth_domain *,
> +		   struct rpc_clnt *, const struct cred *,
> +		   const struct nfs_fh *, const fmode_t);
> +
>  static inline int fh_want_write(struct svc_fh *fh)
>  {
>  	int ret;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

