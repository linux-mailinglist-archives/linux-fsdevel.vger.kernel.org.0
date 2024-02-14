Return-Path: <linux-fsdevel+bounces-11604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211A855377
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 20:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA4E1F217B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D9513DB80;
	Wed, 14 Feb 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TnsCLdTh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD5127B5D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940162; cv=none; b=UQ0rn5qJCljtldYQHk8lR7PRihtKsDCRURvlDT13safwV4rgtmRkwme9wjKz/t4NKaY5TvyhqSHOU9hekde2J2IuA8mvtyZ+yqQrEzfFN3/A11vRkL8gFRXrTwzriF3j/n6ASNVOVcYTg81z68YKTk1DxvMH45kuO51aXk1YbGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940162; c=relaxed/simple;
	bh=p0Xqf5l5UHbMEjlOGdUqX0v0k/kHNtp57gnPKx5Qp3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=lG2w14C1x7EQ/4C8b1tFqxbG+Rgg3n16pig5ep5KyBk/0ldpAcTxWcEe9tFv+eqyb5PTuu5ln+ZpQVBrzyO3mKEeDUnQOyN/GEyuAW8138Si4ddQC/a8ibPvqB5Ykhejs3Z4OxKuDx8bSbmXx2b7dkxElBUderyXIIvuzROGQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TnsCLdTh; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240214194911euoutp010e33412fd5d477fc608dd40918714511~z0oTg6Hvj1667816678euoutp01M
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 19:49:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240214194911euoutp010e33412fd5d477fc608dd40918714511~z0oTg6Hvj1667816678euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707940151;
	bh=kvbTVEQV2U0t0xEud1N/gL2u/EkcZMJX2njmT1RmQQ4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=TnsCLdThxogT96lb/v896uvU2OlICBc8AD0E7WHIhW05nG3Rs08ueJ5PjmE4wlcv4
	 jhr8h6KVCLYJ/ogzJtYQ3DMHUahBetB8Kx38a4QOO/fXALx95qFMnTeapV6Sp3qFrB
	 tZ1iExSayNhts8L+0cpy6b60wUN/5w5Hydp7cFrc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240214194911eucas1p14e669af4aeca84e1455ec191ca66338e~z0oTLOyud2565825658eucas1p1-;
	Wed, 14 Feb 2024 19:49:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 07.3C.09552.7391DC56; Wed, 14
	Feb 2024 19:49:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b~z0oSvgpvu2566525665eucas1p1E;
	Wed, 14 Feb 2024 19:49:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240214194911eusmtrp29b9fa61b1520cce94240425dcdbb6e75~z0oSuwOga0939409394eusmtrp2N;
	Wed, 14 Feb 2024 19:49:11 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-d1-65cd1937bf6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.62.10702.6391DC56; Wed, 14
	Feb 2024 19:49:10 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240214194910eusmtip1b16ec3e3ce7b11edf9104c8d81d7b13c~z0oSi3uY70135901359eusmtip1J;
	Wed, 14 Feb 2024 19:49:10 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Wed, 14 Feb 2024 19:49:10 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Wed, 14 Feb
	2024 19:49:09 +0000
From: Daniel Gomez <da.gomez@samsung.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
	"hughd@google.com" <hughd@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "dagmcr@gmail.com" <dagmcr@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"willy@infradead.org" <willy@infradead.org>, "hch@infradead.org"
	<hch@infradead.org>, "mcgrof@kernel.org" <mcgrof@kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/9] shmem: fix llseek in hugepages
