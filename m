Return-Path: <linux-fsdevel+bounces-64225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FEBDDDA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6B43BC971
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D431B809;
	Wed, 15 Oct 2025 09:48:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37F2836B5;
	Wed, 15 Oct 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521716; cv=none; b=N3kcOPGsgGQgcrGkCwEuzNZxE7HXXs7A2EPhVdORPWI+bJjtdh4wL3/uS+g1pMqYgSPFjy2hkTKGUmXidzNUmdcGxcw5y3wle5UbAOweZI/7GiVTaDlh6VA16rlQqQ10TUs1stx5UqcMryaENsTkqfIdG63ABFqUn4QwHT2U7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521716; c=relaxed/simple;
	bh=ci2GAK96GpSlDOtokEvI17IcFg1bYDVpieRXum3v43o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUcXMcXgvPMpoelyg7UOsruivrPpKxJT7VK+je1Y2xCxoAlPhJ2LOW1ehAYmDa7fjVH0h2Ea25pEOF5alIcCTgXWFSe2RaWjw/bhbr+QQ8Ip8HodJ1uzgvDJD0ZLyPUuFXsVvsiqz2gLV4l6EiVjCSVxH7uJJqBz56l71FxeHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B69C4CEF8;
	Wed, 15 Oct 2025 09:48:24 +0000 (UTC)
Date: Wed, 15 Oct 2025 10:48:21 +0100
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
Subject: Re: [PATCH v2 19/19] rust: regulator: replace `kernel::c_str!` with
 C-Strings
Message-ID: <a6d606c0-716f-49b5-81cf-362b325b7872@sirena.org.uk>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
 <20250925-core-cstr-cstrings-v2-19-78e0aaace1cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qu2IBVFvaIEaH/yu"
Content-Disposition: inline
In-Reply-To: <20250925-core-cstr-cstrings-v2-19-78e0aaace1cd@gmail.com>
X-Cookie: Sentient plasmoids are a gas.


--qu2IBVFvaIEaH/yu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 09:54:07AM -0400, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.

This doesn't apply against current code, please check and resend.

--qu2IBVFvaIEaH/yu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjvbeQACgkQJNaLcl1U
h9Dt8Af/TLwPaPEPyJKhHTg8cZeHf70d+vVL0moyk8tdCcvNggPRPd8mXg0NT9mO
qmJvoWmet4bQC3McxDEI2hDArwrV6orbVM8LsRyd78hdChnLNP1058/WMu4IMsm9
2BDs6OT5Nma+7YMa+KS6S7fkuUmt9AG/CkBR9NAGDX0K6kGd/GQ1E9I11cf8Cdqs
YFLT67SrYyxGv3ZGtK5IkUOmqn8vSKPTtrQiuzfeSkwR6iBWmy5jq1VR/Qh2Kycq
c/7pMyRZK1HaRL+RnAGvZaPuru3c9bRia03t2TS0BaJJYl8QMaNG2TqmOxxHBHNP
0Dagzm72apYtzPFYbdE9flnTkc2o/Q==
=ofuh
-----END PGP SIGNATURE-----

--qu2IBVFvaIEaH/yu--

