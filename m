Return-Path: <linux-fsdevel+bounces-36905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302839EAD34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 10:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92E8188E201
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4ED225412;
	Tue, 10 Dec 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="etz1KsKZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB522540B;
	Tue, 10 Dec 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824149; cv=fail; b=b+fsHoxqDY2TCPve3XTt0+SzKWoqlyejxQcZdEqzFzKKWA4K0K82f0cBB78guq6e5ci+ZtZ5DJ18+zwSQ40uLh5GNiO7jp9RAeF7foMRmJh6z2+rE+XhToYqPDk0ML5PdYnqSsYvE4q/auxAfWU0cDaGuR0y3zaJAKBMnibGXnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824149; c=relaxed/simple;
	bh=Txpd8WfU6smANj+UIs6BwcUM03ycB9MDqRLazTQnhLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuJSXCgkPVtiLLTRGmkhf3OzHH2W+eleT3TXDR1LD/tdmlteRGTkYBTs2TbJwj3LBbDE+FFo60lFnA2xcmEbSwNX1xgSLuBG0DJXtwt+Oo0RQCOmRKIbulmLkQFLZ62iDSqyA7O+4xJKu8thx72LpseH85AlvbRvyTd7Bm30mjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=etz1KsKZ; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPBHn5E5NLEDx2M5mVhmeFCgEP8qW2i//elzXjTCBw0gVZPGz1EdpK367IvPpeT4iesCW6cBclqreZQbxUPvabn+uYTHVd+KpUm2P8BJ47VBuircoubpUoZXWrj3tB/IMG5ycnfgBGj4hCiHO55rLgdl7725oy+GbRb3YYz579rAkPR2xc7Lb/9uOaYFiaeYZ3H0rI2qtgn7/iMj7LgCJ4jpqbkZUJoUXr/WDxyn59O8xYnhUwGT9hoCq3YszIgu42Wii6AG2FQeXFktmCxoO7cIOMhNUAzW/ehGb3A0CsDwpTF3Hc531RFMMnSWoSERzJFslOGRAn8OZsTtEiOPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaNMzxoG2eScPPvYOEWiCLCN/uTciIDbMbfl7KLstPQ=;
 b=ln0+1EdOrbhrtVpUTR39OHzF0FddqiF9liGI6ZtqxLhpp1i5+zy/8BNsvgqC0vWaRr926yz0klhguTOwtMI1oGxsFeLworDpqx+M4V3NO0LbEmH4aM919RTj2UPLaIoJpxoPfeuNZqwh2lVID8g+S3xnViVq+klwpS7d+lLUChQzDTx76/o85ljkwtFl1nvYCUcE/0ASRCNlhlxaHE1PFu7JUsPspvXb610Xn+8edyrAuMfU8p1Xb17CUWZRUu3Fyv4+WjprNAgrj8vzHMGK8lMPCdjyY0AG3hHmFs1+ry0M0SSfQAlfwschjNQ2YOeuI0eXLokiESY9C5knmZF68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.dk smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaNMzxoG2eScPPvYOEWiCLCN/uTciIDbMbfl7KLstPQ=;
 b=etz1KsKZ4C/8YXM94B0RAg78iPizwPZEMZRvjEqRHj70F95ZYjHY+TKqlMALYGwBPj4AoMymrNDvChaaOvk+cgU0ulkIirPp3MCyvN/JivalShwLyqRzprd08bYVdS+FBOBtaYivxqH/oEbP2cHBAHOTGRWjqHf5lZ4Pa5cWYXE=
