Return-Path: <linux-fsdevel+bounces-47151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278FBA9A052
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62AF9447D8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 05:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4861B0439;
	Thu, 24 Apr 2025 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dom1xWUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0993E139B;
	Thu, 24 Apr 2025 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745471250; cv=fail; b=p+en/SwAapaeOXg2oTcpg8pDAaTwS0kawONFMcxWxXuUQCpJj2LgmtZOTiIFNrF46Ccd8BxjHj+vtYSiOO+mAkIVaQVP2hXJ6GvVdbISPBTddd3v8c+7q5T5JMVEbvaqS8OeHOAsdB/MNZv5UszugHRMEx6r+D51Qn227wb4Wk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745471250; c=relaxed/simple;
	bh=ebghqKvLzDtDEC0GCf3jeNbnjL3Aejt2EIYK044w++A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nSa8sowWVj/M+DE6VjLX48iH3HnPTzo/onT5viMrBnuzRtw0j5bRGdfYkj+usdcwToXhEGtinSuHMI1z/IgMYC8hTio9xzn3xD46rJRz2gQCPv2tSA3gSUFNViCbCNQhzsgESIzOznp0N9Wei7BxUr6h2l5C0tSyMKhvzFLU0GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dom1xWUV; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHmmxSG3LhNnZjf0g9GaCI22gd3R2KV/XzXUlRf0pUnDZIhjEHSVi8DhNbRvJW/6kG6pD7NmMN39Fcrny+Ibd3H/uGoNwoT/azxtTIOXyXMK6JlRutTzWm1V/ONbVgwmeh/VRs70Rg1LRYywlDp9yH9/6tdeK9+PITG4KcB1aynFacj71uVjjChQp6TqT2YJcDRNJrKvg4cqf8KnerQBx2mC7g1TloTn/yqfs+YQpiBpN8Zx0fJaczelNLx/JpoNlNqJHn+mR60vChaVzzvXHfaWNtsU0oDqc7NdiwuibgsUoIi9xY2qXAMLC1qpNY7Q4v7YLG/USPQP8VzCbb25fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqI9p3mzUnOUm/KKi3dxMvlaNTPfYMhN/d0UW1/Y96c=;
 b=GVjw/+o7P4UcS6YYToDtOjjuAW6SaQMONOdLY3M95GbIyD39J9teomlVsbZud3NVdRghUxPI2BrcnknnK2VVnpytOF3Ys2Euyp6P5+6WdvIn077dmicG339DO29Bsx8Q2NOYgzmd2Rt+QlYQAe0b59+lM5mU9HGq8D7qlIXehtCJAD2DRDSydPjqTf6NMS2NLlEKz9mO+PhFBAuXak4cSUKiKUKaTMmMMA29tbybgl3ktLiTbBvzc5RvIGyPhiEJImg2ETfMa85fXxNjJFT5NwQsOHiD1SpyJcmwN3ootv1z1poA3uQiv+az4TNBd26di+hmlW6F2odnOQ47xn4uBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqI9p3mzUnOUm/KKi3dxMvlaNTPfYMhN/d0UW1/Y96c=;
 b=Dom1xWUVnRReTfhwWyZcOg/topS8A+B1lLe6wnkFK1xjyhYpN5wMqcCfUeojtxtVhWmFD0+zpzDPXGLrf1joGaqJ/zCg4+elkt/2PiR/mtUCYw+wwIWG6q2Yh2qrU1k6d4iR+o0MYFd3lUtwRw8j50LuAg/Id75ghVjidv+6O7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 24 Apr
 2025 05:07:25 +0000
