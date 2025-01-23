Return-Path: <linux-fsdevel+bounces-39978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C4FA1A839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8F4188BFF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F83B212D9C;
	Thu, 23 Jan 2025 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="pArEmL9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3C14659D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651352; cv=fail; b=cL/J3raeOabSMdCnL0p0lnf5fuCJ6mxsiKqVSXFWWoKu/iuw/SwVbGjPrRlUl0Oky5jHxtKEQWLDUO4xT++nZkYUlOg53qq0oqCRftGjyvhsGjZ/m459WkxcXMgkCG2JR8+uDyrugLRGNZsYhgMP2gBpwKm4BkAl3vcszZ8wds0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651352; c=relaxed/simple;
	bh=7uUznK/YfZU6oNaNqW7LoZdrn6Fsh6HO9Ng4Vz0MDEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRkDJdgaqHq7LlX4Ahdz1Bv5ayu5a3y54C0Ej+AmcQA7l1diIdlfQ0DFB+mEEuw8dubNdIt9OuMynVS+pSEqSLerpABQ6VbhvLmPOMr5B92S9jT1Qn55OOO2sY1q2t272RMO1hF5M2iirzKeMd0yBtleaZiAAvI718WoVGS+TyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=pArEmL9x; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46]) by mx-outbound45-180.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 23 Jan 2025 16:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeFCDfGIevmRxIe9tSTQgouKXr6vZAE7f4DpiiGR6zGJLkQt+hoX0Y46laYu+H4JRb11dO3tJ2RhmbsRP9Ji9FtYOZCnOs5semlJ6UBuULZXvKMcCYQ6iRXiXTd/9QId4on2koPqZEQ/yycVbdJk40Aj1A4LvhyXBI/U+TjSYfZujrZVSTNu/nuobvWiA+xdK562lJbLMFPcAJZ9TGMRMPzATRR0zNoPujZZhcelfjH9R8UNjlAHYy5zA5JQ4R41Nvff6iEmwLbm8BP9oE9QnSG4wDN3EoSBlNb5Pp7S774cIyF1b3gf8x6GvuMLQlsGaFBUPmrQ8lHyTL15dhQLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbdn+bx/mGhyu063yjZNwQmWoVeh1ncOW23ua6R1b2U=;
 b=sUAc1LKA3eEB8phUG1sZ/+4s4gmB4FVVa6M08T6muxIOariwihaQJ16S6e/ybWXXTkn3KiVmuDyEut70tdrQEYUNAZjNVK6s5xkX4UZ4tRQ0RB1GXUztJPxTYSVVKu7I7DlYanY/IfIwcBVUgjYLL8N5U3HeUi9rZVyZ+q78PH3I5EQrjWOq5/RDIgcVdeq2uyOCQLSqRhLVvw/c2YucCibbgMFLSfmX0Fjp02avR6908YkBSjuOBybAeNQ5ca4kP+/H1IvZpemcpG1G8mODZK5MP/zPSkToYMh408MEi4gCUcWv32WIyZInGACgofcZJTW3G6QeAomsjmD1nFVtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbdn+bx/mGhyu063yjZNwQmWoVeh1ncOW23ua6R1b2U=;
 b=pArEmL9xQ6X8jpwBjD7WNUp3wiVFq7UDc6lSZBVO3HzEtPgX5mRsTxwogYx1IX5NUFpUf1ek0YBJiMsNoamopmvS05nQOddDp6HFGoGqQ/hmvFHtisFUKEg7Q2PD7KAWeTMV1dbLRDY08iD9x+Ou3UXxu0qy1ZEpnoVWzSwLrbs=
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by MW5PR19MB5652.namprd19.prod.outlook.com (2603:10b6:303:1a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 16:55:37 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::73) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Thu,
 23 Jan 2025 16:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Thu, 23 Jan 2025 16:55:36 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 5448558;
	Thu, 23 Jan 2025 16:55:36 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 23 Jan 2025 17:55:34 +0100