Received: from BL1PR13CA0259.namprd13.prod.outlook.com (2603:10b6:208:2ba::24)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 09:49:02 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::40) by BL1PR13CA0259.outlook.office365.com
 (2603:10b6:208:2ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.12 via Frontend Transport; Tue,
 10 Dec 2024 09:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 09:49:01 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:48:58 -0600
From: Bharata B Rao <bharata@amd.com>
To: <axboe@kernel.dk>
CC: <bfoster@redhat.com>, <clm@meta.com>, <hannes@cmpxchg.org>,
	<kirill@shutemov.name>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <willy@infradead.org>
Subject: [PATCHSET v6 0/12] Uncached buffered IO
Date: Tue, 10 Dec 2024 15:18:42 +0530
Message-ID: <20241210094842.204504-1-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 64000f0b-e162-4ebb-f0d0-08dd18ffe05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bndJK2sxV3crZURXTmJYWjRJYlZGL2U4bXNNM1pDUm5mWXg3VkJwR05QdFFl?=
 =?utf-8?B?QUdpT2RFV2RpcXhnd2FOY1U1a3lsbHpmamNodURtSnEyTE5BaGgwYVYyRDJG?=
 =?utf-8?B?SUdHVE1DT0RYbExCNk9NQ2t5NjU5YWw1ZVJCT0VqU1R3MGVpRUp6UkZEN01m?=
 =?utf-8?B?RmpTcGdZb3JnZ1F6N0pVSHRUaU1ZVW9ZTDFHQ3M1cTNOVEpDTWJ3NDY2Tyt3?=
 =?utf-8?B?SXNOamtiWWRKQmVGcXJtTVc0a0NBRStsRXVKQStsekZsTUFRd0NrVGRoSXdl?=
 =?utf-8?B?eEY4aFpCM1htZTdZWG4yUkwvM251aXZKY0JXam4zZVpnWXlUbUU2SnhBWU9l?=
 =?utf-8?B?RExBcmxuamhGME1YbU5adHlBVTVTWFEyQm84MDNSZ0k0dnhOdkU2TmFkTFZC?=
 =?utf-8?B?cEU2VFBLTXlITzBNakRTR1dEa0JTTzhDSjV4VE5yZ1F1N3FtTEVaYUZyeW9W?=
 =?utf-8?B?R2NQQjJVdEdSeUtTRjRkRmxyU0x3dTlac2dHYkZUMEphUVZ3ZlVyU1g3SUpt?=
 =?utf-8?B?dFB0SnFaYjNWeEx3amhvTUtoMTkzZkR6blNsTi81MklvWEg0NlBZODVEa2pR?=
 =?utf-8?B?d3BFQk1PclhoNzhZVzhjdExiSnZ0aENuOGZWbEhINkQ0V1lmYVc5RHNHd2lz?=
 =?utf-8?B?NXVwNkFuQnFSUlZmZElrV002UG9BOUJRUkRvRy9RVkJNdmY2aFY0TW5Oa044?=
 =?utf-8?B?UzFKTmlNMXNHQzRTUDdOdnRtSlhobjMralh2K3UvZDdHc1pxMFk2aHpndks5?=
 =?utf-8?B?YUNDWjBOalBtS0JUYlR1TTM1RnJRSkNhaDFzMmwxbVQwY2lpeWxFbHhJZnln?=
 =?utf-8?B?aS9udkQ0Nm9yN0lMSEU3WnZJODBaVWpzOXdpVXN6Vmt4U0htaGo3SDhDVFhk?=
 =?utf-8?B?UkVtYjhINEVlRzlydEVOOVR5WU9BVUN4cUwyVG15M015bVZjM1dMV3FocjlX?=
 =?utf-8?B?TXRpRG9iTlRmM1F4czY5cEZZVWx0Vzd6ZTFWSkk5dGZVbktyeWZMVWw2Q21y?=
 =?utf-8?B?bnpOSUdKMXBiQ2lQYkdqZVhkSG9zTlMwQ29Ta0w5SnJDOUpORHVuQTZXb3Q1?=
 =?utf-8?B?Z0VUVlBqQ0p6a3NrMEFtVHpiUCsyb0VHK1hLMHRVeWpaZ2RNQVRXR2R1Rzdu?=
 =?utf-8?B?KzRMbzNIcnBuS2dnMTZsZzJydmFLcmVaSkoySi9OOG52b2dKNDhVZVp0a25V?=
 =?utf-8?B?UnhHclEzN25Ick9ZaFpzK3Y4SU1qM2FRaHArYXN5cGczWC9vT21kOVFSQW8r?=
 =?utf-8?B?S2lpVUhENXAwRTBXa0Uzb0h3TnRSWVFXb0ZrWHRTVU9BdWtSVm10K3gyT0Vn?=
 =?utf-8?B?VTAzZ08rSjdrNFFzM2sxSmNsUCtWb0JIVk9RbFBXeFZHVUYzZm5hVGtwLytI?=
 =?utf-8?B?ZTdJM3pkL2xuSEdwcHJBaTZUSFJyYW9HQ0g1RThRQjdSQ09YdERGTERPQ2V4?=
 =?utf-8?B?WTczWEZ0cy8rN0N5VkZMVEdpMXdJc09hNkNIS0hjbzFaRE9wOTRCYjN1NjdX?=
 =?utf-8?B?SlB0R25FRW9ZMlU4ZFlha2lieFU4VFZsRnJVY090TUY3dVpCKzhyOGVhaVln?=
 =?utf-8?B?eVRKdnp0cnMxRGQ4MlpnekhMTFVzY2k2YW56UFBhVG5JR0RSK0ttRUp2QXZY?=
 =?utf-8?B?VXBKeGpIcGc0eDBpVzNyajlHQm5HZnE1cjVrUndtdlgwR3M3eXJZZDFlQVM2?=
 =?utf-8?B?VXRyTmZJaC9CYmlZTlBUaHhWY3VEWk5OWjQrRHZQVVFOdDYxakJDMUFkbEpy?=
 =?utf-8?B?VmhOSmNDVDFxc3VuTSs0RWFYcVFBbE5KNXd2UVNTT2FCSkpMODVaSHBsYXpJ?=
 =?utf-8?B?dWxhWVIwSlRBR2JlQzl1R1VQN3VEWUNjSzFmN1l1NlhiMGZCM25xNlozQVZz?=
 =?utf-8?B?Rlh3NEk2a3RSMFJHU2dSdmxCL3Z1bjVDRllhS01MeGd6Q1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:49:01.5702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64000f0b-e162-4ebb-f0d0-08dd18ffe05b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492

Hi Jens,

I ran a couple of variants of FIO to check how this patchset affects the
FIO numbers. My other motivation with this patchset is to check if it
improves the scalability issues that were discussed in [1] and [2].
But for now, here are some initial numbers.

To enabled uncached buffered IO, I have modified FIO pvsync2 engine to
issue preadv2()/pwritev2() calls with RWF_UNCACHED set. The FIO change
looks like below and I assume this is good enough to correctly use this
patchset.

diff --git a/engines/sync.c b/engines/sync.c
index b8be4eb3..44e9da3d 100644
--- a/engines/sync.c
+++ b/engines/sync.c
@@ -170,6 +170,8 @@ static enum fio_q_status fio_pvsyncio2_queue(struct thread_data *td,
        if (o->nowait)
                flags |= RWF_NOWAIT;
 
+       flags |= RWF_UNCACHED;
+
        iov->iov_base = io_u->xfer_buf;
        iov->iov_len = io_u->xfer_buflen;
 
Also note that I am using your buffered-uncached.8 branch from
https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.8 that has
changes to enable uncached buffered IO for EXT4 and block devices.

In the below reported numbers,
'base' means kernel from buffered-uncached.8 branch and
'patched' means kernel from buffered-uncached.8 branch + above shown FIO change

FIO on EXT4 partitions
======================
nvme1n1     259:12   0   3.5T  0 disk 
├─nvme1n1p1 259:13   0 894.3G  0 part /mnt1
├─nvme1n1p2 259:14   0 894.3G  0 part /mnt2
├─nvme1n1p3 259:15   0 894.3G  0 part /mnt3
└─nvme1n1p4 259:16   0 894.1G  0 part /mnt4

fio -directory=/mnt4/ -direct=0 -thread -size=3G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
fio -directory=/mnt3/ -direct=0 -thread -size=3G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
fio -directory=/mnt1/ -direct=0 -thread -size=3G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
fio -directory=/mnt2/ -direct=0 -thread -size=3G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest

Four NVME devices are formatted with EXT4 and four parallel FIO instances
are run on them with the options as shown above.

FIO output looks like this:

base:
   READ: bw=1233MiB/s (1293MB/s), 1233MiB/s-1233MiB/s (1293MB/s-1293MB/s), io=4335GiB (4654GB), run=3600097-3600097msec
  WRITE: bw=529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=1858GiB (1995GB), run=3600097-3600097msec
   READ: bw=1248MiB/s (1308MB/s), 1248MiB/s-1248MiB/s (1308MB/s-1308MB/s), io=4387GiB (4710GB), run=3600091-3600091msec
  WRITE: bw=535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s), io=1880GiB (2019GB), run=3600091-3600091msec
   READ: bw=1235MiB/s (1294MB/s), 1235MiB/s-1235MiB/s (1294MB/s-1294MB/s), io=4340GiB (4660GB), run=3600094-3600094msec
  WRITE: bw=529MiB/s (555MB/s), 529MiB/s-529MiB/s (555MB/s-555MB/s), io=1860GiB (1997GB), run=3600094-3600094msec
   READ: bw=1234MiB/s (1294MB/s), 1234MiB/s-1234MiB/s (1294MB/s-1294MB/s), io=4337GiB (4657GB), run=3600093-3600093msec
  WRITE: bw=529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=1859GiB (1996GB), run=3600093-3600093msec

patched:
   READ: bw=1400MiB/s (1469MB/s), 1400MiB/s-1400MiB/s (1469MB/s-1469MB/s), io=4924GiB (5287GB), run=3600100-3600100msec
  WRITE: bw=600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s), io=2110GiB (2266GB), run=3600100-3600100msec
   READ: bw=1395MiB/s (1463MB/s), 1395MiB/s-1395MiB/s (1463MB/s-1463MB/s), io=4904GiB (5266GB), run=3600148-3600148msec
  WRITE: bw=598MiB/s (627MB/s), 598MiB/s-598MiB/s (627MB/s-627MB/s), io=2102GiB (2257GB), run=3600148-3600148msec
   READ: bw=1385MiB/s (1452MB/s), 1385MiB/s-1385MiB/s (1452MB/s-1452MB/s), io=4868GiB (5227GB), run=3600136-3600136msec
  WRITE: bw=594MiB/s (622MB/s), 594MiB/s-594MiB/s (622MB/s-622MB/s), io=2087GiB (2241GB), run=3600136-3600136msec
   READ: bw=1376MiB/s (1443MB/s), 1376MiB/s-1376MiB/s (1443MB/s-1443MB/s), io=4837GiB (5194GB), run=3600145-3600145msec
  WRITE: bw=590MiB/s (618MB/s), 590MiB/s-590MiB/s (618MB/s-618MB/s), io=2073GiB (2226GB), run=3600145-3600145msec

