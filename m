Return-Path: <linux-fsdevel+bounces-42635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7830AA45520
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 06:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F56171A7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 05:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901C3266B6C;
	Wed, 26 Feb 2025 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NOCE6TmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370B7DA73;
	Wed, 26 Feb 2025 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549418; cv=fail; b=Gddmqc992FC485cU0tDLQq5Je398Dn4SgPMlZCcbWdCl8JojsN+C1lvGLhNjDALdz3W1KnLeeqR+ojuz+uNanXB1XHkX7hxeUJQT0pmBDXYfeI++vXwPUomaCypK38GOscv165icC2muzoIMwfHoN8NYAXGnxtZJVbfGp5nz9U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549418; c=relaxed/simple;
	bh=iP9HHN7aSryCZPuXbh3cbkz5l3+WszdsrLlHA25Wh4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IdS8St4dHeY8mp0HkiVqW3RIRo9BDvGTMivnanDHYCzFpSMJ5pqijWKpt3rYXOf6L0wqAWehPxe78wnTxiqLVGTJoEE8/XEB4WeE/7JRBSYGMv1RzDCWAr8vtSRHdJZvm+CMHogY2dQ87zSWL/awq57bIc+xkxa+sijr2a3CFIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NOCE6TmH; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGk9Sqi1uSXHZjtH6FJv5ULkTgKVDYdHQ+2Qnep8b998YCK7WsmzBXmqSf+nQwv3Yxp5no9iL9IRMGyI5AgfajcqZLdu5552lr/e9aLyk3cX5sN3Fs6iF+Z75w/ecmjq5snm/8BRqIsO37hcnHOCl/tK0nARJPq7E9DlHKJnwQnzqAk8C0rz2i3IhYPZ+qPaAO6tLM1oewf+U+TF99II0NJmIyWe3ckH52LKv3QKSbeBJ2ZKS6oyqF+1UPNOs6kxlCxfy9fFVNB67ja36zPzhfzTxBkNmqPlLBy8/mnvJXgHuSzqF8LdovbZIhp7diZc9AMxEuL9GsvXHSIB4nc/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjhtA2FZ8rAMEQCU5gSCmsYWtt7qckk9qcR3gl7zDYo=;
 b=gw7HsC3/EW1s20tFdtfn8G+PtsOUZuAC0uRUdIyPz8Jdx5Wuok6mX5qI9KCEvNdgs6qF5hhHHUGflwFFxDunowiKvoIASLPUM9cXkwKP6Gz2oPh4MwQtaiY0t4lx4cXeMUryQ4K/Vq5gUixmwXpsFvn4Qrr88iDztmK6swrIFkng4ZgS0LNR9dXskAzCy+v2ez9cKfC/cv04D5YN/pu3v+qDNCMaIQWDWEqz215X0TiCwoTSW2Jy6n8yA5M/oMayhb9u4ACZe1Mp7hzYnzH1OCJK8MJwL8IHkgnoOinAw22kJbgdi2eomWjWYrT+fF2XMWnjr2aQrq3c91xi21YXeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjhtA2FZ8rAMEQCU5gSCmsYWtt7qckk9qcR3gl7zDYo=;
 b=NOCE6TmHK1P89oiy5DTZpFKOojp9goma9Ras2+rGkcYutPEOztUNfBpP4m0ccGKKP//RhC/+paMKTwVXSkqtfcXLS1xCRdnaG4tkUPFxEp7OFHEn067J3A4pMPe5lS2HiYE2pV7Lv7P14n3MB3bxb+0H9y1Z+x9xR7yJCIdvScI=
