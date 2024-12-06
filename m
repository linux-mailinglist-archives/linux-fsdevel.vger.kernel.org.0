Return-Path: <linux-fsdevel+bounces-36616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD259E6987
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 10:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6757828325E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACE1DDA0F;
	Fri,  6 Dec 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HzaaIgkj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED575197548
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475647; cv=none; b=PQceIsLyfRcBTiSaaMAv2eUfMTJ/QJOtps0t5FBScyuxdcOXUZS7CuDvYyAEcHtyWuCPFW5A6GuQHGQhjkQTV8wx7O8211E4Ms0SpgAnoEOSvKeFSm8CVoW6OtZ24EWSoOLg1ioKlUMUAAx2/xj3XslG1RXVl7UNe7H3nXzIRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475647; c=relaxed/simple;
	bh=h/jMTotFuxnM0D2p4HTTUDkXP73GNC6bPT53ah0AYjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=X7kl4aR2iUbZyRf+w9zi9nN4Q6ggm0QW4l/wG7zHRLno0U/18H2u5La5H0uvJVAYbgmCJxvGZlB6s0p1m95XGhODrbJYDUDMr8+OEXTKXNuoEE421UrOYWLovUJJxfIqDYLM+AMdScZs9VsJ4yHoJLwTzEETqhlOLXnao8IiffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HzaaIgkj; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241206090032euoutp0173540aea69e4f10bf51c366e10479b90~Oiucomio62049720497euoutp01D
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 09:00:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241206090032euoutp0173540aea69e4f10bf51c366e10479b90~Oiucomio62049720497euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733475632;
	bh=HA8XSRBC3z58+YB/XdZO/a+P0mv6PxJbXV4aXju2atk=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=HzaaIgkj8DxvSOsBOr1D0l2Q4ywGmOthLXeFo+BkuectJRpyuYQfyOLGU4xjy8+jd
	 atNE8VndF1GymNOaFxV7q/sR3QUhao3aIMCggPpYR2YcyjYcu8Qr6uGEwG7SF2I5pd
	 H6YyqlufyGrXgKkKPMO8DqSzpStSWrRomSVaylOI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241206090031eucas1p2a813c3ed1fbd02894040d67b8fa20946~OiucdsgKq2802828028eucas1p2d;
	Fri,  6 Dec 2024 09:00:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id DD.C6.20821.F2DB2576; Fri,  6
	Dec 2024 09:00:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241206090031eucas1p23196c2e72cd04cc3e53021f485935520~OiucM5pDV1630416304eucas1p2-;
	Fri,  6 Dec 2024 09:00:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241206090031eusmtrp2d7fe022f7cddcbf13f0f62aa2f9df49f~OiucMWp5Y1198711987eusmtrp2b;
	Fri,  6 Dec 2024 09:00:31 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-73-6752bd2fccfa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 5D.0B.19920.F2DB2576; Fri,  6
	Dec 2024 09:00:31 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241206090031eusmtip286041ac4a65551e20b09044aafb68f28~OiucEIvHF3075630756eusmtip2q;
	Fri,  6 Dec 2024 09:00:31 +0000 (GMT)
