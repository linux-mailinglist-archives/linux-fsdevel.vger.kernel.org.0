Return-Path: <linux-fsdevel+bounces-43410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFCEA560D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 07:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D68B17630C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 06:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E71A5BA0;
	Fri,  7 Mar 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h6hhUqlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FED1A316A;
	Fri,  7 Mar 2025 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741328710; cv=fail; b=gQCdfRGIjh/qT7CLgkEISpuFQWsbZapPmN3i5MNn/GR90ybUcip6tQU3/6AjIsYlDt7pHC//6lnzzSLBEVv9BvPguvYBbb9IE3zZGLgM10/ahntjIcu7LK0ni1JbYNCM5QhYJ6eNhMaCGDxo5aS1A5IlZbUwUo/at1BHilXpC6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741328710; c=relaxed/simple;
	bh=Cse6Fk96aC24s41zMsiszobfJg6WVJdIE2wfwJ4avEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZUjQSXFrYL8Eo2eXqsUgA9zUpPT3D/fB2C/Jhq2qlQQQZwMc5T65G7lLw3zHFC9otImgs4NcUONLVTpjRqY26ssY7oxbIF5KYI76TJtOgXmyCqg1m1yNM09rIUv6d/AhjhpzBSCSnbwqYrsnyAZmCPQTg1iU2nH6D4d+jpOXIl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h6hhUqlC; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC3YLxS8du/IVTS5pRPyGh6680jCtn66gpCA72Osa58VnbfpGx/wJrxjlGHELlrnhIPsv/GxJHLSeBG6OywIJKeAxDCSDWtUohOA4HRvQD8tsqUbAJ/VQ8krpbPXKIlFiaPGONUlzTEUf9XjPvw/p4YGbYoMObLw+7JOtFS/doyLa/LW4EO8HizBU45yFx09dR0d+tI/Tvxf/hLtX3mCW0gRCX9Zwyb7lsxJhvH7G/0gejS3L2QpxoU0ZJM+b3ciaE9/1CPKO3W8NKJ4W2twVNRnJhbhtG7uTcxwuxucMIoakiVv9w4/mrSyCbk5UMDolxSaZJcqYciwRUJGc1IhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vukLi2Gz3y66NCfkzMcKV0iWeAhmt6dcDy8fO9Oyno=;
 b=ePNgxa1oUeaOcNzRFB+qz3hnQTwkP5dnoLkY+8tf2SU7haDx+u5Bomkm5BMsMLY0oTELM82TFeQ7GabMBqbJloZ2oSB/gd5wz7DqfBMvhzjmf8AdB/sYqZdw/+zsK+gLaHaMeuMRx5nVWPg5D+Rd+GmoPDBu51KxUw/MowsUfcikYg9MJwDX2j3JWIGgBzu4CxuwFUc/AczqWF6mkTI/i6rlmTzOjJT7oNmmIsiqto2l/9uzN4uj3naB4KdKw0BUJquOe33b5tfAQqffebPNWkjNQuUQ3F8HHhkFhzp8kWO2w7970GZKSjc5QOnB0aSOnyC79vXu2LKHbCV/LBclog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sina.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vukLi2Gz3y66NCfkzMcKV0iWeAhmt6dcDy8fO9Oyno=;
 b=h6hhUqlCzw7dv85eZgNA14oMzTLGuWw9+/cqRszJadQwjebupLkVowPNhGizBvR34+RYl/rlxGYWwAx2LhjToF+vSAzwEXGN530cM4N/ee8IqxwYAH6ilYqNYz7S6D7yjj1lJuiskNgbxytzMpWMgQPD9dQgOYs0ubn1mA8aZps=
