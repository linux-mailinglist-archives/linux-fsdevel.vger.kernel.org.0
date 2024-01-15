Return-Path: <linux-fsdevel+bounces-7957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBACB82DEA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247561F22C19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364FB182B3;
	Mon, 15 Jan 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l7pl4ljP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26E182A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240115175447euoutp01d65741c406b583419559691644f80617~qlt2zI0As0434804348euoutp01Q
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 17:54:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240115175447euoutp01d65741c406b583419559691644f80617~qlt2zI0As0434804348euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705341287;
	bh=BXsSyq/ETS6VHy49YmdYk+79vD9CUUsCSBhh019gJfo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=l7pl4ljPIyngWGzwFF2ot1P5WbmqQ8vkaXcgZMAQQve5V2Ama9mPoJW1nHAI33Wjm
	 5t1UVOq8SGsSZDYds9zUGFeEurbCK2E2t/sEwSnP9NZk6lfxmUrdbYSrrDKaS6lgVQ
	 W99ujb/t3GI4kT2bo0158K5yodQQjzbUNgN0ptho=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240115175447eucas1p2579ccc7b04824ded5b2e7ea9ace6b99f~qlt2VREfc2424624246eucas1p2T;
	Mon, 15 Jan 2024 17:54:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B7.6E.09539.76175A56; Mon, 15
	Jan 2024 17:54:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240115175446eucas1p111db0849d5ea9fa820c71ad5a003f637~qlt16QncW1005210052eucas1p1O;
	Mon, 15 Jan 2024 17:54:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240115175446eusmtrp2b6e3ba6dac4ad20d4e5b5e1c06da268f~qlt15rFlu1804618046eusmtrp2Y;
	Mon, 15 Jan 2024 17:54:46 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-74-65a57167756f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 83.7B.09146.66175A56; Mon, 15
	Jan 2024 17:54:46 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240115175446eusmtip1dfaeaa659f9440378ec2fe2893a2726c~qlt1u5Ktw1870818708eusmtip1o;
	Mon, 15 Jan 2024 17:54:46 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 15 Jan 2024 17:54:46 +0000
Date: Mon, 15 Jan 2024 18:54:45 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<a.manzanares@samsung.com>, <linux-scsi@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<slava@dubeiko.com>, Kanchan Joshi <joshi.k@samsung.com>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] : Flexible Data Placement (FDP) availability
 for kernel space file systems
