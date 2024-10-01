Return-Path: <linux-fsdevel+bounces-30565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5B98C5C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 21:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7702846EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 18:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D21CCEDC;
	Tue,  1 Oct 2024 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="a7vooxlQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F11A08C6;
	Tue,  1 Oct 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809188; cv=none; b=ktaiaMkR3HUOJ4ZZwjHC48Q96z7rJXeQ5L4Pwu9rt+RGEWmkkbYQ/AHNSq7X+bUsa7dsCsDYlvFhNFgYH75Fp7SXAz8yGSexHr4QoCpTQz7qZYNp+OEFsyDWE16lZm6bc73+anO/iS0QO3UjFJWuX/XG93Q+7cRje2Bbxml8DFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809188; c=relaxed/simple;
	bh=srQwgyYq+G97BRzwotELBbaZrcRKSuj98FoHLN6u0Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhN+emYqBkDUCxzeWWr5trPt3ax6fu+8GamJJeWg+QaxZwHuuWOeqs3otHX/Krq3ubZ7PDT/kAO8YvUDgbP46C5r7YNO0DMbpGCwgE2GbIH+yvJtwMDMM0TBUFbxuwHboPt4RHfFs9W62EphGj1KZ9A3wY8oKUuR6fmmhwxFtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=a7vooxlQ; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1727809152; x=1728413952; i=christian@heusel.eu;
	bh=k3WrPHh+pQgOST0TG/DsxdIM//YxJc9OTvspQubSD94=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a7vooxlQc1UC7oVfE6hwKR/VmmLq+n7gmtt9Fspe8MpyyVgKeuH1ygRbvw9Yn/Ua
	 M7wTLKd1P6I7KxQB3chjkDHqi0PV4raSWU4U/ZwCdS63qaZsl8H0AuuAT+DGr0o0g
	 3/npNuk8f2zyLq7o9ay8MB2GfWm05J0xClQ1qlkbnzCK8i0OyGlnUNUhAGQGJHyE0
	 uONACAGccXSOyo5+d8Rjyac6ULyHHoMrVafthxAS1ZqmMo+1/5sf98j8DyZAETyHC
	 R7VJVG7EjVypjKGg7fkbbiJALaKtBxKniw8pPFeAQ5IA9DTxHgBL3t5Twp/b0yaMW
	 3/kyuvT2OROOJWC/5A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.196.158.52]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQ8OG-1sZf041sQq-00KOdp; Tue, 01 Oct 2024 20:59:12 +0200
Date: Tue, 1 Oct 2024 20:59:09 +0200
From: Christian Heusel <christian@heusel.eu>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Krzysztof =?utf-8?Q?Ma=C5=82ysa?= <varqox@gmail.com>, 
	yangerkun <yangerkun@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-btrfs@vger.kernel.org
Subject: Re: [regression] getdents() does not list entries created after
 opening the directory
Message-ID: <b8089429-cff1-41f3-a3ee-a3c345f2289a@heusel.eu>
References: <8196cf54-5783-4905-af00-45a869537f7c@leemhuis.info>
 <ZvvonHPqrAqSHhgV@casper.infradead.org>
 <b77aa757-4ea2-4c0a-8ba9-3685f944aa34@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mpz5nn36wgj3iugp"
Content-Disposition: inline
In-Reply-To: <b77aa757-4ea2-4c0a-8ba9-3685f944aa34@leemhuis.info>
X-Provags-ID: V03:K1:T88c3DXPkd2HIhYeJcp9wz8+CpvNbgYL+fxcLFE+b2+653QmuyL
 CnNEpJ8bizXbbmrIrDJ2w26gWP99wahEaMr/HUWZ3AFb7miazUAyV3ytEa0IPMtBgcsIV+X
 jlITf2/AHEZmkzYv1rFTXfr+0s8C+ujq5kMOwCUszYYgacUWD+KRsPsSycrjrNdqSohPz+2
 1SpXq3+SoYJs3FD2rVU6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lmQO8pjVS9k=;X1guPrCyMDhfoREQYE2f42iYwck
 9ElwZJWhVYljCu6LGX8a9tT+PlpfJMYdJ6im2jl8CKxDZy5o14PN9K8U/HELb/e7zXxHGniZr
 wMlHe6le3lLCj3DyAfQPBdEA5LZC/uBVCednsz935MCRtTaB/S3nkI5xYnrOZffdf8yvwKMOH
 XBtMtjBISBoiqFh7NCgJGgVyLezFKIIuNhsH5s+bg7tQQiOuMI1Dw6HJWh+zlS8ghTLrs9AFL
 qfjm88CJdV3I2m4ynDFxdHA8WfhMLs5gh2XtFDCFt8s+62Q3ARN4HGcf/z15HhUOrlt4xhAMy
 1hz0l0cJAQC6CdoDqAGcIZ1hHHANavK6Itm9SOBUqjB0R3vgOJ0LHpujeoiNDwmnpDhkj4xLj
 UV3uKTAHH3McGNXEoeFwsZGdniPOTfC373YFHpHZ2PuO1oDnOISfu7UJYuv9fGmKM29x/AAz6
 VhnLDbVh1aJ7P63IV3etEoq0wau/hdnAXhKpQ+gD0vFV0wI4E0ag6PTYnnuHhrM3lpaGTYeN/
 Qe6Q0jdQ6Y9FeEF6N6yHaqC5PONFKCh7bJC819OL/agpGqkTnRSz7GO0H6Cs1mnWGQLe0CNHr
 bR5Mhq5DOnmCvkpQ0eXJKis96S2VevFlYMp6bfOqOMD7Z4GAe2BeeS30yPW+7SrKqmLwh++Lt
 gFNk+3TLRWbtIAAMAjUDfoxXCssAJBinAsFZJ8pjhRrUX2Ycv4JolUrQgwoG/q3xk/MxDBDyr
 AlR/sla/qrf5xpnI9DlnrQqCkLFoiEODQ==


