Return-Path: <linux-fsdevel+bounces-43545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A019A584D9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 15:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F25E188E7D5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF71D6DBC;
	Sun,  9 Mar 2025 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j7C9lnN0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D9026AF5;
	Sun,  9 Mar 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741528892; cv=fail; b=hMI2rZWiyH98gPiQ0Ur2LMjHTUetSUbX1N6zLYcyfBA7dK/WYPzm9Zj6B2oap/yFUjg5v23+FCpPfS9IC8UknSmUjgemG02PufFYV7IR+VJ3hNddYvPWUcvCru+FlveSMnUn6PHRDZ5zgPfS6t3sJQJqRe5f/vWMZH1TuS9lxcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741528892; c=relaxed/simple;
	bh=Fej1XoAR6hTBDllm7BQdvESMU6HskjNxhUeU1grgvW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t2etC6+iSW3RNXn6F9BJrYYlhAcnKoKFht82I1bVjQCKO/P/ppfPWdwqnuVSNILKYM03rDeEBtAGqIp+80Mkd9+VGaJAaHJxv9Bagmp9qKt8+1d/CusA9CdO24FLrhFE8DpwhACOb/758BBI86KVL8OIGsUfdEEKvpgBjN8eTqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j7C9lnN0; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Irt7NuAQ0borjD5esQ2BjlMH3q+bA0yBqUnnaeeMim8EvZjg2jve39O+2Gv21kxH9edszWufxf96PH4LRSoEUS3GGx3Qb5JHIosp1GRLi0QsMjZ5JpsWm+zZwRXMswV4z8i0pX0pKFeqDVBxfiyJBgLYRQDIKbWYUi4Yf9Kr5jg/77ZCmTl42VgDJXU6IcD+dztgZGPtUGg9xL4MNQJsqltB0rzIQIJgYwwMYCcrJU2ehA0LQ/F7R1HXLS7kkbJwRgZsyc73VN/bTHDbkDyPoMAXI5RNtcrDYBpRBiE3vgaOHjHjwyg+zSCQ5NVg34hxpPUgx13c/8yPx0KAbssOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X24fddzWG+stAjquIlBc/2cwgG1KeQiVWba4SVwYlB8=;
 b=ePlxNFgKqwywb0tns3MJTCh+mjY/uPtjwUOYhlkBael1pN5Ye0OthvW/bCuOmJllix9c3bIvK/8+AhQFCFpBjz1uaVkAN4tI8OsvWBqo0afonwGkySk5+jzwfDD5gkS08hOSP8HstgANRtVDiDdoWd8IPwR2XG5SpK3SxvCgI7l+VcN1CAsj5GvhfL3i2X6170ZVnQSPJw9JZ5Z2yvDpjIqUKNjtsxEmUNonA+xbThWwGS0V2EHhwU7YsB+dpOiUGKxYUgI7nVAX56qm1iCor1kiAVwxwfXyrca5MW0jVezh4Ju+xVKCb20b/kbCBEfVwmDB4LSwAAH4b+QBqUk1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=sina.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X24fddzWG+stAjquIlBc/2cwgG1KeQiVWba4SVwYlB8=;
 b=j7C9lnN0IHrrT99/PipKWcBfEhbJf9Y99ZDf5HWHHgRVj9e4OjJ3S3GxMCBTOaT3ES8wrU9DAA74dlf9HqXxS3JAMn6xRwHzlqz4vIIkjUwTfuFt7jVZyZsDYEulIu4QyyBfwhnQeNx8Natn1NKGYvoKbqwNgRLAMhcuNaYOJjA=
