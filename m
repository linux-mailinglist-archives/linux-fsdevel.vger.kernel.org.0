Return-Path: <linux-fsdevel+bounces-67066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5328EC33D19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 04:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8769D422C30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9D263C8A;
	Wed,  5 Nov 2025 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="keyWjXu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6851E3787;
	Wed,  5 Nov 2025 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311610; cv=fail; b=lmAcITA8hB3B2ju4j0yKumwn4N+UsyKqyFAp3zyqkS9XVFv3HmNfoyXn6mojY2QYbHn+/ItNKBvqJ3oFpB4rwQJF+Yb3ljVNMhWhYl3iJ1H5Mkf4+gDWXU/KkXojW1itNa9ak6OdwEhTPLz9Bj4tXyx1njhsOgEJ2FGW2MMBNjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311610; c=relaxed/simple;
	bh=EVjWRp0TiOr6+/kf50FO8UwfNLNwSmizAp3ZkNGfAG4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k5uyneBfg0RK1Lybm2A+gS2Pxz54IKnLI6/QB+BI4ZyHHnva5ewUBRZk17h4V17Zk+5kfKr5wsKVaKJyZIOEJ6eM5dQTlVNqOfFEmGAsBWVC8s/zrLLHW5ajjfeIcJoM+XRZOFKk/7RuwCxYdM+yQzLn17ga1DuIDTSrN+KYkKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=keyWjXu8; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy3OgWjMnAjoGBC6p1Xp7/mBxH7XmUE4H3nE6r+cV03KPDott8Zt2WdU8rtj3UcP7W2/2s0r92y+KteVk5GrawfaAq6vmXCjLzkRha2uKg/Uk66KeAAmwvPw50lmKSIE57nSgteRwANPUHgND0lh7spkMQFOcaZVWcy4oJhtzPrIYYeUdNS5LOzMASSrsMLxzF2O850iOcIKGLBFho/43hLUdaonFoR+vZNbDL8+zA6wLzapwTENTvxjI/k4hS/Vk/Mp9ydOZuKwEVx11ImgfWbQNEmQLLLFRDwYUPkbZ0TKGZaGXu9uUFMii4ZJxAdKCf79wKpZJuzmW81nFJdslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYGk9CMSoD4/w/JZaCie4bdwD+PRauDEN+0Hxrru7cM=;
 b=yE4K2rlXIgiUFnZUBDsZIuBE4UjuB4daDdPHhFjrir9G9SRvOHzdli8/D+z409s8CaCQyx7ORfyipTq9TS0c4ITDcLXfaH/h5KDumjH+6f3x5aKK6lkWCQPfK86R3E73yynoIc4MTQnjS88qzblH6GXpPQMa1HsjFrpQjXoDXcwuZgK316pcgXzIT3rFMjnnNPJ3i4LpiRH+3U9NwEWDqtRbuut3+V2yOnVu7T3yYpNVYJ+7zTgt6bfCBGxUS/NRLAqFEEZniarSpaHI0b/6iJ0NNcTkFebGBFfqCDXvdOp08+Im4pc1ZDKvlbd+XeFiCbpmgWLzdtwooq26Hvqmqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYGk9CMSoD4/w/JZaCie4bdwD+PRauDEN+0Hxrru7cM=;
 b=keyWjXu8o5SNPAiZoKx2AoeFPvUEgFU26wldpbviw3fch5c5nZvLz7aJCfqamrWlUEGFmwWpoM8fal/+wgZvwicJeULiYnQaTUeTfI5OWJ6/2996e0qxHXJ4tf+AvGh6FCGLa6KwMzCpSlioTTa0VB5aEJaonDnh60spNPO1wIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 03:00:03 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::c18e:2d2:3255:7a8c%4]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 03:00:02 +0000
