Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199C51CA707
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEHJWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgEHJWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 05:22:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C9C05BD43;
        Fri,  8 May 2020 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8pX7i8uPtHU7HN4LiIFYJSz1zLla2TEkp0jZ2qu15RI=; b=GOOO9v2QplkrXMye0xGfmThwzE
        LGK1+j6gYEzDAXuvhQpa/icS2f9t6+y/sGTeDAbK4JB48nRHYec3N3jCxQMp5ZASxOwKtypYCiIRK
        Vbgj1OUJEBE6WBmO0V8r7rFvcZ50o52awLIsNYLtHAnGRVPckLfIaFQnGqI3v26xkvkXZ4VxVOgz4
        PfFZFXHAysCwvDXLM3+BcgTb8Ee2RmT/K3MJbXwSauYE4wznfb6Z5k2dShehfOa0xlZgWaOPGrDMu
        lWQxBdehatdCSXws7x/KS3vTZ9W61+y8P1jRcDPrSjhQzfW715yqccPAFizZ4Ufa7eTJEtfnjoFgh
        DDr9S7Pg==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzDY-0000AI-Ek; Fri, 08 May 2020 09:22:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 11/11] fs: don't change the address limit for ->read_iter in __kernel_read
Date:   Fri,  8 May 2020 11:22:22 +0200
Message-Id: <20200508092222.2097-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508092222.2097-1-hch@lst.de>
References: <20200508092222.2097-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we read to a file that implements ->read_iter there is no need
to change the address limit if we send a kvec down.  Implement that
case, and prefer it over using plain ->read with a changed address
limit if available.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index f0009b506014c..70715a0e2375d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -421,7 +421,6 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
-	mm_segment_t old_fs = get_fs();
 	ssize_t ret;
 
 	if (!(file->f_mode & FMODE_CAN_READ))
@@ -429,14 +428,25 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	set_fs(KERNEL_DS);
-	if (file->f_op->read)
+	if (file->f_op->read_iter) {
+		struct kvec iov = { .iov_base = buf, .iov_len = count };
+		struct kiocb kiocb;
+		struct iov_iter iter;
+
+		init_sync_kiocb(&kiocb, file);
+		kiocb.ki_pos = *pos;
+		iov_iter_kvec(&iter, READ, &iov, 1, count);
+		ret = file->f_op->read_iter(&kiocb, &iter);
+		*pos = kiocb.ki_pos;
+	} else if (file->f_op->read) {
+		mm_segment_t old_fs = get_fs();
+
+		set_fs(KERNEL_DS);
 		ret = file->f_op->read(file, (void __user *)buf, count, pos);
-	else if (file->f_op->read_iter)
-		ret = new_sync_read(file, (void __user *)buf, count, pos);
-	else
+		set_fs(old_fs);
+	} else {
 		ret = -EINVAL;
-	set_fs(old_fs);
+	}
 	if (ret > 0) {
 		fsnotify_access(file);
 		add_rchar(current, ret);
-- 
2.26.2

