Return-Path: <linux-fsdevel+bounces-44615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F9A6AAD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D3F3AB8AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68C74BED;
	Thu, 20 Mar 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mKTXmvAW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B331EB198
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487229; cv=none; b=BX8xLoXglzq9b9IfjR7TiU37uUgpCwLL81jBVDelvAi2zNcN+/kj3Oc+IQoOzHyjGd9pzL12JbxkTgbWiEPq+KzTLNi/WvhsmVaeHDzdXxF0tfZxTa9z61my+1K9TutYPR8YXklMsTdnpVUZw6g8u3CJQDixJLq28jzSsBYXYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487229; c=relaxed/simple;
	bh=BqjdSgiXP93170tlNOugnnP/KUOYumTk/f1yaoXR0XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=JWqCDIZfP3i2ZqCvFyiBc5QVkIrC09NNYEFHLlbbpsKtHOA4ekruh+FHcZWIAm8JM9T/L965hM/XWiZmh0I2zPlNFMucBWEzWr6rwOC7pGr2agvUPqf7/7r9c8iltGovbFis8DmD5NEn75nijy4H0RL4yHOaZ+EKMVB/MS4xNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mKTXmvAW; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250320161339epoutp035e4e887a867f515027c4e22eaf003c32~ujuTu_1Gy1745117451epoutp03L
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 16:13:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250320161339epoutp035e4e887a867f515027c4e22eaf003c32~ujuTu_1Gy1745117451epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742487219;
	bh=1QhXPUc+UhsbA3QNDxXoX2eKXdOw0cgYCugrDd2js8Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mKTXmvAW2l6BMRPv6hVoOS7GlBcBv3c58LsOpkCGvuVHLLusUxnpRooDLf1EYqvSD
	 HuLEanTr/hEErOJnpJT4t3PEGueerPXNxe7OiR8gOruUZrSg1/6cWy6rBS4rNwCVp4
	 Iv9g5yRFW/xz0AroyEnSvL2/X6bCi0/DcEqLES30=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250320161338epcas5p3300497d14102a14142b36f46515e39a6~ujuSqt-RI0817008170epcas5p3l;
	Thu, 20 Mar 2025 16:13:38 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZJVxX4mxsz4x9Pq; Thu, 20 Mar
	2025 16:13:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.3B.19710.0BE3CD76; Fri, 21 Mar 2025 01:13:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250320161335epcas5p2709afc3ff29ffec350164003b511f92d~ujuQEy8Ch0265102651epcas5p2M;
	Thu, 20 Mar 2025 16:13:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250320161335epsmtrp241cc853355b1a879f392060c68c9cbd8~ujuQDsIZq3146031460epsmtrp2o;
	Thu, 20 Mar 2025 16:13:35 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-8e-67dc3eb0b364
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.43.18729.FAE3CD76; Fri, 21 Mar 2025 01:13:35 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250320161332epsmtip13339e115f8abf0a704f8b543d976a2d5~ujuNIqF5u1448214482epsmtip1d;
	Thu, 20 Mar 2025 16:13:32 +0000 (GMT)
