Return-Path: <linux-fsdevel+bounces-6823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA081D3F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D3EB230B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B4DDB3;
	Sat, 23 Dec 2023 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HjFKjpVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1100D313;
	Sat, 23 Dec 2023 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231223120904euoutp021bd63559d92e4ca3b76589f56ae6fa42~jdKboj2LK2847428474euoutp02q;
	Sat, 23 Dec 2023 12:09:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231223120904euoutp021bd63559d92e4ca3b76589f56ae6fa42~jdKboj2LK2847428474euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703333344;
	bh=Rjs08YUO6R5Fo6m/E8HPd170IMaYrZG1q3E30ZVxhYo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HjFKjpVxkQxerAyWXijiGkF8JGspr67e6eNlsWFf2JKzMDSex3b+11f20hHrF6wp9
	 AFSKPnIumRkZNGz4KVQ/wQ74nyHoOT5FzDEXIUVbAhKHqq6IvIwVHk6nxKGlOeCqNd
	 DR+kX/9DtDDLuwBEqwIyvXirafdWhqrYzqE8eK+E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231223120903eucas1p210d87e21ded82ea460a1f83c938be14a~jdKay16PP0090300903eucas1p2f;
	Sat, 23 Dec 2023 12:09:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.C7.09539.FDDC6856; Sat, 23
	Dec 2023 12:09:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231223120902eucas1p1352ab08a66a5cbf982039b55c810573c~jdKZh8TVT1118711187eucas1p1C;
	Sat, 23 Dec 2023 12:09:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231223120902eusmtrp22caac69eb58fcb878c2880e5259a27fe~jdKZg8KqS1757817578eusmtrp2l;
	Sat, 23 Dec 2023 12:09:02 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-8e-6586cddf2ff9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 96.DC.09146.DDDC6856; Sat, 23
	Dec 2023 12:09:01 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231223120901eusmtip11a74ba805023d18843ac5d35d8b74a97~jdKZWgTIi0225402254eusmtip1a;
	Sat, 23 Dec 2023 12:09:01 +0000 (GMT)
