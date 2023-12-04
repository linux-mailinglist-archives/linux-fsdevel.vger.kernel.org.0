Return-Path: <linux-fsdevel+bounces-4753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A97128030A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F49E280A19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43FE224D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Umyn7Y5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1110FA;
	Mon,  4 Dec 2023 00:43:20 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231204084318euoutp01ee7dabbcf18ad0df6fe293845daa7740~dlGWKlQFn0169201692euoutp01x;
	Mon,  4 Dec 2023 08:43:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231204084318euoutp01ee7dabbcf18ad0df6fe293845daa7740~dlGWKlQFn0169201692euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701679398;
	bh=hUZsAmSk95WEIzJ9RUcGUSd+zr2Kqs9vErQ81TuxOmw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Umyn7Y5Ni5ryV1PKXkC1aOz2hQOIvlq3C6kXoRHoHyIGXlbojaUGfsk9vahlsHr/Z
	 OkS6cLxVX5xBjsiqpt6L/C7Lxl8YRqAmsKZfLNbjbHhnvymriH3vTRVkJKHm6dwokl
	 slLvduy8tgZTFgBStqCwOH857XEz+XDEqwMP0pF8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231204084317eucas1p11dd9ab492fb8a71efd4c1e736771233f~dlGVxcoLy0755207552eucas1p1C;
	Mon,  4 Dec 2023 08:43:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 77.A9.09814.5219D656; Mon,  4
	Dec 2023 08:43:17 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231204084317eucas1p14c79a170988056cc2ad7499dadc1d3b0~dlGVQgJkM1146411464eucas1p1-;
	Mon,  4 Dec 2023 08:43:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231204084317eusmtrp1fde1045f9829d11dc3aaf0854c8c6c70~dlGVPf6sY1513115131eusmtrp1U;
	Mon,  4 Dec 2023 08:43:17 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-29-656d91257e0a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.5A.09146.4219D656; Mon,  4
	Dec 2023 08:43:16 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231204084316eusmtip2f87fc24f956edd53b912687a007e35e7~dlGVDwNiu2035720357eusmtip2U;
	Mon,  4 Dec 2023 08:43:16 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 4 Dec 2023 08:43:16 +0000
