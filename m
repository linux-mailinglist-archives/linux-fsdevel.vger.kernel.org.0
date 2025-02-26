Return-Path: <linux-fsdevel+bounces-42714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4EA468B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 18:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5611F1889037
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0300222A81D;
	Wed, 26 Feb 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GsKgoQ6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501422F3BA;
	Wed, 26 Feb 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592609; cv=fail; b=E7s+1Mkr8dRmranYo9ecI/e13j4f3FhktqJycqazJxjuYLCsjTMg3NJsRO4cECjiOVeQenFvwqD5sUCNyz/8anFkl8u5Jups8incdUIQTYSL8eq59pZrUejbRKyWAQXkiPyLGaA68KhU2L/cq61ErmMVI04wgczePlKxodiiG5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592609; c=relaxed/simple;
	bh=mNQQl6nFaudRuUsmTWikbaqV9ZIH2hDh9kBfUhxsWxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ppBAUFLSvCV02sYWS2cW6i6uLMQqm1/WRuobcpPZzaPFGvmIKd60m1E5Wn6fsvXATc7aOqr6xXEzEgxauUyuQVL/m/RiU16QM/Sg/HT8T19mKdl9dfjylyiGQqOuU4/VNikd3iHV1CrSb8x2iRLsQvoyL2X//SNfJnBrhaaxt9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GsKgoQ6B; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZC9RzVSKhcyQD5y8JbKVStwLw83CjIS1GoMz2jlHPOR/7My3bCAUBP6MV4UNiGj0lXdJwXX/R4YiJnWQY6tyNjzv12AxfeN6MRo5j8bAj9r5Vp2oCJAVBOXkMDpf638DZ9VEjExYzMlkF+52/2FUTZ/PFtjcZpFBUYBy4xMTMcSFjkEnUVfLs/bEiBuCYBlnVd5PN3VTQ+zW3IYpHBzDExl5pT49aeXCHBU/TsO7WEzKV3kkjaW0vEGsLklfVrkfihR4ZP5umAGA2al53RoYhyeSZJ66Cz+uHnRNPTK4xrdvAW3USSo11agkCf63PMa+lwuBx0b5RNECzUSoBrA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEgLyheEtAk7OqWANcgFuMp8G3y8Z0j1u7+c90I8CAA=;
 b=abPr7AsgZbkCtMHlmCxIZnjtEaeymsQGZ4jROmOCspBU4AumXIlhlSSg8YFu6mJNMmizy/K8j3oLgQQSLId8rjL5NMoWouQmYnBQhg6S6wZsoTvjyOlZnvpQPZXjqgjY13JsCI14/jZsr8TOH5dGrXvmOiSwszkdiiaICnQcokmi2EYavt7JV9GgslOhp9PgOYlGVlG3X3qwTkN2MUyDol0mEYE+YdUJM4J/IAdUp1G57ufcX06gBp5B5rBsF6SIRyXoUF+uxMBqSUY2jUoUFyuwbh4lOZRy2jd57y72JLikt1W537LdR5rnc/fl/C2K7iEZqxp6kk6FeM7CnzdHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEgLyheEtAk7OqWANcgFuMp8G3y8Z0j1u7+c90I8CAA=;
 b=GsKgoQ6BbmIYmRzXnpvqI+kCj1OqzEjexRwP2jReyYyifPB7ThiPOIqMiOEE8BwhiUC1dKa/ImZbT5lBrf7bFaC/3w/vq4i2uZqiVD0GR8K8Sp0aTJmhMSBnbu6eCcukxOUFkGUw1SshdiaTHCuc+fix1mxsM0uc8ch4Lk3ky8M=
