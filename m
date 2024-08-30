Return-Path: <linux-fsdevel+bounces-28017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2A3966136
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE44B1F26332
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75219993F;
	Fri, 30 Aug 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gbYUKLEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53B19992C
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019159; cv=none; b=ruvJbIxmsWM1lWCWcryEID3L9f5Nr3mTHLccKOLBuaxXq13pBzDESAkFoApekpok2GIfo2lSJIC7m9lI1OAzDT/eIAbYz79TxpRiwjwfTZVOvs+Ag9TZWQaAP9z6k5ZB/EtJaZqRGfAEUINj6zMp18dIotJ+pKD1vr3+6Haqbwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019159; c=relaxed/simple;
	bh=6OgZ8ZtxXt7quQNbv+3H6Meh4CQOGZxgszGMT+sAe0w=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=p/zWhIuAMVct+uvVlPuh58qzfTsPycrziqdH/GDh+Qa/VnMWZtGdhKAjAcaYQPsPqgPmCDJPuA+tdG7bSrwwxDx986hEX9Xv0EiAzApOk2kpmTA1wofremeNtxOEYo4UYFGTnCX7/b6/tDSEQ6Wc+sI9G1PG0aSUzyvSdIMoErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gbYUKLEu; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240830115916euoutp01789927fd9bb5856f46959ab69b7eef38~wf8h1Gw1a2511225112euoutp01a
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 11:59:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240830115916euoutp01789927fd9bb5856f46959ab69b7eef38~wf8h1Gw1a2511225112euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725019156;
	bh=DHfHERZ6en3013iCiK+PboFb1SXkYatz5nFnB7G0GlY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gbYUKLEuEwKPI68ulqU/oAR4XTO9SPNEkHPy+P2ywlsjfpkAsGn/NOSwG6vv6E+5S
	 fNASe1qmB/Y5wYMQZQhUjIQDaXrDJyxdSgON44sS5dJW6Dg7L93dKioAx6i79uIFEs
	 qY/n5ZTa0YeeoVjAxhcq+NCleVZf5lL4ynjng54Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240830115915eucas1p1ec9aa5512061fffdee90f1cdc93ec447~wf8hdiS0U2675426754eucas1p1o;
	Fri, 30 Aug 2024 11:59:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 1D.45.09624.314B1D66; Fri, 30
	Aug 2024 12:59:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240830115915eucas1p122027e15f14938de31489f75c174b1fd~wf8g84L7A1990419904eucas1p1Y;
	Fri, 30 Aug 2024 11:59:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240830115915eusmtrp22562364f0592658a6eaf77b9fcae9cad~wf8g6O6Qc3191831918eusmtrp2T;
	Fri, 30 Aug 2024 11:59:15 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-02-66d1b41327b7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.87.14621.314B1D66; Fri, 30
	Aug 2024 12:59:15 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240830115914eusmtip2c32ae4bfe73d445aa2fd37cd74966ac0~wf8gp-A_b0276402764eusmtip2F;
	Fri, 30 Aug 2024 11:59:14 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 30 Aug 2024 12:59:14 +0100
Date: Fri, 30 Aug 2024 13:59:13 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: <axboe@kernel.dk>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, <martin.petersen@oracle.com>,
	<James.Bottomley@HansenPartnership.com>, <brauner@kernel.org>,
	<jack@suse.cz>, <jaegeuk@kernel.org>, <jlayton@kernel.org>,
	<chuck.lever@oracle.com>, <bvanassche@acm.org>,
	<linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <gost.dev@samsung.com>, <vishak.g@samsung.com>
