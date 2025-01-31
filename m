Return-Path: <linux-fsdevel+bounces-40482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3ECA23B99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 10:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C144E3A93FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A55191F6C;
	Fri, 31 Jan 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rkf6/SNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A55322B;
	Fri, 31 Jan 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738317012; cv=fail; b=cFXWOUc9vyJVEzcudrnBOCKmDflshvhMPqbx2aM2WLfZUs+H1An1DIh8DoUER+fscAlAtXdZKvIyH99hBWvUbNRnq1JP7vVGQVBcc/1a5YOwN2T22vSA68H4BEwunw1uOglrOkTEh3r+SiStPg3FMZ2gS+1gwa56joTRUpC7i1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738317012; c=relaxed/simple;
	bh=Y/giaaixoDob6qrVne4bw92U08wqPsO1RCx6i5cWdds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HrrzVu5jyYWxynUyO4MaqUambEqKzuSTEHrcaflahCCXxIOAs0VAQWsvYgdQU53wZk8rDE0u90lYNBLVNpvs3H4OqOj0sLebTkbWpozt1p+Re/HzMHkjVi93342smphK0OSGD6h/ycuTp4B+zBAZGjrh5MTWDSjDQ31yqTyMqCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rkf6/SNz; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnyMfLftDFae0s8ghxXVrw5IfFntMl+uN/gpSO6h1OIJWEaNnm2lNLend6BTak05ec4jDxdfufUx1W1H5b6UboThWZB195eUg+zQyVyOSJ0UthnzgW+vg0qCCowo9+Z1O7xlt/h7hIsN2cqIiVQoJzqZkNJddcLSvkR59KMq3spBQgybgHk8o1Mus8CcP4VXWwZWI30zltsIQ0iN6ON9PZzmhtRufyOiseARAaFx6Y28obqYlSzW7UueIyKzCepTrHvGQRg/VOdsl1DuYWmJVs1P9MKb7kzb2Usdmf/lJKo7j89f25XwXs+DJEtABZONM9efFtxMUTDqb/3q0os1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeFt2HR2onbEVgbXpakfhFks4567BWLCFnwFFO6w/7M=;
 b=OR6CTZUK+E7UT1Px/1mVOU37Un3BjSIccLmLuD6z5Cq7Ugmpc6qT1OLsAEuGMsZ/oL6hr027vN58PPOXZKYozVMGhrkwtQ9Zj3PUDgFkxD5FxOUUt0y4pt2gzh5QSP9Xy6NcM+i1bqkVt+cX+3Es9+7BLmaGaoAjlPV9YEV+Sc4EpsK/ey68wrC4y9HRkmm2Nmea3bcd5O/ULbMmYNH5dGDaRYCUXSaRU1eCacnDlKp8gSTedcPqeb5TC0WCkG7L5qeQDamN+aMKPrJRXa/VkouKrs7BHdS6A6J8XyFFvbe4sJ7Wye5gXwZ82yteRetjYjcTl/N0XwRJwWGqbyfyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeFt2HR2onbEVgbXpakfhFks4567BWLCFnwFFO6w/7M=;
 b=Rkf6/SNz6pUtp/QzJPPYbcpOw10DdUv9S8As8lK0dI19nY/wLwqN554P4VAQMIsiIbh2xP0TTXUvAxgZhmehNtGpxDoJcB7p/0zFW5+Ycia1H+1sQ2UYCqHFipvwaId0GwplbCLDNsakFkeFsomZv+5jlOA6lAcN5e8u/m/Y/1Q=
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.22; Fri, 31 Jan 2025 09:50:07 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::bd) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 09:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 09:50:06 +0000
Received: from [10.136.41.235] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 03:50:02 -0600
Message-ID: <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
Date: Fri, 31 Jan 2025 15:19:32 +0530
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
	<linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Neeraj Upadhyay
	<Neeraj.Upadhyay@amd.com>
