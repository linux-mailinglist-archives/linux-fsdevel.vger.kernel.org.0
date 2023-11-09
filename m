Return-Path: <linux-fsdevel+bounces-2642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B38A7E736E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3411C20AF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5376374E8;
	Thu,  9 Nov 2023 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g0oXBtSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEE374CF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:12:19 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF93D5F;
	Thu,  9 Nov 2023 13:12:19 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231109211216euoutp01e5e16ec4043192e6210f7b2253b6bf5d~WEMKAFQgg2238122381euoutp01r;
	Thu,  9 Nov 2023 21:12:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231109211216euoutp01e5e16ec4043192e6210f7b2253b6bf5d~WEMKAFQgg2238122381euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699564337;
	bh=yv9LfHKexHKirbuSxuZOREkRNlwsv8Ux8ZWm2qSQQxs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=g0oXBtSAL8KC4V8EFzfdRGsePCi/G/3zhWrklwa+l4rEMvEXpDUmjsDoc+FtFI7xy
	 lKpXkRIVYvm/IG6t2Of/WVeuigf0Q6PUA8ysQMGzg3TDVZWOwkdJNUSCzn39IWOsMM
	 WuVmomeT3LpQeONfPXk0d7X18Gei+yoKd6TisrJE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231109211216eucas1p2a116f54806eee8f9e8500e9006d0b0c8~WEMJkCPhY0570205702eucas1p2y;
	Thu,  9 Nov 2023 21:12:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 3F.0B.42423.03B4D456; Thu,  9
	Nov 2023 21:12:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231109211215eucas1p2f4a2125049ed63ea8c6c2f5ca0bb4222~WEMINQuTQ2560425604eucas1p21;
	Thu,  9 Nov 2023 21:12:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231109211214eusmtrp2498b89f0928fa58272136e5c3ed10b6f~WEMIMI8UC1807718077eusmtrp29;
	Thu,  9 Nov 2023 21:12:14 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-26-654d4b305ac7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.96.10549.E2B4D456; Thu,  9
	Nov 2023 21:12:14 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231109211214eusmtip1d71c1f642882d981ea5450891db263fc~WEMH4aERD1799817998eusmtip1l;
	Thu,  9 Nov 2023 21:12:14 +0000 (GMT)
Received: from localhost (106.210.248.176) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 9 Nov 2023 21:12:14 +0000
Date: Thu, 9 Nov 2023 22:12:12 +0100
From: Joel Granados <j.granados@samsung.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, <willy@infradead.org>,
	<josh@joshtriplett.org>, Kees Cook <keescook@chromium.org>, David Howells
	<dhowells@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Benjamin LaHaise <bcrl@kvack.org>, Eric
	Biederman <ebiederm@xmission.com>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
	Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
	Anton Altaparmakov <anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
	<joseph.qi@linux.alibaba.com>, Iurii Zaikin <yzaikin@google.com>, "Theodore
 Y. Ts'o" <tytso@mit.edu>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick
 J. Wong" <djwong@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
	<coda@cs.cmu.edu>, <linux-cachefs@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-aio@kvack.org>, <linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>,
	<linux-ntfs-dev@lists.sourceforge.net>, <ocfs2-devel@lists.linux.dev>,
	<fsverity@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<codalist@telemann.coda.cs.cmu.edu>
Subject: Re: [PATCH 2/4] aio: Remove the now superfluous sentinel elements
 from ctl_table array
