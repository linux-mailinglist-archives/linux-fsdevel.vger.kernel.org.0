Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8274D156
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 11:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGJJ0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 05:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGJJ0S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:26:18 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302DB8E;
        Mon, 10 Jul 2023 02:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZthGiu2D3GNwz73rEHqwnicC0Dr6GlQACLb6NrGbzbHWhxS3C+UApv1ArMU/1tUtSO81pbMYscmcRkbI++HDkSeTK/+EOhz6s6/TtT7/N6X/Bmgwg141unNIoXgQ0Vo5hhV/hXJdukxuvYDoTxNDOf89BmVavzQLKg10cKdY7Qs81eFXCW7xUmxwy1ktjuOqqqrXNrP1Z1/FOamOZFNtuq1LFSf298tkpHBm5fBrZJ9xCHYHJ6b/qABxolTVH2StYSr95jn/V+ftV8kQFsP3BKNbqz0c2L+yiXJsURQl9hhjDEf5YNo6+lVYJ2WG+pdcSgo9ONvh8/ud3+H9NjCUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e7KJlST6kwjUzniwF6pQzUEMnvkwN5OtQMwJKqN4H8=;
 b=XlteTDa0+1wkJpnX8T0SGcOoLxWYisZbuZABf53bQO3sCHXpL0Zq2AvHZyVFrcCBwIGkMlBIzEVVCCZKwZ2nav7USXvbbXhV7s/iSkUmvml/d9I4SmMKhxWsNv3UXJ/LmXOYHhzwzE5JbTvf3qyAKGNjTK6doS7G157OWw1mn5XsTJutIY1648kHvqENoYuoZMVj0UlHK5mOUAj0rupK6xnKtRQjnlnSGYQSDEiLhNfj/bP8x+f7Wc8CrXFWgX8B9Q+MXX531r1uN1lX88xfXGrev2RQElWch+ogGuJiNzh/BPwUzqJ1sSSd75HgdBRzBivc+UsS0ROOrN7QKyjy0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e7KJlST6kwjUzniwF6pQzUEMnvkwN5OtQMwJKqN4H8=;
 b=iFOZHBh8mRZR8GkEVU+j/G1Ut4ExFKaKWFNwZbWcpUTy3P2m/0SuC+lsErc0/k10qoEUFYGcu4fS5EU4DC+V+LDchOIYMDgtxc8eUapHj6Ok2FmllAOEeUNsIUHfknq8qFB5hEO1sd+U7UnSJQx+2ZZs76XK9GES0g1orimG6O1jCM8mV8wygstRIzdOhfB+t8yXjjFzXUSHKfUv9swf+62kLN0a42hPc79n/+IFld37x1ZwtZzVQFh6QaG0NMxTz+TIWw/FhgvpT4fBjDFo0clQsPRidCfggtjMkBZLPmkBCJInJKngJR3+pNbeOfjjbdGBBuVfDYU3S4P8X9wVOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
 by KL1PR0601MB4307.apcprd06.prod.outlook.com (2603:1096:820:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:26:10 +0000
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019]) by TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:26:10 +0000
From:   Zehao Zhang <zhangzehao@vivo.com>
To:     linkinjeon@kernel.org, sj1557.seo@samsung.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Zehao Zhang <zhangzehao@vivo.com>
Subject: [PATCH] exfat: Add ftrace support for exfat and add some tracepoints
Date:   Mon, 10 Jul 2023 17:25:59 +0800
Message-Id: <20230710092559.19087-1-zhangzehao@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5706:EE_|KL1PR0601MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: b53c05c3-fbae-49fd-e294-08db8127b203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yj8z6upYwE8AJHicl3XHXAl46UpGO/i1uzES+ehoSvhQfOUg0lGBN70d06UyyyXoP97p2+6cYMJ+QBCxPdCca01wwdKgiG8f6qUFwo6qSi/NT1dHMyT2pqomDfR7/jkX2J/JZPHb1k1+mz+wjTCnH21seZSVkZrG4/Ly2I5jbdgbtbDQazs7hd+gtjBntelxGQBoIkkWK0aZzglLuNLgOUNxKD1lCG49OkTAxtKD7Xsj6cx+esqi7RvXUQL1L/bH+oGvA5C/+x+DtbNzilK3OwZvTFQeDnsGK6Lqq3gLAuhO04I/8S9Q+K1BdTGHDsBiyQcMV0cdgYvhh2y72wmNS56OKy1nEgEMtl6HeYu0lmEDMOTI698ixmrXAXHswizF/qmr9kBSDiajm6Buyo/+gQ9yyjTX9GioP7kroJ7Bv29cAj+ZAVJa49s7jr1xj/ghn0jhCZQQG6r2AQEIWvONdCLxAvLsV7TFzRy2Lwa5mMJ0hb7jWWcvmh7th8XD7xER1L4UHBu9/07di5AFLbZ/8gI7BIpD2Fbwmtk19RBY6LqhiYO5OXC+AdsIYKnH0sn2jrI4cNEYsHsSPra2VRy+O5tQuMl0yvjAE7lP9xvPTALkA5lMzFEtMshoIMhbRp25
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5706.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(186003)(26005)(1076003)(6506007)(2616005)(6512007)(107886003)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(5660300002)(8936002)(8676002)(478600001)(66946007)(6486002)(52116002)(6666004)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?caTFFox1gT4cIa2WL9o/FyTDxkcz0w8XXEMWV1Un1Rp/7BvtkA4HkJtxxhDU?=
 =?us-ascii?Q?j1O4MRzXBUUFOVmI4BNKzKSZzlaRhYpR+3G96UF+GiAISKhGz4TLK62uwipJ?=
 =?us-ascii?Q?3lAq+Ok2c9MBHDOkJatlD7B+WKABbV7w8a7N5/AX5NdqwuqL8oiImyoCPaZA?=
 =?us-ascii?Q?vvYU4A9QMi6H+Wev0LFM+wSr3NYCfgeaeWeD7CLGBf8GJS108OGdrLW3Omel?=
 =?us-ascii?Q?/vepsD5OiobOxfKvp7NxGDu9SMOZG2Pg9NDEOJQbP81FbN14D5se7/dKeYe2?=
 =?us-ascii?Q?IegKpEHdZ3xFGR3jjHKyZa+J7p0p0W+MrtfkX2vFyRee0ZDhqNZXLHT41fSI?=
 =?us-ascii?Q?ceegN/nnCOHDWuBgiWAE1XVs4VzGClMExqmIndMtMse0v25F31qNaUGr5b2I?=
 =?us-ascii?Q?T7eRghMlCDfmWwIPx6QuL+6Hbb/S8mN4wdu2OKC/iuLNxZvUNlhTXocWqJhJ?=
 =?us-ascii?Q?1tc4swkyLwVItP/GJmeDEgWqgdqYnk4Hf7wpAY0YGXR7xjtDeTQ03gSIGDBc?=
 =?us-ascii?Q?CzdXgbMa9zwea8yC9qRHx6dPQD1JTg0JenEUhuTrsqz1J7nbm4cP6+9JlVun?=
 =?us-ascii?Q?H7QzdhJUoUtjYtl6ONeWlMP5y1HFHVxgJFb6ZsXG+jQWzlhzDeF/fpcJlEYK?=
 =?us-ascii?Q?ziFoYJWDFa7geNlQj/oHmq2yS0sEJCkkNsBFJ4kNmr7O+ha/BF17TR/qt0hw?=
 =?us-ascii?Q?EQw+NJGEPX0n6zsQlAbySa3VaQA3QEUObAcoOL/9cLP+ONTvucPdIyzqkO0T?=
 =?us-ascii?Q?OrLLB93jI5PVtdskphVNbD1IaMfm88FFnKR/fHPuHc7uPbRH5ZXci38nomri?=
 =?us-ascii?Q?TD8RAobMOVOeX0aY846TJ9BOqGacPWJT9iU5A9i3df0DK44jiiEcn/6rHhmo?=
 =?us-ascii?Q?OdC/SdlPJxcv6WYzS1cNk03SsZpD5lMZarTcF5tYFLcMVGWhHOH2iZ/BjLUY?=
 =?us-ascii?Q?8ahc7revBL8r0KEKC/rMmLwzs/g5Uv4hAfh0qoZ+UcG3+l7/va03UgT0jRQK?=
 =?us-ascii?Q?RNPQHFyytmq4eKGBySUNfsGjYUjZPmrEib7nL0wjtvBrtfGHb0LiWNYKBi2g?=
 =?us-ascii?Q?aJJ2p+CUJ0FXfM4UvehV0x4KpWIBtKAVEIqgqqv6kNkgvObhEFz6DBv/lf0F?=
 =?us-ascii?Q?WJc+57aLZzmmjBNpLhe31WeHtNVp+6hLhZMLVt53C6TSMJFP6taS5FzJh3NE?=
 =?us-ascii?Q?lz2pbnXxWLM0jVisljSkWfpP1B4ER5beufioW+ymylFZ0NDFdkFeeGfXo7J3?=
 =?us-ascii?Q?Qq7kvf2Rk9bXAh1ncbAEx4xj8ccVH48N3H3aJSzz7kXF8GWxlMwAwUVD8I8z?=
 =?us-ascii?Q?gkvrrCGg9FYdL5XUC/VWPVVISoxem+mkt8w7QMYXChLETxKxeHWDRNBKcYM7?=
 =?us-ascii?Q?44S+xvWBkISEZBFN1rgCZfgUEkH1/mfAurNYf4NNfLo9P6lyF+K3S4R6hhgL?=
 =?us-ascii?Q?MzH9xTeBAM/VHX3dZGK6OtCfqumk6agcege2F7KABnhIQpT87slZoPL8XW9G?=
 =?us-ascii?Q?W0mREIOsTaIpbD/XdSfR5S2b797WI9UwqsZVeomZnnUHkywapvHDHVVwNxsL?=
 =?us-ascii?Q?YOdpZ6KUNSRs1PS6Fr/6t/66xjegQegh44QSZbK3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53c05c3-fbae-49fd-e294-08db8127b203
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5706.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:26:09.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 942R+fuBD7tISFsnJ30kzxLT3h+tmPAUV9IltBjrWUBIAnGzj7p2GUtLkqfdAO8lLXF1P9yIPFp2+9w2E2q7og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4307
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 MAINTAINERS                  |   1 +
 fs/exfat/inode.c             |  16 +++
 fs/exfat/namei.c             |  10 +-
 include/trace/events/exfat.h | 192 +++++++++++++++++++++++++++++++++++
 4 files changed, 218 insertions(+), 1 deletion(-)
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
index 481dd338f2b8..48fec3fa10af 100644
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
@@ -335,6 +338,10 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 
 static int exfat_read_folio(struct file *file, struct folio *folio)
 {
+	struct inode *inode = folio->mapping->host;
+
+	trace_exfat_read_folio(inode, folio);
+
 	return mpage_read_folio(folio, exfat_get_block);
 }
 
