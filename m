Return-Path: <linux-fsdevel+bounces-5525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B3480D269
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C35281A39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A2250F0;
	Mon, 11 Dec 2023 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilzGVkJz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B01F16B;
	Mon, 11 Dec 2023 16:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD94C433C9;
	Mon, 11 Dec 2023 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702312904;
	bh=YplM3Lc/uJviJ/vwXKtb5pm7aSZ8QLfQpUexo4dL2iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilzGVkJzyKnUP6gPXSvqDBkQBAoL+Io3eCfft5PJ0awXLjCb2xy6GuIudA1K9GNrB
	 7wKnCVX8v0WTs9Z5ZHYJrJbtJLl/e3oWgoC10v8rkC6ePTUdHII+s+apjgkRPSkJpD
	 eOav2dWutOfiz4a/u3HCfW9Wk8hQh6GGcVNOzn6PryrhpMzgapCucZVXhS+x49k1mN
	 PXFtZObnI46GWdojijwSscsskbLmv97FkYIMMQ7jJc5kWibMWG6EIRJTc5q+RNMMwC
	 WIH4HennPImHllcStg1cr7c6udBqJTeLk7vD1mLabZJy5Z8xsZkAkhDR9RsAA6OkzU
	 2Fp8UL+NH3yVQ==
Date: Mon, 11 Dec 2023 16:41:35 +0000
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
Message-ID: <1368c558-c58c-4574-907e-36b07dee31bb@sirena.org.uk>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BnXU97Dc8NyxrdI0"
Content-Disposition: inline
In-Reply-To: <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
X-Cookie: Better dead than mellow.


--BnXU97Dc8NyxrdI0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 05:32:16PM +0100, David Hildenbrand wrote:
> On 11.12.23 17:15, Suren Baghdasaryan wrote:

> > Ok, I was updating my headers and that's why I could not reproduce it.
> > David, should the test be modified to handle old linux headers
> > (disable the new tests #ifndef _UFFDIO_MOVE or some other way)?

> That's an open question: do we want to be able to build selftests against
> any host headers, and not the in-tree headers that have to be manually
> installed and dirty the git tree?

Quite a lot of existing selftests rely on the headers being installed to
build...

> One obvious drawbacks is that we'll have to deal with all that using a bunch
> of #ifdef, and the tests that will be built+run will depend on the host
> headers.

> Especially the letter is relevant I think: Our upstream testing won't be
> able to build+run tests that rely on new upstream features. But that's what
> some key benefit of these selftests, and being able to run them
> automatically on a bunch of different combinations upstream.

...for exactly this reason.  It causes real pain testing new interfaces.

> Further, the tests are closely related to the given kernel version, they are
> not some completely separate tests.

Note that there's a general desire for the tests to *run* with older
kernels and use whatever feature test mechanisms exist to skip tests
that won't run.  That's often needed anyway for configurable things.

> (3) avoids dirtying the tree as a "make headers_install" would, but it also
> means that each test that makes use of new uapi has to update the relevant
> headers (what people working on QEMU are used to).

Note that you can do an out of tree build to avoid dirtying things.

--BnXU97Dc8NyxrdI0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3O74ACgkQJNaLcl1U
h9B0dgf/WZJDnoE/dzWYhyYWKPFZlpPobwsO1rVstQxD6dR5DNJh0GyPL11T0jn6
EJgVd8Esw3KE2twbk7SgsRpf3nz55wD4zyJKiE9po7nyCDwG+xsehhfRtdajnW+p
MSubtQFkjCS6tZWnOwAeYlIfXEQ6f8LscjulZxDX4HZxbqYn2KF61jn8BzmUiRQ+
aZFTB3qQ1DLZwOSNMT5WhAedVLN9B7joTDT5rFxftNvOvEWyLk95ugvqsK13GDEe
0u1r4u2jYv4TFr805sq7o1vedsZ50jWRjapAlTu1+8WZcNV15s4Mokb7TELPc4CI
KqdTkJiBtDz0xu9dIxjmNccqT3j0YQ==
=NqsE
-----END PGP SIGNATURE-----

--BnXU97Dc8NyxrdI0--

