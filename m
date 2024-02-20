Return-Path: <linux-fsdevel+bounces-12150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22685B901
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C901C21B98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18D964CCB;
	Tue, 20 Feb 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g4UHC2OI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFC63519
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424821; cv=none; b=LECn4CEzdevlfK3J3PKgiwSYpuKTbRJjAyR6J1w8Z0Dy569UVb2taO3vBB7MvKcckzASXOlCaSigV3Ly4dv5Omt5mprF+vAPxxoYHPmwnTogckstyzHGKfcMW8p6yC2ntM+NXbssXvYfZF6y1Rau7o9/K6X7dGgu2drScy+9VxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424821; c=relaxed/simple;
	bh=q0kPfjDVjTWxPpSsv7vqSFUm6CXaLJ2o1fR/B46A6iQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=sCgMyaVr9crFsltZOBfC1Rx1VfVwIj+TW0Okf+29I8386u42oUqhpYMhGJ/hq9vz8Wre/7/tkbNrtfF6P+Psiyn2zTklbwffLDVfj4st2pJmJygCBOcWkOJrh4w/nfMAlh62e03jLWnOw3xaZLhGZ7zJba79D/AX3zm7L4pS2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g4UHC2OI; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240220102651euoutp021c0d5be5c14a98e92b83793ef50368f8~1i1CYfzqQ1184211842euoutp02Z
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 10:26:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240220102651euoutp021c0d5be5c14a98e92b83793ef50368f8~1i1CYfzqQ1184211842euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708424811;
	bh=sTY7ZRk35VsBSy0i3v23h9cFe5OPagqweTLl8auI+eQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=g4UHC2OI52ZZLkGT8VCTfOBxOsGJ/IW6EEorqYO02kvd2XQav0keIyo9+XSfptQ4/
	 FR++xaEJI/+HcMwQgHlPloo4SRiCDLzpItY4a8PHolxqy5K7VZzdUIeHoCvL5XpeDM
	 MKxCBP+yEU2OZryEIO3t+o5FA0MK7TEi1h19WkLg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240220102651eucas1p1a21d0aa60706eb9bccd9823eb48c6361~1i1B_p1we0582105821eucas1p1U;
	Tue, 20 Feb 2024 10:26:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 46.73.09539.B6E74D56; Tue, 20
	Feb 2024 10:26:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240220102651eucas1p2e91df10d53d15bd0b0563d6f583e54a3~1i1BklAJu0042900429eucas1p20;
	Tue, 20 Feb 2024 10:26:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240220102651eusmtrp11d925864ec25430c55dcbf12cabb6c35~1i1Bj-xSt2942329423eusmtrp1s;
	Tue, 20 Feb 2024 10:26:51 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-99-65d47e6b3528
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 23.BC.09146.A6E74D56; Tue, 20
	Feb 2024 10:26:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240220102650eusmtip16a646dbb0038cbbb3932f8898113a892~1i1BVO6lQ1236712367eusmtip1T;
	Tue, 20 Feb 2024 10:26:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 20 Feb 2024 10:26:48 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Tue, 20 Feb
	2024 10:26:48 +0000
From: Daniel Gomez <da.gomez@samsung.com>
To: Hugh Dickins <hughd@google.com>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dagmcr@gmail.com"
	<dagmcr@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"willy@infradead.org" <willy@infradead.org>, "hch@infradead.org"
	<hch@infradead.org>, "mcgrof@kernel.org" <mcgrof@kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/9] shmem: fix llseek in hugepages
