Return-Path: <linux-fsdevel+bounces-27896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783E964BD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827BEB21026
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B4F1B5801;
	Thu, 29 Aug 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYr81UFW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00051AB505;
	Thu, 29 Aug 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949629; cv=none; b=hEMzdRDhMLt5Ck/U3w7bLTTGnR7RfDO4Ob7uvjwN8AdK94rGRTTx2dxFvXMgCycc6/a2eCINSMKEtVxJS3drtQFCS+ImnEE5woVj+IOtgAa1GIXJ8QjMzh49g0UxiEehEHvEIoCI/wmvCDklyCZt6PCbQgzobRuJJllyT8n1krc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949629; c=relaxed/simple;
	bh=+vas9FIvy57xLalqCJGi5kcVAENb9TBrhTuPOtN4omY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMnzDsq9/Mz1nTpsFUQHoiNBG9R6EBC0h2EdOHsAN0YG9ddl31h8e/ZK7pBrKS1QBLG+IHtEYOmDt33VzEWQcH8E6CzyCNU1WOCGhoeooZsGher8MibcZ8DybtwcmMoIgbPIJ1tz9REhlO+syMa/2mqWQ6J0p5jF56WCThwUBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYr81UFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BECAC4CEC1;
	Thu, 29 Aug 2024 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724949629;
	bh=+vas9FIvy57xLalqCJGi5kcVAENb9TBrhTuPOtN4omY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VYr81UFWlbAFz/XM/VAH95ukOe52U0oWQ6hOIKzd0z7fnjRjAX+GGYraZ6s3T2GVy
	 KHNSz0rTkT6yTxidzaCbT8k03t31VM4W4YNuuFfg3mA1AIT9d8zW0bFrrPMs3r9mnn
	 PVZqkwz1DyGhTjYUWe2BbhUNSwhE0lORpo9/KFbJeG69PcZpGBdoxqAzkgPgUtN+ZH
	 PmYPOeYPop1rpJeWsN1Wz+i6tggIwF1wDjARVCQKJMWHIndh89z7crqDPvxIkSxBms
	 3eaAw3V0Zju8ytYUjNhNypbpuMvIfpqlQGoTZePTBb+57GTSb00i/RnxOevgCF9lux
	 sbMnecuF93ohA==
