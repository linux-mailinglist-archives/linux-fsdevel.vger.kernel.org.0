Return-Path: <linux-fsdevel+bounces-51064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6CCAD26EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 21:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F84188C7B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 19:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5A21FF42;
	Mon,  9 Jun 2025 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cdWLdx2l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E6021FF23
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749498098; cv=fail; b=i7K0LVhPwB6glp9I46jO76vJo+hnntOsRPYWgPrbF4cRuzPkivX6W0mVJqRB8cue9pjf7oXtTMm+dYH1BTLKvKSKv3dKx/B1A6g9ipEhsyqWTbprex1Z6ACJeAt99ijPeQJId5Awdp/wwp1G37RiTIWyZGIjFJMWZqOpEpA2PoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749498098; c=relaxed/simple;
	bh=uIXshOISEvTCg1VHv6K7bbL/f9+xTMueREE616oceXU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=eXfwasgDmuAwdif3rMpVIRdfEc7DZINLlgMA4egUxzjwJVyYhvdmyupJ+RpdSfJBUeSet1+7CyQvziSEPj4z47+pb9vmcBrb3T2zrxJArKo+ff073AkPswVFsHjC6GHq/iMDFuYQODulffMpo6W9+UMAptGM0cHpBgnVlTUNqKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cdWLdx2l; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559DZAoE028757;
	Mon, 9 Jun 2025 19:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=uIXshOISEvTCg1VHv6K7bbL/f9+xTMueREE616oceXU=; b=cdWLdx2l
	2N+BKwD2EquBoplTHevO2kfZSmAkKFiDErfOK3FlgKiO02ZnI7qs8h4itadFlK3b
	x7HTopEAgBCt4ZLeE5rrPqMNLA//w/vbybtYPMbFoXyKvUNoUIZs60H9IZGbno/Q
	GgRxG/5sJ02MvL6fCMU/9qkjDbnSruOek1QWf47aCdC/CPNkEh1uvgENrckCf7xT
	y0rohTKGIvmbqmTCI0aVmwQFmYsRqAMgyMvv3HpRUrdFiz1Z9rQ1YajgcdQF8ij5
	bUIlIjRnaTCS3Th52GgMvwv92EafmBIq+RSQAoDh06kl2UJfywdrUA276MuZdCPc
	2FSvLcxbX1BIkw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgu9jwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 19:41:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfcJJPzqQ5WY/rMQictGJhUayQ13OtRHNg7bu0jxPnaOYbZYwxWSRr8V3PvAh/D2LV469E92tU9b/LNFfOaQfhPee7AwKEudNu2OUWYPVSEgzDnsD1NhPu7iiJxI8V9Pe8LVv00E8Am2Nma2NJWgaq1p+WvkEViQ7AgLLRtDK3P32yh+uZaP+Wf4b2QISrrj7ZQRgFLAdCKYQfzUXVKrSQbR4IaKJmeKKDONJAAIyWZA5od+mirUWm5SNxbFSODc3iq7bMtS1qtf4aCDBUdOZEh7oEtqBFL44h9ANPnuQRwthX4NIAL+KuVirK/2MqZElknnLM6mHp1m6GV0ApX15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIXshOISEvTCg1VHv6K7bbL/f9+xTMueREE616oceXU=;
 b=jC8gXboEF3syFJeuGJPoIsvKVrGN0SKUIbeba4DD7qs9ebsIHVjNFFmPQJ4nqgAGIj7KwMqViVRShAB9w5i87Gz5MtCtWyNzG0vKI0fKcYLpYa6veY8YkYtvVSkesaNl6WdkXlJKfy8Grg/RTFdu0EYkV5cuE6ERjgp4f4ll9vDkx3Um5BtY8KdeIsdMpCLnkjzI9g6nUBMudyJEOkExlyt85wwQfdVO/BgHY8aUBRQ6vI87ibApnz0tN1Bc047QEgfqYgj2nQsxbIawDXhDrxh0mvKr1lNYj3fpry/fXPbxXSMBVA0jI1sCZbmKsbStMjdcksfk7DRDu0vfNoAh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4405.namprd15.prod.outlook.com (2603:10b6:a03:35a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 19:41:30 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8813.018; Mon, 9 Jun 2025
 19:41:30 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [HFS] generic/740 failure details
Thread-Index: AQHb1msKldMSRfJNPkiVh/gHk+GTk7P6rG2AgACTuoA=
Date: Mon, 9 Jun 2025 19:41:30 +0000
Message-ID: <7c676b6fe21c84033d34a09f4a02f2eb8746bce8.camel@ibm.com>
References: <ab5b979190e7e1019c010196a1990b278770b07f.camel@ibm.com>
	 <5b8df0f3-e2da-43d4-8940-0431429eccee@vivo.com>
In-Reply-To: <5b8df0f3-e2da-43d4-8940-0431429eccee@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4405:EE_
x-ms-office365-filtering-correlation-id: 5be4f524-d516-4e84-a934-08dda78da1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0lTU2Y5R25lV0JlRGxWODRRSUVCZHZmTDZ4L0hqay9OUWM0TkJpRi9hZFo0?=
 =?utf-8?B?clg1UldZMFdPYTRoOWhiZmxKTVhmZDFjR1k0V2lqdUliK2NsT0RKUnB3ZGVP?=
 =?utf-8?B?QTlNdUlWUnlmQVEvSWlFNzJSUW04alM1V0w0NkRQUStxUjhOWFFIaUFHRGJY?=
 =?utf-8?B?UzRrdXl4RVMyUWI0Tk1jVG90NGVjOS9HR0xqaWdvSmd4RWVvNjEwU3RZbjlL?=
 =?utf-8?B?djJEelE1Vy90bko5MHJIZ3lrSnZkMVNFSlA4Ukk4TXYzSE1PNkhCOHhSdGZO?=
 =?utf-8?B?V1pDY2gza1Y4UGF5a0ZYMFpkVEV3RFNKaXE4N0FvaVg3MHZFU3ZoMmVCUndh?=
 =?utf-8?B?RWwyQ05haFZQT0JpbUt3ZXlOUzRqWk1CQS9EUEE3NjhGdjlLeG50UHRIaHVV?=
 =?utf-8?B?UytKVW1IZnc3WnJrUlkxZGhJZDQ2K3pnTStEaFBRdHVBZ1B4dVRoT05NTWcy?=
 =?utf-8?B?ODZ5QjhsUnY1M3FmZ0p1WFpyTEc4ajYwMjZsbU1TZnJ4a3V3c09VcGVMc245?=
 =?utf-8?B?S2VIcWxiSVE0d0k3U1lORVlzUFMxODd3NVNiYUE2MGdhTFdhMEdvSUNuemJz?=
 =?utf-8?B?RGxXSldOQ1ltQkFNeiswZEVlT3JzYjN6NXlleTNlUC9nb0FTYk9xdHAwRldF?=
 =?utf-8?B?YnlWa2EwUTlKVTNzMDRtRUNWMHF6RWd6a0lsZkhaOXVpOWFkMFp6RHkveVBn?=
 =?utf-8?B?Qllrejl5THJKUEgwR1ZLQnA5UFZxTGxualRaTHY5Vjl0WEErS1BCOEJnRG0x?=
 =?utf-8?B?MjRDc0F5dGVCdVkva2ZFSlBqclpNOCtKdDVyNWxPcDZ1MVJiLytJbjdkcXdx?=
 =?utf-8?B?NHZjRFh2M1Z5bDZMY0crV0xFNkxlYnA5KzhzM0tTN1dJUmgyTDJpVkZaSDZ4?=
 =?utf-8?B?NUxHbExTUnRtZFhKcUZVL1V5cm4vRHlaYlQ4V2lBaWIwWmp1MkNyVC91KzJU?=
 =?utf-8?B?RFVsS1o5NXNMWWNtUDdSMzJRbWJzbHcydlVUNUE5cHZnMW0vZUNwTTdwOHpj?=
 =?utf-8?B?NDB0c3dDYXcwdkxKeVpQeW15K2xWMHFlZVBmcENZUk9lZHd5VkNSelI4TVJp?=
 =?utf-8?B?OTdmTUNiUmxlWWw2RUR4YlhrNCtYTkJzaDVYVStFdEd3bTJRb3N5YVFNTFc3?=
 =?utf-8?B?cGxxdkI1UWJyU2FBaDJBazNWUWpSNE96THczRE9xa296ajFKdFdLeGpvdzRa?=
 =?utf-8?B?TFU4c2JKUzJlMjdsWHJBVEVYcko0RERTZkhFYTN3REpKNElIUDdYM3I0U3o4?=
 =?utf-8?B?QWY2S3QyeTRleE5BTjNYQXlOSEZKNitSbTZKYmRDaXZaN3pVTTA4M1hmQ1dy?=
 =?utf-8?B?SzhrL2FWU2RONjVweTNoTzhGck9RRldmTUMzOTY4SElIeGZYQXlHNEk4R0ZT?=
 =?utf-8?B?VmNsTEV3RWtkVUZ1OFNPU0J0V2dDbUQyaks2T2J3NnlVSU9UaHU4bDRNNlYr?=
 =?utf-8?B?WXNia0xoSTFVZ1N6WUJheWk1STcwTTlIOGU0ZVIwVnNDU3JUdndXbVV0SU5T?=
 =?utf-8?B?U0NvemNTZk45M0JCWGhtOWhUb1pkS3UwSjZvWHBsdzUzVldMT0dEZFlvbXdi?=
 =?utf-8?B?TTJiWGgvcjl1SEY5K2lROVVLUHRRSlRabm1ITjR5dHgrRHJmMmM5ZTVSaTNi?=
 =?utf-8?B?N3RqNWVxY1Zqekx2WS9mcXlUMERPaHE4NWZORDB0d0EzeHArVEZoL3QvalRE?=
 =?utf-8?B?RkxRQkZMZXVkM0I3ZVpmb1Z3MVBKMlk2aDFsU2FZTUJoL1RURC9aNWQrVXZJ?=
 =?utf-8?B?eDV6bUJhRk13TmhYZWFLaEZPU0E5WnNROUZ1eTNjc05SZkxJM2tSQk55VGFl?=
 =?utf-8?B?K1JRaHFiMlRvKy9Za253TFE4OTZwUHF4dmFJSVY5Z2hvRldHdDZya01qbTF5?=
 =?utf-8?B?MnJ3dmxrSHZ5VEgraUcxOVp3dlFzbEVvUVR5SGxNZGhmMFdhMW5jMTczWlVw?=
 =?utf-8?B?N29IUUxvU3dHU2hZWUljckJDdDNibGxQeU5DOGFuYWxiTWFBTUd1dC94UUlH?=
 =?utf-8?Q?zlOcvgkK4rRhEBwX1gac0y4bsZTbFs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym4xMzNmekYrbUhwOHI5L3JqZ1dOSFhnNzBZMUQwN3BnMTVSZ0JjMTZ2Tmd4?=
 =?utf-8?B?TUxWMUo2d3VMeFpuWnZ6K1ZmN3BMQlNvNkpKY2xKNVRJRnVHcnA1UVI1Zmtw?=
 =?utf-8?B?Z1dZQUxaK3FaTmlPYytXVzRQbjVuM25nTElLQUc0OEtDbkZ6d2lRUTZ6Q0xr?=
 =?utf-8?B?U1hLS3NubzVSdVNaSVZYd0VqUVR3MkRYZTYwWjREbHpCTmpOWVo1SHJBS1hJ?=
 =?utf-8?B?VU5UMHh3YjdkWTQ0K2JKaWwxbC8rUzhRRjd5eEIwWWNidXM5T3FtVW96MGRt?=
 =?utf-8?B?OFMrZ3cvRTZCYldQdk1ZNHhrRWpBNDVoR2VMQ296VFZERkRQSFhDdElYd0FW?=
 =?utf-8?B?bVViZUJTVWZkSTZ2d0FESXRsL3l3aE9pcFluejdnRHVFSmRXaUEwMHlKMFpw?=
 =?utf-8?B?c1pUNEpjaFZ1NW93NFVHTzZhR0g3L1N5WTRoRytlbjhSYjlPR1dqVU9TSjZX?=
 =?utf-8?B?UndsUGJGMkQ3d1BIQ0NnUkx4U25UTGpZUVMxSGV4bjAyd1NFek4zS1VrQ1FR?=
 =?utf-8?B?bHJIRTZXa1FienNYcHFzUzBZbmFVd0F4a3BHUWhLSlMxV1VnUVRCcjFyRmhs?=
 =?utf-8?B?alB1QVFUT3hCOUxYalZYeGRYTEZXY21VSnc5dko4amtKRzhFUFNhNThuQjdu?=
 =?utf-8?B?d1R5SWtrWCs1aDFPcXhKYjVPd2locWpIYUlUbXFhc2UrcUdxcVFiQm9ObkpG?=
 =?utf-8?B?YTljdXhZS01yOThPZzBBRHZjcEtFNTBIUkQyendmTkFtN29laE9GNFJsdzF4?=
 =?utf-8?B?cU1sSkhhL05aNy8wOXozc2JjU1BkSzdwbmpieTExd014TXVmM3h6Y243QXlM?=
 =?utf-8?B?Y2Nyb0h4NllaMmF0bEszbFh4N1dFK29zUFlCdWRZd083Yk9qaFovTVZaN3p5?=
 =?utf-8?B?eXZlQnFSTTFWUGpvQ2xEVENaTmJQYXp1d0xTaWJIcms2Y3A3VzFKMG9GbklQ?=
 =?utf-8?B?cWZBQmZjdmlEd2E0Mm5iNE9haldsR05XYUVuRkZsTVluTGFEM0RZSEthTVBj?=
 =?utf-8?B?Ny9oeGJJQlFoSXk2ZXlhNlZ1dU8xU0IxQXQxaDhJdHNSc0Z1eVVaNFh4Wi9P?=
 =?utf-8?B?dkhmaHlXQktiaFZKNFljWkU4eW1ydlJTd255S0ZKRld0TDJZVDZWK3VBelph?=
 =?utf-8?B?ekZ4bW8xbGtSRnlqUitsdWs2ZlNWL05ZZFIwaE5nVXBOeXgvZDRNejQ0dDhQ?=
 =?utf-8?B?UUpGUTA2SmJJaS9rSFRPbHpybjRXdmJSQ0dhYXo3dzZVbXJZS2FFbFZ0SWRu?=
 =?utf-8?B?bTdabWlrRWhWcnk5NjNBeE10UjZXWUtWN21TWXprWmRCSjgvVzlIM1R5QlhG?=
 =?utf-8?B?dHJGbXJ6OEhCWWY1VHNUYjIremhNaitGRjhScFZjWElwa1RRTWlHVGJjZUE0?=
 =?utf-8?B?UEhHdksxdjZjNm9DYlcxYmx6azlxMnp6WWN6d2txb21qdEVxMk9kWjVicTNV?=
 =?utf-8?B?akl0TVpFK2puSGNGcmdVdXZlMEdSVHBOQWNXVjFXTjI0Mit0YUNMSmRwNjVX?=
 =?utf-8?B?Y1BpcW5IQ0xZYzVyUW9nc3MrbGdYNWphcHFiUzF6elNEOEpCTWNMUk9VQUR0?=
 =?utf-8?B?TCtzZ2g3UXl6MmltbTFPUlVZb1I4RXR5YlhCSTFNK25OQngzTCtxZUlrMTVm?=
 =?utf-8?B?TlUzUGxPNkEzV2E2dzVieUZTL29BZTV0ODUrVXhRK3YxbXVwbXAwT1UrRGhY?=
 =?utf-8?B?NW1DNG50a1huY1NES0d6N0VSakZKY21rdEZRWU1GbG5acFJoY2ZOMHU2VC9Z?=
 =?utf-8?B?UnpTSSsxL3lVLzd3RjN6T3k0NGNQZVpDWEIrVGJ6MnUxcm01YXBCdWI1Q2JL?=
 =?utf-8?B?VmVScWVZSTY2ckRpdFVtSXprcTQrU3lVaytlNUVCMHVTbGJXTytYNEkyMURE?=
 =?utf-8?B?dGZHYzJwaWUrcnZVVGN5RjdvS3V2bGl1d3BneUhXUkZTaWU2VFdzcFQwWkNP?=
 =?utf-8?B?elFhSG5mZ3c2TEdzZGdiOXVWR1BzbnRaclhkQmR4UlJzMEJvUUY1aXdhcWdz?=
 =?utf-8?B?cElLMnVlQjVnTlp3RVRPZWFBbTZ5b1BmUUkwRjJBTU1ma04vSDZHYkhJTTlz?=
 =?utf-8?B?Tmk0K0w3bk5sNGVqTEVZN0Q4aS8vb0U4ZERiT2JkZlpTOEdpVHRGU05wcU1s?=
 =?utf-8?B?bnhFNVVXUW5XbmNySysySzRqYU9tUDdWZkdtVE1kQ09oM0JSc2ZTNW5TaGRK?=
 =?utf-8?Q?4rtKxFoUxT5quVWceLtjlEE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0E6C8C55402E348B65F3F92A74228BA@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be4f524-d516-4e84-a934-08dda78da1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 19:41:30.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmuscyIAK4eoArZOdC853lhbkbwLGDbiAB7JUb/fAuDncOEw9U0gkHm7Ev+6cyMdG3Dvd2B5JjNSDxEbh3wlKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4405
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=684738ec cx=c_pps a=nbHxHWYZ5biEzOhcRz1Xag==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=KWA8fD4C8zTt-tDwvJkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xM2GtodXRdtjE34VBf3yO-RQqx5d9uy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0NiBTYWx0ZWRfX7QUS411pmiYB gIT5Nl4BvUD7zv3zmm61UHBDM39+ieBsLs/EbtvtcREVvpVB4m6aU95SiwXmVNiq4LqTqK/eF8w Etwlv9cmV9c7NX9pK223exDt5g1b0HJAZdPzLWs4z9gvkcHDIf/3xyXsjJjr3KFgA2yQBTvy2d0
 JkmvVJj/2Q43UinxVLKtzFiuAkhffuUMm1IjbShITOSsQfWXRrWKcv71v8YGxaMnbGq8lSPdV+B ON54365FbpNjfitdsBEAXCFcXXBIt4QmQncUhhmGsVUFU6PDib34jZ5ezOm+cL2DXQ3Rcjjm/yO NuBezruZhsTJIWa9yUZSiorJmDDPJ1yOzj2p+dPsJE/yU/q9hkKakt4SfznRreOFdc56AgaQNu8
 sitCq+asfumt2lneb7A3KnnlnsclWhgo2kwpl+bqcu8XO1r84hzMvXb38/cMArq5n5TblMRo
X-Proofpoint-ORIG-GUID: xM2GtodXRdtjE34VBf3yO-RQqx5d9uy3
Subject: RE: [HFS] generic/740 failure details
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_08,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090146

SGkgWWFuZ3RhbywNCg0KT24gTW9uLCAyMDI1LTA2LTA5IGF0IDE4OjUyICswODAwLCBZYW5ndGFv
IExpIHdyb3RlOg0KPiBIaSBTbGF2YSBhbmQgQWRyaWFuLA0KPiANCj4g5ZyoIDIwMjUvNi82IDA2
OjQxLCBWaWFjaGVzbGF2IER1YmV5a28g5YaZ6YGTOg0KPiA+IEhpIEFkcmlhbiwgWWFuZ3RhbywN
Cj4gPiANCj4gPiBXZSBoYXZlIGZhaWx1cmUgZm9yIGdlbmVyaWMvNzQwIHRlc3Q6DQo+ID4gDQo+
ID4gLi9jaGVjayBnZW5lcmljLzc0MA0KPiA+IEZTVFlQICAgICAgICAgLS0gaGZzDQo+ID4gUExB
VEZPUk0gICAgICAtLSBMaW51eC94ODZfNjQgaGZzcGx1cy10ZXN0aW5nLTAwMDEgNi4xNS4wLXJj
NCsgIzggU01QDQo+ID4gUFJFRU1QVF9EWU5BTUlDIFRodSBNYXkgIDEgMTY6NDM6MjIgUERUIDIw
MjUNCj4gPiBNS0ZTX09QVElPTlMgIC0tIC9kZXYvbG9vcDUxDQo+ID4gTU9VTlRfT1BUSU9OUyAt
LSAvZGV2L2xvb3A1MSAvbW50L3NjcmF0Y2gNCj4gPiANCj4gPiBnZW5lcmljLzc0MCAgICAgICAt
IG91dHB1dCBtaXNtYXRjaCAoc2VlIC9ob21lL3NsYXZhZC9YRlNURVNUUy0yL3hmc3Rlc3RzLQ0K
PiA+IGRldi9yZXN1bHRzLy9nZW5lcmljLzc0MC5vdXQuYmFkKQ0KPiA+ICAgICAgLS0tIHRlc3Rz
L2dlbmVyaWMvNzQwLm91dAkyMDI1LTA0LTI0IDEyOjQ4OjQ1Ljk2NDI4NjczOSAtMDcwMA0KPiA+
ICAgICAgKysrIC9ob21lL3NsYXZhZC9YRlNURVNUUy0yL3hmc3Rlc3RzLQ0KPiA+IGRldi9yZXN1
bHRzLy9nZW5lcmljLzc0MC5vdXQuYmFkCTIwMjUtMDYtMDUgMTU6MjU6MTguMDcxMjE3MjI0IC0w
NzAwDQo+ID4gICAgICBAQCAtMSwyICsxLDE2IEBADQo+ID4gICAgICAgUUEgb3V0cHV0IGNyZWF0
ZWQgYnkgNzQwDQo+ID4gICAgICAgU2lsZW5jZSBpcyBnb2xkZW4uDQo+ID4gICAgICArRmFpbGVk
IC0gb3Zlcndyb3RlIGZzIHR5cGUgYmZzIQ0KPiA+ICAgICAgK0ZhaWxlZCAtIG92ZXJ3cm90ZSBm
cyB0eXBlIGNyYW1mcyENCj4gPiAgICAgICtGYWlsZWQgLSBvdmVyd3JvdGUgZnMgdHlwZSBleGZh
dCENCj4gPiAgICAgICtGYWlsZWQgLSBvdmVyd3JvdGUgZnMgdHlwZSBleHQyIQ0KPiA+ICAgICAg
K0ZhaWxlZCAtIG92ZXJ3cm90ZSBmcyB0eXBlIGV4dDMhDQo+ID4gICAgICAuLi4NCj4gPiAgICAg
IChSdW4gJ2RpZmYgLXUgL2hvbWUvc2xhdmFkL1hGU1RFU1RTLTIveGZzdGVzdHMtZGV2L3Rlc3Rz
L2dlbmVyaWMvNzQwLm91dA0KPiA+IC9ob21lL3NsYXZhZC9YRlNURVNUUy0yL3hmc3Rlc3RzLWRl
di9yZXN1bHRzLy9nZW5lcmljLzc0MC5vdXQuYmFkJyAgdG8gc2VlIHRoZQ0KPiA+IGVudGlyZSBk
aWZmKQ0KPiA+IFJhbjogZ2VuZXJpYy83NDANCj4gPiBGYWlsdXJlczogZ2VuZXJpYy83NDANCj4g
PiBGYWlsZWQgMSBvZiAxIHRlc3RzDQo+ID4gDQo+ID4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhl
IHdvcmtmbG93IG9mIHRoZSB0ZXN0IGlzIHRvIHJlZm9ybWF0IHRoZSBleGlzdGluZyBmaWxlDQo+
ID4gc3lzdGVtIGJ5IHVzaW5nIHRoZSBmb3JjaW5nIG9wdGlvbiBvZiBta2ZzIHRvb2wgKGZvciBl
eGFtcGxlLCAtRiBvZiBta2ZzLmV4dDQpLg0KPiA+IEFuZCwgdGhlbiwgaXQgdHJpZXMgdG8gcmVm
b3JtYXQgdGhlIHBhcnRpdGlvbiB3aXRoIGV4aXN0aW5nIGZpbGUgc3lzdGVtIChleHQ0LA0KPiA+
IHhmcywgYnRyZnMsIGV0YykgYnkgSEZTL0hGUysgbWtmcyB0b29sIHdpdGggZGVmYXVsdCBvcHRp
b24uIEJ5IGRlZmF1bHQsIGl0IGlzDQo+ID4gZXhwZWN0ZWQgdGhhdCBta2ZzIHRvb2wgc2hvdWxk
IHJlZnVzZSB0aGUgcmVmb3JtYXQgb2YgcGFydGl0aW9uIHdpdGggZXhpc3RpbmcNCj4gPiBmaWxl
IHN5c3RlbS4gSG93ZXZlciwgSEZTL0hGUysgbWtmcyB0b29sIGVhc2lseSByZWZvcm1hdCB0aGUg
cGFydGl0aW9uIHdpdGhvdXQNCj4gPiBhbnkgY29uY2VybnMgb3IgcXVlc3Rpb25zOg0KPiA+IA0K
PiA+IHN1ZG8gbWtmcy5leHQ0IC9kZXYvbG9vcDUxDQo+ID4gbWtlMmZzIDEuNDcuMCAoNS1GZWIt
MjAyMykNCj4gPiAvZGV2L2xvb3A1MSBjb250YWlucyBhIGhmcyBmaWxlIHN5c3RlbSBsYWJlbGxl
ZCAndW50aXRsZWQnDQo+ID4gUHJvY2VlZCBhbnl3YXk/ICh5LE4pIG4NCj4gPiANCj4gPiBzdWRv
IG1rZnMuZXh0NCAtRiAvZGV2L2xvb3A1MQ0KPiA+IG1rZTJmcyAxLjQ3LjAgKDUtRmViLTIwMjMp
DQo+ID4gL2Rldi9sb29wNTEgY29udGFpbnMgYSBoZnMgZmlsZSBzeXN0ZW0gbGFiZWxsZWQgJ3Vu
dGl0bGVkJw0KPiA+IERpc2NhcmRpbmcgZGV2aWNlIGJsb2NrczogZG9uZQ0KPiA+IENyZWF0aW5n
IGZpbGVzeXN0ZW0gd2l0aCAyNjIxNDQwIDRrIGJsb2NrcyBhbmQgNjU1MzYwIGlub2Rlcw0KPiA+
IEZpbGVzeXN0ZW0gVVVJRDogMjA2MmUtZDhkNS00NzMxLTlmM2QtZGRkY2YxYWE3M2VlDQo+ID4g
U3VwZXJibG9jayBiYWNrdXBzIHN0b3JlZCBvbiBibG9ja3M6DQo+ID4gCTMyNzY4LCA5ODMwNCwg
MTYzODQwLCAyMjkzNzYsIDI5NDkxMiwgODE5MjAwLCA4ODQ3MzYsIDE2MDU2MzINCj4gPiANCj4g
PiBBbGxvY2F0aW5nIGdyb3VwIHRhYmxlczogZG9uZQ0KPiA+IFdyaXRpbmcgaW5vZGUgdGFibGVz
OiBkb25lDQo+ID4gQ3JlYXRpbmcgam91cm5hbCAoMTYzODQgYmxvY2tzKTogZG9uZQ0KPiA+IFdy
aXRpbmcgc3VwZXJibG9ja3MgYW5kIGZpbGVzeXN0ZW0gYWNjb3VudGluZyBpbmZvcm1hdGlvbjog
ZG9uZQ0KPiA+IA0KPiA+IHN1ZG8gbWtmcy5oZnMgL2Rldi9sb29wNTENCj4gPiBJbml0aWFsaXpl
ZCAvZGV2L2xvb3A1MSBhcyBhIDEwMjQwIE1CIEhGUyB2b2x1bWUNCj4gPiANCj4gPiBJdCBsb29r
cyBsaWtlIHdlIG5lZWQgdG8gbW9kaWZ5IHRoZSBIRlMvSEZTKyBta2ZzIHRvb2wgdG8gcmVmdXNl
IHRoZSByZWZvcm1hdCBvZg0KPiA+IGV4aXN0aW5nIGZpbGUgc3lzdGVtIGFuZCB0byBhZGQgdGhl
IGZvcmNpbmcgb3B0aW9uLg0KPiANCj4gSSB3b25kZXIgaWYgdGhpcyBpcyBhIGdvb2QgdGltZSB0
byByZWltcGxlbWVudCBoZnMtcHJvZ3MgaW4gcnVzdC4NCj4gDQoNCkZyYW5rbHkgc3BlYWtpbmcs
IEkgZG9uJ3Qgc2VlIHRoZSBwb2ludCB0byByZS13cml0ZSB0aGUgaGZzLXByb2dzIGluIFJ1c3Qg
Zm9yDQptdWx0aXBsZSByZWFzb25zOg0KKDEpIG1vc3RseSwgdGhlIG1haW4gdXNlLWNhc2UgdGhh
dCBIRlMvSEZTKyBwYXJ0aXRpb24gaXMgY3JlYXRlZCB1bmRlciBNYWMgT1MNCmFuZCBzb21lYm9k
eSB0cmllcyB0byBtb3VudCBpdCB1bmRlciBMaW51eCB0byBhY2Nlc3MgZGF0YTsNCigyKSBBcHBs
ZSBpcyB0aGUgb3duZXIgb2YgdGhlIGNvZGUgb24gTWFjIE9TIHNpZGUgYW5kIGl0J3Mgbm90IGdv
b2QgdG8NCnNpZ25pZmljYW50bHkgZGV2aWF0ZSBmcm9tIHRoZSBBcHBsZSdzIHN0YXRlIG9mIHRo
ZSBjb2RlOw0KKDMpIEkgYmVsaWV2ZSB0aGF0IEFwcGxlIGNvbnNpZGVycyBoZnMtcHJvZ3MgYXMg
b2Jzb2xldGUgY29kZSBhbmQgdGhleSBkb24ndA0Kd2FudCBhbnkgc2lnbmlmaWNhbnQgY2hhbmdl
cyBpbiBpdDsNCig0KSB0aGUgaGZzLXByb2dzIGlzIHVzZXItc3BhY2UgdG9vbCwgaXQgaXMgbm90
IGZyZXF1ZW50bHkgdXNlZCwgYW5kIGV2ZW4gaXQNCmZhaWxzLCB0aGVuIHRoZXJlIGlzIG5vIG11
Y2ggaGFybS4NCg0KVGhlIHBvaW50IGZvciBMaW51eCBrZXJuZWwgZHJpdmVyIGlzIGNvbXBsZXRl
bHkgZGlmZmVyZW50Og0KKDEpIGl0J3MgY29tcGxldGVseSBpbmRlcGVuZGVudCBmcm9tIEFwcGxl
IGltcGxlbWVudGF0aW9uIGFuZCB3ZSBjYW4gbW9kaWZ5IGluDQphbnkgcmVhc29uYWJsZSB3YXk7
DQooMikgdGhlIG1lbW9yeSBzYWZldHkgYW5kIHN0YWJpbGl0eSBvZiBrZXJuZWwgZHJpdmVyIGlz
IG1vcmUgaW1wb3J0YW50Ow0KKDMpIHVzaW5nIFJ1c3QgZm9yIEhGUy9IRlMrIGRyaXZlciBpcyBh
IHByYWN0aWNhbGx5IG5ldyB0ZWNobm9sb2d5IGFkb3B0aW9uOw0KKDQpIHBvdGVudGlhbGx5LCBy
ZS13cml0aW5nIEhGUy9IRlMrIGRyaXZlcnMgaW4gUnVzdCBjb3VsZCByZW1vdmUgbXVsdGlwbGUN
CmV4aXN0aW5nIChhbmQgdW5rbm93biB5ZXQpIGJ1Z3MgYW5kIGltcHJvdmUgZWZmaWNpZW5jeSBv
ZiBpdDsNCig1KSByZS13cml0aW5nIEhGUy9IRlMrIGtlcm5lbCBkcml2ZXIgY291bGQgYmUgcG90
ZW50aWFsbHkgaW50ZXJlc3RpbmcgZm9yDQppbnZvbHZpbmcgbmV3IGd1eXMgaW50byBIRlMvSEZT
KyBhY3Rpdml0eSBidXQgaGZzLXByb2dzIGlzIG5vdCBzbyBhdHRyYWN0aXZlLA0KZnJvbSBteSBw
b2ludCBvZiB2aWV3Lg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

