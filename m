Return-Path: <linux-fsdevel+bounces-50133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC053AC8703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF78D9E7A69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 03:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210FD1A239B;
	Fri, 30 May 2025 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="faZCbeab";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="faZCbeab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B4D9476;
	Fri, 30 May 2025 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748576688; cv=fail; b=evMGtsgL3wAwBmelLuyColrYnczgLLpKFU5goDTEzgyLCYnY4O0xG9ZFjWVWkBT2nARCOzZxb8hB+tRUMVLGDh/cxNqHoCi/YhJEe7oCQ08O5Nefu7rk8qpwSZSRZuADYFGa/Tb2hJ+b436GHGBklihWJiUJz6AmNdppb/NYDZ0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748576688; c=relaxed/simple;
	bh=wwIjirUhIgWZJ1DjUy1Qwq/Ai37Wd81P490+xs9wOdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sgEo1Ln0Ts5iHt+c9Dbnz2l4bu3c8KLYA1h/uvk4AyjGswwCrMmc3fYbSsBYMlr9U24+yMFaJqg4zlHoVKOPxL9kK0G5pUga9m0GIfD1Qp27IaVQDfKCq0xL21cedFSwqjgPuFP4DG/3QAgxkR7nIfJ2fZ+HwThCG5wDpNUUs4I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=faZCbeab; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=faZCbeab; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yOyTHlTFFxBM1X/xnsF08QPLziMLNzCAvfFD2Qk/Ev/ezajLuDWXL3kXQjHE1HTWmE4bAAVe30WTMa7Ea80vUPB9fm2Iq54dQpSLQeJBptTZw5gmUdMIyTOEkIcK1P/xEE6E7xJH6i27nZM4c0v/Z/Wm9F1jCjyWT6LBqCwyv/PbI0Z72KacwdmeoivOi5lkexcr4rn060uPcgtjLxKLsp5MwPNjB75XlLkpeTBSeZiugOkHra2e8xEu1y9F737SzQNCphhboqN26VLGZj+Xc5+y/6vjdmZy1y/0BURLwo4R1HeqgH8W1J/R60x2SUtzQPr4Tahd7mAvGSLi3f1xgA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgdgxDtYraOOX/156EODSqY+dry3gHH9u1xQiTfCa+g=;
 b=arQ8BonX01DxLIhGkFJQPa35zu+oCeOk5ZBs6LbnbjVhEDX53fpHe46DeZPMUVlYAznenBr/jkaS21Uz0hBe7OPEcLiENBnRQDYIsz6Fr0Npl1IbWqyau+q3PV6zRClfo09tGSiwiMvXucSEceC6mLHQo+CKgPrNm0pwmyn9u0EpqY/MNj2p9G8c/fNKjsj9SFZkwjmAbKq1VIt2tSoM4oFdFZWzBCgKug4WVhc6LJsJ9UftrOxkRSlYmRkCYU0eZBs5CvmDcIn02lGwga9sOO4ndHZ3GY/S/ZYsnlHVUzq3ubOx8tJphTRHpppCTLHZWX4MnKfMHKLG1l17M1zAkA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgdgxDtYraOOX/156EODSqY+dry3gHH9u1xQiTfCa+g=;
 b=faZCbeabGkk/rgiMWNM3u73tzSIId5USGESBo3luZXPBbKNaHqUqNt/60qdKiEyi9wmhl8En5iO5NVZIYvVdXI7sV8gk2bDlj2RESabxf9uGXBjk1j7+a2QnywnXDAksNj5sQrmUCWz/oKa+vXTlavUD11mqlP/jY6uTI1Q6b7Q=
