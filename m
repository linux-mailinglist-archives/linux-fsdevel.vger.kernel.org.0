Return-Path: <linux-fsdevel+bounces-30314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7799894A0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 11:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E15285868
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3931C14D710;
	Sun, 29 Sep 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZYqjUkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DF184D;
	Sun, 29 Sep 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727603291; cv=none; b=LaWSxInb2p7p8EIMX88qZWNk66fl1nH2i7an+VHAXtDhwYXnwAkT+wi0VNuhW7xvdzFwVbjnTO8v+t0ZyVILAW9hIVnGqcfYA4uaFPHiplYhRNYL+9qU64yyTsgHgLwIeafcQFcBh+kJWVF/wkt8gD6v0kIWnMAPK+a/FUWbxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727603291; c=relaxed/simple;
	bh=Q85EQZ1C0LWdCS5RaobjsfqzLm5bDoBuzWbpeweMj9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb7IWRlldnLut5tRaV5lBOxq+XtVKdpmgdr1MSpX1OBZDk8Ocm/R3h4fcoJZaprTCUnp9O3wMjsPBj5J2SBGU0A8BpOZ5mL4dltl58ZMtM8OFxNwVNoL1bZL55+Z7kqyPMewCE02rkhLIrRSDLuVDjsIZ9y2Wi5b/rz+Ma2xRBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZYqjUkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAA7C4CEC5;
	Sun, 29 Sep 2024 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727603291;
	bh=Q85EQZ1C0LWdCS5RaobjsfqzLm5bDoBuzWbpeweMj9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZYqjUkdiv7S8FgTbaYbV0XUknhL1P1VVmTo9P1W2GctlLPXcJ8oJQHBKlPZgjXo2
	 Es2xS3ESgdg86l3wNftoKH9yH1/mTm6moYrm8dO7zU9boWmnMHAw8RgfZX0mjjOtZF
	 3Topn8mc6AxsEl9nm1AzniZzWYp8ZvUI1lQvJdgHq4cipjPYGwJMkUqiJAjl1fNVVH
	 4V2xLeDXnFXCRYKaPkvjwJu2MSGKPGUGkuP+NA3eC/XdQPRwLsGdFWj7FNnY4DOSXy
	 CKQblIkIkEUIRFJqSL4eUbxg5R1gDF2r/Fs5YYJQanEMuWLUSlYPW9HSAKjbigtLm5
	 iX9v7pf55JwHQ==
Date: Sun, 29 Sep 2024 11:48:05 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, justinstitt@google.com, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
Message-ID: <squaseoxrkkxw7my6cdxksmiuhfj2qzd3luwzkyhnd7of2envx@w6s7ncgh4ea3>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
 <202409281414.487BFDAB@keescook>
 <xzhijtnrz57jxrqoumamxfs3vl7nrsu5qamcjcm4mgtdhruy5r@4az7dbngmfdn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vmgihngka57rzukx"
Content-Disposition: inline
In-Reply-To: <xzhijtnrz57jxrqoumamxfs3vl7nrsu5qamcjcm4mgtdhruy5r@4az7dbngmfdn>


--vmgihngka57rzukx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, justinstitt@google.com, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
References: <20240817025624.13157-1-laoar.shao@gmail.com>
 <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
 <202409281414.487BFDAB@keescook>
 <xzhijtnrz57jxrqoumamxfs3vl7nrsu5qamcjcm4mgtdhruy5r@4az7dbngmfdn>
MIME-Version: 1.0
In-Reply-To: <xzhijtnrz57jxrqoumamxfs3vl7nrsu5qamcjcm4mgtdhruy5r@4az7dbngmfdn>

