Return-Path: <linux-fsdevel+bounces-27962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886E96534F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 01:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3304F283659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 23:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0D21BA895;
	Thu, 29 Aug 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IScwE0J5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q4kEuAOa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IScwE0J5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q4kEuAOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6C156F41;
	Thu, 29 Aug 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973057; cv=none; b=EnUm0gUxHzHR7iT5nOguQ8MLKGkR4obe4YGJ0vuJuVZgX/jqCxG1iF1rF2cEsMFolZyUzH6rgiTGo5YLnxrsRVVDo0yF2FFhEPa4bWbltygQwh+J6cA2ZQ3Eph0aWWLOPlUi2dNdp/a51rZEU4RS1xofldziiKVDq09zNF78EJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973057; c=relaxed/simple;
	bh=cNtrDwT0JvW+4p5qWUsTWhm94BhFpTPwKrl4XKNu8V8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XTkQ7ZkMnEFsa0ZmAAOw2tIe8FYtf3B/FYkdqKOIetYBFDRKJba3HWF9zRmBoNGY/l6xG8yRsGTm9f2QVWcn5b3UUgAPDIlZWndFD86QVNg57egjAECzpFEncCJMzeOh/V597dUv4QkWjZfMKEqBncsewR9QjADaY4wi/f3lKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IScwE0J5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q4kEuAOa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IScwE0J5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q4kEuAOa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 369961F769;
	Thu, 29 Aug 2024 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724973053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OB80+4/K2f6OnknK91W1WXWmMZPn3a22YftPNUfWLK0=;
	b=IScwE0J5vqTAWenPgh0aLdp+bYAiuD7ENdh3IUymgxR6jHFRKQuIZcHVABDIJ1j2XjsHf/
	RkAZjMeCI6Hhbvuq9PvZuLomISr2GJVrZbcOqCTGJkzDc4HHjyf85x6gDlX5i/XgdCQx7b
	i6q5btqMMhIWX78iCrr6mjV3w80PwMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724973053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OB80+4/K2f6OnknK91W1WXWmMZPn3a22YftPNUfWLK0=;
	b=q4kEuAOaCw6zgio3fX/tzKAX66dbAmoZh+0oyMaVrOZE+mQwJaQP3AxIEdmPCr0Tl8rasa
	kVQF+n6aUyEw3xCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IScwE0J5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q4kEuAOa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724973053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OB80+4/K2f6OnknK91W1WXWmMZPn3a22YftPNUfWLK0=;
	b=IScwE0J5vqTAWenPgh0aLdp+bYAiuD7ENdh3IUymgxR6jHFRKQuIZcHVABDIJ1j2XjsHf/
	RkAZjMeCI6Hhbvuq9PvZuLomISr2GJVrZbcOqCTGJkzDc4HHjyf85x6gDlX5i/XgdCQx7b
	i6q5btqMMhIWX78iCrr6mjV3w80PwMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724973053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OB80+4/K2f6OnknK91W1WXWmMZPn3a22YftPNUfWLK0=;
	b=q4kEuAOaCw6zgio3fX/tzKAX66dbAmoZh+0oyMaVrOZE+mQwJaQP3AxIEdmPCr0Tl8rasa
	kVQF+n6aUyEw3xCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F317139B0;
	Thu, 29 Aug 2024 23:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5RgUDfr/0GadYgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 29 Aug 2024 23:10:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 16/25] nfsd: add localio support
In-reply-to: <ZtCbZtHG3iKqWIkF@tissot.1015granger.net>
References: <>, <ZtCbZtHG3iKqWIkF@tissot.1015granger.net>
Date: Fri, 30 Aug 2024 09:10:38 +1000
Message-id: <172497303821.4433.13901820641101888326@noble.neil.brown.name>
X-Rspamd-Queue-Id: 369961F769
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 30 Aug 2024, Chuck Lever wrote:
> On Wed, Aug 28, 2024 at 09:04:11PM -0400, Mike Snitzer wrote:
> > From: Weston Andros Adamson <dros@primarydata.com>
> >=20
> > Add server support for bypassing NFS for localhost reads, writes, and
> > commits. This is only useful when both the client and server are
> > running on the same host.
> >=20
> > If nfsd_open_local_fh() fails then the NFS client will both retry and
> > fallback to normal network-based read, write and commit operations if
> > localio is no longer supported.
> >=20
> > Care is taken to ensure the same NFS security mechanisms are used
> > (authentication, etc) regardless of whether localio or regular NFS
> > access is used.  The auth_domain established as part of the traditional
> > NFS client access to the NFS server is also used for localio.  Store
> > auth_domain for localio in nfsd_uuid_t and transfer it to the client
> > if it is local to the server.
> >=20
> > Relative to containers, localio gives the client access to the network
> > namespace the server has.  This is required to allow the client to
> > access the server's per-namespace nfsd_net struct.
> >=20
> > CONFIG_NFSD_LOCALIO controls the server enablement for localio.
> > A later commit will add CONFIG_NFS_LOCALIO to allow the client
> > enablement.
> >=20
> > This commit also introduces the use of nfsd's percpu_ref to interlock
> > nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> > not destroyed while in use by nfsd_open_local_fh, and warrants a more
> > detailed explanation:
> >=20
> > nfsd_open_local_fh uses nfsd_serv_try_get before opening its file
> > handle and then the reference must be dropped by the caller using
> > nfsd_serv_put (via nfs_localio_ctx_free).
> >=20
> > This "interlock" working relies heavily on nfsd_open_local_fh()'s
> > maybe_get_net() safely dealing with the possibility that the struct
> > net (and nfsd_net by association) may have been destroyed by
> > nfsd_destroy_serv() via nfsd_shutdown_net().
> >=20
> > Verified to fix an easy to hit crash that would occur if an nfsd
> > instance running in a container, with a localio client mounted, is
> > shutdown. Upon restart of the container and associated nfsd the client
> > would go on to crash due to NULL pointer dereference that occuured due
> > to the nfs client's localio attempting to nfsd_open_local_fh(), using
> > nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
> >=20
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
> >=20
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index a46b0cbc4d8f..1b8a5edbddff 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
> >  	tristate
> >  	select FS_POSIX_ACL
> > =20
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
> > =20
> >  	  If unsure, say N.
> > =20
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
> > =20
> > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > index b8736a82e57c..78b421778a79 100644
> > --- a/fs/nfsd/Makefile
> > +++ b/fs/nfsd/Makefile
> > @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
> >  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilelayoutx=
dr.o
> > +nfsd-$(CONFIG_NFSD_LOCALIO) +=3D localio.o
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index a83d469bca6b..49f4aab3208a 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -53,7 +53,7 @@
> >  #define NFSD_FILE_CACHE_UP		     (0)
> > =20
> >  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> > -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> > +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALI=
O)
> > =20
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
> > + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfs=
d_file
> > + *
> > + * @cl_nfssvc_net: the 'struct net' to use to get the proper nfsd_net
> > + * @cl_nfssvc_dom: the 'struct auth_domain' required for localio access
> > + * @rpc_clnt: rpc_clnt that the client established, used for sockaddr an=
d cred
> > + * @cred: cred that the client established
> > + * @nfs_fh: filehandle to lookup
> > + * @fmode: fmode_t to use for open
> > + *
> > + * This function maps a local fh to a path on a local filesystem.
> > + * This is useful when the nfs client has the local server mounted - it =
can
> > + * avoid all the NFS overhead with reads, writes and commits.
> > + *
> > + * On successful return, returned nfs_localio_ctx will have its nfsd_fil=
e and
> > + * nfsd_net members set. Caller is responsible for calling nfsd_file_put=
 and
