Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB2211448
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGAUXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgGAUXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA82C08C5DD;
        Wed,  1 Jul 2020 13:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0zhvBQZ7oT4xAzbMT5Iv8nd7tiG+K7QhKCHlApRhAsY=; b=m6QAMpsncHp6GJgjPJqlvj+XuG
        ibRrIE4JoVhp0LtIaaVfifKvDKgGobUpXZo5lz+EycfqhpFs45MxF+0Co8YRiYty03YTPHrt+SOn3
        bqpSRRlmSXBm3Q0jkprMBY4EdtFbkbnAIlPXPatKg+k46RZGZuhRCoA9sgQI1bY4Qo8TWB7fOeN0T
        pB7D0CoONK2/SjrDW6aREg3tZZOLS370ovCF9SkjnStvBLl9p9veFn7Z7MPG307EYVcaj5g80vBHd
        ZqDMC4GBNpjcjLCQiVVMZ59f2Aj1jk6jVUhlwUW7aNcY2wO02cxruAi/8NXyD8zISzSsZmXufe23f
        awg9mpTQ==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjGB-0002Qk-Vg; Wed, 01 Jul 2020 20:23:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/23] fs: remove __vfs_read
Date:   Wed,  1 Jul 2020 22:09:40 +0200
Message-Id: <20200701200951.3603160-13-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701200951.3603160-1-hch@lst.de>
References: <20200701200951.3603160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold it into the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c    | 43 +++++++++++++++++++++----------------------
 include/linux/fs.h |  1 -
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index a0a0b5d1d9249c..6a2170eaee64f9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -419,17 +419,6 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	return ret;
 }
 
-ssize_t __vfs_read(struct file *file, char __user *buf, size_t count,
-		   loff_t *pos)
-{
-	if (file->f_op->read)
-		return file->f_op->read(file, buf, count, pos);
-	else if (file->f_op->read_iter)
-		return new_sync_read(file, buf, count, pos);
-	else
-		return -EINVAL;
-}
-
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
 	mm_segment_t old_fs = get_fs();
@@ -443,7 +432,12 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 	set_fs(KERNEL_DS);
-	ret = __vfs_read(file, (void __user *)buf, count, pos);
+	if (file->f_op->read)
+		ret = file->f_op->read(file, (void __user *)buf, count, pos);
+	else if (file->f_op->read_iter)
+		ret = new_sync_read(file, (void __user *)buf, count, pos);
+	else
+		ret = -EINVAL;
 	set_fs(old_fs);
 	if (ret > 0) {
 		fsnotify_access(file);
@@ -476,17 +470,22 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 		return -EFAULT;
 
 	ret = rw_verify_area(READ, file, pos, count);
-	if (!ret) {
-		if (count > MAX_RW_COUNT)
-			count =  MAX_RW_COUNT;
-		ret = __vfs_read(file, buf, count, pos);
-		if (ret > 0) {
-			fsnotify_access(file);
-			add_rchar(current, ret);
-		}
-		inc_syscr(current);
-	}
+	if (ret)
+		return ret;
+	if (count > MAX_RW_COUNT)
+		count =  MAX_RW_COUNT;
 
+	if (file->f_op->read)
+		ret = file->f_op->read(file, buf, count, pos);
+	else if (file->f_op->read_iter)
+		ret = new_sync_read(file, buf, count, pos);
+	else
+		ret = -EINVAL;
+	if (ret > 0) {
+		fsnotify_access(file);
+		add_rchar(current, ret);
+	}
+	inc_syscr(current);
 	return ret;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 22cbe7b2e91994..0c0ec76b600b50 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1917,7 +1917,6 @@ ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
 			      struct iovec *fast_pointer,
 			      struct iovec **ret_pointer);
 
-extern ssize_t __vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
-- 
2.26.2

