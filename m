Return-Path: <linux-fsdevel+bounces-58374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC08B2DA33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 12:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85465C0FC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CCB2E2DF6;
	Wed, 20 Aug 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Cf8r21yy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB71A08A3;
	Wed, 20 Aug 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686354; cv=none; b=pyIOKUQY1euLKSVC01+YzivfQcczNols0RLbZRv7XuIrpkfLDZHGlST5pZCbVU7+yCNoX7ke0cMpUDnL1zbl/ZECCP5dMqK/mbNHRkJMbXUlHD+Hq3RmDkhecJ5fnUs1AEUttlhK3VrCipWxn6B4px5hyupJBD+f7MbxMvLy1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686354; c=relaxed/simple;
	bh=jilKxaZEwfaTEc+ZOXJWOakVu0+DB4g2LsvinFAQTys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF+LoQTwCpsoSIWNpgm26xBjesqmnKrYrfzXAaAM6v0wtUvywGkib/5T6AKtRgLxERXkczQrZsv+Gtr+9hri2FhgTnQoAIwiN1DRqvt4hxDHxuawrCv54cH9txeWn6YstTz+AKuP+D/rOwL7fxtsQQIDfXEVOjfDpidLUuNzaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Cf8r21yy; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c6NGt4McKz9txB;
	Wed, 20 Aug 2025 12:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755686342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewfe1p/aEyCzaiSaRpSyZ63tEEHUAO6lj3X+J01N0Lg=;
	b=Cf8r21yygbkg+AOpmyYhrYuyf08/Gp0Bzu87zgSCrrEEXBolZS2vQ27oHsWcpM88gOCZ7R
	0+CNnOKAPDG/PeTgnYycxJxgNDk5W4kXajRytN3YV8bfipmZRDNgvgGojjQShjTzAPEROt
	ra+bbc+Ziv45eadwF3tLCWswlQCju8zeKwdVwBrOizQB+Gg13mR33Zyx+tc6tfoRhKITkE
	8w4q2lN4MjKige93jizmm4CLAD4bomIEebv952cgSUon4O01UeouByEQca71gKEQ6QfuGs
	yR91QVS/Akpz6Z0tJXgad5aSO6I9Prv3ZmHrWB0E1uwKz0WW5r0t5RPUJi5mrw==
Date: Wed, 20 Aug 2025 20:38:48 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 07/12] man/man2/fsmount.2: document "new" mount API
Message-ID: <2025-08-20.1755686261-lurid-sleepy-lime-quarry-j42HLU@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-7-f61405c80f34@cyphar.com>
 <1989d90de76.d3b8b3cc73065.2447955224950374755@zohomail.com>
 <2025-08-12.1755007445-rural-feudal-spacebar-forehead-28QkCN@cyphar.com>
 <198c6e76d3e.113f774e874302.5490092759974557634@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="usu7k5kxr5vzveta"
Content-Disposition: inline
In-Reply-To: <198c6e76d3e.113f774e874302.5490092759974557634@zohomail.com>


--usu7k5kxr5vzveta
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 07/12] man/man2/fsmount.2: document "new" mount API
MIME-Version: 1.0

On 2025-08-20, Askar Safin <safinaskar@zohomail.com> wrote:
>  ---- On Tue, 12 Aug 2025 18:33:04 +0400  Aleksa Sarai <cyphar@cyphar.com=
> wrote ---=20
>  >   Unlike open_tree(2) with OPEN_TREE_CLONE, fsmount() can only be call=
ed
>  >   once in the lifetime of a filesystem context.
>=20
> Weird. open_tree doesn't get filesystem context as argument at all.
> I suggest just this:
>=20
>   fsmount() can only be called
>   once in the lifetime of a filesystem context.

The reason I wanted to include the comparison is that you can create
multiple mount objects from the same underlying object using
open_tree(2) but that's not possible with fsmount(2) (at least, not
without creating a new filesystem context each time).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--usu7k5kxr5vzveta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKWluBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8HqgEA5gdP363+e0Qvap7lKkmf
7xVL4tnxaGyh9NHyapXTn5UA/1Ok9BIkD7qH82FZrHpbXznBtXN9ME/TbH5Saevg
JKEG
=3Kox
-----END PGP SIGNATURE-----

--usu7k5kxr5vzveta--

