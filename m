Return-Path: <linux-fsdevel+bounces-68001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C8C4FFDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 23:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2019B34D44A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6C2E8B83;
	Tue, 11 Nov 2025 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QhLFcUrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2552BDC3F;
	Tue, 11 Nov 2025 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900946; cv=fail; b=ej8ux6amzig3cqTOPEK5UfBw/WmXHT7ndHVdelKQQXMaJrzgfueuVqGdXDUG3eYlvHCfZu6Obvrc+GStlQm1VGNSRi8SPsVZcbA05G15dwiWsRIewlt8xWN+DYfiiJPuTOg/+2RK9E5HBvpUq8fMd39QWGiGD7F2jzqF4AOHrco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900946; c=relaxed/simple;
	bh=CtjfRpw/vxGz/j2oGt9pruJdTZ9KoHIHWNLiGAovjag=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=PTTR6FTwOyjicOO2Z7Fecj6L1fU9MMqRIHHt4yNjToKDQN1ajZ9jWlvQ/8+5fhj/wE8gBVIZJUmtWoBkEkafa4vwLn1lvB/gyS6ZAKJSYM0ANy8AjyJRKnOIqOdReOgyyypIzPbWKUrGxDP1qiimIJFskSxvnVv2H7io91hJHbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QhLFcUrw; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABH0kbW023602;
	Tue, 11 Nov 2025 22:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=CtjfRpw/vxGz/j2oGt9pruJdTZ9KoHIHWNLiGAovjag=; b=QhLFcUrw
	igevwfUCljZcyw631wrXFWM1jnNQv9XytqtMSpjEzkXhU2wq+JK5em0p2j3qrBvE
	Bze25s18YwRizovF/drB0C3UXX2bvFAItKpCjn6mRfLTvN3d+9AAzw3wUG3eDqPw
	uqle2AbjtIcGdEqcFP1ZehxbRHe0MsfOsSI4CNERi0LE8c1fb/uCDntJRG+d4GFj
	o7u/ZDwWfZAbfNkrepK/viXu0jyINxCRmuXc0emWNJwHgnxdrDSzETukB7Rxjubo
	+/0k2DyKloH9ov6TlEcYL8hvktNoGna+CtDWYVMLhyn6Xf19NsAQSFHQDiqbZBRD
	0qZrHtkBJAiBuQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj6drx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 22:42:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukp30AY4ux5FqRt3lBKBM14Cg9bNda+iLlt2sZ2bOeiflgCsRaBQPdrl/QG/PuWvhyPQp/vhASd84M8Au13JDbLnAw3PzRemNqyE4rVh+rIdLInEM7gVDFl7Sv68zrNzflCOHw9kh/f2EIceHeExE0yA12xgOovEX48Lp0ZKC7lVoGYyxx1DAjbikEPhX6ig6JgOyTdTj32MUWsHvskdwPMI/BgCvWUPZBwMw5l/sLcrGgkGFxnaAmziAJdpuhXYnBqxwG3EH45mUqODfL6roqMt8CK6/nr4MV/eQDMWocAUtofEBcG0zn/WaIZNPq1v81QeokgdKj7O42yOOlwqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtjfRpw/vxGz/j2oGt9pruJdTZ9KoHIHWNLiGAovjag=;
 b=j6xc4CiJdmrHiT+xn3KHewtf8T9hzP/1YbxXadccr5DSCfNXvUVUG9YGc5BepVHmpRNvBfl41GFJlKYWqWgrdxcUAcOXtT+oqBzILWKR2EgcGKJvmRY0nXMQHlczMirzh7Z7ygn/vBuV8R4qNhirxglUOZHim1Zc0vGrReQnVtySBipyfK6JsJCCMQxn9X6lEaC/vkfXWSAID+Na7o5BO2AVuiZvTocJ4cOMln54GLidzcouk80DpqODNhRqex9uyD3+Qrwnna6tQFfIQ+1RMKkNGhoEUWbA5dP+QVfdI0ZXFRLetH5F9Q4XdYcuXL/BbHSfByv7XSN4f5tOuYzdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PPFE463773B1.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 22:42:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 22:42:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "contact@gvernon.com" <contact@gvernon.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/2] hfs: Validate CNIDs in
 hfs_read_inode
Thread-Index: AQHcUxpPkd/kQAITXEWhDP6QPRYmTLTuEp6A
Date: Tue, 11 Nov 2025 22:42:09 +0000
Message-ID: <a31336352b94595c3b927d7d0ba40e4273052918.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-3-contact@gvernon.com>
	 <df9ed36b-ec8a-45e6-bff2-33a97ad3162c@I-love.SAKURA.ne.jp>
