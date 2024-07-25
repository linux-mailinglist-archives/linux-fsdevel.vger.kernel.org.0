Return-Path: <linux-fsdevel+bounces-24223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312293BC4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 08:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17894B22794
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7131662E5;
	Thu, 25 Jul 2024 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T+1fRtcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B43611B
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721887261; cv=none; b=Ur2xHgcaBHOxkeJwhPUIlMNcIeXRwgHfPjd5cLQWScRMk4gFAbX/3KmMwsPEdmClsgXCt6FozqMwD5abCL68QUqsrO0ntauobJaBBd1wHJa8PHz1jroYHeuyTTOLyYDaUldYaItL0uldYMsM2NwLWaJ8tbcAsGEyUzfYMsnSEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721887261; c=relaxed/simple;
	bh=GzHjjxIDFwEMHMzhz4cnseDzBQdKO8qFZ+HP+s/9t2U=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Ep1niq2BhF9as6lJ6s2O2r3UJWciXrG6g8z7Um2Q5qZOC1k7jc9t5glAFipVquXFQ8XlnbV5WmG4t/+U391HfJuxSp6zxuDkeKSj6JDSqSbDxGtlDWSaoAORVudEjRY4asFLmUDaHCYDXkBtBrD2Dx+u8xW/sqYFp9ToABpg1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=T+1fRtcn; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240725060055epoutp03ada5c890432e9082e0ad4aac0b450cd7~lX1YBLXMz1331213312epoutp033
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 06:00:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240725060055epoutp03ada5c890432e9082e0ad4aac0b450cd7~lX1YBLXMz1331213312epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721887255;
	bh=vRNYyuiZ/cqW3uzGGflNYphSAwnFfuFIlD/3TcPliec=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=T+1fRtcnkMrdc8zeT980FB1rsPyPWybYjlwk7wG/b0drXiQLllvqJzL8caZmkez5a
	 MD8P7RhlXiuUcdzmf8JExJZ9Ht6UEYy68SbyPAnITxyrTa8aL5YZbqYrJUlYwlveR8
	 1OfQs/gY73DuNZhVwgeY87ywGmeoRQ4DES16r2Lo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240725060055epcas1p44ced5d792e3cd91b3e66cd8566bf23a8~lX1Xngei22645726457epcas1p4S;
	Thu, 25 Jul 2024 06:00:55 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.243]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WV0cQ5TRfz4x9QC; Thu, 25 Jul
	2024 06:00:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.4B.08992.61AE1A66; Thu, 25 Jul 2024 15:00:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240725060054epcas1p1494596fab623da39060e9dd2cc766cd2~lX1W_7glJ2963529635epcas1p1H;
	Thu, 25 Jul 2024 06:00:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240725060054epsmtrp1e6ee0b44c9788f0674bbf615f1cfc26f~lX1W_LNhJ0895008950epsmtrp1R;
	Thu, 25 Jul 2024 06:00:54 +0000 (GMT)
X-AuditID: b6c32a33-96dfa70000002320-4e-66a1ea16a69a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.A6.19367.61AE1A66; Thu, 25 Jul 2024 15:00:54 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240725060054epsmtip21756e52d8d7bbe9ddf62b8779a146722~lX1WwlvI22933529335epsmtip2i;
	Thu, 25 Jul 2024 06:00:54 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Christoph Hellwig'" <hch@infradead.org>, "'Dongliang Cui'"
	<dongliang.cui@unisoc.com>
Cc: <linkinjeon@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
	<hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>,
	<cuidongliang390@gmail.com>, "'Zhiguo Niu'" <zhiguo.niu@unisoc.com>,
	<sj1557.seo@samsung.com>