> > + * nfsd_serv_put (via nfs_localio_ctx_free).
> > + */
> > +struct nfs_localio_ctx *
> > +nfsd_open_local_fh(struct net *cl_nfssvc_net, struct auth_domain *cl_nfs=
svc_dom,
> > +		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> > +		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> > +{
> > +	int mayflags =3D NFSD_MAY_LOCALIO;
> > +	int status =3D 0;
> > +	struct nfsd_net *nn;
> > +	struct svc_cred rq_cred;
> > +	struct svc_fh fh;
> > +	struct nfs_localio_ctx *localio;
> > +	__be32 beres;
> > +
> > +	if (nfs_fh->size > NFS4_FHSIZE)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	localio =3D nfs_localio_ctx_alloc();
> > +	if (!localio)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	/*
> > +	 * Not running in nfsd context, so must safely get reference on nfsd_se=
rv.
> > +	 * But the server may already be shutting down, if so disallow new loca=
lio.
> > +	 */
> > +	nn =3D net_generic(cl_nfssvc_net, nfsd_net_id);
> > +	if (unlikely(!nfsd_serv_try_get(nn))) {
> > +		status =3D -ENXIO;
> > +		goto out_nfsd_serv;
> > +	}
> > +
> > +	/* nfs_fh -> svc_fh */
> > +	fh_init(&fh, NFS4_FHSIZE);
> > +	fh.fh_handle.fh_size =3D nfs_fh->size;
> > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > +
> > +	if (fmode & FMODE_READ)
> > +		mayflags |=3D NFSD_MAY_READ;
> > +	if (fmode & FMODE_WRITE)
> > +		mayflags |=3D NFSD_MAY_WRITE;
> > +
> > +	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> > +
> > +	beres =3D nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, cl_nfssvc_do=
m,
> > +					&fh, mayflags, &localio->nf);
> > +	if (beres) {
> > +		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> > +		goto out_fh_put;
> > +	}
> > +	localio->nn =3D nn;
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
> > +static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typ=
echeck =3D nfsd_open_local_fh;
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
> > =20
> >  TRACE_EVENT(nfsd_compound,
> >  	TP_PROTO(
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index 01947561d375..e12310dd5f4c 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -33,6 +33,8 @@
> > =20
> >  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >=3D=
 NFSv3 */
> > =20
> > +#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio u=
sed */
> > +
> >  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> >  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
> > =20
> > @@ -158,6 +160,11 @@ __be32		nfsd_permission(struct svc_cred *cred, struc=
t svc_export *exp,
> > =20
> >  void		nfsd_filp_close(struct file *fp);
> > =20
> > +struct nfs_localio_ctx *
> > +nfsd_open_local_fh(struct net *, struct auth_domain *,
> > +		   struct rpc_clnt *, const struct cred *,
> > +		   const struct nfs_fh *, const fmode_t);
> > +
> >  static inline int fh_want_write(struct svc_fh *fh)
> >  {
> >  	int ret;
> > --=20
> > 2.44.0
> >=20
>=20
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> I think I've looked at all the server-side changes now. I don't see
> any issues that block merging this series.
>=20
> Two follow-ups:
>=20
> I haven't heard an answer to my question about how export options
> that translate RPC user IDs might behave for LOCALIO operations
> (eg. root_squash, all_squash). Test results, design points,
> NEEDS_WORK, etc.

Export options that translate user IDs are managed by nfsd_setuser()
which is called by nfsd_setuser_and_check_port() which is called by
__fh_verify().  So they get handled exactly the same way for LOCALIO as
they do for WIRE-IO.

NeilBrown


>=20
> Someone should try out the trace points that we neutered in
> fh_verify() before this set gets applied.
>=20
>=20
> --=20
> Chuck Lever
>=20


