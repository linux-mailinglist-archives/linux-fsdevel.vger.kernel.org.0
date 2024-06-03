Return-Path: <linux-fsdevel+bounces-20806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032CB8D80D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6791F21E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666784E17;
	Mon,  3 Jun 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FOfTfbDi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D084D06
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413456; cv=none; b=KHkPL8mvBqSpKo/luspu0vwSkRlN99wu50ijq+QpXv+3laaxRZk3vG/n57suMOmWcL7a+ns/OcrEvOEotfYsdlZ1WZuOhjXHqQHBeFZUHLcqz3x1Wco6H1terOoM3UeVpijNgV243Ceh8PwDj02lSmDjWPVeF33cqaJt1K53G2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413456; c=relaxed/simple;
	bh=D3gB42XtxeSBE/jlJ1UPPvQmW6H1Vaq5vTF/0Hf4J0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=C3tCQvq+lhee7JDMQ2oOqwMtmM4CKAWTjKUVpbu7BXrWtyQkukCEtTjzKvhEBDewC0+sUTMw6xMxurkUUJiU2fFYqz/qaZO+lx2PSgLEV1gJ6BebFXF5OiEMYWLPPEv2ATnU9RpESGcegvlr5zSWmO86o+vXpXNFvWFPkCJy9Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FOfTfbDi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240603111733epoutp024c8071f59fec1104f76823d363bf1f98~Vem-ATnPx2925229252epoutp02a
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 11:17:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240603111733epoutp024c8071f59fec1104f76823d363bf1f98~Vem-ATnPx2925229252epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717413453;
	bh=D3gB42XtxeSBE/jlJ1UPPvQmW6H1Vaq5vTF/0Hf4J0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FOfTfbDiGYY8dC+XkOh6fGvoSgYi+VKu3PQWMQ3I+dOlNKYBCeRGLbpjOtBQAZ0j1
	 F6yeyzcPhDg2vZJa+7qvRzQXw3aDosUaUS+74DZkxsPSvBuRU6ilXXPcbQ7PF2Cr6+
	 xMGYE71BQ1t9xzuUlXsLW5XXhxthiawahnvDJUcw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240603111732epcas5p1ccf2e0f93b02b557dd78df93aa32c170~Vem_YDuab0938609386epcas5p1y;
	Mon,  3 Jun 2024 11:17:32 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VtB5k1BY1z4x9Q0; Mon,  3 Jun
	2024 11:17:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.39.09989.946AD566; Mon,  3 Jun 2024 20:17:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240603111120epcas5p32f11d320999cb72c11dd1a3eae7ddbb0~VehjYO1QI1720317203epcas5p36;
	Mon,  3 Jun 2024 11:11:20 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240603111119epsmtrp2f707e276d7ee7977b7bd999f469b7c14~VehjVlxGB0717207172epsmtrp2i;
	Mon,  3 Jun 2024 11:11:19 +0000 (GMT)
X-AuditID: b6c32a4a-e57f970000002705-d6-665da649f8aa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.BE.18846.7D4AD566; Mon,  3 Jun 2024 20:11:19 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240603111116epsmtip2cdcced5778a81386c3c2c6481e874bdf~Vehf6HtUx0894208942epsmtip2t;
	Mon,  3 Jun 2024 11:11:16 +0000 (GMT)
