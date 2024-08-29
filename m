Return-Path: <linux-fsdevel+bounces-27899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4D964C14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6193E1C2310A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F51B5EA6;
	Thu, 29 Aug 2024 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNSGLwmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E024A2BD08;
	Thu, 29 Aug 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950352; cv=none; b=YTc8PURwbArW7zctL3N/C9m7BxVPe7w7BHPTpHYzaWBR3+5I3t5hilr1BJMvacTzKm6TdF2ArTXjDnpQex10mrp7PA5Mve0mz0opJaQphFtF/9L7JAZ4E3dChSJMXcsRdBw6LEkSp/U5Ok4Evyhg06qbS9wXC+8J4ufRPj4mP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950352; c=relaxed/simple;
	bh=9bacAnQDaobyX1A5n7M0NTC/J1+KRbSc7fS1E8d9OdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAYF+hSe+qJH1gDZm3mzpY5IwDFqMeEBpo7pYRxEAJbLmFQFbImuWJA+AzUA6dS9z/FvxtnuxZ4hCpX6aePpsy/hlwhVsj/UbN7Avh5tRMMQ+PEYrFuMkhyM9Rxj/tzRmCrWztTGkEUqa2f1+I9QeqPJe11AaSG9b9h68xqKvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNSGLwmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41040C4CEC1;
	Thu, 29 Aug 2024 16:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724950350;
	bh=9bacAnQDaobyX1A5n7M0NTC/J1+KRbSc7fS1E8d9OdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNSGLwmnjtJs+Fzpu5bkAlw/4+zVMTVJrpM8MogaiVUIHMzYvUJV0LlXpUHSC3SaY
	 GfyBOViZhAoTLZIEDrVwv8vYyeDRDeYx4fIdVR2fHI33Q15FmOOoMbFGZrUN3588p/
	 qZjcK+It9DKBaQuKvFGKb86LhdgJRk4mi4dl8B3V+LnJV6FFems744WLMGpez9Jsix
	 xGkMX8yV8/KP00JU7Fk3OQQgC0koKV7KbNsuY/subD5S43ODkGyZSm7Io3sMexwBoU
	 8aYGX9HwWkwgDqGgt/zjd2kHGJppYg+/oYn10wJrHaZaZs6oSB4SXwBOHHigEt471x
	 4sqjBi2/L3vNg==
Date: Thu, 29 Aug 2024 12:52:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
Message-ID: <ZtCnTV7nb4CVNdAN@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-16-snitzer@kernel.org>
 <43d5ce3b7b374ed2ac7595932e2109e14ffd13e7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d5ce3b7b374ed2ac7595932e2109e14ffd13e7.camel@kernel.org>

