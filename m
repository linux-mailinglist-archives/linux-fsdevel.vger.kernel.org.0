Return-Path: <linux-fsdevel+bounces-28436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE2996A3C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 18:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9623CB28EA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E0B18A94E;
	Tue,  3 Sep 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMBSnFH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D915F17DFF4;
	Tue,  3 Sep 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379782; cv=none; b=fwh4T5JqoIV63sak/FA6NdN1TJ9bjGLNrJa9onXR2oajfko7yTIJr5PUn5STJnZopvbRAGxaplu29cmt+V7IBnP4+MNhrv4nbXP0bHIfdzZDps+b1YKy9LuN6s35/OtnSjodDRJfC1eG9TVz1l7qgz0PJylzyq7/L0Rgz610YpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379782; c=relaxed/simple;
	bh=vYJtB38KfqMpyiiNsCqZ2bLfUekv+uksBu8saIUJLcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2coLy11vVAKVAQKff024P9vKefB4lmbgArOy5cSUOnHV9DhP9cWwGa3NQ9vhbeyOolG5StUKzBU1nxWZLw3oy13io+1GtPrKDX4YnoXwHQq9UChRrHNfre0x5x90qrILFmEO46L4+eDHyxmWkQyzpkue7jYutZY4j1KsIVewL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMBSnFH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D95C4CEC8;
	Tue,  3 Sep 2024 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725379782;
	bh=vYJtB38KfqMpyiiNsCqZ2bLfUekv+uksBu8saIUJLcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMBSnFH0To8XaDcRAu0SkAkjEPgmv/NxT65KyCWB1Hwk7k8hda57EFsfKtHfU59sc
	 ar8KKeOJNfbRpm9tob7rpmTm+W9bV3O1nQXOWqG6aL9UTwkPA9RgF/ct3lk2BIWnYW
	 lhHKJWmDM95iuooMYTeCz1wGml1mBWEJLGG6NlW6WjLqF6yHif5GzXNsNUGRczeC31
	 cflqVhjKpeQV2j3bLBftMIbSNYg8BBYleVpRImgoWVn/eWDDjD0JbTy0Koa+8bdOiR
	 ksEY9U1hWMMqOVyvhWXfZiWzg+QHnfQEw/sfcSACwerVISW87XtZAZG6c2Xi+a0ZCU
	 8rAMMNDY4uxBg==
Date: Tue, 3 Sep 2024 12:09:41 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <Ztc0xZIrAtZszJNf@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <20240831223755.8569-17-snitzer@kernel.org>
 <ZtceWJE5mJ9ayf2y@tissot.1015granger.net>
 <cd02bbdc0059afaff52d0aab1da0ecf91d101a0a.camel@kernel.org>
 <ZtckdSIT6a3N-VTU@kernel.org>
 <981320f318d23fe02ed7597a56d13227f7cea31e.camel@kernel.org>
 <ZtcrTYLq90xIt4UK@kernel.org>
 <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>

