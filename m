Return-Path: <linux-fsdevel+bounces-28188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8BA967CC2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 01:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231D8281A2D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 23:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759418595B;
	Sun,  1 Sep 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WjQeLYeu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AGNO0U2O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DhgXrB+F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bsY8T8UV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271B78C60;
	Sun,  1 Sep 2024 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725233871; cv=none; b=gzY0DIQ5ewQOmtXBgvBgEyV3UfHOd/1AV/YGRST7efpC0GSC5F90XlqixmahR7fXpe7IVbee9Xz6BiNuXRR5vmf061k2b6QYQYkqixFhx03VtYUrZfgCs5Z9jRsdv8gQn/95e31w9npv6CaE3DeAJQkUYvB894Is1C/U+fKUqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725233871; c=relaxed/simple;
	bh=wFN9OcWPQzqi9pIBsshSPnvgusJIOu3AIzbBfwrlcIQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TfPLA+dBUvFaJtorsAuOIcJF1LeLjQt4jvVo/SzwEZ61retnE2D5aGXT9tSmKsO6+m8bg8LorRyzYnY/JfvbT4mBkOBFNO5FRsQDZl2Evf6CH1VZwstTc8ThozAA9kUkORl79Gmj91gHok00+xg4QX+nykaQeSv8i0Cob4QPjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WjQeLYeu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AGNO0U2O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DhgXrB+F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bsY8T8UV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D36821B13;
	Sun,  1 Sep 2024 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725233867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXrckj4py0IHtwcbxCbRa8BHqAKLS0SD01GfsTpY8Qc=;
	b=WjQeLYeuh/60n1oxH6cF4Ws06kprE/ALGjqGokZ0cvDJ42H3hP41pZmdI6gqIKaAhK0nbq
	ENRkoKF8cEKMDyZjEcUbODT1fpUjbTj2s2hkBvsSDIOlui+qO0pXEaLHWrkW7/HqbxCdJ+
	tsmRcRX7r5xv6eiTSM4IeCOKH+AJuaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725233867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXrckj4py0IHtwcbxCbRa8BHqAKLS0SD01GfsTpY8Qc=;
	b=AGNO0U2OfBV/u6LBjKGHObKsVRJUXgUIQCPNF4uhZ0+2h8QHbyhUfJ7unrwOnzwClaUtxx
	vRgxYg3qPjERtcCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725233866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXrckj4py0IHtwcbxCbRa8BHqAKLS0SD01GfsTpY8Qc=;
	b=DhgXrB+FJNqJ/mIQILoghW3uCt5kodjRo3ru0eUFywuWRCsqzPPGAmm2dxMHqcsY7C9rd+
	SqnG8IHW0/pO89ttVuJq7HdlsQN13a4D/desMj2VLUF297JVDvu5yHqvNydqykkjCa3wRi
	KaWFo76d+OjRTmK0r0J1kRAe+kaopvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725233866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXrckj4py0IHtwcbxCbRa8BHqAKLS0SD01GfsTpY8Qc=;
	b=bsY8T8UVqPtB8+SrLpU9zEj6m4iZuv1bkevUx/TDvk6bDgVRQWy5qLD9EdSYqIDEuGJbL9
	hY4Zg4ar7/lnEmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD8091373A;
	Sun,  1 Sep 2024 23:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d2kbIMf61GYJLwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 01 Sep 2024 23:37:43 +0000
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
Subject: Re: [PATCH v15 15/26] nfs_common: prepare for the NFS client to use
 nfsd_file for LOCALIO
In-reply-to: <20240831223755.8569-16-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>,
 <20240831223755.8569-16-snitzer@kernel.org>
