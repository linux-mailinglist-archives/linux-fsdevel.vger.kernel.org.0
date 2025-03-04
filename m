Return-Path: <linux-fsdevel+bounces-43033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6AA4D2ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1783AD437
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 05:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33D81F461C;
	Tue,  4 Mar 2025 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TLuvfWuv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21A1F3B8A;
	Tue,  4 Mar 2025 05:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065769; cv=fail; b=mwMtODYsXsimeEZOFgYluJwcWWFJ/F0qsbcT7gqx/rcaSoOz1pX2Tf1sdQB+9chdq1mRQF81sWWskvUHAJDEXYd8cpDcxh0B7fobSllrUMyrU2053gW+CHn4v2XZA5K5MSF1rLQLGhHaGQnWc/TzXBWvmBFy1DpahLCv1rn1TM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065769; c=relaxed/simple;
	bh=vcKjwl+MapdQlfqFm8ev1NDoq03aJAUEpCOstx8mGRQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=qA+Top9PAOWsw59ory+WpLdN3ZPAAtBArDZXHubaKBxJOaGayIuabq5rMQUOYAs/Jd10M0VmHHWHtk/ynQHlBAuF3jRHAeHykD0/K+KvLlIC0o8xUy9xyitDrjgVeb6Rzf9W7pnzVxu8nmEYvwAwTtWsAfTc5oYTaPZcrxY+Veg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TLuvfWuv; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUKtm4afyJgvk4oazlmM+tZxhIB4RLSmKJu9ZMptMo53iLEjn8/WGXh0yd0JLd4jfBuufp2logLh4UBr7wOEj2bojp/ntD0qKXn26L+6i0zFMkPetH8K5OZcXnqn0hw+iW+Y8/Hj6MEQ5uwoAqzB5BHGKjzS88Y3lsOolEEDQLoSpvv3ZV1RDe2vsaE2/PlUu32Tc79hqjmcBvoHyjRQrKZrv+scghhY+GxOPqVqA9EDiOm4AwG9Da5ynyhTbyxgW0YoxDdchCnCpYRbR4ZuGHoPXclzHMrm9PS8h71XMafwNEAIkxAr6iK8h1G2KLw5WP0e8DAj88asSe4WBvoiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmYV3TOgLVXbUhHlwGf9ygZJUdgjQ27xFvVilo9tuds=;
 b=wrpyHN4LdbqNe8Zyyhaod5k1j54ekwglWoUgCaTg1jPEaOjA2tIMNvtEHKL3/Vzc3nCMxeHQdUQPRkdB3hHtEkvjSJdV+cDMbvjj+5Za9VN8ANPsQjLR7verNe5IB4dVcRfFkMc6jwWt3z6JVOMNtYljYys+jQ0q5kVLplUzmezMY91XW2x8VapAgXvQ1BQtJDw/eMBKrSxgzzMkkIzMQGLQ9sfn8aD73DyV7zsqmZgV0enNcWs9H8gZBHEHa4svT5fQJ6bP55DoNk8E/OG8qXdaKS0n6t8V0oYlk4BfgCtaFtQrrNKvIhvkjIRCDFM0KHFJ5qf8z97YOSTZsB/FYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmYV3TOgLVXbUhHlwGf9ygZJUdgjQ27xFvVilo9tuds=;
 b=TLuvfWuvfXUQ45fYwl/Ufe+ctoRCpFl/eoP1gmJdSVoVePzbk6Xv0A2spnGsAjEirFUYwSPwhIysR6Eze9mHoGYZBTkArWoI/NiaPvdFQNVsLAhwL5GvuYZXiGb5lW2i9JY9Z19b2COTMZqtyAiMxVrVwaDL7B2Up2jVxwETo6A=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 05:22:44 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::60) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 05:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 05:22:44 +0000
