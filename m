Return-Path: <linux-fsdevel+bounces-42923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58AFA4BB1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 10:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51868171268
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1271F0E5C;
	Mon,  3 Mar 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z13i4+Bp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F41EB1AF;
	Mon,  3 Mar 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995217; cv=fail; b=kgJyCbIBnG4tmqm3fvSbfDC1zgYQRfylwYegP61bWC5WXgDHosDXFdccnpsuE9j67LgsNiDNl1YvPFjCObc3xRdZyNI+2LWUPVudvyyq4qCfex9huzoInQdexCAdd0go+Jqer46uyspliFzGDpVWwwZZBSV1URVnvYc0WDT+vT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995217; c=relaxed/simple;
	bh=T58R3cUqO0v5QQ5T5El6gcP93zyxP850zlHGFFUTtZ8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=j4lqiSfMoUmUDmkhV1VmLeapi9YZ9eWudGSLKdDKklgReCqhVW5gnbJeIz5ndhqprLTMe4bsm8PR8vF4eOEJ0BtYo2y0byLUyAMg+OEs68ReKrWQCMwqSvvmglb2mGy0ZU8qHYRiENUZy4ssqgI7BnpzJ9u4zNiVKckckQfBrFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z13i4+Bp; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2tCO+wQzf2nQU+3yzisTO8jVaVCscGsBySIg+lRlSO/f01Av9amrDKf+7JMeaPAmNbati3HeIqmbJBCfK7yQjt8jzn+7/aPt+fY/oRhUTv+1lOt6wNYCf6AzVu37s8EzePALq++9n2CU7chQ2keCieuurJhXxwcea/aD+TqjGvvZGH/ReGHUDsXRsIiOiJOl6kzoMgxhaKfFRCiiP5UlM3IFIbOVpqyXCGShrq6vkmAdkIUo/AvvahvNPbd+QnzmixaoNdVIGJh2au0yXUIXhYyCLZzCflx+JNwkNdn4Uk2KfzE8lwm1NjHxr+4mfwaiUe+AUAu/DXB6r7g1zdxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL5ZnYkVgvQN84WBg8zcF8zu3BlnDtwCCnXxPMfbdEs=;
 b=KX7DlADEhy9/1kBeISFQEFml9+gcwKfmtiDcNUCHOg/wGjDkCY9PwDGJH6CncR3JcjG6LzWtaXsWwWZtkWX/1S4FtdMYUYOk1xo6JvHu3ReEGQC4jWqqljm52zWv6QM/Brrw/0qwydEtSm0o76nptd/SiXau9s51yGtO3nrY2v1VQNTNeHbClUmmeI6bCO8eODftgzZ6sGUwmo7NmAIZef1mWuWzGncGbEpldn/ZGN7lHQwKWTITw5pg5dhpSir1ezxMipJRAKdXRw2jvZib0u0T1CwLJlrH/w73Bzu2C7C6KvdVE4Fyv50fvlQ97350EYqy1OXhuOlLf6q8aYJT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL5ZnYkVgvQN84WBg8zcF8zu3BlnDtwCCnXxPMfbdEs=;
 b=Z13i4+BpOkINxQxHqFsg56IcbQxAk7v9ecV3F+2qTqd2oME/odR2Gn52ll5YCP+cA+sAB3WTA/i3/dKmO7WKGIgB5D+UTtqQC7oXqzrbQQ8RgrzyzkhLj+N2UObQ2jVdO/Q9ZQpx1JfqV4B1Au6jTyFooQvuZuhJVJyFVzi4JXE=
