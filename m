Return-Path: <linux-fsdevel+bounces-28412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE796A177
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F1C1F26104
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8E12B94;
	Tue,  3 Sep 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH0UW/9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256216F0D0;
	Tue,  3 Sep 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375608; cv=none; b=iDier0K2gCthK08QTlBB3IUKgzaFTvdTv7eKNN2N/aseBF/CWZXWUIfbE83GydQqJVAPw+l8nFgaH2N/LlxF2Ie7I2W8eSmv4vnaYq0nnIkUk4yfsT+bgqe1Bnvw+ZZjb36xlZMt5npboN7jHywGIXK4AYoAw0CyRdjXvw48vAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375608; c=relaxed/simple;
	bh=R5XiZuiRdMRoAx0ed2jLR34djSeA0ECqYKdldFsKt+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF3EwY31cocwKIbhO1dfpzgD79egBuaZIVGA+JGvhJBN+1g6nGkTHGrJBljvDh1wE6vJveNWza4j0p8svRyi4krPIt+vAgP69/Ot/EacFP1pltcqwhjMdyQ0xQzMcBS1Br4+fKmX4MDFoYUfnGTCH2WjA2sYhrt6VM+s9mLNXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH0UW/9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2E6C4CEC4;
	Tue,  3 Sep 2024 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725375607;
	bh=R5XiZuiRdMRoAx0ed2jLR34djSeA0ECqYKdldFsKt+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EH0UW/9ZwKLeBZkerCnI9iNZn3fH1IhWJslXvZ+pDQclIKMTzsrrbnHjCjRxP0cVr
	 l1wwHIO8My6dIKbaGtfwXjnt7cvUJw8J82QIvVhgV48BXEbjZLIN2mcwT5Fa4J1vto
	 Nfz6n8G+tKRIsjItrJnwqZq1uiLcS+7PQRIJkpbvvuNwDnfA6YLteSZ1Wins3OkZ8Y
	 ZO8+2RUFx+Cx+lq7g3LG8LuWhkT8k87tT7chR1PzEgDmSQYlUKvkD4bVTJLZGymjmi
	 rBl3BUXTxt+eWuF/OXG6vojKb+p6C+4O8O9rveqwXV31XuihzI1KpBQj6VBrxJOCCp
	 NpRFmsGdpsOLQ==
Date: Tue, 3 Sep 2024 11:00:05 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <ZtckdSIT6a3N-VTU@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <20240831223755.8569-17-snitzer@kernel.org>
 <ZtceWJE5mJ9ayf2y@tissot.1015granger.net>
 <cd02bbdc0059afaff52d0aab1da0ecf91d101a0a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd02bbdc0059afaff52d0aab1da0ecf91d101a0a.camel@kernel.org>

