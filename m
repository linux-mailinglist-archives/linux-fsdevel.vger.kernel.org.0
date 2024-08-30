Return-Path: <linux-fsdevel+bounces-27973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE396569F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247652856E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 05:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096914C5B0;
	Fri, 30 Aug 2024 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNJTZ4MS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05C139D1E;
	Fri, 30 Aug 2024 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994117; cv=none; b=RjkkgP2Tq95X8MpyTWRuuWpM7+JaB360Y47BTmI+zCZ5omRaCi9sRvusSE9oANqVYFfQ8IpH/RXKt+ToB4WPHwD0soBrdcJLtNO3J9xfubVtK5gfHazQrBY8o8IIF/3IUgh972c+QkR2gZsCZw+YnnqeJIX3jMJz4bOqfvnyjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994117; c=relaxed/simple;
	bh=Pj2KxtKIIdl3fOm0LTAp4pW4SAbJFCXzIjnUhIfvXNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOztZ7l13iDacEooXWY0C4s9gM6v1xXi0Cv3oBVqncxOK7tCdnEtuXm8wi1bBmqe/8G/ur+DksMdncnokV3poRjkBaHIBfuTSW1ivy0HgK9YGBb0DQW30rO1LVv7YD8sSig0tb74Z70czOuCZDnvyrtPl9v0iBElbviP7oBfco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNJTZ4MS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DC3C4CEC8;
	Fri, 30 Aug 2024 05:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724994117;
	bh=Pj2KxtKIIdl3fOm0LTAp4pW4SAbJFCXzIjnUhIfvXNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNJTZ4MSUpKmMqRpwqwo6w8XAf7kcjuJyL2EYF5RCD4c8QGO3/WZz87tj1t7awJZN
	 F/dABNU/YE22rBsiZWs2U0Uhe0jj+c7huqy7nLLxv+GEPgQqA1MPzERrkX5+uP/DBk
	 VmxuOSlBu2Jxi3Ecyr5HAFepZwlqSeHSEirS8dIS+PP2vfiWq4PB/0w5ThBZLi7IrT
	 mbcrqPwSzLcdylxoPMXSe0nvIGNZoOiPA1XVbaiQMA4KZktjNaaZp4kvlNZrTvJ8zI
	 WSMhE5+kneZ0kZfp3qMctti4RgX7UWHI+JGoYwi9OzyiJIToPlVn4DmjBS1luI3Mjy
	 XmB0UYRwYTzAA==
Date: Fri, 30 Aug 2024 01:01:55 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
Message-ID: <ZtFSQz8YaD3A4r3Y@kernel.org>
References: <>
 <95776943752608072e60f185e98f35a97175eecd.camel@kernel.org>
 <172499257359.4433.13078012410547323207@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172499257359.4433.13078012410547323207@noble.neil.brown.name>