Received: from BN9PR03CA0807.namprd03.prod.outlook.com (2603:10b6:408:13f::32)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 14:01:22 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::86) by BN9PR03CA0807.outlook.office365.com
 (2603:10b6:408:13f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Sun,
 9 Mar 2025 14:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Sun, 9 Mar 2025 14:01:21 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 9 Mar
 2025 09:01:18 -0500
Message-ID: <deb24649-e19a-4117-a3ec-dd6f5ee52f48@amd.com>
Date: Sun, 9 Mar 2025 19:31:15 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Hillf Danton <hdanton@sina.com>, Oleg Nesterov <oleg@redhat.com>
CC: Mateusz Guzik <mjguzik@gmail.com>, "Sapkal, Swapnil"
	<swapnil.sapkal@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com> <20250304050644.2983-1-hdanton@sina.com>
 <20250304102934.2999-1-hdanton@sina.com>
 <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
 <20250307104654.3100-1-hdanton@sina.com> <20250307112920.GB5963@redhat.com>
 <20250307235645.3117-1-hdanton@sina.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250307235645.3117-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ab632c-283e-4c81-0d7f-08dd5f12deee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckVOSE1vMitxU2J5TGxBdEdVZjFUREtCZVhjOEVkcUdLYklTaDkxa0NSODEx?=
 =?utf-8?B?WlAxUFNBS1hnK2ZXVWp5a0xseEJnMExUb2tLbzR2K2Vyb3QwYzArcEl0OFYz?=
 =?utf-8?B?WEJpTjI4czc3NHBmSW9jQS9pMk4vR2pudnQ5RnpaQ09Hb3Z3dThiRjRrRU5r?=
 =?utf-8?B?REZEWGlveElycHhlRnhPUC9PUXdGUWlPb2huRzUyYlhSQm8vUnU2UWpabXFW?=
 =?utf-8?B?K2MxSzRKd0J2VVB5RnUyMTFaWUo3RHdXU2JlK0xhNkxpc2VvZVhkd2pxaVkx?=
 =?utf-8?B?MVUzVmF1NE92M294emRlWXZyTmFsKzBmTk12eGc1dVVWRVp0VjZBY1ZKSXBq?=
 =?utf-8?B?NmhFby95dlhQNjZqN0YvaGdRd0pRZC95RzZ6c2NPT0ZzTm5rRUhEaWhjaGRv?=
 =?utf-8?B?UG52UnhYclU0ME8wb3R3eVdFN2dxbXNLeWo2VWgwbnhSUU8xVklMMWRreEZH?=
 =?utf-8?B?RWNaSkZZMGV1QW8vUHhtcnJxR21FZUdWMVgvQkZVTmMwbHlsL2hhcWtjOVBa?=
 =?utf-8?B?S09aTjJmb0E2alhpd21QcmNsUmlqTTVHMXpld2ZRcmorRVR6RnZJRVpUMWls?=
 =?utf-8?B?R0NxQU82N2VPcUo0Q1IvUy9iSGU4T1l2NEUzb1l1R3ZJQVV2U2hreGgzbExV?=
 =?utf-8?B?M1kwc2dWQjN1eENxdityejF0SnNUM1ZMdHpuYXNNOXBHUVcvR0ZsT1ZGNDEz?=
 =?utf-8?B?MmdBMlY2TVNzOWloUWhlejdaMnNwUjVYaGZVZW9ZVlRBMlFnWlFEVWhQS1lX?=
 =?utf-8?B?L0cycHgzZTZxYjlJbmtLbFhIUCtKK1Z6WFIxZTlMMnNyTVIxRXhZSStJdklV?=
 =?utf-8?B?RFBKYXA2U3VZZy8wY2hvdkxjWC9DSVlvSzc2dDZKekoybnNUemxScmY2SXdj?=
 =?utf-8?B?SDF6SjN1ak50QVg5SzJiQ28yMGgwR3hpNUtNOE9FY2Y3UGtVMWJWNzc2YS9H?=
 =?utf-8?B?c1NNZGlKSWxTUzFTOTAvV3hGdm5semJCZjNLNTd4Y1Joa0RhdExVZ2RsRnZW?=
 =?utf-8?B?bWZ5S0krbEdIZlRIcmRkcnIxZmMvY0dsRkc5ajhKODBOeEV6Rk00MzI0ZENx?=
 =?utf-8?B?bVIrRWVFUnRsSHFXb21aL05sL1NINUdXZ2h3U1JSNmxtUHBKMkxER1FuWXJk?=
 =?utf-8?B?QWZ5YlpuSFZ0NXM0ZDNtMnBJT3hnUDBmQWN6V0FFNFBLdmpIV2thNVUyK1cy?=
 =?utf-8?B?SkpEREQxZXdrYVVRMHE2YmFINVlDdXd2dDF0TGdSV3JBRG1RQm5QRXhOZmhH?=
 =?utf-8?B?YmtnR2F5clFiKzErYXMxaFdxQ29iNTcvSDMvb0o2TU14V3Azams5bkxubTBY?=
 =?utf-8?B?TjYyQlA5bUhNdit0ak9pUWlUWHdyamRmdVFOOWdBeTFaamw2Z1REQXk0aHdT?=
 =?utf-8?B?YnhzUmd6NjFrcXlVdUZocThKZ3ljMHpKYmZZLzNpS0NEbnFwaFAvZWtUNTdl?=
 =?utf-8?B?dmtnaDhvVjIrOFg0VlAyL2RvbHlzNldyd2JFWE9EOU5JeTVqQTdKMWRhNXdP?=
 =?utf-8?B?UHV5V21NUmpsNmIzWXMrMi9GTnA0d2FvOUxyeWxYYm1VQ3BjMW5CRW9nUmdi?=
 =?utf-8?B?QzI5V2lEc25lL1V5SjZldHdUdWpzWlZEaHZoRWlxdUZuQjJSSlI4UXkrQUQw?=
 =?utf-8?B?dmlNUHRJOG1OQm5iNHFWemx6QTRML2c0RTUwbzMveU5wOXgrM0owN3Q3TzdW?=
 =?utf-8?B?QVdCT2svQ2FmRHBjRkpXRVBNRHZOdktZSkNCdGlMSStrVDgyZVNoY1RsWXk2?=
 =?utf-8?B?STZVRkVLcHZBSEc1VWlPTkN2d1Mxc1liT0lTQWk0WWpqZ1d6ZVo4dEF6cnRN?=
 =?utf-8?B?RVdQdzI1ekFIS096M0NlRDA4eEt5K1dBMm9tSW1OOWZxMWFXMzF2MnJKaUVo?=
 =?utf-8?B?NTJBKzlqb1FXSVF6a1R5TXRacHVxMUkrK2x5Y3EzRzlsTDg0NE1veTF2MTB1?=
 =?utf-8?B?R242WHpyNjVQV1FjYVBpYjNLUm0wTmZwcStjN3l3ZDVHZitoSTJrOFV1d0xF?=
 =?utf-8?Q?zp0/XO9ZAzqEHMi+5w17c3XLUs/2RY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 14:01:21.0202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ab632c-283e-4c81-0d7f-08dd5f12deee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

Hello Hillf,

On 3/8/2025 5:26 AM, Hillf Danton wrote:
> On Fri, 7 Mar 2025 13:34:43 +0100 Oleg Nesterov <oleg@redhat.com>
>> On 03/07, Oleg Nesterov wrote:
>>> On 03/07, Hillf Danton wrote:
>>>> On Fri, 7 Mar 2025 11:54:56 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
>>>>>> step-03
>>>>>> 	task-118766 new reader
>>>>>> 	makes pipe empty
>>>>>
>>>>> Reader seeing a pipe full should wake up a writer allowing 118768 to
>>>>> wakeup again and fill the pipe. Am I missing something?
>>>>>
>>>> Good catch, but that wakeup was cut off [2,3]
>>
>> Please note that "that wakeup" was _not_ removed by the patch below.
>>
> After another look, you did cut it.
> 
> Link: https://lore.kernel.org/all/20250209150718.GA17013@redhat.com/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

So that is not problematic because pipe_write() no longer increments the
head before a successful write. What also changed in that patch above is
the order in which we do copy_page_from_iter() and head increment - now,
the head is incremented only if copy_page_from_iter() actually manages to
write data into the buffer which eliminates the need to do a wakeup if
nothing was found in the buffer ...

> ---
>   fs/pipe.c | 45 +++++++++------------------------------------
>   1 file changed, 9 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 2ae75adfba64..b0641f75b1ba 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -360,29 +360,9 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)

