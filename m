Return-Path: <linux-fsdevel+bounces-42392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC466A41929
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 10:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81C07A4BB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340624A04E;
	Mon, 24 Feb 2025 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VfSdBJaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187031A0BCD;
	Mon, 24 Feb 2025 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389212; cv=fail; b=JEc7bgTTKdVds1JRlGvsISmNjUgNajfSOvbng0OCNDuGgyoydhFAeMkE7/WCFFRXeWnTPEXWZRoMsb9D6JrA1b1yOdFmpMBOmfXbQDYAG+udEg9LjTT5Jl49HUUDVAzLN5olZ5cEUv47kug0TNnYhBbsoiUg4JEjjBj04aO4908=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389212; c=relaxed/simple;
	bh=5UPZVMyGT9kTlopkoDAI+TYe5ZC/ATL4BYNYhXM/RTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EiGLPZyX2Cml2qg+urRGd5r2t0Kq96osxfjzdqTQvLpZB1B52Zd3nFc435fRHIhc2TcvCxgFjjis3dkM3u05A95XQMCOL+ZdlT/HSVgFSUR0c98/ug6pdgUNZc6MZN1jkZ/QqPpIR3nROMjS5y4czTTBozd0sn5Uj7drAFVoH/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VfSdBJaU; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwOAtiSyEQ2SYVNzs87AwrYbG9Zzw0jnHihP3+EBF1prh1JlnikyfEazLLHuLnGcJR50sNB+ekTsDUAc3p0WE+Iai94OKSxVDNi/Wa698q4lisf2UUcrpw3LNBOabvgHGdJ+y1d4eHmfesyFtpFvxwbRFOi062M70yulS5TTp9k3djCNZwyanpf4syBIUvuflxzzl7Frxr3QzeFEb08jfZ7g0XSJuB3GmS+ma4wo0ywtkr5agKTyny4SBXEwaSWyBHFZupzWXHlnlC1AImAXoHcy5c5lOEoe/9bLe899dLnL3IdMc0RVNBxVxsVJU4ttrka8/apL4xUjKcR6eOSiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOoAqzKsVnOEeyaT/kvnMOt+FLUw6hA5Uh1vpf6vUTM=;
 b=Vy+QblMq6pJLNV//3XpmD0kzh4rU9AAE+h1vSgLvtZsgDx7JzxFjbWRHGOY0ApyhGiQkdjZMXzi+npNLGljBEdFIY0qElnTrGDbaUFLM4ZlVCBdxNXIIEzZwwKmphmQ5eBVbCYly83e2/gY0gO1uM/tHpWzdkYKcO1gBdjBmkPABatitOuLxZvOnGQKwlN01p8HYL1/vks0J4iTp/c/NmRZrVJgwFktN6GSju1cHcUyHarO+edMjd4D1g0SNtpSC/mXU0XbybtaR273Lrlp23ufV8JWn0oVB++rD/McmmStOv+x7hjCbtobXn+lobNd5wGLxClEwYYdVrq/X9lkJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOoAqzKsVnOEeyaT/kvnMOt+FLUw6hA5Uh1vpf6vUTM=;
 b=VfSdBJaUBQgaAks5McUB3e3eQsCxj2o7obPxRixivbD1xowrwDMFqIolA4xT/DuYwpmG7eNqc01FEPqAhcrwbFMm40/nmELPeIi+TnxmR2YaEJDcs8CFpGc6lpl99msD5+uaUOwj6X3DXYdDKgxkCoFIQOVy0Ppi3XcXtw9evv8=
