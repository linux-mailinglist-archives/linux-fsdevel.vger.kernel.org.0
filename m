Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB07C74EEC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 14:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjGKM3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjGKM3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:29:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071f.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::71f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4561739;
        Tue, 11 Jul 2023 05:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxLKgJq0b7C5CHmhS13Hj5nEWN5Zfp0j1UiasviFHReD1aE2Qrdw5DBq1Uy7H1LvjTR7tAnF1jAl3uaBqzmpFEM1+ynfHdvcAEhwhdt5a2MU9lCeWlGNoJhr2ZPAR3npsusnzE7PYxB5DPhYQXGlc5Od+QgoiXGtsAVxa7X9x/GOgz4u7rJL+C9cPNteGFlguTcyO82C2M/oQq+imGaxZON+8itRAyMOcFl5bwA+FP0NhNGIG+pstp7t5BTAVXGatTxjbTwR3Bd9OB00J9IzAGWqVtfMsI4Dq2tni2VgRpVaqdNVbPPm3m8/wvYcehoX9w3kHWYTF1TvclK7HSA7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOHuy0P+mXd0cVvuNQ3l6H4kkgZHxrLSsNmElm0G0Rg=;
 b=j/I9W2Jg4AhlTSa6IGliur9VdDPbPLum6WwDGjIf4Nppg5N5jY32X3sxCskSGPrFqWWPeUQIl6CpFIReZVC28sEwHrdd+BnUeNiBl/zod7nXzldr2S7p+f/kNkGZO4NaZxeWLn89gL8/aiavHz3hBwNKitzQ94Ud9B9QBIFixcaWg2hjMC07TuX1JmuMCdTQQgpvSW5BKdA7t8KpSkjcnNM1lsJDvFJIb5pLlEMKqCHCSN3wlhcUR62xVa+bH4RLJbsXhrY+V1wzOnskEU+Ho5QjvHeZhlLRHnDyVNSxVKxrtOiAzzZAkafIZ2nez7FHUHNgRlJxlFH/BQmhWaZJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOHuy0P+mXd0cVvuNQ3l6H4kkgZHxrLSsNmElm0G0Rg=;
 b=SjfDNnRQpqavWZmc+4oVUJ3Z0Y1JfwAP6P8LEaJHpaEGokTmxGtbpFjmWXSXQLgZUlSZMVFP1/YUYx/AA4JOuscyeuO5ABv3RVWvzLUPIlyompm097r8VcCcGIXJLghpuipNxRD4xLJcodE0a65ScHbLO96xhgm8TdVRCKOc5LkN/J4lKENlmOWWbuH0QOaF48sJJ8EqoP1w6jmaPqsqrirCewpD17KfX5rOfrr4UYvJ0fDZV3SvBf3e6i2XsOuQ/0AL4Icn4Sntw7Y6OXYHpsEfJnHkDJKQI/SavNhyAXXJl+mIwnxH/11+kX2HBhgPc7s1ZtlMH675eSVTFQoPmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
 by TYUPR06MB6149.apcprd06.prod.outlook.com (2603:1096:400:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 12:22:21 +0000
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019]) by TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 12:22:20 +0000
From:   Zehao Zhang <zhangzehao@vivo.com>
To:     linkinjeon@kernel.org, sj1557.seo@samsung.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Zehao Zhang <zhangzehao@vivo.com>
Subject: [PATCH v2] exfat: Add ftrace support for exfat and add some tracepoints
Date:   Tue, 11 Jul 2023 20:22:08 +0800
Message-Id: <20230711122208.65020-1-zhangzehao@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To TY0PR06MB5706.apcprd06.prod.outlook.com
 (2603:1096:400:272::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5706:EE_|TYUPR06MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 531b744b-15c6-4689-399c-08db8209792c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgdqsVQ+55TFH3gQgbjEwyKQaNAfg/T7IzfzqAEJoRzfqhCME1X1eFO+F1ThesBWVKfbruf3K90ufgMVr2oUYK/7ngMeAbSB8vFHaNYPfd2yqaqNjCnU8zQ1jTISewIiTe4AJaXJTwzHi3n3zjYnda/tAfaqjXcBcGnlmizZDT7arTYtIQ3dyLFRTgOqGi9oY5MlzOMjXJOBcrzOg4N+bLO3l3qChluKZ6CbkmRFrCudgBMj6VMQ+UAhzzQR1gx/EnD4WUKewPfg1r3wgaP+7GLNcE7KvnsLcYe5nobR8Yeug/s6kiB+tDtR63fADVk3hsHwf3YWNXXUMDgiktPEsEe2w093F4qTsBZ1wCT6yk5rCmwdxZJrkJ20KltH6OT1Dgk5d8j4zgfEqkt9aSEWXPiKD2XIP4NtqUXBLZVNcXrYcAG+Oxeifi4Q3LPGDo7vbm7Q5zFDMTfI5Ouj4vbueAWGSbx2Cq5UtlmiEWrcYGAxr4DNg+TsEpJ+JZfDdJfQOPwQ9y4+hPKQtBk0Gs77NtaMUWP49aoJ2N6NymOEPWaE9Q5Xww/JMbyibZTSs5GDoSshC9VnP4WBX9ecTWDAOSkC3V/qdn9lE/egawcnn2785Ozx/IYzA3Ck/0NoomN9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5706.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(41300700001)(83380400001)(2616005)(2906002)(186003)(36756003)(38100700002)(5660300002)(26005)(38350700002)(4326008)(107886003)(8936002)(8676002)(1076003)(6506007)(66476007)(66556008)(316002)(86362001)(66946007)(478600001)(6512007)(52116002)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bICy/EVjUX+Rkeoiv1oA8kkJKgKLYJQU3pUqzFPCZwwBf8/jwUviQGQieF+F?=
 =?us-ascii?Q?WQiULQKcBwPS0Mr1sMBWLtfKjHgj/CH/ueR2e0Xjky3RQG1mT9803udxxIW3?=
 =?us-ascii?Q?ivAjVOtPO/4Qw486lP03ZcUDeqMzJBqTXqMzsb84rIOaPpA990N3oXhVVYzQ?=
 =?us-ascii?Q?Cm9r5piUN24ZxTbY5+GrKtMDDwz371C57yU55LgjlJ3JOBGsw9vxwKkeQrJu?=
 =?us-ascii?Q?PMPefieNmtNmlo+lWV40fQ0OepA6ivpy6FYoU88PeNY7PMvTV3ZHjzr+Uq0+?=
 =?us-ascii?Q?QLQTSI1v/l4wauGK+K3wDEeKNUlVwAIFjGWWOlb8joIb1pcwsRFyZj/st1cw?=
 =?us-ascii?Q?kZKb3E1G52YxJs6UEzvxyUgV5AA6i3vtfIse+e2WPh4wBgIkYQrW3Zj5vFje?=
 =?us-ascii?Q?CIJ2fXqzr1Z2tjBYJgrL/t/FvFcRplmCovhzvDT5SPMp5iU9yOTSZv5dVVCn?=
 =?us-ascii?Q?oEOpY7N/32yTlAPHVis12Rpyv2di+A8wzdfH2w7XLFpLzQaEc6nzPRbYF8hN?=
 =?us-ascii?Q?6d8dZV42Q4HTyHezNiD7QhkTp3y2M8HPv6dJ/HZiltywe5LfZs3dixYUUCvM?=
 =?us-ascii?Q?dST61puQg60PgKcdWMaB2A6hKJSqh4D26agqmBoi2eTVTV2JsVYm1LZu2/sy?=
 =?us-ascii?Q?QSda0w1832p8JKddx8711/tc2NUdmkCY4FwZqnQDE7iM99YELa4Mrr4CHBZL?=
 =?us-ascii?Q?JIj5Uc2fqUz6Y2QRo7+zrky6QOL9Fbs1jVOrjlyBmGFnYozKpotPfnq1OcDY?=
 =?us-ascii?Q?N8no75kgWRZL7CAKH0KIc1WoUlwuh6pL58AgXka1w0sArW3lyBzsKasJmEJ7?=
 =?us-ascii?Q?4nLrQPKxOcN5riEjsz0YHjwGEnxcBzhhyNKwJ6Kayh9sWmTwJFSmk3gsbIIz?=
 =?us-ascii?Q?oS6jKl1CTz58bPcO7523B1yc0Z+Y95Icr7ZIUfMVxamVABqPiGywadnuM+wr?=
 =?us-ascii?Q?0A/RLywiU/pQOlhTxz8L+poQeuweffp72oxC7kgJUcBBUBDhTA4YThGAuP7y?=
 =?us-ascii?Q?z1dRU+dv+CMF4ZaJ1t2ZfbtqYI+pgxSEtaXJwyFWF6gsIcXpnk6Z5Jikls3o?=
 =?us-ascii?Q?mUH9kxaeWWRSxp+ISOihTWzXWCF+0ctzrspcuROMWrDcmLfchKfnouSKyBzN?=
 =?us-ascii?Q?+JcmoRY7LMBpiavM6p9Xz5in7qjvSB/6YgWwWHXvYgYWld4X86Yne9hqfUW3?=
 =?us-ascii?Q?yUE2FQnSa6KoP59MB+wq1hRqsNvyuSM1KuL5fs0RULqOt3zl20sV0jspaex5?=
 =?us-ascii?Q?+uvqyzXnRKYLKrU2cyoIZ9pAmKWX3A1qfmTEC08bSPMrZqNi1WCuVmMMptN0?=
 =?us-ascii?Q?pewQqKEejmG+Oz4zy/OQK8uG6D3i94I+650Yl+JW846aryHBTOljkmEuPaGJ?=
 =?us-ascii?Q?i8jQLJFkU89fKJ2zIkBmseoiPvN7VHccV5QUroolMv8anODzqg9tIWhY9qmK?=
 =?us-ascii?Q?PQxxI54kRHCVn5+D+6tRsNWvi3yrf2AklT7beDvKfx0QPyal3DOmA79OfTcR?=
 =?us-ascii?Q?zpxa7PEevQnjdckua4rsjc7VgT3BqwWcfRPjS6gzAWVDVSanslEoTxTBvIjM?=
 =?us-ascii?Q?iv74vVrsP1WRn8VCMETZOQqcBcMRnznNvob8OV/C?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531b744b-15c6-4689-399c-08db8209792c
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5706.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:22:20.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKcR96+Epue44D6LydgE6Oov+XscaK8lPc+FEYW3gxhYTm7AzJgwvcCdPYVLvDfxcyJRiNlhvqZi4qR/8auDKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add ftrace support for exFAT file system,
and add some tracepoints:
exfat_read_folio(), exfat_writepages(), exfat_write_begin(),
exfat_write_end(), exfat_lookup_start(), exfat_lookup_end()

exfat_read_folio():
shows the dev number, inode and the folio index.

exfat_writepages():
shows the inode and fields in struct writeback_control.

exfat_write_begin():
shows the inode, file position offset and length.

exfat_write_end():
shows the inode, file position offset, bytes write to page
and bytes copied from user.

exfat_lookup_start():
shows the target inode, dentry and flags.

exfat_lookup_end():
shows the target inode, dentry and err code.

Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>
---
v2:
- Keep the dereferencing logic out of the code path,
  only happens in the trace event functions.

Thanks for Steve's advice.

 MAINTAINERS                  |   1 +
 fs/exfat/inode.c             |   9 ++
 fs/exfat/namei.c             |  10 +-
 include/trace/events/exfat.h | 190 +++++++++++++++++++++++++++++++++++
 4 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/exfat.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f115c355a41..fbe1caa61a38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7752,6 +7752,7 @@ L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 F:	fs/exfat/
+F:	include/trace/events/exfat.h
 
 EXT2 FILE SYSTEM
 M:	Jan Kara <jack@suse.com>
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 481dd338f2b8..81fe715baab0 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -17,6 +17,9 @@
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/exfat.h>
+
 int __exfat_write_inode(struct inode *inode, int sync)
 {
 	unsigned long long on_disk_size;
@@ -335,6 +338,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 
 static int exfat_read_folio(struct file *file, struct folio *folio)
 {
+	trace_exfat_read_folio(folio);
 	return mpage_read_folio(folio, exfat_get_block);
 }
 
@@ -346,6 +350,7 @@ static void exfat_readahead(struct readahead_control *rac)
 static int exfat_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
+	trace_exfat_writepages(mapping, wbc);
 	return mpage_writepages(mapping, wbc, exfat_get_block);
 }
 
@@ -371,6 +376,8 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
 			       exfat_get_block,
 			       &EXFAT_I(mapping->host)->i_size_ondisk);
 
