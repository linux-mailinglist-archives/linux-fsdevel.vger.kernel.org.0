Return-Path: <linux-fsdevel+bounces-27889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A015B964AED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B2A1C24136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0D81B374C;
	Thu, 29 Aug 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6mv5ZWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D71A2C0A;
	Thu, 29 Aug 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947344; cv=none; b=kCs6byHbCLpCVDDHq5N/9vl8LA7lIH0SlfQvWcY+z+U2PaBSnfbQuneSBnfTAJYBdzREWkrc5IZJA7+q7HEcBQDPiPiiKERcPkueHBpkwyAyZJ8vQ6WBsmM1FsMw/+wqsJLfWb+WEC1M3baq4UN5EmGt7CwZRo65vR+Yu23zP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947344; c=relaxed/simple;
	bh=vrMYTZjfjXnXgVnFrUTdv2XLX8TfartsWbQQCSQ+HNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUGHLmcdKN2JhzFdiTzRzDtORUs9vS8XQKpkxqAr5CZYpQ7NbaeFIDSc/7nCDtIWEdF3S1qSxLEUjSMx52MZ9M4ASIkjSGI0PvUP/ZA+T5UhJH+VdmyVXnyPLyUtnmQ/HGhiwmn3L/tSzJ2WRTipafnbexdw9T9ZUMKR69k61Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6mv5ZWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0467C4CEC1;
	Thu, 29 Aug 2024 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724947343;
	bh=vrMYTZjfjXnXgVnFrUTdv2XLX8TfartsWbQQCSQ+HNU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=k6mv5ZWPun93UpN7aVGMkp6GX9tBmqXwAuqvzwRwCnf4E2mFdW7AjczZ4RHxdf7wE
	 0x6fJwiF6FJeW7lypo+ab2gH9W21l1k1L3XtEhBkR/fykMk+2NA46STP1bBPgGYWf3
	 TUPO10P0adR0SBF9INnptqWjv+4UQk7x1XkCaQMcflnj3sOEV7JLCk+ZHwPj6XGDI7
	 JPcU9TX9Z6B0yxPyDm1MlnabLW8VdhC6Cb/2gvO+Iaxgi56r5YK7mD2oxU6/sqVheE
	 VPskkH0DKIBPse86zi0xiTuZsYB3ZZPIprih40DZPa5tDOnxuCdZJG+3x1eHE2eWtU
	 tfPAA1aE1pLCg==
Message-ID: <df287db6d3c6936503c46e124b1011439dc9c9f2.camel@kernel.org>
Subject: Re: [PATCH v14 13/25] SUNRPC: replace program list with program
 array
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, 
 Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 12:02:21 -0400