On Tue, Sep 03, 2024 at 10:40:28AM -0400, Jeff Layton wrote:
> On Tue, 2024-09-03 at 10:34 -0400, Chuck Lever wrote:
> > On Sat, Aug 31, 2024 at 06:37:36PM -0400, Mike Snitzer wrote:
> > > From: Weston Andros Adamson <dros@primarydata.com>
> > > 
> > > Add server support for bypassing NFS for localhost reads, writes, and
> > > commits. This is only useful when both the client and server are
> > > running on the same host.
> > > 
> > > If nfsd_open_local_fh() fails then the NFS client will both retry and
> > > fallback to normal network-based read, write and commit operations if
> > > localio is no longer supported.
> > > 
> > > Care is taken to ensure the same NFS security mechanisms are used
> > > (authentication, etc) regardless of whether localio or regular NFS
> > > access is used.  The auth_domain established as part of the traditional
> > > NFS client access to the NFS server is also used for localio.  Store
> > > auth_domain for localio in nfsd_uuid_t and transfer it to the client
> > > if it is local to the server.
> > > 
> > > Relative to containers, localio gives the client access to the network
> > > namespace the server has.  This is required to allow the client to
> > > access the server's per-namespace nfsd_net struct.
> > > 
> > > This commit also introduces the use of NFSD's percpu_ref to interlock
> > > nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> > > not destroyed while in use by nfsd_open_local_fh and other LOCALIO
> > > client code.
> > > 
> > > CONFIG_NFS_LOCALIO enables NFS server support for LOCALIO.
> > > 
> > > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > Co-developed-by: NeilBrown <neilb@suse.de>
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > 
> > > Not-Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > > Not-Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/Makefile           |   1 +
> > >  fs/nfsd/filecache.c        |   2 +-
> > >  fs/nfsd/localio.c          | 112 +++++++++++++++++++++++++++++++++++++
> > >  fs/nfsd/netns.h            |   4 ++
> > >  fs/nfsd/nfsctl.c           |  25 ++++++++-
> > >  fs/nfsd/trace.h            |   3 +-
> > >  fs/nfsd/vfs.h              |   2 +
> > >  include/linux/nfslocalio.h |   8 +++
> > >  8 files changed, 154 insertions(+), 3 deletions(-)
> > >  create mode 100644 fs/nfsd/localio.c
> > > 
> > > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > > index b8736a82e57c..18cbd3fa7691 100644
> > > --- a/fs/nfsd/Makefile
> > > +++ b/fs/nfsd/Makefile
> > > @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
> > >  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
> > >  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
> > >  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> > > +nfsd-$(CONFIG_NFS_LOCALIO) += localio.o
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 89ff380ec31e..348c1b97092e 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -52,7 +52,7 @@
> > >  #define NFSD_FILE_CACHE_UP		     (0)
> > >  
> > >  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> > > -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> > > +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
> > >  
> > >  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> > >  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > new file mode 100644
> > > index 000000000000..75df709c6903
> > > --- /dev/null
> > > +++ b/fs/nfsd/localio.c
> > > @@ -0,0 +1,112 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * NFS server support for local clients to bypass network stack
> > > + *
> > > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> > > + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> > > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > > + * Copyright (C) 2024 NeilBrown <neilb@suse.de>
> > > + */
> > > +
> > > +#include <linux/exportfs.h>
> > > +#include <linux/sunrpc/svcauth.h>
> > > +#include <linux/sunrpc/clnt.h>
> > > +#include <linux/nfs.h>
> > > +#include <linux/nfs_common.h>
> > > +#include <linux/nfslocalio.h>
> > > +#include <linux/string.h>
> > > +
> > > +#include "nfsd.h"
> > > +#include "vfs.h"
> > > +#include "netns.h"
> > > +#include "filecache.h"
> > > +
> > > +static const struct nfsd_localio_operations nfsd_localio_ops = {
> > > +	.nfsd_open_local_fh = nfsd_open_local_fh,
> > > +	.nfsd_file_put_local = nfsd_file_put_local,
> > > +	.nfsd_file_file = nfsd_file_file,
> > > +};
> > > +
> > > +void nfsd_localio_ops_init(void)
> > > +{
> > > +	memcpy(&nfs_to, &nfsd_localio_ops, sizeof(nfsd_localio_ops));
> > > +}
> > 
> > Same comment as Neil: this should surface a pointer to the
> > localio_ops struct. Copying the whole set of function pointers is
> > generally unnecessary.
> > 
> > 
> > > +
> > > +/**
> > > + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
> > > + *
> > > + * @uuid: nfs_uuid_t which provides the 'struct net' to get the proper nfsd_net
> > > + *        and the 'struct auth_domain' required for LOCALIO access
> > > + * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
> > > + * @cred: cred that the client established
> > > + * @nfs_fh: filehandle to lookup
> > > + * @fmode: fmode_t to use for open
> > > + *
> > > + * This function maps a local fh to a path on a local filesystem.
> > > + * This is useful when the nfs client has the local server mounted - it can
> > > + * avoid all the NFS overhead with reads, writes and commits.
> > > + *
> > > + * On successful return, returned nfsd_file will have its nf_net member
> > > + * set. Caller (NFS client) is responsible for calling nfsd_serv_put and
> > > + * nfsd_file_put (via nfs_to.nfsd_file_put_local).
> > > + */
> > > +struct nfsd_file *
> > > +nfsd_open_local_fh(nfs_uuid_t *uuid,
> > > +		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> > > +		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> > > +	__must_hold(rcu)
> > > +{
> > > +	int mayflags = NFSD_MAY_LOCALIO;
> > > +	struct nfsd_net *nn = NULL;
> > > +	struct net *net;
> > > +	struct svc_cred rq_cred;
> > > +	struct svc_fh fh;
> > > +	struct nfsd_file *localio;
> > > +	__be32 beres;
> > > +
> > > +	if (nfs_fh->size > NFS4_FHSIZE)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	/*
> > > +	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
> > > +	 * But the server may already be shutting down, if so disallow new localio.
> > > +	 * uuid->net is NOT a counted reference, but caller's rcu_read_lock() ensures
> > > +	 * that if uuid->net is not NULL, then calling nfsd_serv_try_get() is safe
> > > +	 * and if it succeeds we will have an implied reference to the net.
> > > +	 */
> > > +	net = rcu_dereference(uuid->net);
> > > +	if (net)
> > > +		nn = net_generic(net, nfsd_net_id);
> > > +	if (unlikely(!nn || !nfsd_serv_try_get(nn)))
> > > +		return ERR_PTR(-ENXIO);
> > > +
> > > +	/* Drop the rcu lock for nfsd_file_acquire_local() */
> > > +	rcu_read_unlock();
> > 
> > I'm struggling with the locking logistics. Caller takes the RCU read
> > lock, this function drops the lock, then takes it again. So:
> > 
> >  - A caller might rely on the lock being held continuously, but
> >  - The API contract documented above doesn't indicate that this
> >    function drops that lock
> >  - The __must_hold(rcu) annotation doesn't indicate that this
> >    function drops that lock, IIUC
> > 
> > Dropping and retaking the lock in here is an anti-pattern that
> > should be avoided. I suggest we are better off in the long run if
> > the caller does not need to take the RCU read lock, but instead,
> > nfsd_open_local_fh takes it right here just for the rcu_dereference.

I thought so too when I first saw how Neil approached fixing this to
be safe.  It was only after putting further time to it (and having the
benefit of being so close to all this) that I realized the nuance at
play (please see my reply to Jeff below for the nuance I'm speaking
of). 

> > 
> > OTOH, Why drop the lock before calling nfsd_file_acquire_local()?
> > The RCU read lock can safely be taken more than once in succession.
> > 
> > Let's rethink the locking strategy.
> > 

Yes, _that_ is a very valid point.  I did wonder the same: it seems
perfectly fine to simply retain the RCU throughout the entirety of
nfsd_open_local_fh().

> Agreed. The only caller does this:
> 
>         rcu_read_lock();
>         if (!rcu_access_pointer(uuid->net)) {
>                 rcu_read_unlock();
>                 return ERR_PTR(-ENXIO);
>         }
>         localio = nfs_to.nfsd_open_local_fh(uuid, rpc_clnt, cred,
>                                             nfs_fh, fmode);
>         rcu_read_unlock();
> 
> Maybe just move the check for uuid->net down into nfsd_open_local_fh,
> and it can acquire the rcu_read_lock for itself?

No, sorry we cannot.  The call to nfs_to.nfsd_open_local_fh (which is
a symbol provided by nfsd) is only safe if the RCU protected pre-check
shows the uuid->net valid.

Mike

