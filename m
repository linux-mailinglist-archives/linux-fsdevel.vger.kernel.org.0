Return-Path: <linux-fsdevel+bounces-35953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDE9DA1D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 06:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D0BB22CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 05:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B201411C8;
	Wed, 27 Nov 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pWlaQMOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071CD3FB9C;
	Wed, 27 Nov 2024 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686494; cv=fail; b=KXgZb1R7WhRv6dssLYYjt42XfVnpU0fSKlOx0P1dvD2fSAzH7wOV/nDY9i2aGFad+dbbvPwCjkavxPzXXFT3QmvGTrFSYiQzvZ8xeOb+hrw82r6FMBHOyVhUb1nwMTHNieYVC8vvzLKIg8EuwQKS+r0wTK8+1YcwMsfa5qctjIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686494; c=relaxed/simple;
	bh=V944oMLOVaHxzty0WPFcQIxoWh7Hz4aBgsNVbqiE/UU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MbAXilDg7uNAWnrCwaS9sbNEmyhyFo+JEIfUqJvFQ2y65kiVfz4ia6NQ+zV1e4pkZltJzAOvSnYQ/ONcvYy8iMYi1Cl8WkzWui5eMCnC1IwqHUZvCb601p9/tahDR3xdb8Mvn6OFKAS+3spNQPlARFRS6Ekttu/S1OBqn+x47gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pWlaQMOH; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2/QZ36vrFkJ5jAfhIPFdmS4t/9jS8I5rh9gb8QQsUB7wH4s9bP03gwj8teOTlutWg+wVFZTI0nHG3GW2w2HmqSXBanGpmwHyFmtACZUH999TqsDLFyQZc+p//ukNFhrGxiN+0KBhN8IET2Bz9bP83aszmy0X+MoPsO1dygIBvJGOwjViSXcu8czbA5xwssrxHvaoA8MYm8dnVM3Zqz6SrLRhd+TR4vaT3TKgt96aA3HXZrHCsO5EulTQKav+107eaZQfygWs5VdUY/pcLZJDuOpVsCbUdaNMQFhjc83Fpcl7ES470gWcLo44ruN3N3ItwioQC9Wc9UoRUv+ctqQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjJ7Qk9JR5Jdeajt7WNpBhjFR7ZtelWxw0mjHzvuWZg=;
 b=WHtDU0DVaiaoBPbijYwIijV3zo+50poPic+rIHrAQIJcKIXKKk+Ccgmu3hoJM9uG5RNjW5kSoRG+SCi2+V7rzSXE0XkVit+rTCxSEsrOSwf1UgLrZo4Fti2a9lLnzqUpzGvZvU6UgMCkcNrmEJjGGLWgVXX5/ZuGsMB2pNNQkyBdL2PsHZrVxxkUunUnL9CH5uFRXLXN4rLC8N+TpnE94KechCOQDn6CIdQFT/3xI2SVTSrks8cgMOcMPLwJJ4KPHwG1qTEt0RH2CNQRFTiGlFrz7TtE1Z3f6CbndN2ZTiHGVuiVuqd+6H1JYUY17G0IkCNdBOwWhW/2GYAQTSdlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjJ7Qk9JR5Jdeajt7WNpBhjFR7ZtelWxw0mjHzvuWZg=;
 b=pWlaQMOHis1cbu9PLXi5JM9xY4gu5fLYTDtDdXhlx2QuJOlAbTrnV+ZFIjaqKJMaE3lmqf9jGIq5s0N5+weKUxBnWOFVQUuUsVMWOW1o+K11o407S76YGug2r6wTXkZ6ZDgL1QNmeKPMHAlLiLxAHBkvaMf3mJzm3Ugr0eBTUPk=