Date: Mon, 02 Sep 2024 09:37:40 +1000
Message-id: <172523386083.4433.15441958580216280135@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,hammerspace.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sun, 01 Sep 2024, Mike Snitzer wrote:
> The next commit will introduce nfsd_open_local_fh() which returns an
> nfsd_file structure.  This commit exposes LOCALIO's required NFSD
> symbols to the NFS client:
>=20
> - Make nfsd_open_local_fh() symbol and other required NFSD symbols
>   available to NFS in a global 'nfs_to' nfsd_localio_operations
>   struct (global access suggested by Trond, nfsd_localio_operations
>   suggested by NeilBrown).  The next commit will also introduce
>   nfsd_localio_ops_init() that init_nfsd() will call to initialize
>   'nfs_to'.
>=20
> - Introduce nfsd_file_file() that provides access to nfsd_file's
>   backing file.  Keeps nfsd_file structure opaque to NFS client (as
>   suggested by Jeff Layton).
>=20
> - Introduce nfsd_file_put_local() that will put the reference to the
>   nfsd_file's associated nn->nfsd_serv and then put the reference to
>   the nfsd_file (as suggested by NeilBrown).
>=20
> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs_to
> Suggested-by: NeilBrown <neilb@suse.de> # nfsd_localio_operations
> Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs_common/nfslocalio.c | 23 +++++++++++++++++++++++
>  fs/nfsd/filecache.c        | 30 ++++++++++++++++++++++++++++++
>  fs/nfsd/filecache.h        |  2 ++
>  fs/nfsd/nfssvc.c           |  2 ++
>  include/linux/nfslocalio.h | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 87 insertions(+)
>=20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 22b0ddf225ca..64f75a3a370a 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -114,3 +114,26 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uu=
id)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
> +
> +/*
> + * The NFS LOCALIO code needs to call into NFSD using various symbols,
> + * but cannot be statically linked, because that will make the NFS
> + * module always depend on the NFSD module.
> + *
> + * 'nfs_to' provides NFS access to NFSD functions needed for LOCALIO,
> + * its lifetime is tightly coupled to the NFSD module and will always
> + * be available to NFS LOCALIO because any successful client<->server
> + * LOCALIO handshake results in a reference on the NFSD module (above),
> + * so NFS implicitly holds a reference to the NFSD module and its
> + * functions in the 'nfs_to' nfsd_localio_operations cannot disappear.
> + *
> + * If the last NFS client using LOCALIO disconnects (and its reference
> + * on NFSD dropped) then NFSD could be unloaded, resulting in 'nfs_to'
> + * functions being invalid pointers. But if NFSD isn't loaded then NFS
> + * will not be able to handshake with NFSD and will have no cause to
> + * try to call 'nfs_to' function pointers. If/when NFSD is reloaded it
> + * will reinitialize the 'nfs_to' function pointers and make LOCALIO
> + * possible.
> + */
> +struct nfsd_localio_operations nfs_to;
> +EXPORT_SYMBOL_GPL(nfs_to);
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 2dc72de31f61..89ff380ec31e 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -390,6 +390,36 @@ nfsd_file_put(struct nfsd_file *nf)
>  		nfsd_file_free(nf);
>  }
> =20
> +/**
> + * nfsd_file_put_local - put the reference to nfsd_file and local nfsd_serv
> + * @nf: nfsd_file of which to put the references
> + *
> + * First put the reference of the nfsd_file's associated nn->nfsd_serv and
> + * then put the reference to the nfsd_file.
> + */
> +void
> +nfsd_file_put_local(struct nfsd_file *nf)
> +{
> +	struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> +
> +	nfsd_serv_put(nn);
> +	nfsd_file_put(nf);
> +}
> +EXPORT_SYMBOL_GPL(nfsd_file_put_local);

This and the others doesn't need to be exported.  The name is only used
inside this module.

