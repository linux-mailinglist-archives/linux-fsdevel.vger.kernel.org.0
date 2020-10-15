Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6099128E980
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 02:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbgJOAbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 20:31:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33330 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbgJOAbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 20:31:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F0VOFK103888;
        Thu, 15 Oct 2020 00:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YUYWg3XzxSCvOZHF+a7OgK6XdMb2rwqs5xQUmlO/FGo=;
 b=TFOs0t6kFz+53jCHgSStyMrrak+MZvi7v4W88QbzdpH3lKocq/9f/KGRP5AcUBqB+yoS
 Gzbuy6r+tm09xDRA7gMtZTptUjeEOIIALc4FDiMt/cFaKDLpWIEuwIlfA5fme610CU6p
 qXD9DKVVgLcJlIpLWoP3ABhz++JWi/7RzfibzC8BO12HbRyMtbZ139jusmcP02dyhcJo
 tXASy8AhltQa/fTPMNBG89OjIC4R3Fvpo0CZsD55uq3uiRNvciXlncOqa5rw67uTMtGK
 e0iCviZmGLPbXmdev9xvB+G+1LoKnC/kKvs0nwoWiMmTtOoF4BHY1YtrGguc34EPuf+k Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 343pak0y9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 00:31:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09F0UaUk108194;
        Thu, 15 Oct 2020 00:31:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 343pvykjdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 00:31:30 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09F0VTWL008741;
        Thu, 15 Oct 2020 00:31:29 GMT
Received: from localhost (/10.159.142.84)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 17:31:28 -0700
Subject: [PATCH 2/2] vfs: move the remap range helpers to remap_range.c
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 14 Oct 2020 17:31:27 -0700
Message-ID: <160272188774.913987.12639321764718683233.stgit@magnolia>
In-Reply-To: <160272187483.913987.4254237066433242737.stgit@magnolia>
References: <160272187483.913987.4254237066433242737.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Complete the migration by moving the file remapping helper functions out
of read_write.c and into remap_range.c.  This reduces the clutter in the
first file and (eventually) will make it so that we can compile out the
second file if it isn't needed.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/read_write.c    |  473 ---------------------------------------------------
 fs/remap_range.c   |  480 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    3 
 3 files changed, 477 insertions(+), 479 deletions(-)


diff --git a/fs/read_write.c b/fs/read_write.c
index d3428189f36b..f0877f1c0c49 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1832,476 +1832,3 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
 out2:
 	return ret;
 }
