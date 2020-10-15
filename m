Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7269428F701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbgJOQmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 12:42:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42596 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbgJOQmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:42:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FGcsqP129752;
        Thu, 15 Oct 2020 16:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cetU3b9BgFAp9dV2WNdrjegtKFI8rDiyBLl9+mzhj4Q=;
 b=ZCSz+VKR9KX09omPuqsX/pELxQG2nXzcb8P3Wa1kzj8BzGjZ5JILoMGtne4P6hPAFCBB
 joJXaDzCwP/t6AB0INZ+RVGDRJEpwlaG5hW6ncI5nETYTe74d+uD2u7GfnuDERhsIy3R
 YKOyrrJST/s/fGUH6rGKzf/CMp0HlCdAyzSuXzZh8YRrNCVLKNOAcjkvtSimu4DL0/dW
 FbYr65eE5GwHvu9Qkp1s6160HEuJUmh1DQRmE96MTBx7yfqOfuux0f6hiWjntb8Lo4fP
 EpyWAttGxwY+lfIz44zufboLbsVbF0z4fsP9/B1vok11Yyrhtwl8Ci1FX1+flUY35bt0 tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 346g8gjwgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 16:42:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FGfL97192925;
        Thu, 15 Oct 2020 16:42:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 343pv22x2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 16:42:13 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09FGgBKw014989;
        Thu, 15 Oct 2020 16:42:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 09:42:11 -0700
Date:   Thu, 15 Oct 2020 09:42:10 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/2] vfs: move the generic write and copy checks out of mm
Message-ID: <20201015164210.GB9825@magnolia>
References: <160272187483.913987.4254237066433242737.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160272187483.913987.4254237066433242737.stgit@magnolia>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=888 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=1 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=1
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=905 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150110
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

The generic write check helpers also don't have much to do with the page
cache, so move them to the vfs.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/read_write.c    |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    3 -
 mm/filemap.c       |  143 ----------------------------------------------------
 3 files changed, 143 insertions(+), 146 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index f0877f1c0c49..016444255d3e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1701,6 +1701,59 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
 				       flags);
 }
 
+/*
+ * Performs necessary checks before doing a file copy
+ *
+ * Can adjust amount of bytes to copy via @req_count argument.
+ * Returns appropriate error code that caller should return or
+ * zero in case the copy should be allowed.
+ */
+static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    size_t *req_count, unsigned int flags)
+{
+	struct inode *inode_in = file_inode(file_in);
+	struct inode *inode_out = file_inode(file_out);
+	uint64_t count = *req_count;
+	loff_t size_in;
+	int ret;
+
+	ret = generic_file_rw_checks(file_in, file_out);
+	if (ret)
+		return ret;
+
+	/* Don't touch certain kinds of inodes */
+	if (IS_IMMUTABLE(inode_out))
+		return -EPERM;
+
+	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
+		return -ETXTBSY;
+
+	/* Ensure offsets don't wrap. */
+	if (pos_in + count < pos_in || pos_out + count < pos_out)
+		return -EOVERFLOW;
+
+	/* Shorten the copy to EOF */
+	size_in = i_size_read(inode_in);
+	if (pos_in >= size_in)
+		count = 0;
+	else
+		count = min(count, size_in - (uint64_t)pos_in);
+
+	ret = generic_write_check_limits(file_out, pos_out, &count);
+	if (ret)
+		return ret;
+
+	/* Don't allow overlapped copying within the same file. */
+	if (inode_in == inode_out &&
+	    pos_out + count > pos_in &&
+	    pos_out < pos_in + count)
+		return -EINVAL;
+
+	*req_count = count;
+	return 0;
+}
+
 /*
  * copy_file_range() differs from regular file read and write in that it
  * specifically allows return partial success.  When it does so is up to
@@ -1832,3 +1885,93 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
 out2:
 	return ret;
 }
+
+/*
+ * Don't operate on ranges the page cache doesn't support, and don't exceed the
+ * LFS limits.  If pos is under the limit it becomes a short access.  If it
+ * exceeds the limit we return -EFBIG.
+ */
+int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
+{
+	struct inode *inode = file->f_mapping->host;
+	loff_t max_size = inode->i_sb->s_maxbytes;
+	loff_t limit = rlimit(RLIMIT_FSIZE);
+
+	if (limit != RLIM_INFINITY) {
+		if (pos >= limit) {
+			send_sig(SIGXFSZ, current, 0);
+			return -EFBIG;
+		}
+		*count = min(*count, limit - pos);
+	}
+
+	if (!(file->f_flags & O_LARGEFILE))
+		max_size = MAX_NON_LFS;
+
+	if (unlikely(pos >= max_size))
+		return -EFBIG;
+
+	*count = min(*count, max_size - pos);
+
+	return 0;
+}
+
+/*
+ * Performs necessary checks before doing a write
+ *
+ * Can adjust writing position or amount of bytes to write.
+ * Returns appropriate error code that caller should return or
+ * zero in case that write should be allowed.
+ */
+ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	loff_t count;
+	int ret;
+
+	if (IS_SWAPFILE(inode))
+		return -ETXTBSY;
+
+	if (!iov_iter_count(from))
+		return 0;
+
+	/* FIXME: this is for backwards compatibility with 2.4 */
+	if (iocb->ki_flags & IOCB_APPEND)
+		iocb->ki_pos = i_size_read(inode);
+
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
+		return -EINVAL;
+
+	count = iov_iter_count(from);
+	ret = generic_write_check_limits(file, iocb->ki_pos, &count);
+	if (ret)
+		return ret;
+
+	iov_iter_truncate(from, count);
+	return iov_iter_count(from);
+}
+EXPORT_SYMBOL(generic_write_checks);
+
+/*
+ * Performs common checks before doing a file copy/clone
+ * from @file_in to @file_out.
+ */
+int generic_file_rw_checks(struct file *file_in, struct file *file_out)
+{
+	struct inode *inode_in = file_inode(file_in);
+	struct inode *inode_out = file_inode(file_out);
+
+	/* Don't copy dirs, pipes, sockets... */
+	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
+		return -EISDIR;
+	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+		return -EINVAL;
+
+	if (!(file_in->f_mode & FMODE_READ) ||
+	    !(file_out->f_mode & FMODE_WRITE) ||
+	    (file_out->f_flags & O_APPEND))
+		return -EBADF;
+
+	return 0;
+}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 073da53b59b0..8fb063ab7d50 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3012,9 +3012,6 @@ extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
-extern int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
-				    struct file *file_out, loff_t pos_out,
-				    size_t *count, unsigned int flags);
 extern ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		struct iov_iter *to, ssize_t already_read);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
