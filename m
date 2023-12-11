Return-Path: <linux-fsdevel+bounces-5542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41880D3DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5282F1F21A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D354E1DF;
	Mon, 11 Dec 2023 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLD55wAh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54874E1D1;
	Mon, 11 Dec 2023 17:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE08C433C7;
	Mon, 11 Dec 2023 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702315949;
	bh=WCZbx2NHItGvVYJdNm3seZiECC9kBcXrBMakH/5y2GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLD55wAhi415G5i1FOx5XSlKU0PD4PfNfCROijwQrJ6ISBIgW0yYA+UQgGXuyrBxM
	 PV5qRRb+bo58o/Io89rRoNyx+5JWppYxFQko24Y9U5IZPxbpcTz15c5RH5Luz7A7qA
	 d6vbV1nMzZ/DXJiPRp0u/5zZIAFECeUsvgezaPjUfpCPWuhj36oo4NJwUK303xXRsC
	 FCLD+4SN2kjOP/MUx8b5uPvRjiuVwoOBJXMGANXfGG+IS3I8sASO1XWr749u2cKJ2X
	 lKAaz9Sm59kQ4iMlxCcO9iRB/0dVlEwdpmvsJm7EA8ZQPgjInsr62/cslhs+9Je9PE
	 uogNKYKDLWVQA==
Date: Mon, 11 Dec 2023 17:32:20 +0000
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
	ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <052dc756-cc05-4aa8-9724-14d42853089c@sirena.org.uk>
References: <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <1368c558-c58c-4574-907e-36b07dee31bb@sirena.org.uk>
 <6ee5d68a-fa54-4ed6-bc41-2bff0d9eb12f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wtM8tjuv5dS/G0Kr"
Content-Disposition: inline
In-Reply-To: <6ee5d68a-fa54-4ed6-bc41-2bff0d9eb12f@redhat.com>
X-Cookie: Better dead than mellow.


--wtM8tjuv5dS/G0Kr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 05:53:59PM +0100, David Hildenbrand wrote:

> > > (3) avoids dirtying the tree as a "make headers_install" would, but it also
> > > means that each test that makes use of new uapi has to update the relevant
> > > headers (what people working on QEMU are used to).

> > Note that you can do an out of tree build to avoid dirtying things.

> Yes, but apparently the simple "make headers_install" will dirty the kernel.

> See (and ideally comment on)

> https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com

I mean, I guess people who don't want to install the headers are just
not going to be able to build a bunch of tests?  There definitely are a
bunch of tests where it's not needed so I can see why people would not
like being forced to do the headers step if they're only interested in
those tests.

--wtM8tjuv5dS/G0Kr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3R6MACgkQJNaLcl1U
h9D+Igf/ZMvHWGlrE+b/Z+ooB6z2lP/fcPq9HkLDAGQE9oEBoV9NPQXZS9zKxN6x
mVXihH5FBismZ/3eXmS4pzsMQpdnWSS97iGY5KgrS4qATy3EmFHnYTiNyW3vocyW
7OV8t61FaEctCaQ7gMkb3pKokm3XdGqhUAEMUml1+PfiTHa0iAhcFEI0VBukmKdG
ugBUMNVSRoF4OppkOiolHALCnffAFLu6X6ISsCVAwORGy73NnwqTUEQ3VpKlP6II
qwmwnifh5MCg4Dsj9x3gfGJBkqTYVtNUA4cnOz7KTmv4z8MTlWpZc00FNXGFMqlX
71mkGz7FGIrGTGB5MQGJwP4eLTX2gA==
=pC6/
-----END PGP SIGNATURE-----

--wtM8tjuv5dS/G0Kr--

