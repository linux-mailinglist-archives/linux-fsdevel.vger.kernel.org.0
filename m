Return-Path: <linux-fsdevel+bounces-13289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C693986E341
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014A01C21D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFCE6F50A;
	Fri,  1 Mar 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTHxOMSp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5E6EB7C;
	Fri,  1 Mar 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303054; cv=none; b=RiVLBp1Fps0j+5cv8HrmLouxmQzC/TPNNqBmSid1CrqxdqbMoewuvLpM11JsTAii8gcjjd5FkChGnceiFzwP2ij7l5LlleJW4MIP8SNXyuMnM46mkDNWDv6GV4H3r3E5lsPVp5H/JjdGwIjHmwBcqnEPaRBW6CkmlqQa0V9L2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303054; c=relaxed/simple;
	bh=2ShIAu9aZ8JgsAuFdkiNPsP5fHzU5NJRTwCaSw/PEp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3DKAjSJ3yDZVXtiGugjZyAijfoU2wpE/EZvibeW85oRS+gyZ3olDjDV8eHyKoBQNzQByWREOGffTmOCoJvjZlkg96w9TeDJVKbLSDMd4m9PmFQACANfHc68n0c7b4rbio0muZTdt5lmK7QXmN0rgGmsBU7Q7mR+ezglOy4vmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTHxOMSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFBBC433C7;
	Fri,  1 Mar 2024 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709303053;
	bh=2ShIAu9aZ8JgsAuFdkiNPsP5fHzU5NJRTwCaSw/PEp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTHxOMSpiF+wkW+P6AxOX8LcZVGY5xt9HSew5vdtPX298f6u1KTW9UAX8Zdi5ujqn
	 jMkg2q62mA9uD3nPuXAwF4Cz8WC9amMkRLiIcZwt6EbeDJrM5SPvIWLrYRbTL+8XW4
	 mCGwIUPcbLtGtQsrUoL+W2y/BCF/EXQMPGnrR7djmTCe9pM05kknyBLPbau1jjuWLm
	 +L/dbMZq7BB07HwR2GL4cSXEh44Jk5uDcM68aq+AEL49ImAL9zlA0Yf8opz2gkH1GO
	 zguDs/3YOp1LWWuAur7ghZyfo8yZt319eCGjw1qztsfXoxcNYq7K3ssOIsquoBLXkF
	 aGRq48op4cx+g==
Date: Fri, 1 Mar 2024 14:24:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zi Yan <ziy@nvidia.com>, Aishwarya TCV <aishwarya.tcv@arm.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Message-ID: <888bedc2-9677-4958-8dd7-71fbbd66b08d@sirena.org.uk>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
 <08703C70-DD6E-446A-9ABC-BC2C8E33B8CD@nvidia.com>
 <f7a3d07d-290b-46d6-884e-fa288901c3c6@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2H4DSXjCnO3MNwX"
Content-Disposition: inline
In-Reply-To: <f7a3d07d-290b-46d6-884e-fa288901c3c6@arm.com>
X-Cookie: Schizophrenia beats being alone.


--d2H4DSXjCnO3MNwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 01:09:04PM +0000, Ryan Roberts wrote:
> On 01/03/2024 12:52, Zi Yan wrote:

> > I can do that. But is this a new requirement that self tests have to be=
 finish
> > in CI/CD environment? Can you provide a guideline for it?=20

> I'm not sure what's written down, but certainly anyone should be able to =
run the
> selftests with as little knowledge as possible, and they should only fail=
 if
> they detect a real problem. By convention a test should be skipped if the

It does get mentioned in talks and things but TBH I think it's just
generally a good practice thing.

> > Since I always assume
> > selftests are just ran by human who can set up environment.=20

> I believe kernelci have been running mm skeftests on x86 for a long time.=
 We
> have started running them against arm64 on our CI for the last couple of =
months
> and it had found a number of real issues in the kernel in -next, so this =
is
> helping find and fix things early. So there is definitely benefit to keep=
ing
> these tests clean and robust.

They're also being routinely run on at least some platforms by LKFT
(though from a quick check it seems not with the magic command line
options to set up secretmem and huge pages) and CKI, possibly also some
of the other CI systems I'm less aware of.

--d2H4DSXjCnO3MNwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXh5QQACgkQJNaLcl1U
h9CxkAf/adE7KBi4x/8BcY4JyrlGWzoh04qkP32+a1ogYNL/OSoAT8tziWVGRHB3
iV/4b1y1dcwrcAHsYMg4WTebJsa7BkOEleKQeZpQrjJLWM50FDngX4uTm5nzuQQT
RIiD7Pp8pjJIV+uC1BiQrVUGOoJwepIBOu1fta6NslqtaIXFDnH2m1d0Uj/fsitN
1yNfRkDHFQTPdcNWUIUskJLFrjhF5gqNyLNwN4+QnJwJWTfhgfOOCtrZTo8Uj7KD
xtA/wImC0/lxwNcIm98Dn8EFFk14Ap/9/WcAekG1mL0rF+WN0ZKnaU4MiW9HHJkO
/cpR3XdfvBIka+CwGDUQoH0uJCG4Gw==
=xf+x
-----END PGP SIGNATURE-----

--d2H4DSXjCnO3MNwX--

