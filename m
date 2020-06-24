Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A2A207922
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405059AbgFXQ3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404764AbgFXQ31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:27 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAAFC061573;
        Wed, 24 Jun 2020 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VHv8vV/zSvtU7OOAqr9Qu8tuddmtuvpgD3IE+DOaLXs=; b=BYmF1uoU37E5NXUZV/N5uUhN8L
        kLfdntSaS1J2sHkhwgkQe1bigYHTeSylJDZtb0graYXEYbmzBB/X1PKcIzLUdTGqiwdoGPIJYlHnQ
        OnLOhoqF3MsIvho4MQa1Fl/Kw4SPil8+tSFfLpz4IhRWZfeHevlBOXTM95MFt+XE8p1RDB0mAWdZ2
        5o+O1PQpPEIo21Ku67TdxawC5gZLVT41G+f9UwWgaOQOZjxSYimoFsNCWostJL/bXWCi7HatkdbdP
        gswGXJi/BNohjkC15q0HPX5FGlteXfDKsg1poy8KnwRs4m1RAN2LNGqmULVAytMvxnq/yP9d3k3A1
        6SwKDAIg==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8Go-0006oQ-EA; Wed, 24 Jun 2020 16:29:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
Date:   Wed, 24 Jun 2020 18:28:53 +0200
Message-Id: <20200624162901.1814136-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624162901.1814136-1-hch@lst.de>
References: <20200624162901.1814136-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add two new file operations that are identical to ->read and ->write
except that they can also safely take kernel pointers using the uptr_t
type.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h      |  4 ++--
 fs/read_write.c    | 18 ++++++++++++++----
 include/linux/fs.h |  3 +++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 242f2845b3428b..b6777a47b05163 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -189,9 +189,9 @@ int do_statx(int dfd, const char __user *filename, unsigned flags,
 static inline void set_fmode_can_read_write(struct file *f)
 {
 	if ((f->f_mode & FMODE_READ) &&
-	    (f->f_op->read || f->f_op->read_iter))
+	    (f->f_op->read || f->f_op->read_uptr || f->f_op->read_iter))
 		f->f_mode |= FMODE_CAN_READ;
 	if ((f->f_mode & FMODE_WRITE) &&
-	    (f->f_op->write || f->f_op->write_iter))
+	    (f->f_op->write || f->f_op->write_uptr || f->f_op->write_iter))
 		f->f_mode |= FMODE_CAN_WRITE;
 }
diff --git a/fs/read_write.c b/fs/read_write.c
index e7f36b15683049..24ffbf3cbda243 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -430,7 +430,9 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	if (file->f_op->read) {
+	if (file->f_op->read_uptr) {
+		ret = file->f_op->read_uptr(file, KERNEL_UPTR(buf), count, pos);
+	} else if (file->f_op->read) {
 		mm_segment_t old_fs = get_fs();
 
 		set_fs(KERNEL_DS);
@@ -485,7 +487,9 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 
-	if (file->f_op->read)
+	if (file->f_op->read_uptr)
+		ret = file->f_op->read_uptr(file, USER_UPTR(buf), count, pos);
+	else if (file->f_op->read)
 		ret = file->f_op->read(file, buf, count, pos);
 	else if (file->f_op->read_iter)
 		ret = new_sync_read(file, buf, count, pos);
@@ -530,7 +534,10 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
 
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	if (file->f_op->write) {
+	if (file->f_op->write_uptr) {
+		ret = file->f_op->write_uptr(file, KERNEL_UPTR((void *)buf),
+				count, pos);
+	} else if (file->f_op->write) {
 		mm_segment_t old_fs = get_fs();
 
 		set_fs(KERNEL_DS);
@@ -592,7 +599,10 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 	file_start_write(file);
-	if (file->f_op->write)
+	if (file->f_op->write_uptr)
+		ret = file->f_op->write_uptr(file,
+				USER_UPTR((char __user *)buf), count, pos);
+	else if (file->f_op->write)
 		ret = file->f_op->write(file, buf, count, pos);
 	else if (file->f_op->write_iter)
 		ret = new_sync_write(file, buf, count, pos);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fac6aead402a98..d8fc3015f5a197 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -39,6 +39,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/uptr.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1830,6 +1831,8 @@ struct file_operations {
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	ssize_t (*read_uptr) (struct file *, uptr_t, size_t, loff_t *);
+	ssize_t (*write_uptr) (struct file *, uptr_t, size_t, loff_t *);
 	int (*iopoll)(struct kiocb *kiocb, bool spin);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
-- 
2.26.2

