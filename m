Return-Path: <linux-fsdevel+bounces-44934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92261A6E866
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 03:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C73A9A8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 02:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A8E18C031;
	Tue, 25 Mar 2025 02:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qVr8Untt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057B189BAC;
	Tue, 25 Mar 2025 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742871165; cv=fail; b=Q9w/bE0xoz72S1tZygZ2X5ITB9E4Z5P7eqCFvxqbxpMZ23th94lWt5eDAMJyicbAAFymDyY2qKN1H871qPuPU+6tlN711eQwwiIrGDZPG1V4zZJWLe7jUq9Wqo45LuqYU1XbuhkKjDW1QuQKba9vUV9HjSX7XQzgb6R2ev1JnbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742871165; c=relaxed/simple;
	bh=YDgfE39MmNyMz4znYhm4uzGopPmIHJVwEDqWaIc3Zfc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=G4oTzf6VtlUzNsrbugokqo9VvSSgQr+dMhwOoX9tt73pMnKMyVzMp1radZfigaivIdP18/2WER2/cKbdnSM6hJj20OM3Ej7DQiWKpIT1ssocQ12kVjgiAQUmQjTreCLNe/T5Szjz67CSR0grNd4hChNPdGB5InyvOxzju4Vw3Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qVr8Untt; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrWL/kVXcmnX4tmwOih+GjJ9fjXcT0LjQcV1xnjq72nQ3DF67pv1ggtXXIgO/inMFHlgtP9y5PwN80hZULqpCdbEOTmA/Sxxn1oyCrrvH+xoBheYpT+/YnIYNGm3QyO06cDt6/uhD/KvoLw5ODWrDXFVi5OaAIvCIg5phTR8KB5lNSBM9XKixyCddZMeoBsyTLisY8NFA60ZU/ORR5zTfq5fVBjQjvrASSg5CB2awVvz3euQg97yTd6xVF3Mtm6g5+SjB2h46jBg8VH0FcA394Gq8Pk5nKTPVD4gSOq0yfJwR/u1/e1btc8Nflc8P8BTTnoJhrvi8d7euiEk4+ZTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW5lxkmNWf7qVnlEqHNwog4VB0hgVU/jwPGfI2eURjU=;
 b=tobhTsgC1o2xPYccDZrv0JxuZSuyKO5dygwZF6kfurQG+N/64OdY4Ut4PcDvZFaPnxfC78BQuimsQC7VuBSjo8m4TKlr5Vb1pdlAqRbvhBdWBojBC/V5EMJYZTpQwUhHsgbF2RxFjmfS+sBs59Ck6lIueQZVO9MH8l9hXCaIGgMTls+PdQh7poyqK0W7Pww5ssMUMCki6LL/SY8NjZS1lncyD0MltHZUeXaXQ+Vm1UgUl2nCXWCOetacsE8DUHTbSGNm3U1Fn5sd5zYjP1NfaDmYm+7E+LM9W/yxbE3/CBFtpkpXuI0/EyWyquef8uha0CsiQe1k2+ZifAUs0m2Tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW5lxkmNWf7qVnlEqHNwog4VB0hgVU/jwPGfI2eURjU=;
 b=qVr8Untt2YSAeb2k+QjOBFLVuszG78wgp0LkwOB6F5qvHBmc5qKzHF7tUDDoU4XUkRhKOIPE63F13n8l0NOd1B9sV1tWAGMy76Ywxg8NHFKobD1Syc2gbB+Uafojr/OWlw4BQwV5Vd+Z9PX8ekI4BTHassqvtyZIwDkirXrzcG8=
