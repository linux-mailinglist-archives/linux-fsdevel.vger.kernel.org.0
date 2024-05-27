Return-Path: <linux-fsdevel+bounces-20216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6F18CFDDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 12:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B655B23034
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 10:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7685013BACD;
	Mon, 27 May 2024 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Rh2ndBRu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC813AD0E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804391; cv=none; b=T/uPoi1Y9TSCkAFXlJ1h7e3dq2qh/SKLFNuKsD9d9R1N2gZLEp93jZwhYf/siwIhT/ZYd6XwDB0o7/EEerk8Lt+MBxFEtgMeEfZHGeyG/TWmENHUhJQlIOf4PAVBQ6hIXWkCt6ecShXAdQ0tQ8Qjc6IZEg0PuYNA3BABi44kAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804391; c=relaxed/simple;
	bh=Kr4l0x8PNw4zSltcIYoL7UZLHPCeyGC4FnJ3t4A/OAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYZlao4Flls8BpyiK/YqdbRP0vgpufmZ2Dc7DoYnsTb996ATWIKqkcuyKeQFaBRaS0TPe/YJaHWcyRv/qJMpKibEz/cmREiqP4B6NOBoMK/cNKGPXEKNavFgi4//mLIjfW1hkoBH8uKUdOXmene2QuEowWoIqCPxLrabeTLALhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Rh2ndBRu; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=0t+T
	7WHX4la5LMrFE6PjVGCaYFT0TyBcOR1BCAmjNmg=; b=Rh2ndBRu/UYt67O8euVq
	I7mDDOnIbKTIiLnGjO5pr+HfBMP+h0HL53Rh972C+BQ0PLkM2HMYRhO46crrR0Bv
	pOPhFS55VMJeD+jzg4YWwbT2xT5KDcqqdWncTlNlbUl0TFis8TcJ+PmgSE7HPWgd
	4vlVW4abPpJyH45xpvX4e88xpsWq7i/U/kCEAOxmMUNw73caWvD389YsO5wZwmns
	NJmel8JE+ZJVww+Yp9d2xaqsHA+MQNwldBawEhLgGlojsyKsGrxw8j0k+WDR5K5i
	9s+mbx2Ouxdroh6X7h1u3Ge1PZrktmHlUmOrULheQ/GoerhEtFykfwigFy2CKAOY
	4w==
Received: (qmail 2284887 invoked from network); 27 May 2024 12:06:19 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 May 2024 12:06:19 +0200
X-UD-Smtp-Session: l3s3148p1@XEQoq2wZvLoujntm
Date: Mon, 27 May 2024 12:06:18 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-renesas-soc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
Message-ID: <20240527100618.np2wqiw5mz7as3vk@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Christian Brauner <brauner@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>,
	linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hqjbo2nzioraqstx"
Content-Disposition: inline
In-Reply-To: <20240524-glasfaser-gerede-fdff887f8ae2@brauner>


--hqjbo2nzioraqstx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christian,

> Afaict, the "auto" option has either never existent or it was removed bef=
ore
> the new mount api conversion time ago for debugfs.

Frankly, I have no idea why I put this 'auto' in my fstab ages ago. But
it seems, I am not the only one[1].

[1] https://www.ibm.com/docs/en/linux-on-systems?topic=3Dassumptions-debugfs

> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index dc51df0b118d..713b6f76e75d 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -107,8 +107,16 @@ static int debugfs_parse_param(struct fs_context *fc=
, struct fs_parameter *param
>         int opt;
>=20
>         opt =3D fs_parse(fc, debugfs_param_specs, param, &result);
> -       if (opt < 0)
> +       if (opt < 0) {
> +               /*
> +                * We might like to report bad mount options here; but
> +                * traditionally debugfs has ignored all mount options
> +                */
> +               if (opt =3D=3D -ENOPARAM)
> +                       return 0;
> +
>                 return opt;
> +       }
>=20
>         switch (opt) {
>         case Opt_uid:
>=20
>=20
> Does that fix it for you?

Yes, it does, thank you.

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Happy hacking,

   Wolfram


--hqjbo2nzioraqstx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZUWxYACgkQFA3kzBSg
KbYn7BAAgjXXfe6438wgV+D2SvJ7lziQ32oC2AKs/kiVtJYHQ6vmj9M5fCgIfuNG
5kSvB/KAwYsMIZrEtYmAWJRJAlpUz4PQHxCEGCgD4QktsUTZW8I+7Y4uwI33D+Sf
BbkGsv2sDvTV+LfVp7VSmQRuMHUkJaSYkpDLEpI2I5NRL99KnqplLSuxJi7VtAoJ
sVw4AFj48H3Ea1L78YW7CGUUVE2j9s98NQzKHyBHl4ZALfIvJAvfpJn5LgMOhHEU
C5w0MzKnIh1iUovzqnTVJVok7LpPrVE3pk7KkScGl/0XkKn3AEdegjk4ydf1+9TI
2i5EKQdFyRv1WqsN3HYuRRyaZOhu1HobWpQcBeJ6yZht/OawnopjiQe8CvkJF23p
Dndc97Mc3inp6U03l9gq4zhjMqVzhQQnPp78HXTLUVppxDlfHeMAkxtz0PC/7vQ3
jM4nysaIwvYPItDjVFNyvGMUhdnPb0lKM1gGl5IVnVu7qhsSR5Myx0qwr8XJ6sRV
sSggapJDx0Otpt/M1Rdav3jdHUJvBXAnYTCfOe+x2T2eQLizBp+BY+u6oSbAqpbs
5G34N/rVjerSlrgEqVgK5RRsXu8xxdKdyMxNhKJltAz8oMYOvwuWTKq5NeaCauLf
KOIyxgdi5MP49mjs2CVvnuqoH60dPU0QyPLPJUtwWRhNKn2/Y7s=
=GJ16
-----END PGP SIGNATURE-----

--hqjbo2nzioraqstx--

