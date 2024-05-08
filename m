Return-Path: <linux-fsdevel+bounces-19087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1828BFC66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED00B223D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AEC84D12;
	Wed,  8 May 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ARf9yryb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506882C6B;
	Wed,  8 May 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168450; cv=none; b=ffMMPGQL5nfF0JWtJTVQZvlSvCfmqeqkQGYucynwYstoNNB9w/EIUBMsxLhfDi7VcbAlf/ZH+84TvFFy4ULU2st2szICL17AYcxypGIMM39RznZ8RJXtHE3nVaX/V/nwRn9JGAijaOBEfrqYTD13jvGvu8iXd/3DaPh7cjrai+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168450; c=relaxed/simple;
	bh=VYbyN92+PJMbs2AKtNDJEqVxdaaDoCupy0qED/4tmIk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=MKRxFlfnBDCObZvqU/nzNrN8leRpvE1oyrPhS7OKzO3uUx8lklwbK/CEF/+mG7OFY2Sj3y0Qd50QaHVbMjPsu2fJ179JArJ/gOPB7LAVgF8EW2TqTyzEUXiaWWPu+l+ObEOCxFr3wR+hI/EpHNOUxE2RwlEBGkVQg4sntOp4rtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ARf9yryb; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240508114046euoutp01c37f593f2a27b20f7d0fd2731027a54b~NgJ1CqoWY2038520385euoutp01U;
	Wed,  8 May 2024 11:40:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240508114046euoutp01c37f593f2a27b20f7d0fd2731027a54b~NgJ1CqoWY2038520385euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715168446;
	bh=gtbGdnHi+Sywm4GJEWUqxx3nEyjlhODfQVe10fNojck=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ARf9yrybjupqwXRiQSE0Q+Tc1VlSDD++6M71TuY+w8UkpabWpt+Bd8asmIwK5/S1b
	 p9DuAfcc4CfOwakhdbcNO5XJRUC3eEs2nIyv98AaKJUjgJCQxVPiTUPHlm8FXtoUrm
	 DraRLqHwAMzxsVBDEVDoUEvhrhA8MTbEvMJRkiJc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240508114045eucas1p2008b107d5bc84df1055d3c8f6f665522~NgJ00-QmY1758717587eucas1p26;
	Wed,  8 May 2024 11:40:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DE.2B.09875.DB46B366; Wed,  8
	May 2024 12:40:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240508114044eucas1p1bafa4ded49711d101a6ec02ee4cb497d~NgJ0CfQx03085530855eucas1p1l;
	Wed,  8 May 2024 11:40:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240508114044eusmtrp12f636116d09000caf814157fd2f0936e~NgJ0BWWL81100011000eusmtrp10;
	Wed,  8 May 2024 11:40:44 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-36-663b64bda894
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 77.0C.09010.CB46B366; Wed,  8
	May 2024 12:40:44 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240508114044eusmtip2fa7284d181f2b50d0064e9cbaa2aaf8d~NgJz0FG2t1990419904eusmtip2H;
	Wed,  8 May 2024 11:40:44 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 8 May 2024 12:40:43 +0100