Received: from BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::24)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 06:25:04 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::92) by BL1P221CA0009.outlook.office365.com
 (2603:10b6:208:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 06:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 06:25:02 +0000
Received: from [10.136.39.36] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 00:24:59 -0600
Message-ID: <6ff2e489-7289-4840-868e-9401f26033c6@amd.com>
Date: Fri, 7 Mar 2025 11:54:56 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Hillf Danton <hdanton@sina.com>, Oleg Nesterov <oleg@redhat.com>
CC: Mateusz Guzik <mjguzik@gmail.com>, "Sapkal, Swapnil"
	<swapnil.sapkal@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250307060827.3083-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 1855968b-92e0-410b-356b-08dd5d40cb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2VsMXdoQ1doc0FoTFdmK0ovbzdhdTc0dVZLM0pKMXUvYXM4REl5SThjYUFa?=
 =?utf-8?B?a0Vsc1lDOHBYN1ZEMFBMSkVuN1NJWEhXS2krOW9IOGo2Y0NKV2syMVQzTHpj?=
 =?utf-8?B?VW9MN1pZTVU1Yy9UdGRQVkJuTUQxaXRBNUZjM1lGOTRFWEVoVGo3b2Q1YSto?=
 =?utf-8?B?QVBxUHQ0Y09XMjVpK0NkREFVNjdkeU5uSHhPNzJZNjEyYjA4bC9vMXovSlBk?=
 =?utf-8?B?bmJSTGgrRVZveEVKOHIxK0pySzhGTmtLbkRuRnZORU5TMnVnTk1nYlE3Ykgx?=
 =?utf-8?B?bGM2Y0daai9PdENWWlEyNGpubWN4R1VxcHVNdlpBNFVWbmxDWUdFSHFsSDdi?=
 =?utf-8?B?WWhJR0FCNEN4Y2h0RWdvYzh3UUdpVDh1aHY2cnpaZ05McUk5VmpPa3QyelMw?=
 =?utf-8?B?L2hWai9Tc0lPN2tmNHVJRjNCcGh5bHJ4Z21YRHhPNnFIbFhDTEtJU3pPMXpS?=
 =?utf-8?B?YjlOdUh2U0gva2hRN1NMUWVVOHpoVFQrTjIzT1NGUUg2c2lFQ1JCTmpzTU1I?=
 =?utf-8?B?WEtHMXhVaHE5d1lLL0M5UExRWHdsNTluVFZxRU5FTGpDZ0R0dVd6dmVhMDlj?=
 =?utf-8?B?SjJoWUNpWG9KZUtFbjdPKzVacWxObjVkMkRiQVF6TFlGeFZDSzc3d0UvWE1J?=
 =?utf-8?B?b2RQOWFmNWsxaXFPZWI0SHAxS1ZDOGovMDM5Ykw0U0lOK0xsNVZNOXhWWUlQ?=
 =?utf-8?B?OW8weElkZy9HeXhCcEFuOVM3U0lBYm5vWjJsRmd2NUtFYUNxRFVVRGZobWNs?=
 =?utf-8?B?WnB5ZTdJWmViQkh1UzZWK3JoeThUcFdqdm1LTnd5UHBxU1pUa1FMUFRYSGxU?=
 =?utf-8?B?L2RGdXpIUzdycTF1SFZaVGN1ak9OWmtwdnZaL0EvLzZmdzhmRkNtR3haWUM2?=
 =?utf-8?B?ZFh0d2FVUGFneUI0NVJDdVV5d1VTK2lyTkVyQzFIOG9nV0lzaWN4QlVZRFEv?=
 =?utf-8?B?c1B1ZnJOMXBmNVZrUE1PYk9RRlZ2MmZEOVpqQXpvMXo3QnQyS1JReURuMWlF?=
 =?utf-8?B?dmo2OXVqekdnTWhyWjZMd3BranVxcXhudVZRRm0vaWpSRGwyamtYVFhIYnY5?=
 =?utf-8?B?MHdON3d3WU5rMXNrZVRzVDFaTnlBM0J3Lzh1YzZnd01XR0lkdW9aTzdhZWhX?=
 =?utf-8?B?UkNOc05kdzd1WERrR0x5ODB0Y3lRLzh1U1g5UjA5UnU5a2xSNFB1Wng4SEQw?=
 =?utf-8?B?M0hYVjVLdVRERXFXdzRqaVEwMmF4WHBvU0YzbFhySWxzZjJzZkIyRVJud0g5?=
 =?utf-8?B?OHRPeEUrb3BUZVNFdlZibTRYZkZLSnVlQmlxU0JDZEltd2JLMVU1dlludWJ1?=
 =?utf-8?B?TWNPRDdQYld5TlNrQzMvVm0xRVU1ZDhrSU5JS1Z6Vk53OHc0aEh4Zk9ld0RG?=
 =?utf-8?B?RkZGSE96dEh3N3ppQVUwL1NMbU1TRFhvbDFEempTM0tYeVVIcjdFNW9DVkt2?=
 =?utf-8?B?RThZb3JhZVV5NDJJNjFYeCtRcURXUzlBL1k5cGFoWFcyRDNyM0UzU2lEYlRI?=
 =?utf-8?B?d2huTXFoL2xNMm13Y1dwRzIyNzNkYmtyNDBJeVNqSlRVa3EzZUhNZFRPNVYx?=
 =?utf-8?B?MU9USkZvbmVZczZFYXQvVzJFZVkwQWc1QkVJU0Z3UjREZUZVcUVkN0lVaU1v?=
 =?utf-8?B?NSswZG5kNjFScW1PbzVwalJxamhUaTdvekZ1d3RQY0RtcTlPYjJCenNHT3Fs?=
 =?utf-8?B?UnVoSjZReDRDVENNanJ6NlYwZ2dvZUxMQW5Od25GQjBiTmRVTXZhNitYVjM4?=
 =?utf-8?B?Y29HZ1JEMmNkRUNIYjREZjE1Z29UeHlkSTBUSEpZVmFiS0Evd0VrS05sN3BQ?=
 =?utf-8?B?MG1JclJuRWV4U2lXWUl5K3RiOEVUQ3oreVNyREUyMUZTVTgvVDFxMVNuMFNH?=
 =?utf-8?B?aGN1V082K1VKdmR1WWxlWWcwVnVRalBBMUhJTlcrT2VFSHpnb2xnTGdiWFFK?=
 =?utf-8?B?cGJJVUpoWEl4SUxYdmlKeGNpNkJTSm5id2EwK2o5RytTRnp6alpNVXp6Qklo?=
 =?utf-8?Q?rZLTgzvtKG7kgWAgvUZMjjxqGyVPpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:25:02.4037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1855968b-92e0-410b-356b-08dd5d40cb2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

Hello Hiilf,

On 3/7/2025 11:38 AM, Hillf Danton wrote:
> On Thu, 6 Mar 2025 10:30:21 +0100 Oleg Nesterov <oleg@redhat.com>
>> On 03/06, Hillf Danton wrote:
>>> On Wed, 5 Mar 2025 12:44:34 +0100 Oleg Nesterov <oleg@redhat.com>
>>>> On 03/05, Hillf Danton wrote:
>>>>> See the loop in  ___wait_event(),
>>>>>
>>>>> 	for (;;) {
>>>>> 		prepare_to_wait_event();
>>>>>
>>>>> 		// flip
>>>>> 		if (condition)
>>>>> 			break;
>>>>>
>>>>> 		schedule();
>>>>> 	}
>>>>>
>>>>> After wakeup, waiter will sleep again if condition flips false on the waker
>>>>> side before waiter checks condition, even if condition is atomic, no?
>>>>
>>>> Yes, but in this case pipe_full() == true is correct, this writer can
>>>> safely sleep.
>>>>
>>> No, because no reader is woken up before sleep to make pipe not full.
>>
>> Why the reader should be woken before this writer sleeps? Why the reader
>> should be woken at all in this case (when pipe is full again) ?
>>
> "to make pipe not full" failed to prevent you asking questions like this one.
> 
>> We certainly can't understand each other.
>>
>> Could your picture the exact scenario/sequence which can hang?
>>
> If you think the scenario in commit 3d252160b818 [1] is correct, check
> the following one.
> 
> step-00
> 	pipe->head = 36
> 	pipe->tail = 36
> 	after 3d252160b818
> 
> step-01
> 	task-118762 writer
> 	pipe->head++;
> 	wakes up task-118740 and task-118768
> 
> step-02
> 	task-118768 writer
> 	makes pipe full;
> 	sleeps without waking up any reader as
> 	pipe was not empty after step-01
> 
> step-03
> 	task-118766 new reader
> 	makes pipe empty

Reader seeing a pipe full should wake up a writer allowing 118768 to
wakeup again and fill the pipe. Am I missing something?

> 	sleeps
> 
> step-04
> 	task-118740 reader
> 	sleeps as pipe is empty
> 
> [ Tasks 118740 and 118768 can then indefinitely wait on each other. ]
> 
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/pipe.c?id=3d252160b818045f3a152b13756f6f37ca34639d

-- 
Thanks and Regards,
Prateek


