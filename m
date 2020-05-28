Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1518B1E56AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 07:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgE1FlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 01:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgE1FlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 01:41:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B1C05BD1E;
        Wed, 27 May 2020 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AZrEO4uOUGmTKGyBg+hBxvz5LOpc/mMjva1AqdoZkhw=; b=acJn3my92W68iGQuJv65iNtVDP
        wEJXlE9AXQT0Lzi7DuU07lKSfx8dyBXZwvcWiJ/q0kqyZDSOEoC37PGTiJ+BZUL9t3UopY5XE4Mng
        A+GKs5GOB/rJf+b9cZaGhfIu5QsSfXA017LuvvojCGWU8FHDFSphfE++7hK51+DTq1p9822sukmmp
        2tsUZnvr0DJhneypHKf0c7SVhB1BXOauU28NJJ1ULOTSuv+ryU+Qe+L5AA+zT0q/djgrrTOetz7jJ
        hgw0Ie/4+0DW95olcevSRWNPinBWorHERWAg6WrG0uYFRNpWIxMXGhcBEEuPYekHzUMzfsewxjHG6
        gmsReeUQ==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeBHv-0002Ok-2c; Thu, 28 May 2020 05:41:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 08/14] fs: remove __vfs_write
Date:   Thu, 28 May 2020 07:40:37 +0200
Message-Id: <20200528054043.621510-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528054043.621510-1-hch@lst.de>
References: <20200528054043.621510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold it into the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index abb84391cfbc5..3bcb084f160de 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -488,17 +488,6 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	return ret;
 }
 
-static ssize_t __vfs_write(struct file *file, const char __user *p,
-			   size_t count, loff_t *pos)
-{
-	if (file->f_op->write)
-		return file->f_op->write(file, p, count, pos);
-	else if (file->f_op->write_iter)
-		return new_sync_write(file, p, count, pos);
-	else
-		return -EINVAL;
-}
-
 /* caller is responsible for file_start_write/file_end_write */
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
 {
@@ -516,7 +505,12 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	p = (__force const char __user *)buf;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
-	ret = __vfs_write(file, p, count, pos);
+	if (file->f_op->write)
+		ret = file->f_op->write(file, p, count, pos);
+	else if (file->f_op->write_iter)
+		ret = new_sync_write(file, p, count, pos);
+	else
+		ret = -EINVAL;
 	set_fs(old_fs);
 	if (ret > 0) {
 		fsnotify_modify(file);
@@ -554,19 +548,23 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 		return -EFAULT;
 
 	ret = rw_verify_area(WRITE, file, pos, count);
-	if (!ret) {
-		if (count > MAX_RW_COUNT)
-			count =  MAX_RW_COUNT;
-		file_start_write(file);
-		ret = __vfs_write(file, buf, count, pos);
-		if (ret > 0) {
-			fsnotify_modify(file);
-			add_wchar(current, ret);
-		}
-		inc_syscw(current);
-		file_end_write(file);
+	if (ret)
+		return ret;
+	if (count > MAX_RW_COUNT)
+		count =  MAX_RW_COUNT;
+	file_start_write(file);
+	if (file->f_op->write)
+		ret = file->f_op->write(file, buf, count, pos);
+	else if (file->f_op->write_iter)
+		ret = new_sync_write(file, buf, count, pos);
+	else
+		ret = -EINVAL;
+	if (ret > 0) {
+		fsnotify_modify(file);
+		add_wchar(current, ret);
 	}
-
+	inc_syscw(current);
+	file_end_write(file);
 	return ret;
 }
 
-- 
2.26.2