Thread-Topic: [RFC PATCH 0/9] shmem: fix llseek in hugepages
Thread-Index: AQHaW2RT7xV/K52STUGwCHRBbQ9MBbEKRvYA
Date: Wed, 14 Feb 2024 19:49:09 +0000
Message-ID: <25i3n46nanffixvzdby6jwxgboi64qnleixz33dposwuwmzj7p@6yvgyakozars>
In-Reply-To: <20240209142901.126894-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E71788F15B89794881397A82FB093F9F@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87rmkmdTDfZfFbWYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjOKySUnN
	ySxLLdK3S+DKOD3lJ1vBdJGKx60djA2MZwW6GDk5JARMJP7M/svUxcjFISSwglFi0eKPbBDO
	F0aJrtUHWSCcz4wSKxc9ZYJpuX57PjtEYjmjxM+GxwhVu66cgOo/wyixtr2bFcJZyShxbfYe
	NpB+NgFNiX0nN4H1iwg8Z5Ro3f0RzGEW2MQscXzRNnaQKmEBa4lTh2cxgtgiAjYSmxqamSBs
	I4lXjU1AcQ4OFgFViTPXMkBMXgFfib/PwF7iBOqc92g92C5GAVmJRyt/gU1kFhCXuPVkPtQP
	ghKLZu9hhrDFJP7tesgGYetInL3+hBHCNpDYunQfC4StLHFtTRsTxBwdiQW7P7FB2JYSK3+s
	YYGwtSWWLXwNNpMXaP7JmU/AwSIhMJdLYv/BVqhBLhLPV4FCBcQWlnh1fAv7BEadWUjum4Vk
	xywkO2Yh2TELyY4FjKyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxApPf6X/Hv+5gXPHq
	o94hRiYOxkOMEhzMSiK8k3rPpArxpiRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1O
	TS1ILYLJMnFwSjUwOfx7ZTx3enRyWJkTZ5THxk172FiUmJfvF3t+PvW84Cv710W3rfnPhiUv
	FltyxUaoOvvGVZO1TgIhLMp/1S1O/ti3YK5Ufv6sG0vfL1gz79rTSyoHPXifBObO/u8oZKui
	JTdNVKqnfDLDg8ttrjcmqUc2byufmKZw47r3g1SJFMn4sOnsT7wvTfa87Me+Z8db3pyTbW2W
	hi9tzRK0nIPS17ma7z9XH1SnYPaizb2LfabMpt+TrDq4FwdndMbUbZ4hfmb33ua5XMUrWV8/
	TM3Muh7Uuz0w6flLofJlR9aZBwddFhb+Hrbx1rSH98wN/gRbzm2aMq/o8PJzBqx++lVWk2eL
	S2Tu2RU+vUGr6qGLEktxRqKhFnNRcSIA4ShCBO0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsVy+t/xu7pmkmdTDRZNt7CYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjNKzKcov
	LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOD3lJ1vBdJGK
	x60djA2MZwW6GDk5JARMJK7fns/excjFISSwlFGi6/YaRoiEjMTGL1dZIWxhiT/Xutggij4y
	Sky9+w3KOcMo8Wv+cUYIZyWjxPy3F9lBWtgENCX2ndwENldE4CmjxPTfh1hAHGaBTcwSxxdt
	A6sSFrCWOHV4FthCEQEbiU0NzUwQtpHEq8YmoDgHB4uAqsSZaxkgJq+Ar8TfZ2B3CwlYSUzb
	fpoNxOYEmjLv0Xowm1FAVuLRyl9g05kFxCVuPZnPBPGCgMSSPeeZIWxRiZeP/0G9piNx9voT
	qJcNJLYu3ccCYStLXFvTxgQxR0diwe5PbBC2pcTKH2tYIGxtiWULX4PN5BUQlDg58wnLBEaZ
	WUhWz0LSPgtJ+ywk7bOQtC9gZF3FKJJaWpybnltspFecmFtcmpeul5yfu4kRmNa2Hfu5ZQfj
	ylcf9Q4xMnEwHmKU4GBWEuGd1HsmVYg3JbGyKrUoP76oNCe1+BCjKTDkJjJLiSbnAxNrXkm8
	oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk85zkSNtLHtjmrd4r/ws
	ddOprapVjafw0J69uaqV24pOPSmuXZ/6yp4v0CA+bf49X6/2ZTl3ZG2eqV6aaKx33ql6/hyz
	qQtfSc2eXKf6qqF7klSTdGGB6I55nRKK/Uu+6h9LLYnzf/ybb+NZrqneLasltM2n28ysz+Pb
	cvrw99YY1uQkrV3m1aabQk46VSnXPDvqYb079Klw6tl7e2cm2TbZrT69Vyyjbb7SHZ8laxYE
	NS/b+2f9Jff4C/1sloG/n/Bbvu9dv/OEYP/2jiV5StOa5M4vnfrmSKGqZd7kjbMVJj2R4L1w
	s2DHkfA/2zckBX3f4hxs9eLkaR3eF2vlXn0MPaAimbniyu+es5kLDiuxFGckGmoxFxUnAgDn
	ZulO9AMAAA==
X-CMS-MailID: 20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b
X-Msg-Generator: CA
X-RootMTR: 20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b@eucas1p1.samsung.com>

On Fri, Feb 09, 2024 at 02:29:01PM +0000, Daniel Gomez wrote:
> Hi,
>=20
> The following series fixes the generic/285 and generic/436 fstests for hu=
ge
> pages (huge=3Dalways). These are tests for llseek (SEEK_HOLE and SEEK_DAT=
A).
>=20
> The implementation to fix above tests is based on iomap per-block trackin=
g for
> uptodate and dirty states but applied to shmem uptodate flag.

Hi Hugh, Andrew,

Could you kindly provide feedback on these patches/fixes? I'd appreciate yo=
ur
input on whether we're headed in the right direction, or maybe not.

Thanks,
Daniel

>=20
> The motivation is to avoid any regressions in tmpfs once it gets support =
for
> large folios.
>=20
> Testing with kdevops
> Testing has been performed using fstests with kdevops for the v6.8-rc2 ta=
g.
> There are currently different profiles supported [1] and for each of thes=
e,
> a baseline of 20 loops has been performed with the following failures for
> hugepages profiles: generic/080, generic/126, generic/193, generic/245,
> generic/285, generic/436, generic/551, generic/619 and generic/732.
>=20
> If anyone interested, please find all of the failures in the expunges dir=
ectory:
> https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstests/ex=
punges/6.8.0-rc2/tmpfs/unassigned
>=20
> [1] tmpfs profiles supported in kdevops: default, tmpfs_noswap_huge_never=
,
> tmpfs_noswap_huge_always, tmpfs_noswap_huge_within_size,
> tmpfs_noswap_huge_advise, tmpfs_huge_always, tmpfs_huge_within_size and
> tmpfs_huge_advise.
>=20
> More information:
> https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstests/ex=
punges/6.8.0-rc2/tmpfs/unassigned
>=20
> All the patches has been tested on top of v6.8-rc2 and rebased onto lates=
t next
> tag available (next-20240209).
>=20
> Daniel
>=20
> Daniel Gomez (8):
>   shmem: add per-block uptodate tracking for hugepages
>   shmem: move folio zero operation to write_begin()
>   shmem: exit shmem_get_folio_gfp() if block is uptodate
>   shmem: clear_highpage() if block is not uptodate
>   shmem: set folio uptodate when reclaim
>   shmem: check if a block is uptodate before splice into pipe
>   shmem: clear uptodate blocks after PUNCH_HOLE
>   shmem: enable per-block uptodate
>=20
> Pankaj Raghav (1):
>   splice: don't check for uptodate if partially uptodate is impl
>=20
>  fs/splice.c |  17 ++-
>  mm/shmem.c  | 340 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 332 insertions(+), 25 deletions(-)
>=20
> --=20
> 2.43.0=

