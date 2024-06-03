Return-Path: <linux-fsdevel+bounces-20790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D418D7C6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 09:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C671B225BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9984482E2;
	Mon,  3 Jun 2024 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RGGnHXMh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6E94EB51
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399498; cv=none; b=FeUO16SPpiHMudGURLwhF4in6wt97HCtljWGJ9rtxc/bx0+UyvfCDKPRYBUIRWvqJzGG7O6X9oSqwXx0Q6udsWCP8Jz4+ZMkRfXeEx9x94DDwDM23iPyuU95WpDdxp9FgbzCA5gPC0glK5Y+HFSDs7GzfBG0UxpKZw10GVXn9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399498; c=relaxed/simple;
	bh=MMSanncrp/6sHc+FstGi0yx7PbgnY74Rsicjkp0BGFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORsK974rAjA40VaF8eOwwK7C5wkCJ941FCYlhimAIq1uPHGdLfsc3RtRmB5/uqrgb4gFtBihuaGpMmMkP39PosKgmum0qxYUwRdfmYMWbVR33FBjHP/RHFo3nzGWrZu/t4oAoj49MXbw1arLyMXJz+fRNB0WNVpqalmxLekP2CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RGGnHXMh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=MMSa
	nncrp/6sHc+FstGi0yx7PbgnY74Rsicjkp0BGFY=; b=RGGnHXMh6QLX6orEcadl
	amLGnMcGYcaT6VBOeFbLrovvvrO6ZgBJng4oCuB3H+rxCz4/LCTSKgphySIo0stM
	gJE0sxjG4MLsjJq61L9C5fub0KZSBHPo92nc3gsSST4kcB+xsOwEhCgJP/WKLq9E
	qbGrXwCrAAvf30lWoaA1BsEEs/kmMjIOKo77SvXscOTxnwCJtz3j+p4gERJrMjHy
	PRh7HmJCmoKK8RnqdlUad8awF9Nimw2MSTkAuu6Wqzx8y25yEFNElW6V52qtzsff
	ov6kvmztdLE4PtZFlbfZlfOusHMxO2gk9VIx1Lduh0Gh64Xo8ofajjYUl4OMtItE
	wA==
Received: (qmail 1864745 invoked from network); 3 Jun 2024 09:24:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 09:24:50 +0200
X-UD-Smtp-Session: l3s3148p1@wnqQOvcZAIAgAwDPXzLGAH1eNELjOc3g
Date: Mon, 3 Jun 2024 09:24:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-renesas-soc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Howells <dhowells@redhat.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
Message-ID: <nr46caxz7tgxo6q6t2puoj36onat65pt7fcgsvjikyaid5x2lt@gnw5rkhq2p5r>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Christian Brauner <brauner@kernel.org>, Eric Sandeen <sandeen@redhat.com>, 
	linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <20240527100618.np2wqiw5mz7as3vk@ninjato>
 <20240527-pittoresk-kneipen-652000baed56@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkspjckpbjuf2tis"
Content-Disposition: inline
In-Reply-To: <20240527-pittoresk-kneipen-652000baed56@brauner>


--xkspjckpbjuf2tis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Does that fix it for you?
> >=20
> > Yes, it does, thank you.
> >=20
> > Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Thanks, applied. Should be fixed by end of the week.

It is in -next but not in rc2. rc3 then?


--xkspjckpbjuf2tis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZdb70ACgkQFA3kzBSg
KbZkJhAAoj5KbUejwU9YyeAk7sGJ8tfd/3ZOjyGc6Y9EHGp4Lv53qOwXCtoJdiqU
jMbq8dBC3CXTAvKwSugsUG73nbxiYct0B6GNFVGu31s0BfMwiarrU+Wo98PB/w8H
vpPaZ51lGOmUbAoojm0HkfC9UOrO8tSlrvzs6YXNJXS+RO70p/dUFEQzzOQhORuN
g+xuliNgWR7Fpp2lqzUQZEckRyaRqLB35jGhCZBOuFJcB2xrDkGU+htN4s/r8Edt
6AUh7IBw0uuQgFWJoMDHlhMMDswymVcdYK7IKN7w5T1c3h+zMdE45W+rNoISMrP/
ThvkK2Lrt0xGJJLURGAoiLbQrON6p+9yQZwOiA/k9ULYz+hRxrPJE8l8XVPZ2Grb
9T07N9FB2IdeUBtTDqZ81Ei+hccLbrgX9YwWV23R8I8vZrWV8fIPQgY5pRKqAMaO
VUZAcZJEB0sYjVcoRiXIiLSX80dXe5rzrnf49D0PHMEk9GCP399TkFhmVrXiQAS3
3F4S8WubvO3WDt/qzy9Yuq/P8Lf+2kClb5RiGHUxIkGOTupxVbdy9O5H9D3FUilx
r2/FrTbQ7kSVPKW+QFJ93YH5/GEU9QERVmnApKmA38vI0Ow2nclci61+H/NNicKv
nRMlFWXKprL8+ox9MEMHfWRkp5ET/lhILa5hivXYMqyB8UIyC2A=
=Bmf7
-----END PGP SIGNATURE-----

--xkspjckpbjuf2tis--

