Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66A7207932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405162AbgFXQap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404692AbgFXQ3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:25 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA41EC0613ED;
        Wed, 24 Jun 2020 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CNk/aSiWmmbV6EV6DanHCszvKlV+254CO/X+KDTk2bo=; b=RutPLeiKe6pB5IbiaUm72jhFLG
        MlClnq7utWReRPV633zRff0I6qSvq7hy2NV+KiIFdwOX7vs9hc22h8j78nNavOr9ReVGnpHq8NIeG
        6uMnXtaN/XLoo0dV/lYr7h+nScNlmiG6oqCu5H6fYe/kxh1FlJ3PR6wJaJsa+Jtp65dRtnvN8FlvF
        QD73Vg1VIUcEdqDcTtjhbtZ+bhxo7EOpuxfOAL1ZY6qRXg484Rt9tYHGmUdleVvrFxPlykR/EkR7x
        SRHsZDWGW6hKoBmooVTYu4tqYvvVTlGxy9rxPV0Ef97df46BEGuKKiswVMB3Lvaza2B2OeSqpiNo5
        bhM/du8A==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8Gn-0006nz-0a; Wed, 24 Jun 2020 16:29:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/11] fs: factor out a set_fmode_can_read_write helper
Date:   Wed, 24 Jun 2020 18:28:52 +0200
Message-Id: <20200624162901.1814136-3-hch@lst.de>
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

Add a helper to set the FMODE_CAN_READ and FMODE_CAN_WRITE logic
instead of duplicating it in two places.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/file_table.c |  7 +------
 fs/internal.h   | 10 ++++++++++
 fs/open.c       |  8 +-------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f9575a7c..646b83f07a9589 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -199,16 +199,11 @@ static struct file *alloc_file(const struct path *path, int flags,
 	file->f_mapping = path->dentry->d_inode->i_mapping;
 	file->f_wb_err = filemap_sample_wb_err(file->f_mapping);
 	file->f_sb_err = file_sample_sb_err(file);
-	if ((file->f_mode & FMODE_READ) &&
-	     likely(fop->read || fop->read_iter))
-		file->f_mode |= FMODE_CAN_READ;
-	if ((file->f_mode & FMODE_WRITE) &&
-	     likely(fop->write || fop->write_iter))
-		file->f_mode |= FMODE_CAN_WRITE;
 	file->f_mode |= FMODE_OPENED;
 	file->f_op = fop;
 	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
 		i_readcount_inc(path->dentry->d_inode);
+	set_fmode_can_read_write(file);
 	return file;
 }
 
diff --git a/fs/internal.h b/fs/internal.h
index 9b863a7bd70892..242f2845b3428b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -185,3 +185,13 @@ int sb_init_dio_done_wq(struct super_block *sb);
  */
 int do_statx(int dfd, const char __user *filename, unsigned flags,
 	     unsigned int mask, struct statx __user *buffer);
+
+static inline void set_fmode_can_read_write(struct file *f)
+{
+	if ((f->f_mode & FMODE_READ) &&
+	    (f->f_op->read || f->f_op->read_iter))
+		f->f_mode |= FMODE_CAN_READ;
+	if ((f->f_mode & FMODE_WRITE) &&
+	    (f->f_op->write || f->f_op->write_iter))
+		f->f_mode |= FMODE_CAN_WRITE;
+}
diff --git a/fs/open.c b/fs/open.c
index 6cd48a61cda3b9..01f2de93c91710 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -832,13 +832,7 @@ static int do_dentry_open(struct file *f,
 	f->f_mode |= FMODE_OPENED;
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
 		i_readcount_inc(inode);
-	if ((f->f_mode & FMODE_READ) &&
-	     likely(f->f_op->read || f->f_op->read_iter))
-		f->f_mode |= FMODE_CAN_READ;
-	if ((f->f_mode & FMODE_WRITE) &&
-	     likely(f->f_op->write || f->f_op->write_iter))
-		f->f_mode |= FMODE_CAN_WRITE;
-
+	set_fmode_can_read_write(f);
 	f->f_write_hint = WRITE_LIFE_NOT_SET;
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
-- 
2.26.2

