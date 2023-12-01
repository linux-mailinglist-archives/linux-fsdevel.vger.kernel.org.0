Return-Path: <linux-fsdevel+bounces-4594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19452801032
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27752817E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A414CE1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T5hnN8q5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD75D40;
	Fri,  1 Dec 2023 08:31:27 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231201163123euoutp01665d06b3e9693dcbe494a262b1aed34f~cwjMbTCwJ0139601396euoutp01n;
	Fri,  1 Dec 2023 16:31:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231201163123euoutp01665d06b3e9693dcbe494a262b1aed34f~cwjMbTCwJ0139601396euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701448284;
	bh=WVy81ELyRL4ewwE4ZYe0oK50KRr9OpFGuAYWG5kBZMs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=T5hnN8q50eP00IBSFxXQAmJOUWxamW7q5TgY32OyLDzxtqknOy+NSFpaD+hNGS22h
	 lAl1jSR1s6PYfGTR44xLswxW6E0bJ5PeYeyD92Yig9PVD9pgWwbw+RdOAP96cSRFpa
	 HSL5sRW9jZcY5g+9CAJzjtum8vWCcOBeJWmcoFcg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231201163123eucas1p12da48aab4b9c40d3f3a425181f60030e~cwjMQKq0E3066430664eucas1p1T;
	Fri,  1 Dec 2023 16:31:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D8.E0.09539.B5A0A656; Fri,  1
	Dec 2023 16:31:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231201163123eucas1p2f5f881dbb605051d96bc381d005105bc~cwjLqZTvw2617626176eucas1p2w;
	Fri,  1 Dec 2023 16:31:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231201163123eusmtrp17d8c939cc6ca86c6494a9f619ce5e83a~cwjLpySTf0767607676eusmtrp1X;
	Fri,  1 Dec 2023 16:31:23 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-f5-656a0a5b309c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.8C.09274.A5A0A656; Fri,  1
	Dec 2023 16:31:23 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231201163122eusmtip13205e20233e61dd48e89596404465dd2~cwjLawovx0218502185eusmtip13;
	Fri,  1 Dec 2023 16:31:22 +0000 (GMT)
