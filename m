Return-Path: <linux-fsdevel+bounces-62761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA8BB9FD77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 16:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD8D189DB31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B52C11EB;
	Thu, 25 Sep 2025 14:01:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7B2882CC;
	Thu, 25 Sep 2025 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808887; cv=none; b=lf6b9rrYnogiH03mgVkCv63gqwZx7z85ljMch2LA429sPju8jLNAxsJ5UaDRKWEykXzK72hYztsev2kdcCxm1v/9hWeENjreWWbsvpr7763k3xvKsrj+GVUOj29rAWGydqVUIZ7/F33s8z3nob77hx31OEC3WICzcGQIEvMth78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808887; c=relaxed/simple;
	bh=UEga0Cn1cNdtXR+ZlCqCnDhbrofbpXwOxocUKJa8dws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV2uhD7jyKcjUuG0b4KiIWzT0WmaRwU5g4ER+mOjLbdY545wbtjNQifH2yqDHVBO413irT16Gt4CwyI0rNJgzlfNriUe7i51plKOx9Tx3nY2qPvPm8RpDBQbH2Jl881fUYcssfQQxIqWaS9iStSLA2YFICPmq3cFTF7cN/Z5Ygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED797C4CEF0;
	Thu, 25 Sep 2025 14:01:13 +0000 (UTC)
Date: Thu, 25 Sep 2025 15:01:11 +0100
From: Mark Brown <broonie@debian.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
Message-ID: <111409f1-33cd-4cd1-b3fd-e38402a82c9f@sirena.org.uk>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JGFFBrCHdqJdDJfa"
Content-Disposition: inline
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
X-Cookie: Shipping not included.


--JGFFBrCHdqJdDJfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 09:53:48AM -0400, Tamir Duberstein wrote:
> This series depends on step 3[0].
>=20
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the previous series must go).

Given that we're almost at the merge window isn't it likely that these
will get applied once the current rust tree is in mainline?

--JGFFBrCHdqJdDJfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVSyYACgkQJNaLcl1U
h9C17Qf/YgEwpltWEUIGgUaSbpdA0l3EOpF8ChVfeUiB5k9dCOndChZptDoIsg85
PB++cSfnFQkgzNH3wYTfwtUmYyk2V+NSPaWGooIfOVBrnzE60Vp/buyAVu2FMFa+
eCzJ5UP9/CxqrpD00TxXBCEuTh1ejksRqsawy2e47xND1j1+WdeUp6QSVg4O+gyv
f/AsLvo8yACTbYWgqONdC3AWxUlaCHmuZLXaNbtmaKsZaOeeE2nPDfNGK0XA8dFm
OW+b38cPKCdFYtkOoP/uQGu9lyKqrwDfJNRuO1ca8Rv4Ey8eHwQ2EmMCBs76yorL
+4uyntn5a+EHzOE3s+95LwAANHWJXA==
=8lId
-----END PGP SIGNATURE-----

--JGFFBrCHdqJdDJfa--

