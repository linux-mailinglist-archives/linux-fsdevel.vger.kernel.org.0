Return-Path: <linux-fsdevel+bounces-64086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53ABD77B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 07:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2F2E34AC11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254E229ACF7;
	Tue, 14 Oct 2025 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Aw5R92ec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o/btPEZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89EC1D6DB5;
	Tue, 14 Oct 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420899; cv=none; b=TDUtUEEVfngwsm/qXesMhGZ7SxPXZh5FuGRVGOtAR5w6CUI6uZW/MVpqZSQMwpfJzTyBlSX21Wu6j2HUSWGWoide+dmGqB0/RsoMMeW6W6rQ3r7WcxrrWVYrtEHQB8u6HBGkvAlyUpjiw0PfzbumuyJWn2n4zM0KLD/j4a4THp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420899; c=relaxed/simple;
	bh=uegBLj59RJQhWXj6mlxI9NQJtvv1PvtnctEltpmrOTY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rOUNicLja2B+vmbPd3bZ3T8jREEsVo1e3bT8sulwDhFsJSslRsL6R58qBR5WDNzBlZJe/2xT8vuUDLPuhTpjnTX66QkBXfp0c6OqmRySk7hgzEU/fjql7Lr8TOTQdbBu07QcC/YGfVKwn96jsK/LOMO7Mz+nlNImFsxRMKgMm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Aw5R92ec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o/btPEZQ; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id E88CE130001D;
	Tue, 14 Oct 2025 01:48:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 14 Oct 2025 01:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760420895; x=1760428095; bh=rOMKmFAm0WYZgl5MX5scSy1m5wik2x9mcuD
	tQFlTYLs=; b=Aw5R92eccAEyJrtqxi1RTOFXajVvHzlm4Eo2W1B7CJTwUduK5MT
	zgZX9m1yexKNJy/QCC7qOr+xjb+eb9FQO9KtM4bzhm3rBxuCAC7RD+/qbErnWVNx
	WzIzJlIMHGcGQ7ID6ost8tmDw5YfcvjBa46wnmB0rhzWAFSB1DDcsL4fG22q9zre
	YgToglnSlnQAPV/qTZw3r57RhVcGGhiL0jO+pL6uX0H9GrTN8T8fOAh8THII0CcR
	q+b1AsgEd4hii7jCLaTYMTrvn31SQc8qPNglPErSk6kpzrKlV8zN9n9W1jXwa3zZ
	3RMarB9cNFW9xKHoWt+ErfDmKhByi+R6paA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760420895; x=
	1760428095; bh=rOMKmFAm0WYZgl5MX5scSy1m5wik2x9mcuDtQFlTYLs=; b=o
	/btPEZQM6HQFqW+n0XO+WzOYpQd+7umSu6b3JOXOG4Xy9j/BqgL3bANljKs5BYdI
	Cctp+GRKBjaV6gDXfN9qlFFjbfYYWg4uoWAoFtmvbRBZmo5mmZrqiEqZy2mHuBz6
	wbRU94VcgXG1bOd55u9GITmnOP6/nKT7DMp5qyPgUoXHud+kyuFOlb4iPptRSoNI
	navi1IrfkgvOcgf2N24dGy1Uc9r+ELVCb4FdODKrx13LjROZElXIyxfYCYYYG7Cb
	Z4uZ9EU3uR/4o2heTutxqQn8gbkZliFqxRIWTYkHrHwxg9mRtksFLd6SxnTAjAme
	xwtJJ0oWJDCq6XX7skX0Q==
X-ME-Sender: <xms:H-TtaFJiME1Wr32XX27p5xp-hYn9E87GLO3-mJ8Odh7m_vhaFUeIeg>
    <xme:H-TtaALqEJaS09U585MN_ydfOCav44M7MQmpUbB-BXYzWVXwpeHJrIzQP6M1bSXcI
    522au_IT4RRn6s_V3cUu4f_C3VoEEm1jRRA2y_3eLQ3fj59Yg>
