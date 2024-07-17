Return-Path: <linux-fsdevel+bounces-23838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D7C933FAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564861C2326E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFD21CF8A;
	Wed, 17 Jul 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3PIF9no"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B118181B94;
	Wed, 17 Jul 2024 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230118; cv=none; b=oSvfXw8wB+WQnOAftL6hCXJ8jyaerTToKepygi0uHvGGNBO0p+dVDkSs/caBHxRs/pZRwhFHM0oCEaAkdHjlk27C9po8E0crn2GbBp1JlqWS68J7xyWCRco0Tfqnhv9ml9+LDY9Q1k1XXrbpJk5xxfSBKKGWaWDe1+Yx9F5RwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230118; c=relaxed/simple;
	bh=ukWBWdiCV90bf+K1lUELQn/UyLGZdA/ugOA19ZyBXHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncRTl/Qfhwmn3A42ei07mIxT1f7ftEZgKruI3oeookSwN+ZcX27hd1j5563GXtRJCR+OFyZLhXP2wbcpbtiFI0AAXLzg+9C6bOBRQ1d79udRfbGPKyPu5Vuj4oGEbWPNxT8GxeKR3XQo3gtT+i4VoNF1v2C0hkVEGkMSNocPiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3PIF9no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4EEC4AF11;
	Wed, 17 Jul 2024 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721230117;
	bh=ukWBWdiCV90bf+K1lUELQn/UyLGZdA/ugOA19ZyBXHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3PIF9noxw/EmK0iQ64CIvMRoQtkUSZm+1XevS7zxoStKg5JQPXHJlg8IU5RJZpcr
	 kkF2HbTJe+ClHj3+rZQDKaKK2Cy4VcJvwK2A40VhLza++TNBmeFKpxsYozVv1V+RJd
	 BeHJUyzEuN47tHZ6V6NszSlSMSW94Va2/HjvLsAeMB6t5uPrWosA0FKDJ+PlgEaZog
	 3KzdUg9k+Nx1gMZjK7jl1xM1jAOpM3bo5Qp47w2Q9KaDwUpZns+jwrGfVa+4n+Wi50
	 DUlk9Lud/2N6I51hkdkPMdV+XmlL1vfq4/oVWxBdhChNqFtoGDJReknBht7B/a4Tbe
	 Y1QWQ/qq+FoyA==
Date: Wed, 17 Jul 2024 16:28:27 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "fweimer@redhat.com" <fweimer@redhat.com>,
	"sroettger@google.com" <sroettger@google.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"ross.burton@arm.com" <ross.burton@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"Schimpe, Christina" <christina.schimpe@intel.com>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"Pandey, Sunil K" <sunil.k.pandey@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 05/39] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <dbc210a3-7653-444a-9dcc-b8d4ea92bd9b@sirena.org.uk>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
 <20240625-arm64-gcs-v9-5-0f634469b8f0@kernel.org>
 <87a5iph6u2.fsf@oldenburg.str.redhat.com>
 <Zo7SdDT_cBp6uXgT@finisterre.sirena.org.uk>
 <2fb80876e286b4db8f9ef36bcce04bbf02af0de2.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h9KvXQkczWY3GIVF"
Content-Disposition: inline
In-Reply-To: <2fb80876e286b4db8f9ef36bcce04bbf02af0de2.camel@intel.com>
X-Cookie: You should go home.


--h9KvXQkczWY3GIVF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 06:50:12PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-07-10 at 19:27 +0100, Mark Brown wrote:
> > On Wed, Jul 10, 2024 at 12:36:21PM +0200, Florian Weimer wrote:

> > > We also have a gap on x86-64 for backtrace generation because the
> > > interrupted instruction address does not end up on the shadow stack.
> > > This address is potentially quite interesting for backtrace generatio=
n.
> > > I assume it's currently missing because the kernel does not resume
> > > execution using a regular return instruction.=A0 It would be really u=
seful
> > > if it could be pushed to the shadow stack, or recoverable from the
> > > shadow stack in some other way (e.g., the address of the signal conte=
xt
> > > could be pushed instead).=A0 That would need some form of marker as w=
ell.

> > Right, we'd have to manually consume any extra address we put on the
> > GCS.=A0 I'm not seeing any gagetisation issues with writing an extra va=
lue
> > there that isn't a valid stack cap at the minute but I'll need to think
> > it through properly - don't know if anyone else has thoughts here?

> Shadow stack has one main usage (security) and another less proven, but
> interesting usage for backtracing.=A0I'm wary of adding things to the sha=
dow stack
> as they come up in an ad-hoc fashion, especially for the fuzzier usage.=
=A0Do you
> have a handle on everything the tracing usage would need?

Yeah, the current instruction pointer seems fairly straightforward to
idiomatically fit in there but going beyond that gets tricker.

> But besides that I've wondered if there could be a security benefit to ad=
ding
> some fields of the sigframe (RIP being the prime one) to the shadow stack=
, or a
> cryptographic hash of the sigframe.

One trick with trying to actually validate anything extra we put in
there from the sigframe would be that one of the things a signal handler
can do is modify the signal context - for the specific case of RIP
that'd be an issue for rseq for example.

--h9KvXQkczWY3GIVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaX4xoACgkQJNaLcl1U
h9Cgxwf9EtoH1wDADGEHB812knHuhpaXQ+HApRHTVo5CjSDf2jXeTXGAeof7B8TM
MLHNoO3uezt5r1bpHpC7gAruLzfAEs+G+rahhQswSuEDDGQLhcZga0SHFL2cmZpM
SZ2Lk3725bJaoUzexEHk/8ZjpXnrzWXi+U/YoTi9PfcX6bUfVufG0hPr/xR8836n
kKF9q2R93WTz8gIiIHpuUqgQ7jRjrDW5UIi0KhRobcLRKBhL5aYVQ1T9GVgwjA4v
7R3dDdrlAWQLJcjwjciJ3Ti6xSB2evfDt2FjmDE23My2AkO7dJebKhz7fABWCRbZ
f2X9PmkSZlUHX26EuZIME4o9ENxnWg==
=HySw
-----END PGP SIGNATURE-----

--h9KvXQkczWY3GIVF--

