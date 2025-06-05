Return-Path: <linux-fsdevel+bounces-50700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBCCACE84E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 04:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7B5177781
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 02:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EB71F2BAE;
	Thu,  5 Jun 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="uTaZBqus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7DD84E1C;
	Thu,  5 Jun 2025 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749089987; cv=fail; b=YGAp6dFaV+byJt1Qd+LPzK2xgosJQ7yxLkjYGfVDwZNzjysu6sidd2ird+hAwkgpoHf75qBHNN74A2UgJ+yEvjgM/4s9H8mC4ltAAJ2+ccL/xW7MHu3toDE7g83nq1SlheMFzad1/+CXOZv7Jf/uUavfb2qvx6JW6cMGC8Rbsu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749089987; c=relaxed/simple;
	bh=JLzr8vQvnNhBEj1Oabml2Ba2GZwFqZgU4xhgcXfc1BA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e6CifQ+9wZ3grin2ARS+WLRi4baet69EwJx2c8AESkO5VBg8M5lVs9vW3HpA/PTUFj8kWV93+7ZcHaBjZAehPCdeH0sKL7KxtDvJ2bCkjL5209qSMETGSqTIByxDQXRqak2fNYqJDSfvlb9BMtv8HTX5bVpCzMTEIKVHHu3xCW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=uTaZBqus; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749089985; x=1780625985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JLzr8vQvnNhBEj1Oabml2Ba2GZwFqZgU4xhgcXfc1BA=;
  b=uTaZBqusUtf8rzy+Xde8XCWdAqWm3k/x+fI36BCBqRE5lq239A+m+ThN
   Kpo2sPRV0ZW9+mGcu+hY3gHlFP6b6Gh28EfA0XcMDIzM2iNAzMNREZs0R
   XkQuJ28MC7W7bLps5hbUxh1M8IOToQLSVLhk6513ETeA3f8RITI0ARn5F
   HfNApVJHesnB8KGpwDfQXnWja9U//D13khCSRvyxtGV7HaMIhnHk0euRq
   ph+6D6/K/BlHG/ytYc+qmkgGHXf+75KGg9VNCu1oyaN56iiBClz8Ly2pK
   JP9JDDQF87xQEiPkgVBHqYWczUYt0xsV97nORV8n5vBX49URDet9/cwKY
   g==;
X-CSE-ConnectionGUID: Sipr873bS/aQn1i+xcs4VQ==
X-CSE-MsgGUID: MxDJKgoDToyeffjUhBtSXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="157633432"
X-IronPort-AV: E=Sophos;i="6.16,210,1744038000"; 
   d="scan'208";a="157633432"
Received: from mail-japanwestazon11011006.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.6])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:18:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYidLXrGJg+o2PW8SzzbQMzfoK42C4dCo9bX6kgTvXATGWlcJEX9CnabeE85wpJ+sJufyueQfdqHmDHhzRWUBRp1W5l0E0fjShV6SE5/Z+7tC/HSb9JYWpn22LW3fmqtkb+3AdTnHQK3OtdWGxPPDn0zkWZAFgH9XVl8zzSATj2Ns9eo9toGB8mF0v/C9vBepvDU3xBMlHMRffYrs/X5oJJSywctLMcB09/gEm3BC/H7VfvTe/a10PubgLT8iNAV4jnQ8vf2g0HVTbvWHx2nB4aZAjbw05JSgG3lEWapzSIQHzvAtL9TaMv5E4XKUEeJJ1m++YTDIp7y+tw1l6lbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLzr8vQvnNhBEj1Oabml2Ba2GZwFqZgU4xhgcXfc1BA=;
 b=w0365kDjJ8nbtlJro9PVoxBmeSVdv8rVOfaJduXIliRVDJTxp/xjZsIiMFeMSzRhwA15pqvUCYez2HcytVe9J/9rL9VlGGRnq8Yy9QgsGwlaWnGgReLJpZPvYnJclv3f/f4BpBdRFlUl3zHKyPRB3l9+NJSfour0JXv3OGZ1QTovKXMCoPNh34Y//yE1VBGtc2Tm3D3E8BK5TBGpjX3G08zyJlXiqHlpftpn6P+ykKdxBXfet98kRWnidmcpJ5cwkk/q+Gyl7dkESr3kl/M4gfvy/F8uCPQQ/lI6k0KEbGXckiuRMxLVrth1KDJSzOaHhCugqevcdzhnTa6fe9ujOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYVPR01MB11277.jpnprd01.prod.outlook.com (2603:1096:400:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 02:18:22 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 02:18:22 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dave Jiang <dave.jiang@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 4/7] cxl/acpi: Add background worker to wait for
 cxl_pci and cxl_mem probe
