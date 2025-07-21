Return-Path: <linux-fsdevel+bounces-55561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64622B0BF26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B2B17D7C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6161B2882C4;
	Mon, 21 Jul 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lRB2y0Gv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A7280A35
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087030; cv=none; b=B+UK6pLmU6R+cDP/+6C3Lj86LBb1x2n/2J9+DieMt/NQRGuh93bi/nIHCO7/KTD9/80Yzyzh+py+TZ5JH6X+sxPGMJdPGLtozABD+3UPxWtigX/eYf4LUZfy2L/1n1Xy0K84YLpPBjRjs2f1R5xZPigvLU7u/a4ftqpfAltqywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087030; c=relaxed/simple;
	bh=Rl1YOas+fgdSq/Kvz1mZmGoA1VVRBztEtrYFaM8Wj+Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=p46N/C/FsLqsEqUphRHYxauidX8r8vidhUt5SW2uArG6w8ib9ecPb2vsoKsN0jcBtWQRZ9rKpxGlfQxWigY5oI+DdctqkNpIdHyBGimxQkRjUNO6DG9Ma0mLtOywOUWEBiLEzdiDzbKhVm37V4jl1IFyy39m20kHhDh0JQE2v6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lRB2y0Gv; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250721083706epoutp049dcea9d620ac93a220331dc97d9aba2a~UN1zGv0Tt0999909999epoutp043
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 08:37:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250721083706epoutp049dcea9d620ac93a220331dc97d9aba2a~UN1zGv0Tt0999909999epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753087026;
	bh=YG4PKzlB/k2XkqqC2Fwg1WOfj+qB+gJoAcf5VPjR4+U=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lRB2y0GvimRKVWaKamok++pKVj5e28SutJY7wV34/xAvQ9YesFbDN2mol+rIhOW/n
	 5dPU3YSpoDgH1cD70AIPf+KTNgITzTT4GXITt/MA0gXvEHyOMNiD7HB2T2GHHt0gHA
	 Ihblk1X8gHPnhAMEzgEkevl5euvQ0AC86pBSDqIw=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250721083705epcas2p1ef23d8a6ab218eff2aecac29da62ea1d~UN1yixB0L0843808438epcas2p1U;
	Mon, 21 Jul 2025 08:37:05 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.36.100]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4blv012mR6z3hhT4; Mon, 21 Jul
	2025 08:37:05 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250721083704epcas2p3a89014b76970287dfaf58634370050c6~UN1xI70750668906689epcas2p37;
	Mon, 21 Jul 2025 08:37:04 +0000 (GMT)
Received: from KORCO118546 (unknown [12.36.150.57]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250721083704epsmtip183eb0ff8b1d8a430baeee8173a410623~UN1xDxi5y2989629896epsmtip1p;
	Mon, 21 Jul 2025 08:37:04 +0000 (GMT)
From: "hoyoung seo" <hy50.seo@samsung.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <beanhuo@micron.com>, <bvanassche@acm.org>,
	<kwangwon.min@samsung.com>, <kwmad.kim@samsung.com>, <cpgs@samsung.com>,
	<h10.kim@samsung.com>, <willdeacon@google.com>, <jaegeuk@google.com>,
	<chao@kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <aH3on5GBd6AfgJuw@infradead.org>
Subject: RE: [PATCH v1] writback: remove WQ_MEM_RECLAIM flag in bdi_wq
Date: Mon, 21 Jul 2025 17:37:03 +0900
Message-ID: <000001dbfa1a$a2a1ad80$e7e50880$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGsuCKma20p4qExdocLsEkdiKd5rQFAzVkXAhcIlgS0gAXygA==
Content-Language: ko
X-CMS-MailID: 20250721083704epcas2p3a89014b76970287dfaf58634370050c6
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250721062037epcas2p25fd6fcf66914a419ceefca3285ea09f3
References: <CGME20250721062037epcas2p25fd6fcf66914a419ceefca3285ea09f3@epcas2p2.samsung.com>
	<20250721064024.113841-1-hy50.seo@samsung.com>
	<aH3on5GBd6AfgJuw@infradead.org>



> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Monday, July 21, 2025 4:14 PM
> To: hy50.seo <hy50.seo@samsung.com>
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> alim.akhtar@samsung.com; avri.altman@wdc.com; jejb@linux.ibm.com;
> martin.petersen@oracle.com; beanhuo@micron.com; bvanassche@acm.org;
> kwangwon.min@samsung.com; kwmad.kim@samsung.com; cpgs@samsung.com;
> h10.kim@samsung.com; willdeacon@google.com; jaegeuk@google.com;
> chao@kernel.org; linux-fsdevel@vger.kernel.org
> Subject: Re: [PATCH v1] writback: remove WQ_MEM_RECLAIM flag in bdi_wq
> 
> On Mon, Jul 21, 2025 at 03:40:24PM +0900, hy50.seo wrote:
> > if it write with the write back option with f2fs, kernel panic occurs.
> > Because the write back function uses bdi_wq and WQ_MEM_RECLAIM flag is
> > included and created.
> > However, this function calls f2fs_do_quota() of f2fs and finally tries
> > to perform quota_release_work.
> > the quota_release_work is performed in the events_unbound workqueue,
> > but the WQ_MEM_RECLAIM flag is not included.
> 
> And what makes you assume the WQ_MEM_RECLAIM was added just for fun and
> can simply be deleted?

No way..
It's because i just don't know much about this part.
And WQ_MEM_RECLAIM flag is absolutely necessary.
Because it is necessary for stable write back operation when memory is
insufficient. 
is it right?
I'll find another way for fix bug.
Thanks for your reply.


