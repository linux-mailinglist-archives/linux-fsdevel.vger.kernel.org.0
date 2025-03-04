Return-Path: <linux-fsdevel+bounces-43035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3277FA4D30B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC8188E608
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 05:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D31F3B8A;
	Tue,  4 Mar 2025 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IRuvPAZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0179F5;
	Tue,  4 Mar 2025 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066578; cv=fail; b=icJVtOLxRUHXRjuiaC3tshQ5gDo5Vaq5GahaO/FylYziaOTxaIUA/vdKtnOAtIBqb0cfK+l5Rza2Oy6103IaQmRRSOpUwnuep2DAzYnsEWafDmCeOTkDJDIzMUKl8iwj8tAukRYBjsMeqwCyTqbMgG3j42Mka2l4Y63lkZlyONQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066578; c=relaxed/simple;
	bh=Tm+lgYaUHH+mm9DXpohK9tfctnVpbTb1NGvZTHlXLBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jv/NFZgcCE5mpMiU8ONqVSpARsWBlEUpKLbVXmtHTFnsaEfCYCfZRl6RUIV7Jr1OysfJIKSShbs+ZldqV3gQG4PBt0f3HUYvLxvUQ9NoYONZL3E5FEGe4rVwqVnw43GpX8KOzN+ZLYeNS2mUDPnP5/xcO29y15mV5qHE3sPODI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IRuvPAZN; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2KjxIp2D5iIn7Aaz4q38UJcTO1Jt1xngJF3yFJO6oQ2pUFLGXmG5fq01T/vBijtj4IzDZCLv8P9j/fuOPbiUrgMx11iW5qrvQE4xnf3TkM1rPKiCfB3vhZlvLkIm0cFSK2D/SlKPxv92LkVrLretI7cJmZaVN+20gJVleLqMZKzAgKdJ8WvV/N0Oi+ezwNL2fgC8/HJewKR8Y/qPoOt1GhXNk5HEvPcAqI5o8YL31wrmsZy7MuGd60/6JvmkHdFQOlFEzquwDldIosQyNdnuyji2rEvD+iHoJu/hQQJ8OZ7DgJo1QyqJA46k56vdRjlWlSjRzwH9f/wQ64geAl8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxMYT1sDwLjr3kCwojn6t5lQml+V8pWBp6jtoHv/eCE=;
 b=Qac7+gE4v5uEodQWNOg2Wx0rFyazF1p4qI+Nlz6vXSlWxv9TmwPuBteB6Hj04q4X4PTdNO/hCwx+I5X1S8uu/Uk1IcxQPKJP7EaNoqJ3aasG4hoxYerqhZL0AN+tnkI/286tM3CM/IafD/SAbU8pyy/pmehlKA2q93uWeb/zA08bvtvTF1Hgq9p/V1DCvkfuz7+S+FPLtvJRXdGV2Gm2iIZgOlEl23f7UQJJoL8q9+GgOD1edWwEca7zXsIKMpWpeuAaCE+qeu8kn2GDIx+PAIKOwx1rVcgLWM2BtKWLj5cX4Btr/KROSjAegBql4OThGFh57MuAWcRCxUi8UDWjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sina.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxMYT1sDwLjr3kCwojn6t5lQml+V8pWBp6jtoHv/eCE=;
 b=IRuvPAZNxfhhM1GL5glINa5L74DhOc9U8ErHn5lic2s51KZq5gwobEBBEmloFyg1tRXRdecShHibT1PpuiFMWeVdcFtDahGKN3hY2vGHp614Z9T3qq5AzJqTzbHq43SdTohBN0jLFVjrmuz5NfunFxXnTovNENMo1dqe2iev+oo=
