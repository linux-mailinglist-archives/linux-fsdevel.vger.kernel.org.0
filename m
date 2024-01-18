Return-Path: <linux-fsdevel+bounces-8233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5CA831304
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 08:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C90B28232D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 07:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D8B641;
	Thu, 18 Jan 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eApEPL3I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA38F60
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561953; cv=none; b=XDy+g0NWZ6g+gaOYbpzlCKGUHZ8I0Ea0R7YqRNJrwj6msV8Xpo6UjyLIjvlkhrt1kuhuXa4Erj1SYie7CsoM3qV3Gs5zoGnDpnpj/pF2iDyFda0Z1fwZjTYlnKGTp8yflviB82l6ZWdHTbgYEdSIuhn0KuUBkpz665sOJZPoPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561953; c=relaxed/simple;
	bh=+ndldX/st2sjnLiMkzNWFl0AgtOt9jiAWnKfij46FUQ=;
	h=Received:DKIM-Filter:DKIM-Signature:Received:Received:Received:
	 Received:X-AuditID:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Originating-IP:
	 X-ClientProxiedBy:X-Brightmail-Tracker:X-Brightmail-Tracker:
	 X-CMS-MailID:X-Msg-Generator:X-RootMTR:X-EPHeader:CMS-TYPE:
	 X-CMS-RootMailID:References; b=sVei2vfkdXGlv+7puhfyBYt+HAMU02wMmWkMB0PTu76piHibQphr+crrYKVaV0+WAHq3Awpr9ApJ65kdi/Al3szkzm9xSiLMl3H7R8RwZVWk6B9Zsu3kCSv6mHeBCjP0xkZdR9Bh76DNk3LexR928v3F+rDDUteHeFGdPlj+beQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eApEPL3I; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240118071229euoutp01f5df0dd93173903cf7636857edd03234~rX45tj5lK2452224522euoutp01i
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 07:12:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240118071229euoutp01f5df0dd93173903cf7636857edd03234~rX45tj5lK2452224522euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705561949;
	bh=+ndldX/st2sjnLiMkzNWFl0AgtOt9jiAWnKfij46FUQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=eApEPL3IPDLgVwq3tIgVRRQMpWMAg0gN8JeAfP8UCE1DnRQ5fHmGi2BifnbRAol1Z
	 4RqRO3NWBWjc+4B06LpFySG0UjDNTC7u6Ersrne7avwXx6sQO6kE63ewYMurVaeS8l
	 1hDzoJQr+3Q9oQsKXCunzSHT7Pxf0UIqFrGGOyWA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240118071228eucas1p171b1b91b48410c6b39693280dd80a72a~rX45e1wYc0829208292eucas1p1X;
	Thu, 18 Jan 2024 07:12:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D6.02.09552.C5FC8A56; Thu, 18
	Jan 2024 07:12:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240118071228eucas1p222bfd790ac1019fbf68a5f2170e663e1~rX45CK0Rw2641626416eucas1p2w;
	Thu, 18 Jan 2024 07:12:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240118071228eusmtrp25486a22febedbc9aba939cbaea7e9110~rX45BOZ961566915669eusmtrp2W;
	Thu, 18 Jan 2024 07:12:28 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-68-65a8cf5cc9ab
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 68.10.09146.C5FC8A56; Thu, 18
	Jan 2024 07:12:28 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240118071228eusmtip270875b1c152bce150956677843a96e5e~rX44z2cUf2497324973eusmtip2l;
	Thu, 18 Jan 2024 07:12:28 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 18 Jan 2024 07:12:27 +0000
