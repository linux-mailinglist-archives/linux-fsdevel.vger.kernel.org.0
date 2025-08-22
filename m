Return-Path: <linux-fsdevel+bounces-58732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CDCB30CB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 05:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222316056DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 03:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C728D8CE;
	Fri, 22 Aug 2025 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KCqTb0ZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0EA21ADB9;
	Fri, 22 Aug 2025 03:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834142; cv=fail; b=hPAHJVG99X8hLKYXv6XLApCFUuO2QvIG835oRYCvLMY9Pf1EsEhBUUww6CaiilE019uagQ5KBR2YMth8NRLEgRvV7eH/8TRF1izavH+rNcVh5O1x9WQbhYullgD7w+MDeXvxiypu0odWTyxx0kXslluEg8gBW2xPCIc/kSehHH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834142; c=relaxed/simple;
	bh=fP/kU3u1PXVfB56QwbN2qt/HkRBGg0JwZhucaZttopM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eYBYfyDdpSV2g7FMGEy4NHjMbXiRMEcHHm0dn0L9suiWZ7HQZLuLHDR6NxjJ1WQ7TssUGLesXhg3JDHpJsJ3hbxCB0S/7l+Kf43SKASaEbNHB26UyAwesQyrhWbI0RAEhHEwul5R+fTXigATJjuOwN5Bm4m2GCB39g0YQBQPOR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KCqTb0ZI; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjidWx9LRRx+cLE5BnWrAV0PbDERltcLNafnF8ue/RwzxOSjiXUfu93q67SWOU8/mtOuSp55Dej8HIuCOMVU44ft89EwHYv2Xx8PPAM8xaeCpj8GJt+9J5yfr+T0GDtMDu68MSzxbCm6hwVbW673IkG1pNjhBRH8wxbHUQsQzufMbit5O8u6lnD2uCNW4PDWGeSdzUEdn+0unaLSr9tojD+/ogR+H2OqZEPLVKpSccI8iOp2+eoxTsPtdXhQ2SDRcrcko1e5agouSedtJHU7MEINXVe/HSbeaAepS2rLbQTVL+MjZw34B9bR8xfNwAelhvJopylsnvfbgYd1BZ7Jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnX8NOuDrjMcEvgu+GzHgV2VKEObj9qh3j5GHJqwHoc=;
 b=cZPOc5LvMLKIMMFkcbUwes5FyQ1suL4HdAhZUm9jlxwmy0SMoRKXF1UkJzXMccblp/eB56+mza/8oEdJVQTMeFhdV+VNsrRjLIjl/uq0rg9TH3WtLcb05fn/t1aKT0mRn6yDY6gikN5ydwP9oLXlZv0hJNUc3qSqrKZvsrDrSP36eI8VjAD1Nx8kOy6bR94iqC78iPffNqqk8pb8SQFTKiPXc4WfDD8hkoN34VO9rz1eqRUa23LrKdCWPYiFTFZ2qDLiutHYAHcMkZ4jiV75CvHVT94HbQR2C8amWKKS3emM9skG+3cI5uJ1unjsIzkpB5fslJLKdZdi6u0Gr5cPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnX8NOuDrjMcEvgu+GzHgV2VKEObj9qh3j5GHJqwHoc=;
 b=KCqTb0ZIGVaD28c9MnFpiSVWXmHRXuQlVKt9EmDCYqF81LLak9e5AcVRlwiEGiwh15LdeYeRInlcnUkcJgcnmLWIFDhJPZ3zTV55rJyEGun6jhInhZenxCNvZ4fkEDYHpaJSjBtbFN62dmByzjSxpynN7/cJT9HmUDtnt/V9D6I=