Received: from CH5PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:1ed::9)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 05:36:12 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::40) by CH5PR02CA0015.outlook.office365.com
 (2603:10b6:610:1ed::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Tue,
 4 Mar 2025 05:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 05:36:10 +0000
Received: from [10.136.44.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 23:36:06 -0600
Message-ID: <0d17fc70-01a8-43b4-aec6-5cede5c8f7ba@amd.com>
Date: Tue, 4 Mar 2025 11:05:57 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Hillf Danton <hdanton@sina.com>, "Sapkal, Swapnil"
	<swapnil.sapkal@amd.com>
CC: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
 <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <20250304050644.2983-1-hdanton@sina.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250304050644.2983-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 428ae5c9-c08c-49a8-f1a6-08dd5ade785e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TndiNlNoS2RiaUh4NTVpcmYzb3owMDBNSmplSkViUTFlakVZUFZLcXVyZkV1?=
 =?utf-8?B?V3pKb3dTcGQzbTdMVWxuSmNQUGZHMlpVQmllak9aMXVPbmgzSWUvV0IwakNZ?=
 =?utf-8?B?eUFCZ1RmZURKd3hvdVJlcElnOFpDN0ViK1pMQ09tMnlBS3F3Y3paKzU5cWcx?=
 =?utf-8?B?bHFTSk5wYWFRQVdpdllvQ2RPRTVOcWZINzdXeE1WZnh1aXBuVkp2K2hiWW02?=
 =?utf-8?B?UW11RjY2ZzVnYzdObTlRREZnVUxCZVhlUHI1dWZHYk8rV1VRVWRnYWVjRHk0?=
 =?utf-8?B?bjU4eVdiT2RDdURWNUFIOEJFcThVNC9ZWFE1NzJWMjNLS3d2a1NqZHhCTE1o?=
 =?utf-8?B?M244UzhsVjJWNUtVYkJzbXBNR1BaUXB5NVpyR0FOS1pSN0svTlJKelhHYVBk?=
 =?utf-8?B?eEJ2ejRUZEZhQWdLY1ZjdFVnb2Y1VWU2ZVBGeEo2czI3Y29OdnJxUWpCTjUw?=
 =?utf-8?B?UmlzTkZ6N1RLVUVGZ3J1MmFJR2RRdEIrUTc2UkZDZWFjR1Y0dGFqbHVTMEZM?=
 =?utf-8?B?R3BDa012c2Fyb3JRamMvSkU0OGw1WFJLdUIxSlhlT0hoWjNsbmpkRVB5YjFp?=
 =?utf-8?B?b3g0SUh6bjgrdVV4U2hIOTQ5ZlFzWDlLY3p0SlFwZTRsc2hKNTBMaWdOMUcw?=
 =?utf-8?B?c2daZWF2RGttMTRqUkRpcjB4NnFOVzNpOGY4ZlFaQWhndWdYMzZ5cG9VaHZq?=
 =?utf-8?B?eTQxRGQ2OXZ0UGdLQmFSMTR4MUFtMUNxL05qN0FhNkhMWitLckpzaG9JcGhw?=
 =?utf-8?B?OVd6M2tVcUh5Z04ybmViWkJxRGVrVEZ5TEpNQXJERm8zRWdVT0hTMzg3Qkh5?=
 =?utf-8?B?V09maWQwNkE2ZWE0R0MrRXQzbDZON2dZa294TU9IbWlGZm1oS1IzdlAyc3Fn?=
 =?utf-8?B?c2Q2SnVPaXVrT005MnRoV2pQaHk3dFRHbFJJbVBWYmc0MUcwbFF1YWZRY3dQ?=
 =?utf-8?B?QzVuQ09zdDZ2Yk8xMVdBWW1IZ01iOEZ6c3NmbEdDTE1mUXlJUEFYcmNJclpl?=
 =?utf-8?B?cmh0SGx6V1hnbVNXeTMzYnI0SFZWRUpmR0QyT1FWRTVia0UvaTVpS3g5VG5R?=
 =?utf-8?B?VVFkNlR0QncrbUpvanBadGZiQ0U2SUdlOVZzdGdXZWRSV2J2TFFqem9uQmxy?=
 =?utf-8?B?bGtvbFYzeEtqY05xZngxcCtXQXphNmxra3h3aitWaGg0R0RsUTZMancxUmxQ?=
 =?utf-8?B?RzBQV0pVejJVaVdlTDNMZEF5WmVlcm1jMGtUUWRDSzlJR1Q2a21ZWG5LOUxj?=
 =?utf-8?B?WDRVWjRwa2pGOUpQeDJaazZ4ckxhWHRsUGdwdWI1eGI1M2RGYlFTb2FRK0dK?=
 =?utf-8?B?VjFtc0Jjd1cxZ0VEbUx0OHMzclNrWHM2Nng1VzdtUS9NalQ2QVFiS2ZBZDBs?=
 =?utf-8?B?dWlUY0k4MWI2OFhXTUQwaDlXQy8yTHcrWW1wNDVFVGtpV2JYOWxpVzd0T2lU?=
 =?utf-8?B?azRWYzRSa2J3UmVYSkJUcjdLc2tNenVvc0t0U25CcjFPY1Y1d01YQyttMTVK?=
 =?utf-8?B?MHg0aHdyQjQvQ3lkNDFkeS93NS85UEw4MkFlNyt6NmNodUFOakROcDM5MHZV?=
 =?utf-8?B?SHdqUWxsL1NIQW1rQVZPTCt6MFRqcEhlYXJQeHZibnZnOFVYTU9BQ3ZTM0Vi?=
 =?utf-8?B?RC9UYkYvUExoZC9IaTRrYWMzUUpmdWh4MCtGc1E2MytldTVRQ09RZytrL1Zn?=
 =?utf-8?B?ay9JTTI1VVBPTkdCVUNsaElxQ3Uwa2ZHN1A4Q25vTDJzZEdLOXZ6TmphTmQ2?=
 =?utf-8?B?UXhtV2RwcWZEdi9ac2dkMUJrb1Y5ekdoc1VGbWZIcDZ6SDhGekpzR1kzN0Ju?=
 =?utf-8?B?OXROak4rUVNKa1I0Uk5XeWUveW5RUkxlNFptR2NyUUpZZkI4NmVNUENNRVh0?=
 =?utf-8?B?eG9NN1dVRWE2SG1ZbDZ3ZnNWVEZNMXgyYWxBOW02clh4UTR6aEwzTit5SlVt?=
 =?utf-8?B?dEFKVGJFRTBBTElOZzdFT2xrTmhQUUFodHBvWGRiTTdvVHdaSjRWakY2VDZL?=
 =?utf-8?Q?kVsCGOPXiGy5NKiVJwQYXEMKNg4gZk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:36:10.4423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428ae5c9-c08c-49a8-f1a6-08dd5ade785e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603

Hello Hillf,

On 3/4/2025 10:36 AM, Hillf Danton wrote:
> On Mon, 3 Mar 2025 15:16:34 +0530 "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
>> On 2/28/2025 10:03 PM, Oleg Nesterov wrote:
>>> And... I know, I know you already hate me ;)
>>>
>>
>> Not at all :)
>>
>>> but if you have time, could you check if this patch (with or without the
>>> previous debugging patch) makes any difference? Just to be sure.
>>>
>>
>> Sure, I will give this a try.
>>
>> But in the meanwhile me and Prateek tried some of the experiments in the weekend.
>> We were able to reproduce this issue on a third generation EPYC system as well as
>> on an Intel Emerald Rapids (2 X INTEL(R) XEON(R) PLATINUM 8592+).
>>
>> We tried heavy hammered tracing approach over the weekend on top of your debug patch.
>> I have attached the debug patch below. With tracing we found the following case for
>> pipe_writable():
>>
>>     hackbench-118768  [206] .....  1029.550601: pipe_write: 000000005eea28ff: 0: 37 38 16: 1
>>
>> Here,
>>
>> head = 37
>> tail = 38
>> max_usage = 16
>> pipe_full() returns 1.
>>
>> Between reading of head and later the tail, the tail seems to have moved ahead of the
>> head leading to wraparound. Applying the following changes I have not yet run into a
>> hang on the original machine where I first saw it:
>>
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index ce1af7592780..a1931c817822 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -417,9 +417,19 @@ static inline int is_packetized(struct file *file)
>>    /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
>>    static inline bool pipe_writable(const struct pipe_inode_info *pipe)
>>    {
>> -	unsigned int head = READ_ONCE(pipe->head);
>> -	unsigned int tail = READ_ONCE(pipe->tail);
>>    	unsigned int max_usage = READ_ONCE(pipe->max_usage);
>> +	unsigned int head, tail;
>> +
>> +	tail = READ_ONCE(pipe->tail);
>> +	/*
>> +	 * Since the unsigned arithmetic in this lockless preemptible context
>> +	 * relies on the fact that the tail can never be ahead of head, read
>> +	 * the head after the tail to ensure we've not missed any updates to
>> +	 * the head. Reordering the reads can cause wraparounds and give the
>> +	 * illusion that the pipe is full.
>> +	 */
>> +	smp_rmb();
>> +	head = READ_ONCE(pipe->head);
>>    
>>    	return !pipe_full(head, tail, max_usage) ||
>>    		!READ_ONCE(pipe->readers);
>> ---
>>
>> smp_rmb() on x86 is a nop and even without the barrier we were not able to
>> reproduce the hang even after 10000 iterations.
>>
> My $.02 that changes the wait condition.
> Not sure it makes sense for you.
> 
> --- x/fs/pipe.c
> +++ y/fs/pipe.c
> @@ -430,7 +430,7 @@ pipe_write(struct kiocb *iocb, struct io
>   {
>   	struct file *filp = iocb->ki_filp;
>   	struct pipe_inode_info *pipe = filp->private_data;
> -	unsigned int head;
> +	unsigned int head, tail;
>   	ssize_t ret = 0;
>   	size_t total_len = iov_iter_count(from);
>   	ssize_t chars;
> @@ -573,11 +573,13 @@ pipe_write(struct kiocb *iocb, struct io
>   		 * after waiting we need to re-check whether the pipe
>   		 * become empty while we dropped the lock.
>   		 */
> +		tail = pipe->tail;
>   		mutex_unlock(&pipe->mutex);
>   		if (was_empty)
>   			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>   		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> -		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
> +		wait_event_interruptible_exclusive(pipe->wr_wait,
> +				!READ_ONCE(pipe->readers) || tail != READ_ONCE(pipe->tail));

That could work too for the case highlighted but in case the head too
has moved by the time the writer wakes up, it'll lead to an extra
wakeup.

Linus' diff seems cleaner and seems to cover all racy scenarios.

>   		mutex_lock(&pipe->mutex);
>   		was_empty = pipe_empty(pipe->head, pipe->tail);
>   		wake_next_writer = true;
> --

-- 
Thanks and Regards,
Prateek


