Return-Path: <linux-fsdevel+bounces-40090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C85A1BDC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E6B3AC028
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDBC1DD872;
	Fri, 24 Jan 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JsZQSQUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5A1DC9AE;
	Fri, 24 Jan 2025 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737753088; cv=fail; b=s4r2ReeOQPKZzywnz0gxQtkhAvIC/AoiBDeG4ormEl36XYxvJWO8/HmbG5AwsHTmTtdvwKE8Zhq5VENsAoQH2boeQadecn1f+G3nR6L5JPfEsK920+Y7VlPoyAAEBkTe+Sxlb7qm/7fIm3zhwtV1+8cskbzn4Gr0nE35qT2wAXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737753088; c=relaxed/simple;
	bh=9iBxkn5ptWnu8WeCOdqsil711VYEtL/6czrqFdBLPuY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Bxdrp6j6RaPdLnJAQlgwfbCvoxcVUul1cUrUdz/NWyo0XC6wIk0Yd4XkaJz9i6qGKIk/Dv0uThj6h7TGwQJTI6eEpsrSDkoFW0CilfJFVc61MdGm6FQJ2AKRwiotvzb/wMOszqVLuoNBOq1ztUxTO8w6xv525vhv6/xc0VoyofE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JsZQSQUv; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OEHgf6012952;
	Fri, 24 Jan 2025 21:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9iBxkn5ptWnu8WeCOdqsil711VYEtL/6czrqFdBLPuY=; b=JsZQSQUv
	pq/sEZadEPcDrN5V3G/UzQ5sWi91Aw7Dm/lYWssyvu1t3R2KceRl2UvdkHwlgngT
	o4GAQt+h34ZexEeXvPJTfa2VrnPkr1YdK1OpTazP3oAWiHrLNsOQ4DAVpsFgd02h
	36ftyIgs76WpL3fSuTBfHQPdFJRJZcHV7We7hl+i4gwK71OYd7EQAjZFlr8Tjc10
	0JKHaWvqquHlhB5zauhIx9/IeY/W0W2WY8yuUiQRSfMqc3AdI4YanM0nxeIr7qFc
	iqO91tGNC6hNw8mgHrLHRtfo9qcd6GuHtKMTLNyY7B+EQQc+LswioEiLzPr/xYio
	BQ6qdbLyO07qrw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c4p7vv0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 21:11:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIJArVJc0cSF+CoLb0ASy+FN43TjSSGSn1XJOtDLqyV3GaZKs53wIdSidjLKfhDRWCEpOd5b0Cs8sOYz4A0GFVYt7g1vHoaENSwcS/duNSZGbkFrj07bhFtSzPm8CgFmFTL7gksDuIGudvdAaLTo/q8MD08JCfvR2r/ME88nwzyOe2VIRdDtbeXAoHEnADgq0vRxQ+8pnYj3DLaONjl/U9mH0acWd/EcbDSYEdNoUkutverVuCCyy5i0M9rvyQFY3zTYz7oulT7WyNgYDgj0ztNXXpduNO8djDiGO60kKE7KTg9ro4aI+iZIU1TWgEOPpsJx0m0PNn6WYGxCTD4rkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iBxkn5ptWnu8WeCOdqsil711VYEtL/6czrqFdBLPuY=;
 b=ZBkeVUePfjm+ZO8qO/EcxyEs5Ke9tk6TW5okxFS2ukPuheIHWeT89KwOLr5xU5nIiyzvX4wHdyM934Y2YouYW1gu+gJciwExH5uZiFMGdds/3yEBk2AzUQEhiGbLzSBOHZJr41Y1XO3uZDXLchfLrcEi0gdR4OXsJKrnrEqdEgnfoqIcLBRu8REtPpONMsMX//48xLtobCtlArB2osAZFC9r0A6ftTuJ+DJjqB4F3B11lMAUNacE+gLfakeyNm3mXQtXZazCbT5r6OxxWIJMtrhrxFWcyLWvDeYPm2j6ahWmZO6rrI6bYTqQezrEt7tsDIobnidRMyOtoXd7pC5zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW3PR15MB3978.namprd15.prod.outlook.com (2603:10b6:303:40::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Fri, 24 Jan
 2025 21:11:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 21:11:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        "bvanassche@acm.org"
	<bvanassche@acm.org>,
        "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Greg Farnum <gfarnum@ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Thread-Topic: [EXTERNAL] Re: [LSF/MM/BPF TOPIC] Generalized data temperature
 estimation framework