On Thu, Aug 29, 2024 at 12:40:27PM -0400, Jeff Layton wrote:
> On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > Introduce struct nfs_localio_ctx and the interfaces
> > nfs_localio_ctx_alloc() and nfs_localio_ctx_free().  The next commit
> > will introduce nfsd_open_local_fh() which returns a nfs_localio_ctx
> > structure.
> > 
> > Also, expose localio's required NFSD symbols to NFS client:
> > - Cache nfsd_open_local_fh symbol and other required NFSD symbols in a
> >   globally accessible 'nfs_to' nfs_to_nfsd_t struct.  Add interfaces
> >   get_nfs_to_nfsd_symbols() and put_nfs_to_nfsd_symbols() to allow
> >   each NFS client to take a reference on NFSD symbols.
> > 
> > - Apologies for the DEFINE_NFS_TO_NFSD_SYMBOL macro that makes
> >   defining get_##NFSD_SYMBOL() and put_##NFSD_SYMBOL() functions far
> >   simpler (and avoids cut-n-paste bugs, which is what motivated the
> >   development and use of a macro for this). But as C macros go it is a
> >   very simple one and there are many like it all over the kernel.
> > 
> > - Given the unique nature of NFS LOCALIO being an optional feature
> >   that when used requires NFS share access to NFSD memory: a unique
> >   bridging of NFSD resources to NFS (via nfs_common) is needed.  But
> >   that bridge must be dynamic, hence the use of symbol_request() and
> >   symbol_put().  Proposed ideas to accomolish the same without using
> >   symbol_{request,put} would be far more tedious to implement and
> >   very likely no easier to review.  Anyway: sorry NeilBrown...
> > 
> > - Despite the use of indirect function calls, caching these nfsd
> >   symbols for use by the client offers a ~10% performance win
> >   (compared to always doing get+call+put) for high IOPS workloads.
> > 
> > - Introduce nfsd_file_file() wrapper that provides access to
> >   nfsd_file's backing file.  Keeps nfsd_file structure opaque to NFS
> >   client (as suggested by Jeff Layton).
> > 
> > - The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
> >   symbols prepares for the NFS client to use nfsd_file for localio.
> > 
> > Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs_to
> > Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs_common/nfslocalio.c | 159 +++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/filecache.c        |  25 ++++++
> >  fs/nfsd/filecache.h        |   1 +
> >  fs/nfsd/nfssvc.c           |   5 ++
> >  include/linux/nfslocalio.h |  38 +++++++++
> >  5 files changed, 228 insertions(+)
> > 
> > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > index 1a35a4a6dbe0..cc30fdb0cb46 100644
> > --- a/fs/nfs_common/nfslocalio.c
> > +++ b/fs/nfs_common/nfslocalio.c
> > @@ -72,3 +72,162 @@ bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *
> >  	return is_local;
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> > +
> > +/*
> > + * The nfs localio code needs to call into nfsd using various symbols (below),
> > + * but cannot be statically linked, because that will make the nfs module
> > + * depend on the nfsd module.
> > + *
> > + * Instead, do dynamic linking to the nfsd module (via nfs_common module). The
> > + * nfs_common module will only hold a reference on nfsd when localio is in use.
> > + * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
> > + */
> > +static DEFINE_SPINLOCK(nfs_to_nfsd_lock);
> > +nfs_to_nfsd_t nfs_to;
> > +EXPORT_SYMBOL_GPL(nfs_to);
> > +
> > +/* Macro to define nfs_to get and put methods, avoids copy-n-paste bugs */
> > +#define DEFINE_NFS_TO_NFSD_SYMBOL(NFSD_SYMBOL)		\
> > +static nfs_to_##NFSD_SYMBOL##_t get_##NFSD_SYMBOL(void)	\
> > +{							\
> > +	return symbol_request(NFSD_SYMBOL);		\
> > +}							\
> > +static void put_##NFSD_SYMBOL(void)			\
> > +{							\
> > +	symbol_put(NFSD_SYMBOL);			\
> > +	nfs_to.NFSD_SYMBOL = NULL;			\
> > +}
> > +
> > +/* The nfs localio code needs to call into nfsd to map filehandle -> struct nfsd_file */
> > +extern struct nfs_localio_ctx *
> > +nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
> > +		   const struct cred *, const struct nfs_fh *, const fmode_t);
> > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
> > +
> > +/* The nfs localio code needs to call into nfsd to acquire the nfsd_file */
> > +extern struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
> > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_get);
> > +
> > +/* The nfs localio code needs to call into nfsd to release the nfsd_file */
> > +extern void nfsd_file_put(struct nfsd_file *nf);
> > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_put);
> > +
> > +/* The nfs localio code needs to call into nfsd to access the nf->nf_file */
> > +extern struct file * nfsd_file_file(struct nfsd_file *nf);
> > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_file);
> > +
> > +/* The nfs localio code needs to call into nfsd to release nn->nfsd_serv */
> > +extern void nfsd_serv_put(struct nfsd_net *nn);
> > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_serv_put);
> > +#undef DEFINE_NFS_TO_NFSD_SYMBOL
> > +
> 
> I have the same concerns as Neil did with this patch in v13. An ops
> structure that nfsd registers with nfs_common and that has pointers to
> all of these functions would be a lot cleaner. I think it'll end up
> being less code too.
> 
> In fact, for that I'd probably break my usual guideline of not
> introducing new interfaces without callers, and just do a separate
> patch that adds the ops structure and sets up the handling of the
> pointer to it in nfs_common.

OK, as much as it pains me to set aside proven code that I put a
decent amount of time to honing: I'll humor you guys and try to make
an ops structure workable. (we can always fall back to my approach if
I/we come up short).

I'm just concerned about the optional use aspect.  There is the pain
point of how does NFS client come to _know_ NFSD loaded?  Using
symbol_request() deals with that nicely.

I really don't want all calls in NFS client (or nfs_common) to have to
first check if nfs_common's 'nfs_to' ops structure is NULL or not.

But yeah, I'll put more time to it... ;)

Mike