Subject: Re: [PATCH v4 0/5] Write-placement hints and FDP
Message-ID: <20240830115913.b5pcs7bo26wkj2it@ArmHalley.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20240826170606.255718-1-joshi.k@samsung.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87rCWy6mGcz4qGOx+m4/m8Xrw58Y
	LaZ9+Mls8f/ucyaLlauPMlnMnt7MZPFk/Sxmi439HBY/l61it5h06Bqjxd5b2haXFrlb7Nl7
	ksVi/rKn7Bbd13ewWSw//o/JYt3r9ywOgh6Xr3h7nL+3kcVj2qRTbB6Xz5Z6bFrVyeaxeUm9
	x+4Fn5k8dt9sYPP4+PQWi8eZBUfYPT5vkgvgjuKySUnNySxLLdK3S+DKeLrkA2PBD+GK1nst
	TA2MZ/i7GDk5JARMJJ62/mHrYuTiEBJYwSjx7ehlVgjnC6PE8hsTmSCcz4wSby5OYYFpOXV+
	AlRiOaPE0Ts/WeCqll7ZCzVsC6PE3r71QBkODhYBVYknu7NButkE7CUuLbvFDGKLCKhLdEw/
	BzaJWeAvs0TL9DPsIAlhAUuJQ2ffsoLYvAK2EtMnbGCGsAUlTs58AnYGs4CVROeHJlaQ+cwC
	0hLL/3GAhDmBwv8/vGeHuFRJ4vGLt4wQdq3EqS23wHZJCNzilFh29wYbRMJF4tzU98wQtrDE
	q+NboJplJP7vnM8EYVdLNJw8AdXcwijR2rEVbLGEgLVE35kciBpHiYlLD0OF+SRuvBWEOJNP
	YtK26cwQYV6JjjYhiGo1idX33rBMYFSeheSxWUgem4Xw2AJG5lWM4qmlxbnpqcWGeanlesWJ
	ucWleel6yfm5mxiBCfD0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd4Tx8+mCfGmJFZWpRblxxeV
	5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTD57XcxmrmxRlF3Cm/bdym9K5xx
	uyZczfgV9ccp+eL9x+bby0zf75Gp12M1DN4+O8zgo2Ng+qNP9XU7ZztL/HP5fv6zXtLPRXNN
	3ypUOgpsvnl/p7Z5s5h/2ZQDfj9SN07UVCjfsTFn0tLTPVNzS/lFvaw6cu2dz6d/Z3Q9e83t
	qOfnVWt1Gxyl/h3/EyQ1vYPli3x7bNRTlciyt4nz3EyMg5YrKX7317jKKKJ2oDe8QnjPqXiD
	o+ma2zi5849aJTo4+5/7riei+Wb6iymKjT940hPfxD9tOn1O999y8xWyIg0PJt3aUMvXr2M9
	5XD9B/sf+6tSC5MEfur2l5UUiqc789i+vdDILXwtRVtHVImlOCPRUIu5qDgRAOixgofvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xe7rCWy6mGbSvZrNYfbefzeL14U+M
	FtM+/GS2+H/3OZPFytVHmSxmT29msniyfhazxcZ+Doufy1axW0w6dI3RYu8tbYtLi9wt9uw9
	yWIxf9lTdovu6zvYLJYf/8dkse71exYHQY/LV7w9zt/byOIxbdIpNo/LZ0s9Nq3qZPPYvKTe
	Y/eCz0weu282sHl8fHqLxePMgiPsHp83yQVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY
	6hkam8daGZkq6dvZpKTmZJalFunbJehlPF3ygbHgh3BF670WpgbGM/xdjJwcEgImEqfOT2Dq
	YuTiEBJYyigx4cY0doiEjMTGL1dZIWxhiT/Xutggij4ySryfdI0FwtnCKPF2/lqgKg4OFgFV
	iSe7s0Ea2ATsJS4tu8UMYosIqEt0TD8HtoFZ4DezxO7pa1lAEsIClhKHzr4F28ArYCsxfcIG
	ZoihvYwSq4/3s0EkBCVOznwC1sAsYCExc/55RpBlzALSEsv/cYCEOQWsJP5/eA91tZLE4xdv
	GSHsWonPf58xTmAUnoVk0iwkk2YhTFrAyLyKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMBFs
	O/Zz8w7Gea8+6h1iZOJgPMQowcGsJMJ74vjZNCHelMTKqtSi/Pii0pzU4kOMpsCgmMgsJZqc
	D0xFeSXxhmYGpoYmZpYGppZmxkrivG6Xz6cJCaQnlqRmp6YWpBbB9DFxcEo1MB1ab56TYjb3
	p9L1OboiyyKulM9afpV97sojyRqSmy8HbrEyfy1pHK/5+Itk7enID9uaWgr8VZdf3KT703S6
	snSV6Zk7Bw/UzZwhIzDP9uc85vXXvm/Xy1z2+k/axeXd/32VV1zkO6/P+tltbmLK0VMt21IL
	FFjk/SJOV0hUclknNC7u/mGmsGCS+RuO3s0+rAt0hHnXX2WzyZl/f7dc56oND3dPUK6Q+jpx
	rvKlNxEqx63ys9a9Kjjnv2OSYK+OVpOWW18QV3UIU4ELb4eDiubMafu+JoofXtHtqLLuaoKZ
	hqWSRf2v/qatHY1iz+cLPH33uHD25/LDyyr1fxVvZ6+r2rx+65l/P3Pm+HxcFqTEUpyRaKjF
	XFScCAAvKmsHjQMAAA==
