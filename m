Return-Path: <linux-fsdevel+bounces-44881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA527A6DFE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE08217106E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584E263C85;
	Mon, 24 Mar 2025 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dl39hFLj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2DE261380;
	Mon, 24 Mar 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834194; cv=fail; b=ATgXg1XHAQyy+rxsdW4KhVlMK1LPnEwZ8UFWSxZ5ZkjNtvEc3ncX+qUTdjiFogA0TvGvclpnvBcmacH+LoLuYr1bAYGZW66BxnRYw5EMLx9GvrsU06Z1Gjdq+Iph9SDPIw4o29Nyyl/Z5F1XUYOwTCb6DKQv9/xXCuwYLYXOxLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834194; c=relaxed/simple;
	bh=oCEn3jRNPNehwQB5WFa0UMuKZVbRPL18fOgQnuUI3ZM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=qIEPvqugEwh7v9Vnx0N3uKb8TiVbreVK7nI2b5t42+lhRTwJoZToKAC8Tvm4rMqVnrrn2AHnvnDJ4rYSmgdNCTOCWdg35ZSg4G0PAVZPrMy75A/kB8ebEfoKDHyUN8TVfNbRPVH7I8e3qEPsTYAijZrAKZNfNHnc2x1nfRKK0w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dl39hFLj; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUWTncqetaJmfsOc12f1bH/LZ582ZM4BMU0qGTFmIFL6NJS8+eqqoz2yI26qyL/P6xusKqa+fZZF4ft36Pxy12R62lDpT0q6WTuwwV6Xu+jyVZ5J3/3F9hMOvRK4xL9wOGjJtq8djZ4E+cJvEaNCHHXI64A/6kGDPe88TZE4xTVKhpixnslR6iMAQCgyZfooyXt6uYd8gXeheFT+xe5jLKPuCXmx0m3XuPEyAQVw5Msxucxzncw+F7+4jW7ovQ6rxlVVH+ItnJFpiur8hFtNNuUnCAvU0duDj0G43BDM6Z8gmSW/MNQd0xrC3x5Wl+PkJ8yKMmNjv4Caa/2LkOpZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhGmZQTgiLPZ1W1OhAur0TXWOWkrOrPBVOe6h27CqnQ=;
 b=NoOK05F6xnBUGUZKNk6LSTQWp1ZcrykpIDSgpsqZJJUAmhNUBWWC1NXG9m6zW7z9KkBl63eDJJBQ/CwauT1rh2N5wtQVlgvDdIUf99/74yG97CYlRv38GiJ8onsWJIYyL9qBV/rfhxEtx3SyMnm2w9Cnwo+0Els984aOeuYI60SE7IIlWiSQbNXUYeVCy1vGI4MV1LSo2cEvUu2h+co2fnLHmsEwZgJfLFZ19+DfhbbM57zF7rcwfnn0xyz9X/BCLoIcPvyb5QT37KFQaPUw/Km5ZBCjtfTZGAyNmVSa1u/3W93gV90j4DkEasJqLK/4GVQp0YC+H2WVjPV3BhBqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhGmZQTgiLPZ1W1OhAur0TXWOWkrOrPBVOe6h27CqnQ=;
 b=dl39hFLjHiUorvgpRdDLOvYVNi/XFhT/siPxX0rw7j1HC7+GOj29RvqTn21wCAJsGv98cmffJhMek9/dvATPZM5V21727uKYHykogAnhoGKeCQpl8LCAoCKLMjziJ7BOOmBztID6uqiny1PIMUoRG5ICL1AsFNOD/5i6iBzuGaw=
