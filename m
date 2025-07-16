Return-Path: <linux-fsdevel+bounces-55120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E567DB070B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4ACA18970F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42452EE986;
	Wed, 16 Jul 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LFYmlJ4j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99902EE997;
	Wed, 16 Jul 2025 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654867; cv=fail; b=SRaIUP+rpbtFAt+ys5thMXTgc97XEcDfbHp7kcXZ2y4dMa9RHCpdUaRSZu0rbT0Aki2+MernJH82KHrkq29hSBpArnXYbDD3sW8oxS0LS1yUAIApNrbhOnDer74Ou0SDJPu9sGJ4iSe2wxoiWujv7GnQXiO0JwK0QmDgCZzpc2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654867; c=relaxed/simple;
	bh=XzfRhkyRZn8uJx5wQX+WbdkKWBygE8LBrsa5yyhedhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u8ffmqeducPT8OheDWtPF6RPL3e6BNJHM0WKHV6ojWYt0B6Yi7dAuFe7DDgN2PoqxHk+LhRrd2me2LrtrjTWfeO0SWQ3Ocab4mt5RQwik9FG+5lEnrI+Xy7/O74cM7ThhiFkT93M9cIJvGeMhiShJ5I3+saKsVOhPkjZ6EC5Xdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LFYmlJ4j; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydlnOJl68/sALe+nE9ZptsT0XTdmzjF2o6FTBg7bL/VWTyuRyyxxHwjLymDXnK9PR831wRAmmG9/Owg2h0NJ646aDyA0ZhwAl4wLBLcR9UkdyfJ90gctQEnM1lhxucyQyr7B7T203c3y5rm99F2PjyyEFAS/7vYQT6Og30+qAJK6a+FMm5jk0Ee2zEG/UGIE0tVG26jdP9LejNV3W9/cE5g7XNG2OwLnR75xzEAMI6ENQ9Wh7Gh3g81Tn4gM4AeLM9Np54ZwRALB9J+LVbo2L2aGVmBEl5muqJ2E1tWCRbL9Y2Qe1UOHGpgJ/2e/eUQKsnb7Rk2OT5KQE0PUJBhAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dznyoN39twSHOk9h64oopq1p7l/ovxXtGqSjIu/Ppxg=;
 b=Rhvh/0ivON0iGJUYeCPq/Dit0a1kKxjyEb27BcD6v11YxycPpNzFydGk7jn/vAerTgSFn+Ev5dVKs0dnnPGQhrMu6CTuPIrt7mMqQ+IFbjMHg7eflso2hp+ClPBee9vkpilhprswrHW+ObBxljow9O/XpMt5aLWaeuYOYGzKi6YiH9xHZAK4MEt5IzSVBoO+T9T9IJ3f9tO4p4C+NQSlE+WfiWRxqrgTeH6yLWXBnjRal3TTRpyMj+J3WWfxWwJsHAnPHbQao/PT5GGTHMwp53pC6CpO30PJi0C7e1HF4KaU0/qGCAeWA2RZJ4TvaepJxxq5n54FTuLJ2keLORw3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dznyoN39twSHOk9h64oopq1p7l/ovxXtGqSjIu/Ppxg=;
 b=LFYmlJ4jwzAOW+GZbO07PD1EU1x3Hf5uE4ezSfIj8zmbwMQTyu0Jbd26TIU8p1tUffn/ZcI/p6AQn7t8fQ0T764S3lK5odNcvbnXwhX0HFkpmKCr8h8nlNwJVvI34PVrbFjmIXRkhFv/tuZBaKKotU8yf8PObwEgxUWN4DYcF7g=
