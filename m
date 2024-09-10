Return-Path: <linux-fsdevel+bounces-29005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28743972D98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34461F26430
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35218EFC3;
	Tue, 10 Sep 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qNQu/qqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92F18DF94
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960370; cv=none; b=nDUGEnVO88tzN09YeugBhqu39xHBN3dVCzlCrQR/FDtGIGkZ84WOh65L+Y/oCeiiG0zfGR8h/bvDZVksF10v+DrqIDJ8FHL00T6KO00Wk4yOEqZL1sg+EzNNRUg7aNk1nCnrSW8eIMXLJA0J/DZqdXgwqukr5txgTgrvmJHoI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960370; c=relaxed/simple;
	bh=D/buzGYQkufERse75SSjj/vuDr0eYjohZXOoq1FQWj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Qmq75TOTK9hSF8Rzzhbc+UaWqrYZysE2YiI0OS+brvgYhpJ2wn/ckH9SxNGe9eNJJysLbjBpMjOM2cK1AKkOsPBmfULGJWR5YuuShQYH8XnbbbcfgdUnNal8VddCEFO6fXtZxmCvG1FBG8oe4frBELMbLYPwrdWLF86zOd8HKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qNQu/qqc; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240910092606epoutp01492327ea8c011ea657bbb5ffcd220e00~z188YN4Tw2494824948epoutp01i
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 09:26:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240910092606epoutp01492327ea8c011ea657bbb5ffcd220e00~z188YN4Tw2494824948epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725960366;
	bh=MtY5qZOPVIGordnCBFvzVrBfTMRjvMNrDfO7tPymv9k=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qNQu/qqciECo7N+Qr5su9Pn5p1DrkHX7PcmkcbYMNwLTMna70vEU9XE3Oyqru/qv8
	 wLGPiEhl3CbffRzyva8rLXOQdQBCjh5T2EpVpv24jVCnJfIltYRWDww1UnaakT6aPP
	 zg+y+20EjuSJC5O9IGKGrQ++WIIIUh71iCixLdx0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240910092606epcas5p1b482ec48592d08e606bf0c1ad7fb2ce6~z187_8Kmq2995129951epcas5p17;
	Tue, 10 Sep 2024 09:26:06 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X2yxS43Btz4x9Pp; Tue, 10 Sep
	2024 09:26:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7D.F0.09640.CA010E66; Tue, 10 Sep 2024 18:26:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240910092604epcas5p4d01dec7422c7990882f6453c52a78075~z185-cxiQ0887908879epcas5p42;
	Tue, 10 Sep 2024 09:26:04 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240910092604epsmtrp2fa22a8c1a088d03d2222bc0993458c5d~z1859dXm12757627576epsmtrp2k;
	Tue, 10 Sep 2024 09:26:04 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-d8-66e010ac0e90
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.E9.19367.BA010E66; Tue, 10 Sep 2024 18:26:03 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240910092559epsmtip21e15ace98c8e2bda39a2dbad69522f80~z182IcM510197501975epsmtip2l;
	Tue, 10 Sep 2024 09:25:59 +0000 (GMT)
