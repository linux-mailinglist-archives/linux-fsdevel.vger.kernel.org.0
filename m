Return-Path: <linux-fsdevel+bounces-46249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AA8A85D85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B363516D957
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0920229DB72;
	Fri, 11 Apr 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKeLdWrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172929B234;
	Fri, 11 Apr 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375065; cv=none; b=Xat6nMTLsZE/zXqTt32Rzo9y7PBAqRPaJwOOVg2tK9EBcKsf2Ozt1ERWZuPTc07t5JHcLZ/I2spTG7S7J/KOvV/6TMYhUH1lh/KTQG8cpZ662BhtQADWyZiYQvKWWTZNkMgjJj5HgT4OwrymL2My46Sbyi8W59Nt6YgxqXyc6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375065; c=relaxed/simple;
	bh=/8uaMex2yn2R+ZosGV9NzEaxk9mPYO7HU4z+Z4R12M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSsXuOpA2g6R2tjkA/zKBZ8DI0QzSPGkt0Eg14qiCuoOdOHjeAFvvWM+6q1/bwgrUHFlJWMte0nOJZqmzjpNLQx1z/Ca/WZdPHLV1rCsmaV/4A9ycO30uVUGqAYy4P4iajFNoQXFoXqIBpKZ35qAlwMN1G5A2XCxRTApQBPlAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKeLdWrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AE7C4CEE2;
	Fri, 11 Apr 2025 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744375065;
	bh=/8uaMex2yn2R+ZosGV9NzEaxk9mPYO7HU4z+Z4R12M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKeLdWrfC19z9zd2XQZKVBqr/ODBHwml77Z5XtwSTq8zBuwd6C3EmMpajGA9shOn0
	 p8dnJQPNMA6bJvv/eRDLvH+1oTJBvFNLEXrakVNYXDx/DKG9ma7QNpZBTu0lvkS2dS
	 6v8pdd1GssLBoq9mi4rMBjN8UnS4G2dHy42sp0ZbnQ+JDY8RrsjFxuuJX+mXY6SZn9
	 Kvy5rRowcJYRltwOUZvUSqYc4oBYWi71UglEu9nrrVEtdfqgGb0dBluyNJfTnC4nK3
	 PA6VgD0XGRWTROp9HM7iJsMCo5HtC+sRsd1skLC8o0qLapS2ZKSKR5I46HuesqxFBI
	 mEMOxpfh1w0qg==
Date: Fri, 11 Apr 2025 14:37:40 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] sysctl: move u8 register test to lib/test_sysctl.c
Message-ID: <ncfru3u5wwbnsdtehdwecaihhxy4kdhn4ip5nyno7o7fgatwaw@rjp73b4nu7ci>
References: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
 <20250321-jag-test_extra_val-v1-1-a01b3b17dc66@kernel.org>
 <202504091020.3A06E6C548@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zg2ap4wtnzxx7lsp"
Content-Disposition: inline
In-Reply-To: <202504091020.3A06E6C548@keescook>


--zg2ap4wtnzxx7lsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 10:26:56AM -0700, Kees Cook wrote:
> On Fri, Mar 21, 2025 at 01:47:24PM +0100, Joel Granados wrote:
> > If the test added in commit b5ffbd139688 ("sysctl: move the extra1/2
> > boundary check of u8 to sysctl_check_table_array") is run as a module, a
> > lingering reference to the module is left behind, and a 'sysctl -a'
> > leads to a panic.
> >=20
> > To reproduce
> >     CONFIG_KUNIT=3Dy
> >     CONFIG_SYSCTL_KUNIT_TEST=3Dm
> >=20
> > Then run these commands:
> >     modprobe sysctl-test
> >     rmmod sysctl-test
> >     sysctl -a
> >=20
> > The panic varies but generally looks something like this:
> >=20
> >     BUG: unable to handle page fault for address: ffffa4571c0c7db4
> >     #PF: supervisor read access in kernel mode
> >     #PF: error_code(0x0000) - not-present page
> >     PGD 100000067 P4D 100000067 PUD 100351067 PMD 114f5e067 PTE 0
> >     Oops: Oops: 0000 [#1] SMP NOPTI
> >     ... ... ...
> >     RIP: 0010:proc_sys_readdir+0x166/0x2c0
> >     ... ... ...
> >     Call Trace:
> >      <TASK>
> >      iterate_dir+0x6e/0x140
> >      __se_sys_getdents+0x6e/0x100
> >      do_syscall_64+0x70/0x150
> >      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >=20
> > Move the test to lib/test_sysctl.c where the registration reference is
> > handled on module exit
> >=20
> > 'Fixes: b5ffbd139688 ("sysctl: move the extra1/2 boundary check of u8 to
>=20
> Typoe: drop leading '
>=20
> > sysctl_check_table_array")'
>=20
> And avoid wrapping this line for the field.
>=20
> >=20
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
>=20
> Otherwise looks good to me.

Thx for the feedback;=20
Changed this and took in your trailers, but wont resend.

Best
--=20

Joel Granados

--zg2ap4wtnzxx7lsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmf5DQgACgkQupfNUreW
QU+E1Qv/QukQGbyEzmzoHNz2YK7Udn5VKQIOW2yPC5zsJqRGysBgkGyVoJa8wctt
yaxtcx4FNYFCI/l6u8Z+2cFx3vkXGh3q02zvuQnMq6LwS/CO04cWjvHUhZAVXl4e
fHXxF27eqpRePOZ5tUjXdo4s3DddBieYJ/aL+kRvsE6wDrwb9dWVwNJXcQoZO2oU
Lhar9DC2NcA3StqOM2lfQ2xx2GQT5qGU6XzLCSXJTC9lwgCE3N1CT5cvk+Broc90
/LLq7bKrsidFbwxvlByhaFif7ObFl6OKulQ84apUIqDWuKu62QPA/zZ5+w71xeYI
AU1a72Grs54cgIVyrCNEKVbIu1nlVWjkhAGlS2gDihwx10y78gl7+25csFKklEhM
KoqG/6ngemVRaJrzA6mV6JWA6omA0jfrobrjtboAqml37/fq0GBFk1CHrYIFtlNJ
xhS+Ql3ImjslYY8vRVDstLnMBAisXmYNmAeDceh6JHhh8HigobkrSD5vfHGOUmwE
4kA9kPyh
=6Pet
-----END PGP SIGNATURE-----

--zg2ap4wtnzxx7lsp--

