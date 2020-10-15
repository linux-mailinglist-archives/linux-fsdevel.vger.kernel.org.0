Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74EC28E97F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 02:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbgJOAb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 20:31:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgJOAb3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 20:31:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F0U0vj056610;
        Thu, 15 Oct 2020 00:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rgzakw6Kfk9akyvsSG3kcBBgBwnxeVj9VjaCBl4MSRo=;
 b=TZYAVcmx7F//dYLw1qiIfhnJ8ZyeHGu5TX2dU6U6tVNyh4+m+xlaCzuU9Pz4x1uhKH4k
 3OjKzB26wRiIwtfBhv1UL95UbPPIPRc8IMp4RslpV9YmfRu1ENXVe8ucmBwzqD6WNexa
 FSsoXDT1p3neTqoYVoStq+LcqysvlA6+YWqdzKc6LsRDEWFEOKo+YB1oQUYyfWX6lK9o
 uagnXaA/mPUTRyTNbkwY7RUdFhjfjs1q5IarBGIzvZvofjl1dLoxECiAJ1r7Siyc7yMJ
 i3HVmDH7G3gKY+pSCdBhbSSv8mw5wMO1V+UY8Xl6QvUA4K7+CQJVV//3hPnCOv7/NPp4 iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 343vaegms1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 00:31:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F0Tajk159088;
        Thu, 15 Oct 2020 00:31:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 344by4dpth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 00:31:23 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09F0VMFq007707;
        Thu, 15 Oct 2020 00:31:22 GMT
Received: from localhost (/10.159.142.84)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 17:31:22 -0700
Subject: [PATCH 1/2] vfs: move generic_remap_checks out of mm
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 14 Oct 2020 17:31:21 -0700
Message-ID: <160272188127.913987.8729718777463390497.stgit@magnolia>
In-Reply-To: <160272187483.913987.4254237066433242737.stgit@magnolia>
References: <160272187483.913987.4254237066433242737.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

I would like to move all the generic helpers for the vfs remap range
functionality (aka clonerange and dedupe) into a separate file so that
they won't be scattered across the vfs and the mm subsystems.  The
eventual goal is to be able to deselect remap_range.c if none of the
filesystems need that code, but the tricky part here is picking a
stable(ish) part of the merge window to rearrange code.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/Makefile        |    3 +-
 fs/remap_range.c   |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    2 +
 mm/filemap.c       |   81 +----------------------------------------
 4 files changed, 108 insertions(+), 81 deletions(-)
 create mode 100644 fs/remap_range.c


diff --git a/fs/Makefile b/fs/Makefile
index 1c7b0e3f6daa..7173350739c5 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -13,7 +13,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
-		fs_types.o fs_context.o fs_parser.o fsopen.o init.o
+		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
+		remap_range.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/remap_range.c b/fs/remap_range.c
new file mode 100644
index 000000000000..e66d8c131b69
--- /dev/null
+++ b/fs/remap_range.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * linux/fs/remap_range.c
+ *
+ * Copyright (C) 1994-1999  Linus Torvalds
+ */
+
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/sched/xacct.h>
+#include <linux/fcntl.h>
+#include <linux/file.h>
+#include <linux/uio.h>
+#include <linux/fsnotify.h>
+#include <linux/security.h>
+#include <linux/export.h>
+#include <linux/syscalls.h>
+#include <linux/pagemap.h>
+#include <linux/splice.h>
+#include <linux/compat.h>
+#include <linux/mount.h>
+#include <linux/fs.h>
+#include "internal.h"
+
+#include <linux/uaccess.h>
+#include <asm/unistd.h>
+
+/*
+ * Performs necessary checks before doing a clone.
+ *
+ * Can adjust amount of bytes to clone via @req_count argument.
+ * Returns appropriate error code that caller should return or
+ * zero in case the clone should be allowed.
+ */
+int generic_remap_checks(struct file *file_in, loff_t pos_in,
+			 struct file *file_out, loff_t pos_out,
+			 loff_t *req_count, unsigned int remap_flags)
+{
+	struct inode *inode_in = file_in->f_mapping->host;
+	struct inode *inode_out = file_out->f_mapping->host;
+	uint64_t count = *req_count;
+	uint64_t bcount;
+	loff_t size_in, size_out;
+	loff_t bs = inode_out->i_sb->s_blocksize;
+	int ret;
+
+	/* The start of both ranges must be aligned to an fs block. */
+	if (!IS_ALIGNED(pos_in, bs) || !IS_ALIGNED(pos_out, bs))
+		return -EINVAL;
+
+	/* Ensure offsets don't wrap. */
+	if (pos_in + count < pos_in || pos_out + count < pos_out)
+		return -EINVAL;
+
+	size_in = i_size_read(inode_in);
+	size_out = i_size_read(inode_out);
+
+	/* Dedupe requires both ranges to be within EOF. */
+	if ((remap_flags & REMAP_FILE_DEDUP) &&
+	    (pos_in >= size_in || pos_in + count > size_in ||
+	     pos_out >= size_out || pos_out + count > size_out))
+		return -EINVAL;
+
+	/* Ensure the infile range is within the infile. */
+	if (pos_in >= size_in)
+		return -EINVAL;
+	count = min(count, size_in - (uint64_t)pos_in);
+
+	ret = generic_write_check_limits(file_out, pos_out, &count);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the user wanted us to link to the infile's EOF, round up to the
+	 * next block boundary for this check.
+	 *
+	 * Otherwise, make sure the count is also block-aligned, having
+	 * already confirmed the starting offsets' block alignment.
+	 */
+	if (pos_in + count == size_in) {
+		bcount = ALIGN(size_in, bs) - pos_in;
+	} else {
+		if (!IS_ALIGNED(count, bs))
+			count = ALIGN_DOWN(count, bs);
+		bcount = count;
+	}
+
+	/* Don't allow overlapped cloning within the same file. */
+	if (inode_in == inode_out &&
+	    pos_out + bcount > pos_in &&
+	    pos_out < pos_in + bcount)
+		return -EINVAL;
+
+	/*
+	 * We shortened the request but the caller can't deal with that, so
+	 * bounce the request back to userspace.
+	 */
+	if (*req_count != count && !(remap_flags & REMAP_FILE_CAN_SHORTEN))
+		return -EINVAL;
+
+	*req_count = count;
+	return 0;
+}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a08..eea754a8dd67 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3012,6 +3012,8 @@ extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
 extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				loff_t *count, unsigned int remap_flags);
