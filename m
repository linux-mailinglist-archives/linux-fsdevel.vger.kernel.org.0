Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB834127D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 02:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhCSByB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 21:54:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41511 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231518AbhCSBx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:53:27 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/u3svKNKKTDE1sBcTiGjsMiAIKoaSvp033AA?=
 =?us-ascii?q?0UdtRRtJNvGJjszGpoV+6TbYqhY0HEshl9eJJbWaTRrnmKJdzIENMd6ZMjXOl2?=
 =?us-ascii?q?elIYpr54mn4xCIIUfD38FH06MISclDIfnRKXQ/ssrg+gm/FL8bsby62YSln/3X?=
 =?us-ascii?q?wXsobSwCUdAC0y5DBgyWElJ7SWB9bPJXKLOn+sFFqzC8EE5nDPiTO39tZYj+ju?=
 =?us-ascii?q?yOvJfnTDpDPBQ/9TSJ5AnC1JfKVzSewTcSOgki/Ysf?=
X-IronPort-AV: E=Sophos;i="5.81,259,1610380800"; 
   d="scan'208";a="105876706"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Mar 2021 09:53:25 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 5CE404CEB2A3;
        Fri, 19 Mar 2021 09:53:20 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 09:53:10 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 19 Mar 2021 09:53:09 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
Subject: [PATCH v3 07/10] iomap: Introduce iomap_apply2() for operations on two files
Date:   Fri, 19 Mar 2021 09:52:34 +0800
Message-ID: <20210319015237.993880-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5CE404CEB2A3.A0EF3
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
---
 fs/iomap/apply.c      | 56 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iomap.h |  7 +++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 26ab6563181f..fbc38ce3d5b6 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -97,3 +97,59 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 
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
+		goto out_src;
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
+		goto out_dest;
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
+
+	if (ret)
+		return written ? written : ret;
+
+	if (ret2)
+		return written ? written : ret2;
+
+	return written;
+}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5bd3cac4df9c..913f98897a77 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -148,10 +148,15 @@ struct iomap_ops {
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
2.30.1



