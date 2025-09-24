Return-Path: <linux-fsdevel+bounces-62540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8546DB98033
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 03:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066134C388D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11D1EA7CE;
	Wed, 24 Sep 2025 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="mqhLsynf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127817BA6;
	Wed, 24 Sep 2025 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758677701; cv=none; b=kTtL2DaEhAj+jqt1ntMekA+XcUzhwqeetHPamdMJzFwSBCIWSmlK4TuMW5pVW3x84erpl71tY594aKFMzMZMyaJXJWcQgcuqKhEIRYgD8qvu0bzqABZ7TnlbkVHH9jh/SNvVKoyKI8e0WFrlMBhr5jNFokE8Ms9em5PqQjVKLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758677701; c=relaxed/simple;
	bh=lO9+ovq91/TgtqhbH25S7snsi4CVfNQT+eMpCTJ3S7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca2fmbftKPMl68OFumoqFEjf1PA0OT7+XpU2izQvWP0WT5QFzISQJVoRvjBuGK19A7UtZF9LNQ+JhCKTKiJAnfxQ0Mr7mUix//XiSRNeVuq0+dt2wpkZHkktxKZcF2vtLPr8zLviB9GKpDS3h2pNKNgLgLw46llpssboiSzPzpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=mqhLsynf; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cWfXs0lRHz9tCC;
	Wed, 24 Sep 2025 03:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758677693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FO/O1QYuK4rqB1hpgKUYhTN5JGnU9DG/xls0jzT16W8=;
	b=mqhLsynfkRBszyHmspJqrLl0QQ6vTp+b+IijVtKNnaRvSqFBGXhhnQYhh2ITS6sEVrhN0e
	9i+t6eScXLorl6CnVpdaXDAF7uavy0BwUlUp+a07TjDaFCtjJqQlhB1GR+ITvFuxBtf5HP
	f651zc4bs8CjgVPiy+fynzKbbewZIa2LR4lhcY4qPY75n44Sx+GRgbbf5DKiF+ad1b+pOI
	ObMfq8Pu1Iy7obuVEslD7jhSNVy7IUSS650wOcE8gHaRvGBDnC4cU0UMixJG1CS4620yIm
	wls8pI1rwhcez34cewfgWhg85tev6esvAzquJnc0EaSYhjHAp1jgsnop/J+mWA==
Date: Wed, 24 Sep 2025 11:34:40 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 07/10] man/man2/open_tree.2: document "new" mount API
Message-ID: <2025-09-24-marbled-ominous-skate-riches-QJMLCR@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-7-1261201ab562@cyphar.com>
 <gyhtwwu7kgkaz5l5h46ll3voypfk74cahpfpmagbngj3va3x7c@pm3pssyst2al>
 <2025-09-22-sneaky-similar-mind-cilantro-u1EJJ2@cyphar.com>
 <aqhcwkln4fls44e2o6pwnepex6yec6lg2jnngrtck3g5pc6q5d@7zibx3l2vrjw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vfo47q5e4mux6kdu"
Content-Disposition: inline
In-Reply-To: <aqhcwkln4fls44e2o6pwnepex6yec6lg2jnngrtck3g5pc6q5d@7zibx3l2vrjw>


--vfo47q5e4mux6kdu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 07/10] man/man2/open_tree.2: document "new" mount API
MIME-Version: 1.0

On 2025-09-22, Alejandro Colomar <alx@kernel.org> wrote:
> Hi Aleksa,
>=20
> On Mon, Sep 22, 2025 at 08:09:47PM +1000, Aleksa Sarai wrote:
> > > > +is lazy\[em]akin to calling
> > >=20
> > > I prefer em dashes in both sides of the parenthetical; it more clearly
> > > denotes where it ends.
> > >=20
> > > 	is lazy
> > > 	\[em]akin to calling
> > > 	.BR umount2 (2)
> > > 	with
> > > 	.BR MOUNT_DETACH \[em];
> >=20
> > An \[em] next to a ";"? Let me see if I can rewrite it to avoid this...
>=20
> You could use parentheses, maybe.

I tried it a few different ways and I think it reads best with a single
em dash as a parenthetical -- since ";" indicates the end of a clause I
don't think you need to "close" the parenthetical with a corresponding
em dash.

Here is the parentheses version, but I plan to just keep the em dash
version in the patchset. If you really prefer the parenthesis version
feel free to replace it.

  This implicit unmount operation is lazy
  (akin to calling
  .BR umount2 (2)
  with
  .BR MNT_DETACH );
  thus,
  any existing open references to files
  from the mount object
  will continue to work,
  and the mount object will only be completely destroyed
  once it ceases to be busy.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--vfo47q5e4mux6kdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaNNKsBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8h4AD/Wcoe7m37jWc/BhSAMmy7
5J7v6RtMEVM6694cfozacuMA+wemOQKXKtYSNII11gxZCywch8PPbKMq1K5ure5X
xDAA
=W8YQ
-----END PGP SIGNATURE-----

--vfo47q5e4mux6kdu--

