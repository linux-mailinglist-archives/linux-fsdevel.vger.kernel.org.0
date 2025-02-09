Return-Path: <linux-fsdevel+bounces-41345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C88A2E187
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 00:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9973A5BDA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 23:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C522241CA6;
	Sun,  9 Feb 2025 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ThdWecdi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50C14B092;
	Sun,  9 Feb 2025 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739144368; cv=fail; b=R5H2vfLwWIeumM4LFhAQAnAEBa3Lwc6iXpqB3BSeVDNDOHfaQFPWu3bqmyazHf0/GzkezIqiVuZ106giAzhpTAvwAAqgqj8/kUlClIc428Sl6HbyyINgavExxMr49zRXY6W4+YOQdgXMFbt1M3cRo8MIciltu+CLzGJxMAa5N0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739144368; c=relaxed/simple;
	bh=j6ezEyOwXB1UnanxcURp3KDCeKF6/KoU9on9Saxu6VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KWm/dpPV/mzMU05dbxU6mLXjBl/4jZiv1gxwY7chJ37NHqKuVplq6pg/kM9XGSHPMbC+niIjzlceX5DIpV3LcvMBILMoIeEYdgrbV6e0M5Chy9kiQDNUCRQaqQ5HEhCmZvac6uYb27FYqf9YzeSTTWIRIeLN5U2HWRw/AmLlFlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ThdWecdi; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfhdWp39dEF7zvUbVriLJLeGzj4ojZMvHl9G2QVWKcttaHiQV59sktBd6r4d+FRlJvIcG7nVTAXKz/YnwxArk/TIwLl1Z8m6aJ+ci97ioWUAqH5VNUiMJ4HoFeWBkQsIeSxaT5cPB7u34AkMabZ0/q0NhKGEp4jfr5tRmiB7djDfM0Mv+7a7YAHFgmXuVmSzfF9KJsmv86N5C7VxcP4qMkNOn7SpBcyfR2iyXV4EBmKomDuLB8l/AeqQCD2e2VkqD/7lXysDqwZl+K9LuCeQt+Wh2Go98ybHKzQxa5q+O2yF/Z41k0AkRv7eu437r+6YKM2MB4ROD6ZMonlun/AhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg6hsje8gdg3byEfHq+pUr1m8xjzwqYZg2IKUbvp0/k=;
 b=kEjp54LhMvtjRZfy50Sq9erk4Ze2TCOZILn8CtEnJZJhHoDqGMp8V65iRd73ceqUl9NbgcqQ5aTyzksCRoG1nxieHO/gwHxRlBrueOgIMOdbxd+nrPry2NiU/GJY6jBsy9Nmj+GMbI6wtt6uiZ4uuPynz+JlDto4eT02EFIITJyKJTdbozXB77JYQJUq/QNxNw3R8ljFH3xKYbhvgTxH5VASf9kimWP2H5H/vkEgMraeSGURmGsfh3TsnilqEF6JipClI2A3K9IeZSQWYmJ94gH9sHnvpZaEeQEwwthFq6XV0hAa3Xt4h31XAIesBMmkAgmy0c2nwb/NW8sm+qkB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg6hsje8gdg3byEfHq+pUr1m8xjzwqYZg2IKUbvp0/k=;
 b=ThdWecdivAjR9YIk3gweb55N0pwu8kc5uAHw711HZoIc2PcgZlwC8EDB5oHOw+y9m2BXzgKBxnLv0sFON+pKKHPteHGRSFmq88aIjFziPmrlZdZABzqpyiVGYc5+ZMXD3rRyUsoqpfjPymhecNFqjmezdZD4V2S0CoYElpUQNq8=
