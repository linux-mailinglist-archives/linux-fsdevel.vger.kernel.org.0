Return-Path: <linux-fsdevel+bounces-27627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B0962E9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 19:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75E9284E78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779BB1A76A5;
	Wed, 28 Aug 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/xcOhor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB11A3BCE;
	Wed, 28 Aug 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866378; cv=none; b=sKTXaddVtPQ/6nZUN7s08Euw37DGGj7NOAavF3H7JGv796Bh4rEqjXxucLLBao6U4+e48fe1jT6iL5gd7l12ctyjyujh0/NkotrowsMIXzhyTzklUCvaaUKnOvz/8KmnidPTVKSR4qv/LfYBCyxCE3yuF0efntuRqp3vDSsYPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866378; c=relaxed/simple;
	bh=4MDDdzSEhRjEbEa2n9fIYxr42mIY+eyZfSj6+j+Bu0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEaL/Pf4PgHqJjzwWdqKFjIiFEJJBqGUuOpOLicxoUU5Ol9afleYtlZSluN88oNHOc4ryVuQSfSWbhfJTdXkaYxIWMtcuwJHhCH8cY1uyH8MTCloy8Lx0cCFdJKCs3pB2AwaAFl7KLN+GRX+qpOh8S5gn/eOJLacWLMSjK5Dk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/xcOhor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71927C4CEC0;
	Wed, 28 Aug 2024 17:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866378;
	bh=4MDDdzSEhRjEbEa2n9fIYxr42mIY+eyZfSj6+j+Bu0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/xcOhorFRSv2vHmRagMWmGxh+ScNnb9p5YrzG9/pAmQfUsEg399/CaTU0Z06a3Kd
	 25gBR9x3tRKON/9TVqn3X9yWKKyvoaXPglSuRX8H/AEzCQfOfamSFXFrUflPvWSiAU
	 m2RTlwhEQm6GYG4Uu3jWFaCtKcYLtQjATOV2MkQy03IMy9y2Bez9OmpxvhprGtMcQG
	 PjRlInV3Bc/JK1THjQVmMuPnn6fu1rOqZ3+sGnnl2KRptQU5L4iIPf6dlZynx0jL9x
	 730E1RPdEdJUvwP5kiHq7t30Mte5uQ7x3NQJjn8eIqgssRzUyqSg0jXamQWsy9Pz/C
	 BWKufAwkMrGMg==
Date: Wed, 28 Aug 2024 18:32:48 +0100
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
Message-ID: <4de41478-3bc8-4cb4-a557-3e9402afe858@sirena.org.uk>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-25-41b81947ecb5@kernel.org>
 <ZshYTyNbveD7WMyJ@arm.com>
 <ZshjmuYcejbhaSBg@finisterre.sirena.org.uk>
 <Zsixz6Y9xWxqaQaV@arm.com>
 <ZskGqU8BSvR01W30@finisterre.sirena.org.uk>
 <ZsxSKVAOHQq12YfB@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qwAebp9So100JWhv"
Content-Disposition: inline
In-Reply-To: <ZsxSKVAOHQq12YfB@arm.com>
X-Cookie: You are number 6!  Who is number one?


--qwAebp9So100JWhv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2024 at 01:00:09PM +0300, Catalin Marinas wrote:
> On Fri, Aug 23, 2024 at 11:01:13PM +0100, Mark Brown wrote:
> > On Fri, Aug 23, 2024 at 04:59:11PM +0100, Catalin Marinas wrote:

> gcs_preserve_current_state() only a context switch thing. Would it work
> if we don't touch the thread structure at all in the signal code? We
> wouldn't deliver a signal in the middle of the switch_to() code. So any
> value we write in thread struct would be overridden at the next switch.

I think so, yes.

> If GCS is disabled for a guest, we save the GCSPR_EL0 with the cap size

s/guest/task/ I guess?

> subtracted but there's no cap written. In restore_gcs_context() it
> doesn't look like we add the cap size back when writing GCSPR_EL0. If
> GCS is enabled, we do consume the cap and add 8 but otherwise it looks
> that we keep decreasing GCSPR_EL0. I think we should always subtract the
> cap size if GCS is enabled. This could could do with some refactoring as
> I find it hard to follow (not sure exactly how, maybe just comments will
> do).

I've changed this so we instead only add the frame for the token if GCS
is enabled and updated the comment, that way we don't modify GCSPR_EL0
in cases where GCS is not enabled.

> I'd also keep a single write to GCSPR_EL0 on the return path but I'm ok
> with two if we need to cope with GCS being disabled but the GCSPR_EL0
> still being saved/restored.

I think the handling for the various options in the second case mean
that it's clearer and simpler to write once when we restore the frame
and once when we consume the token.

> Another aspect for gcs_restore_signal(), I think it makes more sense for
> the cap to be consumed _after_ restoring the sigcontext since this has
> the actual gcspr_el0 where we stored the cap and represents the original
> stack. If we'll get an alternative shadow stack, current GCSPR_EL0 on
> sigreturn points to that alternative shadow stack rather than the
> original one. That's what confused me when reviewing the patch and I
> thought the cap goes to the top of the signal stack.

I've moved gcs_restore_signal() before the altstack restore which I
think is what you're looking for here?

--qwAebp9So100JWhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPXz8ACgkQJNaLcl1U
h9AINwgAghxTu8PB4VcQHkYwz1H/qDleYcPMAHplNpZgcLpx59wTJgBZ5QfIwDnV
v12mJKsZJ3gfnHdZipZjp7EKhKGELQUTGRLICZqBr9S/8SfK3cXC3z6gQEXLxu3W
Z122sDonqb/vfykIYhrtWeP12Rgm1n7KRplfJrXGx+xfZD2pQRdydES4L5RWtbZU
coJqFBLlGHRFqsnIUQni4PFl1UCQRVitFHHS4nL+Fs/lGj+rkjM69mkCQjmAHR1d
/Wivj6fyHPPQj8UCXiCXkk+/KcM64IZqgoTzIdYH+khbjTKKaBC0s06fnqJqU2n1
d06XGwawJkM0HfQlIcf0XRaB8a7aew==
=V6Zo
-----END PGP SIGNATURE-----

--qwAebp9So100JWhv--

