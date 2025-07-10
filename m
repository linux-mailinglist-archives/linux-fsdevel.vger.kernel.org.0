Return-Path: <linux-fsdevel+bounces-54445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471B4AFFC02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718B31C4247F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9733328C5B8;
	Thu, 10 Jul 2025 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RBANHl0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B38128C2DC;
	Thu, 10 Jul 2025 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135573; cv=fail; b=Q0dFMbW9iYwlrXWmuOLBJp/ev7Bw4v7wsaILJvD2T98bpqt8ttOkl2u1PDYyDzBHqzcxH1X/aD6Ch7/LFm/cv3N7B6mPbstltFaHlVjxrARnAylBmD0hbfECRoWa0O7IYSYMTZKFreMLgYlqYlB9AfhOstp1RpASnvJf39SW/N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135573; c=relaxed/simple;
	bh=BGdkzkF1jmlSeaKTxKJ5VG5T5vJ3Uh7bMSR4OMp8hT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ap/+mBvVELYTQhM8PRLhlQKI5N/woJJx96pWP3J71TH63TqatHaLCRhT+Y8Aqe/7V66xWnfQ2P0k0rfryci6ICKRBNdju100MkEhfU/bq9i2hGe2JwPrDI0BiNmMHbVP5AUvnLL7g6vL3dXSQBq3Iy5DIHag7MGOww8t7w8kAcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RBANHl0M; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752135571; x=1783671571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BGdkzkF1jmlSeaKTxKJ5VG5T5vJ3Uh7bMSR4OMp8hT8=;
  b=RBANHl0MdwIvaV4r1ezDpJr1aDy1N99nEoJ4f5i+YvFPBQ1y25QcFAaA
   frHZUoJnOneQE7ATLW5XrJKuNXGra1RjQ/up+aAZJn3/Iax8YwLJTSAtj
   g01zfMrOVak71dZ1/XSGl96ocL9MrhtCLq8G9JUfcDIi9hMz3APeV//Iz
   tf4d/NE9gfDQRKeJYZwFDVh1vf59TvIExOTsZA/JhmuKvmmMxCa3yBlcE
   yeBZaFX9Rh0tt8F2eXMkfLZps9xVED6bYyTFHEDRBSIDZaxys0qwqymij
   +8LpVWx6NfwEHpjRAX/FCwy3b126w02ERn8lCMkZR/iUwrRN10a7C4anH
   Q==;
X-CSE-ConnectionGUID: Xz1txhDsT7uuODEndCduXQ==
X-CSE-MsgGUID: T6tSe9RDQKmrEHUAuogKOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="160689489"
X-IronPort-AV: E=Sophos;i="6.16,300,1744038000"; 
   d="scan'208";a="160689489"
Received: from mail-japanwestazon11010033.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.33])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 17:18:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lI8gCzYTvj53TGiwd+epsRruqOaPr/Y6NH1dEiR5juivDNJPPJ3QwXP69Vp+uZzeAyNaD+hCjZbrQzmg5ejecRrW98tFafhadbmP/d9R+70mE64POUdpNgTvwKwkJQp8F/VvSTze8wxFwZfRP8QO+fBKqHrx0tT0o7YcI57Y8LUnYP7/Zi+EFj/3K4QIrnNOc+JpEsaKgGPbKSXGtqwczw3iAzLQ9NBdkIKtxnYv/fW1vb1lIBpUfpvZ1GWcVB2QadibX4sFLR9BZQDhjOp094pe5tNTVe417/e+cW2ACFjaZ723d+YCmO6hUIdYKb4m0gaH0zNLOYXfHdf9tFZHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGdkzkF1jmlSeaKTxKJ5VG5T5vJ3Uh7bMSR4OMp8hT8=;
 b=jquwhVDCM4vRzz2u53wgOvXo5uxCHtxAz5ut/3mcUBLXlCyptvqVrdv8jRgEExPMSzmEDW3oQUA4eh5nMW96PSL7nQ31P6IugkSmbeGRXE02qEmxv8CKqC8twN7JPKimwJEhQ2NrkkS1b2cfViV4VTNA4clTUYWyWgZnBgDQP9bqU+9Dqj/fgSG+JhvcISqFNYqufnILXiuFayoF1VaRNFYtQdVMA3uQISqEI3vImAoXPmdJYVUs6ItWH0fmDSXGc6EFrC1EzLH0maksOntT/5Hd13SNun0ufsTzwj5bTIhVwM3A+fVWNJTS/lZbs8jJjoRsXGpeO0wMaBZi7rGu6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com (2603:1096:604:3a3::6)
 by TYWPR01MB11031.jpnprd01.prod.outlook.com (2603:1096:400:398::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 08:18:07 +0000
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0]) by OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 08:18:06 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Koralahalli Channabasappa, Smita"
	<Smita.KoralahalliChannabasappa@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED
 resources until after CXL region creation
