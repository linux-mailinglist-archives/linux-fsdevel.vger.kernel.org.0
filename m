Return-Path: <linux-fsdevel+bounces-13100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E6086B3B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53381C26280
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20A15D5CF;
	Wed, 28 Feb 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GeNE0TGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE415D5AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135422; cv=none; b=qzRpGWi8zCchLMVCclzvplZdMoLJCW5+dyLq98mCTWD1GDb/jGHPi8t6FqBhGXOXQzOvfOW8egJkAMUEgDJSWb9akmJqZQCsnyAhZTFK5/NCrRX3Zlx4WBbMSJtpUJHAFc6yX0HJudnJv8jQihZyS5l8mjT5JWBZjmEDYqhOGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135422; c=relaxed/simple;
	bh=87JHNQZaA9y17Sa7HpJjvpiSvH9z/gQYfQrrCqUQphA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=as1OKTbsfm8la+b10cK7AciLysmTQhR1FdN4CcA8RG6mkOKWqdO6cBaWVbhgyQV15Beke8QuAIgZP5hB3xoVQmbOZmzHDLYLoV/E32b4RFzL9LqwhkoBE0hyRwmzKB4Vk4CfDH/PCDxjGyj18AkfYaKR2P7DqQzTRDYbuPQexlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GeNE0TGA; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240228155011euoutp0172fe3b7ced856c434ff7f5a717d85ceb~4EZnmL6pW2934729347euoutp01h
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 15:50:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240228155011euoutp0172fe3b7ced856c434ff7f5a717d85ceb~4EZnmL6pW2934729347euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709135411;
	bh=zJQNDKkL21r6aqDh+Pd7p8kIqJDT8RuvNrtky0wFojU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=GeNE0TGAF3F1I64PWxLS+Cnt2s8Ki49LWyBg5eQR5OoVBb1MjrXLIZ8j9dS0WWcNs
	 /uieBjYx2+8wp9W2IDMsDyipLYe+MPetV4cJGO3xuWEEHTqhe9NWTcLj4MQT3IWnQu
	 vSjTr5luyhC7SXokii9y5Tva/g/pwKWZq5t2fUNQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240228155010eucas1p208db80ff52de37bfee321a2d5fd008c0~4EZnPxfO62088320883eucas1p2J;
	Wed, 28 Feb 2024 15:50:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 13.4B.09814.2365FD56; Wed, 28
	Feb 2024 15:50:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240228155010eucas1p2806c87bd10048751fc10b0208d1c9ba7~4EZmtgReR2969229692eucas1p2m;
	Wed, 28 Feb 2024 15:50:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240228155010eusmtrp1e464ab5e705be901da71fd784de2e04d~4EZmsu7S21793817938eusmtrp1S;
	Wed, 28 Feb 2024 15:50:10 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-6f-65df5632106c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 77.94.09146.2365FD56; Wed, 28
	Feb 2024 15:50:10 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240228155010eusmtip1a777fa7a10cfd8ede49aa8efc6099de7~4EZmhlrUS2327423274eusmtip1B;
	Wed, 28 Feb 2024 15:50:10 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Wed, 28 Feb 2024 15:50:09 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Wed, 28 Feb
	2024 15:50:09 +0000
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
Thread-Index: AQHaW2RT7xV/K52STUGwCHRBbQ9MBbEKRvYAgAc7d4CAAZVngIAAJPeAgArwXwCAAdelgA==
Date: Wed, 28 Feb 2024 15:50:08 +0000
Message-ID: <ffp7bvnaa3qxjdc54gj3tlhgryctyguzzcax7kqnh7tumotqet@4rjsmb2zos5i>
In-Reply-To: <elozg4pnyccaxmbb2nde3brtm32jko56e4mydxx53srze4zkcv@hukwjfblnjlo>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEF626806C9A2D44A5F46ACC9A220D18@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djPc7pGYfdTDRY8NbKYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjOKySUnN
	ySxLLdK3S+DKuHjuEGPBAdmK9b2rWBsYN4p3MXJySAiYSPR3nmLvYuTiEBJYwShxfMEJVgjn
	C6PE/SPf2CCcz4wSy/qnM8G0bJ+wixEisZxRYsvtn4xwVW1LvzFDOGeA+tv+QDkrGSUaP35k
	BelnE9CU2HdyEzuILSIgLTHr2EoWkCJmgU8sEt1zVoMtERawljh1eBYjRJGNxKaGZiYIO0zi
	S1cvM4jNIqAq0XnzMQuIzSvgKzFr1xywBZwCfhIbO9vAahgFZCUerfwFtoxZQFzi1pP5UE8I
	SiyavYcZwhaT+LfrIRuErSNx9voTRgjbQGLr0n0sELayxKtF7YwQc3QkFuz+xAZhW0rc+TId
	ar62xLKFr5kh7hGUODnzCdhjEgIzuSQeflsMtdhFYt+zx1C2sMSr41vYJzDqzEJy3ywkO2Yh
	2TELyY5ZSHYsYGRdxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZj+Tv87/mUH4/JXH/UO
	MTJxMB5ilOBgVhLhlRG8myrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUg
	tQgmy8TBKdXA5P1ljfKu5OeyIluau1imG4vlz5xaGf00ZqvLkTu6XN+bbAusGf3fL2Vacvv1
	/LbibB9b0Tx+b7P2kLMiZ0NE80/fUHylcPeKsIfiJN8lky8yG0qknVBQmeG/PVShvuVh50WN
	5Z4RJ19am/GLnlrNnqXVYtQjtPWASlLbJ4WSgrXbVm7W1P1zSEW3xnTJ9JX9ep83M8u0PX0v
	Xea2rHxOyzTTj+dnGS1e9sjzi8nlPo/pLntXHYtX95j59VCeGZ9gnuXVoyphx87fCMmdsJaj
	9VptfasxxyU77V3rz+Rv+bJOXP/T711tbTN33VPLOWYSbLE4onqZacWqvu038heVr8rXkv4q
	J/Jp9d3Ik0JdSizFGYmGWsxFxYkAJkpaMO4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsVy+t/xu7pGYfdTDU5N5beYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjNKzKcov
	LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuHjuEGPBAdmK
	9b2rWBsYN4p3MXJySAiYSGyfsIuxi5GLQ0hgKaPEwredjBAJGYmNX66yQtjCEn+udbFBFH1k
	lPjx/zUThHOGUeLLqw6ozEpGiQVvfjGBtLAJaErsO7mJHcQWEZCWmHVsJQtIEbPAJxaJ7jmr
	wYqEBawlTh2exQhRZCOxqaGZCcIOk/jS1csMYrMIqEp03nzMAmLzCvhKzNo1hxVi205miQvb
	f4E1cwr4SWzsbANrYBSQlXi08hfYZmYBcYlbT+YzQTwhILFkz3lmCFtU4uXjf1DP6Uicvf4E
	6mkDia1L97FA2MoSrxa1M0LM0ZFYsPsTG4RtKXHny3So+doSyxa+ZoY4TlDi5MwnLBMYZWYh
	WT0LSfssJO2zkLTPQtK+gJF1FaNIamlxbnpusaFecWJucWleul5yfu4mRmBq23bs5+YdjPNe
	fdQ7xMjEwXiIUYKDWUmEV0bwbqoQb0piZVVqUX58UWlOavEhRlNg4E1klhJNzgcm17ySeEMz
	A1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBiamuxNXNZ16/mOS5LavIRU9
	qqmebhd0N2os3vw9PoUzczMTE/OuNtZpnrdFo3gmavezp5luFW04lcPZyflR7I8Tfw6f6xRd
	7YkTD7n8rJzykvPPJ32efe0fvm990tJfLL6Xt+DxzeYKEVERM8XyM9Nrqn8b/mX0vrbm4ZpJ
	HxN+bt9+Tid/5nmeJWHBX123rKtrL+C+4HB8wjX/78Kad/mef1Z5a7dtgtakz5LXpulpp0Va
	85xUtlx78JKP3/3jwbuYJSPlJa7WsTZquSieUj89c959xmxRpXnCN6rlNt7rdshk3dtluek9
	W0Qyl6L9hLnRj+IFuX7aXLi74k3zulb+S9LxXkvk7TtcFvkxTldiKc5INNRiLipOBADHHA3F
	9gMAAA==
