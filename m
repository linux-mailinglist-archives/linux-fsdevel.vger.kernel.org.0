Return-Path: <linux-fsdevel+bounces-61214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB61B56428
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 03:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3457AC6D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 01:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646091E260C;
	Sun, 14 Sep 2025 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Q2kD1hd3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvQD44im"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AD1DFDB8
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811917; cv=none; b=koQLCCAkLlqpqBIBIP9UHWam+Rh9HYVzFEYJibAQAnTjzH6lS0Ud+VHqO55j2LtSgS49RuiMz9KdO/JTxWiOAKCJ83srg3WZwo8DcdZ6nVenHr+6v0h9kxujAXD4CNvuALnRX0cvdj0j20zXzV1sbJEfSIdHyUhpaD574zJpFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811917; c=relaxed/simple;
	bh=r8ZHaLnirPPjbqQ5LAP2K+IOCb/YvHk2MrzfyBnZWEc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JIWbO4cZDzwtp0E2GL9A6WjYVU0flECy6ZggGC0e7LzcUjERmKQ7xxzkeTYFG6v5hunAGyvxduGNnRE/MK3e89SltUgZ3QOPDtWY8OR0it3fCXqYZwEM57L4p0Fx4NPUdCynLzfkG7WjOSvS0ooM8WeJn1QjzulihO3inQ0avpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Q2kD1hd3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvQD44im; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B5BA6EC010C;
	Sat, 13 Sep 2025 21:05:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 13 Sep 2025 21:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757811912; x=1757898312; bh=n8V1U/G2IQreF4o3nSpPJVNwsofMZ0ZQmk0
	6O8M+nFQ=; b=Q2kD1hd3KpHp3qtPprWSvc4qcDRBiYTdGQSAnM0vNvjZzsnzMpC
	OuWsSHQiiTbjImzBsvkrBdhi1Gdv8oMRlP5/EY6d1IpF3XbJOoxQbND5C3pCiQL2
	ygoYBX7JvFFYFLpFLsiCOBGfCbx4EtPNFSRBuLsMi85f3gVUUjwzsV6kSNd8zYKF
	DGmfY8pcHeO1qJl9jjm2+BQRMtxtJV1Mux33aJ25xqRS1Me/M65rla4S2Y5LZDBT
	nXIpvrtPLuDSnC8i0XkfSOSJm+YpCfs1R7B0JxLyjAqcrqZxiAqT0ybPcP3GlS3k
	twlpgesdApTcny/BNbCvJqi+IevWxzBW1Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757811912; x=
	1757898312; bh=n8V1U/G2IQreF4o3nSpPJVNwsofMZ0ZQmk06O8M+nFQ=; b=V
	vQD44imQ1JeOezuSJXn+ZG3M1VGxHMBI+FUZ/lLkInmcpMcJctc7ITeKtNMiOZer
	ZpF/fMPPdBMpqWg30hapnvjI0HV2xg+/eomG3jynRur1/jVhz304gUs7ul4x9FlW
	TVXg8ryu5c0WIRjCneADR41OGZczYRB/1+0+jeFHSl7GSxuKSh8VI+Dw4HKDRci4
	+ukUuwyCJFpclCPYW5MHGM0aqmhhtXJZv8HkGuad9RLthz/M1Y9oDqMGyo3rlh1w
	szG6Wvaqn/7ilCuvKZLivFEOXd2GA6JSU1XUH7espCqJimT3s/utaFa/lolZik/L
	vAcRIHaidKsz2kzZKmWkg==
X-ME-Sender: <xms:yBTGaLJ8HDRFnqWKSJwJYRT9FcMO4jf23dneSRezS2mLZcX8SAPI2Q>
    <xme:yBTGaGh6SSbqJ6tIrmo_aLUi01qAyEqvx3WiSuyKyPbTHvpDKX-QvXZQLGksoBR8O
    uw2g80fp_hY5w>
X-ME-Received: <xmr:yBTGaJSS8FeO6CNiK4icnmewh9nij8AUvYR01JTf9NVbGAp2W2FhxiXm00gEbzXhSBWLrnLxbNBbv25eRnbgtJPnbZ9djDnmydrLoAZkDJzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepthhrohhnughm
    hieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:yBTGaAU90_gCSqhZgQfokGvwu5OTKXZVduRVjKUkbGQRrltHJxj-dg>
    <xmx:yBTGaFTnDuCwXL0QNnD-cKn1zqAnYaTSsZ1ClUgsDv7OecTu8teAAg>
    <xmx:yBTGaCnLUitMYtD-5ucUh1YpYX-K3FdMEo2FDzp9mHrkzoEQF1agsQ>
    <xmx:yBTGaD624P5v6WVRA2-biB5aov2dCap97hx_8h3S2a5ReFmhc_QzYw>
    <xmx:yBTGaJgnj9yGR5cMhvpdrbI-HK_kiV5DyD8ZuLE7E_Pjy5PnEu-HR6Pg>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 21:05:10 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>, Trond Myklebust <trondmy@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Jan Kara" <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
