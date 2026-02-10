Return-Path: <linux-fsdevel+bounces-76813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGhAEgvUimnWOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:45:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A951176D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3631301063C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7886532E729;
	Tue, 10 Feb 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R+PeUzlt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632925CC74;
	Tue, 10 Feb 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705923; cv=fail; b=Lg2T0R2U8Aj+0LadVY4Q4Llj7WMwVpxQplBkwuV+E3EBPJyhk1A4CW8qWjDZWMbun/obojCrr4cPb3GT5lV9BQbY1nJy4+z5IfMwIlDM5ilfVHPvxTMAvliYwFWrbLDk0PVzpbVMOAIt/TJY1NQHBvXxjBVj2OvEAQTMH6gWGK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705923; c=relaxed/simple;
	bh=EhMoXdFK6aH1Lo2xEETMSlx3oBTjpDyhKU3sEl4Z8F0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kaf9xgzDfkLvBj7s2l+Dgvw2ICr3Q4pJIhmz95Tn0e3QMcbBOkdkNqNBXZydOiIZTr9I34qu1dgAABmooYzKUFdOEzTlpQV80XYpkHPwBUc2PnoY2Jfz1N8gyzLxbyk195808jN3zwrr6gyY6/+3s1jttx1ygtCPami1o42Vmj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R+PeUzlt; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T16wGP97clep9qbbIxCtupMHQuQgiN1NK/2KjWI7shDJ0wNJKj/XctA4/eAep8ULaTmxLUeWe75JVfr15SZkp5OjKxTApxnnJm2u90hIw9/4wmSdtrZ6yfZkcM2jCBsWJUONRHp3IlmeK2zBKjMI7jZZ6gXeugS82mPrQTTU5LJp37mV6gqSdSJUBoSIGZ6O/nyhNazzTl+ryL/8XODAoOrPAxwjSG0IDQmaVK6QHXx/mIkd9bDwT+N7GUIzPJYqMxb9RW9PpI3c9nth4l0l4N2R1ABMMi+0UYK1hVU+8rHfbTpoujN5Y/V+q7wQBRB+cM8c1Zeo8f96UwThiqxBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GBiiEg+cJyODVw7P8KEWV0PHGY57kbT5Adu9g/R6Wk=;
 b=iQIC0g8btFixBw5vg8DyUN7eolucSAmKQ9N5X1szv1gVkQH7jWfhjzgcbx4MiADUbV61x2WvTANIr7CP+xw6kxBpeFNToOUb4TIMr72XjJVHQI5cRmfkXNAEBnHUyWD2bbubARjN8+bro1MsbxEuGL2KRjOsGSrpdfengN8Ayt9WvYfaqayt9klP44k/fHVsBTIYfeRXkk5ECCl1fxK+1WG46gSIPjAIIXQ5m456Ba0saRZ2ReIfxO7plHKzuF/o3OW26ijIBU6h9OD5taIXk8VbjHkhR8dbjSoTT1Nz3c6t/pGa/1e4bPXdPIfuFNc6HRUHvGIbn7yanGu8F5D83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GBiiEg+cJyODVw7P8KEWV0PHGY57kbT5Adu9g/R6Wk=;
 b=R+PeUzltDrAkipVPf7Q/ebSYhoePqFjDc5Tw14YB+5KGNm9vHKCb61ZlVeq93AtjI21Y64p8mM3dIG7Ys14309ug/PAXn3d75/CfHZnch2FxSrLX6PdTZtoBowNHXrWaaQFj0HAQQmpgUboqX+4s4nSOftDK+UkT3dThuKGDK2Q=
