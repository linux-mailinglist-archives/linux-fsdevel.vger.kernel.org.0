Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151A23582C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhDHMFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 08:05:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24855 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231513AbhDHMFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:05:23 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AEs1dYKNTetm8FsBcTiGjsMiAIKoaSvp033AA?=
 =?us-ascii?q?0UdtRRtJNvGJjszGpoV+6TbYqhY0HEshl9eJJbWaTRrnmKJdzIENMd6ZMjXOl2?=
 =?us-ascii?q?elIYpr54mn4xCIIUfD38FH06MISclDIfnRKXQ/ssrg+gm/FL8bsby62YSln/3X?=
 =?us-ascii?q?wXsobSwCUdAC0y5DBgyWElJ7SWB9bPJXKLOn+sFFqzC8EE5nDPiTO39tZYj+ju?=
 =?us-ascii?q?yOvJfnTDpDPBQ/9TSJ5AnC1JfKVzSewTcSOgki/Ysf?=
X-IronPort-AV: E=Sophos;i="5.82,206,1613404800"; 
   d="scan'208";a="106797297"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Apr 2021 20:05:11 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 969E04D0B8A3;
        Thu,  8 Apr 2021 20:05:05 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 8 Apr 2021 20:05:00 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 8 Apr 2021 20:05:00 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <david@fromorbit.com>, <hch@lst.de>,
        <rgoldwyn@suse.de>
Subject: [PATCH v4 4/7] iomap: Introduce iomap_apply2() for operations on two files
Date:   Thu, 8 Apr 2021 20:04:29 +0800
Message-ID: <20210408120432.1063608-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 969E04D0B8A3.A1BFB
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
index d202fd2d0f91..9493c48bcc9c 100644
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
2.31.0



