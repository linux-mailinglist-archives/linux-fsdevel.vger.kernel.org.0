Return-Path: <linux-fsdevel+bounces-43341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F1A549D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A471896905
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDA720C46C;
	Thu,  6 Mar 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UVyywfKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF820C460;
	Thu,  6 Mar 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261192; cv=fail; b=AKwSaSsMMWHjL7R/72qhxiMmcKJJdZ5ILvK0llJs0cCWMCCE69CzlUQLstbem7aixhN/WrruNNneh197xCxvTopAtc5sD7PBuPDGVvlyVYFSOhqf+JtgqVUAeNeY607WrMxOZiHdouYAO86wyZhSyC/NjcQsDMU626zqH93eN3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261192; c=relaxed/simple;
	bh=QhDI9x9ZkYzaaG5JxaLtg3l/rXukZE96D7hAlM/Czhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V03Ux9ZC7iVMBA/Brefqz15OvEIPTb0UON958vR6wMXFf72mtyxRuN2ESFgt14qOyvHpY/qAsm64BIKp0vcTBQTPHKNA4NvPhBU4XKV1YhCfZW5Tjif9GLTPHnhCS8o0N6sInGyhfi0mDESjjgcXo7RLlgoFiAUbbjIE2lyrCcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UVyywfKM; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8etNqU6FG00FQwR58BTy7hBPkPSb17xE2AZFO/i3OLgTElEPiKE8zGwm3UJNiLSNqxZf3UAzidZTbgwadVJbGUnVKrqKe+lzCvIan+7bQ3VU1HF3rZ2Y5F+zApSgU2xv+TjK0k/VWjy0BXTrKtljITQ1z/6PB25s/fSd8fFwSXZIrmaRdGuTEvIywH46mlqn0zdodez0NTFJQ9gW1ERZaWwvudxCeKmL+SADd/0AbgbaLw4TL7xGv5kX6Pf/+IcVQPQgWbc1mMPNLQI1ttkd4DM6Cm/TojWd8aj/k4TjBTXMhZJOMNr576f7buxAnxmplTAjzy3ozkYHAgwfWbqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGJo8b/IVO4Vpp/wFK/cKL4EIBmnd/uSe/g9Q/PEGGg=;
 b=QQY4ZW5Ke3HwL6DbOwSg9d14s1/mSo11FycmdSnEHuM4MLn5LbGjPzbfRruQa3V8Tk6ZoS8XwxYEvqQ7lvfMYWr5RX8aw2Ztw0O6qsW+av8XjqCXIGFNIf+RHnh69xF+NbTjDXr40foSxqM3Fr7qHbR/f/Yvn02Vm0NUvw1D85Oi9mWUJiwxtxJRCy7/iacHmB22lAHvnONDWc7SmdkIvjQK9vrUQY8MmGj/c2wKjwva/CcBMfbSdqyR2wQpUmTzD5ONukMbiIE77fUEhdugdU8MZyo8pTUbrAYRXzYfL9bUEXmH84cm4+OD/FZ8TeLNprVnllESwkGMjN8kpM6Opw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGJo8b/IVO4Vpp/wFK/cKL4EIBmnd/uSe/g9Q/PEGGg=;
 b=UVyywfKMRCFSHy6+Yln7BdvUbal7vBfGfX7wcckQIts9NjyYH2u54QC3jkWRGaOUt9iEnTBrwVGfb9GPv6BMTOD6gf6RWSBnqoosK3g8JClrPAJhdkPSx4mFB4yVlbMELS/SsuRDIv3wY7qDqcbXZ88SfeVKczs8XhOWgnZti6g=
Received: from DS0PR17CA0012.namprd17.prod.outlook.com (2603:10b6:8:191::20)
 by BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 11:39:47 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::73) by DS0PR17CA0012.outlook.office365.com
 (2603:10b6:8:191::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Thu,
 6 Mar 2025 11:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 11:39:47 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 05:39:40 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov
	<oleg@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Rasmus Villemoes <ravi@prevas.dk>,
	<Neeraj.Upadhyay@amd.com>, <Ananth.narayan@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH 0/3] pipe: Convert pipe->{head,tail} to unsigned short