References: <20250102140715.GA7091@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250102140715.GA7091@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e03935-84a1-489e-455a-08dd41dca4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDRSYk9hc3NwLzZ3MU41KzdMemVrVUFrMElhTjBZaUxIb1lBckZlMEZIYkMy?=
 =?utf-8?B?aGZGQ29tZ2RNOHFocnJsdHJhY2JGWUp4MnQrRFBDM0hIbmZHNkVsNWNUdVlj?=
 =?utf-8?B?cVBWOThvQ0ZNYWdsb2xvQk9ZbnJZbXRWUEhUWk1iVnFsRDR6V2ZNdGZKOEZh?=
 =?utf-8?B?Vnp5OG5MZ2lBNk9mMUhDanJ0RThsWkVqSHNUYlhXRjZDdnN2U2N6Wkd2cU1n?=
 =?utf-8?B?a2tpTTVrdXF0MThrRy9qOVNPcE9lMjVTS2NvSi82cW9zTkl3M1U4bjJaVTND?=
 =?utf-8?B?QzhoN2N0d3pNSU9PTk54cGozbHMvZldWME1DNTBIRmJBZVNjYjVMYkI4RDFF?=
 =?utf-8?B?RTVJenh4cURQbCtFUFRrNnNwdEtCNTlxbGl4T24vbitCRkVPRGxFcHo5K1lF?=
 =?utf-8?B?QWtLNVIzT3dJN3JoVS9rejAwV0VkS05VVG9kN0FQVVZHT0drMXRLblRBRUVD?=
 =?utf-8?B?bW5qYmY2SzlKSkpNczVJalRxbkphVTB2dDhKdWZOWUtuLzZ2aitQWHR2Qngw?=
 =?utf-8?B?cGNHT1Y3dFM2Mk44ZnFsRm5scUc4cExOWjN6NU92UnRBMWdWcUhLeVczT2Yx?=
 =?utf-8?B?UGdVU2FtZW9oMERZKzdkTkhGRFVEVjBPRmU5bURhOTZLeU9Jb2RJalQ4dHdH?=
 =?utf-8?B?dWRZdzlmMXBaZmw4bVVad2k3Kzg1Si9vekJ2MUIvdlp5ODQ0RnpLQXpoRFM5?=
 =?utf-8?B?d2llN1g0QzBEU1hEYjRHOTdRNW0zLzBOSTBJOUhubzQyQWJGemNrRVFJMmdZ?=
 =?utf-8?B?VndUdmdBZzFBazZpY1RRbmJBbWtOTk0xa1FwblBpZHkyWE15TUFTOGhDY1dE?=
 =?utf-8?B?ckdnN05CY001aE00SkFUUVFKNFhUaDdPS0ZVUkhuYmlCOERRbHJUSUZ2V0Zx?=
 =?utf-8?B?SkFBTGVha3BCbEFHM2VxSXAwS2QxZm40bnVLRmIzajR0OElQSTgza0s1bzRG?=
 =?utf-8?B?TGpRSDBpZEhmQ2pKRTNtRjd6L0hxdUl1SHg2N1k2WlMzK29QaVFpdjhWS0Rv?=
 =?utf-8?B?WTY0VldMTEdLdWJTb0tTTHcrdG12MVNGb042VXpUamxDSHU1N0xVVHF4c040?=
 =?utf-8?B?NjZCMzN5WnJUZ05qWmRJVlRMVXZqMnhOWmM0ZUhYbmRKQys2N3hmMHJtN3k2?=
 =?utf-8?B?UTFoM0hDM0JrMDc3Z0MxVlhXNmpuYnFFeDlPTGJVOTlIL2VuS2Rzd21HVWl6?=
 =?utf-8?B?ZnVDa0lXdklkQVZvM3hzZ1pEdHZld2RvTXFaTFZibmUveUFUTlZtNVIveXBl?=
 =?utf-8?B?cC9JdHhrMW1vMStFSTgxQTNQM3YxSFhWNU9nWHlFLzYweDJnQnFsbTRncnRT?=
 =?utf-8?B?MHN0bUN5YnEyRnJTTzZlYndaL2hDTEx0YU5kSWpEaDhkUnUvanUwN0F0TUdW?=
 =?utf-8?B?eld6d0ZBNnJXSzJBVDJ1RDJGT29ob1BrUlIvVmdUdVduT2lnNnBUNWN0S0h6?=
 =?utf-8?B?MklTbmUyVVZWY2hYUG41WG9hSVVXbDROc3ZWU29uaHdpeXhwNWZOQzhyVjYz?=
 =?utf-8?B?QVJyN3NqOUdRZUV1ZFJ0dDFvc29HWS9nMU4vcTluc0lTc1ZnWmtqUzVoMmcv?=
 =?utf-8?B?MThhMVcwTUJmSDVKZnNZZ1N1N0pxeXViNFpHV0pORU4zTHpuVHgyOWpYR2RU?=
 =?utf-8?B?aWZMMlY4OUpvUHNMM2x4MzdRT2dlbndoVE1qZ0xEc3p4dmtzdUtWL3pTVGor?=
 =?utf-8?B?U0hoUWdZeDBRbDMvbDI1aUVIeHpZdXM5ekxhZHRaMVRLWCtyWnN0d3BNWWtD?=
 =?utf-8?B?WWJJYmd4djdGdVlMWDB1RWhXN1c2Y2s0QTZPcFhmbldJZ3dCZHk1Z2F0Tmhh?=
 =?utf-8?B?OUcrNi9ZM3lPdU1NUVFKQUVFaUxma0pJdXgxOWN3OHR5TGNCUENsb2dPTW45?=
 =?utf-8?B?N3VhampqSmYvWHh6UVZRc0NTcmpLM3NhWnNZVG1lcTlacmhNYkVGMGVYYk9N?=
 =?utf-8?B?UDdYQ01rbjZPank4U3FUcVcvZHUvZ05kNXU4NWZ3NVk5OEYzcjR1WVZWODc3?=
 =?utf-8?Q?Q9JYaxnuxiBSTCCQ4INbVWh2rmDkOg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 09:50:06.8190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e03935-84a1-489e-455a-08dd41dca4c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

Hello Oleg,

On 1/2/2025 7:37 PM, Oleg Nesterov wrote:
> wake_up(pipe->wr_wait) makes no sense if pipe_full() is still true after
> the reading, the writer sleeping in wait_event(wr_wait, pipe_writable())
> will check the pipe_writable() == !pipe_full() condition and sleep again.
> 
> Only wake the writer if we actually released a pipe buf, and the pipe was
> full before we did so.