Thread-Topic: [PATCH v4 4/7] cxl/acpi: Add background worker to wait for
 cxl_pci and cxl_mem probe
Thread-Index: AQHb1NWwFxOtCct2okebJfTHnbLTZbPyv7mAgABSdoCAAMRbAA==
Date: Thu, 5 Jun 2025 02:18:22 +0000
Message-ID: <f96fc202-a3ff-488e-b0d5-e6505eb76da7@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-5-Smita.KoralahalliChannabasappa@amd.com>
 <860121d7-4f40-4da5-b49a-cfeea5bc14c5@fujitsu.com>
 <acb0f359-cd4a-4221-a7ba-9c473ad7ecd2@intel.com>
In-Reply-To: <acb0f359-cd4a-4221-a7ba-9c473ad7ecd2@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYVPR01MB11277:EE_
x-ms-office365-filtering-correlation-id: d881e991-584b-474e-58f5-08dda3d73ef9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2N0SWdQOW5tWVREUnJ0Y2M2aTNFOXNNaS9KSFpsanpqOFNoRmZJdk82eVV2?=
 =?utf-8?B?ZkFPY2NHMzV0TXdTNFpFUjgxUHhGY3dJcHIvRWVBaXN1eWpTOUd0RlI3TFZF?=
 =?utf-8?B?NXIxS1VwdXdrdE42RmtsK2N5Z3dJeldTdE9TM1F6RmFVdmowcFRlUjcyVzR4?=
 =?utf-8?B?amtjZlR1U3B2OStwRFZBSXRMNlhGLzZzZ2tJYWtMNzZtd25EUm8wUURoOVBL?=
 =?utf-8?B?MGcwd3dvOTg2QmtaM3hUS3Z5b3luUVlSbEFOSUVtM2hvRHI0SFRQTjUrMXpD?=
 =?utf-8?B?L1JZRktzT2p6akVDNVpCeldnODZBakg5RmZkalYrM0ViaTBCODlKOTFndnNH?=
 =?utf-8?B?MURld0NTZnNvWmxoMVQxa0J1c1RPMXErWGxUQzF1blFnMDJtSGtXK2RjTzBp?=
 =?utf-8?B?MDJmaGJsSVRWdFd2WVF6Y1NKaUVsQTlXUmFMTHp2TTFOUmtJYlkyaFd6aHVs?=
 =?utf-8?B?T2tiWllQU3BLbE9YdWRkZFllYVJRQlc1amE2M1BLNG5UV1Q2YlkzREIrK05W?=
 =?utf-8?B?NFlod0VFdTZyZzhiLzZ0cktEOWh5R2w5VGV2VkZoU0c4ejJRTDNtYytKcnA1?=
 =?utf-8?B?N3ZoVEo0S1ppOW5hS1F1bGU4V3o4VTZYc21ST3R1UC95dEFyempZcDBZa2VV?=
 =?utf-8?B?eGQzWjl6dmxCRUNSTDQ3Qm1mbndjd1d6anFnWkVPNzVBeDR2NmFOWkZ3dmJM?=
 =?utf-8?B?bVJLSXdra1IwWG5qTWdQcW0wVzRZLzJLOXk1S3Nra0pnMU05TUJRUnlDVnRj?=
 =?utf-8?B?TDlKcEJ4M0FaL3dDRGtSaUpHNzN0QURiODNSRmI5eFZlTklzRUZkeWYyNVNp?=
 =?utf-8?B?ZkxlSnU0UkxOelZIVmZwMFpEZUNwNS96M1Z5VFQ0U1B4REEyYkczS29ybTkw?=
 =?utf-8?B?NTA2b2hzOVh4MjNvM3R2SENDeW56RkdaS0JNaENZWXdWUitIekxJcytNNXZU?=
 =?utf-8?B?OGVLbUl1WEJTVkgzUFpKU01lZFQyOUdOeEp6WElERG11TUdoYnBKNUJjdkxM?=
 =?utf-8?B?MUZrQ2pnczE4TEZCd0orRkVleDBncHF4UG96MEVSaXExSkUxRkpKMmxxQzNw?=
 =?utf-8?B?UENXMjgrZCsrdkJLaXkyaG4zTTQxd1QrdzA1OTgxUGlWcXMyLzZjNjNiZW5q?=
 =?utf-8?B?MXZtcjFaWUpDQzZZV2t4Yko4MlF4amE2c3o0NFE2dVVPMzR0cUhCNjJPeUcw?=
 =?utf-8?B?TjZPTmlwa2hOSFVvaGhOUk5zNHdpd0VHOUJaeWwwbEJlc0FjWk94S25zeFFu?=
 =?utf-8?B?YmpWdGNheXdJalhsZjVla2Mrb0dtZk14U0NRbTJPSFMvSkxrMUtHemF2Yita?=
 =?utf-8?B?cUtRS0pvY01vY0NoWnR5OStlQ0htdXB0UTUvWWoxMnFUc2dNbjZEd25WY0x2?=
 =?utf-8?B?d2JFMWMzZ2g3Z201RzI5d1NvdENyRkF6WlF1S3lsYldabXVvNGFZaHQwWG5I?=
 =?utf-8?B?cXhVbFB0emhhWkNjS2FPUkNVcEx0bWZqSFZqck12Y25mL1JNNklVWlNwVkpK?=
 =?utf-8?B?QTdYbTVuLzh0TzB4RHFmQ21rdTFTMEFLVldDTysyd0c5WDZONGtvTzloVDVk?=
 =?utf-8?B?S3RkWVNyYVFmMS9rY0tZcVd2allaOFlZc2UwTjlTK3JodythVUdEN1RST1Aw?=
 =?utf-8?B?S2xuUVhOblpzQnFhTjVTTTN1NVFEemVVcGFhcit4QW1UNFJZbVVKaEc4WHhJ?=
 =?utf-8?B?WUtEdGtwVkhCa0NMRU1tMEZUeWFxOG52ZlI4d3lqZDRNb1VhcWE5ZGR6QVNW?=
 =?utf-8?B?Yjg4a2NHNDErNjlRYTNrNzl5R24wM0ZoVVpndE1DSFBQb1lmOWwvdFNadVIx?=
 =?utf-8?B?dVdFWmRLQ252NmpzcE1LTEZaU0lCc0pFbnU2QUoyMDIyUHVseUhHS0pScUox?=
 =?utf-8?B?RDRNNUo3YTRiR0MvN1FJSXRUM1k2K08wVW11emhrL3pUSzFwVDFYeW5DZUR5?=
 =?utf-8?B?aGQvS2x0YzdTK2Y1UFljbEFGM3FJa1huSVpkcGNiSTh0M1NNdFUyV0dkR3Z4?=
 =?utf-8?B?ZG5QSmFKYy9SSi9IQ1hPbTFnNlJNSmtXZDZodi9CVzBwK3NTb0VzdjdreUFP?=
 =?utf-8?Q?MH5iBh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXFNVG5xNmRDMjQwWE90T1FhWkEvdGx1b3hBS0xXQ2owblZyRVVxQTFjOGp2?=
 =?utf-8?B?RWVqcXdOYXBFeDNTbm54c0IxUHM0cmIwYUMvNUs5dWkya2NFS2lJa2JET3k2?=
 =?utf-8?B?QnB1TEFxNmYvVnljWnVuK3Ywbm1ISisySTVCZ0tjekR0Y1EvWG43ZXVicktC?=
 =?utf-8?B?T3JPUGxpZEpwVWVDdzlBL1UwT1JsNTduZTc1OVRqSm5YYXJYN09Sb1pEZnJY?=
 =?utf-8?B?MWFmSW9EL09ZTVNrOEFvNy9DMU4rMVIyOHc4TWFObVV0ZkZHaUt5cGJweVdU?=
 =?utf-8?B?SXAxOG1yVXJOMkQzZ2tjYm96VjJWTk4wWmVWcDljZG92OFlhNEJsYWczQUt2?=
 =?utf-8?B?aDMzTHNIVGd5a2hab2hVa3FHRy9YeXBFbWhKbXVEMEhiem1zbndTeTZaTjR3?=
 =?utf-8?B?OHhhTXVMRU1VNHlUREZUWGs2NmRIKzduUXQ0K1YzS0VlM0ExTi9WMzYwZGRB?=
 =?utf-8?B?VHdSNkU4aEpVYXJ1WjJrTm5EWTdGWmlmakh0emFUbjJ3eVhWYVZSRUlwY3po?=
 =?utf-8?B?TnlGM1VsZUd3WE8zNUg2MzhrWmprSys5aENGRUVFaGpmcnExNm9TTUs1M3M3?=
 =?utf-8?B?cVV4aUI0S0lzLzBqWktkNXZRMmpEb1orSVVwc2t4RUVKaDRBMGNJK2NybmFK?=
 =?utf-8?B?ZCtvanlxZW9xejd3VTVmZFhrZHF3L1F5c3hPNG5IdDZwZDh2OWlJUUhxZjk1?=
 =?utf-8?B?cE1zQldKdHdFL1crLzlXdFM4TEhDKzlTbWpWdU5ZVzZIdmpYTmZGdERUMVMx?=
 =?utf-8?B?SytEemNueWVzdm9KTDhacVJ3di9rcFJYVW5iZnpheFJJaDlia2swTlUvSmEw?=
 =?utf-8?B?amJIMXlkcUxtTXQ2eGs3ZDI0cnlJSGtDZDVJNEd3cTBLMm9JLys2ZWR1TGVa?=
 =?utf-8?B?NzVzNmRuVnErdUxjdWxBWFhuUTRjYVNPaW9rMEdoR29hOEVueS9leWJGTUVJ?=
 =?utf-8?B?WTFvT2VEd1JUNmd2ZnkxN0NhbUZENlE4c2xPbENGQXRqY3VPbXNtNnp4M0RX?=
 =?utf-8?B?YktzcFhxSDdOci9YWjlJdFBiMFpHRklYcXFBNDJhTEV2RzJpRlplRFJUZlpJ?=
 =?utf-8?B?TUo0ZExHNDdNM1lCV1N6QThWMFkxdWltdkdSWVBQbk5hM1k4bEFhK0hFK3Ra?=
 =?utf-8?B?YVdOUTExT2NrSEpGN01XYnprRmprNlFmcVhyTWs0aHVYdG9hK1ZVZ2k2L1ZJ?=
 =?utf-8?B?UXp4U1JjT1Z2cmRvelp5ZG5VUXlycWNEeUU5Zkc4Tm5QanJFcGVlTkVwVExZ?=
 =?utf-8?B?cklPQTUyVW5BN3RjQitmbWR2MFJ4THk0NmZjSk5NWkZzY2NSa1JRTFA4TUlt?=
 =?utf-8?B?VzJGckowdzJTWFo0VHYrbmlZWWhnWGMxREIrQndscmJnUmxUOVFveXhnZ2tl?=
 =?utf-8?B?RExlcm9XeTRVWWJNdnpTU1BzY3VCWXVNS25XOGF4QkxUa0RBeElhYktNYlJ2?=
 =?utf-8?B?VUtMa25adDJkVnZFYnlBV1lWSFJoZVdCWmlsNm1Mdm56elFHL0h1YlQ0VGda?=
 =?utf-8?B?RnhsVFZSbm9pTHk2QjIxL3NNYWtHeFJvakRReGN1Z2kzVzViUWF5Y01MZGE1?=
 =?utf-8?B?cGVjT2tzNXRVL3RzRmduZUxtMHF1M3orOHlPZXAzQmFlQ3RlQS9kTlEzRnli?=
 =?utf-8?B?eTRDdzlGS01rQUk4S2lzeVUrRzNROUMrQ0VIbXRHN3o4eXd0UmlJcW03VkU5?=
 =?utf-8?B?MHRmelh1OHNETGIxUTVCV1RtZVFYajhtTkJXYUdkR1E0M1NyS0NML0Q3TSs5?=
 =?utf-8?B?WTJKdFE1bEQ1dklqTWVjWDRuTXFBOExHMlVKbGJLYW45QTFoSW1xMDZrbkxa?=
 =?utf-8?B?OEhsRFNwSkdkNGZxcDQ2SmltQkZUQjhKMUp1bjh5eFhZSXZhZnc1aU9xWDlU?=
 =?utf-8?B?U2RtM0hURWdtQ3lnclE2c2VsaVVLcndvYUhuREtSTGxQc3gyMG5mNUpua3lh?=
 =?utf-8?B?c29YVzZDa1YvaW82V2hoeXIzS08vaDlwMnFZd1Q5aUpJV3IzQ0I4VlZkU1RV?=
 =?utf-8?B?bE1KOXZvMnBBMkFEOWpLbzQ1RGRIQzJCY1FYTUZ4M2t1VGkxMTBlMXVhK0ZP?=
 =?utf-8?B?NFRRTmhxUUdERTBybXhUREFsMkRlVTJONFdtcWtEeUtYV2wyMWRuSWY3OWJk?=
 =?utf-8?B?ZytjTkpIUVY1UUxoaVlSK3NWSExQd25kdGtYOEQxT0p2L3IzV0llOEJKakZ5?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CE00E8569E46342B45866DD4418231F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eReRtyaAAN6PV34Lw+CScxeb06PXUKXBqo5ocRsxUczmrK0zf7QrmXBaJtowcYAo+xJvmYv9KwlGQLhFLymjx0yftMRePGZIwQ3NosF0WJORBlY5icOE0bOyAIh8wKzUJoGsCTdq/wndt/4yb6rObkys9hvR0Q7xz+aUbqoMFFmBuslrvK2skdaaGV1oO3ZCgvCb5ITryBYfxc2JhnBHShoYcI0IEOKjq+zlNiZVkXBqFsUkrWQC48nuQ+dmGj6IbvJ5Ik9h+yUMb1h3aaxXM9TQOIVBmwF3tjiqx3fA2x3H6MzEhQ5lMjfMxNT3ATHgtDu7sLAz8youxd3eSX2rbd3s6aDGjavlrdEJMrVkyVM/2PvITsy5AjguWs6q/vxWUY0m2v9+cf1Ixtr582G9AXHc3aOWrTAjVjnCsFlRi9V8JE7vGVSxeeDdBQ3zV69T3bX0vZJehdhVllnogaXnAdmfKreKaNYBvrAr8T48WhXo4pPqiy0LVFLM0VJ6yQ7wFqRKJ8iNhtMbN0uA4LNQ5TJzsJDryD4RX0TbiSMVVVXzJJ/wc+fMRwwClBvxKmciwo6qqH9wznBObh9AuBaay8nUlsRB/4m1IY9bgCj7f8kzxuL7qlcSdb4J9Hfim6yW
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d881e991-584b-474e-58f5-08dda3d73ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 02:18:22.5804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hObMRO5SVPj6d0etH+PT2P9tFehHtQEq7+F3SYj6serMyfshwcQFkqcRZxr4mWrKwPcMgqqa430zg46QDRLcXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11277