Date: Wed, 8 May 2024 13:40:38 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>,
	<linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-security-module@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-xfs@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <kexec@lists.infradead.org>,
	<linux-hardening@vger.kernel.org>, <bridge@lists.linux.dev>,
	<lvs-devel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <linux-sctp@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <apparmor@lists.ubuntu.com>
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240508114038.vnx2hchpxeimuqz2@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="t6g7ogcm2uwc3jep"
Content-Disposition: inline
In-Reply-To: <4cda5d2d-dd92-44ef-9e7b-7b780ec795ab@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUxTVxjGc+5XS7fipYiegGAoaNzcyocyTsSBRJ03/rEsBjMDy2wdF3RC
	q21RtuisgeH4UgQNFgwrVMBJC1hqBTajI1CkTMCprNsQAhTcBCNSOkZAWJuLm8n++z3PeZ43
	75scPi56TPnzD8nVrFIuSxNTAsJinet591ZyTEp4lVaMTlt1JHK2d1LIos/H0MuWMzgyWwcB
	GrOO8NBP+eno+24Xhkyj/ST64VYXgSoa5gB60HqZQoOGJRL13ekm0cMb9QQabyskkMWZTaGi
	yiwcjekmSDRVMEKh9oZ7BGpdaOah+b/HMTQ/u0iirG+ncWQvGgPIqluFiuptBOppcpLbAply
	zX2CsVVBRmfKYEzXcinGNF3MY5qunGL+aNICpvdSJWD67UME82z+Lsb01UxSjNMUxJzLt/I+
	EiYKtiazaYeOscqwWKng4PSFAexIuV9mdn+sBtz3yQNefEhvhjnTLjIPCPgi+iqAo84XOCdm
	3EI3BTjhBNBZXUq9qvSU3Vt+qAXQUN5H/psa6phY7psAtLWNuWN8PkGHwmHjek+bot+BvZMD
	uIdX0lvhd385eR7G6Ys8WH5T6mFfWgrN1SXAw0J6G5wrHCE59oFdWgfB5TNh652bpGc8TgfA
	2kW+x/Zyj/z5bDvBLRoMXfrBZT4JbebfMM9qkJ4SwJahYcrThfQOWDCygcv4wqedZh7Ha2B3
	SQHB5UsAvL04xeNEHYA1p10Yl4qB2Q8dy414ONj7K+CGekP7Mx9uT29YbCnFOVsIv8kRcen1
	sG5wkigCIWWvXVb22mVl/13G2RJov3iB+p+9EdZUTuAcvw/r658TOsC7BlazGar0VFYVKWeP
	S1SydFWGPFXymSLdBNy/vnuxc6YZ1D59IWkDGB+0gVB3eaSxrg/4E3KFnBWvFHaciU4RCZNl
	X3zJKhX7lRlprKoNBPAJ8WrhuuS1rIhOlanZwyx7hFW+esX4Xv4abBcTU0HtS9keFxRtb9V4
	gzy/4vCrzXvWGQP2tigchsadvwc/YCQr3tR/kNGcULLFJbNej0saVhSr/tSYy6IS5pJc1rip
	2X0Vvn7SVd7BupCciPEfN+dvtEc2RvvqE4+GSXbcNQaIwn5xfE7R8dnHonJHd+//uPxE4IzX
	E7XPrKZ6bdBugzr2uu3ABrKr9FH8Jn1y5NfanQWZ2BNacbSmpoqQrnje8WiXhH2r/Y0c4+1A
	Z3dIw8ntVnWkUVCq3LKwlGTXai491hjAV2vGXi5VHd4UTg6cyPrkrLa/028hlIhi+i6fMxbe
	YGsT3pvtsFkSA04NHDhuTsj9MMJRev7TKw4xoTooi3gbV6pk/wAtwQFpcAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsVy+t/xe7p7UqzTDM5cMLJoPLaA1eLzkeNs
	FtsWdzNZ/N3Zzmyx5dg9Rounxx6xW5zpzrXYffork8Wmx9dYLfbsPcliMW/9T0aLy7vmsFnc
	W/Of1eLCgdOsFle2rmOxeHaol8Vi2+cWNosJC5uZLZ4ueM1q8aHnEZvFkfVnWSx2/dnBbvH7
	xzMmi9/f/7FaNM//xGxxY8JTRotjC8QsJqw7xWJxbvNnVgdZj9kNF1k8Ti2S8FiwqdRj06pO
	No9Nnyaxe2xeUu/xYvNMRo/zMxYyely7cZ/F4+3vE0weF5a9YfP4vEnOo7/7GHsAb5SeTVF+
	aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexuEXE9gKZopW
	PD7WztzAeF6wi5GTQ0LAROLcrLOMXYxcHEICSxkllk6bzwSRkJHY+OUqK4QtLPHnWhcbRNFH
	RokXG9cxQzibGCX2TdwE5HBwsAioSDxcqwbSwCagI3H+zR1mEFtEwEZi5bfP7CA2s8BUdonZ
	2xNAbGGBBIktSyczgti8Ag4SP3sfsULM7GSS2H73FFRCUOLkzCcsEM1lEpuXzmcF2cUsIC2x
	/B8HSJgTaP6lviMsEIcqSnxdfA/KrpX4/PcZ4wRG4VlIJs1CMmkWwiSIsI7Ezq132DCEtSWW
	LXzNDGHbSqxb955lASP7KkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCUt+3Yzy07GFe++qh3
	iJGJg/EQowpQ56MNqy8wSrHk5eelKonwHm03TxPiTUmsrEotyo8vKs1JLT7EaAoMxInMUqLJ
	+cBknFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwLRXjfWeXbv/
	21OMW8McPK51fmtbYLsovVerk2O1TEjn2fWSxz8eWOETlWmeVlS8tYVf+Nit5JO3/DZ8eZ1p
	wL9ll9gp72/TxZadjf8Q6X4wj72pTP3U0QuKj22vGZdy5t2+u39/zELOi0c+71pYJ3fzgkSf
	xoYtlaF1vi+uN2xeUSC5xfKMf59VVu+jrc63e8KbbRZwc0q+Ttgvs9qupyNmTjO/Wfzu6m3T
	59doib3buXTm0yfX9k4Km7HwS+HHA1ukpEyileXTGEwnnZxq+/zqsvUGHNb/kzcxGW85cDaI
	592LvTUOP1ymHSq8V8strvt6W9vL2k0iMsX7vk491H1GY0ZMh4vPk9il685ccExSYinOSDTU
	Yi4qTgQA//bFNQ4EAAA=
