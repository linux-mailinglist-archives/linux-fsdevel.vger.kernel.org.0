Return-Path: <linux-fsdevel+bounces-58738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E0EB30CC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 05:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C191860613A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 03:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9246C28C85B;
	Fri, 22 Aug 2025 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u70LPZlc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D729A9F9;
	Fri, 22 Aug 2025 03:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834147; cv=fail; b=KSsY2MdgNx36isXceRqTCARmLbXHzh9dgUouhXStivEsKN8KL7pd4EA2JfywWCydvGjFGy5gy4AwTAZrPqbdgwrYfVkajz0+h4WkUdtO5FN52nvCWp6tdtIznN0LXvMmN6H0RPqtMlYzrpCI+lWVbSzYt4DyeqR+3hYofY6Jasg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834147; c=relaxed/simple;
	bh=k6xToHZCIwzzvjPuUmm8KCVXBqQvfqCUfKM0PTZbTA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dE0Wd5Ac5gUiP+/fhBWQDIs1tq6Jv+yA9t8cMrMhPw/6I9da6TldBe47ygsrD8HcIzOmeEAP1HeThqQ0LY6c9XR8+Kpxg4cGgBwSK+wbNtyxGl52UOmPj517ZTkUi41WTRzHvKJOMFm3qmnkdgpF5DY9ROgQvBwL+HFtpHE2CyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u70LPZlc; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLzUdpnElvCpGnEG54lln7Gt7jxebNHf/m0mOnvD/eEj4W2aOOHAxzY+ac3mgDP/OmXj9karQwWQ1ozXOi555keHLKhLxLc8+qoqu+KO/QJceRx2oAF6C/PX+/ZQAFZpd7jjQem3lYfmVihw81+6N0LBZJD8Dcbj9PhxJWuzOnxkAmjbzAnBqE7fkpps8qqQPi3nubBmuw/PDWPwzZWI2lt6pcviOQbKbqMfOXaSNx7afbVHjnGVhu1Y7S02BhcEWDjOn5pYjfRqdccUha9w4JFbSZfLrgdW+jWIIt5MWd8TfsZm/aEeoOUlvfliyJfnEJnQGuobEQsaruunbylrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGxxuH6cTkEwxs0HyuZEYfnX0n4BqEF+j51O6Ip4Z/8=;
 b=aA8YZDImC5WxAX5MHHzzA0hW6GIaI/TwvrGESJa1OQ8YiTDurx4jL+z3oAgh/Vjud7ku7U62dRHTOd04yVh2gJcK6QciTpJDSK7sGDRqDI6ax6qImBNz1X8HzbKTwtmgctX+d0ozw6P8xauALhaCjUdCN2lUMVYGFQmI3PmBDRbEGruhytdtRkbl+UiMahw5m+tA5GdAl3oe+sy3e/Fov7/UMpVZ2K0SeriFDxhd3BNDOFHFdSUNgzJhlZ99/2hK2JD1XfaO13jE23VQgRy9f7xMf80tlONngnO+B+qihq/0Xif+ZGz7JYVLuf15tl+/O3HIjnwNxswMk7I13jcJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGxxuH6cTkEwxs0HyuZEYfnX0n4BqEF+j51O6Ip4Z/8=;
 b=u70LPZlcADD46UAqTxP5TQWDgB72hA0K1+MUByBtx7a9bGz/eKInHx01v16gPzZa5DDD08THEKOe9shXp3wW4ITZAUWdvZG98G8Na+06+anjcKKo2rT79gqKkCLNYpqR7pdFpmHKGumNukt+IJ7sqlCoN8j/VfX8U04W02mN8bI=