+extern int generic_write_check_limits(struct file *file, loff_t pos,
+		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
 extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
diff --git a/mm/filemap.c b/mm/filemap.c
index 99c49eeae71b..cf20e5aeb11b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3098,8 +3098,7 @@ EXPORT_SYMBOL(read_cache_page_gfp);
  * LFS limits.  If pos is under the limit it becomes a short access.  If it
  * exceeds the limit we return -EFBIG.
  */
-static int generic_write_check_limits(struct file *file, loff_t pos,
-				      loff_t *count)
+int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 {
 	struct inode *inode = file->f_mapping->host;
 	loff_t max_size = inode->i_sb->s_maxbytes;
@@ -3161,84 +3160,6 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_write_checks);
 
-/*
- * Performs necessary checks before doing a clone.
- *
- * Can adjust amount of bytes to clone via @req_count argument.
- * Returns appropriate error code that caller should return or
- * zero in case the clone should be allowed.
- */
-int generic_remap_checks(struct file *file_in, loff_t pos_in,
-			 struct file *file_out, loff_t pos_out,
-			 loff_t *req_count, unsigned int remap_flags)
-{
-	struct inode *inode_in = file_in->f_mapping->host;
-	struct inode *inode_out = file_out->f_mapping->host;
-	uint64_t count = *req_count;
-	uint64_t bcount;
-	loff_t size_in, size_out;
-	loff_t bs = inode_out->i_sb->s_blocksize;
-	int ret;
-
-	/* The start of both ranges must be aligned to an fs block. */
-	if (!IS_ALIGNED(pos_in, bs) || !IS_ALIGNED(pos_out, bs))
-		return -EINVAL;
-
-	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
-		return -EINVAL;
-
-	size_in = i_size_read(inode_in);
-	size_out = i_size_read(inode_out);
-
-	/* Dedupe requires both ranges to be within EOF. */
-	if ((remap_flags & REMAP_FILE_DEDUP) &&
-	    (pos_in >= size_in || pos_in + count > size_in ||
-	     pos_out >= size_out || pos_out + count > size_out))
-		return -EINVAL;
-
-	/* Ensure the infile range is within the infile. */
-	if (pos_in >= size_in)
-		return -EINVAL;
-	count = min(count, size_in - (uint64_t)pos_in);
-
-	ret = generic_write_check_limits(file_out, pos_out, &count);
-	if (ret)
-		return ret;
-
-	/*
-	 * If the user wanted us to link to the infile's EOF, round up to the
-	 * next block boundary for this check.
-	 *
-	 * Otherwise, make sure the count is also block-aligned, having
-	 * already confirmed the starting offsets' block alignment.
-	 */
-	if (pos_in + count == size_in) {
-		bcount = ALIGN(size_in, bs) - pos_in;
-	} else {
-		if (!IS_ALIGNED(count, bs))
-			count = ALIGN_DOWN(count, bs);
-		bcount = count;
-	}
-
-	/* Don't allow overlapped cloning within the same file. */
-	if (inode_in == inode_out &&
-	    pos_out + bcount > pos_in &&
-	    pos_out < pos_in + bcount)
-		return -EINVAL;
-
-	/*
-	 * We shortened the request but the caller can't deal with that, so
-	 * bounce the request back to userspace.
-	 */
-	if (*req_count != count && !(remap_flags & REMAP_FILE_CAN_SHORTEN))
-		return -EINVAL;
-
-	*req_count = count;
-	return 0;
-}
-
-
 /*
  * Performs common checks before doing a file copy/clone
  * from @file_in to @file_out.