Above this, we have:

	if (!total_len)
		break;	/* common path: read succeeded */
	if (!pipe_empty(head, tail))	/* More to do? */
		continue;

And if a read is successful, one of them must be hit and with that
reordering in pipe_write(), and the readers must be able to wake a
writer if !pipe_empty() ...

>   			break;
>   		}
>   		mutex_unlock(&pipe->mutex);
> -
>   		/*
>   		 * We only get here if we didn't actually read anything.
>   		 *
> -		 * However, we could have seen (and removed) a zero-sized
> -		 * pipe buffer, and might have made space in the buffers
> -		 * that way.
> -		 *
> -		 * You can't make zero-sized pipe buffers by doing an empty
> -		 * write (not even in packet mode), but they can happen if
> -		 * the writer gets an EFAULT when trying to fill a buffer
> -		 * that already got allocated and inserted in the buffer
> -		 * array.
> -		 *
> -		 * So we still need to wake up any pending writers in the
> -		 * _very_ unlikely case that the pipe was full, but we got
> -		 * no data.
> -		 */
> -		if (unlikely(wake_writer))
> -			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> -		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -
> -		/*
>   		 * But because we didn't read anything, at this point we can
>   		 * just return directly with -ERESTARTSYS if we're interrupted,
>   		 * since we've done any required wakeups and there's no need
> @@ -391,7 +371,6 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
>   			return -ERESTARTSYS;
>   
> -		wake_writer = false;
>   		wake_next_reader = true;
>   		mutex_lock(&pipe->mutex);
>   	}
> 
>> "That wakeup" is another wakeup pipe_read() does before return:
>>
>> 	if (wake_writer)
>> 		wake_up_interruptible_sync_poll(&pipe->wr_wait, ...);
>>
>> And wake_writer must be true if this reader changed the pipe_full()
>> condition from T to F.
>>
> Could you read Prateek's comment again, then try to work out why he
> did so?
> 
>> Note also that pipe_read() won't sleep if it has read even one byte.

and that is the key why Oleg's optimization that he highlighted above
which is why it cannot cause a hang (with my imagination). Now, let
us take a closer look at the whole sleep and wakeup mechanism. I'll
expand the one for pipe_write() since that was the problematic bit we
analyzed but you can do the same for pipe_read() side too. The

     wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));

in pipe_write() will boil down to these bits (I'll only highlight the
important ones):

     ret = 0;

     might_sleep()
     if (!pipe_writable()) { /* First line of defense */
         init_wait_entry(&__wq_entry, WQ_FLAG_EXCLUSIVE);

         for (;;) {
             /* Below is expansion of prepare_to_wait_event() success case*/
             spin_lock_irqsave(&wq_head->lock, flags);
             __add_wait_queue_entry_tail(wq_head, __wq_entry);
             set_current_state(TASK_INTERRUPTIBLE);
             spin_unlock_irqrestore(&wq_head->lock, flags);

             /* Second line of defense */
	    if (pipe_writable())
                 break;

             schedule();
         }
         finish_wait(&wq_head, &__wq_entry);
     ]
     return 0;