Received: from [106.110.32.87] (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 6 Dec 2024 09:00:30 +0000
Message-ID: <795962d3-0bab-47d0-9254-df0e98e3a314@samsung.com>
Date: Fri, 6 Dec 2024 10:00:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/config: use modprobe -w when supported
Content-Language: en-GB
To: Luis Chamberlain <mcgrof@kernel.org>
CC: <patches@lists.linux.dev>, <fstests@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gost.dev@samsung.com>,
	<sandeen@redhat.com>
From: Daniel Gomez <da.gomez@samsung.com>
In-Reply-To: <Z1Ing_noobsMJCRS@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOV39vUHpBj+/6lmcbtnLbrFn70kW
	ixsTnjJaXD5xidFi+hZHB1aPTas62TxebJ7J6PF+31U2j8+b5AJYorhsUlJzMstSi/TtErgy
	dn3YwVKwnqviUONNpgbGiRxdjJwcEgImEj1PX7GC2EICKxglNt337mLkArK/MEr8erGcGcL5
	zCix6OM7VpiOW89WMUJ0LGeUmPu1Bq7oTuM5FghnB6PE+ravYFW8AnYSH2/vBbNZBFQk7k+a
	wAIRF5Q4OfMJmC0qIC9x/9YMdhBbWMBJ4k57GxOIzSwgLtH0ZSXYZhEBDYl9E3qh4t2MEms3
	CYDYbAKaEvtObgLr5RQwk3i2fhHQLg6gGiuJ6Sc8IcrlJba/ncMM8YCixIyJK1kg7FqJU1tu
	MYHcLCHwgkPizd1GqC9dJD4+fssOYQtLvDq+BcqWkfi/cz4ThJ0usWTdLKhBBRJ7bs9iBdkr
	IWAt0XcmByLsKHHsy1IWiDCfxI23ghDn8ElM2jadeQKj6iykgJiF5OFZCA/MQvLAAkaWVYzi
	qaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIEJ5vS/4592MM599VHvECMTB+MhRgkOZiUR3sqw
	wHQh3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGJv8TC6rU
	DFfPuz//eRLT0RX1RzUYLrdktJfu27Uq/+fn1exrpnJzb+ObYCy2as96AePXonYStbsTNrqt
	tlrFM/UWy7IXPtwHciT0bQ5GnlP5zFu6M3Ree5ns8p/NJaX2BnHdffsmPZnG+My4Ku9M7rwn
	T12LTPM+t6g7P3sSuWrxpt/LaraE8O1W+N4zWf/9jWXHtDaKX8ys+bPnLu+1cob9uZu2Vs88
	y7Px2mGjaJeCGZl/DQN4eM6JK/8NEUqPqPSKn3xU8lhsW9tBDZ/bYoxC/fNS5k3buLrz7h+3
	9BsMMz9ceffn3OqFRy9Ntpb/V+WnP/XMyVLr7bIpDPsdT288fqL3n2u9VpviDqbrxg1KLMUZ
	iYZazEXFiQD87yxnnwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7r6e4PSDaYul7M43bKX3WLP3pMs
	FjcmPGW0uHziEqPF9C2ODqwem1Z1snm82DyT0eP9vqtsHp83yQWwROnZFOWXlqQqZOQXl9gq
	RRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl7Pqwg6VgPVfFocabTA2MEzm6
	GDk5JARMJG49W8XYxcjFISSwlFHi0OLzzBAJGYmNX66yQtjCEn+udbFBFH1klPgx+xMLhLOD
	UeL9gTOMIFW8AnYSH2/vBbNZBFQk7k+awAIRF5Q4OfMJmC0qIC9x/9YMdhBbWMBJ4k57GxOI
	zSwgLtH0ZSXYNhEBDYl9E3qZQBYwC3QyShy8PQlq9VtGiXVvjoJVsQloSuw7uQlsEqeAmcSz
	9YsYISZZSCx+c5AdwpaX2P52DtQ/ihIzJq5kgbBrJT7/fcY4gVF0FpIDZyE5ZBaSUbOQjFrA
	yLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMEa3Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuGt
	DAtMF+JNSaysSi3Kjy8qzUktPsRoCgylicxSosn5wCSRVxJvaGZgamhiZmlgamlmrCTO63b5
	fJqQQHpiSWp2ampBahFMHxMHp1QD05ZFUVffcye9miUc3/Tzv8+yCQ+mdLectJZ+syzwdpBN
	v/guW977XhKuUdPiWK2U5G/fi1I/GfBguSQraz1fhfC9uUyvNz+4VdzX4R0lVlAYzlsl/dk5
	sm/LhF+rTG7aypR4h0tzf6ryyrzzaVJwreEsVj3u2GPFF120lgl2HM48FfnZcmtydjF3tEMJ
	56oNxkqPtbf9z3259MS5iJOWZh77A88Y+NhmJM0tkltc0CAZ+UIpk6cpbkuisRSv3sI5B/M2
	CnpeOLvk7hFzvvsTBZrXZbrXOzj9mHT1dEvE/+avkf9tpm5iVV27c6MdG5PLyrPsTKwX2FX+
	GD0WuvVq2bwFB/iWiG06K7pX/nmOEktxRqKhFnNRcSIASM5pMVoDAAA=
X-CMS-MailID: 20241206090031eucas1p23196c2e72cd04cc3e53021f485935520
X-Msg-Generator: CA
X-RootMTR: 20241205002632eucas1p1550f6c9513d111b21cb22cacb09ed680
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241205002632eucas1p1550f6c9513d111b21cb22cacb09ed680
References: <CGME20241205002632eucas1p1550f6c9513d111b21cb22cacb09ed680@eucas1p1.samsung.com>
	<20241205002624.3420504-1-mcgrof@kernel.org>
	<95e41652-65c9-4fd7-9cc4-344b90b006b6@samsung.com>
	<Z1Ing_noobsMJCRS@bombadil.infradead.org>

On 12/5/2024 11:21 PM, Luis Chamberlain wrote:
> On Thu, Dec 05, 2024 at 08:41:22AM +0100, Daniel Gomez wrote:
>> On 12/5/2024 1:26 AM, Luis Chamberlain wrote:
>>> We had added support for open coding a patient module remover long
>>> ago on fstests through commit d405c21d40aa1 ("common/module: add patient
>>> module rmmod support") to fix many flaky tests. This assumed we'd end up
>>> with modprobe -p -t <msec-timeout> but in the end kmod upstream just
>>
>> I can't find modprobe -p and/or -t arguments in the manual. What do they
>> mean?
> 
> I had proposed -p to mean patient module remover with a default timeout
> set, -t to override. In the end this went upstream instead over a lot of
> dialog with just -w <timeout>.
> 
>> but i can't find the module remover support in kmod.
>>
>>
>> Nit. I find useful using the long argument instead of the short one (e.g.
>> --wait instead of -w). as it's usually self-descriptive. But I guess we
>> don't have that long option for -p and -t?
> 
> It was one or the other that went upstream, we implemented this on
> fstests upstream as an open coded solution while we wanted for this
> meachanism to be agreed upon and merged. I just forgot to come back to
> this after -w was merged and decided upon.

Thanks for clarifying.


> 
>    Luis