X-CMS-MailID: 20240228155010eucas1p2806c87bd10048751fc10b0208d1c9ba7
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
	<elozg4pnyccaxmbb2nde3brtm32jko56e4mydxx53srze4zkcv@hukwjfblnjlo>

On Tue, Feb 27, 2024 at 11:42:01AM +0000, Daniel Gomez wrote:
> On Tue, Feb 20, 2024 at 01:39:05PM +0100, Jan Kara wrote:
> > On Tue 20-02-24 10:26:48, Daniel Gomez wrote:
> > > On Mon, Feb 19, 2024 at 02:15:47AM -0800, Hugh Dickins wrote:
> > > I'm uncertain when we may want to be more elastic. In the case of XFS=
 with iomap
> > > and support for large folios, for instance, we are 'less' elastic tha=
n here. So,
> > > what exactly is the rationale behind wanting shmem to be 'more elasti=
c'?
> >=20
> > Well, but if you allocated space in larger chunks - as is the case with
> > ext4 and bigalloc feature, you will be similarly 'elastic' as tmpfs wit=
h
> > large folio support... So simply the granularity of allocation of
> > underlying space is what matters here. And for tmpfs the underlying spa=
ce
> > happens to be the page cache.
>=20
> But it seems like the underlying space 'behaves' differently when we talk=
 about
