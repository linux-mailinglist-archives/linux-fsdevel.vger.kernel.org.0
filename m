Return-Path: <linux-fsdevel+bounces-5572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9595680DB89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 21:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E64AB215AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 20:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834253E15;
	Mon, 11 Dec 2023 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsnscW4Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634F5381E;
	Mon, 11 Dec 2023 20:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB20AC433C7;
	Mon, 11 Dec 2023 20:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702326107;
	bh=rBpsBQzFgdCR4uHw0YOyenL0nzKHxfcOgHqKnrLFUgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsnscW4ZZ5eBgpkU295ZqeOTsNn9/RTDGLj7cdzfkE8r9Ykj9rjeLJWZOosb66RpM
	 PcruomYoMTgkCOxzS7igzpPDXBSXxzbMKwDpyKmEn52XohKoXrPW+E4FaeTUTZn/vf
	 TE3qxb83kDoO9+z3I2BE7RP6RRCqeG9Oazz/sB5uqVqZtClli7+l5e1u5pkoTigTEa
	 V3YMc/Mulx67x28a+6szulTMl72N2/2hfHpb/71TBZBlG9ScNb/+3rwtjq8LhVoRYf
	 6jiEm7qGsyygnUZxQkZrZl+HWG8LWyMUyl4ymFPGxjkqmV0MNZZL8RX+rQMmNkD3Hl
	 7I/AKm1Q3PoWA==
Date: Mon, 11 Dec 2023 20:21:38 +0000
From: Mark Brown <broonie@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
	ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
References: <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2t6rLyxDF+xX0gNK"
Content-Disposition: inline
In-Reply-To: <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
X-Cookie: Better dead than mellow.


--2t6rLyxDF+xX0gNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 10:46:23AM -0800, John Hubbard wrote:

> Or (4) Hack in little ifdef snippets, into the selftests, like we used
> to do. Peter Zijlstra seems to be asking for this, if I understand his
> (much) earlier comments about this.

I can't help but think that if we're having to manually copy bits of
the uapi headers (which are already separated out in the source) into
another part of the same source tree in order to use them then there's
room for improvement somewhere.  TBH it also doesn't seem great to add
additional variables that depend on the user's build environment, we
already have enough build issues.  It ought to be mostly tedious rather
than hard but it's still a pain, especially given the issues we have
getting kselftest fixes merged promptly.

--2t6rLyxDF+xX0gNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3b1IACgkQJNaLcl1U
h9D6XQf9FJcaZ/aSuBGP4yhVAKDtuYM+O0Qsar4MJCFGlNRbAu/ep77u/lb6SiNm
LU23BBBAiqPUIKnMW5exn+9u4d7eZg/jgUqktFGJQUooAZXP7tesJ2juToB11Von
QMaHZ51yQWx/4vduSYWRr1jeH6bKVsC4iUQD8NAxCP7NgC5DqzoKkZUshRIJ1UPa
m+TgJ2pDfv6sHcEeBnNvfGIUR7AtUlR+CyGsoRs+vv1EUYGuOmV46mf4w34U1FUc
cSDhODvruTSYW8nNp0yvLcfzC+vgcC6N24IvLy06fYwhVWLsPx3dL089H+FYubVt
1ik547NSpFhk2Unxhvfsaj1pgPYtCA==
=lcNl
-----END PGP SIGNATURE-----

--2t6rLyxDF+xX0gNK--