Message-ID: <43d5ce3b7b374ed2ac7595932e2109e14ffd13e7.camel@kernel.org>
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 12:40:27 -0400
In-Reply-To: <20240829010424.83693-16-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-16-snitzer@kernel.org>
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
> Introduce struct nfs_localio_ctx and the interfaces
> nfs_localio_ctx_alloc() and nfs_localio_ctx_free().  The next commit
> will introduce nfsd_open_local_fh() which returns a nfs_localio_ctx
> structure.
>=20
> Also, expose localio's required NFSD symbols to NFS client:
> - Cache nfsd_open_local_fh symbol and other required NFSD symbols in a
>   globally accessible 'nfs_to' nfs_to_nfsd_t struct.  Add interfaces
>   get_nfs_to_nfsd_symbols() and put_nfs_to_nfsd_symbols() to allow
>   each NFS client to take a reference on NFSD symbols.
>=20
> - Apologies for the DEFINE_NFS_TO_NFSD_SYMBOL macro that makes
>   defining get_##NFSD_SYMBOL() and put_##NFSD_SYMBOL() functions far
>   simpler (and avoids cut-n-paste bugs, which is what motivated the
>   development and use of a macro for this). But as C macros go it is a
>   very simple one and there are many like it all over the kernel.
>=20
> - Given the unique nature of NFS LOCALIO being an optional feature
>   that when used requires NFS share access to NFSD memory: a unique
>   bridging of NFSD resources to NFS (via nfs_common) is needed.  But
>   that bridge must be dynamic, hence the use of symbol_request() and
>   symbol_put().  Proposed ideas to accomolish the same without using
>   symbol_{request,put} would be far more tedious to implement and
>   very likely no easier to review.  Anyway: sorry NeilBrown...
>=20
> - Despite the use of indirect function calls, caching these nfsd
>   symbols for use by the client offers a ~10% performance win
>   (compared to always doing get+call+put) for high IOPS workloads.
>=20
> - Introduce nfsd_file_file() wrapper that provides access to
>   nfsd_file's backing file.  Keeps nfsd_file structure opaque to NFS
>   client (as suggested by Jeff Layton).
>=20
> - The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
>   symbols prepares for the NFS client to use nfsd_file for localio.
>=20
> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs_to
> Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs_common/nfslocalio.c | 159 +++++++++++++++++++++++++++++++++++++
>  fs/nfsd/filecache.c        |  25 ++++++
>  fs/nfsd/filecache.h        |   1 +
>  fs/nfsd/nfssvc.c           |   5 ++
>  include/linux/nfslocalio.h |  38 +++++++++
>  5 files changed, 228 insertions(+)
>=20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 1a35a4a6dbe0..cc30fdb0cb46 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -72,3 +72,162 @@ bool nfs_uuid_is_local(const uuid_t *uuid, struct net=
 *net, struct auth_domain *
>  	return is_local;
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> +
> +/*
> + * The nfs localio code needs to call into nfsd using various symbols (b=
elow),
> + * but cannot be statically linked, because that will make the nfs modul=
e
> + * depend on the nfsd module.
> + *
> + * Instead, do dynamic linking to the nfsd module (via nfs_common module=
). The
> + * nfs_common module will only hold a reference on nfsd when localio is =
in use.
> + * This allows some sanity checking, like giving up on localio if nfsd i=
sn't loaded.
> + */
> +static DEFINE_SPINLOCK(nfs_to_nfsd_lock);
> +nfs_to_nfsd_t nfs_to;
> +EXPORT_SYMBOL_GPL(nfs_to);
> +
> +/* Macro to define nfs_to get and put methods, avoids copy-n-paste bugs =
*/
> +#define DEFINE_NFS_TO_NFSD_SYMBOL(NFSD_SYMBOL)		\
> +static nfs_to_##NFSD_SYMBOL##_t get_##NFSD_SYMBOL(void)	\
> +{							\
> +	return symbol_request(NFSD_SYMBOL);		\
> +}							\
> +static void put_##NFSD_SYMBOL(void)			\
> +{							\
> +	symbol_put(NFSD_SYMBOL);			\
> +	nfs_to.NFSD_SYMBOL =3D NULL;			\
> +}
> +
> +/* The nfs localio code needs to call into nfsd to map filehandle -> str=
uct nfsd_file */
> +extern struct nfs_localio_ctx *
> +nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *=
,
> +		   const struct cred *, const struct nfs_fh *, const fmode_t);
> +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
> +
> +/* The nfs localio code needs to call into nfsd to acquire the nfsd_file=
 */
> +extern struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
> +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_get);
> +
> +/* The nfs localio code needs to call into nfsd to release the nfsd_file=
 */
> +extern void nfsd_file_put(struct nfsd_file *nf);
> +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_put);
> +
> +/* The nfs localio code needs to call into nfsd to access the nf->nf_fil=
e */
> +extern struct file * nfsd_file_file(struct nfsd_file *nf);
> +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_file);
> +
> +/* The nfs localio code needs to call into nfsd to release nn->nfsd_serv=
 */
> +extern void nfsd_serv_put(struct nfsd_net *nn);
> +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_serv_put);
> +#undef DEFINE_NFS_TO_NFSD_SYMBOL
> +

I have the same concerns as Neil did with this patch in v13. An ops
structure that nfsd registers with nfs_common and that has pointers to
all of these functions would be a lot cleaner. I think it'll end up
being less code too.

In fact, for that I'd probably break my usual guideline of not
introducing new interfaces without callers, and just do a separate
patch that adds the ops structure and sets up the handling of the
pointer to it in nfs_common.

