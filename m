Return-Path: <linux-fsdevel+bounces-42940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1224A4C590
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40F2188CCEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195CF214A84;
	Mon,  3 Mar 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tCSBAFze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE77215192;
	Mon,  3 Mar 2025 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016787; cv=fail; b=vB5IBEY7MXOuRcG1/u9SpdebKg4xCihsVAC/Vzy3yJIFFD93WWTuiGWRDAninqB0a46BeT5KMrZho3adLjHHx2ycwjQ6TbViCGZMo5YJ9TABQm/rh8vnLcBPH3A+tpVx8yHk/CW/nADnZu3do558WP/XeWoDLi2G16U1r789VVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016787; c=relaxed/simple;
	bh=1BbSXrxecaJBWFJpPXvk7Dv6au9rTbnJQ3adw+m3FKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fOCWi9s6EceEkpqNepULkoB0CVJiIZzGEoTvJ9SwOUjkvbYMdbMVTKRnQumckeHRZuooR7f1nfaS2Sb5ExsFsquaIc5mlwb6egcOcXnsGoUvvqL0il0QpAe835xJFgig4s6Z97VBjabMcPirM6RCr6WnTLbx8z3+XevXL/QspEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tCSBAFze; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5OWVbTbYbMQCPOxWK/7M6g/zY3/obtccCmE5pkGQDtoScDiJZVgrJXlOMHZgpTR54FhnWVFL4kmCUFqtIV/4Jb9S9XV39QSOVk3+ttb9Jd/H7q5gWBvFldyGmaGJ77ElbIpkEKa61hp/jhGmgKFKoSFcoRHAAIYki32HX0jSnA8vCcemxOMTmEF2rppwa1lYL1ii1PnRqeU/hvW9X/0OTOnOwfKtIxp9el+ND051WiBZ6Ff+XnOEj6ybqWqtZjvDPKoxMTf/E2/I+y0DCg3wwzsjfhqCowyDooA+PpUE84z1y2m1qb5HyyvASwdJtqxTQCLSHS+C3QADxG3rzZ2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlsgxBQIQ0fAHUKXLYAvjTVXAhjWUZdW6h+Id416zqU=;
 b=TgtYh95XaDOXFiVpNwnmPvTomrooVn4aVs+bw6p852K2ikAPpRBBcme14EDC12zicboAbdbp89aMyCwfUigiqCUAMFYBN7WLR7ugQlqRG1L5Yi3UeBQmUpY37c1T5WFpaloV4mHQBnyhmWC6BshFwgOycPxgeZRX/lX+fT/t0C0NeQI2aOkf2yfyDNUasdKoA2M1MVz9DWw8gYusSRPnVv5eJIyeLiSZZvTM+2izR8+ufpLRmr414YIbQknlhqc+RNfptfN3WaDM2m5/1y72gg2CP+aQPvXUJxbY2HeleZymN1kC/cSAbUvmB21b43z6MNLmwZxCQypBLWzVO64q0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlsgxBQIQ0fAHUKXLYAvjTVXAhjWUZdW6h+Id416zqU=;
 b=tCSBAFze0MmWoBfy21H80XQYXOtUkeGZ1W5+WIgk9GQrNQeONajVmC5BUrQ/DxGPOCxeiBtCh2TVgvw207iKEI6yBj7tg+hRJ38gFqK4sr2KSFGCHwgKOmRerC05PtG2LNIpwd0mX8Ri5ZCwz+tYZYS8399LrcJM75k6N1Ov/7s=