-
-static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
-			     bool write)
-{
-	struct inode *inode = file_inode(file);
-
-	if (unlikely(pos < 0 || len < 0))
-		return -EINVAL;
-
-	 if (unlikely((loff_t) (pos + len) < 0))
-		return -EINVAL;
-
-	if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
-		loff_t end = len ? pos + len - 1 : OFFSET_MAX;
-		int retval;
-
-		retval = locks_mandatory_area(inode, file, pos, end,
-				write ? F_WRLCK : F_RDLCK);
-		if (retval < 0)
-			return retval;
-	}
-
-	return security_file_permission(file, write ? MAY_WRITE : MAY_READ);
-}
-/*
- * Ensure that we don't remap a partial EOF block in the middle of something
- * else.  Assume that the offsets have already been checked for block
- * alignment.
- *
- * For clone we only link a partial EOF block above or at the destination file's
- * EOF.  For deduplication we accept a partial EOF block only if it ends at the
- * destination file's EOF (can not link it into the middle of a file).
- *
- * Shorten the request if possible.
- */
-static int generic_remap_check_len(struct inode *inode_in,
-				   struct inode *inode_out,
-				   loff_t pos_out,
-				   loff_t *len,
-				   unsigned int remap_flags)
-{
-	u64 blkmask = i_blocksize(inode_in) - 1;
-	loff_t new_len = *len;
-
-	if ((*len & blkmask) == 0)
-		return 0;
-
-	if (pos_out + *len < i_size_read(inode_out))
-		new_len &= ~blkmask;
-
-	if (new_len == *len)
-		return 0;
-
-	if (remap_flags & REMAP_FILE_CAN_SHORTEN) {
-		*len = new_len;
-		return 0;
-	}
-
-	return (remap_flags & REMAP_FILE_DEDUP) ? -EBADE : -EINVAL;
-}
-
-/* Read a page's worth of file data into the page cache. */
-static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
-{
-	struct page *page;
-
-	page = read_mapping_page(inode->i_mapping, offset >> PAGE_SHIFT, NULL);
-	if (IS_ERR(page))
-		return page;
-	if (!PageUptodate(page)) {
-		put_page(page);
-		return ERR_PTR(-EIO);
-	}
-	return page;
-}
-
-/*
- * Lock two pages, ensuring that we lock in offset order if the pages are from
- * the same file.
- */
-static void vfs_lock_two_pages(struct page *page1, struct page *page2)
-{
-	/* Always lock in order of increasing index. */
-	if (page1->index > page2->index)
-		swap(page1, page2);
-
-	lock_page(page1);
-	if (page1 != page2)
-		lock_page(page2);
-}
-
-/* Unlock two pages, being careful not to unlock the same page twice. */
-static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
-{
-	unlock_page(page1);
-	if (page1 != page2)
-		unlock_page(page2);
-}
-
-/*
- * Compare extents of two files to see if they are the same.
- * Caller must have locked both inodes to prevent write races.
- */
-static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
-					 struct inode *dest, loff_t destoff,
-					 loff_t len, bool *is_same)
-{
-	loff_t src_poff;
-	loff_t dest_poff;
-	void *src_addr;
-	void *dest_addr;
-	struct page *src_page;
-	struct page *dest_page;
-	loff_t cmp_len;
-	bool same;
-	int error;
-
-	error = -EINVAL;
-	same = true;
-	while (len) {
-		src_poff = srcoff & (PAGE_SIZE - 1);
-		dest_poff = destoff & (PAGE_SIZE - 1);
-		cmp_len = min(PAGE_SIZE - src_poff,
-			      PAGE_SIZE - dest_poff);
-		cmp_len = min(cmp_len, len);
-		if (cmp_len <= 0)
-			goto out_error;
-
-		src_page = vfs_dedupe_get_page(src, srcoff);
-		if (IS_ERR(src_page)) {
-			error = PTR_ERR(src_page);
-			goto out_error;
-		}
-		dest_page = vfs_dedupe_get_page(dest, destoff);
-		if (IS_ERR(dest_page)) {
-			error = PTR_ERR(dest_page);
-			put_page(src_page);
-			goto out_error;
-		}
-
-		vfs_lock_two_pages(src_page, dest_page);
-
-		/*
-		 * Now that we've locked both pages, make sure they're still
-		 * mapped to the file data we're interested in.  If not,
-		 * someone is invalidating pages on us and we lose.
-		 */
-		if (!PageUptodate(src_page) || !PageUptodate(dest_page) ||
-		    src_page->mapping != src->i_mapping ||
-		    dest_page->mapping != dest->i_mapping) {
-			same = false;
-			goto unlock;
-		}
-
-		src_addr = kmap_atomic(src_page);
-		dest_addr = kmap_atomic(dest_page);
-
-		flush_dcache_page(src_page);
-		flush_dcache_page(dest_page);
-
-		if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
-			same = false;
-
-		kunmap_atomic(dest_addr);
-		kunmap_atomic(src_addr);
-unlock:
-		vfs_unlock_two_pages(src_page, dest_page);
-		put_page(dest_page);
-		put_page(src_page);
-
-		if (!same)
-			break;
-
-		srcoff += cmp_len;
-		destoff += cmp_len;
-		len -= cmp_len;
-	}
-
-	*is_same = same;
-	return 0;
-
-out_error:
-	return error;
-}
-
-/*
- * Check that the two inodes are eligible for cloning, the ranges make
- * sense, and then flush all dirty data.  Caller must ensure that the
- * inodes have been locked against any other modifications.
- *
- * If there's an error, then the usual negative error code is returned.
- * Otherwise returns 0 with *len set to the request length.
- */
-int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
-				  struct file *file_out, loff_t pos_out,
-				  loff_t *len, unsigned int remap_flags)
-{
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
-	bool same_inode = (inode_in == inode_out);
-	int ret;
-
-	/* Don't touch certain kinds of inodes */
-	if (IS_IMMUTABLE(inode_out))
-		return -EPERM;
-
-	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
-		return -ETXTBSY;
-
-	/* Don't reflink dirs, pipes, sockets... */
-	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
-		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
-		return -EINVAL;
-
-	/* Zero length dedupe exits immediately; reflink goes to EOF. */
-	if (*len == 0) {
-		loff_t isize = i_size_read(inode_in);
-
-		if ((remap_flags & REMAP_FILE_DEDUP) || pos_in == isize)
-			return 0;
-		if (pos_in > isize)
-			return -EINVAL;
-		*len = isize - pos_in;
-		if (*len == 0)
-			return 0;
-	}
-
-	/* Check that we don't violate system file offset limits. */
-	ret = generic_remap_checks(file_in, pos_in, file_out, pos_out, len,
-			remap_flags);
-	if (ret)
-		return ret;
-
-	/* Wait for the completion of any pending IOs on both files */
-	inode_dio_wait(inode_in);
-	if (!same_inode)
-		inode_dio_wait(inode_out);
-
-	ret = filemap_write_and_wait_range(inode_in->i_mapping,
-			pos_in, pos_in + *len - 1);
-	if (ret)
-		return ret;
-
-	ret = filemap_write_and_wait_range(inode_out->i_mapping,
-			pos_out, pos_out + *len - 1);
-	if (ret)
-		return ret;
-
-	/*
-	 * Check that the extents are the same.
-	 */
-	if (remap_flags & REMAP_FILE_DEDUP) {
-		bool		is_same = false;
-
-		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
-				inode_out, pos_out, *len, &is_same);
-		if (ret)
-			return ret;
-		if (!is_same)
-			return -EBADE;
-	}
-
-	ret = generic_remap_check_len(inode_in, inode_out, pos_out, len,
-			remap_flags);
-	if (ret)
-		return ret;
-
-	/* If can't alter the file contents, we're done. */
-	if (!(remap_flags & REMAP_FILE_DEDUP))
-		ret = file_modified(file_out);
-
-	return ret;
-}
-EXPORT_SYMBOL(generic_remap_file_range_prep);
-
-loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
-			   struct file *file_out, loff_t pos_out,
-			   loff_t len, unsigned int remap_flags)
-{
-	loff_t ret;
-
-	WARN_ON_ONCE(remap_flags & REMAP_FILE_DEDUP);
-
-	/*
-	 * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
-	 * the same mount. Practically, they only need to be on the same file
-	 * system.
-	 */
-	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
-		return -EXDEV;
-
-	ret = generic_file_rw_checks(file_in, file_out);
-	if (ret < 0)
-		return ret;
-
-	if (!file_in->f_op->remap_file_range)
-		return -EOPNOTSUPP;
-
-	ret = remap_verify_area(file_in, pos_in, len, false);
-	if (ret)
-		return ret;
-
-	ret = remap_verify_area(file_out, pos_out, len, true);
-	if (ret)
-		return ret;
-
-	ret = file_in->f_op->remap_file_range(file_in, pos_in,
-			file_out, pos_out, len, remap_flags);
-	if (ret < 0)
-		return ret;
-
-	fsnotify_access(file_in);
-	fsnotify_modify(file_out);
-	return ret;
-}
-EXPORT_SYMBOL(do_clone_file_range);
-
-loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
-			    struct file *file_out, loff_t pos_out,
-			    loff_t len, unsigned int remap_flags)
-{
-	loff_t ret;
-
-	file_start_write(file_out);
-	ret = do_clone_file_range(file_in, pos_in, file_out, pos_out, len,
-				  remap_flags);
-	file_end_write(file_out);
-
-	return ret;
-}
-EXPORT_SYMBOL(vfs_clone_file_range);
-
-/* Check whether we are allowed to dedupe the destination file */
-static bool allow_file_dedupe(struct file *file)
-{
-	if (capable(CAP_SYS_ADMIN))
-		return true;
-	if (file->f_mode & FMODE_WRITE)
-		return true;
-	if (uid_eq(current_fsuid(), file_inode(file)->i_uid))
-		return true;
-	if (!inode_permission(file_inode(file), MAY_WRITE))
-		return true;
-	return false;
-}
-
-loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
-				 struct file *dst_file, loff_t dst_pos,
-				 loff_t len, unsigned int remap_flags)
-{
-	loff_t ret;
-
-	WARN_ON_ONCE(remap_flags & ~(REMAP_FILE_DEDUP |
-				     REMAP_FILE_CAN_SHORTEN));
-
-	ret = mnt_want_write_file(dst_file);
-	if (ret)
-		return ret;
-
-	ret = remap_verify_area(dst_file, dst_pos, len, true);
-	if (ret < 0)
-		goto out_drop_write;
-
-	ret = -EPERM;
-	if (!allow_file_dedupe(dst_file))
-		goto out_drop_write;
-
-	ret = -EXDEV;
-	if (src_file->f_path.mnt != dst_file->f_path.mnt)
-		goto out_drop_write;
-
-	ret = -EISDIR;
-	if (S_ISDIR(file_inode(dst_file)->i_mode))
-		goto out_drop_write;
-
-	ret = -EINVAL;
-	if (!dst_file->f_op->remap_file_range)
-		goto out_drop_write;
-
-	if (len == 0) {
-		ret = 0;
-		goto out_drop_write;
-	}
-
-	ret = dst_file->f_op->remap_file_range(src_file, src_pos, dst_file,
-			dst_pos, len, remap_flags | REMAP_FILE_DEDUP);
-out_drop_write:
-	mnt_drop_write_file(dst_file);
-
-	return ret;
-}
-EXPORT_SYMBOL(vfs_dedupe_file_range_one);
-
-int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
-{
-	struct file_dedupe_range_info *info;
-	struct inode *src = file_inode(file);
-	u64 off;
-	u64 len;
-	int i;
-	int ret;
-	u16 count = same->dest_count;
-	loff_t deduped;
-
-	if (!(file->f_mode & FMODE_READ))
-		return -EINVAL;
-
-	if (same->reserved1 || same->reserved2)
-		return -EINVAL;
-
-	off = same->src_offset;
-	len = same->src_length;
-
-	if (S_ISDIR(src->i_mode))
-		return -EISDIR;
-
-	if (!S_ISREG(src->i_mode))
-		return -EINVAL;
-
-	if (!file->f_op->remap_file_range)
-		return -EOPNOTSUPP;
-
-	ret = remap_verify_area(file, off, len, false);
-	if (ret < 0)
-		return ret;
-	ret = 0;
-
-	if (off + len > i_size_read(src))
-		return -EINVAL;
-
-	/* Arbitrary 1G limit on a single dedupe request, can be raised. */
-	len = min_t(u64, len, 1 << 30);
-
-	/* pre-format output fields to sane values */
-	for (i = 0; i < count; i++) {
-		same->info[i].bytes_deduped = 0ULL;
-		same->info[i].status = FILE_DEDUPE_RANGE_SAME;
-	}
-
-	for (i = 0, info = same->info; i < count; i++, info++) {
-		struct fd dst_fd = fdget(info->dest_fd);
-		struct file *dst_file = dst_fd.file;
-
-		if (!dst_file) {
-			info->status = -EBADF;
-			goto next_loop;
-		}
-
-		if (info->reserved) {
-			info->status = -EINVAL;
-			goto next_fdput;
-		}
-
-		deduped = vfs_dedupe_file_range_one(file, off, dst_file,
-						    info->dest_offset, len,
-						    REMAP_FILE_CAN_SHORTEN);
-		if (deduped == -EBADE)
-			info->status = FILE_DEDUPE_RANGE_DIFFERS;
-		else if (deduped < 0)
-			info->status = deduped;
-		else
-			info->bytes_deduped = len;
-
-next_fdput:
-		fdput(dst_fd);
-next_loop:
-		if (fatal_signal_pending(current))
-			break;
-	}
-	return ret;
-}
-EXPORT_SYMBOL(vfs_dedupe_file_range);
diff --git a/fs/remap_range.c b/fs/remap_range.c
index e66d8c131b69..e2cb46108a06 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -32,9 +32,9 @@
  * Returns appropriate error code that caller should return or
  * zero in case the clone should be allowed.
  */