In-Reply-To: <ZqD8dWFG5uxmJ6yn@infradead.org>
Subject: RE: [PATCH v2] exfat: check disk status during buffer write
Date: Thu, 25 Jul 2024 15:00:54 +0900
Message-ID: <17d6401dade58$0287e640$0797b2c0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQItpdPUYDcdohGaqP+peTI17yo97wDEgLlZAlqmsEKxSGnjgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGJsWRmVeSWpSXmKPExsWy7bCmga7Yq4VpBk/vqltM/HGF1eLl5rfM
	FvM/P2GzOD1hEZPFoz33mCwmTlvKbLFn70kWi8u75rBZvD7wkNliy78jrBZTnx5jdeD22Dnr
	LrvH5hVaHptWdbJ59G1ZxehxuP0su8fnTXIBbFENjDaJRckZmWWpCql5yfkpmXnptkqhIW66
	FkoKGfnFJbZK0YaGRnqGBuZ6RkZGeqZGsVZGpkoKeYm5qbZKFbpQvUoKRckFQLW5lcVAA3JS
	9aDiesWpeSkOWfmlID/pFSfmFpfmpesl5+cqKZQl5pQCjVDST/jGmNH9qo21oJ2lou9DJ1sD
	4yzmLkZODgkBE4nTc58zdTFycQgJ7GCUuPRxKzOE84lR4s6La6xwztf7y1lgWu4ePQ7VspNR
	4uCBJqiWl4wSnTOXMYFUsQnoSjy58RNsiYhArETj7ansIEXMAr1MEi83rgMr4gQq2tN3hrGL
	kYNDWMBF4t9Hc5Awi4CqxMwrzxlBbF4BK4mdxyawQdiCEidnPgG7gllAXmL72zlQTyhI7P50
	lBVil5PE2+/HmSBqRCRmd7aBHSchsINDYtPho4wQDS4Sa17vg2oWlnh1fAs7hC0l8bK/jR2i
	oZtR4vjHd1A/z2CUWNLhAGHbSzS3NrOBHM0soCmxfpc+xDI+iXdfe1ghSgQlTl/rZgYpkRDg
	lehoE4IIq0h8/7CTBWbVlR9XmSYwKs1C8tosJK/NQvLCLIRlCxhZVjGKpRYU56anJhsWGCLH
	+CZGcJLWMt7BeHn+P71DjEwcjIcYJTiYlUR4l91fmCbEm5JYWZValB9fVJqTWnyIMRkY2BOZ
	pUST84F5Iq8k3tDMzNLC0sjE0NjM0JCwsImlgYmZkYmFsaWxmZI475krZalCAumJJanZqakF
	qUUwW5g4OKUamDo/JG87rfgxKeWFa7CU3XElA8P3TQH9yhlmYRu8wrQnOd1hPXun9/RkPpl2
	a8OVUr/myGoIHNIKPmMbuGC5FMukjfxXFbI3dXv22hwX7Bbfo8ekOzEmK4jHRZJNr8Cn8Vxx
	xuTZTSH/ONdamGWrbZhXZWnEnRU+beHxa99EjGa3v4i4yd4/o0hd3VXk6+17WpM3BexUYahU
	v/hsmfupd6HrpmyIL5t+dK758Rn5Lbe6+6+2fFnpxMIWoX9Ixmf2LG/ZE98bJHmY/Gd4Pf7k
	E2rXEiHdfIX12dopoSdZy3Yo26R8leES5n1gGHd364KK5Zazv2z1rXn29vGnlvjfdts+x/X5
	Msw03MW1Q22SEktxRqKhFnNRcSIA6Z4UcYkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvK7Yq4VpBmfXC1pM/HGF1eLl5rfM
	FvM/P2GzOD1hEZPFoz33mCwmTlvKbLFn70kWi8u75rBZvD7wkNliy78jrBZTnx5jdeD22Dnr
	LrvH5hVaHptWdbJ59G1ZxehxuP0su8fnTXIBbFFcNimpOZllqUX6dglcGd2v2lgL2lkq+j50
	sjUwzmLuYuTkkBAwkbh79DhTFyMXh5DAdkaJrfuWs3QxcgAlpCQO7tOEMIUlDh8uhih5zihx
	9e0tFpBeNgFdiSc3foLNERGIlTjW/Y8ZpIhZYCqTxO69c6GGbmKUaNz3nQmkihOoY0/fGUaQ
	qcICLhL/PpqDhFkEVCVmXnnOCGLzClhJ7Dw2gQ3CFpQ4OfMJ2D3MAnoSbRvBSpgF5CW2v50D
	db+CxO5PR1khbnCSePv9OBNEjYjE7M425gmMwrOQTJqFMGkWkkmzkHQsYGRZxSiaWlCcm56b
	XGCoV5yYW1yal66XnJ+7iREccVpBOxiXrf+rd4iRiYPxEKMEB7OSCO+y+wvThHhTEiurUovy
	44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpjKKyqDzIOaio129M3LuS8m
	cOjR3PpP6XzVL6v27zDhXRfqvE2h4pKlmnn/9r7fD/uMluQZnLkZ0+X4Quxps/dhDs7VjLVt
	kzQ8J7w5fbZMePtny0n2Py/ntJYc3Z/96cyH12xsqWsVPtdeSn6cmHZSlb9jfd3ZLV1hkudZ
	vXcKeKSdefM2z8I01irpxKc53c85ru47zhXCGfnPbe+HW2dZfh4rKet7zeocplI9h32n0/R7
	j73lc3Wa9r4Jub/K4MHHm6uPXzgoE/HA79L0jMn6GjwNYjbNrQ46x69F37XbPOHzjJg9VpIN
	hscmFxQdOj1Zy/DbvWu8kxsPnOXU2/DJq9nghVCGR0nU353T0/YrsRRnJBpqMRcVJwIAyK/Q
	KycDAAA=
X-CMS-MailID: 20240725060054epcas1p1494596fab623da39060e9dd2cc766cd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240724130711epcas1p3a6b887e2f40e3430e22d739093485cc6
References: <20240723105412.3615926-1-dongliang.cui@unisoc.com>
	<CGME20240724130711epcas1p3a6b887e2f40e3430e22d739093485cc6@epcas1p3.samsung.com>
	<ZqD8dWFG5uxmJ6yn@infradead.org>

> > +static int exfat_block_device_ejected(struct super_block *sb)
> > +{
> > +	struct backing_dev_info *bdi = sb->s_bdi;
> > +
> > +	return bdi->dev == NULL;
> > +}
> 
> NAK, file systems have no business looking at this.  What you probably
> really want is to implement the ->shutdown method for exfat so it gets
> called on device removal.

Oh! Thank you for your additional comments. I completely missed this part.
I agree with what you said. Implementing ->shutdown seems to be the
right decision.


