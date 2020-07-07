Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E534D217580
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgGGRtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgGGRsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F94C08C5DC;
        Tue,  7 Jul 2020 10:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RHUcUsvFM01nbSipjJ9wbpJn0M6zNebEekts07Aqyyk=; b=sUyc/Xx90PACCH/5DMtZ5TmMZF
        lf7i9vm7s2YVB029wP+OgA2KCC+Qw7Lf31pfH2K3vrZWSfjxhtQdsrg1rW2m81uboYTsHJwRBK2aG
        2//EkgTY8c8wClX0IUYqIeXub4iRTj3g8hJoeLljo7KkIuwPNV57zniiXS/WxM3iFxKwbNkR7Dxjh
        561nEWJp9QQkRQO85+7SIn0QHoklx+snhRz/FxWBQJJBSDphpm9GQNcmDAr2/kMfg0mskDSMB9fiD
        LK0S3u5DBA3IMYhz0MMrC9KATKwT49OhLV1gplFcfDm2y6+bE9WF+OzdQJElG+gIh3w2/I+hQN6wr
        cHqe8f+Q==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhb-0003JN-Fg; Tue, 07 Jul 2020 17:48:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/23] fs: don't change the address limit for ->read_iter in __kernel_read
Date:   Tue,  7 Jul 2020 19:47:51 +0200
Message-Id: <20200707174801.4162712-14-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
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

