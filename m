Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3334E2078AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404948AbgFXQO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404235AbgFXQOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:12 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55346C0613ED;
        Wed, 24 Jun 2020 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dVcUaNs/nJl21S9DI4MlGzuWbjmDqO4Jqbdos/3DXPs=; b=SEYiB5BqjCV6jniJkzB5E8JhTG
        eJ224sWAei+pMxmYPPkoawxmQpXxYMxcJS5/eB/EA30KLPrh/N8LPd4eyqdF6SPySZUlx0+AZlJ5V
        iSSvz+G6018e89C3IFeQN+FBzQ62uo97HtWSfghbxf6g4brX2/rD0ceg6KjXLg3gU2Kn+bzxA8ekT
        +tPNoHv+eaVo5sQarUK+8RIbfQ83B47c24ojDotVbqmX3cRPUXj34gG8TSAdwVm96JcRAtLDjLjU4
        JgrkShJfGSzErP2Z4ICzwB0oLETA5q8Crqbs+Rk22LJ6e0ezj+2IR0HTvmEFRTyG3a828xcyIRHkg
        fI7Q3sMA==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo81x-0005yT-Pk; Wed, 24 Jun 2020 16:13:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 07/14] fs: remove __vfs_write
Date:   Wed, 24 Jun 2020 18:13:28 +0200
Message-Id: <20200624161335.1810359-8-hch@lst.de>
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
 fs/read_write.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5110cd1e6e2771..96e8e354f99b45 100644
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