Received: from localhost (106.210.248.232) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 1 Dec 2023 16:31:22 +0000
Date: Fri, 1 Dec 2023 17:31:20 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/7] sysctl: constify sysctl ctl_tables
Message-ID: <20231201163120.depfyngsxdiuchvc@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="62vksxdeaplkstjx"
Content-Disposition: inline
In-Reply-To: <475cd5fa-f0cc-4b8b-9e04-458f6d143178@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djP87rRXFmpBienaFg0L17PZvHr4jRW
	izPduRZ79p5ksZi3/iejxeVdc9gsfv94xmRxY8JTRotlO/0cOD1mN1xk8ViwqdRj06pONo/9
	c9ewe3zeJOfR332MPYAtissmJTUnsyy1SN8ugSujadst1oI79hVLZrWxNjBeNupi5OSQEDCR
	+HP2EmMXIxeHkMAKRom7K6ewQzhfGCW2v1/KAuF8ZpTomvCYHablbE8PVNVyRonWZV3scFW7
	uv9DDdvCKPHh3l6gDAcHi4CKxLn/liDdbAI6Euff3GEGsUUEbCRWfvsM1swssItJ4vHDuUwg
	CWEBe4meg+vYQGxeAXOJ/Rs6oWxBiZMzn7CA2MwCFRJ/N85nBpnPLCAtsfwfB0iYE2jm7eal
	jBCXKktcn/mCCcKulTi15RYTyC4JgeWcEndOHmeFSLhINHa/ZYOwhSVeHd8C9aaMxOnJPSwQ
	DZMZJfb/+8AO4axmlFjW+BVqrLVEy5UnUB2OEj1/1zKCXCQhwCdx460gxKF8EpO2TWeGCPNK
	dLQJQVSrSay+94ZlAqPyLCSvzULy2iyE1yDCehI3pk5hwxDWlli28DUzhG0rsW7de5YFjOyr
	GMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAtPc6X/HP+1gnPvqo94hRiYOxkOMKkDNjzas
	vsAoxZKXn5eqJMJ7/Wl6qhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILU
	IpgsEwenVANTCUPQkw2sew/NfRH29oPb83TP6G9dOrO++y06Lbj4bGDVmqaNDfLJPq+uT7o2
	1XDBlauPVvJEyRe1KP3sMpdu/F7IO3X++b+xKasZ5k2d8YYj/qNtR0M01zr75V/X3r3LYvkj
	vOh2xuOZm9L5DXN8djx5/+T/XX23BbpPNive9ro5yULn9pnwB7+PftEXOcp7P0q/uC0nO2Xh
	Dn8lD55b0dO+LXdoz++8t9tDSdPpxTS3xftmxnGvqP5yru172eK/ExjzY03Dk1fP5fuoFf4g
	a6L7+3cflqVcLDzPpP1r6o8DBzuWq7X7F+4v87arZOBJnHg1ODzbhsvA5WfA8YAJWzW+ShnU
	3VytwGMl98HglhJLcUaioRZzUXEiAK5DLCHuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xu7rRXFmpBj+bmCyaF69ns/h1cRqr
	xZnuXIs9e0+yWMxb/5PR4vKuOWwWv388Y7K4MeEpo8WynX4OnB6zGy6yeCzYVOqxaVUnm8f+
	uWvYPT5vkvPo7z7GHsAWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
	kpqTWZZapG+XoJexdOt8poJb9hVnm5awNzBeNOpi5OSQEDCRONvTw97FyMUhJLCUUeJ7x1UW
	iISMxMYvV1khbGGJP9e62CCKPjJK7J80EcrZwiix6dxjoCoODhYBFYlz/y1BGtgEdCTOv7nD
	DGKLCNhIrPz2GWwDs8AuJonHD+cygSSEBewleg6uYwOxeQXMJfZv6ASzhQR+MEq86KuEiAtK
	nJz5BOwiZoEyiWNnvjGC7GIWkJZY/o8DJMwJNP9281JGiEOVJa7PfMEEYddKfP77jHECo/As
	JJNmIZk0C2ESRFhHYufWO2wYwtoSyxa+ZoawbSXWrXvPsoCRfRWjSGppcW56brGRXnFibnFp
	Xrpecn7uJkZgpG879nPLDsaVrz7qHWJk4mA8xKgC1Plow+oLjFIsefl5qUoivNefpqcK8aYk
	VlalFuXHF5XmpBYfYjQFBuJEZinR5HxgCsoriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJ
	zU5NLUgtgulj4uCUamBa0qAxM2BRMIvEVd+DTc15T5duNFwixOXJw/Mmqu4sh8365PxQw4Sm
	MIGV9ZPLDj1el+F9LV7C3VH1ywPbtw8dfrI8XFDO4i5iN9GEYfXG3m+K05y2eOUemWV3yE60
	fs5Ci6vZIsdFk0NLZj46rPdV9UDVLcFJljNVivkTmgV7ZPhXzs6RmBbQLqni7a92J0SxOPOA
	4IEyfnefp1vfbt6QyOwY72ahH8uvYceygNVNqz/9eYjiufsfp61fvfjO2vrLdrwp7xtLtGNk
	JUIZz8e9zjK5kBdzefLhjRJbDtjN0nn3YxdPeNVZ7+gPPvuuyIpy58Rlr3umtsRUKm/u9MDr
	/fvmSScEFS+edySBQYmlOCPRUIu5qDgRAM2fcV6JAwAA
X-CMS-MailID: 20231201163123eucas1p2f5f881dbb605051d96bc381d005105bc
X-Msg-Generator: CA
X-RootMTR: 20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439
References: <CGME20231125125305eucas1p2ebdf870dd8ef46ea9d346f727b832439@eucas1p2.samsung.com>
	<20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
	<20231127101323.sdnibmf7c3d5ovye@localhost>
	<475cd5fa-f0cc-4b8b-9e04-458f6d143178@t-8ch.de>