Message-ID: <20240115175445.pyxjxhyrmg7od6sc@mpHalley-2.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20240115084631.152835-1-slava@dubeyko.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7rphUtTDf4t4beY9uEns8XeW9oW
	e/aeZLGYv+wpu0X39R1sFvte72W2+HR5IZDYMpvJgcPj8hVvj0dPDrJ6HFz/hsVj85J6j8k3
	ljN6fN4kF8AWxWWTkpqTWZZapG+XwJUxd+Vv5oLrghWvL8k2ME7j62Lk5JAQMJHYPK+bvYuR
	i0NIYAWjxIED8xkhnC+MEtcnzWKDcD4zStx78IYdpuXo5assEInljBIXXu5lgata8W8FlLOV
	UeL7wv2MIC0sAqoSt6duZwOx2QTsJS4tu8UMYosIaEnM3jeFCcRmFljNJPHwuGAXIweHsECO
	RPsUb5Awr4CLxLO2c6wQtqDEyZlPWCDKrSQ6PzSxgpQzC0hLLP/HARLmFLCQeDLzLQtIWEJA
	WWL5dF+Im2slTm25xQRymYTABw6JNd2LoZ5xkdj/aAeULSzx6vgWKFtG4v/O+UwQdrbExTPd
	zBB2icTi98eYIeZbS/SdyYEIO0ocurOTESLMJ3HjrSDEkXwSk7ZNh6rmlehoE4KoVpNYfe8N
	ywRG5VlI3pqF5K1ZCG8tYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZhyTv87/mkH
	49xXH/UOMTJxMB5ilOBgVhLhrb6zJFWINyWxsiq1KD++qDQntfgQozQHi5I4r2qKfKqQQHpi
	SWp2ampBahFMlomDU6qBqZEvWOHpLj61FJEV5cEGe54VhMqUuh3QSjy2eMWCuVuv7Oh9/TIu
	KYpvh6/bNhfeXy+YZii9KHus9eJN/P6HukH/OvMM+Q8JinrNSZGPiJL1kD6b91KIecaTc+se
	+erKchksDi3zXTBdTv57WL1EffBsmbffxK5diGh5uTry0XuL9vCJBmpZObKp7S8qGD7yL+te
	JzZD8XDnu1snOqomeCdOOX32tE5/pMscIX6vNQus1zg88lp3coPvcontpjYrHOYpGIstvaik
	t7GsY9JJL54lj7IVglS6V6yaZ7pl1TfD1MAy26lzmLa527zdU3TjEGtjk9abzx5y9gsXLHHo
	D7rxp/zUshOKn1TDHPNDlViKMxINtZiLihMBlz9nUqgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7pphUtTDR591LeY9uEns8XeW9oW
	e/aeZLGYv+wpu0X39R1sFvte72W2+HR5IZDYMpvJgcPj8hVvj0dPDrJ6HFz/hsVj85J6j8k3
	ljN6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
	pG+XoJcxd+Vv5oLrghWvL8k2ME7j62Lk5JAQMJE4evkqSxcjF4eQwFJGiYOnJzFCJGQkNn65
	ygphC0v8udbFBlH0kVHiS9tyRghnK6PE6m0LwDpYBFQlbk/dzgZiswnYS1xadosZxBYR0JKY
	vW8KE4jNLLCaSeLhccEuRg4OYYEcifYp3iBhXgEXiWdt51ghZnYzSnz6vY4ZIiEocXLmExaI
	XguJmfPPM4L0MgtISyz/xwES5gQKP5n5lgUkLCGgLLF8ui/EzbUSn/8+Y5zAKDwLyaBZSAbN
	Qhi0gJF5FaNIamlxbnpusaFecWJucWleul5yfu4mRmD0bTv2c/MOxnmvPuodYmTiYDzEKMHB
	rCTCW31nSaoQb0piZVVqUX58UWlOavEhRlNgQExklhJNzgfGf15JvKGZgamhiZmlgamlmbGS
	OK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5Nb2qMm6f7fOR6R3ivvH7yZvJo/PopFtPxlevap
	6LjnW74WMPpdF3ltePKJeNS+pz7rzV5Mfbxuy/784sKY5ZF9HFO7N+oGdiYr6FrK1IkrbI+c
	p1AlJHLUJ6A5uKCtYZNmgNiGBUc+nT+2eUGfo9y0zoZnm9tOVhuvadB4K37Ff+3r+BMrz3x6
	fnnKUa6nKbIrQmbI6O88/D5/dvvHeP/a1858Kk+sUk+V6q7b1p4skOL9gS3ghtDe+Qmrz/W/
	suervGnhfeyDysJFeglW/w0eT7592fjaI6Xll16a2iZOnvt5/RWrB1HfhHwOBJRs+1WztrdI
	Y5pxUn+w+sN02Vz7x3Hber94yegy6Mx89ECJpTgj0VCLuag4EQAmyXQiRwMAAA==
X-CMS-MailID: 20240115175446eucas1p111db0849d5ea9fa820c71ad5a003f637
X-Msg-Generator: CA
X-RootMTR: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9
References: <CGME20240115084656eucas1p219dd48243e2eaec4180e5e6ecf5e8ad9@eucas1p2.samsung.com>
	<20240115084631.152835-1-slava@dubeyko.com>

On 15.01.2024 11:46, Viacheslav Dubeyko wrote:
>Hi Javier,
>
>Samsung introduced Flexible Data Placement (FDP) technology
>pretty recently. As far as I know, currently, this technology
>is available for user-space solutions only. I assume it will be
>good to have discussion how kernel-space file systems could
>work with SSDs that support FDP technology by employing
>FDP benefits.

Slava,

Thanks for bringing this up.

First, this is not a Samsung technology. Several vendors are building
FDP and several customers are already deploying first product.

We enabled FDP thtough I/O Passthru to avoid unnecesary noise in the
block layer until we had a clear idea on use-cases. We have been
following and reviewing Bart's write hint series and it covers all the
block layer and interface needed to support FDP. Currently, we have
patches with small changes to wire the NVMe driver. We plan to submit
them after Bart's patches are applied. Now it is a good time since we
have LSF and there are also 2 customers using FDP on block and file.

>
>How soon FDP API will be available for kernel-space file systems?

The work is done. We will submit as Bart's patches are applied.

Kanchan is doing this work.

>How kernel-space file systems can adopt FDP technology?

It is based on write hints. There is no FS-specific placement decisions.
All the responsibility is in the application.

Kanchan: Can you comment a bit more on this?

>How FDP technology can improve efficiency and reliability of
>kernel-space file system?

This is an open problem. Our experience is that making data placement
decisions on the FS is tricky (beyond the obvious data / medatadata). If
someone has a good use-case for this, I think it is worth exploring.
F2FS is a good candidate, but I am not sure FDP is of interest for
mobile - here ZUFS seems to be the current dominant technology.

>Which new challenges FDP technology introduces for kernel-space
>file systems?

See above. All we have done is wire up the NVMe driver. This is a good
discussion for LSF/

>Could we have such discussion leading from Samsung side?

Of course. We are happy to host a session on this if it gets selected.
We will add it to one of our submission.