> large folios and huge pages. Is that correct? And this is reflected in th=
e fstat
> st_blksize. The first one is always based on the host base page size, reg=
ardless
> of the order we get. The second one is always based on the host huge page=
 size
> configured (at the moment I've tested 2MiB, and 1GiB for x86-64 and 2MiB,=
 512
> MiB and 16GiB for ARM64).

Apologies, I was mixing the values available in HugeTLB and those supported=
 in
THP (pmd-size only). Thus, it is 2MiB for x86-64, and 2MiB, 32 MiB and 512 =
MiB
for ARM64 with 4k, 16k and 64k Base Page Size, respectively.

>=20
> If that is the case, I'd agree this is not needed for huge pages but only=
 when
> we adopt large folios. Otherwise, we won't have a way to determine the st=
ep/
> granularity for seeking data/holes as it could be anything from order-0 t=
o
> order-9. Note: order-1 support currently in LBS v1 thread here [1].
>=20
> Regarding large folios adoption, we have the following implementations [2=
] being
> sent to the mailing list. Would it make sense then, to have this block tr=
acking
> for the large folios case? Notice that my last attempt includes a partial
> implementation of block tracking discussed here.
>=20
> [1] https://lore.kernel.org/all/20240226094936.2677493-2-kernel@pankajrag=
hav.com/
>=20
> [2] shmem: high order folios support in write path
> v1: https://lore.kernel.org/all/20230915095042.1320180-1-da.gomez@samsung=
.com/
> v2: https://lore.kernel.org/all/20230919135536.2165715-1-da.gomez@samsung=
.com/
> v3 (RFC): https://lore.kernel.org/all/20231028211518.3424020-1-da.gomez@s=
amsung.com/
>=20
> >=20
> > > If we ever move shmem to large folios [1], and we use them in an opor=
tunistic way,
> > > then we are going to be more elastic in the default path.
> > >=20
> > > [1] https://lore.kernel.org/all/20230919135536.2165715-1-da.gomez@sam=
sung.com
> > >=20
> > > In addition, I think that having this block granularity can benefit q=
uota
> > > support and the reclaim path. For example, in the generic/100 fstest,=
 around
> > > ~26M of data are reported as 1G of used disk when using tmpfs with hu=
ge pages.
> >=20
> > And I'd argue this is a desirable thing. If 1G worth of pages is attach=
ed
> > to the inode, then quota should be accounting 1G usage even though you'=
ve
> > written just 26MB of data to the file. Quota is about constraining used
> > resources, not about "how much did I write to the file".
>=20
> But these are two separate values. I get that the system wants to track h=
ow many
> pages are attached to the inode, so is there a way to report (in addition=
) the
> actual use of these pages being consumed?
>=20
> >=20
> > 								Honza
> > --=20
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR=