Received: from DM6PR11CA0037.namprd11.prod.outlook.com (2603:10b6:5:14c::14)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sun, 9 Feb
 2025 23:39:20 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::98) by DM6PR11CA0037.outlook.office365.com
 (2603:10b6:5:14c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Sun,
 9 Feb 2025 23:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Sun, 9 Feb 2025 23:39:20 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 9 Feb
 2025 17:39:15 -0600
Message-ID: <b050f92e-4117-4e93-8ec6-ec595fd8570a@amd.com>
Date: Mon, 10 Feb 2025 05:09:12 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized
 buffer
To: Oleg Nesterov <oleg@redhat.com>
CC: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Mateusz Guzik <mjguzik@gmail.com>, Neeraj Upadhyay
	<Neeraj.Upadhyay@amd.com>, Oliver Sang <oliver.sang@intel.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
References: <20250209150718.GA17013@redhat.com>
 <20250209150749.GA16999@redhat.com>
 <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
 <20250209180214.GA23386@redhat.com>
 <CAHk-=whirZek1fZQ_gYGHZU71+UKDMa_MYWB5RzhP_owcjAopw@mail.gmail.com>
 <20250209184427.GA27435@redhat.com>
 <CAHk-=wihBAcJLiC9dxj1M8AKHpdvrRneNk3=s-Rt-Hv5ikqo4g@mail.gmail.com>
 <20250209191510.GB27435@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250209191510.GB27435@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3bfcfc-782a-4514-1acb-08dd4962f9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVU3azhpSzZIWGJzMzJpRVUvVEo1dlVQWjJoNTcyWkxMRExlT0kwdEpCbTF1?=
 =?utf-8?B?aTR2dGtTN0dvOEpEcEJBamVRZ3VNVjltR2ZNZ2hHMlVsMjdUT2N1d1QvZncy?=
 =?utf-8?B?UTh2R3hvZWRYR1d4ZkQwZDJWVGtrZmxENFc3MS9KQloybHMvVlBOU2dwZzQx?=
 =?utf-8?B?Zm9RNVg2MlRrTFNjbnFiOW80aVJLeTl4OEVna3lsLzlmREw4TTZzZGl1akNM?=
 =?utf-8?B?bWtKRDY0cVgwaUJqL2doQ2FxWEk1S2FHU3RUUWhKTlM2cWpqTEt4MWhpZExH?=
 =?utf-8?B?RThWWVVOeGtiVngvdHk0a2phWHlUcUFFdnBOMTJPT1RXNHppd3VVMXV3emla?=
 =?utf-8?B?S3FJRjk4QTk1WFZjSWFaWC9rbngwRW5WNmt3M1NoWDVvSUFaNEFOdGtQdDlr?=
 =?utf-8?B?UUlyS0N1VkQ3WFo5bUZ1ZnA1UGgrN2c3eTNzNTRTclljSjExYlJPWTRCZE9l?=
 =?utf-8?B?VUFMQmdVOUcwTlpIQXQvSENKTzRuMXNrTDN4aDVOYU1XVXpSWFFwaDBWdnZa?=
 =?utf-8?B?b3BmaE1kbG1lK29SNGV5b1dUcm52Y2IvV0txc3RmaTNVS2pyQm1TMWp4L1d5?=
 =?utf-8?B?REpTRHB1OXdMVlFCL3ozaFpqQUtTTnlQM21Cc1NhTWNabG1CWE1KVWt6S29n?=
 =?utf-8?B?NjZlRnZuZ2QxVHQzT25CamxNQUZxTDFlenhMVjR4VEJjZm9CSUo5ME8wcm1h?=
 =?utf-8?B?KzJtZ2JKdFRWWkVYdmNYOFN1NkJna0FMdG5Oc3pGOXdRTmxReUVZbWprdXJ1?=
 =?utf-8?B?YU9YeDRTMm9ZWjFadlI0b2V0SkNoTXJKUnZOU1k1ckxoOHF2RzBzaHZicmtN?=
 =?utf-8?B?cHFzT2RmNUtBcS9uN1FOdVlqT1UwUHBnL2JrTnNLVk1JWFJPSHh1ZENES0pX?=
 =?utf-8?B?OUtHMDA0dUV2THVkWDU3Nnd3NVFOazA2a1pVZkRKNTZpcTF6bk1OcE1JcTB6?=
 =?utf-8?B?WE0vbWFRblMxWXJQcVU1a2tGckFjcmFVL2Y2RFVySFZDZHJ0TzZTMWRsRU95?=
 =?utf-8?B?eHJ5SzJ0czlibmh6bStMM0dWbzRzNTVTQ09HWTdkWnNjWkljTFRZSGtCeHp5?=
 =?utf-8?B?Z1krNFFrRE5aakxRa0VlOHNMWVFOKzFLQ09WL3BkTU9TMEZzaEdFRGxWUk81?=
 =?utf-8?B?RFZtS1B1SUNhOUdYU2RDL2xESFI3RVhkd1VJOW9BRVQ4U3NvcHE5eThVWVJh?=
 =?utf-8?B?NXY1cm5TR2ZWTCtsUGNKSktLQ2FQR3Y5NElwM0VsV0ZlOUowa0J3bStTaGxk?=
 =?utf-8?B?dU9sZk5JZDdpbHdHSVJQQW9ZSWpJY2NhZ2RVdE8zMVVVRG1rd2ZITHgrWG5E?=
 =?utf-8?B?d0FHRnBmTUdybnByNjMvaitLN01kQU02ZzFhRi9Telo3Q2pKVlpzTFlJOUtI?=
 =?utf-8?B?ZjVUN05md0xFT3NTdHl3OFJzdWVzNm9FN1FidGJBaGF4NDZOait0NlJ0RDFB?=
 =?utf-8?B?Ni9ybVQ0aUMrdXU5S0tjeTIxaDQzQmk1M2dsRFlWUnk0a3pkMk9uSll1c0lM?=
 =?utf-8?B?c0ZZdWdMaGFBcTBEdmRFN3FPVkZVazJzUDZJQUNzUGpEdUVxeHZ1a0hTL0d5?=
 =?utf-8?B?aDU2SFJKRVc3bHN6L2ZCaVlaZjdUZmtkT2hoT0tpTmNKZkR4djhvYXdCci9P?=
 =?utf-8?B?aE5aNWdTeW1zeEJLa3pEMk04TXBvV2ViK0pRVk1lNlNFL0I5Nkl6eC8xc3lK?=
 =?utf-8?B?SC9hZmdzcE1VQmNXOHlzbFp0bmNFUmNyQitTMU9nL09wODhtUzNDbU4vVnNO?=
 =?utf-8?B?aDFTZ25XaTlDYUpFWXcwUFpmNUFDWWM4a3JkZ09GVmRXMTVvdTdXR2YxMEJF?=
 =?utf-8?B?MGFWQmpzOUJkRGwzYnZOY29PbmpYUXlCbXlwQVY0NWhuelBmK1FmNmI2aUJx?=
 =?utf-8?B?Y213QlVhUHYyZHR6SzNsQVVvQjhxdmRTZzdqY2R5c2lHTms2ZWc5cmY4c2RE?=
 =?utf-8?B?WHJxOUxpdEFqN0VnNVBQMWhDalJnNjAwdnBnNkFWR2Ntc0tLMzlqakhNNi8w?=
 =?utf-8?Q?bEFnB21H0aYGPWY0Z0Uff/UrEYgEiE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 23:39:20.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3bfcfc-782a-4514-1acb-08dd4962f9bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793

Hello Oleg,

On 2/10/2025 12:45 AM, Oleg Nesterov wrote:
> On 02/09, Linus Torvalds wrote:
>>
>> On Sun, 9 Feb 2025 at 10:45, Oleg Nesterov <oleg@redhat.com> wrote:
>>>
>>> Again, lets look eat_empty_buffer().
>>>
>>> The comment says "maybe it's empty" but how/why can this happen ?
>>
>> WHY DO YOU CARE?
> 
> Because it looks unclear/confusing, and I think it can confuse other
> readers of this code. Especially after 1/2.
> 
>> So here's the deal: either you
> ...
>>   (b) you DON'T convince yourself that that is true, and you leave
>> eat_empty_buffer() alone.
> 
> Yes, I failed to convince myself that fs/splice.c can never add an
> empty bufer. Although it seems to me it should not.
> 
>> In contrast, the "eat_empty_buffer()" case just saying "if it's an
>> empty buffer, it doesn't satisfy my needs, so I'll just release the
>> empty buffer and go on".
> 
> ... without wakeup_pipe_writers().
> 
> OK, nevermind, I see your point even if I do not 100% agree.
> 
> I'll send v2 without WARN_ON() and without 2/2.

Went ahead and tested that version on top of mainline with your
previous change to skip updating {a,c,m}time, here are the results:

==================================================================
Test          : sched-messaging
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:       mainline + no-acm_time[pct imp](CV)   patched[pct imp](CV)
  1-groups     1.00 [ -0.00]( 7.19)                0.95 [  4.90](12.39)
  2-groups     1.00 [ -0.00]( 3.54)                1.02 [ -1.92]( 6.55)
  4-groups     1.00 [ -0.00]( 2.78)                1.01 [ -0.85]( 2.18)
  8-groups     1.00 [ -0.00]( 1.04)                0.99 [  0.63]( 0.77)
16-groups     1.00 [ -0.00]( 1.02)                1.00 [ -0.26]( 0.98)

I don't see any regression / improvements from a performance standpoint
on my 3rd Generation EPYC system (2 x 64C/128T. boost on, C2 disabled)
Feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> Oleg.
> 

-- 
Thanks and Regards,
Prateek


