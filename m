Return-Path: <linux-fsdevel+bounces-43368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87481A54F4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E8C189B062
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5CE1FDE37;
	Thu,  6 Mar 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kx7k6MT5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB517B500;
	Thu,  6 Mar 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275211; cv=fail; b=U8eCwdYzwUjD1XZDtpwfQsQknQDluPandFRkXCO21TqGetKAiT7JNP03q0CqG4QWfsEE+2j94uunZUWJ9zLFHw5gC7ihcqUnLV9oCYc8xXEqbpVPANguLz6zpnpSN0JAvQMpdVjtJtkm1alZX59iX4PwGFgKy9WyvRuCBs4omKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275211; c=relaxed/simple;
	bh=p/j9mwB6ozP5NNuJJ7luLfaDtqCbHchIvogxFZwgqbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h/tauk2+WWnLLCEF38qIPLLeUsEtidn/pZqoKAVtNRLNrznMyP8/uuULpJZ5AlGYdaj9BMBu1z5gj+uK8KPlYgETV7dLTGIlqAQhgXPu698WREKe0TPSd2R0PtPHfdZ7xvJfdY//MD7WpC50s5vHGU8f1BNpz3Gqgszk4mKmaig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kx7k6MT5; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKhjiOskQCs+pUwAr+U0x876Tx8+eNMGu4QyaZ9VDgtSxoNSe0OKJEwCLMXDmaSUt7XLa4yVjNoVmk8CQCijAOT/eLWNncNwmk8DyLUSK0bT6fH2oRlYWj52/GjgLHGFV+FmCjCERpkDIdoU8ZVyibNJauzbQILf2XnKML+Mmk56w7KOg1M9v4iHI/5P5DEpD2e6Jovr8m5ui+7vB+GVbgLRg6zaL5/AR+U633H7DW/aMtCEs0vFx/BOOCrXnkyaQz99jl4D/Mh2hX6bTzu+3Q0mHVrTlaDp+XuaT1PpHx4EGW/DBIGOxtlDu7US2fjEEzKBRPeMr9hJLx14BduP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTc+83HyaYqpRAllhCZ1EK1SMHyS3pZOvOBym1l5jYE=;
 b=Cjtj82NHQBRqHgS+GPIw/8L1DGRMOo7fnQHFs6YcJB5OWQ7D81nvlmHacI8igKJ/1P6rDT3inSSHQP/RoC7jqSrQO0NMJF7m7wOX1ULL9d9yGBS70EwykBsdxQ1D5xof2p34GetWXrVtBseM1Db0ssu9EZWgvqi21djIFQVuva85YTnoXbNV8V0GdRdrls3NhBA601T0sHsCeko5qHW+96GmXtlQPfujfbByU4A1yO5QsgpFzHNZZqPfbzzBDmAuMjYpUDLhzDxr5rQk8hT9ihMImWsWA4KOFri/d10f6MRUfFKsqUbItDW5mIglDtN5v8XCQyI0AnjHU3D2W7ou8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTc+83HyaYqpRAllhCZ1EK1SMHyS3pZOvOBym1l5jYE=;
 b=kx7k6MT5PIErhVOIHLLho079e0iwK6J03+iwteC4JwA46Dnu5AdnoOzRHKSSiat8Y+03Mg1viiP8Alm5NHlUIN0ushCaa5Y4gcOg/l1ECfLaXwvwe8lSGVsz2KupjVnnewttEEBPuw9FIXy/34us+6+IiDG/km5A0URwWrLLUb0=
Received: from CH0PR03CA0269.namprd03.prod.outlook.com (2603:10b6:610:e5::34)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 15:33:25 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::b1) by CH0PR03CA0269.outlook.office365.com
 (2603:10b6:610:e5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 15:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 15:33:24 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 09:33:19 -0600
Message-ID: <39574d99-51a2-4314-989e-6331ca7c0d75@amd.com>
Date: Thu, 6 Mar 2025 21:03:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] treewide: pipe: Convert all references to
 pipe->{head,tail,max_usage,ring_size} to unsigned short