Subject: [PATCH 5/5] fuse: Fix the struct fuse_args->in_args array size
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-5-8aee9f27c066@ddn.com>
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
In-Reply-To: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737651330; l=932;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=7uUznK/YfZU6oNaNqW7LoZdrn6Fsh6HO9Ng4Vz0MDEk=;
 b=6oUez94nIIeCZtpmZ/wwOVfbdjqNCZC2SAF20yF+vz3bt7yc0RRun/D3S0ivnfoROdmKmZPl2
 PXmA37FaZCbD11t2aKUrRA5YEr8jy5RY9KHzubMd0UG/akGctZPX9qt
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|MW5PR19MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 25431981-150f-4454-4cb3-08dd3bcec29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjVBYzhOTXhOZVh5QmVGellxVjl4VEsrS2hqSjkzWEVUYTNIcXo5TlJRSTBC?=
 =?utf-8?B?SlZqSGpPMXBZMEJ6MFVNRjFYRWk3ZXJLRllCMlZ3VzQzckE2RkVENWdYV0tl?=
 =?utf-8?B?a1hHSDNDZW9JZU1Od2xSOXBWdG9ET2Vrb0lXVkFrL3MzNXVUWkE1RndLcFRX?=
 =?utf-8?B?cjR5WmlOaVF4MGFod2Z3Qk9kOUhCNUpBTUc5eklaOE9kYzl2UVpOS09OQUpW?=
 =?utf-8?B?elJlSXAxZ0RCRDZFaHdKNktabkNnSm9qY0phd09oOFU5T3RkZkg5UCtQTCtF?=
 =?utf-8?B?cmJNcENSajVGc1llMkprSlFXb0ZjdE05NGRwTGN1UzN0Yk02bnl6YzA5T2Rh?=
 =?utf-8?B?amFMV2ZIVnI0WWZBOHdaL3N1R0dXTlVKODBiUmVHQ1RvQXBQSU9YMFc3Y1Fo?=
 =?utf-8?B?UU5iQkxGWDN0RXJuOEJxQXRNZlI2TFlqZU4rcWg4YWZyK3NaaVRLa0Rsbm5T?=
 =?utf-8?B?ZDBvU1MrOFMvR2MyTm5jYU5LL3dFV0RRc2s3MnA3bDl2YmhCYUh3aXUwZkFz?=
 =?utf-8?B?Zm41YU4rZHZTUys2d0ZKdFd6YSs1TVRGMk1xVGs1aldWT2k5OWV5eThLdith?=
 =?utf-8?B?bld0eEZua0NMbnhwb0VydXdlUCs5alZiVWVpNDBacVpiYTh2czNVdFlPVDk4?=
 =?utf-8?B?end4U1RvUEZEc2s0bW5JQzV2d3FqNGc3K1o4aEFQU1QrcEJrU3ppdlRNQVA4?=
 =?utf-8?B?dmxVSGZCSTAwQ250VDlpTW83UFNUMG9tajRsb0czdHF0YzF2Ykc3UTBwWGxF?=
 =?utf-8?B?amJpSzhVbStNU3hyckUvWjdwQlNJNnYwc1hBMmoyb2g0emw5L1I2bEFwVzFj?=
 =?utf-8?B?RDZNMlNtbktpbDQ4R2NTcmJMM3VCTDdzZXNLUEhEaXN5NVZTRUdxYUlYeUQz?=
 =?utf-8?B?c1hVMWlSWitSb1l2d1dzQ0NVODA5aWI2VzFUanR6dngxRHVTbFpIMDNDRlZE?=
 =?utf-8?B?bXFsMTVNcTZvMjQvTDFDWjFzUHhJSThzN0VHMExobVV5bVErVHdlWFN0VXk2?=
 =?utf-8?B?d1hMYlptUmhyVDllVXIrc21ySXZxRE11NUd3Y2tKV3dhZDBCZEFQTzAxUGlu?=
 =?utf-8?B?eEJWazRpMVI3cjdtVzR6UW1NSkRaTnVUYzNJWWV1b1A0TE5KcDZYVllVOHdi?=
 =?utf-8?B?UHdnVE9kUmdxZWFJNVBEcVdibXVuTTMzUXdxZStscHphbVFPTVJiMkdZL0ZO?=
 =?utf-8?B?K3poNmZTRTMzRFhqOFhpYzA0Q1d1Yjh4Q1F3Y3hvc003clowSWtpcXdYekd1?=
 =?utf-8?B?MElNRGVGM3c0dDQvTkVRTkFyVzA0NExMNXlqOUZmam5xSndMbnBLa0hhSHpJ?=
 =?utf-8?B?VllnODM5NllNNEd3RGM5TWFrRWtObXFHRzV2VDFIKy8xdm56WFBBM2FsUHFM?=
 =?utf-8?B?clV4YVpwVHdyS3pNam1pem0yWEx6TzROWmYwUHg4OTZMQWU1a1g0TVZTNGxV?=
 =?utf-8?B?cjR4c0tIc1FueEpXbXlMcVZvMExBY1RKT0VkUFNCMWFnVFpLTGEwK0psY01p?=
 =?utf-8?B?aHlQR3RSMWdQeDlYdHF0UlBYYnRxdEJQL2FJVlRBTlIrN3hmTEhqanZ3SzNC?=
 =?utf-8?B?WVVJK1JUdXhMd1JtMzlsR2taNjdZd3NHcGUwbDRVdDVDdSs2clpkRWFQWnps?=
 =?utf-8?B?Qk8yUTM5c0paNkhJYmtLUldaSzVTR1V5MmdYVzh3UjU2OXp0cTB4VGppODF0?=
 =?utf-8?B?Y0VsbldpcWlWTGh4WDJLcDl4MVBIOFRkNFpxVSs3K1FuemxhWXpmT2ZncDdj?=
 =?utf-8?B?UThOWjBGOXphVy9HQUk3YVhlTmxGOGF5eCtybEd1SzhjRnVndzdPL2oveHdp?=
 =?utf-8?B?amFicTcrczBtRG1kejgvL1F1eWJxdDRIVWdYVVNWeXZCblJIbys4bzRjV293?=
 =?utf-8?B?Z1RTa3Q2RHhJemxZNXE3MGxxY2M3bW1zU1pOOWh0WXlnUm5VdlV5S1UyV2JD?=
 =?utf-8?B?VmhEdUdpMjlRQStvRkdZQVhoSWU2NlI4K2JsSXNuVVBtODhjdENxdDN2SnVS?=
 =?utf-8?B?Z0NiblRUTm93PT0=?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G947iCr2E1Xi9gCUu2cqBh8y/NSBOf5uXnH9gTU7onK2+ExVMTRQIXhif6jkP90jRa3gcRSpqdqYhzrUsRC4xdSScCMlrzpaGomCBNqOQwClEWp7oG6i8bpzwjh1JDAhY3Az05u08gyXZCB/Kx0RYAFccUKz82qCXAzfOgiHC/sDPsHGLO6vKnD+1j0Om5wiq2LfcZ+YEj094fifIZv5NW4F7u2Q2TomyqV7qYiuf5acIy/T1YYL+A8yJJV/MT5RrB8r261x0+mntBLu+09EagvGu7k6II2Qsu3PCqX6Bn7S4nJ4XXho1HGLxU8VFKozFRREXLF4oYOhnEG4oka9WbRuzYbZB9a6UrXcw3BtZZFNeekapTnB3v9UN7jnID/7FXAxUWuIq+UDV/BjS/ESH4dg7MoJIbiW/2nCtOO53yYvxuyeR6I15r5SuoZPWD3Fb5P4q1CF2PcNe5OGT0dsF7/vNmWvmg2mQTCEbDhd/ykfaXPGIS+qOhYz3EedwKH2BGsgWe66rUukYLThsXVnVtVnK1jFd+PzJUrBmiuaNLvglGkNGzHqBGNsaQ02gNM3VwvPUUgtRhNLExLBH/MZdjMFzZnypJIxOeHkMVAmClOyhw5KwRhwQvLCp31B/KG9YxZis2Nv2nJ5o1LKULS2ng==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:55:36.9734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25431981-150f-4454-4cb3-08dd3bcec29a
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR19MB5652
X-BESS-ID: 1737651339-111700-13407-10115-1
X-BESS-VER: 2019.1_20250122.1822
X-BESS-Apparent-Source-IP: 104.47.57.46
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYGZkBGBlDM0tTCNCXN0igx1S
	TZ3MzI0tDc0DzVONXcwCDN0MjAMkmpNhYArGDOZUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262004 [from 
	cloudscan11-173.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The patch that made in_args[0] to be alway the header,
missed that the array size for in_args is too small for
some operations.

Fixes: fuse: make args->in_args[0] to be always the header
Spotted by: smatch / Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/fuse_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 886c3af2195892cb2ca0a171cd7b930b6e92484c..fee96fe7887b30cd57b8a6bbda11447a228cf446 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -310,7 +310,7 @@ struct fuse_args {
 	bool is_ext:1;
 	bool is_pinned:1;
 	bool invalidate_vmap:1;
-	struct fuse_in_arg in_args[3];
+	struct fuse_in_arg in_args[4];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
 	/* Used for kvec iter backed by vmalloc address */

-- 
2.43.0