Received: from MN2PR18CA0010.namprd18.prod.outlook.com (2603:10b6:208:23c::15)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 05:56:52 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::5d) by MN2PR18CA0010.outlook.office365.com
 (2603:10b6:208:23c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 05:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 05:56:52 +0000
Received: from [10.136.35.94] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 23:56:47 -0600
Message-ID: <2a0a8e1e-1c37-4655-8a82-54681b2a83ae@amd.com>
Date: Wed, 26 Feb 2025 11:25:41 +0530
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
	<gautham.shenoy@amd.com>, <Neeraj.Upadhyay@amd.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com> <20250225115736.GA18523@redhat.com>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20250225115736.GA18523@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: d8436942-87fa-4e36-906b-08dd562a5e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmpPZEJsdTJTeXYxUFFQZWljRGZrTjBQNUNwR2tDM0U2V2VwUjJrSytHNEdh?=
 =?utf-8?B?Y0tIZ2twa25KWktLMlAwcVFXZVYwbTdmSDRsMVRYeVBKNkFibDB1cjdsUFJz?=
 =?utf-8?B?WnNJQkJnbWxmNVhYak0xVGFZNzk2aDlOVDBaNmx2WHBySXozQ3JMRmxMY3hr?=
 =?utf-8?B?ODA3WU9FMzRxdnRwcmN3SEdRcWRjRjZnV3hSdmdEYjJieG9WVWhMYnRTak5U?=
 =?utf-8?B?YUIxVGlpUlVYN2lPOTM1N2s1ZklOL3pOUjM1aUplUjQzVTZ1aC83RGZkNkNt?=
 =?utf-8?B?bC9BSXdSTEF3SGZlbFVMdDVWU3JPWWl4N0lXSWlLUGY2bmorWExmUTlsUTFr?=
 =?utf-8?B?d0FPK3pGUGlCOFVza212enhSbkd5MWRMbXFta3ZxUEp4QjllRW9CU0xORjc5?=
 =?utf-8?B?eGRvYk5KbStXYm9OODI5Q1dIa3ZKUHo3WmFVYmNickFYY1JaWkZ0U2Z4UlB4?=
 =?utf-8?B?ck5heS9GL0pDYyt5KzNuV3FSNkNocmhTM3NkbWVkSkhxa0hqbkdNQXdyN0U3?=
 =?utf-8?B?c0pzMVE0RnZta1pkRUdzR0FGc0JZZzhqa2p3M2N5SnNkZDUvcGNKRU00eERy?=
 =?utf-8?B?bEcrZmx0NkM1WW1rRmNaVmdvWk1xWHpKNUEwMEVJemQvc2s4cU1OdFBwQTBS?=
 =?utf-8?B?U0pYWUNvZk1TTjVHRWtCKzNtcVp4OFAva1piL1A1WmpPYkZ4RnlGeklMelZJ?=
 =?utf-8?B?Tkp4V2hIQmVlM1ZBUmJrZFgvc1VlU0N4MWtTNnNGZ1NacWxnQk12OXdKcTk1?=
 =?utf-8?B?c0h6aEFWZlFNQlBEc2NKWkxUU1YwaWZUdGhRWkhSRnFLSkVscUVSU2lrVkta?=
 =?utf-8?B?QXlkNnA3YXRtbUllU1dDTjJhOGw0Y1hOQXBVT0xScnZtbnQvSGJXWTZEM0Vo?=
 =?utf-8?B?dzRBU3N6UHJab1RPd3RHN2F5akJNWnVxd3R1TFR3OE5ub0lSTVJLWXJZeVZE?=
 =?utf-8?B?MFhpR09YNE42TWltVzMwcUN0Nk1Zb1kzd2k0ZlArTG1PdXV6WFlDdDNPdkZw?=
 =?utf-8?B?RWJvOVh5cE1KcUVKMU1sajU4bTZIMGtkZHlNOFNRRFJTdWNBQzBkbEZiajhZ?=
 =?utf-8?B?NTlVSFRON1FLZVpIMXBxbDVyK3pidlNwcGFWNEhOdTVhRVdybXBDdkpsZjFZ?=
 =?utf-8?B?c0RwNGxkMTNrUENsMVdWQnpEY3ZMVGx2RGJiZjNLL0UySzVmZndaNm9yMENj?=
 =?utf-8?B?ZExrc2ZQbUpFRk5FT3JXejVXVEQycVhmaUR4WVk0b3Z1VlM4bXRQT1ZBWEFj?=
 =?utf-8?B?bWVvUG1wNFZvSG9FWUdjUHdMOWFKVE9NVEZOL2x0RWxhWkp1UnBLYnBsUTBG?=
 =?utf-8?B?ZGtvcUFwZjNQUXNSUFBockZvL0VjMjFGRW95c0U3SVdMZVQwczhlN3k4WkVx?=
 =?utf-8?B?NE5rcVdxUkxWQXViSlJpcWZSeSt5STk2WnRGL0h1UTViVTIyS3U5RHVMNjRZ?=
 =?utf-8?B?ZEg5V05EbU94N2tpbkxJWVhyaExGKzNndlhZYkljWEcxQmNQTk9YZHFWb1Qr?=
 =?utf-8?B?VjlCLy84cFhTc2l4dDZJbUZpNzQzNS81ZTF5QkF3NURIc2lwU3hxSUhMVm44?=
 =?utf-8?B?MFlGbHY4a3piRHQ5SkcxMmd6NDRQaDB4U1FnNERtVGlGcFZBb2crL1lnVUEy?=
 =?utf-8?B?VXJYcnBRVjRGVzFrN3FRVnJKVlkzci9vc1BHNDFwWUxpY0NPd01Nc1EwSk5D?=
 =?utf-8?B?OU14aXZDTWxaNlVxc0pyMklPd3VrL04rV0ZQWXVKNU9tOG8vK2RhN1ovdlc0?=
 =?utf-8?B?SmFzc3FwVTdsNmpCWDBiL2JSN3RHTTJwMGcwYzZWd3FiQm1NS2F2ME9uWXQ1?=
 =?utf-8?B?MEh2RWdHZTk0b3AxUEdYSksyZUR5R2FDeHpTcEJKUFJtdnp4MVJXRXRIWnlz?=
 =?utf-8?B?TGxZWHcxdFVvVWUvbUQ1SE83bFdua3B5eURnQ1VJc0NiU3Z1NGJmY1c4bm81?=
 =?utf-8?Q?lw/l8yjKB1kmvQUWr9Ga3SLn18E0oDyW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:56:52.2768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8436942-87fa-4e36-906b-08dd562a5e10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412

Hi Oleg,


On 2/25/2025 5:27 PM, Oleg Nesterov wrote:
> On 02/24, Oleg Nesterov wrote:
>>
>> Just in case, did you use
>>
>> 	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/hackbench/hackbench.c
>>
>> ?
> 
> Or did you use another version?
> 

I am running hackbench using lkp-tests which downloads hackbench source 
from same rt-tests with version 2.8.

https://github.com/intel/lkp-tests.git
https://www.kernel.org/pub/linux/utils/rt-tests/rt-tests-2.8.tar.gz

> Exactly what parameters did you use?
> 

Exact command with parameters is

	/usr/bin/hackbench -g 16 -f 20 --threads --pipe -l 100000 -s 100

> If possible, please reproduce the hang again. How many threads/processes
> sleeping in pipe_read() or pipe_write() do you see? (you can look at
> /proc/$pid/stack).
> 

In the latest hang, I saw 37 threads sleeping out of which 20 were 
sleeping in pipe_read() and 17 in pipe_write().

Main hackbench thread (which spawns the readers and writers) has the 
following stack trace:

[<0>] futex_wait_queue+0x6e/0x90
[<0>] __futex_wait+0x143/0x1c0
[<0>] futex_wait+0x69/0x110
[<0>] do_futex+0x147/0x1d0
[<0>] __x64_sys_futex+0x7c/0x1e0
[<0>] x64_sys_call+0x207a/0x2140
[<0>] do_syscall_64+0x6f/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

The readers have the following pipe_read stack trace:

[<0>] pipe_read+0x338/0x460
[<0>] vfs_read+0x308/0x350
[<0>] ksys_read+0xcc/0xe0
[<0>] __x64_sys_read+0x1d/0x30
[<0>] x64_sys_call+0x1b89/0x2140
[<0>] do_syscall_64+0x6f/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

The writers have the following pipe_write stack trace:

[<0>] pipe_write+0x370/0x630
[<0>] vfs_write+0x378/0x420
[<0>] ksys_write+0xcc/0xe0
[<0>] __x64_sys_write+0x1d/0x30
[<0>] x64_sys_call+0x16b3/0x2140
[<0>] do_syscall_64+0x6f/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

> Please pick one sleeping writer, and do
> 
> 	$ strace -p pidof_that_write
> 
> this should wake this writer up. If a missed wakeup is the only problem,
> hackbench should continue.
> 

I tried waking one of the writer and the benchmark progressed and 
completed successfully.

> The more info you can provide the better ;)
> 
> Oleg.
> 
--
Thanks and Regards,
Swapnil