The sequence for the writer wait is:

o Add on the wait queue.
o Set task state to TASK_INTERRUPTIBLE.
o Check if pipe_writable() one last time.
o Call schedule()

Now why can't we miss a wakeup? The reader increments the tail, and then
does a wakeup of waiting writers in all cases it finds pipe_full().
Wakeup accesses a the wait queues which does:

     spin_lock_irqsave(&wq_head->lock, flags);
     __wake_up_common();
     spin_unlock_irqrestore(&wq_head->lock, flags);

so adding to wait queue and wakeup from wait queue are always done under
the wait queue lock.

Now there are two non trivial cases:

o This is the simple case:

                  writer                                                 reader
                  ======                                                 ======

if (!pipe_writable()) /* True */ {
     for (;;) {
         ...                                            wake_writers = pipe_full(); /* True */
                                                        tail = tail + 1
                                                        wake_up_interruptible_sync_poll(&pipe->wr_wait) {
                                                            /*wr_wait is empty */
                                                        }
         ...
         /* Adds itself on the wait queue */
         writer->__state = TASK_INTERRUPTIBLE;
         
         if (pipe_writable()) /* True */ {
             break;
             /*
              * Goes and does finish_wait()
              */
         }
     }

     finish_wait() {
         p->__state = TASK_RUNNING;
     }

     /*
      * Goes and does a check under
      * pipe->mutex to be sure.
      */
}

