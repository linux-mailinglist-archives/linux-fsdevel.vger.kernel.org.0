Return-Path: <linux-fsdevel+bounces-27898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053B964BF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86987B226E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C351B5837;
	Thu, 29 Aug 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPVJsRAS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECF1B0120;
	Thu, 29 Aug 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950222; cv=none; b=bcI4lagZa1vbSTkMYYl1gIf7F21KYPyR6vkofWxQgMPNI8NCGW7gIZUpjjHM0r/sIXYgC5NmRxnny1FUpmpTk/oDhs6knAbNf4lqF/vqkoM2Ge/T8M8CuzeVYCt2KdIfE3ZboZIuqGlknDAjgfBC7KTJKpH2X7TRM9yrTRSLP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950222; c=relaxed/simple;
	bh=vkAvV/tBznxAcR3F2O8jfYlkB35JxoLYLZod+HS+/nw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ROTOSYg7SWAyVvcALv8EnQEIrcs4wQgsr4c8Py+wTqIb0v/iuwnkgl/8XTMXjgaVs11WGKfPYgm2DGAoRoSxaNt/I6LUVyG0uJSxpIyOclkOp+EiutQEAL+OAgotMO4ZLKKSIywyx0kgSORDQFFki8mEnIG8g7DVWREaOc/aaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPVJsRAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D02FC4CEC1;
	Thu, 29 Aug 2024 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724950222;
	bh=vkAvV/tBznxAcR3F2O8jfYlkB35JxoLYLZod+HS+/nw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hPVJsRASzYpsBkcjaYbaRZN5HVlCZxjkFAwwo7+BEn++C0Lym/0l9ozrmQHb0cSMj
	 2W7gTjae2BbtRWsIufaF7lX89h6/jbXwJ/ZieG+UWRSRZudMUZRJoFEULLFZibtLfY
	 h0PmIjbeJyL7nK5cbWRdtj7GrwP42dzQMNV4IQaRP0qO+lVLidh9F3EBmJjI63/xic
	 dxgOlFg3sNzR23QzF6a4W2LuuNCytJBhHSO/97jmlkIlpruCetqTv6vKERANk5VlPV
	 R+s2ywIVn3OXGMQmIDN5sp74e6X1Zx36jfIFLoCXrWs3MGaPKzos8iS6Z7YULv79u0
	 xmXbYiPah8Crw==
