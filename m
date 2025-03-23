Return-Path: <linux-fsdevel+bounces-44840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C0BA6D0EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 20:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537573AC587
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1583719E7D0;
	Sun, 23 Mar 2025 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2c4zU1c8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0428E7;
	Sun, 23 Mar 2025 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759460; cv=fail; b=sFXfcr4imtF0LJayWI+6OvcffkUtHzpMJ68uHolJjHC8KCvaGJpkg3FJsYG3skrEU3yTQ2y6FUO4+ajhDgu/y1Q3UrDH7M1KJDq/jjqs44ChMZ3Iq81vlPUYE+wQLVzkeaxY5d3f+WAj24b/k1uPuVjhoCPevy+yV2J9LR1Uvbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759460; c=relaxed/simple;
	bh=z55Gz56za39C3sjAP9Lb4zTVymqC0X6JHvt2n+NVXHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eHbYfTSbmEGrH+fyx2xvpy7nt5Xugw67+o/bF0WanOO48MJ3ETnz+sERfD1uo87HRlnNDq0R7QLXYAsXmKxcK5o0ALK64bjdCTtB+gsyj27mcUQxeQDoGFbEPmGOAIwjRcwdZhw4FdDHVFC6mgzxc+FMhFTfg+yN4skdQK2tGaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2c4zU1c8; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+G6pM3V6OHoF5ZYZ3olXLq7zHiNbwFRvW/wpI3qyhmAASf2HzYBxPopAx63pAaPg9DrZaLr6hpz5flaVPfyzmV1Puj89OCXvvXSqysYHDhXfU1XoaCU8G1VXgGrQOWAKVSxCQBfSFzCwTU1+GprKmbvaGIRdiAoyp/CfIUQdYLMqAksXxWaQ0v5x9Jnqd49h6dKyJ9NOmlARviGuazl5z8eALFu0kyWb3Z91ikeBtK1rJsBnO/qNAjO0F0CI66DcOND3gRB9TfxljIS5da2bIBqP64sXjLnntK2ZTx1Hy0wVYWl5EQ+zfYuD2g05MfXR9Uh4ulKWi/xp5dOZdfdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bioPFA65gArxZ5kNg6BQB/qc6THJBJWwxanL9UTbMrw=;
 b=zDpB/dwqrFOhJr8PSgg58fKw6glZVrHlfWU/Znif9BKgR4mA/JGcu4i0JS/ckFecdf391oVGnoFS1ieWbHt7AdXiGjDRxJ7dGTWslDOfvBk6dTixjQ3s8yNf5CZouiGyqYRfImXNwZFSDWIwi9Us+bl0ao50tGKj9vQ/xMQpV20eS9PBsnrUS0kq3fu5MVTGa0n6ECDemLD7LPPeRdgXsxGGKk3vCNIROB0hsA44K9ravqeLgpJIn+BteBngnBCF/sON0s12J0W4eySG+ElfLAD8Ywf67fL641itLMY3EUk7X3TVSFf6IFto4y8F7SrEhv0zDOE8TrHxeeO2fFVIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bioPFA65gArxZ5kNg6BQB/qc6THJBJWwxanL9UTbMrw=;
 b=2c4zU1c8KaKf2nj44OXevjKtWrqBUEIhgXWdAbFfT2N9/1E/UXN+g6nctUD2Jmqe5EYpk3JA0vRR/8xbwudq7SAY0bLdjbxKjZA2f/roDN8+zNiFzf8rxImJEQAfZ4rAPSCTvkBmv/mKT3WnDi74OikJFI3YZSb5FFmfo/vTeTE=