Thread-Topic: [PATCH v4 7/7] cxl/dax: Defer DAX consumption of SOFT RESERVED
 resources until after CXL region creation
Thread-Index: AQHb1NW76oeHF2NVEUGw97u/oRYO67QAZ5YAgCqTTACAAEHDAA==
Date: Thu, 10 Jul 2025 08:18:05 +0000
Message-ID: <10e044b9-f126-47d5-86a3-b5b0fcc0bc14@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-8-Smita.KoralahalliChannabasappa@amd.com>
 <aac45d58-afca-487c-8d14-62d5e7fd490e@fujitsu.com>
 <a4860c1e-e6ec-4f5a-a039-bb2066740523@amd.com>
In-Reply-To: <a4860c1e-e6ec-4f5a-a039-bb2066740523@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14468:EE_|TYWPR01MB11031:EE_
x-ms-office365-filtering-correlation-id: 3dff5195-cc62-460a-71b7-08ddbf8a4c1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2JoMzFpYTNTTDJHc1A5ZTYvUmpwM29uNjBxQmVJOTdwZU9KTGJSYmw2N0ky?=
 =?utf-8?B?VTQ4UHlSS1M5WHUzc3pOeXIzc2Y0U3lnT1N6blFmODNTR0VjNFFyM1JvY0w0?=
 =?utf-8?B?cFdXSzE5RU5DMnhESUJ2WXNnaG1UMGxIVERnd25xS2lua2lMalFWN29QNmI2?=
 =?utf-8?B?OVZLMEN5YmIxNTk3YktSMXUzN2gxQ0ROUUdBZ2s2b2I3V3FyUko3RVptaE1y?=
 =?utf-8?B?aHg1OUJaSUVibVpqYkxxMm9VWnFvWk8rTzk1ZUtNQW9QTG5VdGpPbFdBbzZ4?=
 =?utf-8?B?bVFCdW1LMWNtWlR6QWZmNlFVVmpNeGRHMHJiY0wxMGJ3VW9qeVhqNkp6WHhE?=
 =?utf-8?B?T1ZKQ3ZacDc3V0hYZm5ZWENvRU9yV1dvY1FpR0toN3lHUFA2N001SVVjclNQ?=
 =?utf-8?B?NG5sZjgzeDVCY0owZzFjaGhXcktoaWNUZC9xRkhoN0JzWlRyNjIyakhGZm1U?=
 =?utf-8?B?Q092WkRPS0dMcDBmUStGbGwvRkxud3JUWm9LNU9kNWZTSW5kNEcxQ0V1ZEhF?=
 =?utf-8?B?Q3AzOVVHTGNvcFd3bnM0SnJGZHFyVlEzbzY2UXlWZDh2eG5nYlpnS1pRM05u?=
 =?utf-8?B?bmdMZzdsUGwyTFR5LzBldmdJUGEyVHJhR0NNSGFJSHJLanVteWREZjY3ZGYy?=
 =?utf-8?B?Rkh0MWxkc1RBd2thMU51b0pMUDFvTnJianNETUJ2V0tlcFA3YjR6LzVmK3NP?=
 =?utf-8?B?VURNbFdhYUNKR3VSQ1NoR0tYRFNHUlc2eERPSEY4YzJEQkJ4Rk5zdWxPMlVx?=
 =?utf-8?B?S0lEUFN3ZFlud2FJV21hd2pUQ2hLL01oWXA2cGF5QVJMcmkwMVN6cVNIb1Ez?=
 =?utf-8?B?SVhNWGVyU1dERDh5R2dKWmU2RDFrMzY3UUtFTmxWVnhDcEF4OTFxNDNvT0Jo?=
 =?utf-8?B?YWpmd25EcFlzTXdiQ3BJcTNKSElOYmxtbTlLV3hHMW9GM29vQlR2R3IzQVN3?=
 =?utf-8?B?MU9MRkttb2RmR3dPTWYyN2o0UDJ2TDdKbE1JSERlS1YrUE1Vd2Y4OG9TZTZl?=
 =?utf-8?B?UCtjN2oyeTg5QzdyZ0VJckFXTllWc0NCRk15ZHNsV25xNDhGMGFXRGlObE9J?=
 =?utf-8?B?bnRMSzRiYVVBNzZFcXJGcFpFYmxJK1pQdWp0bm9RZnRreEVJbDU4QkVpWG9l?=
 =?utf-8?B?SjJWKzF5TGFkamhqMy8vOXNFb2NuSHF4Mk1TanZlWjVQc3VCYWxPNWhJVlN3?=
 =?utf-8?B?RmZscTJTaERMNzQ3YVFFRHBPeVpndXFHUVp2Q3dpeTlSM2xFakUrWGd5MUhn?=
 =?utf-8?B?b2MybnNmSldrZ0IrRUpFR0lPMEZnSXRza1dBWlNMWGdiNzhrTjF3cW5xTXQ4?=
 =?utf-8?B?cUVNWnZGM2xicXhxVC94NDM5TjlqKzc3Mmk0Ky9PRGRuRElGMDdsY0Qvbmhz?=
 =?utf-8?B?RGs5MCtlTVdyNDNoN3JxSnpEZS9TaGJBNlU3TlVQcHF6WHdVeEhsVlo1UjM2?=
 =?utf-8?B?WUUrajEwWEFpK3BOZm9RNEpDUUFtQXNoMTkvRmVzY3VsOHRXeVJubDJuTDkx?=
 =?utf-8?B?VUQxSktlQml1MVZTVnV0ZVhWa2F2dUZkVmVxbGRDdVdhRDc2ckZhb3dVb3lx?=
 =?utf-8?B?cGVtTGNWZmJMbXZXazRLWlA5YVNyQm1sR2ZEUS8ySGNoUlJ5VTJmUHI3N1VK?=
 =?utf-8?B?d3BhRldCcWhTcWNyWTM4Nmk2bEszekNaNCtVa1VTd0VrMDdrbUllS3VkTjla?=
 =?utf-8?B?MCtlV0ZoTGFTcFIxU3lScTRTbGlHYlhlSVVzWWdJMGh5V1YxTVlLNlptVjRr?=
 =?utf-8?B?MUFlTUVxTWQ5WUUrMFRJL2ZLMjhwNHo2Q0hwQnJUUWVQMHdaREdmVnc2eGl4?=
 =?utf-8?B?KzBwdUJVT1doMDJYYmw1TUlvNEd5OUNtV25mVTRJb1NaZlpmU3plZSs2RURv?=
 =?utf-8?B?TGNDUU50OFlLL3piRFo3M0ZsV29tSGpQNUppM01wNytWTWVnb2dvMkkwT1Ji?=
 =?utf-8?B?MURFZGpCbDc0cHFOYkhUZGx5NlQyQjIvMndkN0dmNjRVVjdvTGYyMlB1enBa?=
 =?utf-8?B?aU5McUJ0K2lJVXBocE53MFpDa0xjN0JHcTJ1eHBFWjJQaVV5RjJPSTl2bEha?=
 =?utf-8?Q?yRdZkP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14468.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vmt0UTdXR283V1BQQ0FhdWppUERRU041MTNINFlDeGVpWWx2TlJSb25RUVNK?=
 =?utf-8?B?dmw2SXo4ZFVYeWNPRDZVeGtXRDVxZ0ZsQUhjRURHU0JpYzZ1QW5aUG9EQXlZ?=
 =?utf-8?B?OGIwUmVTV1FBOUF1OFh2dUlaQU1zYkhZSm9PcXVxRVgxUFVhRXJ0ZWYwQ3U3?=
 =?utf-8?B?T3Q2Vk02Nyt6S2dSaXZRUUNqTGtoaFlxNXZTK0tqRC9acFhmNlFvVHd2N3ZW?=
 =?utf-8?B?RENoYm1Bai94TjZHWWtBNEFkMjlCN2s1MlM5TkVxa1Z6aXJGN2oyY0hwdTgv?=
 =?utf-8?B?dlRsb2UydFBteVlxYVlnbmJIR0VIMk43YjlYZHFRYi9nSnIrS2pNQkVJazgy?=
 =?utf-8?B?ZHowaXp5SkRTY3FvU0pIZUt3L1llTlBtU3V4NEJLRU9JWGw2dTdEa1BwT0Mx?=
 =?utf-8?B?dnFmUll3RndQdFVmWmhhV2xlRHFZeE1ENFZFU2VxaWs0ZDBaTU4xRDFJdDc1?=
 =?utf-8?B?d1p2MFFsK2ZZN2VIQ1lHVU1oVVBJN1czWVRUM1ExM2ZNb2ZRVzZYTnRuN3pa?=
 =?utf-8?B?ZG9XdDZzS0gzNGlIdEN5MUVoRHJTK1A3Z0tXQUdVcmhZSHZFRGdTOUNUZWxF?=
 =?utf-8?B?cm14QlJzWVJGaTJ2NnhnSzJNa2VRUlpEZkFGMTBYY1IyOE96S3YzRzNHUnZN?=
 =?utf-8?B?N1U0eHRYMldNT3EvREVmWkhDb1VNdnJDU1FuU3lZNE04eXpsYXh1TkRxaURN?=
 =?utf-8?B?ZVNlK3A2YnRtb1MxR0V6TXRnd1BiZXVzcnhSZWp6WkQ0UkI2dmJnVE5rcE01?=
 =?utf-8?B?akpWZGtOZ0pnVzlBcDhsSy9rbEk1R2FUN0Y3aUF3M0FicnMzblRVcVUvblJY?=
 =?utf-8?B?MVZPcUp6NlRyTmlyNzU0ZkdPbGloZ0lCQ1RMczJnU3lmVkh0NUpvNzVzQmxG?=
 =?utf-8?B?UU9JNTNFMTAzT3EvRyt3bUI0YVFwZkdsaU1TTndWS0Y2bWNtY2dFSGZDQ251?=
 =?utf-8?B?MDF2Ym1SRjU1am9ENjhBbVlHOVhPM0tFdnZMK0FjOHJ5cm5nS3FUUjhhRDFt?=
 =?utf-8?B?NmlXQUtBbUt1NjJ4ekFXb1pybk8rYUhtNS9PM0VEeUdWTCtmNCtPSmdqeHVE?=
 =?utf-8?B?cllxcG91RjlkM3hsZnBEUnFXUzB6MjU3OWlCVkptMnRxY3JPYkt4M2gxRnI0?=
 =?utf-8?B?RW1DWVVTUjJKWnhuKzFHUXdwemdnc3Nqc21qUUQwc3pqQVQzblhZRVhCL0ZV?=
 =?utf-8?B?M2RoUUdORlV4SmRuSFBqTEdtQTk3R2dwWERyY1QvVmMyTjRtQ2pMUG01ZWJo?=
 =?utf-8?B?b0wrWG9pWDc4SXcrWG41bE5tYStNRXFBT0JrZ2REaHEzWFRjSHlmcjlhRXIv?=
 =?utf-8?B?Q0Yzem9mUUF3Rzd0NzNrSmZOc1NlaUhNRURFWFNvS05TTTQyZThtTXFPQVk3?=
 =?utf-8?B?Nm9saDVGbDdXT3VSOTBDdUpBVEp6MndYdjBiNkJZZ1doaCtuZk5tdnlUV0xh?=
 =?utf-8?B?djFDaGtua1JiZUNybTgzVFFtck9vbWw0OEJ2VWc1VlhjTTZLdFBOY05aTkJw?=
 =?utf-8?B?TnpubENZUWJzNlVxcXdUQm5GekVHTVJ5T3NiN2MrNzBlS09UZnRvZmZ5TWRP?=
 =?utf-8?B?MEdBN2NMYXRnOWRXaDVra0JYYjhiYk5jYkU4c1p0WUg4ZmlUQ05qUUM5Z1Np?=
 =?utf-8?B?SjhLNEZkNXZGNGc4Y2xIeTgzRFc4RmY3eUxtdkZ1eXk2elVmVnF6RlR3enVV?=
 =?utf-8?B?NVpsY0ZuNG9JRlAwMjJLMjJFQ3E1SnZCRnlmUmJLZEhmcnlMUlZVQyt2OEh4?=
 =?utf-8?B?TEUwam4rZzNybVlycTVSK0pTaHJ3V1ZJWG5Ja29iS2VYb1AvL1FiWUV5NlJy?=
 =?utf-8?B?a0Y1dHFodnlZTE96NCtnejJ3Y2JEN0txL0R5TVllallod1hoWjBYVkJOUUlX?=
 =?utf-8?B?bkk5dXhEcU16Tm5HUjdObDAreTRFd2htYlppU1NHQXgvWi9Da01OWC9QZkhW?=
 =?utf-8?B?dzRFUHE1Y2UrMldqNWVBS2tNWEFqY1NmcUt5NW53UzFSZWliWXZTQ3AzSGRL?=
 =?utf-8?B?MmJXM3RZeGg3emc2Y0QzWFQ4T0x2L21pcjVjSldzSHFpVGltWHVidktkTGtp?=
 =?utf-8?B?bUYwWXB5TWpXZjMybjRXcCtrUm5SOXA1ejRhclQ0SERqZU9DTGZ1aXM0c09J?=
 =?utf-8?B?cFpwVnpydlRKNVBsdmwrWEs0Vjl1djM0dTAvNldXUDBTdFVGMlJEbDIzMDdm?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2439BF5C1329344BDEDA0C8440016E9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	63CVdcWpXD4SFBfDN1zSV+duRU5pTG0uDa9oAqPHeCjnTxXk5plxMN6cswx/dyAwY/sDjZehWDq6xi0JjjeHHmrbzLirkz6s//RsX0sE+wTrwKpmrwpIcYH9Mz4Mjt/p4NticMNhQIaNycflw5xOv0TTnm39VJjQvN0zGlSKkj568r3uHvYARxknrmtcBLzf5kdjJQNlIzaR9zsCaMcWe2PV1pdc+YHOkkL/sYyuYtLmRqIvISZ+B0i71Xna6R3RnL/bSKZl6gj2b7fDbDrcXe6olV34yD37eA6xZLeOmvMQaYh0rJ2pLr+pQTr1Dod+6ZNjwb6SasHJQkoOMYHAzM7Jz2tGF2HU/nRXTO08vd717Mihd4aeyAwGoafoZolDvF9qy3TJDJvR1+I3iKESizeWsp2BPIwlIWQ2xQgqhyC7UCVsEy2nHUoLnjquiwz7NmJmNnOTXaJiAbIQwtX0QBffytR7IsQTqgGcNNX19MsUCMuYku43EfD1EM8tOlQc7CAW8IEfB6NBlNQMMzO39KR8/g8HkzHm5PaMXXv0aJvE4ZUDK0+amQI/lvK8dH28mGXr+Z9Kqym5/7q0klY55rVTAx0+EmtvU5MyWZ+E88Qd4n8AnOke44LSlEaMDFs2
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14468.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dff5195-cc62-460a-71b7-08ddbf8a4c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 08:18:05.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDhYVSeoBaNerhmSlB431G39KHqJNTbWUZ+eMgzCp6A4vaV2F3yd+L//9d54F0aApToA/1P2hoWCAy2RaTA7cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11031

