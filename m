Return-Path: <linux-fsdevel+bounces-27972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79696567E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 06:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797431F229AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 04:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEEE14B09F;
	Fri, 30 Aug 2024 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J7vMcuDE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iJXRcNI9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J7vMcuDE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iJXRcNI9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9814D711;
	Fri, 30 Aug 2024 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724992599; cv=none; b=fH9GRopewj4Jna7YbPSje7poKh3Xj8tsxoWDOBrEm1vq4bapBjDb6G45lpLXCuJANz7quH3DCgAvfCeLulyQ36ILwvWv4nyPoKafw0zvSs5wkg1aRQHahaUyq8cHmXAlHmOao6BjyvJe+U2TW9ElOX+y2MHagN36IPjXo/7M4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724992599; c=relaxed/simple;
	bh=KgoG4yJwSlIncZu3uXOM6fgZ/zzgkPRNuN+bkA7d0Qs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Hu6dT77e+qY9SB/N+w4EqYEE2gvyM6wJYQsAIgYfcLoYZ9/EId/UcHtZDabGVNSCU0tSTrnfRUFqyDc/cM6Q1RZ08ROnQHyfLKZtx/plmjjAiMT2X5UZ4dEBVBoX6b4XGCDFwUrRjqtDHY5K4whSz9vc4w6vdyQhvub9npCOfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J7vMcuDE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iJXRcNI9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J7vMcuDE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iJXRcNI9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBECC1F79E;
	Fri, 30 Aug 2024 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724992594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SC536qI5El1MUvSXzgfykOrzSLhPKmHkVPaGz3C2fsc=;
	b=J7vMcuDE89vOKCETs7xNQ8UslgneXDRmXCBq23MWDDb1cW9iZ3KH3yxGipX25rcWOfcWr9
	OIX12IoWKuw9KpRDzNnxEEOBL4cr371NxBm7DJdoTb324UE/BRABwlKTwL5jtNwiBYRMp8
	014qw+NwLUj+20j8A396iNooQ5aocoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724992594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SC536qI5El1MUvSXzgfykOrzSLhPKmHkVPaGz3C2fsc=;
	b=iJXRcNI92tzpDorZGI0glfaAJRrNcakbR3n24uYja2eF0p3mIvBq5uNwPFvwG8lnX/Vccp
	Dh+Xuj9w8sd6p0BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724992594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SC536qI5El1MUvSXzgfykOrzSLhPKmHkVPaGz3C2fsc=;
	b=J7vMcuDE89vOKCETs7xNQ8UslgneXDRmXCBq23MWDDb1cW9iZ3KH3yxGipX25rcWOfcWr9
	OIX12IoWKuw9KpRDzNnxEEOBL4cr371NxBm7DJdoTb324UE/BRABwlKTwL5jtNwiBYRMp8
	014qw+NwLUj+20j8A396iNooQ5aocoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724992594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SC536qI5El1MUvSXzgfykOrzSLhPKmHkVPaGz3C2fsc=;
	b=iJXRcNI92tzpDorZGI0glfaAJRrNcakbR3n24uYja2eF0p3mIvBq5uNwPFvwG8lnX/Vccp
	Dh+Xuj9w8sd6p0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21C14136A4;
	Fri, 30 Aug 2024 04:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pi/0MU9M0WZENAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 04:36:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
