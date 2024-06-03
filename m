Return-Path: <linux-fsdevel+bounces-20805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A068D80CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22EB1C21D33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC484A4F;
	Mon,  3 Jun 2024 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fBCyfFmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444D823B5
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413453; cv=none; b=AdBbXjB8KoiizBvyXTVi6vbOhXS51jhKd9V/oMldV2Vd+H4pOT5pZctEg8WOAcTg/vFLHhoTbgCQxdESmuz23ZZaj7goCw470Knc/6DHlQBeRB3b6u1FNtvPatW165xagxBO+r6TNGB2kJofvl16hCuSa7iKbLheEzDpujJBrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413453; c=relaxed/simple;
	bh=X9ILtM/+5hKq9Dskgzk3jggSkTrWGbcydimSrAcZB/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=PJXOA6SWSamLJLZ0a+Io2J1EtCc/H7lS0Pkx62ocETvYvSA/V/wTk+pmujyYqCKgV05dRpN3G7Grclg9m1cefsQ6XgRDYfJxwgjxPaK9wdyt8A/pPINLuf19JGlqjjlOJLJOOM4n0MtrIBClt7d4h/UdGTA/1Z1kZMBUpOp5RE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fBCyfFmm; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240603111728epoutp03fc0511af40a20b90a850d7af84d842b9~Vem6xW2kP1949519495epoutp03d
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 11:17:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240603111728epoutp03fc0511af40a20b90a850d7af84d842b9~Vem6xW2kP1949519495epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717413448;
	bh=NdbbPTU401HPnUoOaw/F+ZPaUI8FnwtrRdYBN1GmdNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fBCyfFmmOdsx9UkBEa9C/gMGpiNyDk4AnmSWtZbFfDv+7gBM+/il6hdrezNZoUm6u
	 brNd0Yu+RFdFsvyiRq3EIXyNs2rR5HOPiAJA2VvMW5i5ShY8k0rytDknHtWX3ygeiW
	 3INEWIAMTs1GV2KS6JZWO4Og6VhdoTW05ZmMqKO8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240603111727epcas5p447c1effda385c696f1a1dab79263bc00~Vem6CshrS0313903139epcas5p4f;
	Mon,  3 Jun 2024 11:17:27 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VtB5f5Krnz4x9Pr; Mon,  3 Jun
	2024 11:17:26 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F7.39.10035.646AD566; Mon,  3 Jun 2024 20:17:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240603110051epcas5p1210a0ffdd361216c504cc342c8d4f247~VeYaUA-3V1603316033epcas5p10;
	Mon,  3 Jun 2024 11:00:51 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240603110051epsmtrp274773a1330edafc070774ea66a2e82c2~VeYaSaTm90159301593epsmtrp2H;
	Mon,  3 Jun 2024 11:00:51 +0000 (GMT)
X-AuditID: b6c32a4b-b11fa70000002733-8b-665da646c938
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.BD.18846.362AD566; Mon,  3 Jun 2024 20:00:51 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240603110042epsmtip288f7ecce5d34cdfe18b68ceb823a3cdb~VeYRdfn010474404744epsmtip2K;
	Mon,  3 Jun 2024 11:00:41 +0000 (GMT)
Date: Mon, 3 Jun 2024 10:53:39 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, martin.petersen@oracle.com, bvanassche@acm.org,
	david@fromorbit.com, hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 00/12] Implement copy offload support
