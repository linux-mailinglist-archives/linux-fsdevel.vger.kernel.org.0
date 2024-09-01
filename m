Return-Path: <linux-fsdevel+bounces-28190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11034967CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 01:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B46C1C20D58
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 23:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD3C14E2FA;
	Sun,  1 Sep 2024 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0lZaSpC0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6GtGZX5C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0lZaSpC0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6GtGZX5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810126F2F3;
	Sun,  1 Sep 2024 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725234429; cv=none; b=ANWGhV/+Dp0v9uYMSGowEpp4bgnlrNTK2s+vOFS0s5legraIEEKRrVnWhypw6SzPOg5oBRZhBTQpFvaM8pIjJyjVS9oiqP8E8zsGy2hLhI/p4iiNZOVQMuXY9njJmjwBoW/1UZv7+lqJjqceTL+Ku9AHdCwj9VrjVywlmCuLxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725234429; c=relaxed/simple;
	bh=PY3leBEpdE8WDVzO/KAUtEmoRirOGSJ3TuR3Tp85z7Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KaTASaMlv2YzNflpjNSLlrX8jjP3q6mPug9t0oB6ojHjlDRbcQeSeBgMElsozcOhrdP6Bt7kAGzR4Tr9lSV4+v+6nLu7Ynm6ngDaRn86OcCuhJO1uO2f2eeBjQ/uIYDu2IqwR3ltq0tZ2p0ia5c3jAFC/ajAvRBKc0INShtFKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0lZaSpC0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6GtGZX5C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0lZaSpC0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6GtGZX5C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BCFC1FB79;
	Sun,  1 Sep 2024 23:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725234425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI+xad2vDdEPIsfiArLsVgH5Ak4uP4qfIGS1Vuu5X5A=;
	b=0lZaSpC0Fs0f9mT+Vie3ifcmInwmQwtLNd1efF77PvjBn/w/zQuS7L+EC1WUtasrUwKMMA
	fCElxsUqVXRfVx2TB5Yzu1ih1KBGh27C0bdx13DzyZFkdwsf8Q8R8/HWqOORKvY4Dadm5V
	Lyy2Yf9jJF5QKiVAjFu9m7TVc53mZQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725234425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI+xad2vDdEPIsfiArLsVgH5Ak4uP4qfIGS1Vuu5X5A=;
	b=6GtGZX5CrzAFdSuXUCj6Iq3rZQGOWqxG3eBqK/gHQZBuDb4HWUjbJ3OGYPlgMPvOm7FdD6
	KhRAqTvh8gvGpNDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0lZaSpC0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6GtGZX5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725234425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI+xad2vDdEPIsfiArLsVgH5Ak4uP4qfIGS1Vuu5X5A=;
	b=0lZaSpC0Fs0f9mT+Vie3ifcmInwmQwtLNd1efF77PvjBn/w/zQuS7L+EC1WUtasrUwKMMA
	fCElxsUqVXRfVx2TB5Yzu1ih1KBGh27C0bdx13DzyZFkdwsf8Q8R8/HWqOORKvY4Dadm5V
	Lyy2Yf9jJF5QKiVAjFu9m7TVc53mZQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725234425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI+xad2vDdEPIsfiArLsVgH5Ak4uP4qfIGS1Vuu5X5A=;
	b=6GtGZX5CrzAFdSuXUCj6Iq3rZQGOWqxG3eBqK/gHQZBuDb4HWUjbJ3OGYPlgMPvOm7FdD6
	KhRAqTvh8gvGpNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED1D81373A;
	Sun,  1 Sep 2024 23:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pZ3zJ/b81GZVMQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 01 Sep 2024 23:47:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
In-reply-to: <20240831223755.8569-17-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>,
 <20240831223755.8569-17-snitzer@kernel.org>