Date: Mon, 4 Dec 2023 09:43:14 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/7] sysctl: constify sysctl ctl_tables
Message-ID: <20231204084314.i7tvvejhlppdz5zd@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="qjmppfb42xwa7qzq"
Content-Disposition: inline
In-Reply-To: <e3932680-d284-4e13-9c0c-f202d588bf60@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djP87qqE3NTDe6uVrJoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBbFJdNSmpOZllqkb5dAlfG24ddzAUrtSua1j1mbGB8ptjFyMkhIWAi
	cfv9dsYuRi4OIYEVjBKTDxxiBEkICXxhlLjcZAlhf2aUmL0iGqZhee8cZoiG5YwS6xobmCAc
	oKLrBx9AOZsZJc5taQQbxSKgIvF562UWEJtNQEfi/Js7zCC2iICNxMpvn9lBGpgFdjFJPH44
	lwkkISxgL9FzcB0biM0rYC7ROOEbI4QtKHFy5hOwQcwCFRKvm84C1XAA2dISy/9xgIQ5gWbe
	+3iXCeJUJYmvb3pZIexaiVNbboEdJyGwnFNi44E+sF4JAReJPdN1IGqEJV4d38IOYctInJ7c
	wwJRP5lRYv+/D+wQzmpGiWWNX6E2WEu0XHkC1eEo0fN3LSPEUD6JG28FIe7kk5i0bTozRJhX
	oqNNCKJaTWL1vTcsExiVZyH5bBaSz2YhfAYR1pO4MXUKprC2xLKFr5khbFuJdevesyxgZF/F
	KJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmOJO/zv+ZQfj8lcf9Q4xMnEwHmJUAWp+tGH1
	BUYplrz8vFQlEd55t7JThXhTEiurUovy44tKc1KLDzFKc7AoifOqpsinCgmkJ5akZqemFqQW
	wWSZODilGpia5btP/Ip69+TbfMETTxcLLNgot8ljwh65SZN+NWWudRBf2LbDPU94y0rR9F6t
	yAUPjvKdPXNwcnfjdJaf/8Ln72qyWWFyu+KdtIVA8A/ulrnmxjVBbWc13KNb98joWMjc2S/n
	U32I30WG7VSHdMBtD5X4rcv+7EgryzxRqMUyaaLigyk/+Tc8nH3r9c9TrTMWmm39+z9QibvU
	3DT8RT/TviqZZ99t1ocdnRj4RO3mX/HWpSHVumvLdWLMTghuOlkT5CyXpG+80Uh+euN9ef33
	yg4fGF5MrvXUyNs5fcOJn5um/IlZWv/h1N6d57IMPLjY9rTPsJ67J5SRY4l+4nethwttNyvb
	RYdUVln45+YosRRnJBpqMRcVJwIAZwxM5+wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7oqE3NTDZYdsLZoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
	SmpOZllqkb5dgl7Gmqn9LAXLtSueLzrB2MD4RLGLkZNDQsBEYnnvHOYuRi4OIYGljBJLH71k
	gUjISGz8cpUVwhaW+HOtiw2i6COjRM/qP1AdmxklOp79AutgEVCR+Lz1MpjNJqAjcf7NHWYQ
	W0TARmLlt8/sIA3MAruYJB4/nMsEkhAWsJfoObiODcTmFTCXaJzwjRFi6g0miY3XjjJCJAQl
	Ts58AjaVWaBMYt3G80A3cQDZ0hLL/3GAhDmBFtz7eJcJ4lQlia9veqHOrpX4/PcZ4wRG4VlI
	Js1CMmkWwiSIsI7Ezq132DCEtSWWLXzNDGHbSqxb955lASP7KkaR1NLi3PTcYkO94sTc4tK8
	dL3k/NxNjMBo33bs5+YdjPNefdQ7xMjEwXiIUQWo89GG1RcYpVjy8vNSlUR4593KThXiTUms
	rEotyo8vKs1JLT7EaAoMxonMUqLJ+cA0lFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKa
	nZpakFoE08fEwSnVwBR69t2rWlGv2V82L7/eeHGddZ9nz7ukWnO5bxX9GZoTVN76eK2+1+TL
	2HBEzkX6YW230ONXtdM8DAt7viYGO0xlvZzyR0H45h9JzY7yk2bqC525XygpOC62qp0rzZT9
	/IjWQ5GeM3qfXqabbV7rHtciVGax8Xp5dEFcv04YQ/KEeKZyt6LJZwPiRY/84/oRb/E5bOef
	5J4HWVsWR5YvWDkv41bvn1nri5yf87XpuawVeSPz0dXPSll11d7jMpPjqj//Sm5ad5j9ddO+
	qYcPVSQxXpcwe2yW9+HNIsuCjHkW2Vln/truF3n56O7MDI81CdPrHP4b5u1Vqn14X36HUu+b
	L3cCGmN67LMEF1U9UWIpzkg01GIuKk4EAJtbPECLAwAA
X-CMS-MailID: 20231204084317eucas1p14c79a170988056cc2ad7499dadc1d3b0
X-Msg-Generator: CA
X-RootMTR: 20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439
References: <CGME20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439@eucas1p2.samsung.com>
	<20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
	<20231127101323.sdnibmf7c3d5ovye@localhost>
	<475cd5fa-f0cc-4b8b-9e04-458f6d143178@t-8ch.de>
	<20231201163120.depfyngsxdiuchvc@localhost>
	<e3932680-d284-4e13-9c0c-f202d588bf60@t-8ch.de>

--qjmppfb42xwa7qzq
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey

I see that you sent a V2. I'll try to get to it at the end of the week.

On Sun, Dec 03, 2023 at 04:37:01PM +0100, Thomas Wei=DFschuh wrote:
> Hi Joel,
>=20
> On 2023-12-01 17:31:20+0100, Joel Granados wrote:
> > Hey Thomas.
> >=20
> > Thx for the clarifications. I did more of a deep dive into your set and
> > have additional comments (in line). I think const-ing all this is a good
> > approach. The way forward is to be able to see the entire patch set of
> > changes in a V1 or a shared repo somewhere to have a better picture of
> > what is going on. By the "entire patchset" I mean all the changes that
> > you described in the "full process".
>=20
> All the changes will be a lot. I don't think the incremental value to
> migrate all proc_handlers versus the work is useful for the discussion.
> I can however write up my proposed changes for the sysctl core properly
> and submit them as part of the next revision.
Looking forward to seeing them in V2

>=20
> > On Tue, Nov 28, 2023 at 09:18:30AM +0100, Thomas Wei=DFschuh wrote:
> > > Hi Joel,
> > >=20
> > > On 2023-11-27 11:13:23+0100, Joel Granados wrote:
> > > > In general I would like to see more clarity with the motivation and=
 I
> > > > would also expect some system testing. My comments inline:

<--- snip --->

