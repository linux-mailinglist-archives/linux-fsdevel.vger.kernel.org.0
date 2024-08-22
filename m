Return-Path: <linux-fsdevel+bounces-26822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A1295BD4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C3FB22B64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304B01CEAD2;
	Thu, 22 Aug 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikqtAQwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DA1D12E4;
	Thu, 22 Aug 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347859; cv=none; b=EN4vgeKd9UBvupeYtuj48maAkCelVdXmx5QJJNoqD6Rrad3KUuQo0OmPW6W5eUQ9FR2SfCYzpha6qxYxvuKofBcHjjXaAl1iPfcVjr3A/Al52rSgmICLjR8pBOXrCQe67hrrXBiLc8PMLcWQQPDbvDNKTA8+X+7L1kP+BfofmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347859; c=relaxed/simple;
	bh=NEmbbg8L2Bfrsg3LdNNpLmYp7+z/wYUOhdnFgomJAhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gybwa6OqavMFZ0iZ7crZJrRWkBs9xfd0n3tvXGTmJNp2z4d0g+D++906PbqBV+9uy5V9jxUeWAJ9fphWB0iZRQOWo1abM180D9B5H3qybzkcowG8e4F1x5QSntP6ZJ0B1P2nkhYsciW5+S+EcKPOKT263VwJP4JMt9wEWi7xvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikqtAQwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85044C32782;
	Thu, 22 Aug 2024 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724347859;
	bh=NEmbbg8L2Bfrsg3LdNNpLmYp7+z/wYUOhdnFgomJAhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikqtAQwtRrEpLzRohAGA+qNmOG+TVb1qThYeB20Y/Rk8LI7FU0VJET/gHeWL16BXq
	 QZJfX39NMfafJ1FzVkN4ltE2CZW3ItKeVYt8IycDgCeLLfuh0r2uRLDWZ04/PypHs6
	 s+MGNZPewB6jtWVhV7hrSdK3dA9ZJDHvvHhPAtsfxbo5lcriqWLIPch63YvNEb7bvj
	 mKT4+II0xSVQPbirmPqGpXOCJtrJ5BOwbz+S2JpDOkZcFSQI6txfB5pByPQr/Jo0Mu
	 8SvR/xM9sWHMARckle6xSHr228r6G6hj9zO2NXqWhsK7TG51FQwJDp+RQ7WZOdHsEf
	 rIBkFTrNQkZOg==
Date: Thu, 22 Aug 2024 18:30:55 +0100
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
Subject: Re: [PATCH v11 19/39] arm64/mm: Handle GCS data aborts
Message-ID: <Zsd1zxJ1n5-_lpbx@finisterre.sirena.org.uk>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-19-41b81947ecb5@kernel.org>
 <ZsdjbsDrMWgBU9Hj@arm.com>
 <Zsdq4ymaW0vQffH_@finisterre.sirena.org.uk>
 <ZsdzKrTbrolW0lHn@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QBL8uS70EYGjHk3p"
Content-Disposition: inline
In-Reply-To: <ZsdzKrTbrolW0lHn@arm.com>
X-Cookie: Your love life will be... interesting.


--QBL8uS70EYGjHk3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 06:19:38PM +0100, Catalin Marinas wrote:
> On Thu, Aug 22, 2024 at 05:44:19PM +0100, Mark Brown wrote:
> > On Thu, Aug 22, 2024 at 05:12:30PM +0100, Catalin Marinas wrote:
> > > On Thu, Aug 22, 2024 at 02:15:22AM +0100, Mark Brown wrote:
> >=20
> > > > +static bool is_invalid_gcs_access(struct vm_area_struct *vma, u64 =
esr)
> >=20
> > > > +	} else if (unlikely(vma->vm_flags & VM_SHADOW_STACK)) {
> > > > +		/* Only GCS operations can write to a GCS page */
> > > > +		return is_write_abort(esr);
> > > > +	}

> > Yes, that should check for a data abort.  I think I'd formed the
> > impression that is_write_abort() included that check somehow.  As you
> > say it's to avoid spinning trying to resolve a permission fault for a
> > write (non-GCS reads to a GCS page are valid), I do think we need the=
=20
> > is_write_abort() since non-GCS reads are valid so something like:
> >=20
> > 	if (!esr_is_data_abort(esr))
> > 		return false;
> >=20
> > 	return is_write_abort(esr);
>=20
> We do need the write abort check but not unconditionally, only if to a
> GCS page (you can have other genuine write aborts).

tThat was to replace the checks in the above case, not the function as a
whole.

--QBL8uS70EYGjHk3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbHdcwACgkQJNaLcl1U
h9DRZgf/cfCggcnTIkzrBOCGpdBnnvrHenLxqYdUHuYxfAA/f/+OY6Ryiz7GiVVN
dsEg7gYHWwsk0cTwEgGm++++b84foIZ1WeBZ46XlkFKSK0McT1h01SxvUqi6bu3R
Mj62HWq2M43bg8tVzjIsNFMIZKxKg/8RJVKFsg0KTx/Y4JLXoJkLtplgh4eCuxh0
Xg0yYgmx4aE7JOYegrvzRVUuj0F6rT8Io3eU7LbdJ4GpP28wCf6jVymCjyhQOHav
sWHIP3j85jUutzI9HQAsfUt9BnT6GMnKfu16R9nOAdGgfc/XMzzW7lgzRJhLeroa
kebp1dN/8F8ek5AKqLqstfOmgDdTzg==
=+1Rr
-----END PGP SIGNATURE-----

--QBL8uS70EYGjHk3p--