Date: Thu, 6 Mar 2025 11:39:21 +0000
Message-ID: <20250306113924.20004-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
References: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BL4PR12MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: f015c1c0-0590-472f-e312-08dd5ca39910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JMP8JP1mrOJ80elsX8BWvnWl2I24GCz7BhxhqBYTejiuIq7FGT3zFwyapcwZ?=
 =?us-ascii?Q?ci/4GkgTBBz89srqWeqeZFxJayZUO1d+SltPvLJs4Gzk5kjj9aZ9XmuCvYUf?=
 =?us-ascii?Q?68UBJn2sEEkdQwR6R1nJyV/PdWYz7ZKPqqO9n0mbItivOWix+vfA/XW/6Bgq?=
 =?us-ascii?Q?BuoLdbEzDdrp4UgH3y6ed8MGRo/jEnh2lwORtev5QKK64XL9NPcLz8PvRTDY?=
 =?us-ascii?Q?HekqcXeCJY31Q/lbySeNM3OV0Ld0lYWGzCnUX9FMQkNht593EqooXS8+AxTe?=
 =?us-ascii?Q?cjExMrEm7wTuienCYweDHD6JK1rY4im5zB5h1B/AVmfNv9mB1i2UdpR6Vbdh?=
 =?us-ascii?Q?WzlvUIUTqirigL2vBSdXQhl232ra3Ohe/m3Nyh3RKtpiz9lzvnCdxxsficaX?=
 =?us-ascii?Q?F98nmZm0RpAtKCwtekVas2TPmQKewVIMSOyx/aMmLowoTSmlsirxSvCXm0+C?=
 =?us-ascii?Q?mXaqv/XzazIDCGe9niklu5i4a7a5EXoSaQBAzYPkgCMhtqicfjSVeTvHMWMS?=
 =?us-ascii?Q?SiUe/Z2Iv7nrabVJrB8dw+YIk+Vbw5JhHQBOmYzlo3DUIsfxm1nDlFGQRy6h?=
 =?us-ascii?Q?3+yZ+MFHEOaQ2jSHR4P/R3MrDQ/0Vuc6BAHU5XkIE7o3pGxEdyWGFvwW+WvS?=
 =?us-ascii?Q?U8M4q/50VzbkZC6nYUuWwA8qshIZvSEhjnWVTKkOV7wgwE6xPVRB207cLHLC?=
 =?us-ascii?Q?IsI8KbBlQx+KImAtq0/7KEWveV7FvRDeLzLUEoO2OiiAhlWGKcqDN2VFIKT4?=
 =?us-ascii?Q?tm0jWRbliqG4+xM0TFkzIKgp9TqgiDbYHhJQny+Aidf3GW6O3Y13lYyo160U?=
 =?us-ascii?Q?gdHNXyDXvoALIxTuwAxkk1N4V8SqqmRGuph88GWzY04N/w/L2vzKurtCHLUt?=
 =?us-ascii?Q?KWwgo/wllvVbmHzzOHLlB7+/r3b+kMbXQ2sDV2oq5hZZtBAWKbQkiZd+TvZr?=
 =?us-ascii?Q?0cZ8rzg3Ehf2KZusvNZbklriS1KSdD7I3KKBM9STqYnynV3BI8rcTgs45lya?=
 =?us-ascii?Q?CDRvsl9IjdeRchxOfQrrz+hnj489CymasFIZsYoGV9hszi+9qtwR2KM2Y4dA?=
 =?us-ascii?Q?ibKj2TqI/w/p9nhjB2tA4au02S5xR3PnUT8ltmLVCKjcQ/cHrvx0C9RCl+z/?=
 =?us-ascii?Q?t71XhHZLp9coy/6euSft4xIzUFMkkekcvV2MqM2pBPj/vOiNGT5xEV1x3gI3?=
 =?us-ascii?Q?g1C0PLkLp0srqY15yzvRJaLV+rokdPJd1hR8irabDSSUGnZ9uHfa2IcYsi3V?=
 =?us-ascii?Q?hwFnOy4/tO2eWW5PKutERw41+edHh6v6nSKIJtkI7TKtXFstgSG+c94Ua9ys?=
 =?us-ascii?Q?+1iBpEqX1+euusogDNymG2XhLB9pblyXAJO9HqeMmwniS0zA706yLB+Xgcst?=
 =?us-ascii?Q?8G3rQWPUyACx41ieC0pi12eDt7O/e0BqmtwWHu28ku76Jhi8IHpAZQDGciIl?=
 =?us-ascii?Q?6t3cwQOYroOer6dlTnjxlOP3RLBHeANOKKpuxChMRIgP5tAwgDmYsPaO7p3F?=
 =?us-ascii?Q?mZA9AfJtX0HbWCgMMjhuLYGwoS/P9Vb54ZVY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:39:47.2048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f015c1c0-0590-472f-e312-08dd5ca39910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9482