Thread-Index: AQHbbqDXiGJ8UXK5fEWDdER5m+EPkbMma7kA
Date: Fri, 24 Jan 2025 21:11:10 +0000
Message-ID: <0fbbd5a488cdbd4e1e1d1d79ea43c39582569f5a.camel@ibm.com>
References: <20250123203319.11420-1-slava@dubeyko.com>
	 <39de3063-a1c8-4d59-8819-961e5a10cbb9@acm.org>
In-Reply-To: <39de3063-a1c8-4d59-8819-961e5a10cbb9@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW3PR15MB3978:EE_
x-ms-office365-filtering-correlation-id: d9f70926-3971-4ea6-f6a8-08dd3cbba09c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eC83V2hDR2VTTTZhUXR1cm9jdmlRZUlFRzRKMmIvU0s0K0xaa3BtdmpLSVpq?=
 =?utf-8?B?ZkpoemZHWmtLdFhQT3R0ZjFWUkxoM0l2NjRQMU0xMU5mNlI0UkRhbWxNYVJV?=
 =?utf-8?B?blhqY1M1MTlZcThMWXNDYmc2N0ZoZmtUbjRNaUdlLzVMYWxuVlpJNHhtdERo?=
 =?utf-8?B?STJ4QjQvQURqZ0YraEx3cGhLMFNsTWxSQ2JzMllBcVJTNHdpeFB3U2N6VldJ?=
 =?utf-8?B?VlJPSFQ5QXFDTWhPR2owRFpvbTlNZDdkalhnS2tRWVdEN0grU1g4Y290eG1D?=
 =?utf-8?B?SzVLT1lhSWZCMU5xSFdmb00wdjIxNWtnazUrb3RNRDRzWEgrbVBTSlB0UjlT?=
 =?utf-8?B?UlZneitIUlhpZmVlUHp1OVlWdzdvcHJPZ0VrMWJVTUFRRTR6Wm5jMi9seDZp?=
 =?utf-8?B?ampoMU5kZDFFcmkwdSt0dWx1dW1yRTlDZlE4MmRyYjkzQk9vbFlzVWlvcVRL?=
 =?utf-8?B?U0dhTW00TXJsM1dKekZvRWE2Z3BIOUVMRkhGRUtqTGxnRS9lamhwL1BEWTFK?=
 =?utf-8?B?ZDlaNSsyUWlvL2RRT3hTa240cHZMZDZ6WkNGbnhIa2RoaWdTNWszRlVTNmQ5?=
 =?utf-8?B?ellSMlBhTDNWU3ZJL29iSG5zYjlSa2J3Z3lYOVd0cExRUDY3cWhCSnhRbGU5?=
 =?utf-8?B?cGRYVFUvQ0dCNmduTGpSeEtuTDI0VUo4U21JTGdNTEUxbk5BS09QSnhXS3d2?=
 =?utf-8?B?Ri9BSjV1TnM4a0hQWC9vR3NPSG1lVmtEK1c4WWE3MzFZd0NGZ2FHWWU4STNG?=
 =?utf-8?B?WGFlUEpnS3BqZjJnV3o4M1VRV3I3ZGxERHp3YnlCNmlyb2tkZTYyNXhseTJ6?=
 =?utf-8?B?T1pXZUwyRlIvYy83RnQxY1ZjUDJMOU9VWUo1TmtxOWpmNDI5bUxrVGZFZ0Jv?=
 =?utf-8?B?dnJ3N00vaGtjNFFXRnlZTWs4Nk9HeCtxdUZBR1gwd2VoRWRzaFl2aWJxRmd0?=
 =?utf-8?B?Y1BEVG03Vlpoa2NBdU8xSUZBLy9kV3BRSnhDSUZqSUMzck1GYnJTRlMyREJC?=
 =?utf-8?B?TDEyY0pwQ0ZFbnltVzBNSitDUThJeEtxWGM2dWNPcDd5MUZwQnRFcFlPVzVO?=
 =?utf-8?B?OE1tZGIyOEtUVDAyT0UzWjQyMTE0VWxWNWpyVk9heTdXaFg3bmN0U1UySDBP?=
 =?utf-8?B?OUNmK2dGeDhOWC8waTNoZDU2Smg4MW8yQTZlUGpodHg0VkMxVnAwMXhjWlVM?=
 =?utf-8?B?NmNGbnExcittVGFNeStpbFVZMmZORCsvdXpxTWx3TVNGQ2p0MjlaU1lMSHFt?=
 =?utf-8?B?YjhxdHJoSE9DaVY4Y2xUdGxHbEpKT2Q5NWJFejVwcUtXaEJES3BTZHV0Y0Nq?=
 =?utf-8?B?VFdxNDdGTitlSHFTc1RaWkh1S0duWXo1YnhBVkx4S0ZaSmV5aUJSQWdJdUdW?=
 =?utf-8?B?YzZla0RzWWwrWnFaNDhVVWYzaGdVZjdwRGc4UjVWU0FjNWRPWDVzME1QaGVp?=
 =?utf-8?B?Q0tYNk5RSGxEZ3kwL0o5SklVc0RpdXdaV2NTVGZEVUpMSkdiYjFvcEE5ZEtB?=
 =?utf-8?B?eStVT0QrcVBzeFgxNnZ2MHZkbDN0Y2h0Vi9CZm5EbVJvdUZMQU9QMkE2Q2kr?=
 =?utf-8?B?RSs2QVpPcUVoVTU3S0pBQjh0eGd3Vkp2Y1hVdDVkNFp2VGJFUTQzTytEYVY2?=
 =?utf-8?B?R3FpN0lDNERuYUM3S0NXMDB4ZnJoU2kwQTZLUEdBb0g1WHFmVjV6ejVmcjl1?=
 =?utf-8?B?SEp3MktXaFI0RjBOTG5qWTRibnkvZVRiN3lRai9MbGQ1eUVEbkozdmZSUEIw?=
 =?utf-8?B?OXp5bWtCTFEzVWxuSVEzVTZKM093aEI2dWtlaVd1ZGhnMXFBdGZuTUVaeVd1?=
 =?utf-8?B?WHRPbzd2NjdndExENkF0a0FBdUVaMEpPZTF5aDVld09WTjhuVUt1WXI1VkVy?=
 =?utf-8?B?UjZ0V1g0c055YXQ2T2FNeXJ3WGlWZDhoMkRQNDg0WHQ5bFdzVDY5Q0pCdGlC?=
 =?utf-8?Q?sjwkPubTIc++QZ/YbZsOS3ezL96v9Yjx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFdPNWFtYmM0V0RQSXFzZmVURUpQSDlXeDdjemx6dHZZeDBpUDluaUg3WkNZ?=
 =?utf-8?B?bEg5aC8xSStVbEZ1QWdnem5zWjRyQ0kzMHdmb3lmR1JNOERyeUJWU0NKQzFz?=
 =?utf-8?B?b2VDR3o1eFJ5N1UxeW1OK2lUZ0RZTSsya0I4djkvZUlYSTZKTnNpOVpiS0g2?=
 =?utf-8?B?WFRFSEpnUHRVN2dIUVg0cjRnREFSZEJabGpTMlhoOExFUEhTdm5nSlY1dnJl?=
 =?utf-8?B?Q0lTTjBCT1hpVzN1cUVhc1hZeHdRa2VsL1IwMGRTbDdFR3FSUmQybG5FVEdy?=
 =?utf-8?B?YTJjeXZUMmRLeGY3SXpJcUNzNnlzOXhhb0FadlRKKzhicG44QTNtTkdEVHBV?=
 =?utf-8?B?ZldaUVdIMjJFanMvYlNteDJkbGFYVHpQMmhzUmlTWjgvdE9VTVlPZFpBNGE5?=
 =?utf-8?B?MXoydmN1TU9nc3Q0bjdlMjA2T0VvWDZaK1VKcWcwYm1yS0hlaWp1QmNXdjh0?=
 =?utf-8?B?UXlDK3RyNW5CNzBjSmJJV2c1ZVpEaHRQL21aTEF1bVN2UnhLYStVcmJqNXFx?=
 =?utf-8?B?QjIwenRGalp4dFl3OEtNbEY4QndlMnNudHNzRjlLNGtnaGVXUGhGY3BTQWU2?=
 =?utf-8?B?bERSaWNRaFJLM0hzREJBdXRSaVM3aitrU1hLcnFLcEZRald3ZlllQWlucHYw?=
 =?utf-8?B?OCsvU1hkNEcxODBSL3JaNUJPVkFMazJ4VlV5ZU9odWN4SzVGdnZBbkpCZ0Qy?=
 =?utf-8?B?eDUwa21wR055aU9rVVRvd3FMbVJMTGgzODNjYm1nYzdiSnRhUmpmQVBZbWVW?=
 =?utf-8?B?Y25MV0s2TmpDMmhMb2dyZit4QXRtVFFaMlRLRlV5TGh6SUtaVjRRbmN6Q0wz?=
 =?utf-8?B?cU1BZE5IZmRlQURqcjluaVdEdUdOaW14TXVVWWFTN2lQL0FGT3Z2NU5BRjV4?=
 =?utf-8?B?MTBtekNub2s5czk0cmpXSVowVXVEZWl2NEZTM21MU2ZpZXZ3eXhQZU9qWXNh?=
 =?utf-8?B?QUtiN0Y3dXkvQkU1UnQ4VS9aTUNRL01zVUsxSEJmZUk0SFQyTmdRU0dIaG9X?=
 =?utf-8?B?elZGMlU3aFo4KzBFT1VFU09DS1pzSHQza0FNMHdKU2dXWkhlaXgxVVh3YldG?=
 =?utf-8?B?ZEtvdElLQ2Qzd3dZRDgvQkozcWs1dUljYVV5WTJKV05GYnFJbTRqWVRVSjRX?=
 =?utf-8?B?WDBSVUhPdXpHUkxvaGg2SXVoVVF3byt0U0xWa1BaWm9jRTJPUGtOd1Q3SVpU?=
 =?utf-8?B?WG55UTVlb0cvaVJqcHpOWGpxRTVPby9xZm1Va24vYXN1RERwZ29YUjkySWoy?=
 =?utf-8?B?U3FadUdFTThuemQwa2tpR3FydERyUHFnUFREM1JpaTlQb3VEVkRGOEo1MUQ1?=
 =?utf-8?B?RkdUZlI3Njk5elYrSW9YQzFOZTNvSjdUbGlmWDk5M0d3VVgvRDVVaG1VcUJN?=
 =?utf-8?B?Y25PdGxIREMxWDRvS29Oc1Bwa0JaU3IxTjVLUytPL25RK2kzNGVQTm82R2Nh?=
 =?utf-8?B?d2JUenp3eUhNQXBSbWcrNE9uelNDUS83d1YrVXNXRktXdms4Z1JDdDZYaTBG?=
 =?utf-8?B?ZGIvdmduQWZnTWdpTXVJcHZ5UjF1dHU0US8yVmVDeTEvUFNIa21OTVozOWdi?=
 =?utf-8?B?VDdJeUVLYTRJdStDS2J5K1EyZ0FpS1k0aCtMRStGY3FXbWxoaThBd0dxUmlx?=
 =?utf-8?B?bVc5NENXZ1ZFMmQxay9jWUFab2ovSjZSOStXUXJYYWg4ZmhaSVlLWXNnWjk2?=
 =?utf-8?B?Rmw2Tmg4b1pnU0pVREVnT2JCbDEvZHZjSnBpaEp0ODNBMnpJOXBUTXZrRXEv?=
 =?utf-8?B?U2N3OXVmZFp5eHZ0Wk5hNThKaG01U044Q1hQcnVFRXFWSGdxd2xuOFVDUTh4?=
 =?utf-8?B?Tk1qK3cydzZNR3FQcUlHdS9mbjU5bThtYzhGWitSbHpwVVQ2MmtBQzBOOGcw?=
 =?utf-8?B?VWtBY292dFhMMU1YVXh6VVRYazJMc3oxOVhFRmF0dkVTWHJPbjF5OEhOVC9h?=
 =?utf-8?B?MW4rWUVxQ05WRHVpMTBPRWZaMXBnbHl0NTlWM2JKaXFRcWZoTGhOeFpWZTh3?=
 =?utf-8?B?WGRPQ1hpVzNvTHNxT1JQOG0wZzk5QVUyR3V1LzJlSVdRSXl4dG1CazVNMXRv?=
 =?utf-8?B?ZHE1eEhMZTdDVmFWRnorMWZwTnBhbEV3dERSdkxKSTl6aEpMWFFOSC9kSzlk?=
 =?utf-8?B?OHdZZkdrb0F3OUk5d2ZLZDdmK1d5U3ViS05uNVZmK25DT0QrS2pRU0d2S3Vn?=
 =?utf-8?Q?kE7zCCRnX1rMUGZxYLQ605A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FB774490E50004685D59DC03E86CF56@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f70926-3971-4ea6-f6a8-08dd3cbba09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 21:11:10.7152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jA/ofNQUKo2N8s/X8dHQK5Sg2f3aJ/r+SyuoSQ8j9XSAwZmPp55OPFoWezBsrvQUMD6sLvo90ehOyMyOi4f/hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3978
