Return-Path: <linux-fsdevel+bounces-44861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9FEA6D894
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 11:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C729916C6B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 10:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBFA25DCF8;
	Mon, 24 Mar 2025 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d3stwIN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E5205E26;
	Mon, 24 Mar 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813286; cv=fail; b=n2aBiTvsSjE6JaxunNC9LxoSqL6h/Z0umvc+R6l4iq+jMnokzj9DrxoyWpxjT+5mfehfQZQ/gqpDicQI7FlVAHU3N3E1/qKEEL+TJj/WCZAG7apmVCjyc8wV/Ysx2/KHCDQ0m3A51Fl9RhB1UBLTgqRzUEiVVGO7RaB5WuLqsEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813286; c=relaxed/simple;
	bh=S1Q+5mMYzsATkM9fBO6oOkbTnKu7ocD2WYGL+sf/UiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rowO0UgT5wpfftwPopP1GZiG2fialVi+mI8mqM7oapEt0Tw3XYjyQWwDJnIhE+82p6VTy9sEkW+tAM1QjXHfxwEn1rSA5nI3GHjIAqjiNmaAzXa1aegxC22HEcb3HkYDtheOOxhvh5yq4qnIg/dPYLpiUilT1IhLE8hzmwaQyNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d3stwIN2; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE8HyVeUotswK2v/jUXKWsnpGbKybxQdwijrYQZMNqgcLhBKOxooMvozd8DpVFyoIgYTl1ArrcCOk5Ij4gCLyYMz0r90RQ2gyQLKN15QXCV1XxGuv8oLh3FCZaRD1esBwPcTY+/DkzXmEDkRs9ATheQ+MZeGIQJ0vqBEvGVx+odJ+HuWTs3oCt2RJ4mg2+HLwtLR1+89IG4x6p9dLkSq1e/C/Og7yGQc3PfdNPIBGjHiu0siYARegwB/Gxg3DfRKJToT653MPypz7ffvNQiVxlCDfrkWoctEh9hK6Li/p+uTMCU/isEqQJB+6EF2GfWyGMhiiL83zUjBTI5B3zkyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z4gUFn+HAQXWsRvG1fmQun0e/a+AY+40KMkfinjWp8=;
 b=lEbkJanFoLMdxNXWe0Xp/idK+oSR/zr376wHvjvvHssUJarydZLv8tESLQU6YOGdytcuUeGytUEt73zCGWYE3tAQ/7IZq+foI7PK+Oem1hngs+DfEMaUAu8TheznZOgahC1f3RJomDVZ5XgrfyrVvIzn9LjNb7NACsXj61HfBVhYtRByl6w6jupwjKVMytbaQQ5bcT19OgyXfzj8hbJM/xNxG++xIRU2+7oUUL9rya51pjFobvo4HDjBJBQBbOrPD/QMGcNNiz+8LjOSj9Ag/Q0Qg0mJc4b4wB4BtTRMut0DImfrQ7FZFxn0TU0OLUJZmhtSZhTeIlGdfnEdiWcwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z4gUFn+HAQXWsRvG1fmQun0e/a+AY+40KMkfinjWp8=;
 b=d3stwIN2EyBnViFZD/Sh7IEhLU8xxpYoDAVXku03IUy97WFa2PXBiY4VEVyRVzPqgfYOk30ew6BaPDrZto0pkQTLeOwe9teYg8U5n3wQdzr//Gk9FCCtlhWkpfGEi1OpPPaj6krIt8IraJlnjXlPqctQIsomBfQoDipoN55L5L8=