O This is slightly complicated case:

                  writer                                                 reader
                  ======                                                 ======
if (!pipe_writable()) /* True */ {
     for (;;) {
         /* Adds itself on the wait queue */
         writer->__state = TASK_INTERRUPTIBLE;
         if (pipe_writable()) /* False */ {
             /* The break is not executed */
         }
         ...                                            wake_writers = pipe_full(); /* True */
                                                        tail = tail + 1
                                                        wake_up_interruptible_sync_poll(&pipe->wr_wait) {
                                                            default_wake_function() {
                                                                ttwu_runnable() {
                                                                    /* Calls ttwu_do_wakeup() which does */
                                                                    p->__state = TASK_RUNNING
                                                                }
							   }
                                                        }
         ...
         schedule() {
             if (!p->__state) /* False */ {
                 /*
                  * Never called since p->__state
                  * is RUNNING
                  */
                 try_to_block_task();
             }
         }

         ... repeat the loop
         if (pipe_writable()) /* True */ {
             break;
             /*
              * Goes and does finish_wait()
              */
         }
     }

     finish_wait() {
         p->__state = TASK_RUNNING;
     }

     /*
      * Goes and does a check under
      * pipe->mutex to be sure.
      */
}

All in all, the writer will wither see a pipe_writable() and never fully
block, or it will be woken up it will add itself to the wit queue and
will be woken by a reader after moving pipe->tail if pipe_full()
returned true before. If I've missed something, please let me know and
I'll try to go back and convince myself on how that situation can happen
and get back to you but so far, my head cannot think of a situation
where the pipe can hang after the recent set of fixes and optimizations.

>>
>>>> [2] https://lore.kernel.org/lkml/20250304123457.GA25281@redhat.com/
>>>> [3] https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/
>>>
>>> Why do you think
>>>
>>> 	[PATCH v2 1/1] pipe: change pipe_write() to never add a zero-sized buffer
>>> 	https://lore.kernel.org/all/20250210114039.GA3588@redhat.com/
>>>
>>> can make any difference ???
>>>
>>> Where do you think a zero-sized buffer with ->len == 0 can come from?

I audited the post_one_notification() code and the paths that lead up
to it:

o remove_watch_from_object() will have the data of size watch_sizeof(n)
   so that beffer size is definitely !0 (unless (watch_sizeof(n) & 0x7f is
   zero but what are the odds of that?)

o Other is __post_watch_notification() which has a early return for

       ((n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT) == 0

    and also a WARN_ON() so it'll not add an empty buffer and will instead
    scream at the users if someone tries to do it.

splice() cases too cannot do this based on my understanding so I don't
think we can run into the issue but I'm limited by my own imagination :)

>>
>> Oleg.

-- 
Thanks and Regards,
Prateek