DQoNCk9uIDEwLzA3LzIwMjUgMTI6MjIsIEtvcmFsYWhhbGxpIENoYW5uYWJhc2FwcGEsIFNtaXRh
IHdyb3RlOg0KPj4NCj4+IHdoYXTCoGlzwqB0aGXCoGltcGFjdMKgaWbCoG9uZcKgY29uc3VtZXPC
oGFsbMKgU09GVMKgUkVTRVJWRUTCoHJlc291cmNlcz8NCj4+DQo+PiBTaW5jZcKgYGhtZW1fcmVn
aXN0ZXJfZGV2aWNlKClgwqBvbmx5wqBjcmVhdGVzwqBITUVNwqBkZXZpY2VzwqBmb3LCoHJhbmdl
cw0KPj4gKndpdGhvdXQqwqBgSU9SRVNfREVTQ19DWExgwqB3aGljaMKgY291bGTCoGJlwqBtYXJr
ZWTCoGluwqBjeGxfYWNwacKgLMKgY3hsX2NvcmUvY3hsX2RheA0KPj4gc2hvdWxkwqBzdGlsbMKg
Y3JlYXRlwqByZWdpb25zwqBhbmTCoERBWMKgZGV2aWNlc8Kgd2l0aG91dMKgY29uZmxpY3RzLg0K
PiANCj4gWW91J3JlwqBjb3JyZWN0wqB0aGF0wqBobWVtX3JlZ2lzdGVyX2RldmljZSgpwqBpbmNs
dWRlc8KgYcKgY2hlY2vCoHRvwqBza2lwDQo+IHJlZ2lvbnMgb3ZlcmxhcHBpbmcgd2l0aCBJT1JF
U19ERVNDX0NYTC4gSG93ZXZlciwgdGhpcyBjaGVjayBvbmx5IHdvcmtzIGlmIHRoZSBDWEwgcmVn
aW9uIGRyaXZlciBoYXMgYWxyZWFkeSBpbnNlcnRlZCB0aG9zZSByZWdpb25zIGludG8gaW9tZW1f
cmVzb3VyY2UuIA0KDQpJSVVDLCB0aGlzIHJlbGllcyBvbiB0aGUgdGhlIHJvb3QgZGVjb2RlciBy
ZXNvdXJjZShDRk1XKSBoYXMgYmUgYWxyZWFkeSBpbnNlcnRlZCBpb21lbV9yZXNvdXJjZSB3aGlj
aCBpcyBjdXJyZW50bHkgZG9uZSBpbiBjeGxfYWNwaQ0KDQpUaGlzIGFsc28gY2FuIGJlIHJlc29s
dmVkIGJ5IHRoZSBtb2R1bGVzIGxvYWRpbmcgZGVwZW5kZW5jZSBjaGFpbi4NCnNvbWV0aGluZyBs
aWtlIHRoaXM6DQoNCiNpZiBJU19NT0RVTEUoQ09ORklHX0NYTF9BQ1BJKQ0KTU9EVUxFX1NPRlRE
RVAoInByZTogY3hsX2FjcGkiKTsNCiNlbmRpZg0KDQoNCg0KPiBJZiBkYXhfaG1lbV9wbGF0Zm9y
bV9wcm9iZSgpIHJ1bnMgdG9vIGVhcmx5IChiZWZvcmUgQ1hMIHJlZ2lvbiBwcm9iaW5nKSwgdGhh
dCBjaGVjayBmYWlscyB0byBkZXRlY3Qgb3ZlcmxhcHMg4oCUIGxlYWRpbmcgdG8gZXJyb25lb3Vz
wqByZWdpc3RyYXRpb24uDQo+IA0KPiBUaGlzIGlzIHdoYXQgSSB0aGluay4gSSBtYXkgYmUgd3Jv
bmcuIEFsc28sIEFsaXNvbi9EYW4gY29tbWVudCBoZXJlOiAiTmV3wqBhcHByb2FjaMKgaXPCoHRv
wqBub3TCoGhhdmXCoHRoZcKgQ1hMwqBpbnRlcnNlY3RpbmfCoHNvZnTCoHJlc2VydmVkDQo+IHJl
c291cmNlc8KgaW7CoGlvbWVtX3Jlc291cmNlwqB0cmVlLiIuLg0KDQpJIHRoaW5rIGhpcyBwb2lu
dCB3YXMgdGhlIGxhdHRlciBzZW50ZW5jZS4NCiJPbmx5IG1vdmUgdGhlbSB0aGVyZSBpZiBDWEwg
cmVnaW9uIGFzc2VtYmx5IGZhaWxzIGFuZCB3ZSB3YW50IHRvIG1ha2UgdGhlbSBhdmFpbGFiZSB0
byBEQVggZGlyZWN0bHkuIg0KDQp3aGljaCBpbiBteSB1bmRlcnN0YW5kaW5nIHdhcyByZW1vdmUg
dGhlICdzb2Z0IHJlc2VydmVkJyBpbiB0aGUgbmV4dCByZWdpb24gY3JlYXRpbmcuDQoNCg0KPiAN
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtY3hsL1pQZG9kdWY1SWNrVldRVkRAYXNj
aG9maWUtbW9ibDIvDQo+IA0KPj4NCj4+PiBUb8KgcmVzb2x2ZcKgdGhpcyzCoGRlZmVywqB0aGXC
oERBWMKgZHJpdmVyJ3PCoHJlc291cmNlwqBjb25zdW1wdGlvbsKgaWbCoHRoZQ0KPj4+IGN4bF9h
Y3BpwqBkcml2ZXLCoGlzwqBlbmFibGVkLsKgVGhlwqBEQVjCoEhNRU3CoGluaXRpYWxpemF0aW9u
wqBza2lwc8Kgd2Fsa2luZ8KgdGhlDQo+Pj4gaW9tZW3CoHJlc291cmNlwqB0cmVlwqBpbsKgdGhp
c8KgY2FzZS7CoEFmdGVywqBDWEzCoHJlZ2lvbsKgY3JlYXRpb27CoGNvbXBsZXRlcywNCj4+PiBh
bnnCoHJlbWFpbmluZ8KgU09GVMKgUkVTRVJWRUTCoHJlc291cmNlc8KgYXJlwqBleHBsaWNpdGx5
wqByZWdpc3RlcmVkwqB3aXRowqB0aGUNCj4+PiBEQVjCoGRyaXZlcsKgYnnCoHRoZcKgQ1hMwqBk
cml2ZXIuDQo+Pg0KPj4gQ29udmVyc2VseSzCoHdpdGjCoHRoaXPCoHBhdGNowqBhcHBsaWVkLMKg
YGN4bF9yZWdpb25fc29mdHJlc2Vydl91cGRhdGUoKWDCoGF0dGVtcHRzDQo+PiB0b8KgcmVnaXN0
ZXLCoG5ld8KgSE1FTcKgZGV2aWNlcy7CoFRoaXPCoG1hecKgY2F1c2XCoGR1cGxpY2F0ZcKgcmVn
aXN0cmF0aW9uc8KgZm9ywqB0aGUNCj4+IMKgwqDCoHNhbWXCoHJhbmdlwqAoZS5nLizCoDB4MTgw
MDAwMDAwLTB4MWZmZmZmZmZmKSzCoHRyaWdnZXJpbmfCoHdhcm5pbmdzwqBsaWtlOg0KPj4NCj4+
IFvCoMKgwqAxNC45ODQxMDhdwqBrbWVtwqBkYXg0LjA6wqBtYXBwaW5nMDrCoDB4MTgwMDAwMDAw
LTB4MWZmZmZmZmZmwqBjb3VsZMKgbm90wqByZXNlcnZlwqByZWdpb24NCj4+IFvCoMKgwqAxNC45
ODcyMDRdwqBrbWVtwqBkYXg0LjA6wqBwcm9iZcKgd2l0aMKgZHJpdmVywqBrbWVtwqBmYWlsZWTC
oHdpdGjCoGVycm9ywqAtMTYNCj4+DQo+PiBCZWNhdXNlwqB0aGXCoEhNQVTCoGluaXRpYWxpemF0
aW9uwqBhbHJlYWR5wqByZWdpc3RlcmVkwqB0aGVzZcKgc3ViLXJhbmdlczoNCj4+IMKgwqDCoMKg
MTgwMDAwMDAwLTFiZmZmZmZmZg0KPj4gwqDCoMKgwqAxYzAwMDAwMDAtMWZmZmZmZmZmDQo+Pg0K
Pj4NCj4+IElmwqBJJ23CoG1pc3NpbmfCoHNvbWV0aGluZyzCoHBsZWFzZcKgY29ycmVjdMKgbWUu
DQo+IA0KPiBZZWFoLCB0aGlzIGJ1ZyBpcyBkdWUgdG8gYSBkb3VibGUgaW52b2NhdGlvbiBvZiBo
bWVtX3JlZ2lzdGVyX2RldmljZSgpIG9uY2UgZnJvbSBjeGxfc29mdHJlc2Vydl9tZW1fcmVnaXN0
ZXIoKSBhbmQgb25jZSBmcm9tIGRheF9obWVtX3BsYXRmb3JtX3Byb2JlKCkuDQo+IA0KPiBXaGVu
wqBDT05GSUdfQ1hMX0FDUEk9eSzCoHdhbGtfaW9tZW1fcmVzX2Rlc2MoKcKgaXPCoHNraXBwZWTC
oGluwqBobWVtX2luaXQoKSwNCj4gc28gSSBleHBlY3RlZCBobWVtX2FjdGl2ZSB0byByZW1haW4g
ZW1wdHkuIEhvd2V2ZXIsIEkgbWlzc2VkIHRoZSBkZXRhaWwgdGhhdCB0aGUgQUNQSSBITUFUIHBh
cnNlciAoZHJpdmVycy9hY3BpL251bWEvaG1hdC5jKSBjYWxscyBobWVtX3JlZ2lzdGVyX3Jlc291
cmNlKCksIHdoaWNoIHBvcHVsYXRlcyBobWVtX2FjdGl2ZSB2aWEgX19obWVtX3JlZ2lzdGVyX3Jl
c291cmNlKCkuDQo+IA0KPiBDYXNlIDEgKE5vIGJ1Zyk6IElmIGRheF9obWVtX3BsYXRmb3JtX3By
b2JlKCkgcnVucyB3aGVuIGhtZW1fYWN0aXZlIGlzIHN0aWxswqBlbXB0eS4NCj4gDQo+IHdhbGtf
aG1lbV9yZXNvdXJjZXMoKcKgd2Fsa3PCoG5vdGhpbmfCoOKAlMKgaXQnc8KgZWZmZWN0aXZlbHnC
oGHCoG5vLW9wLg0KPiANCj4gTGF0ZXIsIGN4bF9zb2Z0cmVzZXJ2X21lbV9yZWdpc3RlcigpIGlz
IGludm9rZWQgdG8gcmVnaXN0ZXIgbGVmdG92ZXIgc29mdC1yZXNlcnZlZMKgcmVnaW9uc8Kgdmlh
wqBobWVtX3JlZ2lzdGVyX2RldmljZSgpLg0KPiANCj4gT25secKgb25lwqByZWdpc3RyYXRpb27C
oG9jY3VycyzCoG5vwqBjb25mbGljdC4NCj4gDQo+IENhc2UgMjogSWYgZGF4X2htZW1fcGxhdGZv
cm1fcHJvYmUoKSBydW5zIGFmdGVyIGhtZW1fYWN0aXZlIGlzIHBvcHVsYXRlZCBiecKgaG1hdF9y
ZWdpc3Rlcl90YXJnZXRfZGV2aWNlcygpwqAodmlhwqBobWVtX3JlZ2lzdGVyX3Jlc291cmNlKCkp
Og0KPiANCj4gd2Fsa19obWVtX3Jlc291cmNlcygpIGl0ZXJhdGVzIHRob3NlIHJlZ2lvbnMuIEl0
IGludm9rZXMgaG1lbV9yZWdpc3Rlcl9kZXZpY2UoKS7CoExhdGVyLMKgY3hsX3JlZ2lvbsKgZHJp
dmVywqBkb2VzwqB0aGXCoHNhbWXCoGFnYWluLg0KPiANCj4gVGhpcyByZXN1bHRzIGluIGR1cGxp
Y2F0ZSBpbnN0YW5jZXMgZm9yIHRoZSBzYW1lIHBoeXNpY2FsIHJhbmdlIGFuZCBzZWNvbmTCoGNh
bGzCoGZhaWxzwqBsaWtlwqBiZWxvdzoNCj4gDQo+IFvCoMKgIDE0Ljk4NDEwOF0ga21lbSBkYXg0
LjA6IG1hcHBpbmcwOiAweDE4MDAwMDAwMC0weDFmZmZmZmZmZiBjb3VsZCBub3QgcmVzZXJ2ZcKg
cmVnaW9uDQo+IFvCoMKgwqAxNC45ODcyMDRdwqBrbWVtwqBkYXg0LjA6wqBwcm9iZcKgd2l0aMKg
ZHJpdmVywqBrbWVtwqBmYWlsZWTCoHdpdGjCoGVycm9ywqAtMTYNCj4gDQo+IEJlbG93LCBkaWQg
dGhlIGpvYiB0byBmaXggdGhlIGFib3ZlIGJ1ZyBmb3IgbWUgYW5kIEkgZGlkIGluY29ycG9yYXRl
IHRoaXPCoGluwqB2NS4NCg0KQWN0dWFsbHksIEkgZG9uJ3QgdGhpbmsgaXQncyBhIHJlYWwgcHJv
YmxlbSwgY3VycmVudCBjb2RlIGNhbiB0b2xlcmF0ZSBzdWNoIGR1cGxpY2F0aW5nIHJlZ2lzdHJh
dGlvbi4gc28gSSdtIGZpbmUgdG8ganVzdCB0dXJuIGl0IHRvIGRldl9kZWJ1ZyBmcm9tIGRldl93
YXJuLg0KDQoNCg0KPiANCj4gc3RhdGljwqBpbnTCoGRheF9obWVtX3BsYXRmb3JtX3Byb2JlKHN0
cnVjdMKgcGxhdGZvcm1fZGV2aWNlwqAqcGRldikNCj4gew0KPiArwqDCoMKgwqBpZsKgKElTX0VO
QUJMRUQoQ09ORklHX0NYTF9BQ1BJKSkNCj4gK8KgwqDCoMKgwqDCoMKgwqByZXR1cm7CoDA7DQo+
IA0KPiAgwqDCoMKgwqBkYXhfaG1lbV9wZGV2wqA9wqBwZGV2Ow0KPiAgwqDCoMKgwqByZXR1cm7C
oHdhbGtfaG1lbV9yZXNvdXJjZXMoaG1lbV9yZWdpc3Rlcl9kZXZpY2UpOw0KPiB9DQo+IA0KPiBM
ZXQgbWUga25vdyBpZiBteSB0aG91Z2h0IHByb2Nlc3MgaXMgcmlnaHQuIEkgd291bGQgYXBwcmVj
aWF0ZSBhbnkgYWRkaXRpb25hbMKgZmVlZGJhY2vCoG9ywqBzdWdnZXN0aW9ucy4NCj4gDQo+IE1l
YW53aGlsZSwgSSBzaG91bGQgYWxzbyBtZW50aW9uIHRoYXQgbXkgYXBwcm9hY2ggZmFpbHMsIGlm
IGN4bF9hY3BpIGZpbmlzaGVzIHByb2JpbmcgYmVmb3JlIGRheF9obWVtIGlzIGV2ZW4gbG9hZGVk
LCBpdCBhdHRlbXB0cyB0byBjYWxsIGludG8gdW5yZXNvbHZlZCBkYXhfaG1lbSBzeW1ib2xzLCBj
YXVzaW5nIHByb2JlIGZhaWx1cmVzLiBQYXJ0aWN1bGFybHkgd2hlbsKgQ1hMX0JVUz15wqBhbmTC
oERFVl9EQVhfSE1FTT1tLg0KPiANCj4gbGQ6wqB2bWxpbnV4Lm86wqBpbsKgZnVuY3Rpb27CoGBj
eGxfc29mdHJlc2Vydl9tZW1fcmVnaXN0ZXInOg0KPiByZWdpb24uYzooLnRleHQrMHhjMTUxNjAp
OsKgdW5kZWZpbmVkwqByZWZlcmVuY2XCoHRvwqBgaG1lbV9yZWdpc3Rlcl9kZXZpY2UnDQo+IG1h
a2VbMl06wqAqKirCoFtzY3JpcHRzL01ha2VmaWxlLnZtbGludXg6Nzc6wqB2bWxpbnV4XcKgRXJy
b3LCoDENCj4gDQo+IEkgc3BlbnQgc29tZSB0aW1lIGV4cGxvcmluZyBwb3NzaWJsZSBmaXhlcyBm
b3IgdGhpcyBzeW1ib2wgZGVwZW5kZW5jeSBpc3N1ZSzCoHdoaWNowqBkZWxheWVkwqBtecKgdjXC
oHN1Ym1pc3Npb24uwqBJwqB3b3VsZMKgd2VsY29tZcKgYW55wqBpZGVhcy4uDQo+IA0KPiBJbiB0
aGUgbWVhbnRpbWUsIEkgbm90aWNlZCB5b3VyIG5ldyBwYXRjaHNldCB0aGF0IGludHJvZHVjZXMg
YSBkaWZmZXJlbnQgYXBwcm9hY2ggZm9yIHJlc29sdmluZyByZXNvdXJjZSBjb25mbGljdHMgYmV0
d2VlbiBDTUZXIGFuZCBTb2Z0IFJlc2VydmVkIHJlZ2lvbnMuwqBJwqB3aWxswqB0YWtlwqBhwqBj
bG9zZXLCoGxvb2vCoGF0wqB0aGF0Lg0KDQoNClRoYW5rcyBpbiBhZHZhbmNlLg0KDQooSSBhbSB1
bmNlcnRhaW4gd2hldGhlciBzdWNoIGFuIGFwcHJvYWNoIGhhcyBldmVyIGJlZW4gcHJvcG9zZWQg
cHJldmlvdXNseS4pDQoNCg0KDQoNCj4gDQo+IFRoYW5rcw0KPiBTbWl0YQ0KPiA=

