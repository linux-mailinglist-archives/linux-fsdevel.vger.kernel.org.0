Return-Path: <linux-fsdevel+bounces-21471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53201904638
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EC5282E68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 21:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222F153836;
	Tue, 11 Jun 2024 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="tUCJtIwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3FE1527A2;
	Tue, 11 Jun 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140942; cv=none; b=RLLPW1l9WzkWG6xoSR5i7l3Yksb+26jLZNUGdqZKpbry48ZeYyCqXPwGYek55Czs0C8Qe6vjWolYMxgfX5WDqoiMzAEsWvBPOT0BtR+8V8+ye+dN/0sumaxIQJMFshDuCqEJsPDc3b5vSlbV2tk0LKw1oDc1VRa1Wy4uzkBQ3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140942; c=relaxed/simple;
	bh=yjMBvWB5+B7dFt47iCo5AaFzQSISODEVKaHGFZRRL14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuyFmFJ0dhFKtAHu8AqANUGveWUmKEug+EXC6VI7N+1vUKZZ5PouJ2Z5zVnNbZlG5/Eznq/7rj7aWgbPLRE9i6qk+0pvodrKFYXV9q/GZFC7L+4Zp3dOVSOtqkinv3aLfmcpjFym47FL5qLnAjtpATLPSgam0Et406iPoXbu0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=tUCJtIwU; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1718140907; x=1718745707; i=christian@heusel.eu;
	bh=yjMBvWB5+B7dFt47iCo5AaFzQSISODEVKaHGFZRRL14=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tUCJtIwUF7ZiqD2pwXcvForQaAd3wVXt5vBH9nYUVr/xme5Zd7BhMZK9RvySI2yR
	 2EGBCHAruy0SobHSbdlWs4D7o0AGSXkQ28GroRXihc314MPYqTd1wLyhoaZoUu9mb
	 pLXFhlWCmiWUTN6SAWii3fb8LgBoh/DuIZCRtzhJZW7JP5Ses6KZC1J5x6lW0LTnH
	 Yiajw9Lv91pqdO7GaWpgiCSuOyD03mPTbKvTAg/hx26LsXC34qwwsQq+gkedWkUhq
	 GaLuJAiEMIPvme+UnfrH0t3Xjdq8TcCX39qX2Kd+3fUU990L+AkCutf6jHn2rty94
	 SUgKjYmq9Rn7TakP1g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MV5nC-1rsQF23SbO-00KKSj; Tue, 11
 Jun 2024 23:21:47 +0200
Date: Tue, 11 Jun 2024 23:21:35 +0200
From: Christian Heusel <christian@heusel.eu>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Damien Le Moal <dlemoal@kernel.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	regressions@lists.linux.dev
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
Message-ID: <678af54a-2f5d-451d-8a4d-9af4d88bfcbb@heusel.eu>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-12-bvanassche@acm.org>
 <Zmi6QDymvLY5wMgD@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4sl6cuacyuhoilmf"
Content-Disposition: inline
In-Reply-To: <Zmi6QDymvLY5wMgD@surfacebook.localdomain>
X-Provags-ID: V03:K1:foLHCmu243axhoMmi+81hYCdUWji/QUP2esFrCkTAjpwsLB54oR
 zGmiPvbsQF7NvPcIsjPCL3ZHOyI5OiMJ3lFKrW7ViasszasL824LGW4uFIMnbtk8rVg2A5I
 sZmfOH40DRJg+K4aue7Bq9NfN+Ufc7q/Vuy5XLPJ5ywNyLbM9Cq5DSw6Kv9L/s8Cdl8nFxv
 XYL/rNAsC4PGBYZygZCLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TufAOKclaEA=;UF5vsxXuoz8AKA5HiT/d/zDZq6F
 Tv/BiLgj9Cc++RvKVrXpPeHdng+V8sRUU76zV9DtySdKo1LHFrB3EqCSelgcXrRFn6JeHQGAz
 ZjMZnkE8Tm/utZ9BORO2vuPcASMo2DAqGJTQFnAVR7KwouZWmhCZTjYmwwR1t1h2bbXIRSBxX
 zskfQbXXuZfK0sMlJfTSy8wIyzjpID9cg+IWTJTTK1R/K1cTq45Y+MO1oVnqlogtC8jdBmWsQ
 cQe36eDWYja3ETnhzl+p8kQIf0/A9YlPEb4J92CyZl2ZSOrEEtpL+bdQwHpgbiE2323r2tiyo
 LfFBuraPgM6FhXqDyM3hZllvcv5n8OoDu6e5k5rZByq0jl2VBbuX1KCZh5obY7JpyKdtUsFLy
 Z0Y/XhhUbboszUH0InXQHVEOFKvEl9qElkUBa6VFHwaSAawhLcVe00nGYg2N8hYSLI9jFlPcg
 Iisvi8snmYEhuPnXaXlIFVzWlH/LtOF3TzE209o1hQEk/p31pHlt+FyXjhvhzJqi77IZwA/Ko
 kSPLkFOKDdF6C/7aUNCIMLFVcvOLG1wr88ZUsEZOEdLq37+r/a3z/MDhu9Sa6C4wzCNgWGtjx
 jBDO8I6xrq5q8hhXviZ27myjLy3ZtRZFoa+T4c4n9BmRsUllXS9CzG27z/valoIFiIGXsBFw6
 3x+VhYPHcAL2nYfMGMYMSGlqMmFdLYrkn6MpOdKPozhkt+liWMXTpXLSS+l04EmRjjx2eruA+
 YU8IJIxou7syATcev1oodgXfLDxMbPwXf5G36lA5FHp7+AG6SpN0yinFY/oO7vby7E/t1UGNs
 qhUcd1Bn8gLqWQF91pb3X+qA==