Message-ID: <d4b9402e-7dc9-4933-bded-0d92f4aeb064@amd.com>
Date: Tue, 4 Nov 2025 18:59:57 -0800
User-Agent: Mozilla Thunderbird
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Subject: Re: [PATCH v3 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL
To: Tomasz Wolski <tomasz.wolski@fujitsu.com>, alison.schofield@intel.com,
 Dan Williams <dan.j.williams@intel.com>
Cc: Smita.KoralahalliChannabasappa@amd.com, ardb@kernel.org,
 benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com,
 dave.jiang@intel.com, dave@stgolabs.net, gregkh@linuxfoundation.org,
 huang.ying.caritas@gmail.com, ira.weiny@intel.com, jack@suse.cz,
 jeff.johnson@oss.qualcomm.com, jonathan.cameron@huawei.com,
 len.brown@intel.com, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, lizhijian@fujitsu.com, ming.li@zohomail.com,
 nathan.fontenot@amd.com, nvdimm@lists.linux.dev, pavel@kernel.org,
 peterz@infradead.org, rafael@kernel.org, rrichter@amd.com,
 terry.bowman@amd.com, vishal.l.verma@intel.com, willy@infradead.org,
 yaoxt.fnst@fujitsu.com
References: <aQAmhrS3Im21m_jw@aschofie-mobl2.lan>
 <20251103111840.22057-1-tomasz.wolski@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20251103111840.22057-1-tomasz.wolski@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: a81c3012-701b-4ec7-ac90-08de1c176a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1ZvYTA3WkRqeUp1eWNSdUU4cjQwR04yZXVuWkplWEFadUR0Mk5FaVYxSm5T?=
 =?utf-8?B?elZjYVZleitrUnNvckR6TmJrdGZhNjFKK3FMZWhNa0hTbGpNVUZJWlgvUjRX?=
 =?utf-8?B?djVYT0xJYXdRQjdtSy83WjFSZno2K1BTaEptVmlhcG54Ty95VzE3aHdQbWwx?=
 =?utf-8?B?NnZScmNCLy9ERzJKRzJNNzlxd2pPdGw3T1Q2ViswdXhOSUU1YUtIaHlYemtN?=
 =?utf-8?B?c3BBTmY3ZHRuWG9UZzdWQmh6Y1U5b01pOFVPenRwM0Rwa2xMQ2NNYnlmUEgz?=
 =?utf-8?B?YUwxTVpYSFZsME1yMzBmTFM5NlRGSWF3NEhtOGNCQ05HdkpKL1A2RFFRbkVP?=
 =?utf-8?B?ZFRmbjgvWTZxUUx3ZGxSVW5wUDluSjdqNlhEQkVuUlBDV2cySFJjM1N0eGFv?=
 =?utf-8?B?aGI3TVM3eDhpSmVCOHAwRVI4S3Z0UXFPZEhxZE1xUmkzWDVpMDNQam40eGJP?=
 =?utf-8?B?NitZUlVMWWN3NzF6K05XdjIvMzFsWVorczM2R3J1N2xyeEFYblZWaVFEV1VK?=
 =?utf-8?B?Mmx1S1JJS0lWZUErckNUVWEwbGhZZTZCSTQ5K1lYOTVLcUVvV0F4Mlp6dW9T?=
 =?utf-8?B?N2h0Q2pEMkZkaWFoV2xLRm1wS2M5U0JjaU5mWmhoMjRVYWtSZjhNdzBiUUsy?=
 =?utf-8?B?ejNMTkFLamJTRS9kOW1ESTVqd20yODlkdWxiamRPUXdPSXNNZG9WMHhYWjJo?=
 =?utf-8?B?T295endjWmhJRkc2TTc4R2JHQXNlL3lvZUJGc3dDektTbG1DR09Zc2xKS3VL?=
 =?utf-8?B?cmVTaWhzUUNTMlVyRTBaOTV1d1g5WVR6QnZ6MlZQTytQeWQ0czhkUTFaZ0Zv?=
 =?utf-8?B?cFJNZVg5M1F4OURYbmF4Z2tqZGp4eUpMWmVMZVhPTEFVdXhRQ2NFZlY3b0lI?=
 =?utf-8?B?elkxL1J4YXJaeWY1Y1I2bVFnMjVGZnk3MDNtYSsyOXFUZUt6c3I4akRYcksz?=
 =?utf-8?B?alEvNUszWW5GR2tlWnlnWU03SG1MZzg5TzJ4RFVrV1ZRMUNpeU9qWlJ3QWIv?=
 =?utf-8?B?emJNWTd4NU1JclVTU0h1a0w0WkQrckNUTXFDWkt3R3lrZGRZdW1KMmxuVkow?=
 =?utf-8?B?UTZHQko4OGdnRENqZHpjdGRhRXhUbWtyK1VHam8vRXR2emFqNVorY1ZOYXd4?=
 =?utf-8?B?dDE1d3h0dUdVbXJHWWZmQlVneWNFaWRyajM3ZEFXcXJlZDYxUzJJSlo4RFk4?=
 =?utf-8?B?akVnN25VS1AzM0pNbGUxbndvZ3Roc0M1ZFVRbUVyNXdycGw1YWR4alo5N1BM?=
 =?utf-8?B?eDlIak9WM1ROV0hpZlJaUGpvYUVtWHZPRVM5d1RwZkhoQlJ3NVBBYUc4TXRy?=
 =?utf-8?B?Tjd2RldVK2xOcmRhVVR1RDJabHZTTHRBYjFtemdEUkd0anFmU1RnUWF0VmhB?=
 =?utf-8?B?ZGtMU3pDWWEzQmh6cm44cmlLdFRJK0RmUHV3M0c5VzljQ0NHSFFBbGdCVUYx?=
 =?utf-8?B?RmVHZHJ2QyttUW03TVJwM2d5V21FdG9GSGxVWWlxd3dzQVpDdFpYV2lYYm4y?=
 =?utf-8?B?VlJWNGg4UDhGa21MVVRnZENxOXp5ZzFCYU1WcUxveEJoamNxWG9BMjFyYStH?=
 =?utf-8?B?d2gzSkJpSXQ1eERxWXA2VnpHVC9UK3BsV2pUSXhBSmdGZE5zZHcxamtZUWVS?=
 =?utf-8?B?NWtKZkFibXFkcy91Zjd3M0d6aDZQaytXRE9wSGN0ZEFSZXg1TnRLSGhvcjBn?=
 =?utf-8?B?NXBtL25XV0g5UG1tUVVjcnppWVc1dmdRVTBoSFl0dTdJb1lIcXc5Rlo1cXQ5?=
 =?utf-8?B?SnpucGU2Q25nN2dkeVdUZ3MrNDhWcTVzdmpucEFlQXRManhYOG55MjVLOTlH?=
 =?utf-8?B?enB3YmFLbGtZOEJueGtmTGVDUStnb1lEd0Nsc3lQYTVkUDlTQXhUdmJhS2tj?=
 =?utf-8?B?SmpvelErNDNMS0lWdlMrQ05xVjBwTmNuRkdNY3llOXpaU3o1bGo1SVpoUStB?=
 =?utf-8?Q?JEDvak/9KUKdkYTlUPjQCmcY3ByWgX2n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3BISjc1Vy9HRDBzYUd4UCs1TnlDZEdrS3duSXNrL3kzamdNMWwyZTRydFhK?=
 =?utf-8?B?NTR5ZjJJckJ5d1hsK0hMSzZpbXl4QWpXMEs0U1NWVm1NdlE5NmRJMGFsVEdj?=
 =?utf-8?B?RXgxd0ErbnVuaW15dDhZN1B1QkpDZGxmclhUMzVxT3plMW4wM2M1cDl2akhj?=
 =?utf-8?B?ajdrWWtwcEdrMUlrUXV0Tm9kSWRWUDZnSFpIQ0dOZUJIYUg4T1NBVGpDMHFx?=
 =?utf-8?B?TXBQbGVNQjdBdENhR2dqMTBubklIdW5EUlBPUEhQN3AyVTQ0VHB2WEtKMUMr?=
 =?utf-8?B?RHlIaG9tdFlsUUdMWWEreGJlbGlFTnV4SUM1RHp2Wlc5TFJjcjJUQ3FRQWZm?=
 =?utf-8?B?aHRza0QzelNkNE9HeG9MREFtcHhVdW40MTdGcmZ6K3FHU0ozRkJINnd5d2sw?=
 =?utf-8?B?RkZzN3BQcCtJcCtETTFpa29oRHlGdEFpVXhFUEwzZHNmUEpsUWhzZzZxb2Y2?=
 =?utf-8?B?VkV0TkpvRk1iOHpzVTE5TDhJeUwwUVNvSFNzRkRDYmdzL2NuOXJRSGE2UnhO?=
 =?utf-8?B?SXNKbjd6OUVqYVduUW5HbVRKeW1EdVhqdjl0WFE0UVhibzRXT29VRjV4a0V0?=
 =?utf-8?B?d1JrZFNKaFBaQXZRSDgxTDRINk0rQkZSRitOcFgxbml5V0VQZ3lrWnVCb3NK?=
 =?utf-8?B?K3V2aXRRTmtjY2VGVHVQcXpqMHNmekw4eFhjZFRBbktNbDJKWUsray9KWjVC?=
 =?utf-8?B?bjFuSjhzdEJiVDFqYVJYWkFqSnd4UURPMVJJNXFlNDV2RU9COVJZWnZhT0Nr?=
 =?utf-8?B?WVJoVGN4OEx3MEd5aVBjb1VBTlZkTjhzMExlRzYyTVd4MWFXVkY4SXB2eSt3?=
 =?utf-8?B?aFo4L3dSd0lqWjRRSDFOdWFjb1grRHp1RFZXbWZjdEF5LzBwbzJjSGtzQmF2?=
 =?utf-8?B?MVk5S2EvTlhTVmpQRkd3Z0ZweGUzRmt2NXJramlOVzVMN3l3NmhMd09LT0Qx?=
 =?utf-8?B?YmE2T3VaK1lkVGtOQXJsK3l2SDFmUWFJSStCQ3FFZmdHampXVUY5cTFIWFJ1?=
 =?utf-8?B?RzNwamtpU25BUVM4aFFwWUxsNHZBSHYwYWI2VmJrQ1UwWlJZWlVjSG9POFVZ?=
 =?utf-8?B?ZFJxNW1YOE9EMGRLL3RzM1UzbU1TZ3pWRFUrM3A5bC9pcndXdFh2V3VCbFRi?=
 =?utf-8?B?eWpMVXpsTjNCUTRzempUQ0hiWHhXWFVIbnVoaGhFc1R4VEt2WWs5ZVR3YWVl?=
 =?utf-8?B?VkpxS0lWbW0zaFdsR3JDemRvWVk1N09XMGdkQm5ielVnczd6alQvK2dPdkww?=
 =?utf-8?B?SndmTk11TkQrTnNBVlN4UHF5VGhjZFpDK2pTWVVmV0QrKzVTaFRYVGtqSXpJ?=
 =?utf-8?B?aCtQSytiSklXUm55ZE5WbU5QOXVjamJ1eVlYOG1FL0FKakhBcTVFckxEMVk4?=
 =?utf-8?B?UzU4cWk3SWRON2lHUERpWHZmMi9lK0haWTBVaS9RTnVBZzBld3RQQUZmUFYz?=
 =?utf-8?B?R1lSbVVrZVNoUG1wNGpaWjNaQUFndDlpRzJDM3ZudktVUzZZYnNxVDUvVGl4?=
 =?utf-8?B?VFlvenlMWVhMK2orNk9iL1F0ZkVPcjIwZU5qQzFTUXpZZ1F4MTZ5ajU3aGlS?=
 =?utf-8?B?VnRxZjlSN1pjNUwwTnh6bHFIVzE4ZzRvdE1OY2ZERUdMc3lXNFRNU1c2d2ZU?=
 =?utf-8?B?WXhTbkxobStXektlRFJMcUYvK1l1RnZiaTVvOEIvZllocDB6YXVyTDRtNkl0?=
 =?utf-8?B?WWJqaXFLd0hoaGtQdW8zUTdkZzcwVjVGVnAydzcvbU5TWGJwVjA5am5ZdDl6?=
 =?utf-8?B?a1ZzOTViT3ptcm85aWV2NkVTNEtYZEJMTUtWN2RaVy8vcW55K2xUbVBhZnZk?=
 =?utf-8?B?UmQ3b0NnRFhZelBCQWh0TElZZmNQeDV0eVprdmpFZzFUQ1k5YUxsN28rNStN?=
 =?utf-8?B?MGZ3MFNWRzVsOThvd1A4ZnF6M2p4OVovNGd1QnZrVmpDTzJ2OFdpaHVMYnIy?=
 =?utf-8?B?YWNPa0xTZnAwS2EwTjVZQlBZL2NwOTNFdGc4dTI4VW1YS0swVWgwamJUaXZs?=
 =?utf-8?B?aURQUnV3M3pmRk9FbkFHRGU2TlNVWmJyc05Cajdud0lhR2s3RVdiMUNVSGhn?=
 =?utf-8?B?dTZvOGpGblVnUzJ1UzJpVXBCM3Q4TGZnR3QzYWVIcEs4YjViaVJIQXYzV0hD?=
 =?utf-8?Q?pTfMSqRTiOX55qDHeGN+oh0aO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81c3012-701b-4ec7-ac90-08de1c176a27
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 03:00:02.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mUzUoDRgLXcdADgWFCn75+4rVTTA5zSf90xMcLTjv+Fmhb022iwCkXm7nxUMs81tjq575rJjGk8tbbeBonLxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

Hi Tomasz,

On 11/3/2025 3:18 AM, Tomasz Wolski wrote:
> Hi Alison and Smita,
> 
> I’ve been following your patch proposal and testing it on a few QEMU setups
> 
>> Will it work to search directly for the region above by using params
>> IORESOURCE_MEM, IORES_DESC_NONE. This way we only get region conflicts,
>> no empty windows to examine. I think that might replace cxl_region_exists()
>> work below.
> 
> I see expected 'dropping CXL range' message (case when region covers full CXL window)
> 
> [   31.783945] hmem_platform hmem_platform.0: deferring range to CXL: [mem 0xa90000000-0xb8fffffff flags 0x80000200]
> [   31.784609] deferring range to CXL: [mem 0xa90000000-0xb8fffffff flags 0x80000200]
> [   31.790588] hmem_platform hmem_platform.0: dropping CXL range: [mem 0xa90000000-0xb8fffffff flags 0x80000200]
> [   31.791102] dropping CXL range: [mem 0xa90000000-0xb8fffffff flags 0x80000200]
> 
> a90000000-b8fffffff : CXL Window 0
>    a90000000-b8fffffff : region0
>      a90000000-b8fffffff : dax0.0
>        a90000000-b8fffffff : System RAM (kmem)
> 
> [   31.384899] hmem_platform hmem_platform.0: deferring range to CXL: [mem 0xa90000000-0xc8fffffff flags 0x80000200]
> [   31.385586] deferring range to CXL: [mem 0xa90000000-0xc8fffffff flags 0x80000200]
> [   31.391107] hmem_platform hmem_platform.0: dropping CXL range: [mem 0xa90000000-0xc8fffffff flags 0x80000200]
> [   31.391676] dropping CXL range: [mem 0xa90000000-0xc8fffffff flags 0x80000200]
> 
> a90000000-c8fffffff : CXL Window 0
>    a90000000-b8fffffff : region0
>      a90000000-b8fffffff : dax0.0
>        a90000000-b8fffffff : System RAM (kmem)
>    b90000000-c8fffffff : region1
>      b90000000-c8fffffff : dax1.0
>        b90000000-c8fffffff : System RAM (kmem)
> 	
> a90000000-b8fffffff : CXL Window 0
>    a90000000-b8fffffff : region0
>      a90000000-b8fffffff : dax0.0
>        a90000000-b8fffffff : System RAM (kmem)
> b90000000-c8fffffff : CXL Window 1
>    b90000000-c8fffffff : region1
>      b90000000-c8fffffff : dax1.0
>        b90000000-c8fffffff : System RAM (kmem)
> 
> However, when testing version with cxl_region_exists() I didn't see expected 'registering CXL range' message
> when the CXL region does not fully occupy CXL window - please see below.
> I should mention that I’m still getting familiar with CXL internals, so maybe I might be missing some context :)
> 
> a90000000-bcfffffff : CXL Window 0
>    a90000000-b8fffffff : region0
>      a90000000-b8fffffff : dax0.0
>        a90000000-b8fffffff : System RAM (kmem)
> 
> [   30.434385] hmem_platform hmem_platform.0: deferring range to CXL: [mem 0xa90000000-0xbcfffffff flags 0x80000200]
> [   30.435116] deferring range to CXL: [mem 0xa90000000-0xbcfffffff flags 0x80000200]
> [   30.436530] hmem_platform hmem_platform.0: dropping CXL range: [mem 0xa90000000-0xbcfffffff flags 0x80000200]
> [   30.437070] hmem_platform hmem_platform.0: dropping CXL range: [mem 0xa90000000-0xbcfffffff flags 0x80000200]
> [   30.437599] dropping CXL range: [mem 0xa90000000-0xbcfffffff flags 0x80000200]