Received: from MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 09:46:50 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::72) by MN2PR20CA0066.outlook.office365.com
 (2603:10b6:208:235::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Mon,
 3 Mar 2025 09:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 09:46:50 +0000
Received: from [10.252.216.136] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 03:46:46 -0600
Content-Type: multipart/mixed;
	boundary="------------5VrYAH7SbZij67knriX0bMJB"
Message-ID: <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
Date: Mon, 3 Mar 2025 15:16:34 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Oleg Nesterov <oleg@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>
CC: Mateusz Guzik <mjguzik@gmail.com>, Manfred Spraul
	<manfred@colorfullife.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>, <Ananth.narayan@amd.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20250228163347.GB17761@redhat.com>
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: a79623a4-baba-448e-d424-08dd5a38527b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V25JU05na1V1bk4zSkNjeEg2aHBadzB1Rm9xZFVHSTVrdk9MdmpXZWtaM290?=
 =?utf-8?B?VDhIZWREYzlxTVg4bWlUc0pCT2tXcEM5WmJFbXE4SzZHYjFwZmVkV3dRQita?=
 =?utf-8?B?L2NEVS95RFR4Nnp6ekpMS2RGdjFucVBBM0ZnSWlFZzczRnVCdmVTRmJUdFRC?=
 =?utf-8?B?dFJ2RDJGL09qUVo1SmFoOUF2UGR0OU15eTFPcWNOSCtyaTFCNjFJakJ1aW9v?=
 =?utf-8?B?Q1ZPY29ZcTF3bGVidkFXYXNyb3I3akNycjNzeGU2TmJrdlJCdDlNdmFmeHlw?=
 =?utf-8?B?aXFVamJMQzlHekM3RGxnN1EvVGZnQkpRQUFqdFJIa29ZUXJmRlZXUnV1MkFJ?=
 =?utf-8?B?alNqdzFqZ2NWa2JlelZGVGJmSjFJQURwMHo3Y3pjSGZpOVNBNVp0YjRnSEJL?=
 =?utf-8?B?SVJmQ09CY1RyRFNNU2g0UkNrWGNOcGgvb09manpmNjAzNE1MMWxGRXM4U0h1?=
 =?utf-8?B?SlMvbW9vaVk5NDBHaDhBbWhhby9HM01kZmNlY3BlYlN5bURDUmJaRXhwQ0Zt?=
 =?utf-8?B?MjhWNEZkR0FxL01DYTdzV29oL2ZGRCtvd3dQaTJjZEk5WWpLN25UMnhBTlcw?=
 =?utf-8?B?NzIvcmRxL3dXaloyd200WnIxanRieEJPc0JtTkV0U0FWSXhNNW1WVHFaMTdP?=
 =?utf-8?B?ZWYvYnlEc2RQNTQ5THY3Z3ViRzFXZWplWnl3Mzk0d3VBYmQ4Rno4eVgyY2xY?=
 =?utf-8?B?Q3pLZzU0U1NUdk93bUxmdEhYRG0xMGp2Ulo3Tm84eEpZODhUVFhtRVJqM3Zq?=
 =?utf-8?B?ZGFjZFZTekhQWUJhdkNqL0JFT2d4R2MwU0J5ZzE2NnRLQSt6aFA3YUVlTFlP?=
 =?utf-8?B?eklQd1pCcTU2Q252QjNQVmpBMGxGQXNPZEN1UWlyQzRpNnFPa1FuMzVsMU9B?=
 =?utf-8?B?ZzI0TG1vZ0FRSERWb2N3WjJmT0pMQ3JZUjJHa1gxQmlEUDdiTkdzUE9zRU5T?=
 =?utf-8?B?N29rdmZSYm9mUlNvLzFsNGYrRzNsc1Y4Mk51cUN2WDd1NDNVUmpmcXFVN2JB?=
 =?utf-8?B?YUJDSFVCTEM1Mk9VTHlTZm1MM1BZNWtPVUcrdGFiZUVtZ2RkMVBVY1kyRVpM?=
 =?utf-8?B?WHYwdFR1ZDVRQnlmb0ppN1JPN0liWDVNakZobWIxQXFjNTdwOWdraWRzbFBx?=
 =?utf-8?B?bWN3SjhSL0tCbzJhM0FXREdyY1Z6NEVwZmhZbCtIc1BmckZLaWNEdVRDVC9U?=
 =?utf-8?B?NFZ0NmJvR3V4MmV0RFlQNURZR05nVDRldUlpR2xRUE4zZTY1OFJRbmUrR1hK?=
 =?utf-8?B?SjNueUJtR3pJM2dkYXdFcnByRy9vZFRTdm1RRERVeEcwZE5kZFY0Z2Fvd0ZS?=
 =?utf-8?B?Vmh0c0VYaXhJQ3lDTHg5ZUFqai91bUxRcjF1aThNTTlSTU1BdjJwdVNoaW1X?=
 =?utf-8?B?UHliOWthcnJ5UnU4Zzh6akt4Y08xbHhhQjNpL084UVJCWkZ1UWFNcThsajVE?=
 =?utf-8?B?TnViVmk4bEs2NVJWd2VacncvVk9WclFMYjc4N2ZhYXdCQ0tnNVJieUZVSEI1?=
 =?utf-8?B?aWJLV2xqUUdiNVpIYjAwUTVJb3FNL1p5TjJ0UFBxZHFDNFVBbmN2dGVyTDV0?=
 =?utf-8?B?YnFvYTFhYVVLU09WbitIUzdBWDY1T0g4cERjMHRvZ3FGUmM1em9BZ0xLYi9L?=
 =?utf-8?B?SUhDQ0lzZFkrRWNON2NvNHd3VnVYc2ZXanpHOVhWSDZkcE9HZDhPS1J3UFFR?=
 =?utf-8?B?WFVyd2xVSEQ3MXpGQ2t4NFNNeHpXUTR1cTlOTW9HSFlBcVhOb1NGQVB3THRv?=
 =?utf-8?B?RDdVQXphOTJhRWVSa3VIRWlQTDBodWZLQXJWQWRtK2R4YkF3RXBUVGo4RWtx?=
 =?utf-8?B?cjhnODdkSmNIZ1duRjNLQTFJQ0RYeFRBaTlURllJOWpPNVdRb1NGVkRvcnFY?=
 =?utf-8?B?NXA2c1g4YW1DOEJ2YmoycW9KNG1GQTlJMTlFSEphdnJVUGJiNVpTc1d5bnhQ?=
 =?utf-8?B?TncvZXZmRVBOdnZNcVdQUDloeHFlenNwN0ZiOFVwL0kxL1hQVElOaFNaUGcr?=
 =?utf-8?Q?GcuXmeeMzYWykAhxbUA01cV3FJ8PZE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(4053099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:46:50.4525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79623a4-baba-448e-d424-08dd5a38527b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962

--------------5VrYAH7SbZij67knriX0bMJB
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oleg,

On 2/28/2025 10:03 PM, Oleg Nesterov wrote:
> And... I know, I know you already hate me ;)
> 

Not at all :)

