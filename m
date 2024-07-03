Return-Path: <linux-fsdevel+bounces-23057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC5926730
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983041C225EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94C1181B9F;
	Wed,  3 Jul 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="pSZ840wY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199A1850BF
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027881; cv=fail; b=saiqrGrz0rBRib+eLs1YFPd1fFEZoB+IHKFNBBpwNCHpxQUVBT0zU3Q3XxgD/II5/cDBD6zh18WEPYbY4W2jxJfLNtgOqjJBC8Hy4E/WpggT0irYE69k2kKvoa7QbknY+dn3acQ0XWn9IxW0XI883YukstdE4sEnPeaBPHsoWdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027881; c=relaxed/simple;
	bh=KAfSJElOnIlc5CubJ5pFKh/T6UoMouLKiTjptqkkvtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DAP87ZZEZPyCLOyTAN9tvacc/mkmsuNQoquWtxu0lZFdqsMPT37HmRUX0RhSp2kPA3NjoLsewzPFqWML1ALgG6g+JNnPJJ6haNChwQKAm/BCkkRb+tmRtC0j20HZ3Wv0W+71zajL3+qg703pZwlj5rbNZJunryb6PwaYiFx9n8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=pSZ840wY; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169]) by mx-outbound9-66.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 03 Jul 2024 17:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8NHJjQzCCTGnnKKWBD6OdOUaCfrGHAzLR2yHfgYSqG9EIA8FwTltt0ANyCmZ4B9G9e2ivI7ylNa6Z5pbMJ6ZN6CghJfy+RlvN8swAQmS9Ah5ggg2W8YTdMtVxgJ/95TaDpNCQE4u/17JFaRO8klQO1Kq2YxXQdULyaOUPJGWO7COe1pntJSBeTNmyED2nGWpCT3OXlnew4p0zA4yMmr7HPhu6rBEL3dyhApoABt6S5SsoDNxNVM6vvQodRUoUODjU6ZExcy0hi8a63DSkVGV/EKq/k+vHmbbgJAxJwTtdQ7o1Uoc8g9WrC2W/fatSbq6dBGOqc1JNTYNHI1q6Ks+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhQYRo+88GabKRiItJNDvc+2aIgv9M3odBjOVVeK/A8=;
 b=B0/B8jLAzHV2jhiPnEdDyznfg185jqfCgF4NeCSjaXeBeCJp+ranWRzfpEMqpGWc+f0Gmjt8jLm6eaJB4D3GDUOpbvlcVo0P43Vld20Qhv2REYfs/NbVzCQXkFp9+hzK8l9G96kJwr1RSLKPRHFKf8CpobPuvmy0RSp9J0PyhzVU+kjBE9csQDBd5xUnQeLHylDe0zI6m4cGZQhN9+YzCc9/6AWulC0arOm77zeKvw+AZDnECOzBSFmsgyb7u4f0t9U5M8gJ8M9yeRfpoo6MVmGUeBBq9Qs/eFYxB4GH2d/ASm/cSOYkgO6q0Y01fUY+cat0cI38+b2GRP8c16OA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhQYRo+88GabKRiItJNDvc+2aIgv9M3odBjOVVeK/A8=;
 b=pSZ840wYOo+p1j/S49Fl1Yjdnf6WR7QUFl4dg/XZKmdz+gysfzU9cPDH0KejfXsacnI2UyyxBSC04G/HAz1oZm/y9xyctqqay8nlumR6dLv+v/fhb+vS5FSTXKRq0UOj0fkNwBcbGwTxXizS3treWcQUQkRpOZeijsDsgpR8Ag0=
