Return-Path: <linux-fsdevel+bounces-12942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973C868F5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 12:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819961F273DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811213A249;
	Tue, 27 Feb 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PM4n/0Sg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678A54BFC
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034135; cv=none; b=PAWVjgqMgUUR9BCwI8ey4rto2C2HiVxdwqQUyKwa/ba5r9qA8dCv7OwWEIXuWvUPd5KRQpE+YwBNIZIrlBScD229sdsX2hfN6QsnMPRVYsN3tqZXSAG4oel9r+VXjRdS0mZiipYo01AYzTPW6YwsJtJS1kKN5f5C8tPYM+b12pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034135; c=relaxed/simple;
	bh=l8JyPh3KUUyVYVGPAmg1GAglhyb3oHIknNuJ/fa5eJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=S6I/oD6Nx59wwKB3gTBh9JmaXzR/C1DyghN6VazLEpDbmwgitVXHXXDaCF0BGpO+Qf4BqYsygzQctDu3ki3xXKz8MBWcUNFaDM3rWUyvpkm9UkE0Ihh+4JO9YaIJ79H+gaCKJ9Qso1OshXBRosbbVZouFQTYkhXLc7VFCdPXdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PM4n/0Sg; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240227114204euoutp0248ada0aab257bc11958532058b6b4bdf~3tXsi6piB1616816168euoutp02S
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 11:42:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240227114204euoutp0248ada0aab257bc11958532058b6b4bdf~3tXsi6piB1616816168euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709034124;
	bh=9NZAb323gBIz+kfWKWXT2Qoef/UCSAmPG14ZN7ecbFM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=PM4n/0Sgb4SQrKUUn+JQDNaIloF8z/biaeaG4QZ8NyM53PwYU9Y3VE42Qx0Kc7vcp
	 n9V/Zs3vbY/4INq0plS1/76paMjI0RGQ11sVz27T24mSneWNcWi9xIBmpL78PvD68q
	 ZZCBKSpUs/nYaTohHufz6Tsv6a47qzOPm1aJFZkc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240227114203eucas1p2b2e419dded18da00b8324a89f8ce80ad~3tXsID21T1978519785eucas1p2p;
	Tue, 27 Feb 2024 11:42:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DA.81.09814.B8ACDD56; Tue, 27
	Feb 2024 11:42:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240227114203eucas1p1ecacb1730fade22562318b58ac69b48d~3tXrnfip80667706677eucas1p1J;
	Tue, 27 Feb 2024 11:42:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240227114203eusmtrp17eae2062c2cc345b40e3029cd2d55c30~3tXrmmTmf2906129061eusmtrp1W;
	Tue, 27 Feb 2024 11:42:03 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-93-65ddca8bed18
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.A6.10702.A8ACDD56; Tue, 27
	Feb 2024 11:42:02 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240227114202eusmtip197888232c7483b0724d3b4d4af2dd178~3tXrcBZ-t1045210452eusmtip1J;
	Tue, 27 Feb 2024 11:42:02 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 27 Feb 2024 11:42:02 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 27 Feb
	2024 11:42:02 +0000
From: Daniel Gomez <da.gomez@samsung.com>
To: Jan Kara <jack@suse.cz>
CC: Hugh Dickins <hughd@google.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dagmcr@gmail.com"
	<dagmcr@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"willy@infradead.org" <willy@infradead.org>, "hch@infradead.org"
	<hch@infradead.org>, "mcgrof@kernel.org" <mcgrof@kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/9] shmem: fix llseek in hugepages
