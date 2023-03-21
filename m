Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCCE6C3255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 14:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCUNJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 09:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCUNJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:09:32 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCBE2D75;
        Tue, 21 Mar 2023 06:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOPNwRh6PRpbU+mD6aQDv8pLsxhWNMDhDtZP7M3bYJk1cTtNeTSZCqnQQjyXcSLHLnizcN4o0SZ/Vi+Xvx6/EvGXacws3E+smqBZCW1+PqnJDXX4536bYdW9/C3c8biWZ9pTWzMARv2a62ccFY4+ok26gACKpB01pox/q37IuAyBUOKQ/2STTcOyld5V3j1s76b5Hykes9h4zUFP+FNG/tTFbt+FGh33Qid0los1VoWa9TS4KDb6FXgNbpwW1+IdRN1Ua6jjPTrRLM9crBBMYjD37xdeHAGsp6fC6E3toxrDMEcy9wdo/IO14p7oYPI+4GzVtWAsJCCjZr++3ZJbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGdsEJXcQ/HK4aNBXBbLDxzK2MtapF9nxQfexeJIBSk=;
 b=gpKNcNeIMCGRwFoMv7A1lXXo0khzQBD7sfzXefngSfhdvwvrt2kXSMIZO1nFRPuq1TWCrhoII8CzGBi6AHHsbl+13L1yB9CrZ1oTiQBuTtief4EZMIwSa/x8IdayemQVloU0sAod0N6PDiTF5KGcKCqfGY96FSmvUoqME01ic28qJfyKLryy6muSGVVaf/IevS5WaRkAc+qcuIx0foc4fKAB9Z37mWkpypvMGMZtLhXx+I2QPfne9mNrswOudVH+yNpufletwNaqUlu0cx2kWdFsFv1efpT7Tzh80u4fHhPj1Dlal77iB4IMBe9JJo37zl+pG/V+MZHG2KJ4IybDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGdsEJXcQ/HK4aNBXBbLDxzK2MtapF9nxQfexeJIBSk=;
 b=FuMvk2xQPBhpsACQU+sxizI49wYvQp04DRtVpLlIUm8D+i6QF5b90hPtBtNPGqm9guplGAkKpHAQdwUIQl5f7+wmYjx4kc2Qiomht4X8OINl436I9GP//mgOtj9QRtiDIzPSDeS3ah+kV4VaEAbIe9CJ0AJ0iWaQSe7B8yfwtHaT2rAy2MaWRc6M8HwiZejTSxfbWVHYAa2ZA2iOzzfkIBHMFIxyoYqZlxd94UlJd3LS7wS7n7zBNt3S8tJzOUUGfT7XW1O55AerJVPp0K4Adhql1MrtJ09myz+nllu70QZpjFBOYdmhYtxCHeYLv4r7B2wRcrRSPFU0lCDCmRBnCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5507.apcprd06.prod.outlook.com (2603:1096:400:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 13:09:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:09:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] fs/drop_caches: move drop_caches sysctls into its own file