On Fri, Aug 30, 2024 at 02:36:13PM +1000, NeilBrown wrote:
> On Fri, 30 Aug 2024, Jeff Layton wrote:
> > On Thu, 2024-08-29 at 12:52 -0400, Mike Snitzer wrote:
> > > On Thu, Aug 29, 2024 at 12:40:27PM -0400, Jeff Layton wrote:
> > > > On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > > > > Introduce struct nfs_localio_ctx and the interfaces
> > > > > nfs_localio_ctx_alloc() and nfs_localio_ctx_free().  The next commit
> > > > > will introduce nfsd_open_local_fh() which returns a nfs_localio_ctx
> > > > > structure.
> > > > > 
> > > > > Also, expose localio's required NFSD symbols to NFS client:
> > > > > - Cache nfsd_open_local_fh symbol and other required NFSD symbols in a
> > > > >   globally accessible 'nfs_to' nfs_to_nfsd_t struct.  Add interfaces
> > > > >   get_nfs_to_nfsd_symbols() and put_nfs_to_nfsd_symbols() to allow
> > > > >   each NFS client to take a reference on NFSD symbols.
> > > > > 
> > > > > - Apologies for the DEFINE_NFS_TO_NFSD_SYMBOL macro that makes
> > > > >   defining get_##NFSD_SYMBOL() and put_##NFSD_SYMBOL() functions far
> > > > >   simpler (and avoids cut-n-paste bugs, which is what motivated the
> > > > >   development and use of a macro for this). But as C macros go it is a
> > > > >   very simple one and there are many like it all over the kernel.
> > > > > 
> > > > > - Given the unique nature of NFS LOCALIO being an optional feature
> > > > >   that when used requires NFS share access to NFSD memory: a unique
> > > > >   bridging of NFSD resources to NFS (via nfs_common) is needed.  But
> > > > >   that bridge must be dynamic, hence the use of symbol_request() and
> > > > >   symbol_put().  Proposed ideas to accomolish the same without using
> > > > >   symbol_{request,put} would be far more tedious to implement and
> > > > >   very likely no easier to review.  Anyway: sorry NeilBrown...
> > > > > 
> > > > > - Despite the use of indirect function calls, caching these nfsd
> > > > >   symbols for use by the client offers a ~10% performance win
> > > > >   (compared to always doing get+call+put) for high IOPS workloads.
> > > > > 
> > > > > - Introduce nfsd_file_file() wrapper that provides access to
> > > > >   nfsd_file's backing file.  Keeps nfsd_file structure opaque to NFS
> > > > >   client (as suggested by Jeff Layton).
> > > > > 
> > > > > - The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
> > > > >   symbols prepares for the NFS client to use nfsd_file for localio.
> > > > > 
> > > > > Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs_to
> > > > > Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
> > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > ---
> > > > >  fs/nfs_common/nfslocalio.c | 159 +++++++++++++++++++++++++++++++++++++
> > > > >  fs/nfsd/filecache.c        |  25 ++++++
> > > > >  fs/nfsd/filecache.h        |   1 +
> > > > >  fs/nfsd/nfssvc.c           |   5 ++
> > > > >  include/linux/nfslocalio.h |  38 +++++++++
> > > > >  5 files changed, 228 insertions(+)
> > > > > 
> > > > > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > > > > index 1a35a4a6dbe0..cc30fdb0cb46 100644
> > > > > --- a/fs/nfs_common/nfslocalio.c
> > > > > +++ b/fs/nfs_common/nfslocalio.c
> > > > > @@ -72,3 +72,162 @@ bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *
> > > > >  	return is_local;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> > > > > +
> > > > > +/*
> > > > > + * The nfs localio code needs to call into nfsd using various symbols (below),
> > > > > + * but cannot be statically linked, because that will make the nfs module
> > > > > + * depend on the nfsd module.
> > > > > + *
> > > > > + * Instead, do dynamic linking to the nfsd module (via nfs_common module). The
> > > > > + * nfs_common module will only hold a reference on nfsd when localio is in use.
> > > > > + * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
> > > > > + */
> > > > > +static DEFINE_SPINLOCK(nfs_to_nfsd_lock);
> > > > > +nfs_to_nfsd_t nfs_to;
> > > > > +EXPORT_SYMBOL_GPL(nfs_to);
> > > > > +
> > > > > +/* Macro to define nfs_to get and put methods, avoids copy-n-paste bugs */
> > > > > +#define DEFINE_NFS_TO_NFSD_SYMBOL(NFSD_SYMBOL)		\
> > > > > +static nfs_to_##NFSD_SYMBOL##_t get_##NFSD_SYMBOL(void)	\
> > > > > +{							\
> > > > > +	return symbol_request(NFSD_SYMBOL);		\
> > > > > +}							\
> > > > > +static void put_##NFSD_SYMBOL(void)			\
> > > > > +{							\
> > > > > +	symbol_put(NFSD_SYMBOL);			\
> > > > > +	nfs_to.NFSD_SYMBOL = NULL;			\
> > > > > +}
> > > > > +
> > > > > +/* The nfs localio code needs to call into nfsd to map filehandle -> struct nfsd_file */
> > > > > +extern struct nfs_localio_ctx *
> > > > > +nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
> > > > > +		   const struct cred *, const struct nfs_fh *, const fmode_t);
> > > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
> > > > > +
> > > > > +/* The nfs localio code needs to call into nfsd to acquire the nfsd_file */
> > > > > +extern struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
> > > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_get);
> > > > > +
> > > > > +/* The nfs localio code needs to call into nfsd to release the nfsd_file */
> > > > > +extern void nfsd_file_put(struct nfsd_file *nf);
> > > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_put);
> > > > > +
> > > > > +/* The nfs localio code needs to call into nfsd to access the nf->nf_file */
> > > > > +extern struct file * nfsd_file_file(struct nfsd_file *nf);
> > > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_file);
> > > > > +
> > > > > +/* The nfs localio code needs to call into nfsd to release nn->nfsd_serv */
> > > > > +extern void nfsd_serv_put(struct nfsd_net *nn);
> > > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_serv_put);
> > > > > +#undef DEFINE_NFS_TO_NFSD_SYMBOL
> > > > > +
> > > > 
> > > > I have the same concerns as Neil did with this patch in v13. An ops
> > > > structure that nfsd registers with nfs_common and that has pointers to
> > > > all of these functions would be a lot cleaner. I think it'll end up
> > > > being less code too.
> > > > 
> > > > In fact, for that I'd probably break my usual guideline of not
> > > > introducing new interfaces without callers, and just do a separate
> > > > patch that adds the ops structure and sets up the handling of the
> > > > pointer to it in nfs_common.
> > > 
> > > OK, as much as it pains me to set aside proven code that I put a
> > > decent amount of time to honing: I'll humor you guys and try to make
> > > an ops structure workable. (we can always fall back to my approach if
> > > I/we come up short).
> > > 
> > > I'm just concerned about the optional use aspect.  There is the pain
> > > point of how does NFS client come to _know_ NFSD loaded?  Using
> > > symbol_request() deals with that nicely.
> > > 
> > 
> > Have a pointer to a struct nfsd_localio_ops or something in the
> > nfs_common module. That's initially set to NULL. Then, have a static
> > structure of that type in nfsd.ko, and have its __init routine set the
> > pointer in nfs_common to point to the right structure. The __exit
> > routine will later set it to NULL.
> > 
> > > I really don't want all calls in NFS client (or nfs_common) to have to
> > > first check if nfs_common's 'nfs_to' ops structure is NULL or not.
> > 
> > Neil seems to think that's not necessary:
> > 
> > "If nfs/localio holds an auth_domain, then it implicitly holds a
> > reference to the nfsd module and the functions cannot disappear."
> 
> On reflection that isn't quite right, but it is the sort of approach
> that I think we need to take.
> There are several things that the NFS client needs to hold one to.
> 
> 1/ It needs a reference to the nfsd module (or symbols in the module).
>    I think this can be held long term but we need a clear mechanism for
>    it to be dropped.
> 2/ It needs a reference to the nfsd_serv which it gets through the
>    'struct net' pointer.  I've posted patches to handle that better.
> 3/ It needs a reference to an auth_domain.  This can safely be a long
>    term reference.  It can already be invalidated and the code to free
>    it is in sunrpc which nfs already pins.  Any delay in freeing it only
>    wastes memory (not much), it doesn't impact anything else.
> 4/ It needs a reference to the nfsd_file and/or file.  This is currently
>    done only while the ref to the nfsd_serv is held, so I think there is
>    no problem there.
> 
> So possibly we could take a reference to the nfsd module whenever we
> store a net in nfs_uuid. and drop the ref whenever we clear that.
> 
> That means we cannot call nfsd_open_local_fh() without first getting a
> ref on the nfsd_serv which my latest code doesn't do.  That is easily
> fixed.  I'll send a patch for consideration...

I already implemented 2 different versions today, meant for v15.

First is a relaxed version of the v14 code (less code, only using
symbol_request on nfsd_open_local_fh.

Second is much more relaxed, because it leverages your original
assumption that the auth_domain ref sufficient.

I'll reply twice to this mail with each each respective patch.

Maybe I save you some time...