@@ -346,6 +353,10 @@ static void exfat_readahead(struct readahead_control *rac)
 static int exfat_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
+	struct inode *inode = mapping->host;
+
+	trace_exfat_writepages(inode, wbc);
+
 	return mpage_writepages(mapping, wbc, exfat_get_block);
 }
 
@@ -364,6 +375,7 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned int len,
 		struct page **pagep, void **fsdata)
 {
+	struct inode *inode = mapping->host;
 	int ret;
 
 	*pagep = NULL;
@@ -371,6 +383,8 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
 			       exfat_get_block,
 			       &EXFAT_I(mapping->host)->i_size_ondisk);
 
+	trace_exfat_write_begin(inode, pos, len);
+
 	if (ret < 0)
 		exfat_write_failed(mapping, pos+len);
 
@@ -394,6 +408,8 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
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
index 000000000000..67ac91c75cc6
--- /dev/null
+++ b/include/trace/events/exfat.h
@@ -0,0 +1,192 @@
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
+#define show_dev(dev)		(MAJOR(dev), MINOR(dev))
+#define show_dev_ino(entry)	(show_dev(entry->dev), (unsigned long)entry->ino)
+
+
+TRACE_EVENT(exfat_write_begin,
+	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len),
+
+	TP_ARGS(inode, pos, len),
+
+	TP_STRUCT__entry(
+		__field(dev_t,        dev)
+		__field(ino_t,        ino)
+		__field(loff_t,       pos)
+		__field(unsigned int, len)
+	),
+
+	TP_fast_assign(
+		__entry->dev    = inode->i_sb->s_dev;
+		__entry->ino    = inode->i_ino;
+		__entry->pos    = pos;
+		__entry->len    = len;
+	),
+
+	TP_printk("dev (%d,%d) ino %lu pos %lld len %u",
+		show_dev(__entry->dev),
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
+		show_dev(__entry->dev),
+		(unsigned long) __entry->ino,
+		__entry->pos, __entry->len, __entry->copied)
+);
+
+TRACE_EVENT(exfat_read_folio,
+	TP_PROTO(struct inode *inode, struct folio *folio),
+
+	TP_ARGS(inode, folio),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(pgoff_t, index)
+
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->index	= folio->index;
+	),
+
+	TP_printk("dev (%d,%d) ino %lu folio_index %lu",
+		show_dev(__entry->dev),
+		(unsigned long) __entry->ino,
+		(unsigned long) __entry->index)
+);
+
+TRACE_EVENT(exfat_writepages,
+	TP_PROTO(struct inode *inode, struct writeback_control *wbc),
+
+	TP_ARGS(inode, wbc),
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
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->nr_to_write	= wbc->nr_to_write;
+		__entry->pages_skipped	= wbc->pages_skipped;
+		__entry->range_start	= wbc->range_start;
+		__entry->range_end	= wbc->range_end;
+		__entry->writeback_index = inode->i_mapping->writeback_index;
+		__entry->sync_mode	= wbc->sync_mode;
+		__entry->for_kupdate	= wbc->for_kupdate;
+		__entry->range_cyclic	= wbc->range_cyclic;
+	),
+
+	TP_printk("dev (%d,%d) ino %lu nr_to_write %ld pages_skipped %ld "
+		"range_start %lld range_end %lld sync_mode %d "
+		"for_kupdate %d range_cyclic %d writeback_index %lu",
+		show_dev(__entry->dev),
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
+		show_dev_ino(__entry),
+		__get_str(name),
+		__entry->flags)
+);
+
+TRACE_EVENT(exfat_lookup_end,
+
+	TP_PROTO(struct inode *dir, struct dentry *dentry,
+		int err),
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
+		show_dev_ino(__entry),
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

