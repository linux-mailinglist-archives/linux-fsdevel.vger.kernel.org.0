Return-Path: <linux-fsdevel+bounces-42762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 396F8A484EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D8D189B8FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800BD1B422A;
	Thu, 27 Feb 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fz9tQmxa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944A1A8403;
	Thu, 27 Feb 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673241; cv=fail; b=syNUavjtH+ttAi0LquwtRKBrwlWbgyEq5syJwyowZyeUOSuUZCB8XQsANNGvtnJ0S7uysJEHDaQqo/m4kmqGsclK+F5h6Ws9i6CIhzgQ7c1H2esUt7NyXIbOo5vo+sTKA3QQFVk8r58UbII9pRjQIluOUP5IvXCDntY7mJ41ApE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673241; c=relaxed/simple;
	bh=3TsceqaR5I5yk/4CilUi297s/7rilmdKORCYqlFXhRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fy8l3/xOYSMYt/LzcjY0rNR6Ak48V+0To5LPdOaDmYATgqtuTeVU11t49C9T4RlPx13Q0HjnCz/czYggPq63h+5AYXQT2y/p1JJ3sHiV1ek9cT3EYoM54dQKHJEvlqJsN33hCZfbro2ICMFS/XnL00Khx9c5/T1q1cuEbmX5r+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fz9tQmxa; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl9NOeJAheHCceKboNMTIBafqfyiWIG+PxuFzQ7efCeL6iP07fHK5em7/h/2amQ09bHMsIIKXQJ/xU9eznN0hsBMGPal8BKVT/B0R4x8Gu9bqre+jTRi1VdQh+NAHBwMKlrwOdhTH5v4je4MHLcXqzxgPoVFmO3XQsrKhXcVGB0yb+IM1jEkKx0VBCATwhLVjlOldSnKoErqJAyKprEB9DmSSkne+31FiYYOmffdM54ulcRm4amBsPS14H7liqTcciN0lLcbo8OwKrwdu/Rmhsdk021FwJidhvkiwWX5wUrjiyocq4h8zIeS8xrFYFNXXDXnBQM5HYjBa7h5wcG5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmAStuCXR1np7JmFFJZaeoWQ3pR2KCrnz4RT09+IZYQ=;
 b=DhutbMI834aD+iJNZBKaqxD135g7bPoAId2k7fVtt0B19+G5h1jPJnm6Tp8VpxS2Zjaao/9ntaulAyyrUNpi9CAAo+Aa/Tr0qA0Ouk8rE2PfUOynSk3Ofn/x9nsp34sUQQ+WC960gSevMTiacMTj8eZqCkt9BQvZIm/RHN55LUFnxs0RBW0ZTQSmVU18Yl+w/lrAzagRFp+p0H7nkRo36shgp3+gUsr/N1Hq0aGLhgEr8Pw209ZJdyPVtm/mcfiuWKjSoDs4wiNt4L1iENYRqzCQVrbJkRf08sH7F84f6X5qeN2us5++KtmJ4z6ic0im0oU3eYjTgSPEVTIIrmm4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmAStuCXR1np7JmFFJZaeoWQ3pR2KCrnz4RT09+IZYQ=;
 b=Fz9tQmxatyJRsGLGlGbSmeN8bU+EWkO1zwiAdJUev/BVqhMFn1p4CSWK7TK4noarfwKNbuxRlvJN9YHFtPl0mSfbYlzoDycmxclET3KHSfLbzYNqlZr8/pe7TxWTNWCTOqWf2JO0QuvNOGXFM4ja8C8J/QN2m+U1C1m2KMInzmQ=