In-Reply-To: <20240829010424.83693-14-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-14-snitzer@kernel.org>
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
> From: NeilBrown <neil@brown.name>
>=20
> A service created with svc_create_pooled() can be given a linked list of
> programs and all of these will be served.
>=20
> Using a linked list makes it cumbersome when there are several programs
> that can be optionally selected with CONFIG settings.
>=20
> After this patch is applied, API consumers must use only
> svc_create_pooled() when creating an RPC service that listens for more
> than one RPC program.
>=20
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/nfsctl.c           |  2 +-
>  fs/nfsd/nfsd.h             |  2 +-
>  fs/nfsd/nfssvc.c           | 38 ++++++++++-----------
>  include/linux/sunrpc/svc.h |  7 ++--
>  net/sunrpc/svc.c           | 68 ++++++++++++++++++++++----------------
>  net/sunrpc/svc_xprt.c      |  2 +-
>  net/sunrpc/svcauth_unix.c  |  3 +-
>  7 files changed, 67 insertions(+), 55 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1c9e5b4bcb0a..64c1b4d649bc 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2246,7 +2246,7 @@ static __net_init int nfsd_net_init(struct net *net=
)
>  	if (retval)
>  		goto out_repcache_error;
>  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
> -	nn->nfsd_svcstats.program =3D &nfsd_program;
> +	nn->nfsd_svcstats.program =3D &nfsd_programs[0];
>  	for (i =3D 0; i < sizeof(nn->nfsd_versions); i++)
>  		nn->nfsd_versions[i] =3D nfsd_support_version(i);
>  	for (i =3D 0; i < sizeof(nn->nfsd4_minorversions); i++)
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 4ccbf014a2c7..b0d3e82d6dcd 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -85,7 +85,7 @@ struct nfsd_genl_rqstp {
>  	u32			rq_opnum[NFSD_MAX_OPS_PER_COMPOUND];
>  };
> =20
> -extern struct svc_program	nfsd_program;
> +extern struct svc_program	nfsd_programs[];
>  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_versi=
on4;
>  extern struct mutex		nfsd_mutex;
>  extern spinlock_t		nfsd_drc_lock;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index e43d440f9f0a..c639fbe4d8c2 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -35,7 +35,6 @@
>  #define NFSDDBG_FACILITY	NFSDDBG_SVC
> =20
>  atomic_t			nfsd_th_cnt =3D ATOMIC_INIT(0);
> -extern struct svc_program	nfsd_program;
>  static int			nfsd(void *vrqstp);
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  static int			nfsd_acl_rpcbind_set(struct net *,
> @@ -90,20 +89,9 @@ static const struct svc_version *nfsd_acl_version[] =
=3D {
>  # endif
>  };
> =20
> -#define NFSD_ACL_MINVERS            2
> +#define NFSD_ACL_MINVERS	2
>  #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
> =20
> -static struct svc_program	nfsd_acl_program =3D {
> -	.pg_prog		=3D NFS_ACL_PROGRAM,
> -	.pg_nvers		=3D NFSD_ACL_NRVERS,
> -	.pg_vers		=3D nfsd_acl_version,
> -	.pg_name		=3D "nfsacl",
> -	.pg_class		=3D "nfsd",
> -	.pg_authenticate	=3D &svc_set_client,
> -	.pg_init_request	=3D nfsd_acl_init_request,
> -	.pg_rpcbind_set		=3D nfsd_acl_rpcbind_set,
> -};
> -
>  #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
> =20
>  static const struct svc_version *nfsd_version[NFSD_MAXVERS+1] =3D {
> @@ -116,18 +104,29 @@ static const struct svc_version *nfsd_version[NFSD_=
MAXVERS+1] =3D {
>  #endif
>  };
> =20
> -struct svc_program		nfsd_program =3D {
> -#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> -	.pg_next		=3D &nfsd_acl_program,
> -#endif
> +struct svc_program		nfsd_programs[] =3D {
> +	{
>  	.pg_prog		=3D NFS_PROGRAM,		/* program number */
>  	.pg_nvers		=3D NFSD_MAXVERS+1,	/* nr of entries in nfsd_version */
>  	.pg_vers		=3D nfsd_version,		/* version table */
>  	.pg_name		=3D "nfsd",		/* program name */
>  	.pg_class		=3D "nfsd",		/* authentication class */
> -	.pg_authenticate	=3D &svc_set_client,	/* export authentication */
> +	.pg_authenticate	=3D svc_set_client,	/* export authentication */
>  	.pg_init_request	=3D nfsd_init_request,
>  	.pg_rpcbind_set		=3D nfsd_rpcbind_set,
> +	},
> +#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> +	{
> +	.pg_prog		=3D NFS_ACL_PROGRAM,
> +	.pg_nvers		=3D NFSD_ACL_NRVERS,
> +	.pg_vers		=3D nfsd_acl_version,
> +	.pg_name		=3D "nfsacl",
> +	.pg_class		=3D "nfsd",
> +	.pg_authenticate	=3D svc_set_client,
> +	.pg_init_request	=3D nfsd_acl_init_request,
> +	.pg_rpcbind_set		=3D nfsd_acl_rpcbind_set,
> +	},
> +#endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
>  };
> =20
>  bool nfsd_support_version(int vers)
> @@ -637,7 +636,8 @@ int nfsd_create_serv(struct net *net)
>  	if (nfsd_max_blksize =3D=3D 0)
>  		nfsd_max_blksize =3D nfsd_get_default_max_blksize();
>  	nfsd_reset_versions(nn);
> -	serv =3D svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
> +	serv =3D svc_create_pooled(nfsd_programs, ARRAY_SIZE(nfsd_programs),
> +				 &nn->nfsd_svcstats,
>  				 nfsd_max_blksize, nfsd);
>  	if (serv =3D=3D NULL)
>  		return -ENOMEM;
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 437672bcaa22..c7ad2fb2a155 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -67,9 +67,10 @@ enum {
>   * We currently do not support more than one RPC program per daemon.
>   */
>  struct svc_serv {
> -	struct svc_program *	sv_program;	/* RPC program */
> +	struct svc_program *	sv_programs;	/* RPC programs */
>  	struct svc_stat *	sv_stats;	/* RPC statistics */
>  	spinlock_t		sv_lock;
> +	unsigned int		sv_nprogs;	/* Number of sv_programs */
>  	unsigned int		sv_nrthreads;	/* # of server threads */
>  	unsigned int		sv_maxconn;	/* max connections allowed or
>  						 * '0' causing max to be based
> @@ -357,10 +358,9 @@ struct svc_process_info {
>  };
> =20
>  /*
> - * List of RPC programs on the same transport endpoint
> + * RPC program - an array of these can use the same transport endpoint
>   */
>  struct svc_program {
> -	struct svc_program *	pg_next;	/* other programs (same xprt) */
>  	u32			pg_prog;	/* program number */
>  	unsigned int		pg_lovers;	/* lowest version */
>  	unsigned int		pg_hivers;	/* highest version */
> @@ -438,6 +438,7 @@ bool		   svc_rqst_replace_page(struct svc_rqst *rqstp=
,
>  void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
>  void		   svc_exit_thread(struct svc_rqst *);
>  struct svc_serv *  svc_create_pooled(struct svc_program *prog,
> +				     unsigned int nprog,
>  				     struct svc_stat *stats,
>  				     unsigned int bufsize,
>  				     int (*threadfn)(void *data));
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index ff6f3e35b36d..b33386d249c2 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -440,10 +440,11 @@ EXPORT_SYMBOL_GPL(svc_rpcb_cleanup);
> =20
>  static int svc_uses_rpcbind(struct svc_serv *serv)
>  {
> -	struct svc_program	*progp;
> -	unsigned int		i;
> +	unsigned int		p, i;
> +
> +	for (p =3D 0; p < serv->sv_nprogs; p++) {
> +		struct svc_program *progp =3D &serv->sv_programs[p];
> =20
> -	for (progp =3D serv->sv_program; progp; progp =3D progp->pg_next) {
>  		for (i =3D 0; i < progp->pg_nvers; i++) {
>  			if (progp->pg_vers[i] =3D=3D NULL)
>  				continue;
> @@ -480,7 +481,7 @@ __svc_init_bc(struct svc_serv *serv)
>   * Create an RPC service
>   */
>  static struct svc_serv *
> -__svc_create(struct svc_program *prog, struct svc_stat *stats,
> +__svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stat=
s,
>  	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
>  {
>  	struct svc_serv	*serv;
> @@ -491,7 +492,8 @@ __svc_create(struct svc_program *prog, struct svc_sta=
t *stats,
>  	if (!(serv =3D kzalloc(sizeof(*serv), GFP_KERNEL)))
>  		return NULL;
>  	serv->sv_name      =3D prog->pg_name;
> -	serv->sv_program   =3D prog;
> +	serv->sv_programs  =3D prog;
> +	serv->sv_nprogs    =3D nprogs;
>  	serv->sv_stats     =3D stats;
>  	if (bufsize > RPCSVC_MAXPAYLOAD)
>  		bufsize =3D RPCSVC_MAXPAYLOAD;
> @@ -499,17 +501,18 @@ __svc_create(struct svc_program *prog, struct svc_s=
tat *stats,
>  	serv->sv_max_mesg  =3D roundup(serv->sv_max_payload + PAGE_SIZE, PAGE_S=
IZE);
>  	serv->sv_threadfn =3D threadfn;
>  	xdrsize =3D 0;
> -	while (prog) {
> -		prog->pg_lovers =3D prog->pg_nvers-1;
> -		for (vers=3D0; vers<prog->pg_nvers ; vers++)
> -			if (prog->pg_vers[vers]) {
> -				prog->pg_hivers =3D vers;
> -				if (prog->pg_lovers > vers)
> -					prog->pg_lovers =3D vers;
> -				if (prog->pg_vers[vers]->vs_xdrsize > xdrsize)
> -					xdrsize =3D prog->pg_vers[vers]->vs_xdrsize;
> +	for (i =3D 0; i < nprogs; i++) {
> +		struct svc_program *progp =3D &prog[i];
> +
> +		progp->pg_lovers =3D progp->pg_nvers-1;
> +		for (vers =3D 0; vers < progp->pg_nvers ; vers++)
> +			if (progp->pg_vers[vers]) {
> +				progp->pg_hivers =3D vers;
> +				if (progp->pg_lovers > vers)
> +					progp->pg_lovers =3D vers;
> +				if (progp->pg_vers[vers]->vs_xdrsize > xdrsize)
> +					xdrsize =3D progp->pg_vers[vers]->vs_xdrsize;
>  			}
> -		prog =3D prog->pg_next;
>  	}
>  	serv->sv_xdrsize   =3D xdrsize;
>  	INIT_LIST_HEAD(&serv->sv_tempsocks);
> @@ -558,13 +561,14 @@ __svc_create(struct svc_program *prog, struct svc_s=
tat *stats,
>  struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsi=
ze,
>  			    int (*threadfn)(void *data))
>  {
> -	return __svc_create(prog, NULL, bufsize, 1, threadfn);
> +	return __svc_create(prog, 1, NULL, bufsize, 1, threadfn);
>  }
>  EXPORT_SYMBOL_GPL(svc_create);
> =20
>  /**
>   * svc_create_pooled - Create an RPC service with pooled threads
> - * @prog: the RPC program the new service will handle
> + * @prog:  Array of RPC programs the new service will handle
> + * @nprogs: Number of programs in the array
>   * @stats: the stats struct if desired
>   * @bufsize: maximum message size for @prog
>   * @threadfn: a function to service RPC requests for @prog
> @@ -572,6 +576,7 @@ EXPORT_SYMBOL_GPL(svc_create);
>   * Returns an instantiated struct svc_serv object or NULL.
>   */
>  struct svc_serv *svc_create_pooled(struct svc_program *prog,
> +				   unsigned int nprogs,
>  				   struct svc_stat *stats,
>  				   unsigned int bufsize,
>  				   int (*threadfn)(void *data))
> @@ -579,7 +584,7 @@ struct svc_serv *svc_create_pooled(struct svc_program=
 *prog,
>  	struct svc_serv *serv;
>  	unsigned int npools =3D svc_pool_map_get();
> =20
> -	serv =3D __svc_create(prog, stats, bufsize, npools, threadfn);
> +	serv =3D __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
>  	if (!serv)
>  		goto out_err;
>  	serv->sv_is_pooled =3D true;
> @@ -602,16 +607,16 @@ svc_destroy(struct svc_serv **servp)
> =20
>  	*servp =3D NULL;
> =20
> -	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
> +	dprintk("svc: svc_destroy(%s)\n", serv->sv_programs->pg_name);
>  	timer_shutdown_sync(&serv->sv_temptimer);
> =20
>  	/*
>  	 * Remaining transports at this point are not expected.
>  	 */
>  	WARN_ONCE(!list_empty(&serv->sv_permsocks),
> -		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
> +		  "SVC: permsocks remain for %s\n", serv->sv_programs->pg_name);
>  	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
> -		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
> +		  "SVC: tempsocks remain for %s\n", serv->sv_programs->pg_name);
> =20
>  	cache_clean_deferred(serv);
> =20
> @@ -1149,15 +1154,16 @@ int svc_register(const struct svc_serv *serv, str=
uct net *net,
>  		 const int family, const unsigned short proto,
>  		 const unsigned short port)
>  {
> -	struct svc_program	*progp;
> -	unsigned int		i;
> +	unsigned int		p, i;
>  	int			error =3D 0;
> =20
>  	WARN_ON_ONCE(proto =3D=3D 0 && port =3D=3D 0);
>  	if (proto =3D=3D 0 && port =3D=3D 0)
>  		return -EINVAL;
> =20
> -	for (progp =3D serv->sv_program; progp; progp =3D progp->pg_next) {
> +	for (p =3D 0; p < serv->sv_nprogs; p++) {
> +		struct svc_program *progp =3D &serv->sv_programs[p];
> +
>  		for (i =3D 0; i < progp->pg_nvers; i++) {
> =20
>  			error =3D progp->pg_rpcbind_set(net, progp, i,
> @@ -1209,13 +1215,14 @@ static void __svc_unregister(struct net *net, con=
st u32 program, const u32 versi
>  static void svc_unregister(const struct svc_serv *serv, struct net *net)
>  {
>  	struct sighand_struct *sighand;
> -	struct svc_program *progp;
>  	unsigned long flags;
> -	unsigned int i;
> +	unsigned int p, i;
> =20
>  	clear_thread_flag(TIF_SIGPENDING);
> =20
> -	for (progp =3D serv->sv_program; progp; progp =3D progp->pg_next) {
> +	for (p =3D 0; p < serv->sv_nprogs; p++) {
> +		struct svc_program *progp =3D &serv->sv_programs[p];
> +
>  		for (i =3D 0; i < progp->pg_nvers; i++) {
>  			if (progp->pg_vers[i] =3D=3D NULL)
>  				continue;
> @@ -1321,7 +1328,7 @@ svc_process_common(struct svc_rqst *rqstp)
>  	struct svc_process_info process;
>  	enum svc_auth_status	auth_res;
>  	unsigned int		aoffset;
> -	int			rc;
> +	int			pr, rc;
>  	__be32			*p;
> =20
>  	/* Will be turned off only when NFSv4 Sessions are used */
> @@ -1345,9 +1352,12 @@ svc_process_common(struct svc_rqst *rqstp)
>  	rqstp->rq_vers =3D be32_to_cpup(p++);
>  	rqstp->rq_proc =3D be32_to_cpup(p);
> =20
> -	for (progp =3D serv->sv_program; progp; progp =3D progp->pg_next)
> +	for (pr =3D 0; pr < serv->sv_nprogs; pr++) {
> +		progp =3D &serv->sv_programs[pr];
> +
>  		if (rqstp->rq_prog =3D=3D progp->pg_prog)
>  			break;
> +	}
> =20
>  	/*
>  	 * Decode auth data, and add verifier to reply buffer.
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 53ebc719ff5a..43c57124de52 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -268,7 +268,7 @@ static int _svc_xprt_create(struct svc_serv *serv, co=
nst char *xprt_name,
>  		spin_unlock(&svc_xprt_class_lock);
>  		newxprt =3D xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
>  		if (IS_ERR(newxprt)) {
> -			trace_svc_xprt_create_err(serv->sv_program->pg_name,
> +			trace_svc_xprt_create_err(serv->sv_programs->pg_name,
>  						  xcl->xcl_name, sap, len,
>  						  newxprt);
>  			module_put(xcl->xcl_owner);
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index 04b45588ae6f..8ca98b146ec8 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -697,7 +697,8 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
>  	rqstp->rq_auth_stat =3D rpc_autherr_badcred;
>  	ipm =3D ip_map_cached_get(xprt);
>  	if (ipm =3D=3D NULL)
> -		ipm =3D __ip_map_lookup(sn->ip_map_cache, rqstp->rq_server->sv_program=
->pg_class,
> +		ipm =3D __ip_map_lookup(sn->ip_map_cache,
> +				      rqstp->rq_server->sv_programs->pg_class,
>  				    &sin6->sin6_addr);
> =20
>  	if (ipm =3D=3D NULL)

Reviewed-by: Jeff Layton <jlayton@kernel.org>

