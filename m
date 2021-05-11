Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347A5379D78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 05:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhEKDLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 23:11:33 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41077 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230198AbhEKDL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 23:11:28 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AjPfbyK8Qk534sxVhmvRuk+A+I+orL9Y04lQ7?=
 =?us-ascii?q?vn2YSXRuE/Bw8Pre5cjztCWE8Ar5N0tQ+uxoVJPufZqYz+8Q3WBzB8bFYOCFgh?=
 =?us-ascii?q?rLEGgK1+KLqFeMdxEWtNQtspuIGJIfNDSfNzZHZL7BkWyF+sgbsaW62ZHtleHD?=
 =?us-ascii?q?1G1sUA0vT6lh6j1yAgGdHlYefng9ObMJUIqb+tFcpyetPVAebsGADHEDWOTZ4/?=
 =?us-ascii?q?LRkpaOW296OzcXrBmJkSiz6KP3VzyR3hIlWTtJxrs4tUjp+jaJnZmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,290,1613404800"; 
   d="scan'208";a="108110563"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2021 11:10:17 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 7EDEB4D0BA79;
        Tue, 11 May 2021 11:10:12 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 11 May 2021 11:10:02 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 11 May 2021 11:10:00 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <viro@zeniv.linux.org.uk>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v5 4/7] iomap: Introduce iomap_apply2() for operations on two files
Date:   Tue, 11 May 2021 11:09:30 +0800
Message-ID: <20210511030933.3080921-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7EDEB4D0BA79.A4007
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some operations, such as comparing a range of data in two files under
fsdax mode, requires nested iomap_open()/iomap_end() on two file.  Thus,
we introduce iomap_apply2() to accept arguments from two files and
iomap_actor2_t for actions on two files.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/apply.c      | 52 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iomap.h |  7 +++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 26ab6563181f..0493da5286ad 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -97,3 +97,55 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 
 	return written ? written : ret;
 }
+
+loff_t
+iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2, loff_t pos2,
+		loff_t length, unsigned int flags, const struct iomap_ops *ops,
+		void *data, iomap_actor2_t actor)
+{
+	struct iomap smap = { .type = IOMAP_HOLE };
+	struct iomap dmap = { .type = IOMAP_HOLE };
+	loff_t written = 0, ret, ret2 = 0;
+	loff_t len1 = length, len2, min_len;
+
+	ret = ops->iomap_begin(ino1, pos1, len1, flags, &smap, NULL);
+	if (ret)
+		goto out;
+	if (WARN_ON(smap.offset > pos1)) {
+		written = -EIO;
+		goto out_src;
+	}
+	if (WARN_ON(smap.length == 0)) {
+		written = -EIO;
+		goto out_src;
+	}
+	len2 = min_t(loff_t, len1, smap.length);
+
+	ret = ops->iomap_begin(ino2, pos2, len2, flags, &dmap, NULL);
+	if (ret)
+		goto out_src;
+	if (WARN_ON(dmap.offset > pos2)) {
+		written = -EIO;
+		goto out_dest;
+	}
+	if (WARN_ON(dmap.length == 0)) {
+		written = -EIO;
+		goto out_dest;
+	}
+	min_len = min_t(loff_t, len2, dmap.length);
+
+	written = actor(ino1, pos1, ino2, pos2, min_len, data, &smap, &dmap);
+
+out_dest:
+	if (ops->iomap_end)
+		ret2 = ops->iomap_end(ino2, pos2, len2,
+				      written > 0 ? written : 0, flags, &dmap);
+out_src:
+	if (ops->iomap_end)
+		ret = ops->iomap_end(ino1, pos1, len1,
+				     written > 0 ? written : 0, flags, &smap);
+out:
+	if (written)
+		return written;
+	return ret ?: ret2;
+}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c87d0cb0de6d..95562f863ad0 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -150,10 +150,15 @@ struct iomap_ops {
  */
 typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
 		void *data, struct iomap *iomap, struct iomap *srcmap);
-
+typedef loff_t (*iomap_actor2_t)(struct inode *ino1, loff_t pos1,
+		struct inode *ino2, loff_t pos2, loff_t len, void *data,
+		struct iomap *smap, struct iomap *dmap);
 loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 		unsigned flags, const struct iomap_ops *ops, void *data,
 		iomap_actor_t actor);
+loff_t iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2,
+		loff_t pos2, loff_t length, unsigned int flags,
+		const struct iomap_ops *ops, void *data, iomap_actor2_t actor);
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
-- 
2.31.1



