Return-Path: <linux-fsdevel+bounces-74128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 373FAD32B57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C357D312597F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1C38A2AE;
	Fri, 16 Jan 2026 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="gVbcrCR7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022142.outbound.protection.outlook.com [40.107.200.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9F337118;
	Fri, 16 Jan 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573947; cv=fail; b=EpyGymitppgMrdcYRaxC7AKz+EN7hZ1FQkBo9p7kXeKjrXDQwgBo7LHOfzlywjhJb2YQlKHUDD8hGXbQuhL6dyxaZ2gJevy2uq2bndDoZ9sCkvjYiNv1SNYuS6gkvoG346TjSW/KH5WtC768ZnpZuzq6CtfQIvAginwveBBsrFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573947; c=relaxed/simple;
	bh=ceJaHJEx8NQjvrm+lgELw4ZNXOYu6GXwVHAorvlA0gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vE8QEr0GY1PGZAkNHCAdOquWMc3Esmww6drxCnW7L8MVPXyYyJlYzrCtLidZxqchEU3qMXeSmedYebPPsidD6p5lWPDEjUJoBZheK8z50ogZcyLG8opBYVegh+EDOuIpWjT5BajLhCyozcxtBvIpGFqhZW3LtbKVTVs6P9t4l80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=gVbcrCR7; arc=fail smtp.client-ip=40.107.200.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg30PN6zPbCoI1k74WC+mlKj3vu5JZiOspVdU6cwDRDA3daTzI27J8mPdVrP0hNAD5Weu07GI960YJ+MqSjHLKj95eBnmoYVKKrt9S2eb071hUC2V8lBu+oZiaT+mF5sPgdXn3QfBRu/nZcJ23uhJpow4CXqlxpcb1ToI/vPftedG6Ojv5z2x+87B1vndKnp7uT0gcw53/3j5VPXwVOzcgY1ULkjbeqFaemOE48OpGY0H7iMX6w7fPfZMnwL/Vj9DEj6DhhuJ5ClEOQcs84KNz+kfOOPQrm/5tzjVd43tdCFXIWynVJXIwg9MHt7Fa/LS3S/ip8TWAmMdcWjd8ppnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9mfphmILKFq/aQWOj0/+D/34fB03vov6OvkomZFh9o=;
 b=GHAr3C525GHpzyU647orjJBJ4xmN/CnLLo+eugdQpB9FN4tUJui0oN7HdwwLoG9i/0ScGWUZDIh9irvk9fnpETcc3JqGsirpyDLupESGhNA+MXaie/6RCfl+Cj6TKa4m9kARKKL3rmXCf1Y1D/edwydjARC4zL4kXWOYgs6CSNxYHTA6xcxg5SbTM1rv9SCj8uE9Re3QrCHxn0YRMA6ht4znyUtbH3sarCJ5qACyzBrFIXoxLgi1oJdDrPrbR0WianEDGxGc8uw6qOR6whMTf02RGWtXHTM4ke9zKr6HZkvSKAof/U9sttMsk3zcsWpobmp3Nbagtr7cE291VIPjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9mfphmILKFq/aQWOj0/+D/34fB03vov6OvkomZFh9o=;
 b=gVbcrCR7ENitfjwuR3aB9T6OLQwGrxUjGolO//UyrVl5IINs6Vq15HweXbUXfo2TJdPuIs+LRUQUTKx7Ksf2asPlTVt7ekkmQf2obgnBGgrTtNE5l/OwoAhSMZN2THCbkooN9N0mMQl8LQS2ikf/dQHQj5DDoEbw+56WuBhtRNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 CH0PR13MB4716.namprd13.prod.outlook.com (2603:10b6:610:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Fri, 16 Jan 2026 14:32:20 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:32:20 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v1 1/4] nfsd: Convert export flags to use BIT() macro
