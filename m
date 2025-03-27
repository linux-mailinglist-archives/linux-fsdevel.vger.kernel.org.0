Return-Path: <linux-fsdevel+bounces-45157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34607A73CAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 18:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5EF189B501
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914B219A8B;
	Thu, 27 Mar 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/FLpEOO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC3433B1;
	Thu, 27 Mar 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097606; cv=fail; b=C/0ydy6q3QI9t4FEyZc0fgjizGLLpqL+jCWNtpdTrUuj7eMyL9Z74sOvYpImc84TDAXjPdfmTdl5hW2FH5hAwxIVUMyjnWiaD8W8A+TD25TDYlSzMwsqWBlq6dY760E81u3VYGmN/QheRMHCLIoc4UsAB8WqYnZdxgZURiQ2RDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097606; c=relaxed/simple;
	bh=L5W6OatC1aE6Wo+1AbpDOQpq8udLMTLIMpnvbdAMZCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tdbdx1hL7xCh01oobGDkwr80uCJXKCFYda3c7aWhwoIRHVm+d/LL0igFwuVUTGenB1JtQe4UM733JdIuTy05f17ufjZvVjL9BaFUSU8VXONE5M5D9pUO3FibUrAVAi8h8pIhTaD8VE77sfpaiFiyIE0sqG9ttaKG4WNrandCgSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/FLpEOO; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNgPUvUoYA9d7EW2WYFByzt5uzD2npUPdYSn+G87i9NrT0Bv0waGkLFNzlXD0ynQpv8admosWx7kM+e4NKT9SXzZqb1sfGxCJblFmxspkQV9qmFfvml5xHRiYBVQ18Z/om+i45QthalSQT++zfp7NhgeHrQpx3mJFgn1HtUwahAscpCa7xhwnZOgiYaIklkazFjxno5RE66V4tlY9AVTP5eV+qQo3oPBD/K6e5BRnKcF7Spyo7qYVUt5cG3pktAhtS8UVTyD+qtFRtS5bwlEIC5TfTxY+zu1WA6Xwg/ZsT2XNgaE5BThRd/e55U2pAD8Uw+xiZvQwj6JL0hRQd+3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZPYR1lXleHvKQQlFqRTmNB4YBbwjvmcYM7wCp+4aNs=;
 b=Ka4cAfnZPiCzngvbXA9RsUgLwpryMbS1oepo6mjTBrWvPrNvYqrZCyDPnilQMUvaIG+esSHBfaY18alSX0uEFS5caUg3+oOuMCAdrfHtMfURpT3dXIM8EbEFspOv8KIcVwJKw6vOpgXaFTB1fVH4v7dp6WMi+mz+Fb8nivPir9f6aV6t795kPBrsxH8io3wWYcOybhyz01uWISdnNMJa8k4jxv+vU0SkVMAZuy7sb47YFyCmRHY7v4WhdPb2GO7nyibjqSZOZUZwa/PMh12EcQTtWROrryz/83oJFnlIys+XIXxH6lMc5NoIuH66jv/0P8Evc+2cKnsKJRzyojeBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=codewreck.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZPYR1lXleHvKQQlFqRTmNB4YBbwjvmcYM7wCp+4aNs=;
 b=o/FLpEOOI3JDseZiCgSu6DyeiLyjqOYKQxtC89PwndOz+9pMS9Gvg2EQlXh1Yq3AmNIhmBoyzRkY+la8HWulIMTTv8lvgkoCWp3n47sigOuZtNSV849/8ybdlklh32Btja2h5VODVa6rynLFPq/SA1+kyfZ0sybp0ixA+l5yqlo=