Thread-Topic: [RFC PATCH 0/9] shmem: fix llseek in hugepages
Thread-Index: AQHaW2RT7xV/K52STUGwCHRBbQ9MBbEKRvYAgAc7d4CAAZVngIAAJPeAgArwXwA=
Date: Tue, 27 Feb 2024 11:42:01 +0000
Message-ID: <elozg4pnyccaxmbb2nde3brtm32jko56e4mydxx53srze4zkcv@hukwjfblnjlo>
In-Reply-To: <20240220123905.qdjn2x3dtryklibl@quack3>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00717DEDED894B4ABA452342B0C962FB@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTZxjH895dr0c3tqMweALdIDiyqVhUpLs5QraFzEsM7Ef2h25h2o13
	gCvI7qiO8Q/RLMwaGDjxR1tDx8aPCgnmGE5QGq1ihcpkGyowgeGOBcHNWJqINq0bPVz63+eb
	9/t8v8+TvAyp/V2VyJSUVWChzGhKpTXU6csPf153cGgSr5/zpXD2rk6aW7joQ9xwXYDmvPXN
	BDfrq6M429H9BHeuf5Difuuz09xU52MVN1Y/i7hrQY+KCyzZ6def5nutk2reIZn57vY1vHTy
	AM1LvkNq/sqxAMVfdVxS84vSC7wk/028E/WBJrsQm0r2YCEjZ6em+NexI+ry6sQvXJ67RDW6
	F2dBUQywm2Ax2E9akIbRsu0IHrkbCEX4EUjHZtSKWEQQmOsinoycCt1QKQ9tCO5NXyD+d81Z
	mpAiriJwu27RinAiCPp/QMvzNLsaXIOSepnj2CSwXnZSyyaS9VFw0N4RLollX4Ohi1akmLJB
	qt5PKJwP33SfDjPFpkFP36NwUDSbB65Rh2qZo9gsaDhyPDyL2OfhtlPxkGwCTMhNK0fEQLPt
	HKlwPIT6ZmiF02H4powUXg89LS5K4VUw31yDlJx0cJz10Qq/Cj0jrpX8tdD63QKp7BMDg8fl
	8GHANmpgavSASgnKhZb22pXQWJj3/KiuR+nWiP2sER3WiA5rRIc1osOBVCdRAjaLpUVY3FiG
	9+pFY6loLivSf7K7VEL//T9vyOM/g9rm7+vdiGCQGwFDpsZF62ImsTa60Fj5JRZ27xDMJiy6
	URJDpSZEpxUmYy1bZKzAn2FcjoUnrwQTlVhN5HWVyFf4l546r2/L3fVMy4vvp1RO9Vq44Vbm
	0Max2qnGqvdcut40+e71B5k4f7s8Upslil+TW6dtzi392PCKvUF4eSmmZ28KKv+qwnvGO6RC
	Ez/l3JmQMtwu70LbrnXv4syhNzs/um+Y7sgtqIxf3NSacW3zSGEeG9J+PFAXz224M/Bn9tbk
	B7q42MOWw2bhL0wGke7D8Q7Yt0ducsQ++33BzKd93xqKPv+HqfHf/ON2lakkuDQOsqC7dSN3
	nz6zMjF/4m3PDlvXlmyUY65KckqhudElw9qs7oIT9m2z87a3Ao2G4kuPV28e9m8zzT43kPzQ
	brYRzf3Fv7xRM349lRKLjRvWkIJo/BeMtm6o7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsVy+t/xu7rdp+6mGiwIsJizfg2bxevDnxgt
	zvb9ZrM4PWERk8XTT30sFrOnNzNZ7Nl7ksXi8q45bBb31vxntbgx4Smjxfm/x1ktfv+Yw+bA
	47Fz1l12jwWbSj02r9Dy2LSqk81j06dJ7B4nZvxm8Tiz4Ai7x+dNch6bnrxlCuCM0rMpyi8t
	SVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4dGMae0GDVMW+
	42+YGhjfi3QxcnJICJhIbPh3jbWLkYtDSGApo8TRV4cYIRIyEhu/XGWFsIUl/lzrYoMo+sgo
	8WVhAwuEc4ZR4sa261DtKxkl1nVsYwFpYRPQlNh3chM7iC0iIC0x69hKsA5mgU8sEt1zVjOB
	JIQFrCVOHZ7FCFFkI7GpoZkJwvaT6N+8DcxmEVCV2LrrF9ggXgFfiX1XFgBt4wDa9pVJYns5
	SJhTwFRi4rSZYGMYBWQlHq2EKGcWEJe49WQ+E8QLAhJL9pxnhrBFJV4+/gf1mo7E2etPoF42
	kNi6dB8LhK0s8WpROyPEHB2JBbs/sUHYlhJbL+yDmq8tsWzha2aI0wQlTs58wjKBUWYWktWz
	kLTPQtI+C0n7LCTtCxhZVzGKpJYW56bnFhvpFSfmFpfmpesl5+duYgQmtW3Hfm7Zwbjy1Ue9
	Q4xMHIyHGCU4mJVEeGUE76YK8aYkVlalFuXHF5XmpBYfYjQFBt1EZinR5HxgWs0riTc0MzA1
	NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCabunu0rXx0qK8WJO/1uo1u9ec
	tXk55e/WesXlF49HTNJW6Dh8IT5ZV91WV3jXk5vnxLo9My64nK7RTJ21692ruVeVrz/MEP3n
	X2VzwXVu7cuqLb9EamPW3rkQlHFT+AJ7eWqS6ZoLL/5N2ubDeebRGqdtIh2dexbNru5wZS7u
	cNnVYVYgnjLrXccxeeOGre4Hff2mRGs9vuvz3/6VOotuTvbyhIJ72t9v7Llaf8ha1a7o8f83
	nn6869XXOjj9WWCae2eeNEP5joJ6ztUa9wxaeqapXLUNlQ3KaKv96BmSKtE7KW2/AMNOuSe6
	55Qz3AWN3z2xvdCzzedvUYgYl9Jj5XOxE5qnTfO87WPycrsSS3FGoqEWc1FxIgCeYCCa8wMA
	AA==