DQoNCk9uIDA0LzA2LzIwMjUgMjI6MzUsIERhdmUgSmlhbmcgd3JvdGU6DQo+Pj4gICAgDQo+Pj4g
K3N0YXRpYyBERUNMQVJFX1dBSVRfUVVFVUVfSEVBRChjeGxfd2FpdF9xdWV1ZSk7DQo+PiBHaXZl
biB0aGF0IHRoaXMgZmlsZSAoc3VzcGVuZC5jKSBmb2N1c2VzIG9uIHBvd2VyIG1hbmFnZW1lbnQg
ZnVuY3Rpb25zLA0KPj4gaXQgbWlnaHQgYmUgbW9yZSBhcHByb3ByaWF0ZSB0byBtb3ZlIHRoZSB3
YWl0IHF1ZXVlIGRlY2xhcmF0aW9uIGFuZCBpdHMNCj4+IHJlbGF0ZWQgY2hhbmdlcyB0byBhY3Bp
LmMgaW4gd2hlcmUgdGhlIGl0cyBjYWxsZXIgaXMuDQo+IFlvdSBtZWFuIGRyaXZlcnMvY3hsL2Fj
cGkuYyBhbmQgbm90IGRyaXZlcnMvY3hsL2NvcmUvYWNwaS5jIHJpZ2h0PyANCg0KWWVzDQoNCg0K
PiBUaGUgY29yZSBvbmUgaXMgbXkgbWlzdGFrZSBhbmQgSSdtIGdvaW5nIHRvIGNyZWF0ZSBhIHBh
dGNoIHRvIHJlbW92ZSB0aGF0Lg0KDQoNCkNvbXBsZXRlbHkgbWlzc2VkIGl0cyBleGlzdGVuY2Ug
LSB0aGFuayB5b3UgZm9yIGNhdGNoaW5nIGFuZCBjbGVhbmluZyB0aGF0IHVwIQ0KDQpUaGFua3MN
ClpoaWppYW4NCg0KDQo+IA0KPiBESg==