Received: from CY5PR19CA0084.namprd19.prod.outlook.com (2603:10b6:930:69::20)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:36:28 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::ba) by CY5PR19CA0084.outlook.office365.com
 (2603:10b6:930:69::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 16:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 16:36:27 +0000
Received: from [10.252.90.31] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 11:36:23 -0500
Message-ID: <569a9447-aec8-4afa-a709-caac6c6804fa@amd.com>
Date: Mon, 24 Mar 2025 22:06:20 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: Oleg Nesterov <oleg@redhat.com>, syzbot
	<syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
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
 <CAGudoHGdOf35YM013VjGKQJF81OeMN6XQfkx8oF7PKLe08CjDQ@mail.gmail.com>
 <8fbd6f22-2086-4cf7-923f-ac95688c8ddf@amd.com>
Content-Language: en-US
In-Reply-To: <8fbd6f22-2086-4cf7-923f-ac95688c8ddf@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 27853c96-0d42-4557-7da1-08dd6af20650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEpqb0lHUnh4NURzMXRYNVVCNHFvaW1tNEVFRjFmMk9JNDk1QWx6ZTRjUm94?=
 =?utf-8?B?SjdVU1UxVG1maGlqcTNldW4yc0MvWE1icFhqclM2QmRPakRRU0thUVZzRVpD?=
 =?utf-8?B?YWxTSmpBUG1ZTndZemdHcUpFUXBMcnJOMWlCWloxVjNma1JxbDVqeVBhZWtV?=
 =?utf-8?B?WlBldDBOWG9BWlJlQm1CRXF0SC9iZElRNGN6NytXYlBkNVJxWDZZclp6Yldl?=
 =?utf-8?B?bG0vcjFiM0o0OWN0dHJ4MlRFMUZpS1JNeGliTEkrclpFWVdodTJaRzNxNTRN?=
 =?utf-8?B?MVFrUXJycVJJbVJUa0p2Uk5NWVFlREpEMVc5TmxYNFJZNnY3QlJBZXlMdzhN?=
 =?utf-8?B?WDI4dDRVdXdrRlJjVERvWitDSTZxZWMyWkxramRuY3JCL2pEVnN5Y3VEbHRr?=
 =?utf-8?B?aS9QcE1OQ2lDQ21FcmxVdnZPN0tpTk1ObXhpUy9IY2ZHMGlIYXZ3NmkwZFpR?=
 =?utf-8?B?WTFHdmVBV0RNRVBZdnUrQUljWUtkRHEydzNJN3d1c1liTmJJUEMyMThaWnVs?=
 =?utf-8?B?cmNuMVVtUzF0UmpQMlJtM3dsNGdpei9LNWpUQm5aaEpDTGtaMHBBa0FqeTFF?=
 =?utf-8?B?aHFlYVF1NDRyajFFYVhyRlF3eXN5ZWl6THNDTDIzRUZjVGxsTC9UZlhkd0li?=
 =?utf-8?B?Nmx5TXA0M0ZXOEpRcTArcHVtZElZc1ZiQXhwdkVDUUROTVIvdVlpN2E1VFR4?=
 =?utf-8?B?N1dMUjBKVmRJbStuVHdpUnEvU0dhd0RPaW9EUDE4Rmx1QnJlZUFlK1htYm9B?=
 =?utf-8?B?UzUyVVIwaEtyNzZhcGZvc255WC85SklBOUJhNFpXZk9IRnNpSm9pWEw1bWpt?=
 =?utf-8?B?Q2UxbFN5UG82aitsZERLaUlaVnViamE5KzM3TUYxaXI0QmRxdjlCc3p3MUpU?=
 =?utf-8?B?S1RjbEtra3VyRjMzN3BWZE5OZVpXZi90OEdiT1NteFBsaTIrRm5NVkQ2NTha?=
 =?utf-8?B?T0x3eUNNOGllM1o0Ynl1c3pFK2xidC9DaTQxV09IQVZSZ1BnNHEyRSsvWjBL?=
 =?utf-8?B?S3B3Y0NzNHJobDY4VW8rRnluS21SeGgrREhZczlXWlRDTUo5dDBzS1V2UnZz?=
 =?utf-8?B?SXI3VXBJRFd6SnNEeWVFMExGM3ZibG1tUGUvQ09hYVd1UVlLRm5PS0pKZ1V3?=
 =?utf-8?B?aWNvVHBWRjd5NzRqUkNkYTNXN25EQTJabngwNzI2bEtOQlJhY2JPek94Y2du?=
 =?utf-8?B?ZzBNTnB4TEVLd2R1a2VCVmFJbmVIT21BMUlkcFNuNnptMG5taTZkWGxaSS92?=
 =?utf-8?B?ekxZNW5wbW15MTl5cjNBdktwM293TEZ1VDM4M21xWStXTU9GRzlWR3BtMkRU?=
 =?utf-8?B?TDhGcHJiU2dTaWxRazFjZEVXbjNiVnhlZlBwamlnVTQxZW45SzBtd3M3YWpY?=
 =?utf-8?B?WXdDMkJzU3RaTEwwanpUZDBLNWxBMVJiRnpudllCWHpENWJmb0FpSThXT0pN?=
 =?utf-8?B?MUdzemxiaFVSNVV4ejJkUEJEejU0RE1jcEFaOUlvNG4rb2RiQ0pQalAxVUtM?=
 =?utf-8?B?eHNENVEzTFZOS29SUjNKOTErZ0c4bXlmdjlrYjJWNFJLenQwdFo1OHJMcTlI?=
 =?utf-8?B?UUpidHJDTjBaY1kxWXlnVCtmL3NRSTUzQjZzRDJaQXhzUXVPaEdPTWxnZ1JZ?=
 =?utf-8?B?bVp2Z2NOZ0E3L2NPK2l1cktwdHJESEg3bFZYdiswOVQxVHVOV3kyaWQyQmRZ?=
 =?utf-8?B?R0ZaMnVOWXpEaFBLa0VCVnQrd1RCREIxQnhCZHhVWTJrdkJqY0JhcW5MUSt3?=
 =?utf-8?B?Y05KeE52dFBvbVJ6VG9NMWdRbnlsaEkwMnFDR0dHQitJam1uSk51eTNmYVhR?=
 =?utf-8?B?QjBvSTNlQUNna2c2VVhGMWpzQk5OL3hMblFMNTRGZXpnckcvRnp0OU5rZG9C?=
 =?utf-8?B?cTBoUG0vdVB0OHQ2V0hYcEJ6bFFXRk5wcXcrZUtDU2NPZzNlQ1NYbEdnVHor?=
 =?utf-8?B?dnkvT3lXc2U0K2kxaDBnMkFvb28rUncvaFplY1lUaU1GRHRuL1dVQVJHZjRm?=
 =?utf-8?B?blZYZlFRR1pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:36:27.5640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27853c96-0d42-4557-7da1-08dd6af20650
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075



On 3/24/2025 9:55 PM, K Prateek Nayak wrote:
> Hello Mateusz,
> 
> On 3/24/2025 9:33 PM, Mateusz Guzik wrote:
>> On Mon, Mar 24, 2025 at 3:52 PM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>> So far, with tracing, this is where I'm:
>>>
>>> o Mainline + Oleg's optimization reverted:
>>>
>>>       ...
>>>       kworker/43:1-1723    [043] .....   115.309065: p9_read_work: Data read wait 55
>>>       kworker/43:1-1723    [043] .....   115.309066: p9_read_work: Data read 55
>>>       kworker/43:1-1723    [043] .....   115.309067: p9_read_work: Data read wait 7
>>>       kworker/43:1-1723    [043] .....   115.309068: p9_read_work: Data read 7
>>>              repro-4138    [043] .....   115.309084: netfs_wake_write_collector: Wake collector
>>>              repro-4138    [043] .....   115.309085: netfs_wake_write_collector: Queuing collector work
>>>              repro-4138    [043] .....   115.309088: netfs_unbuffered_write: netfs_unbuffered_write
>>>              repro-4138    [043] .....   115.309088: netfs_end_issue_write: netfs_end_issue_write
>>>              repro-4138    [043] .....   115.309089: netfs_end_issue_write: Write collector need poke 0
>>>              repro-4138    [043] .....   115.309091: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>>>    kworker/u1030:1-1951    [168] .....   115.309096: netfs_wake_write_collector: Wake collector
>>>    kworker/u1030:1-1951    [168] .....   115.309097: netfs_wake_write_collector: Queuing collector work
>>>    kworker/u1030:1-1951    [168] .....   115.309102: netfs_write_collection_worker: Write collect clearing and waking up!
>>>       ... (syzbot reproducer continues)
>>>
>>> o Mainline:
>>>
>>>      kworker/185:1-1767    [185] .....   109.485961: p9_read_work: Data read wait 7
>>>      kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read 7
>>>      kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read wait 55
>>>      kworker/185:1-1767    [185] .....   109.485963: p9_read_work: Data read 55
>>>              repro-4038    [185] .....   114.225717: netfs_wake_write_collector: Wake collector
>>>              repro-4038    [185] .....   114.225723: netfs_wake_write_collector: Queuing collector work
>>>              repro-4038    [185] .....   114.225727: netfs_unbuffered_write: netfs_unbuffered_write
>>>              repro-4038    [185] .....   114.225727: netfs_end_issue_write: netfs_end_issue_write
>>>              repro-4038    [185] .....   114.225728: netfs_end_issue_write: Write collector need poke 0
>>>              repro-4038    [185] .....   114.225728: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>>>      ... (syzbot reproducer hangs)
>>>
>>> There is a third "kworker/u1030" component that never gets woken up for
>>> reasons currently unknown to me with Oleg's optimization. I'll keep
>>> digging.
>>>
>>
>> Thanks for the update.
>>
>> It is unclear to me if you checked, so I'm going to have to ask just
>> in case: when there is a hang, is there *anyone* stuck in pipe code
>> (and if so, where)?
>>
>> You can get the kernel to print stacks for all threads with sysrq:
>> echo t > /proc/sysrq-trigger
> 
> This dumps an insane amount of stuff on my console. Let me search if there
> is any reference to pipe somewhere in there.

Only pipe_read() and pipe_write() pairs I found were for:

[ 1043.618621] task:containerd      state:S stack:0     pid:3567  tgid:3475  ppid:1      task_flags:0x400040 flags:0x00000002
[ 1043.629673] Call Trace:
[ 1043.632133]  <TASK>
[ 1043.634252]  __schedule+0x436/0x1620
[ 1043.637832]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1043.642638]  ? syscall_exit_to_user_mode+0x51/0x1a0
[ 1043.647538]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1043.652347]  ? __smp_call_single_queue+0xc7/0x150
[ 1043.657072]  schedule+0x28/0x110
[ 1043.660320]  futex_wait_queue+0x69/0xa0
[ 1043.664176]  __futex_wait+0x13c/0x1b0
[ 1043.667863]  ? __pfx_futex_wake_mark+0x10/0x10
[ 1043.672325]  futex_wait+0x68/0x110
[ 1043.675747]  ? __x64_sys_futex+0x77/0x1d0
[ 1043.679775]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1043.684585]  ? pipe_write+0x42c/0x630                   <----------- here
[ 1043.688269]  ? copy_fpstate_to_sigframe+0x330/0x3d0
[ 1043.693167]  do_futex+0x13c/0x1d0
[ 1043.696501]  __x64_sys_futex+0x77/0x1d0
[ 1043.700359]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1043.705170]  ? vfs_write+0x376/0x420
[ 1043.708767]  do_syscall_64+0x6f/0x110
[ 1043.712449]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1043.717259]  ? ksys_write+0x90/0xe0
[ 1043.720768]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1043.725579]  ? syscall_exit_to_user_mode+0x51/0x1a0
[ 1043.730475]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1043.735288]  ? do_syscall_64+0x7b/0x110
[ 1043.739144]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1043.743953]  ? irqentry_exit_to_user_mode+0x2e/0x160
[ 1043.748935]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

