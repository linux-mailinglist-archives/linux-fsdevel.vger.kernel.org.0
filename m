Return-Path: <linux-fsdevel+bounces-5898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C58113F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DEB1F22BEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A02E630;
	Wed, 13 Dec 2023 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaBOz/47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2E2DF62;
	Wed, 13 Dec 2023 14:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1A6C433C7;
	Wed, 13 Dec 2023 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702476041;
	bh=uBRmDLreG8WgwNQkvzLPBqQqss2T/ZofeYOVFa+eznA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaBOz/47yY6VrRxrv3KKFtukVEZ+DALugU+umNCVqzDhVU9TRoPPiFIp6ki7L9H85
	 +SSElnIH3cjgLrJjtr+W8i5TGHkloO1SPoxHDMtPwN7rgnMdsPs8Je95lVTgYqohyR
	 JqrZYSFXbJEp38k/t+mh2g0yhf4bcVTVKhzt8BhWXEmA+Dp95HZqRoBeVDRrQFdJer
	 vaqixHfU41igB/RuHZQCeqqD00PejJoOR9FbU1fUo6TJxgJ11TH6I5zO5bFGZAsJNH
	 DIhMhseUcZXSIwpFgmoLPWal2mkolYNmSACLQw+G+Y6KkL40k6cbvAwEE3B3ToU/m3
	 +VG3sMai75JfA==
Date: Wed, 13 Dec 2023 14:00:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
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
Message-ID: <c0aa00a2-38a5-42da-9951-64131d936f7e@sirena.org.uk>
References: <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
 <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
 <e3048458-726e-4b98-b2bf-908ea9066959@nvidia.com>
 <0f97db9c-5b86-4f56-8463-2520fe79f709@sirena.org.uk>
 <f1b0b80a-1cc6-48c4-8a53-0222b3e59c7f@nvidia.com>
 <2e4a719b-f2b3-48db-99db-d96040d78b12@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/XZEbL4J1kAPYGOF"
Content-Disposition: inline
In-Reply-To: <2e4a719b-f2b3-48db-99db-d96040d78b12@collabora.com>
X-Cookie: One size fits all.


--/XZEbL4J1kAPYGOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2023 at 08:58:06AM +0500, Muhammad Usama Anjum wrote:
> On 12/13/23 7:14 AM, John Hubbard wrote:

> > Oh, this sounds like it would work nicely. No more "make headers"
> > required (hooray!). Instead, the new approach would be "selftests are
> > allowed to include from tools/include", and then we can just start
> > copying the files that we need to that location, and gradually fix up
> > all the selftests.

> No, this wouldn't work.

Note that we have a bunch of selftests (at least arm64, hid, kvm, rseq
and sgx from a quick grep) which already use and rely on the headers in
tools/include.

> * The selftests are applications which include default header files. The
> application don't care from where the header files are picked up at compile
> time. We should be able to build the application on normal system with
> latest headers installed without any changes.

I think there is much less interest in building out of the kernel than
there is in avoiding having to handle random userspace headers...

> * The header files cannot be included directly as they need to be processed
> first which is done by `make headers`. Here is a diff between kernel fs.h
> and processed header file to be used by applications:

I guess that's another reason why the sync is done manually.  There are
also a bunch of files in tools/include that are just completely
different implementations of things (not just uapi).

--/XZEbL4J1kAPYGOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV5uP8ACgkQJNaLcl1U
h9B4Agf+MNb0FxSD5g83dGXjn3wfAIHYImULMzBSAyVwk+xbUBcF5RwuyI/Up6pe
jF7sirB8JObQgIDvOntBvbLGxjnrbKVZmrnnrz3IZLy9coVcvydGocN2dgTK/U63
0n4vbXdOYqavpATUodi9QyrB+1peaITg+DvOBR95uoORBc94VM7bXVxGgD61oZ0N
ZElj6Uuiegt+pu4yzSnCsNrXvvIUk1y1jl59tH1NV+WAnoHsDkNJReua3pUtYU3c
MUyU+EkGOUI256iUVCafNaBqkbWvy070pa/QToV9OI+js6AF5//Yj0LR1LtZprjq
q371z9Rj+1s+jACuAtuq8ELOJrN3QQ==
=PCP4
-----END PGP SIGNATURE-----

--/XZEbL4J1kAPYGOF--

