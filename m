Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0DD207920
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405057AbgFXQ3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404782AbgFXQ31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:27 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF591C061795;
        Wed, 24 Jun 2020 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AYFB+Z0RU8R831U4cx7G5n0/06yd4vKHvkQQiVELYcc=; b=lkvN4/ZoodNqqMV2cXxhBSLzWu
        CfYlslhKWkfLn2dHg/ETf3XsFO7e4jkbaUvl0EAmC4oiNAxmBzo0DiPGbMnxEJJQMKkanElt/VcVp
        iSt46GH9LEODydo+p5UPJdPPpiN7Uhce8jOdOej3/oOS39QjLn+ptNV5G6UxbCAwTQxM0MP0Ottm3
        KsJ137m9E51U6FAMfaxSJ/V6dpVEUxNY6p6C9otT8x6bD7QHRQ1FCjcBhiNkfmcuBEnAFNANLCMdh
        uQeEMzLY11Bf2Rp2p+pUqrt24S7O79O3c7ziyHouFOkjIkSWewyzn3e6J4/+aQdG+5ZEjWlgC6wV1
        xZQpk0SA==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8Gr-0006oy-R1; Wed, 24 Jun 2020 16:29:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/11] fs: refactor new_sync_read
Date:   Wed, 24 Jun 2020 18:28:55 +0200
Message-Id: <20200624162901.1814136-6-hch@lst.de>
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

Pass the read_iter method as a parameter and mark the function
non-static.  This allows reusing it for additional callsites e.g.
in procfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c    | 8 +++++---
 include/linux/fs.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 24ffbf3cbda243..b92c222ca886ca 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -401,7 +401,8 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 				read_write == READ ? MAY_READ : MAY_WRITE);
 }
 
-static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
+ssize_t iter_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos,
+		ssize_t (*cb)(struct kiocb *iocb, struct iov_iter *iter))
 {
 	struct iovec iov = { .iov_base = buf, .iov_len = len };
 	struct kiocb kiocb;
@@ -412,7 +413,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_init(&iter, READ, &iov, 1, len);
 
-	ret = call_read_iter(filp, &kiocb, &iter);
+	ret = cb(&kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ppos)
 		*ppos = kiocb.ki_pos;
@@ -492,7 +493,8 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 	else if (file->f_op->read)
 		ret = file->f_op->read(file, buf, count, pos);
 	else if (file->f_op->read_iter)
-		ret = new_sync_read(file, buf, count, pos);
+		ret = iter_read(file, buf, count, pos,
+				file->f_op->read_iter);
 	else
 		ret = -EINVAL;
 	if (ret > 0) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d8fc3015f5a197..d0fea0281ef29b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1919,6 +1919,8 @@ ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
 			      unsigned long nr_segs, unsigned long fast_segs,
 			      struct iovec *fast_pointer,
 			      struct iovec **ret_pointer);
+ssize_t iter_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos,
+		ssize_t (*cb)(struct kiocb *iocb, struct iov_iter *iter));
 
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
-- 
2.26.2