X-CMS-MailID: 20240508114044eucas1p1bafa4ded49711d101a6ec02ee4cb497d
X-Msg-Generator: CA
X-RootMTR: 20240423075608eucas1p265e7c90f3efd6995cb240b3d2688b803
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240423075608eucas1p265e7c90f3efd6995cb240b3d2688b803
References: <CGME20240423075608eucas1p265e7c90f3efd6995cb240b3d2688b803@eucas1p2.samsung.com>
	<20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
	<20240503090332.irkiwn73dgznjflz@joelS2.panther.com>
	<4cda5d2d-dd92-44ef-9e7b-7b780ec795ab@t-8ch.de>

--t6g7ogcm2uwc3jep
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 04:09:40PM +0200, Thomas Wei=DFschuh wrote:
> Hey Joel,
>=20
=2E..
> > # Motivation
> > As I read it, the motivation for these constification efforts are:
> > 1. It provides increased safety: Having things in .rodata section reduc=
es the
> >    attack surface. This is especially relevant for structures that have=
 function
> >    pointers (like ctl_table); having these in .rodata means that these =
pointers
> >    always point to the "intended" function and cannot be changed.
> > 2. Compiler optimizations: This was just a comment in the patchsets tha=
t I have
> >    mentioned ([3,4,5]). Do you know what optimizations specifically? Do=
es it
> >    have to do with enhancing locality for the data in .rodata? Do you h=
ave other
> >    specific optimizations in mind?
>=20
> I don't know about anything that would make it faster.
> It's more about safety and transmission of intent to API users,
> especially callback implementers.
Noted.

=2E..
> > # Show the move
> > I created [8] because there is no easy way to validate which objects ma=
de it
> > into .rodata. I ran [8] for your Dec 2nd patcheset [7] and there are le=
ss in
> > .rodata than I expected (the results are in [9]) Why is that? Is it som=
ething
> > that has not been posted to the lists yet?=20
>=20
> Constifying the APIs only *allows* the actual table to be constified
> themselves.
> Then each table definition will have to be touched and "const" added.
That is what I thought. thx for clarifying.

>=20
> See patches 17 and 18 in [7] for two examples.
>=20
> Some tables in net/ are already "const" as the static definitions are
> never registered themselves but only their copies are.
>=20
=2E..

best

--=20

Joel Granados

--t6g7ogcm2uwc3jep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY7ZLUACgkQupfNUreW
QU8gUgv+JUZin5OAF3NMj7s3DmErLOcek/iw2Q4tXtrCSrstF9AEp1KJR4h7cMPe
Nh/NrY7roszof3ADLw9QcvijqtC2/YxQqtu+PqVfRYn15Tv7/eFIYRElCTK3Xdxj
xMkZb9Afo5tMvUqCXLuy7hsa5GxNrpk5wLv3OEQnaOQPriuI0fAdMxQEFZXtRFst
ZNvVqOVbGzH5fZhv6YS21SHWAIbki2fKfu9etPSftEhi5TQ60KT0GfnNLhonPMES
3q2s+Ox+m8zkKdpI8YZK/KYO7u7qM2aEGCcKQejM4cdJs8Ii0VVQT5lwyEipveYM
5d+sAYm/dF/FfZ6ocaC7REDrCC2P3+IxskN73CNRhwkkiUBSzXu52QdTzaAUF09Z
azXiYxq/FpInFPHbBRWHRoeLkknyIlNmKUvVW+H6EHoMxgio7Pn2ERgGo4on6m8Z
DX/ExB4ksH+M9m8Mw5niW9tzCilWV1c6EvwQ+9FlNY0szADvScD0Ocv3M0FVfvcx
BVIXt1UD
=UpYq
-----END PGP SIGNATURE-----

--t6g7ogcm2uwc3jep--