Received: from MW4PR03CA0215.namprd03.prod.outlook.com (2603:10b6:303:b9::10)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 09:26:42 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::d) by MW4PR03CA0215.outlook.office365.com
 (2603:10b6:303:b9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 09:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 09:26:41 +0000
Received: from [10.252.195.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 03:26:32 -0600
Message-ID: <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
Date: Mon, 24 Feb 2025 14:56:09 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Oleg Nesterov <oleg@redhat.com>, Manfred Spraul
	<manfred@colorfullife.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
CC: WangYuli <wangyuli@uniontech.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>
References: <20250102140715.GA7091@redhat.com>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20250102140715.GA7091@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 4734e8f0-8b3a-407e-b484-08dd54b5590d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDU2VWZCSTlwRkJHdHduRFQ5dnRSRGVCRE9SaG1weEhSVjZqNzdrY2hDbXU1?=
 =?utf-8?B?VDVIWjBQdUVRUUVwVFlsNTFtVHVUbVZZVmxud0pHZkVHNEFXSlJYaHNoYVJK?=
 =?utf-8?B?OUFyVFIrZGJxUmFwRm1oeTc3OUxia0xXTlZ4TDdVaHhWTld6RGRSa2VKRHR2?=
 =?utf-8?B?QUs5TEVoWS92YURxWXN5WkhWVU9oeVJYN2x6am9BbGFJUHp6dXpKQ0tXbGQ0?=
 =?utf-8?B?NGVxS2tCemZSZFE5aXI3QXI0bnNFZzY0V2JSRGhydzgrRExCWWpnTWJ2cHlB?=
 =?utf-8?B?Q2s1MzhMMjBEdms3dlZxZ2cwR0xNWXBPNWRuSnQvZGViU0FONDR6cndqVG1t?=
 =?utf-8?B?ZVpvL1EvK3ZZSEpYbkxhRXo2S2VDd1UwNXdSTUpuWW9rczVmc0NINDZvV1ZP?=
 =?utf-8?B?ZmRURVovRjArRERtVCtJR2gxdGFuMDE2bHdPcWkxb05pbURYemtPUGl6dmk4?=
 =?utf-8?B?RDg2a29pbXhUYklLanBKWG4zWGFnYXpGaXdmTHVwNE50cnBJYmY2ak50bWYr?=
 =?utf-8?B?ZWdjak5xWGVtTjBIZ1AzMW9Edm1udmJKckpuQzZtTWd1Y2Q0M3cwaVEvZkVO?=
 =?utf-8?B?Q1FxendGUFgxSkl0SGt1NVFHSkYxN3J3Smk0bTVoV054bEFGNUg3KzBpNXIr?=
 =?utf-8?B?U0JZSFo2Tys4L0xaZHhoUHpJY25NNWt6SUlISUw2Wm5CY1Nqc1AvZS9DTmhw?=
 =?utf-8?B?Zy9wZXFjTjF0ektPaVdJRU43aTM3eUo0clNyNVlNWmYrNjBuUGtZcVRDRDFk?=
 =?utf-8?B?V2lXNEt1YnR3ZFRoT0JqZFZzekY1YnNWTnZSMHlPdk5GQ2dvZkNWT1hqUzNy?=
 =?utf-8?B?RVIra0NBQzN3aGlFTGlLWWJqeFRyUjFBKzNoYmRaa0gwampEY0FPVlNoZFFl?=
 =?utf-8?B?V0Vwby9oUFNMZVFvam1vMFo3WXpLcGVMLzlkalVKc3ZRR0FtWDRKVXB4Rmw0?=
 =?utf-8?B?a0hWZmxNWndneTF6eEZTOExBT0QvcFdaU1RtdTZpdU1yTCt1MkJHSU5mZmNz?=
 =?utf-8?B?T1REdHIwRktXbjhaOHBVSm95QjBMQTYveVVBVXloalNXTjEvaFRxaGtTR0hC?=
 =?utf-8?B?MUVsUS9zRTJmay8wNU1yQXUwRFkrUVNPWGRPZDJBZXZqQmNiZkNQZm5IZlZM?=
 =?utf-8?B?MnR4ZG1Uam1GaDh6UWYwdEE3UFh2U25KanEzNks3cEpBV0tvWEZ6U240OCtC?=
 =?utf-8?B?ZUEvNTB3blp2T2FWRWoxbVhoZTRrZDNoYTRiRG1tbFh0d3Fna2JKNEFTWWZr?=
 =?utf-8?B?Uk5XekI0dkxiVXZRNS96L1lBeXFqczdVcjA5N0Myd2JDODBVT3JsdXk0Szgr?=
 =?utf-8?B?VS9iOVlrZEh3ZGlTR1NIWnQxd2c4Q3U2ZnZZdTR4L0VXZCt3MjB2RkRBbVFP?=
 =?utf-8?B?NGwxVThXeGRMRStSV0xJc3d4VFpmTGtSQldvNjdBZ0h2M3NlWE44amRuMGM2?=
 =?utf-8?B?SG1iVllXZ25pUGg4aEhReTVYa3RyNEpoek9mbFppcEpDQi9sUkQxZmtpOWIr?=
 =?utf-8?B?SkdZODFmSndGTlBoR3ovR1BzcW00UU5BK1AycVVOdngzV2FJZis5T3U5Q2ZV?=
 =?utf-8?B?Q1FIcmd0YUZyNFRnRTdJTjArbllLR0JoNDBKYm05UTVWblVTR2ZacEVvOXJJ?=
 =?utf-8?B?dGlRQ3g2UUtmNnlJV3kvMlBBOEhyYWhHeGZBZEh6aWE5OVZpcVQwZkk2OUxt?=
 =?utf-8?B?YmZJdDBPbHM1ZVJtWG9tMWhzWTdBMUt0Q0MrUGxzT2hxMzZRTDZsekdqT1U1?=
 =?utf-8?B?cUNOYUNPRkl6dDBBdi9QOTZYb0Fid0VBTWdjOE44MjJ6U1ppYVEwWmtwaFFO?=
 =?utf-8?B?QnNqZDMxTllYZzFzb3RMcjZXd1BBZ3RPNThGTkorSkhtdCtSZGtJVllWYnQ0?=
 =?utf-8?B?TXF0Q2dwQmRxQ1cyUElZc2xwNGJkNDFNVHJBSlV6Zzl6aWc3Y1FoTW1HS1NJ?=
 =?utf-8?B?WFVHSDRsL0xOYjZESE1zRDh0ZFNhdGIwRVZLZTNNVW1TRWRHY0V0SWd0K1pN?=
 =?utf-8?Q?qNrncORf+rcw95s79LJ9v+1qZYMT1o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 09:26:41.4799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4734e8f0-8b3a-407e-b484-08dd54b5590d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

Hello Oleg,

On 1/2/2025 7:37 PM, Oleg Nesterov wrote:
> wake_up(pipe->wr_wait) makes no sense if pipe_full() is still true after
> the reading, the writer sleeping in wait_event(wr_wait, pipe_writable())
> will check the pipe_writable() == !pipe_full() condition and sleep again.
> 
> Only wake the writer if we actually released a pipe buf, and the pipe was
> full before we did so.
> 

We saw hang in hackbench in our weekly regression testing on mainline 
kernel. The bisect pointed to this commit.

This patch avoids the unnecessary writer wakeup but I think there may be 
a subtle race due to which the writer is never woken up in certain cases.

On zen5 system with 2 sockets with 192C/384T each, I ran hackbench with 
16 groups or 32 groups. In 1 out of 20 runs, the race condition is 
occurring where the writer is not getting woken up and the benchmarks 
hangs. I tried reverting this commit and it again started working fine.

I also tried with
https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/. After 
applying this patch, the frequency of hang is reduced to 1 in 100 times, 
but hang still
exists.

Whenever I compare the case where was_full would have been set but 
wake_writer was not set, I see the following pattern:

ret = 100 (Read was successful)
pipe_full() = 1
total_len = 0
buf->len != 0

total_len is computed using iov_iter_count() while the buf->len is the 
length of the buffer corresponding to tail(pipe->bufs[tail & mask].len).
Looking at pipe_write(), there seems to be a case where the writer can 
make progress when (chars && !was_empty) which only looks at 
iov_iter_count(). Could it be the case that there is still room in the 
buffer but we are not waking up the writer?

> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   fs/pipe.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 12b22c2723b7..82fede0f2111 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -253,7 +253,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   	size_t total_len = iov_iter_count(to);
>   	struct file *filp = iocb->ki_filp;
>   	struct pipe_inode_info *pipe = filp->private_data;
> -	bool was_full, wake_next_reader = false;
> +	bool wake_writer = false, wake_next_reader = false;
>   	ssize_t ret;
>   
>   	/* Null read succeeds. */
> @@ -264,14 +264,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   	mutex_lock(&pipe->mutex);
>   
>   	/*
> -	 * We only wake up writers if the pipe was full when we started
> -	 * reading in order to avoid unnecessary wakeups.
> +	 * We only wake up writers if the pipe was full when we started reading
> +	 * and it is no longer full after reading to avoid unnecessary wakeups.
>   	 *
>   	 * But when we do wake up writers, we do so using a sync wakeup
>   	 * (WF_SYNC), because we want them to get going and generate more
>   	 * data for us.
>   	 */
> -	was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
>   	for (;;) {
>   		/* Read ->head with a barrier vs post_one_notification() */
>   		unsigned int head = smp_load_acquire(&pipe->head);
> @@ -340,8 +339,10 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   				buf->len = 0;
>   			}
>   
> -			if (!buf->len)
> +			if (!buf->len) {
> +				wake_writer |= pipe_full(head, tail, pipe->max_usage);
>   				tail = pipe_update_tail(pipe, buf, tail);
> +			}
>   			total_len -= chars;
>   			if (!total_len)
>   				break;	/* common path: read succeeded */
> @@ -377,7 +378,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   		 * _very_ unlikely case that the pipe was full, but we got
>   		 * no data.
>   		 */
> -		if (unlikely(was_full))
> +		if (unlikely(wake_writer))
>   			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
>   		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>   
> @@ -390,15 +391,15 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
>   			return -ERESTARTSYS;
>   
> -		mutex_lock(&pipe->mutex);
> -		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
> +		wake_writer = false;
>   		wake_next_reader = true;
> +		mutex_lock(&pipe->mutex);
>   	}
>   	if (pipe_empty(pipe->head, pipe->tail))
>   		wake_next_reader = false;
>   	mutex_unlock(&pipe->mutex);
>   
> -	if (was_full)
> +	if (wake_writer)
>   		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
>   	if (wake_next_reader)
>   		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
--
Thanks and Regards,
Swapnil