Message-ID: <796adeb4-2b7e-4d01-866b-1f47b6eb10e5@samsung.com>
Date: Thu, 20 Mar 2025 21:43:31 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
To: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	david@fromorbit.com, leon@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	joro@8bytes.org, brauner@kernel.org, hare@suse.de, willy@infradead.org,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <Z9w7Nz-CxWSqj__H@kbusch-mbp.dhcp.thefacebook.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TWVBTVxjm5N4sMAWvEeXIQ4mZWgYsmGCgBwuhM2XayzI2M07t8tA0E24D
	Q0hiFitahgyboIWwaWkUtSClQKsYGAQhZVFphYqUFIS0QZDwUBYR6JQCbWk2W96+8/3f969z
	WBjbwAxkpSm0lFohkXMZPnjbnZCQsGbhrzLextmXUJPNwEDzd1YAuvBsHUNLljYaau2fBMhi
	90MTPR001FVTTkMNTfdoaHijHaCii81MVN43BlDlRh2GzNYDqMt8H0eT32zR0XfzZgyNl84C
	tFqXx0S9A4VMdH1+CUebf15ivL6HtPdeppGWn5PIgRpIdhhtTPLh5E2cbPk6lLQ80JGmxiIG
	aVopZ5IV4/WA7JzQM8jlWStOlrQ2ArJl8DS5anpRtOOD9JhUSpJCqTmUQqpMSVPIYrlJR8Vv
	iCOjePwwfjR6lctRSDKoWG58sijszTS5Y3gu54RErnNQIolGwz0ojFErdVqKk6rUaGO5lCpF
	rhKowjWSDI1OIQtXUNrDfB4vItIh/Cg9daN6mK4q9T7ZvKXWg2vMs8CbBQkB3DTZHdiHxSY6
	AXxa00VzP1YANCzn0JwqNvEHgGsFp547nlU+YLh5M4CN1TK3YRHAHz6bAM6ALyGEU0UGlxkn
	9sPf6to8/E54/ws77sS7iSD42FrlamMXkQhHlrpdSf2JBDhx/nOGMylG2DDYPmZ0BTAiAFrt
	VxxJWSwGEQKHK3RO2puIg+sr/R5JELy1eAlzeiFxyxvaegY9c8bDheLbdDfeBee+b/XwgXD1
	qZnhxulw6skU7safwvaWEo8+Dur/Gqc762KOujduH3TX8oPFm3ZXO5DwhYUFbLd6H5wsn/U4
	A+B01TUPJuHgeAPu3lUZDdZZG/BSwDFuW4tx25TGbeMY/698FeCNYC+l0mTIKGmkiq+gPvnv
	3FJlhgm4fkZofDsYv/JPeB+gsUAfgCyM6+/rX/iLjO2bIsk8RamVYrVOTmn6QKTjPmVY4G6p
	0vG1FFoxXxDNE0RFRQmiD0XxuQG+uR15MjYhk2ipdIpSUernPhrLO1BPe/u99+dDE4ePliRn
	q/Yc95qeDlurb5qdGUX7Z6bezQ0ePSSViRNLbEf8KmQDaWcsq1vFufvMP5q+xLUvJH21UHLM
	z8JMWV8z/TRU2FMVcr2GOl2SMK+tjRtQj2gr946Kk7O2kvINd4948YRNj8/bOBF3O+nczpz8
	LP9HAoZ16BXGWztu5L7sN/f3OcPv5Qn9tctPgmNeuynN9lm5ly/uvjBTsMotG8iJGDrcLQpo
	0l82aKz5+vCR8AUChB4vzTv54VxQjf0YZ5SdJZ66esZWtHFAeO5EptejwrHa1I+rlY3dskyR
	fKctuHYxuLR2hJ5fUfmw91uzaFnX8M5Fq7BeIsrm4ppUCT8UU2sk/wKQrvlbogQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO+d4drZaHpfpl9ptUHihlSXxhWUXiI5alFlEQpeRp1XqlM1p
	WcGsEGeXqU3LaSss081VtnmlTFslalTSbDVzdmFRZqUtArWL5Vbgv4fnfW4/XgoXfCYCqP3S
	dFYmFScLSR5Rf084a8GNqF7Jorq6MFTtUJNo4J4LoOKhERwNWusxVNvWB5DVORXZW5swdLu8
	EEP66gcY6hptBEhVWsNBhRYbQJrRChw194Sh280dBOozjnmhOwPNOHqR/w6gbxUnOOhuZy4H
	XR8YJNCP4TJylR/jvKvDGGt3LNNZDpkmrYPDPOm7STDmqlDG+kjBmAwqkjG5CjnM2ReVgLll
	V5LM13c9BHOm1gAY88PDzDfTrE3eCbzliWzy/gxWtjBqN2/f6IUur7R87sGaMZkSXOHkAS4F
	6Qg4pHlE5gEeJaBvAXhsqBd4Dv7wuG34n2ga1P9+z/GIBgB8XnXGLeLTUfC1So2NY4KeB/sr
	6v/xPrCjxEmM4+n0bPiq57w7aBodA58OtpDj2JeOhvaic+5mnHbg0G5wEJ6GAgwatGq3G/87
	o8d58W8DRZF0COw6qxinufRKOOJqIz2SpTCvLg948GzY8LkMzwcC7YQd2glJ2gkW7QTLJUAY
	wAw2TZ4iSZGHp4VL2UyRXJwiV0gloj2pKSbg/ojQkEbQYBgSWQBGAQuAFC705fvmvpQI+Ini
	Q1msLHWXTJHMyi0gkCKE/nz/D6cTBbREnM4msWwaK/t/xShugBITqURv5pQGvsnNiinxrlow
	PS4us9Gp10fsCihQFIflt228tjaoLjgzNGOzjctV2x8e6HiZ2YLV2HRrlWa1wCeeyjqnB5Fq
	jaV92dWA4tb+x8YtJ3f4roteUVqyl9nmCBmNm1xr+tQfZAkyrl5h//nlY2dgzMaMZ92BcxNO
	8S7nGBtcpV5v7yjnz0zlpSt/FmwfWemzxng/tiyn/COxQTcWuzc5J3sJX3fJ3L0t+H78jqQo
	v8U3NdGFP37Ft2eQp13V+iO6JRxnhKNp+ffr6VMqW9tbZ5zK3jMpyft75FTpVrReg/sdshGD
	TS0l2qNFsb3mnerhyGxVTeTj4MqYyX0JViEh3ycOD8VlcvEfOW2zHoADAAA=
X-CMS-MailID: 20250320161335epcas5p2709afc3ff29ffec350164003b511f92d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250320155856eucas1p1e98451f76fb93feebc7e4bb497e8155f
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
	<20250320141846.GA11512@lst.de>
	<a40a704f-22c8-4ae9-9800-301c9865cee4@acm.org>
	<CGME20250320155856eucas1p1e98451f76fb93feebc7e4bb497e8155f@eucas1p1.samsung.com>
	<Z9w7Nz-CxWSqj__H@kbusch-mbp.dhcp.thefacebook.com>

On 3/20/2025 9:28 PM, Keith Busch wrote:
> On Thu, Mar 20, 2025 at 08:37:05AM -0700, Bart Van Assche wrote:
>> On 3/20/25 7:18 AM, Christoph Hellwig wrote:
>>> On Thu, Mar 20, 2025 at 04:41:11AM -0700, Luis Chamberlain wrote:
>>>> We've been constrained to a max single 512 KiB IO for a while now on x86_64.
>>> No, we absolutely haven't.  I'm regularly seeing multi-MB I/O on both
>>> SCSI and NVMe setup.
>> Is NVME_MAX_KB_SZ the current maximum I/O size for PCIe NVMe
>> controllers? From drivers/nvme/host/pci.c:
> Yes, this is the driver's limit. The device's limit may be lower or
> higher.
> 
> I allocate out of hugetlbfs to reliably send direct IO at this size
> because the nvme driver's segment count is limited to 128. The driver
> doesn't impose a segment size limit, though. If each segment is only 4k
> (a common occurance), I guess that's where Luis is getting the 512K
> limit?

Even if we hit that segment count limit (128), the I/O can go fine as 
block layer will split that, while application still thinks it's single 
I/O.
But if we don't want this internal split (for LBS) or using passthrough 
path, we will see failure.