Message-ID: <c9289a2f-ecb3-7e3e-c5d9-336ce2bc09a7@samsung.com>
Date: Tue, 10 Sep 2024 14:55:58 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 5/5] nvme: enable FDP support
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org, jlayton@kernel.org,
	chuck.lever@oracle.com, bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, Hui Qi <hui81.qi@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <ZtsoGX2QY-TjBolb@kbusch-mbp.mynextlight.net>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTHdx+0hVFzLa8fZBtd2SNgoJSVekHp3GzYZS4Gh0BituAdvTwC
	fdDbTpxLqKIyMcDEANIhrRQwgBuKhMeQBMsYMmCQIQM72+Eom0gcCFsmoLCWyxj/fc7J+Z5n
	DgfhnWQHcDKVWkqjJLMFLA+0rTf4zdBr2FRa+JT1JbzJVsLC53oXIbx8YRnB121/wPi9nk4Y
	b2jqg/HO+q/Z+FcV+TDuaDYg+I0SDj59f4mNL9c3svFSy88Q3m3dhf9U8x5+q3sAxY31M2z8
	/EQHC7/avwbjbatGBP9mbh7FRwxV7H2+xNjdA8SI/QZKlJf+wCLGhnVES+M5FnGzNo/oMi3B
	RNc9PYt4MmNFieLWRogYMn3HJpZaXon3PJK1N4Mi5ZSGTylTVfJMZXqM4EBCyv6USEm4KFQU
	he8W8JWkgooRyD6ID43NzHaOK+B/SmbrnK54kqYFQulejUqnpfgZKlobI6DU8my1WB1Gkwpa
	p0wPU1LaaFF4eESkM/BoVkb/chtL3eSZe350ma2HTnkUQu4cgIlBa8EcqxDy4PCwLghcrbmL
	MMYiBEZbpt22jOqyGmcYZ0NSvw4z/k4IrDZc2VQ8hoDd2uTmysvFpOB5tx51CVDsdTDRe4hx
	7wQDlQ7UxT7YJ2BlvApysZcz58SdecTFCOYHrA4j7GJvLAjYjJUbTSCYGQWPisxurpwsLBiM
	XtS50B2LBhfOHGakgaD9cdVGOwAzu4PLD6/AzJgyUDfdjjLsBR71t7IZDgBLf3azGM4CU79N
	bcZ8DjpuFrsx/DbQP5vcKIs4yzZ/K2Rq7QBFqw6YWQkXfHGWx0S/CuylM5tKP/DgUu0mE6C5
	/nt4a1PdFxeQLyG+YdtWDNumN2wbx/B/ZROENkL+lJpWpFN0pFqkpI5tnTtVpWiBNn4hJK4D
	sk0thFkgmANZIMBBBN7cEqk9jceVk8c/ozSqFI0um6ItUKTzOheQAJ9UlfOZlNoUkTgqXCyR
	SMRRb0lEAj/u3JnLch6WTmqpLIpSU5r/dDDHPUAPF/FrM6JNtz3gyhz2eM2Hg++/VpFqNuV4
	7RdGhvpOJyKZytv5J+IjZMWri4qQuOqRfcefNu9e6zPGkrRF+8vfpqDcPfNnf3VP9JUW+2PU
	scDFAfmh5GdlUqHu3QTzuI+DJqnTuuv5wbs4CUkVEfOZt+pGhx5U+x+U3RmOO7ocBj/sseZO
	KJJmV/4C92fLn58IMa69EHXYS2y+jj6VJmi8n9jqftyTY2jP66FnT5+C1Od2SB3J3KDYl6Vl
	oncC7dcGFiryFtKEicO8Urde2ZEXbQ3W9TH9P5aCWnPL74OKjwomgyYLjXYVKyZp9WRJ8seI
	4g3P/IMBK8I+yaXBnb1DApTOIEUhiIYm/wVws0vWlAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSvO5qgQdpBvcm2VisvtvPZvH68CdG
	i2kffjJb/L/7nMni5oGdTBYrVx9lsti5bC27xezpzUwWT9bPYrbY2M9h8fjOZ3aLn8tWsVtM
	OnSN0WLvLW2LS4vcLfbsPcliMX/ZU3aL7us72CyWH//HZLHt93xmi3Wv37NYnJ81h91BzOPy
	FW+P8/c2snhMm3SKzePy2VKPTas62Tw2L6n32L3gM5PH7psNbB4fn95i8ejbsorR48yCI+we
	nzfJBfBEcdmkpOZklqUW6dslcGUc/7mNrWA1T0X3hZ/sDYxNXF2MHBwSAiYSy/4zdTFycQgJ
	bGeU+Dipn7GLkRMoLi7RfO0HO4QtLLHy33N2iKLXjBLTzv1iBknwCthJ/N3bwAIyiEVAVeL6
	4UCIsKDEyZlPWEBsUYEkiT33G5lAbGGgXddPvAdrZQaaf+vJfLC4iICyxN35M1lB5jMLLGaR
	2LRxGxvEsreMElM3XmADWcAmoClxYXIpiMkpYCUxsTUEYo6ZRNfWLkYIW15i+9s5zBMYhWYh
	OWMWknWzkLTMQtKygJFlFaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZw7GsF7WBctv6v3iFG
	Jg7GQ4wSHMxKIrz9dvfShHhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQW
	wWSZODilGph2m7ya35ot5KP/YYb6hKd5wsctNNOaz+lnb2Fry96Rd13xnb5VcnLw+wM/z7v5
	3A1z3HYjc+pNA5eOJH/2Lf/+52hUT+BcU2vYlu/xzWyv+SPpcot/k9LZpIzW3dgUfWfbllXV
	h7rkhSZe10q4duqRRJxgvS0nu9QnEcl7whOL5mpGvLyuUBRw0zzSXPl0RXffckP9/bebOL/e
	rT6/wu7y7efzNPfkbFqTGCkrfP69UVVQ/svtn79VXG+5kS/Bl5D3RatH21yzzcomI3WOTYtX
	Lc80q4NXXumcMO1dLn3yPI941ZwV7z+bO52333cieVOjY9+FBw1XHsg55LzT5Tq7YobzRu8X
	LM6zVcz99iqxFGckGmoxFxUnAgBTa/iJbAMAAA==
X-CMS-MailID: 20240910092604epcas5p4d01dec7422c7990882f6453c52a78075
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171430epcas5p3d8e34a266ced7b3ea0df2a11b83292ae
References: <20240826170606.255718-1-joshi.k@samsung.com>
	<CGME20240826171430epcas5p3d8e34a266ced7b3ea0df2a11b83292ae@epcas5p3.samsung.com>
	<20240826170606.255718-6-joshi.k@samsung.com>
	<ZtsoGX2QY-TjBolb@kbusch-mbp.mynextlight.net>

On 9/6/2024 9:34 PM, Keith Busch wrote:
> On Mon, Aug 26, 2024 at 10:36:06PM +0530, Kanchan Joshi wrote:
>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
>> to control the placement of logical blocks so as to reduce the SSD WAF.
>>
>> Userspace can send the data placement information using the write hints.
>> Fetch the placement-identifiers if the device supports FDP.
>>
>> The incoming placement hint is mapped to a placement-identifier, which
>> in turn is set in the DSPEC field of the write command.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Hui Qi <hui81.qi@samsung.com>
> 
> I'm still fine with this nvme implementation.
> 
> Acked-by: Keith Busch <kbusch@kernel.org>
> 
> The reporting via fcntl looks okay to me, but I've never added anything
> to that interface, so not sure if there's any problem using it for this.
> 

The difference comes only in the fcntl interface (hint type/value pair 
rather than just value), otherwise it piggybacks on the same kernel 
infrastructure that ensures the hint is propagated fine. So I do not 
foresee problems.

And FWIW, we have had precedents when a revamped fcntl was introduced to 
do what was not possible with the existing fcntl. Like: 
F_{GET/SET}OWN_EX over F_{GET/SET}OWN.

Per-file hinting has its uses, particularly for buffered IO. But the 
current interface can only do data-lifetime hints. The revamped 
interface may come handy for other things too (e.g., KPIO).