-int generic_remap_checks(struct file *file_in, loff_t pos_in,
-			 struct file *file_out, loff_t pos_out,
-			 loff_t *req_count, unsigned int remap_flags)
+static int generic_remap_checks(struct file *file_in, loff_t pos_in,
+				struct file *file_out, loff_t pos_out,
+				loff_t *req_count, unsigned int remap_flags)
 {
 	struct inode *inode_in = file_in->f_mapping->host;
 	struct inode *inode_out = file_out->f_mapping->host;
@@ -101,3 +101,477 @@ int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	*req_count = count;
 	return 0;
 }
+
+static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
+			     bool write)
+{
+	struct inode *inode = file_inode(file);
+
+	if (unlikely(pos < 0 || len < 0))
+		return -EINVAL;
+
+	 if (unlikely((loff_t) (pos + len) < 0))
+		return -EINVAL;
+
+	if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
+		loff_t end = len ? pos + len - 1 : OFFSET_MAX;
+		int retval;
+
+		retval = locks_mandatory_area(inode, file, pos, end,
+				write ? F_WRLCK : F_RDLCK);
+		if (retval < 0)
+			return retval;
+	}
+
+	return security_file_permission(file, write ? MAY_WRITE : MAY_READ);
+}
+
+/*
+ * Ensure that we don't remap a partial EOF block in the middle of something
+ * else.  Assume that the offsets have already been checked for block
+ * alignment.
+ *
+ * For clone we only link a partial EOF block above or at the destination file's
+ * EOF.  For deduplication we accept a partial EOF block only if it ends at the
+ * destination file's EOF (can not link it into the middle of a file).
+ *
+ * Shorten the request if possible.
+ */
+static int generic_remap_check_len(struct inode *inode_in,
+				   struct inode *inode_out,
+				   loff_t pos_out,
+				   loff_t *len,
+				   unsigned int remap_flags)
+{
+	u64 blkmask = i_blocksize(inode_in) - 1;
+	loff_t new_len = *len;
+
+	if ((*len & blkmask) == 0)
+		return 0;
+
+	if (pos_out + *len < i_size_read(inode_out))
+		new_len &= ~blkmask;
+
+	if (new_len == *len)
+		return 0;
+
+	if (remap_flags & REMAP_FILE_CAN_SHORTEN) {
+		*len = new_len;
+		return 0;
+	}
+
+	return (remap_flags & REMAP_FILE_DEDUP) ? -EBADE : -EINVAL;
+}
+
+/* Read a page's worth of file data into the page cache. */
+static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
+{
+	struct page *page;
+
+	page = read_mapping_page(inode->i_mapping, offset >> PAGE_SHIFT, NULL);
+	if (IS_ERR(page))
+		return page;
+	if (!PageUptodate(page)) {
+		put_page(page);
+		return ERR_PTR(-EIO);
+	}
+	return page;
+}
+
+/*
+ * Lock two pages, ensuring that we lock in offset order if the pages are from
+ * the same file.
+ */
+static void vfs_lock_two_pages(struct page *page1, struct page *page2)
+{
+	/* Always lock in order of increasing index. */
+	if (page1->index > page2->index)
+		swap(page1, page2);
+
+	lock_page(page1);
+	if (page1 != page2)
+		lock_page(page2);
+}
+
+/* Unlock two pages, being careful not to unlock the same page twice. */
+static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
+{
+	unlock_page(page1);
+	if (page1 != page2)
+		unlock_page(page2);
+}
+
+/*
+ * Compare extents of two files to see if they are the same.
+ * Caller must have locked both inodes to prevent write races.
+ */
+static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+					 struct inode *dest, loff_t destoff,
+					 loff_t len, bool *is_same)
+{
+	loff_t src_poff;
+	loff_t dest_poff;
+	void *src_addr;
+	void *dest_addr;
+	struct page *src_page;
+	struct page *dest_page;
+	loff_t cmp_len;
+	bool same;
+	int error;
+
+	error = -EINVAL;
+	same = true;
+	while (len) {
+		src_poff = srcoff & (PAGE_SIZE - 1);
+		dest_poff = destoff & (PAGE_SIZE - 1);
+		cmp_len = min(PAGE_SIZE - src_poff,
+			      PAGE_SIZE - dest_poff);
+		cmp_len = min(cmp_len, len);
+		if (cmp_len <= 0)
+			goto out_error;
+
+		src_page = vfs_dedupe_get_page(src, srcoff);
+		if (IS_ERR(src_page)) {
+			error = PTR_ERR(src_page);
+			goto out_error;
+		}
+		dest_page = vfs_dedupe_get_page(dest, destoff);
+		if (IS_ERR(dest_page)) {
+			error = PTR_ERR(dest_page);
+			put_page(src_page);
+			goto out_error;
+		}
+
+		vfs_lock_two_pages(src_page, dest_page);
+
+		/*
+		 * Now that we've locked both pages, make sure they're still
+		 * mapped to the file data we're interested in.  If not,
+		 * someone is invalidating pages on us and we lose.
+		 */
+		if (!PageUptodate(src_page) || !PageUptodate(dest_page) ||
+		    src_page->mapping != src->i_mapping ||
+		    dest_page->mapping != dest->i_mapping) {
+			same = false;
+			goto unlock;
+		}
+
+		src_addr = kmap_atomic(src_page);
+		dest_addr = kmap_atomic(dest_page);
+
+		flush_dcache_page(src_page);
+		flush_dcache_page(dest_page);
+
+		if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
+			same = false;
+
+		kunmap_atomic(dest_addr);
+		kunmap_atomic(src_addr);
+unlock:
+		vfs_unlock_two_pages(src_page, dest_page);
+		put_page(dest_page);
+		put_page(src_page);
+
+		if (!same)
+			break;
+
+		srcoff += cmp_len;
+		destoff += cmp_len;
+		len -= cmp_len;
+	}
+
+	*is_same = same;
+	return 0;
+
+out_error:
+	return error;
+}
+
+/*
+ * Check that the two inodes are eligible for cloning, the ranges make
+ * sense, and then flush all dirty data.  Caller must ensure that the
+ * inodes have been locked against any other modifications.
+ *
+ * If there's an error, then the usual negative error code is returned.
+ * Otherwise returns 0 with *len set to the request length.
+ */
+int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+				  struct file *file_out, loff_t pos_out,
+				  loff_t *len, unsigned int remap_flags)
+{
+	struct inode *inode_in = file_inode(file_in);
+	struct inode *inode_out = file_inode(file_out);
+	bool same_inode = (inode_in == inode_out);
+	int ret;
+
+	/* Don't touch certain kinds of inodes */
+	if (IS_IMMUTABLE(inode_out))
+		return -EPERM;
+
+	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
+		return -ETXTBSY;
+
+	/* Don't reflink dirs, pipes, sockets... */
+	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
+		return -EISDIR;
+	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+		return -EINVAL;
+
+	/* Zero length dedupe exits immediately; reflink goes to EOF. */
+	if (*len == 0) {
+		loff_t isize = i_size_read(inode_in);
+
+		if ((remap_flags & REMAP_FILE_DEDUP) || pos_in == isize)
+			return 0;
+		if (pos_in > isize)
+			return -EINVAL;
+		*len = isize - pos_in;
+		if (*len == 0)
+			return 0;
+	}
+
+	/* Check that we don't violate system file offset limits. */
+	ret = generic_remap_checks(file_in, pos_in, file_out, pos_out, len,
+			remap_flags);
+	if (ret)
+		return ret;
+
+	/* Wait for the completion of any pending IOs on both files */
+	inode_dio_wait(inode_in);
+	if (!same_inode)
+		inode_dio_wait(inode_out);
+
+	ret = filemap_write_and_wait_range(inode_in->i_mapping,
+			pos_in, pos_in + *len - 1);
+	if (ret)
+		return ret;
+
+	ret = filemap_write_and_wait_range(inode_out->i_mapping,
+			pos_out, pos_out + *len - 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Check that the extents are the same.
+	 */
+	if (remap_flags & REMAP_FILE_DEDUP) {
+		bool		is_same = false;
+
+		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
+				inode_out, pos_out, *len, &is_same);
+		if (ret)
+			return ret;
+		if (!is_same)
+			return -EBADE;
+	}
+
+	ret = generic_remap_check_len(inode_in, inode_out, pos_out, len,
+			remap_flags);
+	if (ret)
+		return ret;
+
+	/* If can't alter the file contents, we're done. */
+	if (!(remap_flags & REMAP_FILE_DEDUP))
+		ret = file_modified(file_out);
+
+	return ret;
+}
+EXPORT_SYMBOL(generic_remap_file_range_prep);
+
+loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
+			   struct file *file_out, loff_t pos_out,
+			   loff_t len, unsigned int remap_flags)
+{
+	loff_t ret;
+
+	WARN_ON_ONCE(remap_flags & REMAP_FILE_DEDUP);
+
+	/*
+	 * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
+	 * the same mount. Practically, they only need to be on the same file
+	 * system.
+	 */
+	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
+		return -EXDEV;
+
+	ret = generic_file_rw_checks(file_in, file_out);
+	if (ret < 0)
+		return ret;
+
+	if (!file_in->f_op->remap_file_range)
+		return -EOPNOTSUPP;
+
+	ret = remap_verify_area(file_in, pos_in, len, false);
+	if (ret)
+		return ret;
+
+	ret = remap_verify_area(file_out, pos_out, len, true);
+	if (ret)
+		return ret;
+
+	ret = file_in->f_op->remap_file_range(file_in, pos_in,
+			file_out, pos_out, len, remap_flags);
+	if (ret < 0)
+		return ret;
+
+	fsnotify_access(file_in);
+	fsnotify_modify(file_out);
+	return ret;
+}
+EXPORT_SYMBOL(do_clone_file_range);
+
+loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
+			    struct file *file_out, loff_t pos_out,
+			    loff_t len, unsigned int remap_flags)
+{
+	loff_t ret;
+
+	file_start_write(file_out);
+	ret = do_clone_file_range(file_in, pos_in, file_out, pos_out, len,
+				  remap_flags);
+	file_end_write(file_out);
+
+	return ret;
+}
+EXPORT_SYMBOL(vfs_clone_file_range);
+
+/* Check whether we are allowed to dedupe the destination file */
+static bool allow_file_dedupe(struct file *file)
+{
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+	if (file->f_mode & FMODE_WRITE)
+		return true;
+	if (uid_eq(current_fsuid(), file_inode(file)->i_uid))
+		return true;
+	if (!inode_permission(file_inode(file), MAY_WRITE))
+		return true;
+	return false;
+}
+
+loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
+				 struct file *dst_file, loff_t dst_pos,
+				 loff_t len, unsigned int remap_flags)
+{
+	loff_t ret;
+
+	WARN_ON_ONCE(remap_flags & ~(REMAP_FILE_DEDUP |
+				     REMAP_FILE_CAN_SHORTEN));
+
+	ret = mnt_want_write_file(dst_file);
+	if (ret)
+		return ret;
+
+	ret = remap_verify_area(dst_file, dst_pos, len, true);
+	if (ret < 0)
+		goto out_drop_write;
+
+	ret = -EPERM;
+	if (!allow_file_dedupe(dst_file))
+		goto out_drop_write;
+
+	ret = -EXDEV;
+	if (src_file->f_path.mnt != dst_file->f_path.mnt)
+		goto out_drop_write;
+
+	ret = -EISDIR;
+	if (S_ISDIR(file_inode(dst_file)->i_mode))
+		goto out_drop_write;
+
+	ret = -EINVAL;
+	if (!dst_file->f_op->remap_file_range)
+		goto out_drop_write;
+
+	if (len == 0) {
+		ret = 0;
+		goto out_drop_write;
+	}
+
+	ret = dst_file->f_op->remap_file_range(src_file, src_pos, dst_file,
+			dst_pos, len, remap_flags | REMAP_FILE_DEDUP);
+out_drop_write:
+	mnt_drop_write_file(dst_file);
+
+	return ret;
+}
+EXPORT_SYMBOL(vfs_dedupe_file_range_one);
+
+int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
+{
+	struct file_dedupe_range_info *info;
+	struct inode *src = file_inode(file);
+	u64 off;
+	u64 len;
+	int i;
+	int ret;
+	u16 count = same->dest_count;
+	loff_t deduped;
+
+	if (!(file->f_mode & FMODE_READ))
+		return -EINVAL;
+
+	if (same->reserved1 || same->reserved2)
+		return -EINVAL;
+
+	off = same->src_offset;
+	len = same->src_length;
+
+	if (S_ISDIR(src->i_mode))
+		return -EISDIR;
+
+	if (!S_ISREG(src->i_mode))
+		return -EINVAL;
+
+	if (!file->f_op->remap_file_range)
+		return -EOPNOTSUPP;
+
+	ret = remap_verify_area(file, off, len, false);
+	if (ret < 0)
+		return ret;
+	ret = 0;
+
+	if (off + len > i_size_read(src))
+		return -EINVAL;
+
+	/* Arbitrary 1G limit on a single dedupe request, can be raised. */
+	len = min_t(u64, len, 1 << 30);
+
+	/* pre-format output fields to sane values */
+	for (i = 0; i < count; i++) {
+		same->info[i].bytes_deduped = 0ULL;
+		same->info[i].status = FILE_DEDUPE_RANGE_SAME;
+	}
+
+	for (i = 0, info = same->info; i < count; i++, info++) {
+		struct fd dst_fd = fdget(info->dest_fd);
+		struct file *dst_file = dst_fd.file;
+
+		if (!dst_file) {
+			info->status = -EBADF;
+			goto next_loop;
+		}
+
+		if (info->reserved) {
+			info->status = -EINVAL;
+			goto next_fdput;
+		}
+
+		deduped = vfs_dedupe_file_range_one(file, off, dst_file,
+						    info->dest_offset, len,
+						    REMAP_FILE_CAN_SHORTEN);
+		if (deduped == -EBADE)
+			info->status = FILE_DEDUPE_RANGE_DIFFERS;
+		else if (deduped < 0)
+			info->status = deduped;
+		else
+			info->bytes_deduped = len;
+
+next_fdput:
+		fdput(dst_fd);
+next_loop:
+		if (fatal_signal_pending(current))
+			break;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(vfs_dedupe_file_range);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index eea754a8dd67..073da53b59b0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3009,9 +3009,6 @@ extern int sb_min_blocksize(struct super_block *, int);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
-extern int generic_remap_checks(struct file *file_in, loff_t pos_in,
-				struct file *file_out, loff_t pos_out,
-				loff_t *count, unsigned int remap_flags);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);

