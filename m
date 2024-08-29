Return-Path: <linux-fsdevel+bounces-27936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8511964D31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4631C2288C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67681B81A1;
	Thu, 29 Aug 2024 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duqW8i4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCF1B78E1;
	Thu, 29 Aug 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953712; cv=none; b=fZv+3xcxMoHpC0/tcOLT5riIZlmVSG0mbb1NIhf9/hkDyE1va4ixOBjmK75OipWL/TKpxusDqMjL5nGxcRyVaptlNASRsXp20KlScHH/v456kTIqXoyZtqiBP4PVtsGH81vH5lAYGn2CvsB0D/W6WLZ7171znIeJeI3JeFPOcLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953712; c=relaxed/simple;
	bh=Yus5cdWabaGj3Jv5j4m1SNdVxjf4SrMfLG6VNeAqazU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WVnG9s1jyuOFXjW0/C399HQBYttN46Xq69rS5gcai6kJs6ut61Td5LmD+DYO9ISmZOh/kDDJC/m77XDseZSOOVAfqvu8wkl1aoT2xYLRnCpInMQbh0Q67brS0sxxL+li2JBOC644WPLKqlM2GORhGxjNWypGdwQalQtPohlZh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duqW8i4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA66DC4CEC1;
	Thu, 29 Aug 2024 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953711;
	bh=Yus5cdWabaGj3Jv5j4m1SNdVxjf4SrMfLG6VNeAqazU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=duqW8i4CM5SqlDheevzZefhu6AEQtj15Zk2UNoSfiThjmDysrOjGlNhy/2qfmxv4C
	 zTqUtBWSjWlfJCKkMJn+5Y62Vdrrw4SQ8PVF1X5zvRht8QCARPzL4+jhaBqJJRtl8Q
	 +4Z4E2i2CjNjcOX9FrspwXvxyrBj9a0WNl6aTisIxQgEOpV6F/QVFF80woK5I89Qf7
	 AxrzScxkr7FxCBd1BA+6F5iK8mDjvFzpXTnh9iXqtSgk6rQg/31+Y7XGtpx05Bllls
	 bknD9azYWMMRZztNGdyfuQig45ld/iwcwlsmM7mlaeNCyEfEhgVod1TJMW7Ax5cIQK
	 sS6HMNPCm/nDQ==
Message-ID: <95776943752608072e60f185e98f35a97175eecd.camel@kernel.org>
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, Anna
 Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@hammerspace.com>,
 NeilBrown <neilb@suse.de>,  linux-fsdevel@vger.kernel.org
Date: Thu, 29 Aug 2024 13:48:29 -0400
In-Reply-To: <ZtCnTV7nb4CVNdAN@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
	 <20240829010424.83693-16-snitzer@kernel.org>
	 <43d5ce3b7b374ed2ac7595932e2109e14ffd13e7.camel@kernel.org>
	 <ZtCnTV7nb4CVNdAN@kernel.org>
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

