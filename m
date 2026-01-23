Return-Path: <linux-fsdevel+bounces-75318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBRCHoz0c2ny0AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:22:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26D7B1A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E60C5301C8A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164122C08A1;
	Fri, 23 Jan 2026 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mxTDI1hv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9/DDws7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEDD3E47B;
	Fri, 23 Jan 2026 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206897; cv=none; b=C1V17F1fZ8Pk9zL1LCndFV8e2GOkYmywneva9z0t2jv8MmI7td9QdRBEakMPQZ7vsF++cEEK8UZxCMs/utCRXxF4xVYROCb+tfr0s3Zwo6c0WtmoU8jahVJOpInTeDyOZDEIJVXFoCLFjQyDE0FVMS5nt76mrGZWsThZDo8AaRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206897; c=relaxed/simple;
	bh=0XCMoG6oIl/nkUOlVBYNV1e0ZD8NURx/Vufwzo8+dKw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ElVO5Eyrs+aI5Uo3wlCqkLcdZkmOGpF/a+/klKeVY8YRMSB8D6dOxFJ4Xd9thO6wht03zSuPKajP7PvSLqVfiEk8IX7H6qEq6NJc7vtMZbBjW5BR4PD+PL1QmZMlQHpeJgP04QTPNaz5gEkXgnLr0lxC0H89PWRx5OO1YtTZ+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mxTDI1hv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9/DDws7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDC7D1400096;
	Fri, 23 Jan 2026 17:21:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Jan 2026 17:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769206893; x=1769293293; bh=Ut1HyxkGGZhZHF5d1dJGule83CusZqiSJFH
	Vq0MLNbc=; b=mxTDI1hvIo/wzpD5e/BVaZr6amLPbWhww++3++ah7CEfid3I/hS
	VFpnq5kcC2oarj02uqXVxJcGkqT+RE89oi0vSx2iVi0ws3LrFYT54yX5zwmhh9ip
	TQmORKc+CmtsjFyWuHzk73I8Kd9uxXuH8Izb3PT87IshvBIjwNxqw0WQEzKZKn+W
	UCEjCKmen3Lf17+2f00qfNNCrjMBFN1CVfsA7EbsrXwAcsXq5OuDhX1O5bddDGpC
	v8uJ+Ol9kyp5DonQXMQP78ZRc3B5PfB2WtI7vht2aOsaKLTJwj3XgzQGLWiZYO5k
	SJi7osdoPwhb75ODBHFAxIUufOeACHK3x6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769206893; x=
	1769293293; bh=Ut1HyxkGGZhZHF5d1dJGule83CusZqiSJFHVq0MLNbc=; b=l
	9/DDws7nVy59ByCXdMXuJyrFbVaH2GuUYGbbBp95bAcgzxRIGKfI2CZMNb3IwCe6
	CUdgx1AmenEFsZXBbfrRLoo7IgLRPQQMjKMkcfIeq/rD4T0e8UkbM0PwsLWgDNhm
	GuU+ITL/7vIyEs/kOnrlmPMPuwn9ofecVWaH2xAi9U6EfdON981kLeXhneCYggkB
	f0ZVC7g92816Oji6khySMSFMmqorZGGVfUIDMH3dLULI+afJGMabxDLilOkzjjHO
	Yo6d6Mwp58pSRaKqpovtyDIgkbiVCQ/6tLdFr2CzZdP/9lHD3yI4B4ZmwY+jonlN
	aAdHV7L0097lfwCm0rEsw==
X-ME-Sender: <xms:bfRzaaXfTDiRcxILsHqfGvMZ-XjiDbdfpRnF11nwO6bMI52rbkIVQA>
    <xme:bfRzaSdKqkIcjzhWUx7b_-SESOequeRwC6csLb8GQFdzljRqsAkAe6-ujHQ6-C3-F
    D72ZGF_0tgLkpvqKUOQ2OtrPn94CpngFKPVBkuAABZDyvTR8_w>
