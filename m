Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710F55C1A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfGARDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:03:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59562 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbfGARDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:03:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnYd8089965;
        Mon, 1 Jul 2019 17:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uzjyhLM5dT8Ql7hJijVz5rZFms6QfvRqeQOhu5jX4MY=;
 b=3MW4O/9eBXTpPdqIoO9c9fV9nHHDxDgEN34LSEiRdVEIr5BAQyf+2v4qNCZgPT7LaYDX
 lwYyrTIU2n4nAfLeQ3tCfdmZLLFczx8iLWxeJT/+sA8ecTosu46rbg9dsLUuTvxr/MYJ
 aNy/1IFOAEYV8RdkiQBGxbKD7IYwOdUCHsHioXwr+NgaT7nRkTqxthl3aJQ3TJ1vJ7fe
 Ip1fmXeE2aQJeEjJ6rrqlEyJxbGRyzm82Kpyi2cpE/V/PwH7brr6MOFxDEWYzpqC3ppz
 EPROHw4qa110qDh7krlgFg6lgRv3botMWLuXLwV6tZImAwyBsPciSGidz7rhQqSJDvYt 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbevm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:03:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmMFG154232;
        Mon, 1 Jul 2019 17:03:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tebqg1h69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:03:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x61H30lB032520;
        Mon, 1 Jul 2019 17:03:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:03:00 -0700
Subject: [PATCH 09/11] iomap: move the page migration code into a separate
 file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:02:59 -0700
Message-ID: <156200057959.1790352.8764969968089533689.stgit@magnolia>
In-Reply-To: <156200051933.1790352.5147420943973755350.stgit@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010201
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
 fs/iomap/migrate.c |   40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 29 deletions(-)
 create mode 100644 fs/iomap/migrate.c


diff --git a/fs/iomap.c b/fs/iomap.c
index b946418cb8b4..885e2021b4d0 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -96,32 +96,3 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 {
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
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
index 754eea00ac79..c88888795e12 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -16,4 +16,5 @@ iomap-y				+= \
 					seek.o \
 					write.o
 
+iomap-$(CONFIG_MIGRATION)	+= migrate.o
 iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/migrate.c b/fs/iomap/migrate.c
new file mode 100644
index 000000000000..5fd58a868c80
--- /dev/null
+++ b/fs/iomap/migrate.c
@@ -0,0 +1,40 @@
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
+#include "iomap_internal.h"
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

