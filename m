Return-Path: <linux-fsdevel+bounces-32188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054469A20D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 13:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2D51F27398
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656D1DC1A2;
	Thu, 17 Oct 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK6wZKGy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0201DA612;
	Thu, 17 Oct 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164129; cv=none; b=s32xFJU6PCkR6wh6k+IHt0DpAwJsljTDlU7mjC5mIe1BrcDLe5dTYaP+QurMsQrezm9SfWskkk1ViArvwIuGJEJBlqiakRbvqnUvSAuX92BhnvQzrZ3QcsyEESBbuSL7KffFhsYdivYjXnKKCjcGSHP/4capN50gZkgLZygElCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164129; c=relaxed/simple;
	bh=Z4LR3CRnxCq5BQ9I7QAYlCCccUdbY5cPtdO7aItqP6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pixJYq43teGCfOhNvBEKqMaLcMEbSUsED+LMPlvryyGq9WuH7NPIhTW1Xk+qy3bVLe4qSTrBcMza6J6G4NSjEDHo2C7W69VC7K7hWvKFFOa4vUjKvkm+E2bIbkbvm5VtVhm6a2TmQIUWWuEZjf6KrUlzWRr6hxDm0tgZL16XmIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK6wZKGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2E8C4CEC5;
	Thu, 17 Oct 2024 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729164128;
	bh=Z4LR3CRnxCq5BQ9I7QAYlCCccUdbY5cPtdO7aItqP6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rK6wZKGylGdhEKFKYYKm5FhubKKCvW2LX8PfnXDspi4lWRNoyBmX/Hu4ee0TnO5tQ
	 Vjy4lPwdN2N1sVMtpGj8qGxaJylgPWwVDWcxxk3BEvKai++DnDecXqOY3HItFQTp7U
	 pNJiI7FSAvVviyzvJOYyNROVPPx90/cD5/Hiz/A1HIY1I2MRYZasWmAdKuS77OSUn8
	 UWPW1l3WlLtc3/knuylT5vc6lJhJnKtHC6zkSOLIe2m2UcbuYCXFc4IeWdNptANeu4
	 aHfgsSXAXrcC5XIgUV8Zx+I4M3lZctG/VfemAeUjlJdgxuPksU8T7O4NT6y5Y91oN4
	 EewoF5bfUtWCA==
Date: Thu, 17 Oct 2024 12:22:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH RFC/RFT v2 1/2] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <2b24849e-3595-414a-b11e-eb03cd3c3b28@sirena.org.uk>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
 <20241016-shstk_converge-v2-1-c41536eb5c3b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="muUhb7tZMOd3DMds"
Content-Disposition: inline
In-Reply-To: <20241016-shstk_converge-v2-1-c41536eb5c3b@rivosinc.com>
X-Cookie: One picture is worth 128K words.


--muUhb7tZMOd3DMds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 02:57:33PM -0700, Deepak Gupta wrote:
> VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
> VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
> stack). In case architecture doesn't implement shadow stack, it's VM_NONE
> Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
> or not.

Reviewed-by: Mark Brown <broonie@kernel.org>

though

> @@ -387,7 +392,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
>  	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) =3D=3D VM_WRITE;
>  }
> =20
> -
>  static inline void vma_iter_config(struct vma_iterator *vmi,
>  		unsigned long index, unsigned long last)
>  {
>=20

Unrelated (but reasonable) whitespace change.

--muUhb7tZMOd3DMds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcQ81kACgkQJNaLcl1U
h9CQUQf+JD018dyJIN7oFahuVrCr4JxvO/kwj3Bwd5KXTc+C4NvzP4V9NwC9RYKh
G+wqnGlQWOikoDJCPjXJ4zR6eipO4Svgrxa+rtmM5x6Tp11gTF11GBUdSdXB79+1
8eyIIDM7gb70YdEbNFRRIXc83XmpOJpekDhtcmEB7mt3HOSUY4ss/UPyfQ6MpBUU
9m4qvm31pDeNnVxR186xVUWYP9h+7P54JY4ijrA4NXMOSsJP3/mkyCAwRrSIzvUw
rZOiuOE22hHihqQ72tnCdTTERhQBJHdVGkQNLb+lPP4KrVVG+OK31wpdgZXVLgPl
HaI+lM+gTYDPBta6eEXKbTDgs+irEg==
=LfV7
-----END PGP SIGNATURE-----

--muUhb7tZMOd3DMds--

