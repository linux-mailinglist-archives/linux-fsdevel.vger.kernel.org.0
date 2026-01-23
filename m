Return-Path: <linux-fsdevel+bounces-75327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGWTD64GdGkM1gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:39:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA807B83A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8FC03013788
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1192EA15C;
	Fri, 23 Jan 2026 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="O+ab5QIA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g732HcvJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34A3009FA;
	Fri, 23 Jan 2026 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769211554; cv=none; b=eFJR4qHy9avmlwan6dIKWQR8zTph3/OzknbpngKtXTHY3Umxb1nMxpNpIsQN2sZGDoviXOlbjyNwb+Xfi9My8w1TERdzYAgunu87q25/RWXiclv97kgn3h+jt1R784H8Vh67VdFHRrTTihIqDGS8TYywA3k1OZUem+GSZHfNzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769211554; c=relaxed/simple;
	bh=Gl5Beitxina184zGs9g94xTjTrsWcascAuDMd/mzKzc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cUBT4bsB4fVu26KQ26FFVGn9TXeONZ2SyIkAXAeccLRIYdZgfYFYp9z3QVZjJIo35g74UvxtaEz9n56dI3bPmdH6H0aCRaKvtnSrmMJ63QygVgkVcgs/i2Os9WLfsdIDjB/Ls6uhjvHiSJwg5JlAeLG/zS3IICM5PFUsPkvCqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=O+ab5QIA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g732HcvJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17F2B14000E9;
	Fri, 23 Jan 2026 18:38:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Jan 2026 18:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769211538; x=1769297938; bh=Wg6YyJm2qNl6d1/dYOiDgJyw6CNSoDEsGwv
	tcbrPMbA=; b=O+ab5QIADvCzRPJ9l6TrlmTXqAYqjK15raP7WgNgiNAOwrFtPQI
	xTKeEZ9qWkPbQ0JSTVRoUwkLx9uMbQr6Srt4zMHtKfTnKxcmIR5Mm7jZ/DdNeKrb
	EwQ5rnbntOkc/CQWsA/rnFAWdQshVB4JK7FAv01DUFKKokMugJxAoZzWdKz0q6Kk
	Vv0UGmUjpwBEJsL3B5RP0tak33wUlixq4PNT8g3zy0w96fmAZ2txekX9YKPOBUAw
	olzhLbSCwTtGThAZlX40VxPouwJSPD68WANO5XphiX+kpvknYVpypJR68PxP/0bK
	YW6SXycOe8sNoDBDFTp7YtiZBxKKrpFJTXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769211538; x=
	1769297938; bh=Wg6YyJm2qNl6d1/dYOiDgJyw6CNSoDEsGwvtcbrPMbA=; b=g
	732HcvJKOMZD5UQjodyElWQUJPfHm2cONps9oOvTeUwoI82c6UU/1FbsJZaNuqAN
	9D/khZ3RUSiHVY5QnC5wimK1RYeKWY9PxWn4mvWbVXX2k4+IVQpWj7NBy7Mb29OF
	lvmFjMEqP2g9joYoAQuLmt465e4B0Yb5iIvaB/abbCd2+4jy3DcqUKJT6BgiGHmn
	RMYRQP9GCb0QP9nERIpjIm1K3CunUHmJNULvuOb+ngqkaG08uGiNmpPCBVSoCZiG
	RGOEzQTemZb+oKtc23sg3ciFDs8ykbJuX/z/KivXLdC+VgA6OkaHuDNKpjeiVGJ7
	3LebexGiq5wixLcoE/eew==
X-ME-Sender: <xms:kQZ0aZzxXZ3fMSP7VpO2gdNOz8jQ_u5ajN-E7JV7V3cRNb6Vz_6Tfw>
    <xme:kQZ0aYcirTtbnVlYsaECHdAAqhq0Nq75umb89ULf74fClLXJmj3PyJgt0P8HevRlo
    eHzzKv86JdEnWtKfz6tiDB17euPQJ4PXaZacN86CmccAwuHhQ>