Received: from BN9PR03CA0453.namprd03.prod.outlook.com (2603:10b6:408:139::8)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bda) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 16 Jul
 2025 08:34:21 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::35) by BN9PR03CA0453.outlook.office365.com
 (2603:10b6:408:139::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 08:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 08:34:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 03:34:20 -0500
Received: from [10.252.218.128] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 16 Jul 2025 03:34:15 -0500
Message-ID: <9b03a602-cfa9-431a-97b9-7f46d2238e6a@amd.com>
Date: Wed, 16 Jul 2025 14:04:14 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
To: Nam Cao <namcao@linutronix.de>, Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Xi Ruoyao
	<xry111@xry111.site>, Frederic Weisbecker <frederic@kernel.org>, Valentin
 Schneider <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <linux-rt-users@vger.kernel.org>, Joe
 Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens
 Axboe <axboe@kernel.dk>
CC: <stable@vger.kernel.org>
References: <cover.1752581388.git.namcao@linutronix.de>
 <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b3969a-cac2-40b6-129f-08ddc4438fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFY1dEdNaGNoZUw1TUZST2RqaWtYUEQwdmZBaGhjQk8zd2lqZWUrL29zTUFW?=
 =?utf-8?B?QnJtTks4elEzU0k5b21yeG4yZ2phZjBBd1lxeHhub2E5MFZZQlREaXRHTCtS?=
 =?utf-8?B?cXRvSFIzU2xKa3pmbkpLRWYyRHJTYTF4Wjl3N0RvQ2FEN0NlazJwWmQ5d0ZR?=
 =?utf-8?B?QlFNQkJRWDRtL3Z6NitSeFo2cmMxYVYzSXh5VlZkRFlBdlpZd05yRENMd0pK?=
 =?utf-8?B?YkJ1ek5idThuUTBySHVFM0VHTDRMQVduQ3Nsd3l6SWdNZDFVdktuNUY5Y3JF?=
 =?utf-8?B?b1RpVU5sdENFSVJJZWdTc3VEdXdxaUkyOUU0UUZ2cEw5VW1Wbmd4ZGtCOEpy?=
 =?utf-8?B?cTlCb0V1ZzRaTDhhblppWkk2TW1PK1duam1wRW1maWJaOGFBdEJsc3VobXds?=
 =?utf-8?B?MEltYmFSRm1kcDJKaVRlZkZxV3ZxTldRWTREUHlwMHVkaG8vRlJNTkQ0Rllw?=
 =?utf-8?B?WTY5endYZUNGU1U0c3VjeVp5Mit3ZXZJRGdGcWdrVlZEcDJ2ckM4NmRzZk42?=
 =?utf-8?B?UUxETEtUSHhmcW16aHVQMDA1dlhlSU9EQXljRUMxS1BWbTE3dlNtV2NjaFJv?=
 =?utf-8?B?RGgxUk93S1Fuczh3N013S3hlQUN6a0s5eWYrK3FTbkkxS2RnWWtMcEZaUG5B?=
 =?utf-8?B?b3F0cFl5YmRWZW5TbmRyRHVUR3A5WlYzRjZDaURlYmNNWlZzaHpTR2JBRnpJ?=
 =?utf-8?B?bkM5blc0VVlVRDg1cUM1SlN4am5jMFZYQWtLZ3VyU1ZsdXQ1M0kyUlhSTy9p?=
 =?utf-8?B?S2RMblRVY1ZJK3pTdHBXank4c2ljcWFaUTlIcytxUXk3YjV1YVFLQU9FS29s?=
 =?utf-8?B?dUNUYWtMM3hFY0NHUytPUFVrd1VCNGlXMUZDcEZHYjMrZU5WRk1GVW9wMUdF?=
 =?utf-8?B?T1hWNkdnendSTjJDSU5uT2lGVnRPc00yaEpZWHhRNVpFRTZIVmhnRWRWVGF4?=
 =?utf-8?B?R3U1T2QyQ0lZajFpZ2lBVldoc0NHbUpYSElSQjZ5Q0FHQzd4b1J1TWNHQVpC?=
 =?utf-8?B?UUNOTHZiNUdiS2lURlAzd09nY1J6dExiTVFjTTdjVktzT2F1WmN5UUc5L2FB?=
 =?utf-8?B?Vjc1aFc0ODVYQzhjblZZb3ZpcUErUm9pQWxaRVMySEdkcnRpSExqQmJLMCs1?=
 =?utf-8?B?bWVyKzE0M3pKN0k2YVcwMTZ0ck5Nd2dBTG9zNytSdm53NG1sZDZWNlo1RXRx?=
 =?utf-8?B?TDVUcW1weVBKNjlpZ0RMUE9ySm9JdTBlMFdYSGV3UzRIbyswaWlTaWVZaEd0?=
 =?utf-8?B?SkxQUkR2dGQwNVZFK1Y2b0Z3V01aR3k3ZlNjRlpueG1jVUZES2dnU2cwaTZU?=
 =?utf-8?B?U1BBQjdoUEJzTlFWTC9vWnBCMjBlei8yQjNlc3ord21iSEd5RDhPTlF4Y1lX?=
 =?utf-8?B?akM5WGt0NHY3eVNoeFF5T056Q3RjdHpRdnJIZ05CVWFqQ3N0MlQ3NUdQUWFH?=
 =?utf-8?B?STRqTVVEQWN6YnRUOGJVc2xRLzRDMHJmcDVoaWlNRFJldlRxbWI0OHFEaGlV?=
 =?utf-8?B?L3QrbUlQL2NhRVVtQ1FIak1SWjdUTVF3VjVVcU1TYldLL2U3dkdKbnBqOTNI?=
 =?utf-8?B?dy9mOW1VSTdIOTNlTWJidUE5TE51aDBSeDRNdmxmYVFuVisxQUVGSjNiV25X?=
 =?utf-8?B?NWRGejJMdk9ORnVCeWljTXgrcHovZWhPTldrRXhDY2hsRDc2cGU0LzE2OTJK?=
 =?utf-8?B?NklZeXpyTEVzay8rZ1g4TmFtU2tRZ1dxZ1QrWk1CTU9Nakx2b3IyeXMyczZ4?=
 =?utf-8?B?eHRXcmxYekhxcUJxekJFcG9ZM2ZESll5TzBTYmMrYk1QUXphaDVSMmRqUUpo?=
 =?utf-8?B?aEMzUS9zL09WaXJCT0RVYTNrUmZwWVhVL0VTckFlV0cya1VlbVpWeVlsanYx?=
 =?utf-8?B?NWdVTytXRWF5ZWtaRmFLS2VIczJpYStKdEpaS0IwR0RaWHE3WlFyT1hGcmxH?=
 =?utf-8?B?QlhnTnRSemJjSExlYTd2WmVSazQ0QVhZSHB2ZnVhU29xSWdYS2NLdWNmSVY3?=
 =?utf-8?B?dTg1c01mcEVtdnEyZG9QR0Y1QzZybklKY0ZzVmRmZm1ZM204bUZMYzhrS2Nl?=
 =?utf-8?B?MSs1UEp4Wk8wNXFLMmlmWEppK2I3MVV0MjhIb2N1NHlLczNpZi81dTBpNzhu?=
 =?utf-8?Q?BwjI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 08:34:21.1859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b3969a-cac2-40b6-129f-08ddc4438fe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236

Hello Nam,

On 7/15/2025 6:16 PM, Nam Cao wrote:
> The ready event list of an epoll object is protected by read-write
> semaphore:
> 
>   - The consumer (waiter) acquires the write lock and takes items.
>   - the producer (waker) takes the read lock and adds items.
> 
> The point of this design is enabling epoll to scale well with large number
> of producers, as multiple producers can hold the read lock at the same
> time.
> 
> Unfortunately, this implementation may cause scheduling priority inversion
> problem. Suppose the consumer has higher scheduling priority than the
> producer. The consumer needs to acquire the write lock, but may be blocked
> by the producer holding the read lock. Since read-write semaphore does not
> support priority-boosting for the readers (even with CONFIG_PREEMPT_RT=y),
> we have a case of priority inversion: a higher priority consumer is blocked
> by a lower priority producer. This problem was reported in [1].
> 
> Furthermore, this could also cause stall problem, as described in [2].
> 
> Fix this problem by replacing rwlock with spinlock.
> 
> This reduces the event bandwidth, as the producers now have to contend with
> each other for the spinlock. According to the benchmark from
> https://github.com/rouming/test-tools/blob/master/stress-epoll.c:
> 
>     On 12 x86 CPUs:
>                   Before     After        Diff
>         threads  events/ms  events/ms
>               8       7162       4956     -31%
>              16       8733       5383     -38%
>              32       7968       5572     -30%
>              64      10652       5739     -46%
>             128      11236       5931     -47%
> 
>     On 4 riscv CPUs:
>                   Before     After        Diff
>         threads  events/ms  events/ms
>               8       2958       2833      -4%
>              16       3323       3097      -7%
>              32       3451       3240      -6%
>              64       3554       3178     -11%
>             128       3601       3235     -10%
> 
> Although the numbers look bad, it should be noted that this benchmark
> creates multiple threads who do nothing except constantly generating new
> epoll events, thus contention on the spinlock is high. For real workload,
> the event rate is likely much lower, and the performance drop is not as
> bad.
> 
> Using another benchmark (perf bench epoll wait) where spinlock contention
> is lower, improvement is even observed on x86:
> 
>     On 12 x86 CPUs:
>         Before: Averaged 110279 operations/sec (+- 1.09%), total secs = 8
>         After:  Averaged 114577 operations/sec (+- 2.25%), total secs = 8
> 
>     On 4 riscv CPUs:
>         Before: Averaged 175767 operations/sec (+- 0.62%), total secs = 8
>         After:  Averaged 167396 operations/sec (+- 0.23%), total secs = 8
> 
> In conclusion, no one is likely to be upset over this change. After all,
> spinlock was used originally for years, and the commit which converted to
> rwlock didn't mention a real workload, just that the benchmark numbers are
> nice.
> 
> This patch is not exactly the revert of commit a218cc491420 ("epoll: use
> rwlock in order to reduce ep_poll_callback() contention"), because git
> revert conflicts in some places which are not obvious on the resolution.
> This patch is intended to be backported, therefore go with the obvious
> approach:
> 
>   - Replace rwlock_t with spinlock_t one to one
> 
>   - Delete list_add_tail_lockless() and chain_epi_lockless(). These were
>     introduced to allow producers to concurrently add items to the list.
>     But now that spinlock no longer allows producers to touch the event
>     list concurrently, these two functions are not necessary anymore.
> 
> Fixes: a218cc491420 ("epoll: use rwlock in order to reduce ep_poll_callback() contention")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org

Tested this version with the reproducer that Jan shared in [1] on top of
tip:sched/core (PREEMPT_RT) and I didn't run into any rcu-stalls with
your patch applied on top (the VM is running the repro for over an hour
now and is still responsive). Feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

[1] https://lore.kernel.org/all/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/

> ---
>  fs/eventpoll.c | 139 +++++++++----------------------------------------
>  1 file changed, 26 insertions(+), 113 deletions(-)
-- 
Thanks and Regards,
Prateek