To: Oleg Nesterov <oleg@redhat.com>, Rasmus Villemoes <ravi@prevas.dk>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi
	<miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, "Christian
 Brauner" <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Hugh Dickins" <hughd@google.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Jan Kara
	<jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Mateusz
 Guzik" <mjguzik@gmail.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	<Neeraj.Upadhyay@amd.com>, <Ananth.narayan@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
 <20250306113924.20004-1-kprateek.nayak@amd.com>
 <20250306113924.20004-4-kprateek.nayak@amd.com>
 <20250306123245.GE19868@redhat.com> <20250306124120.GF19868@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250306124120.GF19868@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f85133-2085-4f76-393e-08dd5cc43c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVhBYXBzVmo5OXpzMUZMWjBqRDZJR2Y4NU5LdWFTbGE4Yzlvcjd3dm8rV2pG?=
 =?utf-8?B?cDBoNmpleEpQdksxdDRET2RFcUtCWVJhWjRQZzhjcHlyaVc1eDFTT1RxM3lV?=
 =?utf-8?B?bFF6Zi9tbFE1N3duS2s0WDRBMzg2dW9iVmFHNW1oZW1YcTJnaHk1RStHT3RZ?=
 =?utf-8?B?NnlQb1JORmFLdk4zc1hTN3dYdE5tRnVudk00Z1Vzb0p2SUpMMWFCeEtkYjlF?=
 =?utf-8?B?R3RYQjNwUHhBaEsvU25rcFh0bUVVMElHWTF6M0NzUzFVbHZkb0RyQzFOUzBR?=
 =?utf-8?B?MnpadFFMamh0TGM0TVY3NE41c2c3V25YUWEySG4rYUEyalhiUVBUUW01MGFO?=
 =?utf-8?B?NGZnODlJUmdVQXU0Y0lUWUVjTkNHTTFCQXRldi84NklIQzNHRzhpVTZmNURN?=
 =?utf-8?B?eDZQUnZtaG1wR3UzSnFiS01WcElSeTJJNTJ3dzRQZjdETWtvbk1QZ0NGdzEw?=
 =?utf-8?B?cG9XcUQ1UUVwdjYyZlRDVUpwd3hwMjRRMnBLQmlERnlxRDNBUEJhN2ZpWEd6?=
 =?utf-8?B?ZDE1OU9VdGtZUWozaTZJNVhBT08vT3pwaldXZWd2ZHkyWDNNUFM0TlR4cEhV?=
 =?utf-8?B?OWdrQjZPTWVMWDNKL2hJTVFnNGtObGZldWVLd3JWSFRWQWY4RkppcGFUUE50?=
 =?utf-8?B?NXR4ZUVQemc2WmN5YzNuZkowQ2wySXZxMmEyREVHS213bmdKZTVMQzZ5MG8r?=
 =?utf-8?B?NWQ2c0dHVVBYT1hCeGpBWis0QS9namppSWg2bGdVYWNwZWtTZmxJY1haMHJv?=
 =?utf-8?B?b0hMVWZqR3E0cEY2ZUN0TWZUc1IrSHczVkZMZktVc0R6clNhVUxsU1pjdEFZ?=
 =?utf-8?B?L3pqWTduZ0V6Ti9nTHM1TTQvbmYxUUhsdXNETG00SFlUNXBLeDV4cjBwUnNu?=
 =?utf-8?B?VU41clRxZmZrenNMelduRW5qallBV1krVkFPVDhKY2E5T3lJV2dsdUJvT01B?=
 =?utf-8?B?YW9BVWxDTTdVdEVscHNwWXA3S1l1dFQwUlhsUFQrU0VCZEY1MnFpRWVvOGhB?=
 =?utf-8?B?ZkVES1lnSDZHRG9kVFI0MlBSYnpKK3dxTmNvcENOOGNtdnhzSkdOay9PSzBk?=
 =?utf-8?B?MUtTdnB4QitmaTZDUnhVMmVHU0dzcWVMMkcvcHNRWkFjV0V3bkg3RWlxZFA1?=
 =?utf-8?B?SzdlRC9EdVN6UVdjanVuS3BEYnh2MjRpR0R1MmFPcU5NREZ3WnVMOURhOFR6?=
 =?utf-8?B?a0tNN0ZqdFFMU28zY0FteFl3OU9Vd3QyenJaL0NXRTltU0QrdWtNNjVPNFB5?=
 =?utf-8?B?aUJMWGxhYlFzcWtPYUMxSm4raUQ5L1lxTnZHa01Xcm5CU1IxVDBZNnFIWXcz?=
 =?utf-8?B?TTJEQllsS09TUTZZYXZyZnI1QW9VdC9DUWYyMW5YU1pqNnZxSzVQY21oZ1VZ?=
 =?utf-8?B?dTJSRE9tQk4yRnpINndZcS9lQU4vWGpJeUxwbW1sS3A1UjJEbW13OTZJMlYv?=
 =?utf-8?B?RUpSdFhtaGhCeHVsem9Da1ZuNVFwVWk3NktwRitPY2VWZ1VadTMwTGVEekkx?=
 =?utf-8?B?WlcxT0xmUkhQWnArbGlYcVg0MkxqRHdGMHcrZlhMRzJmNlhnMEZEajJZWWhV?=
 =?utf-8?B?MzBEa3QwNkg3bDRCU0VZM0Q3R0NZWjFVUTVITGpZbURvamhwU3RkVkJnZkNo?=
 =?utf-8?B?Sk1ucXVuQmdqY3Ztd3VyaXhNN0h2SmhvaWhYSmdWdU9QK0R6QS9ZZFJGenZj?=
 =?utf-8?B?aUVBbTNPZXFmQzJZTjF1UWptQlVJdFc5T1JZZjE3RWhtRkVWQmM0ZkdIclFO?=
 =?utf-8?B?UExsUFJQcXovdWtsMUVUWm1SejZpYTZiNWJiNG4wbGRTdkNSZ1lUSzc0TTY1?=
 =?utf-8?B?aUJrMGEya0ZlaS9VL0lITEMwMFVHMVY0TlRBY0FxWDZjekpuNk0wZ2VRVkpB?=
 =?utf-8?B?U0lqRWVBMStHalJndlNBbGZPcHpwSzVkSGFHWUxTMm9MVEhqOGx6NWRKOFRI?=
 =?utf-8?B?VUxwUThUbmw0SHlaeGQ2OWRXeUhEZGhzbUpkSUhaZ2tVeWtrQ3BKOC8vQjhv?=
 =?utf-8?B?ZGU2YmJXN0h3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:33:24.9386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f85133-2085-4f76-393e-08dd5cc43c36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737

