Return-Path: <linux-fsdevel+bounces-43207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE57A4F62A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 05:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8CB3AA5F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 04:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDDE1C7005;
	Wed,  5 Mar 2025 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qx4K263s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030C2E3364;
	Wed,  5 Mar 2025 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741149687; cv=fail; b=BQWHWVQs8Z57cKMoeVPCOMveUBI63CvIx/RqS4WaJupc+CPdYk2qEGc1V5Tisaq8KL8InkOBMCQHZEpa5WLTS+rQkBEadlTk83kMusjBS6ZuBusFI+GyztOSMHqqaXkZfaKu/QgPYM30nNdBdH/GOgS7EFxYHwp3RHTk+a9WnWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741149687; c=relaxed/simple;
	bh=VYPTyLfsql/nAwHPp8nW7eokAKCmfFFLXhF5Ix7IvwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UBtasmi1idtou+w7L4tWUAxTUL9rUCTNpIVsajdKNvULTrMq8UcE2Q69WE7iSfsPIgY/rKQiI0VwaX+iid2KazImhROrI9BG0Cy3ZttKY+Bzys8LFfDrQjVSsFj5mBkYCkxFdLP8Loj9+DC2VLnKF9UD9FR4N5FY/pKg0iviEJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qx4K263s; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQGSdP1eia40oLNvL4F8qJlHZmFgUZOxdFdunYhjHqsG+GRI1Q4yrCsNhGWRue9owA7CQcnxgJu7dcZyfhMF82MXmwcFbsSEGKE0qX+SvxJCUxyMXBYymlmeNhZ1x8n9O4mrVsr8988HPnJWV+XSUGwe6W2+YmsXvrg38ZZHAWj3MxT2bPqjXsgyOHgwwufUj5M0vN9SbkOMTQziL4y9KCeb9y94nqa5hp5yxU3dqwPizOKxivSCsid30yc8EmuGRUT/IiJkAzXStmhEWA0wuxzSXgLbfEn4oKENDCGQoB5O1l6/B5X9KbGo0RBAZNFjqTN7KsLN8jhwQQP8Xaf3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4CrQE3dYpoToMVxEFqGNkoFCf4iY9j5s2GFr6zTRTc=;
 b=grcKSWaUCQVpN2yLjPA03Q55wFxxvtRcCao5BXp5VK16ca5OXF7wosAX3HxKrj9jDtg3Yvr05MG4OxHH/njmsf4xHaN0/hT02oDqMPKvSREeUMbL2/RhXY3IvSe3VVxCs70nIMuk2/uGV0HW4eHyao5wIcyvh7sz8vK0WCQUSizYgPIEOwTVP460WQAVIvYanZC0K86D3nHn7jXyYNnloBOWdw6pEr2tw4uyNby3XM+uhVBR4qxxs09zjLP1syh0ZyurS3HCT5p3rKNih4INwC0Laf54CmLn2yU2Dc3Z6WNYp7AqqQL/HePhMOs26Jw9M8dnf3gj1T262R2rJ6DkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4CrQE3dYpoToMVxEFqGNkoFCf4iY9j5s2GFr6zTRTc=;
 b=qx4K263sKMDmk5ulpv332oMznw09Mwsl1w6q76b+NHyURRyA/HDEZFAmTclEiWVYmZzYwBqXtMQTv5zObRa+pUkF4HqLBUqAEi9nx6l9K9VQf7LZH91FT9jeaNhIT1zdalqhw1S1VP7K5dlklb/pHYrWCD00Wf0NjfaLp5GfapU=
