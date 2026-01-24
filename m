Return-Path: <linux-fsdevel+bounces-75339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IM/HvcmdGkl2gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 02:57:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC9C7C229
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 02:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2941301DB81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE821EF09B;
	Sat, 24 Jan 2026 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="W1QGLxbF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A1fu7UBo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63131145B27;
	Sat, 24 Jan 2026 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219810; cv=none; b=th5azbhBJqtcWU4EPILyOyLJR8gZTxHmx8nPSaWA06shAeRwA3mXYl6uweDiQKpyXig4IvxNo7wTTjtwTKetgmPc5MsErvZWANy8pOuge9yJbZ4HugWSe3cTMqjGa174y50JpuQEfrM/JSWCbHRCuljQnidGK9N0bWu49uHMeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219810; c=relaxed/simple;
	bh=NLAqcp8p+2nNpcq/bDqNKsNxt38BVc4fwG4KzxlCJB8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SgM9bzsy40zrIsaa2VVk3HLaCLCtfvshb8+6CK31+Beq6efvxUdUfta4zo3ZoYp3i2+qXorQvUMK+XVIRLIKFj9kOFeZ6npTmgt+ddSDTuuqlEA8ZJoVFVfRVQuso2usA8S06CcI92BrgmJAJcURqI4B7imXjJHp2g0nxDE7nio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=W1QGLxbF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A1fu7UBo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CFAC14000AF;
	Fri, 23 Jan 2026 20:56:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 23 Jan 2026 20:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769219806; x=1769306206; bh=3SNrRUpnY4cv7T5LopuGP+wIiG8AZFh7qBf
	5ULbw5mY=; b=W1QGLxbFWAe568IdpA0JRxStzwCMjKQB3PnfcKvqOOvGR/rIouW
	N2FCWJVdaEcZ/zJtgGz8/66SP02i+88hsuyW30BcD7WKivQcxSAeAYrrLdfYOkY6
	B8i8wDF13VRa7TRgxH04DhP0+R111T2F8U7N/dTiIvSmrukKs5h2FSYdFZ7qhj+F
	geEfUdVBBwKVFVskkH0kriyX/kOZKEq2P1LYYAdJoONVX3SZgjBG9TvaGBKYF90B
	Ux/hZXHRqJ/00sryb9U2gJp7D6Xla/zUZk8NoK/h1UrmxZIhnVTPIm3JgnJBbmh2
	Z2mPaFslvRlNOmauoJJszv+cyHEw3oEvMCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769219806; x=
	1769306206; bh=3SNrRUpnY4cv7T5LopuGP+wIiG8AZFh7qBf5ULbw5mY=; b=A
	1fu7UBozLBvhZLaNPS6WMMDwAfFuRXJbkGuGFw5pOQUqJeIkqOkJ0IqEGaYdzcdQ
	GltJ5owdsJbWloK1DyZ1z4KILMDPBJJNzi/d/e2wmkCIgxeTBD0n/DUq6cJhIhJD
	hQ3R8VH/Gkp+bH/9mHJVoPlFodMewQnU8BtZ18F5Re3g/KqLkx611KChGOc0FT5C
	LUH+DhpBE4tdJe2ZdWrc3I7SS89Lo1XvXWhWKWDwFXVGMRNa7ebuuaaweTec19NW
	ItOr6jDs4LkaKrBms+WIfZkGYYqx+28WlgFc0w1tlyNbKzUp3wNc8OZFQHSlvTeu
	XEFR2VRxg0urWrfTtzitg==
X-ME-Sender: <xms:3iZ0aS1oTXm03CJ-88B2LTaOp6hDNlip4GqyWmOq_TZft_jkEmusFA>
    <xme:3iZ0aQ-c7jdHI6lw1lPtoXOumRfy26bwXCE-FSJq-GUwtgon5QouGeo9pmnuNoWnH
    S-4ptcaG6vBiUwfUQIcQUclMQijDfsdtoffpz32osn1KZAVSw>
