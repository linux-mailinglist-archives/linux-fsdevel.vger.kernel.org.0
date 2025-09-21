Return-Path: <linux-fsdevel+bounces-62337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BDEB8D92D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CB67A1318
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04137257AC1;
	Sun, 21 Sep 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="z22nrgjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657ED19D8AC;
	Sun, 21 Sep 2025 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758449004; cv=none; b=Wcb2m9JBg+dUxY+iD3/L0xeWHMPKnBgXDiNWAzjmLcJ2lx7DiUANif8TdKxqlJKf6c7xNC2t8jVPwxBuphbVFUrvBDydPUrACk7xZYxp6FcFtgiNb/+TfwxRQIYGKwMqrOHiSg0yiTDs/oMTGIQaz1Wln6hP1utb/EXtBjSeCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758449004; c=relaxed/simple;
	bh=W11PXjoxakV6HQwskenQBv2X9EdC2ohv75ayu4lk+00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOPHXCCVqpraOM4R0oXBYo0amT7t6LIksfxxrE66Vw2JUNB0dpInZAijUiBtaryuQCOACFeFp5fRajoBWN9xBSiLHJmS5XG3VkWmYZfQ2wD4h1q78tdhcVOT6i6k/eolITFdA5z1ttipAKt8Mumwol4SMw2SLqdXAXxYMU4EghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=z22nrgjH; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cV1yt4bznz9tKj;
	Sun, 21 Sep 2025 12:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758448998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKS99zi+LC9YqpEpCiXRgCG5mqAhOouOogZ5P+HrXuY=;
	b=z22nrgjHAO7+Se+WOAK5uDyE+CFDhwD8TEUFLe/p2LwPMyWyfPGZkNnKB24Sfoh4cQMZls
	mUwhmsaoUjrPKFm3X3kuJKgKbq4Dhr1C5jQg9Q6Jw0MFn0K70f5g5F1MunyGAu1NIdGo+G
	eSuI6j5BcXatrRpmJkGhWMfz8or4Z4dl7p52QOrKNDpIyGbD5Xj5OIGXZwQdGA5gTE6ieY
	MvcIwomHYYDhc92n99SykoDw//5V9SuuPk0zo4pwbArd1IAuII6qJp7iCIXbNyUu477mrz
	rZkzJUn/RSgLuMcZGxraBzGWRsToGG6vFKpj6RUTC5b7WZHl2ZVU9ErvKc1QYQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Sun, 21 Sep 2025 20:03:08 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 08/10] man/man2/mount_setattr.2: mirror opening
 sentence from fsopen(2)
Message-ID: <2025-09-21-sad-swampy-pillar-rigor-ESCPmx@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-8-1261201ab562@cyphar.com>
 <fqgxjzw5dxsd6ymm4tmvxmokq4uh2xo6lk5rqhjg4tjw5eblgg@wy5kbuhwmfnx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o2kb62jybuar3jog"
Content-Disposition: inline
In-Reply-To: <fqgxjzw5dxsd6ymm4tmvxmokq4uh2xo6lk5rqhjg4tjw5eblgg@wy5kbuhwmfnx>
X-Rspamd-Queue-Id: 4cV1yt4bznz9tKj


--o2kb62jybuar3jog
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 08/10] man/man2/mount_setattr.2: mirror opening
 sentence from fsopen(2)
MIME-Version: 1.0

On 2025-09-21, Alejandro Colomar <alx@kernel.org> wrote:
> Hi Aleksa,
>=20
> On Fri, Sep 19, 2025 at 11:59:49AM +1000, Aleksa Sarai wrote:
> > All of the other new mount API docs have this lead-in sentence in order
> > to make this set of APIs feel a little bit more cohesive.  Despite being
> > a bit of a latecomer, mount_setattr(2) is definitely part of this family
> > of APIs and so deserves the same treatment.
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> Thanks!  I've applied this patch.
> <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/c=
ommit/?h=3Dcontrib&id=3D7022531182883ed1db5d4c926506cd373e0795ee>
> (Use port :80/)

Ah, you forgot to switch to "file-descriptor-based" like you suggested
in patch 1. ;)

>=20
> Cheers,
> Alex
>=20
> > ---
> >  man/man2/mount_setattr.2 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> > index 4b55f6d2e09d00d9bc4b3a085f310b1b459f34e8..b27db5b96665cfb0c387bf5=
b60776d45e0139956 100644
> > --- a/man/man2/mount_setattr.2
> > +++ b/man/man2/mount_setattr.2
> > @@ -19,7 +19,11 @@ .SH SYNOPSIS
> >  .SH DESCRIPTION
> >  The
> >  .BR mount_setattr ()
> > -system call changes the mount properties of a mount or an entire mount=
 tree.
> > +system call is part of
> > +the suite of file descriptor based mount facilities in Linux.
> > +.P
> > +.BR mount_setattr ()
> > +changes the mount properties of a mount or an entire mount tree.
> >  If
> >  .I path
> >  is relative,
> >=20
> > --=20
> > 2.51.0
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es>
> Use port 80 (that is, <...:80/>).



--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--o2kb62jybuar3jog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaM/NXBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/ueAEA5WMbchi5wFWRpYgW+wKZ
wD0MKn8L1TOvClgTrz/URvUBAKyem47HvBSrq7YTF51iKA24CSRNtR/YBYrTGrWs
Z78M
=tRII
-----END PGP SIGNATURE-----

--o2kb62jybuar3jog--

