Return-Path: <linux-fsdevel+bounces-21363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8076902B78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 00:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D409284C28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 22:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0497614D6E9;
	Mon, 10 Jun 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RKt2O1wt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB618E2A
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057824; cv=none; b=hji9c66r8/nUIybnGseMWhh0PV/isvJSx8iYXkc0BZS5SrnweEnUcS3sjuebp1KOnXMfEvCYJIpKWdo4TS+Trhk0yDK5iUpK6ZUtj9UbYvkN5GsPSziAOuMewUtuQJyyFWwhIAMvcOYina5q/MQDB8ZxeRb0994C4VkM31yk9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057824; c=relaxed/simple;
	bh=IoijB5wdJI+f80sHP+Qb2UiHgIxvmICh+gvZQzIMUrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4R4JsrGKnIwt7mympCpd5BJKxlei4AYpz/apCqJ5KU7IWGZNCZ18THj40j5DROtuq4j9akvxihE7T8IXlMemXQvB6SkW3+GR0GuXLw+5a1hLi2oBsyPk8Zdpmr47oao0BgqLFPRJyjRaQJ2hi5maqu0GWwndLX37dsx28eH3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RKt2O1wt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1718057818;
	bh=luZV3v+xBz5D4FBxzYNdfnmjJT0zk0lDio3OF4Nrk9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RKt2O1wtJH/napIK6S3T16T1Bn+zMRSLjPKG7LNW+RnIGWkgnMh7LsKMGXg6NON9+
	 8wt9U6qAHFDJo/Kza6BMlv/1OKTmiE2luHroJdi/qopPgOc0bW7hRTrslQaT3eisqK
	 VQAsYdGgS1kW6iEQckGkdBUCMrZj3Eh/qqLqEsVoO5aqkodoQUGvIJF9Sj5F19QCbs
	 R9QbAKGaNQuOl0R41k0teb2NJ+c2jWw0PjSD8KcYT1jd03J7QRCaSVchrQT48NW4kW
	 2ZkPlqgZBZRtDEzNXbDdaJ5w5jdbWY7g/LbWccC3QZIQgLYv1n1ns7d2Qzv9BW1otc
	 GLM6RiHPzmI5Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VymPQ1YvLz4w2Q;
	Tue, 11 Jun 2024 08:16:58 +1000 (AEST)
Date: Tue, 11 Jun 2024 08:16:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, linux-fsdevel@vger.kernel.org, David Teigland
 <teigland@redhat.com>
Subject: Re: A fs-next branch
Message-ID: <20240611081657.27aa51b5@canb.auug.org.au>
In-Reply-To: <20240610131539.685670-1-agruenba@redhat.com>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
	<20240520132326.52392f8d@canb.auug.org.au>
	<ZkvCyB1-WpxH7512@casper.infradead.org>
	<20240528091629.3b8de7e0@canb.auug.org.au>
	<20240529143558.4e1fc740@canb.auug.org.au>
	<20240610131539.685670-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_SY.COYEzl1Be.GT21cA/BJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_SY.COYEzl1Be.GT21cA/BJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Mon, 10 Jun 2024 15:15:38 +0200 Andreas Gruenbacher <agruenba@redhat.com=
> wrote:
>
> I don't know if it's relevant, but gfs2 is closely related to dlm, and dlm
> isn't included here.  Would it make sense to either move dlm into fs-next=
, or
> move gfs2 out of it, to where dlm is merged?

I don't know the answer to those questions, sorry. Hopefully someone
can advise us.
--=20
Cheers,
Stephen Rothwell

--Sig_/_SY.COYEzl1Be.GT21cA/BJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZne1kACgkQAVBC80lX
0GwTbQf/Q6vL66lQKwI2tezvE53VpMivuLtVVnH8watgsEa57aWjha7CP4yXD2I7
vVeG6U2DmzgG+jADAdlAVdx75lGzoR/dZ2u6eFL7vJicxGQuZfNRMx664+v2vy5K
aRjvwwhPhwjPgeOUqxljOXDWeM4Mfu/IaTjBzWeekl6mL7oXCrdD77o8DVBD8Erw
hrSg7CF7Ailt2P+fy9eaqzBkNBxcZc6FrFUMpoqe8/e5s4jHw/DD1aO6YLmfSrZt
2w75nPO9n9LE3TkLBoXkTHKozGZ+HI3wzFu7gm9sE5W+zJN0qz0+I+h3SQiNytd6
pcF4x25FUg1dUkvRon7ENr/xStNqig==
=3wlv
-----END PGP SIGNATURE-----

--Sig_/_SY.COYEzl1Be.GT21cA/BJ--

