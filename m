Return-Path: <linux-fsdevel+bounces-28453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BF96AC3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 00:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2001E1F24E3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878B1B9827;
	Tue,  3 Sep 2024 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sB55t5a5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PUj7Hs/z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sB55t5a5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PUj7Hs/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28271186E30;
	Tue,  3 Sep 2024 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725402716; cv=none; b=PaR3tsE0hLJhWbrUKCehfRLSmswz9WNXzw8pU8yf4SnvkKNTS223N3t250QuMCrPA1GRn84iXFBvbey86Yi8tbPgKLm5+bR8harnVQTceyzujxd/YWAe8cZrmnqAHmElHQPpYlCpg4ShjrQMuWMsD0q5pH4NaFB5py79g2auHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725402716; c=relaxed/simple;
	bh=tZRii2t15TCwzU2o1OeoZFDuiKLfEaCqU2xlDnpUKq4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LUMkHPgH5IkLw4mU1N/hloG3YaNexafKw5BspG0Iy4jBSN8qF+Xk3rgB2YdnsDAE4cyr+mOl8+SVoZIuv0LdEuJ+UQ1kWyymejwxNaxPsJorWEqz4PLF3oLuzDpRXUi+7KpaRNQacRcf8zc7O/uc8fOGPT13ptSdtufKBM1inE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sB55t5a5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PUj7Hs/z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sB55t5a5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PUj7Hs/z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DF9521A14;
	Tue,  3 Sep 2024 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725402712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep78Toqo+zCMq74UO3n8I1Kl0N5WozDFqpve9fvywnM=;
	b=sB55t5a5bUo6cqnxmIQzvkmUEylhsbY0SQhdlabAo8H4m7dHm/06trnlWARLN2YhIUOgT6
	hrs9BjSr9BwI2YNPEtkhstSkbBvdEKk6CyMm5BfEssprk0A3gwEd03Oxz9gupSCAWymXpo
	U/ucuOQW9wUuV5g6aR9i4r06g4RltMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725402712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep78Toqo+zCMq74UO3n8I1Kl0N5WozDFqpve9fvywnM=;
	b=PUj7Hs/z2Ql6KZ4sdYSJjICVTcQWrKMnfHWQoHnk0WbrC0SVMIaz9Yng0jeFVq+/PavTpe
	ozNGaVDoC3iXN4AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sB55t5a5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="PUj7Hs/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725402712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep78Toqo+zCMq74UO3n8I1Kl0N5WozDFqpve9fvywnM=;
	b=sB55t5a5bUo6cqnxmIQzvkmUEylhsbY0SQhdlabAo8H4m7dHm/06trnlWARLN2YhIUOgT6
	hrs9BjSr9BwI2YNPEtkhstSkbBvdEKk6CyMm5BfEssprk0A3gwEd03Oxz9gupSCAWymXpo
	U/ucuOQW9wUuV5g6aR9i4r06g4RltMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725402712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep78Toqo+zCMq74UO3n8I1Kl0N5WozDFqpve9fvywnM=;
	b=PUj7Hs/z2Ql6KZ4sdYSJjICVTcQWrKMnfHWQoHnk0WbrC0SVMIaz9Yng0jeFVq+/PavTpe
	ozNGaVDoC3iXN4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44FCC139D5;
	Tue,  3 Sep 2024 22:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mwWWNlSO12b8YAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 03 Sep 2024 22:31:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