Message-ID: <20231109211212.4qkpi3crc77qjls2@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="on2lta5fousi47b2"
Content-Disposition: inline
In-Reply-To: <20231109160831.GA1933@sol.localdomain>
X-Originating-IP: [106.210.248.176]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTbTBcZxjNe/fu3osy1zK8QZMMITOJEImmb6NEtD9uG2k7aWc6NKKbuhUN
	S3YpyUwbrLS+2rCUWout8RGWTawdsUjJplnjIyUVpYJpBO0Q0fiKr9ruutJmpv/Oc55zzpzn
	x0Ny+DWEAxkhjGVEQkGkM88cb9Cv9Ow/cPwEc2CmlkK9KiVAl7UGHGnVGi5K39DgaPr2HEC/
	3NmBDCN/YGipZhBDzaonGCopreehJ8lrOOobt0KGhhQC1basc1DamIGHCvMlGCp/kMZFKxXV
	BOr4eQlHVRXLBDIoolF3RhRqHBnHUXZeOQfl5iUD9LSsk0AtNzuMYU1yHhqtMXBRb1sXF32d
	Kgeoab2RQBnZ+QQazJoA6GZJIo50o/1clFzUykWdq50YMgweRZczVwjU83c7F60tG0MqtO/4
	76MLE+/htOKnQHri3kn62m9SHq2VjRC0Qh1Hr+vqCLr+6l56aNqXVlen8Wj1nJSgtQ9fo/+s
	LwB0s2Ieo5O773Do7+cWeO85BJu/HsZERnzOiDz9PjY/K3/QBmJ+dUiYkXslgmy7dGBGQsob
	3q2Y56YDc5JPXQWwtyoFY4cFALv6dBx2mAdQkSvBn1uy5u/z2EUlgKWFOdi/qtU2xaaKT2kA
	VC6dM2Gc2g2/qe/mmTCPcoc9j4eNsSRpS7lBffm7Ji+HqreA6WO3MBNvQwlgyS03k9ySehVq
	p4Z5LLaGHQXjm/EcKgHKi4sJk5xDOcLKDdJEmxm7/Shp4LA9XaDkRhvB4i9gp2ZosyakBiyg
	Jreayy7ehKsZ17ewDZxq12wZnKBBW7JlyAGwdeMvgh2UAFYkLWKsygem3B/fchyD2elXcFMj
	SFnBwRlrtqgVlDbkc1jaEqZ+xWfVblA5+hjPAi6yF06TvXCa7L/TWNodKprneP+j98GKH6Y5
	LPaFKtUsrgBENbBn4sRR4YzYS8jEe4gFUeI4YbjHJ9FRamB8oq6N9rlGUDT11EMHMBLowG6j
	eey6shc44MJoIeNsa9nrHcjwLcMEFy4youhQUVwkI9YBRxJ3trd0DdvJ8KlwQSxzjmFiGNHz
	LUaaOSRiUmVkZKI04NtxH0HLJdLjoz0fOp4+leQf69JklyGWDRVZ+5pZpFXvKj+084h7hHob
	fKvxUD8pX3QaeXmgJTNFYI/i1YslZ4JEmbrgcR+PN4RlazvO+5yvKk1o6vxUdbgofrgrsBZf
	1dhVbtv1ZX9Ih6ejxnM5pOa7zx7lJB+R2tZNzvpdmfWpCZTUOPhFOV2bypQ907ZK0rZ72a9U
	Hl1TcQ96rumKVSWSU4f1rsfqXio4eDzmgn9IpHT7K1EFgxaTJ7LCH9oMB7n2JfFPC1WTS/sN
	U2T1noCLv595tq73CXUXXHob/2CA/6js/dvLHQVBqW561Ul9cJdd3t2JkYBQL++FG864+KzA
	ay9HJBb8A8+sNYu/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTbUxTVxjeuff23gJluePLu/oBdsQgzkqB4oGJGhOTu8wBw7n4Mcaq3IAb
	bUkLytxcEFABaQaE8FEZlI0yvtW2Mio4sUINBRU3QGDC0BWHohgoYzCBrrUsM9m/533e53nO
	ed+cw0bdTDiXfVSSzMgkokQe7ox1L98c2cx/730moHk+APY21QN4Wm/FoF6jY8GcZR0GJ2/M
	APhz5zpoHfkDgXMNgwhsbZpCYMV3WhxOpb/A4C/m16G1OZOAjW2LKMx+aMXh+eIMBKp/zWbB
	heo6AnbdnsNgbfU8Aa0qKew5J4YtI2YM5hepUVhYlA7gdJWJgG1Xu2xhV8pwONpgZcHe9m4W
	PJtVBuCVxRYCnssvJuBg3jiAVyvSMGgY7WfB9G+vsaDpbxMCrYM74OncBQLeWbrJgi/mbSHV
	+oidm+jzaXcxWtWxhx6/G01fGCrAab1yhKBVmhR60XCJoLU1/vTwZDitqcvGac1MAUHrH4TS
	E9pSQLeqLAid3tOJ0iUzs3gU9yB/m0yaksz4JEjlyeG8QwIYyBeEQn5gcChfELQ1JixQyNuy
	fVsck3j0GCPbsv1TfkLhwDWQ1MdNbayZx9LAN145wIlNkcFUnqUPzwHObDdSDajHGYOEo7GG
	ujTbz3Jgd2pxIGdFNA2oMWUHy1HoALVww4jbVRjpSym0PS8xTr5N3Xl6H80BbLYHuYEyqiPt
	epTUulCFv+lf8u6kiKq4vsEudyW3Uvon91cO+BOhOq2nUEfjDaqr1IzZMUoeo27Vt2N2L0qu
	pn5YZttpJ9sEP2U0o46LvkVl/Ni+MsBJyrL0COQBd+UrScpXkpT/JTlof2pw+THyP3oTVV05
	iTpwONXU9BxTAaIOeDApcnG8WC7gy0VieYoknn9EKtYA20NuNi5oW0D5k2m+ASBsYAC+NufD
	i/W9gItJpBKG5+HaG7yHcXONE31xgpFJY2UpiYzcAIS2JeajXM8jUtuvkCTHCkIChILgkNAA
	YWhIEG+V67tJWSI3Ml6UzHzOMEmM7F8fwnbipiFfjzd/L+UcH49RCP0Ks7PeOXjok2c9F0oV
	S+vVJ6Okt4rrfNYFKQ/4uHFiT31Ym0mQCR9fV+5/rW1j2biHCA7l+A0fNlg8z+yq5DxVpmmH
	zbuKORONDQW6R5+ZN2vPPF/fUrOXCZvrOO7tG9bbHzTtqeHw4n8fGhuLeLPcC+3sng0cmFi7
	O8kUlK9uFYssiLfLX/uGai+v9tob9gET5Tx6QnhP4aNzyq3yyh05qx376pnJPdFgUfjFLR74
	8rZ7tEJXaS7HZC1hxkoZI9JydsrxVdXUvQd9MQ3ekSUXXVw7MqPn969JbTUIpriqqn2tuwp9
	PdcaLxdFRpQ4pR427tj4EQ+TJ4gE/qhMLvoHvx/GvF0EAAA=