> but if you have time, could you check if this patch (with or without the
> previous debugging patch) makes any difference? Just to be sure.
> 

Sure, I will give this a try.

But in the meanwhile me and Prateek tried some of the experiments in the weekend.
We were able to reproduce this issue on a third generation EPYC system as well as
on an Intel Emerald Rapids (2 X INTEL(R) XEON(R) PLATINUM 8592+).

We tried heavy hammered tracing approach over the weekend on top of your debug patch.
I have attached the debug patch below. With tracing we found the following case for
pipe_writable():

   hackbench-118768  [206] .....  1029.550601: pipe_write: 000000005eea28ff: 0: 37 38 16: 1

Here,

head = 37
tail = 38
max_usage = 16
pipe_full() returns 1.

Between reading of head and later the tail, the tail seems to have moved ahead of the
head leading to wraparound. Applying the following changes I have not yet run into a
hang on the original machine where I first saw it:

diff --git a/fs/pipe.c b/fs/pipe.c
index ce1af7592780..a1931c817822 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -417,9 +417,19 @@ static inline int is_packetized(struct file *file)
  /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
  static inline bool pipe_writable(const struct pipe_inode_info *pipe)
  {
-	unsigned int head = READ_ONCE(pipe->head);
-	unsigned int tail = READ_ONCE(pipe->tail);
  	unsigned int max_usage = READ_ONCE(pipe->max_usage);
+	unsigned int head, tail;
+
+	tail = READ_ONCE(pipe->tail);
+	/*
+	 * Since the unsigned arithmetic in this lockless preemptible context
+	 * relies on the fact that the tail can never be ahead of head, read
+	 * the head after the tail to ensure we've not missed any updates to
+	 * the head. Reordering the reads can cause wraparounds and give the
+	 * illusion that the pipe is full.
+	 */
+	smp_rmb();
+	head = READ_ONCE(pipe->head);
  
  	return !pipe_full(head, tail, max_usage) ||
  		!READ_ONCE(pipe->readers);
---

smp_rmb() on x86 is a nop and even without the barrier we were not able to
reproduce the hang even after 10000 iterations.

If you think this is a genuine bug fix, I will send a patch for this.

Thanks to Prateek who was actively involved in this debug.

--
Thanks and Regards,
Swapnil

> Oleg.
> ---
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 4336b8cccf84..524b8845523e 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -445,7 +445,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>   		return 0;
>   
>   	mutex_lock(&pipe->mutex);
> -
> +again:
>   	if (!pipe->readers) {
>   		send_sig(SIGPIPE, current, 0);
>   		ret = -EPIPE;
> @@ -467,20 +467,24 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
>   		unsigned int mask = pipe->ring_size - 1;
>   		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
>   		int offset = buf->offset + buf->len;
> +		int xxx;
>   
>   		if ((buf->flags & PIPE_BUF_FLAG_CAN_MERGE) &&
>   		    offset + chars <= PAGE_SIZE) {
> -			ret = pipe_buf_confirm(pipe, buf);
> -			if (ret)
> +			xxx = pipe_buf_confirm(pipe, buf);
> +			if (xxx) {
> +				if (!ret) ret = xxx;
>   				goto out;
> +			}
>   
> -			ret = copy_page_from_iter(buf->page, offset, chars, from);
> -			if (unlikely(ret < chars)) {
> -				ret = -EFAULT;
> +			xxx = copy_page_from_iter(buf->page, offset, chars, from);
> +			if (unlikely(xxx < chars)) {
> +				if (!ret) ret = -EFAULT;
>   				goto out;
>   			}
>   
> -			buf->len += ret;
> +			ret += xxx;
> +			buf->len += xxx;
>   			if (!iov_iter_count(from))
>   				goto out;
>   		}
> @@ -567,6 +571,7 @@ atomic_inc(&WR_SLEEP);
>   		mutex_lock(&pipe->mutex);
>   		was_empty = pipe_empty(pipe->head, pipe->tail);
>   		wake_next_writer = true;
> +		goto again;
>   	}
>   out:
>   	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
> 

--------------5VrYAH7SbZij67knriX0bMJB
Content-Type: text/plain; charset="UTF-8"; name="debug.diff"
Content-Disposition: attachment; filename="debug.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL3BpcGUuYyBiL2ZzL3BpcGUuYwppbmRleCA4MmZlZGUwZjIxMTEu
LmEwYjczN2E4YjhmOSAxMDA2NDQKLS0tIGEvZnMvcGlwZS5jCisrKyBiL2ZzL3BpcGUuYwpA
QCAtMjE3LDYgKzIxNywyMCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcGlwZV9yZWFkYWJsZShj
b25zdCBzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlKQogCXJldHVybiAhcGlwZV9lbXB0
eShoZWFkLCB0YWlsKSB8fCAhd3JpdGVyczsKIH0KIAorLyogRG9uZSB3aGlsZSB3YWl0aW5n
IHdpdGhvdXQgaG9sZGluZyB0aGUgcGlwZSBsb2NrIC0gdGh1cyB0aGUgUkVBRF9PTkNFKCkg
Ki8KK3N0YXRpYyBpbmxpbmUgYm9vbCBwaXBlX3JlYWRhYmxlX3NsZWVwX2NoZWNrKGNvbnN0
IHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUpCit7CisJdW5zaWduZWQgaW50IGhlYWQg
PSBSRUFEX09OQ0UocGlwZS0+aGVhZCk7CisJdW5zaWduZWQgaW50IHRhaWwgPSBSRUFEX09O
Q0UocGlwZS0+dGFpbCk7CisJdW5zaWduZWQgaW50IHdyaXRlcnMgPSBSRUFEX09OQ0UocGlw
ZS0+d3JpdGVycyk7CisJYm9vbCBlbXB0eSA9IHBpcGVfZW1wdHkoaGVhZCwgdGFpbCk7CisJ
Ym9vbCByZXQgPSAhZW1wdHkgfHwgIXdyaXRlcnM7CisKKwl0cmFjZV9wcmludGsoIiVwOiAl
ZDogJXUgJXU6ICVkXG4iLCAodm9pZCopcGlwZSwgcmV0LCBoZWFkLCB0YWlsLCBlbXB0eSk7
CisKKwlyZXR1cm4gcmV0OworfQorCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBwaXBl
X3VwZGF0ZV90YWlsKHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUsCiAJCQkJCSAgICBz
dHJ1Y3QgcGlwZV9idWZmZXIgKmJ1ZiwKIAkJCQkJICAgIHVuc2lnbmVkIGludCB0YWlsKQpA
QCAtMjQzLDYgKzI1Nyw3IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHBpcGVfdXBk
YXRlX3RhaWwoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwKIAkgKiBXaXRob3V0IGEg
d2F0Y2hfcXVldWUsIHdlIGNhbiBzaW1wbHkgaW5jcmVtZW50IHRoZSB0YWlsCiAJICogd2l0
aG91dCB0aGUgc3BpbmxvY2sgLSB0aGUgbXV0ZXggaXMgZW5vdWdoLgogCSAqLworCXRyYWNl
X3ByaW50aygiJXA6IHQ6ICV1IC0+ICV1XG4iLCAodm9pZCopcGlwZSwgcGlwZS0+dGFpbCwg
cGlwZS0+dGFpbCArIDEpOwogCXBpcGUtPnRhaWwgPSArK3RhaWw7CiAJcmV0dXJuIHRhaWw7
CiB9CkBAIC0zODgsNyArNDAzLDcgQEAgcGlwZV9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwg
c3RydWN0IGlvdl9pdGVyICp0bykKIAkJICogc2luY2Ugd2UndmUgZG9uZSBhbnkgcmVxdWly
ZWQgd2FrZXVwcyBhbmQgdGhlcmUncyBubyBuZWVkCiAJCSAqIHRvIG1hcmsgYW55dGhpbmcg
YWNjZXNzZWQuIEFuZCB3ZSd2ZSBkcm9wcGVkIHRoZSBsb2NrLgogCQkgKi8KLQkJaWYgKHdh
aXRfZXZlbnRfaW50ZXJydXB0aWJsZV9leGNsdXNpdmUocGlwZS0+cmRfd2FpdCwgcGlwZV9y
ZWFkYWJsZShwaXBlKSkgPCAwKQorCQlpZiAod2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX2V4
Y2x1c2l2ZShwaXBlLT5yZF93YWl0LCBwaXBlX3JlYWRhYmxlX3NsZWVwX2NoZWNrKHBpcGUp
KSA8IDApCiAJCQlyZXR1cm4gLUVSRVNUQVJUU1lTOwogCiAJCXdha2Vfd3JpdGVyID0gZmFs
c2U7CkBAIC0zOTcsNiArNDEyLDggQEAgcGlwZV9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwg
c3RydWN0IGlvdl9pdGVyICp0bykKIAl9CiAJaWYgKHBpcGVfZW1wdHkocGlwZS0+aGVhZCwg
cGlwZS0+dGFpbCkpCiAJCXdha2VfbmV4dF9yZWFkZXIgPSBmYWxzZTsKKwlpZiAocmV0ID4g
MCkKKwkJcGlwZS0+cl9jbnQrKzsKIAltdXRleF91bmxvY2soJnBpcGUtPm11dGV4KTsKIAog
CWlmICh3YWtlX3dyaXRlcikKQEAgLTQyNSw2ICs0NDIsMTkgQEAgc3RhdGljIGlubGluZSBi
b29sIHBpcGVfd3JpdGFibGUoY29uc3Qgc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSkK
IAkJIVJFQURfT05DRShwaXBlLT5yZWFkZXJzKTsKIH0KIAorLyogRG9uZSB3aGlsZSB3YWl0
aW5nIHdpdGhvdXQgaG9sZGluZyB0aGUgcGlwZSBsb2NrIC0gdGh1cyB0aGUgUkVBRF9PTkNF
KCkgKi8KK3N0YXRpYyBpbmxpbmUgYm9vbCBwaXBlX3dyaXRhYmxlX3NsZWVwX2NoZWNrKGNv
bnN0IHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUpCit7CisJdW5zaWduZWQgaW50IGhl
YWQgPSBSRUFEX09OQ0UocGlwZS0+aGVhZCk7CisJdW5zaWduZWQgaW50IHRhaWwgPSBSRUFE
X09OQ0UocGlwZS0+dGFpbCk7CisJdW5zaWduZWQgaW50IG1heF91c2FnZSA9IFJFQURfT05D
RShwaXBlLT5tYXhfdXNhZ2UpOworCWJvb2wgZnVsbCA9IHBpcGVfZnVsbChoZWFkLCB0YWls
LCBtYXhfdXNhZ2UpOworCWJvb2wgcmV0ID0gIWZ1bGwgfHwgIVJFQURfT05DRShwaXBlLT5y
ZWFkZXJzKTsKKworCXRyYWNlX3ByaW50aygiJXA6ICVkOiAldSAldSAldTogJWRcbiIsICh2
b2lkKilwaXBlLCByZXQsIGhlYWQsIHRhaWwsIG1heF91c2FnZSwgZnVsbCk7CisJcmV0dXJu
IHJldDsKK30KKwogc3RhdGljIHNzaXplX3QKIHBpcGVfd3JpdGUoc3RydWN0IGtpb2NiICpp
b2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20pCiB7CkBAIC00OTAsNiArNTIwLDcgQEAgcGlw
ZV93cml0ZShzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSkKIAkJ
CX0KIAogCQkJYnVmLT5sZW4gKz0gcmV0OworCQkJdHJhY2VfcHJpbnRrKCIlcDogbTogJXVc
biIsICh2b2lkKilwaXBlLCBoZWFkKTsKIAkJCWlmICghaW92X2l0ZXJfY291bnQoZnJvbSkp
CiAJCQkJZ290byBvdXQ7CiAJCX0KQEAgLTUyNSw2ICs1NTYsNyBAQCBwaXBlX3dyaXRlKHN0
cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQogCQkJICogYmUgdGhl
cmUgZm9yIHRoZSBuZXh0IHdyaXRlLgogCQkJICovCiAJCQlwaXBlLT5oZWFkID0gaGVhZCAr
IDE7CisJCQl0cmFjZV9wcmludGsoIiVwOiBoOiAldSAtPiAldVxuIiwgKHZvaWQqKXBpcGUs
IGhlYWQsIGhlYWQgKyAxKTsKIAogCQkJLyogSW5zZXJ0IGl0IGludG8gdGhlIGJ1ZmZlciBh
cnJheSAqLwogCQkJYnVmID0gJnBpcGUtPmJ1ZnNbaGVhZCAmIG1hc2tdOwpAQCAtNTc3LDcg
KzYwOSw3IEBAIHBpcGVfd3JpdGUoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0
ZXIgKmZyb20pCiAJCWlmICh3YXNfZW1wdHkpCiAJCQl3YWtlX3VwX2ludGVycnVwdGlibGVf
c3luY19wb2xsKCZwaXBlLT5yZF93YWl0LCBFUE9MTElOIHwgRVBPTExSRE5PUk0pOwogCQlr
aWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMsIFNJR0lPLCBQT0xMX0lOKTsKLQkJ
d2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX2V4Y2x1c2l2ZShwaXBlLT53cl93YWl0LCBwaXBl
X3dyaXRhYmxlKHBpcGUpKTsKKwkJd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX2V4Y2x1c2l2
ZShwaXBlLT53cl93YWl0LCBwaXBlX3dyaXRhYmxlX3NsZWVwX2NoZWNrKHBpcGUpKTsKIAkJ
bXV0ZXhfbG9jaygmcGlwZS0+bXV0ZXgpOwogCQl3YXNfZW1wdHkgPSBwaXBlX2VtcHR5KHBp
cGUtPmhlYWQsIHBpcGUtPnRhaWwpOwogCQl3YWtlX25leHRfd3JpdGVyID0gdHJ1ZTsKQEAg
LTU4NSw2ICs2MTcsOCBAQCBwaXBlX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0
IGlvdl9pdGVyICpmcm9tKQogb3V0OgogCWlmIChwaXBlX2Z1bGwocGlwZS0+aGVhZCwgcGlw
ZS0+dGFpbCwgcGlwZS0+bWF4X3VzYWdlKSkKIAkJd2FrZV9uZXh0X3dyaXRlciA9IGZhbHNl
OworCWlmIChyZXQgPiAwKQorCQlwaXBlLT53X2NudCsrOwogCW11dGV4X3VubG9jaygmcGlw
ZS0+bXV0ZXgpOwogCiAJLyoKQEAgLTcwNSw2ICs3MzksNTAgQEAgcGlwZV9wb2xsKHN0cnVj
dCBmaWxlICpmaWxwLCBwb2xsX3RhYmxlICp3YWl0KQogCXJldHVybiBtYXNrOwogfQogCitz
dGF0aWMgREVGSU5FX01VVEVYKFBJX01VVEVYKTsKK3N0YXRpYyBMSVNUX0hFQUQoUElfTElT
VCk7CisKK3ZvaWQgcGlfZHVtcCh2b2lkKTsKK3ZvaWQgcGlfZHVtcCh2b2lkKQoreworCXN0
cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGU7CisKKwlwcl9jcml0KCItLS0tLS0tLS0tIERV
TVAgU1RBUlQgLS0tLS0tLS0tLVxuIik7CisJbXV0ZXhfbG9jaygmUElfTVVURVgpOworCWxp
c3RfZm9yX2VhY2hfZW50cnkocGlwZSwgJlBJX0xJU1QsIHBpX2xpc3QpIHsKKwkJdW5zaWdu
ZWQgaGVhZCwgdGFpbDsKKworCQltdXRleF9sb2NrKCZwaXBlLT5tdXRleCk7CisJCWhlYWQg
PSBwaXBlLT5oZWFkOworCQl0YWlsID0gcGlwZS0+dGFpbDsKKwkJcHJfY3JpdCgiaW5vZGU6
ICVwXG4iLCAodm9pZCopcGlwZSk7CisJCXByX2NyaXQoIkU9JWQgRj0lZDsgVz0lZCBSPSVk
XG4iLAorCQkJcGlwZV9lbXB0eShoZWFkLCB0YWlsKSwgcGlwZV9mdWxsKGhlYWQsIHRhaWws
IHBpcGUtPm1heF91c2FnZSksCisJCQlwaXBlLT53X2NudCwgcGlwZS0+cl9jbnQpOworCisv
LyBJTkNPTVBMRVRFCitwcl9jcml0KCJSRD0lZCBXUj0lZFxuIiwgd2FpdHF1ZXVlX2FjdGl2
ZSgmcGlwZS0+cmRfd2FpdCksIHdhaXRxdWV1ZV9hY3RpdmUoJnBpcGUtPndyX3dhaXQpKTsK
KworCQlpZiAocGlwZV9lbXB0eShoZWFkLCB0YWlsKSAmJiB3YWl0cXVldWVfYWN0aXZlKCZw
aXBlLT5yZF93YWl0KSAmJiB3YWl0cXVldWVfYWN0aXZlKCZwaXBlLT53cl93YWl0KSkgewor
CQkJcHJfY3JpdCgiUkQgd2FpdGVyczpcbiIpOworCQkJX193YWl0X3F1ZXVlX3RyYXZlcnNl
X3ByaW50X3Rhc2tzKCZwaXBlLT5yZF93YWl0KTsKKwkJCXByX2NyaXQoIldSIHdhaXRlcnM6
XG4iKTsKKwkJCV9fd2FpdF9xdWV1ZV90cmF2ZXJzZV9wcmludF90YXNrcygmcGlwZS0+d3Jf
d2FpdCk7CisJCX0KKworCQlmb3IgKDsgdGFpbCA8IGhlYWQ7IHRhaWwrKykgeworCQkJc3Ry
dWN0IHBpcGVfYnVmZmVyICpidWYgPSBwaXBlX2J1ZihwaXBlLCB0YWlsKTsKKwkJCVdBUk5f
T04oYnVmLT5vcHMgIT0gJmFub25fcGlwZV9idWZfb3BzKTsKKwkJCXByX2NyaXQoImJ1Zjog
bz0lZCBsPSVkXG4iLCBidWYtPm9mZnNldCwgYnVmLT5sZW4pOworCQl9CisJCXByX2NyaXQo
IlxuIik7CisKKwkJbXV0ZXhfdW5sb2NrKCZwaXBlLT5tdXRleCk7CisJfQorCW11dGV4X3Vu
bG9jaygmUElfTVVURVgpOworCXByX2NyaXQoIi0tLS0tLS0tLS0gRFVNUCBFTkQgLS0tLS0t
LS0tLS0tXG4iKTsKK30KKwogc3RhdGljIHZvaWQgcHV0X3BpcGVfaW5mbyhzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlKQogewogCWludCBraWxs
ID0gMDsKQEAgLTcxNiw4ICs3OTQsMTQgQEAgc3RhdGljIHZvaWQgcHV0X3BpcGVfaW5mbyhz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlKQogCX0K
IAlzcGluX3VubG9jaygmaW5vZGUtPmlfbG9jayk7CiAKLQlpZiAoa2lsbCkKKwlpZiAoa2ls
bCkgeworCQlpZiAoIWxpc3RfZW1wdHkoJnBpcGUtPnBpX2xpc3QpKSB7CisJCQltdXRleF9s
b2NrKCZQSV9NVVRFWCk7CisJCQlsaXN0X2RlbF9pbml0KCZwaXBlLT5waV9saXN0KTsKKwkJ
CW11dGV4X3VubG9jaygmUElfTVVURVgpOworCQl9CiAJCWZyZWVfcGlwZV9pbmZvKHBpcGUp
OworCX0KIH0KIAogc3RhdGljIGludApAQCAtODAwLDYgKzg4NCwxMyBAQCBzdHJ1Y3QgcGlw
ZV9pbm9kZV9pbmZvICphbGxvY19waXBlX2luZm8odm9pZCkKIAlpZiAocGlwZSA9PSBOVUxM
KQogCQlnb3RvIG91dF9mcmVlX3VpZDsKIAorCUlOSVRfTElTVF9IRUFEKCZwaXBlLT5waV9s
aXN0KTsKKwlpZiAoIXN0cmNtcChjdXJyZW50LT5jb21tLCAiaGFja2JlbmNoIikpIHsKKwkJ
bXV0ZXhfbG9jaygmUElfTVVURVgpOworCQlsaXN0X2FkZF90YWlsKCZwaXBlLT5waV9saXN0
LCAmUElfTElTVCk7CisJCW11dGV4X3VubG9jaygmUElfTVVURVgpOworCX0KKwogCWlmIChw
aXBlX2J1ZnMgKiBQQUdFX1NJWkUgPiBtYXhfc2l6ZSAmJiAhY2FwYWJsZShDQVBfU1lTX1JF
U09VUkNFKSkKIAkJcGlwZV9idWZzID0gbWF4X3NpemUgPj4gUEFHRV9TSElGVDsKIApkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9waXBlX2ZzX2kuaCBiL2luY2x1ZGUvbGludXgvcGlw
ZV9mc19pLmgKaW5kZXggOGZmMjNiZjVhODE5Li40OGQ5YmY1MTcxZGMgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvbGludXgvcGlwZV9mc19pLmgKKysrIGIvaW5jbHVkZS9saW51eC9waXBlX2Zz
X2kuaApAQCAtODAsNiArODAsOSBAQCBzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvIHsKICNpZmRl
ZiBDT05GSUdfV0FUQ0hfUVVFVUUKIAlzdHJ1Y3Qgd2F0Y2hfcXVldWUgKndhdGNoX3F1ZXVl
OwogI2VuZGlmCisKKwlzdHJ1Y3QgbGlzdF9oZWFkIHBpX2xpc3Q7CisJdW5zaWduZWQgd19j
bnQsIHJfY250OwogfTsKIAogLyoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvd2FpdC5o
IGIvaW5jbHVkZS9saW51eC93YWl0LmgKaW5kZXggNmQ5MGFkOTc0NDA4Li4yYzM3NTE3ZjZh
MDUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvd2FpdC5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvd2FpdC5oCkBAIC0yMTUsNiArMjE1LDcgQEAgdm9pZCBfX3dha2VfdXBfbG9ja2VkX3N5
bmNfa2V5KHN0cnVjdCB3YWl0X3F1ZXVlX2hlYWQgKndxX2hlYWQsIHVuc2lnbmVkIGludCBt
b2QKIHZvaWQgX193YWtlX3VwX2xvY2tlZChzdHJ1Y3Qgd2FpdF9xdWV1ZV9oZWFkICp3cV9o
ZWFkLCB1bnNpZ25lZCBpbnQgbW9kZSwgaW50IG5yKTsKIHZvaWQgX193YWtlX3VwX3N5bmMo
c3RydWN0IHdhaXRfcXVldWVfaGVhZCAqd3FfaGVhZCwgdW5zaWduZWQgaW50IG1vZGUpOwog
dm9pZCBfX3dha2VfdXBfcG9sbGZyZWUoc3RydWN0IHdhaXRfcXVldWVfaGVhZCAqd3FfaGVh
ZCk7Cit2b2lkIF9fd2FpdF9xdWV1ZV90cmF2ZXJzZV9wcmludF90YXNrcyhzdHJ1Y3Qgd2Fp
dF9xdWV1ZV9oZWFkICp3cV9oZWFkKTsKIAogI2RlZmluZSB3YWtlX3VwKHgpCQkJX193YWtl
X3VwKHgsIFRBU0tfTk9STUFMLCAxLCBOVUxMKQogI2RlZmluZSB3YWtlX3VwX25yKHgsIG5y
KQkJX193YWtlX3VwKHgsIFRBU0tfTk9STUFMLCBuciwgTlVMTCkKZGlmZiAtLWdpdCBhL2tl
cm5lbC9zY2hlZC93YWl0LmMgYi9rZXJuZWwvc2NoZWQvd2FpdC5jCmluZGV4IDUxZTM4ZjVm
NDcwMS4uOGYzM2RhODdhMjE5IDEwMDY0NAotLS0gYS9rZXJuZWwvc2NoZWQvd2FpdC5jCisr
KyBiL2tlcm5lbC9zY2hlZC93YWl0LmMKQEAgLTE3NCw2ICsxNzQsMjkgQEAgdm9pZCBfX3dh
a2VfdXBfc3luY19rZXkoc3RydWN0IHdhaXRfcXVldWVfaGVhZCAqd3FfaGVhZCwgdW5zaWdu
ZWQgaW50IG1vZGUsCiB9CiBFWFBPUlRfU1lNQk9MX0dQTChfX3dha2VfdXBfc3luY19rZXkp
OwogCit2b2lkIF9fd2FpdF9xdWV1ZV90cmF2ZXJzZV9wcmludF90YXNrcyhzdHJ1Y3Qgd2Fp
dF9xdWV1ZV9oZWFkICp3cV9oZWFkKQoreworCXdhaXRfcXVldWVfZW50cnlfdCAqY3Vyciwg
Km5leHQ7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKKworCWlmICh1bmxpa2VseSghd3FfaGVh
ZCkpCisJCXJldHVybjsKKworCXNwaW5fbG9ja19pcnFzYXZlKCZ3cV9oZWFkLT5sb2NrLCBm
bGFncyk7CisJY3VyciA9IGxpc3RfZmlyc3RfZW50cnkoJndxX2hlYWQtPmhlYWQsIHdhaXRf
cXVldWVfZW50cnlfdCwgZW50cnkpOworCisJaWYgKCZjdXJyLT5lbnRyeSA9PSAmd3FfaGVh
ZC0+aGVhZCkKKwkJcmV0dXJuOworCisJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlX2Zyb20o
Y3VyciwgbmV4dCwgJndxX2hlYWQtPmhlYWQsIGVudHJ5KSB7CisJCXN0cnVjdCB0YXNrX3N0
cnVjdCAqdHNrID0gIChzdHJ1Y3QgdGFza19zdHJ1Y3QgKiljdXJyLT5wcml2YXRlOworCisJ
CXByX2NyaXQoIiVkKCVzKVxuIiwgdHNrLT5waWQsIHRzay0+Y29tbSk7CisJfQorCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJndxX2hlYWQtPmxvY2ssIGZsYWdzKTsKK30KK0VYUE9SVF9T
WU1CT0xfR1BMKF9fd2FpdF9xdWV1ZV90cmF2ZXJzZV9wcmludF90YXNrcyk7CisKIC8qKgog
ICogX193YWtlX3VwX2xvY2tlZF9zeW5jX2tleSAtIHdha2UgdXAgYSB0aHJlYWQgYmxvY2tl
ZCBvbiBhIGxvY2tlZCB3YWl0cXVldWUuCiAgKiBAd3FfaGVhZDogdGhlIHdhaXRxdWV1ZQpk
aWZmIC0tZ2l0IGEva2VybmVsL3N5cy5jIGIva2VybmVsL3N5cy5jCmluZGV4IGM0YzcwMWM2
ZjBiNC4uNjc2ZTYyM2Q0OTFkIDEwMDY0NAotLS0gYS9rZXJuZWwvc3lzLmMKKysrIGIva2Vy
bmVsL3N5cy5jCkBAIC0yNDc3LDYgKzI0NzcsMTEgQEAgU1lTQ0FMTF9ERUZJTkU1KHByY3Rs
LCBpbnQsIG9wdGlvbiwgdW5zaWduZWQgbG9uZywgYXJnMiwgdW5zaWduZWQgbG9uZywgYXJn
MywKIAogCWVycm9yID0gMDsKIAlzd2l0Y2ggKG9wdGlvbikgeworCWNhc2UgNjY2OiB7CisJ
CWV4dGVybiB2b2lkIHBpX2R1bXAodm9pZCk7CisJCXBpX2R1bXAoKTsKKwkJYnJlYWs7CisJ
fQogCWNhc2UgUFJfU0VUX1BERUFUSFNJRzoKIAkJaWYgKCF2YWxpZF9zaWduYWwoYXJnMikp
IHsKIAkJCWVycm9yID0gLUVJTlZBTDsK

--------------5VrYAH7SbZij67knriX0bMJB--

