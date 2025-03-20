Return-Path: <linux-fsdevel+bounces-44556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98DCA6A4D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F86484764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B02F21CA04;
	Thu, 20 Mar 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hzWs/efL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E679C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469643; cv=none; b=AzHEo+v18mJffTj1LZs4uS3vZMn+r3KTBw1j7qv2LnVG8gcT9MnYdBE4K6Uab+d5qQIDETs5w9Ku+MxC8vHZbadyhDhk36PX7tvKdT5BBOYdQx8jN/4Vl5MpUUtIMsR1SkXKwZQlMGliEJAbezXAuBj4ns6XXLiutIMCVk8uF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469643; c=relaxed/simple;
	bh=LtPkzS2UDnspv9Skq0leXv989tQCG1fEQv/HfdGUIQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=oaDzpBr9zJoVu+BmE7vET8iGqrv6zMXQeEo86i8rO3h/k0ov8V3wsp9bsrl0YzRRiwJru1Ab3mfRLUohab71LQ1IGGmUVd3ayctnzi6X+wLlj6m/Kss788CciocqDhhVEXe1+nzDi2SpQxE4axSvCJr8rvjsb33LBQmTw/2mukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hzWs/efL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250320112033epoutp0174cb2ae14037c8df61beba288170c27b~ufuZMeRty0416204162epoutp01k
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 11:20:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250320112033epoutp0174cb2ae14037c8df61beba288170c27b~ufuZMeRty0416204162epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742469633;
	bh=b4Pa1yJymQKIUsKy2MJVD8GAitBRaLvYefAQptjMWpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hzWs/efL9w/lnHss06rO1V0GgfJu203bXkrgJM8C5O92V4HoukP7J1YSAX+c57MTX
	 mT/pKI2R77BbW8cd8KK3CMxa93ScY+gUz0WLbu8LlAz4AAJn8jnlNSkHpWAQDz+yW2
	 Al8pHW8w/dj2QWrRC+jgiV24RaiSMdBul4IhPjd4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250320112032epcas5p2c860455c33859910dc33a7af0e144f53~ufuYCRk200675606756epcas5p2M;
	Thu, 20 Mar 2025 11:20:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4ZJNRL28fqz4x9Pw; Thu, 20 Mar
	2025 11:20:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C3.3E.20052.EF9FBD76; Thu, 20 Mar 2025 20:20:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250320071635epcas5p3c0430a47750bfc038515e12fa809a82e~ucZYeP_Q21714517145epcas5p3n;
	Thu, 20 Mar 2025 07:16:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250320071635epsmtrp18497215da61de3d3c363ca7919e2dda4~ucZYUzdpJ2201222012epsmtrp1C;
	Thu, 20 Mar 2025 07:16:35 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-f8-67dbf9feac1b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.79.18729.3D0CBD76; Thu, 20 Mar 2025 16:16:35 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250320071633epsmtip21714aa39314e2c0500706d62fd58fbc6~ucZWj4qyR2027320273epsmtip29;
	Thu, 20 Mar 2025 07:16:33 +0000 (GMT)
