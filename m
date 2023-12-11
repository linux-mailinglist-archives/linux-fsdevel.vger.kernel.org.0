Return-Path: <linux-fsdevel+bounces-5519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7580D1E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC88B20DC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65113AF7;
	Mon, 11 Dec 2023 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvCSSld6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837324B4B;
	Mon, 11 Dec 2023 16:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B704C433C7;
	Mon, 11 Dec 2023 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702312463;
	bh=QbRrkITDgkJCeqMLW1qe7fhOw6lXgNPsb71J+dKjZmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvCSSld6cPnM0hPRvec27Uh4IabHwsQOX/uckEDpbEWgTGwQazayJJ4XiuOn+Qb/G
	 pq3jhFh9QpiE2ALVq6eMdLaqmNVlg2GQmuhYKMgecgNKIhoxDuTI76Z6/3aIWhaq+7
	 VJ5nvlSP54hGmFneWqBusqIYEN6/V4gcPdl3hhhHEpfikqwhglHfbVZKry8UuZ4R03
	 VSDYaWJIKJFB3D24kBFZaqrZWuKYgp8KXOYtczdFemKB8xe+i89Q/gP+hutiN+lHKn
	 JP7zcC2tVGndaAXyQS5qGibfr1DfULsbXVBMQeTXX6+kQBzVWvfbg4R1E6NsKTlHDU
	 5yw9Mt/hxq9oA==
Date: Mon, 11 Dec 2023 16:34:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
	ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <915d2f82-0bcd-4992-9261-81687ca16e9f@sirena.org.uk>
References: <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <9d06d7c1-24ae-4495-803d-5aec28058e68@sirena.org.uk>
 <CAJuCfpGEbGQh=VZbXtuOnvB6yyVJFjJ9bhwc7BaoL4wr1XLAfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UmzPtGFsmRTmz9FI"
Content-Disposition: inline
In-Reply-To: <CAJuCfpGEbGQh=VZbXtuOnvB6yyVJFjJ9bhwc7BaoL4wr1XLAfQ@mail.gmail.com>
X-Cookie: Better dead than mellow.


--UmzPtGFsmRTmz9FI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 08:29:06AM -0800, Suren Baghdasaryan wrote:

> Just to rule out this possibility, linux-next was broken on Friday
> (see https://lore.kernel.org/all/CAJuCfpFiEqRO4qkFZbUCmGZy-n_ucqgR5NeyvnwXqYh+RU4C6w@mail.gmail.com/).
> I just checked and it's fixed now. Could you confirm that with the
> latest linux-next you still see the issue?

Yes, it looks like it's fixed today - thanks!  (The fix was getting
masked by the ongoing KVM breakage.)

--UmzPtGFsmRTmz9FI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3OgYACgkQJNaLcl1U
h9B9pwf9EjjPpa2QYF7F1JyuE+gyyQEssW9afBJMvjjhu6DYQp+9i0USYwSk2/OX
t5c2+FWTXahvCkVtvHE9nmaCF44rS2gbhHkwABa/qA2+Pi/DPJ7LD6EgKzEZtY4u
hslaiTtYvx1R0ba0X8AHASRfzOvVis63I5eetswE9JeeEdM1i+IdwuO0V0tg6rTl
gFuxAkkW4uwgA5zLAYQIS3BxENIN1Uz9bxDMnmq/O7RWaihd3ArPhGYwWu1BKfoy
nqFpiREyp0b6s29XYAkveW1/xId23STrmpiRIJ3e3k97dotoW7VE1t5S9uT+g/iA
SCd8qIVMSFeFSdfOgyKyXJ+VaV+GYg==
=aBaU
-----END PGP SIGNATURE-----

--UmzPtGFsmRTmz9FI--