Received: from SJ2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:a03:505::11)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 15:46:19 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::82) by SJ2PR07CA0001.outlook.office365.com
 (2603:10b6:a03:505::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 15:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 15:46:18 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 09:46:13 -0600
Message-ID: <30d35796-4687-440e-845f-b015d52fa4f0@amd.com>
Date: Mon, 3 Mar 2025 21:16:08 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Alexey Gladkov <legion@kernel.org>, Oleg Nesterov <oleg@redhat.com>
CC: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul
	<manfred@colorfullife.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com> <20250225115736.GA18523@redhat.com>
 <Z8Wn0nTvevLRG_4m@example.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <Z8Wn0nTvevLRG_4m@example.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: dea755f2-47c1-4e2a-8db1-08dd5a6a89e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFRjN1lrTHRFWGRvTFZSWkRFNTBhaFlZU3JBQnRnVDloUkQ2SnU1OUJmRWF4?=
 =?utf-8?B?TVpzUHNxajV3ck1aWnl3MzQwbkRWQ3JyblU1K1RwVi8vTS9CRGZ5dUxISUtK?=
 =?utf-8?B?Q0t4MldmeU5kZmpVdCsyODNCRUhhcWxWcURZY2NCaTJXdHRtMXUvSHdiQWVm?=
 =?utf-8?B?bFZSL2JRcitpQkxiak5ZMTJhU2ZPY096RmJtc1VVKzBFeGFmbGZrVGdqMExm?=
 =?utf-8?B?R1AxZWdIV2lhaUt2UlJ6azRNU2tUcmhzVU1yMjBJbGkwL1JmYndLU0g5QUJD?=
 =?utf-8?B?OU8zS0FmWXQ0ZjFkWjgwd2lYeVYwRFNmMWZRbmpScENFSmdodytqZTF1dFNw?=
 =?utf-8?B?RldWSTN1K0NleHV6YVNZUVJyeUo1eXRtVDFOQ3hBYi8xeWMxY0VlcFBOaXRE?=
 =?utf-8?B?TVk3RGkza0cwbXc2dGJSenI4ZUlrOVArN0ttWnVRMStON2NrM2U3ZytLN1JH?=
 =?utf-8?B?SUFZR3dtOTJqZDBKeXNIMHA1Qll6cFV3U2Z4eHp4RzN2NUtLeU5sZWFQNmY0?=
 =?utf-8?B?ejJZb0N2ZUFrUlJ4Y25Fb1lvWmUvSEk4MFgzYTVVNmFENGNlZlZRenJNQ1Zp?=
 =?utf-8?B?dUpQVGVlQmZIRWpLQVBSWFJlOCtyY1BZK2phMzFXbjVIWEgrVTJCT2JKYksz?=
 =?utf-8?B?dUo4QjZjc3lyc2Nsb1JiYlVhTElxYjRDdFV3K0xKS3FJcGRVdzAvNFZpd3Z2?=
 =?utf-8?B?NVVKYkxISENrY0xWQnp3a0ZFSUZFSlFVa085TzhPU3YrODBQQnQzbnZIUVda?=
 =?utf-8?B?NlRaa01JS2RZSXBPUUhhSUNtWXBWZkVHK3dhUmRhMlkxejJDY3RaSzJIclBH?=
 =?utf-8?B?SHRCZmMrUjlwQ1F4L3BGcEg4L2dJaU5CY3Z1S3NVaVZlYjhZdDF0QjRRUFhY?=
 =?utf-8?B?VE43djgzeGR5aDd2MFdINnMrTzZZc0ZOSTI0cm1VckVLNkVQNVFiL3kyOW1E?=
 =?utf-8?B?cXZ4Ujl3UVNMVUp6SFJ4K2xINUltZXZYUmVESTE4d1hyU2llUmdnVEx6amVV?=
 =?utf-8?B?MFpsZFZ5ZlAxRjFlVWFtbXJRSmc4QzlXM2xZSjBBbDBjNmxmRnZCOUZOaHRw?=
 =?utf-8?B?VXBqUHlqZk5LWEEwdVBqV3l0cnJ4NlVlc1E5dFFrTnNTeG5odzZ5bExoVHJu?=
 =?utf-8?B?NzlNU0xBWHFLZW91dWJVOFFidGgycUlOeGdUOEE0RFFCSGpvSVlEOWN0QXVE?=
 =?utf-8?B?bFJLekh5RjN3aG81eFF0WURlaE1scWViNUl1VXBzQU9QLzlSQ3kvYXpEL3BF?=
 =?utf-8?B?aC9mTFlyY3pLNStTYmtZeGszOGtTSnJkSm9XR2lsOCs4d1F5RTd0V3RJdytt?=
 =?utf-8?B?cUZ0SU1yY2ZEbGltZGtycHdRRWFpVURqTEpjWExwbk5kZnB3TExxM3ltTFVx?=
 =?utf-8?B?cDFBSzlMZWpWaThVWlRIa1RkYkRhYzlKekhxVjN1YTdhS2VEb1hQVzh2VVQ1?=
 =?utf-8?B?a0JEcWVLSkVyWmhTMEVUcEtlYzRTT3Z3bDJISWdTdkMvQXpjU0k1VnFtcWpo?=
 =?utf-8?B?eC8reHgva25qM1FyMm9nTFBhME94V2lHeEVLaGU3VXpDazlvUERGWWd5K1cx?=
 =?utf-8?B?ck9mWjFyQ3ViazRzSEhzc1AzVFpOcGpEd2U2N2VYR0FKYTVLQ0IwOWt2Q0F6?=
 =?utf-8?B?QU5zZ2tHWUlQbU9YZXVmQm1SNC9vT1V5d2RDNG1vSG12eTROK0V0YVVBb0xQ?=
 =?utf-8?B?RHljN1J3UHc0VEd6Zys2b2I4N1RQYnhOb1hhQ1ZJaGRhUzIzTUppTjVLT2Fs?=
 =?utf-8?B?RTVlZDkyRDVrR01BcmY2cHhsNFFUL21rK3dRTnlJUlpOZ2w3T0JJbVpqTDg0?=
 =?utf-8?B?T3pPYk92QTFrRFFGSkdFU3duVEVjcVIrcnVPcVJtUndueE05UUthbG9neHdO?=
 =?utf-8?B?UFpHVWcyNVR1UkkxYlZpcVVDdE5heGNqbTJvbWZZNHM2a1BabDZwU0VYWGw3?=
 =?utf-8?B?YVlja1paRURwUVMrNVU5UUxzNDZTN1UraGJ5M1ZOQlpDQXhwaWc4QWpQb0th?=
 =?utf-8?Q?Rc+SHV7g1l9f/f2KWYIQPN2USMHQSs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:46:18.1447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea755f2-47c1-4e2a-8db1-08dd5a6a89e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

Hello Legion,

On 3/3/2025 6:30 PM, Alexey Gladkov wrote:
> On Tue, Feb 25, 2025 at 12:57:37PM +0100, Oleg Nesterov wrote:
>> On 02/24, Oleg Nesterov wrote:
>>>
>>> Just in case, did you use
>>>
>>> 	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/hackbench/hackbench.c
>>>
>>> ?
>>
>> Or did you use another version?
>>
>> Exactly what parameters did you use?
>>
>> If possible, please reproduce the hang again. How many threads/processes
>> sleeping in pipe_read() or pipe_write() do you see? (you can look at
>> /proc/$pid/stack).
>>
>> Please pick one sleeping writer, and do
>>
>> 	$ strace -p pidof_that_write
>>
>> this should wake this writer up. If a missed wakeup is the only problem,
>> hackbench should continue.
>>
>> The more info you can provide the better ;)
> 
> I was also able to reproduce the hackbench hang with the parameters
> mentioned earlier (threads and processes) on the kernel from master.
> 