X-ME-Received: <xmr:H-TtaF8G8LwTXDM9Z2qIQKXw46dp1dc6HTY2mBQaCAobzJU7fxzW8soTOmY3cFGQgk2pKLaBzFhH1YuTQQi9vtuxRLlBwlD8VovL56ZBftzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeljeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvggtrhihphhtfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:H-TtaCwm8n5GoDWIJqcDj30FEpvpKSlL7xhdRYKYjkDOJZSwiQ_ygw>
    <xmx:H-TtaF_fluZhrXLP0cldynUm31pJI37d-3hORrSMQFrPrTHyJsboOw>
    <xmx:H-TtaGiFLmuX43K9Wpqo7vld6I146MTKS8MY6givHf_ph47qxRL3SA>
    <xmx:H-TtaHPCM2MJ2cmkPiKr7wNINbGqxeu-bNlZBzwsmuQ8-dO_GlZWUg>
    <xmx:H-TtaFnaFSlRAZiHAv6p5eBEN_hXXg4XBN7Pwkp6eBOp1VVSVtvZ5qZ5>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 01:48:04 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>, "Tom Talpey" <tom@talpey.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>,
 "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH 12/13] nfsd: check for delegation conflicts vs. the same client
In-reply-to: <20251013-dir-deleg-ro-v1-12-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>,
 <20251013-dir-deleg-ro-v1-12-406780a70e5e@kernel.org>
Date: Tue, 14 Oct 2025 16:48:02 +1100
Message-id: <176042088276.1793333.12640300967459688183@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 14 Oct 2025, Jeff Layton wrote:
> RFC 8881 requires that the server reply with GDD_UNAVAIL when the client

GDD4_UNAVAIL.  Then "git grep" finds it for me.

NeilBrown


> requests a directory delegation that it already holds.
>=20
> When setting a directory delegation, check that the client associated
> with the stateid doesn't match an existing delegation. If it does,
> reject the setlease attempt.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b06591f154aa372db710e071c69260f4639956d7..011e336dfd996daa82b706c3536=
628971369fb10 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -88,6 +88,7 @@ void nfsd4_end_grace(struct nfsd_net *nn);
>  static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpnt=
f_state *cps);
>  static void nfsd4_file_hash_remove(struct nfs4_file *fi);
>  static void deleg_reaper(struct nfsd_net *nn);
> +static bool nfsd_dir_may_setlease(struct file_lease *new, struct file_leas=
e *old);
> =20
>  /* Locking: */
> =20
> @@ -5550,6 +5551,31 @@ static const struct lease_manager_operations nfsd_le=
ase_mng_ops =3D {
>  	.lm_change =3D nfsd_change_deleg_cb,
>  };
> =20
> +static const struct lease_manager_operations nfsd_dir_lease_mng_ops =3D {
> +	.lm_breaker_owns_lease =3D nfsd_breaker_owns_lease,
> +	.lm_break =3D nfsd_break_deleg_cb,
> +	.lm_change =3D nfsd_change_deleg_cb,
> +	.lm_may_setlease =3D nfsd_dir_may_setlease,
> +};
> +
> +static bool
> +nfsd_dir_may_setlease(struct file_lease *new, struct file_lease *old)
> +{
> +	struct nfs4_delegation *od, *nd;
> +
> +	/* Only conflicts with other nfsd dir delegs */
> +	if (old->fl_lmops !=3D &nfsd_dir_lease_mng_ops)
> +		return true;
> +
> +	od =3D old->c.flc_owner;
> +	nd =3D new->c.flc_owner;
> +
> +	/* Are these for the same client? No bueno if so */
> +	if (od->dl_stid.sc_client =3D=3D nd->dl_stid.sc_client)
> +		return false;
> +	return true;
> +}
> +
>  static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struc=
t nfs4_stateowner *so, u32 seqid)
>  {
>  	if (nfsd4_has_session(cstate))
> @@ -5888,12 +5914,13 @@ static struct file_lease *nfs4_alloc_init_lease(str=
uct nfs4_delegation *dp)
>  	fl =3D locks_alloc_lease();
>  	if (!fl)
>  		return NULL;
> -	fl->fl_lmops =3D &nfsd_lease_mng_ops;
>  	fl->c.flc_flags =3D FL_DELEG;
>  	fl->c.flc_type =3D deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
>  	fl->c.flc_owner =3D (fl_owner_t)dp;
>  	fl->c.flc_pid =3D current->tgid;
>  	fl->c.flc_file =3D dp->dl_stid.sc_file->fi_deleg_file->nf_file;
> +	fl->fl_lmops =3D S_ISDIR(file_inode(fl->c.flc_file)->i_mode) ?
> +				&nfsd_dir_lease_mng_ops : &nfsd_lease_mng_ops;
>  	return fl;
>  }
> =20
>=20
> --=20
> 2.51.0
>=20
>=20