Received: from SJ0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:a03:33e::8)
 by IA1PR12MB9531.namprd12.prod.outlook.com (2603:10b6:208:596::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sun, 23 Mar
 2025 19:50:56 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::dc) by SJ0PR03CA0033.outlook.office365.com
 (2603:10b6:a03:33e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Sun,
 23 Mar 2025 19:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 23 Mar 2025 19:50:54 +0000
Received: from [10.252.90.31] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 23 Mar
 2025 14:50:50 -0500
Message-ID: <791d5b5a-3204-41cf-8796-b26018824333@amd.com>
Date: Mon, 24 Mar 2025 01:20:47 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: Oleg Nesterov <oleg@redhat.com>, syzbot
	<syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
CC: <brauner@kernel.org>, <dhowells@redhat.com>, <jack@suse.cz>,
	<jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mjguzik@gmail.com>, <netfs@lists.linux.dev>,
	<swapnil.sapkal@amd.com>, <syzkaller-bugs@googlegroups.com>,
	<viro@zeniv.linux.org.uk>
References: <20250323184848.GB14883@redhat.com>
 <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250323194701.GC14883@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|IA1PR12MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: 300e54d9-b91a-478b-6ec1-08dd6a44060b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHNRdHVyZEdJMlMzVzJrdUdkOVRhM0pNNmJQcnMzV1dXR2RSbTdzQ0IzaXBF?=
 =?utf-8?B?MUR0ZHRySHNxUzFFMlJ5Wkd1RHphSzlJT0NUQnFmV1pvZmR1L0pyY29vOG96?=
 =?utf-8?B?a3dRMzcrR1JJemhoSVd1Q2hyanJRSXpFRkd5YlpUZDdFWWwySGVIKzN0VnYw?=
 =?utf-8?B?R3gyWUFjRDhGVnBBd0FQYzVNSHFZS016bzZNcXJYQ2Q5RllZL29KS2I3dmYv?=
 =?utf-8?B?TEhQbVg1QkZkNVRLS1RpeHk1L21sRGR5dCtzWEh5NnJZdERiUE9xYUR4bmRo?=
 =?utf-8?B?SEFUOHVveTBvQjJOTmEyaFFHNjZ1ejc4SkVYN3NkMXhFamFhVUlaUk5mM0ZL?=
 =?utf-8?B?MElMN3pmV1JqTlFINm56clh2YjIvekduYk5iN1c4VFlka2s3MEYzQjBMWjJX?=
 =?utf-8?B?RVIyank3SGlpWEVKS3A1K3FpcHNvbDVrczVWRlJrU1ROWlJTckRMeTlTRWNk?=
 =?utf-8?B?RmxXZTdONlhqZ0ZVeHYzSTJsdEt4ZkJENEtvWWxWaytCOGE1K3FIUEVBZFFS?=
 =?utf-8?B?a3llaXVQMWI1QTlyNFJERkZBTHBxZm1mVUxPTFBBMCswTDhPbnpJR0I2eUwy?=
 =?utf-8?B?amlTTUZOYkthN3hRYjVmV1Rzb2NVK0t4Wlc2QTdWK1VvUWx5NzJaOCtNNHFs?=
 =?utf-8?B?U3hlWCswSTRyZlhHQVp4QUlzZUhLUWh0NHF1TGZBSkJ5cTAwazhvc0U2ZWRw?=
 =?utf-8?B?L0xFYUxnT3lLVHE4SG45dHZUUk5CdGRjaXl2NTcvckR6aHVjNHZiRlZDVUlO?=
 =?utf-8?B?ditTWG1EcHFQVFZOVXV1eHR0cnhTY3BIMXd6d2hrWTFqMnhPYXhnbFRiekJX?=
 =?utf-8?B?MjdpNjgxa21tN0xWZUM4cUd4MmJkWExwamJWYmdZdktEanhRVVA2WjdmaE5E?=
 =?utf-8?B?YkJZSGtyak5IdFNVOW1WY3pvSnBOcWdmTFZ2Vzc2VFB5MkhLSVdnbUp3STlE?=
 =?utf-8?B?R1hnYVIzQ1Nna3gxNHpXMEpOejJzNjExU1ZYQ1pzODFOdThvMmRhdnh2Qm1Q?=
 =?utf-8?B?L21uY1FML3VhUjZrUWl3SVdDbXQ5bE9UbFlFS09wSmJmRFlpMkJjZ1BkN2t3?=
 =?utf-8?B?RnJTRkhkRTduc25UeE5sbVIvSWt1YlppQ3ZsdGdQQXAwOTJGZTg4R3k4ZGVq?=
 =?utf-8?B?eDVkM01HZGRsVW5iN205TERkYjh5R2dzd1hFcVBzTDNDVHkzRXNVWlBIYzN1?=
 =?utf-8?B?RllVczRPSG0rL1BpTG9mK2t3L1hUVkNwN1J0dEpwbDluQUs5YllHSjNUa1lG?=
 =?utf-8?B?K0xCNWRlNDNoNWMreVlEaHhFU1ZKV2F5WFlROUtvRHVBUElxK1FhVnNLVVU1?=
 =?utf-8?B?czZlaE9oWEFteC9NakRCOURLK1ROWGlGb1RUTkN1Qm1wcndINHVNZVB1MXVn?=
 =?utf-8?B?cVh0UkZkL2g2bGFkZEpyWDdIMlB4bWl0T09vcjlueE5BZVZMajMzRzlpaGlv?=
 =?utf-8?B?bmU0eGphVDZhcWovcFJ0RzdNY2RpZFpoaU5MK21BbkNUS2paL015bHc5bWln?=
 =?utf-8?B?YWs4TkZnT1lDQ1NGemRDRHRodktpV3JxQjlQUDJ1QWpoRXB3R1FQUTBmVHcx?=
 =?utf-8?B?Qk9NQTZtOU1DbWVMMk5oclBJeDRDdktONzYyRWhjUnhtdmhXT2IzMTJTSzV6?=
 =?utf-8?B?V0EzNjRCVlVOb0NtdHFvSE0wMXE4TWNtRmlnY3NCQkltcXRZTUQxWkplUVdB?=
 =?utf-8?B?QzFLZTgrYUEzbmFhYUQ2eElueVBvbFQ3UmJBYjJMTy9nbVBCSkNhOXlzMmor?=
 =?utf-8?B?N3JvN1pxdTFpQ1BPa0YvU3hVSXYreTQ3dlF6bVliZjY1TTVnQlJUenQwVDQ3?=
 =?utf-8?B?VlByY2dxVWxRVWJiaWlCOHhMeXhYZnorYytKcDZFKy8rR09rL2dJVmdybVha?=
 =?utf-8?B?MEJFVGFvWlkvc2VIb0lLbFZNN01QSnNUSmNpT2VKL0dzY0FQWVJmb1BVL3dZ?=
 =?utf-8?B?WjRPUCtNQW5Wa2FQbG5ZWWpaSXhGSGRGOEhwTVpaa21HNWkweE5aSHJabzY3?=
 =?utf-8?B?TUIzR09WUGJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 19:50:54.6648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300e54d9-b91a-478b-6ec1-08dd6a44060b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9531

Hello Oleg,

On 3/24/2025 1:17 AM, Oleg Nesterov wrote:
> On 03/23, syzbot wrote:
>>
>> Hello,
>>
>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>> INFO: task hung in netfs_unbuffered_write_iter
> 
> OK, as expected.
> 
> Dear syzbot, thank you.
> 
> So far I think this is another problem revealed by aaec5a95d59615523db03dd5
> ("pipe_read: don't wake up the writer if the pipe is still full").
> 
> I am going to forget about this report for now and return to it later, when
> all the pending pipe-related changes in vfs.git are merged.

P.S. I'm trying to repro this on my machine on latest upstream. Haven't
gotten lucky yet with the C reproducer with my config. I'm moving to the
the syzbot's config to see if it reveals something. If I have something
I'll report back here.

> 
> Oleg.
> 

-- 
Thanks and Regards,
Prateek