Received: from MW2PR16CA0047.namprd16.prod.outlook.com (2603:10b6:907:1::24)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 04:41:20 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:907:1:cafe::5b) by MW2PR16CA0047.outlook.office365.com
 (2603:10b6:907:1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Wed,
 5 Mar 2025 04:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:41:19 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 22:40:27 -0600
Message-ID: <8fe7d7c2-e63e-4037-8350-9abeeee3a209@amd.com>
Date: Wed, 5 Mar 2025 10:10:14 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov
	<oleg@redhat.com>
CC: Mateusz Guzik <mjguzik@gmail.com>, "Sapkal, Swapnil"
	<swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>, <Ananth.narayan@amd.com>
References: <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
 <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com>
 <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <20250304125416.GA26141@redhat.com>
 <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8466b9-64b6-496b-f2c0-08dd5b9ff970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXgzNFo4NmRoVlRaay9RS2FMMHo5THlPYzZRb0FNdjhQRGRlWjEwUXQzd1Bv?=
 =?utf-8?B?TmcyMTYrem12eUdJYkpVL1NyTzNDeTRGV0poZ1pRSm9DU29tSjVTYjQwaUVs?=
 =?utf-8?B?M3NOK05RK3ZTd3EvdHVhV2EyMW82MkNIYnZ1eEhFQzhQcDBzKzNyRkFqaVZG?=
 =?utf-8?B?b214ZWtXcGYyaENacUI1Zy80UWtVaVRUSks4ZnVRYVExeCtmVklvVGxuVkE2?=
 =?utf-8?B?bUZVanc5N2hxbmNDTW5RRGNUK20ySEpNckJmZEYrSWM0ZDJkN0VQd2NxRWRN?=
 =?utf-8?B?VktCNU9mdHJrMkYrYnYvMnZWOU1pMGEwUXpuVS90NG1ueXBKYjcrZTByVTU2?=
 =?utf-8?B?a1ZFUHg2b2ROeitrendUd2R6TnZ4SHBLMHFTb2pYN3N2Qng3ZEdnT1BRZmhI?=
 =?utf-8?B?WThob05HSFNSOVE0TWpGMm9BNWpoL3V4eDZsd0NMTUx2YUlFQU9BdnFwMmw0?=
 =?utf-8?B?dE9xbE5aaTUzamc5eHZSRHZhUEpXUk1nRXRIM0RNSUNkQmNrWXNBMk5lcWgy?=
 =?utf-8?B?NkI1clpOOG9UOUZ4YmtYbVJvVFgrYllkL0MvUGxXcHdnSG8vT25KVVg4b3BT?=
 =?utf-8?B?SnhHd003RW5xckM4R3VMeE9RWVBaQWNCSFU2eXBBcTZVcnVpcVZTcUhiZEti?=
 =?utf-8?B?WVU3M2pseHJlcEZ5Q2RqVzMzamoyckkyZ0UwcUFiczNZVzNDSmFuZ2NRT0gw?=
 =?utf-8?B?ZUg4TWlnb3FDTUVteTF4ZUIvanhibGl4UFdBSUtnVERSMmpPYStIQTBGKzdm?=
 =?utf-8?B?REh2RmxUUG8zRGdkTGtzQmFyWllUNGlTTURjZG5IQm1UMDgrV3VGQ3NmbWpu?=
 =?utf-8?B?YktlR0c3V3pRYWt3RW1kMmg0MVBUc2NsaTNER2tPV3MvbUJmYWNUZHNkSVBX?=
 =?utf-8?B?MUVFWWVKS2hvZnpHM01GTjc0UCsxZU52NVB4TWJjSFRORXc1TWlKZnhTdTBK?=
 =?utf-8?B?cGYyc29rQUtaSGNTQnY5SHgyT1lUY295dFk2VzdUK3FodXNmL2JCaURZdmZq?=
 =?utf-8?B?M29ScVdtQ3k3cWJTVTVpTjRUMlBqeFJnWVhKWWd1WjBKNk1HVDZTNVI3Sjha?=
 =?utf-8?B?MEcrRWJWZWhaSXlZSVd1Smd4SERGajBySmRGZTFnK09YMU4yaWhVemJWTDd5?=
 =?utf-8?B?Q3dIMXRrU094VHpkTUNBQmdSbW4yTisrMlRPV1JLV1FEbnFrVG91aHNLSytZ?=
 =?utf-8?B?WTZySmo3VURiaFY1ejc4aWxXR2FxNUxHakpmNHcvbm1aZ1U0OTlNSm16dm5F?=
 =?utf-8?B?Y0hRMGduMHE5LzllbVFTdkl6RStxVVR1TStXd2RNNkJFNWRPTHRyTnNYRG1M?=
 =?utf-8?B?NVltK3BrS1pGVnp3ZWNTTHQvZmpHRWVHRmE4SVMyaktaeDROb25JbWRaRXZj?=
 =?utf-8?B?dmNnQjB4bmg1S29QdUc3Y2RVK3V0enNFTy9JQlZqUjFVaWczT292YXhiM01r?=
 =?utf-8?B?MU0rWDF4UlJvZmo2MSt5c080NXdDdXJVRWo0SWZ6dFhUTVc1eFVySi9jalZE?=
 =?utf-8?B?aFdwU2RaOWFFZjV6WU8xdFAzbURTcGtGTGFqWmpUQ2hVc3ZzblpidWlFZWpH?=
 =?utf-8?B?ckVDdkwvNFIxNzVWc1o2ZXNZY3E1UlYza3Ntc0tBTnZIWG1KclA4U0tYSDdh?=
 =?utf-8?B?T2duWU1neFNoQzAvM0NKWC9oS1BxUzJXQlp3Z0cvSnZLUUxabW94YjNsM04r?=
 =?utf-8?B?TmJIalZ3OG5Iek5VMEh2dzcxK2FDRFJUK3VzaUVJbGJSeHpldnA2bGlBVHNk?=
 =?utf-8?B?dG85RnJWbnNObnMxTEsrWDdNdWdoelE4ck5VOVFOd2tCMW5GMlNIdjBnYVlk?=
 =?utf-8?B?SXRCNUx0QVhyU0dZUmExdEVyRmVaeXJpNjVPcUJoN0FYNDRMOUZydHhpdkF4?=
 =?utf-8?B?eWo4bVRnajFKR0M4Z1BheTZURHkzaXlSbjl2U2NLaGdkemx2UUJoZFhKWk9M?=
 =?utf-8?B?RE9aRGhSdG5OTnpwdGc1ZEZLYU9pejhyT2JJSEZjRnZ6bHQyN0trS0NDcnpV?=
 =?utf-8?Q?qORIoAGxx0+QV07L1WCcAjWhC+Er8I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:41:19.7615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8466b9-64b6-496b-f2c0-08dd5b9ff970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

Hello Linus,

On 3/4/2025 11:58 PM, Linus Torvalds wrote:
> On Tue, 4 Mar 2025 at 02:55, Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> I thought this is wrong, but then I noticed that in your version
>> ->head_tail is the 1st member in this union.
> 
> Yes. That was intentional, to make the code have much less extraneous noise.
> 
> The only reason to ever use that "union pipe_index" is for this whole
> "one word for everything", so I feel that making it compact is
> actually more legible than adding extra markers.
> 
>>> + * Really only alpha needs 32-bit fields, but
>>> + * might as well do it for 64-bit architectures
>>> + * since that's what we've historically done,
>>> + * and it makes 'head_tail' always be a simple
>>> + * 'unsigned long'.
>>> + */
>>> +#ifdef CONFIG_64BIT
>>> +  typedef unsigned int pipe_index_t;
>>> +#else
>>> +  typedef unsigned short pipe_index_t;
>>> +#endif
>>
>> I am just curious, why we can't use "unsigned short" unconditionally
>> and avoid #ifdef ?
>>
>> Is "unsigned int" more efficient on 64-bit?
> 
> The main reason is that a "unsigned short" write on alpha isn't atomic
> - it's a read-modify-write operation, and so it isn't safe to mix
> 
>          spin_lock_irq(&pipe->rd_wait.lock);
>           ...
>          pipe->tail = ++tail;
>          ...
>          spin_unlock_irq(&pipe->rd_wait.lock);

 From my understanding, this is still done with "pipe->mutex" held. Both
anon_pipe_read() and pipe_resize_ring() will lock "pipe->mutex" first
and then take the "pipe->rd_wait.lock" when updating "pipe->tail".
"pipe->head" is always updated with "pipe->mutex" held.

Could that be enough to guaranteed that RMW on a 16-bit data on Alpha
is safe since the updates to the two 16-bit fields are protected by the
"pipe->mutex" or am I missing something?

> 
> with
> 
>           mutex_lock(&pipe->mutex);
>           ...
>           pipe->head = head + 1;
>           ...
>           mutex_unlock(&pipe->mutex);
> 
>   because while they are two different fields using two different
> locks, on alpha the above only works if they are in separate words
> (because updating one will do a read-and-write-back of the other).
> 
> This is a fundamental alpha architecture bug. I was actually quite
> ready to just kill off alpha support entirely, because it's a dead
> architecture that is unfixably broken. But there's some crazy patches
> to make gcc generate horrific atomic code to make this all work on
> alpha by Maciej Rozycki, so one day we'll be in the situation that
> alpha can be considered "fixed", but we're not there yet.
> 
> Do we really care? Maybe not. The race is probably very hard to hit,
> so with the two remaining alpha users, we could just say "let's just
> make it use 16-bit ops".
> 
> But even on x86, 32-bit ops potentially generate just slightly better
> code due to lack of some prefix bytes.
> 
> And those fields *used* to be 32-bit, so my patch basically kept the
> status quo on 64-bit machines (and just turned it into 16-bit fields
> on 32-bit architectures).
> 
> Anyway, I wouldn't object to just unconditionally making it "two
> 16-bit indexes make a 32-bit head_tail" if it actually makes the
> structure smaller. It might not even matter on 64-bit because of
> alignment of fields around it - I didn't check. As mentioned, it was
> more of a combination of "alpha" plus "no change to relevant other
> architectures".
> 
>                  Linus

-- 
Thanks and Regards,
Prateek