> > is all sysctl code and cannot be chunked up because of dependencies,
> > then it should be ok to do it in one go.
> >=20
> > > > > * Migrate all other sysctl handlers to proc_handler_new.
> > > > > * Drop the old proc_handler_field.
> > > > > * Fix the sysctl core to not modify the tables anymore.
> > > > > * Adapt public sysctl APIs to take "const struct ctl_table *".
> > > > > * Teach checkpatch.pl to warn on non-const "struct ctl_table"
> > > > >   definitions.
>=20
> > Have you considered how to ignore the cases where the ctl_tables are
> > supposed to be non-const when they are defined (like in the network
> > code that we were discussing earlier)
>=20
> As it would be a checkpatch warning it can be ignore while writing the
> patch and it won't trigger afterwards.
I mention coccinelle it is able to identify const vs non-const uses of
the ctl_table and only warn on the cases where it makes sense. This
would remove false negatives from pushing patches through.

>=20
> > > > > * Migrate definitions of "struct ctl_table" to "const" where appl=
icable.
> > These migrations are treewide and are usually reviewed by a wider
> > audience. You might need to chunk it up to make the review more palpable
> > for the other maintainers.
>=20
> Ack.
>=20
> > > > > =20
> > > > >=20
> > > > > Notes:
> > > > >=20
> > > > > Just casting the function pointers around would trigger
> > > > > CFI (control flow integrity) warnings.
> > > > >=20
> > > > > The name of the new handler "proc_handler_new" is a bit too long =
messing
> > > > > up the alignment of the table definitions.
> > > > > Maybe "proc_handler2" or "proc_handler_c" for (const) would be be=
tter.
> > >=20
> > > > indeed the name does not say much. "_new" looses its meaning quite =
fast
> > > > :)
> > >=20
> > > Hopefully somebody comes up with a better name!
>=20
> > I would like to avoid this all together and just do add the const to the
> > existing "proc_handler"
>=20
> Ack.
>=20
> > >=20
> > > > In my experience these tree wide modifications are quite tricky. Ha=
ve you
> > > > run any tests to see that everything is as it was? sysctl selftests=
 and
> > > > 0-day come to mind.
> > >=20
> > > I managed to miss one change in my initial submission:
> > > With the hunk below selftests and typing emails work.
> > >=20
> > > --- a/fs/proc/proc_sysctl.c
> > > +++ b/fs/proc/proc_sysctl.c
> > > @@ -1151,7 +1151,7 @@ static int sysctl_check_table(const char *path,=
 struct ctl_table_header *header)
> > >                         else
> > >                                 err |=3D sysctl_check_table_array(pat=
h, entry);
> > >                 }
> > > -               if (!entry->proc_handler)
> > > +               if (!entry->proc_handler && !entry->proc_handler_new)
> > >                         err |=3D sysctl_err(path, entry, "No proc_han=
dler");
> > > =20
> > >                 if ((entry->mode & (S_IRUGO|S_IWUGO)) !=3D entry->mod=
e)
> > >=20
> > > > [..]
> > >=20
> > > [0] 43a7206b0963 ("driver core: class: make class_register() take a c=
onst *")
> > > [1] https://lore.kernel.org/lkml/20230930050033.41174-1-wedsonaf@gmai=
l.com/
>=20
> Thanks for the feedback!
>=20
> Thomas

--=20

Joel Granados

--qjmppfb42xwa7qzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVtkRwACgkQupfNUreW
QU+y6gwAjmwiTajL3mLXXNgL5w17CaV42APC0OLNo5wj9QChvb9jjfHkSUyhM5Yu
jkfQdXAvoGv/T1iKWIiO+lD35CNuLrZ+4Jdahw8jk0lPNp7B8qbRTfd4GcVtFwQX
kcOTEZ1hRi7/cXf9yqllN8L5QZx0aALg8N3CM1/d/19nnZFZK+RfhS3ELSps6iIv
xv4VLF+1WbtnKgMQBm9DR6mPt8igvuTY/0sT2haTM8JQ/SomWeID2ouHqViYD+CU
hENTI608WD3x5oB/oozWwGfJhKEncYBbUKGpQH6hxnsFU5s9CjWF28j2bHCCSXW6
F3XKm4c+2bkch6oPvgP0h27ZJVNHZAKUXIUc3zCGwFg6D6w/PitbPkcaGa6wco7s
P+rx6EWENX/6zD0iUReFSE+1WRYpqkh3j/qDLaO2Zc8M84tTAgRxv+ZsIlTEWSFz
sRYZvi/y9k5cjrmmqhNCDPeNV/sCiPw85ftak5aNh8/5gJDdb2Ei8HCXj3ryu6Hp
2WUuz9HZ
=KDf2
-----END PGP SIGNATURE-----

--qjmppfb42xwa7qzq--

