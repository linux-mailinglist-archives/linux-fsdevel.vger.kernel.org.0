Return-Path: <linux-fsdevel+bounces-27976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F869656F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 07:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC570284E0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8A13BAFA;
	Fri, 30 Aug 2024 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NGyUnB9d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ilmmJZqf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QDntRucj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0OLpF3+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9681509BF;
	Fri, 30 Aug 2024 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996057; cv=none; b=G16frLhuZM37uJE5fYtCWkRWTTQwEGfaTD4/XuNBqdOyo23u1WONnd7V6g1e7K+R28CG8cFTwYRefgkTkVXLzST6Nv/edFA6TCbZUmDmgpO5RkZjpfkQSMJa7T1IPtVvhaKs6ZCsSwnraH6U3KbCCRzfkTaE6kuz/9LBEjSNhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996057; c=relaxed/simple;
	bh=iBBNE6U3En/PEc5D1DGmkpGqGZy8kNhdQiVl/DKLu3A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ofuE8ueAzUF6PlunszYJ9gBCui62k4NFxn1ocmcgyT9jste3go/TaBNeB5jY1+D6808qq/Ffp0GbR0d/eWB0F0OzPKjZN/Vd4Ikm+SdRLHwsKEtoRgjnWq2LszUQ5SlwKQalPJl2gsj6sXlRDvfBruXhd9fsGwfUXuqF75gZ9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NGyUnB9d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ilmmJZqf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QDntRucj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0OLpF3+3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20CD721A07;
	Fri, 30 Aug 2024 05:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724996053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nfo3Zn+j+f/Vd6ugv/1ROSPyvCQ50fZHOxb/2DfD/L0=;
	b=NGyUnB9dJnbsAhmNMkhvFbTkkPzLo1B1PcLfTCbKgXQA1R5L59mC87KhNrTQP4iOflbu1x
	98zuk/gcOjhisTe2ez+qFc5xDY+wCG+38KvWrEnFYjH7a3pUE2CJ2oDrskwFztlXzsTD2Z
	CNo8cY9uyKN52gM+TYUlmbQafdZAQbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724996053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nfo3Zn+j+f/Vd6ugv/1ROSPyvCQ50fZHOxb/2DfD/L0=;
	b=ilmmJZqfhtQosFMZMzsBzJHe1t8aZW+peAi5kclYpoX3qsrhCUdjNHvpVlN50B2FSnRiJJ
	64uDRDGo5TIH1LDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724996052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nfo3Zn+j+f/Vd6ugv/1ROSPyvCQ50fZHOxb/2DfD/L0=;
	b=QDntRucjnxgrB08lMpk2TffGk8Y0cU/dxuQMryUXvQ88lqWQbp+wcedF63jonyReO2yjgH
	W9I1Vx7fbXkQAr6repuu1ESc67i2fiK4/jvuAqcTT69SxLqSUezGe+odS1AamgA3yf7tuI
	UoPV4GAPkqBqX4Z9nScAZk7qvHmUkEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724996052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nfo3Zn+j+f/Vd6ugv/1ROSPyvCQ50fZHOxb/2DfD/L0=;
	b=0OLpF3+3B3f6Ws62bsmu4zUMpdPlBQziyB0Ley5iJ3ytqJT5NvJaa9BYFFHlbshJ9haKcu
	gI+jx1qJqB0S+gAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CE5613A44;
	Fri, 30 Aug 2024 05:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kPDYBNFZ0WZUQwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 05:34:09 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 15/25] nfs_common: introduce nfs_localio_ctx struct
 and interfaces
In-reply-to: <ZtFSQz8YaD3A4r3Y@kernel.org>
References: <>, <ZtFSQz8YaD3A4r3Y@kernel.org>
Date: Fri, 30 Aug 2024 15:34:02 +1000
Message-id: <172499604207.4433.12271165205569396628@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 30 Aug 2024, Mike Snitzer wrote:
> On Fri, Aug 30, 2024 at 02:36:13PM +1000, NeilBrown wrote:
> > On Fri, 30 Aug 2024, Jeff Layton wrote:

> > > Have a pointer to a struct nfsd_localio_ops or something in the
> > > nfs_common module. That's initially set to NULL. Then, have a static
> > > structure of that type in nfsd.ko, and have its __init routine set the
> > > pointer in nfs_common to point to the right structure. The __exit
> > > routine will later set it to NULL.
> > >=20
> > > > I really don't want all calls in NFS client (or nfs_common) to have to
> > > > first check if nfs_common's 'nfs_to' ops structure is NULL or not.
> > >=20
> > > Neil seems to think that's not necessary:
> > >=20
> > > "If nfs/localio holds an auth_domain, then it implicitly holds a
> > > reference to the nfsd module and the functions cannot disappear."
> >=20
> > On reflection that isn't quite right, but it is the sort of approach
> > that I think we need to take.
> > There are several things that the NFS client needs to hold one to.
> >=20
> > 1/ It needs a reference to the nfsd module (or symbols in the module).
> >    I think this can be held long term but we need a clear mechanism for
> >    it to be dropped.
> > 2/ It needs a reference to the nfsd_serv which it gets through the
> >    'struct net' pointer.  I've posted patches to handle that better.
> > 3/ It needs a reference to an auth_domain.  This can safely be a long
> >    term reference.  It can already be invalidated and the code to free
> >    it is in sunrpc which nfs already pins.  Any delay in freeing it only
> >    wastes memory (not much), it doesn't impact anything else.
> > 4/ It needs a reference to the nfsd_file and/or file.  This is currently
> >    done only while the ref to the nfsd_serv is held, so I think there is
> >    no problem there.
> >=20
> > So possibly we could take a reference to the nfsd module whenever we
> > store a net in nfs_uuid. and drop the ref whenever we clear that.
> >=20
> > That means we cannot call nfsd_open_local_fh() without first getting a
> > ref on the nfsd_serv which my latest code doesn't do.  That is easily
> > fixed.  I'll send a patch for consideration...
>=20
> I already implemented 2 different versions today, meant for v15.
>=20
> First is a relaxed version of the v14 code (less code, only using
> symbol_request on nfsd_open_local_fh.
>=20
> Second is much more relaxed, because it leverages your original
> assumption that the auth_domain ref sufficient.
>=20
> I'll reply twice to this mail with each each respective patch.

Thanks... Unfortunately auth_domain isn't sufficient.

This is my version.  It should folded back into one or more earlier
patches.   I think it is simpler.

It is against your v15 but with my 6 nfs_uuid patches replaces your
equivalents.=20

Thanks,
NeilBrown

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 55622084d5c2..18b7554ec516 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -235,8 +235,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cr=
ed *cred,
 	if (mode & ~(FMODE_READ | FMODE_WRITE))
 		return NULL;
=20
-	localio =3D nfs_to.nfsd_open_local_fh(&clp->cl_uuid,
-					    clp->cl_rpcclient, cred, fh, mode);
+	localio =3D nfs_open_local_fh(&clp->cl_uuid,
+				    clp->cl_rpcclient, cred, fh, mode);
 	if (IS_ERR(localio)) {
 		status =3D PTR_ERR(localio);
 		trace_nfs_local_open_fh(fh, mode, status);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 8545ee75f756..cd9733eb3e4f 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -54,8 +54,11 @@ static nfs_uuid_t * nfs_uuid_lookup(const uuid_t *uuid)
 	return NULL;
 }
=20
+struct module *nfsd_mod;
+
 void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
-		       struct net *net, struct auth_domain *dom)
+		       struct net *net, struct auth_domain *dom,
+		       struct module *mod)
 {
 	nfs_uuid_t *nfs_uuid;
=20
@@ -70,6 +73,9 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_head=
 *list,
 		 */
 		list_move(&nfs_uuid->list, list);
 		nfs_uuid->net =3D net;
+
+		__module_get(mod);
+		nfsd_mod =3D mod;
 	}
 	spin_unlock(&nfs_uuid_lock);
 }