> +static struct kmem_cache *nfs_localio_ctx_cache;
> +
> +struct nfs_localio_ctx *nfs_localio_ctx_alloc(void)
> +{
> +	return kmem_cache_alloc(nfs_localio_ctx_cache,
> +				GFP_KERNEL | __GFP_ZERO);
> +}
> +EXPORT_SYMBOL_GPL(nfs_localio_ctx_alloc);
> +
> +void nfs_localio_ctx_free(struct nfs_localio_ctx *localio)
> +{
> +	if (localio->nf)
> +		nfs_to.nfsd_file_put(localio->nf);
> +	if (localio->nn)
> +		nfs_to.nfsd_serv_put(localio->nn);
> +	kmem_cache_free(nfs_localio_ctx_cache, localio);
> +}
> +EXPORT_SYMBOL_GPL(nfs_localio_ctx_free);
> +
> +bool get_nfs_to_nfsd_symbols(void)
> +{
> +	spin_lock(&nfs_to_nfsd_lock);
> +
> +	/* Only get symbols on first reference */
> +	if (refcount_read(&nfs_to.ref) =3D=3D 0)
> +		refcount_set(&nfs_to.ref, 1);
> +	else {
> +		refcount_inc(&nfs_to.ref);
> +		spin_unlock(&nfs_to_nfsd_lock);
> +		return true;
> +	}
> +
> +	nfs_to.nfsd_open_local_fh =3D get_nfsd_open_local_fh();
> +	if (!nfs_to.nfsd_open_local_fh)
> +		goto out_nfsd_open_local_fh;
> +
> +	nfs_to.nfsd_file_get =3D get_nfsd_file_get();
> +	if (!nfs_to.nfsd_file_get)
> +		goto out_nfsd_file_get;
> +
> +	nfs_to.nfsd_file_put =3D get_nfsd_file_put();
> +	if (!nfs_to.nfsd_file_put)
> +		goto out_nfsd_file_put;
> +
> +	nfs_to.nfsd_file_file =3D get_nfsd_file_file();
> +	if (!nfs_to.nfsd_file_file)
> +		goto out_nfsd_file_file;
> +
> +	nfs_to.nfsd_serv_put =3D get_nfsd_serv_put();
> +	if (!nfs_to.nfsd_serv_put)
> +		goto out_nfsd_serv_put;
> +
> +	spin_unlock(&nfs_to_nfsd_lock);
> +	return true;
> +
> +out_nfsd_serv_put:
> +	put_nfsd_file_file();
> +out_nfsd_file_file:
> +	put_nfsd_file_put();
> +out_nfsd_file_put:
> +	put_nfsd_file_get();
> +out_nfsd_file_get:
> +	put_nfsd_open_local_fh();
> +out_nfsd_open_local_fh:
> +	spin_unlock(&nfs_to_nfsd_lock);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(get_nfs_to_nfsd_symbols);
> +
> +void put_nfs_to_nfsd_symbols(void)
> +{
> +	spin_lock(&nfs_to_nfsd_lock);
> +
> +	if (!refcount_dec_and_test(&nfs_to.ref))
> +		goto out;
> +
> +	put_nfsd_open_local_fh();
> +	put_nfsd_file_get();
> +	put_nfsd_file_put();
> +	put_nfsd_file_file();
> +	put_nfsd_serv_put();
> +out:
> +	spin_unlock(&nfs_to_nfsd_lock);
> +}
> +EXPORT_SYMBOL_GPL(put_nfs_to_nfsd_symbols);
> +
> +static int __init nfslocalio_init(void)
> +{
> +	refcount_set(&nfs_to.ref, 0);
> +
> +	nfs_to.nfsd_open_local_fh =3D NULL;
> +	nfs_to.nfsd_file_get =3D NULL;
> +	nfs_to.nfsd_file_put =3D NULL;
> +	nfs_to.nfsd_file_file =3D NULL;
> +	nfs_to.nfsd_serv_put =3D NULL;
> +
> +	nfs_localio_ctx_cache =3D KMEM_CACHE(nfs_localio_ctx, 0);
> +	if (!nfs_localio_ctx_cache)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void __exit nfslocalio_exit(void)
> +{
> +	kmem_cache_destroy(nfs_localio_ctx_cache);
> +}
> +
> +module_init(nfslocalio_init);
> +module_exit(nfslocalio_exit);
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 2dc72de31f61..a83d469bca6b 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -39,6 +39,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/seq_file.h>
>  #include <linux/rhashtable.h>
> +#include <linux/nfslocalio.h>
> =20
>  #include "vfs.h"
>  #include "nfsd.h"
> @@ -345,6 +346,10 @@ nfsd_file_get(struct nfsd_file *nf)
>  		return nf;
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(nfsd_file_get);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_file_get_t __maybe_unused nfsd_file_get_typecheck =3D=
 nfsd_file_get;
> =20
>  /**
>   * nfsd_file_put - put the reference to a nfsd_file
> @@ -389,6 +394,26 @@ nfsd_file_put(struct nfsd_file *nf)
>  	if (refcount_dec_and_test(&nf->nf_ref))
>  		nfsd_file_free(nf);
>  }
> +EXPORT_SYMBOL_GPL(nfsd_file_put);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_file_put_t __maybe_unused nfsd_file_put_typecheck =3D=
 nfsd_file_put;
> +
> +/**
> + * nfsd_file_file - get the backing file of an nfsd_file
> + * @nf: nfsd_file of which to access the backing file.
> + *
> + * Return backing file for @nf.
> + */
> +struct file *
> +nfsd_file_file(struct nfsd_file *nf)
> +{
> +	return nf->nf_file;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_file_file);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_file_file_t __maybe_unused nfsd_file_file_typecheck =
=3D nfsd_file_file;
> =20
>  static void
>  nfsd_file_dispose_list(struct list_head *dispose)
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 26ada78b8c1e..6fbbb2e32e95 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -56,6 +56,7 @@ int nfsd_file_cache_start_net(struct net *net);
>  void nfsd_file_cache_shutdown_net(struct net *net);
>  void nfsd_file_put(struct nfsd_file *nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
> +struct file *nfsd_file_file(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
>  void nfsd_file_net_dispose(struct nfsd_net *nn);
>  bool nfsd_file_is_cached(struct inode *inode);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c639fbe4d8c2..13c69aa40d1c 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -19,6 +19,7 @@
>  #include <linux/sunrpc/svc_xprt.h>
>  #include <linux/lockd/bind.h>
>  #include <linux/nfsacl.h>
> +#include <linux/nfslocalio.h>
>  #include <linux/seq_file.h>
>  #include <linux/inetdevice.h>
>  #include <net/addrconf.h>
> @@ -201,6 +202,10 @@ void nfsd_serv_put(struct nfsd_net *nn)
>  {
>  	percpu_ref_put(&nn->nfsd_serv_ref);
>  }
> +EXPORT_SYMBOL_GPL(nfsd_serv_put);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_serv_put_t __maybe_unused nfsd_serv_put_typecheck =3D=
 nfsd_serv_put;
> =20
>  static void nfsd_serv_done(struct percpu_ref *ref)
>  {
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 9735ae8d3e5e..68f5b39f1940 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -7,6 +7,8 @@
> =20
>  #include <linux/list.h>
>  #include <linux/uuid.h>
> +#include <linux/refcount.h>
> +#include <linux/sunrpc/clnt.h>
>  #include <linux/sunrpc/svcauth.h>
>  #include <linux/nfs.h>
>  #include <net/net_namespace.h>
> @@ -28,4 +30,40 @@ void nfs_uuid_begin(nfs_uuid_t *);
>  void nfs_uuid_end(nfs_uuid_t *);
>  bool nfs_uuid_is_local(const uuid_t *, struct net *, struct auth_domain =
*);
> =20
> +struct nfsd_file;
> +struct nfsd_net;
> +
> +struct nfs_localio_ctx {
> +	struct nfsd_file *nf;
> +	struct nfsd_net *nn;
> +};
> +
> +typedef struct nfs_localio_ctx *
> +(*nfs_to_nfsd_open_local_fh_t)(struct net *, struct auth_domain *,
> +			       struct rpc_clnt *, const struct cred *,
> +			       const struct nfs_fh *, const fmode_t);
> +typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_file *)=
;
> +typedef void (*nfs_to_nfsd_file_put_t)(struct nfsd_file *);
> +typedef struct file * (*nfs_to_nfsd_file_file_t)(struct nfsd_file *);
> +typedef unsigned int (*nfs_to_nfsd_net_id_value_t)(void);
> +typedef void (*nfs_to_nfsd_serv_put_t)(struct nfsd_net *);
> +
> +typedef struct {
> +	refcount_t			ref;
> +	nfs_to_nfsd_open_local_fh_t	nfsd_open_local_fh;
> +	nfs_to_nfsd_file_get_t		nfsd_file_get;
> +	nfs_to_nfsd_file_put_t		nfsd_file_put;
> +	nfs_to_nfsd_file_file_t		nfsd_file_file;
> +	nfs_to_nfsd_net_id_value_t	nfsd_net_id_value;
> +	nfs_to_nfsd_serv_put_t		nfsd_serv_put;
> +} nfs_to_nfsd_t;
> +
> +extern nfs_to_nfsd_t nfs_to;
> +
> +bool get_nfs_to_nfsd_symbols(void);
> +void put_nfs_to_nfsd_symbols(void);
> +
> +struct nfs_localio_ctx *nfs_localio_ctx_alloc(void);
> +void nfs_localio_ctx_free(struct nfs_localio_ctx *);
> +
>  #endif  /* __LINUX_NFSLOCALIO_H */

--=20
Jeff Layton <jlayton@kernel.org>

