Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A33ECE57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 08:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhHPGFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 02:05:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38862 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233497AbhHPGFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:05:13 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AFwGloqpC1aVYApE6Xo4ThpkaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="112944870"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Aug 2021 14:04:35 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 767A74D0D4BF;
        Mon, 16 Aug 2021 14:04:33 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 16 Aug 2021 14:04:35 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 16 Aug 2021 14:04:31 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 16 Aug 2021 14:04:28 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>
Subject: [PATCH v7 5/8] iomap: Introduce iomap_iter2 for two files
Date:   Mon, 16 Aug 2021 14:03:56 +0800
Message-ID: <20210816060359.1442450-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 767A74D0D4BF.A1610
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some operations, such as comparing a range of data in two files under
fsdax mode, requires nested iomap_begin()/iomap_end() on two files.
Thus, we introduce iomap_iter2() to accept two iteraters to operate
action on two files.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/iomap/core.c       | 51 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iomap.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/fs/iomap/core.c b/fs/iomap/core.c
index 89a87a1654e8..214538a25110 100644
--- a/fs/iomap/core.c
+++ b/fs/iomap/core.c
@@ -77,3 +77,54 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	iomap_iter_done(iter);
 	return 1;
 }
+
+/**
+ * iomap_iter2 - iterate over a ranges in two files
+ * @iter1:  the first iteration structure
+ * @iter2: the second iteration structure
+ * @ops:   iomap ops provided by the file system
+ *
+ * Iterate two files once.
+ */
+int iomap_iter2(struct iomap_iter *iter1, struct iomap_iter *iter2,
+		const struct iomap_ops *ops)
+{
+	int ret;
+
+	if (iter2->iomap.length && ops->iomap_end) {
+		ret = ops->iomap_end(iter2->inode, iter2->pos, iomap_length(iter2),
+				iter2->processed > 0 ? iter2->processed : 0,
+				iter2->flags, &iter2->iomap);
+		if (ret < 0 && !iter2->processed)
+			return ret;
+	}
+
+	if (iter1->iomap.length && ops->iomap_end) {
+		ret = ops->iomap_end(iter1->inode, iter1->pos, iomap_length(iter1),
+				iter1->processed > 0 ? iter1->processed : 0,
+				iter1->flags, &iter1->iomap);
+		if (ret < 0 && !iter1->processed)
+			return ret;
+	}
+
+	trace_iomap_iter(iter1, ops, _RET_IP_);
+	ret = iomap_iter_advance(iter1);
+	if (ret <= 0)
+		return ret;
+	ret = iomap_iter_advance(iter2);
+	if (ret <= 0)
+		return ret;
+
+	ret = ops->iomap_begin(iter1->inode, iter1->pos, iter1->len, iter1->flags,
+			       &iter1->iomap, &iter1->srcmap);
+	if (ret < 0)
+		return ret;
+	iomap_iter_done(iter1);
+
+	ret = ops->iomap_begin(iter2->inode, iter2->pos, iter2->len, iter2->flags,
+			       &iter2->iomap, &iter2->srcmap);
+	if (ret < 0)
+		return ret;
+	iomap_iter_done(iter2);
+	return 1;
+}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 24f8489583ca..ebef060c65cd 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -186,6 +186,8 @@ struct iomap_iter {
 };
 
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
+int iomap_iter2(struct iomap_iter *iter, struct iomap_iter *iter2,
+		const struct iomap_ops *ops);
 
 /**
  * iomap_length - length of the current iomap iteration
-- 
2.32.0



