Return-Path: <linux-fsdevel+bounces-53080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA4AE9C85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0F41C26756
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 11:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B14275841;
	Thu, 26 Jun 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dy5LkT85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABDA1F2BAD;
	Thu, 26 Jun 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937401; cv=fail; b=HIH+JTtDaXT2Knn0yn/KDX4EhL6dUBzDlqUbvlRuP8nzC8f3kFDvL9V0eWRi710qGG982UiDi+LQ30rW1Kd/FrPEhdnqRJ3zc25j6cAPAWOUnOym+yamrvMVzCu1B9PYQVHAfs8CpibjlpqwTsjtFb1iHbx3OfpCTi3vgT14qJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937401; c=relaxed/simple;
	bh=Da5hIQgdTbap6EVyCAcxhAgl6B54wmVJiZn87nyynB4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=iaSLV/BYBDsdHkfvdRRwyA4PewTvWVuY7dSzCCCSteK+VqtOBZakVpUD9zcwnw2Ru+2LTgrYsXNxwlqJSptLAs7j2nMHbVKIPQbN3pE8NcZ/8cifUipTl5o4EsTS/VjEig6h1jnQ6DFBW6pYc0SwqTrWM8HfzQVPLNUyAJ+AWGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dy5LkT85; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR/Zrmk55YKCT5wc9TXYIcGQlNS6VXM9Lt+1sX35U3KIZ5UQLufz16ehvHXSySQzKxGiFUPlJkw9aXp8YawDm8b+UlCGwc3jVLAYxR31RJFDOERp0qQ3reWY7aiM1eArbdKHQmmcFB9J6lNYSc00qgPZLkccnwIuqmD6ocRbK6MJm2b0+d4twy384i8hcHLIqqRzVXO7hbmKhtsC/T9ndkCoNjMC0AzdsbYBGyQxKGsHkHsvu3qWpFu6+dPMsYQbcoHOxrN73lGr3LosVW8y+6R+5v67x0JlrLsT82PLHtQpj5vHfSBl7JKBKOcZsiiXBYqaJbmOB6n4LjouBNP7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ/dPvTw7lC1vj/OBmHMler3i6VNwu+2bWsIsqIrtko=;
 b=c6+FyVPTvC6vZmDcLPhVMh6BoLYJACtKPDJVBTciaRvnHkWdoUcvOeB0L1Uq4odGyiyNpBWPFOoiPmMB/68TDXX+hFxcjum9y88c03qXA0SqqlTYEykN6F6fZ7F0otVoA8Wwdr7KCE6y3gnsj/d+lWFG4Jb6yzkki6tGjuzilz53/ji2HENz8qIgI2KRbTIsBRuNV25FxW0m2H7jQGH40nafcFTAgnAnY7kOp5KblGrYnRWZP6Q9icKF2EtSZbusbDlVbe5iRJzZ1Xx7XzAkfORI4qpmxVztnxPwFPsgnROifLWgmoOtarTr4bc5xqHmI4kOlRLu2y1ofFb/Dg1dYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huaweicloud.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ/dPvTw7lC1vj/OBmHMler3i6VNwu+2bWsIsqIrtko=;
 b=Dy5LkT859PXAsr5cvXkr0fuu6QW88wjcIWBk1cZ9G0qdHHW8LWIEquzcxLkoTZzryKZMg3v/l9P1kCeE4vES75nzSTDUwKelviHEbDYRmWizWIQD1prUpx1TxP8XSRCHTvCGRc1bj7xGtFg6V8ovD2Q20657Tg9K4CXeoVgkTXU=