In-reply-to: <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>
References: <>, <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>
Date: Wed, 04 Sep 2024 08:31:41 +1000
Message-id: <172540270112.4433.6741926579586461095@noble.neil.brown.name>
X-Rspamd-Queue-Id: 3DF9521A14
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 04 Sep 2024, Chuck Lever III wrote:
>=20
>=20
> > On Sep 3, 2024, at 11:29=E2=80=AFAM, Mike Snitzer <snitzer@kernel.org> wr=
ote:
> >=20
> > On Tue, Sep 03, 2024 at 11:19:45AM -0400, Jeff Layton wrote:
> >> On Tue, 2024-09-03 at 11:00 -0400, Mike Snitzer wrote:
> >>> On Tue, Sep 03, 2024 at 10:40:28AM -0400, Jeff Layton wrote:
> >>>> On Tue, 2024-09-03 at 10:34 -0400, Chuck Lever wrote:
> >>>>> On Sat, Aug 31, 2024 at 06:37:36PM -0400, Mike Snitzer wrote:
> >>>>>> From: Weston Andros Adamson <dros@primarydata.com>
> >>>>>>=20
> >>>>>> Add server support for bypassing NFS for localhost reads, writes, and
> >>>>>> commits. This is only useful when both the client and server are
> >>>>>> running on the same host.
> >>>>>>=20
> >>>>>> If nfsd_open_local_fh() fails then the NFS client will both retry and
> >>>>>> fallback to normal network-based read, write and commit operations if
> >>>>>> localio is no longer supported.
> >>>>>>=20
> >>>>>> Care is taken to ensure the same NFS security mechanisms are used
> >>>>>> (authentication, etc) regardless of whether localio or regular NFS
> >>>>>> access is used.  The auth_domain established as part of the traditio=
nal
> >>>>>> NFS client access to the NFS server is also used for localio.  Store
> >>>>>> auth_domain for localio in nfsd_uuid_t and transfer it to the client
> >>>>>> if it is local to the server.
> >>>>>>=20
> >>>>>> Relative to containers, localio gives the client access to the netwo=
rk
> >>>>>> namespace the server has.  This is required to allow the client to
> >>>>>> access the server's per-namespace nfsd_net struct.
> >>>>>>=20
> >>>>>> This commit also introduces the use of NFSD's percpu_ref to interlock
> >>>>>> nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> >>>>>> not destroyed while in use by nfsd_open_local_fh and other LOCALIO
> >>>>>> client code.
> >>>>>>=20
> >>>>>> CONFIG_NFS_LOCALIO enables NFS server support for LOCALIO.
> >>>>>>=20
> >>>>>> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> >>>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>>>> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> >>>>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >>>>>> Co-developed-by: NeilBrown <neilb@suse.de>
> >>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
> >>>>>>=20
> >>>>>> Not-Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >>>>>> Not-Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>>>>> ---
> >>>>>> fs/nfsd/Makefile           |   1 +
> >>>>>> fs/nfsd/filecache.c        |   2 +-
> >>>>>> fs/nfsd/localio.c          | 112 +++++++++++++++++++++++++++++++++++=
++
> >>>>>> fs/nfsd/netns.h            |   4 ++
> >>>>>> fs/nfsd/nfsctl.c           |  25 ++++++++-
> >>>>>> fs/nfsd/trace.h            |   3 +-
> >>>>>> fs/nfsd/vfs.h              |   2 +
> >>>>>> include/linux/nfslocalio.h |   8 +++
> >>>>>> 8 files changed, 154 insertions(+), 3 deletions(-)
> >>>>>> create mode 100644 fs/nfsd/localio.c
> >>>>>>=20
> >>>>>> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> >>>>>> index b8736a82e57c..18cbd3fa7691 100644
> >>>>>> --- a/fs/nfsd/Makefile
> >>>>>> +++ b/fs/nfsd/Makefile
> >>>>>> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
> >>>>>> nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >>>>>> nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >>>>>> nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilelay=
outxdr.o
> >>>>>> +nfsd-$(CONFIG_NFS_LOCALIO) +=3D localio.o
> >>>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> >>>>>> index 89ff380ec31e..348c1b97092e 100644
> >>>>>> --- a/fs/nfsd/filecache.c
> >>>>>> +++ b/fs/nfsd/filecache.c
> >>>>>> @@ -52,7 +52,7 @@
> >>>>>> #define NFSD_FILE_CACHE_UP      (0)
> >>>>>>=20
> >>>>>> /* We only care about NFSD_MAY_READ/WRITE for this cache */
> >>>>>> -#define NFSD_FILE_MAY_MASK (NFSD_MAY_READ|NFSD_MAY_WRITE)
> >>>>>> +#define NFSD_FILE_MAY_MASK (NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_L=
OCALIO)
> >>>>>>=20
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
> >>>>>> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.=
com>
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
> >>>>>> +static const struct nfsd_localio_operations nfsd_localio_ops =3D {
> >>>>>> + .nfsd_open_local_fh =3D nfsd_open_local_fh,
> >>>>>> + .nfsd_file_put_local =3D nfsd_file_put_local,
> >>>>>> + .nfsd_file_file =3D nfsd_file_file,
> >>>>>> +};
> >>>>>> +
> >>>>>> +void nfsd_localio_ops_init(void)
> >>>>>> +{
> >>>>>> + memcpy(&nfs_to, &nfsd_localio_ops, sizeof(nfsd_localio_ops));
> >>>>>> +}
> >>>>>=20
> >>>>> Same comment as Neil: this should surface a pointer to the
> >>>>> localio_ops struct. Copying the whole set of function pointers is
> >>>>> generally unnecessary.
> >>>>>=20
> >>>>>=20
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map t=
o nfsd_file
> >>>>>> + *
> >>>>>> + * @uuid: nfs_uuid_t which provides the 'struct net' to get the pro=
per nfsd_net
> >>>>>> + *        and the 'struct auth_domain' required for LOCALIO access
> >>>>>> + * @rpc_clnt: rpc_clnt that the client established, used for sockad=
dr and cred
> >>>>>> + * @cred: cred that the client established
> >>>>>> + * @nfs_fh: filehandle to lookup
> >>>>>> + * @fmode: fmode_t to use for open
> >>>>>> + *
> >>>>>> + * This function maps a local fh to a path on a local filesystem.
> >>>>>> + * This is useful when the nfs client has the local server mounted =
- it can
> >>>>>> + * avoid all the NFS overhead with reads, writes and commits.
> >>>>>> + *
> >>>>>> + * On successful return, returned nfsd_file will have its nf_net me=
mber
> >>>>>> + * set. Caller (NFS client) is responsible for calling nfsd_serv_pu=
t and
> >>>>>> + * nfsd_file_put (via nfs_to.nfsd_file_put_local).
> >>>>>> + */
> >>>>>> +struct nfsd_file *
> >>>>>> +nfsd_open_local_fh(nfs_uuid_t *uuid,
> >>>>>> +    struct rpc_clnt *rpc_clnt, const struct cred *cred,
> >>>>>> +    const struct nfs_fh *nfs_fh, const fmode_t fmode)
> >>>>>> + __must_hold(rcu)
> >>>>>> +{
> >>>>>> + int mayflags =3D NFSD_MAY_LOCALIO;
> >>>>>> + struct nfsd_net *nn =3D NULL;
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
> >>>>>> +  * Not running in nfsd context, so must safely get reference on nf=
sd_serv.
> >>>>>> +  * But the server may already be shutting down, if so disallow new=
 localio.
> >>>>>> +  * uuid->net is NOT a counted reference, but caller's rcu_read_loc=
k() ensures
> >>>>>> +  * that if uuid->net is not NULL, then calling nfsd_serv_try_get()=
 is safe
> >>>>>> +  * and if it succeeds we will have an implied reference to the net.
> >>>>>> +  */
> >>>>>> + net =3D rcu_dereference(uuid->net);
> >>>>>> + if (net)
> >>>>>> + nn =3D net_generic(net, nfsd_net_id);
> >>>>>> + if (unlikely(!nn || !nfsd_serv_try_get(nn)))
> >>>>>> + return ERR_PTR(-ENXIO);
> >>>>>> +
> >>>>>> + /* Drop the rcu lock for nfsd_file_acquire_local() */
> >>>>>> + rcu_read_unlock();
> >>>>>=20
> >>>>> I'm struggling with the locking logistics. Caller takes the RCU read
> >>>>> lock, this function drops the lock, then takes it again. So:
> >>>>>=20
> >>>>> - A caller might rely on the lock being held continuously, but
> >>>>> - The API contract documented above doesn't indicate that this
> >>>>>   function drops that lock
> >>>>> - The __must_hold(rcu) annotation doesn't indicate that this
> >>>>>   function drops that lock, IIUC
> >>>>>=20
> >>>>> Dropping and retaking the lock in here is an anti-pattern that
> >>>>> should be avoided. I suggest we are better off in the long run if
> >>>>> the caller does not need to take the RCU read lock, but instead,
> >>>>> nfsd_open_local_fh takes it right here just for the rcu_dereference.
> >>>=20
> >>> I thought so too when I first saw how Neil approached fixing this to
> >>> be safe.  It was only after putting further time to it (and having the
> >>> benefit of being so close to all this) that I realized the nuance at
> >>> play (please see my reply to Jeff below for the nuance I'm speaking
> >>> of).=20
> >>>=20
> >>>>>=20
> >>>>> OTOH, Why drop the lock before calling nfsd_file_acquire_local()?
> >>>>> The RCU read lock can safely be taken more than once in succession.
> >>>>>=20
> >>>>> Let's rethink the locking strategy.
> >>>>>=20
> >>>=20
> >>> Yes, _that_ is a very valid point.  I did wonder the same: it seems
> >>> perfectly fine to simply retain the RCU throughout the entirety of
> >>> nfsd_open_local_fh().
> >>>=20
> >>=20
> >> Nope. nfsd_file_do_acquire can allocate, so you can't hold the
> >> rcu_read_lock over the whole thing.
> >=20
> > Ah, yeap.. sorry, I knew that ;)
> >=20
> >>>> Agreed. The only caller does this:
> >>>>=20
> >>>>        rcu_read_lock();
> >>>>        if (!rcu_access_pointer(uuid->net)) {
> >>>>                rcu_read_unlock();
> >>>>                return ERR_PTR(-ENXIO);
> >>>>        }
> >>>>        localio =3D nfs_to.nfsd_open_local_fh(uuid, rpc_clnt, cred,
> >>>>                                            nfs_fh, fmode);
> >>>>        rcu_read_unlock();
> >>>>=20
> >>>> Maybe just move the check for uuid->net down into nfsd_open_local_fh,
> >>>> and it can acquire the rcu_read_lock for itself?
> >>>=20
> >>> No, sorry we cannot.  The call to nfs_to.nfsd_open_local_fh (which is
> >>> a symbol provided by nfsd) is only safe if the RCU protected pre-check
> >>> shows the uuid->net valid.
> >>=20
> >> Ouch, ok.
> >=20
> > I had to double check but I did add a comment that speaks directly to
> > this "nuance" above the code you quoted:
> >=20
> >        /*
> >         * uuid->net must not be NULL, otherwise NFS may not have ref
> >         * on NFSD and therefore cannot safely make 'nfs_to' calls.
> >         */
> >=20
> > So yeah, this code needs to stay like this.  The __must_hold(rcu) just
> > ensures the RCU is held on entry and exit.. the bouncing of RCU
> > (dropping and retaking) isn't of immediate concern is it?  While I
> > agree it isn't ideal, it is what it is given:
> > 1) NFS caller of NFSD symbol is only safe if it has RCU amd verified
> >   uuid->net valid
> > 2) nfsd_file_do_acquire() can allocate.
>=20
> OK, understood, but the annotation is still wrong. The lock
> is dropped here so I think you need __releases and __acquires
> in that case. However...
>=20
> Let's wait for Neil's comments, but I think this needs to be
> properly addressed before merging. The comments are not going
> to be enough IMO.

I don't have much to add.  Mike's description of the locking requirement
(nfs.to.foo need to be safe) and Jeff's confirmation that we cannot hold
rcu across getting the nfsd_file are exactly what I would have said.

I agree that dropping and reclaiming a lock is an anti-pattern and in
best avoided in general.  I cannot see a better alternative in this
case.

According to Documentation/dev-tools/sparse.txt:

__must_hold - The specified lock is held on function entry and exit.

__acquires - The specified lock is held on function exit, but not entry.

__releases - The specified lock is held on function entry, but not exit.

only __must_hold applies.  But maybe sparse.txt is wrong.

static struct bpf_local_storage_elem *
bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *inf=
o,
				 struct bpf_local_storage_elem *prev_selem)
	__acquires(RCU) __releases(RCU)

gives a counter example.  Maybe we should copy that as you say.  Maybe
we should fix sparse.txt too.

NeilBrown