X-ME-Received: <xmr:bfRzaba3317QDLrsv9fGlkhhwNSs5u7Qpk2JkDZLCH2TWAmYN30DF0nGaYhvrCdzcaUnKxMUr64WDWS4HWIWtX1oWUT0C1zPPUTidIdkcMUV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugi
    dqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqtghrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgt
    khdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:bfRzaWMnSFEL8cvCkYp023lolixZ7GMBYazonIdDZUIFAwaCMFu3rw>
    <xmx:bfRzaZXwsGCE_QrW0XOOuv45vJEIgJbyHODX6OiGBDq4x3rSCI4b5Q>
    <xmx:bfRzabKKhlUG9crR3Qm7yMcDKoQmZCwpCgWZHnO2f4E5GpAVy_rEKw>
    <xmx:bfRzaUqQh8mI07d861kml5C-rYvu3eRrs2opHRth2DJcBwAId53T8Q>
    <xmx:bfRzaY52HnJwHFlTsq4Vln5fgSy8x4qdX2rV2-IrOJaiN-uNabB7X4Ty>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 17:21:30 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
In-reply-to: <5fb38378-a8e0-46d5-956c-de1a3bdaaf23@app.fastmail.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>, =?utf-8?q?=3C0a?=
 =?utf-8?q?aa9ca4fd3edc7e0d25433ad472cb873560bf7d=2E1769026777=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E=2C?=
 <5fb38378-a8e0-46d5-956c-de1a3bdaaf23@app.fastmail.com>