X-CMS-MailID: 20240830115915eucas1p122027e15f14938de31489f75c174b1fd
X-Msg-Generator: CA
X-RootMTR: 20240826171409epcas5p306ba210a9815e202556778a4c105b440
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826171409epcas5p306ba210a9815e202556778a4c105b440
References: <CGME20240826171409epcas5p306ba210a9815e202556778a4c105b440@epcas5p3.samsung.com>
	<20240826170606.255718-1-joshi.k@samsung.com>

On 26.08.2024 22:36, Kanchan Joshi wrote:
>Current write-hint infrastructure supports 6 temperature-based data life
>hints.
>The series extends the infrastructure with a new temperature-agnostic
>placement-type hint. New fcntl codes F_{SET/GET}_RW_HINT_EX allow to
>send the hint type/value on file. See patch #3 commit description for
>the details.
>
>Overall this creates 128 placement hint values [*] that users can pass.
>Patch #5 adds the ability to map these new hint values to nvme-specific
>placement-identifiers.
>Patch #4 restricts SCSI to use only life hint values.
>Patch #1 and #2 are simple prep patches.
>
>[*] While the user-interface can support more, this limit is due to the
>in-kernel plumbing consideration of the inode size. Pahole showed 32-bit
>hole in the inode, but the code had this comment too:
>
>/* 32-bit hole reserved for expanding i_fsnotify_mask */
>
>Not must, but it will be good to know if a byte (or two) can be used
>here.
>
>Changes since v3:
>- 4 new patches to introduce write-placement hints
>- Make nvme patch use the placement hints rather than write-life hints
>
>Changes since v2:
>- Base it on nvme-6.11 and resolve a merge conflict
>
>Changes since v1:
>- Reduce the fetched plids from 128 to 6 (Keith)
>- Use struct_size for a calculation (Keith)
>- Handle robot/sparse warning
>
>Kanchan Joshi (4):
>  fs, block: refactor enum rw_hint
>  fcntl: rename rw_hint_* to rw_life_hint_*
>  fcntl: add F_{SET/GET}_RW_HINT_EX
>  nvme: enable FDP support
>
>Nitesh Shetty (1):
>  sd: limit to use write life hints
>
> drivers/nvme/host/core.c   | 81 ++++++++++++++++++++++++++++++++++++++
> drivers/nvme/host/nvme.h   |  4 ++
> drivers/scsi/sd.c          |  7 ++--
> fs/buffer.c                |  4 +-
> fs/f2fs/f2fs.h             |  4 +-
> fs/f2fs/segment.c          |  4 +-
> fs/fcntl.c                 | 79 ++++++++++++++++++++++++++++++++++---
> include/linux/blk-mq.h     |  2 +-
> include/linux/blk_types.h  |  2 +-
> include/linux/fs.h         |  2 +-
> include/linux/nvme.h       | 19 +++++++++
> include/linux/rw_hint.h    | 20 +++++++---
> include/uapi/linux/fcntl.h | 14 +++++++
> 13 files changed, 218 insertions(+), 24 deletions(-)
>
>-- 
>2.25.1
>

Keith, Christoph, Martin

Does this approach align with the offline conversation we had arund FMS?
Comments on the list would help us move forward with this series.

We would like to move the folks that are using off-tree patches for FDP
to mainline support.

Thanks,
Javier

