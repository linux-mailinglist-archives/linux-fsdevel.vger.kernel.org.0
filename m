Return-Path: <linux-fsdevel+bounces-76819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELqzJwjVimnrOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:49:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B94117806
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD480307AA44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C4330D26;
	Tue, 10 Feb 2026 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FJFEADn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1F330663;
	Tue, 10 Feb 2026 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705940; cv=fail; b=k9hS0QkbYpe3Anm17Da5NaqgqvMxqYNjWG9xRetQ6xcts0GXApEePg4E3MrAhs5ZNZuIYWfcclqgMJcTw9koiYdOnaAezJGsOg6vDt5pmpeqUtlz7hCppZf8NvIYpJPahscppFDRpVdHQUS142lN9uDpr22XSFgFMZnJhTv6r/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705940; c=relaxed/simple;
	bh=7YOrqw7I1cylY95mSS0834bCRaFAO5kLaZkyojeo3LU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=achYbJBbfmEr2JU2sCUIeOXIVHjsGz60Z6wes9PltWEcPvFnhdwbI6ICveeCyMvr6NhOs4JVFuhX4BBCP1N3hDbME3/cqs4VMK6PKk6WAUkIfTgWIysrCFb3SdD5X/uP25lPCVUXWYukN7TTs97wGIgFkYao3HjWfGnjniKRCcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FJFEADn0; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlDyNVIxoWdz+yQZlra5Xw6RtANw5glD/9Gxldm/ofqLE9hfYFWn8ZLUlUg8aad3u76nGCOHtykBeuJDap5YUZ/EbI1J3r3sf4OxZoE0z0W1p6sq7f4FnZDkEuGYb11cFy0njgoHmsfJ7SgOJOk8d5hD8lnVp1IXOcAG7bvIGsBteb0fdRPbwVLeplFvIQn65BCeW7XicAZn21/8kQQHEK+05BDCi+iyORpw8iLzzaFGJqUZi41yGWm00PQseIPepX4qYQ4Nautoi1tUuQduSQpUSC6FGQkvf4F+KXCB1TLOvbbMQRITWFtmLQtP+4+/F0M1lh9MN/QKsL/ZkJ5piA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yY2dbDNPGER4lsFX4jtUJJvRXS/jya/EQoG2E4hljJw=;
 b=gdM5xL3wtmJY0pgMN36sX72tRKZHYQwXzMalX1USXaBDgA9yhD3y/xuY/zors/k0e8/ROycT1Kj2+PJEOxyT9HEiiJV3bRKbtYkTfp6Bky/zRiiCZXgGqKAzHtA+CY2gyVjjQqe7h0hH77DXJcs9JCmifFYwOhKPf+l7CfTrZw9coTmXFxGfSAYq4abhowhYrX2X/+um0RYagSk5E2L6hTucWdiZAexpMus80WWu+yeShVArbKm0aFn/ZjTvNxPH2NnRsMs3cJ7Iuswr5bwYKlsoUJw+yHVajaF7gLoy25hLmWCoGlI729l8xCMOVxX70+XWdfqchFZAPMA8bYXw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY2dbDNPGER4lsFX4jtUJJvRXS/jya/EQoG2E4hljJw=;
 b=FJFEADn0BAk2kZuJ5VVvQ+Ru2pZDzU5tW1DmRW7aeGbBENegyTFlV0308DHikxf/1UF/S7Oy80InlyLNSyUQ35XS+eZ+pR+wShsxfSb06Gpho0fdCmUArgJ6mSmyuEpH46bmslNaekQiHqGqWjgDdgoEVmRKwFsgIlkZGiNOG8A=
