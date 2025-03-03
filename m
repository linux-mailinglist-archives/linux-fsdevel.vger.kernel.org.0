Return-Path: <linux-fsdevel+bounces-42939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B86A4C551
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3495B17387C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865F214A8D;
	Mon,  3 Mar 2025 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sC7I+oqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA02144DC;
	Mon,  3 Mar 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015934; cv=fail; b=J+d60+oUp3kA9k7MWwR09tQv399yckFtk8eSxqLGLsrJwO5iD3w98l3cRttCwG36RWeq4Brwr9GphEQeRELksmXj32hylNP5XpxRCs4xGlCvi8ZKgdTwa7j7uaAKGJkrOw+zlVEUq5otppi0tKC0LNPeJ40tjp26MDpZOljO9iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015934; c=relaxed/simple;
	bh=Z4gL9G0yVA/xCwACpwL/hgTMd+PS1pbnnTCyACG1IPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eEugTMkPdU1OuPsPpibyPRVwQjz42gA1RYCdl9hLZPlrjES3gai+EjhvOgt/VsBIyQ0jIeL26YeXZs682fpPgMIVo0+akM7vEBd+T6RieBQfmo3yoZu7/CEvxLDG7Byq9hYoEASpf2pif+ADyNlNI+XPjaPJmcGo/Kk4m4vPjSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sC7I+oqS; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wa32Q53ZwWG4S3Errd26udY6E/nttdA6ppRrZ5MDjdJ1ecMbTFi4NWupir5SK200BN9mLFw2E91ivkZDyBHegC9o9WLuO+ia9MWu2w6KftKWl4s+IPL1i/Dk+r5lx+dnM/U20mfJ8RtU0NiR6F+tuYlBhspRIpZ6HCePSK7JM+Wo7anuCK0KIymFTV5tHEIVrbsI0YZK+n8LUwXMO76+NG9uxWxyA1Z1AUgqYzYMGbfRGvClPnNbQYq7od1L5b4aqTHBGM6jZT8WGdKRaMMA0o7XqsVz7zrXF1dSIjeGouWMb43+RK/k156H3fBJ3oGJrIJ3JS2ZuPnMt/bIq8hJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrvdE68qZedcp2AJ0AzOcpzsSeIjpQNO3uJU2J6exyU=;
 b=kjTd4/pGR31NsFoDZNedoVLSn4DbK3M2dJyRe9ewP56U4Ip3UBz96dBE2SqJV/HK83CYYlMRKm/f32KFU/c25PF17uRA7f6R/Hv3inf+PxKfsKcuJo3q1qQl13mYMDGaYOkB7hUD3miEBSw4cNNG3yXHC5iogHYvyAQYtmUzBBDZ9EZVRNkKuzUOKYCRXHJvDen/O6a3cX0cwK6KJE56OgAMK9yWdGY2WBvb10IzC+dR87ib2j4dFvfZxCVdTifMXC4y5RWUN+gi513xH1ko5VoHKAzhrrJF6GP60I+b00UtEWarB09SI46qfBdG6NhfBBtLyDq9QWkUglYDI9hBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrvdE68qZedcp2AJ0AzOcpzsSeIjpQNO3uJU2J6exyU=;
 b=sC7I+oqSZWw25QgrzbTsrrRZc/Twa+mfxOjRApeccLiwtRZJAEzjmpaWqXbnu66+1z0hCsMtOAqTyf862D+InnoXvg5ZJ8hkTVB/MiFXmn6o6dS9Wfg0BacmXWf080vo1PYPXhLTwfZe1u8tMgZuvOvlYp5t6/hqEnoJRHIcH4w=