Date:   Tue, 21 Mar 2023 21:09:07 +0800
Message-Id: <20230321130908.6972-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: e775e6e2-2308-4e1d-5c05-08db2a0d7f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0e/N5pnYi7e+gln4WRbYbkwPsF691yDICjU9Wrnt8I/5H32A4MY+S1IHg51TYTocGw0D8UvcpJZGKTwd9T+fBue5ABFYejlVmysDPO7VbJ6U6IkLyqKUnOPdZ389skjheSYr7NPVFhHD/Q41B/ToBuh+DpVOT2vkwQyik8xGLuPBgmljqSi2hvhKIcOaw7KCfyI71v1lIsTHv8z7w+OrtF8QGL4oJt14NlsPjiRt9r9GGSgqpXm3A62jqkUdv8Zxng+j4wablJn0M+rju2dcuaz5Vo9nAskoDh42M61B0JMncCurAEkyhbvSbRPp/Er8uJioRFsFM/NR6jKissVDjFTlsIMCGWFrk7te8t60VO1ErcQyI3xqTzqiKOUasotGlrcYAmI58/xX+XBakHtetiB+Sz+rYZqOds8YFowOsuVnFeOotI31Gt+PBwf+cGz7n8pJoQFrsZlD9oY3oIkkxRbd16vaqpXvwDx8hkRtWvQ/tEvXx6h1EV2w/BMBbNf04nMwHz5isbTyTWJKk5LKOb6Pb0wdw5qQSKPQuU9Y7kIGIjQ4wXYHqBlYj9MBTslPV+joX9OEutxFxeFwVsbi4pjJPvYXpk/fUMCYAmWujD3Hv+Qex+acM1AHWIgugyYageBVC/WUP7+ABmtyK0/zK8fgTPxvSqC+YuQnQ90/0qfoTDLZGt0lZve/6onypx+hFI0+x72npSfS/TWPDsRcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199018)(2616005)(6666004)(6486002)(186003)(6506007)(1076003)(6512007)(26005)(52116002)(38100700002)(38350700002)(86362001)(2906002)(478600001)(83380400001)(8676002)(110136005)(316002)(4326008)(8936002)(41300700001)(5660300002)(66476007)(66946007)(36756003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9y6C8ZUjFym7q/G+Ej/Wvly/rO8LLI4VmVJ1g/zwJj8ozxVrbzNeuBbIhZg/?=
 =?us-ascii?Q?/Ab0DMwqJq1QJjMFf+EtHqXxbLA5yc7XgBk+9GIj6UAKrVWYybMgWFgdwBJb?=
 =?us-ascii?Q?hTm5hKEFAqicd1VV/PPBt90vsbqudj/HI1rD8ICcR5N60PxapjZM9V9nwSHP?=
 =?us-ascii?Q?hnkxXoopIQpcqYb27RWSuluA2+KB9fJXNAQx/MS5V9dkCpzzFZ2I9jtRDm3w?=
 =?us-ascii?Q?fvdP6mBYLXhlpyouus10R6JDH5FlKpi/vcnv6TPDtfMnLUYDpBQOWZoNbE/a?=
 =?us-ascii?Q?bmpN8Wq4VAHWR87cLOBsZtrahdwC+xqFOH7Xr8Pts3A8cYJfVrDbEST9Vwde?=
 =?us-ascii?Q?AP/6+hwsSoI2nlK2EMo1HNX7fNSXzcOnZETgVZTD6mznyieUGGXqmMVzvnCc?=
 =?us-ascii?Q?99Sk2VWytDSks8Kwm3mnJhELOhaOgdQ2XSgog3VaAxXpBG3TeeAMs//Fr+ml?=
 =?us-ascii?Q?C5MWY4KMJaZ3X8H4NCAfFg+EWBwczPLFD/GwrKGgqUzEW+FAix2mc8xY/wNg?=
 =?us-ascii?Q?lkR7IVS2ZuXNM+w+n36UqPERBhfKq+VUOMluTcYqhSq7e/oM+ar5evut9gSy?=
 =?us-ascii?Q?j31ktaXERNu30QGzBBjsEFkZfMMBpNplB8rMssSX8680V+AecH4jJ/1FqplI?=
 =?us-ascii?Q?dezedT8mjzxBHVDIXRfkruY5EIYohaOXRFmfmanuThPVhZL/mBT7XEV8iUEB?=
 =?us-ascii?Q?NYBtPIeZRR59Iyn9PrhZuCFXH4vHCxtXUO3Vv0Ksdm2ZP7iEJMmB0gBk4Bk4?=
 =?us-ascii?Q?953eCRzKwEReXps9IMJ209btneTYqD8nzN6Rp/gGpV8LmnxskQx0HT+KW/PM?=
 =?us-ascii?Q?Mj1r8lHpXBuQELQiO/W6kxQgV1JF6oSoasJaAj+LFePS9oXah13haZKREcuL?=
 =?us-ascii?Q?jqakXtbchg9LXmsgQ7P18pxuOPOutcAMeUaJCIjNBYxoi8IUzfqfsDwh9Kra?=
 =?us-ascii?Q?4UkLzU1Y8eCuIfo2EM1SFptnWgzM1KZL+M1lk3kmvkTsBedXm6Ei8ipzo9AD?=
 =?us-ascii?Q?ZrgLQ5x/UJPxpw90fFusZGhgWvIxsiAAvBovUNU2NL1lSCW4ejs8NeiNR8jk?=
 =?us-ascii?Q?GWWoEPConl4JyDsuaRONVYkasaHKU+mjmS4c/c2vBLWSy8u7+YLdddrKRy5G?=
 =?us-ascii?Q?5H+byV8LPjF2bj3kB9K8rKN/SK3J4xSJfjSyw4kYD1U5px6vmrAGgUEbqTaE?=
 =?us-ascii?Q?FCpYSZY7Bk89m91uiR0lBEzitEwIBosPvys9iMvMu9aWXCzB4araOa260A1X?=
 =?us-ascii?Q?ISpNXzIxok488wG8ZYFf3KMQlrS9LgLMJk6L9gHa3rTCgbMWLPMd+Olj259J?=
 =?us-ascii?Q?eodiZYLyOKMOaUoSqEMKr/25GC9glqBW80N/4dAmXC3fJ6T85pb2OlKZu5l9?=
 =?us-ascii?Q?9Hu8DqZuSPO8WymNdyiwnS4HUYTsOKbQZIFHxjQbwOLqALshSP3Ps4s+yKDM?=
 =?us-ascii?Q?Ia4VJ+y4+W84VhpSjwU4BPJBNV2H8Gcp1GHZ16UjCmuVH6Gdmk+9oanz4eWv?=
 =?us-ascii?Q?y5tznbGvsol8MJjzrloORiQK1k9m7kQky8TSVCjc2d9U8DJjbj+o3XjG/6qU?=
 =?us-ascii?Q?tEnOGh0+s41vjw3gzaxJGOnqsFdBvhequnSq50XG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e775e6e2-2308-4e1d-5c05-08db2a0d7f33
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 13:09:26.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0U1Qi7/JfiftZdAJpCLxDMw2XzjCifzsjvnZSIWn78N8RkJXUy5TQDoFW6zzKDn635G1Ra9JtKZLCp4j2+j0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5507
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This moves the fs/drop_caches.c respective sysctls to its own file.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/drop_caches.c   | 25 ++++++++++++++++++++++---
 include/linux/mm.h |  6 ------
 kernel/sysctl.c    |  9 ---------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index e619c31b6bd9..3032b83ce6f2 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -12,8 +12,7 @@
 #include <linux/gfp.h>
 #include "internal.h"
 
-/* A global variable is a bit ugly, but it keeps the code simple */
-int sysctl_drop_caches;
+static int sysctl_drop_caches;
 
 static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
@@ -47,7 +46,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	iput(toput_inode);
 }
 