@@ -77,8 +83,10 @@ EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
=20
 static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
 {
-	if (nfs_uuid->net)
+	if (nfs_uuid->net) {
 		put_net(nfs_uuid->net);
+		module_put(nfsd_mod);
+	}
 	nfs_uuid->net =3D NULL;
 	if (nfs_uuid->dom)
 		auth_domain_put(nfs_uuid->dom);
@@ -107,6 +115,26 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
=20
+struct nfs_localio_ctx *nfs_open_local_fh(nfs_uuid_t *uuid,
+		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
+		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+{
+	struct nfs_localio_ctx *localio;
+
+	rcu_read_lock();
+	if (!READ_ONCE(uuid->net)) {
+		rcu_read_unlock();
+		return ERR_PTR(-ENXIO);
+	}
+	localio =3D nfs_to.nfsd_open_local_fh(uuid, rpc_clnt, cred,
+					    nfs_fh, fmode);
+	rcu_read_unlock();
+	if (IS_ERR(localio))
+		nfs_to.nfsd_serv_put(localio->nn);
+	return localio;
+}
+EXPORT_SYMBOL_GPL(nfs_open_local_fh);
+
 /*
  * The nfs localio code needs to call into nfsd using various symbols (below=
),
  * but cannot be statically linked, because that will make the nfs module
@@ -135,7 +163,8 @@ static void put_##NFSD_SYMBOL(void)			\
 /* The nfs localio code needs to call into nfsd to map filehandle -> struct =
nfsd_file */
 extern struct nfs_localio_ctx *
 nfsd_open_local_fh(nfs_uuid_t *, struct rpc_clnt *,
-		   const struct cred *, const struct nfs_fh *, const fmode_t);
+		   const struct cred *, const struct nfs_fh *, const fmode_t)
+	__must_hold(rcu);
 DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
=20
 /* The nfs localio code needs to call into nfsd to acquire the nfsd_file */
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 491bf5017d34..d50e54406914 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -45,6 +45,7 @@ struct nfs_localio_ctx *
 nfsd_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
 		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+	__must_hold(rcu)
 {
 	int mayflags =3D NFSD_MAY_LOCALIO;
 	int status =3D 0;
@@ -58,10 +59,6 @@ nfsd_open_local_fh(nfs_uuid_t *uuid,
 	if (nfs_fh->size > NFS4_FHSIZE)
 		return ERR_PTR(-EINVAL);
=20
-	localio =3D nfs_localio_ctx_alloc();
-	if (!localio)
-		return ERR_PTR(-ENOMEM);
-
 	/*
 	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
 	 * But the server may already be shutting down, if so disallow new localio.
@@ -69,17 +66,22 @@ nfsd_open_local_fh(nfs_uuid_t *uuid,
 	 * uuid->net is not NULL, then nfsd_serv_try_get() is safe and if that succ=
eeds
 	 * we will have an implied reference to the net.
 	 */
-	rcu_read_lock();
 	net =3D READ_ONCE(uuid->net);
 	if (net)
 		nn =3D net_generic(net, nfsd_net_id);
-	if (unlikely(!nn || !nfsd_serv_try_get(nn))) {
-		rcu_read_unlock();
-		status =3D -ENXIO;
-		goto out_nfsd_serv;
-	}
+	if (unlikely(!nn || !nfsd_serv_try_get(nn)))
+		return -ENXIO;
+
+	/* Drop the rcu lock for alloc and nfsd_file_acquire_local() */
 	rcu_read_unlock();
=20
+	localio =3D nfs_localio_ctx_alloc();
+	if (!localio) {
+		localio =3D ERR_PTR(-ENOMEM);
+		nfsd_serv_put(nn);
+		goto out_localio;
+	}
+
 	/* nfs_fh -> svc_fh */
 	fh_init(&fh, NFS4_FHSIZE);
 	fh.fh_handle.fh_size =3D nfs_fh->size;
@@ -104,11 +106,13 @@ nfsd_open_local_fh(nfs_uuid_t *uuid,
 	fh_put(&fh);
 	if (rq_cred.cr_group_info)
 		put_group_info(rq_cred.cr_group_info);
-out_nfsd_serv:
+
 	if (status) {
 		nfs_localio_ctx_free(localio);
-		return ERR_PTR(status);
+		localio =3D ERR_PTR(status);
 	}
+out_localio:
+	rcu_read_lock();
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
@@ -136,7 +140,7 @@ static __be32 localio_proc_uuid_is_local(struct svc_rqst =
*rqstp)
 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
=20
 	nfs_uuid_is_local(&argp->uuid, &nn->local_clients,
-			  net, rqstp->rq_client);
+			  net, rqstp->rq_client, THIS_MODULE);
=20
 	return rpc_success;
 }
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 2ecceb8b9d3d..c73633120997 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -164,7 +164,8 @@ void		nfsd_filp_close(struct file *fp);
 struct nfs_localio_ctx *
 nfsd_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
-		   const struct nfs_fh *, const fmode_t);
+		   const struct nfs_fh *, const fmode_t)
+	__must_hold(rcu);
=20
 static inline int fh_want_write(struct svc_fh *fh)
 {
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index e196f716a2f5..303e82e75b9e 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -29,7 +29,7 @@ typedef struct {
 void nfs_uuid_begin(nfs_uuid_t *);
 void nfs_uuid_end(nfs_uuid_t *);
 void nfs_uuid_is_local(const uuid_t *, struct list_head *,
-		       struct net *, struct auth_domain *);
+		       struct net *, struct auth_domain *, struct module *);
 void nfs_uuid_invalidate_clients(struct list_head *list);
 void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
=20
@@ -69,4 +69,8 @@ void put_nfs_to_nfsd_symbols(void);
 struct nfs_localio_ctx *nfs_localio_ctx_alloc(void);
 void nfs_localio_ctx_free(struct nfs_localio_ctx *);
=20
+struct nfs_localio_ctx *nfs_open_local_fh(nfs_uuid_t *uuid,
+		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
+		   const struct nfs_fh *nfs_fh, const fmode_t fmode);
+
 #endif  /* __LINUX_NFSLOCALIO_H */

