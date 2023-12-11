Return-Path: <linux-fsdevel+bounces-5570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473E280DB34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 21:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BE11C214F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 20:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E7B53801;
	Mon, 11 Dec 2023 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5evn4Dx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4452F9C;
	Mon, 11 Dec 2023 20:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA26C433C7;
	Mon, 11 Dec 2023 20:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702324927;
	bh=0muo1Uoi32hut1hx3yMwoWK9bfatBaZv4kIG4F1glqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5evn4DxU2NcpgJ9s72YHzYM8pWzYiZDS4VpHFRrQVGissAfR7uMl4oZFRg0BIAX7
	 CN0OS0Kbnft0dHbdlNHlWimW62G0Tsu8P8djSjW15jd4oqZuhepaiT+ixOexOjGttt
	 cPnuhd5MsxToFTb5zKx0syWfzGQDkNMKfkfSjNEjTG2RaCDiPe/JljeWqSOpmZfkRu
	 wvlHrsRmoI8VUCkicMgLEmhbgcjQ9xUEe4aWcIw3m/GU6VIXwfV5jlXYUR/XWPv38a
	 A/UiHNDjqqR7mkW44WT1jP6GGqfzmdm8EgK1+eQZ2erD5oczAltOvjJ5se7zQYESl3
	 34OdoPsk1CUdg==
Date: Mon, 11 Dec 2023 20:01:59 +0000
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
Message-ID: <400c0342-bb28-4dd2-b132-9927c7babec4@sirena.org.uk>
References: <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <1368c558-c58c-4574-907e-36b07dee31bb@sirena.org.uk>
 <6ee5d68a-fa54-4ed6-bc41-2bff0d9eb12f@redhat.com>
 <052dc756-cc05-4aa8-9724-14d42853089c@sirena.org.uk>
 <8a2ce635-58f4-44e1-a646-6527936c5836@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v6cD9Anxo0FHLDGJ"
Content-Disposition: inline
In-Reply-To: <8a2ce635-58f4-44e1-a646-6527936c5836@redhat.com>
X-Cookie: Better dead than mellow.


--v6cD9Anxo0FHLDGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 07:00:32PM +0100, David Hildenbrand wrote:
> On 11.12.23 18:32, Mark Brown wrote:
> > On Mon, Dec 11, 2023 at 05:53:59PM +0100, David Hildenbrand wrote:

> > > https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com

> > I mean, I guess people who don't want to install the headers are just
> > not going to be able to build a bunch of tests?  There definitely are a
> > bunch of tests where it's not needed so I can see why people would not
> > like being forced to do the headers step if they're only interested in
> > those tests.

> Yes. And before that, people mostly had no clue that headers had to be
> installed in order to compile successfully.

> So maybe a warning to give at least some hint might be reasonable.

That sounds sensible, especially if we could arrange to flag when the
specific tests being built need it.

--v6cD9Anxo0FHLDGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3arYACgkQJNaLcl1U
h9B1kwf9FSJkPhxe7Bh+LVMm9M/JwDNNcn4+8J9LLt5yC5m4APhXIPtgAzsQf7HZ
pA1lZh6HCE3f7G0WAFms4UkYnL4Sg+/5/1KIJmZZ8PiSelGBMEqQxhqJzWcI6za0
gZODJQZdI4yuMG7RLnVum7TzOenAd+7RpT8TOmcn/UM6BF8BWLg26DmB+Yf/Hf/f
gL0W3epHdBysAKO+esLc+6ifEBeokyHtETY9wNLHcKnA09K0YY0Jp55tfwbKvPgi
D8MyS+1kNPy2to2TMPGxhVilrB0zS0ifR8ELa+Dlnf3A0PfsBa2fdIeW2ARZ7+7C
UjMVDE+wbqAH29BU8bvGTEEha1jV1w==
=JgyN
-----END PGP SIGNATURE-----

--v6cD9Anxo0FHLDGJ--