--4sl6cuacyuhoilmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/06/11 11:57PM, Andy Shevchenko wrote:
> Tue, Jan 30, 2024 at 01:48:37PM -0800, Bart Van Assche kirjoitti:
> > Recently T10 standardized SBC constrained streams. This mechanism allows
> > to pass data lifetime information to SCSI devices in the group number
> > field. Add support for translating write hint information into a
> > permanent stream number in the sd driver. Use WRITE(10) instead of
> > WRITE(6) if data lifetime information is present because the WRITE(6)
> > command does not have a GROUP NUMBER field.
>=20
> This patch broke very badly my connected Garmin FR35 sport watch. The boo=
t time
> increased by 1 minute along with broken access to USB mass storage.
>=20
> On the reboot it takes ages as well.
>=20
> Revert of this and one little dependency (unrelated by functional means) =
helps.

We have tested that the revert fixes the issue on top of v6.10-rc3.

Also adding the regressions list in CC and making regzbot aware of this
issue.

> Details are here: https://gitlab.archlinux.org/archlinux/packaging/packag=
es/linux/-/issues/60
>=20
> P.S. Big thanks to Arch Linux team to help with bisection!

If this is fixed adding in a "Reported-by" or "Bisected-by" (depending
on what this subsystem uses) for me would be appreciated :)

Cheers,
Christian

---

#regzbot title: scsi/sd: Timeout/broken USB storage with Garmin FR35
#regzbot introduced: 4f53138fffc2 ^
#regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/li=
nux/-/issues/60

--4sl6cuacyuhoilmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZov98ACgkQwEfU8yi1
JYWeyg/+JkWZBJNBC6sa1CMPAwFdLEuAJWQ1J2bAWgWMLrAL0ZlfnHSS0kUIbtml
CccJeyyl4O5ets5b/dHRE9QAUGKVwQbp0LsVN0x5MQLtsrurNiOsT/gJFuNm+PPr
mLAXPdclmL85+UpKNy4awNO+e35pTerreUcFzsJ+8Z9pJL7DdW0F+oYrOjo7uT09
69gg2ZJw7miEVq4NtSsP/AabMp/vdbbNkXQS5wPHLsLzzIZ9vqbJM51hsk43kXXR
tkBLkr1rLF5oKqBWjKVDtX4B1OsFX/Xmr+L09V7bmaclmKo/vh5baOznwH5aC0w3
hv+U6jpVDlhroQTnfM2XHCbtX0mog9nl/pOh2WuxAg1RRaK8xLLJNA94oFnzCJU6
sUXNDhEVNIny0/h0w8HRwhswLSg62p/1OprcC1hOf8t18/cv/apVGegiKVsfEOGH
ZaeHxqWEu2sPuYIsDq3fojETdONPvaNpO4rYn9CZgUU9ydcuHDt1j+9x7kfFXa+b
CLbP7fBmsdWoBgONIjni0a7RD1EqtWeOKf+frDwM9KZUV10hDVFqzX/uub5OVGif
2sL8Xrg0NnRnFnR7Ig/u1X6Seun7k/BDKul/pgfdK/zk6JzsANUbyAGmSySD3JWn
HBP2ylPjwixrlVKf6twDkC1QZ7UrV0urOKzXPTkLHsJsgHq1ywY=
=avSc
-----END PGP SIGNATURE-----

--4sl6cuacyuhoilmf--