FIO on block devices
====================
nvme1n1     259:12   0   3.5T  0 disk 
├─nvme1n1p1 259:13   0 894.3G  0 part 
├─nvme1n1p2 259:14   0 894.3G  0 part 
├─nvme1n1p3 259:15   0 894.3G  0 part 
└─nvme1n1p4 259:16   0 894.1G  0 part 

fio -filename=/dev/nvme1n1p4 -direct=0 -thread -size=800G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
fio -filename=/dev/nvme1n1p2 -direct=0 -thread -size=800G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
fio -filename=/dev/nvme1n1p1 -direct=0 -thread -size=800G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest
fio -filename=/dev/nvme1n1p3 -direct=0 -thread -size=800G -rw=rw -rwmixwrite=30 --norandommap --randrepeat=0 -ioengine=pvsync2 -bs=64k -numjobs=252 -runtime=3600 --time_based -group_reporting -name=mytest

Four instances of FIO are run on four different NVME block devices
with the options as shown above.

base:
   READ: bw=8712MiB/s (9135MB/s), 8712MiB/s-8712MiB/s (9135MB/s-9135MB/s), io=29.9TiB (32.9TB), run=3600011-3600011msec
  WRITE: bw=3734MiB/s (3915MB/s), 3734MiB/s-3734MiB/s (3915MB/s-3915MB/s), io=12.8TiB (14.1TB), run=3600011-3600011msec
   READ: bw=8727MiB/s (9151MB/s), 8727MiB/s-8727MiB/s (9151MB/s-9151MB/s), io=30.0TiB (32.9TB), run=3600005-3600005msec
  WRITE: bw=3740MiB/s (3922MB/s), 3740MiB/s-3740MiB/s (3922MB/s-3922MB/s), io=12.8TiB (14.1TB), run=3600005-3600005msec
   READ: bw=8701MiB/s (9123MB/s), 8701MiB/s-8701MiB/s (9123MB/s-9123MB/s), io=29.9TiB (32.8TB), run=3600004-3600004msec
  WRITE: bw=3729MiB/s (3910MB/s), 3729MiB/s-3729MiB/s (3910MB/s-3910MB/s), io=12.8TiB (14.1TB), run=3600004-3600004msec
   READ: bw=8706MiB/s (9128MB/s), 8706MiB/s-8706MiB/s (9128MB/s-9128MB/s), io=29.9TiB (32.9TB), run=3600005-3600005msec
  WRITE: bw=3731MiB/s (3913MB/s), 3731MiB/s-3731MiB/s (3913MB/s-3913MB/s), io=12.8TiB (14.1TB), run=3600005-3600005msec