--62vksxdeaplkstjx
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Thomas.

Thx for the clarifications. I did more of a deep dive into your set and
have additional comments (in line). I think const-ing all this is a good
approach. The way forward is to be able to see the entire patch set of
changes in a V1 or a shared repo somewhere to have a better picture of
what is going on. By the "entire patchset" I mean all the changes that
you described in the "full process".

On Tue, Nov 28, 2023 at 09:18:30AM +0100, Thomas Wei=DFschuh wrote:
> Hi Joel,
>=20
> On 2023-11-27 11:13:23+0100, Joel Granados wrote:
> > In general I would like to see more clarity with the motivation and I
> > would also expect some system testing. My comments inline:
>=20
> Thanks for your feedback, response are below.
>=20
> > On Sat, Nov 25, 2023 at 01:52:49PM +0100, Thomas Wei=DFschuh wrote:
> > > Problem description:
> > >=20
> > > The kernel contains a lot of struct ctl_table throught the tree.
> > > These are very often 'static' definitions.
> > > It would be good to mark these tables const to avoid accidental or
> > > malicious modifications.
>=20
> > It is unclear to me what you mean here with accidental or malicious
> > modifications. Do you have a specific attack vector in mind? Do you
> > have an example of how this could happen maliciously? With
> > accidental, do you mean in proc/sysctl.c? Can you expand more on the
> > accidental part?
>=20
> There is no specific attack vector I have in mind. The goal is to remove
> mutable data, especially if it contains pointers, that could be used by
> an attacker as a step in an exploit. See for example [0], [1].
I think you should work "remove mutable data" as part of you main
motivation when you send the non-RFC patch. I would also including [0]
and [1] (and any other previous work) to help contextualize.

>=20
> Accidental can be any out-of-bounds write throughout the kernel.
>=20
> > What happens with the code that modifies these outside the sysctl core?
> > Like for example in sysctl_route_net_init where the table is modified
> > depending on the net->user_ns? Would these non-const ctl_table pointers
> > be ok? would they be handled differently?
>=20
> It is still completely fine to modify the tables before registering,
> like sysctl_route_net_init is doing. That code should not need any
> changes.
>=20
> Modifying the table inside the handler function would bypass the
> validation done when registering so sounds like a bad idea in general.
This is done before registering. So the approach *is* sound.

> It would still be possible however for a subsystem to do so by just not
> making their sysctl table const and then modifying the table directly.
Indeed. Which might be intended or migth be someone that just forgets to
put const. I think you mentioned that there would be some sort of static
check for this (coccinelle or smach, or something else)?=20

> =20
> > > Unfortunately the tables can not be made const because the core
> > > registration functions expect mutable tables.
> > >=20
> > > This is for two reasons:
> > >=20
> > > 1) sysctl_{set,clear}_perm_empty_ctl_header in the sysctl core modify
> > >    the table. This should be fixable by only modifying the header
> > >    instead of the table itself.
> > > 2) The table is passed to the handler function as a non-const pointer.
> > >=20
> > > This series is an aproach on fixing reason 2).
>=20
> > So number 2 will be sent in another set?
Sorry, this was supposed to be "number 1", but you got my meaning :)

>=20
> If the initial feedback to the RFC and general process is positive, yes.
Off the top of my head, putting  that type in the header instead of the
ctl_table seems ok. I would include it in non-RFC version together with
2.

>=20
> > >=20
> > > Full process:
> > >=20
> > > * Introduce field proc_handler_new for const handlers (this series)
I don't understand why we need a new handler. Couldn't we just change
the existing handler to receive `const struct ctl_table` and change all
the `proc_do*` handlers?
I'm guessing its because you want to do this in steps? if that is the
case, it would be very helpfull to see (in some repo or V1) the steps
to change all the handlers in the non-RFC version=20

> > > * Migrate all core handlers to proc_handler_new (this series, partial)
> > >   This can hopefully be done in a big switch, as it only involves
> > >   functions and structures owned by the core sysctl code.
It would be helpful to see what the "big switch" would look like. If it
is all sysctl code and cannot be chunked up because of dependencies,
then it should be ok to do it in one go.