In-Reply-To: <df9ed36b-ec8a-45e6-bff2-33a97ad3162c@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PPFE463773B1:EE_
x-ms-office365-filtering-correlation-id: 1ccc1ed8-5684-43a0-c926-08de21738cc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFhUcDVCc3l5aVVGK3lJL2hyd2ZLWW42OXZiSUFBeURidllWZEZYWVRqR3Zk?=
 =?utf-8?B?YkZ3QXhmdkhBU2FodTZydUJYcXBRSGhsL1R5T3JKVEM3R2lPVW8xVG5oRkdu?=
 =?utf-8?B?ZXdNNkltR0VFRzNhTGU2ZERRNExsZlp2Z0MzanhSQ1JWaGpLYXl2VWExWXRx?=
 =?utf-8?B?dmJ6bDdSOEx0dE1IS0dXanFuL1NUMHJDZ3J3UXE1NENMZXJ2c0JXT3JTRXA5?=
 =?utf-8?B?RFQ0ekJJTzRZSisyQXhSMlJ1anNZcmJOcGZGQlE3RllnTmdJSnB1QzgxTTVk?=
 =?utf-8?B?V3EyZVJqNG1Ealg4ZGdVQ0FEc3JtSjA5OUp4c1pMQ1lGdmlEckNHbU5ZVmMw?=
 =?utf-8?B?TXc5QTE4dlk5dmpuT00yTEJ4WmV2bGM0WmVTU1EwOVl2SGk4Q2lUdzZYS0Ex?=
 =?utf-8?B?WjMwbnBPRVE3ZlN1dzlTQ2gvWDZxWklRcE80RVNWYU04cVFNai9YOUFiN3Vx?=
 =?utf-8?B?eHY3cStWNzNCMG90bC8weUs4cDZDZlNwdzJSclVaOGQzSnA5OVkweFdoOC80?=
 =?utf-8?B?NTBkR1BoLzRGUnVoalZpMGZNTlk4cTd2ZFBZdWNUcDltNENHV092MjRPUkYv?=
 =?utf-8?B?eUlzMFZQc1RpazBqbVJ5bzFxNkNaL0pHWldkRzZaWHZvNzF3dWNCY2ZuMUNq?=
 =?utf-8?B?UUJwWVBNTFV0cmZGYmxjUjlPbW5VQnRTMTQzbno0MU9jUnpyUm9GTXkwU21i?=
 =?utf-8?B?dThkdmcrOElINTNPVXBRdERkVHhCSGh2cnN3elRrYVI3d3JGYUtnN2I4NSs3?=
 =?utf-8?B?bzVRd21aODE1bWFkRW52aWpDOHR3b3JKcmYwZmRtVWN3UkYxMnVKTkJXOEpL?=
 =?utf-8?B?RmVKU3lZcUlUQ29ocFBXekUzazVnY3lnRWRic2hDUGd6aHZaa1NQTzhUY0ZJ?=
 =?utf-8?B?TzFvdC8weEEyQ3pPT2tMYmVRbEI3bkZTOU5TTldRSW15clBtVTJSQlJyQ1Zn?=
 =?utf-8?B?bDArN0d1NGhyWWF3NVBZU3MrVW5lWVZNeTNPWmpTaVZnelg0UFR0NHYvZkIz?=
 =?utf-8?B?TjBGNVZYWjFmNzVNYWtvQXRlV2FYTEJ2SlIrRUhsVGY2NWNyM3d4cEVXOGlO?=
 =?utf-8?B?czErL1J3NVlmc0N6N09JNWs4dVhZMm50WDlZQ0R2ZGFvVXlWZW16Tkd1MmMw?=
 =?utf-8?B?NUFhZDJtMEZ5d2pEVDdoSGhKdWoxcU5ubHJKZzRoemJYREQrdDVJNHVzNHE1?=
 =?utf-8?B?UC9JYjZnTzc2bVkvMGQrQUprVVV2V1QwMWFWQ2xhdENmTjJOZHRCdmlOVHJa?=
 =?utf-8?B?dXN1S0RUQitWYWtoeFAzbFNXUk1JT21iS25tWUlrOFMwR0tTdHdLb0NOcllN?=
 =?utf-8?B?NUdiMm5LWENvQ3U1cGpxbEJISXZqY1RUK2RoTEhldU5MaDV6T3dVZWN1SnV5?=
 =?utf-8?B?TjNMTHFqdFJrZy9Rekg1WTJQd3lGWUJyUXlEVk1QU0F2UEdjL0RheDBkNWZK?=
 =?utf-8?B?WFpQVkZia2Q3b3pDVEVuVU9VKy9tQkxDaUo1VHFxU25sb2thNm1sL0RIQVJi?=
 =?utf-8?B?d1F0c3RuS2VET1oyN3o1eDZsa0ZjRm43YUNtcE91WVJsdmZBZU5BUy9NYkkz?=
 =?utf-8?B?NDhuY0MwYktoTkp1S2hqMHBudVJrYVBvc1NDb29ncjJoQzh3bUFoYUVYaTA4?=
 =?utf-8?B?T3AxTTZDVW1JVjBuNEdLWU5WdUp4L3pzcWVYbTJMZmwzcUtSRkloYlluMDkz?=
 =?utf-8?B?WmJLdXNISGJ2b2NvSnZJN1BZTXYzY0pIK3FLQzlLN3htRXA5K2JBcWNkdFov?=
 =?utf-8?B?SmU5amJIVFgxTGVJV2lJQVR1VTR2Y2w2bW9uOVhCTFdRMU9tYkszMWVmVVZx?=
 =?utf-8?B?dCtwTUhwMC9ITTZydGRtYk5zRW9qUC9kcFNieXlTSHdHZ3BWSXFIVzJWVStU?=
 =?utf-8?B?b0NPSUwveS8vOUE4TVROS0puekhUSGxSL3Q5VmZYS0d5elBRa2xHRzBYK0tJ?=
 =?utf-8?B?dUwwbU5xekR4WlQ1ZktscGtUcTl1cWZjcVhHeitRcVhWUFdxbHhIY1FETTI5?=
 =?utf-8?B?U3UrS1c5VkZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmxZWTlyOUtMM05NVmpIMFdrZythVGJnamF6bXltc3hwVlRDd0ZoL3VaMWpj?=
 =?utf-8?B?VlVPcW1HWCt2UGk0ZXUwSFZhOUNYVnZyN3lqWnFCUVhCUS9KejQ5SisvN1l3?=
 =?utf-8?B?VjhDeUNMYVVRQlFtQ0g0YzZNaTA1TGdneG1lNVliTDVJeHpFT0hYU3N2UmRY?=
 =?utf-8?B?RmRZblJ5RHlBcjc2bGEwT2tIYmI0Szl6eW1xdE93V2l1U2lob3ZxYi9ESEpC?=
 =?utf-8?B?UWRmQXJTTnJ6dWh2dnhyM3JBVVM2dVpYK2I1QzBsb2QwUFdLYWFmTk1MT3Jo?=
 =?utf-8?B?cHZJaVQ4OEFLYmtVUzBsN0xVcURiSHh3TzVoNDlwWkZKSVp6WS94TXRlb0hL?=
 =?utf-8?B?c3NPQjFuNGRNZ3ZOdXROekdZR3V1NmxzcCs1OU5Gd3pFbldoTXVWbnkrK0dz?=
 =?utf-8?B?bTA5UG5zYi8rbmwxdmVtRmhveFNVSnpDMWV6cVlIbXQrRFMzUTErbWtMSTJp?=
 =?utf-8?B?OG5KK292bm9lV25KUjRPeEZXYk83TXk5OE1DY0pvb2ZNOHhqa3U0K0VZNHhn?=
 =?utf-8?B?MjFJckdjR0lLYUcrWVFxVytxOVZVRHpOQTJobEtkUGRGME51NWdVa1prNXQ0?=
 =?utf-8?B?WkNxK0NvRXdKdlJOdUVUc1V4SFlKelZrTVZaeVpEWjlxbFFKTTZDNThybDQ4?=
 =?utf-8?B?NjFvZDZIQzQ1OVpCc1BIRkJRQytTQnZMKzFyWXdkbnBtUG9uOWRCMjhxZHBR?=
 =?utf-8?B?bnpTL2tGOHNZTHFzNlk2SkpyWTc1SnNid09qa3R5SGNTSm5PekI5RTVHeVFJ?=
 =?utf-8?B?ZGpXVVl4VU1yOHpsbyt0Zk02M0FsS2lJbC9qZmZRY0U3QTZNeVc4aUJrVG0x?=
 =?utf-8?B?U1M4N1h5bVhqYVZuZWRuUXFnT0ZMUTNvempwdXZqajlEYkdDOWlpTGZlWVJC?=
 =?utf-8?B?SFRtbTdHOWp6VHkvMFh4d2NUQ1QzbE5OS1FpYXY5Smdlb1JCcUU5Q1pXMEVp?=
 =?utf-8?B?RHZLOGxINzBrS0dGblIvWDIrK1k0VmxYRnlnR0lhYWNkUTVpK0d3a1ZOQ1Ey?=
 =?utf-8?B?dGtPNEs3RWQ2MVc3MGl3eEZadFRzUWtGSG5RdlMwQTVsQ25Ka2hpMkdRaE5V?=
 =?utf-8?B?RTdIMlh0YTExbytCUDNCazQ2M0xBWkxLY3BVeit1WDAxbWNzcnpKN2UzS2Vz?=
 =?utf-8?B?dVdzeXJQQVpoSGJyOEpRVGZNTCtKeE0wMHlWbU9vR2RhRGtnMjlwck5wR2VI?=
 =?utf-8?B?YXRtNWVZOVFWSmVsS3ZEUTBXNGhGbWIwZ2I1Wjd5YWxKLzV2M0l1RVM5SUdK?=
 =?utf-8?B?aTZtYjhKUE1ybDRkSjVmcUdYWTB3Q0NlTjMvOWtpZW9PaTMwK2hsSzNpQmxu?=
 =?utf-8?B?SU9TU2llb1YzdTNTM1V2dmRoQ3pIaVVaTXZUWkgwd0w5TFJRZXdibjdURmFz?=
 =?utf-8?B?RzdraUgvM0owcXlVZUIrd0VPVEVSUjhTTkJWK3lZemVxQStHQXZiV2wraTFQ?=
 =?utf-8?B?em55RzY1eXpBdmRCM0huaWpnendGcVYzU1NLcmlud1dnNXZoY0Y3OHJzaE1p?=
 =?utf-8?B?cjZzaWRRcHRyZXM3K0ZuL01TRndKeXpaeDU4RGRUN0pvamd1U2ZtWnI3ZkRk?=
 =?utf-8?B?MVR2NUlXK21FZWxLSDJtVVJEMmFXOVRmV21yVnF3OTNySkgrVGVOWWY3b3FI?=
 =?utf-8?B?cjlCUVh6alh0SE1EM3NDMlMxbTFNNnFLaGk5SC9HY2Y4MUEvcGttMXI2RzZj?=
 =?utf-8?B?RWJTV3crUUVVRXUzenRmTWl2U2srK2lRN2xDWFZCYU54TXZNTHNvYU5OYlo2?=
 =?utf-8?B?cGNLdmlBVUVWeDVHV2JUcVpyZmlwdW96UTZZRUlWQ3JCUU9QNXFRQlNIZ25k?=
 =?utf-8?B?SUlycklIL2tKTUNqcEs3ZWVWajBOLzZlcnBSWXpaWWorYnpuMWhzQlhpeGNp?=
 =?utf-8?B?RzFTU1p1MFM4Q2NBNXNDRFRNbG54VDhVUDZzZE1qWUF6c2ZFcGxvZ29McSty?=
 =?utf-8?B?UUF5a2tnMEVyTHlJRncra3hxQ29qeFhQUzIxL21wd05tYXdWeUFzcGlJeG1Z?=
 =?utf-8?B?am9lOG03cFd4bGswL3JNSjhuWnprUXZ1cUhyZ2J3a3k4bEkzTk1wZGFSUG45?=
 =?utf-8?B?Q1M1ZHZRUVNDOXNIa2JIK3B6VVFrWEVCMHZGeHY1bHBiMm5CamExNmx0OEdr?=
 =?utf-8?B?TURMaHdqRkRNN2c4cEVzYmZXRGtEZElYdmFDNE9rUkZOZ1BEbUpWam1hRVkz?=
 =?utf-8?Q?yRUMad0dj/v8NsMbtxiJWCc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA19743F3B2AC24296C3099B5CD70B81@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccc1ed8-5684-43a0-c926-08de21738cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 22:42:09.8876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14v8DvMyr26v2GBLF9yQvGFXgKI2DDcIof8WwPLu9UHsBtpeHc5DIBDALzoUNj5vn2gqtVd2HETVBKc/uwvQdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFE463773B1
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6913bbc4 cx=c_pps
 a=xSIn1YjG+VojQN1dL9/zMw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8
 a=GdS5Py9SzHmR8w5op2YA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfXwwYfDO0QACWO
 v/Aa2pzScCgbdqB67oxH/dyKs4P+QMvIlk76eNx86Rf1HDrTo7J7m6DZeFP1+PvioAv0IAuqkSw
 6s4KYFibFa0I2FthS6QVqCKHQr23q77+Gp1Gv+zfugflrDzU97nO4L/Lou7iQl+l+IGWjWZ2kqE
 Fxf7G6H2yxGZmViaSe3XwgvnFILU0LHuSvjiWlGHKFrIfRnT8Br8bVbCSUZUrgkKs01JYdeSUCb
 74x1EFoux3rLzBXo3SWJJJD03jrpHDc++r7wnJTgRlykbXWs1+2mFBM41Ug/uA/mJ12xzC1+cT7
 yjZ/O6RqhSx+ErnBKYf8VxvLGcl0UerUuMImkRJoCpC5vf2aHHwlbanlLY71jYYlyOTNPnOx6Q6
 qM3bzIQMrjwrpLc6SKPR3+4/8mRs2Q==
