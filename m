Return-Path: <linux-fsdevel+bounces-44785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8EDA6C95F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2419F1895C6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADD1F5831;
	Sat, 22 Mar 2025 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dIni23V7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10273199FA8;
	Sat, 22 Mar 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639658; cv=none; b=SQzNV69aG49jRiN/RLAyWr6SRXRtFg/CBTA9hVSoNixtropVbChbf+9NMGMyQ9LecrYQ/TZpBKbf8VG1LBkqfe7pmw7s96I6RtQWtJE6ePeieCIPBH3kvGPouGqsZ2PTSQrq1vdgUwFl4MkXRRRUe/Jh4zt3G5HegxnNa6+7s04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639658; c=relaxed/simple;
	bh=17YsI5GxyYvGX77THVrbQuZV0VKG0FSLDI3HhkTiVDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3qHokn+xzr4QyrP2P9wrjp1cdHzltWiYIAs4/CGnEh0aP987XMUh7fKu34I04BS3bHWkcd+p7p59nCY9joEbKFUaZRC4u0mAMYWbHOZBQ/l7Z8oGL/AFLutqbzUXpW+JJebrxPlsMJ1lZ7L1WCONF1m8dIM5mFFS0MQzLkUFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dIni23V7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1742639646;
	bh=d6lqNtYu0SPwjMSiO0f/soxLChBSY2poPZV5wunYbw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dIni23V7O2+LkbX742eI+v0x2pLIofU0+fbJ6l/h8ly4m0E8YsrNBr7i8mk3lgEUV
	 rp4hyCAngBK2sdfmnjK+cJeI4QB30Hw63RZrPEANBRF2uCZQ/WUN4gkjWn0Vp5Ll91
	 0S8DZD9cxEIM4SrG+fLvsFdVLGOBjyOnOn9nLyEJsjFzlFIyfWrLF54VOghmmycNIE
	 HR8Zny+BrG7XX4Sr06CMlji1GjxfWR4Pj0fyr2GQhCBCTjeCFWoXKR0Ttko7ZWZ55g
	 3AUCLwiL5gis4BRoNQBP1JmbTA6nbXBDdPTxr5eSLxWQf1DRg8JKAT9x9Uu9jacYAA
	 ZSAtIFdH/k92Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZKbJt1j2Rz4wvb;
	Sat, 22 Mar 2025 21:34:06 +1100 (AEDT)
Date: Sat, 22 Mar 2025 21:34:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] XArray: revert (unintentional?) behavior change
Message-ID: <20250322213404.5b28bff6@canb.auug.org.au>
In-Reply-To: <20250321213733.b75966312534184c6d46d6aa@linux-foundation.org>
References: <20250321-xarray-fix-destroy-v1-1-7154bed93e84@gmail.com>
	<20250321213733.b75966312534184c6d46d6aa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GXFKa9AwUULIcm1TGNxl/be";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/GXFKa9AwUULIcm1TGNxl/be
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, 21 Mar 2025 21:37:33 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Fri, 21 Mar 2025 22:17:08 -0400 Tamir Duberstein <tamird@gmail.com> wr=
ote:
>=20
> > Partially revert commit 6684aba0780d ("XArray: Add extra debugging check
> > to xas_lock and friends"), fixing test failures in check_xa_alloc.
> >=20
> > Fixes: 6684aba0780d ("XArray: Add extra debugging check to xas_lock and=
 friends") =20
>=20
> Thanks.
>=20
> 6684aba0780d appears to be only in linux-next.  It has no Link: and my
> efforts to google its origin story failed.  Help?

Its been sitting in Matthew's xarray tree
(git://git.infradead.org/users/willy/xarray.git#main) since Sep 24 2024
and linux-next since then.

--=20
Cheers,
Stephen Rothwell

--Sig_/GXFKa9AwUULIcm1TGNxl/be
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfekhwACgkQAVBC80lX
0GyShwf/VmRXZUSg+C2EZCh1aKUSQ1Dcqf+EkXTjwxAa8gWnfikMvTo7LQoe/dZC
c6ogd2dx6QefkGSehJwNifHAFQKfRfDCDgueqK/SaXRQEqYBcuMNAQbUAB+ffDVY
2w8h+f8nIkKmVjDD4QijMqgNK2Sb2XMmkyfMkMF/1zr4EfzE0OsYVgogMLxCNSzV
+upDpTffAsJbZ5mlzf5DXPasOz2M2wJPWhRGsnLIL/H/tT9yRQ/apVO3ytlLVOjh
+eULrCYUbNS+hfrure0g6ZTutcPbeGWIYVu1C1bbfN3BExNFXK+G6Y1BMiDUdiIT
ovhB/GufBeXMSqIh5YagQtbzR4UfYA==
=ODU6
-----END PGP SIGNATURE-----

--Sig_/GXFKa9AwUULIcm1TGNxl/be--

