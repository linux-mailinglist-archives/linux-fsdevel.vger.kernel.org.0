Return-Path: <linux-fsdevel+bounces-27892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1352964B60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60941C20DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACBD1B5819;
	Thu, 29 Aug 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzInbD61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EC81B0132;
	Thu, 29 Aug 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948158; cv=none; b=CZhtpicQWNGmZvQKfmPvu8HjrLuDZusaOp0H9WuA2vdXbSJa1td6JCppyVFt3Ui6tIrmqLstngL4cKsH0z+X8KW7RkOpPvKckVlUUhwnY6s2lt51iwFJZsJw0+vUlejyzcAfKy8On6gXESoLxWwlrss6i6zmp2Ag72Vw/4z5oiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948158; c=relaxed/simple;
	bh=JNe1ki+/vqtDoa5+lYHhEHCq8biuJ2u3Ys7KPm6Xstk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD1BdfhV8Xla5Sc/EcXCp+s2WsxU5kl+vtzgD+5+6M4hgMwyzu8rc5hmje0krywzDDfsghikzAcsCRHWcACCffqeyKmBpXZ7uWNj8+fw2KYxbClhPD6XxAaZyl/KA9nSAw0SXkh2GgZkFuVt5sizkKlEECY9ppD0GpYhuorc5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzInbD61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39661C4CEC1;
	Thu, 29 Aug 2024 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724948158;
	bh=JNe1ki+/vqtDoa5+lYHhEHCq8biuJ2u3Ys7KPm6Xstk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzInbD61kLd3WJN2Kn+5OrQX9/MDjYToppl5g0eGYbOtjoU2weKeWPpxOmtMw5gyM
	 0HMc9JE885aKLbtZJprK+HkhVSY2pPQlKOod3dEIB9yv4agVzXTl3gSDtOg5wKE6tP
	 jhG0nOtNvh/kNPXO1uoSRoytEiJfRuSPqNxouKUZn1z0EoALQNVKQMCZlQZGEfAC9U
	 Q0EMFbgTVMEefrMGIaPgvwDxq9boaNGlD1mqPVOintT8w0lfexVUtwTjrQOEPLvHEA
	 R66pxgBHL6SA2o9pWE6MUBKBChvlIgCQ3l447xyU0YOFI50cGgm3NBwqo1dCgIHDhh
	 lyW2KZrKwMMrw==
Date: Thu, 29 Aug 2024 12:15:57 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 16/25] nfsd: add localio support
Message-ID: <ZtCevQGIoJZIhsMg@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-17-snitzer@kernel.org>
 <ZtCbZtHG3iKqWIkF@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCbZtHG3iKqWIkF@tissot.1015granger.net>