and

[ 1048.980518] task:dockerd         state:S stack:0     pid:3591  tgid:3582  ppid:1      task_flags:0x400040 flags:0x00000002
[ 1048.991569] Call Trace:
[ 1048.994024]  <TASK>
[ 1048.996143]  __schedule+0x436/0x1620
[ 1048.999741]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.004554]  ? get_nohz_timer_target+0x2a/0x180
[ 1049.009101]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.013911]  ? timerqueue_add+0x6a/0xc0
[ 1049.017768]  schedule+0x28/0x110
[ 1049.021017]  schedule_hrtimeout_range_clock+0x78/0xd0
[ 1049.026088]  ? __pfx_hrtimer_wakeup+0x10/0x10
[ 1049.030470]  do_epoll_wait+0x666/0x7d0
[ 1049.034245]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.039053]  ? __pfx_ep_autoremove_wake_function+0x10/0x10
[ 1049.044556]  do_compat_epoll_pwait.part.0+0xc/0x70
[ 1049.049368]  __x64_sys_epoll_pwait+0x83/0x140
[ 1049.053746]  do_syscall_64+0x6f/0x110
[ 1049.057425]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.062235]  ? do_syscall_64+0x7b/0x110
[ 1049.066079]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.070887]  ? do_futex+0xc2/0x1d0
[ 1049.074309]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.079120]  ? __x64_sys_futex+0x77/0x1d0
[ 1049.083151]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.087958]  ? current_time+0x31/0x130
[ 1049.091731]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.096539]  ? inode_update_timestamps+0xc8/0x110
[ 1049.101264]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.106074]  ? generic_update_time+0x51/0x60
[ 1049.110365]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.115173]  ? touch_atime+0xb5/0x100
[ 1049.118857]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.123671]  ? pipe_read+0x3fe/0x480                   <----------- here
[ 1049.127265]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.132073]  ? ep_done_scan+0xab/0xf0
[ 1049.135757]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.140567]  ? do_epoll_wait+0xe1/0x7d0
[ 1049.144425]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.149234]  ? do_compat_epoll_pwait.part.0+0xc/0x70
[ 1049.154218]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.159027]  ? __x64_sys_epoll_pwait+0x83/0x140
[ 1049.163577]  ? do_syscall_64+0x7b/0x110
[ 1049.167433]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.172243]  ? syscall_exit_to_user_mode+0x51/0x1a0
[ 1049.177141]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.181951]  ? do_syscall_64+0x7b/0x110
[ 1049.185811]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.190619]  ? ksys_read+0x90/0xe0
[ 1049.194025]  ? do_syscall_64+0x7b/0x110
[ 1049.197877]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.202682]  ? syscall_exit_to_user_mode+0x51/0x1a0
[ 1049.207579]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.212391]  ? do_syscall_64+0x7b/0x110
[ 1049.216243]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.221053]  ? do_syscall_64+0x7b/0x110
[ 1049.224900]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1049.229703]  ? do_syscall_64+0x7b/0x110
[ 1049.233561]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

-- 
Thanks and Regards,
Prateek