Received: from BN9PR03CA0122.namprd03.prod.outlook.com (2603:10b6:408:fe::7)
 by CO6PR19MB5386.namprd19.prod.outlook.com (2603:10b6:303:149::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 17:31:00 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::9d) by BN9PR03CA0122.outlook.office365.com
 (2603:10b6:408:fe::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34 via Frontend
 Transport; Wed, 3 Jul 2024 17:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7762.1
 via Frontend Transport; Wed, 3 Jul 2024 17:30:59 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 7E68B27;
	Wed,  3 Jul 2024 17:30:58 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	amir73il@gmail.com,
	drosen@google.com,
	Bernd Schubert <bschubert@ddn.com>,
	stable@kernel.org
Subject: [PATCH] fuse: Disable the combination of passthrough and writeback cache
Date: Wed,  3 Jul 2024 19:30:20 +0200
Message-ID: <20240703173020.623069-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CO6PR19MB5386:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4fa10409-a2a0-4327-cbd9-08dc9b85e78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yni5vTje3e7z5Raj9SeIdnwcTufEwEYb6w+L/4MkNZdJK2XwB7DHfs7yKPyt?=
 =?us-ascii?Q?ahSbQfWXGtHxDEsqLpVBuBqIc0uN0ZGssUKkqbz+hJzCwwZ2d9YiXy3UKdKt?=
 =?us-ascii?Q?Sd5hCLImfJBVg64zHjBCgzj8IR7kJNWg4TOmeLpDvagCRQFdTlFXh7O6IBup?=
 =?us-ascii?Q?ThDC13+4o/no3rrguTtpD/I6S8PY7cg4RsFueMNggXNAJAjMc2V2IKIWFdS1?=
 =?us-ascii?Q?1uTKI4QeHZfXQXBgYyODEAXbYHjEEnYojCR+5EdagSOPzIBCMQ9Wyl8wCAJ6?=
 =?us-ascii?Q?e7BymIEjMOI0BZ/pxFGVk6r4BNAIsppgnbRcM083k79+w9d19CSPPanEE24Y?=
 =?us-ascii?Q?07TRbHaXay5v9k3eJKSsaCNIXo44I9qBa+hqZKWKz4NXITLQf+h3ZvdWCQkH?=
 =?us-ascii?Q?zf5dvh+u7vt8v/5TdPlXXD8GdDbqfWep9Df9e38qmSLK9GhDqcVIa7ZWEv/a?=
 =?us-ascii?Q?KsbibWD1Fis8pd1SXEgn75iKosKqIakWgiWi/5jdmxiNRe7lkvset3hhjaIg?=
 =?us-ascii?Q?HNxQX38PHPqlVYCpTRF3EO0WMShzwlex2gScd+kk42iefFGLp17HQA6esoGM?=
 =?us-ascii?Q?Duv9eTw9SiF+2nspWdqFjNLGo5pTY4z1Bbt7Z69WZGztKNcAZ8Z4vwHr58WO?=
 =?us-ascii?Q?GjVXeXBkmn/FH4uK4PMOWee01JN25jROYYCfit0zg6VWmC8VKRk2+DXmxmtR?=
 =?us-ascii?Q?IwnHCu1gth3p8EAM3zLrbOB8I2euB+h4ncxnN9mq/5jli85lDb9CGW1woiH6?=
 =?us-ascii?Q?QPQ7T6ry05GuH8J78BuXCIzRP0/j9jC6anFbCF3+oPy6c/2h898SKVmzGezO?=
 =?us-ascii?Q?mKOLAxZHTq8om4bvWurm5cwzpqJPDeShGeIWHvseNBGPpJbyyIfxnsZer7mC?=
 =?us-ascii?Q?OHxlOu0OE9NYngYCwWBi7xjZfkA5VCVuoAmCgMCin2jbd05yy0aMwXWsMLRb?=
 =?us-ascii?Q?MdptT7KKYhnSiyeN12Si+JGWofaNUN27WCoyeZShfUiKRLfhNN9g1uZKGCVt?=
 =?us-ascii?Q?dESXDwLrOYAXhBT1I5KMTIAbBq0OFdxAGvC5WT5Y9m2wOTU7nMTgOdSPzDrd?=
 =?us-ascii?Q?EMNtrkt+Q1qCMfnZCtQrucjQPm6IMLt950E+agfI265zxCrPbh7NIz90Krim?=
 =?us-ascii?Q?sfZMPLtZnGjZJa/VJ0myQ8fwvXeAyP+bMM5KUr/a58yV5Yf1geCo1HDd+rks?=
 =?us-ascii?Q?+rYVY0xKuPuJLXKgR8Ng7LyN7iLyBtjS0AfyxDUluSrPVImlUHfGnhtzrfVY?=
 =?us-ascii?Q?fGzL2u4WoiTXZLf8tCD5GKl71MNy76NfKMWueR/rHG39+t/j0lPGnBV/FZBt?=
 =?us-ascii?Q?r18im95IrgZ/9HkR70OGTXjDwBdxMTf9R9oyJGTxZmp73BRm2bgd72GtWUa7?=
 =?us-ascii?Q?ZlXoRk9oYX6JGD9cyCfaKvof5dB/l0YL9KIbzo3yq+NOOvkqpMem7zAOSmhK?=
 =?us-ascii?Q?pTkqkbmb9eh4zu4sLUItrFgYg3RauCHT?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HCJysw61R2UxAkJ7Fuj9GJEDJzcGFIftJBsIBHTnUZ083NPgG/u1tFtPghRTT2/R01HkBodPAafCsUXZgPQ+EGj3WzudlJslVrl/6WiSaY38p2LQOn//cgYO9w22j32iU7HiShP1wtJNdEibqKaNGAFihIQdGgCi5qjM/fNfGciY6IWFpkFj8wi9iti5CgRVFHPMUUGb+vWfNP2N38whmZsfGZzOm4pxydyYoAKm9kj4dfGX4hjZDxtNXgup1lCe15Xe7pku711y+bllB08KFvo/pETPsq0B86Szc4VRBy1/OfrnW1w54t+aX6arDHgDrcjtisW2hVqHZuvL9So+pd3wsY3ca5hes5X+Z1+iT5XQ8l2aayZ90TyjbzDPw6BV1hNR3OWcy+mgeJXnavmO89fLLISjytJTBokTn4Vui4KvDDr0qrMaMZ9w+ERDl5hjRbC2vikDX5NDjt7QNy7IW0wBkNMJJtD4aHOiIeIaC9olK4f6mJC/LDuZ1h1XAtsgqbafVX9wWyx5SbzitGMsbiH92xzETjmkbOBVBIU8T6kQ9YaMSO3o9itSxRjBKL29q+juxVSbeK8cyfeSAm2SvsDWgLOtIPpWfIi2eef+Xu4ajYUDrEpiD7wkK5Oh/DFzNC4xkvztdCUaqFkXMQPb/g==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 17:30:59.6106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa10409-a2a0-4327-cbd9-08dc9b85e78a
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5386
X-BESS-ID: 1720027864-102370-12643-4975-1
X-BESS-VER: 2019.1_20240702.1505
X-BESS-Apparent-Source-IP: 104.47.57.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGxqZAVgZQMMXS0CQp1cgwNc
	nS0sQgxdIkycwk2cjQJNXY3DzRIMlcqTYWAGOfOIVBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.257373 [from 
	cloudscan9-124.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Current design and handling of passthrough is without fuse
caching and with that FUSE_WRITEBACK_CACHE is conflicting.

Fixes: 7dc4e97a4f9a ("fuse: introduce FUSE_PASSTHROUGH capability")
Cc: stable@kernel.org
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..569921d0feab 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1320,11 +1320,16 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			 * on a stacked fs (e.g. overlayfs) themselves and with
 			 * max_stack_depth == 1, FUSE fs can be stacked as the
 			 * underlying fs of a stacked fs (e.g. overlayfs).
+			 *
+			 * Also don't allow the combination of FUSE_PASSTHROUGH
+			 * and FUSE_WRITEBACK_CACHE, current design doesn't handle
+			 * them together.
 			 */
 			if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
 			    (flags & FUSE_PASSTHROUGH) &&
 			    arg->max_stack_depth > 0 &&
-			    arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH) {
+			    arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH &&
+			    !(flags & FUSE_WRITEBACK_CACHE))  {
 				fc->passthrough = 1;
 				fc->max_stack_depth = arg->max_stack_depth;
 				fm->sb->s_stack_depth = arg->max_stack_depth;
-- 
2.43.0