Thread-Topic: [RFC PATCH 0/9] shmem: fix llseek in hugepages
Thread-Index: AQHaW2RT7xV/K52STUGwCHRBbQ9MBbEKRvYAgAc7d4CAAZVngA==
Date: Tue, 20 Feb 2024 10:26:48 +0000
Message-ID: <r3ws3x36uaiv6ycuk23nvpe2cn2oyzkk56af2bjlczfzmkfmuv@72otrsbffped>
In-Reply-To: <e3602f54-b333-7c8c-0031-6a14b32a3990@google.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <416A2C7CA50F0A44B8296ACC92A73E9F@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djPc7rZdVdSDe7cFLeYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjOKySUnN
	ySxLLdK3S+DK6PvKUTDHpGLvi5lMDYz/NbsYOTkkBEwktjz9yNLFyMUhJLCCUeL6lQ/sEM4X
	Ron9cy5BZT4zSmw+1cEO03LiwVIWEFtIYDmjxMPZInBFXxZsYYVwzjBKLDxyA8pZySixYPEp
	ZpAWNgFNiX0nN4GNEhFQlljX/JQJxGYW+MAi0bQ4CMQWFrCWOHV4FiNEjY3EpoZmJgjbSWLP
	xD4wm0VAVeLqztNgNq+Ar8SZ04vBbE4BO4llJ+6zgdiMArISj1b+YoeYLy5x68l8JogXBCUW
	zd7DDGGLSfzb9ZANwtaROHv9CSOEbSCxdek+FghbUaLj2E02iDk6Egt2f4KyLSV6JyyDmq8t
	sWzha2aIewQlTs58Ag47CYGpXBK/tjyCWuwiMWfBLmg4Cku8Or6FfQKjziwk981CsmMWkh2z
	kOyYhWTHAkbWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIGJ7/S/4592MM599VHvECMT
	B+MhRgkOZiURXpbyK6lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotg
	skwcnFINTA78vhbVEny2GqlpuybLz+nK8768p63bXWqRz2mGpwYHFy/4+Uuwvdx80pfNHsrs
	l2IM6wrYhD+3aF+7Ilqif+Lvds6Ej9uOZ+4Xm+m39rieCktN3PG3N6LuOuRsCM446DRFc+2l
	XfVyq3aIMkrc3Hhp9pFmz5NvouaY3NyvkPM9IY7L6P9RudQlqyYzyZpn+qzzb7vtnqp99eLG
	NUKLBD0epuopiE/0Xr/wtHe5TxnXpssxTU4TrrA/fRxwKPijYdqkX7f8/mofieK9fqP8rrdO
	uyO/lYzDp3T+3UfmL+m0fFzt/6Ju9iL9hYGPis5/+DxtwoaN9XtjZOM0D63MXpzhwBawf+ub
	WRt3nJT9wKrEUpyRaKjFXFScCAAtfvI46wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsVy+t/xu7pZdVdSDXZ9tLaYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjNKzKcov
	LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL6PvKUTDHpGLv
	i5lMDYz/NbsYOTkkBEwkTjxYygJiCwksZZS4d40ZIi4jsfHLVVYIW1jiz7Uuti5GLqCaj4wS
	PY3XGCGcM4wSrScnQTkrGSWWt99lB2lhE9CU2HdyE5gtIqAssa75KRNIEbPABxaJHZfvM4Ik
	hAWsJU4dnsUIUWQjsamhmQnCdpLYM7EPzGYRUJW4uvM0mM0r4Ctx5vRiJohtbUwSc47eAzuW
	U8BOYtmJ+2wgNqOArMSjlb/ANjMLiEvcejKfCeIJAYkle85DPScq8fLxP6jndCTOXn/CCGEb
	SGxduo8FwlaU6Dh2kw1ijo7Egt2foGxLid4Jy6Dma0ssW/iaGeI4QYmTM5+wTGCUmYVk9Swk
	7bOQtM9C0j4LSfsCRtZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgWlt27Gfm3cwznv1Ue8Q
	IxMH4yFGCQ5mJRFelvIrqUK8KYmVValF+fFFpTmpxYcYTYGBN5FZSjQ5H5hY80riDc0MTA1N
	zCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamBh2SJskrNyq23cnyqhTufPmkxfn
	LuyVPHj04hLNhIaN6jt7Kl7+8Pz7b/2U3zNVSq+u2KEms9fpv+n24smTt4TYP7n8+US5stE+
	r7gMh0sHFL6teZT3s5Gn28j0IfdzH4332eckJtZrH3m4f+rX9awaLQVpRgv5p7+Le28WLyK4
	LzXB7sZ6hwvb004eflP966uy2fHf10NeaV5PFUyR0GGdXew3/WV8X5Cl246jab0tedcvv1PZ
	rGNbNnnzcb2ZMSax1gq710TErJbt2elw+8ODqEupr4z2ass8Cjmlnyaq5cHrvlTOav0ete0u
	S3b+PJJk8+SJaRTPmW/WTGysB+ZwxO8+dsxhyxWbnox5C+4qsRRnJBpqMRcVJwIAlWYMBPQD
	AAA=
