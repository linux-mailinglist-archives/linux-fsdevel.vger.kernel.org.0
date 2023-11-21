Return-Path: <linux-fsdevel+bounces-3292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381FF7F2602
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 07:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D651F250DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 06:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92F1D54F;
	Tue, 21 Nov 2023 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3wrmadD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2690;
	Mon, 20 Nov 2023 22:55:28 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c230c79c0bso1352971a12.1;
        Mon, 20 Nov 2023 22:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700549728; x=1701154528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgARtT8lNAoPn7nEoA2naRGozC+cHDkv0phYpbjI7dk=;
        b=K3wrmadDrESUjEL72AIxwPFay7ohfunJyVU9H8/GxMm8AxEWdq4zSASiayqk96Ty3R
         SM1HXGsj0i2l9vcfYQI99MmS2btXG9aiRdXpMs7h717fK/khjptMFbgO8F+drjGo+IxN
         GjprcAWTfdc8wkj/yYUFIPm/bQqKVdLDTcBLMP7cTAnB7kHwpFm64sKaygl6luiYV3jW
         t1hkJoNtLi2rJJ+zyL0x80to7PUkyrwQ6wvxxWBDrzhi89w18ko0kFykK+tZIHPiXL9E
         vJqlLWObMQ2pnf7GdXVUxQyy7eIt8Zn4fny0M8deP/9uHuUbvMxHzfQMS6p7roTjHWNF
         4XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700549728; x=1701154528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgARtT8lNAoPn7nEoA2naRGozC+cHDkv0phYpbjI7dk=;
        b=kWh5lLwPdDcpUnI99YpXdt3cPmtl1nicPkF5MbfPaARp7MBn1PpB1zBrfrbsbhI+pu
         qRyq6kTLXriVZfyaz9zA3s2ZImTShyS82All2BHsnNXdtir8cuo/oYfNBeOlSDVxowKm
         WifAsJhtS8akKWsb3vP+vL9DlR8Az4UnjUkm1F6iuuSH+KPXB0JL+6oM016PWn62a9Re
         XpNYznBXE23pUPERPkJ+ATljNLp92kRo5/M2j0mOccFhP/GvP7Iz9D4vNUCUE32TBSwU
         vIQN3gFGJRuTOwYdsZtETHEbFdfavH24YzCEffMbSa0NNnIcyPcssyWKdJGGNutvRGAy
         DKRA==
X-Gm-Message-State: AOJu0Yw1fTdwZVi560Rf7HpR+dU5owN5DiIuIESU5PFesl73ygBOqoGo
	6igLlkQibNhYuYlfPsKxdGk=
X-Google-Smtp-Source: AGHT+IEH3k/yggRAldVGxs67UPOWbNqA5WdQpP7N2G1ra0HlwSqAaCK4vh6k1IuSM5349Z0JqnECgw==
X-Received: by 2002:a17:903:4282:b0:1cb:dc81:379a with SMTP id ju2-20020a170903428200b001cbdc81379amr7383382plb.53.1700549728031;
        Mon, 20 Nov 2023 22:55:28 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902ac8f00b001ce5b6e97b3sm7167437plr.24.2023.11.20.22.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 22:55:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id C0BB6102106C6; Tue, 21 Nov 2023 13:55:25 +0700 (WIB)
Date: Tue, 21 Nov 2023 13:55:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Seamus de Mora <seamusdemora@gmail.com>,
	Linux Manual Pages <linux-man@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Subject: Re: Add sub-topic on 'exFAT' in man mount
Message-ID: <ZVxUXZrlIaRJKghT@archie.me>
References: <CAJ8C1XPdyVKuq=cL4CqOi2+ag-=tEbaC=0a3Zro9ZZU5Xw1cjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h56e6Ou9UZ6sE5+z"
Content-Disposition: inline
In-Reply-To: <CAJ8C1XPdyVKuq=cL4CqOi2+ag-=tEbaC=0a3Zro9ZZU5Xw1cjw@mail.gmail.com>


--h56e6Ou9UZ6sE5+z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 04:55:18PM -0600, Seamus de Mora wrote:
> I'd like to volunteer to add some information to the mount manual.
>=20
> I'm told that exFAT was added to the kernel about 4 years ago, but
> last I checked, there was nothing about it in man mount.  I feel this
> could be addressed best by adding a sub-topic on exFAT under the topic
> `FILESYSTEM-SPECIFIC MOUNT OPTIONS`.
>=20
> If my application is of interest, please let me know what steps I need
> to take - or how to approach this task.
>=20

I'm adding from Alejandro's reply.

You can start reading the source in fs/exfat in linux.git tree [1].
Then you can write the documentation for exfat in Documentation/exfat.rst
(currently doesn't exist yet), at the same time of your manpage contributio=
n.

Cc'ing exfat maintainers for better treatment.

Thanks.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/fs/exfat

--=20
An old man doll... just what I always wanted! - Clara

--h56e6Ou9UZ6sE5+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVxUXQAKCRD2uYlJVVFO
o0/lAP9XsbFit9r8IxumOGcnF3HJ8wG8/ivOqPbeik0Ne3+l6AEA+bNMdJefkURV
5jii6xlG0O6U2G1V3CN5nSYry37ZBws=
=eMLP
-----END PGP SIGNATURE-----

--h56e6Ou9UZ6sE5+z--