X-Proofpoint-GUID: -DEvpbBeqUWqdvA7M9Ve1XrM5ng_tseH
X-Proofpoint-ORIG-GUID: -DEvpbBeqUWqdvA7M9Ve1XrM5ng_tseH
Subject: RE: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

T24gVHVlLCAyMDI1LTExLTExIGF0IDIzOjM5ICswOTAwLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMjUvMTEvMDQgMTA6NDcsIEdlb3JnZSBBbnRob255IFZlcm5vbiB3cm90ZToNCj4gPiAr
CWlmICghaXNfdmFsaWRfY25pZChpbm9kZS0+aV9pbm8sDQo+ID4gKwkJCSAgIFNfSVNESVIoaW5v
ZGUtPmlfbW9kZSkgPyBIRlNfQ0RSX0RJUiA6IEhGU19DRFJfRklMKSkNCj4gPiArCQlCVUcoKTsN
Cj4gDQo+IElzIGl0IGd1YXJhbnRlZWQgdGhhdCBoZnNfd3JpdGVfaW5vZGUoKSBhbmQgbWFrZV9i
YWRfaW5vZGUoKSBuZXZlciBydW4gaW4gcGFyYWxsZWw/DQo+IElmIG5vLCB0aGlzIGNoZWNrIGlz
IHJhY3kgYmVjYXVzZSBtYWtlX2JhZF9pbm9kZSgpIG1ha2VzIFNfSVNESVIoaW5vZGUtPmlfbW9k
ZSkgPT0gZmFsc2UuDQo+ICANCg0KQW55IGlub2RlIHNob3VsZCBiZSBjb21wbGV0ZWx5IGNyZWF0
ZWQgYmVmb3JlIGFueSBoZnNfd3JpdGVfaW5vZGUoKSBjYWxsIGNhbg0KaGFwcGVuLiBTbywgSSBk
b24ndCBzZWUgaG93IGhmc193cml0ZV9pbm9kZSgpIGFuZCBtYWtlX2JhZF9pbm9kZSgpIGNvdWxk
IHJ1biBpbg0KcGFyYWxsZWwuDQoNCkJ1dCwgbWF5YmUsIEkgYW0gbm90IGNvbXBsZXRlbHkgcmln
aHQgdGhhdCB3ZSBuZWVkIHRvIGNhbGwgaXNfYmFkX2lub2RlKCkgaW4NCmhmc193cml0ZV9pbm9k
ZSgpIG9mIGNoZWNraW5nIHRoYXQgaXQncyBiYWQgaW5vZGUuIEZvciBleGFtcGxlLCB1YmlmcyBp
cyBkb2luZw0KaXQgaW4gdGhlIHViaWZzX3dyaXRlX2lub2RlKCkgWzFdLiBOSUxGUzIgaXMgZG9p
bmcgaXQgaW4gbmlsZnNfZGlydHlfaW5vZGUoKQ0KWzJdLiBBbmQgbWFqb3JpdHkgb2YgZmlsZSBz
eXN0ZW1zIGNhbGwgaXNfYmFkX2lub2RlKCkgaW4gZXZpY3RfaW5vZGUoKSBtZXRob2RzLg0KDQpU
aGFua3MsDQpTbGF2YS4NCg0KWzFdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2
LjE4LXJjNS9zb3VyY2UvZnMvdWJpZnMvc3VwZXIuYyNMMjk5DQpbMl0gaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjYuMTgtcmM1L3NvdXJjZS9mcy9uaWxmczIvaW5vZGUuYyNMMTA4
Nw0KDQoNCg==