-int drop_caches_sysctl_handler(struct ctl_table *table, int write,
+static int drop_caches_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret;
@@ -75,3 +74,23 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
 	}
 	return 0;
 }
+
+static struct ctl_table drop_caches_table[] = {
+	{
+		.procname	= "drop_caches",
+		.data		= &sysctl_drop_caches,
+		.maxlen		= sizeof(int),
+		.mode		= 0200,
+		.proc_handler	= drop_caches_sysctl_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_FOUR,
+	},
+	{}
+};
+
+static int __init drop_cache_init(void)
+{
+	register_sysctl_init("vm", drop_caches_table);
+	return 0;
+}
+fs_initcall(drop_cache_init);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ee755bb4e1c1..1a5d9e8a41b5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3513,12 +3513,6 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 
 extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
 
-#ifdef CONFIG_SYSCTL
-extern int sysctl_drop_caches;
-int drop_caches_sysctl_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-#endif
-
 void drop_slab(void);
 
 #ifndef CONFIG_MMU
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ce0297acf97c..6cbae0f7d50f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2148,15 +2148,6 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= lowmem_reserve_ratio_sysctl_handler,
 	},
-	{
-		.procname	= "drop_caches",
-		.data		= &sysctl_drop_caches,
-		.maxlen		= sizeof(int),
-		.mode		= 0200,
-		.proc_handler	= drop_caches_sysctl_handler,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_FOUR,
-	},
 #ifdef CONFIG_COMPACTION
 	{
 		.procname	= "compact_memory",
-- 
2.35.1