X-CMS-MailID: 20231109211215eucas1p2f4a2125049ed63ea8c6c2f5ca0bb4222
X-Msg-Generator: CA
X-RootMTR: 20231108034239eucas1p2e5dacae548e47694184df217ee168da9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231108034239eucas1p2e5dacae548e47694184df217ee168da9
References: <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
	<20231107-jag-sysctl_remove_empty_elem_fs-v1-2-7176632fea9f@samsung.com>
	<CGME20231108034239eucas1p2e5dacae548e47694184df217ee168da9@eucas1p2.samsung.com>
	<20231108034231.GB2482@sol.localdomain>
	<20231109160040.bahkcsp44t5xu7qo@localhost>
	<20231109160831.GA1933@sol.localdomain>

--on2lta5fousi47b2
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 08:08:31AM -0800, Eric Biggers wrote:
> On Thu, Nov 09, 2023 at 05:00:40PM +0100, Joel Granados wrote:
> > > >  static void __init fsverity_init_sysctl(void)
> > > >  {
> > > > +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> > > >  	fsverity_sysctl_header =3D register_sysctl("fs/verity",
> > > >  						 fsverity_sysctl_table);
> > > > +#else
> > > > +	fsverity_sysctl_header =3D register_sysctl_sz("fs/verity",
> > > > +						 fsverity_sysctl_table, 0);
> > > > +#endif
> > > >  	if (!fsverity_sysctl_header)
> > > >  		panic("fsverity sysctl registration failed");
> > >=20
> > > This does not make sense, and it causes a build error when CONFIG_FS_=
VERITY=3Dy
> > > and CONFIG_FS_VERITY_BUILTIN_SIGNATURES=3Dn.
> > >=20
> > > I think all you need to do is delete the sentinel element, the same as
> > > everywhere else.  I just tested it, and it works fine.
> > I found the reason why I added the CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> > here: it is related to
> > https://lore.kernel.org/all/20230705212743.42180-3-ebiggers@kernel.org/
> > where the directory is registered with an element only if
> > CONFIG_FS_VERITY_BUILTIN_SIGNATURES is defined. I had forgotten, but I
> > even asked for a clarification on the patch :).
> >=20
> > I see that that patch made it to v6.6. So the solution is not to remove
> > the CONFIG_FS_VERITY_BUILTIN_SIGNATURES, but for me to rebase on top of
> > a more up to date base.
> >=20
> > @Eric: Please get back to me if the patch in
> > https://lore.kernel.org/all/20230705212743.42180-3-ebiggers@kernel.org/
> > is no longer relevant.
> >=20
> > Best.
>=20
> Yes, that patch was merged in 6.6.  I don't think it really matters here =
though,
> other than the fact that it moved the code to a different file.  I believ=
e all
> you need to do is remove the sentinel element, the same as anywhere else:
Indeed. I thought that I had to handle empty array in a special way, but
it seems that ARRAY_SIZE works for empty arrays as well. I'll correct
this as well. Thx again for the feedback.

