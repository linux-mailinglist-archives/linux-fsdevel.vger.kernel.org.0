Return-Path: <linux-fsdevel+bounces-26893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E34B95CA71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B32281CCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD517E01F;
	Fri, 23 Aug 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p85uLFPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1714A092;
	Fri, 23 Aug 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408734; cv=none; b=icb+AlQGbLFJyH9agcM1YbjIIi/UsMaM0Z9zYJPIxjVnUXjiJkw3IGkXhd/J3qpoa4aocaVwSl+w47nnEYghyKW64SzAuREwivIxcamt96qTmH0Z9N8e/WWaoe0MVAEuLeZMhX2s/aT6sYkKdCv5m4WJEQBtROORtUswsQRwU8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408734; c=relaxed/simple;
	bh=sQqhNYedR1BK3builnVoyg4SxBnBW3yPxbGa623Z0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP1lPRtw1p11txD32uRLQPxZP5MHBrnbKuSIRF43qLF6iz0YsRJq5Y7rRyih1+F8GAhAMWU868DY/jOwnsSKugONwNZnKil8xDGibTKVLL9Sch165vEsFK62qgOP0coPig6pEt8cgTJEC4mmTm7sGOUToteZaX3cEfFiE5xthC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p85uLFPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EFEC32786;
	Fri, 23 Aug 2024 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724408733;
	bh=sQqhNYedR1BK3builnVoyg4SxBnBW3yPxbGa623Z0Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p85uLFPzRzTjF8TlOpeiA4rumcvxDEt5Fylq/9D05p3sIyY+055i0xe3zxSZLAoqN
	 QZHNkumhB+xPzgZ/sxTPyBYYrNrG8f5anr2pue94kpefrN+CCKb4iLhzMhRTBpSA0K
	 sVYCVfW5FfB2qLD+0FFI6UGF0ZbAxjh5/DQ4oH00TXYoDQs14NRelVjlKHMrBh/wqb
	 WIAQ2tuAChr2+JPT3qMr5aq++L4A6q4aPfN6kAHB7/S6XhE8E13elQ+Sv0HMTl8mQd
	 AV1ckfw3bNkrK34vkLNFaaA8WrSpMbnM/HArzMkeG+5njHE00+M1umnvsYvWZyPQyj
	 cpi/uhsdQGqjA==
Date: Fri, 23 Aug 2024 11:25:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 25/39] arm64/signal: Expose GCS state in signal frames
Message-ID: <ZshjmuYcejbhaSBg@finisterre.sirena.org.uk>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-25-41b81947ecb5@kernel.org>
 <ZshYTyNbveD7WMyJ@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/CrZc0/PCTYKFxlL"
Content-Disposition: inline
In-Reply-To: <ZshYTyNbveD7WMyJ@arm.com>
X-Cookie: Your love life will be... interesting.


--/CrZc0/PCTYKFxlL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2024 at 10:37:19AM +0100, Catalin Marinas wrote:
> On Thu, Aug 22, 2024 at 02:15:28AM +0100, Mark Brown wrote:

> > +	gcs_preserve_current_state();
> > +	gcspr = current->thread.gcspr_el0 - 8;

> > +	__put_user_error(gcspr, &ctx->gcspr, err);

> Do we actually need to store the gcspr value after the cap token has
> been pushed or just the value of the interrupted context? If we at some
> point get a sigaltshadowstack() syscall, the saved GCS wouldn't point to
> the new stack but rather the original one. Unwinders should be able to
> get the actual GCSPR_EL0 register, no need for the sigcontext to point
> to the new shadow stack.

We could store either the cap token or the interrupted GCSPR_EL0 (the
address below the cap token).  It felt more joined up to go with the cap
token since notionally signal return is consuming the cap token but
either way would work, we could just add an offset when looking at the
pointer.

> Also in gcs_signal_entry() in the previous patch, we seem to subtract 16
> rather than 8.

We need to not only place a cap but also a GCS frame for the sigreturn
trampoline, the sigreturn trampoline isn't part of the interrupted
context so isn't included in the signal frame but it needs to have a
record on the GCS so that the signal handler doesn't just generate a GCS
fault if it tries to return to the trampoline.  This means that the
GCSPR_EL0 that is set for the signal handler needs to move two entries,
one for the cap token and one for the trampoline.

> What I find confusing is that both restore_gcs_context() and
> gcs_restore_signal() seem to touch current->thread.gcspr_el0 and the
> sysreg. Which one takes priority? I should probably check the branch out
> to see the end result.

restore_gcs_context() is loading values from the signal frame in memory
(which will only happen if a GCS context is present) then
gcs_restore_signal() consumes the token at the top of the stack.  The
split is because userspace can skip the restore_X_context() functions
for the optional signal frame elements by removing them from the context
but we want to ensure that we always consume a token.

> > +	/*
> > +	 * We let userspace set GCSPR_EL0 to anything here, we will
> > +	 * validate later in gcs_restore_signal().
> > +	 */
> > +	current->thread.gcspr_el0 = gcspr;
> > +	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);

> So in preserve_gcs_context(), we subtract 8 from the gcspr_el0 value.
> Where is it added back?

When we consumed the GCS cap token.

> > +	if (add_all || task_gcs_el0_enabled(current)) {
> > +		err = sigframe_alloc(user, &user->gcs_offset,
> > +				     sizeof(struct gcs_context));
> > +		if (err)
> > +			return err;
> > +	}

> I'm still not entirely convinced of this conditional saving and the
> interaction with unwinders. In a previous thread you mentioned that we
> need to keep the GCSPR_EL0 sysreg value up to date even after disabling
> GCS for a thread as not to confuse the unwinders. We could get a signal
> delivered together with a sigreturn without any context switch. Do we
> lose any state?

> It might help if you describe the scenario, maybe even adding a comment
> in the code, otherwise I'm sure we'll forget in a few months time.

We should probably just change that back to saving unconditionally - it
looks like the decision on worrying about overflowing the default signal
frame is that we just shouldn't.

--/CrZc0/PCTYKFxlL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbIY5MACgkQJNaLcl1U
h9Bi+gf8CXq7dITB6mfDzRqVPcrdnIF0zDFjmHC8iIhqzkArOPeUrHuV8v1JvQKo
xxY+T75lyZYVhNmi/4AnCvx2NQ+73+wmg5ZJyg3MMYv67UP5A4Gk8cOO3DP4gNZp
GkinUu6g/33nKttu0Z8bNrylbmSVqqtFnh3Bzbv74LhYyKDe/dQ9CuCtZBEgjcQN
U3x2p8TYyhcqu6/7OkT7MNJtI825nOVxVQh2B4Rlfp0ea+z2UNkTocgU12qsyZRt
ew3ERI/4vdbAgPIIvqX5hmkLCEn6GNpyohGHm6LJ1BEZx3DGM9Ev6Q/ImtCMF+ty
5N4sxm/JaJbA6ExZyirRb8m7CyRISQ==
=OryW
-----END PGP SIGNATURE-----

--/CrZc0/PCTYKFxlL--