patched:
   READ: bw=1844MiB/s (1933MB/s), 1844MiB/s-1844MiB/s (1933MB/s-1933MB/s), io=6500GiB (6980GB), run=3610641-3610641msec
  WRITE: bw=790MiB/s (828MB/s), 790MiB/s-790MiB/s (828MB/s-828MB/s), io=2786GiB (2991GB), run=3610642-3610642msec
   READ: bw=1753MiB/s (1838MB/s), 1753MiB/s-1753MiB/s (1838MB/s-1838MB/s), io=6235GiB (6695GB), run=3641973-3641973msec
  WRITE: bw=751MiB/s (788MB/s), 751MiB/s-751MiB/s (788MB/s-788MB/s), io=2672GiB (2869GB), run=3641969-3641969msec
   READ: bw=1078MiB/s (1130MB/s), 1078MiB/s-1078MiB/s (1130MB/s-1130MB/s), io=3788GiB (4068GB), run=3600007-3600007msec
  WRITE: bw=462MiB/s (484MB/s), 462MiB/s-462MiB/s (484MB/s-484MB/s), io=1624GiB (1743GB), run=3600007-3600007msec
   READ: bw=1752MiB/s (1838MB/s), 1752MiB/s-1752MiB/s (1838MB/s-1838MB/s), io=6234GiB (6694GB), run=3642657-3642657msec
  WRITE: bw=751MiB/s (788MB/s), 751MiB/s-751MiB/s (788MB/s-788MB/s), io=2672GiB (2869GB), run=3642622-3642622msec

While FIO on FS shows improvement, FIO on block shows numbers going down.
Is this expected or am I missing enabling anything else for the block option?

Regards,
Bharata.

[1] https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
[2] https://lore.kernel.org/linux-fsdevel/20241127054737.33351-1-bharata@amd.com/