On Thu, 2024-08-29 at 12:52 -0400, Mike Snitzer wrote:
> On Thu, Aug 29, 2024 at 12:40:27PM -0400, Jeff Layton wrote:
> > On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > > Introduce struct nfs_localio_ctx and the interfaces
> > > nfs_localio_ctx_alloc() and nfs_localio_ctx_free().  The next commit
> > > will introduce nfsd_open_local_fh() which returns a nfs_localio_ctx
> > > structure.
> > >=20
> > > Also, expose localio's required NFSD symbols to NFS client:
> > > - Cache nfsd_open_local_fh symbol and other required NFSD symbols in =
a
> > >   globally accessible 'nfs_to' nfs_to_nfsd_t struct.  Add interfaces
> > >   get_nfs_to_nfsd_symbols() and put_nfs_to_nfsd_symbols() to allow
> > >   each NFS client to take a reference on NFSD symbols.
> > >=20
> > > - Apologies for the DEFINE_NFS_TO_NFSD_SYMBOL macro that makes
> > >   defining get_##NFSD_SYMBOL() and put_##NFSD_SYMBOL() functions far
> > >   simpler (and avoids cut-n-paste bugs, which is what motivated the
> > >   development and use of a macro for this). But as C macros go it is =
a
> > >   very simple one and there are many like it all over the kernel.
> > >=20
> > > - Given the unique nature of NFS LOCALIO being an optional feature
> > >   that when used requires NFS share access to NFSD memory: a unique
> > >   bridging of NFSD resources to NFS (via nfs_common) is needed.  But
> > >   that bridge must be dynamic, hence the use of symbol_request() and
> > >   symbol_put().  Proposed ideas to accomolish the same without using
> > >   symbol_{request,put} would be far more tedious to implement and
> > >   very likely no easier to review.  Anyway: sorry NeilBrown...
> > >=20
> > > - Despite the use of indirect function calls, caching these nfsd
> > >   symbols for use by the client offers a ~10% performance win
> > >   (compared to always doing get+call+put) for high IOPS workloads.
> > >=20
> > > - Introduce nfsd_file_file() wrapper that provides access to
> > >   nfsd_file's backing file.  Keeps nfsd_file structure opaque to NFS
> > >   client (as suggested by Jeff Layton).
> > >=20
> > > - The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
> > >   symbols prepares for the NFS client to use nfsd_file for localio.
> > >=20
> > > Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs=
_to
> > > Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfs_common/nfslocalio.c | 159 +++++++++++++++++++++++++++++++++++=
++
> > >  fs/nfsd/filecache.c        |  25 ++++++
> > >  fs/nfsd/filecache.h        |   1 +
> > >  fs/nfsd/nfssvc.c           |   5 ++
> > >  include/linux/nfslocalio.h |  38 +++++++++
> > >  5 files changed, 228 insertions(+)
> > >=20
> > > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > > index 1a35a4a6dbe0..cc30fdb0cb46 100644
> > > --- a/fs/nfs_common/nfslocalio.c
> > > +++ b/fs/nfs_common/nfslocalio.c
> > > @@ -72,3 +72,162 @@ bool nfs_uuid_is_local(const uuid_t *uuid, struct=
 net *net, struct auth_domain *
> > >  	return is_local;
> > >  }
> > >  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> > > +
> > > +/*
> > > + * The nfs localio code needs to call into nfsd using various symbol=
s (below),
> > > + * but cannot be statically linked, because that will make the nfs m=
odule
> > > + * depend on the nfsd module.
> > > + *
> > > + * Instead, do dynamic linking to the nfsd module (via nfs_common mo=
dule). The
> > > + * nfs_common module will only hold a reference on nfsd when localio=
 is in use.
> > > + * This allows some sanity checking, like giving up on localio if nf=
sd isn't loaded.
> > > + */
> > > +static DEFINE_SPINLOCK(nfs_to_nfsd_lock);
> > > +nfs_to_nfsd_t nfs_to;
> > > +EXPORT_SYMBOL_GPL(nfs_to);
> > > +
> > > +/* Macro to define nfs_to get and put methods, avoids copy-n-paste b=
ugs */
> > > +#define DEFINE_NFS_TO_NFSD_SYMBOL(NFSD_SYMBOL)		\
> > > +static nfs_to_##NFSD_SYMBOL##_t get_##NFSD_SYMBOL(void)	\
> > > +{							\
> > > +	return symbol_request(NFSD_SYMBOL);		\
> > > +}							\
> > > +static void put_##NFSD_SYMBOL(void)			\
> > > +{							\
> > > +	symbol_put(NFSD_SYMBOL);			\
> > > +	nfs_to.NFSD_SYMBOL =3D NULL;			\
> > > +}
> > > +
> > > +/* The nfs localio code needs to call into nfsd to map filehandle ->=
 struct nfsd_file */
> > > +extern struct nfs_localio_ctx *
> > > +nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_cl=
nt *,
> > > +		   const struct cred *, const struct nfs_fh *, const fmode_t);
> > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
> > > +
> > > +/* The nfs localio code needs to call into nfsd to acquire the nfsd_=
file */
> > > +extern struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
> > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_get);
> > > +
> > > +/* The nfs localio code needs to call into nfsd to release the nfsd_=
file */
> > > +extern void nfsd_file_put(struct nfsd_file *nf);
> > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_put);
> > > +
> > > +/* The nfs localio code needs to call into nfsd to access the nf->nf=
_file */
> > > +extern struct file * nfsd_file_file(struct nfsd_file *nf);
> > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_file);
> > > +
> > > +/* The nfs localio code needs to call into nfsd to release nn->nfsd_=
serv */
> > > +extern void nfsd_serv_put(struct nfsd_net *nn);
> > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_serv_put);
> > > +#undef DEFINE_NFS_TO_NFSD_SYMBOL
> > > +
> >=20
> > I have the same concerns as Neil did with this patch in v13. An ops
> > structure that nfsd registers with nfs_common and that has pointers to
> > all of these functions would be a lot cleaner. I think it'll end up
> > being less code too.
> >=20
> > In fact, for that I'd probably break my usual guideline of not
> > introducing new interfaces without callers, and just do a separate
> > patch that adds the ops structure and sets up the handling of the
> > pointer to it in nfs_common.
>=20
> OK, as much as it pains me to set aside proven code that I put a
> decent amount of time to honing: I'll humor you guys and try to make
> an ops structure workable. (we can always fall back to my approach if
> I/we come up short).
>=20
> I'm just concerned about the optional use aspect.  There is the pain
> point of how does NFS client come to _know_ NFSD loaded?  Using
> symbol_request() deals with that nicely.
>=20

Have a pointer to a struct nfsd_localio_ops or something in the
nfs_common module. That's initially set to NULL. Then, have a static
structure of that type in nfsd.ko, and have its __init routine set the
pointer in nfs_common to point to the right structure. The __exit
routine will later set it to NULL.

> I really don't want all calls in NFS client (or nfs_common) to have to
> first check if nfs_common's 'nfs_to' ops structure is NULL or not.

Neil seems to think that's not necessary:

"If nfs/localio holds an auth_domain, then it implicitly holds a
reference to the nfsd module and the functions cannot disappear."

That'll need to be clearly documented though as it's a subtle thing to
rely on for this.
--=20
Jeff Layton <jlayton@kernel.org>

