Return-Path: <linux-fsdevel+bounces-17633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B7B8B0B6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A920B1F27DCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F4B15CD6F;
	Wed, 24 Apr 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZC8TFlTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69815B0EE
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966314; cv=none; b=AEFvAc8NgeIkQzzEDV2aUDr3Pzxby7c07InTScc9wPteHmwbArU7yc0XTwJu7Cxo307QTkWrI7e7wfFiy+9B/zArHytJszWuCqLGELH1TjyXYpaugskOPEuWGARbx3TQkScly+S0wL/wvm7+1t+aWawj03IKMsIlRV3wqbKpcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966314; c=relaxed/simple;
	bh=QhHYOL3gvq1hWSameigx2a1P75ciHtIkjmfoUmo03H8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=lWQByXVRDkDVx23O6yxNjM6yQekBt9+mBQL34Q/3lJ7X13jtRPiaTomsvMy9+Pq55d2M56B94oVQo+FcdjbWk7toqW4YfZiYB3LaB5KFU/Ki2kX7rp181QTVbkqhbqBr5wuVt+KBCqDz+UNzqaRoYNJm6RzsHkOrfKHkyDoDC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZC8TFlTW; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240424134502epoutp037408dec3db9b557a3ad8520d3a21391a~JO0VyOAGo0058600586epoutp03E
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:45:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240424134502epoutp037408dec3db9b557a3ad8520d3a21391a~JO0VyOAGo0058600586epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713966302;
	bh=MT5IbycScESiYFhH/mzXSrhPIZC13moMo1sF3a2s5Ak=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ZC8TFlTWhePHkGzwR1gWpfhOCUUXHt3/GEAnkLKe58XxnvHkYrZZjgHalOhc0lIfn
	 1g5BTnDv6TSjUUQqvUw66TEdjpBAC74KRDYTruozFSQ1yZZDmdRYTZ7rdCth0Qc4U7
	 ZYWEwwCbd+D1pxZPudUY7aTGCGIK3qfA0ZkXTwsM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240424134502epcas1p49479fb066d39e872b18de809d6004f75~JO0VTrCd60048000480epcas1p4L;
	Wed, 24 Apr 2024 13:45:02 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp2.localdomain
	(Postfix) with ESMTP id 4VPgGQ0jFVz4x9Pt; Wed, 24 Apr 2024 13:45:02 +0000
	(GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240424114012epcas1p1356faa4d9906b8e14441ce5ce190c61f~JNHWSuYn52102221022epcas1p1J;
	Wed, 24 Apr 2024 11:40:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240424114012epsmtrp10d53056830fdd6ddc09e45133cb24987~JNHWSFYEM1121511215epsmtrp1B;
	Wed, 24 Apr 2024 11:40:12 +0000 (GMT)
X-AuditID: b6c32a2a-cb1fa700000020c6-f5-6628ef9c785f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.68.08390.C9FE8266; Wed, 24 Apr 2024 20:40:12 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240424114012epsmtip1c3dbf4bb622cd2e112c3edbed3e3dfa1~JNHWJVcz10216102161epsmtip17;
	Wed, 24 Apr 2024 11:40:12 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>, <cpgs@samsung.com>, <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB6316B43EC39999D94F8F011E81102@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1] exfat: zero the reserved fields of file and stream
 extension dentries
Date: Wed, 24 Apr 2024 20:40:11 +0900
Message-ID: <1891546521.01713966302080.JavaMail.epsvc@epcpadp3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIYb7jVRJLYLEtRTVxvT7Lp6UXOnAHATqsHAb21P0IBKCyVbbDWZR4g
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnO6c9xppBivmaFu0HtnHaPHykKbF
	xGlLmS327D3JYrHl3xFWi48PdjNaXH/zkNWB3WPTqk42j74tqxg92ifsZPb4vEkugCWKyyYl
	NSezLLVI3y6BK+PFHteCiawV/a3bGBsYfzF3MXJySAiYSKxYNQfI5uIQEtjNKDG9+RdTFyMH
	UEJK4uA+TQhTWOLw4WKIkueMEltuzgDrZRPQlXhy4yeYLSJgKvHl8gk2EJtZoJ1R4t23WBBb
	SGAzk8TTHmEQm1MgVmLF0rWMILYwkH2s5xYzyHwWAVWJ5SsVQcK8ApYSp9/vY4SwBSVOznzC
	AlLCLKAn0baREWK6vMT2t3OgrleQ2P3pKCtIiYiAm8T3y1UQJSISszvbmCcwCs9CMmgWwqBZ
	SAbNQtKxgJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcNRoae1g3LPqg94hRiYO
	xkOMEhzMSiK8v/6opAnxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgm
	y8TBKdXAVNm+S+BCQ6XhjbXaJzO6BRfwzpkisP23Y1jGon6Fhz78R57o8Rdzv1jKr36f/Wdp
	gZHBao34BrFtL6MSxEOfyWx80fT9+EPr3be3sqYr8N3b+Ov0UuGqaN1PLBaqcjuOxqyWLj3Z
	7nL05s431rbZnP8tukLmTz5sIsS3nssk5pvs7crLPjknFR/6BpW8jzGcXG5SuSG6cN6TLYFC
	mx84JLyNmSy5/pKt7OKTkxzmbjcw/DvZjDEpSmvzstnMIsLNITuumh7fVVkS8+S47f6iY/Pm
	Tz7SwSi12c3CpfLDa7uzx41zQr0ndYm3MzGvbQtab+8eNfvo73yfM08mHp2xLaWt3ZSx7ej8
	4A7buHU/lViKMxINtZiLihMBZgN2HwkDAAA=
X-CMS-MailID: 20240424114012epcas1p1356faa4d9906b8e14441ce5ce190c61f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20240423022908epcas1p2e3f94bde4decfd8dca233031f0177f58
References: <CGME20240423022908epcas1p2e3f94bde4decfd8dca233031f0177f58@epcas1p2.samsung.com>
	<PUZPR04MB63168EFB1C670A913C42E80981112@PUZPR04MB6316.apcprd04.prod.outlook.com>
	<1891546521.01713933302009.JavaMail.epsvc@epcpadp3>
	<PUZPR04MB6316B43EC39999D94F8F011E81102@PUZPR04MB6316.apcprd04.prod.outlook.com>

> > BTW, what about initializing the entire ep (fixed size of 32 bytes)
> > to 0 before setting the value of ep in each init function? This is the
> > simplest way to ensure that all other values are zero except for the
> > intentionally set value.
> 
> Yes, initializing the entire directory entry to 0 is simplest way.
> But 48 more bytes are set to 0 (the total size of the reserved fields is
> 16 bytes).
> 
> I think both ways are acceptable. If you think initializing the entire ep
> to
> 0 is better, I'll update this patch.
It may be more efficient to initialize the entire ep of size 32 bytes at
once.
I will wait for patch v2. :)