I noticed a performance regression in perf bench sched messaging at
higher utilization (larger number of groups) with this patch on the
mainline kernel. For lower utilization, this patch yields good
improvements but once the system is oversubscribed, the tale flips.

Following are the results from my testing on mainline at commit
05dbaf8dd8bf ("Merge tag 'x86-urgent-2025-01-28' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
with and without this patch:

    ==================================================================
     Test          : sched-messaging
     cmdline       : perf bench sched messaging -p -t -l 100000 -g <groups>
     Units         : Normalized time in seconds
     Interpretation: Lower is better
     Statistic     : AMean
     ==================================================================
     Case:         mainline[pct imp](CV)    revert[pct imp](CV)
      1-groups     1.00 [ -0.00](12.29)     1.26 [-25.91]( 2.71)
      2-groups     1.00 [ -0.00]( 3.64)     1.39 [-38.53]( 0.89)
      4-groups     1.00 [ -0.00]( 3.33)     1.41 [-41.42]( 1.21)
      8-groups     1.00 [ -0.00]( 2.90)     1.10 [ -9.89]( 0.95)
     16-groups     1.00 [ -0.00]( 1.46)     0.66 [ 34.46]( 1.59)

On my 3rd Generation EPYC system (2 x 64C/128T), I see that on reverting
the changes on the above mentioned commit, sched-messaging sees a
regression up until the 8 group case which contains 320 tasks, however
with 16 groups (640 tasks), the revert helps with performance.

Based on the trend in the performance, one can deduce that at lower
utilization, sched-messaging benefits from not traversing the wake up
path unnecessarily since wake_up_interruptible_sync_poll() acquires a
lock before checking if the wait queue is empty or not thus saving on
system time. However, at high utilization, there is likely a writer
waiting to write to the pipe by the time the wait queue is inspected.

Following are the perf profile comparing the mainline with the revert:

o 1-group (4.604s [mainline] vs 8.163s [revert])

     sudo ./perf record -C 0-7,64-127 -e ibs_op/cnt_ctl=1/ -- taskset -c 0-7,64-127 ./perf bench sched messaging -p -t -l 100000 -g 1

     (sched-messaging was pinned to 1 CCX and only that CCX was profiled
      using IBS to reduce noise)

							mainline			vs			revert

Samples: 606K of event 'ibs_op/cnt_ctl=1/', Event count (approx.): 205972485144                        Samples: 479K of event 'ibs_op/cnt_ctl=1/', Event count (approx.): 200365591518
Overhead  Command          Shared Object         Symbol                                                Overhead  Command          Shared Object         Symbol
    4.80%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_safe_ret                                  5.12%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_safe_ret
    4.10%  sched-messaging  [kernel.kallsyms]     [k] rep_movs_alternative                                 4.30%  sched-messaging  [kernel.kallsyms]     [k] rep_movs_alternative
    3.24%  sched-messaging  [kernel.kallsyms]     [k] osq_lock                                             3.42%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_return_thunk
    3.23%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_return_thunk                              3.31%  sched-messaging  [kernel.kallsyms]     [k] syscall_exit_to_user_mode
    3.13%  sched-messaging  [kernel.kallsyms]     [k] syscall_exit_to_user_mode                            2.71%  sched-messaging  [kernel.kallsyms]     [k] osq_lock
    2.44%  sched-messaging  [kernel.kallsyms]     [k] pipe_write                                           2.64%  sched-messaging  [kernel.kallsyms]     [k] pipe_write
    2.38%  sched-messaging  [kernel.kallsyms]     [k] pipe_read                                            2.34%  sched-messaging  [kernel.kallsyms]     [k] do_syscall_64
    2.23%  sched-messaging  [kernel.kallsyms]     [k] do_syscall_64                                        2.33%  sched-messaging  [kernel.kallsyms]     [k] pipe_read
    2.19%  sched-messaging  [kernel.kallsyms]     [k] mutex_spin_on_owner                                  2.10%  sched-messaging  [kernel.kallsyms]     [k] fdget_pos
    2.05%  swapper          [kernel.kallsyms]     [k] native_sched_clock                                   1.97%  sched-messaging  [kernel.kallsyms]     [k] vfs_write
    1.94%  sched-messaging  [kernel.kallsyms]     [k] fdget_pos                                            1.93%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSRETQ_unsafe_stack
    1.88%  sched-messaging  [kernel.kallsyms]     [k] vfs_read                                             1.91%  sched-messaging  [kernel.kallsyms]     [k] vfs_read
    1.87%  swapper          [kernel.kallsyms]     [k] psi_group_change                                     1.89%  sched-messaging  [kernel.kallsyms]     [k] mutex_spin_on_owner
    1.85%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSRETQ_unsafe_stack                           1.78%  sched-messaging  [kernel.kallsyms]     [k] current_time
    1.83%  sched-messaging  [kernel.kallsyms]     [k] vfs_write                                            1.77%  sched-messaging  [kernel.kallsyms]     [k] apparmor_file_permission
    1.68%  sched-messaging  [kernel.kallsyms]     [k] current_time                                         1.72%  sched-messaging  [kernel.kallsyms]     [k] aa_file_perm
    1.67%  sched-messaging  [kernel.kallsyms]     [k] apparmor_file_permission                             1.66%  sched-messaging  [kernel.kallsyms]     [k] rw_verify_area
    1.64%  sched-messaging  [kernel.kallsyms]     [k] aa_file_perm                                         1.59%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64_after_hwframe
    1.56%  sched-messaging  [kernel.kallsyms]     [k] rw_verify_area                                       1.38%  sched-messaging  [kernel.kallsyms]     [k] _copy_from_iter
    1.50%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64_after_hwframe                       1.38%  sched-messaging  [kernel.kallsyms]     [k] ktime_get_coarse_real_ts64_mg
    1.36%  sched-messaging  [kernel.kallsyms]     [k] ktime_get_coarse_real_ts64_mg                        1.37%  sched-messaging  [kernel.kallsyms]     [k] native_sched_clock
    1.33%  sched-messaging  [kernel.kallsyms]     [k] native_sched_clock                                   1.36%  swapper          [kernel.kallsyms]     [k] native_sched_clock
    1.29%  sched-messaging  libc.so.6             [.] read                                                 1.34%  sched-messaging  libc.so.6             [.] __GI___libc_write
    1.29%  sched-messaging  [kernel.kallsyms]     [k] _copy_from_iter                                      1.30%  sched-messaging  [kernel.kallsyms]     [k] _copy_to_iter
    1.28%  sched-messaging  [kernel.kallsyms]     [k] _copy_to_iter                                        1.29%  sched-messaging  libc.so.6             [.] read
    1.20%  sched-messaging  libc.so.6             [.] __GI___libc_write                                    1.23%  swapper          [kernel.kallsyms]     [k] psi_group_change
    1.19%  sched-messaging  [kernel.kallsyms]     [k] __mutex_lock.constprop.0                             1.10%  sched-messaging  [kernel.kallsyms]     [k] psi_group_change
    1.07%  swapper          [kernel.kallsyms]     [k] srso_alias_safe_ret                                  1.06%  sched-messaging  [kernel.kallsyms]     [k] atime_needs_update
    1.04%  sched-messaging  [kernel.kallsyms]     [k] atime_needs_update                                   1.00%  sched-messaging  [kernel.kallsyms]     [k] security_file_permission
    0.98%  sched-messaging  [kernel.kallsyms]     [k] security_file_permission                             0.97%  sched-messaging  [kernel.kallsyms]     [k] update_sd_lb_stats.constprop.0
    0.97%  sched-messaging  [kernel.kallsyms]     [k] psi_group_change                                     0.94%  sched-messaging  [kernel.kallsyms]     [k] copy_page_to_iter
    0.96%  sched-messaging  [kernel.kallsyms]     [k] copy_page_to_iter                                    0.93%  sched-messaging  [kernel.kallsyms]     [k] syscall_return_via_sysret
    0.88%  sched-messaging  [kernel.kallsyms]     [k] ksys_read                                            0.91%  sched-messaging  [kernel.kallsyms]     [k] copy_page_from_iter
    0.87%  sched-messaging  [kernel.kallsyms]     [k] syscall_return_via_sysret                            0.90%  sched-messaging  [kernel.kallsyms]     [k] ksys_write
    0.86%  sched-messaging  [kernel.kallsyms]     [k] copy_page_from_iter                                  0.89%  sched-messaging  [kernel.kallsyms]     [k] ksys_read
    0.85%  sched-messaging  [kernel.kallsyms]     [k] ksys_write                                           0.82%  sched-messaging  [kernel.kallsyms]     [k] fput
    0.79%  sched-messaging  [kernel.kallsyms]     [k] fsnotify_pre_content                                 0.82%  sched-messaging  [kernel.kallsyms]     [k] fsnotify_pre_content
    0.77%  sched-messaging  [kernel.kallsyms]     [k] fput                                                 0.78%  sched-messaging  [kernel.kallsyms]     [k] __mutex_lock.constprop.0
    0.71%  sched-messaging  [kernel.kallsyms]     [k] mutex_lock                                           0.78%  sched-messaging  [kernel.kallsyms]     [k] native_queued_spin_lock_slowpath
    0.71%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_unlock                                    0.75%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_unlock
    0.71%  swapper          [kernel.kallsyms]     [k] srso_alias_return_thunk                              0.73%  sched-messaging  [kernel.kallsyms]     [k] mutex_lock
    0.68%  sched-messaging  [kernel.kallsyms]     [k] x64_sys_call                                         0.70%  sched-messaging  [kernel.kallsyms]     [k] x64_sys_call
    0.68%  sched-messaging  [kernel.kallsyms]     [k] _raw_spin_lock_irqsave                               0.69%  swapper          [kernel.kallsyms]     [k] srso_alias_safe_ret
    0.65%  swapper          [kernel.kallsyms]     [k] menu_select                                          0.59%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_lock
    0.57%  sched-messaging  [kernel.kallsyms]     [k] __schedule                                           0.59%  sched-messaging  [kernel.kallsyms]     [k] inode_needs_update_time.part.0
    0.56%  sched-messaging  [kernel.kallsyms]     [k] page_copy_sane                                       0.57%  sched-messaging  [kernel.kallsyms]     [k] page_copy_sane
    0.54%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_lock                                      0.52%  sched-messaging  [kernel.kallsyms]     [k] select_task_rq_fair
    0.53%  sched-messaging  [kernel.kallsyms]     [k] inode_needs_update_time.part.0                       0.51%  sched-messaging  libc.so.6             [.] __GI___pthread_enable_asynccancel
    0.48%  sched-messaging  libc.so.6             [.] __GI___pthread_enable_asynccancel                    0.50%  sched-messaging  [kernel.kallsyms]     [k] fpregs_assert_state_consistent
    0.48%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64                                     0.50%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64
    0.48%  swapper          [kernel.kallsyms]     [k] save_fpregs_to_fpstate                               0.49%  sched-messaging  [kernel.kallsyms]     [k] mutex_unlock
    0.48%  sched-messaging  [kernel.kallsyms]     [k] mutex_unlock                                         0.49%  sched-messaging  [kernel.kallsyms]     [k] __schedule
    0.47%  sched-messaging  [kernel.kallsyms]     [k] dequeue_entity                                       0.48%  sched-messaging  [kernel.kallsyms]     [k] update_load_avg
    0.46%  sched-messaging  [kernel.kallsyms]     [k] fpregs_assert_state_consistent                       0.48%  sched-messaging  [kernel.kallsyms]     [k] _raw_spin_lock_irqsave
    0.46%  sched-messaging  [kernel.kallsyms]     [k] update_load_avg                                      0.48%  sched-messaging  [kernel.kallsyms]     [k] cpu_util
    0.46%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_se                                 0.47%  swapper          [kernel.kallsyms]     [k] srso_alias_return_thunk
    0.45%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_cfs_rq                             0.46%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_se
    0.37%  swapper          [kernel.kallsyms]     [k] __schedule                                           0.45%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_cfs_rq
    0.36%  swapper          [kernel.kallsyms]     [k] enqueue_entity                                       0.45%  swapper          [kernel.kallsyms]     [k] menu_select
    0.35%  sched-messaging  perf                  [.] sender                                               0.38%  sched-messaging  perf                  [.] sender
    0.34%  sched-messaging  [kernel.kallsyms]     [k] file_update_time                                     0.37%  sched-messaging  [kernel.kallsyms]     [k] file_update_time
    0.34%  swapper          [kernel.kallsyms]     [k] acpi_processor_ffh_cstate_enter                      0.36%  sched-messaging  [kernel.kallsyms]     [k] _find_next_and_bit
    0.33%  sched-messaging  perf                  [.] receiver                                             0.34%  sched-messaging  [kernel.kallsyms]     [k] dequeue_entity
    0.32%  sched-messaging  [kernel.kallsyms]     [k] __cond_resched                                       0.33%  sched-messaging  [kernel.kallsyms]     [k] update_curr
---

o 16-groups (11.895s [Mainline] vs 8.163s [revert])

     sudo ./perf record -a -e ibs_op/cnt_ctl=1/ -- ./perf bench sched messaging -p -t -l 100000 -g 1

     (Whole system was profiled since there are 640 tasks on a 256CPU
      setup)

							mainline			vs			revert

Samples: 10M of event 'ibs_op/cnt_ctl=1/', Event count (approx.): 3257434807546                     Samples: 6M of event 'ibs_op/cnt_ctl=1/', Event count (approx.): 3115778240381
Overhead  Command          Shared Object         Symbol                                             Overhead  Command          Shared Object            Symbol
    5.07%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_safe_ret                               5.28%  sched-messaging  [kernel.kallsyms]        [k] srso_alias_safe_ret
    4.24%  sched-messaging  [kernel.kallsyms]     [k] rep_movs_alternative                              4.55%  sched-messaging  [kernel.kallsyms]        [k] rep_movs_alternative
    3.42%  sched-messaging  [kernel.kallsyms]     [k] srso_alias_return_thunk                           3.56%  sched-messaging  [kernel.kallsyms]        [k] srso_alias_return_thunk
    3.26%  sched-messaging  [kernel.kallsyms]     [k] syscall_exit_to_user_mode                         3.44%  sched-messaging  [kernel.kallsyms]        [k] syscall_exit_to_user_mode
    2.55%  sched-messaging  [kernel.kallsyms]     [k] pipe_write                                        2.78%  sched-messaging  [kernel.kallsyms]        [k] pipe_write
    2.51%  sched-messaging  [kernel.kallsyms]     [k] osq_lock                                          2.48%  sched-messaging  [kernel.kallsyms]        [k] do_syscall_64
    2.38%  sched-messaging  [kernel.kallsyms]     [k] pipe_read                                         2.47%  sched-messaging  [kernel.kallsyms]        [k] pipe_read
    2.31%  sched-messaging  [kernel.kallsyms]     [k] do_syscall_64                                     2.15%  sched-messaging  [kernel.kallsyms]        [k] fdget_pos
    2.11%  sched-messaging  [kernel.kallsyms]     [k] mutex_spin_on_owner                               2.12%  sched-messaging  [kernel.kallsyms]        [k] vfs_write
    2.00%  sched-messaging  [kernel.kallsyms]     [k] fdget_pos                                         2.03%  sched-messaging  [kernel.kallsyms]        [k] entry_SYSRETQ_unsafe_stack
    1.93%  sched-messaging  [kernel.kallsyms]     [k] vfs_write                                         1.97%  sched-messaging  [kernel.kallsyms]        [k] vfs_read
    1.90%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSRETQ_unsafe_stack                        1.92%  sched-messaging  [kernel.kallsyms]        [k] native_sched_clock
    1.88%  sched-messaging  [kernel.kallsyms]     [k] vfs_read                                          1.87%  sched-messaging  [kernel.kallsyms]        [k] psi_group_change
    1.77%  sched-messaging  [kernel.kallsyms]     [k] native_sched_clock                                1.87%  sched-messaging  [kernel.kallsyms]        [k] current_time
    1.74%  sched-messaging  [kernel.kallsyms]     [k] current_time                                      1.83%  sched-messaging  [kernel.kallsyms]        [k] apparmor_file_permission
    1.70%  sched-messaging  [kernel.kallsyms]     [k] apparmor_file_permission                          1.79%  sched-messaging  [kernel.kallsyms]        [k] aa_file_perm
    1.67%  sched-messaging  [kernel.kallsyms]     [k] aa_file_perm                                      1.73%  sched-messaging  [kernel.kallsyms]        [k] rw_verify_area
    1.61%  sched-messaging  [kernel.kallsyms]     [k] rw_verify_area                                    1.66%  sched-messaging  [kernel.kallsyms]        [k] entry_SYSCALL_64_after_hwframe
    1.60%  sched-messaging  [kernel.kallsyms]     [k] psi_group_change                                  1.48%  sched-messaging  [kernel.kallsyms]        [k] ktime_get_coarse_real_ts64_mg
    1.56%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64_after_hwframe                    1.46%  sched-messaging  [kernel.kallsyms]        [k] _copy_from_iter
    1.38%  sched-messaging  [kernel.kallsyms]     [k] ktime_get_coarse_real_ts64_mg                     1.39%  sched-messaging  libc.so.6                [.] __GI___libc_write
    1.37%  sched-messaging  [kernel.kallsyms]     [k] _copy_from_iter                                   1.39%  sched-messaging  [kernel.kallsyms]        [k] _copy_to_iter
    1.31%  sched-messaging  [kernel.kallsyms]     [k] _copy_to_iter                                     1.37%  sched-messaging  libc.so.6                [.] read
    1.31%  sched-messaging  libc.so.6             [.] read                                              1.10%  sched-messaging  [kernel.kallsyms]        [k] atime_needs_update
    1.28%  sched-messaging  libc.so.6             [.] __GI___libc_write                                 1.07%  swapper          [kernel.kallsyms]        [k] native_sched_clock
    1.23%  swapper          [kernel.kallsyms]     [k] native_sched_clock                                1.05%  sched-messaging  [kernel.kallsyms]        [k] native_queued_spin_lock_slowpath
    1.04%  sched-messaging  [kernel.kallsyms]     [k] atime_needs_update                                1.05%  sched-messaging  [kernel.kallsyms]        [k] security_file_permission
    0.99%  sched-messaging  [kernel.kallsyms]     [k] security_file_permission                          1.00%  sched-messaging  [kernel.kallsyms]        [k] copy_page_to_iter
    0.99%  swapper          [kernel.kallsyms]     [k] psi_group_change                                  0.97%  sched-messaging  [kernel.kallsyms]        [k] copy_page_from_iter
    0.96%  sched-messaging  [kernel.kallsyms]     [k] copy_page_to_iter                                 0.97%  sched-messaging  [kernel.kallsyms]        [k] syscall_return_via_sysret
    0.91%  sched-messaging  [kernel.kallsyms]     [k] copy_page_from_iter                               0.96%  sched-messaging  [kernel.kallsyms]        [k] ksys_write
    0.90%  sched-messaging  [kernel.kallsyms]     [k] syscall_return_via_sysret                         0.95%  sched-messaging  [kernel.kallsyms]        [k] ksys_read
    0.90%  sched-messaging  [kernel.kallsyms]     [k] ksys_read                                         0.85%  sched-messaging  [kernel.kallsyms]        [k] fsnotify_pre_content
    0.90%  sched-messaging  [kernel.kallsyms]     [k] __mutex_lock.constprop.0                          0.84%  sched-messaging  [kernel.kallsyms]        [k] fput
    0.88%  sched-messaging  [kernel.kallsyms]     [k] ksys_write                                        0.82%  swapper          [kernel.kallsyms]        [k] psi_group_change
    0.80%  sched-messaging  [kernel.kallsyms]     [k] fput                                              0.80%  sched-messaging  [kernel.kallsyms]        [k] __rcu_read_unlock
    0.80%  sched-messaging  [kernel.kallsyms]     [k] fsnotify_pre_content                              0.76%  sched-messaging  [kernel.kallsyms]        [k] x64_sys_call
    0.74%  sched-messaging  [kernel.kallsyms]     [k] mutex_lock                                        0.76%  sched-messaging  [kernel.kallsyms]        [k] mutex_lock
    0.73%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_unlock                                 0.69%  sched-messaging  [kernel.kallsyms]        [k] __schedule
    0.70%  sched-messaging  [kernel.kallsyms]     [k] x64_sys_call                                      0.67%  sched-messaging  [kernel.kallsyms]        [k] osq_lock
    0.69%  swapper          [kernel.kallsyms]     [k] srso_alias_safe_ret                               0.64%  swapper          [kernel.kallsyms]        [k] srso_alias_safe_ret
    0.63%  sched-messaging  [kernel.kallsyms]     [k] __schedule                                        0.62%  sched-messaging  [kernel.kallsyms]        [k] __rcu_read_lock
    0.62%  sched-messaging  [kernel.kallsyms]     [k] _raw_spin_lock_irqsave                            0.61%  sched-messaging  [kernel.kallsyms]        [k] inode_needs_update_time.part.0
    0.57%  sched-messaging  [kernel.kallsyms]     [k] page_copy_sane                                    0.61%  sched-messaging  [kernel.kallsyms]        [k] page_copy_sane
    0.57%  sched-messaging  [kernel.kallsyms]     [k] __rcu_read_lock                                   0.59%  sched-messaging  [kernel.kallsyms]        [k] select_task_rq_fair
    0.56%  sched-messaging  [kernel.kallsyms]     [k] inode_needs_update_time.part.0                    0.54%  sched-messaging  [kernel.kallsyms]        [k] _raw_spin_lock_irqsave
    0.52%  sched-messaging  [kernel.kallsyms]     [k] update_sd_lb_stats.constprop.0                    0.53%  sched-messaging  libc.so.6                [.] __GI___pthread_enable_asynccancel
    0.49%  sched-messaging  [kernel.kallsyms]     [k] restore_fpregs_from_fpstate                       0.53%  sched-messaging  [kernel.kallsyms]        [k] update_load_avg
    0.49%  sched-messaging  libc.so.6             [.] __GI___pthread_enable_asynccancel                 0.52%  sched-messaging  [kernel.kallsyms]        [k] entry_SYSCALL_64
    0.49%  sched-messaging  [kernel.kallsyms]     [k] entry_SYSCALL_64                                  0.52%  sched-messaging  [kernel.kallsyms]        [k] fpregs_assert_state_consistent
    0.49%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_se                              0.52%  sched-messaging  [kernel.kallsyms]        [k] __update_load_avg_se
    0.49%  sched-messaging  [kernel.kallsyms]     [k] mutex_unlock                                      0.52%  sched-messaging  [kernel.kallsyms]        [k] mutex_spin_on_owner
    0.48%  sched-messaging  [kernel.kallsyms]     [k] update_load_avg                                   0.51%  sched-messaging  [kernel.kallsyms]        [k] mutex_unlock
    0.47%  sched-messaging  [kernel.kallsyms]     [k] fpregs_assert_state_consistent                    0.47%  sched-messaging  [kernel.kallsyms]        [k] __update_load_avg_cfs_rq
    0.46%  swapper          [kernel.kallsyms]     [k] srso_alias_return_thunk                           0.43%  swapper          [kernel.kallsyms]        [k] srso_alias_return_thunk
    0.46%  sched-messaging  [kernel.kallsyms]     [k] __update_load_avg_cfs_rq                          0.41%  sched-messaging  [kernel.kallsyms]        [k] __mutex_lock.constprop.0
    0.43%  swapper          [kernel.kallsyms]     [k] menu_select                                       0.41%  sched-messaging  [kernel.kallsyms]        [k] dequeue_entity
    0.39%  sched-messaging  [kernel.kallsyms]     [k] dequeue_entity                                    0.40%  sched-messaging  [kernel.kallsyms]        [k] update_curr
    0.39%  sched-messaging  [kernel.kallsyms]     [k] native_queued_spin_lock_slowpath                  0.39%  sched-messaging  perf                     [.] sender
    0.38%  sched-messaging  [kernel.kallsyms]     [k] update_curr                                       0.39%  sched-messaging  [kernel.kallsyms]        [k] file_update_time
    0.37%  sched-messaging  perf                  [.] sender                                            0.37%  sched-messaging  [kernel.kallsyms]        [k] psi_task_switch
    0.35%  sched-messaging  [kernel.kallsyms]     [k] file_update_time                                  0.37%  swapper          [kernel.kallsyms]        [k] menu_select
    0.35%  sched-messaging  [kernel.kallsyms]     [k] select_task_rq_fair                               0.34%  sched-messaging  perf                     [.] receiver
    0.34%  sched-messaging  [kernel.kallsyms]     [k] psi_task_switch                                   0.32%  sched-messaging  [kernel.kallsyms]        [k] __calc_delta.constprop.0
---

For 1-groups I see "osq_lock" turning slightly hotter on mainline
compared to the revert probably suggesting more optimistic spinning
on the "pipe->mutex".

For the 16-client case, I see that "native_queued_spin_lock_slowpath"
jumps up with the revert.

Adding --call-graph when profiling completely alters the profile but
in case of the revert, I was able to see which paths lead to
"native_queued_spin_lock_slowpath" with 16-groups case:


   Overhead  Command          Shared Object            Symbol
-    4.21%  sched-messaging  [kernel.kallsyms]        [k] native_queued_spin_lock_slowpath
    - 2.77% native_queued_spin_lock_slowpath
       - 1.52% _raw_spin_lock_irqsave
          - 1.35% prepare_to_wait_event
             - 1.34% pipe_write
                  vfs_write
                  ksys_write
                  do_syscall_64
                  entry_SYSCALL_64
                  __GI___libc_write
                  write (inlined)
                  start_thread
       - 1.25% _raw_spin_lock
          - 1.25% raw_spin_rq_lock_nested
             - 0.95% __task_rq_lock
                - try_to_wake_up
                   - 0.95% autoremove_wake_function
                        __wake_up_common
                        __wake_up_sync_key
---
  

> 
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

Looking at the performance trend, I tried the following (possibly dumb)
experiment on top of mainline:

diff --git a/fs/pipe.c b/fs/pipe.c
index 82fede0f2111..43d827f99c55 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -395,6 +395,19 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
  		wake_next_reader = true;
  		mutex_lock(&pipe->mutex);
  	}