Best
>=20
> diff --git a/fs/verity/init.c b/fs/verity/init.c
> index a29f062f6047b..b64a76b9ac362 100644
> --- a/fs/verity/init.c
> +++ b/fs/verity/init.c
> @@ -24,7 +24,6 @@ static struct ctl_table fsverity_sysctl_table[] =3D {
>  		.extra2         =3D SYSCTL_ONE,
>  	},
>  #endif
> -	{ }
>  };
> =20
>  static void __init fsverity_init_sysctl(void)

--=20

Joel Granados

--on2lta5fousi47b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVNSyoACgkQupfNUreW
QU8f6Av9HchdVg/mEHIuP40DNIA/nNONzTP07M8jNvcnTldnVSuWwI+4Jz1T86bF
lIGqKW02Wu62D2pk8vbrld2Yfts/CtbF8JbOGbo9jZtW5/pp9ME3nP7ULVYCtKAl
0Orir/BJ0YB5S499YvRSCzJZFbGKNHK+6+2JO4ZkyxDsWkm0ssEPnxjS5cfgT9H2
DVYPgzrlkxjN5Aq+ZeC4S+/zy6dloY1DphgjaLaQ79X51GmIOlXgsDeuYFXe5M7h
p5cWlztiXyM8YluR3kziAsOHu7ZbdzhON6suvgu3kgjH85MaySub9yv9yHlJkq2p
JjCuPoVdimT4sc/jwQ5V5JtU2UyDAkHackubuZWmD4YU5ypQqozPGG0HDJnKkjw1
I9msvwOiAShUVxtnmSMx4ok2XRLYVZE8kk6tITArY3Rk2smqaWgoeEzloZUI4GEZ
QBj2uZPWnVdm60FyN0JL+m+MVyGnva9IX0GJ6azSnZAi0bNE3qVinsp2J226Hib4
PgBFablU
=eq5q
-----END PGP SIGNATURE-----

--on2lta5fousi47b2--