Received: from BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 15:32:05 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a5) by BY5PR03CA0028.outlook.office365.com
 (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Mon,
 3 Mar 2025 15:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 15:32:04 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 09:31:55 -0600
Message-ID: <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
Date: Mon, 3 Mar 2025 21:01:51 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Mateusz Guzik <mjguzik@gmail.com>, "Sapkal, Swapnil"
	<swapnil.sapkal@amd.com>
CC: Oleg Nesterov <oleg@redhat.com>, Manfred Spraul
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
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 662cc7d3-855d-4977-96fa-08dd5a688d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UktUbVQzcUk3Sit6Q0RzODNlZi9mRHNrcU13WjY3R2doRDBKYlZ4RVBkbVFC?=
 =?utf-8?B?NnFqYmErb0pZSjRjLzZlYkVkeHNaYmg2Yk4xSXZtakVibUZoVGI3QnB0dVFl?=
 =?utf-8?B?NXJvVVBneWhrYythck5telBDckJBcVdreUp5WkVwSzI2QTFoY09vTFZ1Um5u?=
 =?utf-8?B?RHZrTEZMRzNOUDk0cmNmUi81UGduMDJPdlQxYnYvOW5hTzdhYkpzajRyRy9L?=
 =?utf-8?B?SkVzdXFoNnFsWjJ2ejMyYnFjUmNMenN0ak1QRG1qRkVhYmFOZlpzZGVjSVdF?=
 =?utf-8?B?VDVUODhDRlNydkZJTUhnUWlyRXJZV3A3aktZa1V5Z0pYQlYvdERNQSswUGQ2?=
 =?utf-8?B?TnNKK3F6RWdLM2JLS1RrMWZpUW1xWTFhbnpmSEZ2bkpjV1J3OFFkRm9iTmx5?=
 =?utf-8?B?b2NnLzdoQW1RbXUyNzBnSkw3VGgzMlE4ZjQ0QVlBT0RvOVU0Q1ZkbzZGVWRk?=
 =?utf-8?B?QUluQk0veXBjUDg0cUJxZkh2QnZyVUd4SSt5allSY3l6S2paYXhqWTQ2OEpV?=
 =?utf-8?B?YVF3c2NZdHNCQmFYYThCQWMweHhWSFhONGJuSUY5R2ZmaEFoMmNzNEJPanly?=
 =?utf-8?B?RjhBWU9WSHlPUFpFMkdpV0M3SWlpbklrcnNyRUJKdE9uVkpDVzFGSllkOWw1?=
 =?utf-8?B?NmRtVmNrakV3b091M3o2TmJQN0syVXNqeEFHcVpPMVlkcThIVnV4d2hUN1lB?=
 =?utf-8?B?QnU4dXA3R2lhcGltTWlBeHJSMC9jWG90SE92THA1UTlKelNwcWtpaW9DT28z?=
 =?utf-8?B?M0QwS3JUamE2YlZSR3ltSHlTanR6SDZVMHhiaTZ3TnVpQTdLeW93TUJCZWJ4?=
 =?utf-8?B?TGhJQ1UzU2ZzSGgrVXo4Q2ZkMXl6VStOYk40WkpXRmQzcmJRN3lmRVp5WVc0?=
 =?utf-8?B?WG95dmhsQ0svVTVpMDMrQ0l4blhhUTE0MVplMzZ4WDhBSmdQSUNveS9LZFVY?=
 =?utf-8?B?c0ViUUovSGVHekp2QmxmdWxWaWtMTFE4c3pkQzhGL3JVZlVpOHl5QXVyWCt5?=
 =?utf-8?B?YjZwT2NpbEZxZnVaVEUwTlVvc0pBZnAxTzhXU29aZitvNEVwRjZQK1hVYWtz?=
 =?utf-8?B?enUyNWthdURHQm1XOGN6cU1KamZ0dklhbno0cStSeWkvWXF2VmRmazZGekZX?=
 =?utf-8?B?bTNXNEh0dC9VUTI4WHhRVDlFb2tCZ0ljLytlU3VoZHAzMkoyQmZsM3Rja0Z1?=
 =?utf-8?B?SzNzbWxORG9jeEFINXE0dnNXMTBGSmdublN3VnBmdzkvOXJFc2lqQ3V1M3Nh?=
 =?utf-8?B?b2U3d2NpQXJCYVRDNUJjck5aYW9zVnUrUk1vZitnT3prZ3Y3YzQrNUp0b3Zo?=
 =?utf-8?B?MHNHYnVqL0FzV3ArUlplR3hZZG5IMG1QanBVYWppL1h1OGp5YWZBZ1RNcHdY?=
 =?utf-8?B?SWFhRi9RUTU4YlQrSEg1OFdwbk51ZVd4a2dCcXhiSXBXZTdBL3ZxK3M2RTBO?=
 =?utf-8?B?MlN6RUQrSVkxa0dLRGRubGk1NE1KU1IvUlhpc2I2WDBRVHVVd1NUMUJRZk5U?=
 =?utf-8?B?d25NN3ZXOUNWOU1GUjhMZ0pnY0dac0lDSlVjbVFKT1pLYU1XMEh6R1J0Q3M0?=
 =?utf-8?B?Q2JnT3YvUU5odjZEcmdSeFIwZ3pRSEdxSG1sUGZqVGR0d21nK3I4MU9acE1E?=
 =?utf-8?B?M2JQU2ovNngrUXdkUjE2TE1xakxRelQwcEFQa1FXSzh5YnA0amdLRkNFaU94?=
 =?utf-8?B?RzEydkFHUDRRaWx2aGoxRHlFZzFERXVCRm9hdzErYjZKWGFGQUxMQ2dNMFcv?=
 =?utf-8?B?NWhwYlAraG5IUzgxNEZyWFNJNC95VnZOTmlBZjJUdFozV3hpOVNzYzJlTjZK?=
 =?utf-8?B?Sk9HTnJGaTV6MXpNMWdpcHd6aEhYL016dThQeDlrbjNla3RhNUNmWUVWOUJy?=
 =?utf-8?B?OWVHYXBpY2JMaHduUkVaYVFzWDFZaDUzbXAyRExvTVg5NEJpNzRldGxUSGFo?=
 =?utf-8?B?WWJnWGQ0bXp2L1BOQ0V0bk1KMUh6TWpDVjdFM2g4eU1HOTBJdEJ0eGtwUjZW?=
 =?utf-8?Q?GPentVS/RwhMnIJ8URz5c3JrYfj8jo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:32:04.7401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 662cc7d3-855d-4977-96fa-08dd5a688d37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

Hello Mateusz,

On 3/3/2025 8:21 PM, Mateusz Guzik wrote:
> On Mon, Mar 3, 2025 at 3:37 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> On Mon, Mar 3, 2025 at 10:46 AM Sapkal, Swapnil <swapnil.sapkal@amd.com> wrote:
>>> But in the meanwhile me and Prateek tried some of the experiments in the weekend.
>>> We were able to reproduce this issue on a third generation EPYC system as well as
>>> on an Intel Emerald Rapids (2 X INTEL(R) XEON(R) PLATINUM 8592+).
>>>
>>> We tried heavy hammered tracing approach over the weekend on top of your debug patch.
>>> I have attached the debug patch below. With tracing we found the following case for
>>> pipe_writable():
>>>
>>>     hackbench-118768  [206] .....  1029.550601: pipe_write: 000000005eea28ff: 0: 37 38 16: 1
>>>
>>> Here,
>>>
>>> head = 37
>>> tail = 38
>>> max_usage = 16
>>> pipe_full() returns 1.
>>>
>>
>> AFAICT the benchmark has one reader per fd, but multiple writers.
>>
>> Maybe I'm misunderstanding something, but for such a case I think this
>> is expected as a possible transient condition and while not ideal, it
>> should not lead to the bug at hand.
>>
>> Suppose there is only one reader and one writer and a wakeup-worthy
>> condition showed up. Then both sides perform wakeups *after* dropping
>> the pipe mutex, meaning their state is published before whoever they
>> intend to wake up gets on CPU. At the same time any new arrivals which
>> did not sleep start with taking the mutex.
>>
>> Suppose there are two or more writers (one of which is blocked) and
>> still one reader and the pipe transitions to no longer full. Before
>> the woken up writer reaches pipe_writable() the pipe could have
>> transitioned to any state an arbitrary number of times, but someone
>> had to observe the correct state. In particular it is legitimate for a
>> non-sleeping writer to sneak in and fill in the pipe and the reader to
>> have time to get back empty it again etc.
>>
>> Or to put it differently, if the patch does correct the bug, it needs
>> to explain how everyone ends up blocked. Per the above, there always
>> should be at least one writer and one reader who make progress -- this
>> somehow breaks (hence the bug), but I don't believe the memory
>> ordering explains it.
>>
>> Consequently I think the patch happens to hide the bug, just like the
>> now removed spurious wakeup used to do.
>>
> 
> Now that I wrote the above, I had an epiphany and indeed there may be
> something to it. :)
> 
> Suppose the pipe is full, the reader drains one buffer and issues a
> wakeup on its way out. There is still several bytes stored to read.
> 
> Suppose the woken up writer is still trying to get on CPU.
> 
> On subsequent calls the reader keeps messing with the tail, *exposing*
> the possibility of the pipe_writable check being racy even if there is
> only one reader and one writer.