Received: from MW4PR04CA0223.namprd04.prod.outlook.com (2603:10b6:303:87::18)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 05:48:04 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::91) by MW4PR04CA0223.outlook.office365.com
 (2603:10b6:303:87::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Wed,
 27 Nov 2024 05:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 05:48:03 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 23:47:57 -0600
From: Bharata B Rao <bharata@amd.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <nikunj@amd.com>, <willy@infradead.org>, <vbabka@suse.cz>,
	<david@redhat.com>, <akpm@linux-foundation.org>, <yuzhao@google.com>,
	<mjguzik@gmail.com>, <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <joshdon@google.com>, <clm@meta.com>,
	Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 0/1] Large folios in block buffered IO path
Date: Wed, 27 Nov 2024 11:17:36 +0530
Message-ID: <20241127054737.33351-1-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: c0653534-a589-4579-cfe1-08dd0ea70f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGNwNjFxcER2ei9WdGxnbmZxS0I1TzY3emxEWWpUYzVxa0JadEVlN3JqTkIv?=
 =?utf-8?B?aUhIZExXQzJsMHQxdmtQeTNOUjQ1YVQrZnFHU1pKQ1FVcVppdGdaYzlqcDJv?=
 =?utf-8?B?NnRVZFU4UUFvaURrSTFxYUhZU2NPYVVXQVI1MU5RZ3dpN24rVm9URnhSN0w4?=
 =?utf-8?B?THFCd3Q4UTFGWWVuZ3d4NXdMRmY5UzNZWXpscE5haEprSEdLSjRpM041ODN3?=
 =?utf-8?B?Zm1JbnZPQS9CYlBCdmdwZW5BcnQ4SDZTRCtheG55TTdNN00za091UHN1ZHFY?=
 =?utf-8?B?K0hTbkRHdzBCMS83Tm9Vb2dRTU43TjBFM25SYTFkUWZrNytURGdEVUd1bE1s?=
 =?utf-8?B?Zk82ZkNGazRFLy85K0VSOFJLN1hmSmZxUmFaWTc3bHUyNVU1VTNON1NMbFZr?=
 =?utf-8?B?MTBhNm1qbWljOXdxWVJzZXYvU3U5VCtoMUlSVkoza0JuOWk4RlFibjJ3Ui9q?=
 =?utf-8?B?bEVPRmFaSTEzVlI1clFoNDZuSVhWWWJOd1QxbCtGKzg5STJsKzRDMHRiMEtR?=
 =?utf-8?B?N2hCMjdUZjN5d3pDYnppNHZaSGxDUE8yeW9zSExTc3dnYTVGb2E3cXhjSWFx?=
 =?utf-8?B?cUR0ZTd3OHk4MmgxQzVDQWFTNGFtVE9qZFVwVkplVXdvYUlJd0VhK25YTWg5?=
 =?utf-8?B?dGYraGJyNUNiOG9oMWhuWHV0dVVVemc5Q293dHNpUk9BLzhKS1JNV3IzQ3do?=
 =?utf-8?B?RjVpTVNvUVhyb1V0YVpXMHA0QnVzak03ZWNHd1d2aEJkMjNteTNvS3VtT1RI?=
 =?utf-8?B?K09YcEJFZzNRSC96S2ltZGEzYUpPMjZYbzd2ajd2dFJYMnBTSERtTTF6NHhi?=
 =?utf-8?B?cWlRWnVNTWExT0gyV1R3ck9KVHdBR0VVSjJKM2I5elhrZkdtOHlWVkNnQ251?=
 =?utf-8?B?ZW9EcC9WQVdMSjEvdFplcEZzT1FYTUhybWd0VjNSZ3l3YnRJc0ROR0l4YWp3?=
 =?utf-8?B?SVk5ZEIzVXhhaUkxTGp0aDFRelZlMGtmaWx1WTVXU09FZk10ekZFRVd5ak10?=
 =?utf-8?B?QXo1dVRLdDFmbGNrVmZsVUovY1RVNlJuZlFuYVJQQTJCR2lMdC95WXozMGRj?=
 =?utf-8?B?aC9uVDh2VjQ4eUlBOHhpdVI5ZVBZM2Y2dnpkejBKcDBZN3I0dmtvMGc0WWE3?=
 =?utf-8?B?NzQzTXhrNUNYZDhQZjQrcGoraTB3dWZXSXNQZklWRWprdVZ1NXFxdTRwMHdM?=
 =?utf-8?B?OG9BVGhiamNOang3V05udWV4ZmY3T2l2NjIzUWNTOEJrVkVzU3NtOWp1dm9i?=
 =?utf-8?B?Q0NWdlpoTU9BeE9oUzg2ckp1UFBnN20wcjdJVEQrTkpZK0oycmYrVGQ3M2pE?=
 =?utf-8?B?QkNGTmF1MVpCZnBtdDRYNFhwUkRMaXJHUm5EYmlRd0MvRVp1VTY0K1VZdGhU?=
 =?utf-8?B?SlJtVVJ2bVhZRkhmU2pBU3lhdEREZllveWk4UDVhZlZRRmJobzBKN3l5OWFC?=
 =?utf-8?B?a3BhUi9TN3lOc0lIaXlENWp5ck9SSVpyL3N0bC9jVUp4Sng0aHA4UTdUeWVC?=
 =?utf-8?B?d2NpTTlVRXJCbklQT0g2VUJEbG8xVjYrVXdQRU5OQ25qQzB6VGE3STdDSzZv?=
 =?utf-8?B?SmNVMHg5RXh5TW9WRUtuek5vS0tIazN2Y1hGUExLT3ppSHdLK1I0OGxtYmxk?=
 =?utf-8?B?aVEyMGRkODcxR0RocG52dkxzTGUxTUpoVGhWRUQ0bmJ1dkdpeTRmR3crcGJ1?=
 =?utf-8?B?WEFtYnkrNzc5aUpuNFdoS0VYcjYvUXAyd1c3YXhtR2VmbW9GazcxUzhXb0Iz?=
 =?utf-8?B?Ly95ZHZybFdyQndtblhKWVRQRG9LdVY5VUJnWGNnN0tOREpsV3hHMzRNT05q?=
 =?utf-8?B?b2RRaWxTZk0vTHpydm9MY05pTG5naFo3YzRzekhUcFRuVnNyOWFpSm04T0M5?=
 =?utf-8?B?aTdQUGhKU1hwS2M0RHJEbWNEQndxRlhjU3hPeEFqdkFBdVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:48:03.6098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0653534-a589-4579-cfe1-08dd0ea70f6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772