Date: Thu, 20 Mar 2025 12:38:18 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Jan Kara <jack@suse.cz>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, joshi.k@samsung.com, axboe@kernel.dk, clm@meta.com,
	willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <20250320070818.GB16509@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <gamxtewl5yzg4xwu7lpp7obhp44xh344swvvf7tmbiknvbd3ww@jowphz4h4zmb>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmuu6/n7fTDTZ+4rVYfbefzWLLJXuL
	LcfuMVrcPLCTyWLl6qNMFrOnNzNZHP3/ls1i65evrBZ79p5ksdj3ei+zxY0JTxktfv+Yw+bA
	43FqkYTH5hVaHpfPlnpsWtXJ5jH5xnJGj903G9g8zl2s8OjbsorR48yCI+wenzfJBXBFZdtk
	pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2spFCWmFMK
	FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOeL7x
	ImPBR86KaTeWsTcwLuDoYuTkkBAwkWh4coS1i5GLQ0hgN6PEu7X32SGcT4wSU1pms4NUCQl8
	Y5Q4so0TpmPm+UNQRXsZJVq2dzBCOM8YJQ4++sYEUsUioCpxacIFZhCbTUBd4sjzVkYQW0RA
	WmLWsZUsIA3MAquZJI6f3AtWJCzgLdHwejMriM0roCux4usPKFtQ4uTMJywgNqeAn8Tm7bvB
	BokKKEsc2HacCWSQhMAeDolrh2exQdznIvFtyXYWCFtY4tXxLewQtpTEy/42KDtd4sflp0wQ
	doFE87F9jBC2vUTrqX6wg5gFMiT+LW+BmikrMfXUOiaIOJ9E7+8nUL28EjvmwdhKEu0r50DZ
	EhJ7zzVA2R4SZ7ZfhIbwTBaJXb3drBMY5WcheW4Wkn0Qto7Egt2fgGwOIFtaYvk/DghTU2L9
	Lv0FjKyrGCVTC4pz01OLTQsM81LL4VGenJ+7iRGcqLU8dzDeffBB7xAjEwfjIUYJDmYlEV6R
	jtvpQrwpiZVVqUX58UWlOanFhxhNgbE1kVlKNDkfmCvySuINTSwNTMzMzEwsjc0MlcR5m3e2
	pAsJpCeWpGanphakFsH0MXFwSjUwbYo8MWfqd56fovpPV6itdTe63u2Z+/PFnWOP9jfnhnRc
	kTr7lYnRVmbr7x2hZbmBEl2bnj9n0cvpLHr7U932g/7Ce31/J0365ptj4L9i8rtfQZy/X12Y
	9e35vr7jbRICf54G+EY6Prux7564juAD3cOLIpxM769cfyh6CdvVQwprLqUb+5xyzMpsTDm1
	UDe+xlPD9OylLz87WCL8Mv7zPCoOevtQYKOczZXa8A6NS8ntZtm3mtsy3mllOL93/7C8csuX
	0hly14QkrbYbzbR/yuuRfCOpdtaP2ee4/x7pXmWpM3ujxLwK61Z/oz9bBZxzn0ivTrvo+/O4
	mqVJfYNTxQSmlycLfpRMO/Oq7mWumBJLcUaioRZzUXEiAA4EtNddBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXvfygdvpBtdvcFqsvtvPZrHlkr3F
	lmP3GC1uHtjJZLFy9VEmi9nTm5ksjv5/y2ax9ctXVos9e0+yWOx7vZfZ4saEp4wWv3/MYXPg
	8Ti1SMJj8wotj8tnSz02repk85h8Yzmjx+6bDWwe5y5WePRtWcXocWbBEXaPz5vkAriiuGxS
	UnMyy1KL9O0SuDKW9/kUbGSveNfygKmB8SdrFyMnh4SAicTM84fYuxi5OIQEdjNKdF5oYIJI
	SEicermMEcIWllj57zlU0RNGiXXTD4AlWARUJS5NuMAMYrMJqEsced4KFhcRkJaYdWwlC4jN
	LLCaSWLnw2oQW1jAW6Lh9WawzbwCuhIrvv5ghRg6m0Xi6+SLLBAJQYmTM59ANWtJ3Pj3Eugi
	DiBbWmL5Pw6QMKeAn8Tm7bvBdokKKEsc2HacaQKj4Cwk3bOQdM9C6F7AyLyKUTK1oDg3PbfY
	sMAwL7Vcrzgxt7g0L10vOT93EyM4urQ0dzBuX/VB7xAjEwfjIUYJDmYlEV6RjtvpQrwpiZVV
	qUX58UWlOanFhxilOViUxHnFX/SmCAmkJ5akZqemFqQWwWSZODilGpiyZMTVfs8/fz1DpfBf
	rNfuGKEynkTfkzZhr5R1GA9VXNFonieacLJAfKeU1tErEquNNj+Nd/11QtA8uERa/pi8QcXC
	1EVGm7f7lnacP/v7ZMGREqE/O/j/vC2pEWzZKGLmeu/q+2t3t/4uC7Catbrx5aPUmlKFrM8W
	zye4RLc6ClnwTp1++u1TgeWfNv/eGHGFb+MLq+sBJq8aJKUKb2Tt3PFJ7ffbr88mBkXIPvGy
	+Zvlc5jhZNuSR3/zdgUZKJS+eCfhGm8V26K3eS1/U+CVKwUHGoob6j52nxPhDEp4+Gi/wdll
	cYp20nb+rAZ/ZcVdv6UaLenfpJW87c7VbUyvDh53yYmwmcctuZ+1f4cSS3FGoqEWc1FxIgDt
	ZueqHQMAAA==
X-CMS-MailID: 20250320071635epcas5p3c0430a47750bfc038515e12fa809a82e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----CWGevsXS2u69YOPRxXIoEHUfS1BE.HBDCgS7JOZLh2WfTI3=_1c799_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250319155413epcas5p2994ac0666d0454c23af8e23b46892970
References: <20250131093209.6luwm4ny5kj34jqc@green245>
	<Z6GAYFN3foyBlUxK@dread.disaster.area> <20250204050642.GF28103@lst.de>
	<s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
	<Z6qkLjSj1K047yPt@dread.disaster.area>
	<20250220141824.ju5va75s3xp472cd@green245>
	<qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>
	<20250318113712.GA14945@green245>
	<CGME20250319155413epcas5p2994ac0666d0454c23af8e23b46892970@epcas5p2.samsung.com>
	<gamxtewl5yzg4xwu7lpp7obhp44xh344swvvf7tmbiknvbd3ww@jowphz4h4zmb>

-------CWGevsXS2u69YOPRxXIoEHUfS1BE.HBDCgS7JOZLh2WfTI3=_1c799_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> I think xarray here is overkill. I'd just make this a plain array:
> 
> 	struct bdi_writeback_ctx **bdi_wb_ctx_arr;
> 
> which will get allocated with nr_wb_ctx entries during bdi_init(). Also I'd
> make default_ctx just be entry at index 0 in this array. I'm undecided
> whether it will be clearer to just drop default_ctx altogether or keep it
> and set:
> 
> 	struct bdi_writeback_ctx *default_ctx = bdi_wb_ctx_arr[0];
> 
> on init so I'll leave that up to you.

Killing default_ctx completely seems like a better choice here. This
allows us to unconditionally use the for_each_bdi_wb_ctx loop, even for
the existing single writeback case,  by simply relying on bdi_wb_ctx[0].
It also eliminates the need for is_parallel, simplifying the design.

Thanks for the detailed review, Jan! Your suggestions look good to me
and help streamline the plumbing. I'll incorporate them in the next
version.

Thanks,
Anuj Gupta  

-------CWGevsXS2u69YOPRxXIoEHUfS1BE.HBDCgS7JOZLh2WfTI3=_1c799_
Content-Type: text/plain; charset="utf-8"


-------CWGevsXS2u69YOPRxXIoEHUfS1BE.HBDCgS7JOZLh2WfTI3=_1c799_--

