Return-Path: <linux-fsdevel+bounces-27981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B1096574B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 08:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229081C22F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB91531C2;
	Fri, 30 Aug 2024 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAccZObW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9E3C0B;
	Fri, 30 Aug 2024 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997780; cv=none; b=fwmLI17+VTX0X6GuV1UftaxxAD4UUIQT87ruX6gjiA6eUmoAYP9Oqfli8vb+FZROZhElhWiahQsqZM+GSStGnpEcyY7z++0jYPZY5RDtu1BrlplWIqMBgx2coQrVUVH5Ok39861IjtWyM9vTX6qhST+sFqo0tvZ+/zlC0/1on7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997780; c=relaxed/simple;
	bh=HZXJvIsfWAPP4UGKbvXRp25W1mbQHDnOyqQzvMUNUnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq6+e2fs3H20ASO70YsHYBNrwfrqoZ7ppcuhbv7C449UoMM4ZubSuUMYobh9kVhd9kXbytJfJgGqH6AVKqffMPmi0Usv2E89KWEEgtBB19o0gwm0tH2JxcAbu42qBajSt9eET2oomMfD1YRloILwXUuxAb+IIu8ZnoKeDq2M3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAccZObW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34201C4CEC4;
	Fri, 30 Aug 2024 06:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724997779;
	bh=HZXJvIsfWAPP4UGKbvXRp25W1mbQHDnOyqQzvMUNUnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAccZObWLXlPyvF5Z+J7nw7H/uXMliCvpGcSH24ysVqezKKxCC/amA5Mm5Bhg9GL9
	 ic9TuHyWgH0i7H5Hfiri6rNE84D+0MtKvYanQWXpzAk4JjVR7W1P39lQ72Ug43ogSl
	 pm2EJJa/HATN/HJnShIdOb57GcaL/QAjsI3Ut+ZY0QZAYSWPdDYE3AoiiUrO6Vb/in
	 8oftkLOtGzQFicdOY39/WkX3wp6vT/QDo667Rwl2B1wiUU4xOkuoYlXmUFNmeNZBRE
	 4qMv6r8xJ6/dUlnyRN7n2xND+Jhr7waicplA6wfUA5NG013B49SRZ473HhqW7jxMP7
	 1w+Aj4twdiY/g==
Date: Fri, 30 Aug 2024 02:02:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
Message-ID: <ZtFgkg1Cpy0QcevV@kernel.org>
References: <>
 <ZtFSQz8YaD3A4r3Y@kernel.org>
 <172499604207.4433.12271165205569396628@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172499604207.4433.12271165205569396628@noble.neil.brown.name>