Recently we discussed the scalability issues while running large
instances of FIO with buffered IO option on NVME block devices here:

https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/

One of the suggestions Chris Mason gave (during private discussions) was
to enable large folios in block buffered IO path as that could
improve the scalability problems and improve the lock contention
scenarios.

This is an attempt to check the feasibility and potential benefit of the
same. To keep changes to minimum and also to non-disruptively test this
for the required block device only, I have added an ioctl to set large
folios support on block device mapping. I understand that this is not
the right way to do this but this is just an experiment to evaluate the
potential benefit.

Experimental setup
------------------
2 node EPYC server based Zen5 server with 512G memory in each node.

Disk layout for FIO:
nvme2n1     259:12   0   3.5T  0 disk 
├─nvme2n1p1 259:13   0 894.3G  0 part 
├─nvme2n1p2 259:14   0 894.3G  0 part 
├─nvme2n1p3 259:15   0 894.3G  0 part 
└─nvme2n1p4 259:16   0 894.1G  0 part 

Four parallel instances of FIO are run on the above 4 partitions with
the following options:

-filename=/dev/nvme2n1p[1,2,3,4] -direct=0 -thread -size=800G -rw=rw -rwmixwrite=[10,30,50] --norandommap --randrepeat=0 -ioengine=sync -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting

Results
-------
default: Unmodified kernel and FIO.
patched: Kernel with BLKSETLFOLIO ioctl(introduced in this patchset) and FIO
modified to issue that ioctl.
In the below table, r is READ bw and w is WRITE bw reported by FIO.

		default				patched