Date: Thu, 18 Jan 2024 08:12:25 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Dave Chinner <david@fromorbit.com>
CC: Viacheslav Dubeyko <slava@dubeyko.com>,
	<lsf-pc@lists.linux-foundation.org>, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
	<linux-scsi@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, <slava@dubeiko.com>, Kanchan Joshi
	<joshi.k@samsung.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Message-ID: <20240118071225.7ioz3h2eewdgm2sb@ArmHalley.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZahL6RKDt/B8O2Jk@dread.disaster.area>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7ox51ekGuw+p2cx7cNPZostx+4x
	Wuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaLT5cXAokts5kcOD0uX/H2ePTkIKvHwfVvWDxO
	LZLw2Lyk3mPyjeWMHp83yQWwR3HZpKTmZJalFunbJXBlvHzTxFhwTqNi7v9JLA2MbxW6GDk5
	JARMJOb2bWPuYuTiEBJYwSjx5/AaFgjnC6PE/T0tTBDOZ0aJK8+vsMG0TPx/jxUisZxRYvvs
	a+xwVeuub4Jq2cooceRjB5DDwcEioCqx9XYGSDebgL3EpWW3mEFsEQE1iUmTdoAtZxb4wiTx
	af5/sHphgRyJ9ineIDW8ArYSJ+a8ZoOwBSVOznzCAmIzC1hJdH5oYgUpZxaQllj+jwMiLC/R
	vHU22HhOAWOJuc/7GEFKJASUJZZP94W4v1bi1JZbYFdKCEzmlGh+eYARIuEi8eP3HHYIW1ji
	1fEtULaMxP+d85kg7GyJi2e6mSHsEonF748xQ8y3lug7kwMRdpQ4dGcn1Fo+iRtvBSEu45OY
	tG06VDWvREeb0ARGlVlI3pqF5K1ZCG/NQvLWAkaWVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ
	+bmbGIHp6fS/4193MK549VHvECMTB+MhRgkOZiURXn+DZalCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTGm//jhd3chqdPz3reWGx6pOxS/0XWz2K+DL
	d8u36VYLUu43O/+LS+M69ntOnOwf7x+ZWyfN+stevXHOp99f7HlyIyY9jbr5lyuDpaD6fO+Z
	OunQz4F6Dz2mND1zOik19/zi8y41P6NY4nxUGdr8luXMvWnMubBW012BOajl6KYlXS/yiz8o
	3fycvPHJZfM/V1i6bPVjdA8eyWubu/SkWUCC7hPDALeE+OhNdX9U1AwfL/i+qdr7wKE5yhfU
	de8m+XYKPoi5qDohKOVSbUp0zaS/aZM/HXiyd/WF3+dOr/N9yHxKk+ds2GSdVUumOXILTGUS
	2DTPMkLK1tp7KafnWWWHVbULD7rzHfRwVXjA5aHEUpyRaKjFXFScCACwyImCvgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7ox51ekGmzrE7OY9uEns8WWY/cY
	Lfbe0rbYs/cki8X8ZU/ZLbqv72Cz2Pd6L7PFp8sLgcSW2UwOnB6Xr3h7PHpykNXj4Po3LB6n
	Fkl4bF5S7zH5xnJGj8+b5ALYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
	9O1sUlJzMstSi/TtEvQyXr5pYiw4p1Ex9/8klgbGtwpdjJwcEgImEhP/32PtYuTiEBJYyiix
	Y/9ENoiEjMTGL1dZIWxhiT/Xutggij4ySvQdvArlbGWU2P1+GksXIwcHi4CqxNbbGSANbAL2
	EpeW3WIGsUUE1CQmTdrBDFLPLPCFSeLT/P9MIPXCAjkS7VO8QWp4BWwlTsx5DTXzBpPEpHVf
	2CESghInZz5hAbGZBSwkZs4/zwjSyywgLbH8HwdEWF6ieetssF2cAsYSc5/3gZVICChLLJ/u
	C3F/rcTnv88YJzCKzEIydBaSobMQhs5CMnQBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2M
	wAjeduzn5h2M81591DvEyMTBeIhRgoNZSYTX32BZqhBvSmJlVWpRfnxRaU5q8SFGU2AATWSW
	Ek3OB6aQvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJvc3sarG
	mwq+HYszaD+9a9VzEYera6/y5wWcfXFmf/63V2L3eU+lc2nufVIo9car9fuhC0vlhG+lbumL
	lZqzT7j/x8GA0xf7k5QYVwjotofaqE9MZnnk4jtJzCcopWKu9iYx2e2/a7sD7Cetvecz9UlE
	UljNVRbB+n1GdRfP6a5ZLfGQN+rJ/YOr/X9ckpy/wGPJHZvgjANHtj6Nfy3zIjL83ayFNgy7
	9p1tYW5QVjomMV14T7bXwt2Rmyr7i/j4TvG8uNzAzib2Q3R18KNzkX9cFkvd2PzRd4KV29X6
	z4kc2vIMk+6evmHWxmd/78jEIknmWXY3OJQnJTM6/33AvJqfVT5g/vlQjQMST6bt41JiKc5I
	NNRiLipOBABUHj+2aQMAAA==
X-CMS-MailID: 20240118071228eucas1p222bfd790ac1019fbf68a5f2170e663e1
X-Msg-Generator: CA
X-RootMTR: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
	<20240115084631.152835-1-slava@dubeyko.com>
	<20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
	<86106963-0E22-46D6-B0BE-A1ABD58CE7D8@dubeyko.com>
	<20240117115812.e46ihed2qt67wdue@ArmHalley.local>
	<ZahL6RKDt/B8O2Jk@dread.disaster.area>