On Fri, Aug 30, 2024 at 03:34:02PM +1000, NeilBrown wrote:
> On Fri, 30 Aug 2024, Mike Snitzer wrote:
> > On Fri, Aug 30, 2024 at 02:36:13PM +1000, NeilBrown wrote:
> > > On Fri, 30 Aug 2024, Jeff Layton wrote:
> 
> > > > Have a pointer to a struct nfsd_localio_ops or something in the
> > > > nfs_common module. That's initially set to NULL. Then, have a static
> > > > structure of that type in nfsd.ko, and have its __init routine set the
> > > > pointer in nfs_common to point to the right structure. The __exit
> > > > routine will later set it to NULL.
> > > > 
> > > > > I really don't want all calls in NFS client (or nfs_common) to have to
> > > > > first check if nfs_common's 'nfs_to' ops structure is NULL or not.
> > > > 
> > > > Neil seems to think that's not necessary:
> > > > 
> > > > "If nfs/localio holds an auth_domain, then it implicitly holds a
> > > > reference to the nfsd module and the functions cannot disappear."
> > > 
> > > On reflection that isn't quite right, but it is the sort of approach
> > > that I think we need to take.
> > > There are several things that the NFS client needs to hold one to.
> > > 
> > > 1/ It needs a reference to the nfsd module (or symbols in the module).
> > >    I think this can be held long term but we need a clear mechanism for
> > >    it to be dropped.
> > > 2/ It needs a reference to the nfsd_serv which it gets through the
> > >    'struct net' pointer.  I've posted patches to handle that better.
> > > 3/ It needs a reference to an auth_domain.  This can safely be a long
> > >    term reference.  It can already be invalidated and the code to free
> > >    it is in sunrpc which nfs already pins.  Any delay in freeing it only
> > >    wastes memory (not much), it doesn't impact anything else.
> > > 4/ It needs a reference to the nfsd_file and/or file.  This is currently
> > >    done only while the ref to the nfsd_serv is held, so I think there is
> > >    no problem there.
> > > 
> > > So possibly we could take a reference to the nfsd module whenever we
> > > store a net in nfs_uuid. and drop the ref whenever we clear that.
> > > 
> > > That means we cannot call nfsd_open_local_fh() without first getting a
> > > ref on the nfsd_serv which my latest code doesn't do.  That is easily
> > > fixed.  I'll send a patch for consideration...
> > 
> > I already implemented 2 different versions today, meant for v15.
> > 
> > First is a relaxed version of the v14 code (less code, only using
> > symbol_request on nfsd_open_local_fh.
> > 
> > Second is much more relaxed, because it leverages your original
> > assumption that the auth_domain ref sufficient.
> > 
> > I'll reply twice to this mail with each each respective patch.
> 
> Thanks... Unfortunately auth_domain isn't sufficient.
> 
> This is my version.  It should folded back into one or more earlier
> patches.   I think it is simpler.
> 
> It is against your v15 but with my 6 nfs_uuid patches replaces your
> equivalents.
> 
> Thanks,
> NeilBrown

Looks good!  But I noticed you are still using the v14
DEFINE_NFS_TO_NFSD_SYMBOL (just implies that nfs_to is getting setup
using symbol_request) so your refcounting via __module_get is
redundant.  But I see your intent, and I can combine what you provided
below with the v15.option2 that I emailed earlier (lean on your
__module_get rather than the insufficnet auth_domain ref).

Thanks.

> 
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 55622084d5c2..18b7554ec516 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -235,8 +235,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
>  	if (mode & ~(FMODE_READ | FMODE_WRITE))
>  		return NULL;
>  
> -	localio = nfs_to.nfsd_open_local_fh(&clp->cl_uuid,
> -					    clp->cl_rpcclient, cred, fh, mode);
> +	localio = nfs_open_local_fh(&clp->cl_uuid,
> +				    clp->cl_rpcclient, cred, fh, mode);
>  	if (IS_ERR(localio)) {
>  		status = PTR_ERR(localio);
>  		trace_nfs_local_open_fh(fh, mode, status);
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 8545ee75f756..cd9733eb3e4f 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -54,8 +54,11 @@ static nfs_uuid_t * nfs_uuid_lookup(const uuid_t *uuid)
>  	return NULL;
>  }
>  
> +struct module *nfsd_mod;
> +
>  void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
> -		       struct net *net, struct auth_domain *dom)
> +		       struct net *net, struct auth_domain *dom,
> +		       struct module *mod)
>  {
>  	nfs_uuid_t *nfs_uuid;
>  
> @@ -70,6 +73,9 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
>  		 */
>  		list_move(&nfs_uuid->list, list);
>  		nfs_uuid->net = net;
> +
> +		__module_get(mod);
> +		nfsd_mod = mod;
>  	}
>  	spin_unlock(&nfs_uuid_lock);
>  }
> @@ -77,8 +83,10 @@ EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
>  
>  static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
>  {
> -	if (nfs_uuid->net)
> +	if (nfs_uuid->net) {
>  		put_net(nfs_uuid->net);
> +		module_put(nfsd_mod);
> +	}
>  	nfs_uuid->net = NULL;
>  	if (nfs_uuid->dom)
>  		auth_domain_put(nfs_uuid->dom);
> @@ -107,6 +115,26 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
>  
> +struct nfs_localio_ctx *nfs_open_local_fh(nfs_uuid_t *uuid,
> +		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> +		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> +{
> +	struct nfs_localio_ctx *localio;
> +
> +	rcu_read_lock();
> +	if (!READ_ONCE(uuid->net)) {
> +		rcu_read_unlock();
> +		return ERR_PTR(-ENXIO);
> +	}
> +	localio = nfs_to.nfsd_open_local_fh(uuid, rpc_clnt, cred,
> +					    nfs_fh, fmode);
> +	rcu_read_unlock();
> +	if (IS_ERR(localio))
> +		nfs_to.nfsd_serv_put(localio->nn);
> +	return localio;
> +}
> +EXPORT_SYMBOL_GPL(nfs_open_local_fh);
> +
>  /*
>   * The nfs localio code needs to call into nfsd using various symbols (below),
>   * but cannot be statically linked, because that will make the nfs module
> @@ -135,7 +163,8 @@ static void put_##NFSD_SYMBOL(void)			\
>  /* The nfs localio code needs to call into nfsd to map filehandle -> struct nfsd_file */
>  extern struct nfs_localio_ctx *
>  nfsd_open_local_fh(nfs_uuid_t *, struct rpc_clnt *,
> -		   const struct cred *, const struct nfs_fh *, const fmode_t);
> +		   const struct cred *, const struct nfs_fh *, const fmode_t)
> +	__must_hold(rcu);
>  DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
>  
>  /* The nfs localio code needs to call into nfsd to acquire the nfsd_file */
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 491bf5017d34..d50e54406914 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -45,6 +45,7 @@ struct nfs_localio_ctx *
>  nfsd_open_local_fh(nfs_uuid_t *uuid,
>  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
>  		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> +	__must_hold(rcu)
>  {
>  	int mayflags = NFSD_MAY_LOCALIO;
>  	int status = 0;
> @@ -58,10 +59,6 @@ nfsd_open_local_fh(nfs_uuid_t *uuid,
>  	if (nfs_fh->size > NFS4_FHSIZE)
>  		return ERR_PTR(-EINVAL);
>  
> -	localio = nfs_localio_ctx_alloc();
> -	if (!localio)
> -		return ERR_PTR(-ENOMEM);
> -
>  	/*
>  	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
>  	 * But the server may already be shutting down, if so disallow new localio.
> @@ -69,17 +66,22 @@ nfsd_open_local_fh(nfs_uuid_t *uuid,
>  	 * uuid->net is not NULL, then nfsd_serv_try_get() is safe and if that succeeds
>  	 * we will have an implied reference to the net.
>  	 */
> -	rcu_read_lock();
>  	net = READ_ONCE(uuid->net);
>  	if (net)
>  		nn = net_generic(net, nfsd_net_id);
> -	if (unlikely(!nn || !nfsd_serv_try_get(nn))) {
> -		rcu_read_unlock();
> -		status = -ENXIO;
> -		goto out_nfsd_serv;
> -	}
> +	if (unlikely(!nn || !nfsd_serv_try_get(nn)))
> +		return -ENXIO;
> +
> +	/* Drop the rcu lock for alloc and nfsd_file_acquire_local() */
>  	rcu_read_unlock();
>  
> +	localio = nfs_localio_ctx_alloc();
> +	if (!localio) {
> +		localio = ERR_PTR(-ENOMEM);
> +		nfsd_serv_put(nn);
> +		goto out_localio;
> +	}
> +
>  	/* nfs_fh -> svc_fh */
>  	fh_init(&fh, NFS4_FHSIZE);
>  	fh.fh_handle.fh_size = nfs_fh->size;
> @@ -104,11 +106,13 @@ nfsd_open_local_fh(nfs_uuid_t *uuid,
>  	fh_put(&fh);
>  	if (rq_cred.cr_group_info)
>  		put_group_info(rq_cred.cr_group_info);
> -out_nfsd_serv:
> +
>  	if (status) {
>  		nfs_localio_ctx_free(localio);
> -		return ERR_PTR(status);
> +		localio = ERR_PTR(status);
>  	}
> +out_localio:
> +	rcu_read_lock();
>  	return localio;
>  }
>  EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> @@ -136,7 +140,7 @@ static __be32 localio_proc_uuid_is_local(struct svc_rqst *rqstp)
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
>  	nfs_uuid_is_local(&argp->uuid, &nn->local_clients,
> -			  net, rqstp->rq_client);
> +			  net, rqstp->rq_client, THIS_MODULE);
>  
>  	return rpc_success;
>  }
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 2ecceb8b9d3d..c73633120997 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -164,7 +164,8 @@ void		nfsd_filp_close(struct file *fp);
>  struct nfs_localio_ctx *
>  nfsd_open_local_fh(nfs_uuid_t *,
>  		   struct rpc_clnt *, const struct cred *,
> -		   const struct nfs_fh *, const fmode_t);
> +		   const struct nfs_fh *, const fmode_t)
> +	__must_hold(rcu);
>  
>  static inline int fh_want_write(struct svc_fh *fh)
>  {
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index e196f716a2f5..303e82e75b9e 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -29,7 +29,7 @@ typedef struct {
>  void nfs_uuid_begin(nfs_uuid_t *);
>  void nfs_uuid_end(nfs_uuid_t *);
>  void nfs_uuid_is_local(const uuid_t *, struct list_head *,
> -		       struct net *, struct auth_domain *);
> +		       struct net *, struct auth_domain *, struct module *);
>  void nfs_uuid_invalidate_clients(struct list_head *list);
>  void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
>  
> @@ -69,4 +69,8 @@ void put_nfs_to_nfsd_symbols(void);
>  struct nfs_localio_ctx *nfs_localio_ctx_alloc(void);
>  void nfs_localio_ctx_free(struct nfs_localio_ctx *);
>  
> +struct nfs_localio_ctx *nfs_open_local_fh(nfs_uuid_t *uuid,
> +		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> +		   const struct nfs_fh *nfs_fh, const fmode_t fmode);
> +
>  #endif  /* __LINUX_NFSLOCALIO_H */
> 

