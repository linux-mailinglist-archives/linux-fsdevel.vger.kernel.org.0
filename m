Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56E410A42D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 19:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZSuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 13:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfKZSuY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:50:24 -0500
Received: from hubcapsc.localdomain (adsl-074-187-100-144.sip.mia.bellsouth.net [74.187.100.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 175402071E;
        Tue, 26 Nov 2019 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574794223;
        bh=8zSkI0uA1bKe68hzq2SOswi5i3s+OEr2w+qMlRDib3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=zxTfgz98ncQJTwSQyqMClPw+2vEnkz4BYFWvmru9BW/NUbNkSTv+jncaLJBkGkF08
         mw72FdPqeqcZ3Q1sEp3ZiSfnedty8qfZJMQbbJLXLQEEAGZqkGcrqn7khrA/NfiH7e
         YSWdd0ZJPoS+zmBptKCKlBnHD1aYFZkUgSztbn7Q=
From:   hubcap@kernel.org
To:     torvalds@linux-foundation.org
Cc:     Mike Marshall <hubcap@omnibond.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH V3] orangefs: posix open permission checking...
Date:   Tue, 26 Nov 2019 13:50:18 -0500
Message-Id: <20191126185018.8283-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Marshall <hubcap@omnibond.com>

Here's another version that is hopefully closer to
usable...

 Orangefs has no open, and orangefs checks file permissions
 on each file access. Posix requires that file permissions
 be checked on open and nowhere else. Orangefs-through-the-kernel
 needs to seem posix compliant.

 The VFS opens files, even if the filesystem provides no
 method. We can see if a file was successfully opened for
 read and or for write by looking at file->f_mode.

 When writes are flowing from the page cache, file is no
 longer available. We can trust the VFS to have checked
 file->f_mode before writing to the page cache.

 The mode of a file might change between when it is opened
 and IO commences, or it might be created with an arbitrary mode.

 We'll make sure we don't hit EACCES during the IO stage by
 using UID 0. Some of the time we have access without changing
 to UID 0 - how to check?

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/file.c            | 39 +++++++++++++++++++++++++++++++++--
 fs/orangefs/inode.c           |  8 +++----
 fs/orangefs/orangefs-kernel.h |  3 ++-
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index a5612abc0936..c740159d9ad1 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -46,8 +46,9 @@ static int flush_racache(struct inode *inode)
  * Post and wait for the I/O upcall to finish
  */
 ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
-    loff_t *offset, struct iov_iter *iter, size_t total_size,
-    loff_t readahead_size, struct orangefs_write_range *wr, int *index_return)
+	loff_t *offset, struct iov_iter *iter, size_t total_size,
+	loff_t readahead_size, struct orangefs_write_range *wr,
+	int *index_return, struct file *file)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_khandle *handle = &orangefs_inode->refn.khandle;
@@ -55,6 +56,8 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 	int buffer_index;
 	ssize_t ret;
 	size_t copy_amount;
+	int open_for_read;
+	int open_for_write;
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_FILE_IO);
 	if (!new_op)
@@ -90,6 +93,38 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 		new_op->upcall.uid = from_kuid(&init_user_ns, wr->uid);
 		new_op->upcall.gid = from_kgid(&init_user_ns, wr->gid);
 	}
+	/*
+	 * Orangefs has no open, and orangefs checks file permissions
+	 * on each file access. Posix requires that file permissions
+	 * be checked on open and nowhere else. Orangefs-through-the-kernel
+	 * needs to seem posix compliant.
+	 *
+	 * The VFS opens files, even if the filesystem provides no
+	 * method. We can see if a file was successfully opened for
+	 * read and or for write by looking at file->f_mode.
+	 *
+	 * When writes are flowing from the page cache, file is no
+	 * longer available. We can trust the VFS to have checked
+	 * file->f_mode before writing to the page cache.
+	 *
+	 * The mode of a file might change between when it is opened
+	 * and IO commences, or it might be created with an arbitrary mode.
+	 *
+	 * We'll make sure we don't hit EACCES during the IO stage by
+	 * using UID 0. Some of the time we have access without changing
+	 * to UID 0 - how to check?
+	 */
+	if (file) {
+		open_for_write = file->f_mode & FMODE_WRITE;
+		open_for_read = file->f_mode & FMODE_READ;
+	} else {
+		open_for_write = 1;
+		open_for_read = 0; /* not relevant? */
+	}
+	if ((type == ORANGEFS_IO_WRITE) && open_for_write)
+		new_op->upcall.uid = 0;
+	if ((type == ORANGEFS_IO_READ) && open_for_read)
+		new_op->upcall.uid = 0;
 
 	gossip_debug(GOSSIP_FILE_DEBUG,
 		     "%s(%pU): offset: %llu total_size: %zd\n",
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index efb12197da18..961c0fd8675a 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -55,7 +55,7 @@ static int orangefs_writepage_locked(struct page *page,
 	iov_iter_bvec(&iter, WRITE, &bv, 1, wlen);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
-	    len, wr, NULL);
+	    len, wr, NULL, NULL);
 	if (ret < 0) {
 		SetPageError(page);
 		mapping_set_error(page->mapping, ret);
@@ -126,7 +126,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	wr.uid = ow->uid;
 	wr.gid = ow->gid;
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, ow->len,
-	    0, &wr, NULL);
+	    0, &wr, NULL, NULL);
 	if (ret < 0) {
 		for (i = 0; i < ow->npages; i++) {
 			SetPageError(ow->pages[i]);
@@ -311,7 +311,7 @@ static int orangefs_readpage(struct file *file, struct page *page)
 	iov_iter_bvec(&iter, READ, &bv, 1, PAGE_SIZE);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
-	    read_size, inode->i_size, NULL, &buffer_index);
+	    read_size, inode->i_size, NULL, &buffer_index, file);
 	remaining = ret;
 	/* this will only zero remaining unread portions of the page data */
 	iov_iter_zero(~0U, &iter);
@@ -651,7 +651,7 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 			     (int)*offset);
 
 		ret = wait_for_direct_io(type, inode, offset, iter,
-				each_count, 0, NULL, NULL);
+				each_count, 0, NULL, NULL, file);
 		gossip_debug(GOSSIP_FILE_DEBUG,
 			     "%s(%pU): return from wait_for_io:%d\n",
 			     __func__,
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 34a6c99fa29b..ed67f39fa7ce 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -398,7 +398,8 @@ bool __is_daemon_in_service(void);
  */
 int orangefs_revalidate_mapping(struct inode *);
 ssize_t wait_for_direct_io(enum ORANGEFS_io_type, struct inode *, loff_t *,
-    struct iov_iter *, size_t, loff_t, struct orangefs_write_range *, int *);
+    struct iov_iter *, size_t, loff_t, struct orangefs_write_range *, int *,
+    struct file *);
 ssize_t do_readv_writev(enum ORANGEFS_io_type, struct file *, loff_t *,
     struct iov_iter *);
 
-- 
2.20.1