In-reply-to: <95776943752608072e60f185e98f35a97175eecd.camel@kernel.org>
References: <>, <95776943752608072e60f185e98f35a97175eecd.camel@kernel.org>
Date: Fri, 30 Aug 2024 14:36:13 +1000
Message-id: <172499257359.4433.13078012410547323207@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 30 Aug 2024, Jeff Layton wrote:
> On Thu, 2024-08-29 at 12:52 -0400, Mike Snitzer wrote:
> > On Thu, Aug 29, 2024 at 12:40:27PM -0400, Jeff Layton wrote:
> > > On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > > > Introduce struct nfs_localio_ctx and the interfaces
> > > > nfs_localio_ctx_alloc() and nfs_localio_ctx_free().  The next commit
> > > > will introduce nfsd_open_local_fh() which returns a nfs_localio_ctx
> > > > structure.
> > > >=20
> > > > Also, expose localio's required NFSD symbols to NFS client:
> > > > - Cache nfsd_open_local_fh symbol and other required NFSD symbols in a
> > > >   globally accessible 'nfs_to' nfs_to_nfsd_t struct.  Add interfaces
> > > >   get_nfs_to_nfsd_symbols() and put_nfs_to_nfsd_symbols() to allow
> > > >   each NFS client to take a reference on NFSD symbols.
> > > >=20
> > > > - Apologies for the DEFINE_NFS_TO_NFSD_SYMBOL macro that makes
> > > >   defining get_##NFSD_SYMBOL() and put_##NFSD_SYMBOL() functions far
> > > >   simpler (and avoids cut-n-paste bugs, which is what motivated the
> > > >   development and use of a macro for this). But as C macros go it is a
> > > >   very simple one and there are many like it all over the kernel.
> > > >=20
> > > > - Given the unique nature of NFS LOCALIO being an optional feature
> > > >   that when used requires NFS share access to NFSD memory: a unique
> > > >   bridging of NFSD resources to NFS (via nfs_common) is needed.  But
> > > >   that bridge must be dynamic, hence the use of symbol_request() and
> > > >   symbol_put().  Proposed ideas to accomolish the same without using
> > > >   symbol_{request,put} would be far more tedious to implement and
> > > >   very likely no easier to review.  Anyway: sorry NeilBrown...
> > > >=20
> > > > - Despite the use of indirect function calls, caching these nfsd
> > > >   symbols for use by the client offers a ~10% performance win
> > > >   (compared to always doing get+call+put) for high IOPS workloads.
> > > >=20
> > > > - Introduce nfsd_file_file() wrapper that provides access to
> > > >   nfsd_file's backing file.  Keeps nfsd_file structure opaque to NFS
> > > >   client (as suggested by Jeff Layton).
> > > >=20
> > > > - The addition of nfsd_file_get, nfsd_file_put and nfsd_file_file
> > > >   symbols prepares for the NFS client to use nfsd_file for localio.
> > > >=20
> > > > Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs=
_to
> > > > Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  fs/nfs_common/nfslocalio.c | 159 +++++++++++++++++++++++++++++++++++=
++
> > > >  fs/nfsd/filecache.c        |  25 ++++++
> > > >  fs/nfsd/filecache.h        |   1 +
> > > >  fs/nfsd/nfssvc.c           |   5 ++
> > > >  include/linux/nfslocalio.h |  38 +++++++++
> > > >  5 files changed, 228 insertions(+)
> > > >=20
> > > > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > > > index 1a35a4a6dbe0..cc30fdb0cb46 100644
> > > > --- a/fs/nfs_common/nfslocalio.c
> > > > +++ b/fs/nfs_common/nfslocalio.c
> > > > @@ -72,3 +72,162 @@ bool nfs_uuid_is_local(const uuid_t *uuid, struct=
 net *net, struct auth_domain *
> > > >  	return is_local;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> > > > +
> > > > +/*
> > > > + * The nfs localio code needs to call into nfsd using various symbol=
s (below),
> > > > + * but cannot be statically linked, because that will make the nfs m=
odule
> > > > + * depend on the nfsd module.
> > > > + *
> > > > + * Instead, do dynamic linking to the nfsd module (via nfs_common mo=
dule). The
> > > > + * nfs_common module will only hold a reference on nfsd when localio=
 is in use.
> > > > + * This allows some sanity checking, like giving up on localio if nf=
sd isn't loaded.
> > > > + */
> > > > +static DEFINE_SPINLOCK(nfs_to_nfsd_lock);
> > > > +nfs_to_nfsd_t nfs_to;
> > > > +EXPORT_SYMBOL_GPL(nfs_to);
> > > > +
> > > > +/* Macro to define nfs_to get and put methods, avoids copy-n-paste b=
ugs */
> > > > +#define DEFINE_NFS_TO_NFSD_SYMBOL(NFSD_SYMBOL)		\
> > > > +static nfs_to_##NFSD_SYMBOL##_t get_##NFSD_SYMBOL(void)	\
> > > > +{							\
> > > > +	return symbol_request(NFSD_SYMBOL);		\
> > > > +}							\
> > > > +static void put_##NFSD_SYMBOL(void)			\
> > > > +{							\
> > > > +	symbol_put(NFSD_SYMBOL);			\
> > > > +	nfs_to.NFSD_SYMBOL =3D NULL;			\
> > > > +}
> > > > +
> > > > +/* The nfs localio code needs to call into nfsd to map filehandle ->=
 struct nfsd_file */
> > > > +extern struct nfs_localio_ctx *
> > > > +nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_cl=
nt *,
> > > > +		   const struct cred *, const struct nfs_fh *, const fmode_t);
> > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
> > > > +
> > > > +/* The nfs localio code needs to call into nfsd to acquire the nfsd_=
file */
> > > > +extern struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
> > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_get);
> > > > +
> > > > +/* The nfs localio code needs to call into nfsd to release the nfsd_=
file */
> > > > +extern void nfsd_file_put(struct nfsd_file *nf);
> > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_put);
> > > > +
> > > > +/* The nfs localio code needs to call into nfsd to access the nf->nf=
_file */
> > > > +extern struct file * nfsd_file_file(struct nfsd_file *nf);
> > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_file_file);
> > > > +
> > > > +/* The nfs localio code needs to call into nfsd to release nn->nfsd_=
serv */
> > > > +extern void nfsd_serv_put(struct nfsd_net *nn);
> > > > +DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_serv_put);
> > > > +#undef DEFINE_NFS_TO_NFSD_SYMBOL
> > > > +
> > >=20
> > > I have the same concerns as Neil did with this patch in v13. An ops
> > > structure that nfsd registers with nfs_common and that has pointers to
> > > all of these functions would be a lot cleaner. I think it'll end up
> > > being less code too.
> > >=20
> > > In fact, for that I'd probably break my usual guideline of not
> > > introducing new interfaces without callers, and just do a separate
> > > patch that adds the ops structure and sets up the handling of the
> > > pointer to it in nfs_common.
> >=20
> > OK, as much as it pains me to set aside proven code that I put a
> > decent amount of time to honing: I'll humor you guys and try to make
> > an ops structure workable. (we can always fall back to my approach if
> > I/we come up short).
> >=20
> > I'm just concerned about the optional use aspect.  There is the pain
> > point of how does NFS client come to _know_ NFSD loaded?  Using
> > symbol_request() deals with that nicely.
> >=20
>=20
> Have a pointer to a struct nfsd_localio_ops or something in the
> nfs_common module. That's initially set to NULL. Then, have a static
> structure of that type in nfsd.ko, and have its __init routine set the
> pointer in nfs_common to point to the right structure. The __exit
> routine will later set it to NULL.
>=20
> > I really don't want all calls in NFS client (or nfs_common) to have to
> > first check if nfs_common's 'nfs_to' ops structure is NULL or not.
>=20
> Neil seems to think that's not necessary:
>=20
> "If nfs/localio holds an auth_domain, then it implicitly holds a
> reference to the nfsd module and the functions cannot disappear."

On reflection that isn't quite right, but it is the sort of approach
that I think we need to take.
There are several things that the NFS client needs to hold one to.

1/ It needs a reference to the nfsd module (or symbols in the module).
   I think this can be held long term but we need a clear mechanism for
   it to be dropped.
2/ It needs a reference to the nfsd_serv which it gets through the
   'struct net' pointer.  I've posted patches to handle that better.
3/ It needs a reference to an auth_domain.  This can safely be a long
   term reference.  It can already be invalidated and the code to free
   it is in sunrpc which nfs already pins.  Any delay in freeing it only
   wastes memory (not much), it doesn't impact anything else.
4/ It needs a reference to the nfsd_file and/or file.  This is currently
   done only while the ref to the nfsd_serv is held, so I think there is
   no problem there.

So possibly we could take a reference to the nfsd module whenever we
store a net in nfs_uuid. and drop the ref whenever we clear that.

That means we cannot call nfsd_open_local_fh() without first getting a
ref on the nfsd_serv which my latest code doesn't do.  That is easily
fixed.  I'll send a patch for consideration...

Thanks,
NeilBrown