X-CMS-MailID: 20240227114203eucas1p1ecacb1730fade22562318b58ac69b48d
X-Msg-Generator: CA
X-RootMTR: 20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b@eucas1p1.samsung.com>
	<25i3n46nanffixvzdby6jwxgboi64qnleixz33dposwuwmzj7p@6yvgyakozars>
	<e3602f54-b333-7c8c-0031-6a14b32a3990@google.com>
	<r3ws3x36uaiv6ycuk23nvpe2cn2oyzkk56af2bjlczfzmkfmuv@72otrsbffped>
	<20240220123905.qdjn2x3dtryklibl@quack3>

On Tue, Feb 20, 2024 at 01:39:05PM +0100, Jan Kara wrote:
> On Tue 20-02-24 10:26:48, Daniel Gomez wrote:
> > On Mon, Feb 19, 2024 at 02:15:47AM -0800, Hugh Dickins wrote:
> > I'm uncertain when we may want to be more elastic. In the case of XFS w=
ith iomap
> > and support for large folios, for instance, we are 'less' elastic than =
here. So,
> > what exactly is the rationale behind wanting shmem to be 'more elastic'=
?
>=20
> Well, but if you allocated space in larger chunks - as is the case with
> ext4 and bigalloc feature, you will be similarly 'elastic' as tmpfs with
> large folio support... So simply the granularity of allocation of
> underlying space is what matters here. And for tmpfs the underlying space
> happens to be the page cache.

But it seems like the underlying space 'behaves' differently when we talk a=
bout
large folios and huge pages. Is that correct? And this is reflected in the =
fstat
st_blksize. The first one is always based on the host base page size, regar=
dless
of the order we get. The second one is always based on the host huge page s=
ize
configured (at the moment I've tested 2MiB, and 1GiB for x86-64 and 2MiB, 5=
12
MiB and 16GiB for ARM64).

If that is the case, I'd agree this is not needed for huge pages but only w=
hen
we adopt large folios. Otherwise, we won't have a way to determine the step=
/
granularity for seeking data/holes as it could be anything from order-0 to
order-9. Note: order-1 support currently in LBS v1 thread here [1].

Regarding large folios adoption, we have the following implementations [2] =
being
sent to the mailing list. Would it make sense then, to have this block trac=
king
for the large folios case? Notice that my last attempt includes a partial
implementation of block tracking discussed here.

[1] https://lore.kernel.org/all/20240226094936.2677493-2-kernel@pankajragha=
v.com/

[2] shmem: high order folios support in write path
v1: https://lore.kernel.org/all/20230915095042.1320180-1-da.gomez@samsung.c=
om/
v2: https://lore.kernel.org/all/20230919135536.2165715-1-da.gomez@samsung.c=
om/
v3 (RFC): https://lore.kernel.org/all/20231028211518.3424020-1-da.gomez@sam=
sung.com/

>=20
> > If we ever move shmem to large folios [1], and we use them in an oportu=
nistic way,
> > then we are going to be more elastic in the default path.
> >=20
> > [1] https://lore.kernel.org/all/20230919135536.2165715-1-da.gomez@samsu=
ng.com
> >=20
> > In addition, I think that having this block granularity can benefit quo=
ta
> > support and the reclaim path. For example, in the generic/100 fstest, a=
round
> > ~26M of data are reported as 1G of used disk when using tmpfs with huge=
 pages.
>=20
> And I'd argue this is a desirable thing. If 1G worth of pages is attached
> to the inode, then quota should be accounting 1G usage even though you've
> written just 26MB of data to the file. Quota is about constraining used
> resources, not about "how much did I write to the file".

But these are two separate values. I get that the system wants to track how=
 many
pages are attached to the inode, so is there a way to report (in addition) =
the
actual use of these pages being consumed?

>=20
> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR=

