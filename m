Return-Path: <linux-fsdevel+bounces-24339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198693D7BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A9D284468
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1127517D347;
	Fri, 26 Jul 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV/Z7vEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B3812;
	Fri, 26 Jul 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015575; cv=none; b=pgHBxkMdml4rnBSNNH3tOHGRdNiuS+hsDuW+UbjQUnFt/lbAr5k+agSNQ2N+k/5Y8wyuMuaE4TrTl0qnIzMet6I3JiI09Z9qBjSpZA6SHM8PLlCJDmNqGytDRzxU+ueM6ES9mULwtUDf/hu//XuTdOBpFmy1HJS9eCQUQa/z4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015575; c=relaxed/simple;
	bh=8w1mM4hsz30RIDmoijcUZjPnnrqcKXvR4sSqM1tep/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axDG/WJNMsRewWeTiz714nUgr5QefqEY+eHLY1vtk9ZiMJWOqGCQBVY3B0EaqQbgbrmniPNkSUhnsUUgax2KRsDB3Cw5I+GddKAZ3aYbSpmLTe4YR4c+N1rPCFfFD6uswP/x8Yhyt1u5rKrmw3OPe/W5+yZnD+7p4i/RSy4uH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV/Z7vEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184F0C32782;
	Fri, 26 Jul 2024 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722015575;
	bh=8w1mM4hsz30RIDmoijcUZjPnnrqcKXvR4sSqM1tep/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DV/Z7vEtOQ6fpK1XlwOsYQ7qcHj5loTqEE6QOhCsSqjvyq9NRvKlcmNtdC2g8jhY6
	 aWv73Vf0gzmua1r6eBaKdypdddT45gnW/E0ABD3it7eli5FXDS+vnvrvDj+V5Zfuuf
	 xJNXr3X9g2ZxiiKEMQrknbNds0YasB4VTugZ9IQSP4WKpt7pUqp9dLjKWUReroNOBk
	 zdaLXSY7z39Eb+B855w+mW2obCbZIuBQWm6KGs+ypfSLztcWYns4CkQV6YGLM+lL6w
	 dPuiR8OQU9eJqPpaihNfj/a0aVBCnjAMFu+cCYtlW4GgQA0xW00IYT91LmXOdgA9e2
	 EkBh389uPh7Pg==
Date: Fri, 26 Jul 2024 18:39:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <a52f1762-afd4-4527-88ac-76cdd8a59d5d@sirena.org.uk>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <229bd367-466e-4bf9-9627-24d2d0821ff4@arm.com>
 <7789da64-34e2-49db-b203-84b80e5831d5@sirena.org.uk>
 <cf7de572-420a-4d59-a8dd-effaff002e12@arm.com>
 <ZqJ2I3f2qdiD2DfP@e133380.arm.com>
 <a13c3d5e-6517-4632-b20d-49ce9f0d8e58@sirena.org.uk>
 <ZqPLSRjjE+SRoGAQ@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jKu8x7uvwJS8RqOX"
Content-Disposition: inline
In-Reply-To: <ZqPLSRjjE+SRoGAQ@e133380.arm.com>
X-Cookie: It is your destiny.


--jKu8x7uvwJS8RqOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2024 at 05:14:01PM +0100, Dave Martin wrote:
> On Thu, Jul 25, 2024 at 07:11:41PM +0100, Mark Brown wrote:

> > That'd have to be a variably sized structure with pairs of sysreg
> > ID/value items in it I think which would be a bit of a pain to implement
> > but doable.  The per-record header is 64 bits, we'd get maximal saving
> > by allocating a byte for the IDs.

> Or possibly the regs could be identified positionally, avoiding the
> need for IDs.  Space would be at a premium, and we would have to think
> carefully about what should and should not be allowed in there.

Yes, though that would mean if we had to generate any register in there
we'd always have to generate at least as many entries as whatever number
it got assigned which depending on how much optionality ends up getting
used might be unfortunate.

> > It would be very unfortunate timing to start gating things on such a
> > change though (I'm particularly worried about GCS here, at this point
> > the kernel changes are blocking the entire ecosystem).

> For GCS, I wonder whether it should be made a strictly opt-in feature:
> i.e., if you use it then you must tolerate large sigframes, and if it
> is turned off then its state is neither dumped nor restored.  Since GCS
> requires an explict prctl to turn it on, the mechanism seems partly
> there already in your series.

Yeah, that's what the current code does actually.  In any case it's not
just a single register - there's also the GCS mode in there.

--jKu8x7uvwJS8RqOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaj304ACgkQJNaLcl1U
h9CeVAf/WJj2W/iYeqVHnIEx+p4FWw5ApJBNcEdmXOIBDVGUJEIji/s5+DIMmTsR
GnMMoGn0PGovhD7ABJPly+Ysr1Ma/cWGs/eia+AhmGLvDh7ATNWxUWPWoQpfH4vI
FFXbia4AkmLZ34lsI6P1BKT5wTRVWQj9QaTTCFxVdoNmBF7nYgnT0u0A4Od9O9Vm
iX064HfEvrM/PwRID8FMKY2pXuOWTRWJrQ7X1l75V7H0wdUW1h6b5tWIyUuoZIOl
RChlS70kcpLdwt6Y0KjNj5bblDCwZ3KNQPEVcEWq2lMChKzoxm1I1QNmc7XEAqf9
JC4bAZwKKaKlseDDs61j4qyz/Nj1Hg==
=DfYC
-----END PGP SIGNATURE-----

--jKu8x7uvwJS8RqOX--