--mpz5nn36wgj3iugp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/10/01 02:49PM, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 01.10.24 14:18, Matthew Wilcox wrote:
> > On Tue, Oct 01, 2024 at 01:29:09PM +0200, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> >>> 	DIR* dir =3D opendir("/tmp/dirent-problems-test-dir");
> >>>
> >>> 	fd =3D creat("/tmp/dirent-problems-test-dir/after", 0644);
> >=20
> > "If a file is removed from or added to the directory after the most
> > recent call to opendir() or rewinddir(), whether a subsequent call to
> > readdir() returns an entry for that file is unspecified."
> >=20
> > https://pubs.opengroup.org/onlinepubs/007904975/functions/readdir.html
> >=20
> > That said, if there's an easy fix here, it'd be a nice improvement to
> > QoI to do it, but the test-case as written is incorrect.
>=20
> Many thx Willy!
>=20
> Which leads to a question:
>=20
> Krzysztof, how did you find the problem? Was there a practical use case
> (some software or workload) with this behavior that broke and made your
> write that test-case? Or is that a test-program older and part of your
> CI tests or something like that?

The above message and the mentioned patch reminded me of an [old
issue][0] that is bothering us in the Arch Linux Infrastructure Team
which makes files vanish if modified during an rsync transaction (which
breaks our mirror infrastructure because it makes the package sync
databases [go missing][1]).

The issue was previously discussed with the BTRFS developers after they
implemented a [similar patch][2] (atleast judging from the title of
both) for their filesystem who also pointed to the standards compliance
after we have complained.

The workload and the issue with it (and how the new behaviour breaks
rsync for our usecase) was [nicely explained][3] by one of the BTRFS
developers.

So going back to the initial question: There could be a practical
usecase this causes a regression for, atleast if the patch has the same
implications as the BTRFS patch has. While we will have to sort out our
issue separately with the BTRFS folks I thought I'd still leave this
information in this thread.

> Ciao, Thorsten

Cheers,
Chris

[0]: https://lore.kernel.org/linux-btrfs/00ed09b9-d60c-4605-b3b6-f4e79bf92f=
ca@foutras.com/
[1]: https://gitlab.archlinux.org/archlinux/infrastructure/-/issues/585
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi=
t/?id=3D9b378f6ad48c
[3]: https://lore.kernel.org/linux-btrfs/ZP8AWKMVYOY0mAwq@debian0.Home/

--mpz5nn36wgj3iugp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmb8Rn0ACgkQwEfU8yi1
JYXavBAArTSgj5qGEGfQd/DPUlTK+Wu0dcezPOB1BX47GnKWOV6FvFdOsKL9y6A2
nqoL1Dhmhz9lz/WWMboln2HEN5ompIXJTYLe9EeCOu6lWuxwctJdszOlP9+sFdMf
FUOrQXK6OUs56hrWn8Ew/RUAmJ0NvvdZk75l+OriGWM5QTt1qiDS4cK5zIpp7EI7
TFulZ4kA9VO6PjWzR4bKIC5pTe2zDB1U+PNlVk9JIFo8HCDLSHSjfWh0d9Sxs3YN
bcXyq9vrhFhbPjFUt41ZZHn469MoPC5Wi0WI5qkLzhMQRoHFs+ObX+V63X79YESA
ckDPGZjo3LVXXsBjzlblMkMfjVuXZk2yfR3btVCrJ3U3kDBq8Wy4mQQHbXkDrs76
00PwUjfx9arQuwyzMfAhqiHStqDY1AuIS2CenkiRSTFttfNtGSWfnqpgAVjlnWZM
5VO7FaG4CuJNDAcFlsxMVTICrHSZjccFF5IapDC42auYOSmeFiEKVBcSa51TAy6I
CTfWNKnN5JJxMmjC51tpDkLCNGCatTi/UL6zMj8jjqq06vulF8ZzscgneA35OTB7
/wmzPmKgs0OrS0j0xwM86M1WyfSrzVEvXcvjCbrItXLkx8mXCXunlquGovjgR926
Vi0UpS7HaqtNGlmlj4B/Iswbk7xRjETTNRT170aUkpjoTHsIBcg=
=2qI0
-----END PGP SIGNATURE-----

--mpz5nn36wgj3iugp--