On Thu, Aug 29, 2024 at 12:01:42PM -0400, Chuck Lever wrote:
> On Wed, Aug 28, 2024 at 09:04:11PM -0400, Mike Snitzer wrote:
> > From: Weston Andros Adamson <dros@primarydata.com>
> > 
> > Add server support for bypassing NFS for localhost reads, writes, and
> > commits. This is only useful when both the client and server are
> > running on the same host.
> > 
> > If nfsd_open_local_fh() fails then the NFS client will both retry and
> > fallback to normal network-based read, write and commit operations if
> > localio is no longer supported.
> > 
> > Care is taken to ensure the same NFS security mechanisms are used
> > (authentication, etc) regardless of whether localio or regular NFS
> > access is used.  The auth_domain established as part of the traditional
> > NFS client access to the NFS server is also used for localio.  Store
> > auth_domain for localio in nfsd_uuid_t and transfer it to the client
> > if it is local to the server.
> > 
> > Relative to containers, localio gives the client access to the network
> > namespace the server has.  This is required to allow the client to
> > access the server's per-namespace nfsd_net struct.
> > 
> > CONFIG_NFSD_LOCALIO controls the server enablement for localio.
> > A later commit will add CONFIG_NFS_LOCALIO to allow the client
> > enablement.
> > 
> > This commit also introduces the use of nfsd's percpu_ref to interlock
> > nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> > not destroyed while in use by nfsd_open_local_fh, and warrants a more
> > detailed explanation:
> > 
> > nfsd_open_local_fh uses nfsd_serv_try_get before opening its file
> > handle and then the reference must be dropped by the caller using
> > nfsd_serv_put (via nfs_localio_ctx_free).
> > 
> > This "interlock" working relies heavily on nfsd_open_local_fh()'s
> > maybe_get_net() safely dealing with the possibility that the struct
> > net (and nfsd_net by association) may have been destroyed by
> > nfsd_destroy_serv() via nfsd_shutdown_net().
> > 
> > Verified to fix an easy to hit crash that would occur if an nfsd
> > instance running in a container, with a localio client mounted, is
> > shutdown. Upon restart of the container and associated nfsd the client
> > would go on to crash due to NULL pointer dereference that occuured due
> > to the nfs client's localio attempting to nfsd_open_local_fh(), using
> > nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
> > 
> > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/Kconfig          |   3 ++
> >  fs/nfsd/Kconfig     |  16 +++++++
> >  fs/nfsd/Makefile    |   1 +
> >  fs/nfsd/filecache.c |   2 +-
> >  fs/nfsd/localio.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/trace.h     |   3 +-
> >  fs/nfsd/vfs.h       |   7 +++
> >  7 files changed, 135 insertions(+), 2 deletions(-)
> >  create mode 100644 fs/nfsd/localio.c
> > 
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index a46b0cbc4d8f..1b8a5edbddff 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
> >  	tristate
> >  	select FS_POSIX_ACL
> >  
> > +config NFS_COMMON_LOCALIO_SUPPORT
> > +	bool
> > +
> >  config NFS_COMMON
> >  	bool
> >  	depends on NFSD || NFS_FS || LOCKD
> > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > index c0bd1509ccd4..e6fa7eaa1db0 100644
> > --- a/fs/nfsd/Kconfig
> > +++ b/fs/nfsd/Kconfig
> > @@ -90,6 +90,22 @@ config NFSD_V4
> >  
> >  	  If unsure, say N.
> >  
> > +config NFSD_LOCALIO
> > +	bool "NFS server support for the LOCALIO auxiliary protocol"
> > +	depends on NFSD
> > +	select NFS_COMMON_LOCALIO_SUPPORT
> > +	default n
> > +	help
> > +	  Some NFS servers support an auxiliary NFS LOCALIO protocol
> > +	  that is not an official part of the NFS protocol.
> > +
> > +	  This option enables support for the LOCALIO protocol in the
> > +	  kernel's NFS server.  Enable this to permit local NFS clients
> > +	  to bypass the network when issuing reads and writes to the
> > +	  local NFS server.
> > +
> > +	  If unsure, say N.
> > +
> >  config NFSD_PNFS
> >  	bool
> >  
> > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > index b8736a82e57c..78b421778a79 100644
> > --- a/fs/nfsd/Makefile
> > +++ b/fs/nfsd/Makefile
> > @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
> >  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> > +nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index a83d469bca6b..49f4aab3208a 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -53,7 +53,7 @@
> >  #define NFSD_FILE_CACHE_UP		     (0)
> >  
> >  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> > -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> > +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
> >  
> >  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> >  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > new file mode 100644
> > index 000000000000..4b65c66be129
> > --- /dev/null
> > +++ b/fs/nfsd/localio.c
> > @@ -0,0 +1,105 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NFS server support for local clients to bypass network stack
> > + *
> > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> > + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > + */
> > +
> > +#include <linux/exportfs.h>
> > +#include <linux/sunrpc/svcauth.h>
> > +#include <linux/sunrpc/clnt.h>
> > +#include <linux/nfs.h>
> > +#include <linux/nfs_common.h>
> > +#include <linux/nfslocalio.h>
> > +#include <linux/string.h>
> > +
> > +#include "nfsd.h"
> > +#include "vfs.h"
> > +#include "netns.h"
> > +#include "filecache.h"
> > +
> > +/**
> > + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
> > + *
> > + * @cl_nfssvc_net: the 'struct net' to use to get the proper nfsd_net
> > + * @cl_nfssvc_dom: the 'struct auth_domain' required for localio access
> > + * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
> > + * @cred: cred that the client established
> > + * @nfs_fh: filehandle to lookup
> > + * @fmode: fmode_t to use for open
> > + *
> > + * This function maps a local fh to a path on a local filesystem.
> > + * This is useful when the nfs client has the local server mounted - it can
> > + * avoid all the NFS overhead with reads, writes and commits.
> > + *
> > + * On successful return, returned nfs_localio_ctx will have its nfsd_file and
> > + * nfsd_net members set. Caller is responsible for calling nfsd_file_put and
> > + * nfsd_serv_put (via nfs_localio_ctx_free).
> > + */
> > +struct nfs_localio_ctx *
> > +nfsd_open_local_fh(struct net *cl_nfssvc_net, struct auth_domain *cl_nfssvc_dom,
> > +		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> > +		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> > +{
> > +	int mayflags = NFSD_MAY_LOCALIO;
> > +	int status = 0;
> > +	struct nfsd_net *nn;
> > +	struct svc_cred rq_cred;
> > +	struct svc_fh fh;
> > +	struct nfs_localio_ctx *localio;
> > +	__be32 beres;
> > +
> > +	if (nfs_fh->size > NFS4_FHSIZE)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	localio = nfs_localio_ctx_alloc();
> > +	if (!localio)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	/*
> > +	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
> > +	 * But the server may already be shutting down, if so disallow new localio.
> > +	 */
> > +	nn = net_generic(cl_nfssvc_net, nfsd_net_id);
> > +	if (unlikely(!nfsd_serv_try_get(nn))) {
> > +		status = -ENXIO;
> > +		goto out_nfsd_serv;
> > +	}
> > +
> > +	/* nfs_fh -> svc_fh */
> > +	fh_init(&fh, NFS4_FHSIZE);
> > +	fh.fh_handle.fh_size = nfs_fh->size;
> > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > +
> > +	if (fmode & FMODE_READ)
> > +		mayflags |= NFSD_MAY_READ;
> > +	if (fmode & FMODE_WRITE)
> > +		mayflags |= NFSD_MAY_WRITE;
> > +
> > +	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> > +
> > +	beres = nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, cl_nfssvc_dom,
> > +					&fh, mayflags, &localio->nf);
> > +	if (beres) {
> > +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> > +		goto out_fh_put;
> > +	}
> > +	localio->nn = nn;
> > +
> > +out_fh_put:
> > +	fh_put(&fh);
> > +	if (rq_cred.cr_group_info)
> > +		put_group_info(rq_cred.cr_group_info);
> > +out_nfsd_serv:
> > +	if (status) {
> > +		nfs_localio_ctx_free(localio);
> > +		return ERR_PTR(status);
> > +	}
> > +	return localio;
> > +}
> > +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> > +
> > +/* Compile time type checking, not used by anything */
> > +static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index d22027e23761..82bcefcd1f21 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> >  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
> >  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
> >  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> > -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> > +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> > +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
> >  
> >  TRACE_EVENT(nfsd_compound,
> >  	TP_PROTO(
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index 01947561d375..e12310dd5f4c 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -33,6 +33,8 @@
> >  
> >  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
> >  
> > +#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used */
> > +
> >  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> >  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
> >  
> > @@ -158,6 +160,11 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
> >  
> >  void		nfsd_filp_close(struct file *fp);
> >  
> > +struct nfs_localio_ctx *
> > +nfsd_open_local_fh(struct net *, struct auth_domain *,
> > +		   struct rpc_clnt *, const struct cred *,
> > +		   const struct nfs_fh *, const fmode_t);
> > +
> >  static inline int fh_want_write(struct svc_fh *fh)
> >  {
> >  	int ret;
> > -- 
> > 2.44.0
> > 
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> I think I've looked at all the server-side changes now. I don't see
> any issues that block merging this series.

OK, thanks!

> Two follow-ups:
> 
> I haven't heard an answer to my question about how export options
> that translate RPC user IDs might behave for LOCALIO operations
> (eg. root_squash, all_squash). Test results, design points,
> NEEDS_WORK, etc.
> 
> Someone should try out the trace points that we neutered in
> fh_verify() before this set gets applied.

I'll work on both as a prereq for posting the final.