Received: from localhost (106.210.248.246) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 23 Dec 2023 12:09:00 +0000
Date: Thu, 21 Dec 2023 13:12:30 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Julia Lawall <julia.lawall@inria.fr>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231221121230.xlcjmtpvvztguxom@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="tk4p6fhpr7ylfiyf"
Content-Disposition: inline
In-Reply-To: <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7djPc7r3z7alGmw5yGfxYV4ru0Xz4vVs
	Fr8uTmO1aFrVz2xxpjvXYs/ekywW89b/ZLS4vGsOm8XvH8+YLG5MeMposWynnwO3x+yGiywe
	CzaVekx6cYjFY9OqTjaPO9f2sHnsn7uG3ePzJjmP/u5j7AEcUVw2Kak5mWWpRfp2CVwZzcf3
	sRRMVKxY9uY1cwPjJ6kuRg4OCQETidMnvLsYuTiEBFYwSjRcfcYK4XxhlDh2qx/K+cwocWLT
	YpYuRk6wjiMXG5lAbCGB5YwSe5ot4IqO/bjCAuFsZZTYde0AO0gVi4CqxL6efawgNpuAjsT5
	N3eYQWwRARuJld8+s4M0MAv0MEvM3TyVHeQoYQEHiW1NkiA1vALmEu+v7WCBsAUlTs58AmYz
	C1RIPNp3nRmknFlAWmL5Pw6QMCfQyK2b17BBHKoscfPXO2YIu1bi1JZbTCCrJAQOc0r8OdbH
	CvG/i8TNa+wQNcISr45vgbJlJP7vnA9VP5lRYv+/D+wQzmpGiWWNX5kgqqwlWq48gepwlFg3
	dynUUD6JG28FIe7kk5i0bTozRJhXoqNNCKJaTWL1vTcsExiVZyH5bBaSz2YhfAYR1pO4MXUK
	G4awtsSyha+ZIWxbiXXr3rMsYGRfxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZgIT/87
	/mkH49xXH/UOMTJxMB5iVAFqfrRh9QVGKZa8/LxUJRHefJ2WVCHelMTKqtSi/Pii0pzU4kOM
	0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQamtrNnjqunrvx/0cM5cf3XNX/2J/EwuQdt
	mn/qzP4lDBUyIvHqK5eu55VR3mp+1F6cT23pagHPhX9Vp/SFX199/YT9Y8kWmZ0VN9+sTWmN
	lPTkmfNoZVH/HcdjNvyrsuRMs6/enRa4RH/64X/nHi/9rz4lavNbhe/T0sqFy91eWh2eWJcy
	d+/u694xO09PE4x4VRVq0HGC2ybs04JlqzvSwsLOOcrN6qnfnuPMaJi4dF7mj+1RKndMEgxi
	1/MZnpLL1Jr1qH6NFw+Xwc/lysI1WV4zyuMsNzhseWq+4rXYJAsuFtHm7xdbG5071/FGBF28
	Ze1R5mzLsOPPnh+XnkX5Ov88WXvjst+f+HXWE9Z0KbEUZyQaajEXFScCAGfkrD7/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42I5/e/4Xd27Z9tSDR51W1l8mNfKbtG8eD2b
	xa+L01gtmlb1M1uc6c612LP3JIvFvPU/GS0u75rDZvH7xzMmixsTnjJaLNvp58DtMbvhIovH
	gk2lHpNeHGLx2LSqk83jzrU9bB77565h9/i8Sc6jv/sYewBHlJ5NUX5pSapCRn5xia1StKGF
	kZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GnHeFBf2KFTOBBjUwfpDqYuTkkBAw
	kThysZGpi5GLQ0hgKaPEhlnbmSESMhIbv1xlhbCFJf5c62KDKPrIKHFs2XF2CGcro8SnCcdZ
	QKpYBFQl9vXsA+tgE9CROP/mDtgkEQEbiZXfPoM1MAv0MEs0LtsF1MDBISzgILGtSRKkhlfA
	XOL9tR0sEEMnsUhsefSYGSIhKHFy5hOwBcwCZRLXPjQygvQyC0hLLP/HARLmBJq/dfMaNohL
	lSVu/noH9UGtxOe/zxgnMArPQjJpFpJJsxAmQYR1JHZuvcOGIawtsWzha2YI21Zi3br3LAsY
	2VcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEJoRtx35u3sE479VHvUOMTByMhxhVgDofbVh9
	gVGKJS8/L1VJhDdfpyVViDclsbIqtSg/vqg0J7X4EKMpMBQnMkuJJucDU1VeSbyhmYGpoYmZ
	pYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOTbMbHv/yVti36YTmvPvgEiodzCO1x
	3ONz4uDctJsR86UzprvtKKlRdco7VptqusC+QTOeg3OdnZ5KGz8/xzQdrks/nG/sKpt98m7E
	lSNT067Y6W447ft8T+aFgp1r1+78Ok3uYdqjxE8pT/Y+L9fvMdoeknXTL3b19IuW9zIkAvTT
	lu7M65+v1LFfos9QV/NQICufi7VBo7t2EO/N6xP4Zi/K8rm7ZX9cePC8FB6bz6YGghtyf9wM
	uWjUlnZsdvT2gA3r+BQfK3fNL2tatv7Py3N6y780B3yewFoYcF0749C9gwm6X+fcemi/4oaR
	1rTnVtZh265NPvmOzZnnw74Il8MdTl03l1xw5DJT+RCsxFKckWioxVxUnAgA3XhgaZ0DAAA=
X-CMS-MailID: 20231223120902eucas1p1352ab08a66a5cbf982039b55c810573c
X-Msg-Generator: CA
X-RootMTR: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
	<20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<20231207104357.kndqvzkhxqkwkkjo@localhost>
	<fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
	<20231208095926.aavsjrtqbb5rygmb@localhost>
	<8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
	<20231212090930.y4omk62wenxgo5by@localhost>
	<ZXligolK0ekZ+Zuf@bombadil.infradead.org>
	<20231217120201.z4gr3ksjd4ai2nlk@localhost>
	<908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>

