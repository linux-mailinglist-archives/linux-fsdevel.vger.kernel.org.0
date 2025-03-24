Return-Path: <linux-fsdevel+bounces-44868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DB0A6DAF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 14:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950FD3A76D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEBB25EF8E;
	Mon, 24 Mar 2025 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aJRV1W0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C96802;
	Mon, 24 Mar 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822403; cv=fail; b=KAmxj0NQ2O5myMiPez6NxXSdv5OmdT3MkwoMQHd5YK81C0SvU6YqE2jWoW8JYeG9OA8yHKN49Du799/NSwOaIX3Pqyc1LD+BwIzzYfIeDzEi6Eq4/H/kemWXYQxKsYP50gBvWhMZx0asXD1uHt9TFcsUxj1oQDslIpAnU+NQbnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822403; c=relaxed/simple;
	bh=vtS6LslM6TOa1SdM9G8uRVsRp/A2I/8DCFtetXTdJAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VICD/AEs72ITfumgT7B0jOsA0M5n+wt0eOtbl7SW42xoW2guefO+qKXC1v5+ZLKn6k4DBXxX8mlKR530Kyg3joEEfFMVdFiCiSuzHVcFNhnpRnJljlTBccneAcHT6VavrK2Bt5WShaeNNBBrooPm80pC8gYEmkQs1gYOdd0rxFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aJRV1W0E; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2zzSsH0UuqBu4FR1YPz+CqNiQd2uQPtXhztR0EDj9giuytgyXxdszdWwxnn1P8l4iMVNx6h6G0X3EjKND7LhZFdHel8ZFBVb2Efp+KKSwUg+PeZaj57j7IRt4Ehe2ZGlu0JIzYdaoLL6I3oLTbbNMtOgQfDfvJe49OTyWQOQD46/JsiiA/qmKS/7U5ZwBLwZqJTErUced0KD/Mkg0GW3gfkasvBltpspbPwDtr5HsKSXkYF+KXxLcTYNT0MtKxeel+AOyr/GNzNfxh1muXgUt5F8yHEtxA+n6jsALYZDbK0xYID2+ObcyGA422R1BQo1RPkVCMWKsEnrucy3qx3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LR8aijfESUl9oohdfxBcWAWSJvHmsjabmxGsVDgKP0=;
 b=EdxxIJnt2VSu4VYfyQH8Mr0qqQ1G7FHHNXIm+xFrQuRdd4DA535l9zwroYdz8m2Zz8Gh/f3u7InuFJkDg8ir1c2OC9WVX2sPBtIDnQywm2CShkzgK41WHKsHdMxAn14cxreRtPZyFLcSVK3uJDqTgFSPkZznHFQFsDW3JES2AEn6w4zXo+0vm4esr5YnP9Z1LFY0iaNChjPUrsjAk4WRf262Ud9BBaFttEBrLYj3ZZ1aG/kzjwh3/cq/5RFsh328nJMoN8//4nM0nFcZjdC5PpXqUF8DU3pPQZemvfnAzDPU+BOeDQLYPn3a6qe/nHwXwAPQagckHIDucKPlK/AlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LR8aijfESUl9oohdfxBcWAWSJvHmsjabmxGsVDgKP0=;
 b=aJRV1W0EcyzIOVM8+ZvytokYpHdIEKc078g9bg+MAo4PltiavRMnN5KPgwzVn7VudKfeumzHLru5+fLz42t2rcflt2TS45O2RrSge2qMNj9WyZSQkx+xCuEh5M8pZJVKX8s/gx40Nk4k24KChFGBJE0DJx+8G+H6E8ZWCVaLXUA=
