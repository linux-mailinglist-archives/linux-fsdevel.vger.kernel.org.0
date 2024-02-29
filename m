Return-Path: <linux-fsdevel+bounces-13221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E5486D650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A658B215F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 21:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B978F6D501;
	Thu, 29 Feb 2024 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9/CjJ8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EEE6D50C;
	Thu, 29 Feb 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243150; cv=none; b=GG3N9TkZuspsS6yj6GPowgp5bLliBiRJnSNdI45+WsA1j3bJ2NZsIJSokOioOnGkY5ySclmXcfYVraoilJ/1nA541SEvR7Bxw/5yPfEAURxFZpQZJs01PXDprFQIuTLiKDVM+dUa0J9l8IVobdoUKUZiLTrlK+eUsEhZe3j0klQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243150; c=relaxed/simple;
	bh=G4EYkzPzFZ97EhbBfqtvrgTbhgg2qWPt+odKPoorlmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqJlyBlLG3CE2ppbNiv1FSi1Ek/N/GdEcO8H49ZzhAR9SSajsSTRxKZqHy1t/BBDI61Aih9H9gNV2xQPMbSUvG2TtrwZrLljcqwWgWCCD0gKwUG9Md0yTsHPfV2J1pNo1/eAf3wm68Z+H88ieCpEFLqdbGLuO8B9S2krbi5c75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9/CjJ8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9021C433C7;
	Thu, 29 Feb 2024 21:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709243149;
	bh=G4EYkzPzFZ97EhbBfqtvrgTbhgg2qWPt+odKPoorlmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9/CjJ8MOWWmJ77VMYivZMauQoKvUZky6TY1nilZ/ZH+J4l+3gH4vhVrEjDUmgAP6
	 iTyd+A2kT0zdOhpzMbCpeKuawtG1hXwkF1OmrfbDy8bWOuauKzcnU4EDtBTWYK9njK
	 rXp9msPg34jWdRG61D8CFJhzoWUmuN/823DH7FEhm9kePll/FcPWSlm+9q1lV2NV9S
	 eojbqeNA6LFj4wleY/5QkiYVW9FItDzWhabFF86uEdJAqtkjVER2a5ZBOriDDJ2t4G
	 9UqXiZTiMf9DBU0eiSIZ+/uwHTcL7ODurX4VIUJc7fvquTvcD55TuVqfWW/EO371it
	 2irBvLnw8Y3WQ==
Date: Thu, 29 Feb 2024 21:45:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 33/38] kselftest/arm64: Add a GCS test program built
 with the system libc
Message-ID: <c710a6b1-cf58-4e32-ada0-c0b256a62b2c@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-33-c9fec77673ef@kernel.org>
 <87sf1n7uea.fsf@linaro.org>
 <9b899b4e-7410-4c3b-967b-7794dac742e4@sirena.org.uk>
 <87ttlzsyro.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+ic7W6qvciabkElL"
Content-Disposition: inline
In-Reply-To: <87ttlzsyro.fsf@linaro.org>
X-Cookie: Marriage is the sole cause of divorce.


--+ic7W6qvciabkElL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:24:59PM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> > I believe based on prior discussions that you're running this using
> > shrinkwrap - can you confirm exactly how please, including things like
> > which firmware configuration you're using?  I'm using current git with
> >
> >   shrinkwrap run \
> >         --rtvar KERNEL=3Darch/arm64/boot/Image \
> >         --rtvar ROOTFS=3D${ROOTFS} \
> >         --rtvar CMDLINE=3D"${CMDLINE}" \
> >         --overlay=3Darch/v9.4.yaml ns-edk2.yaml
> >
> > and a locally built yocto and everything seems perfectly happy.
>=20
> Yes, this is how I'm running it:
>=20
>   CMDLINE=3D"Image dtb=3Dfdt.dtb console=3DttyAMA0 earlycon=3Dpl011,0x1c0=
90000 root=3D/dev/vda2 ip=3Ddhcp maxcpus=3D1"
>=20
>   shrinkwrap run \
>       --rtvar=3DKERNEL=3DImage-gcs-v8-v6.7-rc4-14743-ga551a7d7af93 \

I guess that's bitrotted?

> My rootfs is Ubuntu 22.04.3. In case it's useful, my kernel config is
> here:

=2E..

> https://people.linaro.org/~thiago.bauermann/gcs/config-v6.8.0-rc2

Thanks, it seems to be something in your config that's making a
difference - I can see issues with that.  Hopefully that'll help me get
to the bottom of this quickly.  I spent a bunch of time fighting with
Ubuntu images to get them running but once I did they didn't seem to
make much difference.

--+ic7W6qvciabkElL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXg+wQACgkQJNaLcl1U
h9DZxgf/UlqOshXqv9IbI4UXiot4QEsHhZ0uPw/+cIwJW0LPVndUMhKWjgagc3yv
HwCf2QQxjkRQTOAeO7dsMdW9WhMBi4cPzta19y3Z9rkAn8XuQM7LXg97WIQDNp7O
3ommNUjVAxq47zUvZhrQC18uzEb8WggdwNqJhcgn4mo/2GwN9uZp2xEZt1CRjZuk
9BOCuvR8dqbQvTXBik+7OZ45roOoTCLl8XUrmPk6VAlcK+DcBoDFt9jm9tgdG6zb
1Ua3jh2YvNe6s/qM5auYh/qB/V6wlz4n5yT0zvnhbC5XXzhaHkjV1/We3jerpisD
2teyFuaDxTwqX+5D8D871wwBTD3IPg==
=WDVJ
-----END PGP SIGNATURE-----

--+ic7W6qvciabkElL--