--tk4p6fhpr7ylfiyf
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 11:10:15PM +0100, Thomas Wei=DFschuh wrote:
> On 2023-12-17 13:02:01+0100, Joel Granados wrote:
> > Catching up with mail....
> >=20
> > On Tue, Dec 12, 2023 at 11:51:30PM -0800, Luis Chamberlain wrote:
> > > On Tue, Dec 12, 2023 at 10:09:30AM +0100, Joel Granados wrote:
> > > > My idea was to do something similar to your originl RFC, where you =
have
> > > > an temporary proc_handler something like proc_hdlr_const (we would =
need
> > > > to work on the name) and move each subsystem to the new handler whi=
le
> > > > the others stay with the non-const one. At the end, the old proc_ha=
ndler
> > > > function name would disapear and would be completely replaced by th=
e new
> > > > proc_hdlr_const.
> > > >
> > > > This is of course extra work and might not be worth it if you don't=
 get
> > > > negative feedback related to tree-wide changes. Therefore I stick t=
o my
> > > > previous suggestion. Send the big tree-wide patches and only explore
> > > > this option if someone screams.
> > >
> > > I think we can do better, can't we just increase confidence in that we
> > > don't *need* muttable ctl_cables with something like smatch or
> > > coccinelle so that we can just make them const?
> > >
> > > Seems like a noble endeavor for us to generalize.
> > >
> > > Then we just breeze through by first fixing those that *are* using
> > > mutable tables by having it just de-register and then re-register
> > So let me see if I understand your {de,re}-register idea:
> > When we have a situation (like in the networking code) where a ctl_table
> > is being used in an unmuttable way, we do your {de,re}-register trick.
>=20
> unmuttable?
meant muttable here.

>=20
> > The trick consists in unregistering an old ctl_table and reregistering
> > with a whole new const changed table. In this way, whatever we register
> > is always const.
> >=20
> > Once we address all the places where this happens, then we just change
> > the handler to const and we are done.
> >=20
> > Is that correct?
>=20
> I'm confused.
>=20
> The handlers can already be made const as shown in this series, which
> does convert the whole kernel tree.
> There is only one handler (the stackleak one) which modifies the table
> and this one is fixed as part of the series.
>=20
> (Plus the changes needed to the sysctl core to avoid mutation there)
>=20
> > If that is indeed what you are proposing, you might not even need the
> > un-register step as all the mutability that I have seen occurs before
> > the register. So maybe instead of re-registering it, you can so a copy
> > (of the changed ctl_table) to a const pointer and then pass that along
> > to the register function.
>=20
> Tables that are modified, but *not* through the handler, would crop
> during the constification of the table structs.
> Which should be a second step.
>=20
> But Luis' message was not completely clear to me.
> I guess I'm missing something.
>=20
> > Can't think of anything else off the top of my head. Would have to
> > actually see the code to evaluate further I think.
> >=20
> > > new tables if they need to be changed, and then a new series is sent
> > > once we fix all those muttable tables.
>=20
> Thomas

--=20

Joel Granados

--tk4p6fhpr7ylfiyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWEK64ACgkQupfNUreW
QU9fQwwAhJseIaIy1SORh8aGmpJivq9kgOI86oUxtrqGcIBpz9NSYcNlSrl6qfeV
d1P2Y6DnBrNzfTDGvo0MMHV4hc181jrHB+wB00RtwNISrnjFd1rQuaUQNFDHNQw+
swOlzFczncIOufZa2nc2GuGF3CfhEjTIsHZADcRIIrumAkIfLUhf4ctVqdrmCUGW
qkn7zXoyq2LBY8A3Nkp5FP/pX5EVkPZcejoH8BJlVnVHR47AmbKO5YQ6Me5qngm0
xrm7W1EqEk3KkIJ9D9ortKfDhaWLju9RZivSkMcI0r6nu/ucfHG7BNCA0igE5Wbl
C/YAmWqZsBYHHR/0kPurtwhvw/kbwVchI4oTJYhUE+sPrPUeqJPRgk60SsDGEUuz
pmWBeWHv7A610Pelao9tBiRfO8Y3Z2JgGEgyRB7qyzZi0RQGobK3ZAlMTbrezSsr
EC6xMBMaLNxJK3gNjSZnvfGpq1itOK9348ohKziaiiE3g4KVu/xNYlPc2knSifhp
s5kuZU5K
=d5zj
-----END PGP SIGNATURE-----

--tk4p6fhpr7ylfiyf--