ro (w/o -rw=rw option)
Instance 1	r=12.3GiB/s			r=39.4GiB/s
Instance 2	r=12.2GiB/s			r=39.1GiB/s
Instance 3	r=16.3GiB/s			r=37.1GiB/s
Instance 4	r=14.9GiB/s			r=42.9GiB/s

rwmixwrite=10%
Instance 1	r=27.5GiB/s,w=3125MiB/s		r=75.9GiB/s,w=8636MiB/s
Instance 2	r=25.5GiB/s,w=2898MiB/s		r=87.6GiB/s,w=9967MiB/s
Instance 3	r=25.7GiB/s,w=2922MiB/s		r=78.3GiB/s,w=8904MiB/s
Instance 4	r=27.5GiB/s,w=3134MiB/s		r=73.5GiB/s,w=8365MiB/s

rwmixwrite=30%
Instance 1	r=55.7GiB/s,w=23.9GiB/s		r=59.2GiB/s,w=25.4GiB/s
Instance 2	r=38.5GiB/s,w=16.5GiB/s		r=57.6GiB/s,w=24.7GiB/s
Instance 3	r=37.5GiB/s,w=16.1GiB/s		r=59.5GiB/s,w=25.5GiB/s
Instance 4	r=37.4GiB/s,w=16.0GiB/s		r=63.3GiB/s,w=27.1GiB/s

rwmixwrite=50%
Instance 1	r=37.1GiB/s,w=37.1GiB/s		r=40.7GiB/s,w=40.7GiB/s
Instance 2	r=37.6GiB/s,w=37.6GiB/s		r=45.9GiB/s,w=45.9GiB/s
Instance 3	r=35.1GiB/s,w=35.1GiB/s		r=49.2GiB/s,w=49.2GiB/s
Instance 4	r=43.6GiB/s,w=43.6GiB/s		r=41.2GiB/s,w=41.2GiB/s

Summary of FIO throughput
-------------------------
- Significant increase(3x) in bandwidth for ro case.
- Significant increase(3x) in bandwidth for rw 10%.
- Good gains(~1.15 to 1.5x) for 30% and 50%.

perf-lock contention output
---------------------------
The lock contention data doesn't look all that conclusive but for 30% rwmixwrite
mix it looks like this:

perf-lock contention default
 contended   total wait     max wait     avg wait         type   caller

