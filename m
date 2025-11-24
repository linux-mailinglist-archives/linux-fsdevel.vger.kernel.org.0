Return-Path: <linux-fsdevel+bounces-69652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DB7C80313
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB3B3A2255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165FB2F9DA7;
	Mon, 24 Nov 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsZ/Jn9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC7231827;
	Mon, 24 Nov 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983399; cv=none; b=Rpj1wwL4WbXiY69sGovyziBuQD4uUJxU/0zseAIdXvkX6/UuzzPO+We61+77KP9qxOdBXs0KTG6/tJ++If7DrNAq5kmswL1UcUgZecvEKjEhVioLiR776w/FvIw7ffsODRLW+G5bh/5QqPsIpGBJHMl0nrRtqnRKxdy/sUV1dJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983399; c=relaxed/simple;
	bh=ZDGxe0et8RhQ+hJ61YBgi5tr4tBcp53cd3HyYjmj27I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+bSnlj50PsoqHGu1HUvgAGJTf9aNMIbgBeZbfkuUbsPyJgoooGMiDKIwNGkKSpDpGmovzi/L5GFdaYYloAegI945jclDFrsY7nNWPjy3sHhDPqmaJfZ3eNWnJ0fkcDkwzhtOlFXjF+DJkwlxeV9lhP8ciDJSkd2g+2U9d50oSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsZ/Jn9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66511C4CEF1;
	Mon, 24 Nov 2025 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763983398;
	bh=ZDGxe0et8RhQ+hJ61YBgi5tr4tBcp53cd3HyYjmj27I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsZ/Jn9it/+sh/rrHAvaw+5JOhd2SyNSDZEk4ITy+JaMhloKD7Kuud+/5CmyoqUfh
	 MRPNDITAGuiF09RFHm9T3v7FnMNHi9qR4LZ5X8YYrwqOeFH/13S7g67pxfTzjIHOZW
	 EnFnvVWn2w5qgIC+8NQyrtGFOwARwYvZOMRqh1N9QRnWIasp2gLVPMWUFgWDwXPWht
	 kHL1IpCzYV6jfo7cj+nQxwOHfwf+kXRmhq2sxesUw6Ef3bqDi0uRjaeY93iVNFisUh
	 xyNBC7pAW5fcMOyeH15v89ugbbbWzllcRFW6gn9RlmhNaPNbtANq0761aWR997plPA
	 aA7Gy50yMKbhw==
Date: Mon, 24 Nov 2025 11:23:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrei Vagin <avagin@gmail.com>
Cc: Andrei Vagin <avagin@google.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by
 grab_requested_mnt_ns
Message-ID: <d689e03e-0f20-4a33-bd74-6cf342f92485@sirena.org.uk>
References: <20251111062815.2546189-1-avagin@google.com>
 <aSMDTEAih_QgdLBg@sirena.co.uk>
 <CANaxB-wmgGt3Mt+B3LJc4ajVUdTZEQBUaDPcJnDGStgSD0gtbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fkkat3RS3Jv9xTqX"
Content-Disposition: inline
In-Reply-To: <CANaxB-wmgGt3Mt+B3LJc4ajVUdTZEQBUaDPcJnDGStgSD0gtbQ@mail.gmail.com>
X-Cookie: Single tasking: Just Say No.


--fkkat3RS3Jv9xTqX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 07:15:16AM -0800, Andrei Vagin wrote:
> On Sun, Nov 23, 2025 at 4:51=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBA=
DF (9)

> The merged patch is slightly different from what you can see on the
> mailing list, so it's better to look at commit 78f0e33cd6c93
> ("fs/namespace: correctly handle errors returned by
> grab_requested_mnt_ns") to understand what is going on here.

> With this patch, the spare field can be used as the `mnt_ns_fd`. EINVAL
> is returned if both mnt_ns_fd and mnt_ns_id are set. A non-zero
> mnt_ns_fd (the old spare) is interpreted as a namespace file descriptor.

I can see what's happening - the question is if the test failure it
triggers is a problem in the kernel or in the test.

--fkkat3RS3Jv9xTqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkkQCEACgkQJNaLcl1U
h9B7cAf8CylPT04pVxV0zP9AVsk6Weoe2abAv+Jzs82mbH19vosHaEJzZP3Z8xww
rWvbZTvtdCAVvvn1HntEXTuHnS+i44nLkr92oLDEKq/edtejWBh5DJr7VVvVHaM7
RnpPW8c5W855jl1otPJD8z033oAEpGGtWmNHinCtMAAGcHyRY+PVmogOSurEmrdO
yOQg5tEtFyEixz0273clcXyOnLgWnfqM9KkpaTagdAJfc0qhKRFPIdN5+T3VQJyT
wpxIWe8uZYP6H7P3/Hm+YaTuIk60UJHF7qXFhyvmP1i9ZxX8FdntAIIEPp8Muo2H
NLelHSiO9jPdQdkt0DGlvSQIxYYpGA==
=WYr4
-----END PGP SIGNATURE-----

--fkkat3RS3Jv9xTqX--