Received: from SJ0PR05CA0209.namprd05.prod.outlook.com (2603:10b6:a03:330::34)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 17:56:43 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::dc) by SJ0PR05CA0209.outlook.office365.com
 (2603:10b6:a03:330::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Wed,
 26 Feb 2025 17:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 17:56:43 +0000
Received: from [10.252.195.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 11:56:38 -0600
Message-ID: <b8f0fc4c-7b54-4bec-b3cf-9e0b542832f4@amd.com>
Date: Wed, 26 Feb 2025 23:26:35 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
To: Oleg Nesterov <oleg@redhat.com>
CC: Manfred Spraul <manfred@colorfullife.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>, <mjguzik@gmail.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com> <20250225115736.GA18523@redhat.com>
 <2a0a8e1e-1c37-4655-8a82-54681b2a83ae@amd.com>
 <20250226113845.GB8995@redhat.com>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20250226113845.GB8995@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: b8993515-d929-48d7-7245-08dd568eede4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SktmOVpMM3oyYVlNK2F2V3JiVGNLRDJia1JHTkx0TFRvTlhpMzVuZE0yd0hl?=
 =?utf-8?B?OVoxZ0dLS0ppdFNPWnZiVHoxYWtMWjlTaGo3aTY0c1QvRFZ2S01mTmRHZ3VV?=
 =?utf-8?B?clF3a2E5UGhDdkRidjN6SloyNC9wVHNXNkQzMWVHNE41bkxmdUFVWFpqSmkr?=
 =?utf-8?B?d1RFV3lscjBZbEFLNU9YMHhSeEhUS29JalJEZFU4VXVITUZjeEY2UUNrdElk?=
 =?utf-8?B?VjhHb0Z1QVVwSE5uM2hPZE1MVU1sYVExeXROYWQ2akFCYlpPSmlSVlJZYW9s?=
 =?utf-8?B?dW9yU3Q5S3NSSklBRGduNzZpUjBTMUx6ZFlxZngrV1puZHRyYm5iQytZdFFM?=
 =?utf-8?B?TkV4L1ZpYktqdTNsUmNxZXJVS0l1SkUrQmFMRFNOMjdGdFlVNjRiQyt6YTZH?=
 =?utf-8?B?ZFFiaXNwdEg5alo2Qm4waVQ3bjUyL3I1MU1wWVo4cjdQSGlEZTJMUExVMnhT?=
 =?utf-8?B?enNMeWEzN2plWnBTcTZjdS9rT09jeHZidVE5YjIzSDNoR0NSV2c4MnR6bExV?=
 =?utf-8?B?aDltYTNBSjhDOU5zQTU1bWtvQ3FxbHQ2c3p2K1RRUUhWdHlYMUQxWHJzTTRk?=
 =?utf-8?B?bFR6c0xmWWlXUmtjSHhJUE5TR1JFTDcyVTRNMXFTcXRlN21BNXF6ZkszbmEr?=
 =?utf-8?B?M2VBN1lRcEpwb0RUTjEweGdkMVU1bmVzUkxyaEZDYXpXbnh5ZzZHWnphNDhq?=
 =?utf-8?B?S2Eycm5RVlY0QmYyVGlMazlUbzV0bm81cElBRWxlMnE4QkdWaTBvT25QVGNV?=
 =?utf-8?B?VG10RWdUcnFvaHRHZU1uZXBkOFdsb0E2d0ZBYmlJazAwNGFBWktBMG90R3oz?=
 =?utf-8?B?akV3b0YrZitZblpFVWZnbks1ZSt0OEVzTmhsUUt3NUtFVmo5UUV4Z2xpVndr?=
 =?utf-8?B?OXp1REMveTRYaGgzeGM0LzBSVXMzNTRSY0syYXpOL1c0SmNZWUlKaDlKN05J?=
 =?utf-8?B?UUNjZkh1djZubTZFWm1iMW84elZwb0NhUEtvajZ2cW1kekdCWTlST1c3NGtV?=
 =?utf-8?B?ZnNjZDkxem5yMk5rVU0wSmtjRkhHS2VmaWJDLzJneEhROTFkNEg5VVRTV0VF?=
 =?utf-8?B?U3kwSjJqUDVWb2JIMVhPSXJqSDVWZDZPWS9qUVNkQzR6bWxobnJjTDNpMEli?=
 =?utf-8?B?MlVGdXlzTEdMRGdBRFBydjY3Sm5tWUR2akZITExjVmphVm1kMi9oaGhId254?=
 =?utf-8?B?VUNWNXFEa3k1VkZQQ3hDWncxK1JsODlpV09Vd1ZxY01Ma3BNMHVIbW5sOTFI?=
 =?utf-8?B?THd2bDdmbExFMmpqNlpSNUtub0ZQTjVhVEZkWmp5WG1kTTZWMWFncjRXMDlO?=
 =?utf-8?B?Qy82TS9Sa3ZlaUNDeEdYYVB1bXViUU9mVHNZbmhWeTdzZUZmZWpmQXA4dkxU?=
 =?utf-8?B?VFBwVFBDbnNPMG1vYWd1cVlRaW1yeWNJQ0xyQmloa3cxYVl0V3loQS9lcHNO?=
 =?utf-8?B?NUJOcGhObjE5WXYrYnc1MGFUbm1ZKzZnbXBKY3ZiV0F2QUg0MXVBdnFtTzZu?=
 =?utf-8?B?V3h0QWUySzF3QlRqMTNheDU2N1RsZHRRbDZvVTgxeVhqbXBDdWhwMHNUakt3?=
 =?utf-8?B?TW8wRlVCcHFCY2tia1ZDRjUzMG1FbXcwRUJEMURGbW1haE5PMFdRTDRPSGVx?=
 =?utf-8?B?aTNCZFovc0s4ZzMxaWM5T0tIWlVBT1hqc2dCbEdXbm5SUFNER0I2aHFJVEoz?=
 =?utf-8?B?S2dNNVNsRlRCODlyM3pPU0FjUVFsdUdjRHN6WEljWWlHYkF3alcxK1RKek9Y?=
 =?utf-8?B?U3FETUR2OVhWTHFqbmhjS2pCVEZwanhmTHhqbUNGajBPWThmKzBzZEtCTHVY?=
 =?utf-8?B?elVCeVpuRkQ5RXNiTkdoZHF2Y25XeVBWMHJFMFk4dXpyTjV4QzFkLzV5c1hi?=
 =?utf-8?B?OE0vYTdXT2x5bVVVVXh3bG9pLzY3Z0RTWk1JZG1aSTZXUU81VGp4SUx5UWQ5?=
 =?utf-8?B?V0pHeUp6RGNlcVB6aGZrallEY1RxVG45bVFBZVN0UlJoS0dRK0VxZm5ZK2g1?=
 =?utf-8?Q?LwaINl37GeSZit9qJjeTgWwk4QyfAU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:56:43.1432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8993515-d929-48d7-7245-08dd568eede4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258

Hi Oleg,

On 2/26/2025 5:08 PM, Oleg Nesterov wrote:
> Thanks Sapkal!
> 
> I'll try to think. Meanwhile,
> 
> On 02/26, Sapkal, Swapnil wrote:
>>
>> Exact command with parameters is
>>
>> 	/usr/bin/hackbench -g 16 -f 20 --threads --pipe -l 100000 -s 100
> 
> Can you reproduce with "--process" rather than "--threads" ?
> 
I was able to reproduce the issue with processes also. Total 33 
processes were sleeping out of which 20 were readers and 13 were writers.

The stack trace for main hackbench process is as follows:

[<0>] do_wait+0xb5/0x110
[<0>] kernel_wait4+0xb2/0x150
[<0>] __do_sys_wait4+0x89/0xa0
[<0>] __x64_sys_wait4+0x20/0x30
[<0>] x64_sys_call+0x1bf7/0x2140
[<0>] do_syscall_64+0x6f/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

I am trying to reproduce the issue with suggestions by Mateusz.

> Oleg.
> 
--
Thanks and Regards,
Swapnil

