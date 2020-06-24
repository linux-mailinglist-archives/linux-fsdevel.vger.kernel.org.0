Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FAC207895
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404872AbgFXQOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404844AbgFXQOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:14 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA3C061797;
        Wed, 24 Jun 2020 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0zhvBQZ7oT4xAzbMT5Iv8nd7tiG+K7QhKCHlApRhAsY=; b=rj9UEETwxin4VJAPjVg6r3e023
        RH1DQnKT1JJoQx1tsI3bZTXut1oay83DL5F03ruwCjxPwITaC2uUXDl4U6yFJkAZBYWNLRCanWr0B
        qZk1d6TR0UPaf2L5EGSDMV59k61OZgMeFcxebOP1Hl0jwghcI6izwjcC1gdEMP+EAeZ25K/4Czcbr
        jR0UoVKrXuS/NZvCcmOJdzyhoBM6zk3oZT+wvCCtqedfQ0j1dyX03pKW+aZ/sty3oBN27fAn79bTK
        Za/JCVS20StmGsAuE1WsstlYa+BjlqocGKW3I++BHi8+F1XouOfWvQ8hwWKVCVg2T0FQIsbxQXbmX
        p2ZYzMDA==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo823-0005zC-Tw; Wed, 24 Jun 2020 16:13:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 12/14] fs: remove __vfs_read
Date:   Wed, 24 Jun 2020 18:13:33 +0200
Message-Id: <20200624161335.1810359-13-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624161335.1810359-1-hch@lst.de>
References: <20200624161335.1810359-1-hch@lst.de>
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

