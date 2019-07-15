Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E838669A5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 20:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfGOSAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 14:00:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbfGOSAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:00:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHxWdB149548;
        Mon, 15 Jul 2019 18:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=7+0CGB6j1eUeuIZ68X13Ka98HWgrhZ+hH7FzVP8SkjM=;
 b=StTXrpXgPeVxJGAcU5Q2zF28NkedK/qfXgJbOYQNk5qG0vx1kNgiAetUEpyGCKeah0KM
 ovgIq8p4TPeQycU/Zi7TpKydENFo7FsncWEQgahKSecTfjZoFW2c6hDP3vh+vSdq7Rx2
 RbAJOByNfyP7qqykoVtr/PE/ltqQBrgAj/3Lv+1Y9kG2gEbv1FOuKofy0kejmObos6eX
 inxLv+aiDMHXrkKfWnfiHrf3YUGdTZ3GL8xlbFAeGCjiA5rL+TeFMtaSvXbjsMb4d3LM
 eiv79YMAeP4v/Yyz0xrQlod87YpgiRqg4puleUzxWAOidRX03cV5NtjVkW/N7Xg7ZxuE BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xqr0fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 18:00:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHwbFE073955;
        Mon, 15 Jul 2019 18:00:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tq6mmdrj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 18:00:07 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6FI06Cx004895;
        Mon, 15 Jul 2019 18:00:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 11:00:06 -0700
Subject: [PATCH 7/9] iomap: move the page migration code into a separate file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        agruenba@redhat.com
Date:   Mon, 15 Jul 2019 11:00:05 -0700
Message-ID: <156321360519.148361.2779156857011152900.stgit@magnolia>
In-Reply-To: <156321356040.148361.7463881761568794395.stgit@magnolia>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150209
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150209
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Move the page migration code into a separate file so that we can group
related functions in a single file instead of having a single enormous
source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap.c         |   29 -----------------------------
 fs/iomap/Makefile  |    1 +
 fs/iomap/migrate.c |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 29 deletions(-)
 create mode 100644 fs/iomap/migrate.c


diff --git a/fs/iomap.c b/fs/iomap.c
index ab658a4b97d3..88a3144351a9 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -89,32 +89,3 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 
 	return written ? written : ret;
 }
-
-#ifdef CONFIG_MIGRATION
-int
-iomap_migrate_page(struct address_space *mapping, struct page *newpage,
-		struct page *page, enum migrate_mode mode)
-{
-	int ret;
-
-	ret = migrate_page_move_mapping(mapping, newpage, page, mode, 0);
-	if (ret != MIGRATEPAGE_SUCCESS)
-		return ret;
-
-	if (page_has_private(page)) {
-		ClearPagePrivate(page);
-		get_page(newpage);
-		set_page_private(newpage, page_private(page));
-		set_page_private(page, 0);
-		put_page(page);
-		SetPagePrivate(newpage);
-	}
-
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
-	else
-		migrate_page_states(newpage, page);
-	return MIGRATEPAGE_SUCCESS;
-}
-EXPORT_SYMBOL_GPL(iomap_migrate_page);
-#endif /* CONFIG_MIGRATION */
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index d2a81819ae01..04cbeed44248 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -14,4 +14,5 @@ iomap-y				+= \
 					fiemap.o \
 					seek.o
 
+iomap-$(CONFIG_MIGRATION)	+= migrate.o
 iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/migrate.c b/fs/iomap/migrate.c
new file mode 100644
index 000000000000..d8116d35f819
--- /dev/null
+++ b/fs/iomap/migrate.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/migrate.h>
+
+#include "internal.h"
+
+int
+iomap_migrate_page(struct address_space *mapping, struct page *newpage,
+		struct page *page, enum migrate_mode mode)
+{
+	int ret;
+
+	ret = migrate_page_move_mapping(mapping, newpage, page, mode, 0);
+	if (ret != MIGRATEPAGE_SUCCESS)
+		return ret;
+
+	if (page_has_private(page)) {
+		ClearPagePrivate(page);
+		get_page(newpage);
+		set_page_private(newpage, page_private(page));
+		set_page_private(page, 0);
+		put_page(page);
+		SetPagePrivate(newpage);
+	}
+
+	if (mode != MIGRATE_SYNC_NO_COPY)
+		migrate_page_copy(newpage, page);
+	else
+		migrate_page_states(newpage, page);
+	return MIGRATEPAGE_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(iomap_migrate_page);

