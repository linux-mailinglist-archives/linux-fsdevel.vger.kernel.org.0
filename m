Return-Path: <linux-fsdevel+bounces-44693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC14A6B6C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 10:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F79481AF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76231F0E4D;
	Fri, 21 Mar 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="og2LnBpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9861EFFAF
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548504; cv=none; b=FvhwZu7rkpFpG8fii89i1IKGIBcuAc2BvzRr0wP1cgMT661OK7eaEuotnzqJqOKq6izDtcIZtFOSrt1qjdmSpCXHSK82wQDwJV05rZFXuFilHbtuFd7CcndIiMEClIoHUzYdLCgBOHjWmBvbEdOrb4PlUXhRg89TI65nJqAEwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548504; c=relaxed/simple;
	bh=0XSypQ5zRR54q/OOeGDMZkZ6sir/ql/w23CFHOCrSDk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=LI4TStsROC/XxX04MzDUK43u0d6+DPmonAXIFSMGIYM6D8L903+0UkshlaMP+RsyeLhIDqufm+aO/SQMiaJoXIXAiwVO/NUP65av55ml1LRxEngy/j9MIyFas53UjaEBER98O5xmWOkGj8gyyNeymt4r7zeIelkg0FCoLaHIfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=og2LnBpv; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250321091500euoutp02865cd6c19a7b7c0780131ca598931196~uxqDyW5yA2984429844euoutp02r
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 09:15:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250321091500euoutp02865cd6c19a7b7c0780131ca598931196~uxqDyW5yA2984429844euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742548500;
	bh=kNAM1R1HcAsH6Vhbw1Rvoo09UepNnwwrLKDhYROZtMs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=og2LnBpvtYUY/ZknVs6KONvWUXuUdOrDz1tKHxNH9BHJoutvdNryp8vPhK9KlzF2Y
	 BzE5BzUY8Evo2Cj6n4ZxUudWXgU7dwSIgmH5QxQIkyKyBkV75/PbsJ8pYHjP2iyJS+
	 2boBQI0Hz4wDf4L9qOujjl7QMDV8QZpUic0j38Cc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250321091459eucas1p161e141aa7326845f1bd9e2d2345d072a~uxqDVWd-U0991209912eucas1p1I;
	Fri, 21 Mar 2025 09:14:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 3A.DA.20821.31E2DD76; Fri, 21
	Mar 2025 09:14:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250321091459eucas1p2e32e6d201c819fdcfcc04ec5988bf5fa~uxqCrjfcY1991019910eucas1p2D;
	Fri, 21 Mar 2025 09:14:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250321091459eusmtrp21e04f8d44751e75c856195435f1ee123~uxqCqsEIf3051730517eusmtrp2N;
	Fri, 21 Mar 2025 09:14:59 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-80-67dd2e13770f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B8.FA.19654.31E2DD76; Fri, 21
	Mar 2025 09:14:59 +0000 (GMT)
