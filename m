Return-Path: <linux-fsdevel+bounces-10311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ABA849A7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAF51C20643
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50007210ED;
	Mon,  5 Feb 2024 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiq7v3WH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E072C859;
	Mon,  5 Feb 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136563; cv=none; b=Q039HIxyetQidiyk+auvmGWLw7iWVfJ0n0SnMdVp+yuIDbh7JsgGIbsHGEZVwSPSGQ1kkUgIsg9LTDlywJ/etFfmEtchCvVVKb1VBvzegAubMVUITkPwjupK3bYERsZ2bJF0XYqJrAYsXACVEC86K2I3JFnFzuBzqZv61ibUCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136563; c=relaxed/simple;
	bh=W/gM23dRxGIQHhXX9oPXf9/doTEakFPicYrHGjQOU1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAqc8fxcX4EQ9Hwi0WrQOIw82PJebCvNzno++fG7KNEItPNlKk8E4OUlZAtFuJdM0XUSKmsnod0i/17M9UQX+znq4FbpL2bj1Ud2DLOpSXu23NXdGhp0JkBZe3kZeDR0Yo2dIuiKHGgoqfMBXD3HbQERVQyhtkeFVkaE4PzP+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiq7v3WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E9CC433F1;
	Mon,  5 Feb 2024 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136563;
	bh=W/gM23dRxGIQHhXX9oPXf9/doTEakFPicYrHGjQOU1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiq7v3WH4BXjlBM5da8GhgVzNWrFmT69sXn2Z3kO+XSByinlTm+nldLGPza1A7/ZM
	 wYC2Gg9vCokYw5fDYx/qQEg2c+CFP8iw+xofOVbNYvnsXNedFxCGd3ufs6VxoNBeXH
	 50FKZLbJXyju+0fAQ40QoDCyBn6FtSNDMwDjUf/bYITVShxqCLWvtPS6T5UZsH074b
	 a0LHJ05ccHIX0vYhq4C9uU5ICN03IOzpsz9v1K8Bnll82Jt9fqjDRwilIiy+Cj6O2j
	 Bj2o/ErTqvL0oT0WwGQ3pMhdwKYHeSpKoUUHqRyRoHtoufMjdrU1igTNgB3FQOIkyG
	 /jdgN58UpyTUQ==
Date: Mon, 5 Feb 2024 12:35:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 13/38] KVM: arm64: Manage GCS registers for guests
Message-ID: <825d2b35-fa10-43ad-b3b3-b29a77f3fed0@sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-13-c9fec77673ef@kernel.org>
 <868r3z6y6v.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SWF5NMV/X92Kf8zP"
Content-Disposition: inline
In-Reply-To: <868r3z6y6v.wl-maz@kernel.org>
X-Cookie: No solicitors.


--SWF5NMV/X92Kf8zP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2024 at 09:46:16AM +0000, Marc Zyngier wrote:
> On Sat, 03 Feb 2024 12:25:39 +0000,
> Mark Brown <broonie@kernel.org> wrote:

> > +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> > @@ -25,6 +25,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
> >  {
> >  	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
> >  	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
> > +	if (has_gcs())
> > +		ctxt_sys_reg(ctxt, GCSPR_EL0) = read_sysreg_s(SYS_GCSPR_EL0);

> We have had this discussion in the past. This must be based on the
> VM's configuration. Guarding the check with the host capability is a
> valuable optimisation, but that's nowhere near enough. See the series
> that I have posted on this very subject (you're on Cc), but you are
> welcome to invent your own mechanism in the meantime.

Right, which postdates the version you're replying to and isn't merged
yet - the current code was what you were asking for at the time.  I'm
expecting to update all these feature series to work with that once it
gets finalised and merged but it's not there yet, I do see I forgot to
put a note in v9 about that like I did for dpISA - sorry about that, I
was too focused on the clone3() rework when rebasing onto the new
kernel.

This particular series isn't going to get merged for a while yet anyway
due to the time it'll take for userspace testing, I'm expecting your
series to be in by the time it becomes an issue.

> > +	if (has_gcs()) {
> > +		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSPR_EL1),	SYS_GCSPR);
> > +		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSCR_EL1),	SYS_GCSCR);
> > +		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
> > +			       SYS_GCSCRE0_EL1);
> > +	}

> For the benefit of the unsuspecting reviewers, and in the absence of a
> public specification (which the XML drop isn't), it would be good to
> have the commit message explaining the rationale of what gets saved
> when.

What are you looking for in terms of rationale here?  The KVM house
style is often very reliant on reader context so it would be good to
know what considerations you'd like to see explicitly addressed.  These
registers shouldn't do anything when we aren't running the guest so
they're not terribly ordering sensitive, the EL2 ones will need a bit
more consideration in the face of nested virt.

--SWF5NMV/X92Kf8zP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXA1iYACgkQJNaLcl1U
h9Dczgf8Co+AEsFdqthpdeHca9wZHZrvIV4GyHYFYxQUc2QQcQF8l68f9qpa+7WU
wwyKL5wu1uARGynhBiI1rGQHAv8lBunf5D4wkD3kJ8X/AtB0wSRFutA2Q35fQDo3
HcJi94+8UvNTLtAgbLMmiyihG6PxVhpUfwA3SZCuun068j81Zcd1hX4hUlpuSEXr
hm5Hy73ooZ/T/F5OrYsxxUuEbTRWHYhPq+CXEhWhtyTK9wRAzDes+UK6rXdjfOmj
iFWAR4jYhFukgcENJvGgwKKvS1YUFxMABGAPJmIfjjX/3eVNriZDeh5DFHyrrp+R
LPixjIxkXqN9p1+ZfpiReAfH4T+wRQ==
=7b9C
-----END PGP SIGNATURE-----

--SWF5NMV/X92Kf8zP--

