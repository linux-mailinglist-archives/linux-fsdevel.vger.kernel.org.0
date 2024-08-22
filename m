Return-Path: <linux-fsdevel+bounces-26815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440DA95BC31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A2828417A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4E1CDFAF;
	Thu, 22 Aug 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF/ody/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261F1CDA26;
	Thu, 22 Aug 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345064; cv=none; b=k0RBbmAHZs25X46ac6XS8bJGzpdHsaOpF9AT5pk1RQvSYxWALCPPZP/jqXGPbo6GHYPvpHHMC04qRXCx51+EFib8pnNYct0rNcybbDGHGb5nenwAfjpPd4GteC4eNc2epAPq/TveWx2Sl8o5qtk77xh6wW+BxmxfQqGI9TRwvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345064; c=relaxed/simple;
	bh=5nVMn4LkuuoZiKq1lrBVs6QotPTnawufcHvhIzc/8+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq//lLXZVsbPaA3rhQd8AU4OURLS2MTjt3Z6SRTdlKNRQ9XtlvHLAAKM5hncpkKzOdJL6ewIOSQrK77xnmZvba0gCnyjWz1s1c00vkymeBn8OZ8TL8ND9DFLr9XSSYeEzQ9vHDCGBZO29yZnIBkJKQbTDEJJVdWTBvtJnK6Ss3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF/ody/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80409C32782;
	Thu, 22 Aug 2024 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345064;
	bh=5nVMn4LkuuoZiKq1lrBVs6QotPTnawufcHvhIzc/8+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pF/ody/9/o+/aOJwArsMCPFpQwT0EV8UZiSyMkWuRkDtaA9zA98X+68GNesul+qdI
	 j359/Vz+Gg/HlVhmwMmcZDq+MII6ZkB1sdpS+muocrnk+e0OetqMq6OMevkFZ1wlxw
	 rJjRMNbBUPb0hCeLZmKDpONpxkKiB4/L1XTe4iir3IjqZ+wS5gH/zukRsz1HNYuV/A
	 L0BeUNIgcvmdLlyd6iSWGzrpfaaUh5HgC27f/N/wW7ML7feQU/1eiGe0y6HbmsDWuP
	 3Y10FUYq+KJSsnWRAfZrVTfTipSHpXYxMFaMZ/BuKVufWhHKBlEVXQWq6Vosu32jb/
	 3WGuBDHl/XkYg==
Date: Thu, 22 Aug 2024 17:44:19 +0100
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
Message-ID: <Zsdq4ymaW0vQffH_@finisterre.sirena.org.uk>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-19-41b81947ecb5@kernel.org>
 <ZsdjbsDrMWgBU9Hj@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="coW1UanIXdwHEo32"
Content-Disposition: inline
In-Reply-To: <ZsdjbsDrMWgBU9Hj@arm.com>
X-Cookie: Your love life will be... interesting.


--coW1UanIXdwHEo32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 05:12:30PM +0100, Catalin Marinas wrote:
> On Thu, Aug 22, 2024 at 02:15:22AM +0100, Mark Brown wrote:

> > +static bool is_invalid_gcs_access(struct vm_area_struct *vma, u64 esr)

> > +	} else if (unlikely(vma->vm_flags & VM_SHADOW_STACK)) {
> > +		/* Only GCS operations can write to a GCS page */
> > +		return is_write_abort(esr);
> > +	}

> I don't think that's right. The ESR on this path may not even indicate a
> data abort and ESR.WnR bit check wouldn't make sense.

> I presume we want to avoid an infinite loop on a (writeable) GCS page
> when the user does a normal STR but the CPU raises a permission fault. I
> think this function needs to just return false if !esr_is_data_abort().

Yes, that should check for a data abort.  I think I'd formed the
impression that is_write_abort() included that check somehow.  As you
say it's to avoid spinning trying to resolve a permission fault for a
write (non-GCS reads to a GCS page are valid), I do think we need the=20
is_write_abort() since non-GCS reads are valid so something like:

	if (!esr_is_data_abort(esr))
		return false;

	return is_write_abort(esr);



--coW1UanIXdwHEo32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbHauIACgkQJNaLcl1U
h9A+Rwf/dhRu5UsqpoCA6/xq9A0Cnab5ynXnvR1EzbaEJwCP9rNRs+GxUHMjS602
nhOn9hOMoiPZGQf6EXx1EQEKVTrRMdcKY6xmuJMvanSHbsVrmiYd/O9gy1dfNkSM
TDmxmZ7Xc0G+qStZRZgpooJVDlbVRaCux4cNvKFjYcDX3wVF2Liq1NrHD3xrfelV
vIRbUgCxo+LVDAkpsO/OOc1EK99EzOcV2xAnCddVDud02JsIW+KsG4/9MvW1YIJP
NfpjBpbB/8mwaQfrssODC3R5By97ak392CJHPuTEhr6ymNONeJyVtB9c/2UiROsd
A+w312rp0+u9/cY9Ul958kpl56JVdw==
=+JCX
-----END PGP SIGNATURE-----

--coW1UanIXdwHEo32--

