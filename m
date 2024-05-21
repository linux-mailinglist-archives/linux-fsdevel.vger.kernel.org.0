Return-Path: <linux-fsdevel+bounces-19976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342C8CBA98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64C21F23863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6EF7C6C9;
	Wed, 22 May 2024 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bIGEBkUr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB879B87
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716354118; cv=none; b=spMPdZ0sEdBu9IDlx2FVa6LcKboIDIOlJeMitc8LlFAp6QmnvDOqN7CHcBH/ZQ98wz0/fejEoEkRDjv3+QrtKEfnwyYHof/8VXRYsqxzLydvVlHInT4hv8HzAjIUlXODv+vkvrcCZ3azLm9dajB7J54vqHz2rdDddKy8pV02Alc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716354118; c=relaxed/simple;
	bh=v+UZFDGcIplCeWgyOKOk7LUl/tgd1hVNH/BQuH7kVhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=eOSguS9mdJE97Qrn73bQLnzd9ClZN2BxRbSKTY059GGiGG9N9fzv9UANLGqcV+btg1mWXA3loeWXYqw/9RIXSYTPwYC9w81oJHpq+hNh/b5HOxeUB4lfhiiUjeXhcAyemoMZeO03ilxjsZ8flo5F+zTWAzj3n9kAhi0donakQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bIGEBkUr; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240522050154epoutp0194fc2ef74733d5950da5d4470dbca11f~RtvlKhCjt0716007160epoutp01A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:01:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240522050154epoutp0194fc2ef74733d5950da5d4470dbca11f~RtvlKhCjt0716007160epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716354114;
	bh=v+UZFDGcIplCeWgyOKOk7LUl/tgd1hVNH/BQuH7kVhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bIGEBkUrTINXnyvIkKFop6jbt0P5KHa++22msGRYVEie0tGoOFaivH4E435CCl+qQ
	 Zj5Olfmm5M8sW3N9fYsFSNXs0F08ad1IjMplZ8NTj1n6o3lfSQbGnupYuKtQjakOmt
	 apiVSG5uBi2SRMh94ChbmA3fspJYBX7kagibTrZM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240522050153epcas5p4c49060d71c380fd1a311b8ef4f7dc111~RtvkWJubf0799007990epcas5p4K;
	Wed, 22 May 2024 05:01:53 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VkfKr2wQcz4x9QH; Wed, 22 May
	2024 05:01:52 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DB.81.08600.E3C7D466; Wed, 22 May 2024 14:01:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240521145521epcas5p3085c3982fb14dab0709d493d3e1b941b~RiMcb82eq2206322063epcas5p3P;
	Tue, 21 May 2024 14:55:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521145521epsmtrp1967b56785c8cc04ff0efd8e503c27f9c~RiMcZUDzh2227322273epsmtrp1W;
	Tue, 21 May 2024 14:55:21 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-e8-664d7c3e8a2b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3E.1C.08924.9D5BC466; Tue, 21 May 2024 23:55:21 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240521145517epsmtip26cc224d597e605d820abffa401131a56~RiMY8JjcX2617526175epsmtip2_;
	Tue, 21 May 2024 14:55:17 +0000 (GMT)