Thank you for reporting your observations!

If you are able to reproduce it reliably, could you please give the
below diff posted by Swapnil from the parallel thread [1] a try:

diff --git a/fs/pipe.c b/fs/pipe.c
index ce1af7592780..a1931c817822 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -417,9 +417,19 @@ static inline int is_packetized(struct file *file)
  /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
  static inline bool pipe_writable(const struct pipe_inode_info *pipe)
  {
-    unsigned int head = READ_ONCE(pipe->head);
-    unsigned int tail = READ_ONCE(pipe->tail);
      unsigned int max_usage = READ_ONCE(pipe->max_usage);
+    unsigned int head, tail;
+
+    tail = READ_ONCE(pipe->tail);
+    /*
+     * Since the unsigned arithmetic in this lockless preemptible context
+     * relies on the fact that the tail can never be ahead of head, read
+     * the head after the tail to ensure we've not missed any updates to
+     * the head. Reordering the reads can cause wraparounds and give the
+     * illusion that the pipe is full.
+     */
+    smp_rmb();
+    head = READ_ONCE(pipe->head);
  
      return !pipe_full(head, tail, max_usage) ||
          !READ_ONCE(pipe->readers);
---

We've been running hackbench for a while now with the above diff and we
haven't run into a hang yet. Sorry for the troubles and thank you again.

[1] https://lore.kernel.org/all/03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com/

-- 
Thanks and Regards,
Prateek