X-Proofpoint-GUID: d0yj88quVxeSeXkzqqtBx67yphJRENle
X-Proofpoint-ORIG-GUID: d0yj88quVxeSeXkzqqtBx67yphJRENle
Subject: RE: [LSF/MM/BPF TOPIC] Generalized data temperature estimation framework
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_09,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=959 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240144

SGkgQmFydCwNCg0KT24gRnJpLCAyMDI1LTAxLTI0IGF0IDEyOjQ0IC0wODAwLCBCYXJ0IFZhbiBB
c3NjaGUgd3JvdGU6DQo+IE9uIDEvMjMvMjUgMTI6MzMgUE0sIFZpYWNoZXNsYXYgRHViZXlrbyB3
cm90ZToNCj4gPiBJIHdvdWxkIGxpa2UgdG8gZGlzY3VzcyBhIGdlbmVyYWxpemVkIGRhdGEgInRl
bXBlcmF0dXJlIg0KPiA+IGVzdGltYXRpb24gZnJhbWV3b3JrLg0KPiANCj4gSGkgU2xhdmEsDQo+
IA0KPiBJcyBkYXRhIGF2YWlsYWJsZSB0aGF0IHNob3dzIHRoZSBlZmZlY3RpdmVuZXNzIG9mIHRo
aXMgYXBwcm9hY2ggYW5kDQo+IHRoYXQgY29tcGFyZXMgdGhpcyBhcHByb2FjaCB3aXRoIGV4aXN0
aW5nIGFwcHJvYWNoZXM/DQo+IA0KDQpZZXMsIEkgZGlkIHRoZSBiZW5jaG1hcmtpbmcuIEkgY2Fu
IHNlZSB0aGUgcXVhbnRpdGF0aXZlIGVzdGltYXRpb24gb2YNCmZpbGVzJyB0ZW1wZXJhdHVyZS4N
Cg0KV2hpY2ggZXhpc3RpbmcgYXBwcm9hY2hlcyB3b3VsZCB5b3UgbGlrZSB0byBjb21wYXJlPw0K
QW5kIHdoYXQgY291bGQgd2UgaW1wbHkgYnkgZWZmZWN0aXZlbmVzcyBvZiB0aGUgYXBwcm9hY2g/
IERvIHlvdSBoYXZlDQphIHZpc2lvbiBob3cgd2UgY2FuIGVzdGltYXRlIHRoZSBlZmZlY3RpdmVu
ZXNzPyA6KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg0KDQo=

