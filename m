Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FCE4EC711
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347242AbiC3OvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347228AbiC3OvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286731659E
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dJj5Ad8dHf6csmUAG2uVgzkNp7UijvsF9VGRFxXvofk=; b=Mt3R5TTR27Qnt5X4lk0cMUuh6d
        A3QrutGhh2w0REOm+rflbeGsD/xy2CXaP2vANXqFSII/3FqvtC9AtybRcpbau78l3B9IIv008y7ah
        m/j+keQchDAyxeI+BlinvECdGndGJsFsvrOrxS4CeN0+2nI+zfDaSWZErxrgUpZ5Oq5/Rw0EKhskY
        zwf1+BjqMY+MsemMOeEMUcMPIcMDlDiDiibKyunR+QtYvEIvTK87z5/Ywa52F7f51z8XPrraBQnyz
        N8ECZf0zqePGjWaFYZmWOaBoisK7SsjgIgFaYPjT+qAdjeDaaG8wBqM++qNDc39T1YwqxlmIeWzxI
        bojZUxUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZZdc-001KDH-Bp; Wed, 30 Mar 2022 14:49:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 06/12] fs: Pass an iocb to generic_perform_write()
Date:   Wed, 30 Mar 2022 15:49:24 +0100
Message-Id: <20220330144930.315951-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220330144930.315951-1-willy@infradead.org>
References: <20220330144930.315951-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/ceph/file.c     |  2 +-
 fs/ext4/file.c     |  2 +-
 fs/f2fs/file.c     |  2 +-
 fs/nfs/file.c      |  2 +-
 include/linux/fs.h |  2 +-
 mm/filemap.c       | 10 ++++++----
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index feb75eb1cd82..6c9e837aa1d3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1869,7 +1869,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * are pending vmtruncate. So write and vmtruncate
 		 * can not run at the same time
 		 */
-		written = generic_perform_write(file, from, pos);
+		written = generic_perform_write(iocb, from);
 		if (likely(written >= 0))
 			iocb->ki_pos = pos + written;
 		ceph_end_io_write(inode);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8bd66cdc41be..6feb07e3e1eb 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -267,7 +267,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 		goto out;
 
 	current->backing_dev_info = inode_to_bdi(inode);
-	ret = generic_perform_write(iocb->ki_filp, from, iocb->ki_pos);
+	ret = generic_perform_write(iocb, from);
 	current->backing_dev_info = NULL;
 
 out:
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d3f39a704b8b..5b89af0f27f0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4448,7 +4448,7 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 		return -EOPNOTSUPP;
 
 	current->backing_dev_info = inode_to_bdi(inode);
-	ret = generic_perform_write(file, from, iocb->ki_pos);
+	ret = generic_perform_write(iocb, from);
 	current->backing_dev_info = NULL;
 
 	if (ret > 0) {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index b0ca244c50d0..150b7fa8f0a7 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -646,7 +646,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	result = generic_write_checks(iocb, from);
 	if (result > 0) {
 		current->backing_dev_info = inode_to_bdi(inode);
-		result = generic_perform_write(file, from, iocb->ki_pos);
+		result = generic_perform_write(iocb, from);
 		current->backing_dev_info = NULL;
 	}
 	nfs_end_io_write(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8ff28939de60..468dc7ec821f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2999,7 +2999,7 @@ extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
-extern ssize_t generic_perform_write(struct file *, struct iov_iter *, loff_t);
+ssize_t generic_perform_write(struct kiocb *, struct iov_iter *);
 
 ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
diff --git a/mm/filemap.c b/mm/filemap.c
index d904cd7e4181..3a5ffb5587cd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3752,9 +3752,10 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -3884,7 +3885,8 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			goto out;
 
-		status = generic_perform_write(file, from, pos = iocb->ki_pos);
+		pos = iocb->ki_pos;
+		status = generic_perform_write(iocb, from);
 		/*
 		 * If generic_perform_write() returned a synchronous error
 		 * then we want to return the number of bytes which were
@@ -3916,7 +3918,7 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
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