Yup. One possibility looking at the larger trace data, we may have a
situation as follows:

Say:

pipe->head = 16
pipe->tail = 15
2 writers were waiting on a reader since pipe was full
and action ...

         Reader                          Writer1                                  Writer2
         ======                          =======                                  =======

pipe->tail = tail + 1 (16)
(Wakes up writer 1)             (!pipe_full() yay!)
done                            pipe->head = head + 1 (17)
                                 (pipe is not full; wake writer2)        (yawn! I'm up)
                                 done                                    head = READ_ONCE(pipe->head) (17)
                                                                         ... (interrupted)
(Guess who's back)
pipe->tail = tail + 1 (17)      (back again)
...                             pipe->head = head + 1 (18)
(reader's back)                 (I'm done mate!)                        ... (back)
pipe->tail = tail + 1 (18)                                              tail = READ_ONCE(pipe->tail) (18)
...                                                                     (u32)(17 - 18) >= 16? (Yup! Pipe is full)
(Sleeps until pipe has data)                                            (Sleep until pipe has room)

---

Now the above might be totally wrong and I might have missed a few
intricacies of the wakeups in pipes but below is the trace snippet that
led us to try rearranging the reads and test again:

     hackbench-118768  1029.549127: pipe_write: 000000005eea28ff: 0: 32 16 16: 1  (118768 - sleeps)
     ...
     hackbench-118766  1029.550592: pipe_write: 000000005eea28ff: h: 37 -> 38     (118766 - write succeeds)
     ...
     hackbench-118740  1029.550599: pipe_read:  000000005eea28ff: t: 37 -> 38     (118740 - read succeeds)
     ...
     hackbench-118740  1029.550599: pipe_read:  000000005eea28ff: 0: 38 38: 1     (118740 - sleeps)
     hackbench-118768  1029.550601: pipe_write: 000000005eea28ff: 0: 37 38 16: 1  (118768 - wakes up; finds tail (38) > head (37); sleeps)

The trace goes on but if at this point 118766 were to drop out, 118740
and 118768  would both indefinitely wait on each other. This is an
uncharted territory for Swapnil and I so we are trying a bunch of stuff
based on patterns we see - any and all advice is greatly appreciated.

-- 
Thanks and Regards,
Prateek

> 
> I'm gonna grab lunch and chew on it, but I think you guys are on the
> right track. But some more fences may be needed.
> 
>>> Between reading of head and later the tail, the tail seems to have moved ahead of the
>>> head leading to wraparound. Applying the following changes I have not yet run into a
>>> hang on the original machine where I first saw it:
>>>
>>> diff --git a/fs/pipe.c b/fs/pipe.c
>>> index ce1af7592780..a1931c817822 100644
>>> --- a/fs/pipe.c
>>> +++ b/fs/pipe.c
>>> @@ -417,9 +417,19 @@ static inline int is_packetized(struct file *file)
>>>    /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
>>>    static inline bool pipe_writable(const struct pipe_inode_info *pipe)
>>>    {
>>> -       unsigned int head = READ_ONCE(pipe->head);
>>> -       unsigned int tail = READ_ONCE(pipe->tail);
>>>          unsigned int max_usage = READ_ONCE(pipe->max_usage);
>>> +       unsigned int head, tail;
>>> +
>>> +       tail = READ_ONCE(pipe->tail);
>>> +       /*
>>> +        * Since the unsigned arithmetic in this lockless preemptible context
>>> +        * relies on the fact that the tail can never be ahead of head, read
>>> +        * the head after the tail to ensure we've not missed any updates to
>>> +        * the head. Reordering the reads can cause wraparounds and give the
>>> +        * illusion that the pipe is full.
>>> +        */
>>> +       smp_rmb();
>>> +       head = READ_ONCE(pipe->head);
>>>
>>>          return !pipe_full(head, tail, max_usage) ||
>>>                  !READ_ONCE(pipe->readers);
>>> ---
>>>
>>> smp_rmb() on x86 is a nop and even without the barrier we were not able to
>>> reproduce the hang even after 10000 iterations.
>>>
>>> If you think this is a genuine bug fix, I will send a patch for this.
>>>
>>
>>
>> --
>> Mateusz Guzik <mjguzik gmail.com>
> 
> 
> 