Date: Mon, 3 Jun 2024 11:04:15 +0000
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
Subject: Re: [PATCH v20 11/12] null: Enable trace capability for null block
Message-ID: <20240603110415.7furv27qlemddzee@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240601062343.GA6347@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUZRTvu3f37sUJWoGGDwgGr/YQBHcV1g9GihkcujycMMJGGVo3uLDI
	srvtQlLTJE8NFQQTnF3cQlghQECFmOWVvJ8hKYFJgliAjKQQYA3xapddrP9+5/ed3zm/c858
	JG5ZxLEjY6TxjEIqklDEFlZt205n14Di8Chehxmq6u3EUUr2Ko7KR88TaKZtHqC8uSUcTTSf
	Bmi5fwBHNZ1jABUUaljofnMdhhoLL2CotLwDQ/mXUjHUsf6UQBdahwGaHFJjqGnEBV05pWWh
	xqYeFhqsv0ygb4snOaikaw1DOV8NYUg3kQxQ5cwsC3WP2KOB1S62jz09+HMg3VsI6Tr1KIce
	GLvBogf7E+ibZRkEXa09SU9XqwDdcD+JoIuyvmbTmanPCLou/SGb/nNyhEXP/jBE0Fk1ZYD+
	saCdE2x1NHa/mBFFMgonRhohi4yRRntTgSFCX6GHgMd35XuifZSTVBTHeFMHgoJd/WIk+t1Q
	Tp+KJAl6KlikVFK7396vkCXEM05imTLem2LkkRK5u9xNKYpTJkij3aRMvBefx9vjoU88Fivu
	mbmHy3M5iXeSa4kkkEacAWYk5LrDP1RL+BmwhbTkNgCYN6IljME8gMXpU5wXQc/0dc6mZOUf
	Hdv4UAdgZVEeZgwWAGxeXNvIYnF3wPzaq+AMIEmC6wL71kkDbc2l4OSTfmDAODeXgOtqe0OK
	FTcQJo9JDLQ51xfOjnSyjHgr7FFNbGAzfZWW+XmWoRXktpnBXx8vAqOhA7D01lPMiK3gk64a
	k1E7uPCsyTTnCVh68TvCKE4DUH1PbRK/A9N7z+MGEzhXDKdGTbQDzO2txIw+LWDm8oSpvjnU
	fbOJt8NrVQWm+rZw+O9kE6bh0sRp04IeAngq7RGWDRzV/xtI/V879UYLL5gxl8I20vawZI00
	wp2wqn53AWCXAVtGroyLZpQe8j1S5sSLG0fI4m6Cjd/iHKADj8bn3FoBRoJWAEmcsjbP+jIs
	ytI8UvTZ54xCJlQkSBhlK/DQXycHt3s1Qqb/btJ4Id/dk+cuEAjcPfcK+JSN+Uy6JtKSGy2K
	Z2IZRs4oNnUYaWaXhLGbrg/fCGrTvJ5Y5b2txrHdd3Hw6qGDDZMK2pWui3grNaarvp1/bMW/
	4uyH89c0KfmltCOZZ1GeofOJbQzVBaVrfrdYPPLbm91FLrsE2vAZbLS+r+aN7O1UzvcrV+4E
	5HL9D3OqfUMrioYdnY7Lbl+yOSo9udrNrnoJUz3vuzvE12Yme81MTYerz9mO25Vn7HgQ+stK
	kO/LH4/VqxQL7hd/Gremjk99cPDBF86v1IZq3sN8PFuOxIaJdjmEvFsi3Hb2r7vv7/MPO1yB
	CSWD0fJbDpf3ftLHG3OOss9Peh6qwh/bxHxUNhbi10JaLvMPZSvEGbNufoHK3rWtt+1roxKL
	X/PXUiylWMR3xhVK0b+vszxutgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCSvO71JbFpBrv+mFmsP3WM2aJpwl9m
	i9V3+9ksXh/+xGgx7cNPZosnB9oZLX6fPc9sseXYPUaLBYvmsljcPLCTyWLPoklMFitXH2Wy
	mD29mcni6P+3bBaTDl1jtHh6dRaTxd5b2hYL25awWOzZe5LF4vKuOWwW85c9ZbdYfvwfk8XE
	jqtMFjueNDJarHv9nsXixC1pi/N/j7M6SHtcvuLtcWqRhMfOWXfZPc7f28jicflsqcemVZ1s
	HpuX1Hu82DyT0WP3zQY2j8V9k1k9epvfsXnsbL3P6vHx6S0Wj/f7rrJ59G1ZxehxZsER9gDh
	KC6blNSczLLUIn27BK6M+9N6mQuOs1TMmL2atYHxAnMXIyeHhICJxJ9fO1i7GLk4hAS2M0oc
	e7OCESIhKbHs7xGoImGJlf+es0MUfWSUuP9yPytIgkVARWL2tqVADRwcbALaEqf/c4CERQSU
	JJ6+Ogs2h1lgJpvEmfm5ICXCAt4SjfdyQMK8As4S728dY4EYeZ9RYuXRJ0wQCUGJkzOfsED0
	mknM2/yQGaSXWUBaYvk/sPGcQJsOfvrEMoFRYBaSjllIOmYhdCxgZF7FKJpaUJybnptcYKhX
	nJhbXJqXrpecn7uJEZwMtIJ2MC5b/1fvECMTB+MhRgkOZiUR3r666DQh3pTEyqrUovz4otKc
	1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGpvKn7V03VGSzm1eIF8TuFskSZ09l
	ENG5vNnEY1rcNNb48wf8XgUHJkV96pTYGCPtqVa3beqNs69+5Fls27cy16L4erf6iltN+5yN
	kmPLhLcnBr74cCh3ZSibdyK72TSheXcW1P9YvrWwff1/2WzGG3xRypn3Tt5PEF/W413zbjPj
	2d7oZ8lsk3rC/spJsiZbq0tYP7va1ett91F4/sfwXVdqmF7+VQhqWW7zfWaY5pPDTDVTZFiu
	3TNacmxjyql503ceVMp4umP7rs3HH9sebLHrtxepXzXzwD7pA538inollu/3VV/fxfDg7jKW
	3umf1f47flJkP937MS0oxnvR5sPx+k7n+c7Laeo2++SKKbEUZyQaajEXFScCAKh+bmp1AwAA
X-CMS-MailID: 20240603111120epcas5p32f11d320999cb72c11dd1a3eae7ddbb0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_5215e_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103027epcas5p4789defe8ab3bff23bd2abcf019689fa2
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103027epcas5p4789defe8ab3bff23bd2abcf019689fa2@epcas5p4.samsung.com>
	<20240520102033.9361-12-nj.shetty@samsung.com>
	<20240601062343.GA6347@lst.de>

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_5215e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 01/06/24 08:23AM, Christoph Hellwig wrote:
>On Mon, May 20, 2024 at 03:50:24PM +0530, Nitesh Shetty wrote:
>> This is a prep patch to enable copy trace capability.
>> At present only zoned null_block is using trace, so we decoupled trace
>> and zoned dependency to make it usable in null_blk driver also.
>
>No need to mention the "prep patch", just state what you are doing.
Acked.
>Any this could just go out to Jens ASAP.
>
There is no user of trace apart from zoned and copy offload.
Hence this would not make sense as separate patch.

Thank you,
Nitesh Shetty

------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_5215e_
Content-Type: text/plain; charset="utf-8"


------Fualeei1.f5fhWGYL679EBd0hH5-OLgtfrOtH6wInDZGwDEe=_5215e_--