X-ME-Received: <xmr:3iZ0aX4HbeAYlCjUf3xBzbmG6gkDODYJ7dBoS4eWBCS2LD0Q2irOxKyOiyIXmpN_WA21nRHPh6MqvxYz1C6frdqUTphCP6rjgbfo_Oz39Bg->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:3iZ0aYvPgGxYX6HJlM-M-vQK8kBqg6sJlnFlOhpzVjyKVxlkdSqpig>
    <xmx:3iZ0aZ15xJN_dVH5N1iXsAJoClBGMPBoUtbQujjOFE-oqCXPW91k5w>
    <xmx:3iZ0aRoTVeUlWJU1zjY5JoFErPresnxezV9wTTi65DBtcEDrEz-vUw>
    <xmx:3iZ0aZIU5YJXh_fYxbZmx_Ulep5jSZNCB1dHiOvKSdOCS5_--nH1hw>
    <xmx:3iZ0aZ9YCAkQRmqqIzJUbAqseUSIuubMu0XO5oxm-Md3x_mcKBjq9jzG>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 20:56:42 -0500 (EST)
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
In-reply-to: <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
References: <>, <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
Date: Sat, 24 Jan 2026 12:56:39 +1100
Message-id: <176921979948.16766.5458950508894093690@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FREEMAIL_CC(0.00)[hammerspace.com,oracle.com,kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75339-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Queue-Id: DAC9C7C229
X-Rspamd-Action: no action

On Sat, 24 Jan 2026, Chuck Lever wrote:
>=20
> On Fri, Jan 23, 2026, at 6:38 PM, NeilBrown wrote:
> > On Sat, 24 Jan 2026, Chuck Lever wrote:
> >> On 1/23/26 5:21 PM, NeilBrown wrote:
> >> > On Sat, 24 Jan 2026, Chuck Lever wrote:
> >> >>
> >> >> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
> >> >>> NFS clients may bypass restrictive directory permissions by using
> >> >>> open_by_handle() (or other available OS system call) to guess the
> >> >>> filehandles for files below that directory.
> >> >>>
> >> >>> In order to harden knfsd servers against this attack, create a metho=
d to
> >> >>> sign and verify filehandles using siphash as a MAC (Message Authenti=
cation
> >> >>> Code).  Filehandles that have been signed cannot be tampered with, n=
or can
> >> >>> clients reasonably guess correct filehandles and hashes that may exi=
st in
> >> >>> parts of the filesystem they cannot access due to directory permissi=
ons.
> >> >>>
> >> >>> Append the 8 byte siphash to encoded filehandles for exports that ha=
ve set
> >> >>> the "sign_fh" export option.  The filehandle's fh_auth_type is set to
> >> >>> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles rece=
ived from
> >> >>> clients are verified by comparing the appended hash to the expected =
hash.
> >> >>> If the MAC does not match the server responds with NFS error _BADHAN=
DLE.
> >> >>> If unsigned filehandles are received for an export with "sign_fh" th=
ey are
> >> >>> rejected with NFS error _BADHANDLE.
> >> >>>
> >> >>> Link:=20
> >> >>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hamm=
erspace.com
> >> >>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> >> >>> ---
> >> >>>  fs/nfsd/nfsfh.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++=
+--
> >> >>>  fs/nfsd/nfsfh.h |  3 ++
> >> >>>  2 files changed, 73 insertions(+), 3 deletions(-)
> >> >>>
> >> >>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> >> >>> index ed85dd43da18..ea3473acbf71 100644
> >> >>> --- a/fs/nfsd/nfsfh.c
> >> >>> +++ b/fs/nfsd/nfsfh.c
> >> >>> @@ -11,6 +11,7 @@
> >> >>>  #include <linux/exportfs.h>
> >> >>>
> >> >>>  #include <linux/sunrpc/svcauth_gss.h>
> >> >>> +#include <crypto/utils.h>
> >> >>>  #include "nfsd.h"
> >> >>>  #include "vfs.h"
> >> >>>  #include "auth.h"
> >> >>> @@ -137,6 +138,61 @@ static inline __be32 check_pseudo_root(struct=20
> >> >>> dentry *dentry,
> >> >>>  	return nfs_ok;
> >> >>>  }
> >> >>>
> >> >>> +/*
> >> >>> + * Append an 8-byte MAC to the filehandle hashed from the server's =

> >> >>> fh_key:
> >> >>> + */
> >> >>> +static int fh_append_mac(struct svc_fh *fhp, struct net *net)
> >> >>> +{
> >> >>> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >> >>> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> >> >>> +	siphash_key_t *fh_key =3D nn->fh_key;
> >> >>> +	u64 hash;
> >> >>> +
> >> >>> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
> >> >>> +		return 0;
> >> >>> +
> >> >>> +	if (!fh_key) {
> >> >>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not=
=20
> >> >>> set.\n");
> >> >>> +		return -EINVAL;
> >> >>> +	}
> >> >>> +
> >> >>> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
> >> >>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d=
=20
> >> >>> would be greater"
> >> >>> +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)),=20
> >> >>> fhp->fh_maxsize);
> >> >>> +		return -EINVAL;
> >> >>> +	}
> >> >>> +
> >> >>> +	fh->fh_auth_type =3D FH_AT_MAC;
> >> >>> +	hash =3D siphash(&fh->fh_raw, fh->fh_size, fh_key);
> >> >>> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
> >> >>> +	fh->fh_size +=3D sizeof(hash);
> >> >>> +
> >> >>> +	return 0;
> >> >>> +}
> >> >>> +
> >> >>> +/*
> >> >>> + * Verify that the the filehandle's MAC was hashed from this fileha=
ndle
> >> >>> + * given the server's fh_key:
> >> >>> + */
> >> >>> +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
> >> >>> +{
> >> >>> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >> >>> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> >> >>> +	siphash_key_t *fh_key =3D nn->fh_key;
> >> >>> +	u64 hash;
> >> >>> +
> >> >>> +	if (fhp->fh_handle.fh_auth_type !=3D FH_AT_MAC)
> >> >>> +		return -EINVAL;
> >> >>> +
> >> >>> +	if (!fh_key) {
> >> >>> +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles,=20
> >> >>> fh_key not set.\n");
> >> >>> +		return -EINVAL;
> >> >>> +	}
> >> >>> +
> >> >>> +	hash =3D siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
> >> >>> +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &has=
h,=20
> >> >>> sizeof(hash));
> >> >>> +}
> >> >>> +
> >> >>>  /*
> >> >>>   * Use the given filehandle to look up the corresponding export and
> >> >>>   * dentry.  On success, the results are used to set fh_export and
> >> >>> @@ -166,8 +222,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqs=
t=20
> >> >>> *rqstp, struct net *net,
> >> >>>
> >> >>>  	if (--data_left < 0)
> >> >>>  		return error;
> >> >>> -	if (fh->fh_auth_type !=3D 0)
> >> >>> +
> >> >>> +	/* either FH_AT_NONE or FH_AT_MAC */
> >> >>> +	if (fh->fh_auth_type > 1)
> >> >>>  		return error;
> >> >>> +
> >> >>>  	len =3D key_len(fh->fh_fsid_type) / 4;
> >> >>>  	if (len =3D=3D 0)
> >> >>>  		return error;
> >> >>> @@ -237,9 +296,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqs=
t=20
> >> >>> *rqstp, struct net *net,
> >> >>>
> >> >>>  	fileid_type =3D fh->fh_fileid_type;
> >> >>>
> >> >>> -	if (fileid_type =3D=3D FILEID_ROOT)
> >> >>> +	if (fileid_type =3D=3D FILEID_ROOT) {
> >> >>>  		dentry =3D dget(exp->ex_path.dentry);
> >> >>> -	else {
> >> >>> +	} else {
> >> >>> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
> >> >>> +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
> >> >>> +			goto out;
> >> >>> +		}
> >> >>> +
> >> >>>  		dentry =3D exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
> >> >>>  						data_left, fileid_type, 0,
> >> >>>  						nfsd_acceptable, exp);
> >> >>> @@ -495,6 +559,9 @@ static void _fh_update(struct svc_fh *fhp, struc=
t=20
> >> >>> svc_export *exp,
> >> >>>  		fhp->fh_handle.fh_fileid_type =3D
> >> >>>  			fileid_type > 0 ? fileid_type : FILEID_INVALID;
> >> >>>  		fhp->fh_handle.fh_size +=3D maxsize * 4;
> >> >>> +
> >> >>> +		if (fh_append_mac(fhp, exp->cd->net))
> >> >>> +			fhp->fh_handle.fh_fileid_type =3D FILEID_INVALID;
> >> >>>  	} else {
> >> >>>  		fhp->fh_handle.fh_fileid_type =3D FILEID_ROOT;
> >> >>>  	}
> >> >>> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> >> >>> index 5ef7191f8ad8..7fff46ac2ba8 100644
> >> >>> --- a/fs/nfsd/nfsfh.h
> >> >>> +++ b/fs/nfsd/nfsfh.h
> >> >>> @@ -59,6 +59,9 @@ struct knfsd_fh {
> >> >>>  #define fh_fsid_type		fh_raw[2]
> >> >>>  #define fh_fileid_type		fh_raw[3]
> >> >>>
> >> >>> +#define FH_AT_NONE		0
> >> >>> +#define FH_AT_MAC		1
> >> >>
> >> >> I'm pleased at how much this patch has shrunk since v1.
> >> >>
> >> >> This might not be an actionable review comment, but help me understand
> >> >> this particular point. Why do you need both a sign_fh export option
> >> >> and a new FH auth type? Shouldn't the server just look for and
> >> >> validate FH signatures whenever the sign_fh export option is
> >> >> present?
> >> >=20
> >> > ...and also generate valid signatures on outgoing file handles.
> >> >=20
> >> > What does the server do to "look for" an FH signature so that it can
> >> > "validate" it?  Answer: it inspects the fh_auth_type to see if it is
> >> > FT_AT_MAC.=20
> >>=20
> >> No, NFSD checks the sign_fh export option. At first glance the two
> >> seem redundant, and I might hesitate to inspect or not inspect
> >> depending on information content received from a remote system. The
> >> security policy is defined precisely by the "sign_fh" export option I
> >> would think?
> >
> > So maybe you are thinking that, when sign_fh, is in effect - nfsd
> > could always strip off the last 8 bytes, hash the remainder, and check
> > the result matches the stripped bytes.
>=20
> I=E2=80=99m wondering why there is both =E2=80=94 the purpose of having the=
se two
> seemingly redundant signals is worth documenting. There was some
> discussion a few days ago about whether the root FH could be signed
> or not. I thought for a moment or two that maybe when sign_fh is
> enabled, there will be one or more file handles on that export that
> won=E2=80=99t have a signature, and FT_AT_NONE would set those apart
> from the signed FHs. Again, I=E2=80=99d like to see that documented if that=
 is
> the case.

I would document it as:

 sign_fh is needs to configure server policy
 FT_AT_MAC, while technically redundant with sign_fh, is valuable
  whehn interpreting NFS packet captures.

>=20
> In addition, I=E2=80=99ve always been told that what comes off the network
> is completely untrusted. So, I want some assurance that using the
> incoming FH=E2=80=99s auth type as part of the decision to check the signat=
ure
> conforms with known best practices.
>=20
> > Another reason is that it helps people who are looking at network
> > packets captures to try to work out what is going wrong.
> > Seeing a flag to say "there is a signature" could help.
>=20
> Sure. But unconditionally trusting that flag is another question.

By the time the code has reached this point it has already
unconditionally trusted the RPC header, the NFS opcode, the '1' in
fh_version, the fh_fsid_type and the fsid itself.

Going further to trust fh_auth_type to the extent that we reject the
request if it is 0, and check the MAC if it is 1 - is not significant.

NeilBrown


