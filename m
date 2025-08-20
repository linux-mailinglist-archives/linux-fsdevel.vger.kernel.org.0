Return-Path: <linux-fsdevel+bounces-58361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10BBB2D40F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 08:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB862A7E55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 06:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C72C08CB;
	Wed, 20 Aug 2025 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J6DcNBuW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273D277C9A;
	Wed, 20 Aug 2025 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671374; cv=fail; b=LZjlWvfA55jUW2vktB/ho0c7uxzpBsgu2WndP6pHjvecb9uGzmsZvjCRNoH+pHm/X7ZzJLsfAYTBAGbuuC7vZa7wsvhKfBrY4GYwt9f2sJvfLbRUSQKUbOgXeq94H+meuB4ssWyzb/tSymQpImEGsFh2r2idpSqCmhECjpc833s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671374; c=relaxed/simple;
	bh=KtPecVA+SKUsBsaUR+3GgaW+EcCBu+Orm/s7b9s3oE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jIyZnr++kpJpol8rEwguUJ1aLfRN+LnY/jxrUP4tcGMEhIjtIGqW+z3w+O3EHua6nt20qHPsapctUjCHpbu756ptXz+ur1hXl/BdFingvQwGghsccTr+t1oeDm2eeruDP7yhe6qhubohH8XhGQv9aRhhqAnPjO+TcLkcu9un2WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J6DcNBuW; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5vP6+tijtudj2ifFaxqxEYA8TuiN1xavzONznivru2/SNc8ERkH7bXt/CaYN4ZL6QN2MNQFKp2K+baCIQl9GzJBDSme86wYX/6YhLqxBxxrtx5KOVtQJ+Cz/VoCGTfbtPvzbABnOgvelt6L1g5oAkia3ggzJiBzxC95BBjIbWabQx7T1VXjLD3RcVyrEXjpFR1lVrcyMLfUQ2peTRJ7ev9Kkwl9TXemBFfnX5XZ6UVEiY+nmpw3u1BrO/oaPlbE/tlQyK/gkhO+jxRbUxSVeBXUK93ZhB6mOONO9GGcylOKI/OqjJO30cfVfnSl7j1ceQigf+NAxEMR+H2SfgI2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbeOWknQtUjT2jERZLYHtz1GtCyHPp8LAy6RMmhUW8I=;
 b=fV76GgPasV8SZOa+e8SdwdYQQC3HifG7TP9VN2fV0eVzXRsTJomHc1cKLquQnf3fSu/Mudj8XPsou5vn83olE5uvs8c49iHTptvSWo055mPrCT/cP34jY5/svLMjenPEB8kFiTFORgHjQZxqnwDrkcgv0B0sizZfBhMpAil0i/B0/VP9VYkm/laOKGTXXtttcg1pl4PC1KmgMJ+OTtMgGdGOw7q/uLqMii4+TpVxpLUsnGXyL8Uq1nRgKVqbI6LAmZu76u3fYdHwYWdiF7U6/mT/xjG3C4u/jXdAJ+6JnkVyh7zlkgnuEPAA8Zu+P1W8D/3YvBvEG+f5XGodaxcEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbeOWknQtUjT2jERZLYHtz1GtCyHPp8LAy6RMmhUW8I=;
 b=J6DcNBuWeyhVbNZfGJq7WXZATTCk9d/+aJjZMDeTdwi9Dd16ftt1PyFH2cwqeFj6JMvt/whFKf7bDjpPCFqbu1Bpoua4lhQZjhjldvBvFUg7uC91Mu4l1+ZguS2H4wKJ/30gqk5ZYyUO9kotcapdAM2USY/OEtjMZRf+eTQO4Mw=