X-ME-Received: <xmr:kQZ0aWBoYplmGtKwXP0KJf2L_7yFjLO89gHlM9--Z61WaKGOdgdEf9BAgc9Cu2UEX-O0UBfquDe-18Xf-vfpi7KuOTsqGTog7OqlzjknB1xi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtfeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:kQZ0aU7qfflDzFiTLHe6HfBvtDIhiLlNrh-zjjzgLTUAija58SMgiw>
    <xmx:kQZ0aXcUtTFFU0j-pGEw9CA62HKYGApk8LuHW3BWg8xFY-5ajLeqjA>
    <xmx:kQZ0aSs3uzA9euy2T0QLiHxDkKIjnwSDNfHh-Zazo0_MRKX5nS9wzg>
    <xmx:kQZ0afnw6UO8p975iUATtZNyRhRhxmUj341HxVZoJVkfHwxEFgZwlQ>
    <xmx:kgZ0aT9u3Q04HfJD3GXwwlMMi9wSgC0N_cneZH931JdjoM32QTZf7vKN>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 18:38:54 -0500 (EST)
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
In-reply-to: <8d024335-7be0-48f3-80d3-99bd85b6386b@kernel.org>
References: <cover.1769026777.git.bcodding@hammerspace.com>, =?utf-8?q?=3C0a?=
 =?utf-8?q?aa9ca4fd3edc7e0d25433ad472cb873560bf7d=2E1769026777=2Egit=2Ebcodd?=
 =?utf-8?q?ing=40hammerspace=2Ecom=3E=2C?=
 <5fb38378-a8e0-46d5-956c-de1a3bdaaf23@app.fastmail.com>,
 <176920688733.16766.188886135069880896@noble.neil.brown.name>,
 <8d024335-7be0-48f3-80d3-99bd85b6386b@kernel.org>