Received: from BY3PR10CA0001.namprd10.prod.outlook.com (2603:10b6:a03:255::6)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Tue, 10 Feb
 2026 06:45:15 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::90) by BY3PR10CA0001.outlook.office365.com
 (2603:10b6:a03:255::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 06:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:45:15 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:45:14 -0600
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
Subject: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL and HMEM
Date: Tue, 10 Feb 2026 06:44:52 +0000
Message-ID: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfbf10b-b6ce-486d-b4e2-08de686ff2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZibLoViJ/VYeCt+j1YhMF5VlMIXpHNELNmhc4UzJ9yr6wBsQtPEUN5j3KJ2G?=
 =?us-ascii?Q?dpBfuLI/K71g2CauNtw8qZCpLCvpQ0+TIlwZVFEkfttffGZXekkkK54SXnxg?=
 =?us-ascii?Q?x4rgKas3uJj5AWDwH0BhO+/mvhPbPyo2Gw2lnVR4viYPLgqdpposvBAODaVn?=
 =?us-ascii?Q?t261gcbon1RIg6iASjXuHUZK3PUSaCv7KZFsaXHUinsjS7E6yyRMkHeirDon?=
 =?us-ascii?Q?omfXIRspYUoCKhPloxcGeu0XrhZtbYlTy7f1/ACG87cwL/z85WZ6G3akK33U?=
 =?us-ascii?Q?PToMzbzuGO8KdpLKzj5GaRlvY3ieNG/Ljwn9DE2IDxEP5vTiB+5EvA/nwuiD?=
 =?us-ascii?Q?nG3HxDUuy9KS3fIgR4TY3Yf3ihVWMkXZQTXxQ2HrUvT/e9/yQ1x7gmQgDqol?=
 =?us-ascii?Q?go6ePypSGYU9HXSW9IjtNjFTxBaNuRUvUjtvqWzAk6AVLvyO4WNJ2vZRUjWd?=
 =?us-ascii?Q?d5wpPQtwu7CzS4AIsytfBvU2GMTbx+MDF6D8EqDLIHO4MlOlbJER9rhzHe48?=
 =?us-ascii?Q?024vzlde6uuVrzpJRbtnad4BKQ7JwPQrjWaBULIedu66sQrGGGx4msOFxuLQ?=
 =?us-ascii?Q?2+Wy9WohNnmfaytx+rbNqMEmnZOTftVWJKppLWHDsHjI1VtCNNTGLZVTRmnr?=
 =?us-ascii?Q?h0Auem2WFwca/APixzAmK5aqkhS7S7PYF6Ir+8oMlUgsx3ZA3x2152F6xugM?=
 =?us-ascii?Q?GDifqzJHMyg0JB/XetsohoV9s5kSWsXT0x7se/Ds6ijkkTmoR61J3rUXX0i8?=
 =?us-ascii?Q?jY3k8uBGT9eh9cdbnxSkKr+57jEEwRQV92p/N9GmoPTd+mLg4m9ouVTWGjpJ?=
 =?us-ascii?Q?iQ3noQNkDyzyGrUpF6c01dul1906/a/Axe3qG1KSujY/S2Gonug4ZrQJRRQL?=
 =?us-ascii?Q?dqelXp8id/VX4Hzvj+DTMdQE6ZKHk9hRUy7CKvvgdC9ih1gIk5+l7GWqEFnk?=
 =?us-ascii?Q?SHUEfiz7HIdhFBHejZYRbYsBfdV7h0sqsfN+b9sVtmPNbOlbCYyXMaHlKJUS?=
 =?us-ascii?Q?N2Iq9udFbOwqqfV9BX7eBGsvb4KHqNSFXh1n3V3bL72SIFm7bb0CRurFEaAo?=
 =?us-ascii?Q?HBEJ6PDkB7RUBfSIOK2vpiJ0eM4DVyth9hrMAmJZVCGaw9sls4FIiTFDiIiD?=
 =?us-ascii?Q?8D30aYmBjs1TZX2YrpQbjWlzQtLGARS6XGVWik8JSNwPAC7ZsmewrjzWuLuU?=
 =?us-ascii?Q?fFQTYMnRo+YO3n5Cvg1Gc0UOApR7adQecUyddN4tU5zkM5DKMi7DUx7SrawP?=
 =?us-ascii?Q?8XioRq+4/KShZWeMJacQuHVwgYWRl3EYtVMQ0mw8tU4ekJBu1vK2UpeLR9px?=
 =?us-ascii?Q?YpzQValY04MuN/+JRZhskhfSvI6guEc9nFd/vwiKBIpFjBfoR1pd8rOuDttu?=
 =?us-ascii?Q?IwqKe50oN2O1gJOTZMILE5P7S7gzwjTxJi1RGPI9t5T3F1+r1BbZJtUF1VfT?=
 =?us-ascii?Q?Qe5yLPvWtq9qOU+lQLELDbMvluitQ1k0z+fBfomq9uTH32zsBHEtwl6SPu7K?=
 =?us-ascii?Q?sy8LqBWjyP2pFxkDy90WI09CEMpHYKPzg7Etvxe4BHf/0l3App3Yixlc1wk5?=
 =?us-ascii?Q?wfEc14PNgy6n28EcXcg5eLtSCx0F6B2I3E1fcwBqzLiAamvLkJs4esmXzJ7V?=
 =?us-ascii?Q?kDX3KCufuQb8p/drdapMXlD4dgs7bkG9jxAUs/BnkmPDxm74lzYqLkMRvdL+?=
 =?us-ascii?Q?TlL0Rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JeO7b52jgk0pVjxuUeTTLUorAD8jtae6A+8bMoMljA2qdhDkHpZNnus3u8if77pHfUG5KevGdupplOSLb93+4bwVdx2BaSfgICVhOQfddH2sEib+qhDkZ1WxQj2KWC2g5E++zeKVAere3hv0pyb3fmZzHl0Ct1lMpa+loCP2zZR+bjJNNR0StulrR3FFLTKtOvugCwux9HpkYYjgYIKAXEgpCpPJIzhxn2YAcrgAyxCf2x9KLB5xVHxkVPuyO3c4agV9HrXPy/+CNBVc7MowrwHrF72MvncG1VgEzmaq0NpoPiyvzJs2Z9MAZmVBV7wSwEZoTI1SZHhX6OqdA6eGlGA4zu04z+c2tqC1slHZch0+EVdolYcOUKLfeqHdqScenczHv6NJ1vpJeGoXiewUzdBpou2yBKMFYmz1HDms4zV1+RPS4WxtgTofukxRHXeP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:45:15.3628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfbf10b-b6ce-486d-b4e2-08de686ff2a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76813-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 31A951176D6
X-Rspamd-Action: no action

This series aims to address long-standing conflicts between HMEM and
CXL when handling Soft Reserved memory ranges.

Reworked from Dan's patch:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d

Previous work:
https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/

Link to v5:
https://lore.kernel.org/all/20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com

The series is based on branch "for-7.0/cxl-init" and base-commit is
base-commit: bc62f5b308cbdedf29132fe96e9d591e526527e1

[1] After offlining the memory I can tear down the regions and recreate
them back. dax_cxl creates dax devices and onlines memory.
850000000-284fffffff : CXL Window 0
  850000000-284fffffff : region0
    850000000-284fffffff : dax0.0
      850000000-284fffffff : System RAM (kmem)

[2] With CONFIG_CXL_REGION disabled, all the resources are handled by
HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
and dax devices are created from HMEM.
850000000-284fffffff : CXL Window 0
  850000000-284fffffff : Soft Reserved
    850000000-284fffffff : dax0.0
      850000000-284fffffff : System RAM (kmem)

[3] Region assembly failure works same as [2].

[4] REGISTER path:
When CXL_BUS = y (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = y),
the dax_cxl driver is probed and completes initialization before dax_hmem
probes. This scenario was tested with CXL = y, DAX_CXL = m and
DAX_HMEM = m. To validate the REGISTER path, I forced REGISTER even in
cases where SR completely overlaps the CXL region as I did not have access
to a system where the CXL region range is smaller than the SR range.

850000000-284fffffff : Soft Reserved
  850000000-284fffffff : CXL Window 0
    850000000-280fffffff : region0
      850000000-284fffffff : dax0.0
        850000000-284fffffff : System RAM (kmem)

"path":"\/platform\/ACPI0017:00\/root0\/decoder0.0\/region0\/dax_region0",
"id":0,
"size":"128.00 GiB (137.44 GB)",
"align":2097152

[   35.961707] cxl-dax: cxl_dax_region_init()
[   35.961713] cxl-dax: registering driver.
[   35.961715] cxl-dax: dax_hmem work flushed.
[   35.961754] alloc_dev_dax_range:  dax0.0: alloc range[0]:
0x000000850000000:0x000000284fffffff
[   35.976622] hmem: hmem_platform probe started.
[   35.980821] cxl_bus_probe: cxl_dax_region dax_region0: probe: 0
[   36.819566] hmem_platform hmem_platform.0: Soft Reserved not fully
contained in CXL; using HMEM
[   36.819569] hmem_register_device: hmem_platform hmem_platform.0:
registering CXL range: [mem 0x850000000-0x284fffffff flags 0x80000200]
[   36.934156] alloc_dax_region: hmem hmem.6: dax_region resource conflict
for [mem 0x850000000-0x284fffffff]
[   36.989310] hmem hmem.6: probe with driver hmem failed with error -12

[5] When CXL_BUS = m (with CXL_ACPI, CXL_PCI, CXL_PORT, CXL_MEM = m),
DAX_CXL = m and DAX_HMEM = y the results are as expected. To validate the
REGISTER path, I forced REGISTER even in cases where SR completely
overlaps the CXL region as I did not have access to a system where the
CXL region range is smaller than the SR range.

850000000-284fffffff : Soft Reserved
  850000000-284fffffff : CXL Window 0
    850000000-280fffffff : region0
      850000000-284fffffff : dax6.0
        850000000-284fffffff : System RAM (kmem)

"path":"\/platform\/hmem.6",
"id":6,
"size":"128.00 GiB (137.44 GB)",
"align":2097152

[   30.897665] devm_cxl_add_dax_region: cxl_region region0: region0:
register dax_region0
[   30.921015] hmem: hmem_platform probe started.
[   31.017946] hmem_platform hmem_platform.0: Soft Reserved not fully
contained in CXL; using HMEM
[   31.056310] alloc_dev_dax_range:  dax6.0: alloc range[0]:
0x0000000850000000:0x000000284fffffff
[   34.781516] cxl-dax: cxl_dax_region_init()
[   34.781522] cxl-dax: registering driver.
[   34.781523] cxl-dax: dax_hmem work flushed.
[   34.781549] alloc_dax_region: cxl_dax_region dax_region0: dax_region
resource conflict for [mem 0x850000000-0x284fffffff]
[   34.781552] cxl_bus_probe: cxl_dax_region dax_region0: probe: -12
[   34.781554] cxl_dax_region dax_region0: probe with driver cxl_dax_region
failed with error -12

v6 updates:
- Patch 1-3 no changes.
- New Patches 4-5.
- (void *)res -> res.
- cxl_region_contains_soft_reserve -> region_contains_soft_reserve.
- New file include/cxl/cxl.h
- Introduced singleton workqueue.
- hmem to queue the work and cxl to flush.
- cxl_contains_soft_reserve() -> soft_reserve_has_cxl_match().
- Included descriptions for dax_cxl_mode.
- kzalloc -> kmalloc in add_soft_reserve_into_iomem()
- dax_cxl_mode is exported to CXL.
- Introduced hmem_register_cxl_device() for walking only CXL
intersected SR ranges the second time.

v5 updates:
- Patch 1 dropped as its been merged for-7.0/cxl-init.
- Added Reviewed-by tags.
- Shared dax_cxl_mode between dax/cxl.c and dax/hmem.c and used
  -EPROBE_DEFER to defer dax_cxl.
- CXL_REGION_F_AUTO check for resetting decoders.
- Teardown all CXL regions if any one CXL region doesn't fully contain
  the Soft Reserved range.
- Added helper cxl_region_contains_sr() to determine Soft Reserved
  ownership.
- bus_rescan_devices() to retry dax_cxl.
- Added guard(rwsem_read)(&cxl_rwsem.region).

v4 updates:
- No changes patches 1-3.
- New patches 4-7.
- handle_deferred_cxl() has been enhanced to handle case where CXL
  regions do not contiguously and fully cover Soft Reserved ranges.
- Support added to defer cxl_dax registration.
- Support added to teardown cxl regions.

v3 updates:
 - Fixed two "From".

v2 updates:
 - Removed conditional check on CONFIG_EFI_SOFT_RESERVE as dax_hmem
   depends on CONFIG_EFI_SOFT_RESERVE. (Zhijian)
 - Added TODO note. (Zhijian)
 - Included region_intersects_soft_reserve() inside CONFIG_EFI_SOFT_RESERVE
   conditional check. (Zhijian)
 - insert_resource_late() -> insert_resource_expand_to_fit() and
   __insert_resource_expand_to_fit() replacement. (Boris)
 - Fixed Co-developed and Signed-off by. (Dan)
 - Combined 2/6 and 3/6 into a single patch. (Zhijian).
 - Skip local variable in remove_soft_reserved. (Jonathan)
 - Drop kfree with __free(). (Jonathan)
 - return 0 -> return dev_add_action_or_reset(host...) (Jonathan)
 - Dropped 6/6.
 - Reviewed-by tags (Dave, Jonathan)

Dan Williams (3):
  dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved
    ranges
  dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL
  dax/cxl, hmem: Initialize hmem early and defer dax_cxl binding

Smita Koralahalli (6):
  cxl/region: Skip decoder reset on detach for autodiscovered regions
  dax: Track all dax_region allocations under a global resource tree
  cxl/region: Add helper to check Soft Reserved containment by CXL
    regions
  dax: Add deferred-work helpers for dax_hmem and dax_cxl coordination
  dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory
    ranges
  dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree

 drivers/cxl/core/region.c |  34 +++++++++-
 drivers/dax/Kconfig       |   2 +
 drivers/dax/Makefile      |   3 +-
 drivers/dax/bus.c         |  84 ++++++++++++++++++++++++-
 drivers/dax/bus.h         |  26 ++++++++
 drivers/dax/cxl.c         |  28 ++++++++-
 drivers/dax/hmem/hmem.c   | 129 ++++++++++++++++++++++++++++++++++----
 include/cxl/cxl.h         |  15 +++++
 8 files changed, 303 insertions(+), 18 deletions(-)
 create mode 100644 include/cxl/cxl.h

-- 
2.17.1