Date: Fri, 16 Jan 2026 09:32:11 -0500
Message-ID: <c8735411d66dd7db9c5abb2b5a1c4d9b98ea174a.1768573690.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|CH0PR13MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: e743ff81-6ef5-4330-10a0-08de550c0e73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XeNmxza9zPLp93Dh7m6iXpUV562xk0SZ5CB3Xe8YA3aBGrFAwy4bQ6hTy868?=
 =?us-ascii?Q?OT7w3MXmpYqPRXO/zMzVDgTGoUy6pfXrETWoASC0MQ7PiJKOrPRWKtSYPdCE?=
 =?us-ascii?Q?+D+fbhuj3PkVQW+lXo7dTPs0lSm1BQL+HfQrR/oCw1OxEqVL7cwge/JPDV6+?=
 =?us-ascii?Q?BEG6Ui9pXxjVVzTrXrRJJc9yibDoM0/WgZuFiEJ78EeXctDKvka+mBNywCcM?=
 =?us-ascii?Q?NR9sAdQN9yKiQY6r8hv/sJnjUfkAvjZy16t8PM+6vYTNn3SHB4h7/e6dIgaY?=
 =?us-ascii?Q?KSUWm16SE8/72zSfUjhleRpeAezOnBVXC9ltALz9DvEEIIxS+SydWAYiloZR?=
 =?us-ascii?Q?jsZSkykNqjIP4pwdX3twE3j+xNbL1E9EX3KYJOPYcbVLEGlefxEFNNITWguX?=
 =?us-ascii?Q?L5xWhcE5Z3xgNDKz3bx6rov9b1q8hEdSxfB8ZaMa2voH+vOCTU7LmQnRLBYN?=
 =?us-ascii?Q?7xZ7jk6JIoyHMNJmngTCerHKQJQNnjJvZGxwlzjn2O07cZvxJosG3JX/Gowk?=
 =?us-ascii?Q?2hhQeMtPmlLpi5AhYtrOqa8mAEv3ncaCuWR1ZEB4lPgjzTjwMqsiv/FER7iv?=
 =?us-ascii?Q?ChCsjM5IyaXb8MxszLTx5WhNzbfz8Q2wbu4Af8jddxEGbkjvLi5fIG4xRsb3?=
 =?us-ascii?Q?Ux+mJItJ0n7vzw7yMp6QDMuwBETEsS2taeItJweTH9NdoV3kkA7LxdrnmuB2?=
 =?us-ascii?Q?RjusESvCYuRi00H5P+gDUP5efqD0dzw/5rCCT/lT2N+8PepOPd3aADiLydWL?=
 =?us-ascii?Q?lbaMUFv8IKjMlRaNJfLhgyvgHnqIDKIglJ3AJZdy8GrLogypA3/C/+m52sM4?=
 =?us-ascii?Q?8k7oCKHJh3/weslRX32H5w9gT10MDo2esTgcapxUU25qga3VbSmrxbOET1+r?=
 =?us-ascii?Q?J6mxhm2d1GQ7IjrZ4OC53trfLd6mzyl1PBDdFAIle9q2IciI9fNPfjosx+Vf?=
 =?us-ascii?Q?P2to5xMq2qQ7dvXx27EJ1WEPXb+L1c8HaL2thR29Ce+sqn+QSntieRbwn46d?=
 =?us-ascii?Q?uGreshL/h6SWb+DP95f5+O6MVgtiUXDKDtRmyV9F0tcqFZULL0vA8/2rqxJK?=
 =?us-ascii?Q?yFnA14NWl8/0sRZCZ0/4aTRyj9RNgxDw/WgJk3dPYwAox1K9Cm85WwC6Odwq?=
 =?us-ascii?Q?WvOeXVsW9N2bQ0oxdnB9f8+++voqdsTtJN1lFDqSk0yA9w890B1qZI+J3z/F?=
 =?us-ascii?Q?XXKs/7Nxcxt1AA1L9tunOcuztE6FVa1zKuAN5d9WG53Hz+kdpUceCjtGzAW0?=
 =?us-ascii?Q?oDt24Jb3pQPIK4FX1wWo/8AUVpZpyJim/9M6e5Yj+57Is+oMcDfWTXLBl9u0?=
 =?us-ascii?Q?bB9wXpqDDKVZM0eGCMo7jylIPl9N8KiJx8UBb8DNfjhKQwBK7kldvsWgAm3z?=
 =?us-ascii?Q?fkhi6SR6Lv2uOisGc/cfsnDVkBg9V4O6EWKRv6WFgpnGJ5SoQ+MiQuCMqyRI?=
 =?us-ascii?Q?E2oIB0B2p0C6MeI6eJ/ksv/LXavZVRq9kcU4frEIO7XUZIgxf0QFUdbHIKQa?=
 =?us-ascii?Q?QyIHD5FoJRiXlaM4pni+UJeKrQ8bXQDbxYqq2GlFQPAsPQxNixlV/8StTWwJ?=
 =?us-ascii?Q?H02f3uJ9yXFi+6Bg61I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9rMf8Dv75B2CyRtJ2qNZEdgzhz7IoYAfPUi45ScAFMTkHts9X5+SA0yptDF?=
 =?us-ascii?Q?hPV/pFsXlN8CA3K2Az3M1vvuHF8/FGgj/o6WmPcGAsJ37m0eZXtHmXmoG0v6?=
 =?us-ascii?Q?T/jr1DJKb0Ba5CLrgaadMmvnnAku2Y1Q133YMN1UPiU5YzzLrUOj80FP8q4g?=
 =?us-ascii?Q?27IkIZh4Bg/1zmiz+yUDMxCY/jsrpa6oO3F1iIvk7vxp7fWd3uIVRAb7JsfX?=
 =?us-ascii?Q?YhDvAmxVPfLtcDUnVcHpoIFwKCdBk1MRgvaThUYA7ioBFvH6bghl92MfI9VE?=
 =?us-ascii?Q?2LbvnnKrPoH4z0ZDa0xr+jEvVG8PPrEf+UOnyvH5Kd4dqHMHTIHXbzK8NXph?=
 =?us-ascii?Q?/UNSFg83hD1gF7/sxQAWBLTq7YQpmOhwEqBgjFMNB2Mbl51/24besa70Hy0A?=
 =?us-ascii?Q?KEStNy+7yOhUD1ZbMQO1CmPXMBtEAzQDemdOUgjdeDKOBYZ+R0FGHHIsumi7?=
 =?us-ascii?Q?LPF8ZJbZTI9o3Y7S83BAHH8a8tp9WpVGutP5RWB6btSQWTly/PHuDgqdxdm+?=
 =?us-ascii?Q?jHvXnr4NrgKyDNjko3ECxiFJIfX5tUrt4u+c2fkzyzeVxM/7VZTGEsr73ENx?=
 =?us-ascii?Q?XxJS1ieoLeHSF/80B16OUzZPkXIScxle6cVFgD3vrbPJEOQVigicN2QzDlo/?=
 =?us-ascii?Q?+QwBYIVj6AjNehasdIXX7Hg7Jfy4UJfI0nvwz+C4Bn6WaXLn9KAKOMoPy3c1?=
 =?us-ascii?Q?2XMkmO15sQu45eeWciPMNuFu+8AcwUHk/MBwnY12w74sIlSLPiQ92oRqZYiG?=
 =?us-ascii?Q?yp15NZh+SOizz+afnGp+C3z7rQGCXqbVSFGgKac7cxAIwzF4Offj10oP4XmK?=
 =?us-ascii?Q?0kz4GnUz+jWc8GlAcdImWwXXgS+GaEr6/JuzA61PebtfV9bDu8RkFQKSDy2+?=
 =?us-ascii?Q?uWKwRjcMxnozD+agQmvfCvJOxkOAvj8V2DoHaSWmpNMyzoBNX/ifmE2BCJWX?=
 =?us-ascii?Q?pFwuMFaJPZivISbei4qPH4ilyOodjQqewOUVuCXwgHe6NuryplWGJGVfQW8P?=
 =?us-ascii?Q?323XO5D12yLQH2U0SkA3JGW7+bbJ0/LpUthTTE394HodNvBQxtYiON5RfKii?=
 =?us-ascii?Q?wWLsGtk7CpTn5PehgUaTrXvo5FVk3UhIEF6aUVi1NT40k4ILphgZiyyuQtFA?=
 =?us-ascii?Q?C7TB9lz70nI4oALBGkmLBcuco3bZf3egpGGH5SxZP7Gd8c5Y5PpllxI/mF/l?=
 =?us-ascii?Q?6o1+6ceipIEZpefKuK91bYT/VljLh6UMyp9P4tuERky/mey6xo15xDvUcvym?=
 =?us-ascii?Q?6iFoNtzKEu9qWPHKilx25nUzy867B3dkxtaQ7VlGRqUgfgIVz1nI/vPdJYqv?=
 =?us-ascii?Q?eATgSw0UAYNtKWtpMPDHlhiVyeqzyBVgvvOM/VxG7Is61WyK7Bi41ZICeUQ7?=
 =?us-ascii?Q?maEEWpqWlkvn9ZcCkj9P4ofWbosGIDN/UogkDPLCvjkMG4y+8O2ANjWj2Zhe?=
 =?us-ascii?Q?GnOWi3QnRc+nc4YTjYSX83h7qMLSxoHfNSSrA0KlmJSajfVOB7Xd71BRRIYY?=
 =?us-ascii?Q?da7DdaYzSWjMQEowmmXj6MUeGCtOFOMe9LrOqpZu9iAKvDY63jtVIiLPZcaI?=
 =?us-ascii?Q?nnAjp0iFghnKEdWdjNm95AGTS7c5KkrYWtuxv9eVb7AsS5fxDkmCgFGtdouZ?=
 =?us-ascii?Q?li1ItiZUBtSX/aTxoYkta8npF7A8BtIAqEKFN4zMvBx/9+d7R3fBwdElJVYC?=
 =?us-ascii?Q?b8Azdgx1aQljog1dwDg6B90XLqwjhOxJQMqEsj68QUGQowdxyu/OoYX9NH2o?=
 =?us-ascii?Q?ggirvWMD5lbdhFnOaFJtXdmeRCVojXc=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e743ff81-6ef5-4330-10a0-08de550c0e73
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:32:20.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +W3DQ3zBoxMV9y86wZ2xtUau8j07DbTYH2mkgoz8O1C+RxtX/MVzeXFvHsIut8C3j7Rx/GROlCclZhdklRBzzIfTEVn2Ph3qPVtEw9BuiTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4716

