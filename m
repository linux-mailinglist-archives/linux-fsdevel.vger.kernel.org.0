Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5731021145E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgGAUYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgGAUXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE3C08C5DC;
        Wed,  1 Jul 2020 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RHUcUsvFM01nbSipjJ9wbpJn0M6zNebEekts07Aqyyk=; b=OKVqcm4qQdk5NaMWLBudEqHkLA
        J96QDK0UycV8OAw8rULwatZGK7JiINTEwwtOXCb1eBW8aXgFGaOCgcYFrdV+D6yz0Bzq4DDMwhNU8
        ZZbgOLvvFO6dBUO4lQo5QUriGVHPiUltjpW4Avf2drtbEllrLG81fEg0M+yxzlEg/KFlp70v+NrCJ
        hzTJnvOIFxRqF093N1ec/Ewu2LbqlSABhspSLqJu0Xv1cEauyjLlsy6VBGwRQXj71IevHoCaR/hAR
        Dp4o1OKhA4J8xhvw3MffeMcr9wkXQaZ8nCywUKKucl28Bakxc7I8w81CwhdruE1hrLRR/1FEJU6c8
        v5z1YtnA==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjGD-0002Qw-5x; Wed, 01 Jul 2020 20:23:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/23] fs: don't change the address limit for ->read_iter in __kernel_read
Date:   Wed,  1 Jul 2020 22:09:41 +0200
Message-Id: <20200701200951.3603160-14-hch@lst.de>
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

If we read to a file that implements ->read_iter there is no need
to change the address limit if we send a kvec down.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 6a2170eaee64f9..8bec4418543994 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -421,7 +421,6 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
-	mm_segment_t old_fs = get_fs();
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_READ)))
@@ -431,14 +430,25 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	set_fs(KERNEL_DS);
-	if (file->f_op->read)
+	if (file->f_op->read) {
+		mm_segment_t old_fs = get_fs();
+
+		set_fs(KERNEL_DS);
 		ret = file->f_op->read(file, (void __user *)buf, count, pos);
-	else if (file->f_op->read_iter)
-		ret = new_sync_read(file, (void __user *)buf, count, pos);
-	else
+		set_fs(old_fs);
+	} else if (file->f_op->read_iter) {
+		struct kvec iov = { .iov_base = buf, .iov_len = count };
+		struct kiocb kiocb;
+		struct iov_iter iter;
+
+		init_sync_kiocb(&kiocb, file);
+		kiocb.ki_pos = *pos;
+		iov_iter_kvec(&iter, READ, &iov, 1, count);
+		ret = file->f_op->read_iter(&kiocb, &iter);
+		*pos = kiocb.ki_pos;
+	} else {
 		ret = -EINVAL;
-	set_fs(old_fs);
+	}
 	if (ret > 0) {
 		fsnotify_access(file);
 		add_rchar(current, ret);
@@ -520,7 +530,14 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
 
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	if (file->f_op->write_iter) {
+	if (file->f_op->write) {
+		mm_segment_t old_fs = get_fs();
+
+		set_fs(KERNEL_DS);
+		ret = file->f_op->write(file, (__force const char __user *)buf,
+				count, pos);
+		set_fs(old_fs);
+	} else if (file->f_op->write_iter) {
 		struct kvec iov = { .iov_base = (void *)buf, .iov_len = count };
 		struct kiocb kiocb;
 		struct iov_iter iter;
@@ -531,13 +548,6 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
 		ret = file->f_op->write_iter(&kiocb, &iter);
 		if (ret > 0)
 			*pos = kiocb.ki_pos;
-	} else if (file->f_op->write) {
-		mm_segment_t old_fs = get_fs();
-
-		set_fs(KERNEL_DS);
-		ret = file->f_op->write(file, (__force const char __user *)buf,
-				count, pos);
-		set_fs(old_fs);
 	} else {
 		ret = -EINVAL;
 	}
-- 
2.26.2

