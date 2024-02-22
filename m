Return-Path: <linux-fsdevel+bounces-12516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CEB8602BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92FF1F24FE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995A554906;
	Thu, 22 Feb 2024 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HuVnE2RX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FF548F2
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630393; cv=none; b=KOJWCTDqfaYKE4DEFuPDfvR81VukTUhPVYBR6+nXhIeQZKTwtm9tcKWQ2ydNFS+69mok4zaseVAgliJULFP2O4IgumJivol5yTiNPKop97S/oR3yPDJ7sQGpIkZkzu6h4VItNNoXUpHPsrmfd4WniWLk3nXqAZMWmbWHDjPu7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630393; c=relaxed/simple;
	bh=AH/aCmCf3PyIeJPMZ77q1sPqNJaG20sqlvwsHKuE3+Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type:
	 References; b=f1RQzxI+yip1sViE3n1oVt0A5B3Dj03oDtLWfypxFiH7KZr5pEY0flIwN6R72X2EThxaG1TT+XQDp5y8yj323+wHVGHaLQ5W5Mi61JSRMeO3MR8fkAPCdOsspr3iAENQFkBoHy9qgd7bU39onV4NRpnNdElXedBVpeh80GI7WNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HuVnE2RX; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240222193306epoutp0207c6c1324000993f283b36782286deaf~2RkiwQpPU0112501125epoutp02o
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 19:33:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240222193306epoutp0207c6c1324000993f283b36782286deaf~2RkiwQpPU0112501125epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708630386;
	bh=Aw0IMN9Y7pRYo0SHD+2VVrkD9QVYuIV0fmU55u7YJW8=;
	h=Date:From:Subject:To:Cc:References:From;
	b=HuVnE2RXGIl94gGbSgJDqFy7aRTz19YcHesp479Slg9iUL9SqVulUenVIxhqYNwJ1
	 jCjM6+fkR2l4PLlUwnVQDw+JM1Ce3uPpRnP4MurosB8+DdEkbqETX1630mgq3fywNH
	 bRNkBtTw5xfDBGhZeMqQuKt2YTPCQ7kv7UZV/5vc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240222193306epcas5p38944d24b27616360f9254edac8265e4d~2RkiQp2Zo2280222802epcas5p3j;
	Thu, 22 Feb 2024 19:33:06 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Tgjwc3864z4x9Pp; Thu, 22 Feb
	2024 19:33:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.C8.09634.071A7D56; Fri, 23 Feb 2024 04:33:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240222193304epcas5p318426c5267ee520e6b5710164c533b7d~2Rkgafdyu2224022240epcas5p3x;
	Thu, 22 Feb 2024 19:33:04 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240222193304epsmtrp2d5f711e63645fc3832984ffd1f5e3a18~2RkgZyPyc0855908559epsmtrp2C;
	Thu, 22 Feb 2024 19:33:04 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-37-65d7a1706e98
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.E5.07368.F61A7D56; Fri, 23 Feb 2024 04:33:03 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240222193302epsmtip2f9f507d5b8b30595c8713be2ad9bfa8a~2Rkek6Tnc3199931999epsmtip2P;
	Thu, 22 Feb 2024 19:33:02 +0000 (GMT)