Received: from SA1P222CA0196.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::23)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:19:59 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::2c) by SA1P222CA0196.outlook.office365.com
 (2603:10b6:806:3c4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 13:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 13:19:58 +0000
Received: from [10.252.90.31] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 08:19:54 -0500
Message-ID: <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
Date: Mon, 24 Mar 2025 18:49:52 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: Mateusz Guzik <mjguzik@gmail.com>
CC: Oleg Nesterov <oleg@redhat.com>, syzbot
	<syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	<brauner@kernel.org>, <dhowells@redhat.com>, <jack@suse.cz>,
	<jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netfs@lists.linux.dev>,
	<swapnil.sapkal@amd.com>, <syzkaller-bugs@googlegroups.com>,
	<viro@zeniv.linux.org.uk>
References: <20250323184848.GB14883@redhat.com>
 <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
 <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 839c7cb8-4067-4140-eed9-08dd6ad693a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGlzSCtwYUN0YVczYzhpNVR2TU5HV0tRaFhHUE1EN2FZRmovNjc4NlM5aHBw?=
 =?utf-8?B?RGJySjZMdlBwTEp0M3hQaXRHYnVvTStOMUVnRHh4dzd2K0NwRjZtRFE1a00z?=
 =?utf-8?B?RjFkUU13emIwQlJhMXZYUFFqWHVpdDM4OGgySVNUR2h0eGNsR244QWtIVG1u?=
 =?utf-8?B?Wm9hbTczYWFvcXZPK3ZJSVhtcUpTYStJVXNQZVNNcXRkbHU0aldYL0t3Y0VE?=
 =?utf-8?B?WGt3ZmtiUll0OVI2WUU1RzdraDRBL2ZNam9OSWhSYjZ1Q1VaeDlRbGRKR2d0?=
 =?utf-8?B?UitCZnFtSFdFNC90ak5SSlhoR2NpMWJTRGR4akFvb2VmL2xiWnRQVnZxbUhi?=
 =?utf-8?B?QktyTVRYdERLQVp5TEZIS0JVTldIUDl4Tm5rNUwyRTN3MzVBV0h0ZTEvakZa?=
 =?utf-8?B?c2pKZWlKOTFrajlET3VmWDRGL3FXQ0laQVliQkdMQ2xpZVlDbnJsaWlwMGw1?=
 =?utf-8?B?RXZqSDZpNnlXWVZVUzBscitRTkk0SG1RNmlrbmdObzdvZTcwK29nRVREMUY3?=
 =?utf-8?B?ZkNOZnphbytzWnJpWnZlL0o2QmlGajRHYk5jU1V4RDFyZGlIYlFLN2NzMUZ4?=
 =?utf-8?B?TEszTWg1N0NWcnVDbHdvYzFUTWwwSlZmS21nOTRwbllWakFDZksxMEJRT3kx?=
 =?utf-8?B?VXZka2FqdFdIcnVnRVR3cEJHU0dSaENhampJM0gxZGhaT1lsSjBlVGx1Zmhw?=
 =?utf-8?B?ZDR0ZFZOSzBqRGQ5VVlQUXJwZ0E0NjhYSG0rMGI3dUMzMnNKVllqZEljVWVZ?=
 =?utf-8?B?T1RwQUlNWFpWKzhjRWxoY2FzUVVkVzZFWEczQUZGTjJ6WjVBVWhSejlGUkth?=
 =?utf-8?B?RzFSNmpUaTY4U21OMDhpckhTbXNldkErTlp0YkZ1OUw1WVRHWUIvcGZ2VnhN?=
 =?utf-8?B?TXlUQzRHV0NSZTV6RDV0S0lCd1dzNHJ6Wmt4TnVwUHFNd0pzbGx4aHpHTXU2?=
 =?utf-8?B?bU1CS3FtZU4yaExOc28rdk9WRTBrV1poZTFWbkNYTmlLZXJOU2lnMS9zc2hn?=
 =?utf-8?B?c2hEZXN0UXhmQzFHSFNkdWtGT1pyWW55ZGFiR2xXbGNldU8vWkpDZ093T05L?=
 =?utf-8?B?YzUweTN4eWVsNkVQWTFqT2d0WW5RN3hUV3U2S09hdUg5S0hpR3VuZ2E1bUd6?=
 =?utf-8?B?eUZjTFFUY245cFdkMDRaOGpORVdvZEpKY1djazNZUjJQL1pLamFIa3BzR2VZ?=
 =?utf-8?B?MnlEUHN5Z3NTaUYrbkJtUVRQd29DcmZZOFRRVE5rckZvUVorUWExRXVZcDVZ?=
 =?utf-8?B?WHlGODFjVEdHSkFjSXFMZmw5T2hEQWQxam1xNnFILzNnVi9EZHZTbE9Rb1c0?=
 =?utf-8?B?U2czMkhkVDR4U3BRaDR2R1oyRVZLYUZqMDhmU3pqK3JkRjVLWUpKZjlWSzBQ?=
 =?utf-8?B?RllHb2FYMkhUOWNCeTBTYTROcGlkbkp5Tjl6ZU5USGxoVTdWOU1hcHVtSjJp?=
 =?utf-8?B?Y0U0NVRFNHBCQUVqUGxocW1sTWRHTnY1NWxobmFBczR0NVd3K2VvdU4rMWFV?=
 =?utf-8?B?b1RkWDdoZHlBdW9hM1FRWGZlb1oyS3ZZbEdWa05hNU5JLzh0dUdEblMzN2p5?=
 =?utf-8?B?cVVlb3kvVWVQUmpwcjB3WG1SdkFnN2xXbDIvZEpjR0JzOFpWNE81VWpnNEhy?=
 =?utf-8?B?ekU5NGdqWDF1SmcreDcvbmFZT2pmdkZIRFBwc09lcDY4aHZNZ01yZGtXVnJk?=
 =?utf-8?B?RTdSK3lzRW9BWUY0THdUbGNDRjY4c0w2QnhkS1FuTlExWmJQRzZkRjA1Y1Rl?=
 =?utf-8?B?WktWMG5PcUVlVUhXR1lQTVhxdDY4cHFXY1RLSGc2TjVlNHArRUFpeGJxL1d2?=
 =?utf-8?B?MHJJMnBwZFNzbHg2QTRCbFFsMk1rbmxpaWhrWWZ4Y1FlZWd0YUpVYjliWFhv?=
 =?utf-8?B?YkVCMm4xYmJjMFJyWW54Y1pNdGVCYVN4Vmw2MlN2cGNMMjNnQXgwandGTk1t?=
 =?utf-8?Q?9eaZwLVh7Lw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:19:58.8262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839c7cb8-4067-4140-eed9-08dd6ad693a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069

Hello Mateusz,

On 3/24/2025 6:47 PM, Mateusz Guzik wrote:
> On Mon, Mar 24, 2025 at 11:48 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Hello Oleg, Mateusz,
>>
>> On 3/24/2025 2:32 AM, Oleg Nesterov wrote:
>>> Prateek, Mateusz, thanks for your participation!
>>>
>>> On 03/23, Mateusz Guzik wrote:
>>>>
>>>> On Sun, Mar 23, 2025 at 8:47 PM Oleg Nesterov <oleg@redhat.com> wrote:
>>>>>
>>>>> OK, as expected.
>>>>>
>>>>> Dear syzbot, thank you.
>>>>>
>>>>> So far I think this is another problem revealed by aaec5a95d59615523db03dd5
>>>>> ("pipe_read: don't wake up the writer if the pipe is still full").
>>>>>
>>>>> I am going to forget about this report for now and return to it later, when
>>>>> all the pending pipe-related changes in vfs.git are merged.
>>>>>
>>>>
>>>> How do you ask syzbot for all stacks?
>>>
>>> Heh, I don't know.
>>>
>>>> The reproducer *does* use pipes, but it is unclear to me if they play
>>>> any role here
>>>
>>> please see the reproducer,
>>>
>>>        https://syzkaller.appspot.com/x/repro.c?x=10d6a44c580000
>>>
>>>     res = syscall(__NR_pipe2, /*pipefd=*/0x400000001900ul, /*flags=*/0ul);
>>>     if (res != -1) {
>>>       r[2] = *(uint32_t*)0x400000001900;
>>>       r[3] = *(uint32_t*)0x400000001904;
>>>     }
>>>
>>> then
>>>
>>>     res = syscall(__NR_dup, /*oldfd=*/r[3]);
>>>     if (res != -1)
>>>       r[4] = res;
>>>
>>> so r[2] and r[4] are the read/write fd's.
>>>
>>> then later
>>>
>>>      memcpy((void*)0x400000000280, "trans=fd,", 9);
>>>      ...
>>>      memcpy((void*)0x400000000289, "rfdno", 5);
>>>      ...
>>>      sprintf((char*)0x40000000028f, "0x%016llx", (long long)r[2]);
>>>      ...
>>>      memcpy((void*)0x4000000002a2, "wfdno", 5);
>>>      ...
>>>      sprintf((char*)0x4000000002a8, "0x%016llx", (long long)r[4]);
>>>      ...
>>>      syscall(__NR_mount, /*src=*/0ul, /*dst=*/0x400000000000ul,
>>>              /*type=*/0x400000000040ul, /*flags=*/0ul, /*opts=*/0x400000000280ul);
>>>
>>> so this pipe is actually used as "trans=fd".
>>>
>>>> -- and notably we don't know if there is someone stuck
>>>> in pipe code, resulting in not waking up the reported thread.
>>>
>>> Yes, I am not familiar with 9p or netfs, so I don't know either.
>>
>> Didn't have any luck reproducing this yet but I'm looking at
>> https://syzkaller.appspot.com/x/log.txt?x=1397319b980000
>> which is the trimmed log from original report and I see ...
>>
>> [pid  5842] creat("./file0", 000)       = 7
>> [  137.753309][   T30] audit: type=1400 audit(1742312362.045:90): avc:  denied  { mount } for  pid=5842 comm="syz-executor309" name="/" dev="9p" ino=2 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t tclass=filesystem permissive=1
>> [  137.775741][   T30] audit: type=1400 audit(1742312362.065:91): avc:  denied  { setattr } for  pid=5842 comm="syz-executor309" name="/" dev="9p" ino=2 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t tclass=file permissive=1
>> [  137.798215][   T30] audit: type=1400 audit(1742312362.075:92): avc:  denied  { write } for  pid=5842 comm="syz-executor309" dev="9p" ino=2 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t tclass=file permissive=1
>> [  137.819189][   T30] audit: type=1400 audit(1742312362.075:93): avc:  denied  { open } for  pid=5842 comm="syz-executor309" path="/file0" dev="9p" ino=2 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t tclass=file permissive=1
>> [pid  5842] write(7, "\x08\x00\x00\x00\x1a\x17\x92\x4a\xb2\x18\xea\xcb\x15\xa3\xfc\xcf\x92\x9e\x2d\xd2\x49\x79\x03\xc1\xf8\x53\xd9\x5b\x99\x5c\x65\xe9\x94\x49\xff\x95\x3f\xa1\x1c\x77\x23\xb2\x14\x9e\xcd\xaa\x7f\x83\x3f\x60\xe1\x3b\x19\xa6\x6e\x96\x3f\x7e\x8d\xa4\x29\x7e\xbb\xfd\xda\x5b\x36\xfb\x4d\x01\xbd\x02\xe6\xc6\x52\xdc\x4d\x99\xe2\xcb\x82\xc2\xa1\xd4\xa4\x5e\x4c\x89\xba\x99\x94\xe8\x2f\x85\x4b\xbc\x34\xa4\x0b\x3a"..., 32748 <unfinished ...>
>>
>> So we have a "write" denied for pid 5842 and then it tries a write that
>> seems to hangs. In all the traces for hang, I see a denied for a task
>> followed by a hang for the task in the same tgid.
>>
>> But since this is a "permissive" policy, it should not cause a hang,
>> only report that the program is in violation. Also I have no clue how a
>> spurious wakeup of a writer could then lead to progress.
>>
>> Since in all cases the thread info flags "flags:0x00004006" has the
>> TIF_NOTIFY_SIGNAL bit set, I'm wondering if it has something to do with
>> the fact that pipe_read() directly return -ERESTARTSYS in case of a
>> pending signal without any wakeups?
>>
> 
> Per syzbot this attempt did not work out either.
> 
> I think the blind stabs taken by everyone here are enough.
> 
> The report does not provide the crucial bit: what are the other
> threads doing. Presumably someone else is stuck somewhere, possibly
> not even in pipe code and that stuck thread was supposed to wake up
> the one which trips over hung task detector. Figuring out what that
> thread is imo the next step.
> 
> I failed to find a relevant command in
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md
> 
> So if you guys know someone on syzkaller side, maybe you can ask them
> to tweak the report *or* maybe syzbot can test a "fix" which makes
> hung task detector also report all backtraces? I don't know if that
> can work, the output may be long enough that it will get trimmed by
> something.
> 
> I don't have to time work on this for now, just throwing ideas.

I got the reproducer running locally. Tracing stuff currently to see
what is tripping. Will report back once I find something interesting.
Might take a while since the 9p bits are so far spread out.

-- 
Thanks and Regards,
Prateek