Received: from DB9PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:10:1db::27)
 by DBBPR08MB10818.eurprd08.prod.outlook.com (2603:10a6:10:532::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 03:44:39 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::3b) by DB9PR06CA0022.outlook.office365.com
 (2603:10a6:10:1db::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Fri,
 30 May 2025 03:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Fri, 30 May 2025 03:44:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDhU7YTzwiBGWl+SI9q9mfsRxC6ILnCROGH6vnvkZlwtI6urBxczBgR7tgnEaZbHt5qaITWJkuIsUOnmh3Awkzp9N+HPckkdCRUJsi6hPx+RiJjQx5RWZ8LOKYdBjDBhNKR3/2xdHFwukMYuMHO1+/l83LRbtuKalFime83IUvSCWjadl0tVqjyShIucUWvwRIy02jGGa6AlYG5eFKdfubQ45KPnXGZPYE8Aom9kO1mb9u4wR+6B0798Q6hWwiyfflh2wEJPTXZ0iIji0YCcxxLEjp3+u6Lg+of+/BGGDVwwygQD6sd+uxzJhA0dIs0LXSx0jr+e9yhiAXoXk3spEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgdgxDtYraOOX/156EODSqY+dry3gHH9u1xQiTfCa+g=;
 b=JD798vWk7c8eThPaepZPPOl4wM3Eix8SZFI2tQvOUP0GxZuZduF9fBY2YUrRviCFWnw4MYuHRHT2RFrhPGLPSXw8MaHMBTudCz1r3ts2OfyH6q7FseXo6jSBHOenp7TK4g6EZA8vtlW3AxVViD9LWBXzcocHcnNLTPpqNhd1d8Os+EAQPZe3yubjGrI7e/+Bio+Y858Wl40cVCrIFKHHhZ3JJ+utfWk0pvyj1shTdhvyQaDUC6vTgW1tNXD8c0kpoMzw9wv3kLqehFZZZCMHbbMZl03kKrU3oosAE/L3VFin/Dy/e30rJzMVDfb30RHMCjrlBj4kyx9+mG1Or0iu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgdgxDtYraOOX/156EODSqY+dry3gHH9u1xQiTfCa+g=;
 b=faZCbeabGkk/rgiMWNM3u73tzSIId5USGESBo3luZXPBbKNaHqUqNt/60qdKiEyi9wmhl8En5iO5NVZIYvVdXI7sV8gk2bDlj2RESabxf9uGXBjk1j7+a2QnywnXDAksNj5sQrmUCWz/oKa+vXTlavUD11mqlP/jY6uTI1Q6b7Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB9PR08MB9849.eurprd08.prod.outlook.com (2603:10a6:10:462::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 03:44:06 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 03:44:06 +0000
Message-ID: <8fb366e2-cec2-42ba-97c4-2d927423a26e@arm.com>
Date: Fri, 30 May 2025 09:14:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, david@redhat.com, anshuman.khandual@arm.com,
 ryan.roberts@arm.com
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
 <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::18) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB9PR08MB9849:EE_|DB1PEPF00050A00:EE_|DBBPR08MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: 6575a91e-b295-4b94-a217-08dd9f2c4dff
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TWdRaUNLU20yUGFQNm9DZ1dmUElJMFJOUzdzVUNHQUFXb1V6WGFRNm1rV3o3?=
 =?utf-8?B?S3F3VTBYaVExcWtrRkx2bDZPOHloSDJRa0ZCOEpleTY2K0tHdVR0WHJ0cVpS?=
 =?utf-8?B?Mi9YbjlmdWppclJwRm53VEZXeEU4YmRxTEg0bEFyYTZPMkhCanhXMm1naksy?=
 =?utf-8?B?Y1ZKWk5ZZ2dtbnhhQ2huTTRWN2pJeVdybWdoWXNnWXJsZ0FBM0xHOVgzSUtF?=
 =?utf-8?B?eGZUVDJNek9hRXA2VUozU2JISVVCMldybjc1ZUE5Vy9KTmJUUmNiTXhHRy9L?=
 =?utf-8?B?aEtrQ2hBQkFuK01TZGFhKzVycVNINFVweHp0SFlTdmNTc3pPUHpqeDhBQzNW?=
 =?utf-8?B?dXdBeWMxdnliTlp6MXpydUE1aU4rams1TFBNQTQyZzVwZGZDdnEzWEl5K1RR?=
 =?utf-8?B?YjFvUENFN2JpeitIcDk2a1VtY0RJQ3dEZWN5UlFCWkZRS28xUjJwSVA1czdL?=
 =?utf-8?B?VmZrWXB0VmJYTC9qNkZKVUVjRzdnMjhOclMzM3F6Y29CclJSY0hTblVTQU5W?=
 =?utf-8?B?TG1WeHRhQ1h4SWEySkdveDZuakwzODlSb2d1TldiM1Z2RlRyWGV4SDl0eU94?=
 =?utf-8?B?ZHJYQktpcTFKd3VTNkxsUG5vV3FXK1I2bnZTOUVJdkJmTTdsWnJyb0Ezc3dD?=
 =?utf-8?B?bXRWUWFPNno5UDNHSVVVQVhKV0dsRHJHNk5Xd2FsOEgxZTBFZE9ZWGY1SEhq?=
 =?utf-8?B?UXVJRElrZzJMWUFGRXczY0NPd3dldDVJMGhLd0tNaEdRRjYxVTErUXZIV2lZ?=
 =?utf-8?B?UWppcndUNmJDUGFUMjAxOWlrSTFDU24vRkU0TmhETm9admdlR1kxd3dOVkFZ?=
 =?utf-8?B?YkFMV0xKSVNnUUZpQzVoRkZoQW5xRnJmT2h5Q2QvZlczVTNJbCtORWdGL3Zt?=
 =?utf-8?B?WXJyc29HMGE2Y0tMb29iT3NpWjNkUlQ3QTZXaUw2blVEMjduUHBEVjVyWWZH?=
 =?utf-8?B?TStadTJCQ0hOYkhxU0U0VUdZWis0aWhvTms0WFRycm5Mc21xZ3JLZ2hZcFVR?=
 =?utf-8?B?bi93U2g0TWUyUlB0bEVKOUVrNzNKTkUrNWt3ZXlOL3Y4UEFudEFFMFFWK3dM?=
 =?utf-8?B?bi9zUUpYMUV0WExycnhoSkROYTBoMWtsRHdkNWJEd0NiWVQ1S3N3clZVZTBQ?=
 =?utf-8?B?L2FmL0NGT1greEFPMStkQVpreityK0pXYlRnNFR2RjBOVjBaaXlSSWUrRkJM?=
 =?utf-8?B?d1hPNm1uU1ViTlVvSlJoMXlFWDM2V3lERmFSaFlERHBuQXJYR0laRW5ObHVj?=
 =?utf-8?B?bEpxVnk4d05KN0o0Q3lWdk02cTM3V1B0Ym9IK25DTU4xOXNnVlRpa3M0QTVF?=
 =?utf-8?B?SHh6WkJsQ1NtMFlyUU53aXg5aDhBdENxaCtlVWNvaEFYcStmUm4yYjNQQTMx?=
 =?utf-8?B?Uk5KYmU2alNLeEUvY3hJK2w3d1pCYS9rVnNvazIxeVVvclNHWXdnaHlqODlY?=
 =?utf-8?B?dFI3RU5HaHBJZjRGbHc1OWZOOE0xdDhwd0huaEZpdElVQ0FuY2N1WjNPY2dM?=
 =?utf-8?B?Y2hid0JiMTNWdThnOUhTMWxjNFdMNE9zMjRFcndaL0o5TXc5OUROTjlzcncv?=
 =?utf-8?B?OGJSL2hOZWdHWEJSVzZFako5cVlhUGF1dzZGZlRRc094akJydDNaelBwK1h2?=
 =?utf-8?B?aW5ndW1hVzNUY1VvaXFzdHVieHVJd2RBbU13akVXV2ZLaklUdmJHT1U3NHZG?=
 =?utf-8?B?WGtSOGN0U05mZVllWjA2enJ2a1lvQ0laaTgxUTU1T1UrTDFJaHhCb1FWZGMz?=
 =?utf-8?B?Q1gxZTlGL0l1OE9ZL3RueG53dXNQUS9lNmt6c01UcXhhSWlKRWs4Mmd6VW1r?=
 =?utf-8?B?MHBRenc2V0RQSmU4cklRbkxFYXZUdmMzRmpRcTIyK3J4Q01EUXRZUW1WdnRt?=
 =?utf-8?B?VmM5cG43TldDbGFnRnpNaUllL3d2VkxESmZmRVMwTVp4S3c9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9849
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0ea01384-1439-42d6-55db-08dd9f2c3a07
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|1800799024|376014|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWRDaFE0clYxcGN2Sko2b1dpM3FuS1NGWFNqTjl2d3RLdjJKbVRSTURwRFQ0?=
 =?utf-8?B?UzFHM1pPQmZYYVZiTExXNnFXUnJJaHF0dDBhZWpZSFpzWXczV2M0bWF0cTRz?=
 =?utf-8?B?MGdmTzMvN2RhYU1HMEVFWjBiNUxBeEZPdHFKK3NwNU80S1J6WDg1T05GcE5Q?=
 =?utf-8?B?Z05rRTFydnJvTlk3Z29EYXl3N2tLaE9meHZZZ2ZqREdBUHdScVlya1JCQXRX?=
 =?utf-8?B?b3dkZS9lYVRDM0FIWjBVMDlGL0l5T293eDNmeFRUbktiZ2xtek8yS3VEMFlU?=
 =?utf-8?B?aGVrbFhCMHN4bW10SHVWWW1iUG9RYVVkYUFxT2dKeDVqUHhWa29zOWcvSjhE?=
 =?utf-8?B?TEZ2aGFQYUxUTUozaTlmZ0lwUkFyaFFLRFZMTll1K3lGS0xicklHaTUzaTFF?=
 =?utf-8?B?WmN6R1Ztd0IxaWtMenFPdWV1UEl3bDRKR2UwREQ5SnNBYlJFSzVaeVZ0RU0v?=
 =?utf-8?B?MXJ5N0htN0k4dk5NSGJkd3NyMEtRVUd5SDVpMmRsRWFnVXdYOWJ0WVJUajRQ?=
 =?utf-8?B?dGt4dXdWSExuZlZnbkdheTlxZGFFTTcyc0xMblRQUnp1cmtUYjlTdVBLUlda?=
 =?utf-8?B?VWR2aVc4emxvWStLcHcrMGhEQktxZER6SThhSlVlVUdpdW4wclVENmdLZUpj?=
 =?utf-8?B?WTg3SmphdEg3bFlnSDlySE12T3R2RWREMnNaNG9qSjVLL2dKZFB4R2pHSFBp?=
 =?utf-8?B?aExTZCt5bVZSRjZxWFVmVVFNMWRGMmh4SEl0N1QrQ0FscmhQZTZTUDc3ZGRP?=
 =?utf-8?B?RDJ5eDN3Tk56dXBUcEl2RGFMUEpQZnFYeGRsUkt4dkkvTmpsa3hkQzdHK29p?=
 =?utf-8?B?aEpiZmYrdFdWUFJtME9OREpCL1ZaWThQNjAxblFYVURsWENVWHRBZUkrckc5?=
 =?utf-8?B?YTJXcVozZHJNOWhVaU84Z3NnVHZiZEJYa0pBZFBCR3U2cnhOTm1yaWtycDkw?=
 =?utf-8?B?dkxRdTkxc05IZzh0NllQZ0VtWU93RXFEWWNhMU9ZME5lY2hGeWgzNk5qbEpv?=
 =?utf-8?B?dGt6VEFaL2l5ZWg2TFdsT3ArczV5aWg1a3R1T2k1WHZaOWk0RkxzVVB5OXE3?=
 =?utf-8?B?ZEVvNVFDWHNPN2lMdHRyQm4rT20rTVVpakJCNUR3VUVJQVlNbmdXSWI3ZitX?=
 =?utf-8?B?MndiYTRvazhkL2U0WVFEaWZzckU3RW80eHd6eUlJV3Q4S3pPWmk2SEllTmp6?=
 =?utf-8?B?YW5iaTRkQ0d2dVg5dE81dkF2VWFpMHBmNEZCdlpWbEdyOEhDM0JsVDV1czVZ?=
 =?utf-8?B?SHBORXVFOW5XOXNUdkVMam5Ub3BvOW40NU8rZm12UCtUWU9wVWVnYWp3ZXB0?=
 =?utf-8?B?WXZCTEdCajErdlhOVEUyWTAvZzdOVWdVa1k2dGs2WmpTRG5wSTlGdWc2UXp5?=
 =?utf-8?B?RjRkTEFWTnpjamtSSExaWHdxelRPbmcyWUN4UGVaNWtvYVRVdklpWGg5ZGRP?=
 =?utf-8?B?M3J1NGVmL0lWRUlxQk5tY3BlUVVDSUdrYm44UmFhRUNsTGR1R3JlY1BJNi9Y?=
 =?utf-8?B?VDJqdlNrazRHN0FRV3pzQzM3QjZCNVpiSHJuczM4VVB0N1BUVnlLU3lWSTFZ?=
 =?utf-8?B?WkRjWjVia3p6czkvcCtnTGl1MGdJOXFUcjFFSy9rdHJzK3JpZmR6YmxZdjlZ?=
 =?utf-8?B?QkppL0dIVEpwQjB1YS9JMUUvNTlGMTQ4SWNZcUJUYmNNWFhJemRja0pTU0V4?=
 =?utf-8?B?bmNDQm9BeTlOK2FvajZKejM1bTdZVGhuRkZVNVRNZzhrZVVLN2xEbVhDdm03?=
 =?utf-8?B?M0h1MG1GVGxjTE1qV3RyQUo1N2lyK2I4ODU2U1I4MDdNTE11N0djWXgxVDBC?=
 =?utf-8?B?MWtjMW9pOTR3VjA0dG0xNDJqT090aUpMR2kxMTlTMDR3WDBZVDRoQkhDbHh0?=
 =?utf-8?B?TEwzVzhqL0NpUytuejNXRUc1TXAxWDExRDBhckxMaUhRQ2Q0RElyMVNHWnp3?=
 =?utf-8?B?Z004R2FOK1c3U0hBbHVhQmZCZUw1dTJFMlBRNmtHNjRKL1lGNk5NTlRuZ3Iw?=
 =?utf-8?B?cG5YWjFtdnJrQ0wvT2lZVFNDZU9DWHdsSFAxV0srbUgrOEJHYVFjR24vaVpW?=
 =?utf-8?Q?EkItR4?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(1800799024)(376014)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 03:44:39.1439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6575a91e-b295-4b94-a217-08dd9f2c4dff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10818


On 30/05/25 4:17 am, Zi Yan wrote:
> On 28 May 2025, at 23:17, Dev Jain wrote:
>
>> On 28/05/25 10:42 pm, Zi Yan wrote:
>>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>>
>>>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>>>> Then it may happen that the computed slot already falls beyond the batch,
>>>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>>>> order. Thus ensure that the caller is aware of this by triggering a BUG
>>>> when the entry is a sibling entry.
>>> Is it possible to add a test case in lib/test_xarray.c for this?
>>> You can compile the tests with “make -C tools/testing/radix-tree”
>>> and run “./tools/testing/radix-tree/xarray”.
>>
>> Sorry forgot to Cc you.
>> I can surely do that later, but does this patch look fine?
> I am not sure the exact situation you are describing, so I asked you
> to write a test case to demonstrate the issue. :)


