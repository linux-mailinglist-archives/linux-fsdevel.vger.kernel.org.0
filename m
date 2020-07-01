Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D66C211467
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGAUXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAUXM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5A3C08C5DB;
        Wed,  1 Jul 2020 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pE9BZ+cY4E02xMmAEaREea9Ma9ZDLW8TJAoArZaeVmc=; b=GpNEmBmf7qDf4vmsDo/vIBMdx8
        6MAlWttO/t8b7mp0br4blWVH6QoOQrIyzxs1p+xLGvxTKMedPg665ojB26pOl3eFYfAcXfFeA8KWo
        Jo9XdWhquizDsxzUW/Y8GluA6EjzLun9xd34ynKF5fK+J4pO41cqz0fa4gF5vU3KnwG3+KoVuBdNx
        bRrujTPKuYxkiT6MhKLupblwxi3HUezLiOBGyxfpDfkNRLOioc7sUeb+oZNItoc/mKLZRC9lMkjJr
        VOi7LGn5gDOkpJlIvwOXDPsJPh3JkhTGXoQwnf4iWnBl2FERpvXCoD+dVJC8xpfkkfVa+dix/FN3L
        PSGnzw3A==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjG7-0002Pt-D8; Wed, 01 Jul 2020 20:23:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/23] fs: don't change the address limit for ->write_iter in __kernel_write
Date:   Wed,  1 Jul 2020 22:09:36 +0200
Message-Id: <20200701200951.3603160-9-hch@lst.de>
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

If we write to a file that implements ->write_iter there is no need
to change the address limit if we send a kvec down.  Implement that
case, and prefer it over using plain ->write with a changed address
limit if available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 96e8e354f99b45..bd46c959799e97 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -489,10 +489,9 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 }
 
 /* caller is responsible for file_start_write/file_end_write */
-ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
+ssize_t __kernel_write(struct file *file, const void *buf, size_t count,
+		loff_t *pos)
 {
-	mm_segment_t old_fs;
-	const char __user *p;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(file->f_mode & FMODE_WRITE)))
@@ -500,18 +499,29 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	p = (__force const char __user *)buf;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	if (file->f_op->write)
-		ret = file->f_op->write(file, p, count, pos);
-	else if (file->f_op->write_iter)
-		ret = new_sync_write(file, p, count, pos);
-	else
+	if (file->f_op->write_iter) {
+		struct kvec iov = { .iov_base = (void *)buf, .iov_len = count };
+		struct kiocb kiocb;
+		struct iov_iter iter;
+
+		init_sync_kiocb(&kiocb, file);
+		kiocb.ki_pos = *pos;
+		iov_iter_kvec(&iter, WRITE, &iov, 1, count);
+		ret = file->f_op->write_iter(&kiocb, &iter);
+		if (ret > 0)
+			*pos = kiocb.ki_pos;
+	} else if (file->f_op->write) {
+		mm_segment_t old_fs = get_fs();
+
+		set_fs(KERNEL_DS);
+		ret = file->f_op->write(file, (__force const char __user *)buf,
+				count, pos);
+		set_fs(old_fs);
+	} else {
 		ret = -EINVAL;
-	set_fs(old_fs);
+	}
 	if (ret > 0) {
 		fsnotify_modify(file);
 		add_wchar(current, ret);
-- 
2.26.2

