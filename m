Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9A34C024E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiBVTtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiBVTsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE3B6D1D
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Mv5e6qVKV/6am5LSNLVQMEREihYun5/qvpXGjbkBFlw=; b=jYR+vVyozKdqAN/db1mME/Gt39
        sSnbbfiKhTxb8eTKVv25B+LEhlM/aAjpaHx3AGNw3G6YP2pSLcEwql4q00skF6rYP2mStRL+PeQUU
        lNrWdNXEUNkC7yzEfXFDp7SWOo+90kKMRWY2F/bZLt411frXZh7ZtpmmMWYy7b1lIAqgpnZ1fXMIF
        2c52iNX86mo+nNJO3edJMJjs7VKCreo/UwnWy4dojTFKdHtxknzUIzxOOa60/lDbYYOMvvPIKObaL
        543nkXqtySrj09gBln06BQWPMVTHbItPMe1OH0rk1ksQCNSqz1W12GufYfuyq5XiZ2nj4/Uo4BPNb
        6zg5XaoA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb95-0035zT-0Q; Tue, 22 Feb 2022 19:48:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/22] fs: Pass an iocb to generic_perform_write()
Date:   Tue, 22 Feb 2022 19:47:59 +0000
Message-Id: <20220222194820.737755-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can extract both the file pointer and the pos from the iocb.
This simplifies each caller as well as allowing generic_perform_write()
to see more of the iocb contents in the future.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/file.c     |  2 +-
 fs/ext4/file.c     |  2 +-
 fs/f2fs/file.c     |  2 +-
 fs/nfs/file.c      |  2 +-
 include/linux/fs.h |  2 +-
 mm/filemap.c       | 10 ++++++----
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index bbed3224ad68..a22eb492bbba 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1845,7 +1845,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * are pending vmtruncate. So write and vmtruncate
 		 * can not run at the same time
 		 */
-		written = generic_perform_write(file, from, pos);
+		written = generic_perform_write(iocb, from);
 		if (likely(written >= 0))
 			iocb->ki_pos = pos + written;
 		ceph_end_io_write(inode);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8cc11715518a..894565626179 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -265,7 +265,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 		goto out;
 
 	current->backing_dev_info = inode_to_bdi(inode);
-	ret = generic_perform_write(iocb->ki_filp, from, iocb->ki_pos);
+	ret = generic_perform_write(iocb, from);
 	current->backing_dev_info = NULL;
 
 out:
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3c98ef6af97d..067e0eefae9b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4445,7 +4445,7 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 		return -EOPNOTSUPP;
 
 	current->backing_dev_info = inode_to_bdi(inode);
-	ret = generic_perform_write(file, from, iocb->ki_pos);
+	ret = generic_perform_write(iocb, from);
 	current->backing_dev_info = NULL;
 
 	if (ret > 0) {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index b747e3d4c354..68ec0c9579d9 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -642,7 +642,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	result = generic_write_checks(iocb, from);
 	if (result > 0) {
 		current->backing_dev_info = inode_to_bdi(inode);
-		result = generic_perform_write(file, from, iocb->ki_pos);
+		result = generic_perform_write(iocb, from);
 		current->backing_dev_info = NULL;
 	}
 	nfs_end_io_write(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1c0660ff9ff0..394570a970af 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3117,7 +3117,7 @@ extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
-extern ssize_t generic_perform_write(struct file *, struct iov_iter *, loff_t);
+extern ssize_t generic_perform_write(struct kiocb *, struct iov_iter *);
 
 ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
diff --git a/mm/filemap.c b/mm/filemap.c
index bb4e91bf5492..c2bef068afab 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3725,9 +3725,10 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-ssize_t generic_perform_write(struct file *file,
-				struct iov_iter *i, loff_t pos)
+ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 {
+	struct file *file = iocb->ki_filp;
+	loff_t pos = iocb->ki_pos;
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
 	long status = 0;
@@ -3857,7 +3858,8 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			goto out;
 
-		status = generic_perform_write(file, from, pos = iocb->ki_pos);
+		pos = iocb->ki_pos;
+		status = generic_perform_write(iocb, from);
 		/*
 		 * If generic_perform_write() returned a synchronous error
 		 * then we want to return the number of bytes which were
@@ -3889,7 +3891,7 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			 */
 		}
 	} else {
-		written = generic_perform_write(file, from, iocb->ki_pos);
+		written = generic_perform_write(iocb, from);
 		if (likely(written > 0))
 			iocb->ki_pos += written;
 	}
-- 
2.34.1