Received: from SJ0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:a03:3a1::30)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 03:42:15 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::23) by SJ0PR03CA0385.outlook.office365.com
 (2603:10b6:a03:3a1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 03:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 03:42:14 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 22:42:13 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Subject: [PATCH 0/6] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL
Date: Fri, 22 Aug 2025 03:41:56 +0000
Message-ID: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: f76bc764-f21f-4510-01c0-08dde12de2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFpJVzRFVU5NK0JGWFpUTmZieFlKR1JpTmF0ZWFxSVJVSHA2WHM0ZUQ3ZFpX?=
 =?utf-8?B?RWNHNVN5dE5CRktwUGdMcTh3aEJoKzBXTHBaRkYwdzkzQko3Zk5PTUwyQUVi?=
 =?utf-8?B?UktCbFpJR09NeVlKUUtVdjBHVUNWUlFobTVCS1JjaGFwbEFlRVQ5eXVQV3pR?=
 =?utf-8?B?bjgrV2FZUmlhT0U2SEQwTzhUcDNIdW9EZ3kvWUJzSUZ2OU53NUwzcCtGZDJv?=
 =?utf-8?B?Wkdja2VhMHZWYUZwMjFsTkFKN0lJM3NKbEkxcCt0UFR5bENKUjhZTkRORWhI?=
 =?utf-8?B?d3pTZjQ0Q2dhS2pqZ2pkWDE5NlN2Z3UwQlFxZlV2WUYyWWJLV29peDJCU0xN?=
 =?utf-8?B?Y2JrVXlUVkcxcStERmtBbU5FYk0zUWgxcEtTTHpBZ0FlM1JhYjFNenBDUm9N?=
 =?utf-8?B?dG5RZGV4WVMzSnhndUEvZlkxMC9wekJtam1EbUlLY1RrN0xpQkV0N2g3RW8x?=
 =?utf-8?B?ZGRyRFJENElZTGRBK2tTMGhEQkY5Sm5qMU90NjJVanZSZGxuTzZxeEhBZThP?=
 =?utf-8?B?UGJCMmdINUpuU2pLRG1YVGJadWFDT1g2R0NSNng4NkRDWlFybEtSV24yWGNa?=
 =?utf-8?B?ZG1kU2FZVWZhdmdxMHk1WUpXM01tWExuRUkxZWdwRXBLc1hZSXc3V0Nvb1hB?=
 =?utf-8?B?OHFuVWZVVG43R3MzYmpsR2ZKckxYblBTV28va2w3MEc1NkE1TGdETTV1MVly?=
 =?utf-8?B?YzMyOHNwTkg3TzhMeTF6cGp6ZkFsWWMyejhQcHp1SE9ZOFE4MC93NFYvdFdp?=
 =?utf-8?B?SGFleVF4MFgvTGFYMll5bHNxN0NoOGhPc0tzZ2xuVHJOUGtpZ1dsRkd5L3BF?=
 =?utf-8?B?QllGYTJnOTN3cCtSZDAzKzRZSmw0UE9Nc0hhaE1aaWt3bVl1QkxtMkNtSzdu?=
 =?utf-8?B?VldHUDE1Vy85UHZUY05vY1ovcGNkVVJjL1NLL2RtdjM1YTZ2VjZoODlFVUJy?=
 =?utf-8?B?VWx3MTdYbGNjdUpXSGNFSTlRc2MxK3dSQVhrZnJXV200K21PalhNVmZnOGJp?=
 =?utf-8?B?a2MvNHRtT01VZ1NiWjZZRGhsZldIUDkrNTJKQllMQ3lhQnFXWEprRUdMMVBG?=
 =?utf-8?B?NWZCTDlVQzl5L0tFVm9KWUlqRWl4T1V5OE9BR3FuRjh1N1VibjFxd0VmM05Z?=
 =?utf-8?B?SElCZXZoRzdxUDZBdjNaMXpwZ0c4SktkdU1URFFKSE5HR3NGNDZXVU4rZUxR?=
 =?utf-8?B?cWFZdWM1YjRoS0hvYjJ3UWF2RzhVZWlZTGdTQUh0eVg5WW1pZXFLVjh2Vkk4?=
 =?utf-8?B?b25Ud2hQaTBrR3prSXQySzNMMFUrMDFFSFNXS0VSVmdYWG1rdmR3OGNVQTFB?=
 =?utf-8?B?V3p2Y1REa0Rqbzlsa3BJa0NoVHZia2o1VnpxTFVVQjQ2L3FuTGNaZmJjMWtU?=
 =?utf-8?B?cGplcTUrZXFnWTRHUHQvQjY5RVhNdGRLRWRrWnlleU1ZOS9rQkpGYjBtcUNS?=
 =?utf-8?B?TTYyUmFlN2dacWdubFp3cUNJb2dBdUlUbVNvOFoydFlRSUFJS0dQbCsyZWc5?=
 =?utf-8?B?TmdaTUo2RUxvS1lseGk1ZVM4d3lxdnRKb3diMXlSc3NTbVp3dndraGtlR0JF?=
 =?utf-8?B?WndGamI2UCtmWTZuRlFQV1IrQUhIOE5oQjllWlZYMHh3TjNPaFQ2WXRSUERm?=
 =?utf-8?B?cDVlTVk2L0tSR1dMcFdVUGtGV0VxUVRVSXRwcDYzYVN3dyt1OTZwUlh6UnBk?=
 =?utf-8?B?SnpnYngxVHM5WlZYMlpRTWsxcEZuVXpWQ2dLaHdPMjF5QUlQaXZzYlN4TzhZ?=
 =?utf-8?B?OTk1ZXh6dklZOG5QTGF6bTV1YUN0cXRtbDBOSkJIZ0JPaTdDcnRqNnNLZHlW?=
 =?utf-8?B?NkpjakFVSjc5dVdrMDV0b3ZQc3ZzOGdHRTZZcCs4QjFESlZtVVE4WjlsbitU?=
 =?utf-8?B?VlBiMFUwTGpkY3RxNEpZRExyVnBPeUJhenZDTWlzSEhlOU81T1A0NUdFRTdE?=
 =?utf-8?B?RVBUaUJ2dGlGYnV5bGg0bFR5NHM5Z2NpZzZpaWhEOUxHeUI4cVVxZWpuRTcy?=
 =?utf-8?B?WFpoemFVY0hoNlVGRDJDUVFUc2p2RDMrYmtRZjJjSmdMVzZGY3dEbUhTK0k3?=
 =?utf-8?B?L1FXWVk0eGI5VDJJdHIxZENCSEQ2dUdvUDZ3dz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:42:14.7769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76bc764-f21f-4510-01c0-08dde12de2ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

This series aims to address long-standing conflicts between dax_hmem and
CXL when handling Soft Reserved memory ranges.

I have considered adding support for DAX_CXL_MODE_REGISTER, but I do not
yet have a solid approach. Since this came up in discussion yesterday,
I am sending the current work and would appreciate inputs on how best to
handle the DAX_CXL_MODE_REGISTER case.

Reworked from Dan's patch:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d

Previous work:
https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/

Smita Koralahalli (6):
  dax/hmem, e820, resource: Defer Soft Reserved registration until hmem
    is ready
  dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved
    ranges
  dax/hmem, cxl: Tighten dependencies on DEV_DAX_CXL and dax_hmem
  dax/hmem: Defer Soft Reserved overlap handling until CXL region
    assembly completes
  dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree
  cxl/region, dax/hmem: Guard CXL DAX region creation and tighten HMEM
    deps

 arch/x86/kernel/e820.c    |   2 +-
 drivers/cxl/core/region.c |   4 +-
 drivers/dax/Kconfig       |   3 +
 drivers/dax/hmem/device.c |   4 +-
 drivers/dax/hmem/hmem.c   | 137 +++++++++++++++++++++++++++++++++++---
 include/linux/ioport.h    |  24 +++++++
 kernel/resource.c         |  73 +++++++++++++++++---
 7 files changed, 222 insertions(+), 25 deletions(-)

-- 
2.17.1


