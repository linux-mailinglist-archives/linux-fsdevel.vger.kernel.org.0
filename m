Return-Path: <linux-fsdevel+bounces-57015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2160B1DD93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB3F64E16B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE31233727;
	Thu,  7 Aug 2025 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="qRH5K6SV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7422A7E9;
	Thu,  7 Aug 2025 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595626; cv=none; b=WrSDN0oht0pZTyRqnexqs6nTcc0qcAaQfliwP0AwGHtNhupANjXpSronG7x8lr2rLHZ7MUuZMOdkcTwfpkbVsqlR4gawATd/+nhHjm3uo6jZB9DxCnBS6tEE3tk+E3keNlmBZUAHDs7zMMA0SECElJcXWWpFVwuO5HNvTkcLd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595626; c=relaxed/simple;
	bh=GIY1qdn1PM5w0P4lma7Rr8nZjrRaDcOt6ATOJt4BBCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1XeGCCjLNehpsF5dg5eCdrOIdBLizMsLJgosad99zQmwrlUa2wlJGVACrS397KfmLa9c3QsHkwBbyiu634yxdiDDBkZXk4clAwtKL8LWIzaLhsj+n0E2NJwoJRop9shIgQk+9jvVQ+swLIl49pQxa+LX/oebB7E1PYf7GW/2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=qRH5K6SV; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bycvL59Bwz9tKg;
	Thu,  7 Aug 2025 21:40:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754595614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIY1qdn1PM5w0P4lma7Rr8nZjrRaDcOt6ATOJt4BBCA=;
	b=qRH5K6SV3vbqelTeUTry80+DhsjX9z0ia+SlOFNhP3vY9rPmZAId0JugBp1lNG0PBjtUx5
	HP1OKzEKY6MWp8UCQPl82ZVB6W2QWsB0drUlJ3y96k+yuboFWOSvbL4bDjYr9QgOrjj2p+
	CV5AZl0+IObBjbeDXiflS4YS64uVs/yDU48IjYuiA9O0xNbEJWNe1UDeJsgOr4AK4rF0/U
	CtDTinrbf9z0sj1QFSnqLIzTKO6JnPEa0N8Ilqbbz7Og34YYk1P3g/jSZ5ClwgTRyTOD63
	NNl3XC843NAwnIjOuIeQJyFgLE+uS6zBx6VApLylzuZ5DZwCaMLtD107D+LYXA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 8 Aug 2025 05:39:56 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
Message-ID: <2025-08-07.1754595568-mashed-snarl-jubilant-aphid-little-cavities-jQYU4z@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
 <afty6mfpowwj3kzzbn3p7s4j4ovmput34dtqfzzwa57ocaita4@2jj4qandbnw3>
 <2025-08-07.1754572878-gory-flags-frail-rant-breezy-habits-pRuwdA@cyphar.com>
 <zax5dst65kektsdjgvktpfxmwppzczzl7t2etciywpkl2ywmib@u57e6fkrddcw>
 <2025-08-07.1754576582-puny-spade-blotchy-axiom-winking-overtone-AerGh5@cyphar.com>
 <20250807-intelligent-amorphous-cuscus-1caae0@lemur>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sqyza6k3fknmmvcd"
Content-Disposition: inline
In-Reply-To: <20250807-intelligent-amorphous-cuscus-1caae0@lemur>
X-Rspamd-Queue-Id: 4bycvL59Bwz9tKg


--sqyza6k3fknmmvcd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
MIME-Version: 1.0

On 2025-08-07, Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> On Fri, Aug 08, 2025 at 12:26:48AM +1000, Aleksa Sarai wrote:
> > Konstantin, would you be interested in a patch to add --range-diff to
> > the trailing bits of cover letters? I would guess that b4 already has
> > all of the necessary metadata to reference the right commits.
> >=20
> > It seems like a fairly neat way of providing some more metadata about
> > changes between patchsets, for folks that care about that information.
>=20
> It's already there, just add ${range_diff} to your cover letter template.

Oh, my bad... Time to go re-read the b4 docs again.

> Cheers,
> -K
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--sqyza6k3fknmmvcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJUBDAAKCRAol/rSt+lE
b6aDAP9yUM45QSPNINledCMHUgwPFBD42aeCN7RwpdpJiKw80QD/ecmfBwZxBsax
9vIUPHP3rxg11A4IXULBstt4xFmN3Q0=
=C9vw
-----END PGP SIGNATURE-----

--sqyza6k3fknmmvcd--