On 18.01.2024 08:51, Dave Chinner wrote:
>On Wed, Jan 17, 2024 at 12:58:12PM +0100, Javier González wrote:
>> On 16.01.2024 11:39, Viacheslav Dubeyko wrote:
>> > > On Jan 15, 2024, at 8:54 PM, Javier González <javier.gonz@samsung.com> wrote:
>> > > > How FDP technology can improve efficiency and reliability of
>> > > > kernel-space file system?
>> > >
>> > > This is an open problem. Our experience is that making data placement
>> > > decisions on the FS is tricky (beyond the obvious data / medatadata). If
>> > > someone has a good use-case for this, I think it is worth exploring.
>> > > F2FS is a good candidate, but I am not sure FDP is of interest for
>> > > mobile - here ZUFS seems to be the current dominant technology.
>> > >
>> >
>> > If I understand the FDP technology correctly, I can see the benefits for
>> > file systems. :)
>> >
>> > For example, SSDFS is based on segment concept and it has multiple
>> > types of segments (superblock, mapping table, segment bitmap, b-tree
>> > nodes, user data). So, at first, I can use hints to place different segment
>> > types into different reclaim units.
>>
>> Yes. This is what I meant with data / metadata. We have looked also into
>> using 1 RUH for metadata and rest make available to applications. We
>> decided to go with a simple solution to start with and complete as we
>> see users.
>
>XFS has an abstract type definition for metadata that is uses to
>prioritise cache reclaim (i.e. classifies what metadata is more
>important/hotter) and that could easily be extended to IO hints
>to indicate placement.
>
>We also have a separate journal IO path, and that is probably the
>hotest LBA region of the filesystem (circular overwrite region)
>which would stand to have it's own classification as well.
>
>We've long talked about making use of write IO hints for separating
>these things out, but requiring 10+ IO hint channels just for
>filesystem metadata to be robustly classified has been a show
>stopper. Doing nothing is almost always better than doing placement
>hinting poorly.

I fully agree with the last statement.

In my experience, if doing something, it is probably better to target 2
or 3 data streams that target what you would expect it to be the larger
metric gap (be it data hotness, size, etc).

The difficult thing is identifying these small changes that can bring a
percentage of the benefit without getting into corner cases that take
most of the effort.

>
>> > Technically speaking, any file system can place different types of metadata in
>> > different reclaim units. However, user data is slightly more tricky case. Potentially,
>> > file system logic can track “hotness” or frequency of updates of some user data
>> > and try to direct the different types of user data in different reclaim units.
>
>*cough*
>
>We already do this in the LBA space via the filesytsem allocators.
>It's often configurable and generally called "allocation policies".
>
>> > But, from another point of view, we have folders in file system namespace.
>> > If application can place different types of data in different folders, then, technically
>> > speaking, file system logic can place the content of different folders into different
>> > reclaim units. But application needs to follow some “discipline” to store different
>> > types of user data (different “hotness”, for example) in different folders.
>
>Yup, XFS does this "physical locality is determined by parent
>directory" separation by default (the inode64 allocation policy).
>Every new directory inode is placed in a different allocation group
>(LBA space) based on a rotor mechanism. All the files within that
>directory are kept local to the directory (i.e. in the same AG/LBA
>space) as much as possible.
>
>Most filesystems have LBA locality policies like this because it is
>highly efficient on physical seek latency limited storage hardware.
>i.e. the storage hardware we've mostly been using since the early
>1980s.
>
>We could make allocation groups have different reclaim units,
>but then we are talking about needing an arbitrary number of
>different IO hints - XFS supports ~2^31 AGs if the filesystem is
>large enough, and there's no way we're going to try to support that
>many IO hints (software or hardware) in the foreseeable future.
>
>IF devices want to try to classify related data themselves, then
>using LBA locality internally to classify relationships below the
>level of IO hints, then that would be a much closer match to how
>filesystems have traditionally structured the data and metadata on
>disk. Related data and metadata tends to get written to the same LBA
>regions because that's the fastest way to access related and
>metadata on seek-limited hardware.
>
>Yeah, I know that these are SSDs we are talking about and they
>aren't seek limited, but when we already have filesystem
>implementations that try to clump related things to nearby LBA
>spaces, it might be best to try to leverage this behaviour rather
>than try to rely on kernel and userspace to correctly provide hints
>about their data patterns.

+1