In-reply-to: <20250913212815.GE39973@ZenIV>
References: <>, <20250908051951.GI31600@ZenIV>,
 <175731272688.2850467.5386978241813293277@noble.neil.brown.name>,
 <20250908090557.GJ31600@ZenIV>, <20250913212815.GE39973@ZenIV>
Date: Sun, 14 Sep 2025 11:05:08 +1000
Message-id: <175781190836.1696783.10753790171717564249@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 14 Sep 2025, Al Viro wrote:
> On Mon, Sep 08, 2025 at 10:05:57AM +0100, Al Viro wrote:
>=20
> > > Fudging some type-state with C may well be useful but I suspect it is at
> > > most part of a solution.  Simplification, documentation, run-time checks
> > > might also be important parts.  As the type-state flag-day is a big
> > > thing, maybe it shouldn't be first.
> >=20
> > All of that requires being able to answer questions about what's there in
> > the existing filesystems.  Which is pretty much the same problem as
> > those audits, obviously.  And static annotations are way easier to
> > reason about.
>=20
> Speaking of annoyances, d_exact_alias() is gone, and good riddance, but the=
re's
> another fun issue in the same area - environment for d_splice_alias() call =
*and*
> for one of those d_drop()-just-in-case.
>=20
> The call tree is still the same:
> _nfs4_open_and_get_state()
> 	<- _nfs4_do_open()
> 		<- nfs4_do_open()
> 			<- nfs4_atomic_open()
> 				=3D=3D nfs_rpc_ops:open_context
> 					<- nfs_atomic_open()
> 						=3D=3D ->atomic_open
> 					<- nfs4_file_open()
> 						=3D=3D ->open
> 			<- nfs4_proc_create()
> 				=3D=3D nfs_rpc_ops:create
> 					<- nfs_do_create()
> 						<- nfs_create()
> 							=3D=3D ->create
> 						<- nfs_atomic_open_v23(), with O_CREAT
> 							=3D=3D ->atomic_open
> 							# won't reach nfs4 stuff?
>=20
> ->create() and ->atomic_open() have the parent held at least shared;
> ->open() does not, but the chunk in question is hit only if dentry
> is negative, which won't happen in case of ->open().
>=20
> Additional complication comes from the possibility for _nfs4_open_and_get_s=
tate()
> to fail after that d_splice_alias().  In that case we have _nfs4_do_open()
> return an error; its caller is inside a do-while loop in nfs4_do_open() and
> I think we can't end up going around the loop after such late failure (the
> only error possible after that is -EACCES/-NFS4ERR_ACCESS and that's not one
> of those that can lead to more iterations.
>=20
> 	However, looking at that late failure, that's the only call of
> nfs4_opendata_access(), and that function seems to expect the possibility
> of state->inode being a directory; can that really happen?

No that cannot happen.  In the NFSv4 protocol, OPEN is only used for
files.
Directories use the same model as v3 where you pass a filehandle to
READDIR without establishing and "open" state.

Why do you think nfs4_opendata_access() expects the possibilty of a
directory?  The purpose of the function is to handle to Posix weirdness
around being able to exec() a file that you cannot read().  Over NFS the
client needs to be able to read a file in order to execute it, so NFS
blurs the two permissions together.  This function is check which
permission was asked for and then checking access permissions to make
sure it is allowed.  i.e.  the server might let the client read the file
storing the application, but the client might not let the application be
run.


>=20
> 	Because if it can, we have a problem:
>                 alias =3D d_splice_alias(igrab(state->inode), dentry);
>                 /* d_splice_alias() can't fail here - it's a non-directory =
*/
>                 if (alias) {
>                         dput(ctx->dentry);
>                         ctx->dentry =3D dentry =3D alias;
>                 }
> very much *can* fail if it's reached with state->inode being a directory -
> we can get ERR_PTR() out of that d_splice_alias() and that will oops at
>=20
>         if (d_inode(dentry) =3D=3D state->inode)
>                 nfs_inode_attach_open_context(ctx);
> shortly afterwards (incidentally, what is that check about?  It can only
> fail in case of nfs4_file_open(); should we have open(2) succeed in such
> situation?)

I don't know what is going on here.
Based on the commit that introduced this code

Commit: c45ffdd26961 ("NFSv4: Close another NFSv4 recovery race")

there is presumably some race that can cause the test to fail.
Maybe Trond (cc:ed) could help explain.

NeilBrown

>=20
> Sigh...
>=20