Message-ID: <c4ffd5e55846988b2974178be8e3d96007c6cfa4.camel@kernel.org>
Subject: Re: [PATCH v14 17/25] nfsd: implement server support for
 NFS_LOCALIO_PROGRAM
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 12:50:20 -0400
In-Reply-To: <20240829010424.83693-18-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-18-snitzer@kernel.org>
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
> The LOCALIO auxiliary RPC protocol consists of a single "UUID_IS_LOCAL"
> RPC method that allows the Linux NFS client to verify the local Linux
> NFS server can see the nonce (single-use UUID) the client generated and
> made available in nfs_common.  The server expects this protocol to use
> the same transport as NFS and NFSACL for its RPCs.  This protocol
> isn't part of an IETF standard, nor does it need to be considering it
> is Linux-to-Linux auxiliary RPC protocol that amounts to an
> implementation detail.
>=20
> The UUID_IS_LOCAL method encodes the client generated uuid_t in terms of
> the fixed UUID_SIZE (16 bytes).  The fixed size opaque encode and decode
> XDR methods are used instead of the less efficient variable sized
> methods.
>=20
> The RPC program number for the NFS_LOCALIO_PROGRAM is 400122 (as assigned
> by IANA, see https://www.iana.org/assignments/rpc-program-numbers/ ):
> Linux Kernel Organization       400122  nfslocalio
>=20
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> [neilb: factored out and simplified single localio protocol]
> Co-developed-by: NeilBrown <neil@brown.name>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/localio.c   | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h      |  4 +++
>  fs/nfsd/nfssvc.c    | 23 +++++++++++++-
>  include/linux/nfs.h |  7 +++++
>  4 files changed, 108 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 4b65c66be129..a192bbe308df 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -13,12 +13,15 @@
>  #include <linux/nfs.h>
>  #include <linux/nfs_common.h>
>  #include <linux/nfslocalio.h>
> +#include <linux/nfs_fs.h>
> +#include <linux/nfs_xdr.h>
>  #include <linux/string.h>
> =20
>  #include "nfsd.h"
>  #include "vfs.h"
>  #include "netns.h"
>  #include "filecache.h"
> +#include "cache.h"
> =20
>  /**
>   * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfs=
d_file
> @@ -103,3 +106,75 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> =20
>  /* Compile time type checking, not used by anything */
>  static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typ=
echeck =3D nfsd_open_local_fh;
> +
> +/*
> + * UUID_IS_LOCAL XDR functions
> + */
> +
> +static __be32 localio_proc_null(struct svc_rqst *rqstp)
> +{
> +	return rpc_success;
> +}
> +
> +struct localio_uuidarg {
> +	uuid_t			uuid;
> +};
> +
> +static __be32 localio_proc_uuid_is_local(struct svc_rqst *rqstp)
> +{
> +	struct localio_uuidarg *argp =3D rqstp->rq_argp;
> +
> +	(void) nfs_uuid_is_local(&argp->uuid, SVC_NET(rqstp),
> +				 rqstp->rq_client);
> +
> +	return rpc_success;
> +}
> +
> +static bool localio_decode_uuidarg(struct svc_rqst *rqstp,
> +				   struct xdr_stream *xdr)
> +{
> +	struct localio_uuidarg *argp =3D rqstp->rq_argp;
> +	u8 uuid[UUID_SIZE];
> +
> +	if (decode_opaque_fixed(xdr, uuid, UUID_SIZE))
> +		return false;
> +	import_uuid(&argp->uuid, uuid);
> +
> +	return true;
> +}
> +
> +static const struct svc_procedure localio_procedures1[] =3D {
> +	[LOCALIOPROC_NULL] =3D {
> +		.pc_func =3D localio_proc_null,
> +		.pc_decode =3D nfssvc_decode_voidarg,
> +		.pc_encode =3D nfssvc_encode_voidres,
> +		.pc_argsize =3D sizeof(struct nfsd_voidargs),
> +		.pc_ressize =3D sizeof(struct nfsd_voidres),
> +		.pc_cachetype =3D RC_NOCACHE,
> +		.pc_xdrressize =3D 0,
> +		.pc_name =3D "NULL",
> +	},
> +	[LOCALIOPROC_UUID_IS_LOCAL] =3D {
> +		.pc_func =3D localio_proc_uuid_is_local,
> +		.pc_decode =3D localio_decode_uuidarg,
> +		.pc_encode =3D nfssvc_encode_voidres,
> +		.pc_argsize =3D sizeof(struct localio_uuidarg),
> +		.pc_argzero =3D sizeof(struct localio_uuidarg),
> +		.pc_ressize =3D sizeof(struct nfsd_voidres),
> +		.pc_cachetype =3D RC_NOCACHE,
> +		.pc_name =3D "UUID_IS_LOCAL",
> +	},
> +};
> +
> +#define LOCALIO_NR_PROCEDURES ARRAY_SIZE(localio_procedures1)
> +static DEFINE_PER_CPU_ALIGNED(unsigned long,
> +			      localio_count[LOCALIO_NR_PROCEDURES]);
> +const struct svc_version localio_version1 =3D {
> +	.vs_vers	=3D 1,
> +	.vs_nproc	=3D LOCALIO_NR_PROCEDURES,
> +	.vs_proc	=3D localio_procedures1,
> +	.vs_dispatch	=3D nfsd_dispatch,
> +	.vs_count	=3D localio_count,
> +	.vs_xdrsize	=3D XDR_QUADLEN(UUID_SIZE),
> +	.vs_hidden	=3D true,
> +};
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index b0d3e82d6dcd..232a873dc53a 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -146,6 +146,10 @@ extern const struct svc_version nfsd_acl_version3;
>  #endif
>  #endif
> =20
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +extern const struct svc_version localio_version1;
> +#endif
> +
>  struct nfsd_net;
> =20
>  enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 13c69aa40d1c..eec4a9803c4a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -80,6 +80,15 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
>  unsigned long	nfsd_drc_max_mem;
>  unsigned long	nfsd_drc_mem_used;
> =20
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +static const struct svc_version *localio_versions[] =3D {
> +	[1] =3D &localio_version1,
> +};
> +
> +#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
> +
> +#endif /* CONFIG_NFSD_LOCALIO */
> +
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  static const struct svc_version *nfsd_acl_version[] =3D {
>  # if defined(CONFIG_NFSD_V2_ACL)
> @@ -128,6 +137,18 @@ struct svc_program		nfsd_programs[] =3D {
>  	.pg_rpcbind_set		=3D nfsd_acl_rpcbind_set,
>  	},
>  #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	{
> +	.pg_prog		=3D NFS_LOCALIO_PROGRAM,
> +	.pg_nvers		=3D NFSD_LOCALIO_NRVERS,
> +	.pg_vers		=3D localio_versions,
> +	.pg_name		=3D "nfslocalio",
> +	.pg_class		=3D "nfsd",
> +	.pg_authenticate	=3D svc_set_client,
> +	.pg_init_request	=3D svc_generic_init_request,
> +	.pg_rpcbind_set		=3D svc_generic_rpcbind_set,
> +	}
> +#endif /* IS_ENABLED(CONFIG_NFSD_LOCALIO) */
>  };
> =20
>  bool nfsd_support_version(int vers)
> @@ -949,7 +970,7 @@ nfsd(void *vrqstp)
>  }
> =20
>  /**
> - * nfsd_dispatch - Process an NFS or NFSACL Request
> + * nfsd_dispatch - Process an NFS or NFSACL or LOCALIO Request
>   * @rqstp: incoming request
>   *
>   * This RPC dispatcher integrates the NFS server's duplicate reply cache=
.
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index ceb70a926b95..5ff1a5b3b00c 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -13,6 +13,13 @@
>  #include <linux/crc32.h>
>  #include <uapi/linux/nfs.h>
> =20
> +/* The localio program is entirely private to Linux and is
> + * NOT part of the uapi.
> + */
> +#define NFS_LOCALIO_PROGRAM		400122
> +#define LOCALIOPROC_NULL		0
> +#define LOCALIOPROC_UUID_IS_LOCAL	1
> +
>  /*
>   * This is the kernel NFS client file handle representation
>   */

Reviewed-by: Jeff Layton <jlayton@kernel.org>