Date: Tue, 21 May 2024 20:18:19 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 10/12] dm: Enable copy offload for dm-linear target
Message-ID: <20240521144819.nm25c4txfhwggfae@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <017a9853-6e42-4250-9cfa-1d6ad5786556@acm.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVATdxTH+9vdbDZMocuh/gQ7pam2AoKJTfCHcmildR3KDDN2pjO1iClZ
	gSGETBLqRStCsQgTQNFSYpVTLq1UQGsQxeEQxFJsI3c5tIk90IajUJGCjdnQ8b/P+773fu+a
	H4W71PHdqTilllUrZQoh6UBcafFa6xucHL5X1Dfqg2o6b+EoNXcBR+eHc0g03jIF0FcTczgy
	3fwSoPmubhzV3xoBqKjkDIEGbhow1FhyAkNV59swdDo/DUNtzx6T6ERzL0DmHj2Grg/6oOKj
	ZQRqvH6bQMaGb0hUWG7mo4r2RQwdz+jB0FXTEYAujlsI1DHogboX2nlbPBjjvTCmswQyBv0w
	n+keuUQwxq4kprb6GMnUlR1mfq8rAMy1gRSSKc3O4zG6tL9IxpA+ymMmzYMEY7nRQzLZ9dWA
	+aGolR/h+lF8YCwrk7NqT1YZnSiPU8YECcN2Rm2LkvqLxL7iALRR6KmUJbBBwtD3I3zfi1NY
	lyP0/FSmSLJKETKNRrg+OFCdmKRlPWMTNdogIauSK1QSlZ9GlqBJUsb4KVntJrFItEFqDdwT
	H/tTxkm+qpW3/1pFDpECHhKZQEBBWgIf6Br4mcCBcqGvAdh0egxwxhSAj4oLSc6YBbBtbBYs
	paQ0XiY4x3UAz347iHHGQwCNDeW2KIJeA8+Xf2dliiJpH3jnGfVcdqPXwtmxClsyTheT8Jf+
	J/hzhysdBmuzDbamHGl/2PHjBMaxM7xdYLLpAnozzDfk2/Rl9Cr49bkZnOuoVwANjRTHofDK
	v/Ukx67wz/Z6Psfu8I+co3beB6tOVtpGg/QXAOr79PbRQmB6Z47tUZyOhd3jc/aEV+GpzosY
	pztB3bwJ43RHePXsEr8BL9QU2QuvhL3/HLEzA1NT79o3ZAEwrdKA5YLX9C8Mp3+hHseb4LGJ
	VJ7eujyc9oAVixSHXrCmYX0R4FWDlaxKkxDDRktVYiW77/+TRycm1ALb7/EOvQr6Cxf9mgFG
	gWYAKVzo5lhbv2Ovi6NcduAgq06MUicpWE0zkFqPdRx3XxadaP1+Sm2UWBIgkvj7+0sC3vYX
	C1c4jqefkbvQMTItG8+yKla9lIdRAvcUjNxpFBTg9JNMGPgYNza5FokUFpMgq9hl6MN1TYJR
	b/OVOXPZSPieJwc6V8W3qp29Dh9yUyTfSqgIz5rJnLmctGv51OPW8r9PObW92TSWXhZ5aM32
	36TavsiIlruX3EMidYTwaQjhta11wkHk/FYbNdn+uXnxg64gv6frGF3VjZaMHZW7f97tNBtw
	Q7e1yWICv95xvMBbeOeEa+n9Z7tSzBFZ8xcH80HfZNr38YPTnuDdRxvah85tqVw9nyPx+exe
	yPZXVMm5H2dMNxwsrs57XXbUqH7JdFm9TV4aPDDsfd+3b/XG5bXTK0pmpUPt3g6fqHa+bPHq
	zwtUdFCbJaKmB0PB+9cJCU2sTOyNqzWy/wA12b2dxgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX+/X7/7lZ39Kulbx8wRPRBt4rtpZlrz5fIwMyzzcOl3XXQ5
	d/I4ykXprCTmrhNOD5dqSlceTnW48lC5TksoU0xNip4sj6vobsZ/n31e74d9tg9Dun2hvJmY
	uH2cIk4cK6RdqFs1wunzWm+GSxY0qmaj0vpHJFJljJCo+M0ZGvXWDAF0YeAHiTrvpwD0y2oj
	UcWjdoD0OZco1HrfRKCqnEwCFRY/JNBFTRKBHo59plGm5QVAXS06AlW3BaCryXkUqqquo1Dz
	3WwaXTF08VDB41ECnT3VQqA7nccBKuntp9CTNgGyjTx2WibAzc9FuD4HYpPuDQ/b2sso3GyN
	x8aiVBqX5yXg7vIsgCtbE2mcm37OCacl9dHYdLLDCQ92tVG439xC4/SKIoCf6mt569wjXEKi
	uNiY/Zxi/tIdLtITP7D8K3Ewu1JLJwIjoQbODGQXwsSqm5QauDBubCWAVwxllAN4QcNILemY
	3WHh6AeeQ9QJ4LfqfjugWB9YbLgB1IBhaDYANowx4+vJrC/8+rbAHkqy+TRsuveLNw7cWRE0
	ppvsBXx2EXzSOEA4QvsB1Dy1AAdwhXVZnXYR+Ud0ufwdOV5AsgJYMGovcGaXQI1JY7/Ag50K
	tfnDZAZw1f3n1v3n1v1z6wFZBLw4uVIWLVMGyYPiuAOBSrFMGR8XHbhzj8wI7H/h73cH3C4a
	CLQAggEWABlSOJlvrFgpceNHiQ8d5hR7tiviYzmlBQgYSujJ9+xOi3Jjo8X7uN0cJ+cUfynB
	OHsnEodUG9abpJsCzouGbZlp3LEQ/cwt+jBrfEKP/9oO3KpNkAfPfdY3Z3vwvfklW1Wfzpf5
	+e2uyPoeOiFVsNGzg2v3SpIsqbMOiQJyaY8Ugr9gzWBEN1np+jJl7HVt2EqbMCVP7nlaN2to
	4WBoRmNI4a4Xhoj05b7+cxte1U80XF99/f0qjynFx3dqws09+Wd7fDMj98pym35+xNcmLJar
	GyLDlaWTNn96mbxi7zO8wSt5ZHZvaGpa0yT10W20Odj1mI9MUpptvWw+fUB6ZGlI+4c1tTM9
	gmYM1ZOryl6FCcrDp62PzJaIzLuk2pLkqBrV4S0+fUe0w7ZF3g+q6rS3N44OxggppVQc5E8q
	lOLfWU2MeoYDAAA=
X-CMS-MailID: 20240521145521epcas5p3085c3982fb14dab0709d493d3e1b941b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_161fe_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520103016epcas5p31b9a0f3637959626d49763609ebda6ef
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520103016epcas5p31b9a0f3637959626d49763609ebda6ef@epcas5p3.samsung.com>
	<20240520102033.9361-11-nj.shetty@samsung.com>
	<017a9853-6e42-4250-9cfa-1d6ad5786556@acm.org>

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_161fe_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 20/05/24 04:25PM, Bart Van Assche wrote:
>On 5/20/24 03:20, Nitesh Shetty wrote:
>>Setting copy_offload_supported flag to enable offload.
>
>I think that the description of this patch should explain why it is safe
>to set the 'copy_offload_supported' flag for the dm-linear driver.
>
Acked, will add more description in next version.

Thank You,
Nitesh Shetty

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_161fe_
Content-Type: text/plain; charset="utf-8"


------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_161fe_--

