Return-Path: <linux-fsdevel+bounces-75798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJrrNbVkemmB5gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 20:34:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126EA8314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 20:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9591E303604D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694537419B;
	Wed, 28 Jan 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="qyMe6sHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330CE1DF271;
	Wed, 28 Jan 2026 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628845; cv=none; b=SXv1HHnzgC5RehPN0IKLYJPXvT9pRrZl45OSajVg13D2pQWewvyoobMv84NEJLFPfw8GjHuhIui2CZga7UfyfLFsD3sIEM4DpYKOXdl9T1PXtDbAFzlVPdtJhJuNq9wtvB+Mzm0600dapNIdKpIi2GnnyI2TR7bUXGFogsyaqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628845; c=relaxed/simple;
	bh=E81YN0w3GVPjc+iDX0A+4oREVX4YpgEaEIg49fJXdok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM2UtVeSlfcr1/MvrI+XkxxTXu9rMgAYrN0uvJojOoTSezQBDxKLkTLh6P9vxS9KXKGZOjC83HrXlmLxxhIoBKXesigD6RHKsOmMEfvYe/A2JQrtRwJbnpbuy/nLoT2rolk+DdRsAbu3+9ZV29vaBJ0/+y45peT6t2VokHzEE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=qyMe6sHr; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f1XMf501Zz9t7s;
	Wed, 28 Jan 2026 20:26:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1769628414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vCd7H1TJ4ks7SnfKeArmFODsoCEHZ0gXvt5SKnHjEac=;
	b=qyMe6sHrmcAtAOqNng+0jevKFmvdKns49VJD1nn8ZWLKSLD7uojEW4g+39ms9kgqf9sj5T
	M9DLxAdMoyPuwR461YGficMzb1minOXC383KmRmfHjfPoRVqQ4wRDMobL4PcXU22kNTw7c
	y2zFdFYP+ndkq/FgZ0oRrJR50qV4CGawFq76XHtSql1sHvqjOA2WBrZGJDk941Kkwzmcj/
	PeWrtYx87B2gJKX2x662/CJ/ZRuI4M9dP1bk3TiQsQeZPP3gdOO2mIcb5vrMRDYXoo9+sc
	XbxtdwmInMegh87H3fh0BcJQTAS9/ndcuZFz9QQo1b1+UFTMrH+WYXmdqOT6oQ==
Date: Wed, 28 Jan 2026 20:26:48 +0100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
Message-ID: <2026-01-28-content-sandy-strife-cartels-hShKtl@cyphar.com>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com>
 <2026-01-27-awake-stony-flair-patrol-g4abX8@cyphar.com>
 <vhq3osjqs3nn764wrp2lxp66b4dxpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmls3g2k4wci75pm"
Content-Disposition: inline
In-Reply-To: <vhq3osjqs3nn764wrp2lxp66b4dxpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75798-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,arndb.de,dilger.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cyphar.com:dkim,cyphar.com:url,cyphar.com:mid]
X-Rspamd-Queue-Id: 6126EA8314
X-Rspamd-Action: no action


--pmls3g2k4wci75pm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
MIME-Version: 1.0

On 2026-01-28, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Wed, Jan 28, 2026 at 12:23:45AM +0100, Aleksa Sarai wrote:
> > In my view, this should be an openat2(2)-only API.
>=20
> fwiw +1 from me, the O_ flag situation is already terrible even without
> the validation woes.
>=20
> I find it most unfortunate the openat2 syscall reuses the O_ namespace.
> For my taste it would be best closed for business, with all new flag
> additions using a different space.

We don't have any openat2(2)-only O_* flags yet, I agree that new flag
additions (except for very rare cases where you can make them backward
compatible -- such as a hypothetical O_EMPTYPATH) should be O2_* or
OEXT_* or something.

> I can easily see people passing O_WHATEVER to open and openat by blindly
> assuming they are supported just based on the name.

Yeah, if we don't do that it'll lead to confusion. openat2(2) has
exclusive rights to the 64-bit flag bits so we could start with those
before we need to cross with the O_* flag space.

> that's a side mini-rant, too late to do anything here now
>=20
> > In addition, I would
> > propose that (instead of burning another O_* flag bit for this as a
> > special-purpose API just for regular files) you could have a mask of
> > which S_IFMT bits should be rejected as a new field in "struct
> > open_how". This would let you reject sockets or device inodes but permit
> > FIFOs and regular files or directories, for instance. This could even be
> > done without a new O_* flag at all (the zero-value how->sfmt_mask would
> > allow everything and so would work well with extensible structs), but we
> > could add an O2_* flag anyway.
>=20
> I don't think this works because the vars have overlapping bits:
>   #define S_IFBLK  0060000
>   #define S_IFDIR  0040000
>=20
> So you very much can't select what you want off of a bitmask.

Well, you can filter on S_IFCHR if you want to block both block/char
devices, but yeah the overlap is quite unfortunate... (That would also
mean blocking directories would also block S_IFBLK -- I remembered there
was an overlap but I forgot it coincided with S_IFDIR... Damn wacky
APIs.)

> At best the field could be used to select the one type you are fine with.
>=20
> If one was to pursue the idea, some other defines with unique bits would
> need to be provided. But even then, semantics should be to only *allow*
> the bits you are fine with and reject the rest.
>=20
> But I'm not at all confident this is worth any effort -- with
> O_DIRECTORY already being there and O_REGULAR proposed, is there a use
> case which wants something else?

There's also O_NOFOLLOW in a similar vein.

I can see someone wanting to permit FIFOs, regular files, and
directories being fine but blocking everything else. None of O_REGULAR,
O_DIRECTORY, nor O_NOFOLLOW provide that.

> > > +#define ENOTREG		134	/* Not a regular file */
> > > +
> >=20
> [..]
> > Then to be fair, the existence of ENOTBLK, ENOTDIR, ENOTSOCK, etc. kind
> > of justify the existence of ENOTREG too. Unfortunately, you won't be
> > able to use ENOTREG if you go with my idea of having mask bits in
> > open_how... (And what errno should we use then...? Hm.)
> >=20
>=20
> The most useful behavior would indicate what was found (e.g., a pipe).
>=20
> The easiest way to do it would create errnos for all types (EISDIR
> already exists for one), but I can't seriously propose that.

It might be kinda neat from a potential re-use perspective in other APIs
but yeah it would be quite wasteful to burn 3-5 errnos for this when we
already have ~4 that are logical inverses.

> Going the other way, EBADTYPE or something else reusable would be my
> idea.

I think that would be reasonable and if you word the error message
carefully you can even see it being a fairly generic errno for other
places to use.

--=20
Aleksa Sarai
https://www.cyphar.com/

--pmls3g2k4wci75pm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaXpi9BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG//4QEA7qu8ZDfJ003C5x6tfJ6V
9CNBG+pF0IuGbN1cwc53KlwBAMvdkb3wXqrCh1sJ07UQKE+BF+3sc8tK9QIJVXPP
NX0F
=fMeG
-----END PGP SIGNATURE-----

--pmls3g2k4wci75pm--

