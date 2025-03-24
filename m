Return-Path: <linux-fsdevel+bounces-44880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D60A6DF9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5041896877
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36BD263C72;
	Mon, 24 Mar 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1kozb28/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8482638B2;
	Mon, 24 Mar 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833559; cv=fail; b=JEjUGUB6ykbta0ul3+75rksdYmZa8uUg8AgAbm/Zb9PGMoBBTPfy42DJDHYpllfQqX3JRAwG5NiC/t8R9DzbrjhzSqmSQcaUPw02BCnB6Wkf9Akwo3HSg+QweXmRO2TwBYMGkL3/ZKGMnk0JhsOqG8WoqMc6PbPtvgc0HMV6MoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833559; c=relaxed/simple;
	bh=dqA6E7sLCRZaZ2pK18lDzHElGrr+jGE3PChQta5psOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=plIncRT6YsGa2iDN/RtB3pz+KZgjr2z10zuBFtaHd5E+s0kbMkUnz9umfpeurIXdsjGeSdbG0ZvyHuW8V97/lFjzs68ZYbkxwKdSq7QMTtDHyX6co0vRFi+ohWzt3wrkN9WafImPZ3IyHuFr1OGfjirWtwch3zQ+2wwuF5NxI1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1kozb28/; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks941ftSz1CaDSQoOOkV8Lxq+HdSRZxDGfqk9YUORE/BJ0GyHxWsEn/Bx5AKs8mWRJieg03PDpYxzotHfR88Im35yoUmc3hDcC00Kh0qzfxxCPBmC6Pg22AOYRtb9oVEL+ZYkUlP8Qwuppj1mU4FeamnR+HG5l0dLE14hO2/DfCobeuRYFggJZv5UW4Ky5gFqYUr/EhlJrnMNcpYPt39ntvmkYKuheICB9fJivlXelDvpa5I4toJ8fnHtHH1AKpQPbTfr+paUAHKBuT6fhX3v/X68st0NMSGc0URy0PKdI9gZeytj4Wr/9QflD/MxOxGcDgfIhVcEpfuGsgebD8bCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t36wYHmDGh6v2tU/qxBc4ENPAX0E9ryE+g7kC9m+/2Q=;
 b=MuSjes0VltockSy+wr7Rz96oHGv6mDKhlQ2febKpfoh/HnPzSV2xDNCJLMQ7tiM/wJTitjIA3x8n445KdAmJ5HpPy0JSO2U95qgb/S1VCRMX9pCzXUIRRC6bcfEaqqdtF35izA1QfAItAIjoK8dKj580K5KHVC3UwtiO3yAiV6ovEdnuI5DqnS6l+GksQ9XrJg67t2yluK6IXCpKTDQEf1P6+NOTc8UOyOMHk2Ue/TDGsx/jt2SHs+5oLKgVz6qj+A6Pef7KL9+gDjaBjefkjltlaCmyP6I1eEbSfh+DCfQ3Hre6i+xf7TQHBWBas1LY1FocZFnD5WP44ANPhOCfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t36wYHmDGh6v2tU/qxBc4ENPAX0E9ryE+g7kC9m+/2Q=;
 b=1kozb28/S57fXNX1oMJjuazg5mPQWCDsI4wV18UhDMQrdXKEdIk4b+Y6npp2d+gyeNCfumNgAz93RKJrXZr1eHMp9KtmuRqO4CQuHrpZmk29mGhxwN6CtXbsCeDKJ415lPxG4jvmdeO0jAdBPIB2aiGHvJMgg26XjfBDxsm+mMg=