X-CMS-MailID: 20240220102651eucas1p2e91df10d53d15bd0b0563d6f583e54a3
X-Msg-Generator: CA
X-RootMTR: 20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b@eucas1p1.samsung.com>
	<25i3n46nanffixvzdby6jwxgboi64qnleixz33dposwuwmzj7p@6yvgyakozars>
	<e3602f54-b333-7c8c-0031-6a14b32a3990@google.com>

On Mon, Feb 19, 2024 at 02:15:47AM -0800, Hugh Dickins wrote:
> On Wed, 14 Feb 2024, Daniel Gomez wrote:
> > On Fri, Feb 09, 2024 at 02:29:01PM +0000, Daniel Gomez wrote:
> > > Hi,
> > >=20
> > > The following series fixes the generic/285 and generic/436 fstests fo=
r huge
> > > pages (huge=3Dalways). These are tests for llseek (SEEK_HOLE and SEEK=
_DATA).
> > >=20
> > > The implementation to fix above tests is based on iomap per-block tra=
cking for
> > > uptodate and dirty states but applied to shmem uptodate flag.
> >=20
> > Hi Hugh, Andrew,
> >=20
> > Could you kindly provide feedback on these patches/fixes? I'd appreciat=
e your
> > input on whether we're headed in the right direction, or maybe not.
>=20
> I am sorry, Daniel, but I see this series as misdirected effort.
>=20
> We do not want to add overhead to tmpfs and the kernel, just to pass two
> tests which were (very reasonably) written for fixed block size, before
> the huge page possibility ever came in.

Is this overhead a concern in performance? Can you clarify what do you mean=
?

I guess is a matter of which kind of granularity we want for a filesystem. =
Then,
we can either adapt the test to work with different block sizes or change t=
he
filesystem to support this fixed and minimum block size.

I believe the tests should remain unchanged if we still want to operate at =
this
fixed block size, regardless of how the memory is managed in the filesystem=
 side
(whether is a huge page or a large folio with arbitrary order).

>=20
> If one opts for transparent huge pages in the filesystem, then of course
> the dividing line between hole and data becomes more elastic than before.

I'm uncertain when we may want to be more elastic. In the case of XFS with =
iomap
and support for large folios, for instance, we are 'less' elastic than here=
. So,
what exactly is the rationale behind wanting shmem to be 'more elastic'?

If we ever move shmem to large folios [1], and we use them in an oportunist=
ic way,
then we are going to be more elastic in the default path.

[1] https://lore.kernel.org/all/20230919135536.2165715-1-da.gomez@samsung.c=
om

In addition, I think that having this block granularity can benefit quota
support and the reclaim path. For example, in the generic/100 fstest, aroun=
d
~26M of data are reported as 1G of used disk when using tmpfs with huge pag=
es.

>=20
> It would be a serious bug if lseek ever reported an area of non-0 data as
> in a hole; but I don't think that is what generic/285 or generic/436 find=
.

I agree this is not the case here. We mark the entire folio (huge page) as
uptodate, hence we report that full area as data, making steps of 2M.

>=20
> Beyond that, "man 2 lseek" is very forgiving of filesystem implementation=
.

Thanks for bringing that up. This got me thinking along the same lines as
before, wanting to understand where we want to draw the line and the reason=
s
benhind it.

>=20
> I'll send you my stack of xfstests patches (which, as usual, I cannot
> afford the time now to re-review and post): there are several tweaks to
> seek_sanity_test in there for tmpfs huge pages, along with other fixes
> for tmpfs (and some fixes to suit an old 32-bit build environment).
>=20
> With those tweaks, generic/285 and generic/436 and others (but not all)
> have been passing on huge tmpfs for several years.  If you see something
> you'd like to add your name to in that stack, or can improve upon, please
> go ahead and post to the fstests list (Cc me).