Simplify these defines for consistency, readability, and clarity.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 fs/nfsd/nfsctl.c                 |  2 +-
 include/uapi/linux/nfsd/export.h | 38 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 30caefb2522f..8ccc65bb09fd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -169,7 +169,7 @@ static const struct file_operations exports_nfsd_operations = {
 
 static int export_features_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "0x%x 0x%x\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
+	seq_printf(m, "0x%lx 0x%lx\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
 	return 0;
 }
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index a73ca3703abb..4e712bb02322 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -26,22 +26,22 @@
  * Please update the expflags[] array in fs/nfsd/export.c when adding
  * a new flag.
  */
-#define NFSEXP_READONLY		0x0001
-#define NFSEXP_INSECURE_PORT	0x0002
-#define NFSEXP_ROOTSQUASH	0x0004
-#define NFSEXP_ALLSQUASH	0x0008
-#define NFSEXP_ASYNC		0x0010
-#define NFSEXP_GATHERED_WRITES	0x0020
-#define NFSEXP_NOREADDIRPLUS    0x0040
-#define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 currently unused */
-#define NFSEXP_NOHIDE		0x0200
-#define NFSEXP_NOSUBTREECHECK	0x0400
-#define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
-#define NFSEXP_MSNFS		0x1000	/* do silly things that MS clients expect; no longer supported */
-#define NFSEXP_FSID		0x2000
-#define	NFSEXP_CROSSMOUNT	0x4000
-#define	NFSEXP_NOACL		0x8000	/* reserved for possible ACL related use */
+#define NFSEXP_READONLY			BIT(0)
+#define NFSEXP_INSECURE_PORT	BIT(1)
+#define NFSEXP_ROOTSQUASH		BIT(2)
+#define NFSEXP_ALLSQUASH		BIT(3)
+#define NFSEXP_ASYNC			BIT(4)
+#define NFSEXP_GATHERED_WRITES	BIT(5)
+#define NFSEXP_NOREADDIRPLUS    BIT(6)
+#define NFSEXP_SECURITY_LABEL	BIT(7)
+/* BIT(8) currently unused */
+#define NFSEXP_NOHIDE			BIT(9)
+#define NFSEXP_NOSUBTREECHECK	BIT(10)
+#define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests - just trust */
+#define NFSEXP_MSNFS			BIT(12)	/* do silly things that MS clients expect; no longer supported */
+#define NFSEXP_FSID				BIT(13)
+#define NFSEXP_CROSSMOUNT		BIT(14)
+#define NFSEXP_NOACL			BIT(15)	/* reserved for possible ACL related use */
 /*
  * The NFSEXP_V4ROOT flag causes the kernel to give access only to NFSv4
  * clients, and only to the single directory that is the root of the
@@ -51,11 +51,11 @@
  * pseudofilesystem, which provides access only to paths leading to each
  * exported filesystem.
  */
-#define	NFSEXP_V4ROOT		0x10000
-#define NFSEXP_PNFS		0x20000
+#define NFSEXP_V4ROOT			BIT(16)
+#define NFSEXP_PNFS				BIT(17)
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS		0x3FEFF
+#define NFSEXP_ALLFLAGS			BIT(18) - BIT(8) - 1
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.50.1