Received: from BYAPR06CA0036.namprd06.prod.outlook.com (2603:10b6:a03:d4::49)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 06:45:24 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:d4:cafe::1b) by BYAPR06CA0036.outlook.office365.com
 (2603:10b6:a03:d4::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 06:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:45:24 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:45:20 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Subject: [PATCH v6 7/9] dax: Add deferred-work helpers for dax_hmem and dax_cxl coordination
Date: Tue, 10 Feb 2026 06:44:59 +0000
Message-ID: <20260210064501.157591-8-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7c7693-0071-4212-59f6-08de686ff829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XnoMVdYGxJOKrHfEN6gvFyeSpUVYhU+x8Us/2D93iHkuTT0NED0ME/HiAc19?=
 =?us-ascii?Q?5YP2rfRW/DTLuGe10fh11YmGKv9K6NIhWiMZWLgxQ47JMQguT9Yp32BjgWO6?=
 =?us-ascii?Q?G4cD1/UI6qpIQmA3sf+RukxRPaWxqN3ctjuiknmTpAZDjurWLLpWUP4SLvCa?=
 =?us-ascii?Q?/XKbkkjyDyuGQq8a3kKe8T4+1T/19xs1BqQBFIo8rsGryp2/QoJTGly0vrWq?=
 =?us-ascii?Q?S2bFeHgR1dSWiLFGcLmJMKkWs/WNIpOymvvcUU0sQDS9X9O1bQIRbv/a+Ns7?=
 =?us-ascii?Q?9fLQQzVguM6XaplB4t6OzqTsc4KpJQbxDh53vN6m0IaswEzBFKNVzHhQXyP2?=
 =?us-ascii?Q?yBQaWJydl8L1atzY4EBTF5auDq7medsq39/M3mQbzJnnkzd6weHZJQCMBUiC?=
 =?us-ascii?Q?QIBbDq40WQb4H72SlSDJ49KdPPDASQkFoCYVgVLtVk4J9svjhbU7MrUKcljz?=
 =?us-ascii?Q?cs2ULfQQ2445ysfymm2jzkPAl9kqC2eJQ/XXQp3Isdf7f1OXX6s3HZvecvMw?=
 =?us-ascii?Q?8puu/v1skXTDxCVrRuj/N2azVxsGeornsrLrvULl9b/pxHu4Uxf9LesDZunb?=
 =?us-ascii?Q?cnvi5chQZGRxuoxVMIyV8g2xVXriQUS//a1VuKx0xJmSLn4X7O+HwdaN3iyv?=
 =?us-ascii?Q?/Htw/YNuJsXQhSwhEmIyNbH2sjkZsQ8RT+/EnMGQYNHWum8jh4JPBlXs6cVl?=
 =?us-ascii?Q?iXTO2xlYw32jbdo4bKMc07MO7+EX/M7FM0Ky1ndaUV1tS8rKG0psW08/IXQL?=
 =?us-ascii?Q?XPR4vTXZnYyQNliJrY0Xa0gRhe1KPdQOKAFFzF8q9OEhVlJERc/4tWZyDttE?=
 =?us-ascii?Q?M5EMW30EMrJw9db5EDwTZXCFwR+YHGGeALEUUpDknLnmnhzJEqMQxMDUsZom?=
 =?us-ascii?Q?4rz07DXWZoUjXprKkOSq4aoDKvAl2gUY9v0Ed3xJ1IccMNHdR5hnlUZGLKWE?=
 =?us-ascii?Q?bXaiZYLniV4X8RIQXYRqr+YXC+Zl4thYb/6pSrSaibPhrz3+vRRzJ2IH30DJ?=
 =?us-ascii?Q?CzwUo8Ay3TolFQgl/90fq3LL83R5eD9TCD1VFRgMo9ZFOT9H8sz9xh/Fe++7?=
 =?us-ascii?Q?N+axgCi0w3og7vtA1zJu3pZZPNBWLQw+214tWgYhSwsCSGx9Kp+BD05pVhGJ?=
 =?us-ascii?Q?2uUVy9OKd+aFuu5jT32/3KffNOgFkkNrH57AM0/vU0KX3jsCzWOStHip/dpt?=
 =?us-ascii?Q?TCNuVbM2ZgtDaBt7tnX8/22MPZBa/6iCIvrQ/gl0Q0Ucz/zpwRRbDbRAn2xY?=
 =?us-ascii?Q?n/l/MHao2VkueVqntJHU7cCbdm1f6Cu/c7ibqkDEKMyAFtGpKNn5yuW3XZSD?=
 =?us-ascii?Q?NRAusoT7mQlYPoFhpwobop+1GknOMCw01ZuZK4N6nE6sAScxQA/P4/WRJ2gO?=
 =?us-ascii?Q?OfwdPKnbFv7Zn28dev+vtEP5UoDSlSSs06ydlkxx3BhfydkyUTZxZrGWkXfx?=
 =?us-ascii?Q?AI1GOjsZC/DUBUT5JG2fNX3WuTiLA+dVnwtpssJpaFrNLUrKPkW4Q8RuyPtk?=
 =?us-ascii?Q?eU6JF7Y0V9RESJEmotoNZ9ELGiGige5FZHfy6xFdLWl+BV7Z7W8nMIemqWM9?=
 =?us-ascii?Q?na5iufVJF+OiJ8aGu8ICOlwl0IcYYMR+B9dE9umXFWeLssezyzMBB/oKJauh?=
 =?us-ascii?Q?bvTdex7+c4buvHhN48g8x8jCQvmuvTZFqUQ8jiSqKFYXkWK6mUCwGIxE+upU?=
 =?us-ascii?Q?unPVHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y4bggumPU2Nmx/0ADo/4t5L3LkEQcp4CXwCGdLt9JQn1E/0kAfSmqCIuR87G1ZZY7ogRiyrYFCLa/euleVF0bXg6s8DW/JDA9yLQ1ZOa54jU9eKlwrfuRPYw2xmly5DpMUF7X6B8PZcFLxr46eIt8d/fCpr9kz2om9VVqWDQegRPVVX2JDR8Zhh453FaCUzQJPHSzW2htziiSXqYUS4Mig1Ex9DvlNYGTqm8LtEM64zGZkF60f+MikgBTDa+qRF+zNGuXfFIHN6tugmnIG39Sx8KYfgvAyOr6/spooZFK1Anlqb9Fw+YuquCam/GqFGXfigBNEHLWnKio+0RlCieOusm6RxPBO6wwisIs9AAmFn3nGKe2RIo60fM6bFGomiEhdWXTslcfU2dJ+sBP90unK7ej8GUOk1XjIzLYRik5s312B2CvlYMrgKA16CZEnjY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:45:24.6218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7c7693-0071-4212-59f6-08de686ff829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76819-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09B94117806
X-Rspamd-Action: no action

Add helpers to register, queue and flush the deferred work.

These helpers allow dax_hmem to execute ownership resolution outside the
probe context before dax_cxl binds.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/bus.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dax/bus.h |  7 ++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 5f387feb95f0..92b88952ede1 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -25,6 +25,64 @@ DECLARE_RWSEM(dax_region_rwsem);
  */
 DECLARE_RWSEM(dax_dev_rwsem);
 
+static DEFINE_MUTEX(dax_hmem_lock);
+static dax_hmem_deferred_fn hmem_deferred_fn;
+static void *dax_hmem_data;
+
+static void hmem_deferred_work(struct work_struct *work)
+{
+	dax_hmem_deferred_fn fn;
+	void *data;
+
+	scoped_guard(mutex, &dax_hmem_lock) {
+		fn = hmem_deferred_fn;
+		data = dax_hmem_data;
+	}
+
+	if (fn)
+		fn(data);
+}
+
+static DECLARE_WORK(dax_hmem_work, hmem_deferred_work);
+
+int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data)
+{
+	guard(mutex)(&dax_hmem_lock);
+
+	if (hmem_deferred_fn)
+		return -EINVAL;
+
+	hmem_deferred_fn = fn;
+	dax_hmem_data = data;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_hmem_register_work);
+
+int dax_hmem_unregister_work(dax_hmem_deferred_fn fn, void *data)
+{
+	guard(mutex)(&dax_hmem_lock);
+
+	if (hmem_deferred_fn != fn || dax_hmem_data != data)
+		return -EINVAL;
+
+	hmem_deferred_fn = NULL;
+	dax_hmem_data = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_hmem_unregister_work);
+
+void dax_hmem_queue_work(void)
+{
+	queue_work(system_long_wq, &dax_hmem_work);
+}
+EXPORT_SYMBOL_GPL(dax_hmem_queue_work);
+
+void dax_hmem_flush_work(void)
+{
+	flush_work(&dax_hmem_work);
+}
+EXPORT_SYMBOL_GPL(dax_hmem_flush_work);
+
 #define DAX_NAME_LEN 30
 struct dax_id {
 	struct list_head list;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..b58a88e8089c 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -41,6 +41,13 @@ struct dax_device_driver {
 	void (*remove)(struct dev_dax *dev);
 };
 
+typedef void (*dax_hmem_deferred_fn)(void *data);
+
+int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data);
+int dax_hmem_unregister_work(dax_hmem_deferred_fn fn, void *data);
+void dax_hmem_queue_work(void);
+void dax_hmem_flush_work(void);
+
 int __dax_driver_register(struct dax_device_driver *dax_drv,
 		struct module *module, const char *mod_name);
 #define dax_driver_register(driver) \
-- 
2.17.1