Received: from MN0P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::31)
 by IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Thu, 26 Jun
 2025 11:29:51 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:52b:cafe::93) by MN0P223CA0024.outlook.office365.com
 (2603:10b6:208:52b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 11:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:29:50 +0000
Received: from [10.85.37.22] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 06:29:46 -0500
Content-Type: multipart/mixed;
	boundary="------------TB8qoOf04tujES8TT1dGMnmn"
Message-ID: <f59ef632-0d11-4ae7-bdad-d552fe1f1d78@amd.com>
Date: Thu, 26 Jun 2025 16:59:36 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] ext4: enable large folio for regular file
To: Zhang Yi <yi.zhang@huaweicloud.com>, <linux-ext4@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<willy@infradead.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <yi.zhang@huawei.com>, <libaokun1@huawei.com>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: "D, Suneeth" <Suneeth.D@amd.com>
In-Reply-To: <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|IA0PPFAF4999BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a114e0-2804-4750-f171-08ddb4a4c3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0RtTDJ0RWh2R2FQM3VHTFd4RGZGaE1xWjZmaXJ1bXdVNHRJaVpYN3l1VG4y?=
 =?utf-8?B?dkYrSzRNK0VlQXlKaG1FSmdPeUtmSk9YU09zaDNRZFNyOWVkOXFjVTc5cytl?=
 =?utf-8?B?SkFQTFM4b1J1NkNma29WVDJ2ZW1ESUtidjBsNmdZS1NwU1R3OHE4UVZQdW5v?=
 =?utf-8?B?U3BPZU5nODRuVE5sSjByVDJMV2ZNVFNzVmEzQjUvUUd2WXVLWUtsK3hlaTRJ?=
 =?utf-8?B?WDcreUVxZjBERVRnWml5TXc2ekVxVi9JYkRBVWJKeXo5UmoveWVsRWZnMnZF?=
 =?utf-8?B?OVFxd1FnUjBmajE2aE5xYkhOWWRaTHI1SHB0NGoyR0JxMUp4Slk4NTN3aTR1?=
 =?utf-8?B?N2dQbEczdWlkN3o3Ly8zVEhsQ2p5ajBqUjJlU3lQbkhkNHB5c1NrYUs3TlJw?=
 =?utf-8?B?K3BHa2JKZTdta0FmMW02VjY2K0F3d2N6S2JJb1RNN1g2c0ZMeWxuUjNsc3Q5?=
 =?utf-8?B?TWEyeDVGWUJxaE1KOUloejkrVCtaaVlRYUtaWWZla1VKa0FGWHNMdDkraWVF?=
 =?utf-8?B?YmZhVkc1U2Y3YnlTQWFWZ1UyTCtzbjJadHVSY2xsQW9ieWd4ditVd2pxMk14?=
 =?utf-8?B?VmNjNUxqdDU2OFhRY0FxekwzUUEvdEJSbVJzMnM3SklzSWZINlY5dEFoQmhZ?=
 =?utf-8?B?TkVDOHZ4RlJUeG1yRFpXamp1ZXV1R2xlaS9idEN0aU1ybVg2TXp6YW9qOFh6?=
 =?utf-8?B?V0VCWEFsL0RiaTd6amJyaFRCUGxpSjY4L05QS1VpZGZGY3hBV2FqL08xZ3FO?=
 =?utf-8?B?LzJRZytranZCbGRjSStibDhHVWtzc2plQjVzRTVQdGdET21aWldKbjNDbXcw?=
 =?utf-8?B?V0VhRGJsc0h4WXFFNkZhaTd6RTdsSVFzYUlUMDlzZWUzT3REb3lxNzNWTmJw?=
 =?utf-8?B?LzIvVGQrUDN6dHJtL1Q2ekdmT2ZxS0o4dmJvNmhkSzBEeUcrMVJUSnJnWUNY?=
 =?utf-8?B?RU5rdG14dGVCTFFRMlFFREdhMXppV1FDSW43UngxZEFRQ2cxbktnclMvKzVu?=
 =?utf-8?B?ZkMzMVlOWm4vTG50K2xRNkxwL1lpdGNJaXdGTXQxc2F1L01LaERZbmhMNThL?=
 =?utf-8?B?WnJUcEVlZHpzR0xpei8zRWg0bGdqZSs2VnZVNUFSK2pkdFE0QVBNczFYaC8x?=
 =?utf-8?B?N1IwTmJ5UjRWeWlaOVFlQ2t6anVPUWZxYkdnQWQ2Z0FTM2FoRXZLOWluZ0dh?=
 =?utf-8?B?V2NOK1c4TE9MV0V4cnRLbU8yaWVCR2V6NWw2RHJzRUsvZ1ZyRlo0L3o4MGZs?=
 =?utf-8?B?ZGtLQ2xQbG9nR3JJNWhCV0Iva21PdzVSejI1amllbTJYalAwNDJENlcrT1Fp?=
 =?utf-8?B?L2FxNGxYclFLalNBVTFDUUhEaTFVbzhHZEdzaVVzOE5Yejc2VGVFdWFBWkpO?=
 =?utf-8?B?UXZGaGtxanZJeXRORmQ4dkZmNkhTTzQvWlg2NHRzekYyaW5vQkt6aEpVWHQr?=
 =?utf-8?B?cXdzOXdYZTJyOXV0WWlwWStpNGVpYzYrYUhUN3NTdDdJVlR0MVdwTGwxd2Fh?=
 =?utf-8?B?Z3p6OEZEYVZQczc1eTI0WVdiOEVvaWRaZXQybWQ1R1BUTUFsdTdDUFhma1I0?=
 =?utf-8?B?N1JuWDdYaC9Sd1NKYkR2Vkdhb3JNRXRUdlI5SWhGcDFoYjR4d2pkeUFrRXBp?=
 =?utf-8?B?Vk9SblRiaTNabytUTTRKbTAyb2VsL0hxTWppZWJEWWQxSmFyelpjdkROK3o1?=
 =?utf-8?B?aTZISXE1Qjh6YThZUC9iaDQ4ZUFlc0FLdWRpaVcvR0kvSUhEekdlUHZ3dG5E?=
 =?utf-8?B?TU8wMW9HdDRZeHZQRXdCMmtrRy9BbUh2UG5uUUdZK3hmdGttUUpEZnpkQmxW?=
 =?utf-8?B?V1BuTjlHRHdrR25UTlBOU3FackpueFBEeXpsUjJaRTZjNi9iQm83Q3JMSjRU?=
 =?utf-8?B?b3FjYm0xdmVsWGR0L1R3cWNsTmRHTWlMUHF5Q3VSL3R0T0F6bGMxay9oRmJa?=
 =?utf-8?B?Ykd3UnhCcG5xTmhVZmxsYzVNZWR3M1hCQW0rWlhiekY0cTZtYWpraFdwWW5M?=
 =?utf-8?B?UENTekJwQkIzMkVVOWZTRHJvdjZRRno0Z1ZZeUZyTGxueWhSWldFOVUrR0x1?=
 =?utf-8?B?R0tqWXVOOXdqOUZCMnNTNlQzVFBjNlRkWkJxdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(4053099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:29:50.7226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a114e0-2804-4750-f171-08ddb4a4c3b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6

--------------TB8qoOf04tujES8TT1dGMnmn
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


Hello Zhang Yi,

On 5/12/2025 12:03 PM, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Besides fsverity, fscrypt, and the data=journal mode, ext4 now supports
> large folios for regular files. Enable this feature by default. However,
> since we cannot change the folio order limitation of mappings on active
> inodes, setting the journal=data mode via ioctl on an active inode will
> not take immediate effect in non-delalloc mode.
> 

We run lmbench3 as part of our Weekly CI for the purpose of Kernel 
Performance Regression testing between a stable vs rc kernel. We noticed 
a regression on the kernels starting from 6.16-rc1 all the way through 
6.16-rc3 in the range of 8-12%. Further bisection b/w 6.15 and 6.16-rc1 
pointed me to the first bad commit as 
7ac67301e82f02b77a5c8e7377a1f414ef108b84. The following were the machine 
configurations and test parameters used:-

Model name:           AMD EPYC 9754 128-Core Processor [Bergamo]
Thread(s) per core:   2
Core(s) per socket:   128
Socket(s):            1
Total online memory:  258G

micro-benchmark_variant: "lmbench3-development-1-0-MMAP-50%" which has 
the following parameters,

-> nr_thread: 	1
-> memory_size: 50%
-> mode: 	development
-> test:        MMAP

The following are the stats after bisection:-

(the KPI used here is lmbench3.MMAP.read.latency.us)

v6.15 - 						97.3K

v6.16-rc1 - 						107.5K

v6.16-rc3 - 						107.4K

6.15.0-rc4badcommit - 					103.5K

6.15.0-rc4badcommit_m1 (one commit before bad-commit) - 94.2K

I also ran the micro-benchmark with tools/testing/perf record and 
following is the output from tools/testing/perf diff b/w the bad commit 
and just one commit before that.

# ./perf diff perf.data.old  perf.data
No kallsyms or vmlinux with build-id 
da8042fb274c5e3524318e5e3afbeeef5df2055e was found
# Event 'cycles:P'
#
# Baseline  Delta Abs  Shared Object            Symbol 
 
 
            >
# ........  .........  ....................... 
....................................................................................................................................................................................>
#
                +4.34%  [kernel.kallsyms]        [k] __lruvec_stat_mod_folio
                +3.41%  [kernel.kallsyms]        [k] unmap_page_range
                +3.33%  [kernel.kallsyms]        [k] 
__mod_memcg_lruvec_state
                +2.04%  [kernel.kallsyms]        [k] srso_alias_return_thunk
                +2.02%  [kernel.kallsyms]        [k] srso_alias_safe_ret
     22.22%     -1.78%  bw_mmap_rd               [.] bread
                +1.76%  [kernel.kallsyms]        [k] __handle_mm_fault
                +1.70%  [kernel.kallsyms]        [k] filemap_map_pages
                +1.58%  [kernel.kallsyms]        [k] set_pte_range
                +1.58%  [kernel.kallsyms]        [k] next_uptodate_folio
                +1.33%  [kernel.kallsyms]        [k] do_anonymous_page
                +1.01%  [kernel.kallsyms]        [k] get_page_from_freelist
                +0.98%  [kernel.kallsyms]        [k] __mem_cgroup_charge
                +0.85%  [kernel.kallsyms]        [k] asm_exc_page_fault
                +0.82%  [kernel.kallsyms]        [k] native_irq_return_iret
                +0.82%  [kernel.kallsyms]        [k] do_user_addr_fault
                +0.77%  [kernel.kallsyms]        [k] clear_page_erms
                +0.75%  [kernel.kallsyms]        [k] handle_mm_fault
                +0.73%  [kernel.kallsyms]        [k] set_ptes.isra.0
                +0.70%  [kernel.kallsyms]        [k] lru_add
                +0.69%  [kernel.kallsyms]        [k] 
folio_add_file_rmap_ptes
                +0.68%  [kernel.kallsyms]        [k] folio_remove_rmap_ptes
     12.45%     -0.65%  line                     [.] mem_benchmark_0
                +0.64%  [kernel.kallsyms]        [k] 
__alloc_frozen_pages_noprof
                +0.63%  [kernel.kallsyms]        [k] vm_normal_page
                +0.63%  [kernel.kallsyms]        [k] 
free_pages_and_swap_cache
                +0.63%  [kernel.kallsyms]        [k] lock_vma_under_rcu
                +0.60%  [kernel.kallsyms]        [k] __rcu_read_unlock
                +0.59%  [kernel.kallsyms]        [k] cgroup_rstat_updated
                +0.57%  [kernel.kallsyms]        [k] get_mem_cgroup_from_mm
                +0.52%  [kernel.kallsyms]        [k] __mod_lruvec_state
                +0.51%  [kernel.kallsyms]        [k] exc_page_fault

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>   fs/ext4/ext4.h      |  1 +
>   fs/ext4/ext4_jbd2.c |  3 ++-
>   fs/ext4/ialloc.c    |  3 +++
>   fs/ext4/inode.c     | 20 ++++++++++++++++++++
>   4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..2fad90c30493 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2993,6 +2993,7 @@ int ext4_walk_page_buffers(handle_t *handle,
>   				     struct buffer_head *bh));
>   int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>   				struct buffer_head *bh);
> +bool ext4_should_enable_large_folio(struct inode *inode);
>   #define FALL_BACK_TO_NONDELALLOC 1
>   #define CONVERT_INLINE_DATA	 2
>   
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 135e278c832e..b3e9b7bd7978 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -16,7 +16,8 @@ int ext4_inode_journal_mode(struct inode *inode)
>   	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
>   	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
>   	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
> -	    !test_opt(inode->i_sb, DELALLOC))) {
> +	    !test_opt(inode->i_sb, DELALLOC) &&
> +	    !mapping_large_folio_support(inode->i_mapping))) {
>   		/* We do not support data journalling for encrypted data */
>   		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
>   			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index e7ecc7c8a729..4938e78cbadc 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1336,6 +1336,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>   		}
>   	}
>   
> +	if (ext4_should_enable_large_folio(inode))
> +		mapping_set_large_folios(inode->i_mapping);
> +
>   	ext4_update_inode_fsync_trans(handle, inode, 1);
>   
>   	err = ext4_mark_inode_dirty(handle, inode);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 29eccdf8315a..7fd3921cfe46 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4774,6 +4774,23 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>   	return -EFSCORRUPTED;
>   }
>   
> +bool ext4_should_enable_large_folio(struct inode *inode)
> +{
> +	struct super_block *sb = inode->i_sb;
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return false;
> +	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> +	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> +		return false;
> +	if (ext4_has_feature_verity(sb))
> +		return false;
> +	if (ext4_has_feature_encrypt(sb))
> +		return false;
> +
> +	return true;
> +}
> +
>   struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   			  ext4_iget_flags flags, const char *function,
>   			  unsigned int line)
> @@ -5096,6 +5113,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   		ret = -EFSCORRUPTED;
>   		goto bad_inode;
>   	}
> +	if (ext4_should_enable_large_folio(inode))
> +		mapping_set_large_folios(inode->i_mapping);
> +
>   	ret = check_igot_inode(inode, flags, function, line);
>   	/*
>   	 * -ESTALE here means there is nothing inherently wrong with the inode,

---
Thanks and Regards,
Suneeth D
--------------TB8qoOf04tujES8TT1dGMnmn
Content-Type: text/plain; charset="UTF-8"; name="lmbench_steps.txt"
Content-Disposition: attachment; filename="lmbench_steps.txt"
Content-Transfer-Encoding: base64

U3RlcHMgdG8gcnVuIGxtYmVuY2gzDQoNCjEuIGdpdCBjbG9uZSBodHRwczovL2dpdGh1Yi5j
b20vaW50ZWwvbG1iZW5jaC5naXQgDQoyLiBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29t
L2ludGVsL2xrcC10ZXN0cy5naXQNCjMuIGNkIGxtYmVuY2gNCjQuIGdpdCBhcHBseSBsa3At
dGVzdHMvcHJvZ3JhbXMvbG1iZW5jaDMvcGtnL2xtYmVuY2gzLnBhdGNoDQo1LiBtYWtlDQo2
LiBzZWQgLWkgJy9sYXRfcGFnZWZhdWx0IC1QICBuby9pIFsgLWYgbm8gXSB8fCBkZCBpZj0v
ZGV2L3plcm8gb2Y9bm8gY291bnQ9MSBicz0xRycgYmluL3g4Nl82NC1saW51eC1nbnUvbG1i
ZW5jaA0KNy4gKA0KICAgICAgICAgICAgICAgIGVjaG8gMQ0KICAgICAgICAgICAgICAgIGVj
aG8gMQ0KICAgICAgICAgICAgICAgIGVjaG8gMTAyNDANCiAgICAgICAgICAgICAgICBlY2hv
IGRldmVsb3BtZW50DQoNCiAgICAgICAgICAgICAgICBlY2hvIG5vDQogICAgICAgICAgICAg
ICAgZWNobyBubw0KICAgICAgICAgICAgICAgIGVjaG8gbm8NCiAgICAgICAgICAgICAgICBl
Y2hvIG5vDQogICAgICAgICAgICAgICAgZWNobyBubw0KICAgICAgICAgICAgICAgIGVjaG8g
eWVzDQogICAgICAgICAgICAgICAgZWNobyBubw0KICAgICAgICAgICAgICAgIGVjaG8gbm8N
CiAgICAgICAgICAgICAgICBlY2hvIG5vDQogICAgICAgICAgICAgICAgZWNobyBubw0KICAg
ICAgICAgICAgICAgIGVjaG8gbm8NCiAgICAgICAgICAgICAgICBlY2hvIG5vDQogICAgICAg
ICAgICAgICAgZWNobyBubw0KICAgICAgICAgICAgICAgIGVjaG8gbm8NCiAgICAgICAgICAg
ICAgICBlY2hvIG5vDQogICAgICAgICAgICAgICAgZWNobyBubw0KICAgICAgICAgICAgICAg
IGVjaG8gbm8NCg0KICAgICAgICAgICAgICAgIGVjaG8geWVzDQogICAgICAgICAgICAgICAg
ZWNobw0KICAgICAgICAgICAgICAgIGVjaG8NCiAgICAgICAgICAgICAgICBlY2hvDQogICAg
ICAgICAgICAgICAgWyAxIC1lcSAxIF0gJiYgZWNobw0KICAgICAgICAgICAgICAgIGVjaG8g
bm8NCiAgICAgICAgKSB8IG1ha2UgcmVzdWx0cw0KOC4gY2QgcmVzdWx0cy8gJiYgbWFrZQ==


--------------TB8qoOf04tujES8TT1dGMnmn--