Received: from BN0PR10CA0017.namprd10.prod.outlook.com (2603:10b6:408:143::26)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 06:29:27 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::5f) by BN0PR10CA0017.outlook.office365.com
 (2603:10b6:408:143::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 06:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 06:29:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 01:29:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 01:29:26 -0500
Received: from [10.136.47.145] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Aug 2025 01:29:22 -0500
Message-ID: <f8e85fe1-87e6-4b31-9e87-f48fd7b8e3f6@amd.com>
Date: Wed, 20 Aug 2025 11:59:20 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN
To: Oleg Nesterov <oleg@redhat.com>, Dominique Martinet
	<asmadeus@codewreck.org>, syzbot
	<syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com>
CC: <akpm@linux-foundation.org>, <brauner@kernel.org>, <dvyukov@google.com>,
	<elver@google.com>, <glider@google.com>, <jack@suse.cz>,
	<kasan-dev@googlegroups.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>,
	<willy@infradead.org>, <v9fs@lists.linux.dev>, David Howells
	<dhowells@redhat.com>
References: <68a2de8f.050a0220.e29e5.0097.GAE@google.com>
 <20250819161013.GB11345@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250819161013.GB11345@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: d677bd3c-c09a-417b-6937-08dddfb2e987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|30052699003|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUdLYkRrN0RYU3poOUJ5YlJodnFEdThMVC81Y2t2c0IzYmVDR1FUMEp5ZUVR?=
 =?utf-8?B?R1J1dVY2dVE4bGVDcG1JelA2ZEZzeWpiUDBRN3NSRjNqWFJabFlHVTRhR0pa?=
 =?utf-8?B?NUVHb2lJYktobTkrME9RWmZVL2dNTHBXb2xNSitmNS96MFBQYm9MY3Y5QStT?=
 =?utf-8?B?Rzh1M2pXRWNxekRsaC9ObUxTcDZNWlh2U093RVlTWlpRM3ZKNzZhUFhUZzN5?=
 =?utf-8?B?SlhlVDhSdWdodXFNOFhFVnUxRElkY2VEMisyb21mU09iaEZCTTRJcWFlZDEz?=
 =?utf-8?B?cnRvTjYwNDFLOHBEV0p5c1pMZ0hGSGFoeDErV3I0ZjR5bmhITTlYUDB4d1ZQ?=
 =?utf-8?B?NkJVSHFRbENJN0tIQTNUc3V5TVhrOWg3MVlMT0NncFVVMWhReFc4eEd0TDNV?=
 =?utf-8?B?SlRUUzBFQUltOVhiNXcrNjUzby9GVEV5RVVMVFJzUHE4Y2tYbE5rZXk4UkVi?=
 =?utf-8?B?Q0hhRGlaWXA4WnlOcHUzcTN4YUw2R085UDVWWi9uZFZ6bUpLZm9sUy8wQUpO?=
 =?utf-8?B?VHpJN3NPNVlFYzVybiswVVpUZkxsV1l5VDN2VFhobXpnaGdGNFlCSGVqTWZ4?=
 =?utf-8?B?cVE5Wk9vSG5kdVh0VERpSGZFUkovVzR4V0pXMlVDeVV3dmE3RUNtN3JHcklj?=
 =?utf-8?B?TXc1cTAzZHkvdVBjSU9PelRGNU5jZnhoUHFCRVlkRnZlcmNGNW0rbVc0dWVU?=
 =?utf-8?B?Mlo3VEhnSXExUTVhODQrQVh6SHUzY08wZHFONzJpSkVYNmxGeVpjOEtaTGg5?=
 =?utf-8?B?NC8rRi9NbzJQSCtBNzhnSUllQTVFUXl2QWN1RXZJMVJmQXB2alJ3SmNlaHBw?=
 =?utf-8?B?MHZRK05ick9IR0E0SWZuUnhLZ3FZc1U4MHBZUHdjSktvRStVWmlUcnF5eGNM?=
 =?utf-8?B?Z0psTEtydk5LNjQ0S1kxUHZVNEZCZk1Db0hXWTYyVjhZeHhiRnRTdG1ZVjcv?=
 =?utf-8?B?WndKaHlNYmJlR1JIZHQ3QkJTN2QwREw2UmxwbStZM2NmOCtPb1JrWFFCWnEv?=
 =?utf-8?B?K09meHJmZk04Vk9hcFBqNU5DbUNmMTJoZlZkVWIzaG5tTTFCUGg4MEdUMnlT?=
 =?utf-8?B?b0pmY3YrUU1nakpJU3BNb21CQmFaV1BubmEwRWVtMVlwWVZuL1BkSDRUa1Jt?=
 =?utf-8?B?U2FDOUdkOG0rSThWWUlWeUNFdVpyZ3ZYRkt5NktHZExGdnMxNklvM21lbE5M?=
 =?utf-8?B?WTRlTDVwQ3pxY1oyVUFsVzRGcTRpZWMzcVAwcmNDdFo4NXNrUTFNNy9ETmJS?=
 =?utf-8?B?Sjc1NC9kZ3NjS21FM04zaXV0QXlFZFFCa2V6QngyUWdGSGthd29JdlFTRHN6?=
 =?utf-8?B?RjU3RmJ3bythWHNMeFdTNnBnbkk1STFUMythSmhZZFdneE5PUSt6OGFnUmZZ?=
 =?utf-8?B?QXIxbUVZRlJYcTl6WFF1V1VuZU1HZElsKzBsZFg1MHBqQnJVR0ZPcFl2eCtn?=
 =?utf-8?B?TkJOZHgrYWdQeFFQaG9tWGZabjdlLzUrRjhsL3lzdGMwK0UyclMrZytBQU4r?=
 =?utf-8?B?V1FmSkVHTnkzMWtndkRrY1lYcnBKVjJzU1NkdWdTLzVFNkRnOHRvZzVJOXlJ?=
 =?utf-8?B?VVVhaGxZR1lFdHUzTUpOb0lBeW9uR1JyeG5nZ09PWmhqUjBlQWpubU9kc1pY?=
 =?utf-8?B?cFhIZHhnandlZ1h1amh5K1VSSTBlVkdhbHpHdEhhcXRlMmJieGRTN2ZMS3dN?=
 =?utf-8?B?c1l4WkhDcUViOWx4ZjZZRFZpYVRlMUVWenA1Q2JsaEcvS2pFdjFJMDBOT0tL?=
 =?utf-8?B?eEYwcWtsL3ZBREpQSW9PN0E0SEh2YkxrMXI2TjdaNUloZm5TcitsMlFPUjA4?=
 =?utf-8?B?NkFOc05td1ZYODVkejdvZ3RwQU5iTDdCaGlKSVRpcEt3cUk0MEpadXhVOG1P?=
 =?utf-8?B?dUEvSDBFZ1RKVk1GUit6SXNuaTYvQmNISGc5T1phZmNyYlZzc2tVcm5xWFhU?=
 =?utf-8?B?Y3pRMDFNUW84L3pmcXlTRko0SnhFY1VBY3g2RTVCWlM5RW40bDdlQUtqYWdF?=
 =?utf-8?Q?6iJAcPy789pHcq8xKch/bixqMuDwig=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(30052699003)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 06:29:27.0699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d677bd3c-c09a-417b-6937-08dddfb2e987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849

Hello Oleg,

On 8/19/2025 9:40 PM, Oleg Nesterov wrote:
> p9_read_work() doesn't set Rworksched and doesn't do schedule_work(m->rq)
> if list_empty(&m->req_list).
> 
> However, if the pipe is full, we need to read more data and this used to
> work prior to commit aaec5a95d59615 ("pipe_read: don't wake up the writer
> if the pipe is still full").
> 
> p9_read_work() does p9_fd_read() -> ... -> anon_pipe_read() which (before
> the commit above) triggered the unnecessary wakeup. This wakeup calls
> p9_pollwake() which kicks p9_poll_workfn() -> p9_poll_mux(), p9_poll_mux()
> will notice EPOLLIN and schedule_work(&m->rq).
> 
> This no longer happens after the optimization above, change p9_fd_request()
> to use p9_poll_mux() instead of only checking for EPOLLOUT.
> 
> Reported-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
> Tested-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68a2de8f.050a0220.e29e5.0097.GAE@google.com/
> Link: https://lore.kernel.org/all/67dedd2f.050a0220.31a16b.003f.GAE@google.com/
> Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

A "Debugged-by:" or equivalent would have been fine too since you did
most of the heavy lifting by finding p9_poll_mux() but I don't mind
standing behind this since it is doing the right thing :)

I tested this on top of v6.17-rc2 and the upstream runs into a hang
instantly with the syzbot's reproducer. The dmesg logs:

    INFO: task repro:4150 blocked for more than 120 seconds.
          Not tainted 6.17.0-rc2-upstream #34
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    task:repro           state:D stack:0     pid:4150  tgid:4150  ppid:1      task_flags:0x400140 flags:0x00004006
    Call Trace:
     <TASK>
     __schedule+0x474/0x1620
     ? __wb_update_bandwidth+0x37/0x1d0
     schedule+0x27/0xd0
     io_schedule+0x46/0x70
     folio_wait_bit_common+0x112/0x300
     ? filemap_get_folios_tag+0x232/0x2a0
     ? __pfx_wake_page_function+0x10/0x10
     folio_wait_writeback+0x2b/0x80
     __filemap_fdatawait_range+0x7c/0xe0
     file_write_and_wait_range+0x89/0xb0
     v9fs_file_fsync+0x2d/0x90 [9p]
     netfs_file_write_iter+0xec/0x120 [netfs]
     vfs_write+0x305/0x420
     ksys_write+0x65/0xe0
     do_syscall_64+0x85/0xb30
     ? do_syscall_64+0x223/0xb30
     ? count_memcg_events+0xd9/0x1c0
     ? handle_mm_fault+0x1af/0x290
     ? do_user_addr_fault+0x2d0/0x8c0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
    RIP: 0033:0x7f3b26d1e88d
    RSP: 002b:00007ffe581fa348 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
    RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3b26d1e88d
    RDX: 0000000000007fec RSI: 0000200000000300 RDI: 0000000000000007
    RBP: 00007ffe581fa360 R08: 00007ffe581fa360 R09: 00007ffe581fa360
    R10: 00007ffe581fa360 R11: 0000000000000213 R12: 00007ffe581fa4b8
    R13: 0000558168a6de12 R14: 0000558168a6fd10 R15: 00007f3b26f03040
     </TASK>

With this patch applied on top, I haven't seen a hang yet and I've been
running it for 30min now so feel free to also include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  net/9p/trans_fd.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 339ec4e54778..474fe67f72ac 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -666,7 +666,6 @@ static void p9_poll_mux(struct p9_conn *m)
>  
>  static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
>  {
> -	__poll_t n;
>  	int err;
>  	struct p9_trans_fd *ts = client->trans;
>  	struct p9_conn *m = &ts->conn;
> @@ -686,13 +685,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
>  	list_add_tail(&req->req_list, &m->unsent_req_list);
>  	spin_unlock(&m->req_lock);
>  
> -	if (test_and_clear_bit(Wpending, &m->wsched))
> -		n = EPOLLOUT;
> -	else
> -		n = p9_fd_poll(m->client, NULL, NULL);
> -
> -	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
> -		schedule_work(&m->wq);
> +	p9_poll_mux(m);
>  
>  	return 0;
>  }

-- 
Thanks and Regards,
Prateek