On Tue, Sep 03, 2024 at 03:59:31PM +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 3, 2024, at 11:29 AM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > On Tue, Sep 03, 2024 at 11:19:45AM -0400, Jeff Layton wrote:
> >> On Tue, 2024-09-03 at 11:00 -0400, Mike Snitzer wrote:
> >>> On Tue, Sep 03, 2024 at 10:40:28AM -0400, Jeff Layton wrote:
> >>>> On Tue, 2024-09-03 at 10:34 -0400, Chuck Lever wrote:
> >>>>> On Sat, Aug 31, 2024 at 06:37:36PM -0400, Mike Snitzer wrote:
> >>>>>> From: Weston Andros Adamson <dros@primarydata.com>
> >>>>>> 
> >>>>>> Add server support for bypassing NFS for localhost reads, writes, and
> >>>>>> commits. This is only useful when both the client and server are
> >>>>>> running on the same host.
> >>>>>> 
> >>>>>> If nfsd_open_local_fh() fails then the NFS client will both retry and
> >>>>>> fallback to normal network-based read, write and commit operations if
> >>>>>> localio is no longer supported.
> >>>>>> 
> >>>>>> Care is taken to ensure the same NFS security mechanisms are used
> >>>>>> (authentication, etc) regardless of whether localio or regular NFS
> >>>>>> access is used.  The auth_domain established as part of the traditional
> >>>>>> NFS client access to the NFS server is also used for localio.  Store
> >>>>>> auth_domain for localio in nfsd_uuid_t and transfer it to the client
> >>>>>> if it is local to the server.
> >>>>>> 
> >>>>>> Relative to containers, localio gives the client access to the network
> >>>>>> namespace the server has.  This is required to allow the client to
> >>>>>> access the server's per-namespace nfsd_net struct.
> >>>>>> 
> >>>>>> This commit also introduces the use of NFSD's percpu_ref to interlock
> >>>>>> nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> >>>>>> not destroyed while in use by nfsd_open_local_fh and other LOCALIO
> >>>>>> client code.
> >>>>>> 
> >>>>>> CONFIG_NFS_LOCALIO enables NFS server support for LOCALIO.
> >>>>>> 
> >>>>>> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> >>>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>>>> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> >>>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >>>>>> Co-developed-by: NeilBrown <neilb@suse.de>
> >>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
> >>>>>> 
> >>>>>> Not-Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >>>>>> Not-Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>>>>> ---
> >>>>>> fs/nfsd/Makefile           |   1 +
> >>>>>> fs/nfsd/filecache.c        |   2 +-
> >>>>>> fs/nfsd/localio.c          | 112 +++++++++++++++++++++++++++++++++++++
> >>>>>> fs/nfsd/netns.h            |   4 ++
> >>>>>> fs/nfsd/nfsctl.c           |  25 ++++++++-
> >>>>>> fs/nfsd/trace.h            |   3 +-
> >>>>>> fs/nfsd/vfs.h              |   2 +
> >>>>>> include/linux/nfslocalio.h |   8 +++
> >>>>>> 8 files changed, 154 insertions(+), 3 deletions(-)
> >>>>>> create mode 100644 fs/nfsd/localio.c
> >>>>>> 
> >>>>>> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> >>>>>> index b8736a82e57c..18cbd3fa7691 100644
> >>>>>> --- a/fs/nfsd/Makefile
> >>>>>> +++ b/fs/nfsd/Makefile
> >>>>>> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
> >>>>>> nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
> >>>>>> nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
> >>>>>> nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> >>>>>> +nfsd-$(CONFIG_NFS_LOCALIO) += localio.o
> >>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> >>>>>> index 89ff380ec31e..348c1b97092e 100644
> >>>>>> --- a/fs/nfsd/filecache.c
> >>>>>> +++ b/fs/nfsd/filecache.c
> >>>>>> @@ -52,7 +52,7 @@
> >>>>>> #define NFSD_FILE_CACHE_UP      (0)
> >>>>>> 
> >>>>>> /* We only care about NFSD_MAY_READ/WRITE for this cache */
> >>>>>> -#define NFSD_FILE_MAY_MASK (NFSD_MAY_READ|NFSD_MAY_WRITE)
> >>>>>> +#define NFSD_FILE_MAY_MASK (NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
> >>>>>> 
> >>>>>> static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> >>>>>> static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> >>>>>> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..75df709c6903
> >>>>>> --- /dev/null
> >>>>>> +++ b/fs/nfsd/localio.c
> >>>>>> @@ -0,0 +1,112 @@
> >>>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>>> +/*
> >>>>>> + * NFS server support for local clients to bypass network stack
> >>>>>> + *
> >>>>>> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> >>>>>> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>>>> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> >>>>>> + * Copyright (C) 2024 NeilBrown <neilb@suse.de>
> >>>>>> + */
> >>>>>> +
> >>>>>> +#include <linux/exportfs.h>
> >>>>>> +#include <linux/sunrpc/svcauth.h>
> >>>>>> +#include <linux/sunrpc/clnt.h>
> >>>>>> +#include <linux/nfs.h>
> >>>>>> +#include <linux/nfs_common.h>
> >>>>>> +#include <linux/nfslocalio.h>
> >>>>>> +#include <linux/string.h>
> >>>>>> +
> >>>>>> +#include "nfsd.h"
> >>>>>> +#include "vfs.h"
> >>>>>> +#include "netns.h"
> >>>>>> +#include "filecache.h"
> >>>>>> +
> >>>>>> +static const struct nfsd_localio_operations nfsd_localio_ops = {
> >>>>>> + .nfsd_open_local_fh = nfsd_open_local_fh,
> >>>>>> + .nfsd_file_put_local = nfsd_file_put_local,
> >>>>>> + .nfsd_file_file = nfsd_file_file,
> >>>>>> +};
> >>>>>> +
> >>>>>> +void nfsd_localio_ops_init(void)
> >>>>>> +{
> >>>>>> + memcpy(&nfs_to, &nfsd_localio_ops, sizeof(nfsd_localio_ops));
> >>>>>> +}
> >>>>> 
> >>>>> Same comment as Neil: this should surface a pointer to the
> >>>>> localio_ops struct. Copying the whole set of function pointers is
> >>>>> generally unnecessary.
> >>>>> 
> >>>>> 
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
> >>>>>> + *
> >>>>>> + * @uuid: nfs_uuid_t which provides the 'struct net' to get the proper nfsd_net
> >>>>>> + *        and the 'struct auth_domain' required for LOCALIO access
> >>>>>> + * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
> >>>>>> + * @cred: cred that the client established
> >>>>>> + * @nfs_fh: filehandle to lookup
> >>>>>> + * @fmode: fmode_t to use for open
> >>>>>> + *
> >>>>>> + * This function maps a local fh to a path on a local filesystem.
> >>>>>> + * This is useful when the nfs client has the local server mounted - it can
> >>>>>> + * avoid all the NFS overhead with reads, writes and commits.
> >>>>>> + *
> >>>>>> + * On successful return, returned nfsd_file will have its nf_net member
> >>>>>> + * set. Caller (NFS client) is responsible for calling nfsd_serv_put and
> >>>>>> + * nfsd_file_put (via nfs_to.nfsd_file_put_local).
> >>>>>> + */
> >>>>>> +struct nfsd_file *
> >>>>>> +nfsd_open_local_fh(nfs_uuid_t *uuid,
> >>>>>> +    struct rpc_clnt *rpc_clnt, const struct cred *cred,
> >>>>>> +    const struct nfs_fh *nfs_fh, const fmode_t fmode)
> >>>>>> + __must_hold(rcu)
> >>>>>> +{
> >>>>>> + int mayflags = NFSD_MAY_LOCALIO;
> >>>>>> + struct nfsd_net *nn = NULL;
> >>>>>> + struct net *net;
> >>>>>> + struct svc_cred rq_cred;
> >>>>>> + struct svc_fh fh;
> >>>>>> + struct nfsd_file *localio;
> >>>>>> + __be32 beres;
> >>>>>> +
> >>>>>> + if (nfs_fh->size > NFS4_FHSIZE)
> >>>>>> + return ERR_PTR(-EINVAL);
> >>>>>> +
> >>>>>> + /*
> >>>>>> +  * Not running in nfsd context, so must safely get reference on nfsd_serv.
> >>>>>> +  * But the server may already be shutting down, if so disallow new localio.
> >>>>>> +  * uuid->net is NOT a counted reference, but caller's rcu_read_lock() ensures
> >>>>>> +  * that if uuid->net is not NULL, then calling nfsd_serv_try_get() is safe
> >>>>>> +  * and if it succeeds we will have an implied reference to the net.
> >>>>>> +  */
> >>>>>> + net = rcu_dereference(uuid->net);
> >>>>>> + if (net)
> >>>>>> + nn = net_generic(net, nfsd_net_id);
> >>>>>> + if (unlikely(!nn || !nfsd_serv_try_get(nn)))
> >>>>>> + return ERR_PTR(-ENXIO);
> >>>>>> +
> >>>>>> + /* Drop the rcu lock for nfsd_file_acquire_local() */
> >>>>>> + rcu_read_unlock();
> >>>>> 
> >>>>> I'm struggling with the locking logistics. Caller takes the RCU read
> >>>>> lock, this function drops the lock, then takes it again. So:
> >>>>> 
> >>>>> - A caller might rely on the lock being held continuously, but
> >>>>> - The API contract documented above doesn't indicate that this
> >>>>>   function drops that lock
> >>>>> - The __must_hold(rcu) annotation doesn't indicate that this
> >>>>>   function drops that lock, IIUC
> >>>>> 
> >>>>> Dropping and retaking the lock in here is an anti-pattern that
> >>>>> should be avoided. I suggest we are better off in the long run if
> >>>>> the caller does not need to take the RCU read lock, but instead,
> >>>>> nfsd_open_local_fh takes it right here just for the rcu_dereference.
> >>> 
> >>> I thought so too when I first saw how Neil approached fixing this to
> >>> be safe.  It was only after putting further time to it (and having the
> >>> benefit of being so close to all this) that I realized the nuance at
> >>> play (please see my reply to Jeff below for the nuance I'm speaking
> >>> of). 
> >>> 
> >>>>> 
> >>>>> OTOH, Why drop the lock before calling nfsd_file_acquire_local()?
> >>>>> The RCU read lock can safely be taken more than once in succession.
> >>>>> 
> >>>>> Let's rethink the locking strategy.
> >>>>> 
> >>> 
> >>> Yes, _that_ is a very valid point.  I did wonder the same: it seems
> >>> perfectly fine to simply retain the RCU throughout the entirety of
> >>> nfsd_open_local_fh().
> >>> 
> >> 
> >> Nope. nfsd_file_do_acquire can allocate, so you can't hold the
> >> rcu_read_lock over the whole thing.
> > 
> > Ah, yeap.. sorry, I knew that ;)
> > 
> >>>> Agreed. The only caller does this:
> >>>> 
> >>>>        rcu_read_lock();
> >>>>        if (!rcu_access_pointer(uuid->net)) {
> >>>>                rcu_read_unlock();
> >>>>                return ERR_PTR(-ENXIO);
> >>>>        }
> >>>>        localio = nfs_to.nfsd_open_local_fh(uuid, rpc_clnt, cred,
> >>>>                                            nfs_fh, fmode);
> >>>>        rcu_read_unlock();
> >>>> 
> >>>> Maybe just move the check for uuid->net down into nfsd_open_local_fh,
> >>>> and it can acquire the rcu_read_lock for itself?
> >>> 
> >>> No, sorry we cannot.  The call to nfs_to.nfsd_open_local_fh (which is
> >>> a symbol provided by nfsd) is only safe if the RCU protected pre-check
> >>> shows the uuid->net valid.
> >> 
> >> Ouch, ok.
> > 
> > I had to double check but I did add a comment that speaks directly to
> > this "nuance" above the code you quoted:
> > 
> >        /*
> >         * uuid->net must not be NULL, otherwise NFS may not have ref
> >         * on NFSD and therefore cannot safely make 'nfs_to' calls.
> >         */
> > 
> > So yeah, this code needs to stay like this.  The __must_hold(rcu) just
> > ensures the RCU is held on entry and exit.. the bouncing of RCU
> > (dropping and retaking) isn't of immediate concern is it?  While I
> > agree it isn't ideal, it is what it is given:
> > 1) NFS caller of NFSD symbol is only safe if it has RCU amd verified
> >   uuid->net valid
> > 2) nfsd_file_do_acquire() can allocate.
> 
> OK, understood, but the annotation is still wrong. The lock
> is dropped here so I think you need __releases and __acquires
> in that case. However...

Sure, that seems like more precise context with which to train
lockdep.

> Let's wait for Neil's comments, but I think this needs to be
> properly addressed before merging. The comments are not going
> to be enough IMO.

I obviously have no issues with Neil confirming/expanding what I
shared about the need for checking uuid->net with RCU held to ensure
it safe to call this nfs_to method.  Without it we cannot make the
call, which happens to then take other references (nfsd_serv and
nfsd_file) that we can then lean on for the duration of the NFS client
issuing IO and then dropping the references/interlock when completing
the IO.

The NFS client maintainers need to give a good review anyway, so
plenty of time for Neil to weigh in.

Thanks,
Mike