Received: from MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 03:42:21 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::42) by MN2PR03CA0027.outlook.office365.com
 (2603:10b6:208:23a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 03:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 03:42:20 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 22:42:18 -0500
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
Subject: [PATCH 5/6] dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree
Date: Fri, 22 Aug 2025 03:42:01 +0000
Message-ID: <20250822034202.26896-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: fce420f3-696d-4c3a-38ea-08dde12de5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DHXvKWVPCk4gd1ciZC7zfWwxf36gj1gFn2Vw+B7jjG9iBzvRlE3w6dvQsEfz?=
 =?us-ascii?Q?aFcwFO3B/tI0xkQntYWlKcBPUnFdvGjeL9RQYgYMlyGwNHDFoETlbRp2+ASy?=
 =?us-ascii?Q?dD8BRn3xrEzq22RACCkLVaLtwv0mwbyDCVeEaZMLfk/mJCJ9bTvofAwVUNrh?=
 =?us-ascii?Q?g4NnaQmjclXLaD50c9pVsxTLSuR+cBXzck9/mJ3/9sOVkdr1ZTp++hSCnwbl?=
 =?us-ascii?Q?0x4zg2QDJUDUJceiNza1PwDtiZLDVttlXxmioXuiFu/xgzuTJv9wKlV4l2RM?=
 =?us-ascii?Q?E+Fy4Cy82m5DNG7Y8f/bqSnb1QqBidKauWpZbGEnsJJ/NBzzrA8Jux2oJpJi?=
 =?us-ascii?Q?bGa+haE8M9dHWfdBGdBuc7tdeApbjD4d2cKCxl3ALLOqGo0oq6REip+EzaEA?=
 =?us-ascii?Q?JpJTYmvHmdAeRy7il4LFDPPduBaN53IeuuXbtpAJ6pYO+ThfZe+bDTlYNRIm?=
 =?us-ascii?Q?f5h/afVWp1yHUqj0v+2vZF6b5vdjcafCc/4d4K8x5zBhP0qjvjhblxBOjZKx?=
 =?us-ascii?Q?0bTKPjVWSB95kCtPGy5KUF6NT8sjlzld9+JzE9CXGDZRkUaOXclsWU2Z1Zzv?=
 =?us-ascii?Q?6a/nZehRC0rE49EukRgUQ87NqH1/OTTT5i83Zfnk0vXvo55Y38O4WfxEV+xe?=
 =?us-ascii?Q?kk+V7trgR5YxQMgD2bYLDZMQz/M5bPTMikvLNSRIHL8jelNfwqjjXC7SHL2v?=
 =?us-ascii?Q?tvvO0bGyMfqEEjP3caUpPYzk3LArKus8BMaUGQLnZEIsinHLhDL0cKzqFZOr?=
 =?us-ascii?Q?I2KJgOO7e/j0cq/25ulT65ba74t71LZovnq8Ly59Xa5FjoVm1wPpa5VDkG2d?=
 =?us-ascii?Q?jlNQsepSzjZizXhdJQW0mLEHQvIrI3H2bTWdOcH0F3JmTNEK7uoDcJO7zyZi?=
 =?us-ascii?Q?odCBiszOeFnoMud6sPBQM6sLNQx+y3BybEXRfg9c0hEQ+mvrKouqzhTBU+ia?=
 =?us-ascii?Q?n3P5+Cf9nmQwjEN0XY9y2F1S+ptlU0xQP30iUpV+c2PLYu2WLfgsbo8abWBs?=
 =?us-ascii?Q?QyxI8/v+MEcfWOL6kbtoTkL8j2cOUDZXqQ5xnSeOxoENDjJmCR+1kyQTGE7Y?=
 =?us-ascii?Q?yioVnclQ0rkmrTKhWbPbU9Gx7ImwlNMB2CjvfLrMRjUxd/opzuIbGtwGVgv8?=
 =?us-ascii?Q?J1uS8EQrpkR5wy8B4yFdV3NDqMWjavU8mjYMLtK7jmF0BsDxsAR6o6crZEno?=
 =?us-ascii?Q?36WWQbH4a+L62IFXN6pBim5ajTnQlYuz79YcjOUQgcVhKs2WAS2UVG+63WwY?=
 =?us-ascii?Q?VVnYlRVL6sZs6wGzEV7U7BbPOBD4XmFrpHMciuHep7MDDkBUsYOXHY+l9QMm?=
 =?us-ascii?Q?A0cUv7HCD8WMLLVcuSeq/bKWTAR/gpKbdv/TFDd/Jlpl6ck774VyoMkE723T?=
 =?us-ascii?Q?dPgrdtI6OSFaE3ZNeXjp73//Lzrggb07oPh8DaM3TpArnQ58JuwF7tq9iQJT?=
 =?us-ascii?Q?HzGH/K+Wdy6VLAPPzPPlZDdVHNSfZMrZD4jsVCD0LbFiui+d8lk966CFaiUj?=
 =?us-ascii?Q?HfpUTkNo15kWkmVsEtuwHMPU1cil+uVQ8LAK4VcZBdbPOZ5Ge9zfjB19iw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 03:42:20.3883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce420f3-696d-4c3a-38ea-08dde12de5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864

Reworked from a patch by Alison Schofield <alison.schofield@intel.com>

Reintroduce Soft Reserved range into the iomem_resource tree for dax_hmem
to consume.

This restores visibility in /proc/iomem for ranges actively in use, while
avoiding the early-boot conflicts that occurred when Soft Reserved was
published into iomem before CXL window and region discovery.

Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/hmem/hmem.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 90978518e5f4..24a6e7e3d916 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -93,6 +93,40 @@ static void process_defer_work(struct work_struct *_work)
 	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
 }
 
+static void remove_soft_reserved(void *data)
+{
+	struct resource *r = data;
+
+	remove_resource(r);
+	kfree(r);
+}
+
+static int add_soft_reserve_into_iomem(struct device *host,
+				       const struct resource *res)
+{
+	struct resource *soft = kzalloc(sizeof(*soft), GFP_KERNEL);
+	int rc;
+
+	if (!soft)
+		return -ENOMEM;
+
+	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
+				      "Soft Reserved", IORESOURCE_MEM,
+				      IORES_DESC_SOFT_RESERVED);
+
+	rc = insert_resource(&iomem_resource, soft);
+	if (rc) {
+		kfree(soft);
+		return rc;
+	}
+
+	rc = devm_add_action_or_reset(host, remove_soft_reserved, soft);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
@@ -125,6 +159,10 @@ static int hmem_register_device(struct device *host, int target_nid,
 					    IORES_DESC_SOFT_RESERVED);
 	if (rc != REGION_INTERSECTS)
 		return 0;
+
+	rc = add_soft_reserve_into_iomem(host, res);
+	if (rc)
+		return rc;
 #else
 	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			       IORES_DESC_SOFT_RESERVED);
-- 
2.17.1


