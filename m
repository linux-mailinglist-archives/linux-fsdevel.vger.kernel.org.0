Return-Path: <linux-fsdevel+bounces-44871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323AAA6DD76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 15:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F7A18841C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 14:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3026136E;
	Mon, 24 Mar 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZBD8CGds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307225FA33;
	Mon, 24 Mar 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827978; cv=fail; b=cdKuYzV5l7BVFPEUWHJeP57TxNN0FyWNxqpAnsh5Ppqm7aAgat54ogY+OIdpR5CZZ/lvK9KcKo4JjK+CpDYIitdG9+E1bjcDga7BtocTSaAUwD0/6wEA6dOylpICdyoiBtCxz0iPldb0m3OOC9VWNLuPKKl+3wjRD1+L/38jIyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827978; c=relaxed/simple;
	bh=cF52773kte2rGBPyuR/oCDTVnNcTfLKO4VBzhwra4GQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=qu326t/KVxD8IRjKmihB7wdCwh01Sf6gKN+O/kCZoeINf2six7VLfTke7UKYXnN4+ISzuHTIMiE3ylbi6MzqCqoGOpQbXTEX2aIVNeQH8zVtgXRzm/WRfTaL2RVxYUOcERoZKKaJg7e2xUh9aFqEV6It8Gj+M+zQ1LxC0o8QbpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZBD8CGds; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqQc4NTDQYcwDEDTkGTdDJOBDQgPsmFTEFox4/4n1l/ocSmkOM8TywjoQPJX0pTtyD13y4uac9tQvzPjEIkuqZ8YgrzhWafmcw5RZnI1zDORr+1n8dmWSyiZPe+F8VzOx7E/4ETWm1fhX67BLmRVxOmVT9IQIhWWOb95uZKPJY37Pqm3/Ji8pw3IGSR5vhSgRVaejyi5w0OaglHtZiH5xZPtirmBmWma4lVq884ybbepLI1rMmBX/lzgZVLC0r8pgI7E1uVpjEwsNmM07RSS5FDcDL34x5fD85gLpSbTXWtlOZbOWMJP+U7FFEtG3Fw5jxOw8ublwQT8FpiCxT5ToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydZ+/XW+/lksHcvfKlJe0MqRUM65EDxihesQxkDiuTk=;
 b=fvByEYo/zxyRpolIoM2DOzFp3LweJRpVQQLjbY/BY8ePjCiqp1BFgsPRY2fan3ycFdkY8IKpvvsrR3Z7B/bOs93RXsKAP3mNUbab/6XkLm6wE6kLkjuzzMMIu1L8e07C0+suTqxnDTZbz7r76Rid7qL3SN1YLGlKV5KO12sCEPx5NmfFnujMSCoEJeA1zUnxEt85z3vvTcNBsVV78/ed9DHnnEpkftIr/N130hIho+dgqrpLAiHdy4qONj9nypHGxCUILce2DFfkAiRC9mblS7y6eIlD8STBllEk/M0IOnhmRHLv0DFyz9ZK8bS7fXsmnURk/AE0mIBInl69CzD2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydZ+/XW+/lksHcvfKlJe0MqRUM65EDxihesQxkDiuTk=;
 b=ZBD8CGdscW+xHsJA3g4HTdVY1CHS/xl6duCpXSKxLaxBBlF+mshpP9Lh95qV83J7TQ+7vfyi8BFIDS9pc/m/9StzWI1s18CIy+kgFUgyc5QOhC4PQVxH4Tj7vVDHIOcFKNBf8UroQoN7lHFfIF6YlteCxNVOWS9VJT0HsRhL8/k=
