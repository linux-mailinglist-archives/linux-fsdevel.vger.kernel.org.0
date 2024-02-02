Return-Path: <linux-fsdevel+bounces-10061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A78847691
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BF71F263BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E814AD1E;
	Fri,  2 Feb 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWj0HPXm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C0148FFF;
	Fri,  2 Feb 2024 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896112; cv=none; b=JuAKHHYy2bIbLdOJHSUgFmhUyNH5uXlU6elMUn8vdY1AAHN0eg1TljaO8MJ9p4dveqJTSP3qvU2/t9/tpIowjq/aTzxXjlf/KZK8nAwSqgRVVHBBFVDhckcY+KA+W6DrwiJMBx6h3e6IzYxWqCejdiaVE0WSLcd3og7P7Er2ozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896112; c=relaxed/simple;
	bh=QpwSwu16ZmhG3hCvCC9uXld1IgQWhFd5Z10yeUzElMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOpRxsXIZCgcdT30HW3NQSdrksGxRv2tIt1W1yPpU5rxNlddqGjymYfR+VmPp0ROSveFlEWpZ+w/Gr1mpS7TTNMmN+iZoG/9AYnjN+tCn7z/stfFWqIpo01g26cTDP9tRqWjTHIxtaUrH3dqy14/5fjVcyOg2MaJAtdO8mNYRV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWj0HPXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EBFC433F1;
	Fri,  2 Feb 2024 17:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706896112;
	bh=QpwSwu16ZmhG3hCvCC9uXld1IgQWhFd5Z10yeUzElMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWj0HPXmrt/RfP3e/bBCyi/CwoT2sLMwh1t9Mwp7mYWQLG6QbL6QR2pZkPpN/OTPj
	 GM+KJvEkmbKM4Yg5Ne/xLIyIAXO+CUdJUQum19+cd8DIdgLMOWnjawLCx7xxZXMO/X
	 lBlYDXXYQNyz/1ZhyeJX7Btkh/XRLnEX2xQLNLTCtu6JuvVp8uZN97SHbCkltZ3qoi
	 QRZW1SyH/2LcN3wqS6Kjh7TEfnz5pDGew+k5F5AZXIq2dZ/2wh1E0wY5KdMGufjbg/
	 c0G7+IzzLWZ58BIBZqadSATnFZpe6FiV0ampe6uSl7bEBei1Xdr15xf29fjR9m+8RP
	 jqgCYp1pX2Erw==
Date: Fri, 2 Feb 2024 17:48:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Doug Anderson <dianders@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <79f9ede9-4af0-48e2-9145-67796031420d@sirena.org.uk>
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV>
 <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV>
 <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N65f3aqAGEWc/mks"
Content-Disposition: inline
In-Reply-To: <20240202034925.GW2087318@ZenIV>
X-Cookie: I'm shaving!!  I'M SHAVING!!


--N65f3aqAGEWc/mks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 03:49:25AM +0000, Al Viro wrote:
> On Thu, Feb 01, 2024 at 07:15:48PM -0800, Doug Anderson wrote:

> > [   45.875574] DOUG: Allocating 279584 bytes, n=3D17474, size=3D16,
> > core_note_type=3D1029

> 0x405, NT_ARM_SVE
>         [REGSET_SVE] =3D { /* Scalable Vector Extension */
>                 .core_note_type =3D NT_ARM_SVE,
>                 .n =3D DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_S=
VE),
>                                   SVE_VQ_BYTES),
>                 .size =3D SVE_VQ_BYTES,

> IDGI.  Wasn't SVE up to 32 * 2Kbit, i.e. 8Kbyte max?  Any ARM folks aroun=
d?
> Sure, I understand that it's variable-sized and we want to allocate enough
> for the worst case, but can we really get about 280Kb there?  Context swi=
tches
> would be really unpleasant on such boxen...

The architecture itself is limited to 2048 bit vector lengths, and
practical implementations have thus far not exceeded 512 bits with the
overwhelming majority of systems being 128 bit.  2048 is commonly seen
in emulation though.  As well as the 32 Z registers we have 16 P
registers of VQ*2 bytes plus one more register FFR the same size as the
P registers and a header describing the VL and specific format of the
data, all in this regset.

The Linux ABI defines the maximum vector length much larger than the
architecture allows and that define does flow into the kernel code, I
believe this was based on consideration of bits 8:4 of ZCR_ELx[1] which
look like they're earmarked for potential future expansion should 2048
bits ever prove to be insufficient.  We should really do something like
what we did for SME and define down what ptrace uses to the actual
architectural maximum since no system will ever see any more than that,
that'd still result in large allocations but less impressively and
wastefully so.  I'll go and look at doing a patch for that just now.

Unfortunately SVE_VQ_MAX is in the uapi headers, we've already stopped
using it in the test programs due to the overallocation.

[1] https://developer.arm.com/documentation/ddi0601/2023-12/AArch64-Registe=
rs/ZCR-EL1--SVE-Control-Register--EL1-?lang=3Den

> > [   45.884809] DOUG: Allocating 8768 bytes, n=3D548, size=3D16, core_no=
te_type=3D1035
> > [   45.893958] DOUG: Allocating 65552 bytes, n=3D4097, size=3D16,
> > core_note_type=3D1036

> 0x40c, NT_ARM_ZA.
>                 /*
>                  * ZA is a single register but it's variably sized and
>                  * the ptrace core requires that the size of any data
>                  * be an exact multiple of the configured register
>                  * size so report as though we had SVE_VQ_BYTES
>                  * registers. These values aren't exposed to
>                  * userspace.
>                  */
>                 .n =3D DIV_ROUND_UP(ZA_PT_SIZE(SME_VQ_MAX), SVE_VQ_BYTES),
>                 .size =3D SVE_VQ_BYTES,

Yup, and SME_VQ_MAX is defined to the actual architectural maximum of
2048 largely due to issues with the size of the allocation for ptrace.
There are not yet any physical implementations of SME so I can't comment
on the actual vector lengths we'll observe in the immediate future. =20

I see there's a comment update needed there for s/SVE/SME/ too.

--N65f3aqAGEWc/mks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW9KugACgkQJNaLcl1U
h9CjxQf/UQKcjZqgFzxfc+v+5GPIfo/ob9NZKDjsECvRqxpjjCxPSJ/H5+UwwL/k
SPCFe8qPbJ634EiLguRLFPZU9Fiww9TOjGWtEZM3idw8sa1CodifoxeXqpbBJrub
kcL/9WZzb8b4vPY9/R0Xidhgdno4oe1ydjMUVtkW0hO2nhcMOh6ngQpFTbnkK9BY
4FnukNzD7HS1yc70NsEuhFtpxdYgDLF1i/mT8eprrczGsJl7wv725uPrMehkokjL
XDvCTLne3fMviZnc4ZOlyv3amgW2j7RNIs37Mg58pdg9vnii4qR2WARj9AivdQ7I
OEuGvjf/5YuC5eJ00EppTA6MDv/wfg==
=yRim
-----END PGP SIGNATURE-----

--N65f3aqAGEWc/mks--

