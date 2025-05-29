Return-Path: <linux-fsdevel+bounces-50101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4DFAC824C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46A71BA7763
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072BD231A30;
	Thu, 29 May 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WPXdHRsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2D22E3E2;
	Thu, 29 May 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748544531; cv=fail; b=sj/5vHqrrP9POducuRN7ZuA1dZ+e8z1m54U04kbIYkL9+Q72GzurTZ+UBdOA9SlCmPFjmiNJVAdDHlmVCA5/QWUtaJ0oZvi9pWkCss+Wgn1p+EpfXPxPpFMBwJpEoKPRoieOzaOnwETikhKtD4K3znNBF6AqTUS+ufSAgaBpg4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748544531; c=relaxed/simple;
	bh=k3xkp8dZczSdbbuZpQ0Edz3BrKDqblB1MNv6WN8HdO0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=pPlF8919z0fRp0ONizHnUY2Srxp958JF9jxh3r3jRfOD9IYiSaE+YZuPAmSfpB0zl8j1FDtJ4yIEOcg5258bq3eDQjpAl+FqcgRWELMMcixCZZAcqQvsmjDbi2retRQJZtn021GjrRu7hzvwGgZ6Q8rxXxejqGD+YrwmHubeG0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WPXdHRsS; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDYtOY008352;
	Thu, 29 May 2025 18:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=k3xkp8dZczSdbbuZpQ0Edz3BrKDqblB1MNv6WN8HdO0=; b=WPXdHRsS
	O3g91XRnUkFyyxbNd1tU8ozN5PzjsppHjp/jxpcFGeVwDHMN6Ql88Y/ONjehy/+Z
	MIp2kkVp3+EGPnClRA9d2rG2/l9h0+Scrsm067ZO7thg/fZ9kpsUEos5spzdEbKZ
	m0QLh+f5nIuM+l3hLhwW3p7AzISoprUJcdyDc5QhgDjvUGD19T152qWw7RCBdSyk
	2TTZ1VaJyR41cva1NxUngKAoP7troYwioqaiOG751/eIyURQtmC8RdP52Fxc3IwK
	qlCVKtqiS3tcYuERziGh4DNWXDL4+skxidNItZGl71zTOVvdpULF6Eod6GpoisPL
	DY/gqMlecer/uw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40kfcn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:48:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54TIfPG2004537;
	Thu, 29 May 2025 18:48:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40kfcn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:48:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNFezzsAISwZUd2sMSgVUmXwR9MKCNJBbb6MJsdab5t5DGztKr9EhTjYP52nHSMs7a6cfX07AhUHeR9gYLgnpsXlzaC38eUwWy0+0H3rzi/lRQwZmaOciOWe337WVgfKs10LMoawlDeFBiOgEVu6J4McGuV6wf5Kt+Qy+tL1X68ntJe26YErZOJt7wRvTxvt7Ixqx4OWKZmCq9+SlvoEgs07/9HknBvcrz3WiTVEfFAssY60mo/POLKLS+o0GPU069ifz0YkvR0naP38TnK2OPJpPgomtet0id3wjfeuTUcE07pGJo1Jac+rtE1z9K8B2UJW7QlGXeLFS3RtfSC5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3xkp8dZczSdbbuZpQ0Edz3BrKDqblB1MNv6WN8HdO0=;
 b=A/1wHok8yBKFfMoeyZA6MdD+vl56slhLMkGo10OrsqlQOz+EaaX4CkTP7sli2qrbeB1Cfp+lBGGV7XC2vEnAbLMjUTfgHfcnYa5TJ9csYjjkWH9ORIom796fyW4AaXQFe1SU0AiPCXvTk9CFi2JJ/J7j31Jug7SK8v1g3vpiDUc2u9a2r5ug9leyGDNA9o+oocL2conBRc59Dq2VujSg8mBnlteIODbQVvvkKzul9faMWNFA4w49EzO+Hqbx8KESf7Ma7xbII4/QtkL+qxbTIBvPRyfL/G/pPweRc4wmz3a39ZWNByrMF4QLjD1DU/bLjGoJq1ye4k09zy2K0lA5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB5291.namprd15.prod.outlook.com (2603:10b6:a03:427::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 29 May
 2025 18:48:39 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 18:48:39 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com"
	<syzbot+8c0bc9f818702ff75b76@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ernesto.mnd.fernandez@gmail.com" <ernesto.mnd.fernandez@gmail.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] hfsplus: remove mutex_lock check in
 hfsplus_free_extents
Thread-Index: AQHb0Mim8MXrcYXDMUyw280yC4yBYbPp8wIA
Date: Thu, 29 May 2025 18:48:39 +0000
Message-ID: <ce76e5f39c3c79add342e7302a2945e5c331cb42.camel@ibm.com>
References: <20250529061807.2213498-1-frank.li@vivo.com>
	 <2f17f8d98232dec938bc9e7085a73921444cdb33.camel@ibm.com>
	 <20250529183643.GM2023217@ZenIV>
In-Reply-To: <20250529183643.GM2023217@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB5291:EE_
x-ms-office365-filtering-correlation-id: 91d5f357-b782-463f-657e-08dd9ee16d4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGZkSW0vaU8xMGNxZ05zbS9VRUxvZlA1ZjdpM01vSU1OOWdrVE5DQzZpTW1H?=
 =?utf-8?B?UHQ3TUd1L2p3S2dteVlHekpsQmtQZjd0MGs5bjJvUWFHUnNjWExERC9VL1hX?=
 =?utf-8?B?ZmQzV2MrY3hsWU5MblM0MisrZ3VLeTZ4NW1EQ2R0UUlLa1RXS0Q4STQyNkVR?=
 =?utf-8?B?cktLSGpwMWw0Q000aWJrWTlmMTNQSWdjWjhWWmtZR2d6QlpwTDhsN09qT1R4?=
 =?utf-8?B?a3psdFAyY0gySzg2Zjk3RElGcXd5TW52bG9aTnc1TW5xV1ZaUFI0c0psdC9l?=
 =?utf-8?B?cmVtaHpOVnhBa05kWUFtOTdCRVBndXAyYTRRNFRockZLcjFWYWdPaDkrQnVH?=
 =?utf-8?B?T052NDBreTNKbmE2bi8yYkhHcEQ5L2Q5bWNrRGZnKzh4R2JMSkpwdGhJWTR4?=
 =?utf-8?B?OUdpTEY3N0hQWURkd3JDRkFnK2NCNmM5ZnpGd2h0M0RkMHBCVkNCVTdHRXYx?=
 =?utf-8?B?dXFydk5ZZHRNTTZDMFZadnByb2ZIMXdmNnMvb3NTZWcvNU8xVkFMakgxOHd4?=
 =?utf-8?B?MTA4U3c0UzdRaytEUlp0V1pMeDV4VjNJcXk5RDhhNzd5QTRQby9IWGt5NzFR?=
 =?utf-8?B?aGVWWkFlTHl0NVQ0NU9oOXNMOTcyVDNXVWZVVU1sbll3bkNTZmZIRWNhcG5R?=
 =?utf-8?B?S2NGLzR1YnE4YVZxT3VjLzJaYW9RWDJQN2RueExTNzlYbGRCQy9qbE15MlFI?=
 =?utf-8?B?akhHUm9oR0w5QWUrSlU0TjVaaHFnb1hWWWpsaFFaOVEzNmRYK0hyWWxEQjZH?=
 =?utf-8?B?bVVuanlNZU9hMGR2dWF1dTk1V292YnR0cldDWVpjY2FoUzRBckZIa1dXbjg5?=
 =?utf-8?B?Y0RTeVpBdlVFbTh2Q2JGQU83WkhiL0s2dnVLL2pjdTdRTER1clVYd00xbk12?=
 =?utf-8?B?bkdYSllYZHZEajhUNUNESm42dVg4S0hBbFRmQ2twNVVoWmt3TDIyTmxBdloy?=
 =?utf-8?B?UHlQY1JHdGl6OXpKZUFsK2p3QUo1NHd3ZldrUFNXMWV3THpBTE45UlAzdXpB?=
 =?utf-8?B?UXFKeEVzK25wVFpPemFoWkhaRldsZnZrTG1UM3BROWxWRGVGWlZBcjE3a281?=
 =?utf-8?B?N09rOWpGaTNRTWorZThFMFUzck5FMmxDYkJNZFM3R2FScWRkRlg1c3htNFlh?=
 =?utf-8?B?cHpONHNrS0lZS01aNEdaVjZSRUx4a2JwbUQ5Wm83N2gzL1FTZWJCY2RHc0Z5?=
 =?utf-8?B?NGZQZS9aTEQ0blBYV0U3RjMvc21hSUlBbkZTRUYvcmZSVmY1RklqbWpEdHhG?=
 =?utf-8?B?VlRSM2xQcTIwS3dzY3p2eHFlNEJxVUZqWlgrRTRGazVBeUR5MmZTSzlvRllF?=
 =?utf-8?B?d00wV3VlUDkxdDNpNmg0NzBsYmRSTnRuak5EVDRCdkJIRWRyNjFpcVlHN0xP?=
 =?utf-8?B?TEVYc3RhMXl4cHZQNEljZzhPRE9xd1VTOW9PNjlhSVU5VGROUUxpdkovVWtK?=
 =?utf-8?B?dXlwZURuaVVDMmpvaXhKeDRETXdTNnlOYUtsVGlwWHVJaHZkSTNOd1lvakR6?=
 =?utf-8?B?b1grdXphRnJkTjNSc1RBOVM1aXZ0MkVUbXZmZEdmUTJwMjhTTjZhTU5Zc2Qx?=
 =?utf-8?B?K0EreGZ6RzJMdUFtWWRqRldiSnR1b1VIMElIeGs4WGFIMVpLcW45TmplekZ6?=
 =?utf-8?B?bGJJWlNYbHgwRTZ6bVR0K3hRb3lmQkE4S1V6em4zNENRRVgrZWVYZ21MUkVQ?=
 =?utf-8?B?TkhIelB3MnhxT0F2aEZzWTBvOWF3a1p4TjRSMk04SWxhTzNmVDhlbEJKejFT?=
 =?utf-8?B?WTRtTnZuRDM4OWFZNGNndm1VNTE3T3BTaXZMdGY5TDYwMEpuM1E3OUNBRjJ6?=
 =?utf-8?B?RzZ4Rmd5d2pTK1hBanp1TkdEeXRIQ0tzL1g2QVozdFN3dmhzbUs1NkZWRldE?=
 =?utf-8?B?bFczdGNUZ2JpSVVMTThVRm1Lak83QU9WQUFGTlBNeGc1T0Z6eEduUWJyeW5T?=
 =?utf-8?B?amJYV055OHBzalNMeEVxcWN4OWhHM1JXNi9KeWFGdTI4MnFRTVNiN2hMb2xN?=
 =?utf-8?Q?p+9SeVf69UWeNfoiB1s11ZmkJUchT8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDhHY2dhclJtMWVKN0g4UE9wSndlZG9pbmVYTFRmUTlTS0lNSVEycEc2RDJv?=
 =?utf-8?B?SGZhSlV4UkVabjk3Nk4wYXdxQXAwUGFLZldvMWNjWDhKNWZhTU85RWZwb3Nx?=
 =?utf-8?B?bUNNeXRWcEtXeTF3RHhIL3pOV3ZGMHhOdXRHMWF6TGJlSG5pK2lod1F1YUNv?=
 =?utf-8?B?dzNOTGpYSG9zOHhHSm9OVEhJUUk3YWc3UjdMd3ZnRmc5TlBqVXBBWDZkWkJp?=
 =?utf-8?B?NUJSeStsMVNHSVoxTTlRMml2TXh3ZElsS0orUlprQ1RNZkphZHI3bEhvQ05V?=
 =?utf-8?B?VndTM3dXcnFkazRZbTJyVmFmWk5CSWV4aFRkcXhnTGJMNFhESlIxRndTVEVM?=
 =?utf-8?B?TXhQQlVuTjVMR3AvMXd2ZU1udzJ3bHhTZ2t1SUhRVDBRdjZ3eHo3am1JMXRT?=
 =?utf-8?B?Vjl2Z0tETEFkU1dBTXB6ZGpHSkZScDBWUWVHaEV3bERyRUNlVTh5TXNOWmk1?=
 =?utf-8?B?dS9NRnFFWVpGbmgzR2ZwT3JibGhlZWhmeXZDY2FsYU9VbjA3elpiSUQ0aUF2?=
 =?utf-8?B?c0ttSllGVTRnamR1U2lMZ3RlZzlKR2FwdjBpTnZ5bFRDekxEUUdMQnF3ckpY?=
 =?utf-8?B?TENUODhyWUlLSjdqS2x0clk1c3k3NzdHL0dUS1RocVMxQU5SdUJCNTl4Qkhn?=
 =?utf-8?B?Tk43Rkw3WHdSZ2tWZHlXVGkyZVFSWjN4SVQ2MFQ2RnZyQStGR0l4K0h1WTZK?=
 =?utf-8?B?RVUzcVpvMmJwKzRjOS94MjBSNVBDbmNKVkxYVzRpSFZ3RC9qMVY0NzEyM1o5?=
 =?utf-8?B?OE9xZFROdnA2SnovdkJKdDAxdUl6dEx1YUtiQ0ZaSUlpTk42VVJQWHVtU0cx?=
 =?utf-8?B?SnJ4cUord0FDOTZQWmY2S25vazU0QXlDWTRKQUFpQnpENzRZbml5eTFLWU9h?=
 =?utf-8?B?ekVNZ2tlZlROY0l0UVhPRUZMMEJhcGlLN0tKWmgzMmpaNmxDeHlTMjZVeGVp?=
 =?utf-8?B?cFZDZGlqSm1QNWJwSXg1T3JpY0xZTlpEbnJXMVRsRWIyUzlDcCt6dVppS3l6?=
 =?utf-8?B?ejNWOUxOUVhjdTc3RUFpVWNOa0srNzRNT2p1SU9CMmFTU3JjRUk0c0tYSW1W?=
 =?utf-8?B?Z1hoajJ5SURmTCszRmZteG1qMGtUajRLY3d2ZVFyZ3RiZW5BZkxKMXR1V3dG?=
 =?utf-8?B?ME1oODVzOFFIT2J4cUJLQW1UdkdNQmEzNWhhOS9PRGpncXJxZlRsbGtlV0FZ?=
 =?utf-8?B?SWdOZ3EvNCtGTiszQVI4RzFhSFdaMk9jN3ZLaXFld0VtN3dWVklPOVNia3Uz?=
 =?utf-8?B?QW1wT0tQWG1HQWM5SWdSQ2JYMENBVHY0cU5rdUREeGorcVFGczhwSXJYNk1N?=
 =?utf-8?B?bjNnQlpBeUJHVzZtNGtYRTRNa1FTRWFuMVZTWmJLN1pCeHhrVWlia05vZWFj?=
 =?utf-8?B?bmtFNzFnVEtDYlVpVlR1SjBNbTB4MzZBYW0xck5KM1Q1UnY0SlBqZ3N3amdM?=
 =?utf-8?B?VW9pbndJUWwyRG5hZ0d0a1VSRlhHZ2ViMXFSeWxMTEE5RkQyRS9ORDlkN0FS?=
 =?utf-8?B?WFVkMnRDWi85bzNhc25sU1R3cnFQVG1lckFsSERYZ3Boc2ltNmNlVEdhcEdM?=
 =?utf-8?B?R3plcTZaVkNWUHVLQUQ3Tk9kMDZwNXpIVjg0Wlh2dURhWnZmMVNtNC9BV1c0?=
 =?utf-8?B?REZXSDlabjJEdHBwSU16Q1NxaHpWRE1jZ1FNdmRkeXNxOURiUktaWnhXcGVj?=
 =?utf-8?B?QkZUWHo4ZGN5N2FPeDE4ZnAydlhlRm0vV054Ump4bTFBWEhNV2pxRzEybmk0?=
 =?utf-8?B?UEJDNXBnb3BHRWgrK2dUdFR3MlkyL1NPK0hJS3RTSFllU1Rwa0p1KzdTanBa?=
 =?utf-8?B?VmN4TEI1c3FvaVc3c0VXZitJSk1VL2R5dXFycDFvSGdBZHg5Tk8xNzJ2dXBn?=
 =?utf-8?B?MUdOM3ZTZ2JycURTTVFUZTl1cWErRnYxdXloV3M0RU83amtma3V6YnFWQWlE?=
 =?utf-8?B?NDhPMHdUVkhvZWYzVENNQnVrVjRyd3hDMDVpbXFaM1RCYVRIVzZpZkVKYVRD?=
 =?utf-8?B?YjZCb1lDM3RhV0UrNE1QWUJyS3lUOHQ4b2g0ZEpZdXc3OER5elRsM0pYSlIv?=
 =?utf-8?B?OTFWcTN3S1dWTGFha28rbDNQaStHOEtLOW04UjcvOFNFSlFsSzVjb0lnTzJL?=
 =?utf-8?B?bHBZTXp5OW1HOHZnMDV0L1NYWTNha05XOTdiRFlMeEE3MDBkWk91WVFTSGVz?=
 =?utf-8?Q?7Kx7FrtRq4wkXDuCYvwnzmk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58FA95C71652CA4A9EE46070501A0376@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d5f357-b782-463f-657e-08dd9ee16d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 18:48:39.4863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dl94ttFrGG7S8tBAmnpMiQw3cBlauiaHoassGPM3nYAtv6xg/K/f4qfgQs5BH/VUA8U93+sLl6yON2MEZz7tQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5291
X-Proofpoint-ORIG-GUID: 6vWahbm1PiwEkPQF3JUS26MK0oYZ6gcy
X-Authority-Analysis: v=2.4 cv=fuPcZE4f c=1 sm=1 tr=0 ts=6838ac0a cx=c_pps a=23ZrAAxOjRKSzRVqk0KFSw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=8IEZzKuUEDbqVeZIwp8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4iLEywD-RBPCnK1xutehOv7P0qyIpPCj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4MCBTYWx0ZWRfX04UUvZeE/fkH TlrlHRpQCzRpZJiQNu2ugY8sdIt+39DwEALNJHR6QxXsZxlbQjnW0DU6FrNv/5cdMk6qdaOWzJg 4huxg0gHSR33R/OaW5wcD3T0mIrtnDtkUV+7L/dmnX6/CGkCz/xmV4EQ4s2ZVBb7ecKkw4i0v2C
 bHlrHPxyMO6O0mLtR9wFOTeGym5z+QzwfjjVmUljRzjedFQ1Mw22b9qFizxa9+75fd7KXjGWTzY zrhlYf7EZN7Hj6h9yVQ7i5zz63BzdhdnHtg4xKAWV93O8JLTu//939JP+mqMfJyGld2c72uz1EK cmYajWaMIvl5WveM4OOJ5a31cblCyaQyMi+nXBrUYyFUrxpEmO4KKu3NaX9WH3RRklMS+x9blvt
 R3aVsX0mQrdh+mO5zMssSrstiTJcXGjUEdgXxPFSbcNM8vBI0/+GgoTwFJwos/nGFIzF6nq+
Subject: RE: [PATCH v2] hfsplus: remove mutex_lock check in hfsplus_free_extents
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=950 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290180

T24gVGh1LCAyMDI1LTA1LTI5IGF0IDE5OjM2ICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
aHUsIE1heSAyOSwgMjAyNSBhdCAwNjozNDo0M1BNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9leHRlbnRzLmMgYi9mcy9oZnNw
bHVzL2V4dGVudHMuYw0KPiA+ID4gaW5kZXggYTZkNjE2ODVhZTc5Li5iMTY5OWIzYzI0NmEgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9mcy9oZnNwbHVzL2V4dGVudHMuYw0KPiA+ID4gKysrIGIvZnMvaGZz
cGx1cy9leHRlbnRzLmMNCj4gPiA+IEBAIC0zNDIsOSArMzQyLDYgQEAgc3RhdGljIGludCBoZnNw
bHVzX2ZyZWVfZXh0ZW50cyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPiA+ID4gIAlpbnQgaTsN
Cj4gPiA+ICAJaW50IGVyciA9IDA7DQo+ID4gPiAgDQo+ID4gPiAtCS8qIE1hcHBpbmcgdGhlIGFs
bG9jYXRpb24gZmlsZSBtYXkgbG9jayB0aGUgZXh0ZW50IHRyZWUgKi8NCj4gPiA+IC0JV0FSTl9P
TihtdXRleF9pc19sb2NrZWQoJkhGU1BMVVNfU0Ioc2IpLT5leHRfdHJlZS0+dHJlZV9sb2NrKSk7
DQo+ID4gPiAtDQo+ID4gDQo+ID4gTWFrZXMgc2Vuc2UgdG8gbWUuIExvb2tzIGdvb2QuDQo+ID4g
DQo+ID4gQnV0IEkgcmVhbGx5IGxpa2UgeW91ciBtZW50aW9uaW5nIG9mIHJlcHJvZHVjaW5nIHRo
ZSBpc3N1ZSBpbiBnZW5lcmljLzAxMyBhbmQNCj4gPiByZWFsbHkgbmljZSBhbmFseXNpcyBvZiB0
aGUgaXNzdWUgdGhlcmUuIFNhZGx5LCB3ZSBoYXZlbid0IGl0IGluIHRoZSBjb21tZW50LiA6KQ0K
PiANCj4gVW1tLi4uICAqSXMqIHRoYXQgdGhpbmcgc2FmZSB0byBjYWxsIHdpdGhvdXQgdGhhdCBs
b2NrPw0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlLCBoZnNwbHVzX2ZyZWVfZm9yaygpIHdvcmtzIHVu
ZGVyIGV4dF90cmVlLT50cmVlX2xvY2sgbXV0ZXgNCmxvY2suDQpBbmQgaGZzcGx1c19mcmVlX2V4
dGVudHMoKSBjYWxscyBoZnNwbHVzX2Jsb2NrX2ZyZWUoKS4gVGhpcyBndXkNCnVzZXMgc2JpLT5h
bGxvY19tdXRleCB0byBwcm90ZWN0IGZyZWUgYmxvY2tzIG9wZXJhdGlvbi4gU28sIG9wZXJhdGlv
bg0Kc2hvdWxkIGJlIG1vc3RseSBzYWZlLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