Received: from BYAPR07CA0030.namprd07.prod.outlook.com (2603:10b6:a02:bc::43)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 16:20:36 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::5d) by BYAPR07CA0030.outlook.office365.com
 (2603:10b6:a02:bc::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Thu,
 27 Feb 2025 16:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:20:35 +0000
Received: from [10.252.195.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 10:18:51 -0600
Message-ID: <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
Date: Thu, 27 Feb 2025 21:48:25 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Mateusz Guzik <mjguzik@gmail.com>, Oleg Nesterov <oleg@redhat.com>
CC: Manfred Spraul <manfred@colorfullife.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b6dc31-1b4a-48a8-7915-08dd574aaa63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0hKc3QxS21LbUs5b2VyZEVoZlcvY1hqUUloQ05VdFF5SGhXenhWUmRrb1V5?=
 =?utf-8?B?aDRhaUg4YTAyelBScDQxOHZaN0dzck13Y0tvYnNNdVhBVnJFU3VsUUZVZ05m?=
 =?utf-8?B?RGZGWE83dk5pemh4WDUzUkkxMURFbmVGZGNEdDFrYlVmMFZPclAwU0tjUjRi?=
 =?utf-8?B?QnVrZXNLOHZMbmVyRUtaT292M1JCWERMMHVneEJ3STVVQmMrSjlDNER2ak1w?=
 =?utf-8?B?NkM1NU44ZDV6ZEVOMjFuUUtJWGNxYVZxZmhaaHpZcXl6YUpNdkhhOHowU1Br?=
 =?utf-8?B?djFUQlMvRXUxbXdmQTJvNFVSY21JVDhBeEVzaVA1VlcrZzlYeE9UVDhnaC9Z?=
 =?utf-8?B?UHQ2dmk1NzlsWjhQRWl2NEVNMDZIK3RzMjd2VkVxcVczUS81bStPS1I5NUk5?=
 =?utf-8?B?Ri9kS0ovUXFxdWhydEJ5ZzQzaFFWaHdPM2szNU1IS3ZjSmNSL2dycE0xdHI3?=
 =?utf-8?B?cEY1bkpLSDJ0Q0JwRGJ6ODRCcjZkUHRxRUNJUWtKaTBsV1V5c0dzVWozV0Iy?=
 =?utf-8?B?cDNvVmJ3OWlqQ3RGNHN2aHEzdmtweHlaT25UTFB5eDhHT3Vsd281T2hWZVY5?=
 =?utf-8?B?cWIvUk04QnlwNStCYVJiSjlLeHN4NGQ2QUVtaEs5dmd1TGZzQ3E5L25uMXB6?=
 =?utf-8?B?dWJMeXUzZ0pQVnlTT2VKQkpseVNLaTVyQVJ6cEtzN1ZMY2tSUlVJcTRSd09U?=
 =?utf-8?B?c285WXdEak8rVXFLRFdaajJ1UlArQXhDNHVrT1krUnlSWWJUcWxjVUM1VVNU?=
 =?utf-8?B?bG9ISnNNVndSeHQ5U2cwOEhBRDNwd3RNSXpoWHRKYzNLYWNPcUhudDJmUFRY?=
 =?utf-8?B?TzZLYW5jOEdHd25QY1dEZzR1TCtGbGc2V25jUWRjZE1mUGJnTWd0M29JcXk4?=
 =?utf-8?B?aXNRVmF5bG16QXlCT01uT0tnWDFDUjZNM1dvLzNaaXFrOXVYaEwzZldmSU1E?=
 =?utf-8?B?N01hcmpHVWVwWHNHenFnS2ozSVIrZEpsY0JKOG1DMjQ3eDduM3RBak5wMC9U?=
 =?utf-8?B?OGpuRkdGYUZaTzN5d1ZuMWNpeER2ZEk3dVVSZ3RxcTk5aE1ZR0VURDdrRCta?=
 =?utf-8?B?SEtrWmRack5RN3BJVHZsQTcwVnhLTmhCR0lmVkJDT2c5Y1VJMExPcElwdTR5?=
 =?utf-8?B?emtXamVvdlhXOGl5dHFJVWI3ak8wWTVNS2JjV2RFMHFHdHlrMk1jOE5iOGZM?=
 =?utf-8?B?NXZ6Z1RkZGRIcjBtemZyOXNCTHF6b09tTVpZcERkOHRBZTVYZUJkS004SHEx?=
 =?utf-8?B?U2N2RG5mRDI2c3pNZks0VXpiOElNcTVkUjIwU3J6Rm9HR2g2SFovRDhNOHM0?=
 =?utf-8?B?RVJXYy94VEcweTNRRlRoQ2xXb28zYUloWW42WFhNemZHTW1ncm12cktZbFBr?=
 =?utf-8?B?eEtnOW9ReExlNXRYT1Bndy9XRzhrRWJkVEFkc3FCQXNzNEs4dXVxRFdRZWRN?=
 =?utf-8?B?Qm5vWDduYmhMVEFxd2Uvb2RCWEIrVGJ6L2NoY2JzOXBTT0Z3eXJvRnlreGJN?=
 =?utf-8?B?MERXLytyZFZXenFOb2YyQkpOejE3T2VBMDFUUGN5ems5NUNUeHpFSkUzWHVL?=
 =?utf-8?B?dnZUQUUvaUdyQWJYK2w4N2gySzRKd1FiaUJFZXB5ai9BbVE4NUs4TkhOOHBK?=
 =?utf-8?B?QmNoY2ZWYWRZVzdkclptZUkzWEVZdlJxaHd1d3Jycm1xTWRBb1hXSVlsdzA4?=
 =?utf-8?B?eUkvc1dmcER1c0VYT0dscE1FdzJNSVgxTGxjNCtwVytWeThRQ1g3c2ZaWVNl?=
 =?utf-8?B?S2czSnp3eEZSRmVuUlFvcngzSTM1OXdOQ092OW51ZkNBV1AzS0hmVXhrTHdq?=
 =?utf-8?B?Y3hTV3ZHbHRGdGM5djRuc1ExVUtGRmdiWFFndU8wbXdFY2pKQWRPakFyeWFD?=
 =?utf-8?B?TkpkMGhlNGNUcHIxYVI1MWdCOEsrM2U3aXRPVXFGd3hBNVBLZ21mb3VyV1A4?=
 =?utf-8?B?VTB2eDBuRDlGN2cwVkxtblB3djB3SXRQTnoyMllYNEhFUFZOajRRZmRvTFM4?=
 =?utf-8?Q?40fxqaVx5uf+y68FxkG1fSgSK8LA10=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:20:35.3383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b6dc31-1b4a-48a8-7915-08dd574aaa63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

Hi Mateusz,

On 2/26/2025 6:48 PM, Mateusz Guzik wrote:
> On Mon, Feb 24, 2025 at 03:24:32PM +0100, Oleg Nesterov wrote:
>> On 02/24, Sapkal, Swapnil wrote:
>>> Whenever I compare the case where was_full would have been set but
>>> wake_writer was not set, I see the following pattern:
>>>
>>> ret = 100 (Read was successful)
>>> pipe_full() = 1
>>> total_len = 0
>>> buf->len != 0
>>>
>>> total_len is computed using iov_iter_count() while the buf->len is the
>>> length of the buffer corresponding to tail(pipe->bufs[tail & mask].len).
>>> Looking at pipe_write(), there seems to be a case where the writer can make
>>> progress when (chars && !was_empty) which only looks at iov_iter_count().
>>> Could it be the case that there is still room in the buffer but we are not
>>> waking up the writer?
>>
>> I don't think so, but perhaps I am totally confused.
>>
>> If the writer sleeps on pipe->wr_wait, it has already tried to write into
>> the pipe->bufs[head - 1] buffer before the sleep.
>>
>> Yes, the reader can read from that buffer, but this won't make it more "writable"
>> for this particular writer, "PAGE_SIZE - buf->offset + buf->len" won't be changed.
> 
> While I think the now-removed wakeup was indeed hiding a bug, I also
> think the write thing pointed out above is a fair point (orthogonal
> though).
> 
> The initial call to pipe_write allows for appending to an existing page.
> 
> However, should the pipe be full, the loop which follows it insists on
> allocating a new one and waits for a slot, even if ultimately *there is*
> space now.
> 
> The hackbench invocation used here passes around 100 bytes.
> 
> Both readers and writers do rounds over pipes issuing 100 byte-sized
> ops.
> 
> Suppose the pipe does not have space to hold the extra 100 bytes. The
> writer goes to sleep and waits for the tail to move. A reader shows up,
> reads 100 bytes (now there is space!) but since the current buf was not
> depleted it does not mess with the tail.
> 
> The bench spawns tons of threads, ensuring there is a lot of competition
> for the cpu time. The reader might get just enough time to largely
> deplete the pipe to a point where there is only one buf in there with
> space in it. Should pipe_write() be invoked now it would succeed
> appending to a page. But if the writer was already asleep, it is going
> to insist on allocating a new page.
> 
> As for the bug, I don't see anything obvious myself.
> 
> However, I think there are 2 avenues which warrant checking.
> 
> Sapkal, if you have time, can you please boot up the kernel which is
> more likely to run into the problem and then run hackbench as follows:
> 

I tried reproducing the issue with both the scenarios mentioned below.

> 1. with 1 fd instead of 20:
> 
> /usr/bin/hackbench -g 16 -f 1 --threads --pipe -l 100000 -s 100
> 

With this I was not able to reproduce the issue. I tried almost 5000 
iterations.

> 2. with a size which divides 4096 evenly (e.g., 128):
> 
> /usr/bin/hackbench -g 1 -f 20 --threads --pipe -l 100000 -s 128

I was not able to reproduce the issue with 1 group. But I thought you 
wanted to change only the message size to 128 bytes. When I retain the 
number of groups to 16 and change the message size to 128, it took me 
around 150 iterations to reproduce this issue (with 100 bytes it was 20 
iterations). The exact command was

/usr/bin/hackbench -g 16 -f 20 --threads --pipe -l 100000 -s 128

I will try to sprinkle some trace_printk's in the code where the state 
of the pipe changes. I will report here if I find something.

--
Thanks and Regards,
Swapnil