Message-ID: <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
Date: Fri, 23 Feb 2024 01:03:01 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
Subject: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
To: lsf-pc@lists.linux-foundation.org, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	josef@toxicpanda.com, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmum7BwuupBsceiFqsvtvPZrFy9VEm
	iz8PDS0mHbrGaLH3lrbFnr0nWSzmL3vKbrHv9V5mi+XH/zE5cHpcPlvqsWlVJ5vH5iX1HpNv
	LGf02H2zgc3j49NbLB4TNm9k9fi8SS6AIyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ
	19DSwlxJIS8xN9VWycUnQNctMwfoNiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpO
	gUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdkbH8s9sBZf5KzZ23WBqYLzC08XIySEhYCLRcvg9
	axcjF4eQwG5GiR1HOlkgnE+MEree3oTKfGOUmPh+FhNMy5XGTYwQib2MEju3dkJVvWWUmN17
	nQ2kilfATuLi804wm0VAVeLIwsWsEHFBiZMzn7CA2KICSRK/rs5hBLGZBcQlbj2ZD7SBg4NN
	QFPiwuRSkLCwgL/Ei4l9TCDzRQRuM0pMfT8BbDMzyOa+DT1QzfIS29/OYYY4byKHRNsWaQjb
	RWLjl+ssELawxKvjW9ghbCmJz+/2skHYyRKXZp6Deq1E4vGeg1C2vUTrqX5mkIOYgQ5av0sf
	YhWfRO/vJ2B3SgjwSnS0CUFUK0rcm/SUFcIWl3g4YwmU7SHx4/IJsE1CArESu+atZJ3AKD8L
	KSRmIfl+FpJnZiEsXsDIsopRMrWgODc9tdi0wDAvtRweycn5uZsYwclVy3MH490HH/QOMTJx
	MB5ilOBgVhLhZSm/kirEm5JYWZValB9fVJqTWnyI0RQYJROZpUST84HpPa8k3tDE0sDEzMzM
	xNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqZ5awzPH5Jr600PqYpbt/jM5jVmbkr6
	IhaGz1K9W58vFTu5+0DIWj9XcYvN6Rc/eU3jsQsynrzhY17QZE9tQ3nWVQeTvqZ8u7Om94gI
	b+YUdkFlOz5DgX03pCK3Mt6TXem6PPqi1FyR5b+LS+/t/1kqdjbQXKRz7YtrcQ2mvrO3i+z/
	kCWgV/3z9n4+YZGVhbHsCc/DYtbdNFd6+y3q9u2TmVWaeQV/5ZT2Wkzd/sEgZc6duJOmpc8j
	PLma/rLdyQy71Ss+8VnGew0lzVmBVz5Z7vtokZz8LFvVc/mnzPt5axx2RWbHhZ/45BF4LrM+
	YNaWIMuT+ueFJJbdtmyKNI7VPtdrev9y9zVRqdP/+ZVYijMSDbWYi4oTAW9lYek3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvG7BwuupBv8CLFbf7WezWLn6KJPF
	n4eGFpMOXWO02HtL22LP3pMsFvOXPWW32Pd6L7PF8uP/mBw4PS6fLfXYtKqTzWPzknqPyTeW
	M3rsvtnA5vHx6S0WjwmbN7J6fN4kF8ARxWWTkpqTWZZapG+XwJXRsfwzW8Fl/oqNXTeYGhiv
	8HQxcnJICJhIXGncxNjFyMUhJLCbUeLa8YXMEAlxieZrP9ghbGGJlf+es0MUvWaU2LjtFCtI
	glfATuLi8042EJtFQFXiyMLFUHFBiZMzn7CA2KICSRJ77jcygdjMQENvPZkPZHNwsAloSlyY
	XAoSFhbwlehu3wJ2hIjAbUaJPRsvgDnMAnsZJbrWP2SEaDaT6NraBWXLS2x/O4d5AqPALCT7
	ZiHZMQtJyywkLQsYWVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgRHjJbGDsZ78//p
	HWJk4mA8xCjBwawkwstSfiVViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2amp
	BalFMFkmDk6pBqbZL9Ujfm3YFenw8+r2zfPvihyt2uh8PNRkIc927ZAXLaZPepSjP0kXz5Pj
	W9FWIjBnyyvlIz/iVW2aZCekS/P2OyoJROp9Xue2Z6Jqr71Ec0POMdH7IRMSnhl4zuC+Z5+0
	q6/lTfGEZIVDBgfSex8eELf8cWCm7MRTERrznt8Sr5IRW2m+ZGZlzTIh3/vnryTxcWev3n03
	TvLm6ulylwRfBFj9ONKSuNbI06p9WvKZZOEylnMOuXnrDNy+rT639MZC79I3B1xLZs5MjPw0
	ZfsjpzTmyR3f8xceM3kSKNv0Z5F5zse1FTPj162rMnA6U8q069fyIyHLV22/c0cntfLhCb7c
	iMhvh3lWxG4r7VmsxFKckWioxVxUnAgAH+X/XwcDAAA=
X-CMS-MailID: 20240222193304epcas5p318426c5267ee520e6b5710164c533b7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240222193304epcas5p318426c5267ee520e6b5710164c533b7d
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>

With respect to the current state of Meta/Block-integrity, there are
some missing pieces.
I can improve some of it. But not sure if I am up to speed on the
history behind the status quo.

Hence, this proposal to discuss the pieces.

Maybe people would like to discuss other points too, but I have the 
following:

- Generic user interface that user-space can use to exchange meta. A
new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
direct IO. Buffered IO seems non-trivial as a relatively smaller meta
needs to be written into/read from the page cache. The related
metadata must also be written during the writeback (of data).


- Is there interest in filesystem leveraging the integrity capabilities 
that almost every enterprise SSD has.
Filesystems lacking checksumming abilities can still ask the SSD to do
it and be more robust.
And for BTRFS - there may be value in offloading the checksum to SSD.
Either to save the host CPU or to get more usable space (by not
writing the checksum tree). The mount option 'nodatasum' can turn off
the data checksumming, but more needs to be done to make the offload
work.

NVMe SSD can do the offload when the host sends the PRACT bit. But in
the driver, this is tied to global integrity disablement using
CONFIG_BLK_DEV_INTEGRITY.
So, the idea is to introduce a bio flag REQ_INTEGRITY_OFFLOAD
that the filesystem can send. The block-integrity and NVMe driver do
the rest to make the offload work.

- Currently, block integrity uses guard and ref tags but not application 
tags.
As per Martin's paper [*]:

"Work is in progress to implement support for the data
integrity extensions in btrfs, enabling the filesystem
to use the application tag."

I could not figure out more about the above effort. It will be good to
understand the progress/problems.

I hope to have the RFC (on the first two items) for better discussion.

[*] https://www.landley.net/kdocs/ols/2008/ols2008v2-pages-151-156.pdf

