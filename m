Return-Path: <linux-fsdevel+bounces-48390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25552AAE341
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6704A4C6410
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6B8289814;
	Wed,  7 May 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YZpIYK+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012039.outbound.protection.outlook.com [40.107.75.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131520330;
	Wed,  7 May 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628554; cv=fail; b=YkFvIf3pVJ9ox1U6jHy9hUp0jE39arQUzwDKmLYZ9TKVXsM0onTfiOhMCFTeVdHzNTLvUZkVtgCj/1bZwS8C8fjKj264RFmi/yssRU0OTG6U5KumMgcHjGh2Fs9vLe3t0pgNYKDEifmfdh1AsCqehyFz1TgvztxtMN4qepGqzeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628554; c=relaxed/simple;
	bh=O6wZoCjSG/e5pRCm/jy4ymLTad0Lcqv9Emi8jxNLCvU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N3XBhPi/RJeDxB6rJoeHWhtHlCMpFNyLHDOmtm2QR0StymLaaP21bWKrgd4AdXNb0Nz9jU/VljR/vKHu8tNxwcVFMY+25EdUAzKKsU2T4K8k5iHpLRa47goYUNcwGeWfQYG4FGIlAKmWwkDCC0/nqoy+Fpq9NgqXFdCYNuyWBXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YZpIYK+X; arc=fail smtp.client-ip=40.107.75.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+holifjZfyxBMyY7nczYyZHY97DIS1mf3brjkrN9ZiDQNuYz9MSHAC/RPXGDIsJJZmAbxRf5I+EC6zrTK3GZklAVeguaI2l5KGUFa0Uu8CW8eUCDlThg10sYKlJ8/7DoPqdlRPgyL3X8EzlgRINFPxFXS/PkA+nPQc1T4V3wADg719GnnJ4Oix2kWHZMzpRZHDbHYS8E/sHiIc4iyMw0umoBax5z7/DEfhFttghc3F4STZBnmgCT71sYJcvg23x3vf3yVdYwVbIDhe+7RvC2F9pHUUfcIQyEmF9yspfWQSkc6fUxSAlbxZT01CONlBax9KdExyA3uT7bGgJLNOEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbLCik/+iyf9sT7N8AlOD8EgPz4Ubs6bdgq530Sk7cg=;
 b=T6lQm9DxrP9nk45gcPMr3RLRURKmNpIzc0dNKnp55LUzoJ4np4thkS1UDHQbsocQ2wVijefijc6VV6CoVVM5jWD10xe65d94r9Gi9StGm98Ysiyxd3gWIVrg+orTsCw2uYkrA2t6SZtZgDMt/Kv0S0NdPwdbQOOkWQWyTGubCegVfqbzC2yWAvBkhcuxaBNQH4ouqd3rm2R/ViBATgW6+K9Gg1MBHS79pGQzWtmxHDcRvJI0xA2yw9yNJvVmHgaYtlUXW2tM8lmud5/4Zfc2G+83PFX4jaTqeyIlKmc2B2vdF1bgH9HYJTny28UO5Zx48K6QAPNTcR1mor5UPJ0veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbLCik/+iyf9sT7N8AlOD8EgPz4Ubs6bdgq530Sk7cg=;
 b=YZpIYK+XC/aGLho+nso/tbeZ95o2lm+3vdhI1JEPIXQ6Q2JNTebhvwiFEBhjM4IrZ/9Pyt+ydhWioE8eQ1gOK3Nn1J+zVZsT41OWkxb3qn2A1TuUi5I7XUVFfQujtUFr98z3jgsxkt2mxaF09KJ5P/y6p2DoAGV0zaARJfxk2dvVEzOLecvW1flF4r5JWh824377VMFP1ynMgk1pOCQSiNNjREb7+8QqlQECSgIwghOQliWf6Cxacd4+dhjNSHnrU78pr88I7LWboQT8bsV+83Vc1Gy/yuDB9Of96O4CVF6x+1ggfMGucU9bEpeEkFOjQum18skiW6RlzhSogA8JOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB7180.apcprd06.prod.outlook.com (2603:1096:990:98::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 14:35:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8699.021; Wed, 7 May 2025
 14:35:46 +0000
From: Yangtao Li <frank.li@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hfs: export dbg_flags in debugfs
Date: Wed,  7 May 2025 08:55:46 -0600
Message-Id: <20250507145550.425303-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa24423-ee8a-46dc-abbf-08dd8d747423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/99+XDtJF/S1/UfHIucFWRWKw7jRyCsPTRtzc765NYbjSah2Z004bWP2nfA?=
 =?us-ascii?Q?/JZgc7ueuzXFjJkQTcrDKsgMfsquI54GsWHf540FAD6FSIuQZr0cr1PEeBXi?=
 =?us-ascii?Q?zKWokwz0nexTuFhLSq2Nkf/fvRg4+0A8GbdiOKpElXMP1fFV+2MUk1yY/xeY?=
 =?us-ascii?Q?G3Pi396/qsXTg/fm2tnmTJDa2EhZwaoZ1Frnh0YnCuzi1NDayUvmHW/fdhsC?=
 =?us-ascii?Q?LCa+YXVZwddWJeteUuQIE6ZoxGQ8OaFR0dZ7Jnnr/eB1mDbHVw2LxiWTuY//?=
 =?us-ascii?Q?AuQEevsSpcpty4LdPon31mr5gVuBf7lcSPIj9L5FYyv/Tu1iGXU79HGrBvc5?=
 =?us-ascii?Q?n8tiOC9uOHg4o7a/EU3OkDFTK4JXirXaS7fZ+ELqwVcvCo76ImcraPByjq0K?=
 =?us-ascii?Q?HGq5GLShDIicOZYNTvBcjAoVoMF4cdjEW+J3eWoZOcZcuR2l/9ijSM9QK5Pg?=
 =?us-ascii?Q?zPJP6KXMNxxb9grq8rQ27SGRfLiLP7RQXvqXgAi9elZrr84LEFkRM3AmxrIx?=
 =?us-ascii?Q?m4J84tgQJoDCOAG0MqF/2vrw4j4oIVVQObx7b4ji6tvEDX26dYFBDXqnAg+k?=
 =?us-ascii?Q?JW0v781/Sgpphib63xcq2q0k2ACbRLSRNvq9KyOkG3hleBUQo1vtydUlIWN1?=
 =?us-ascii?Q?ZkOSeO55yw3Dtn57vlsmfq/NIyMasOQuQ6L+acexbdXRN5QbZSnPslzjM8Wv?=
 =?us-ascii?Q?6FV5fDVGdbGy6KR5XRnc/x2peFEJd08EFGwCnh+lXdHQo1avqe17uQiBnNV/?=
 =?us-ascii?Q?JTFJiFNg/SyAPNghzSynOr31kq2J2h5eUwqTs+f1b6qeaTSQkakHTTE3AzLA?=
 =?us-ascii?Q?Y+YdDRC1iATvKIQoEDNmQDdIyBgr30OyZrJkb8b02w2PexcTA3p0FXS3bO6z?=
 =?us-ascii?Q?jKI5LRsktyz4CR5fSEienNsBU5KYIU1jN0OI2yT6SdL/NBnjydDqb2MEmDgm?=
 =?us-ascii?Q?QsHfMIb3Zc9R8lqt4yjbZ+mEzmBAIopLJ5fD67iBel90euvcNhMXFRLGeVvO?=
 =?us-ascii?Q?0DsX6pdeCZfTqI2/fTXka7KOJ7UekPmf9/4kc0Vl/P9qSdPs8DDsqSBUR2Yj?=
 =?us-ascii?Q?InXvNk3OSKav6XEj6ZYi/6zw/C5BfJfkfLBiphySZ7KEbj1a4SBLbtQkaXPX?=
 =?us-ascii?Q?xh9n8GuOsRifJ+v8Nw/A+FvsrAs0t04M3ZnkbpE8WFXsIrlwzy5gtWUC63p3?=
 =?us-ascii?Q?BzZgXmPTU5Yp5di20izsLdUCEdK7JwXUcV2rHBonl9aJV2I0spsktzeii7FV?=
 =?us-ascii?Q?MEbMLyKFIjDcOd0kmkkjIwX5j96wo3ZayUGE4kzl+rhVT89MZLo9DCJ1B86K?=
 =?us-ascii?Q?m60aQCEfBZ6PONy+1HUOQdCDpzRZF3ji5XxSsldlyPlMFIMEqkNaYd/v1UXL?=
 =?us-ascii?Q?LYj5yPlggQ1qhltlayq/PjMyA+zlW6ZXzHzeqlsjFF3ZdMGJyCBN+EhCKPyS?=
 =?us-ascii?Q?TZh3A13wtsfAPqUEKNszybbnf4k4jssPYbqNhdax5+cULPUEjZYogw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?En+1qSy2kxZOq2yx28gp2wK/oern0IiDuF6TkkrSOFhgNwnh0ITppMNXh1SQ?=
 =?us-ascii?Q?FpWyZEB885hm+7padQ8CSHs/2rHTiP0+DWKRvVMAUc6+VpAMXPGp8ADnk96C?=
 =?us-ascii?Q?azlJdtqgcSLuaquEA+cOsKksI2XMxzKvSVHQEpYLUfkUDO6VQsrYZIeY3rbV?=
 =?us-ascii?Q?BWCpOWtzR4wil9HE06+gJIYZC48SRUWsd9n6y9nFh83rwVPGa5IZmbjhmMzW?=
 =?us-ascii?Q?m2GhvwsKoJGFCC9QMWjAp6gNJ0JA5hAiRwxl+K26OhaehmzWMR3hjTdR3JG5?=
 =?us-ascii?Q?zUguaLaCa1gD6rPTOz0/7fMj5BLMqNnggdKq900UaSAozufYtQxlCzx6K1Aa?=
 =?us-ascii?Q?DPlTaSG3KvWvaEs/U6x85qTqQHgPuiIkDKb3lMw9RahIEUIDTdgLVGvXqfEp?=
 =?us-ascii?Q?VixRS8prkz+8XzFP1ruaIPytPWXKm1xNhCXsP9sDvLYNf/izQ3IIeYSwYcN3?=
 =?us-ascii?Q?+aP08QkZFKCTMakw0uqj+/JPrEBpEo86d1UKX/WDbLbMteqLqILlcTlmo9UK?=
 =?us-ascii?Q?iOp0RrUt2YXHKn9yND8P6VymRkvoVALvJjn43wogrvKmJgHdrsuAs8YlcA84?=
 =?us-ascii?Q?CFZs8JQEO8e/0EPtzD07rYbbMg4WVNGWSkkhIYHFPWKyMedlPX5gaSH5Zyvj?=
 =?us-ascii?Q?Mu2hfFn8KQLKEeWx52iU1mQbfbhqDXRtFjVLX9aFOE4IcRbUUsGJY59eO8RH?=
 =?us-ascii?Q?ri1gOHTxqlv874gWx03D+fxSsFddlQxmO9gGUQLZ8Y6Q+fEk3LcLNjAm1T0m?=
 =?us-ascii?Q?Gg+NgThIg+m5ZcDQ4fSTTpT3smHaIQ8NjXjoxJI23OPZuS0EoI1zHa3XEdeA?=
 =?us-ascii?Q?G0k2JkbyJHPVoB0vJaezpvDDmB771Awrwz5ezzuIBhBodyIeCDybuCStzONM?=
 =?us-ascii?Q?CkoF5qTd/o9UQvpjmxijA7AKhRy49cSQ84M41smdFOe+C24nfB33L7woGPeB?=
 =?us-ascii?Q?5zHPBGcGiAKbzCAi2VpIsClfpw3mBEqRB2yX8hXOBieZ4Ub83GZOXU6WBoS+?=
 =?us-ascii?Q?RZn4jA2flKjrUZousakwFLAA8BMESMOJkOA/vOzO/0NkxbG7RXNvpyPeOlEz?=
 =?us-ascii?Q?xlhBqeqPiMZP2dI2AmkoNcr51H1VgjoumR4JOyBnN6hB7uZQJSCyBer5E3OH?=
 =?us-ascii?Q?IkBNLEftkyBxBdekceaoCO/oQy41VFGhtyWsJk4XTHsr0qYf8JHrhA3zPqW3?=
 =?us-ascii?Q?D79/tuGyqGA4uD1mVPszWU3zfAifhGE+q7a6vGc/8xPPFI5ui3IKZSd2ose7?=
 =?us-ascii?Q?m/e+2x96We05UYmRmreAplGGESwtJuzOMsMxQoUHSXxhVUrLjubE3kVElbnw?=
 =?us-ascii?Q?wgPo9uiSyvrV0nLfmDG6X3mhtmOdFMIFjanHzJ+hZ30QpsboaZsQB5rBL1uO?=
 =?us-ascii?Q?SMIbJ2IsHA9AOjAEpxAX50cGmOzqcp9WQwdkp6f/SLGRHVNi01z9/g+fCR/0?=
 =?us-ascii?Q?QbfEph9vGp8EWyc9OcVb4UbfpJRjLN/+ugJNCtTnOY2GxJ96eZw3EjDEvsqC?=
 =?us-ascii?Q?xG4bbuAuQ8n8HqtaN1JM77RjWsDLG7ZKqkv+T4Kj4vUwFYR32MptsCxeS6YW?=
 =?us-ascii?Q?vd+7d058j4NCqy2Gf+VscPTE1v1jJqMUJncWIc4V?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa24423-ee8a-46dc-abbf-08dd8d747423
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:35:46.3190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfKN8U/Ht6i01Exm5uqUkLcZqzKxLqMZDis4b4kNVzr43N1FrKt0fdIRRqtoKurE4NK5UUm6BONeIPi4q0szGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7180

hfs currently has some function tracking points,
which are helpful for problem analysis, but rely on
modifying the DBG_MASK macro.

Modifying the macro requires recompiling the kernel,
and the control of the log is more troublesome.

Let's export this debug facility to debugfs so that
it can be easily controlled through the node.

node:
	/sys/kernel/debug/hfs/dbg_flags

for_each_bit:

	DBG_BNODE_REFS  0x00000001
	DBG_BNODE_MOD   0x00000002
	DBG_CAT_MOD     0x00000004
	DBG_INODE       0x00000008
	DBG_SUPER       0x00000010
	DBG_EXTENT      0x00000020
	DBG_BITMAP      0x00000040

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/hfs/Makefile |  4 ++--
 fs/hfs/debug.c  | 30 ++++++++++++++++++++++++++++++
 fs/hfs/hfs_fs.h | 19 ++++++++++++-------
 fs/hfs/super.c  |  8 ++++++--
 4 files changed, 50 insertions(+), 11 deletions(-)
 create mode 100644 fs/hfs/debug.c

diff --git a/fs/hfs/Makefile b/fs/hfs/Makefile
index b65459bf3dc4..a6b8091449d7 100644
--- a/fs/hfs/Makefile
+++ b/fs/hfs/Makefile
@@ -7,5 +7,5 @@ obj-$(CONFIG_HFS_FS) += hfs.o
 
 hfs-objs := bitmap.o bfind.o bnode.o brec.o btree.o \
 	    catalog.o dir.o extent.o inode.o attr.o mdb.o \
-            part_tbl.o string.o super.o sysdep.o trans.o
-
+	    part_tbl.o string.o super.o sysdep.o trans.o \
+	    debug.o
diff --git a/fs/hfs/debug.c b/fs/hfs/debug.c
new file mode 100644
index 000000000000..4e98f7a3bc74
--- /dev/null
+++ b/fs/hfs/debug.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * hfs debug support
+ *
+ * Copyright (c) 2025 Yangtao Li <frank.li@vivo.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "hfs_fs.h"
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static struct dentry *hfs_debugfs_root;
+u8 dbg_flags;
+
+void __init hfs_debug_init(void)
+{
+	hfs_debugfs_root = debugfs_create_dir("hfs", NULL);
+	debugfs_create_u8("dbg_flags", 0600, hfs_debugfs_root, &dbg_flags);
+}
+
+void hfs_debug_exit(void)
+{
+	debugfs_remove_recursive(hfs_debugfs_root);
+}
+#else
+void __init hfs_debug_init(void) {}
+void hfs_debug_exit(void) {}
+#endif
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index a0c7cb0f79fc..bfcf1441e26b 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -27,6 +27,7 @@
 
 #include "hfs.h"
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
 #define DBG_BNODE_REFS	0x00000001
 #define DBG_BNODE_MOD	0x00000002
 #define DBG_CAT_MOD	0x00000004
@@ -35,23 +36,23 @@
 #define DBG_EXTENT	0x00000020
 #define DBG_BITMAP	0x00000040
 
-//#define DBG_MASK	(DBG_EXTENT|DBG_INODE|DBG_BNODE_MOD|DBG_CAT_MOD|DBG_BITMAP)
-//#define DBG_MASK	(DBG_BNODE_MOD|DBG_CAT_MOD|DBG_INODE)
-//#define DBG_MASK	(DBG_CAT_MOD|DBG_BNODE_REFS|DBG_INODE|DBG_EXTENT)
-#define DBG_MASK	(0)
+extern u8 dbg_flags;
 
 #define hfs_dbg(flg, fmt, ...)					\
 do {								\
-	if (DBG_##flg & DBG_MASK)				\
+	if (DBG_##flg & dbg_flags)				\
 		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 } while (0)
 
 #define hfs_dbg_cont(flg, fmt, ...)				\
 do {								\
-	if (DBG_##flg & DBG_MASK)				\
+	if (DBG_##flg & dbg_flags)				\
 		pr_cont(fmt, ##__VA_ARGS__);			\
 } while (0)
-
+#else
+#define hfs_dbg(flg, fmt, ...) do {} while (0)
+#define hfs_dbg_cont(flg, fmt, ...) do {} while (0)
+#endif
 
 /*
  * struct hfs_inode_info
@@ -184,6 +185,10 @@ extern int hfs_cat_move(u32, struct inode *, const struct qstr *,
 			struct inode *, const struct qstr *);
 extern void hfs_cat_build_key(struct super_block *, btree_key *, u32, const struct qstr *);
 
+/* debug.c */
+extern void __init hfs_debug_init(void);
+extern void hfs_debug_exit(void);
+
 /* dir.c */
 extern const struct file_operations hfs_dir_operations;
 extern const struct inode_operations hfs_dir_inode_operations;
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index fe09c2093a93..8403f3bc89b1 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -452,16 +452,20 @@ static int __init init_hfs_fs(void)
 		SLAB_HWCACHE_ALIGN|SLAB_ACCOUNT, hfs_init_once);
 	if (!hfs_inode_cachep)
 		return -ENOMEM;
+	hfs_debug_init();
 	err = register_filesystem(&hfs_fs_type);
-	if (err)
+	if (err) {
+		hfs_debug_exit();
 		kmem_cache_destroy(hfs_inode_cachep);
-	return err;
+	}
+	return 0;
 }
 
 static void __exit exit_hfs_fs(void)
 {
 	unregister_filesystem(&hfs_fs_type);
 
+	hfs_debug_exit();
 	/*
 	 * Make sure all delayed rcu free inodes are flushed before we
 	 * destroy cache.
-- 
2.48.1