Received: from SA0PR12MB4416.namprd12.prod.outlook.com
 ([fe80::1283:a0b5:75ed:8a8e]) by SA0PR12MB4416.namprd12.prod.outlook.com
 ([fe80::1283:a0b5:75ed:8a8e%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 05:07:25 +0000
Message-ID: <8ab4169a-27ea-4667-aadb-3a105d279d1f@amd.com>
Date: Thu, 24 Apr 2025 10:37:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
To: Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, brauner@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 hca@linux.ibm.com, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Xiao Ni <xni@redhat.com>
References: <20250423045941.1667425-1-hch@lst.de>
Content-Language: en-US
From: "Jain, Ayush" <ayushjai@amd.com>
In-Reply-To: <20250423045941.1667425-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0132.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::8) To SA0PR12MB4416.namprd12.prod.outlook.com
 (2603:10b6:806:99::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 0138de14-f5c6-4e95-99cb-08dd82ede6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE92WWlLSjBBNGJjdXo5eWlVMzVPZXVBb2oweDhIczFLQU9kRjVBRmtNYW91?=
 =?utf-8?B?QzI0eGdGd0ZpSkdvd0VEbTZIbi9KNjRneWJpRVl0MHNXdWlUVmI1RFhIbGRy?=
 =?utf-8?B?ak04amFGNUhiU2swT2t1M1BqMjNObW9GcHF1NThjOHlEalk1RjVRWVU5T3Y0?=
 =?utf-8?B?a3poRTNCMFNLRy9ROTRMSGNCVjRPbG1XOHVtSnNTbjhJV1VpekhtNUhOem1Y?=
 =?utf-8?B?VFMrZUtKWTJmK2NRUXBFM1h2QVlLdmc3L3dPRTM1V0FCR1hOczFLQTB6YmFR?=
 =?utf-8?B?dmhtR2pEbVdWb2YxdGZRNUJ1cVhYUjcyWndSc1daZjBmdkYwa0VkQ0RHdHA1?=
 =?utf-8?B?ckpMN1pZZTB5UkJOL2s2aEQ1OUI2N0lqOXgybXlVRnNpeUV2a0Y3QnJzdk5l?=
 =?utf-8?B?ejlJSmkyY3VPZEZURWc1cUFUK0JUNkZCellyc29TalJ6aHNtZXlIQmlRRWt6?=
 =?utf-8?B?cG5PcmpaSktqaUg1VjZTRG9CclNSd1pCeTBQRFdIb2E4azZ3VEZ4cWxoaFNK?=
 =?utf-8?B?MmYvOTlHRDdNS1hiZ0RTWk9VcFlSUHRQdlpKN1RqYWxScURYRWZHNkFORFN3?=
 =?utf-8?B?aG14UktSY0ozMytxRDVUSGYwRFB6OHRmckdFaDh4SDE5TEFPd0tyOGhPV2lM?=
 =?utf-8?B?V2E4SEU3N09VY3FDWktyVUN2TGFobFRzc0pqSFlYWW5neFlFNzRZdDU2VGtJ?=
 =?utf-8?B?WlRPZXpVS3NweXRGM3p0WjBhN1hpV1AwaEc0b1kzanZBNmh4UnYzMkpRMzFX?=
 =?utf-8?B?YW5FNXJFY3UwekQrRkdWZnNVQ21oWVg2QVVWak11cGh5MUFjRTJlZ3Nocy84?=
 =?utf-8?B?cGN0Szk2TEJoZldxa0J2MEl6ZDFEOU1STUd5dWZvdkdXT1VWZG1OVTE5eU90?=
 =?utf-8?B?S1krTHhEUElUditVK1Vremlxa1dEUkE3OFJ6SmEwYTVqMTJOMUFoK0Jjck9X?=
 =?utf-8?B?UUJ1VjgwNFlic0FjNWE3SnZHbndxUndVQWtNWXVGR2pJS3drVHdIT1JnSVFT?=
 =?utf-8?B?cDJzZVVmUkFVSVgrUytydTlLdy9WRDY5ZUhIa3ZDTExZK2dVbVBGbW40UlhW?=
 =?utf-8?B?SW15V3R4VGI2VzA1cjBBYUpWTHF5a2xGejhaZWkvTEx1eS96WVlvRGROOUI3?=
 =?utf-8?B?SWF0eUJjVkdGNUZleUNxSGNTLzVNZ0Q3YWZmbERieFJhQlh6UnVpc082VUtn?=
 =?utf-8?B?NURmM2VOMHhTRTEvRkVCNGhZTFR0bEM0aXZIUXZYNi80L2F3WWRNcDByR25B?=
 =?utf-8?B?ODFNSHFiTVFaaDE1aXBtTWVlWGxIWUxWSW8rYWZ0MU9QaElJWVd4cFh3WmVO?=
 =?utf-8?B?WjEvR3RSaFo0bVI1My9xcEpBWERYWHZ1L2RjNmlIc1UxUnlFeVd4c0xybmJQ?=
 =?utf-8?B?MWtyN0YxOE1rNXpHaEJWN1hPT3FOK21JREFrU044elo4blFLVDhLWE11YjFV?=
 =?utf-8?B?cUVsQ3U1UENVaXh1WHBSOW9WU0ZQYkpHVzFlMmdmYWFZQjFOQkJZOW1FdHU3?=
 =?utf-8?B?YWpqSGVTa0hLRW95cXZVd3RoOUpQaEN6UWtsSWtaQkRoOSswMzVKR2c2L3Y2?=
 =?utf-8?B?Yy9QWlJJeXBzVTlPdldWMWtMbS9zQW92TnFjUVBMNXFVS3ZpMDFqOWZiNW1F?=
 =?utf-8?B?am9NaUlod0h5b0NWM2czNENTYVpLa3lFUU41TWJpMTlxaFVIdUJ3am9lZ0Fa?=
 =?utf-8?B?c21nTjZZWnZHU2Q0SjNCL2REMEZKK2VFL1VURUVWc1RKVVhzV09mdmp0cjdS?=
 =?utf-8?B?dkd2bWJXdnVaeG5wOWRxNk1ZQmgrcUFFNXE5QVFabDcvRzhPOTU4NTVKKzdr?=
 =?utf-8?B?b2xPSU05aFFxNkNhalRmdGIzNmtIRExoa3lPYVE0cXpDRUUwN3Q0Yis5V2tF?=
 =?utf-8?B?aWVWaGFZZFpwKy9JK2p4Z1UzRm96aFdvSHhVemVZaEIrQ05uQlEvOTJGZ2I5?=
 =?utf-8?Q?du1WmFfnRfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmovTVVFRm5jVExFUS9aVWxreHRxZkZPV292UE4zL3RNM3pEYzExajBXdDVR?=
 =?utf-8?B?ODl5aEFOTWtwVyt3MXVEMXNXU3FEV0E5S1BnamJCQUhJRjY1OGNiWE04RzBY?=
 =?utf-8?B?cXJ3Z2lSS0lPWk45akxvZ2MwZE82M2J4anZBdTBWSE9nWVhvUHYxdldGa1Vq?=
 =?utf-8?B?anJ2QjQvd09oOEpYQm0wUkIyQm1BYTJJdTF5WGNhTjdkdkJRSFR2bm1KVlJB?=
 =?utf-8?B?WWxLbzhtcTNYTE9TaUZBdU9lQ29UbXdodFpzeDBYaFZtai8zVFFDcUFzNHBU?=
 =?utf-8?B?Sm5EdWltUU5XUFpvcW1weXpJVkcyT3dINXFKWFUrWXpENngvZGR4RWJJT0dj?=
 =?utf-8?B?aXNsS0JFRi9MNUpnakJtZ1N4b0dqeHNqandJYVUyekFBSHFxUlhSTWZRZU9l?=
 =?utf-8?B?TzNLQjE1eEZ5RWFjdHJNQlJYdGgyY1Zpc3VGS29rNzRMN1NBYWdJcXM3dG9y?=
 =?utf-8?B?bTdZdFlKVU5WRm5ienhMTEJWVkpKTXFJMkxtN0FhVGszVVRSamNlMC9OVlFw?=
 =?utf-8?B?NDNScGVQZEFhL1dOTmdCZnBGd1I3NUpNS09qclNzZ0phVkFWc2UwZUdtdVA4?=
 =?utf-8?B?OHQ1QUc2R2xrZ0RCaGZ4Z0hxSUxRcnFMZlV0dzZMeVREamF0Yk45a3U2QWdM?=
 =?utf-8?B?MzJ4Sit4Yk9MQ2lwZytteVphanYyY05WZmo1bTdUT29VdE9VS2tqcGNoa2U0?=
 =?utf-8?B?dHBJU1JjTDVaTk0vb09FQWg2U0l6c1dWSWlUWk5wNFp0ZU5MV3NKV05BakZD?=
 =?utf-8?B?bEc0NDY0b2xocERPSVhZY1cyeXc0dFdqcGFpUVBENVE0V2dEbThQV0pwL2o2?=
 =?utf-8?B?dXVCSXdwdFJYVmxCNUxNVXFVUkFXS0VweUVneGFWcC9VRVQwSkJ1T3FTeTU2?=
 =?utf-8?B?SVR1Yk1BMHRKZVREanE3czBNUGFuOWVmeDlFSVhjc3IwTUFtZ21PV0JESzFP?=
 =?utf-8?B?VEh1VWpDd2tYQnUvMTZHcGthQTZUVThDaC8xOTRJWWZveFVXbmdqZ0YxbFB5?=
 =?utf-8?B?YTdSTXZ1M280K3BFN08xdThqangzMG43MHJ1UFVRclhXOXBLRXFJSnJUTllH?=
 =?utf-8?B?TVgrbGN3aFFCczZDZzRhYzZIUTVacytEcm5yN25JNmhlTWloL05LaWlOU0g0?=
 =?utf-8?B?RU90RWRocTZ6YmVMMSt1bGVNRTRUQUFBVVNhL0llQUF2d1k1R2VvcEcxaWxR?=
 =?utf-8?B?ZDNoQ1ZRb2pTYTJlV3puNy9aWDJ1eDZYN3ZKcFB4VnJ5WFdCcU1UZzFLTUpY?=
 =?utf-8?B?OTdIbUlTUThPOHdSVE1mMW50NWtWbzEwNi90MFFLaG14TnV4SlZUUVY5K0t0?=
 =?utf-8?B?dk1XcHpHQmE1SmQwNE1aT1lUbmh2K0VzQ1orQVZ6YjR5NlZCdFBIL28yV2Fr?=
 =?utf-8?B?MVliYmhBNElsUTVzbUlWMXRwalI4azVjL0xMVUdQUGlwSEI0LzlLMlRySk90?=
 =?utf-8?B?dU1iMjVPaTdyZ2t3OHl3d2Z1VE45YkYrRWZyR2h5RFVPVG1OQmgvS3F5MmFk?=
 =?utf-8?B?WFAzMGVmOGp5V3IySnkwc0U3ZFAvYlJIK29QL0Y3cjVMOHQrQm9UMDBNdG1I?=
 =?utf-8?B?b0pvKzZKeFhQSGM5Nyt5cldMc25pWTJNWmg3bVJoOURwK0lHU3d3ZG92NmtE?=
 =?utf-8?B?L3dhb1h3SWZCR0ZEQWpuYnpQTWFxZlZYZ3ZMdlBZTlY5MjVzMVJIV0tOZHdQ?=
 =?utf-8?B?VGpLYkV1ZGUyWW1YOXNJZmdScm1EeStFZkRST2poTGVFQTNjSys5RkFUU1ZI?=
 =?utf-8?B?L2wwOHFtajlPZTFyVk1uWUlUaGM3aXduVGhEc3ZRSmw4amRmcERyRWVVOFYv?=
 =?utf-8?B?dDNhUXUyWmtsN2FCSkhZb3VDQVUwb3UwY1pFZnBOdlJ1MmljWnE4ditRRDRz?=
 =?utf-8?B?elFLS29CVmJTT0x6WnIxTGlBZ2tiMzFXa0gyanlpZXVSNC9qRU1HYUxnQUl2?=
 =?utf-8?B?R3N3bGNodXJWQkd3YkY2YkwxRGs1S3RaVzNPbUFwVDhhenFaeW52dk1MU2NU?=
 =?utf-8?B?aTBXSkVHZFNBZWFpRlZiWGwvWFE4VGQ0ZHVlNzBwSWNXSU5SRFAzcjBsU3Ix?=
 =?utf-8?B?NVdPV0RGc3NXY2VwT0NteGQ2aWFyaFJQdVhyZ0lqb0ZVOTAraWY0dGhUWGpW?=
 =?utf-8?Q?TEBUbyrlP2vytwYDD7+489RDM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0138de14-f5c6-4e95-99cb-08dd82ede6fc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 05:07:25.6458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvgzKIW1u6KfKu6q5hA4oQyhRo0oN3G/QwMjU4lykt0FIlNZ9kcYLzdKiFmuWPCDIXkUVv2Cwj8ppiVS0bTjUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541

Thank you for the fix
This fixes blk devices hang issues on AMD EPYC x86 systems.

Tested-by: Ayush Jain <Ayush.jain3@amd.com>

On 4/23/2025 10:29 AM, Christoph Hellwig wrote:
> The recent move of the bdev_statx call to the low-level vfs_getattr_nosec
> helper caused it being used by devtmpfs, which leads to deadlocks in
> md teardown due to the block device lookup and put interfering with the
> unusual lifetime rules in md.
> 
> But as handle_remove only works on inodes created and owned by devtmpfs
> itself there is no need to use vfs_getattr_nosec vs simply reading the
> mode from the inode directly.  Switch to that to avoid the bdev lookup
> or any other unintentional side effect.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Reported-by: Xiao Ni <xni@redhat.com>
> Fixes: 777d0961ff95 ("fs: move the bdex_statx call to vfs_getattr_nosec")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Tested-by: Xiao Ni <xni@redhat.com>
> ---
>  drivers/base/devtmpfs.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 6dd1a8860f1c..53fb0829eb7b 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -296,7 +296,7 @@ static int delete_path(const char *nodepath)
>  	return err;
>  }
>  
> -static int dev_mynode(struct device *dev, struct inode *inode, struct kstat *stat)
> +static int dev_mynode(struct device *dev, struct inode *inode)
>  {
>  	/* did we create it */
>  	if (inode->i_private != &thread)
> @@ -304,13 +304,13 @@ static int dev_mynode(struct device *dev, struct inode *inode, struct kstat *sta
>  
>  	/* does the dev_t match */
>  	if (is_blockdev(dev)) {
> -		if (!S_ISBLK(stat->mode))
> +		if (!S_ISBLK(inode->i_mode))
>  			return 0;
>  	} else {
> -		if (!S_ISCHR(stat->mode))
> +		if (!S_ISCHR(inode->i_mode))
>  			return 0;
>  	}
> -	if (stat->rdev != dev->devt)
> +	if (inode->i_rdev != dev->devt)
>  		return 0;
>  
>  	/* ours */
> @@ -321,8 +321,7 @@ static int handle_remove(const char *nodename, struct device *dev)
>  {
>  	struct path parent;
>  	struct dentry *dentry;
> -	struct kstat stat;
> -	struct path p;
> +	struct inode *inode;
>  	int deleted = 0;
>  	int err;
>  
> @@ -330,11 +329,8 @@ static int handle_remove(const char *nodename, struct device *dev)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	p.mnt = parent.mnt;
> -	p.dentry = dentry;
> -	err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> -			  AT_STATX_SYNC_AS_STAT);
> -	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> +	inode = d_inode(dentry);
> +	if (dev_mynode(dev, inode)) {
>  		struct iattr newattrs;
>  		/*
>  		 * before unlinking this node, reset permissions
> @@ -342,7 +338,7 @@ static int handle_remove(const char *nodename, struct device *dev)
>  		 */
>  		newattrs.ia_uid = GLOBAL_ROOT_UID;
>  		newattrs.ia_gid = GLOBAL_ROOT_GID;
> -		newattrs.ia_mode = stat.mode & ~0777;
> +		newattrs.ia_mode = inode->i_mode & ~0777;
>  		newattrs.ia_valid =
>  			ATTR_UID|ATTR_GID|ATTR_MODE;
>  		inode_lock(d_inode(dentry));