1337359017     64.69 h     769.04 us    174.14 us     spinlock   rwsem_wake.isra.0+0x42
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
                        0xffffffff8f39e7d2  rwsem_wake.isra.0+0x42
                        0xffffffff8f39e88f  up_write+0x4f
                        0xffffffff8f9d598e  blkdev_llseek+0x4e
                        0xffffffff8f703322  ksys_lseek+0x72
                        0xffffffff8f7033a8  __x64_sys_lseek+0x18
                        0xffffffff8f20b983  x64_sys_call+0x1fb3
   2665573     64.38 h       1.98 s      86.95 ms      rwsem:W   blkdev_llseek+0x31
                        0xffffffff903f15bc  rwsem_down_write_slowpath+0x36c
                        0xffffffff903f18fb  down_write+0x5b
                        0xffffffff8f9d5971  blkdev_llseek+0x31
                        0xffffffff8f703322  ksys_lseek+0x72
                        0xffffffff8f7033a8  __x64_sys_lseek+0x18
                        0xffffffff8f20b983  x64_sys_call+0x1fb3
                        0xffffffff903dce5e  do_syscall_64+0x7e
                        0xffffffff9040012b  entry_SYSCALL_64_after_hwframe+0x76
 134057198     14.27 h      35.93 ms    383.14 us     spinlock   clear_shadow_entries+0x57
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5c7f  _raw_spin_lock+0x3f
                        0xffffffff8f5e7967  clear_shadow_entries+0x57
                        0xffffffff8f5e90e3  mapping_try_invalidate+0x163
                        0xffffffff8f5e9160  invalidate_mapping_pages+0x10
                        0xffffffff8f9d3872  invalidate_bdev+0x42
                        0xffffffff8f9fac3e  blkdev_common_ioctl+0x9ae
                        0xffffffff8f9faea1  blkdev_ioctl+0xc1
  33351524      1.76 h      35.86 ms    190.43 us     spinlock   __remove_mapping+0x5d
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5c7f  _raw_spin_lock+0x3f
                        0xffffffff8f5ec71d  __remove_mapping+0x5d
                        0xffffffff8f5f9be6  remove_mapping+0x16
                        0xffffffff8f5e8f5b  mapping_evict_folio+0x7b
                        0xffffffff8f5e9068  mapping_try_invalidate+0xe8
                        0xffffffff8f5e9160  invalidate_mapping_pages+0x10
                        0xffffffff8f9d3872  invalidate_bdev+0x42
   9448820     14.96 m       1.54 ms     95.01 us     spinlock   folio_lruvec_lock_irqsave+0x64
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
                        0xffffffff8f6e3ed4  folio_lruvec_lock_irqsave+0x64
                        0xffffffff8f5e587c  folio_batch_move_lru+0x5c
                        0xffffffff8f5e5a41  __folio_batch_add_and_move+0xd1
                        0xffffffff8f5e7593  deactivate_file_folio+0x43
                        0xffffffff8f5e90b7  mapping_try_invalidate+0x137
                        0xffffffff8f5e9160  invalidate_mapping_pages+0x10
   1488531     11.07 m       1.07 ms    446.39 us     spinlock   try_to_free_buffers+0x56
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5c7f  _raw_spin_lock+0x3f
                        0xffffffff8f768c76  try_to_free_buffers+0x56
                        0xffffffff8f5cf647  filemap_release_folio+0x87
                        0xffffffff8f5e8f4c  mapping_evict_folio+0x6c
                        0xffffffff8f5e9068  mapping_try_invalidate+0xe8
                        0xffffffff8f5e9160  invalidate_mapping_pages+0x10
                        0xffffffff8f9d3872  invalidate_bdev+0x42
   2556868      6.78 m     474.72 us    159.07 us     spinlock   blkdev_llseek+0x31
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5d01  _raw_spin_lock_irq+0x51
                        0xffffffff903f14c4  rwsem_down_write_slowpath+0x274
                        0xffffffff903f18fb  down_write+0x5b
                        0xffffffff8f9d5971  blkdev_llseek+0x31
                        0xffffffff8f703322  ksys_lseek+0x72
                        0xffffffff8f7033a8  __x64_sys_lseek+0x18
                        0xffffffff8f20b983  x64_sys_call+0x1fb3
   2512627      3.75 m     450.96 us     89.55 us     spinlock   blkdev_llseek+0x31
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5d01  _raw_spin_lock_irq+0x51
                        0xffffffff903f12f0  rwsem_down_write_slowpath+0xa0
                        0xffffffff903f18fb  down_write+0x5b
                        0xffffffff8f9d5971  blkdev_llseek+0x31
                        0xffffffff8f703322  ksys_lseek+0x72
                        0xffffffff8f7033a8  __x64_sys_lseek+0x18
                        0xffffffff8f20b983  x64_sys_call+0x1fb3
    908184      1.52 m     439.58 us    100.58 us     spinlock   blkdev_llseek+0x31
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5d01  _raw_spin_lock_irq+0x51
                        0xffffffff903f1367  rwsem_down_write_slowpath+0x117
                        0xffffffff903f18fb  down_write+0x5b
                        0xffffffff8f9d5971  blkdev_llseek+0x31
                        0xffffffff8f703322  ksys_lseek+0x72
                        0xffffffff8f7033a8  __x64_sys_lseek+0x18
                        0xffffffff8f20b983  x64_sys_call+0x1fb3
       134      1.48 m       1.22 s     663.88 ms        mutex   bdev_release+0x69
                        0xffffffff903ef1de  __mutex_lock.constprop.0+0x17e
                        0xffffffff903ef863  __mutex_lock_slowpath+0x13
                        0xffffffff903ef8bb  mutex_lock+0x3b
                        0xffffffff8f9d5249  bdev_release+0x69
                        0xffffffff8f9d5921  blkdev_release+0x11
                        0xffffffff8f7089f3  __fput+0xe3
                        0xffffffff8f708c9b  __fput_sync+0x1b
                        0xffffffff8f6fe8ed  __x64_sys_close+0x3d