Message-ID: <20240603105339.keuiudmeplxdmczj@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240601054701.GA5613@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd+5tby9OSFeQHWAyUkkcEqBVigcGbAmM3Ag69jJOY6CDKyCl
	bdoizi1bEXDQjbeFWYExROQlRGgWysMQHjJBRhwClilDUjYGE8pLtjBgLReN/31+33N+7/xI
	nHed40wmSFW0QiqW8IldrJ+6Pd7yCqs6fUawsroPNfbfwdHFvA0c1T3OJdBc9xJAReZ/cWTq
	/Aag9cEhHOnvTABUXlHKQsZOA4baKwowVFPXi6GrxWkY6t16SqCCrlGApkd0GOoY90Q/Xqpk
	ofaOuyw03FpCoB+qpjnoRt8mhvIzRzDUYkoFqGFugYV+HndBQxt97HddqOEH4VR/BaQMuscc
	amjiFosaHkymmmqzCKq58mtqpvkKoNqMaoK6llPIprLT5gnKkPE7m1qcHmdRC7dHCCpHXwuo
	e+U9nEj7k4mB8bQ4lla40dIYWWyCNC6IH/5RVEiUyE8g9BL6o8N8N6k4iQ7ih0ZEeoUlSCzD
	4budE0uSLVKkWKnk+wQHKmTJKtotXqZUBfFpeaxE7iv3VoqTlMnSOG8prQoQCgQHRZaP0Ynx
	xrV6XK53PG9Qa3A1aOBpgA0Jub5wYWOcZWUetw3A4jpPDdhl4SUAq41m4oUx3ToGNIDc9vi+
	3IXRDQBmG9IxxlgGcLJnHLeGYnHdYeb6M8zqQHA94cAWaZUduHw4PTsIrIxztQTc0rlY2Z4b
	BB8Z0jlWtuWGQM3NX9gMvwbvXjFtV2djCbOVVcay5oLcbhtYrF7FmRZC4dMnjzgM28PZPv0O
	O8Pl+Q6C4RRYc7maYJzTAdSN6QDz8A7M6M/FmYriYf53uWxG3wu1/Q0Yo9vB7HUTxui2sKXs
	Oe+D9Y3lOwmc4Oha6g5T8B9DEYuZSj2A2sJMkAdcdS91pHspH8MBMMt80cKkhV3gjU2SQQ/Y
	2OpTDti1wImWK5PiaKVIfkhKp7xYcowsqQls38uB8BYwNWn27gIYCboAJHG+g23OV6fO8Gxj
	xZ9foBWyKEWyhFZ2AZFlQfm4854YmeXgpKoooa+/wNfPz8/X/5CfkP+67VxGaSyPGydW0Yk0
	LacVz/0w0sZZjb0nQidHP/6vLUtysPJIxG52WrNaqx345Bbvr0vVwYE+JZKZ/pnmtxtOzM27
	hx6btdfrucvHg7X3H+ZoTkx0NmUeKZy3Xzmv+yJHL8j+M6YwoyAsYtgMvDP17qbotr72cyub
	xN6JJfKD0T+qJn1MxoCzu/Ubixd0ZYtRutknzbMxqa7Hist//XDt6LPj1Gqz/5RScjXvjW+F
	sOhU18M3Py0tM3V3hxyVgmDDkpvA10MD3/dTO4X08FJXzKU1Zx1faT1sU8ZZfjCWYzfQc+3m
	7czeXNeUtLXl03bZX/69qBjec490d7xfMph62Ri91eiwXxTx6vXfCj+bj7Hr3L/iTU7hcxl8
	ljJeLDyAK5Ti/wH/DoZ6uAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe897dnY0xOOsfGtFsRJKa2ZEvZGZIOWhqwZBF8yGntRyKptK
	N0ydWY4yXVG6zKaGppKR95W3vJXpWmaGqSnaVpYsL6BdbFpzRH378/yf3+/58tBQMEQuoUPD
	ozhZuCRMRNmSFY2i5esCc/xPrC9+vQY/fNECcUKqGeKi99coPNI4AfDNsR8QG+ovATyt00Nc
	1tIPsCbnDonf1WsJXJ2jInBBUTOBb99SELh51kRhVcNbgI1dagLX9Lji7KR7JK6uaSVx5+NM
	Ct/NM/Jx/rMZAqdd7iJwlSEe4OKRURI/7xFivfkZz0vIdr7Zzb7IQaxW/Z7P6vsfkWynLpot
	KUym2NJ7F9jh0gzAPnkXR7G5Kdd57FXFV4rVXhzgsePGHpIdre2i2JSyQsC2a5r4vo5HbD2C
	uLDQGE7m5nncNiTtzSSM/Oh4+pUpHsaBn/ZKQNOI2YjSNUIlsKUFTCVAU0kaoAQ2f+aLUZ65
	CVqzIyqY+cS3Lo0DlParl7IUJLMKXZ6eIiwiinFFbbO0ZbyAESHjF92cBzIZFGq/K7VkR2Yb
	6tMm8i3ZjvFGygcveVZnMUATug7KWjig1gwDaYU3oazSQWjxQ0aI8mfm/DZ/Ts0mZ5GpgFH/
	R6j/I9T/CA2AhWAhFymXBksDI93FcolUHh0eLA6MkJaAuTdwOVAF8h6axQ2AoEEDQDQULbBL
	iT16QmAXJDlzlpNFBMiiwzh5AxDSpMjJbmVYcpCACZZEcac4LpKT/W0J2mZJHOEcXxck2Pnj
	RsXgMpW9h+LLPi+uT/C5XjI0lPi0dsywM9VZNfw6pm7qW1tiwOihRZPrH+gdmkM2+/Wq0n+2
	d7tFB4bejPWpluY2yUIcYMyq4fjpiOzTwerNHU3MYdGy3pbDWr/z4+f3KHwmfHJXCCeieN6v
	GpeuXVq+McVTW1F00XQrf/7qWuPKgYCWc7vGElCsl7D8ujIrs1vX4X7QO1Fvr1gBObHO5Jm9
	/9jyAH/z99X9hbvNb8XqHsP4d+xrSuoe0eaNeoSehO5tNbvcPsw7g2euODlzGemyrcIhp0d1
	8ytbJ/f2VSTlZm7ZMLCDBE8y2xNcpxy2p7sUzLvf9WtQRMpDJO4uUCaX/AYjgqMpdQMAAA==