Suppose we have a shift-6 node having an order-9 entry => 8 - 1 = 7 siblings,
so assume the slots are at offset 0 till 7 in this node. If xas->xa_offset is 6,
then the code will compute order as 1 + xas->xa_node->shift = 7. So I mean to
say that the order computation must start from the beginning of the multi-slot
entries, that is, the non-sibling entry.


>
>>
>>>> This patch is motivated by code inspection and not a real bug report.
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>> The patch applies on 6.15 kernel.
>>>>
>>>>    lib/xarray.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/lib/xarray.c b/lib/xarray.c
>>>> index 9644b18af18d..0f699766c24f 100644
>>>> --- a/lib/xarray.c
>>>> +++ b/lib/xarray.c
>>>> @@ -1917,6 +1917,8 @@ int xas_get_order(struct xa_state *xas)
>>>>    	if (!xas->xa_node)
>>>>    		return 0;
>>>>
>>>> +	XA_NODE_BUG_ON(xas->xa_node, xa_is_sibling(xa_entry(xas->xa,
>>>> +		       xas->xa_node, xas->xa_offset)));
>>>>    	for (;;) {
>>>>    		unsigned int slot = xas->xa_offset + (1 << order);
>>>>
>>>> -- 
>>>> 2.30.2
>>> Best Regards,
>>> Yan, Zi
>
> Best Regards,
> Yan, Zi