Thanks for testing and sharing the logs.

After off-list discussion with Alison and Dan (please jump in if I’m 
misrepresenting anything)

Ownership is determined by CXL regions, not window sizing. A CXL Window 
may be larger or smaller than the Soft Reserved (SR) span and that 
should not affect the decision.

Key thing to check is: Do the CXL regions fully and contiguously cover 
the entire Soft Reserved range?

Yes - CXL owns SR (“dropping CXL range”).

No - CXL must give up SR (“registering CXL range”). More on giving up SR 
below.

The previous child->start <= start && child->end <= end check needs to 
be replaced with a full coverage test:

1. Decide ownership based on region coverage: We check whether all CXL 
regions together fully and contiguously cover the "given" SR range.
If fully covered - CXL owns it.
If not fully covered - CXL must give up and the SR is owned by HMEM.

2. If CXL must give up - Remove the CXL regions that overlap SR before 
registering the SR via hmem_register_device().

3. Ensure dax_kmem never onlines memory until after this decision. 
dax_kmem must always probe after dax_hmem decides ownership.

Some of the valid configs (CXL owns: drop CXL range)

1.3ff0d0000000-3ff10fffffff : SR
     3ff0d0000000-3ff10fffffff : Window 1
         3ff0d0000000-3ff0dfffffff : region1
         3ff0e0000000-3ff0efffffff : region2
          3ff0f0000000-3ff0ffffffff : region3
          3ff100000000-3ff10fffffff : region4