Received: from BN9PR03CA0117.namprd03.prod.outlook.com (2603:10b6:408:fd::32)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 27 Mar
 2025 17:46:40 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:fd:cafe::3d) by BN9PR03CA0117.outlook.office365.com
 (2603:10b6:408:fd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Thu,
 27 Mar 2025 17:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Thu, 27 Mar 2025 17:46:39 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 12:46:34 -0500
Message-ID: <377fbe51-2e56-4538-89c5-eb91c13a2559@amd.com>
Date: Thu, 27 Mar 2025 23:16:27 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
To: Dominique Martinet <asmadeus@codewreck.org>, Oleg Nesterov
	<oleg@redhat.com>
CC: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
	<lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, "Mateusz
 Guzik" <mjguzik@gmail.com>, syzbot
	<syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	<brauner@kernel.org>, <dhowells@redhat.com>, <jack@suse.cz>,
	<jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netfs@lists.linux.dev>,
	<swapnil.sapkal@amd.com>, <syzkaller-bugs@googlegroups.com>,
	<viro@zeniv.linux.org.uk>, <v9fs@lists.linux.dev>
References: <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
 <20250325121526.GA7904@redhat.com> <20250325130410.GA10828@redhat.com>
 <f855a988-d5e9-4f5a-8b49-891828367ed7@amd.com>
 <Z-LEsPFE4e7TTMiY@codewreck.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <Z-LEsPFE4e7TTMiY@codewreck.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 363ceb3a-939d-43b6-ed16-08dd6d575438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXg4dDFnQTJCN1g5eU83Wkg1NTBhT3FBcWFKQ1AzUlpLM0xDNGE0VllJZGcv?=
 =?utf-8?B?UWhweHRVVzd6MVN6Z0hoUVpJRmhTMjh0SGpNYXNDWUorVVpuNWxON01DMHJ0?=
 =?utf-8?B?VG9sbEdhWlo3a1hTb0dOaWhON3VWdVFwSE5pMVg0YnNRSEs0Yy9HcHk2d3ha?=
 =?utf-8?B?cHkzMng5eXVrS0hsa2g1dDA2VHRBdmhGMGFxQklrajhaWkN6U2lIbC9oNk5y?=
 =?utf-8?B?Z1VLUEkwczhUeUtGQTI4QXk5QWUzRDJ1aWh4VkRDSGsrT0plQmZ5Z0hqWFBT?=
 =?utf-8?B?aEs1a1RCU0E5SjZVWDlKWiswditkTytLMlZVbk5sOU1ieE0vbUF3dHEwZ092?=
 =?utf-8?B?TnQzZkZTekJoOHNKa2VJTDVOR01VVXhUZkNDcjBQMHhvOHcwb0Y0NWRKS2wy?=
 =?utf-8?B?TFZEMWxwNmlnQWFuWENSSnJVc1RGSXk3bnBlNTljMURIcmxiQ3kxeVFNL3hU?=
 =?utf-8?B?cWR3S1d0SkJNdXBmanpNdFlMaXp1S2JRTW4wNkF0Ujd0dXNZUkZmS3NUUlFp?=
 =?utf-8?B?eVR4UzlEZUNqSHBaYzRocVlvL2trQ25IT29jbjZma0NRL3czN1hqcGZEaXBL?=
 =?utf-8?B?OEFjV3UxTFBJc0M5eUJLMldMNldoa2hXNjliK3FtSGRzdkRnQ1Yyem55UU9C?=
 =?utf-8?B?KzlDclNnUng1d2Fob2dDcGlNaFZPRmVmQitxWStBTFJMUktvQitQSkdjZmg2?=
 =?utf-8?B?aTNXc1ZvV3pNcVlEaGlQQXBKYkhIbWNPajF4NnNzRk4zZHh5Wk1mQW15WkVQ?=
 =?utf-8?B?SHRCRkcrM0JBa0VFeU91Rkt4RlpRUU5lcVM2SjhSVUV3ZFJ3OXpCYmRtUFlm?=
 =?utf-8?B?TjFxS1QyM0kvMjQ1TFBpeGsxVUtFNUNRR3JFdUlZSlFtdWRYOHdFcm1SWkxy?=
 =?utf-8?B?aEI1RXM4MEpnU2dFYmxsYjBRN29hVW9JVzBNVEMvTnZDSEFPYTIybVB4YTlM?=
 =?utf-8?B?LzRYbjdGUkpIVjRFdWhoOGc1aXlVRlVkVnBpMTlLV0l3VXZFRjVZVkRxaXlt?=
 =?utf-8?B?YzVkdi9LUmNhOU9ndlJuL3hHTkN4N0pyZDVPRHlITnZVa1pHbHh2L1VCZnUr?=
 =?utf-8?B?a1BmQjBuZVM3T1lMZVN6Um5LU0YyTndmWElXMXpvVkRJRHl1amJ1OEVFZ2dv?=
 =?utf-8?B?YjhjU3hudExPbW1EVGN3T0kyYTBjRXpFV1czdVNhRWR2bnU1aldkQ1pLRjJS?=
 =?utf-8?B?aGJmYXFRa0xlc3M0bHhSc3YyeHhYaGZpN0grR3RDdUtianFEWlp6UGYrU2hT?=
 =?utf-8?B?M0JhQ29qdHJVaWNyQ2k0Wm5RK0RxVzl6SDdtaDYvMXpBQ296dVdWK0VyZHZw?=
 =?utf-8?B?czhpVnRpRUlSTEVRQ21YMWNONjZoVVl1N0pMMmlvN1FiblZVaXl1NGdqWEwv?=
 =?utf-8?B?b2Z3dU05NStHeEFISkIxZnBZenZiNklBS3JRZTg4S2lXTi9OajBBdmgwM0tF?=
 =?utf-8?B?REtlV1NoQzBJZFhoYmgzMHREMEpzZ1FNaVIrUitqTndBcU1UOGl1MTlIWmhz?=
 =?utf-8?B?Z3dqT09OZXV0b2l5ajlJZXhuL3FsQmZLYW9ScG5tZlBWQ1ZVdVdKV3FOTDc1?=
 =?utf-8?B?U2FBZktZeHJtYjQwQ3JZZFhkN2ZFK3pDbnBleVk0d0pJbDAyaVhPN2hOazcx?=
 =?utf-8?B?SCtHcXVFeUpCOFFoenJyYlQ2dDByK08xRTAxWktZbFlaek5TYXI1bHRTNzFM?=
 =?utf-8?B?TTZmaGU1V0VzVnl0NnVWa2dHTnh5dnJ6NGlONXZTTVFvUHA2MnprUEVwbU9j?=
 =?utf-8?B?S3dQSUlrSE1hbWFHTGR6dnhuQk50UmplWlN3UEVwQW5tVTFMUU05SktCL1By?=
 =?utf-8?B?VGhlL2tSN0o2ZXMwdC9adGpRTGVMazUxVlFSUGNsNkVJd1JzVTRQdlBJeFVD?=
 =?utf-8?B?L29vYk9HN3ZDb3R2bk9CVHdmdTFLaG9ZcERnVzlRdXFTcndwZXF0eUhsaHFi?=
 =?utf-8?B?YW51akNJSkphLzhRbnkxNU5xNDMwMzB2WkZ4TXd3YnU1REJicE56YlB6emZp?=
 =?utf-8?Q?R0QgJp1weBIKdMa0uvOcycYLhAixiU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:46:39.8641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 363ceb3a-939d-43b6-ed16-08dd6d575438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346

Hello all,

On 3/25/2025 8:28 PM, Dominique Martinet wrote:
> Thanks for the traces.
> 
> w/ revert
> K Prateek Nayak wrote on Tue, Mar 25, 2025 at 08:19:26PM +0530:
>>     kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_poll rd poll
>>     kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_request wr poll
>>     kworker/100:1-1803    [100] .....   286.618823: p9_read_work: Data read wait 7
> 
> new behavior
>>             repro-4076    [031] .....    95.011394: p9_fd_poll: p9_fd_poll rd poll
>>             repro-4076    [031] .....    95.011394: p9_fd_poll: p9_fd_request wr poll
>>             repro-4076    [031] .....    99.731970: p9_client_rpc: Wait event killable (-512)
> 
> For me the problem isn't so much that this gets ERESTARTSYS but that it
> nevers gets to read the 7 bytes that are available?

I'm back after getting distracted for a bit. So here it goes:

On the mainline, the signal is actually SIGKILL from parent thread
due to a timeout:

            repro-4084    [112] d..2.   233.654264: signal_generate: sig=9 errno=0 code=0 comm=repro pid=4085 grp=1 res=0
            repro-4084    [112] d..1.   233.654272: signal_generate: sig=9 errno=0 code=0 comm=repro pid=4085 grp=1 res=1
            repro-4085    [125] .....   233.654304: p9_client_rpc: Wait event killable (-512) (1) (0) (118)
            repro-4085    [125] .....   233.654308: p9_client_rpc: Flushed (-512)
            repro-4085    [125] .....   233.654312: p9_client_rpc: Final error (-512)
            repro-4085    [125] .....   233.654313: p9_client_write: p9_client_rpc done
            repro-4085    [125] .....   233.654313: p9_client_write: p9_client_rpc error (-512)
            repro-4085    [125] .....   233.654315: v9fs_issue_write: Issue write done 2 err(-512)

Specifically, this part:

     for (;;) {
       sleep_ms(10);
       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
         break;
       if (current_time_ms() - start < 5000)
         continue;
       kill_and_wait(pid, &status); /* <------- here */
       break;
     }

Now for the 7 bytes that were not read - If you look at the traces,
every time there is a valid trans_mod->request(), there is a kworker
wakeup:

            repro-4102    [100] .....   286.618772: p9_client_write: p9_client_rpc
            repro-4102    [100] .....   286.618780: p9_fd_request: p9_fd_request
            repro-4102    [100] .....   286.618781: p9_fd_request: p9_fd_request EPOLL
            repro-4102    [100] .....   286.618781: p9_fd_request: p9_fd_request schedule work  <----- this
    kworker/100:1-1803    [100] .....   286.618784: p9_write_work: Data write wait 32770

However, for that last 7 byte read, there is in fact no wakeup:

            repro-4102    [100] .....   286.618805: p9_client_write: p9_client_rpc
            repro-4102    [100] .....   286.618817: p9_fd_request: p9_fd_request
            repro-4102    [100] .....   286.618818: p9_fd_request: p9_fd_request EPOLL
            repro-4102    [100] .....   286.618818: p9_fd_poll: p9_fd_poll rd poll
            repro-4102    [100] .....   286.618818: p9_fd_poll: p9_fd_request wr poll  <--- No wakeup after
    kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_poll rd poll
    kworker/100:1-1803    [100] .....   286.618822: p9_fd_poll: p9_fd_request wr poll
    kworker/100:1-1803    [100] .....   286.618823: p9_read_work: Data read wait 7
    kworker/100:1-1803    [100] .....   286.618825: p9_read_work: Data read 7

The kworker would spuriously wakeup, do something, realizes it wasn't
suppose to read it, and then disconnects the connection waking up all
waiters.

But if we haven't sent a request, why are we waiting at all?

> 
> If the repro has already written the bytes in both cases then there's no
> reason to wait 5 seconds here...
> 
> OTOH syzbot 9p code is silly and might have been depending on something
> that's not supposed to work e.g. they might be missing a flush or
> equivalent for all I know (I still haven't looked at the repro)
> 

I believe if c->trans_mod->request(c, req) does not dispatch the
request to the worker for RPC, the caller must not wait. So here
goes something that got the benchmark going in my case which might
be totally wrong but worth a look:

#syz test: upstream aaec5a95d59615523db03dd53c2052f0a87beea7

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 196060dc6138..148533c993f1 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -687,7 +687,11 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
  	else
  		n = p9_fd_poll(m->client, NULL, NULL);
  
-	if (n & EPOLLOUT && !test_and_set_bit(Wworksched, &m->wsched))
+	/* Request was not sent */
+	if (!(n & EPOLLOUT))
+		return -EIO;
+
+	if (!test_and_set_bit(Wworksched, &m->wsched))
  		schedule_work(&m->wq);
  
  	return 0;