On Sun, Sep 29, 2024 at 09:58:30AM GMT, Alejandro Colomar wrote:
> [CC +=3D Andy, Gustavo]
>=20
> On Sat, Sep 28, 2024 at 02:17:30PM GMT, Kees Cook wrote:
> > > > diff --git a/mm/util.c b/mm/util.c
> > > > index 983baf2bd675..4542d8a800d9 100644
> > > > --- a/mm/util.c
> > > > +++ b/mm/util.c
> > > > @@ -62,8 +62,14 @@ char *kstrdup(const char *s, gfp_t gfp)
> > > > =20
> > > >  	len =3D strlen(s) + 1;
> > > >  	buf =3D kmalloc_track_caller(len, gfp);
> > > > -	if (buf)
> > > > +	if (buf) {
> > > >  		memcpy(buf, s, len);
> > > > +		/* During memcpy(), the string might be updated to a new value,
> > > > +		 * which could be longer than the string when strlen() is
> > > > +		 * called. Therefore, we need to add a null termimator.
> > > > +		 */
> > > > +		buf[len - 1] =3D '\0';
> > > > +	}
> > >=20
> > > I would compact the above to:
> > >=20
> > > 	len =3D strlen(s);
> > > 	buf =3D kmalloc_track_caller(len + 1, gfp);
> > > 	if (buf)
> > > 		strcpy(mempcpy(buf, s, len), "");
> > >=20
> > > It allows _FORTIFY_SOURCE to track the copy of the NUL, and also uses
> > > less screen.  It also has less moving parts.  (You'd need to write a
> > > mempcpy() for the kernel, but that's as easy as the following:)
> > >=20
> > > 	#define mempcpy(d, s, n)  (memcpy(d, s, n) + n)
> > >=20
> > > In shadow utils, I did a global replacement of all buf[...] =3D '\0';=
 by
> > > strcpy(..., "");.  It ends up being optimized by the compiler to the
> > > same code (at least in the experiments I did).
> >=20
> > Just to repeat what's already been said: no, please, don't complicate
> > this with yet more wrappers. And I really don't want to add more str/mem
> > variants -- we're working really hard to _remove_ them. :P
>=20
> Hi Kees,
>=20
> I assume by "[no] more str/mem variants" you're referring to mempcpy(3).
>=20
> mempcpy(3) is a libc function available in several systems (at least
> glibc, musl, FreeBSD, and NetBSD).  It's not in POSIX nor in OpenBSD,
> but it's relatively widely available.  Availability is probably
> pointless to the kernel, but I mention it because it's not something
> random I came up with, but rather something that several projects have
> found useful.  I find it quite useful to copy the non-zero part of a
> string.  See string_copying(7).
> <https://www.man7.org/linux/man-pages/man7/string_copying.7.html>
>=20
> Regarding "we're working really hard to remove them [mem/str wrappers]",
> I think it's more like removing those that are prone to misuse, not just
> blinly reducing the amount of wrappers.  Some of them are really useful.
>=20
> I've done a randomized search of kernel code, and found several places
> where mempcpy(3) would be useful for simplifying code:
>=20
> ./drivers/staging/rtl8723bs/core/rtw_ap.c:		memcpy(pwps_ie, pwps_ie_src, =
wps_ielen + 2);
> ./drivers/staging/rtl8723bs/core/rtw_ap.c-		pwps_ie +=3D (wps_ielen+2);
>=20
> equivalent to:
>=20
> 	pwps_ie =3D mempcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
>=20
> ./drivers/staging/rtl8723bs/core/rtw_ap.c:		memcpy(supportRate + supportR=
ateNum, p + 2, ie_len);
> ./drivers/staging/rtl8723bs/core/rtw_ap.c-		supportRateNum +=3D ie_len;
>=20
> equivalent to:
>=20
> 	supportRateNum =3D mempcpy(supportRate + supportRateNum, p + 2, ie_len);

Oops, I misread the original in the above.  I didn't notice that the +=3D
is being done on the count, not the pointer.  The other equivalences are
good, though.

>=20
> ./drivers/staging/rtl8723bs/core/rtw_ap.c:		memcpy(dst_ie, &tim_bitmap_le=
, 2);
> ./drivers/staging/rtl8723bs/core/rtw_ap.c-		dst_ie +=3D 2;
>=20
> equivalent to:
>=20
> 	dst_ie =3D mempcpy(dst_ie, &tim_bitmap_le, 2);
>=20
>=20
> And there are many cases like this.  Using mempcpy(3) would make this
> pattern less repetitive.

--=20
<https://www.alejandro-colomar.es/>

--vmgihngka57rzukx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmb5Ik4ACgkQnowa+77/
2zKNqBAAqNB/fweA49pRRWO/XgFk0EvMiezUqWV2wXsV2l/VUrjeGx/Tecpvhh5b
cze6CNkVl/fKu2M8a5/ysj/r99gtHpNA85bmby3/b4BFwXNfPd7V+Qz1hUI7iXom
3hnuyFNPMH7iIyUxvwwHM3k3qSh1G/rxcVJm2NkRDC0WJo7dEIHl8UxaaXTEcqTO
bbb+umzXIosV+Fhsk1tjwgORKj5GaOVMbbF+hqFeuLt7z1eFWb3MYQAavRKN7SNm
QVgnMlJZir6XIzQv8HaAQvulm4x+N9xvMSlQ9ihADbMHc0YZPxp/ZZqYmnvyopWn
5FlXrWZhfi+tbHSciR4f/n8OVg6go0483iVrLZNs8+rne7Et8iExHCqHlqAIlA9S
d1hJfdjZGGdgO5DbA6Y3H0hf/XS9e/IZ+a+T0MEdvjDv7pv+zhYSuapXnbJ+xbDB
XmpEadusEMQGWkf+8GEeXiI8IujrMCAlncDoisghL3BF/ALac9zkWnFQjjW5l+xJ
op+juVgs6urGNtdRzW8Itu+AlkSJyuYb0rbRfoE6NN+yRG04Yxf9rMC98bI3q8zl
ZZr85yLJayTBLOD+QQVsbeUQJFs4sJan+Bj8EN42+BCZ+Se1XCxSeh2nDSXlpAAX
wv+032Rpbz/aJVCJLO2r02aT/nYCQBDo/gNYqy/cMqdm8R35R80=
=kmHt
-----END PGP SIGNATURE-----

--vmgihngka57rzukx--