Date: Mon, 02 Sep 2024 09:46:59 +1000
Message-id: <172523441999.4433.11827614117615125531@noble.neil.brown.name>
X-Rspamd-Queue-Id: 5BCFC1FB79
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
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 01 Sep 2024, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> Add server support for bypassing NFS for localhost reads, writes, and
> commits. This is only useful when both the client and server are
> running on the same host.
>=20
> If nfsd_open_local_fh() fails then the NFS client will both retry and
> fallback to normal network-based read, write and commit operations if
> localio is no longer supported.
>=20
> Care is taken to ensure the same NFS security mechanisms are used
> (authentication, etc) regardless of whether localio or regular NFS
> access is used.  The auth_domain established as part of the traditional
> NFS client access to the NFS server is also used for localio.  Store
> auth_domain for localio in nfsd_uuid_t and transfer it to the client
> if it is local to the server.
>=20
> Relative to containers, localio gives the client access to the network
> namespace the server has.  This is required to allow the client to
> access the server's per-namespace nfsd_net struct.
>=20
> This commit also introduces the use of NFSD's percpu_ref to interlock
> nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> not destroyed while in use by nfsd_open_local_fh and other LOCALIO
> client code.
>=20
> CONFIG_NFS_LOCALIO enables NFS server support for LOCALIO.
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Co-developed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> Not-Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Not-Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/Makefile           |   1 +
>  fs/nfsd/filecache.c        |   2 +-
>  fs/nfsd/localio.c          | 112 +++++++++++++++++++++++++++++++++++++
>  fs/nfsd/netns.h            |   4 ++
>  fs/nfsd/nfsctl.c           |  25 ++++++++-
>  fs/nfsd/trace.h            |   3 +-
>  fs/nfsd/vfs.h              |   2 +
>  include/linux/nfslocalio.h |   8 +++
>  8 files changed, 154 insertions(+), 3 deletions(-)
>  create mode 100644 fs/nfsd/localio.c
>=20
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..18cbd3fa7691 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilelayoutxdr=
.o
> +nfsd-$(CONFIG_NFS_LOCALIO) +=3D localio.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 89ff380ec31e..348c1b97092e 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -52,7 +52,7 @@
>  #define NFSD_FILE_CACHE_UP		     (0)
> =20
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
> =20
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..75df709c6903
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS server support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + * Copyright (C) 2024 NeilBrown <neilb@suse.de>
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/sunrpc/svcauth.h>
> +#include <linux/sunrpc/clnt.h>
> +#include <linux/nfs.h>
> +#include <linux/nfs_common.h>
> +#include <linux/nfslocalio.h>
> +#include <linux/string.h>
> +
> +#include "nfsd.h"
> +#include "vfs.h"
> +#include "netns.h"
> +#include "filecache.h"
> +
> +static const struct nfsd_localio_operations nfsd_localio_ops =3D {
> +	.nfsd_open_local_fh =3D nfsd_open_local_fh,
> +	.nfsd_file_put_local =3D nfsd_file_put_local,
> +	.nfsd_file_file =3D nfsd_file_file,
> +};
> +
> +void nfsd_localio_ops_init(void)
> +{
> +	memcpy(&nfs_to, &nfsd_localio_ops, sizeof(nfsd_localio_ops));
> +}

Why isn't this
   nfs_to =3D &nfsd_loclaio_ops;
??

Why do we copy all the pointers in the struct instead of just the
pointer to the struct?
Is this to avoid an extra dereference?  If so we need an in-code comment
explaining this optimisation - and why we need it while most used of
_operations structures don't.


> =20
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +/**
> + * nfsd_net_pre_exit - Disconnect localio clients from net namespace
> + * @net: a network namespace that is about to be destroyed
> + *
> + * This invalidated ->net pointers held by localio clients
> + * while they can still safely access nn->counter.
> + */
> +static __net_exit void nfsd_net_pre_exit(struct net *net)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +
> +	nfs_uuid_invalidate_clients(&nn->local_clients);
> +}
> +#endif
> +
>  /**
>   * nfsd_net_exit - Release the nfsd_net portion of a net namespace
>   * @net: a network namespace that is about to be destroyed
> @@ -2285,6 +2304,9 @@ static __net_exit void nfsd_net_exit(struct net *net)
> =20
>  static struct pernet_operations nfsd_net_ops =3D {
>  	.init =3D nfsd_net_init,
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	.pre_exit =3D nfsd_net_pre_exit,
> +#endif

I would rather that these #ifs were not here, but that in the
NFS_LOCALIO disabled case, nfs_uuid_invalidate_clients() were an empty
static inline function.

I think that code of .pre_exit sometime being an empty function is not
significant.

Section 21 of codiing-style.  Or maybe section 20, depending on release
(there is a new section on "Using bool").

https://www.kernel.org/doc/html/v4.14/process/coding-style.html#conditional-c=
ompilation

NeilBrown

