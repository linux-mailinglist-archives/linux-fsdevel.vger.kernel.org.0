Return-Path: <linux-fsdevel+bounces-13484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D567887058D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C021C2256F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6D47F7A;
	Mon,  4 Mar 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOjLdqG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0B4087C;
	Mon,  4 Mar 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566269; cv=none; b=M5Eme6dfeSZJLvcpauhJLqrGT9njTozRm8/4gH/lMy8QTPEXZWb82e9maa2TxvqRZj4DP0LJzMWNCBwD6H5JLoURybu25ouSJHXQbXyMCwV5kP9xx8N52NSwG4Mk8ZuI1FsuA0lgsS5EBAJb/C+PY0nlPKJaomhce2JPnif3TjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566269; c=relaxed/simple;
	bh=VOOhxEaaXiEGSszUCm95YGoWnfW/fhFSY5fjW7bYi+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fss7k8GAFAFuCfSK1xstJEQ0KAk67H/cxz91dIyM9ZIRb9juBwargZ+DCeqsBVhESFmd5fYqiSYzzbIeSTXmgHRJVgMYZeEJtLW384GUjhXWn82LfDeKQy0JPI83CD0OISOFpBJgb4YaYPkaPEETD7QE4cMkEOtCQXPPaO7RVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOjLdqG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B660DC433F1;
	Mon,  4 Mar 2024 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709566268;
	bh=VOOhxEaaXiEGSszUCm95YGoWnfW/fhFSY5fjW7bYi+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOjLdqG3Rp7fTa3zNdfRowBP6NHDroBPtrzWrE5kJFfZg4fcUSYf4QOOVWjEsIO2t
	 8z/FBm6Vn1EHvCvglimG8CLg1SK8ry1eYIuBxEKMlv8TiPWU2Fd/Zs/F/7agqWupyz
	 pf5COdWoV2UOufqQcZvRtmduo1DDeF+g+oSiTrDeLGOTAApEHxwhMlVeDl8/zLtFs6
	 ePdPedSaGghv89x7+5xf0ZXzsaEvByeomnmBmsvrL1Nt4SdlbhGmC6rH3rt1dnGywq
	 O9StsISEHrjz0BBeNgwTCXYe3C7scTsQnbNMzcXRV2Pfk83BocRL+VmKjpEfqW2Z2b
	 /mo1lVv3euGXA==
Date: Mon, 4 Mar 2024 16:31:05 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Jan Engelhardt <jengelh@inai.de>, linux-man@vger.kernel.org
Subject: Re: Undefined Behavior in rw_verify_area() (was: sendfile(2)
 erroneously yields EINVAL on too large counts)
Message-ID: <ZeXpOVxPFIcVGapD@debian>
References: <38nr2286-1o9q-0004-2323-799587773o15@vanv.qr>
 <ZeXSNSxs68FrkLXu@debian>
 <ZeXkLYExJHj98oaS@debian>
 <ZeXnMO0DcZH63B_d@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rUdXQCFvGALZDADc"
Content-Disposition: inline
In-Reply-To: <ZeXnMO0DcZH63B_d@casper.infradead.org>


--rUdXQCFvGALZDADc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Mar 2024 16:31:05 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Jan Engelhardt <jengelh@inai.de>, linux-man@vger.kernel.org
Subject: Re: Undefined Behavior in rw_verify_area() (was: sendfile(2)
 erroneously yields EINVAL on too large counts)

Hi Matthew!

On Mon, Mar 04, 2024 at 03:22:24PM +0000, Matthew Wilcox wrote:
> On Mon, Mar 04, 2024 at 04:09:26PM +0100, Alejandro Colomar wrote:
> > Depending on the width of those types, the sum may be performed as
> > 'loff_t' if `sizeof(loff_t) > sizeof(size_t)`, or as 'size_t' if
> > `sizeof(loff_t) <=3D sizeof(size_t)`.  Since 'loff_t' is a 64-bit type,
> > but 'size_t' can be either 32-bit or 64-bit, the former is possible.
> >=20
> > In those platforms in which loff_t is wider, the addends are promoted to
> > 'loff_t' before the sum.  And a sum of positive signed values can never
> > be negative.  If the sum overflows (and the program above triggers
> > such an overflow), the behavior is undefined.
>=20
> Linux is compiled with -fwrapv so it is defined.

Hmmm; thanks!  Still, I'm guessing that's used as a caution to avoid
opening Hell's doors, rather than a declaration that the kernel doesn't
care about signed-integer overflow bugs.  Otherwise, all the macros in
<linux/kernel/overflow.h> wouldn't make much sense, right?

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--rUdXQCFvGALZDADc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXl6TkACgkQnowa+77/
2zIYqw/+Ntqsehf1/gSP9J0aRmo3StAhiQ/qGdMulfdXXyXe84QxZNgTEfIZjllX
Nzh85Nyb696yq4ccIFsV42M5rFSASCkhYlsjlXXgeqe1/qtrZzqxpSzr4ox6hSNH
A0LrDLyc7DE0EgqDbgKgQ05u4Iuy/1L1eHjvkICIzBoMcLgPPCdLNMDAgGSogiu9
YwfU1OBndtSxkAqtmq27HLhhFUozqLWzd4wlCRcEAn6P2Icctov1fpiEIZRHoTez
QuNDsV5Ox0u3rD8+VSyILNfjTL33DIXuDh4gHPEk09YO7atVqLJ3cMf52Km81vD8
tODvOC9VH/LFE+TtvYkcqAA7VSE+w7pt0hcJzxD0+9/iXc/2oRf/nwItEm2J7sl8
QOhFSHtOOxT5UZ6zv7rm/ritMD5Y7/wdCz1JD6YT0K+ChO34fvTcXlVL9dcxWBrs
g8p4415JSwyn2hbYcyNKLcE6TlGhaTcJiRNXRpC4wT87yx2osvYwPjAIOFwd1WUT
74D7p51m1Vo6ldI5flF9gclkRrnQp7V2SJcKcoqsCnSFARHDBMVOgmuoZzHTmD97
CzEx5XhnAYuY+3UMl+Q1IWbKFzOBHFN3zCHZ/+rXmSqHMiB894SXp4eT886XJnrs
9KEJgkyTPo8W8aZQdXjaRUO2KnOlFIvhhyeuntI6yeE1Q6NsYRM=
=3s/h
-----END PGP SIGNATURE-----

--rUdXQCFvGALZDADc--