> > > * Migrate all other sysctl handlers to proc_handler_new.
> > > * Drop the old proc_handler_field.
> > > * Fix the sysctl core to not modify the tables anymore.
> > > * Adapt public sysctl APIs to take "const struct ctl_table *".
> > > * Teach checkpatch.pl to warn on non-const "struct ctl_table"
> > >   definitions.
Have you considered how to ignore the cases where the ctl_tables are
supposed to be non-const when they are defined (like in the network
code that we were discussing earlier)

> > > * Migrate definitions of "struct ctl_table" to "const" where applicab=
le.
These migrations are treewide and are usually reviewed by a wider
audience. You might need to chunk it up to make the review more palpable
for the other maintainers.

> > > =20
> > >=20
> > > Notes:
> > >=20
> > > Just casting the function pointers around would trigger
> > > CFI (control flow integrity) warnings.
> > >=20
> > > The name of the new handler "proc_handler_new" is a bit too long mess=
ing
> > > up the alignment of the table definitions.
> > > Maybe "proc_handler2" or "proc_handler_c" for (const) would be better.
>=20
> > indeed the name does not say much. "_new" looses its meaning quite fast
> > :)
>=20
> Hopefully somebody comes up with a better name!
I would like to avoid this all together and just do add the const to the
existing "proc_handler"

>=20
> > In my experience these tree wide modifications are quite tricky. Have y=
ou
> > run any tests to see that everything is as it was? sysctl selftests and
> > 0-day come to mind.
>=20
> I managed to miss one change in my initial submission:
> With the hunk below selftests and typing emails work.
>=20
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1151,7 +1151,7 @@ static int sysctl_check_table(const char *path, str=
uct ctl_table_header *header)
>                         else
>                                 err |=3D sysctl_check_table_array(path, e=
ntry);
>                 }
> -               if (!entry->proc_handler)
> +               if (!entry->proc_handler && !entry->proc_handler_new)
>                         err |=3D sysctl_err(path, entry, "No proc_handler=
");
> =20
>                 if ((entry->mode & (S_IRUGO|S_IWUGO)) !=3D entry->mode)
>=20
> > [..]
>=20
> [0] 43a7206b0963 ("driver core: class: make class_register() take a const=
 *")
> [1] https://lore.kernel.org/lkml/20230930050033.41174-1-wedsonaf@gmail.co=
m/
>=20
>=20
> Thomas

--=20

Best
Joel Granados

--62vksxdeaplkstjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVqClcACgkQupfNUreW
QU8bjAv/XDH1QrpOnyw0p5Ef1/EuNDqDCpf//956rA9GC1T48F2ovsuVAtFR7Vht
vrYW3bE4eJlV2IjwDXoLldcVeJoKJPvQXzbX4ALXjnF3FREfaMHz8lU4YuLDhwE4
yaclYTzU8T4YTSTH827E4r0I4qYi+7Vysx0Nj1Lu4OQ4cXmxLwefPrC3BrXpW5Pe
B3nccgjbGdy9ho20n8hWXLlJn114RVPgUxlqX5SbuH2EoPsBCVpfXzHETcOPOFXw
O5IGLleLH+1/A9JI5woGx+WQmGETev2/2Cc9V2hYGU+6kE4LFBbfN4IPYshvAx5z
kQx+3AJluJQXeQ0hCBR0CvSTRPaAKnoLkt5/P+8omwZFUunkyk5iL1o0i0UkxaVT
GHVqtd7gYXUJGr5WSt7brMhUOxhYYrsWl9PKgmqgrhmANVwGxKGfwu0Y3BjzZC47
WCqLSphlvAg6/hKdgAw1iBVixcxOPJK8Ujx7/gafCHmXp/onZmB6egXAG/pYtEhe
9nIBsKx8
=SQPW
-----END PGP SIGNATURE-----

--62vksxdeaplkstjx--