+	trace_exfat_write_begin(mapping, pos, len);
+
 	if (ret < 0)
 		exfat_write_failed(mapping, pos+len);
 
@@ -394,6 +401,8 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
 		return -EIO;
 	}
 
+	trace_exfat_write_end(inode, pos, len, copied);
+
 	if (err < len)
 		exfat_write_failed(mapping, pos+len);
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e0ff9d156f6f..f4f36de4ca0d 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -12,6 +12,8 @@
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
+#include <trace/events/exfat.h>
+
 static inline unsigned long exfat_d_version(struct dentry *dentry)
 {
 	return (unsigned long) dentry->d_fsdata;
@@ -707,6 +709,8 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 	loff_t i_pos;
 	mode_t i_mode;
 
+	trace_exfat_lookup_start(dir, dentry, flags);
+
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 	err = exfat_find(dir, &dentry->d_name, &info);
 	if (err) {
@@ -766,7 +770,11 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 	if (!inode)
 		exfat_d_version_set(dentry, inode_query_iversion(dir));
 
-	return d_splice_alias(inode, dentry);
+	alias = d_splice_alias(inode, dentry);
+	trace_exfat_lookup_end(dir, !IS_ERR_OR_NULL(alias) ? alias : dentry,
+			IS_ERR(alias) ? PTR_ERR(alias) : err);
+
+	return alias;
 unlock:
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
 	return ERR_PTR(err);
diff --git a/include/trace/events/exfat.h b/include/trace/events/exfat.h
new file mode 100644
index 000000000000..782dae6e2e42
--- /dev/null
+++ b/include/trace/events/exfat.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM exfat
+
+#if !defined(_TRACE_EXFAT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_EXFAT_H
+
+#include <linux/tracepoint.h>
+
+#define EXFAT_I(inode)	(container_of(inode, struct exfat_inode_info, vfs_inode))
+
+
+TRACE_EVENT(exfat_write_begin,
+	TP_PROTO(struct address_space *mapping, loff_t pos, unsigned int len),
+
+	TP_ARGS(mapping, pos, len),
+
+	TP_STRUCT__entry(
+		__field(dev_t,        dev)
+		__field(ino_t,        ino)
+		__field(loff_t,       pos)
+		__field(unsigned int, len)
+	),
+
+	TP_fast_assign(
+		__entry->dev    = mapping->host->i_sb->s_dev;
+		__entry->ino    = mapping->host->i_ino;
+		__entry->pos    = pos;
+		__entry->len    = len;
+	),
+
+	TP_printk("dev (%d,%d) ino %lu pos %lld len %u",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		(unsigned long) __entry->ino,
+		__entry->pos, __entry->len)
+
+);
+
+TRACE_EVENT(exfat_write_end,
+	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len,
+			unsigned int copied),
+
+	TP_ARGS(inode, pos, len, copied),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t,	pos)
+		__field(unsigned int, len)
+		__field(unsigned int, copied)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->pos	= pos;
+		__entry->len	= len;
+		__entry->copied	= copied;
+	),
+
+	TP_printk("dev (%d,%d) ino %lu pos %lld len %u copied %u",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		(unsigned long) __entry->ino,
+		__entry->pos, __entry->len, __entry->copied)
+);
+
+TRACE_EVENT(exfat_read_folio,
+	TP_PROTO(struct folio *folio),
+
+	TP_ARGS(folio),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(pgoff_t, index)
+
+	),
+
+	TP_fast_assign(
+		__entry->dev	= folio->mapping->host->i_sb->s_dev;
+		__entry->ino	= folio->mapping->host->i_ino;
+		__entry->index	= folio->index;
+	),
+
+	TP_printk("dev (%d,%d) ino %lu folio_index %lu",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		(unsigned long) __entry->ino,
+		(unsigned long) __entry->index)
+);
+
+TRACE_EVENT(exfat_writepages,
+	TP_PROTO(struct address_space *mapping, struct writeback_control *wbc),
+
+	TP_ARGS(mapping, wbc),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(long,	nr_to_write)
+		__field(long,	pages_skipped)
+		__field(loff_t,		range_start)
+		__field(loff_t,		range_end)
+		__field(pgoff_t,	writeback_index)
+		__field(int,	sync_mode)
+		__field(char,	for_kupdate)
+		__field(char,	range_cyclic)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= mapping->host->i_sb->s_dev;
+		__entry->ino		= mapping->host->i_ino;
+		__entry->nr_to_write	= wbc->nr_to_write;
+		__entry->pages_skipped	= wbc->pages_skipped;
+		__entry->range_start	= wbc->range_start;
+		__entry->range_end	= wbc->range_end;
+		__entry->writeback_index = mapping->host->i_mapping->writeback_index;
+		__entry->sync_mode	= wbc->sync_mode;
+		__entry->for_kupdate	= wbc->for_kupdate;
+		__entry->range_cyclic	= wbc->range_cyclic;
+	),
+
+	TP_printk("dev (%d,%d) ino %lu nr_to_write %ld pages_skipped %ld "
+		"range_start %lld range_end %lld sync_mode %d "
+		"for_kupdate %d range_cyclic %d writeback_index %lu",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		(unsigned long) __entry->ino, __entry->nr_to_write,
+		__entry->pages_skipped, __entry->range_start,
+		__entry->range_end, __entry->sync_mode,
+		__entry->for_kupdate, __entry->range_cyclic,
+		(unsigned long) __entry->writeback_index)
+);
+
+TRACE_EVENT(exfat_lookup_start,
+
+	TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
+
+	TP_ARGS(dir, dentry, flags),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__string(name,	dentry->d_name.name)
+		__field(unsigned int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= dir->i_sb->s_dev;
+		__entry->ino	= dir->i_ino;
+		__assign_str(name, dentry->d_name.name);
+		__entry->flags	= flags;
+	),
+
+	TP_printk("dev = (%d,%d), pino = %lu, name:%s, flags:%u",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		(unsigned long)__entry->ino,
+		__get_str(name),
+		__entry->flags)
+);
+
+TRACE_EVENT(exfat_lookup_end,
+
+	TP_PROTO(struct inode *dir, struct dentry *dentry, int err),
+
+	TP_ARGS(dir, dentry, err),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__string(name,	dentry->d_name.name)
+		__field(int,	err)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= dir->i_sb->s_dev;
+		__entry->ino	= dir->i_ino;
+		__assign_str(name, dentry->d_name.name);
+		__entry->err	= err;
+	),
+
+	TP_printk("dev = (%d,%d), pino = %lu, name:%s, err:%d",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		(unsigned long)__entry->ino,
+		__get_str(name),
+		__entry->err)
+);
+
+#endif /* _TRACE_EXFAT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.35.3

