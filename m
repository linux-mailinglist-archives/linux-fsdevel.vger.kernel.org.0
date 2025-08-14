Return-Path: <linux-fsdevel+bounces-57874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10114B26493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB54170289
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAAF2F60CB;
	Thu, 14 Aug 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPnGEXsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C412E6106;
	Thu, 14 Aug 2025 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171950; cv=none; b=MEcGBj3Mr5mIdnbIUwOaVdMtU/HfbLubPs0LN2znD7CTpER69cAD/wup4l34h2uSIf9JGv3xyeqVAcLI5AeNH3b5FJRXwT6IjPsK5oCKzCr3j/6iqTpHves4eCG1md6y33LZAe393YVeO28iTgtEmUyOgFEGukp2pp2nEfjpzKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171950; c=relaxed/simple;
	bh=FexkV7nvaMJKSQuSjt56VRn1ropgn6XWofqYu3VqSl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx1mkDSspXgCilokvH8kPICDDpkmIB5ifWSSyueAnBaXmftSTYYxPjdKOz8RsAJvhE6dxjseVgAs3sSq+KcDxavje/uHUZ5hnMTeVn31lg+LA8Oqhaf/5Gzwi7QsUgUMEo7KwElEdJ4vWDKrel6qlMJW7vc4tPLB/EZRtcy5HI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPnGEXsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6900C4CEF1;
	Thu, 14 Aug 2025 11:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755171950;
	bh=FexkV7nvaMJKSQuSjt56VRn1ropgn6XWofqYu3VqSl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPnGEXsmQefCR5XKxWgB20+CdEPRHLpwVjZ9QqpgyiEZ/0tCDnmajIc2xnznI+BzQ
	 Is37m5tR5w39ME0RZCAMaBBsKQRSYqMs9a9tZjjyQriX3RqQOr5IihltzPkGu3m3Q4
	 vZTJUJH1TKkWTXuh5TamQ5xvr35SXOixpW9FVi2OiCGYyXHmfuOj0dXi7B8UQAC5Q+
	 zxQk6CKRtdavLtwGvB7gY6HSlp4w30N0rA/eF4w9gIis1iaNFxzbmJZsXiOQE7bHUr
	 9ZJMetEeDzQbchb9v2/vyLtoHZnblpw/SncrzFzAA5/Uj9OF05Wi8okNIKcTLXJXu5
	 tNIXry1AK4ePw==
Date: Thu, 14 Aug 2025 12:45:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
	baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
	ziy@nvidia.com, laoar.shao@gmail.com, dev.jain@arm.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
	jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
Message-ID: <b433c998-0f7b-4ca4-a867-5d1235149843@sirena.org.uk>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
 <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
 <5dce29cc-3fad-416f-844d-d40c9a089a5f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HgKF1GOS9//9I841"
Content-Disposition: inline
In-Reply-To: <5dce29cc-3fad-416f-844d-d40c9a089a5f@lucifer.local>
X-Cookie: This sentence no verb.


--HgKF1GOS9//9I841
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2025 at 11:49:15AM +0100, Lorenzo Stoakes wrote:
> On Thu, Aug 14, 2025 at 11:32:55AM +0200, David Hildenbrand wrote:
> > On 13.08.25 20:52, Lorenzo Stoakes wrote:

> > > I can't see anything in the kernel to #ifdef it out so I suppose you mean
> > > running these tests on an older kernel?

...

> > > But this is an unsupported way of running self-tests, they are tied to the
> > > kernel version in which they reside, and test that specific version.

> > > Unless I'm missing something here?

> > I remember we allow for a bit of flexibility when it is simple to handle.

> > Is that documented somewhere?

> Not sure if it's documented, but it'd make testing extremely egregious if
> you had to consider all of the possible kernels and interactions and etc.

> I think it's 'if it happens to work then fine' but otherwise it is expected
> that the tests match the kernel.

> It's also very neat that with a revision you get a set of (hopefully)
> working tests for that revision :)

Some people do try to run the selftests with older kernels, they're
trying to get better coverage for the stables.  For a lot of areas the
skipping falls out natually since there's some optionality (so even with
the same kernel version you might not have the feature in the running
kernel) or it's a new API which has a discovery mechanism in the ABI
anyway.  OTOH some areas have been actively hostile to the idea of
running on older kernels so there are things that do break when you try.
TBH so long as the tests don't crash the system or something people are
probably just going to ignore any tests that have never passed.

--HgKF1GOS9//9I841
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmidzGUACgkQJNaLcl1U
h9A7uAf/TsWdfXYkIPkM2Rj3C1HzjIuj6j4nnUhMESgtZSbf9Am99POGQmQxnUay
Mz75k34/LOlxbUGyk2oz2tqb4Ad725WPmSqg4IEQXJ3or551O2tAApBrrbwTKfrT
ha9jUqj/hhFasDuM9PZsHTUcEk4DKGYtFHOtrucuQMDOSNH7lsB3BEVyaY4xxHzM
d2dWm3i1c8VlbU8gFIX794INH1sdcja2Syh0d5wraBAZ+NS+uJ5iWyZw43YgTGiX
qQR+HWxD/m3NSNX6L58jpZYJq6Q40xDz8aQQiAd2omnwIYWln4HIitcYTpeNvQNw
Poh6lZXtgIVoXt2Io6PYJpr3LnpP6A==
=Xem/
-----END PGP SIGNATURE-----

--HgKF1GOS9//9I841--