+
+	if (!wake_writer && !pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
+		/*
+		 * Proactively wake up writers if the pipe is not full.
+		 * This smp_mb() pairs with another barrier in ___wait_event(),
+		 * see more details in comments of waitqueue_active().
+		 */
+		smp_mb();
+
+		if (waitqueue_active(&pipe->wr_wait))
+			wake_writer = true;
+	}
+
  	if (pipe_empty(pipe->head, pipe->tail))
  		wake_next_reader = false;
  	mutex_unlock(&pipe->mutex);

base-commit: 05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5
--

and I see that the perfomance at lower utilization is closer to the
mainline whereas at higher utlization, it is close to that with this
patch reverted:

     ==================================================================
     Test          : sched-messaging
     Units         : Normalized time in seconds
     Interpretation: Lower is better
     Statistic     : AMean
     ==================================================================
     Case:         mainline[pct imp](CV)    revert[pct imp](CV)      patched[pct imp](CV)
      1-groups     1.00 [ -0.00](12.29)     1.26 [-25.91]( 2.71)     0.96 [  4.05]( 1.61)
      2-groups     1.00 [ -0.00]( 3.64)     1.39 [-38.53]( 0.89)     1.05 [ -5.26]( 0.93)
      4-groups     1.00 [ -0.00]( 3.33)     1.41 [-41.42]( 1.21)     1.04 [ -4.18]( 1.38)
      8-groups     1.00 [ -0.00]( 2.90)     1.10 [ -9.89]( 0.95)     0.84 [ 16.07]( 1.55)
     16-groups     1.00 [ -0.00]( 1.46)     0.66 [ 34.46]( 1.59)     0.50 [ 49.55]( 1.91)

