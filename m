Return-Path: <linux-fsdevel+bounces-23523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF892DB87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 00:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C7CB20BD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6FD14535A;
	Wed, 10 Jul 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkQtx0Ys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F213D2A2;
	Wed, 10 Jul 2024 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649132; cv=none; b=iBsJF3xiKk2wcpdKjFO8/u3h8tDeK4q5PJQx5U4bHhgHHwd0453Wcbzf2w0BfrT1uQk180kyrQqGYPEh7YiUTSKckb1KOWEF9q4WdLwK2MXuohvorwTmZ5OyE7crZmaer0reY0jVBf6sz7rvTUWn84plF6rjXHWxS0EfsC7LIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649132; c=relaxed/simple;
	bh=Eu93rMUzk399cQ8hiVO2KE52oaiSsroTl8ghLIzLkfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDX1XLXLKIvthlc2OdDkw93yO9oRhjaSJSW1i7gcYkCzPQwT+x6baLem3xjmMf8QsNAapOiZuusWROPbHJFNBUCPngxCc0RFj6pp4E2tRbiHkcpo4O4fP5hAbun3T3+pdzbJZc+3FP01Sla4MI5TCTEVYYgyPOC7CWP++hA8UZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkQtx0Ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46743C32781;
	Wed, 10 Jul 2024 22:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720649131;
	bh=Eu93rMUzk399cQ8hiVO2KE52oaiSsroTl8ghLIzLkfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkQtx0YsVpapXk8nKor0mFxxgG/Sel10dpQi8Mi+udNtmWFH8kMBqVYpOwh4Hd57o
	 Fn1cjYbf21Au8EwCTMMoXlhwsSTLYn9lzqr1pgKMQ4gaNcRJRXZZQMHBu8LiVGWHGI
	 8nKQyBhir7wgr8l2dDteEUogPPp+0XXyFf9mRBsSGqCQ6BPAyGy9zpjKLrN23CPLjz
	 mrGlihLofkSTNkc0FSEniv9n+1JYFQuL2/0tzx7Hqx4md9CGzF26Kf5jWSEY7Ty7MQ
	 ZvhnAixRihlPWHfw+rBcJOiDFE38cp3xk6DMExk6qWoBPLPQdf09GcyH4+EeLUbq2+
	 2gzPUqbO088Tw==
Date: Wed, 10 Jul 2024 23:05:28 +0100
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
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 13/39] KVM: arm64: Manage GCS registers for guests
Message-ID: <Zo8FqFKQkuTv1r2M@finisterre.sirena.org.uk>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
 <20240625-arm64-gcs-v9-13-0f634469b8f0@kernel.org>
 <86v81d2s5t.wl-maz@kernel.org>
 <Zo7B_sRyUyxv7xmO@finisterre.sirena.org.uk>
 <86ttgx2jba.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O0du0pkUMxnEy6Qh"
Content-Disposition: inline
In-Reply-To: <86ttgx2jba.wl-maz@kernel.org>
X-Cookie: Your love life will be... interesting.


--O0du0pkUMxnEy6Qh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 07:28:09PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jul 10, 2024 at 04:17:02PM +0100, Marc Zyngier wrote:

> > > > +	if (ctxt_has_gcs(ctxt)) {

> > > Since this is conditioned on S1PIE, it should be only be evaluated
> > > when PIE is enabled in the guest.

> > So make ctxt_has_gcs() embed a check of ctxt_has_s1pie()?

> No. I mean nest the whole thing *under* the check for S1PIE.

OK, increasing the level of nesting.  Got it.  Does that just apply for
the EL1 registers given that there's no _user S1PIE registers so no
existing check there?

Should we also be doing a similar thing for features that depend on TCR2
- currently that's just PIE but it'll grow?  Probably only when we get
more features rather than now since we don't currently check if the
guest has TCR2, just the system.

> > GCSCRE0_EL1 is for EL0 though, it ended up here mainly because it's an
> > _EL1 register and we are already context switching PIRE0_EL1 in the EL1
> > functions so it seemed consistent to follow the same approach for GCS.
> > The _el1 and _user save/restore functions are called from the same place
> > for both VHE and nVHE so the practical impact of the placement should be
> > minimal AFAICT.  Unlike PIRE0_EL1 GCSCRE0_EL1 only has an impact for
> > code runnning at EL0 so I can move it to the _user functions.

> Exactly. That's where it belongs, because we never execute EL0 while a
> vcpu is loaded. On the contrary, we can make use of a uaccess helper
> while a vcpu is loaded, and that makes a hell of a difference.

OK, to be clear here "it" is GCSCRE0_EL1, not GCSPR_EL1 and GCSCR_EL1
which are for EL1?

> And it makes a difference because it would allow the loading of
> EL0-specific context differently. We had this at some point, and it
> was a reasonable optimisation that we lost. I'm keen on bringing it
> back.

Ah, that'd be good - not only for the optimistation but also since at
the minute it's a bit unclear why there are separate EL0/1 functions.

> > > you want to make this register writable, here's the shopping list:

> > > https://lore.kernel.org/all/87ikxsi0v9.wl-maz@kernel.org/

> > In the linked mail you say you want to see all fields explicitly
> > handled, could you be more direct about what such explicit handling

> This emails enumerate, point after point, everything that needs to be
> done. I really cannot be clearer or more direct. This email is the
> clearer I can be, short of writing the code myself. And I have decided
> not to do it for once, unless I really need to. And as it turns out, I
> don't.

See below, to be clear the only bit I was querying here was:

| - you *must* handle *all* the fields described in that register. There
|   are 15 valid fields there, and I want to see all 15 fields being
|   explicitly dealt with.

TBH it'd probably good to have that whole list in the kernel somewhere.

> > would look like?  I see a number of examples in the existing code like:

> > 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),

> This is clear: Everything is writable, and there are no bits here that
> are otherwise conditional or unsupported.

Ah, I think I see.  I would not have interpreted this as making
everything explicit, to me this makes all the writeable fields writeable
implicitly through them just not being mentioned.  For everything to be
explicit I would expect to see a direct, visible reference in the code
to every single field rather than something like we have here where some
of the fields are not mentioned directly.  The end result is an explicit
value but that's true for any use of ID_WRITABLE().

If my understanding is correct then were I writing the bit I quoted
above I'd probably just drop the "explicitly" from that bullet point due
to the handling of simple writable fields with ID_WRITABLE(), the key
point being that every field needs to be handled with the other points
enumerating the specific options for how each field might be handled.
Does my understanding sound correct?

> > which look to my eye very similar to the above, they do not visibliy
> > explictly enumerate every field in the registers and given that there's
> > a single mask specified it's not clear how that would look.  If
> > ID_WRITABLE() took separate read/write masks and combined them it'd be
> > more obvious but it's just not written that way.

> I don't really see what it would buy us, but never mind.

That was me trying to reconcile my understanding of you asking to make
everything explicit with the code as it is.  I suppose the advantage
would be documentation.

--O0du0pkUMxnEy6Qh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaPBaQACgkQJNaLcl1U
h9CfDgf9Hj4ORu0MQYC7C/o1bJG7/23dWcLbsWEReQjsF9FESFNxn/VmnbesRcD1
BShn5gjVprcOQokU/+w2py8ce3cKIl9K/238nc9ny+GvVPxoL3/F8o9GyrDGyXso
IeRw+jjwiYEIoc3ZF8b5foSxZkw+6043h5ELnTLLv78IlSM1E+E7lv8QysM8JjOX
zJc/G4s7mHk4Ohf9gjL7E13ni2Gy5Fhs7/Afkrz4IReeDNYeEhP4iiI0Ljg2E9XF
kr8rC5XenFN80dsZ5e5uhqg8SBzzHXk1kR69UpZnBM7jjhskJfy9xtzQbTkEjhL3
gA4J5POSV8LP8kFeG1MQkVwNU+a1Vg==
=mJl2
-----END PGP SIGNATURE-----

--O0du0pkUMxnEy6Qh--