Received: from BY5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:180::27)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 10:48:00 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::56) by BY5PR13CA0014.outlook.office365.com
 (2603:10b6:a03:180::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.38 via Frontend Transport; Mon,
 24 Mar 2025 10:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 10:48:00 +0000
Received: from [10.252.90.31] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 05:47:56 -0500
Message-ID: <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
Date: Mon, 24 Mar 2025 16:17:53 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>
CC: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
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
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250323210251.GD14883@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5c6b3f-6b63-47f8-f4b5-08dd6ac1588f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGlrK2FRZWNZcjZ0SmlRQTZyTFplYU1ZM2ZEMksvWWRKRzRwUU5sTGJ1U0hu?=
 =?utf-8?B?VzhEb0MrMGxTOUQ5K3gyNGxSeStKSmh2clRkeDVMNkd1aFZGczJLWFlDWGxI?=
 =?utf-8?B?ditrUHVJaUhGT2lXaFZNdHFpMEZUM1lGaC90ZTJZWFBDdkZNY01wbU9WQ2Qz?=
 =?utf-8?B?NGxNRGdldExacDdJTXlnMmVQeUxXOGs4T0dnSEVLaW1aQWQ2Tmd2S3RGUXRY?=
 =?utf-8?B?MS8zdmJWeG9KL3Rmc1dwWXlOenhTV2xYLzVSV1NELzdrOTIxNFZmajJGYWNQ?=
 =?utf-8?B?Mzl2UzBlQXR4dlpsK3RobmZ6SVpmMTh4aE1NZXhOUXR4MWJOVDEwN05NWWZy?=
 =?utf-8?B?TnhvUlYrZnh3WitBbVFMaWRHNTgybXFiUENzM3dXNzlPYVd5WmQ2VHMzVDU2?=
 =?utf-8?B?UU1ZSk9LMUc3R3pEbmRDVjJvQ3hRSWQwck9wR3Raekt5aHFvaDZyYVdPQnFz?=
 =?utf-8?B?ekpYWUMwWlhnZmRHMDVwWHpwajg5djY5ZTZBa0RXeW5JUGlOVjByNmtvclR6?=
 =?utf-8?B?Z3JqdU1hVDVtVkp5QjdDNXROc3l4TUYzNFNtYVBRMklkN0dQRjRISW1xUjJP?=
 =?utf-8?B?ZzVFYmpta01oc0c5cUZ0SnEvUzlLRnN5L0U2RHNHNzl6WTc1dzVtQ1MzdkxK?=
 =?utf-8?B?d2Q0Mk4rdGlWNTBLS2tsb2t4eDE5Zkt5cDRSTFZTaUxaeE5DdVNWQnh5Y0s5?=
 =?utf-8?B?b0N3cENjS09ValZNNW1rVURyZ3FQc3RxdmNsZGRNMTlmMTJXemMzcmRTb0xX?=
 =?utf-8?B?ZlQ3K3dyRmh5MWRKL25rRmZYbWN1bGUyOUpURjRnc3FrbWoybTlqZUhzZmhr?=
 =?utf-8?B?eitBTTBLbjNrbTNGUVdoUTRLcjgvalN3TzE5TjNzaG9abHgwdW8zcmVSSXJ2?=
 =?utf-8?B?bHV3b1VhY2VmOVQ2QU02V1ZmWVB1TzU2Z0NpYkZmOFIzRDhQZHNMRVB2K1A1?=
 =?utf-8?B?TUNTaHBLTlBRUS9CN09PTE1ocTJYdTc5TVhkMWNFZXlpaU92a2R2N0FSbjcr?=
 =?utf-8?B?enV0UFh0eURWcnlXcGtVOFEzdDA1QkR3NHk2WHprMEYyUXNGcDI5Z2tURjZl?=
 =?utf-8?B?YmZBRUNtVldBZjFtd0taREdqY2JRK2tCTlB5R01qc1ljbEwvZUl2ZkFLaEFl?=
 =?utf-8?B?QTU0NWZxbDIzbk1mbVZpZnFFMEFiNjFiV1dWbmwwTVlybkkvcFp2cjYxSFNE?=
 =?utf-8?B?VFZoL2ozdUxISzN1WlliaG1LZFB1cUFGd0NCcFlRcDFtUTR0ZmRyamVtNTVX?=
 =?utf-8?B?R3hxbm52RUVPTWo3SlNyaHhic2NMQmE4QXNidnVsUU1ZOUdDQlFqMWRleXNT?=
 =?utf-8?B?N1hVaXhNTkJDSFhKK1lKZ01oNWhYMU1JZGRyL3h1bk9SUm9GVmFRS1ZFMjVH?=
 =?utf-8?B?cjc4dFdMMjdmOXhta0Y0QlgvcllkdjkraVk2R1E2Z05JNDZwQkJJUThUZVNR?=
 =?utf-8?B?cmQ5ZUFUajRjUkFrWVRlMTA2VHE3VWcvU0ViQzRvRkFYciszZDJ4ZFhvY25B?=
 =?utf-8?B?QjZSUlJJOHpvaGRkWkV1eXdSV1J1L1REUVlaV2gvRHlGVVBmNDVNbXpaclk3?=
 =?utf-8?B?Q1FFUXdXZThFVlhRRktvMTVhTDdoWU1RNXY2VlZLUUNKeFY1UU1QOXYwZ2VD?=
 =?utf-8?B?T1I0bGM0M2g5SUV1UExMRUVUNk1JODA5N1JHS3RUNUpuVEQvc09LeW9tb09J?=
 =?utf-8?B?N0VxcENRMWM4Q0lxSmJ0YUk3WjNlRmFoWlJHZ1NCUUFUWXpXTHJxWmZYck9E?=
 =?utf-8?B?a0JmY2h0cWZsZ3ljUVMrbVZDQTJTcHNBWkUzN1BXd0lpZFdBQU43N1UvZW9G?=
 =?utf-8?B?bG5lU3FkVTR5THRGMEZJM2xYSGxrQk5ETGwxcU1mQTVLTG50MWl4VlBMMjZ5?=
 =?utf-8?B?cFJLVHFzc2kvNmtMbklIcEptbFVpQWpEVE9JK1pwNTJqTmdBOXZ0UTJVRWhW?=
 =?utf-8?Q?uLBPKLiwO4c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 10:48:00.2133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5c6b3f-6b63-47f8-f4b5-08dd6ac1588f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Hello Oleg, Mateusz,

On 3/24/2025 2:32 AM, Oleg Nesterov wrote:
> Prateek, Mateusz, thanks for your participation!
> 
> On 03/23, Mateusz Guzik wrote:
>>
>> On Sun, Mar 23, 2025 at 8:47 PM Oleg Nesterov <oleg@redhat.com> wrote:
>>>
>>> OK, as expected.
>>>
>>> Dear syzbot, thank you.
>>>
>>> So far I think this is another problem revealed by aaec5a95d59615523db03dd5
>>> ("pipe_read: don't wake up the writer if the pipe is still full").
>>>
>>> I am going to forget about this report for now and return to it later, when
>>> all the pending pipe-related changes in vfs.git are merged.
>>>
>>
>> How do you ask syzbot for all stacks?
> 
> Heh, I don't know.
> 
>> The reproducer *does* use pipes, but it is unclear to me if they play
>> any role here
> 
> please see the reproducer,
> 
> 	https://syzkaller.appspot.com/x/repro.c?x=10d6a44c580000
> 
>    res = syscall(__NR_pipe2, /*pipefd=*/0x400000001900ul, /*flags=*/0ul);
>    if (res != -1) {
>      r[2] = *(uint32_t*)0x400000001900;
>      r[3] = *(uint32_t*)0x400000001904;
>    }
> 
> then
> 
>    res = syscall(__NR_dup, /*oldfd=*/r[3]);
>    if (res != -1)
>      r[4] = res;
> 
> so r[2] and r[4] are the read/write fd's.
> 
> then later
> 
>     memcpy((void*)0x400000000280, "trans=fd,", 9);
>     ...
>     memcpy((void*)0x400000000289, "rfdno", 5);
>     ...
>     sprintf((char*)0x40000000028f, "0x%016llx", (long long)r[2]);
>     ...
>     memcpy((void*)0x4000000002a2, "wfdno", 5);
>     ...
>     sprintf((char*)0x4000000002a8, "0x%016llx", (long long)r[4]);
>     ...
>     syscall(__NR_mount, /*src=*/0ul, /*dst=*/0x400000000000ul,
>             /*type=*/0x400000000040ul, /*flags=*/0ul, /*opts=*/0x400000000280ul);
> 
> so this pipe is actually used as "trans=fd".
> 
>> -- and notably we don't know if there is someone stuck
>> in pipe code, resulting in not waking up the reported thread.
> 
> Yes, I am not familiar with 9p or netfs, so I don't know either.

Didn't have any luck reproducing this yet but I'm looking at
https://syzkaller.appspot.com/x/log.txt?x=1397319b980000
which is the trimmed log from original report and I see ...

[pid  5842] creat("./file0", 000)       = 7
[  137.753309][   T30] audit: type=1400 audit(1742312362.045:90): avc:  denied  { mount } for  pid=5842 comm="syz-executor309" name="/" dev="9p" ino=2 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t tclass=filesystem permissive=1
[  137.775741][   T30] audit: type=1400 audit(1742312362.065:91): avc:  denied  { setattr } for  pid=5842 comm="syz-executor309" name="/" dev="9p" ino=2 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t tclass=file permissive=1
[  137.798215][   T30] audit: type=1400 audit(1742312362.075:92): avc:  denied  { write } for  pid=5842 comm="syz-executor309" dev="9p" ino=2 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t tclass=file permissive=1
[  137.819189][   T30] audit: type=1400 audit(1742312362.075:93): avc:  denied  { open } for  pid=5842 comm="syz-executor309" path="/file0" dev="9p" ino=2 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:unlabeled_t tclass=file permissive=1
[pid  5842] write(7, "\x08\x00\x00\x00\x1a\x17\x92\x4a\xb2\x18\xea\xcb\x15\xa3\xfc\xcf\x92\x9e\x2d\xd2\x49\x79\x03\xc1\xf8\x53\xd9\x5b\x99\x5c\x65\xe9\x94\x49\xff\x95\x3f\xa1\x1c\x77\x23\xb2\x14\x9e\xcd\xaa\x7f\x83\x3f\x60\xe1\x3b\x19\xa6\x6e\x96\x3f\x7e\x8d\xa4\x29\x7e\xbb\xfd\xda\x5b\x36\xfb\x4d\x01\xbd\x02\xe6\xc6\x52\xdc\x4d\x99\xe2\xcb\x82\xc2\xa1\xd4\xa4\x5e\x4c\x89\xba\x99\x94\xe8\x2f\x85\x4b\xbc\x34\xa4\x0b\x3a"..., 32748 <unfinished ...>

So we have a "write" denied for pid 5842 and then it tries a write that
seems to hangs. In all the traces for hang, I see a denied for a task
followed by a hang for the task in the same tgid.

But since this is a "permissive" policy, it should not cause a hang,
only report that the program is in violation. Also I have no clue how a
spurious wakeup of a writer could then lead to progress.

Since in all cases the thread info flags "flags:0x00004006" has the
TIF_NOTIFY_SIGNAL bit set, I'm wondering if it has something to do with
the fact that pipe_read() directly return -ERESTARTSYS in case of a
pending signal without any wakeups?

Well here goes nothing I guess; Totally a shot in the dark:

P.S. I think it should be wake_next_reader but if this does not hang,
perhaps it could point to some interaction with signal pending and
wakeup. There are some EPOLL semantics in pipe_write() which will
cause readers to wakeup if the writer has signal_pending() and
pipe->poll_usage is set.

#syz test: upstream aaec5a95d59615523db03dd53c2052f0a87beea7

diff --git a/fs/pipe.c b/fs/pipe.c
index 82fede0f2111..9efeb86eaac5 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -359,6 +359,8 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
  			ret = -EAGAIN;
  			break;
  		}
+		if (signal_pending(current) && pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+			wake_writer = true;
  		mutex_unlock(&pipe->mutex);
  
  		/*