Received: from CH5P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::29)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:52:52 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::72) by CH5P223CA0008.outlook.office365.com
 (2603:10b6:610:1f3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 14:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:52:52 +0000
Received: from [10.252.90.31] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:52:48 -0500
Message-ID: <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
Date: Mon, 24 Mar 2025 20:22:40 +0530
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
Content-Language: en-US
In-Reply-To: <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 822d573b-dff0-4deb-455a-08dd6ae38d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGhCS1J5MHcycWlrTFM1bTlHMUpUZ0FaZmpFYTNoZHcvSDdFSUx2VUpTT240?=
 =?utf-8?B?QlZNSGQ2dWdoTlc3d2ZlVTBoUk5ZVDE3N0I3Zi9HY3RLUU9JakpwYTdGa3E0?=
 =?utf-8?B?ZVRyYndyT3prVUphb1hqc0t2U2VmcDMvdkk4T05iVUVXSHkySldab3RBdGlE?=
 =?utf-8?B?VjQwdTVEL0ZZL2xtNDRGWkE5L3lMeWZyTkhTWWZxOXB1TzY3Mk9rMmxnRWFC?=
 =?utf-8?B?bnFjbGZMUU02QzB4amJDbVliazczZDdKbVhZRUZUR094OVlVbHVYalM1b3RP?=
 =?utf-8?B?Zm1BN1E1Vm8yNFFLK0IzVFl6YTMzOGdwWGZFU0l4RjJxaDFDbkpPM1Jua3lv?=
 =?utf-8?B?NndoZlAwNmNYQzdDOHdkWlRybUl1MlFqSGtYSjNPSmZUU0VwaFpnRUlVN1Mr?=
 =?utf-8?B?MmVlc2ZTTmtIaWgrcXo5aFlwcUhNci80cHJMK2xUSzZSWDhOQjJvT3hLT2Ri?=
 =?utf-8?B?NTVKUjNVaW9XQVlaazhkek5McUVhOWJ1NVJzZ09pWVVQbUZhVDlRQ1ArN0Jj?=
 =?utf-8?B?SHZtTFV2YXBGRDl6L3Q2MkpnREZpSXA4MnJ5aFA3Q1RLMWQ2YlNZdDVIUkg2?=
 =?utf-8?B?dVYyaktpU3h1cHU0NlNJRE5mSEh2MHU2ak5xcVZLZkFZT21ud3ZnTGdPakZC?=
 =?utf-8?B?SXNPVTNtcUtmclllQzRnSFRqRGs0bkpsVktMcFkyWS8wWTBhOVppNnpidXcv?=
 =?utf-8?B?bWtCUWVTQVh3Q0pucXpLcUJ0azN1TjQyT1UrQ0dOaFFNZ1ZOWUxEUW9qNWIy?=
 =?utf-8?B?aTBBWTFXd09HZXBqMVFDT2hya01TekNhRVluWHhuQ2w0Qk1WNWdxZFByU1pm?=
 =?utf-8?B?VU13Vlo2VmV3T3RmRDlPWVhUdWUxT2V2VTI3bzkxdGs2VlpTb25yNDgxZnJE?=
 =?utf-8?B?Wk1tRlEvMFNkSTFoamZ4QmhVQWVxZmFEcFpYc2pmWU1DYkJqWjVYOTcyMFVx?=
 =?utf-8?B?ektRb2VRWUhOcGQwWHV6VmI0Z3BLcUluMld1RW5TV2pCY0lYK044S1VYNG5P?=
 =?utf-8?B?VXB3RmNHVDhoMzZNTzFrNkw3T2Z0UldNZVRDWVdvL0FkRDNWSVRJWUYwc01B?=
 =?utf-8?B?NnFEbXJOdWRhSEpySlM4MHBSbG14TW44RFA2MHlpNHlpNXBrN3FhRTBYVVdZ?=
 =?utf-8?B?LzU5aGp5cXdURjRjbmVBR2JHeWcvNk9pckVnSXY5a1VsNVNyZmRIS2lpekxM?=
 =?utf-8?B?dWZ1cHp3NVczU3dmLzdjT2I2czJXU2FEMUg3cjg3Q0plcFhUMEdnRzZPWkJh?=
 =?utf-8?B?UVVwTjhLWlBEZFBrbEFOb3htWFVJTkxGenN5UmNOUHNHdmovcVlSV21RZHNv?=
 =?utf-8?B?VFVyMXdkaGIyU0pWVnBYVkREQ3VzTVZOejdYWk10cThtQSsyZGJvd1V3ckZL?=
 =?utf-8?B?K0J6VVlWempCalJ4Y1ZadnpvaDJFaHc0Z0cyT2V5T1R3STR2K21WVGM3Nk16?=
 =?utf-8?B?YU50UTRjTDRyNkNMaTNDT2Y1NFhhRTRLdEo3K3JwdGpQKy9uU2NuQ29CRlRZ?=
 =?utf-8?B?em8yanFYeTNEbVAwb0lwK1UyVDk2bUZZekk5OFRnYWxTVHF1cHlobS9sWUZW?=
 =?utf-8?B?Y3JmeVpzbXd1U21xZE9Nczg3UW5ra1dVZndOQ2RibFdPK0ppcWZrTEhYeXB1?=
 =?utf-8?B?V2NzdDdLNGU2Z1kzR1lLb1RodkxhSUM3cjZ5dGlBMElKc2pzdG1qb2hSOWJX?=
 =?utf-8?B?STV5bVdmMkVydndRMDAwYXptdWxhRk81V2gyaXJCald2cUVNQ3lHVTBpZ24v?=
 =?utf-8?B?T0paLzdiU3Nwcm5sWk82UHZQVjNOblRWTHdZSndNbFZCSFFCL1doZ0xZUGFJ?=
 =?utf-8?B?VytXMkNvbUxuYTBDbUxpT2l6ZnBHZzdTRm45ZDNYNmVsbmpSdGx2OWVlRHIr?=
 =?utf-8?B?UkxNbkpMaHNJSE9VMXovYUVXNm1zQ2FYSUg5bERTVjVNdGh1ZEFqVnRSWENh?=
 =?utf-8?B?S21wS0lzMU5PT2krR01rTU5yY0IwYkFvYW9CT1Y4TlNXbHNiT2RJVlM2VEQv?=
 =?utf-8?Q?cBOCHYbGTXJOssqEA47WN3mXbE9Ckk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:52:52.1868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822d573b-dff0-4deb-455a-08dd6ae38d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951

Hello folks,

Some updates.

On 3/24/2025 6:49 PM, K Prateek Nayak wrote:
>>
>> Per syzbot this attempt did not work out either.
>>
>> I think the blind stabs taken by everyone here are enough.
>>
>> The report does not provide the crucial bit: what are the other
>> threads doing. Presumably someone else is stuck somewhere, possibly
>> not even in pipe code and that stuck thread was supposed to wake up
>> the one which trips over hung task detector. Figuring out what that
>> thread is imo the next step.
>>
>> I failed to find a relevant command in
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md
>>
>> So if you guys know someone on syzkaller side, maybe you can ask them
>> to tweak the report *or* maybe syzbot can test a "fix" which makes
>> hung task detector also report all backtraces? I don't know if that
>> can work, the output may be long enough that it will get trimmed by
>> something.
>>
>> I don't have to time work on this for now, just throwing ideas.
> 
> I got the reproducer running locally. Tracing stuff currently to see
> what is tripping. Will report back once I find something interesting.
> Might take a while since the 9p bits are so far spread out.
> 

So far, with tracing, this is where I'm:

o Mainline + Oleg's optimization reverted:

     ...
     kworker/43:1-1723    [043] .....   115.309065: p9_read_work: Data read wait 55
     kworker/43:1-1723    [043] .....   115.309066: p9_read_work: Data read 55
     kworker/43:1-1723    [043] .....   115.309067: p9_read_work: Data read wait 7
     kworker/43:1-1723    [043] .....   115.309068: p9_read_work: Data read 7
            repro-4138    [043] .....   115.309084: netfs_wake_write_collector: Wake collector
            repro-4138    [043] .....   115.309085: netfs_wake_write_collector: Queuing collector work
            repro-4138    [043] .....   115.309088: netfs_unbuffered_write: netfs_unbuffered_write
            repro-4138    [043] .....   115.309088: netfs_end_issue_write: netfs_end_issue_write
            repro-4138    [043] .....   115.309089: netfs_end_issue_write: Write collector need poke 0
            repro-4138    [043] .....   115.309091: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
  kworker/u1030:1-1951    [168] .....   115.309096: netfs_wake_write_collector: Wake collector
  kworker/u1030:1-1951    [168] .....   115.309097: netfs_wake_write_collector: Queuing collector work
  kworker/u1030:1-1951    [168] .....   115.309102: netfs_write_collection_worker: Write collect clearing and waking up!
     ... (syzbot reproducer continues)

o Mainline:

    kworker/185:1-1767    [185] .....   109.485961: p9_read_work: Data read wait 7
    kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read 7
    kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read wait 55
    kworker/185:1-1767    [185] .....   109.485963: p9_read_work: Data read 55
            repro-4038    [185] .....   114.225717: netfs_wake_write_collector: Wake collector
            repro-4038    [185] .....   114.225723: netfs_wake_write_collector: Queuing collector work
            repro-4038    [185] .....   114.225727: netfs_unbuffered_write: netfs_unbuffered_write
            repro-4038    [185] .....   114.225727: netfs_end_issue_write: netfs_end_issue_write
            repro-4038    [185] .....   114.225728: netfs_end_issue_write: Write collector need poke 0
            repro-4038    [185] .....   114.225728: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
    ... (syzbot reproducer hangs)

There is a third "kworker/u1030" component that never gets woken up for
reasons currently unknown to me with Oleg's optimization. I'll keep
digging.

-- 
Thanks and Regards,
Prateek