perf-lock contention patched
 contended   total wait     max wait     avg wait         type   caller

   1153627     40.15 h      48.67 s     125.30 ms      rwsem:W   blkdev_llseek+0x31
                        0xffffffff903f15bc  rwsem_down_write_slowpath+0x36c
                        0xffffffff903f18fb  down_write+0x5b
                        0xffffffff8f9d5971  blkdev_llseek+0x31
                        0xffffffff8f703322  ksys_lseek+0x72
                        0xffffffff8f7033a8  __x64_sys_lseek+0x18
                        0xffffffff8f20b983  x64_sys_call+0x1fb3
                        0xffffffff903dce5e  do_syscall_64+0x7e
                        0xffffffff9040012b  entry_SYSCALL_64_after_hwframe+0x76
 276512439     39.19 h      46.90 ms    510.22 us     spinlock   clear_shadow_entries+0x57
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5c7f  _raw_spin_lock+0x3f
                        0xffffffff8f5e7967  clear_shadow_entries+0x57
                        0xffffffff8f5e90e3  mapping_try_invalidate+0x163
                        0xffffffff8f5e9160  invalidate_mapping_pages+0x10
                        0xffffffff8f9d3872  invalidate_bdev+0x42
                        0xffffffff8f9fac3e  blkdev_common_ioctl+0x9ae
                        0xffffffff8f9faea1  blkdev_ioctl+0xc1
 763119320     26.37 h     887.44 us    124.38 us     spinlock   rwsem_wake.isra.0+0x42
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
                        0xffffffff8f39e7d2  rwsem_wake.isra.0+0x42
                        0xffffffff8f39e88f  up_write+0x4f
                        0xffffffff8f9d598e  blkdev_llseek+0x4e
                        0xffffffff8f703322  ksys_lseek+0x72
                        0xffffffff8f7033a8  __x64_sys_lseek+0x18
                        0xffffffff8f20b983  x64_sys_call+0x1fb3
  33263910      2.87 h      29.43 ms    310.56 us     spinlock   __remove_mapping+0x5d
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5c7f  _raw_spin_lock+0x3f
                        0xffffffff8f5ec71d  __remove_mapping+0x5d
                        0xffffffff8f5f9be6  remove_mapping+0x16
                        0xffffffff8f5e8f5b  mapping_evict_folio+0x7b
                        0xffffffff8f5e9068  mapping_try_invalidate+0xe8
                        0xffffffff8f5e9160  invalidate_mapping_pages+0x10
                        0xffffffff8f9d3872  invalidate_bdev+0x42
  58671816      2.50 h     519.68 us    153.45 us     spinlock   folio_lruvec_lock_irqsave+0x64
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
                        0xffffffff8f6e3ed4  folio_lruvec_lock_irqsave+0x64
                        0xffffffff8f5e587c  folio_batch_move_lru+0x5c
                        0xffffffff8f5e5a41  __folio_batch_add_and_move+0xd1
                        0xffffffff8f5e7593  deactivate_file_folio+0x43
                        0xffffffff8f5e90b7  mapping_try_invalidate+0x137
                        0xffffffff8f5e9160  invalidate_mapping_pages+0x10
       284     22.33 m       5.35 s       4.72 s         mutex   bdev_release+0x69
                        0xffffffff903ef1de  __mutex_lock.constprop.0+0x17e
                        0xffffffff903ef863  __mutex_lock_slowpath+0x13
                        0xffffffff903ef8bb  mutex_lock+0x3b
                        0xffffffff8f9d5249  bdev_release+0x69
                        0xffffffff8f9d5921  blkdev_release+0x11
                        0xffffffff8f7089f3  __fput+0xe3
                        0xffffffff8f708c9b  __fput_sync+0x1b
                        0xffffffff8f6fe8ed  __x64_sys_close+0x3d
   2181469     21.38 m       1.15 ms    587.98 us     spinlock   try_to_free_buffers+0x56
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5c7f  _raw_spin_lock+0x3f
                        0xffffffff8f768c76  try_to_free_buffers+0x56
                        0xffffffff8f5cf647  filemap_release_folio+0x87
                        0xffffffff8f5e8f4c  mapping_evict_folio+0x6c
                        0xffffffff8f5e9068  mapping_try_invalidate+0xe8
                        0xffffffff8f5e9160  invalidate_mapping_pages+0x10
                        0xffffffff8f9d3872  invalidate_bdev+0x42
    454398      4.22 m      37.54 ms    557.13 us     spinlock   __remove_mapping+0x5d
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f5c7f  _raw_spin_lock+0x3f
                        0xffffffff8f5ec71d  __remove_mapping+0x5d
                        0xffffffff8f5f4f04  shrink_folio_list+0xbc4
                        0xffffffff8f5f5a6b  evict_folios+0x34b
                        0xffffffff8f5f772f  try_to_shrink_lruvec+0x20f
                        0xffffffff8f5f79ef  shrink_one+0x10f
                        0xffffffff8f5fb975  shrink_node+0xb45
       773      3.53 m       2.60 s     273.76 ms        mutex   __lru_add_drain_all+0x3a
                        0xffffffff903ef1de  __mutex_lock.constprop.0+0x17e
                        0xffffffff903ef863  __mutex_lock_slowpath+0x13
                        0xffffffff903ef8bb  mutex_lock+0x3b
                        0xffffffff8f5e3d7a  __lru_add_drain_all+0x3a
                        0xffffffff8f5e77a0  lru_add_drain_all+0x10
                        0xffffffff8f9d3861  invalidate_bdev+0x31
                        0xffffffff8f9fac3e  blkdev_common_ioctl+0x9ae
                        0xffffffff8f9faea1  blkdev_ioctl+0xc1
   1997851      3.09 m     651.65 us     92.83 us     spinlock   folio_lruvec_lock_irqsave+0x64
                        0xffffffff903f60a3  native_queued_spin_lock_slowpath+0x1f3
                        0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
                        0xffffffff8f6e3ed4  folio_lruvec_lock_irqsave+0x64
                        0xffffffff8f5e587c  folio_batch_move_lru+0x5c
                        0xffffffff8f5e5a41  __folio_batch_add_and_move+0xd1
                        0xffffffff8f5e5ae4  folio_add_lru+0x54
                        0xffffffff8f5d075d  filemap_add_folio+0xcd
                        0xffffffff8f5e30c0  page_cache_ra_order+0x220

Observations from perf-lock contention
--------------------------------------
- Significant reduction of contention for inode_lock (inode->i_rwsem)
  from blkdev_llseek() path.
- Significant increase in contention for inode->i_lock from invalidate
  and remove_mapping paths.
- Significant increase in contention for lruvec spinlock from
  deactive_file_folio path.

Request comments on the above and I am specifically looking for inputs
on these:

- Lock contention results and usefulness of large folios in bringing
  down the contention in this specific case.
- If enabling large folios in block buffered IO path is a feasible
  approach, inputs on doing this cleanly and correclty.

Bharata B Rao (1):
  block/ioctl: Add an ioctl to enable large folios for block buffered IO
    path

 block/ioctl.c           | 8 ++++++++
 include/uapi/linux/fs.h | 2 ++
 2 files changed, 10 insertions(+)

-- 
2.34.1


