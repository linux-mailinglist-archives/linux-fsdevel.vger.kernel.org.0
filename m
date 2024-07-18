Return-Path: <linux-fsdevel+bounces-23908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74FB934A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 10:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BDA5B23CE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5267E576;
	Thu, 18 Jul 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R083UVfD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IkgGXvTY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40F2C1AC;
	Thu, 18 Jul 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292815; cv=fail; b=hgZ0qsiKsPX+YuaBf9Kfb16gPuwlDrsOaOdlAOWufC+LE0DbSWLq625xAzFO2L1T956UNV1cdWjxdbahYWuyG975IKH0KJaDfQJ7rH2o4+pDtkNZd32D2m82DBEvVdPkC/BCgUu9QlYbm3ZOEZnEdNHg/mg2zph/A9WnmV4LypY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292815; c=relaxed/simple;
	bh=Ov1KNBfG8EyCi8Bgmrzl/7ZMafCc4T5fMCx369sFpAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NswFrMcFiUZ0OgBMMlO/iQOdJ7dUxZK20p+c/uXpQCwpXD4XpcWlWsiUZo1CH54L/ZfxMQKx/YsAxQ5uaj7mCKYQhBlKEkH+tI9leUqU4hy64qqm7443N8IFJouM3pqQaNBilcbCUy0bYm1rPURScJ/JTtSTGXsJQjTq56uuVgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R083UVfD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IkgGXvTY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I8Uj0v015259;
	Thu, 18 Jul 2024 08:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=dSkROase7TaIGhKaEFWRpDe9gnqpNvQgegVdbFnwE+w=; b=
	R083UVfDkiGbmgwNmQZLPJN8zQzfa307vs+Bm7I185R+johf2jyXOmIp9wPG6mtu
	ik+lZAxkHiSJDZg3KuTZW5FVq+mW6EDbwmlF/sUO6sGTdZMDIef/u8bhIc5NAtig
	ntBDmvX+Lh+Kh/ZkAyM2qKpq4ZODrGH5+7oRd7Atnp7OZOktQo8dO5FA++ZZttKL
	xHonMeKTeoL9/SvIM6Fbr35QlJbd1xsLo9bmcCqlJO8adB8Sqlt6XF30jydXW/Q/
	EOqEbWeKVDWMRpMneCTNwZWABE6QHe56bXteQzi7AsA1DL3EDVTcUoqL/5dJPGkS
	xhWx2Y6TacZIdcEymWbHww==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40eykk02bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 08:53:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46I7hjB6021724;
	Thu, 18 Jul 2024 08:53:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dweube4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 08:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHmNqXITuV6LOEjOiLRSs0+X/RaDZUXdFMzVHrfc1Hy3uZfdwgD3qdVXVrfjkHJslgDUJhJfpj2zvgpAQroKCDTU/1nfd0+0wK4klRTnb78gpwnSaTmFNo7wmD99yMwRD8Fpl3iXpnxR/UZIyqS9wbdgjKNJiuoY3/p0phYMF/tDjTk6kOXeGPlIt7++SsJTn1ik8z051Fb7kFJLpIFF11CTaL27S3dC5XaJa3xS4rwi4i2NvEpWrcGtBbQCenN2slnzq2glaTqLTT3wJU00w9sTLZR/4KZJ6jnTl6bH4Hy+EcNL/yKsJ8BqcZhE7Szim9vortJdJJmz11XVEUyfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSkROase7TaIGhKaEFWRpDe9gnqpNvQgegVdbFnwE+w=;
 b=kTbVbA/4utOlqh1LKLbhXFP1oipo/rtVspuv7KEOZ4/LyxpqaUu1HmOU/sX3ty4lkyZhkJfrDIgTaomxmxBRjPzfbmxL5AWROc+ywNQXYVHOYBYQkPaR8I3ohf/BQFk8EUCKJ7BB2DfpwTbtv6eLPP1a0k7pAKWR320a8HwzjXkwtVW67dj3hRahUs4eNHZooB2bJcr7OMaMnQU8YaiUiTBieIvgDBYEt6vkTmLyKCZFUWjqZvhwW6P+spkqO4F/IlIX7uWgTfKLkoQxenJ7SVpzWvkdZbf+zNhY+irw1AxIVX6ExtFvxKNoek4Gw/bz2h2wUm2Cuem/Bb3ekt2Zgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSkROase7TaIGhKaEFWRpDe9gnqpNvQgegVdbFnwE+w=;
 b=IkgGXvTYnV9FgGivrchgKvOTNiaQY/QsuUoyAlXy6WgdS2m0bf3+SJDOBQsbN+pQApg8T9rVYdnZXaGcA97vbEWxFufrZOmksPM1nzwOf4TihybSS+QN/b3frVfIHs8khPXFIzq5zAk/G6khUpsX8RKKQLpjfp3uDKTTc0QvwzI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7096.namprd10.prod.outlook.com (2603:10b6:806:306::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 08:53:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 08:53:18 +0000
Message-ID: <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com>
Date: Thu, 18 Jul 2024 09:53:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
To: Dave Chinner <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
 <ZpBouoiUpMgZtqMk@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZpBouoiUpMgZtqMk@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8d587a-520d-4ca0-dc88-08dca70711a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K0JuNWFDc2J1SnRXNjIveWE2d2pCVGpZcmhLSnNNakVsYW5WdGZMTHNJQUZC?=
 =?utf-8?B?eUhoQ0FobUtUMFFmZ0J2MGI0Mkd1dmZSOC9hTjNJQmpINk1SaGI3a1QrRVdz?=
 =?utf-8?B?c2dEV0lpaW9tdXJCUEJJV1o0U2pINjB3MDI3MERiNHp4alNQUW1ybTE4ZzEr?=
 =?utf-8?B?QUNHSU81YWZnSGxEdzdWNzd2RkhtQTBDYnVPS1BJcUloLzNaWkpKTkI3OEhz?=
 =?utf-8?B?NnRxTEJhSllpekc2Sm1VTWVCUDJLMStSVmtTNjZYMmZFQTE5US9ReitSMWM3?=
 =?utf-8?B?cUNMTXhnTjNoeDYxeW43TWdCUm42cldzcWQzWjBQMTJEMEtuU21vaWFORnBh?=
 =?utf-8?B?R0ZqbnViaHQ4d0NSYlgwd3lkMUJ5eXFFeVZWajdXaFBjcHJVZTRTdTAyZUFt?=
 =?utf-8?B?QURRbzRpNnFHK0tiWldKZDJ5YmdIL2Nmc2R5TGh3VGNOaW1ES1ZYN0hqbXdU?=
 =?utf-8?B?Z0ZxYitSMnRsVWRxZDNoYUxYaDVOSDlKYUp1eEVhVHQ1Zm0rT0lEd0dubDBG?=
 =?utf-8?B?R0pPODhaWm5WQnFtbWR0SVl0KzdpWEdyMHB2aXVTK0xleUc5bGsveVhFVnNa?=
 =?utf-8?B?UHc4ODVqL2h2Mk5yc1BJMjQzUjBjb0NZekNvay9uUCsybDNpZUVYQ2g3Tzcw?=
 =?utf-8?B?ZW8wM0QyWm0rRllFY05XV1dJRHNXNFg1dmMxdlduRzh3dkQrWFoxeFhPOUR2?=
 =?utf-8?B?NlJ3Q08vMzc2VFR3ZS9IaHphM0pMcUx2MGRUUDRNQVl3UnV2b3ZhNHppaE96?=
 =?utf-8?B?TWtmcEIwSWIvYzM5WVp6R3ozWGdIWWZURTNiZVdMK0laUHhidDl2SVZWZTgy?=
 =?utf-8?B?MWlwV2JIR3JGQXJwZWlyYlhkZlB2TUduY3d4czI3dkIzU3JKNXExRXh4MXR4?=
 =?utf-8?B?bnpKM2huWE95ZEdBdXFLNVQxK1ZoVjRtS1prNzhmRkh4OFJNZnpZWVp3SXVZ?=
 =?utf-8?B?MmVLWTh2Rjhya1FoTVdZcFlUQlQ2dFVSNjFTaGdhUzhCS3lTZnVOT0N6K3RP?=
 =?utf-8?B?L051cUZaYnhZY1hkanVKaks4c1RvdWVtUUVIc2h5YVhGYVl6RUpFMk03NmV3?=
 =?utf-8?B?c2x6RnhXc2ZSWjA4NkMvTVFMMXhONThGNkk3UFJLVzNHV2RjM3B2QkZZMkxi?=
 =?utf-8?B?RXN6aHBXVG9lOW9vRHBXbXlySE1YWmZaUzdscXJiWm5Cc0JjNGl1blFZZG9X?=
 =?utf-8?B?RHIwYzZGL1dmdEtOT1FxaGN2Q1VyT3VrejUvRUZ4aXkyMEJZR0RsbUxHeVJE?=
 =?utf-8?B?aGxHSWlKL2RSbVBSMGZSTi9SVlMyanVkUlp4a25IKzcvd0g1RlVCOWtNRnQ3?=
 =?utf-8?B?T3pTZGUrRG9BQzFBckFaUjlEaTVNQ0luL1hNRDN5cFl6RDZDbFU2WGViNlpD?=
 =?utf-8?B?UkJTTVRRb0M0NnFoNzdBUDIwSktFLzhiNUxTSHJJektRNmlZT3pTOTBIQ2hJ?=
 =?utf-8?B?KzRLL1hWS0RyaHRoQlo2SjJBdU4vbWpVYUFBUzNTYjFucFBIdGtYVjI4d2Zp?=
 =?utf-8?B?YzZkQklzWGxTLzhtSzUzei82c09ZWGR1OElkc1VqWFA0dFcrTlFwYnhidTR5?=
 =?utf-8?B?R3lIS0VaU3VaSHVCUDhwVDM2YUNIVjRMMUZsNHhkUWx1QWpxUUMwWjE1Qnpw?=
 =?utf-8?B?S1BoUzc3U0tFQ1NxMjlXR3ZZN3hINFFhZHlwQ2VhdWl1ZHEvamVmbE1lNE0r?=
 =?utf-8?B?bUJZc1JLWWpwdGVIV1F5S3h1aklWQkp4UG9UR2ZXUVVMYkJqNEp0MUZ2R1pQ?=
 =?utf-8?B?YURQU0lvaXFsYlc5UEQ4eFdYeCtYaENNZzRBc1Vud3ZLV2hqeDJBM2FyT3Rk?=
 =?utf-8?B?eUM4R05rNzhnblBxRkVCZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bG5lbVlKRTFBU2N5Vm9nSWkvNDFVZWcxc2VjanFKTVc1ekh1TEozWEpGRGhZ?=
 =?utf-8?B?a3VXanVUMzJHR2JBS2RNcDJ1Q1NIVGkrVVBRRlBtUElFQ2Fqd0JVeVJ1Q2hP?=
 =?utf-8?B?SldQL0w3UktVV1JDV25QK2haZmFmb2pXMzk4M21EUlZ0OGJNb2hpcjJSazFM?=
 =?utf-8?B?TSs5Y3JBUWZsaGFBMFl4S3F0NXhpU1pkaFdmOGg4Qk45WjZqaGo2N3RqaUNR?=
 =?utf-8?B?TUtZT1NMOHhUQWdQd3NRVGFyaS9Ca09jNnd1d2cvUXVRcm85VzJDbklzMi9H?=
 =?utf-8?B?Yy8yRElXQW9ucmNEKzJBMTVIcnFhVXhpUFV5UmdCaUJLVStCekJkZEQ0a1Vl?=
 =?utf-8?B?SzE4Tm1OU0k5djFrMmlFTFNEbEprelhBbjBKSGlZWEcrNHlUOXZJay9XS1pI?=
 =?utf-8?B?OVZHSHlyVSs2TU9vcFozM1hSMU8zRENBRG9Nc29kSTViaHZsRHBzMlNwb1Ux?=
 =?utf-8?B?cWFUOVFBY3lEU1QycVV3NERoTmo1YUdjUkxVc0xmNVdGREJ2Q2pUMWdaRngr?=
 =?utf-8?B?YnJnME04WDZJU3I2N21yejlBMkpjS3prUTRmdENBSndTRGhSVVYyczRiK1Zx?=
 =?utf-8?B?NVU5UDZ6Sm1mdG1laTFZV296VjJpdi82K2FLQVB3eFJPcWFuSkJidk8wUWZV?=
 =?utf-8?B?WlJSTEozckR2clptd3dhNXJ1a0VmQWN0Vk5xd1VFWEdxNG13RSswREt4dTJS?=
 =?utf-8?B?RTdudDlIZ3pHSDNDWC9yNkZjMXVZZHk3UWxMNFJUVjliZ042cTRFWWJCakR6?=
 =?utf-8?B?bzRXWGlCL0hkZnFkQmExa0JYWERNWURJRUxhTUpHVG9BTkk4OHlLVkRDeGJW?=
 =?utf-8?B?TXpuVDkyWU5sMytpNnFocGc5cmRKMU8rYkptaTZtaEc4M1hxQzdHQS94M2I4?=
 =?utf-8?B?NmlEYWduWmZwMWNkMVFINk14L1ByNTZHU1k5d1VvM1hhKzBaLzh2cmdOZk8r?=
 =?utf-8?B?aWhHcHk0RDdWMWRmMG9PMjN6MnVQQk9CUjIybERrQWV0WXJiM2N6c2JaT1hI?=
 =?utf-8?B?QjJaa2lTODBPbEhKZG5OY2ZKOS9ZUk5STU5qakZjR3NudzRuaXdTMkFYN1A0?=
 =?utf-8?B?dEtZUERqVStaOFR6Q2E0eS81M0xJa3BDVFdYRnZ4YjUvRG5GN29wODJucGcr?=
 =?utf-8?B?enJiN08rVE9tQW4vU3A0VFIwZkFlT3RrS3BlZk5NVVBFVDlvTkNQMWx5dDQr?=
 =?utf-8?B?bTVFY28ydDZTbGxqNldsamRJRGtZQXlvSUwyOWRyY0tDZW55RVRtTWtrQllE?=
 =?utf-8?B?Rkh5Q2N0Ti9wM2c1bjZ6OWYxMzZWM0xySXpQN1VvVVUyY1JBUnVXUDZVTWdH?=
 =?utf-8?B?Uk1xZC9mMVA0VTIrOVBOeXA1c3JCQUdYWHZwcXNGU3BPdEhIQy9xRmRWV3Q4?=
 =?utf-8?B?dk4yZ0Q1QStyVitpenlzVWlBS0phTEZaaHV6SE1vdWZkMFI4SUlFUUtTV2pI?=
 =?utf-8?B?MExEQTkwM2hxT0tYeDNocnlrRTgwNzA0N3dVSnFRQmw5eDVNZE5NNHkydVVH?=
 =?utf-8?B?ZHlXT0k0MmxiRCt5VEUvRGY2UnlDU1BndmVvRDJrbmIyLzJVQ1dQVUMyOG9J?=
 =?utf-8?B?TVQwK2RKeEV5VXJqMGtsTTBXRnl2YlhsZVBTdjQya0NkQUJPOW45cm05aTdt?=
 =?utf-8?B?YThUS0ZDZCtqbVNNNm9nbVhTcjk4TVQrRHZnTXFuMlBvZHBKWUpqRFlhQ0NW?=
 =?utf-8?B?MXpEY1ZHcWVwaytyMUxzVUZGd3l3QjlLZU1rNkU1ZzdmMFU0TnFEcUczTkpy?=
 =?utf-8?B?eWdhUnFQWlRoRTc0bitDOGc1RFlXOEFtQXk4SFpyV3JLVjRwRFQzeTVIR3lu?=
 =?utf-8?B?OUJCOUgza0VYWFJyQ2NkczNBb085Qkd6Uk13S3lLOFBxSi9xMlQyL3RNakpv?=
 =?utf-8?B?M0ViNGRLSmtRSlVwUVIxWjlHSkRZZElaTkpyZFRQOFF3bnpZcDlRUHg0alZx?=
 =?utf-8?B?d0RWMDJJa2U1MWpSbkdGbmZhZW1MdDg0Z2RoOHJJQkJVc0VSeVk1VWdsM3dK?=
 =?utf-8?B?SkZzSEdtellaVW1SYWttbGFXMUdteFdDTDNqV29SS0pqcHg5S2o1Mm8zY2hZ?=
 =?utf-8?B?dUE2QUc2OGZKR0NHd3FtNmdKODNPNkl2enQxNDNkY0hHZDNBZFQyaCtmZjdC?=
 =?utf-8?B?SHEyaGtESlZhVmxzbjFWRTZZRmJ4d2xycjZpMHlDUDBsTkgyckQzNFpkdnBn?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Si8IYgsCCejCvfJGstYDtBxIjkU5KVDY1CEpvhhfS4rBXkmNMTXa1jHiV0FezOf8NcnbDWvf6FUZvjWzWcevR8OOxFIkZYlpJDkmQk86v5PwBT350tnHNukIY7CNRIfWs7teAxkHoklBgVIRVjWvmd/wyAIMimLGL4GyA0FEWNtP4tSrXPcz2UEMAzQ480P707AUxcJprDMljdZL0BFcz10dGTKjbsj+Q/NXw70HtTEf7sq0Im0kydmUbEjhiX2OMM53Hjvqd+mXo/J8NlpRTMli3nCRaAMUh/nWKHm1IUustp1hui9XDlq7QJx6gnxzw3OZsC0rT5Esjl1lLBntAbMHDzMy57To3WySzXe7Dzd6JBRBPLRdL4y89c8kDmzsKsayO/3W2ft0RAyiiMu9TwIiUVfT+SK2UD0g1CD+eDV2jOCt6GQQSW3hMohxXkcWeRj2o3R2LZ8BcAbaCjReVPXrR7yNwuRmpTYEEk1MVHqQq3Rhap9q5WIT2CzKrmHp+fxrsBi7fD9P5Nt6XDJv1X8k8Bb9MOBWb7YOKAXyA9Hql8xkmlc46lXy9rB6ysF3gJ71J8IpKgqkZx/7+RtnQxYFwRnCPy57WQtkkJY/B7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8d587a-520d-4ca0-dc88-08dca70711a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 08:53:18.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knr6dkYL5Oe4KTmYsSboO/WhBzVdaNRLeRv8Zll6e0Vr07vSt7X1K7NbidpWJv9afCh8+QUhN4aig5QmfJ0ziQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_05,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407180056
X-Proofpoint-ORIG-GUID: RNmm9cNZ5AP5_7FNl7t0kjKBpgc8ixV8
X-Proofpoint-GUID: RNmm9cNZ5AP5_7FNl7t0kjKBpgc8ixV8

On 12/07/2024 00:20, Dave Chinner wrote:
>>> /* Reflink'ed disallowed */
>>> +	if (flags2 & XFS_DIFLAG2_REFLINK)
>>> +		return __this_address;
>> Hmm.  If we don't support reflink + forcealign ATM, then shouldn't the
>> superblock verifier or xfs_fs_fill_super fail the mount so that old
>> kernels won't abruptly emit EFSCORRUPTED errors if a future kernel adds
>> support for forcealign'd cow and starts writing out files with both
>> iflags set?
> I don't think we should error out the mount because reflink and
> forcealign are enabled - that's going to be the common configuration
> for every user of forcealign, right? I also don't think we should
> throw a corruption error if both flags are set, either.
> 
> We're making an initial*implementation choice*  not to implement the
> two features on the same inode at the same time. We are not making a
> an on-disk format design decision that says "these two on-disk flags
> are incompatible".
> 
> IOWs, if both are set on a current kernel, it's not corruption but a
> more recent kernel that supports both flags has modified this inode.
> Put simply, we have detected a ro-compat situation for this specific
> inode.
> 
> Looking at it as a ro-compat situation rather then corruption,
> what I would suggest we do is this:
> 
> 1. Warn at mount that reflink+force align inodes will be treated
> as ro-compat inodes. i.e. read-only.
> 
> 2. prevent forcealign from being set if the shared extent flag is
> set on the inode.
> 
> 3. prevent shared extents from being created if the force align flag
> is set (i.e. ->remap_file_range() and anything else that relies on
> shared extents will fail on forcealign inodes).
> 
> 4. if we read an inode with both set, we emit a warning and force
> the inode to be read only so we don't screw up the force alignment
> of the file (i.e. that inode operates in ro-compat mode.)
> 
> #1 is the mount time warning of potential ro-compat behaviour.
> 
> #2 and #3 prevent both from getting set on existing kernels.
> 
> #4 is the ro-compat behaviour that would occur from taking a
> filesystem that ran on a newer kernel that supports force-align+COW.
> This avoids corruption shutdowns and modifications that would screw
> up the alignment of the shared and COW'd extents.
> 

This seems fine for dealing with forcealign and reflink.

So what about forcealign and RT?

We want to support this config in future, but the current implementation 
will not support it.

In this v2 series, I just disallow a mount for forcealign and RT, 
similar to reflink and RT together.

Furthermore, I am also saying here that still forcealign and RT bits set 
is a valid inode on-disk format and we just have to enforce a 
sb_rextsize to extsize relationship:

xfs_inode_validate_forcealign(
	struct xfs_mount	*mp,
	uint32_t		extsize,
	uint32_t		cowextsize,
	uint16_t		mode,
	uint16_t		flags,
	uint64_t		flags2)
{
	bool			rt =  flags & XFS_DIFLAG_REALTIME;
...


	/* extsize must be a multiple of sb_rextsize for RT */
	if (rt && mp->m_sb.sb_rextsize && extsize % mp->m_sb.sb_rextsize)
		return __this_address;

	return NULL;
}

Is this all ok? Or should we follow similar solution to reflink + 
forcealign?