X-CMS-MailID: 20240603110051epcas5p1210a0ffdd361216c504cc342c8d4f247
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_520e5_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102747epcas5p33497a911ca70c991e5da8e22c5d1336b
References: <CGME20240520102747epcas5p33497a911ca70c991e5da8e22c5d1336b@epcas5p3.samsung.com>
	<20240520102033.9361-1-nj.shetty@samsung.com> <20240601054701.GA5613@lst.de>

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_520e5_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 01/06/24 07:47AM, Christoph Hellwig wrote:
>On Mon, May 20, 2024 at 03:50:13PM +0530, Nitesh Shetty wrote:
>> So copy offload works only for request based storage drivers.
>
>I don't think that is actually true.  It just requires a fair amount of
>code in a bio based driver to match the bios up.
>
>I'm missing any kind of information on what this patch set as-is
>actually helps with.  What operations are sped up, for what operations
>does it reduce resource usage?
>
The major benefit of this copy-offload/emulation framework is
observed in fabrics setup, for copy workloads across the network.
The host will send offload command over the network and actual copy
can be achieved using emulation on the target (hence patch 4).
This results in higher performance and lower network consumption,
as compared to read and write travelling across the network.
With this design of copy-offload/emulation we are able to see the
following improvements as compared to userspace read + write on a
NVMeOF TCP setup:

Setup1: Network Speed: 1000Mb/s
	Host PC: Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
	Target PC: AMD Ryzen 9 5900X 12-Core Processor
	block size 8k:
	Improvement in IO BW from 106 MiB/s to 360 MiB/s
	Network utilisation drops from  97% to 6%.
	block-size 1M:
	Improvement in IO BW from 104 MiB/s to 2677 MiB/s
	Network utilisation drops from 92% to 0.66%.

Setup2: Network Speed: 100Gb/s
	Server: Intel(R) Xeon(R) Gold 6240 CPU @ 2.60GHz, 72 cores
	(host and target have the same configuration)
	block-size 8k:
	17.5% improvement in IO BW (794 MiB/s to 933 MiB/s).
	Network utilisation drops from  6.75% to 0.16%.

>Part of that might be that the included use case of offloading
>copy_file_range doesn't seem particularly useful - on any advance
>file system that would be done using reflinks anyway.
>
Instead of coining a new user interface just for copy,
we thought of using existing infra for plumbing.
When this series gets merged, we can add io-uring interface.

>Have you considered hooking into dm-kcopyd which would be an
>instant win instead?  Or into garbage collection in zoned or other
>log structured file systems?  Those would probably really like
>multiple source bios, though.
>
Our initial few version of the series had dm-kcopyd use case.
We dropped it, to make overall series lightweight and make it
easier to review and test.
When the current series gets merged, we will start adding
more in-kernel users in next phase.

Thank you,
Nitesh Shetty

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_520e5_
Content-Type: text/plain; charset="utf-8"


------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_520e5_--