Received: from CAMSPWEXC02.scsc.local (unknown [106.1.227.4]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250321091458eusmtip224f3efd4955992c1c0175a9ab9d54c60~uxqCdXX4I2797827978eusmtip2h;
	Fri, 21 Mar 2025 09:14:58 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSPWEXC02.scsc.local
	(106.1.227.4) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.40; Fri, 21 Mar
	2025 09:14:58 +0000
Date: Fri, 21 Mar 2025 10:14:58 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Daniel Gomez <da.gomez@kernel.org>, Luis Chamberlain
	<mcgrof@kernel.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-block@vger.kernel.org>, <lsf-pc@lists.linux-foundation.org>,
	<david@fromorbit.com>, <leon@kernel.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <axboe@kernel.dk>, <joro@8bytes.org>,
	<brauner@kernel.org>, <hare@suse.de>, <willy@infradead.org>,
	<djwong@kernel.org>, <john.g.garry@oracle.com>, <ritesh.list@gmail.com>,
	<p.raghav@samsung.com>, <gost.dev@samsung.com>
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <20250321091458.rpnwezqjb2t7lwhy@AALNPWDAGOMEZ1.aal.scsc.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320145449.GA14191@lst.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (106.1.227.71) To
	CAMSPWEXC02.scsc.local (106.1.227.4)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTVxjfuff29rZJ8drWeYDOxBrJgFnxNU6c2zRblquYZdP9sTFfRe+K
	Aar2tviMY06x4gxSiUoVh408BAFbgYCUoi0PARFjDYK1TA0khKqMwjasSEe5LPO/3+v7zvdL
	DoVLXwgiqJ1aPavTqlOVpJioaXl9b5FM5dXEXa5chMq82STyufwAvT2bgqpa+gBy94chu8WE
	oatlzRi6H6gF6MSF60JkcnYDlBsoxFHD41hkb2gjUN+1oAA5fA046jk9ANDtdqMQVfiGCfRm
	/CK5Wsb0376EMe0WyNSZvUKmq89KMDdKYhh3p4GxlZ4gGZvfJGTO9BQDpr43g2RGBh5PBToO
	MqO2ed9IEsWrdrCpO9NZ3eLPtomTR4/lC3Y7xPueWsdBBsimsgBFQXo5fFXOZgExJaVLAKwP
	Vgh4MgZgb7+F5MkogM67g1OOaHpiosMzYxQDWJ0zgvPED+Bwlgvw5BmAF12/YaFHCHohzBib
	FZom6WjoaLMJQ1hOK+HAUOd0HqePErCrbJQMGTJ6HXww3DiNJXQCPOXLxHg8G7bl9RMhjNMf
	wYJ6Pxnaj9ORsHiSCsmiKfl5UaWQv3Q+PJ9zleB7JsFfBqd7QtovgvbWgJDXv4SFvpV8XAaH
	WqtmRhUwWPc7xuMU2PmPHfBYDyf/DBA8/gQGy70z+hpYm/tEwK8Mgz0vZ/NHhkFTzTmclyXQ
	mCnl01GwrO8FcRosML9Ty/xOLfP/tQoAXgrmsgYuTcNyS7TsXhWnTuMMWo1q+640G5j6kB2T
	rf5akD80onICjAJOAClcKZfIjR6NVLJDvf8Aq9u1VWdIZTkniKQI5VyJpfGYRkpr1Ho2hWV3
	s7r/XIwSRWRg+enxsV/9qBgcqv7i+KpIiStHpM+OeeiOj1lesPRjeRJzjbOS5d41yOqa83Zj
	V15cTdgRh2Gh1l2nftP9w9mTdU0lfzg2F5WAI/M2hPfkzu9WBNq/l21VfG0/rGmJqHjvjuiD
	Z7Oo4/cyG3M3rPiWM8YZ89dvwj9MvbMyYVtjeF7CRHO0uffRmJvDSO5mIM1zaMvnzGSi+rLW
	a0rX/Sw5E33pVzoqztL8UrFxde/5TQderdOPH0rcXIo/lY4Xva6S3xJVpuc4kh9lNZ2MTTr4
	01/VV0a2xNuTo5KQPuo74BkTPlQV7rFeXxZ+9P1Pr5yK/FumlzNNEwFqcE/w8F1PwtoCJcEl
	q5fE4DpO/S+PVpdN/wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e/4PV1hvbvpBse62CxW3+1ns3h9+BOj
	xd9p2RZbjt1jtLj8hM9iz6JJTBYrVx9lsrjwawejRefsDewWkw5dY7SY8msps8XeW9oWe/ae
	ZLG4t+Y/q8W+13uZLW5MeMpocfBUB7vFutfvWSx+/5jD5iDs8eTgPCaPU4skPHbOusvucf7e
	RhaPzSu0PC6fLfXYtKqTzWPTp0nsHpNvLGf02H2zgc3j49NbQAWnqz0+b5IL4I3SsynKLy1J
	VcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/jcOpe1YB9XxYON
	PxgbGPs5uhg5OSQETCT+nL7N1sXIxSEksJRR4ljvBRaIhIzExi9XWSFsYYk/17rYQGwhgQ+M
	Ekf/q0PYDxklfp/L6GLk4GARUJVo+MIPEmYT0JTYd3ITO4gtIqAk8fTVWUaQ+cwCLSwSp9ZP
	YwRJCAt4SVx6vx9sJq+At0Tv6zYmiCPeM0psenURKiEocXLmE7CDmAV0JBbs/sQGsoxZQFpi
	+T+wBziBwo+WrWeHuFNRYsbElVD3J0kcbZ7HOoFReBaSSbOQTJqFMGkBI/MqRpHU0uLc9Nxi
	I73ixNzi0rx0veT83E2MwFSx7djPLTsYV776qHeIkYmD8RCjBAezkgivSMftdCHelMTKqtSi
	/Pii0pzU4kOMpsCgmMgsJZqcD0xWeSXxhmYGpoYmZpYGppZmxkrivGxXzqcJCaQnlqRmp6YW
	pBbB9DFxcEo1MDksEmWauj3I+5PTjl/pf1V93Kzr+kz27J0lUuO+1FNtQdOZTfnPt0xJMVTS
	bd+5rUCYx/a758SHTJHfmdcbPN146PkTvs/rjxjIWl/YsaHhiN7jhB8rbpcYF68579Pc8Fjj
	v8eTHwZi16XWy006smVq8h+9cNG1C08u2PfJYUeyZnjMISb1XbrHv7Muqerj414RZa2SePNi
	4JO+qCjuu5Oz9z+4tGuSXDpzlKCwksWFPRsWWk/fM03O6cvvT1XmlbJG705kTE/MzT4dtMXe
	88+3xuMbyu71u7Ptbtx3SXNFINMnv4WCqh8TXvUVfluvW9r0k9dm/TYhnc2Tqj/xPkvKj6nl
	zO2376rRzeD6HqLEUpyRaKjFXFScCACniP5TngMAAA==
X-CMS-MailID: 20250321091459eucas1p2e32e6d201c819fdcfcc04ec5988bf5fa
X-Msg-Generator: CA
X-RootMTR: 20250320145500eucas1p121d971c1fae20628b9716bbac197d84f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250320145500eucas1p121d971c1fae20628b9716bbac197d84f
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
	<ijpsvpc5xgd52r3uu3ibkjcyqzl6edke6fbotj7zf2wbw5vrqb@zzr274ln4tjd>
	<CGME20250320145500eucas1p121d971c1fae20628b9716bbac197d84f@eucas1p1.samsung.com>
	<20250320145449.GA14191@lst.de>

On Thu, Mar 20, 2025 at 03:54:49PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 20, 2025 at 02:47:22PM +0100, Daniel Gomez wrote:
> > On Thu, Mar 20, 2025 at 04:41:11AM +0100, Luis Chamberlain wrote:
> > > We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> > > This is due to the number of DMA segments and the segment size. With LBS the
> > > segments can be much bigger without using huge pages, and so on a 64 KiB
> > > block size filesystem you can now see 2 MiB IOs when using buffered IO.
> > 
> > Actually up to 8 MiB I/O with 64k filesystem block size with buffered I/O
> > as we can describe up to 128 segments at 64k size.
> 
> Block layer segments are in no way limited to the logical block size.

You are right but that was not what I meant. I'll use a 16 KiB fs
example as with 64 KiB you hit the current NVMe 8 MiB driver limit
(NVME_MAX_KB_SZ):

"on a 16 KiB block size filesystem, using buffered I/O will always allow
at least 2 MiB I/O, though higher I/O may be possible".

And yes, we can do 8 MiB I/O with direct I/O as well. It's just not
reliable unless huge pages are used. The maximum reliable supported I/O
size is 512 KiB.

With buffered I/O, a larger fs block size guarantees a specific upper
limit, i.e 2 MiB for 16 KiB, 4 MiB for 32 KiB and 8 MiB for 64 KiB.

