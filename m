Return-Path: <linux-fsdevel+bounces-26517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443A95A456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845B6B2304B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1B51B3B11;
	Wed, 21 Aug 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVf6XBs6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B1F7D07D;
	Wed, 21 Aug 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263404; cv=none; b=NXuch/NubouTctiBn2In/PcAgz771ATwMwFmNzTGqjviYfsu+J/dj/qDH4Z8SsbIZmxvdjVcvI4dLIR2nTksRPq0qmzX91jYCNp/lrkBC8R/HVz6C9qxajghllLROa72BtB33KgiM/LjdNOR5QzjcE2Yka7DNCoCUdWCqsPmJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263404; c=relaxed/simple;
	bh=/aRfrKXnSS1N7hftXMF8UQpgchZc2Ul1bFVicgzIero=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeSFTyWybtepfIkOb135erCIv7limj2W+81DRv9mR3eC9fvykAfnLd0wbuRb24KS9UnS2vdl6gUR3Jyv4qhC37qKqVXAUuAWd0mOZYIlsou2IVHdQWjIStKrog0/EbuiPCz5N4as3qKlziO4FlbiyXA9+LIK/4Woi+anS0jIyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVf6XBs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75F2C32781;
	Wed, 21 Aug 2024 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724263403;
	bh=/aRfrKXnSS1N7hftXMF8UQpgchZc2Ul1bFVicgzIero=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVf6XBs6LZ1VwE8MCvsuECUI8wDLGVGOsDoP+OXniIlNf3c8k325LY7GWi5qo07XQ
	 L5WmJeQ22aV02dE0bx8Uv+TTVGqk392h6XEVMUcuE3/Bquc1IP3YU+Tv4lXSErAX1A
	 tIPxc5SMCm4nwEyJW3TPX0DkImgCK/ZstcvqRamVSUaFlJI7wlo8DK+zzT1787oA5Q
	 JymUOdFqBvriwf4scDwIi3uE8VJVvMh86PiQJ2tfnUuD/uI1YznuR8F+kaHBKgHIDU
	 UKW/QdL/rg3e0M2U1kBKyw20f1xQDKzBhdwPOjgZjNs5tM589OUaEaken7gv5k/X4w
	 /DkM7l6sKJTGg==
Date: Wed, 21 Aug 2024 19:03:13 +0100
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
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 23/40] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <d5473c27-167f-46c3-9368-487ed4b657cf@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-23-699e2bd2190b@kernel.org>
 <ZsYj0YYMuX1YRBZT@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vOVm5CyTt8nbbuUu"
Content-Disposition: inline
In-Reply-To: <ZsYj0YYMuX1YRBZT@arm.com>
X-Cookie: You are false data.


--vOVm5CyTt8nbbuUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2024 at 06:28:49PM +0100, Catalin Marinas wrote:
> On Thu, Aug 01, 2024 at 01:06:50PM +0100, Mark Brown wrote:

> > +	ret = copy_from_user(&cap, (__user void*)gcspr_el0, sizeof(cap));
> > +	if (ret)
> > +		return -EFAULT;

> Can the user change GCSPR_EL0 to a non-shadow-stack region, fake the
> cap before sigreturn? copy_from_user() cannot check it's a GCS page.
> Does it actually matter?

We don't take any steps to prevent that since I'm not clear that it
matters, as soon as userspace tries to use the non-GCS page as a GCS it
will fault.  Given the abundance of ways in which a signal handler can
cause a crash it didn't seem worth specific code, the cap token check is
about protecting an actual GCS.

> > +	/*
> > +	 * Push a cap and the GCS entry for the trampoline onto the GCS.
> > +	 */
> > +	put_user_gcs((unsigned long)sigtramp, gcspr_el0 - 2, &ret);
> > +	put_user_gcs(GCS_SIGNAL_CAP(gcspr_el0 - 1), gcspr_el0 - 1, &ret);
> > +	if (ret != 0)
> > +		return ret;

> Doesn't the second put_user_gcs() override the previous ret?

No, we only set ret on error - if the first one faults it'll set ret
then the second one will either leave it unchanged or write the same
error code depending on if it fails.  This idiom is used quite a lot in
the signal code.

--vOVm5CyTt8nbbuUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbGK+AACgkQJNaLcl1U
h9DN2ggAhLNXxP2D63m8tGi5TB8JVrMOEHceQoOhWbYArtPnk8DUJUwAVQKy4370
gWRlpUv3C9Prym8J79cdGllLtJAxGtFL846FtZ4GEzCwI0h42OKyIHIK0ayYDGwT
7mhlLJAE9x/zLEwqeSMWfUiGAUZs+B5Bcc/qe3gEkuBX9zJ1D4kkt0rUSUB8PR9+
mb7bq8tnqBOZ2/Ys/rHd7YOVTKnL9fNb3BG6ORxTFjKI/wwea16GhNrhUMcSaGCx
OjyC6/p6czJQmOMjRXUIRp2W8KD6YyRu8dOKy8imoKaZl7tcxZRwOC2XNWdH+9vC
sBN7fffBdrQUaKButl4to5BBOZzO0w==
=oJjq
-----END PGP SIGNATURE-----

--vOVm5CyTt8nbbuUu--