Thanks for the patches Hugh. I see how you are making the seeking tests a b=
it
more 'elastic'. I will post them shortly and see if we can make sure we can
minimize the number of failures [2].

In kdevops [3], we are discussing the possibility to add tmpfs to 0-day and
track for any regressions.

[2] https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstests/=
expunges/6.8.0-rc2/tmpfs/unassigned
[3] https://github.com/linux-kdevops/kdevops

>=20
> Thanks,
> Hugh
>=20
> >=20
> > Thanks,
> > Daniel
> >=20
> > >=20
> > > The motivation is to avoid any regressions in tmpfs once it gets supp=
ort for
> > > large folios.
> > >=20
> > > Testing with kdevops
> > > Testing has been performed using fstests with kdevops for the v6.8-rc=
2 tag.
> > > There are currently different profiles supported [1] and for each of =
these,
> > > a baseline of 20 loops has been performed with the following failures=
 for
> > > hugepages profiles: generic/080, generic/126, generic/193, generic/24=
5,
> > > generic/285, generic/436, generic/551, generic/619 and generic/732.
> > >=20
> > > If anyone interested, please find all of the failures in the expunges=
 directory:
> > > https://protect2.fireeye.com/v1/url?k=3D9a7b8131-fbf09401-9a7a0a7e-00=
0babffaa23-2e83e8b120fdf45e&q=3D1&e=3De25c026a-1bb5-45f4-8acb-884e4a5e4d91&=
u=3Dhttps%3A%2F%2Fgithub.com%2Flinux-kdevops%2Fkdevops%2Ftree%2Fmaster%2Fwo=
rkflows%2Ffstests%2Fexpunges%2F6.8.0-rc2%2Ftmpfs%2Funassigned
> > >=20
> > > [1] tmpfs profiles supported in kdevops: default, tmpfs_noswap_huge_n=
ever,
> > > tmpfs_noswap_huge_always, tmpfs_noswap_huge_within_size,
> > > tmpfs_noswap_huge_advise, tmpfs_huge_always, tmpfs_huge_within_size a=
nd
> > > tmpfs_huge_advise.
> > >=20
> > > More information:
> > > https://protect2.fireeye.com/v1/url?k=3D70096f39-11827a09-7008e476-00=
0babffaa23-4c0e0d7b2ec659b6&q=3D1&e=3De25c026a-1bb5-45f4-8acb-884e4a5e4d91&=
u=3Dhttps%3A%2F%2Fgithub.com%2Flinux-kdevops%2Fkdevops%2Ftree%2Fmaster%2Fwo=
rkflows%2Ffstests%2Fexpunges%2F6.8.0-rc2%2Ftmpfs%2Funassigned
> > >=20
> > > All the patches has been tested on top of v6.8-rc2 and rebased onto l=
atest next
> > > tag available (next-20240209).
> > >=20
> > > Daniel
> > >=20
> > > Daniel Gomez (8):
> > >   shmem: add per-block uptodate tracking for hugepages
> > >   shmem: move folio zero operation to write_begin()
> > >   shmem: exit shmem_get_folio_gfp() if block is uptodate
> > >   shmem: clear_highpage() if block is not uptodate
> > >   shmem: set folio uptodate when reclaim
> > >   shmem: check if a block is uptodate before splice into pipe
> > >   shmem: clear uptodate blocks after PUNCH_HOLE
> > >   shmem: enable per-block uptodate
> > >=20
> > > Pankaj Raghav (1):
> > >   splice: don't check for uptodate if partially uptodate is impl
> > >=20
> > >  fs/splice.c |  17 ++-
> > >  mm/shmem.c  | 340 ++++++++++++++++++++++++++++++++++++++++++++++++--=
--
> > >  2 files changed, 332 insertions(+), 25 deletions(-)
> > >=20
> > > --=20
> > > 2.43.0=