diff --git a/mm/filemap.c b/mm/filemap.c
index cf20e5aeb11b..9962fd682f20 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3093,149 +3093,6 @@ struct page *read_cache_page_gfp(struct address_space *mapping,
 }
 EXPORT_SYMBOL(read_cache_page_gfp);
 
-/*
- * Don't operate on ranges the page cache doesn't support, and don't exceed the
- * LFS limits.  If pos is under the limit it becomes a short access.  If it
- * exceeds the limit we return -EFBIG.
- */
-int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
-{
-	struct inode *inode = file->f_mapping->host;
-	loff_t max_size = inode->i_sb->s_maxbytes;
-	loff_t limit = rlimit(RLIMIT_FSIZE);
-
-	if (limit != RLIM_INFINITY) {
-		if (pos >= limit) {
-			send_sig(SIGXFSZ, current, 0);
-			return -EFBIG;
-		}
-		*count = min(*count, limit - pos);
-	}
-
-	if (!(file->f_flags & O_LARGEFILE))
-		max_size = MAX_NON_LFS;
-
-	if (unlikely(pos >= max_size))
-		return -EFBIG;
-
-	*count = min(*count, max_size - pos);
-
-	return 0;
-}
-
-/*
- * Performs necessary checks before doing a write
- *
- * Can adjust writing position or amount of bytes to write.
- * Returns appropriate error code that caller should return or
- * zero in case that write should be allowed.
- */
-inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
-	loff_t count;
-	int ret;
-
-	if (IS_SWAPFILE(inode))
-		return -ETXTBSY;
-
-	if (!iov_iter_count(from))
-		return 0;
-
-	/* FIXME: this is for backwards compatibility with 2.4 */
-	if (iocb->ki_flags & IOCB_APPEND)
-		iocb->ki_pos = i_size_read(inode);
-
-	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
-		return -EINVAL;
-
-	count = iov_iter_count(from);
-	ret = generic_write_check_limits(file, iocb->ki_pos, &count);
-	if (ret)
-		return ret;
-
-	iov_iter_truncate(from, count);
-	return iov_iter_count(from);
-}
-EXPORT_SYMBOL(generic_write_checks);
-
-/*
- * Performs common checks before doing a file copy/clone
- * from @file_in to @file_out.
- */
-int generic_file_rw_checks(struct file *file_in, struct file *file_out)
-{
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
-
-	/* Don't copy dirs, pipes, sockets... */
-	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
-		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
-		return -EINVAL;
-
-	if (!(file_in->f_mode & FMODE_READ) ||
-	    !(file_out->f_mode & FMODE_WRITE) ||
-	    (file_out->f_flags & O_APPEND))
-		return -EBADF;
-
-	return 0;
-}
-
-/*
- * Performs necessary checks before doing a file copy
- *
- * Can adjust amount of bytes to copy via @req_count argument.
- * Returns appropriate error code that caller should return or
- * zero in case the copy should be allowed.
- */
-int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
-			     struct file *file_out, loff_t pos_out,
-			     size_t *req_count, unsigned int flags)
-{
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
-	uint64_t count = *req_count;
-	loff_t size_in;
-	int ret;
-
-	ret = generic_file_rw_checks(file_in, file_out);
-	if (ret)
-		return ret;
-
-	/* Don't touch certain kinds of inodes */
-	if (IS_IMMUTABLE(inode_out))
-		return -EPERM;
-
-	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
-		return -ETXTBSY;
-
-	/* Ensure offsets don't wrap. */
-	if (pos_in + count < pos_in || pos_out + count < pos_out)
-		return -EOVERFLOW;
-
-	/* Shorten the copy to EOF */
-	size_in = i_size_read(inode_in);
-	if (pos_in >= size_in)
-		count = 0;
-	else
-		count = min(count, size_in - (uint64_t)pos_in);
-
-	ret = generic_write_check_limits(file_out, pos_out, &count);
-	if (ret)
-		return ret;
-
-	/* Don't allow overlapped copying within the same file. */
-	if (inode_in == inode_out &&
-	    pos_out + count > pos_in &&
-	    pos_out < pos_in + count)
-		return -EINVAL;
-
-	*req_count = count;
-	return 0;
-}
-
 int pagecache_write_begin(struct file *file, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
 				struct page **pagep, void **fsdata)