Received: from BN0PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:143::32)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:25:52 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::34) by BN0PR10CA0006.outlook.office365.com
 (2603:10b6:408:143::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 16:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 16:25:51 +0000
Received: from [10.252.90.31] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 11:25:47 -0500
Message-ID: <8fbd6f22-2086-4cf7-923f-ac95688c8ddf@amd.com>
Date: Mon, 24 Mar 2025 21:55:45 +0530
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
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <CAGudoHGdOf35YM013VjGKQJF81OeMN6XQfkx8oF7PKLe08CjDQ@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAGudoHGdOf35YM013VjGKQJF81OeMN6XQfkx8oF7PKLe08CjDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: a115bcec-73ce-4440-5a89-08dd6af08b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlpPZjRvVHhCWXRFeEJFdHBQUHRDMVFXU2dTTVduWU1FT2JDbE8xclVIM3By?=
 =?utf-8?B?QzBFN1VmOU5sMTBhZC9YZllCTUtMb01zakZUREVpaWpTY0VmcjhtZjJZUTND?=
 =?utf-8?B?Q1dkc1h0OTRPWXBxcXpkUHNQcC9ySEQ4OG9CNmhRY0Yra1lvbWdpWFFTVUlm?=
 =?utf-8?B?RGJyYlN1cmVYeEpTZ29EUHp4WDRwSkZ5ZDlQZnhBR0ZHcVRwMEdvbTA1UHFK?=
 =?utf-8?B?K2hFR2N6OHdVdURXWVFJTENYZkxzdWpLWDZOWUlZUGprWXJYejVIWW9kd00v?=
 =?utf-8?B?VnQvek5yQW9mYUdRWkxOREVnZ0NNRy9FZjUzRi9INEZodEwrTWVScjVsNmtB?=
 =?utf-8?B?NEZPZSt3TUpxZGtPWTRjS0szd2tzSUNwN3l2SE5oTm13U2U0ME16bE8rVTBM?=
 =?utf-8?B?QTJOVE5IQ0lGbmxqMnlWa2hEMmZtWnlNaXoxRVNsL3U1WmFZS1BIOFFJaGln?=
 =?utf-8?B?MW94bVVqL1hpU012Y2dFSkxHTDVYcWVBcnBoQSticEdvbzF5VlY5OFl1Z1Fl?=
 =?utf-8?B?Q016b3FDa0hWTUFxN1lRY0hMUDdqOWdLODdneWN4ejZnY1RmdlIzSDlFSkpD?=
 =?utf-8?B?cktIaGdsQkNKakhoWnI0eU0wWmRlVGw0UlpHMmRSQ1BNVVJNUDhQNnVSUzU0?=
 =?utf-8?B?STlyVnhuMnRqb1VzWXU5VXBzcVJnZXE5YUg4ZlYrV1AyVjB5WGpYUWl3UUlu?=
 =?utf-8?B?UGZMazdLbUluSDRmWWpYOTdCZWlFWEgzMlVodFBhRlJUVkRySms2WHlNMWR1?=
 =?utf-8?B?STdyelhWcThmZUU2c0dsaDhhTDNFTFZjMHE5QWQraEJ6c1EvajZLMXpCT0dl?=
 =?utf-8?B?Y1R1ejJJTDUzRjZ4d25UTHFpNlExT3RKNFNSQVFDMjJRS3ltNmRLVVBPY3dz?=
 =?utf-8?B?bUM0NWV0Ukl5clZWZXJiWjVwS0ZKRUhtWGxMckx1N29hbll6cERqMkd5OGxC?=
 =?utf-8?B?VnAyRkFPalVPeC9vWHNTMzBHVkpVa0d5OXBkMllwbWptM3BaNU5HOHRBWnpP?=
 =?utf-8?B?RFJKdnFxY0tyeHpENDdMNi9mT1NSUG5OU3hnYXNmZnBFZHlBbVBCRHFWV1Rv?=
 =?utf-8?B?b2x3VHBUTmxtdEl3NGhQcmtWcWsyUHBGcFVFY3BQbGxoMjY3bHVJaXF4b3Z3?=
 =?utf-8?B?MjBaQ1d0K1J3RGZrRU4zeFhZMVErM0prYjhMOVdHRzZ4bGw4eVY5MjZtbFBE?=
 =?utf-8?B?YU1OR0ZtVWY4aEdLY2d6TmtkWEsvVHlwQWRkWkFOdVdaWWx6aG1PMmlmSDlK?=
 =?utf-8?B?NkRwL1N5Tk9nOHU2UkVoOFhMNTZiNERTUW5Wd29lM3hUd2NOZVN4eTQva3JQ?=
 =?utf-8?B?d0l0ZG5Ka3I1OVMxUUo2cGRxRnZFaHlPejNpZ2kwRk5hRWxGVnBPOUphU2lK?=
 =?utf-8?B?QXEzdEc3UTF0KzEybEd2RUJlUTlhKzBnWk82M1hHNWZiUHJ2TUZpS0RRTlJh?=
 =?utf-8?B?cWREUW5NZGlKaFl3eGZxRDZOZjJ2d3FxOVVtMzA2Y2RNWUhvSXc3RlFIc0c2?=
 =?utf-8?B?TVVCODJ6MmM0bUxocnExZkIxM09CUWVCRk1sM1dCSGVwdTZRdzZmYUh0ZTI3?=
 =?utf-8?B?VjFWOGhCQzhKSmxHSWJnN1NOVDFKcUR3YXg5c05LQktMZXk0YXRLbzBmWXoy?=
 =?utf-8?B?ZTBxTHBLcVZPOHVoa3FrRkdDNE1DU1c0SVd3YmpxRnM5V3duSElhVDJSOS9B?=
 =?utf-8?B?di9zV3l6WGlzYkFJcXFaTlNhbFR5aC9rK1VnOE04ZnRaWmR5MHNoeml2YndB?=
 =?utf-8?B?VW1Pc0F3TjlkM0JpWTc5WEgwR0Q5SEJldzJhNjVlUlducXlETFdLYzB6eitw?=
 =?utf-8?B?Q2tzUW5lL3Vndk0yazcvSG1pS2NlamFKKzM0QTlVeWoyWUR5Ym8wL29YWGcr?=
 =?utf-8?B?dG1FNml2Y2NuK1VRVFVWUWJRTTVoRUp5STY1dXBiMEJVK1grMm1xbjdRRVpt?=
 =?utf-8?B?WUticjVRNFdvR2YvNWNTYy9OMkYyMTdmdVFBZnZJcXFtSEVNM04rbVFlZ1RW?=
 =?utf-8?Q?FJYeci53kuCrufhduFe550MGk0o1UA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:25:51.9904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a115bcec-73ce-4440-5a89-08dd6af08b6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063

Hello Mateusz,

On 3/24/2025 9:33 PM, Mateusz Guzik wrote:
> On Mon, Mar 24, 2025 at 3:52 PM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>> So far, with tracing, this is where I'm:
>>
>> o Mainline + Oleg's optimization reverted:
>>
>>       ...
>>       kworker/43:1-1723    [043] .....   115.309065: p9_read_work: Data read wait 55
>>       kworker/43:1-1723    [043] .....   115.309066: p9_read_work: Data read 55
>>       kworker/43:1-1723    [043] .....   115.309067: p9_read_work: Data read wait 7
>>       kworker/43:1-1723    [043] .....   115.309068: p9_read_work: Data read 7
>>              repro-4138    [043] .....   115.309084: netfs_wake_write_collector: Wake collector
>>              repro-4138    [043] .....   115.309085: netfs_wake_write_collector: Queuing collector work
>>              repro-4138    [043] .....   115.309088: netfs_unbuffered_write: netfs_unbuffered_write
>>              repro-4138    [043] .....   115.309088: netfs_end_issue_write: netfs_end_issue_write
>>              repro-4138    [043] .....   115.309089: netfs_end_issue_write: Write collector need poke 0
>>              repro-4138    [043] .....   115.309091: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>>    kworker/u1030:1-1951    [168] .....   115.309096: netfs_wake_write_collector: Wake collector
>>    kworker/u1030:1-1951    [168] .....   115.309097: netfs_wake_write_collector: Queuing collector work
>>    kworker/u1030:1-1951    [168] .....   115.309102: netfs_write_collection_worker: Write collect clearing and waking up!
>>       ... (syzbot reproducer continues)
>>
>> o Mainline:
>>
>>      kworker/185:1-1767    [185] .....   109.485961: p9_read_work: Data read wait 7
>>      kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read 7
>>      kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read wait 55
>>      kworker/185:1-1767    [185] .....   109.485963: p9_read_work: Data read 55
>>              repro-4038    [185] .....   114.225717: netfs_wake_write_collector: Wake collector
>>              repro-4038    [185] .....   114.225723: netfs_wake_write_collector: Queuing collector work
>>              repro-4038    [185] .....   114.225727: netfs_unbuffered_write: netfs_unbuffered_write
>>              repro-4038    [185] .....   114.225727: netfs_end_issue_write: netfs_end_issue_write
>>              repro-4038    [185] .....   114.225728: netfs_end_issue_write: Write collector need poke 0
>>              repro-4038    [185] .....   114.225728: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>>      ... (syzbot reproducer hangs)
>>
>> There is a third "kworker/u1030" component that never gets woken up for
>> reasons currently unknown to me with Oleg's optimization. I'll keep
>> digging.
>>
> 
> Thanks for the update.
> 
> It is unclear to me if you checked, so I'm going to have to ask just
> in case: when there is a hang, is there *anyone* stuck in pipe code
> (and if so, where)?
> 
> You can get the kernel to print stacks for all threads with sysrq:
> echo t > /proc/sysrq-trigger

This dumps an insane amount of stuff on my console. Let me search if there
is any reference to pipe somewhere in there. Meanwhile, for the reproducer
threads themself, they are at:

# ps aux | grep repro
root        4245  0.0  0.0  19040     0 ?        D    16:10   0:00 ./repro
root        4306  0.0  0.0  19172     0 pts/5    S+   16:13   0:00 ./repro
root        4307  0.0  0.0  19040     0 pts/5    D    16:13   0:00 ./repro

# cat /proc/4306/stack
[<0>] do_wait+0xa9/0x100
[<0>] kernel_wait4+0xa9/0x150
[<0>] do_syscall_64+0x6f/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

# cat /proc/4307/stack
[<0>] do_lock_mount+0x37/0x200
[<0>] path_mount+0x876/0xae0
[<0>] __x64_sys_mount+0x103/0x130
[<0>] do_syscall_64+0x6f/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

# cat /proc/4245/stack
[<0>] netfs_unbuffered_write_iter_locked+0x222/0x2b0 [netfs]
[<0>] netfs_unbuffered_write_iter+0x12d/0x1f0 [netfs]
[<0>] vfs_write+0x307/0x420
[<0>] ksys_write+0x66/0xe0
[<0>] do_syscall_64+0x6f/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

For kworkers, I did:

# for i in $(ps aux | grep kworker | tr -s ' ' | cut -d ' ' -f2); do cat /proc/$i/stack | grep pipe; done

and I got no output. Same for the string "wait".

> 

-- 
Thanks and Regards,
Prateek