Date: Sat, 24 Jan 2026 10:38:52 +1100
Message-id: <176921153233.16766.17284825218875728993@noble.neil.brown.name>
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
	TAGGED_FROM(0.00)[bounces-75327-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,noble.neil.brown.name:mid,ownmail.net:dkim,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFA807B83A
X-Rspamd-Action: no action

On Sat, 24 Jan 2026, Chuck Lever wrote:
> On 1/23/26 5:21 PM, NeilBrown wrote:
> > On Sat, 24 Jan 2026, Chuck Lever wrote:
> >>
> >> On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
> >>> NFS clients may bypass restrictive directory permissions by using
> >>> open_by_handle() (or other available OS system call) to guess the
> >>> filehandles for files below that directory.
> >>>
> >>> In order to harden knfsd servers against this attack, create a method to
> >>> sign and verify filehandles using siphash as a MAC (Message Authenticat=
ion
> >>> Code).  Filehandles that have been signed cannot be tampered with, nor =
can
> >>> clients reasonably guess correct filehandles and hashes that may exist =
in
> >>> parts of the filesystem they cannot access due to directory permissions.
> >>>
> >>> Append the 8 byte siphash to encoded filehandles for exports that have =
set
> >>> the "sign_fh" export option.  The filehandle's fh_auth_type is set to
> >>> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles receive=
d from
> >>> clients are verified by comparing the appended hash to the expected has=
h.
> >>> If the MAC does not match the server responds with NFS error _BADHANDLE.
> >>> If unsigned filehandles are received for an export with "sign_fh" they =
are
> >>> rejected with NFS error _BADHANDLE.
> >>>
> >>> Link:=20
> >>> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammers=
pace.com
> >>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> >>> ---
> >>>  fs/nfsd/nfsfh.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
> >>>  fs/nfsd/nfsfh.h |  3 ++
> >>>  2 files changed, 73 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> >>> index ed85dd43da18..ea3473acbf71 100644
> >>> --- a/fs/nfsd/nfsfh.c
> >>> +++ b/fs/nfsd/nfsfh.c
> >>> @@ -11,6 +11,7 @@
> >>>  #include <linux/exportfs.h>
> >>>
> >>>  #include <linux/sunrpc/svcauth_gss.h>
> >>> +#include <crypto/utils.h>
> >>>  #include "nfsd.h"
> >>>  #include "vfs.h"
> >>>  #include "auth.h"
> >>> @@ -137,6 +138,61 @@ static inline __be32 check_pseudo_root(struct=20
> >>> dentry *dentry,
> >>>  	return nfs_ok;
> >>>  }
> >>>
> >>> +/*
> >>> + * Append an 8-byte MAC to the filehandle hashed from the server's=20
> >>> fh_key:
> >>> + */
> >>> +static int fh_append_mac(struct svc_fh *fhp, struct net *net)
> >>> +{
> >>> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >>> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> >>> +	siphash_key_t *fh_key =3D nn->fh_key;
> >>> +	u64 hash;
> >>> +
> >>> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
> >>> +		return 0;
> >>> +
> >>> +	if (!fh_key) {
> >>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not=20
> >>> set.\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
> >>> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d=20
> >>> would be greater"
> >>> +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)),=20
> >>> fhp->fh_maxsize);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	fh->fh_auth_type =3D FH_AT_MAC;
> >>> +	hash =3D siphash(&fh->fh_raw, fh->fh_size, fh_key);
> >>> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
> >>> +	fh->fh_size +=3D sizeof(hash);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +/*
> >>> + * Verify that the the filehandle's MAC was hashed from this filehandle
> >>> + * given the server's fh_key:
> >>> + */
> >>> +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
> >>> +{
> >>> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >>> +	struct knfsd_fh *fh =3D &fhp->fh_handle;
> >>> +	siphash_key_t *fh_key =3D nn->fh_key;
> >>> +	u64 hash;
> >>> +
> >>> +	if (fhp->fh_handle.fh_auth_type !=3D FH_AT_MAC)
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (!fh_key) {
> >>> +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles,=20
> >>> fh_key not set.\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	hash =3D siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
> >>> +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, =

> >>> sizeof(hash));
> >>> +}
> >>> +
> >>>  /*
> >>>   * Use the given filehandle to look up the corresponding export and
> >>>   * dentry.  On success, the results are used to set fh_export and
> >>> @@ -166,8 +222,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst=20
> >>> *rqstp, struct net *net,
> >>>
> >>>  	if (--data_left < 0)
> >>>  		return error;
> >>> -	if (fh->fh_auth_type !=3D 0)
> >>> +
> >>> +	/* either FH_AT_NONE or FH_AT_MAC */
> >>> +	if (fh->fh_auth_type > 1)
> >>>  		return error;
> >>> +
> >>>  	len =3D key_len(fh->fh_fsid_type) / 4;
> >>>  	if (len =3D=3D 0)
> >>>  		return error;
> >>> @@ -237,9 +296,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst=20
> >>> *rqstp, struct net *net,
> >>>
> >>>  	fileid_type =3D fh->fh_fileid_type;
> >>>
> >>> -	if (fileid_type =3D=3D FILEID_ROOT)
> >>> +	if (fileid_type =3D=3D FILEID_ROOT) {
> >>>  		dentry =3D dget(exp->ex_path.dentry);
> >>> -	else {
> >>> +	} else {
> >>> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
> >>> +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
> >>> +			goto out;
> >>> +		}
> >>> +
> >>>  		dentry =3D exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
> >>>  						data_left, fileid_type, 0,
> >>>  						nfsd_acceptable, exp);
> >>> @@ -495,6 +559,9 @@ static void _fh_update(struct svc_fh *fhp, struct=20
> >>> svc_export *exp,
> >>>  		fhp->fh_handle.fh_fileid_type =3D
> >>>  			fileid_type > 0 ? fileid_type : FILEID_INVALID;
> >>>  		fhp->fh_handle.fh_size +=3D maxsize * 4;
> >>> +
> >>> +		if (fh_append_mac(fhp, exp->cd->net))
> >>> +			fhp->fh_handle.fh_fileid_type =3D FILEID_INVALID;
> >>>  	} else {
> >>>  		fhp->fh_handle.fh_fileid_type =3D FILEID_ROOT;
> >>>  	}
> >>> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> >>> index 5ef7191f8ad8..7fff46ac2ba8 100644
> >>> --- a/fs/nfsd/nfsfh.h
> >>> +++ b/fs/nfsd/nfsfh.h
> >>> @@ -59,6 +59,9 @@ struct knfsd_fh {
> >>>  #define fh_fsid_type		fh_raw[2]
> >>>  #define fh_fileid_type		fh_raw[3]
> >>>
> >>> +#define FH_AT_NONE		0
> >>> +#define FH_AT_MAC		1
> >>
> >> I'm pleased at how much this patch has shrunk since v1.
> >>
> >> This might not be an actionable review comment, but help me understand
> >> this particular point. Why do you need both a sign_fh export option
> >> and a new FH auth type? Shouldn't the server just look for and
> >> validate FH signatures whenever the sign_fh export option is
> >> present?
> >=20
> > ...and also generate valid signatures on outgoing file handles.
> >=20
> > What does the server do to "look for" an FH signature so that it can
> > "validate" it?  Answer: it inspects the fh_auth_type to see if it is
> > FT_AT_MAC.=20
>=20
> No, NFSD checks the sign_fh export option. At first glance the two
> seem redundant, and I might hesitate to inspect or not inspect
> depending on information content received from a remote system. The
> security policy is defined precisely by the "sign_fh" export option I
> would think?

So maybe you are thinking that, when sign_fh, is in effect - nfsd
could always strip off the last 8 bytes, hash the remainder, and check
the result matches the stripped bytes.
Yes - that could work.

Another reason is that it helps people who are looking at network
packets captures to try to work out what is going wrong.
Seeing a flag to say "there is a signature" could help.

Thanks,
NeilBrown


>=20
>=20
> >> It seems a little subtle, so perhaps a code comment somewhere could
> >> explain the need for both.
> >=20
> > /*=20
> >  * FT_AT_MAC allows the server to detect if a signature is expected
> >  * in the last 8 bytes of the file handle.
> >  */
> >=20
> > I wonder if it is really "last 8" for NFSv2 ...  or even if v2 is
> > supported.  I should check the code I guess.
>=20
> I believe NFSv2 is not supported.
>=20
>=20
> >>
> >>> +
> >>>  static inline u32 *fh_fsid(const struct knfsd_fh *fh)
> >>>  {
> >>>  	return (u32 *)&fh->fh_raw[4];
> >>> --=20
> >>> 2.50.1
> >>
> >> --=20
> >> Chuck Lever
> >>
> >=20
>=20
>=20
> --=20
> Chuck Lever
>=20