2. 3ff0d0000000-3ff10fffffff : Window 1
      3ff0d0000000-3ff0dfffffff : SR
         3ff0d0000000-3ff0dfffffff : region1
      3ff0e0000000-3ff0efffffff : SR
         3ff0e0000000-3ff0efffffff : region2
      3ff0f0000000-3ff0ffffffff : SR
          3ff0f0000000-3ff0ffffffff : region3
      3ff100000000-3ff10fffffff : SR
          3ff100000000-3ff10fffffff : region4

3. 3ff0d0000000-3ff20fffffff : Window 1
       3ff0d0000000-3ff10fffffff : SR
         3ff0d0000000-3ff0dfffffff : region1
         3ff0e0000000-3ff0efffffff : region2
          3ff0f0000000-3ff0ffffffff : region3
          3ff100000000-3ff10fffffff : region4

4. 3ff0d0000000-3ff10fffffff : SR
     3ff0d0000000-3ff10fffffff : Window 1
         3ff0d0000000-3ff10fffffff : region1

Invalid configs (HMEM owns: registering CXL range)

1. 3ff0d0000000-3ff20fffffff : SR
     3ff0d0000000-3ff20fffffff : Window 1
         3ff0d0000000-3ff10fffffff : region1

2. 3ff0d0000000-3ff20fffffff : SR
     3ff0d0000000-3ff10fffffff : Window 1
         3ff0d0000000-3ff0dfffffff : region1
         3ff0e0000000-3ff0efffffff : region2
          3ff0f0000000-3ff0ffffffff : region3
          3ff100000000-3ff10fffffff : region4

3. region2 assembly failed or incorrect BIOS config
3ff0d0000000-3ff10fffffff : SR
     3ff0d0000000-3ff10fffffff : Window 1
         3ff0d0000000-3ff0dfffffff : region1
          3ff0f0000000-3ff0ffffffff : region3
          3ff100000000-3ff10fffffff : region4

I will work on incorporating the 3 steps mentioned above.

Thanks
Smita

> 
> Thanks,
> Tomasz