Received: from [10.136.44.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 23:22:40 -0600
Message-ID: <0f4de435-a48e-4c4b-9c56-b7c4dc1b96cf@amd.com>
Date: Tue, 4 Mar 2025 10:52:37 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Oleg Nesterov
	<oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>,
	<Ananth.narayan@amd.com>
References: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
 <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <da2b1976-b392-4b3e-973b-3029a1ca1d72@amd.com>
Content-Language: en-US
In-Reply-To: <da2b1976-b392-4b3e-973b-3029a1ca1d72@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c3634e-fe31-4854-62a4-08dd5adc97cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjNYajVlSTE5V0M5V0ErZ1RVMXpwNEpkRmF1MEFwR0JkU3VTRkZTUS9KcmJR?=
 =?utf-8?B?aDhXUkNMZVZndnI4UkF4MFhUM1JjeDh5cVFhQTBybEdCdE5SNnFNb1pLUzMr?=
 =?utf-8?B?N0tGNFJ1NitsUzQ4ZzFoQjNSZnBvL2JRd3lPano2ZzNPYUVSZFpYRk94bGdI?=
 =?utf-8?B?Tnl4OEFWK0hIckV3VVFXK1k5c3JhZ0F2K3lXQVgyVkhEbDcxeGdIeGhmejB5?=
 =?utf-8?B?RXRRbXNXL0NKSmdsVlRiZnpZUjZmMUtTNkwyL1Q0WGxyV1E4T2xOcTF1dTZk?=
 =?utf-8?B?bHRSTHlYeWpIRzJqWUNaUm5xeVZobm11aW15Mko5c1hhUnd1QmZIV3BpeHpF?=
 =?utf-8?B?NGRiYnhBYXpXU1FmY0pxcFRIQVgycTZPUWZyZjZWRGl3TU9LZitsQ2UvODdt?=
 =?utf-8?B?dFVkNC90RzFRV09CME9lUENnWTVTZE9ZcXdDdWFza0tObU5kejY2dXNmMW5T?=
 =?utf-8?B?UlVkd2F2QTdVaUJBK0pkN1IwOFJvVVlkREs1cHZyQXZmUSt1OGIva2l5NjZv?=
 =?utf-8?B?M2JtczkwMk5KaGVHOEorVkE1aE1STTNKcFdMOW5rWjVvdFRxVWxmN3h5WFBE?=
 =?utf-8?B?MXBwUzR4M2poV2dOMHJTNVY5UGJTeUlmcTEwMk9wU3QwMXVKVWFpd1hmeWx0?=
 =?utf-8?B?MXNoYW5pZUFaZzNQUVljV1NNb1VYU3NZb0ltWGgxNzdMSjZJSWlaUTBVMzdw?=
 =?utf-8?B?NUtrSitMM2ZucjdrU2NsOXEyOVJUc0QvOTlYMGdZc0xUd1N2RGtzOHcwLzlD?=
 =?utf-8?B?RUw4a0RwbDA3MXBKTUZmS1lqL3pTMDlneWNqNFQxcitDNXFoSHNXTlJOZ3hR?=
 =?utf-8?B?WUtQTjcrV3ZJeE91Z1hWaEVSeFlkZ0d4N2U5bzM5SWZ6Nko5a2pMbEgvSjR3?=
 =?utf-8?B?c0ZRb0pzenBYcUs1UkpEMkozOFRDUHBjejFoNFZ3Ym9BMnpPTUR2L29yUjh0?=
 =?utf-8?B?MXo0R1pDUHFWMFJBNlZjSk44YXZkK1pmOHhIN25hb3VGbHJaQzVQc2VoemlB?=
 =?utf-8?B?YWk0dVRnNXBrVE96K0xhUjBRWUZoSmRnOXIwZDNTMmNjRDVaQnZrckJpVDN2?=
 =?utf-8?B?Y3VUNGI4VEpQNFNDR2l0YVdUbmJYZHVReEdhZ3NTVUJCMUpvSlRRTUxUb2Iz?=
 =?utf-8?B?YXA0aHNraDB2VkVEbGZIRTZRSGp5S1lDOXZlN0JreFJ4SFF6ZXl1M2tMSllw?=
 =?utf-8?B?aFg1WElsNXJQcnk0aSt5L21Fbmp6WVRER0pxcm9oeUJwWCtHR1VTN2pUTlh1?=
 =?utf-8?B?UW1lOC90aE91S3kyZ3Rsc21uYlY4dytOQkx5cS96c1MwUDVvS2VnQ3MvdktL?=
 =?utf-8?B?U0tQQVBCTExmNUJTTUpFSGFPSWFCZTY2Tk9qMGF6eXo4elBxellUSzVJdnVZ?=
 =?utf-8?B?Q0ZRbUR5UlZTSkl3Rm9xUkg1U3NqaWhucWxVZnZTMS9kQUdjakxUNTJXWFkz?=
 =?utf-8?B?by9scStScUhMd0E5a3p1STlVTjFURkFsUGloeGpZS0twcWx1aHVnRllZVCtk?=
 =?utf-8?B?ZU1WbXR2eTMwN3J5ZkExMldkMmswVzJGblZsU0UvQVRIMkVnQzVCdVdQSVNB?=
 =?utf-8?B?Q0FqVDZsTERzWDJoa05rZFBDMm95RGZoVENYbWk0SkJhaWVCaHY1NWtxKzJq?=
 =?utf-8?B?MzZpUzZWQXZXaXRPcmhKNXU3OGNyRDVXQUg5S2RuNHNXc1RnSlBFaG9sblN0?=
 =?utf-8?B?YWkxSE42QXMreWE2Q1NpeWQxcUtmTEhwdnA3bzBYWEh6R0ZNNldLSmFvOUNo?=
 =?utf-8?B?dUE0RlhnK091SmhhNi9hcU1QNTVBSjVPTGlJOUhQRENVSWtPLzlNT1FuNldy?=
 =?utf-8?B?L1RnZWZNTWZnNDdqdXNwTXlWTVZvVjA5VmdmSzJGRDRmazU3Mnp1bERNZldF?=
 =?utf-8?B?TldXcVYwclBaL0ltaFpaTWdSMHdoQ2pFSVR3aXMwMTJZL09yRmx5amhLOEMz?=
 =?utf-8?B?S3ZWS2pRTmFJU3dPWTg4U1RLK3dzYXpBSlJPVFI3V2tXekh4OU83Yjg1THQy?=
 =?utf-8?Q?HL1aT+gzsHHOlTp5+I2x9pj91sCOrc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:22:44.1796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c3634e-fe31-4854-62a4-08dd5adc97cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473

Hello Mateusz,

On 3/4/2025 12:02 AM, K Prateek Nayak wrote:
> Hello Mateusz,
> 
> On 3/3/2025 11:24 PM, Mateusz Guzik wrote:
>> Can you guys try out the patch below?
>>
>> It changes things up so that there is no need to read 2 different vars.
>>
>> It is not the final version and I don't claim to be able to fully
>> justify the thing at the moment either, but I would like to know if it
>> fixes the problem.
> 
> Happy to help! We've queued the below patch for an overnight run, will
> report back once it is done.

Hackbench has been running for a few thousand iteration now without
experiencing any hangs yet with your changes.

> 
> Full disclaimer: We're testing on top of commit aaec5a95d596
> ("pipe_read: don't wake up the writer if the pipe is still full") where the
> issue is more reproducible. I've replaced the VFS_BUG_ON() with a plain
> BUG_ON() based on [1] since v6.14-rc1 did not include the CONFIG_DEBUG_VFS
> bits. Hope that is alright.
> 
> [1] https://lore.kernel.org/lkml/20250209185523.745956-2-mjguzik@gmail.com/
> 
> /off to get some shut eyes/
> 

-- 
Thanks and Regards,
Prateek