The rationale was at higher utilization, perhaps there is a delay
in wakeup of writers from the time tail was moved but looking at all the
synchronization with "pipe->mutex", it is highly unlikely and I do not
have a good explanation for why this helps (or if it is even correct)

Following are some system-wide aggregates of schedstats on each
kernel running the 16-group variant collected using perf sched
stats [0]:

     sudo ./perf sched stats report #cord -- ./perf bench sched messaging -p -t -l 100000 -g 16

kernel                                                           :      mainline                         revert                          patched
runtime                                                          :     11.418s                           7.207s                           6.278s
sched_yield() count                                              :           0                                0                                0
Legacy counter can be ignored                                    :           0                                0                                0
schedule() called                                                :      402376                           403424                           172432
schedule() left the processor idle                               :      144622  (    35.94% )            142240  (    35.26% )             56732  (    32.90% )
try_to_wake_up() was called                                      :      237032                           241834                           101645
try_to_wake_up() was called to wake up the local cpu             :        1064  (     0.45% )             16656  (     6.89% )             12385  (    12.18% )
total runtime by tasks on this processor (in jiffies)            :  9072083005                       5516672721                       5105984838
total waittime by tasks on this processor (in jiffies)           :  4380309658  (    48.28% )        7304939649  (   132.42% )        6120940564  (   119.88% )
total timeslices run on this cpu                                 :      257644                           261129                           115628

[0] https://lore.kernel.org/lkml/20241122084452.1064968-1-swapnil.sapkal@amd.com/

The trend seems to be higher local CPU wakeups albeit with more wait time
but that diesn't seem to hurt the progress of sched-messaging.

>   	if (pipe_empty(pipe->head, pipe->tail))
>   		wake_next_reader = false;
>   	mutex_unlock(&pipe->mutex);
>   
> -	if (was_full)
> +	if (wake_writer)
>   		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
>   	if (wake_next_reader)
>   		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);

If you need any more information from my test setup, please do let me
know. All tests were run on a dual socket 3rd Generation EPYC system
(2 x 64C/128T) running in NPS1 mode with C2 disabled and boost enabled.

-- 
Thanks and Regards,
Prateek