Here is an attempt at converting pipe->{head,tail} to unsigned short
members. All local variables storing the head and the tail have been
modified to unsigned short too the best of my knowledge)

pipe_resize_ring() has added a check to make sure nr_slots can be
contained within the limits of the pipe->{head,tail}. Building on that,
pipe->{max_usage,ring_size} were also converted to unsigned short to
catch any cases of incorrect unsigned arithmetic.

This has been tested for a few hours with anon pipes on a 5th Generation
AMD EPYC System and on a dual socket Intel Granite Rapids system without
experiencing any obvious issues.

pipe_write() was tagged with a debug trace_printk() on one of the test
machines to make sure the head has indeed wrapped around behind the tail
to ensure the wraparound scenarios are indeed happening.

Few pipe_occupancy() and pipe->max_usage based checks have been
converted to use unsigned short based arithmetic in fs/fuse/dev.c,
fs/splice.c, mm/filemap.c, and mm/filemap.c. Few of the observations
from Rasmus on a parallel thread [1] has been folded into Patch 3
(thanks a ton for chasing them).

More eyes and testing is greatly appreciated. If my tests run into any
issues, I'll report back on this thread. Series was tested with:

  hackbench -g 16 -f 20 --threads --pipe -l 10000000 -s 100 # Warp around
  stress-ng --oom-pipe 128 --oom-pipe-ops 100000 -t 600s # pipe resize
  stress-ng --splice 128 --splice-ops 100000000 -t 600s # splice
  stress-ng --vm-splice 128 --vm-splice-ops 100000000 -t 600s # splice

  stress-ng --tee 128 --tee-ops 100000000 -t 600s
  stress-ng --zlib 128 --zlib-ops 1000000 -t 600s
  stress-ng --sigpipe 128 -t 60s

stress-ng did not report any failure in my testing.

[1] https://lore.kernel.org/all/87cyeu5zgk.fsf@prevas.dk/
--
K Prateek Nayak (3):
  fs/pipe: Limit the slots in pipe_resize_ring()
  fs/splice: Atomically read pipe->{head,tail} in opipe_prep()
  treewide: pipe: Convert all references to
    pipe->{head,tail,max_usage,ring_size} to unsigned short

 fs/fuse/dev.c             |  4 +++-
 fs/pipe.c                 | 33 +++++++++++++++-----------
 fs/splice.c               | 50 ++++++++++++++++++++-------------------
 include/linux/pipe_fs_i.h | 39 ++++++++++--------------------
 kernel/watch_queue.c      |  3 ++-
 mm/filemap.c              |  5 ++--
 mm/shmem.c                |  5 ++--
 7 files changed, 69 insertions(+), 70 deletions(-)


base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
-- 
2.43.0