> +
> +/**
> + * nfsd_file_file - get the backing file of an nfsd_file
> + * @nf: nfsd_file of which to access the backing file.
> + *
> + * Return backing file for @nf.
> + */
> +struct file *
> +nfsd_file_file(struct nfsd_file *nf)
> +{
> +	return nf->nf_file;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_file_file);
> +
>  static void
>  nfsd_file_dispose_list(struct list_head *dispose)
>  {
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 26ada78b8c1e..cadf3c2689c4 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -55,7 +55,9 @@ void nfsd_file_cache_shutdown(void);
>  int nfsd_file_cache_start_net(struct net *net);
>  void nfsd_file_cache_shutdown_net(struct net *net);
>  void nfsd_file_put(struct nfsd_file *nf);
> +void nfsd_file_put_local(struct nfsd_file *nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
> +struct file *nfsd_file_file(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
>  void nfsd_file_net_dispose(struct nfsd_net *nn);
>  bool nfsd_file_is_cached(struct inode *inode);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c639fbe4d8c2..7b9119b8dd1b 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -19,6 +19,7 @@
>  #include <linux/sunrpc/svc_xprt.h>
>  #include <linux/lockd/bind.h>
>  #include <linux/nfsacl.h>
> +#include <linux/nfslocalio.h>
>  #include <linux/seq_file.h>
>  #include <linux/inetdevice.h>
>  #include <net/addrconf.h>
> @@ -201,6 +202,7 @@ void nfsd_serv_put(struct nfsd_net *nn)
>  {
>  	percpu_ref_put(&nn->nfsd_serv_ref);
>  }
> +EXPORT_SYMBOL_GPL(nfsd_serv_put);
> =20
>  static void nfsd_serv_done(struct percpu_ref *ref)
>  {
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 4165ff8390c1..62419c4bc8f1 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/uuid.h>
> +#include <linux/sunrpc/clnt.h>
>  #include <linux/sunrpc/svcauth.h>
>  #include <linux/nfs.h>
>  #include <net/net_namespace.h>
> @@ -33,4 +34,33 @@ void nfs_uuid_is_local(const uuid_t *, struct list_head =
*,
>  void nfs_uuid_invalidate_clients(struct list_head *list);
>  void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
> =20
> +struct nfsd_file;
> +
> +/* localio needs to map filehandle -> struct nfsd_file */
> +typedef struct nfsd_file *
> +(*nfs_to_nfsd_open_local_fh_t)(nfs_uuid_t *, struct rpc_clnt *,
> +			       const struct cred *, const struct nfs_fh *,
> +			       const fmode_t);
> +
> +extern struct nfsd_file *
> +nfsd_open_local_fh(nfs_uuid_t *, struct rpc_clnt *,
> +		   const struct cred *, const struct nfs_fh *,
> +		   const fmode_t) __must_hold(rcu);
> +
> +/* localio needs to acquire an nfsd_file */
> +typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_file *);
> +/* localio needs to release an nfsd_file and its associated nn->nfsd_serv =
*/
> +typedef void (*nfs_to_nfsd_file_put_local_t)(struct nfsd_file *);
> +/* localio needs to access the nf->nf_file */
> +typedef struct file * (*nfs_to_nfsd_file_file_t)(struct nfsd_file *);
> +
> +struct nfsd_localio_operations {
> +	nfs_to_nfsd_open_local_fh_t	nfsd_open_local_fh;
> +	nfs_to_nfsd_file_put_local_t	nfsd_file_put_local;
> +	nfs_to_nfsd_file_file_t		nfsd_file_file;
> +} ____cacheline_aligned;

What benefits do you see in these typedef?
The standard practice for operations structures is:

 struct nfsd_localio_operations {
    struct nfsd_file *(*nfsd_open_local_fh)(nfs_uuid_t *, struct rpc_clnt *,
			       const struct cred *, const struct nfs_fh *,
			       const fmode_t);
    void (*nfsd_file_put_local)(struct nfsd_file *);
    struct file *(*nfsd_file_file)(struct nfsd_file *);
 };

which I find to be much readable.

(I'd prefer "struct nfsd_uuid" to "nfs_uuid_t" too but I've decided to
 not push that for now).

This can easily be fixed up after the series lands so it doesn't need to
block landing for v15 if there are no show-stoppers, but I needed to say
something...  But I'm so happy to see an operations structure that I
don't want to sound too negative.

See section 5 of Documentation/process/coding-style.rst=20

https://www.kernel.org/doc/html/v4.14/process/coding-style.html#typedefs


NeilBrown