Date: Sat, 24 Jan 2026 09:21:27 +1100
Message-id: <176920688733.16766.188886135069880896@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75318-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[hammerspace.com,oracle.com,kernel.org,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,messagingengine.com:dkim,brown.name:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: DF26D7B1A8
X-Rspamd-Action: no action

On Sat, 24 Jan 2026, Chuck Lever wrote:
>=20
> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
> > NFS clients may bypass restrictive directory permissions by using
> > open_by_handle() (or other available OS system call) to guess the
> > filehandles for files below that directory.
> >
> > In order to harden knfsd servers against this attack, create a method to
> > sign and verify filehandles using siphash as a MAC (Message Authentication
> > Code).  Filehandles that have been signed cannot be tampered with, nor can
> > clients reasonably guess correct filehandles and hashes that may exist in
> > parts of the filesystem they cannot access due to directory permissions.
> >
> > Append the 8 byte siphash to encoded filehandles for exports that have set
> > the "sign_fh" export option.  The filehandle's fh_auth_type is set to
> > FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles received =
from
> > clients are verified by comparing the appended hash to the expected hash.
> > If the MAC does not match the server responds with NFS error _BADHANDLE.
> > If unsigned filehandles are received for an export with "sign_fh" they are
> > rejected with NFS error _BADHANDLE.
> >
> > Link:=20
> > https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspa=
ce.com
> > Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> > ---
> >  fs/nfsd/nfsfh.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/nfsd/nfsfh.h |  3 ++
> >  2 files changed, 73 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index ed85dd43da18..ea3473acbf71 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/exportfs.h>
> >=20
> >  #include <linux/sunrpc/svcauth_gss.h>
> > +#include <crypto/utils.h>
> >  #include "nfsd.h"
> >  #include "vfs.h"
> >  #include "auth.h"
> > @@ -137,6 +138,61 @@ static inline __be32 check_pseudo_root(struct=20
> > dentry *dentry,
> >  	return nfs_ok;
> >  }
> >=20
> > +/*
> > + * Append an 8-byte MAC to the filehandle hashed from the server's=20
> > fh_key:
> > + */
> > +static int fh_append_mac(struct svc_fh *fhp, struct net *net)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> > +	siphash_key_t *fh_key =3D nn->fh_key;
> > +	u64 hash;
> > +
> > +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
> > +		return 0;
> > +
> > +	if (!fh_key) {
> > +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not=20
> > set.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
> > +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d=20
> > would be greater"
> > +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)),=20
> > fhp->fh_maxsize);
> > +		return -EINVAL;
> > +	}
> > +
> > +	fh->fh_auth_type =3D FH_AT_MAC;
> > +	hash =3D siphash(&fh->fh_raw, fh->fh_size, fh_key);
> > +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
> > +	fh->fh_size +=3D sizeof(hash);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Verify that the the filehandle's MAC was hashed from this filehandle
> > + * given the server's fh_key:
> > + */
> > +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> > +	siphash_key_t *fh_key =3D nn->fh_key;
> > +	u64 hash;
> > +
> > +	if (fhp->fh_handle.fh_auth_type !=3D FH_AT_MAC)
> > +		return -EINVAL;
> > +
> > +	if (!fh_key) {
> > +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles,=20
> > fh_key not set.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	hash =3D siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
> > +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash,=20
> > sizeof(hash));
> > +}
> > +
> >  /*
> >   * Use the given filehandle to look up the corresponding export and
> >   * dentry.  On success, the results are used to set fh_export and
> > @@ -166,8 +222,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst=20
> > *rqstp, struct net *net,
> >=20
> >  	if (--data_left < 0)
> >  		return error;
> > -	if (fh->fh_auth_type !=3D 0)
> > +
> > +	/* either FH_AT_NONE or FH_AT_MAC */
> > +	if (fh->fh_auth_type > 1)
> >  		return error;
> > +
> >  	len =3D key_len(fh->fh_fsid_type) / 4;
> >  	if (len =3D=3D 0)
> >  		return error;
> > @@ -237,9 +296,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst=20
> > *rqstp, struct net *net,
> >=20
> >  	fileid_type =3D fh->fh_fileid_type;
> >=20
> > -	if (fileid_type =3D=3D FILEID_ROOT)
> > +	if (fileid_type =3D=3D FILEID_ROOT) {
> >  		dentry =3D dget(exp->ex_path.dentry);
> > -	else {
> > +	} else {
> > +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
> > +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
> > +			goto out;
> > +		}
> > +
> >  		dentry =3D exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
> >  						data_left, fileid_type, 0,
> >  						nfsd_acceptable, exp);
> > @@ -495,6 +559,9 @@ static void _fh_update(struct svc_fh *fhp, struct=20
> > svc_export *exp,
> >  		fhp->fh_handle.fh_fileid_type =3D
> >  			fileid_type > 0 ? fileid_type : FILEID_INVALID;
> >  		fhp->fh_handle.fh_size +=3D maxsize * 4;
> > +
> > +		if (fh_append_mac(fhp, exp->cd->net))
> > +			fhp->fh_handle.fh_fileid_type =3D FILEID_INVALID;
> >  	} else {
> >  		fhp->fh_handle.fh_fileid_type =3D FILEID_ROOT;
> >  	}
> > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > index 5ef7191f8ad8..7fff46ac2ba8 100644
> > --- a/fs/nfsd/nfsfh.h
> > +++ b/fs/nfsd/nfsfh.h
> > @@ -59,6 +59,9 @@ struct knfsd_fh {
> >  #define fh_fsid_type		fh_raw[2]
> >  #define fh_fileid_type		fh_raw[3]
> >=20
> > +#define FH_AT_NONE		0
> > +#define FH_AT_MAC		1
>=20
> I'm pleased at how much this patch has shrunk since v1.
>=20
> This might not be an actionable review comment, but help me understand
> this particular point. Why do you need both a sign_fh export option
> and a new FH auth type? Shouldn't the server just look for and
> validate FH signatures whenever the sign_fh export option is
> present?

...and also generate valid signatures on outgoing file handles.

What does the server do to "look for" an FH signature so that it can
"validate" it?  Answer: it inspects the fh_auth_type to see if it is
FT_AT_MAC.=20

>=20
> It seems a little subtle, so perhaps a code comment somewhere could
> explain the need for both.

/*=20
 * FT_AT_MAC allows the server to detect if a signature is expected
 * in the last 8 bytes of the file handle.
 */

I wonder if it is really "last 8" for NFSv2 ...  or even if v2 is
supported.  I should check the code I guess.

NeilBrown


>=20
>=20
> > +
> >  static inline u32 *fh_fsid(const struct knfsd_fh *fh)
> >  {
> >  	return (u32 *)&fh->fh_raw[4];
> > --=20
> > 2.50.1
>=20
> --=20
> Chuck Lever
>=20