Hello Oleg, Rasmus,

On 3/6/2025 6:11 PM, Oleg Nesterov wrote:
> On 03/06, Oleg Nesterov wrote:
>>
>> On 03/06, K Prateek Nayak wrote:
>>>
>>> @@ -272,9 +272,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>>>   	 */
>>>   	for (;;) {
>>>   		/* Read ->head with a barrier vs post_one_notification() */
>>> -		unsigned int head = smp_load_acquire(&pipe->head);
>>> -		unsigned int tail = pipe->tail;
>>> -		unsigned int mask = pipe->ring_size - 1;
>>> +		unsigned short head = smp_load_acquire(&pipe->head);
>>> +		unsigned short tail = pipe->tail;
>>> +		unsigned short mask = pipe->ring_size - 1;
>>
>> I dunno... but if we do this, perhaps we should
>> s/unsigned int/pipe_index_t instead?
>>
>> At least this would be more grep friendly.

Ack. I'll leave the typedef untouched and convert these to use
pipe_index_t. This was an experiment so see if anything breaks with u16
conversion just to get more testing on that scenario. As Rasmus
mentioned, leaving the head and tail as u32 on 64bit will lead to
better code generation.

> 
> in any case, I think another cleanup before this change makes sense...
> pipe->ring_size is overused. pipe_read(), pipe_write() and much more
> users do not need "unsigned int mask", they can use pipe_buf(buf, slot)
> instead.

Ack. I'll add a cleanup patch ahead of this conversion. Thank you both
for taking a look.

> 
> Oleg.
> 

-- 
Thanks and Regards,
Prateek


