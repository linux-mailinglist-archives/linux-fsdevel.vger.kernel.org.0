Return-Path: <linux-fsdevel+bounces-26390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7BA958DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6961C217D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F711C37BB;
	Tue, 20 Aug 2024 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMBNHgu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADA482FF;
	Tue, 20 Aug 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176589; cv=none; b=Nivy/DI16SZAsVLWmG54de3w97mvPzrFtv08ur98jrSWtWSx/LCVrDRjRBV/qPu38pPxARoOToRhPM3HUIYIYZyaoASeNatJNTTVkJ+YSPDlQh8haplGbCmxttTv4rVyzNaJpKR0FJkXhcMg9F+YW9ifnYbuuq+P9WOV4YJldC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176589; c=relaxed/simple;
	bh=gZbF78Vf8hQyyvrqZwyllYGTMkZkFUc2boH3xNoj3xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln/rxhNd+M+sHfCmyUsz0fI2pK1TP+GzJW5QhpLIpHOfeQpOrTcF4VhO9TuV+/xDyUZl6maSsI2peLSwtsa2MhAw3K9WS31TQ19qfJfGZKYfdno/GObVwCLVjMmUd7Rt+CX/lE2qzsMxBovMy1NTZf3yCV2c/tvXdroEiuEQ5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMBNHgu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA60CC4AF63;
	Tue, 20 Aug 2024 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724176588;
	bh=gZbF78Vf8hQyyvrqZwyllYGTMkZkFUc2boH3xNoj3xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMBNHgu8QiEUNr6Dj0H9OBOYNtuyoJmzRNKbBHyDLb+AJcBwiuh2LgJrzteoMvVsx
	 5LXnhtvTMAUrTQWGO8C4/3pUWw0n2Ty4gAoWYmAT+yBC5FbQ2efuWgCCm9W086xLv1
	 Zz0YOIynNZ511iDRjmQKgI/z2W0DSwrGpMHtyIFX7gsM+jxsuh0nwza7zZ/cUCLkch
	 5kByC8ltUO3h9EBYmOklMwhN2gyHbUmRzoURFqk+UuCaO0bvG1QT+x0RnLV4jkxDZv
	 rOQIythKgjlcvs2q9paWHNJINWO8TqkFa8qlRlL1CfSG4cDj+KBmcAFn41ujrmw+M5
	 1HSxxSLa5whtA==
Date: Tue, 20 Aug 2024 18:56:19 +0100
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
Subject: Re: [PATCH v10 19/40] arm64/gcs: Context switch GCS state for EL0
Message-ID: <3b316422-7f88-4f5d-a691-eb9209ec4ba9@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-19-699e2bd2190b@kernel.org>
 <ZsMwhdmE_Ai9BbM9@arm.com>
 <0f6fd3ec-2481-4507-af0e-3cbbb7406b54@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3PN7G0mWO4eG7H9j"
Content-Disposition: inline
In-Reply-To: <0f6fd3ec-2481-4507-af0e-3cbbb7406b54@sirena.org.uk>
X-Cookie: You are false data.


--3PN7G0mWO4eG7H9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2024 at 04:44:52PM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2024 at 12:46:13PM +0100, Catalin Marinas wrote:
> > On Thu, Aug 01, 2024 at 01:06:46PM +0100, Mark Brown wrote:

> > > +	/*
> > > +	 * Ensure that GCS changes are observable by/from other PEs in
> > > +	 * case of migration.
> > > +	 */
> > > +	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
> > > +		gcsb_dsync();

> > Could we do the sysreg writing under this 'if' block? If no app is using
> > GCS (which would be the case for a while), it looks like unnecessary
> > sysreg accesses.

> Yes, that should be fine I think.

I forgot when writing the above that we always allow reads from
GCSPR_EL0 in order to avoid corner cases for unwinders in the case of
asynchronous disable.  I'd expect that to be cheap to access though.

--3PN7G0mWO4eG7H9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbE2MIACgkQJNaLcl1U
h9DGLQf+N5+bf9wgOIIzNX1vkURDnQUEK8nayHI+jFDZJUtCwgCR7dnbVvAybutt
pxS7u/jQBZvRrPuIk4JAvlPy/uRMzwfk9ooJ/US3OA2OmcbLQX+k4cNNxkx4uJiN
XP2g8aMT14h2hwKkusxr8dUCwyB55hTlFvHPsLZQ24dqsLp2FMZOXqIjEhjPth/I
qtq8/NVfk4nBuJ2M9HAMVMTiB9RxjE0dkqvWrD11wiWoD4oxozxMWze93JijR2LZ
2DkwdCLX0oezojVLBNXak0Qyw5JCKP+y1UDdtsLfN2kKyEljQp9lr5+hTUdEjv+N
JBdNzCm5oAI+cdBJ0+S4fqr7zDDDLg==
=Yb1u
-----END PGP SIGNATURE-----

--3PN7G0mWO4eG7H9j--