Received: from SN7PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:f2::8)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 02:52:38 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::1d) by SN7PR04CA0003.outlook.office365.com
 (2603:10b6:806:f2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 02:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 02:52:38 +0000
Received: from [10.136.45.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 21:52:35 -0500
Message-ID: <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
Date: Tue, 25 Mar 2025 08:22:32 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>
CC: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	<brauner@kernel.org>, <dhowells@redhat.com>, <jack@suse.cz>,
	<jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netfs@lists.linux.dev>,
	<swapnil.sapkal@amd.com>, <syzkaller-bugs@googlegroups.com>,
	<viro@zeniv.linux.org.uk>
References: <20250323184848.GB14883@redhat.com>
 <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
 <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
Content-Language: en-US
In-Reply-To: <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: c9273a7a-2e73-4767-6f94-08dd6b481ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1F6aGt6K2RMa3dXKzlTRG5IdHR3MzhHVytEc3pFUTBxWW9rbGpKR1dwcEsz?=
 =?utf-8?B?a29SU3FnbWNNeXVOMGNYekdTS0tlbE9mTTNlSlc4Nmt3aGcrNU5VdVN1RkRR?=
 =?utf-8?B?dzRuazJRU3Q1ZXFaZlhDWTRJYUgrWHRHWnE5ODJOZFBmY0Zyem82M2l1Yzgr?=
 =?utf-8?B?ZFVTUnhrNS8xcjI2OE02UGhWWXVoc2dlek43b0w5RTlJK1pSdnZtOVRteGNp?=
 =?utf-8?B?Z1d2cnBNTXVWWHRpa3pibXdVTVB1VkpoQ01PU3hya3BnaUhmcWVGeHYxbVRM?=
 =?utf-8?B?U3BHUm00d2dzcCtySXFlYUpuNGlWMTJtb2RZSWpoZmJvSlVjVS95cWY2YkRR?=
 =?utf-8?B?ZUh5U0xKVEVaa3Y1ejk1ek5DRmRtRVZqdis2UE11QWovSVJtRE4rTEU1Rm5Y?=
 =?utf-8?B?RlRqT21jckZSWDlXREtwdVZJQ1RJa1NkZDJVZ1lKQW5JT3lEUjhiRGJGVTl6?=
 =?utf-8?B?QnFvL0VOaVlrREgrTHFSSnJoWkwrZGFJcXI4YkVjNXFzWGNsOVYxNGl5Yjc0?=
 =?utf-8?B?TFFhbDcvKzZSSm9YUGVqeDJvcTE2eWt1RTVjTEZPVTVUYmhLRC9pbTNQU1JN?=
 =?utf-8?B?V09DVzNvVHhjMWkwV3dZWTdrcDd0TFluUDVaQUJtLytUZ0wwZGl0S293SklM?=
 =?utf-8?B?WGtoRE9WMWk4ZHhQc2U3TGZaT09IeXh5RnU5M01kTGVoUFl5cmdQZ0hjekpJ?=
 =?utf-8?B?RUtEdmRuVFpZcktQQjl0TDFVcldPenZnS2VGSXlpTm1SNDlkMEZ0ZmlOVDdU?=
 =?utf-8?B?NTgrNmpNMEpHZi9ubUpUOGFlMk0xOVdTUlJTdWRuZjE4YnFLWkF6Qk1iZCty?=
 =?utf-8?B?b2ZnTXlLdmpQVFdUUnBTZGJETFBjWXlCRmdqWTBCRlpIL0lKNjhjcnd4Sjgz?=
 =?utf-8?B?a3JNM3BXOE1WTlZyUm1EcWsrY2FjK25zcVpOLzBNUVpqRzVUN091MDB0bkJh?=
 =?utf-8?B?UEJpd0x2M04zMk51Qm1PaGtVcy96akE0WWVnNkFYZnN4eFRHVFB0VlNaSmFi?=
 =?utf-8?B?dEhMYzkwYVJKNWd4U1dIVkc4TC92VnQxSWU0UVVhMitBZDBSNmx4a2RNODEx?=
 =?utf-8?B?cVRTVFpHNXdqWW1vVWZhK29ISXl4NHF6L0NWSjZDWkZyS0lENjVJYnNVR1FV?=
 =?utf-8?B?cTJqTEtaUGxVZ3dhalE4RHVMNGptT25SWEpuK01iMnJRT3JaRHM0Y0lzbndp?=
 =?utf-8?B?UVRPMmlJelY5cWI4ekdHZ2xra0psWVJHRTR0dDE3bVkwODk3NjF1M1Jlc3px?=
 =?utf-8?B?WTFnTjIvYXlYZW9PU1dKRm5mdHAyV3FDdmJtUWVBNjFZR0taWDVCSGI5dkFJ?=
 =?utf-8?B?c29rY0lEb0dKejJlZ24ya2R2eGdoajBZeXFUbFdQbExZaC9JOWhnaGRlaTlY?=
 =?utf-8?B?MmJ3QldNZnk5Q08ySjVwVEhwMTMrbU92dXJUN0NTZEwrUlNZS1pZdENpaGZ4?=
 =?utf-8?B?QUhQeWtDYU5Sb2ZyY1E5MDIxY1hLVDRGS2JEaWxDeDlkQVNWL2YzWUZKT1hW?=
 =?utf-8?B?VHpJRVVZdEJvR0pQMlBWSWxDdFNmSVhnRDhGWUk3d3hJa2toUFlhYXRYOXhi?=
 =?utf-8?B?TlU0aDRFSXVRdE9nbHNwRG1Qb3RHL21LOEFWazdGTnVoektERE96QmE0c2Ro?=
 =?utf-8?B?RXZuOWtPTWZ0Vm9nYURmYzlsdDdDTWtWWjVjeGlQajJTandMS1JnMFhtYmVD?=
 =?utf-8?B?MFladWQ1VEFuR2NMQjZyMU9SQTh6UGloV3U5NFRQZUd5U0dlbFhyRjF2MHE2?=
 =?utf-8?B?emFBK0t3TkxZMENxUE9KSE9Odi90dGhvaldRL0cyam05aExTeStiZkNCUkdx?=
 =?utf-8?B?dHZQQWFzSmxmb2w3OS9RTHcrdDRBODNnZE4yS2JDNjNlRUpzSnlPdGVGQjMr?=
 =?utf-8?B?Tk5NR0hQUkROb29FYUFybUMyN3dTaEFyc3YvM2NkNDVMalhrYVRaaUQ3RE1M?=
 =?utf-8?B?Ti9FNzcvM2R5NEVJR0VDVk1sWGFZUEl3RGY5L1poSEl6WXN5UU8zNlVldzA4?=
 =?utf-8?Q?zX3YuOct5qAZN/2UaB+luGg5t6L6/s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 02:52:38.5900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9273a7a-2e73-4767-6f94-08dd6b481ab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

On 3/24/2025 8:22 PM, K Prateek Nayak wrote:
> Hello folks,
> 
> Some updates.
> 
> On 3/24/2025 6:49 PM, K Prateek Nayak wrote:
>>>
>>> Per syzbot this attempt did not work out either.
>>>
>>> I think the blind stabs taken by everyone here are enough.
>>>
>>> The report does not provide the crucial bit: what are the other
>>> threads doing. Presumably someone else is stuck somewhere, possibly
>>> not even in pipe code and that stuck thread was supposed to wake up
>>> the one which trips over hung task detector. Figuring out what that
>>> thread is imo the next step.
>>>
>>> I failed to find a relevant command in
>>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md
>>>
>>> So if you guys know someone on syzkaller side, maybe you can ask them
>>> to tweak the report *or* maybe syzbot can test a "fix" which makes
>>> hung task detector also report all backtraces? I don't know if that
>>> can work, the output may be long enough that it will get trimmed by
>>> something.
>>>
>>> I don't have to time work on this for now, just throwing ideas.
>>
>> I got the reproducer running locally. Tracing stuff currently to see
>> what is tripping. Will report back once I find something interesting.
>> Might take a while since the 9p bits are so far spread out.
>>
> 
> So far, with tracing, this is where I'm:
> 
> o Mainline + Oleg's optimization reverted:
> 
>      ...
>      kworker/43:1-1723    [043] .....   115.309065: p9_read_work: Data read wait 55
>      kworker/43:1-1723    [043] .....   115.309066: p9_read_work: Data read 55
>      kworker/43:1-1723    [043] .....   115.309067: p9_read_work: Data read wait 7
>      kworker/43:1-1723    [043] .....   115.309068: p9_read_work: Data read 7
>             repro-4138    [043] .....   115.309084: netfs_wake_write_collector: Wake collector
>             repro-4138    [043] .....   115.309085: netfs_wake_write_collector: Queuing collector work
>             repro-4138    [043] .....   115.309088: netfs_unbuffered_write: netfs_unbuffered_write
>             repro-4138    [043] .....   115.309088: netfs_end_issue_write: netfs_end_issue_write
>             repro-4138    [043] .....   115.309089: netfs_end_issue_write: Write collector need poke 0
>             repro-4138    [043] .....   115.309091: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>   kworker/u1030:1-1951    [168] .....   115.309096: netfs_wake_write_collector: Wake collector
>   kworker/u1030:1-1951    [168] .....   115.309097: netfs_wake_write_collector: Queuing collector work
>   kworker/u1030:1-1951    [168] .....   115.309102: netfs_write_collection_worker: Write collect clearing and waking up!
>      ... (syzbot reproducer continues)
> 
> o Mainline:
> 
>     kworker/185:1-1767    [185] .....   109.485961: p9_read_work: Data read wait 7
>     kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read 7
>     kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read wait 55
>     kworker/185:1-1767    [185] .....   109.485963: p9_read_work: Data read 55
>             repro-4038    [185] .....   114.225717: netfs_wake_write_collector: Wake collector
>             repro-4038    [185] .....   114.225723: netfs_wake_write_collector: Queuing collector work
>             repro-4038    [185] .....   114.225727: netfs_unbuffered_write: netfs_unbuffered_write
>             repro-4038    [185] .....   114.225727: netfs_end_issue_write: netfs_end_issue_write
>             repro-4038    [185] .....   114.225728: netfs_end_issue_write: Write collector need poke 0
>             repro-4038    [185] .....   114.225728: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>     ... (syzbot reproducer hangs)
> 
> There is a third "kworker/u1030" component that never gets woken up for
> reasons currently unknown to me with Oleg's optimization. I'll keep
> digging.

More data ...

I chased this down to p9_client_rpc() net/9p/client.c specifically:

         err = c->trans_mod->request(c, req);
         if (err < 0) {
                 /* write won't happen */
                 p9_req_put(c, req);
                 if (err != -ERESTARTSYS && err != -EFAULT)
                         c->status = Disconnected;
                 goto recalc_sigpending;
         }

c->trans_mod->request() calls p9_fd_request() in net/9p/trans_fd.c
which basically does a p9_fd_poll().

Previously, the above would fail with err as -EIO which would
cause the client to "Disconnect" and the retry logic would make
progress. Now however, the err returned is -ERESTARTSYS which
will not cause a disconnect and the retry logic will hang
somewhere in p9_client_rpc() later.

I'll chase it a little more but if 9p folks can chime in it would
be great since I'm out of my depths here.

P.S. There are more interactions at play and I'm trying to still
piece them together.

Relevant traces:

o Mainline + Oleg's optimization reverted:

            repro-4161    [239] .....   107.785644: p9_client_write: p9_client_rpc done
            repro-4161    [239] .....   107.785644: p9_client_write: p9_pdup
            repro-4161    [239] .....   107.785644: p9_client_write: iter revert
            repro-4161    [239] .....   107.785644: p9_client_write: p9_client_rpc
            repro-4161    [239] .....   107.785653: p9_fd_request: p9_fd_request
            repro-4161    [239] ...1.   107.785653: p9_fd_request: p9_fd_request error
            repro-4161    [239] .....   107.785653: p9_client_rpc: Client disconnected (no write) <------------- "write won't happen" case
            repro-4161    [239] .....   107.785655: p9_client_write: p9_client_rpc done
            repro-4161    [239] .....   107.785655: p9_client_write: p9_client_rpc error (-5)     <------------- -EIO
            repro-4161    [239] .....   107.785656: v9fs_issue_write: Issue write done 2 err(-5)
            repro-4161    [239] .....   107.785657: netfs_write_subrequest_terminated: Collector woken up from netfs_write_subrequest_terminated
            repro-4161    [239] .....   107.785657: netfs_wake_write_collector: Wake collector
            repro-4161    [239] .....   107.785658: netfs_wake_write_collector: Queuing collector work
            repro-4161    [239] .....   107.785660: v9fs_issue_write: Issue write subrequest terminated 2
            repro-4161    [239] .....   107.785661: netfs_unbuffered_write: netfs_unbuffered_write
            repro-4161    [239] .....   107.785661: netfs_end_issue_write: netfs_end_issue_write
            repro-4161    [239] .....   107.785662: netfs_end_issue_write: Write collector need poke 0
            repro-4161    [239] .....   107.785662: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
  kworker/u1038:0-1583    [105] .....   107.785667: netfs_retry_writes: netfs_reissue_write 1
  kworker/u1038:0-1583    [105] .....   107.785668: v9fs_issue_write: v9fs_issue_write
  kworker/u1038:0-1583    [105] .....   107.785669: p9_client_write: p9_client_rpc
  kworker/u1038:0-1583    [105] .....   107.785669: p9_client_prepare_req: p9_client_prepare_req eio 1
  kworker/u1038:0-1583    [105] .....   107.785670: p9_client_rpc: p9_client_rpc early err return
  kworker/u1038:0-1583    [105] .....   107.785670: p9_client_write: p9_client_rpc done
  kworker/u1038:0-1583    [105] .....   107.785671: p9_client_write: p9_client_rpc error (-5)
  kworker/u1038:0-1583    [105] .....   107.785672: v9fs_issue_write: Issue write done 0 err(-5)
  kworker/u1038:0-1583    [105] .....   107.785672: netfs_write_subrequest_terminated: Collector woken up
  kworker/u1038:0-1583    [105] .....   107.785672: netfs_wake_write_collector: Wake collector
  kworker/u1038:0-1583    [105] .....   107.785672: netfs_wake_write_collector: Queuing collector work
  kworker/u1038:0-1583    [105] .....   107.785677: v9fs_issue_write: Issue write subrequest terminated 0
  kworker/u1038:0-1583    [105] .....   107.785684: netfs_write_collection_worker: Write collect clearing and waking up!
            repro-4161    [239] .....   107.785883: p9_client_prepare_req: p9_client_prepare_req eio 1
            ... (continues)

o Mainline:

            repro-4161    [087] .....   123.474660: p9_client_write: p9_client_rpc done
            repro-4161    [087] .....   123.474661: p9_client_write: p9_pdup
            repro-4161    [087] .....   123.474661: p9_client_write: iter revert
            repro-4161    [087] .....   123.474661: p9_client_write: p9_client_rpc
            repro-4161    [087] .....   123.474672: p9_fd_request: p9_fd_request
            repro-4161    [087] .....   123.474673: p9_fd_request: p9_fd_request EPOLL
            repro-4161    [087] .....   123.474673: p9_fd_poll: p9_fd_poll rd poll
            repro-4161    [087] .....   123.474674: p9_fd_poll: p9_fd_request wr poll
            repro-4161    [087] .....   128.233025: p9_client_write: p9_client_rpc done
            repro-4161    [087] .....   128.233033: p9_client_write: p9_client_rpc error (-512)     <------------- -ERESTARTSYS
            repro-4161    [087] .....   128.233034: v9fs_issue_write: Issue write done 2 err(-512)
            repro-4161    [087] .....   128.233035: netfs_write_subrequest_terminated: Collector woken
            repro-4161    [087] .....   128.233036: netfs_wake_write_collector: Wake collector
            repro-4161    [087] .....   128.233036: netfs_wake_write_collector: Queuing collector work
            repro-4161    [087] .....   128.233040: v9fs_issue_write: Issue write subrequest terminated 2
            repro-4161    [087] .....   128.233040: netfs_unbuffered_write: netfs_unbuffered_write
            repro-4161    [087] .....   128.233040: netfs_end_issue_write: netfs_end_issue_write
            repro-4161    [087] .....   128.233041: netfs_end_issue_write: Write collector need poke 0
            repro-4161    [087] .....   128.233041: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
  kworker/u1035:0-1580    [080] .....   128.233077: netfs_retry_writes: netfs_reissue_write 1
  kworker/u1035:0-1580    [080] .....   128.233078: v9fs_issue_write: v9fs_issue_write
  kworker/u1035:0-1580    [080] .....   128.233079: p9_client_write: p9_client_rpc
  kworker/u1035:0-1580    [080] .....   128.233099: p9_fd_request: p9_fd_request
  kworker/u1035:0-1580    [080] .....   128.233101: p9_fd_request: p9_fd_request EPOLL
  kworker/u1035:0-1580    [080] .....   128.233101: p9_fd_poll: p9_fd_poll rd poll
  kworker/u1035:0-1580    [080] .....   128.233101: p9_fd_poll: p9_fd_request wr poll
            (Hangs)

-- 
Thanks and Regards,
Prateek


